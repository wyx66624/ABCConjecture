"""Exact finite certificates supplementing the ordinary BC proofs."""
import argparse
import hashlib
import itertools
import json
from pathlib import Path


def matrix_row(p):
    counts = dict(total=0, eigen_one=0, eigen_minus_one=0, both=0, union=0)
    for a, b, c, d in itertools.product(range(p), repeat=4):
        det = (a * d - b * c) % p
        if det == 0:
            continue
        tr = (a + d) % p
        one = (tr - det - 1) % p == 0
        minus = (tr + det + 1) % p == 0
        counts['total'] += 1
        counts['eigen_one'] += one
        counts['eigen_minus_one'] += minus
        counts['both'] += one and minus
        counts['union'] += one or minus
    assert counts == dict(total=p * (p - 1)**2 * (p + 1),
                         eigen_one=p * (p*p - 2),
                         eigen_minus_one=p * (p*p - 2),
                         both=p * (p + 1),
                         union=p * (2*p*p - p - 5))
    return dict(p=p, **counts)


def prime_factors(n):
    out = []
    d = 2
    while d * d <= n:
        if n % d == 0:
            out.append(d)
            while n % d == 0:
                n //= d
        d += 1
    if n > 1:
        out.append(n)
    return out


def point_rows(q):
    rows = []
    for r in range(q):
        if (r*r + 3) % q:
            continue
        total = 1 + sum((y*y - x*x*x - 12*x*x - 6*(3+r)*x) % q == 0
                        for x, y in itertools.product(range(q), repeat=2))
        trace = q + 1 - total
        B = (q+1)**2 - trace**2
        assert trace**2 <= 4*q and B > 0
        rows.append(dict(q=q, r=r, affine_pairs_enumerated=q*q,
                         points=total, trace=trace, B=B,
                         prime_divisors_B=prime_factors(B)))
    assert len(rows) == 2 and rows[0]['B'] == rows[1]['B']
    return rows


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    result = dict(
        scope='Finite GL2 counts and full boundary point counts; not a global-power existence test.',
        matrix_counts=[matrix_row(p) for p in [3, 5, 7, 11, 13, 17, 19]],
        point_counts=[row for q in [7, 13, 19, 31] for row in point_rows(q)],
        exception='The Frobenius divisibility B_q applies only when q differs from the residual prime p.'
    )
    blob = (json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + '\n').encode('utf-8')
    path = Path(__file__).with_name('boundary_support_results.json')
    if args.check:
        assert path.read_bytes() == blob
    else:
        path.write_bytes(blob)
    print(json.dumps(dict(status='PASS', matrix_primes=7, point_counts=8,
                          sha256=hashlib.sha256(blob).hexdigest()), sort_keys=True))


if __name__ == '__main__':
    main()
