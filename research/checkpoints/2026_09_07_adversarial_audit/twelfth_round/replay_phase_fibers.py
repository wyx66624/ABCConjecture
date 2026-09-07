#!/usr/bin/env python3
"""Exact finite supplement to PF; no prime-power deep membership claim."""
from collections import defaultdict
from fractions import Fraction
from functools import lru_cache
from math import gcd, isqrt, prod
from pathlib import Path
import argparse
import hashlib
import json

HERE = Path(__file__).resolve().parent


@lru_cache(None)
def factors(n):
    assert n > 0
    original = n
    out = []
    p = 2
    while p * p <= n:
        if n % p == 0:
            e = 0
            while n % p == 0:
                n //= p
                e += 1
            out.append((p, e))
        p = 3 if p == 2 else p + 2
    if n > 1:
        out.append((n, 1))
    assert prod(p ** e for p, e in out) == original
    for p, _ in out:
        assert p >= 2 and all(p % d for d in range(2, isqrt(p) + 1))
    return tuple(out)


def divisors(n):
    ds = [1]
    for p, e in factors(n):
        ds = [d * p ** j for d in ds for j in range(e + 1)]
    return sorted(ds)


def phase(a, b):
    return Fraction(a * b - 1, a + b + 1)


def divisor_pairs(u, v, B=None):
    assert u > 0 and v > 0 and gcd(u, v) == 1
    K = u * u + u * v + v * v
    modulus = v if B is None else 3 * v
    if B is not None and ((u + v) % 3 or (u * v) % 3 == 0):
        return []
    answer = []
    for P in divisors(K):
        if (P + u) % modulus:
            continue
        Q = K // P
        assert (Q + u) % modulus == 0
        a, b = (P + u) // v, (Q + u) // v
        assert a > 0 and b > 0 and phase(a, b) == Fraction(u, v)
        if B is not None and not (3 * B <= a < 6 * B and 3 * B <= b < 6 * B):
            continue
        answer.append((a, b))
    return sorted(answer)


def build():
    block_rows = 0
    phase_rows = 0
    conditional_injective = 0
    for B in range(1, 21):
        actual = defaultdict(list)
        for a in range(3 * B, 6 * B, 3):
            for b in range(3 * B, 6 * B, 3):
                actual[phase(a, b)].append((a, b))
                block_rows += 1
        for h, pairs in actual.items():
            u, v = h.numerator, h.denominator
            assert sorted(pairs) == divisor_pairs(u, v, B)
            assert B < h < 3 * B
            assert Fraction(9 * B * B - 1, 6 * B + 1) <= h
            assert h <= Fraction((6 * B - 3) ** 2 - 1, 12 * B - 5)
            K = u * u + u * v + v * v
            cap = 1 + (2 * B - 2) // v
            unordered = {tuple(sorted(p)) for p in pairs}
            assert len(unordered) <= cap
            assert len(pairs) <= min(len(divisors(K)), 2 * cap)
            if v > 2 * B - 2:
                assert len(unordered) == 1
                conditional_injective += 1
            phase_rows += 1

    positive_input_rows = 0
    for a in range(1, 41):
        for b in range(1, 41):
            h = phase(a, b)
            if h == 0:
                continue
            assert (a, b) in divisor_pairs(h.numerator, h.denominator)
            positive_input_rows += 1

    B = 7 ** 4
    examples = []
    for u, required in [
        (4526, [(7809, 10767), (8397, 9819)]),
        (4799, [(7668, 12828), (8922, 10386), (9480, 9720)]),
    ]:
        K = u * u + u + 1
        all_pairs = divisor_pairs(u, 1, B)
        for a, b in required:
            assert (a, b) in all_pairs and (b, a) in all_pairs
            assert a % 3 == b % 3 == 0 and B <= a // 3 < 2 * B and B <= b // 3 < 2 * B
            assert (a - u) * (b - u) == K
        examples.append(dict(n=7, B=B, u=u, v=1, K=K,
                             prime_factorization=factors(K),
                             all_ordered_block_pairs=all_pairs,
                             displayed_factor_pairs=[(a-u, b-u) for a,b in required]))

    candidates = [u for u in range((3 * B) // 2, 3 * B) if u % 3 == 2]
    assert len(candidates) == 1201
    maximum = 0
    maximizing = []
    for u in candidates:
        pairs = divisor_pairs(u, 1, B)
        count = len({tuple(sorted(p)) for p in pairs})
        if count > maximum:
            maximum, maximizing = count, [u]
        elif count == maximum:
            maximizing.append(u)
    assert maximum == 3 and maximizing == [4799]
    return dict(
        status='PASS: exact bounded arithmetic only',
        block_B_range=[1, 20], actual_ordered_block_pairs=block_rows,
        distinct_block_phase_checks=phase_rows,
        conditional_injective_fibers=conditional_injective,
        positive_input_range=[1, 40], positive_input_checks=positive_input_rows,
        examples=examples,
        bounded_search=dict(B=B, phase_denominator=1, u_mod_3=2,
                            u_interval=[(3*B)//2, 3*B], upper_exclusive=True,
                            phases_checked=len(candidates), max_unordered_pairs=maximum,
                            maximizing_u=maximizing),
        not_claimed=['deep-prime membership of examples', 'maximum over all rational phases',
                     'uniform phase-fiber bound proved by testing', 'ABC proof or disproof'])


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    payload = build()
    encoded = (json.dumps(payload, indent=2, sort_keys=True) + '\n').encode('utf-8')
    target = HERE / 'phase_fiber_results.json'
    if args.check:
        assert target.read_bytes() == encoded, 'canonical replay differs'
    else:
        target.write_bytes(encoded)
    print(json.dumps(dict(status='PASS', sha256=hashlib.sha256(encoded).hexdigest(),
                         actual_pairs=payload['actual_ordered_block_pairs'],
                         phase_checks=payload['distinct_block_phase_checks'],
                         positive_input_checks=payload['positive_input_checks'],
                         searched_integer_phases=payload['bounded_search']['phases_checked'])))


if __name__ == '__main__':
    main()
