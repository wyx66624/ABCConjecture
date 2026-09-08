"""Bounded PARI pilot with fail-closed parsing and precision comparison.

This records PARI p-adic balls, not an independent certification of its
height algorithm, local-height normalization, or all Chabauty zeros.
"""
from __future__ import annotations
import argparse
import ast
import hashlib
import json
import os
from pathlib import Path
import subprocess
from fractions import Fraction
from replay_padic_entry import run

HERE = Path(__file__).resolve().parent
DEST = HERE / "verification" / "padic_pilot.json"


def value(ball):
    v, ap, u = ball
    assert ap > v and 0 <= u < 5**(ap-v) and u % 5
    return Fraction(u) * Fraction(5)**v


def vp(q):
    if not q:
        return 10**9
    n, d = abs(q.numerator), q.denominator
    v = 0
    while n % 5 == 0:
        n //= 5
        v += 1
    while d % 5 == 0:
        d //= 5
        v -= 1
    return v


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--check", action="store_true")
    args = p.parse_args()
    source = HERE / "replay_padic_pilot.gp"
    cmd = (["wsl.exe", "-d", "Ubuntu-24.04", "--", "/usr/bin/gp", "-q", "-f"]
           if os.name == "nt" else ["/usr/bin/gp", "-q", "-f"])
    proc = subprocess.run(cmd, input=source.read_text(), text=True,
                          capture_output=True, timeout=120, check=True)
    if proc.stderr.strip():
        raise RuntimeError("PARI stderr (rejected): " + proc.stderr)
    rows = [ast.literal_eval(s) for s in proc.stdout.splitlines() if s.strip()]
    assert len(rows) == 9 and rows[-1] == [99, 1]
    exact = run()
    pilots = {}
    for j in [1, 2]:
        z = [r for r in rows[:-1] if r[1] == j]
        assert len(z) == 4
        a = next(r for r in z if r[0] == 0)
        assert a[2] == exact["curves"][j-1]["nine_point"]
        assert a[3:] == [9, 9]
        s = next(r for r in z if r[0] == 1)
        assert s[2] == [[-2, 1] if j == 1 else [6, 9]]
        low, high = [next(r for r in z if r[0] == 2 and r[2] == n)
                     for n in [12, 24]]
        for lo, hi in zip(low[3:], high[3:]):
            assert hi[1] > lo[1]
            assert vp(value(hi)-value(lo)) >= lo[1]
        assert [r[0] for r in high[3:6]] == [1, 1, -1]
        assert high[3][2] % 5 == (4 if j == 1 else 2)
        pilots[j] = high
    # Independent ordinary isogeny identities predict these congruences;
    # record as normalization checks, not as a proof of height functoriality.
    a, b = pilots[1], pilots[2]
    assert vp(value(a[3])+3*value(b[3])) >= min(a[3][1], b[3][1])
    assert vp(value(a[4])-3*value(b[4])) >= min(a[4][1], b[4][1])
    data = dict(schema=1, pari_version="2.15.4", input_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                scope="software p-adic balls and bounded saturation only; no complete QC locus",
                rows=rows[:-1], ball_format=["valuation", "absolute_precision", "unit_residue"],
                precision_comparison="all four balls agree at common precision",
                isogeny_log_height_checks="PASS", saturation_bound=11,
                saturation_scope="prime index factors less than 11 only; not a full basis proof")
    raw = (json.dumps(data, sort_keys=True, indent=2) + "\n").encode()
    if args.check:
        assert DEST.read_bytes() == raw, "canonical pilot changed"
    else:
        DEST.parent.mkdir(parents=True, exist_ok=True)
        DEST.write_bytes(raw)
    print("PASS", hashlib.sha256(raw).hexdigest())


if __name__ == "__main__":
    main()
