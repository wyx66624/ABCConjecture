"""Exact CP finite accounting, reusing the actual checked CC products."""
from __future__ import annotations
import argparse
import hashlib
import json
from math import gcd
from pathlib import Path
from replay_collective_content import run as cc_run, primes_to

HERE = Path(__file__).resolve().parent
OUT = HERE / 'verification' / 'collective_profile_exact.json'


def seal(n):
    return hashlib.sha256(hex(n).encode()).hexdigest()


def run():
    cc = cc_run()  # Includes literal coordinate multiplication and Int gcd checks.
    profiles, extraction_checks = [], 0
    for row in cc['blocks']:
        B = row['B']
        cap = 1
        hp = {}
        for p in primes_to(12*B):
            if p % 3 != 1:
                continue
            h, power = 0, p
            while power <= 36*B*B:
                h += 1
                power *= p
            hp[p] = h
            cap *= p**h
        R = D = N = radical = 1
        depths = {}
        for p, _, discrepancy, _ in row['full_oriented_rows']:
            e = abs(discrepancy)
            depths[p] = e
            N *= p**e
            if e:
                radical *= p
            if p <= 12*B:
                assert e <= hp[p]
                D *= p**e
            else:
                assert e <= 1
                R *= p**e
        assert N == R*D and gcd(R, D) == 1
        assert cap % D == 0 and D % (N//radical) == 0
        extracts = []
        # These are the maximal possible complete g-th-power roots of the
        # actual N, for every g which can have any root Q>1. Every smaller
        # root Q divides this one. No search over unspecified large factors.
        for g in range(2, max(depths.values(), default=0)+1):
            Q = 1
            for p, e in depths.items():
                Q *= p**(e//g)
            if Q == 1:
                continue
            qg = Q**g
            V = N//qg
            assert N == V*qg and V % R == 0 and D % qg == 0
            extracts.append(dict(g=g, Q_hash=seal(Q), V_hash=seal(V)))
            extraction_checks += 1
        profiles.append(dict(B=B, private_radical_hash=seal(R),
                             small_remainder_hash=seal(D), cap_hash=seal(cap),
                             maximal_power_extractions=extracts))
    return dict(schema=1, scope='exact actual full-block CP divisibilities only; not asymptotics or boundary radical',
                counts=dict(profiles=len(profiles), maximal_power_extractions=extraction_checks),
                inherited_actual_CC_counts=cc['counts'], profiles=profiles)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    result = run()
    raw = (json.dumps(result, indent=2, sort_keys=True)+'\n').encode()
    if args.check:
        assert OUT.read_bytes() == raw, 'canonical mismatch'
    else:
        OUT.parent.mkdir(parents=True, exist_ok=True)
        OUT.write_bytes(raw)
    print('PASS', json.dumps(result['counts'], sort_keys=True), hashlib.sha256(raw).hexdigest())


if __name__ == '__main__':
    main()
