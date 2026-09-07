"""Exact rank-stratified local lifts and actual interval counts for RW1--RW3."""
from __future__ import annotations
import argparse
from collections import Counter
from fractions import Fraction
from hashlib import sha256
from json import dumps, loads
from math import gcd, isqrt
from pathlib import Path


def mul(x, y):
    a, b = x
    c, d = y
    return a*c-b*d, a*d+b*c+b*d


def power(x, n, modulus=None):
    out = (1, 0)
    while n:
        if n & 1:
            out = mul(out, x)
            if modulus:
                out = tuple(v % modulus for v in out)
        x = mul(x, x)
        if modulus:
            x = tuple(v % modulus for v in x)
        n //= 2
    return out


def boundary(x):
    a, b = x
    return a*b*(a+b)


def norm(x):
    a, b = x
    return a*a+a*b+b*b


def phi(n):
    return sum(gcd(k, n) == 1 for k in range(1, n+1))


def divisors(n):
    return [d for d in range(1, n+1) if n % d == 0]


def rank_map(p):
    group_order = p-(1 if p % 3 == 1 else -1)
    ranks = {}
    for k in range(p):
        w = (3*k, 1)
        q = norm(w) % p
        if not q:
            ranks[k] = None
            continue
        inv = pow(pow(q, 3, p), -1, p)
        alpha = tuple(v*inv % p for v in power(w, 6, p))
        cur = (1, 0)
        for d in range(1, group_order+1):
            cur = tuple(v % p for v in mul(cur, alpha))
            if cur == (1, 0):
                ranks[k] = d
                break
        assert ranks[k] and (group_order//3) % ranks[k] == 0
    return group_order, ranks


def valuation(x, p):
    assert x
    e = 0
    while x % p == 0:
        x //= p
        e += 1
    return e


def run():
    primes = [p for p in range(5, 62) if all(p % q for q in range(2, isqrt(p)+1))]
    maps = {p: rank_map(p) for p in primes}
    local_rows = []
    for p, maximum in [(5, 4), (7, 4), (11, 3), (13, 3), (19, 3), (31, 2), (43, 2)]:
        group_order, ranks = maps[p]
        possible = divisors(group_order//3)
        for precision in range(1, maximum+1):
            modulus = p**precision
            counts = Counter()
            for k in range(modulus):
                d = ranks[k % p]
                if d is None:
                    continue
                if boundary(power((3*k, 1), d, modulus)) % modulus == 0:
                    counts[d] += 1
            expected = {d: 3*phi(d)-(d == 1) for d in possible}
            assert dict(counts) == expected
            local_rows.append(dict(p=p, precision=precision,
                                   exact_rank_counts=[[d, counts[d]] for d in possible]))

    level_rows = 0
    actual_values = 0
    for b in (1, 5, 16, 41):
        for n in (1, 2, 5, 6, 11, 12):
            counts = Counter()
            maximum_depth = Counter()
            for k in range(b, 2*b):
                w = (3*k, 1)
                actual = abs(boundary(power(w, n)))
                assert actual and gcd(*power(w, n)) == 1
                for p in primes:
                    d = maps[p][1][k % p]
                    if d is None or n % d:
                        assert actual % p
                        continue
                    first = abs(boundary(power(w, d)))
                    s = valuation(first, p)
                    assert valuation(actual, p) == s+valuation(n, p)
                    assert first <= (6*b+1)**(3*d)
                    maximum_depth[p, d] = max(maximum_depth[p, d], s)
                    for e in range(1, s+1):
                        counts[p, d, e] += 1
                    actual_values += 1
            for (p, d), maximum in maximum_depth.items():
                roots = 3*phi(d)-(d == 1)
                for e in range(1, maximum+2):
                    assert counts[p, d, e] <= roots*(Fraction(b, p**e)+1)
                    level_rows += 1

    progression_rows = 0
    for n in range(1, 41):
        assert sum(phi(d) for d in divisors(n)) == n
        for d in divisors(n):
            for z in (5, 11, 31, 61):
                count = sum(p <= z and (p-1) % (3*d) == 0
                            or p <= z and (p+1) % (3*d) == 0 for p in primes)
                assert count <= Fraction(2*(z+1), 3*d)
                progression_rows += 1
    return dict(scope="Exact finite rank counts, lifts and actual interval inequalities; not full-tail proof",
                local_rows=local_rows, actual_blocks=24,
                actual_first_depth_values=actual_values, exact_interval_levels=level_rows,
                exact_progression_rows=progression_rows,
                retained_prime_bound=61)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    payload = run()
    canonical = dumps(payload, sort_keys=True, separators=(",", ":"))
    result = dict(payload=payload, canonical_sha256=sha256(canonical.encode()).hexdigest())
    path = Path(__file__).with_name("rank_root_replay.json")
    if args.check:
        assert loads(path.read_text(encoding="utf-8")) == result
    else:
        path.write_bytes((dumps(result, indent=2, sort_keys=True)+"\n").encode())
    print(dumps(dict(status="PASS", canonical_sha256=result["canonical_sha256"],
                     local_precision_rows=len(payload["local_rows"]),
                     actual_blocks=payload["actual_blocks"],
                     exact_interval_levels=payload["exact_interval_levels"],
                     actual_first_depth_values=payload["actual_first_depth_values"],
                     exact_progression_rows=payload["exact_progression_rows"]), sort_keys=True))


if __name__ == "__main__":
    main()
