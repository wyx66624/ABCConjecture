"""Independent exact arithmetic certificates for the ordinary Q13 proof."""
import argparse
from fractions import Fraction as Q
import hashlib
import itertools
import json
from pathlib import Path


def add(*polys):
    result = {}
    for poly in polys:
        for monomial, value in poly.items():
            result[monomial] = result.get(monomial, Q(0)) + value
    return {m: v for m, v in result.items() if v}


def scale(poly, c):
    return {m: c*v for m, v in poly.items() if c*v}


def mul(p, q):
    out = {}
    for (i, j), a in p.items():
        for (k, l), b in q.items():
            m = i+k, j+l
            out[m] = out.get(m, Q(0)) + a*b
    return {m: v for m, v in out.items() if v}


def power(p, n):
    out = {(0, 0): Q(1)}
    for _ in range(n):
        out = mul(out, p)
    return out


def const(c):
    return {(0, 0): Q(c)}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    u, t = {(1, 0): Q(1)}, {(0, 1): Q(1)}
    A, B = add(power(u, 2), const(-Q(1, 13))), add(scale(u, 2), const(-Q(7, 13)))
    X = add(const(91), scale(u, -338))
    constraint = add(mul(A, power(t, 2)), mul(B, t), B)
    y = add(const(1), t, mul(u, power(t, 2)))
    x = add(const(1), t)
    f = add(power(x, 4), scale(power(x, 3), 3), scale(power(x, 2), 5), scale(x, 3), const(1))
    assert add(scale(power(y, 2), 13), scale(f, -1)) == scale(mul(power(t, 2), constraint), 13)
    delta = add(power(B, 2), scale(mul(A, B), -4))
    cubic = add(power(X, 3), scale(power(X, 2), -13), scale(X, -507))
    assert cubic == scale(delta, 13**6)
    expression = add(scale(mul(A, t), 2), B)
    assert add(power(expression, 2), scale(delta, -1)) == scale(mul(A, constraint), 4)
    assert Q(7, 26)**2 - Q(1, 13) == -Q(3, 676)
    assert 2*Q(7, 26) - Q(7, 13) == 0

    square16 = {n*n % 16 for n in range(16)}
    residues16 = set()
    parity_pairs = 0
    for U, V in itertools.product(range(16), repeat=2):
        if U % 2 == 0 and V % 2 == 0:
            continue
        value = (-U**4 - 13*U*U*V*V + 507*V**4) % 16
        assert value not in square16
        residues16.add(value)
        parity_pairs += 1
    for sign in [-1, 1]:
        for U, V in itertools.product(range(13), repeat=2):
            if U == V == 0:
                continue
            assert (U**4 + sign*U*U*V*V - 3*V**4) % 13 != 0

    point_rows = []
    for prime in [5, 7]:
        counts = [sum((Y*Y - X**3 + 13*X*X + 507*X) % prime == 0
                      for Y in range(prime)) for X in range(prime)]
        point_rows.append(dict(prime=prime, counts=counts, total=1+sum(counts)))
    assert [row['total'] for row in point_rows] == [6, 4]
    assert 1+3+5+3+1 == 13
    result = dict(
        scope='Exact algebra/local residues/torsion point counts; no software rank premise.',
        polynomial_identities=3,
        exceptional_map_values=dict(u='7/26', A='-3/676', B='0'),
        mod16_pairs=parity_pairs, mod16_obstruction_residues=sorted(residues16),
        mod13_nonzero_pairs_per_sign=168,
        mod13_square_residues=sorted({x*x % 13 for x in range(13)}),
        good_reduction_points=point_rows,
        cubic_coefficients={str(m):str(v) for m,v in sorted(cubic.items())}
    )
    blob = (json.dumps(result, indent=2, sort_keys=True)+'\n').encode('utf-8')
    path = Path(__file__).with_name('quartic_13_results.json')
    if args.check:
        assert path.read_bytes() == blob
    else:
        path.write_bytes(blob)
    print(json.dumps(dict(status='PASS', sha256=hashlib.sha256(blob).hexdigest()), sort_keys=True))


if __name__ == '__main__':
    main()
