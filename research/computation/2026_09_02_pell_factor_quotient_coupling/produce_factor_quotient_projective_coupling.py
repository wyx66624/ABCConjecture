#!/usr/bin/env python3
"""Produce evidence for the Pell factor-quotient/projective coupling.

This computation never interprets a bounded no-hit as an unbounded theorem.
The finite exclusion uses an explicit exponent-one prime at every index.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
from math import comb, isqrt, prod
from pathlib import Path


INCIDENCE_INDICES = [3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43]


def prime_sieve(limit: int) -> bytearray:
    flags = bytearray(b"\x01") * (limit + 1)
    flags[0:2] = b"\x00\x00"
    for p in range(2, isqrt(limit) + 1):
        if flags[p]:
            flags[p * p : limit + 1 : p] = b"\x00" * (((limit - p * p) // p) + 1)
    return flags


def pell_pair(n: int, modulus: int | None = None) -> tuple[int, int]:
    a, b = 1, 0
    x, y = 1, 1
    while n:
        if n & 1:
            a, b = a * x + 2 * b * y, a * y + b * x
            if modulus is not None:
                a %= modulus
                b %= modulus
        x, y = x * x + 2 * y * y, 2 * x * y
        if modulus is not None:
            x %= modulus
            y %= modulus
        n //= 2
    return a, b


def legendre(a: int, p: int) -> int:
    z = pow(a % p, (p - 1) // 2, p)
    if z == p - 1:
        return -1
    if z in (0, 1):
        return z
    raise AssertionError("Euler criterion returned a nonsign")


def product_coefficients(ell: int) -> list[tuple[int, int]]:
    """Build c_j from the product formula and d_j from the binomial formula."""
    theta = (ell - 1) // 2
    numerator_product = 1
    denominator = 1
    out = []
    for j in range(theta + 1):
        if j:
            numerator_product *= ell * ell - (2 * j - 1) ** 2
            denominator *= 4 * (2 * j) * (2 * j + 1)
        num = ell * numerator_product
        c, rem = divmod(num, denominator)
        assert rem == 0
        d = comb(theta + j, 2 * j)
        assert (2 * j + 1) * c == ell * d
        out.append((c, d))
    return out


def elem3(ts: list[int]) -> tuple[int, int, int]:
    k = sum(ts)
    c = sum(ts[i] * ts[j] for i in range(len(ts)) for j in range(i + 1, len(ts)))
    h = sum(ts[i] * ts[j] * ts[k]
            for i in range(len(ts)) for j in range(i + 1, len(ts))
            for k in range(j + 1, len(ts)))
    return k, c, h


def companion_a_jet(x: int, k: int, c: int, h: int) -> int:
    return 6 + 8 * x * k + x * x * (8 * c + 4 * k * k) + \
        x**3 * (8 * h + 8 * k * c)


def companion_b_jet(x: int, k: int, c: int, h: int) -> int:
    return 6 + 16 * x * k + x * x * (16 * c + 8 * k * k) + \
        x**3 * (16 * h + 16 * k * c)


def third_ledger(ell: int, A3: tuple[int, int, int],
                 B3: tuple[int, int, int]) -> int:
    ka, ca, ha = A3
    kb, cb, hb = B3
    return (ka - 2 * kb + ell * (ka * ka - 2 * kb * kb)
            + 2 * ell * (ca - 2 * cb)
            + 4 * ell**2 * (ha - 2 * hb + ka * ca - 2 * kb * cb)
            + 4 * ell**3 * (ca * ca - 2 * cb * cb))


def factor_dict(raw: dict) -> dict[int, int]:
    return {int(p): int(e) for p, e in raw.items()}


def quotient_lists(ell: int, fa: dict[int, int], fb: dict[int, int]) -> tuple[list[int], list[int]]:
    x = 2 * ell
    ta: list[int] = []
    tb: list[int] = []
    for q, e in sorted(fa.items()):
        assert (q - 1) % x == 0
        ta.extend([(q - 1) // x] * e)
    for r, e in sorted(fb.items()):
        s = legendre(2, r)
        assert (r - s) % x == 0
        h = (r - s) // x
        tb.extend([s * h] * e)
    return ta, tb


def endpoint_row(ell: int) -> tuple[str, dict]:
    A, B = pell_pair(ell)
    U = A * B
    v = 4 * A * A + 2
    assert v == 8 * B * B - 2
    assert v * v - 32 * U * U == 4
    coeff = product_coefficients(ell)
    alpha = [32**j * c for j, (c, _) in enumerate(coeff)]
    beta = [32**j * d for j, (_, d) in enumerate(coeff)]
    theta = (ell - 1) // 2
    top = alpha[theta]
    assert top == beta[theta] == 32**theta
    a_prev, b_prev = alpha[theta - 1], beta[theta - 1]
    assert (ell - 2) * a_prev == ell * b_prev
    Eprev = a_prev + top * U * U
    Fprev = b_prev + top * U * U
    Tprev = v * Fprev
    Ttop = v * top
    delta = Tprev * (ell * top) - Ttop * ((ell - 2) * Eprev)
    curvature = 2 * v * top * top
    assert delta == curvature * U * U
    assert math.gcd(curvature, U) == 1
    assert delta % (U**3) != 0
    line = f"{ell},{A},{B},{U},{v},{a_prev},{b_prev},{top},{curvature},{delta % (U**3)}\n"
    selected = {
        "index": ell,
        "A": str(A),
        "B": str(B),
        "U": str(U),
        "v": str(v),
        "a_prev": str(a_prev),
        "b_prev": str(b_prev),
        "top": str(top),
        "curvature": str(curvature),
        "delta": str(delta),
        "delta_mod_U_cube": str(delta % U**3),
    }
    return line, selected


def factor_row(source_row: dict) -> dict:
    ell = int(source_row["index"])
    A, B = pell_pair(ell)
    fa, fb = factor_dict(source_row["A_factorization"]), factor_dict(source_row["B_factorization"])
    assert prod(p**e for p, e in fa.items()) == A
    assert prod(p**e for p, e in fb.items()) == B
    ta, tb = quotient_lists(ell, fa, fb)
    x = 2 * ell
    sa = prod(1 + x * t for t in ta)
    sb = prod(1 + x * t for t in tb)
    sell = legendre(2, ell)
    assert sa == A and sb == sell * B
    a, b = (A - 1) // x, (sell * B - 1) // x
    ca, cb = elem3(ta), elem3(tb)
    assert (a - (ca[0] + x * ca[1] + x * x * ca[2])) % x**3 == 0
    assert (b - (cb[0] + x * cb[1] + x * x * cb[2])) % x**3 == 0
    ledger = third_ledger(ell, ca, cb)
    assert ledger % (8 * ell**3) == 0
    v = 4 * A * A + 2
    va, vb = companion_a_jet(x, *ca), companion_b_jet(x, *cb)
    assert (va - v) % x**4 == 0 and (vb - v) % x**4 == 0
    top = 32**((ell - 1) // 2)
    curvature = 2 * v * top * top
    assert (2 * top * top * va - curvature) % x**4 == 0
    assert (2 * top * top * vb - curvature) % x**4 == 0
    oa = sorted(p for p, e in fa.items() if e & 1)
    ob = sorted(p for p, e in fb.items() if e & 1)
    edges = [(q, r, legendre(q, r)) for q in oa for r in ob]
    for r in ob:
        assert prod(s for q, rr, s in edges if rr == r) == legendre(2, r)
    for q in oa:
        assert prod(s for qq, r, s in edges if qq == q) == legendre(B, q)
    squarefull = all(e >= 2 for e in fa.values()) and all(e >= 2 for e in fb.values())
    depth_pairs = [(q, r) for q, eq in fa.items() if eq >= 3
                   for r, er in fb.items() if er >= 3 and legendre(q, r) == -1]
    return {
        "index": ell,
        "A_factorization": {str(p): e for p, e in sorted(fa.items())},
        "B_factorization": {str(p): e for p, e in sorted(fb.items())},
        "A_quotient_list": ta,
        "B_quotient_list": tb,
        "A_coefficients": list(ca),
        "B_coefficients": list(cb),
        "third_ledger_quotient": ledger // (8 * ell**3),
        "companion_residue_mod_x4": v % x**4,
        "A_jet_residue_mod_x4": va % x**4,
        "B_jet_residue_mod_x4": vb % x**4,
        "curvature_residue_mod_x4": curvature % x**4,
        "edge_count": len(edges),
        "squarefull": squarefull,
        "opposite_depth_three_pairs": depth_pairs,
    }


def local_counterexample() -> dict:
    ell, q, r, k, h = 3, 7, 797, 1, 133
    A3, B3 = elem3([k, k, k]), elem3([-h, -h, -h])
    ledger = third_ledger(ell, A3, B3)
    assert A3 == (3, 3, 1)
    assert B3 == (-399, 53067, -2352637)
    assert ledger % (8 * ell**3) == 0
    assert legendre(q, r) == legendre(ell, q) == legendre(ell, r) == -1
    defect = q**6 - 2 * r**6 + 1
    assert defect != 0
    return {
        "ell": ell, "q": q, "r": r, "k": k, "h": h,
        "A_coefficients": list(A3), "B_coefficients": list(B3),
        "ledger": ledger, "ledger_quotient": ledger // (8 * ell**3),
        "characters": {"q_over_r": -1, "ell_over_q": -1, "ell_over_r": -1},
        "synthetic_A": str(q**3), "synthetic_B": str(r**3),
        "negative_pell_defect": str(defect),
        "claim_boundary": "All local premises L3 hold; the global negative-Pell equation fails.",
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    here = Path(__file__).resolve().parent
    parser.add_argument("--source", type=Path, default=here.parent /
                        "2026_09_01_pell_lucas_correlated_all_order" /
                        "correlated_all_order_packet.json")
    parser.add_argument("--output", type=Path, default=here / "factor_quotient_projective_packet.json")
    args = parser.parse_args()
    raw = args.source.read_bytes()
    source = json.loads(raw)
    witnesses = source["finite_packet_exclusion"]["witnesses"]
    indices = [int(row["index"]) for row in witnesses]
    assert len(indices) == 57 and indices[-1] == 271
    digest = hashlib.sha256()
    selected: list[dict] = []
    for ell in indices:
        line, row = endpoint_row(ell)
        digest.update(line.encode("ascii"))
        if ell in (3, 7, 271):
            selected.append(row)
    source_incidence = {int(row["index"]): row for row in source["incidence_audit"]}
    factors = [factor_row(source_incidence[ell]) for ell in INCIDENCE_INDICES]
    assert not any(row["squarefull"] for row in factors)
    result = {
        "schema": "pell-factor-quotient-projective-coupling-v1",
        "policy": "Only a full-premise counterexample retires its exact claim; bounded no-hits retire nothing.",
        "source": {"path": str(args.source.relative_to(here.parent)),
                   "sha256": hashlib.sha256(raw).hexdigest()},
        "endpoint_audit": {
            "prime_index_count": len(indices),
            "largest_prime_index": indices[-1],
            "exact_curvature_identity_count": len(indices),
            "curvature_coprime_count": len(indices),
            "U_cube_nondivisibility_count": len(indices),
            "sha256": digest.hexdigest(),
            "selected_rows": selected,
        },
        "finite_actual_packet_exclusion": {
            "witnesses": witnesses,
            "pocklington_certificates": source.get("pocklington_certificates", {}),
        },
        "factor_quotient_rows": factors,
        "local_ledger_counterexample": local_counterexample(),
        "actual_index_seven_boundary": next(x for x in selected if x["index"] == 7),
        "claim_boundary": (
            "No actual squarefull packet occurs at odd prime index <=271.  "
            "The endpoint U^2 sharpness identity is unbounded; the finite packet exclusion is not."
        ),
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "status": "PASS",
        "endpoint_rows": len(indices),
        "factor_quotient_rows": len(factors),
        "exact_simple_witnesses": len(witnesses),
        "full_actual_packets": sum(row["squarefull"] for row in factors),
        "local_counterexample": [3, 7, 797],
        "output": str(args.output),
    }, indent=2))


if __name__ == "__main__":
    main()
