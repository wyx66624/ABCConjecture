#!/usr/bin/env python3
"""Exact certificates and bounded diagnostics for AS and SG; no ABC claim."""
from pathlib import Path
import hashlib
import json
from math import gcd, isqrt
import sys

OUT = Path(__file__).with_name('finite_replay.json')


def add(*terms):
    result = {}
    for term in terms:
        for exponent, value in term.items():
            result[exponent] = result.get(exponent, 0) + value
    return {e: v for e, v in result.items() if v}


def scale(c, f):
    return {e: c*v for e, v in f.items() if c*v}


def mul(f, h):
    result = {}
    for e, c in f.items():
        for d, v in h.items():
            k = (e[0]+d[0], e[1]+d[1])
            result[k] = result.get(k, 0)+c*v
    return {e: v for e, v in result.items() if v}


def bareiss_det(matrix):
    a = [row[:] for row in matrix]
    previous, sign = 1, 1
    for k in range(len(a)-1):
        if not a[k][k]:
            j = next(j for j in range(k+1, len(a)) if a[j][k])
            a[k], a[j] = a[j], a[k]
            sign = -sign
        pivot = a[k][k]
        for i in range(k+1, len(a)):
            for j in range(k+1, len(a)):
                numerator = a[i][j]*pivot-a[i][k]*a[k][j]
                assert numerator % previous == 0
                a[i][j] = numerator//previous
        for i in range(k+1, len(a)):
            a[i][k] = 0
        previous = pivot
    return sign*a[-1][-1]


def discriminant(coefficients):
    n = len(coefficients)-1
    derivative = [(n-i)*coefficients[i] for i in range(n)]
    rows = []
    for i in range(n-1):
        rows.append([0]*i+coefficients+[0]*(n-2-i))
    for i in range(n):
        rows.append([0]*i+derivative+[0]*(n-1-i))
    resultant = bareiss_det(rows)
    assert resultant % coefficients[0] == 0
    return (-1)**(n*(n-1)//2)*resultant//coefficients[0]


def F(a, b):
    return a**4+3*a**3*b+5*a*a*b*b+3*a*b**3+b**4


def diagonal_slice(c):
    assert c != 0
    target = 3*c**4
    results = set()
    for d1 in range(1, isqrt(target)+1):
        if target % d1:
            continue
        d2 = target//d1
        if d1 >= d2 or (d1+d2) % 52 or (d2-d1) % 2:
            continue
        q, A = (d1+d2)//52, (d2-d1)//2
        if (A-7*c*c) % 26:
            continue
        u = (A-7*c*c)//26
        if u <= 0:
            continue
        h = isqrt(c*c+4*u)
        if h*h != c*c+4*u or h <= abs(c) or (h-c) % 2:
            continue
        a, b = (h+c)//2, (h-c)//2
        assert a-b == c and F(a, b) == 13*q*q
        results.add((a, b, q))
    return results


def main():
    f = {(4, 0): 1, (3, 1): 3, (2, 2): 5, (1, 3): 3, (0, 4): 1}
    S = {(2, 0): 8, (1, 1): 12, (0, 2): 11}
    A = {(2, 0): 7, (1, 1): 12, (0, 2): 7}
    difference = {(1, 0): 1, (0, 1): -1}
    difference2 = mul(difference, difference)
    identities = {
        'axis_gap': add(mul(S, S), scale(-64, f), {(1, 3): -72, (0, 4): -57}),
        'diagonal_gap': add(scale(52, f), scale(-1, mul(A, A)), scale(-3, mul(difference2, difference2))),
    }
    assert all(not residual for residual in identities.values())
    discriminants = [discriminant([1, 3, 5, 3, 1]), discriminant([13, 26, 20, 7, 1])]
    assert discriminants == [117, 117]
    residues = []
    for a in range(8):
        for b in range(8):
            if a % 2 == b % 2 == 0:
                continue
            s = 8*a*a+12*a*b+11*b*b
            r = s % 8 or 8
            assert r in (3, 4, 7, 8)
            residues.append([a, b, r])
    tested = 0
    square_seeds = []
    thirteen_seeds = []
    for b in range(1, 151):
        for a in range(b, 1001):
            if gcd(a, b) != 1:
                continue
            tested += 1
            value = F(a, b)
            q = isqrt(value)
            if q*q == value:
                for u, v in ((a, b), (b, a)):
                    s = 8*u*u+12*u*v+11*v*v
                    r = s % 8 or 8
                    assert 2*r*u < 9*v**3
                assert 2*a < 3*b**3
                square_seeds.append([a, b, q])
            if value % 13 == 0:
                q = isqrt(value//13)
                if 13*q*q == value:
                    c = a-b
                    assert c == 0 or 52*a*b+14*c*c+1 <= 3*c**4
                    thirteen_seeds.append([a, b, q])
    assert [355, 101, 192529] in square_seeds
    slices, classified = 0, []
    for c in range(-80, 81):
        if c == 0:
            continue
        all_points = diagonal_slice(c)
        brute = set()
        for b in range(1, 501):
            a = b+c
            if a <= 0:
                continue
            value = F(a, b)
            if value % 13 == 0:
                q = isqrt(value//13)
                if 13*q*q == value:
                    brute.add((a, b, q))
        assert brute == {point for point in all_points if point[1] <= 500}
        classified.extend(sorted(all_points))
        slices += 1
    payload = {
        'scope': 'exact integer polynomial certificates; bounded seed/slice diagnostics, no global nonexistence claim',
        'zero_coefficient_certificates': list(identities),
        'chart_discriminants_at_c_one': discriminants,
        'primitive_mod_eight_rows': residues,
        'primitive_positive_seed_scan': {'count': tested, 'a_max': 1000, 'b_max': 150, 'a_ge_b': True},
        'square_seeds': square_seeds,
        'thirteen_square_seeds': thirteen_seeds,
        'complete_nonzero_slices': {'count': slices, 'max_abs_c': 80, 'all_classified_points': classified},
        'slice_brute_comparison_b_max': 500,
        'not_verified_by_this_replay': ['effective transcendence theorem', 'Brun-Titchmarsh theorem', 'all moving slices', 'ABC'],
    }
    compact = json.dumps(payload, sort_keys=True, separators=(',', ':')).encode()
    document = {'payload_sha256': hashlib.sha256(compact).hexdigest(), 'payload': payload}
    data = (json.dumps(document, sort_keys=True, indent=2)+'\n').encode()
    if '--check' in sys.argv:
        assert OUT.read_bytes() == data, 'Canonical replay changed'
    else:
        OUT.write_bytes(data)
    print(json.dumps({'status': 'PASS', 'payload_sha256': document['payload_sha256'], 'file_sha256': hashlib.sha256(data).hexdigest(), 'primitive_seeds_tested': tested, 'classified_slices': slices}))


if __name__ == '__main__':
    main()
