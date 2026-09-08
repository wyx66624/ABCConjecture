"""Independent complete square-fibre enumeration for QS2/QS4.

Uses F25 = F5[sqrt(3)] and F49 = F7[sqrt(5)], different defining
polynomials from the author's tables. No norm-character shortcut or CAS.
"""
import argparse
import hashlib
import json
from collections import Counter
from pathlib import Path


def trim(a):
    while len(a) > 1 and a[-1] == 0:
        a.pop()
    return a


def polynomial_product(a, b):
    c = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i + j] += x * y
    return c


def gcd_mod(a, b, p):
    a, b = trim([x % p for x in a]), trim([x % p for x in b])
    while b != [0]:
        while len(a) >= len(b) and a != [0]:
            shift = len(a) - len(b)
            factor = a[-1] * pow(b[-1], -1, p) % p
            for j, x in enumerate(b):
                a[j + shift] = (a[j + shift] - factor * x) % p
            trim(a)
        a, b = b, a
    scale = pow(a[-1], -1, p)
    return [(x * scale) % p for x in a]


def count(p, non_square, coefficients):
    assert pow(non_square, (p - 1) // 2, p) == p - 1

    def add(x, y):
        return ((x[0] + y[0]) % p, (x[1] + y[1]) % p)

    def mul(x, y):
        return ((x[0] * y[0] + non_square * x[1] * y[1]) % p,
                (x[0] * y[1] + x[1] * y[0]) % p)

    def evaluate(x):
        value = (0, 0)
        for c in reversed(coefficients):
            value = add(mul(value, x), (c % p, 0))
        return value

    elements = [(a, b) for b in range(p) for a in range(p)]
    all_squares = Counter(mul(y, y) for y in elements)
    base_squares = Counter(y * y % p for y in range(p))
    fibres = [all_squares[evaluate(x)] for x in elements]
    base_fibres = [base_squares[evaluate((a, 0))[0]] for a in range(p)]
    assert all(v in (0, 1, 2) for v in fibres)
    # The monic sextic has two smooth rational points at infinity.
    return {'prime': p, 'extension_non_square': non_square,
            'base_square_fibres': base_fibres,
            'extension_square_fibres_by_b_then_a':
                [fibres[i:i+p] for i in range(0, p*p, p)],
            'infinity_points': 2,
            'N1': sum(base_fibres) + 2, 'N2': sum(fibres) + 2}


def certificate():
    rows = []
    for name, t, u in [('H2', 1, 4), ('H3', 0, 4)]:
        f = lambda v: [-1, 3*v-3, 3*v, 1]
        coefficients = polynomial_product(f(t), f(u))
        derivative = [i*c for i, c in enumerate(coefficients)][1:]
        for p, non_square in [(5, 3), (7, 5)]:
            assert gcd_mod(coefficients, derivative, p) == [1]
            row = count(p, non_square, coefficients)
            row.update({'curve': name, 'sextic_coefficients_ascending': coefficients,
                        'sextic_derivative_gcd_mod_p': [1]})
            s1, s2 = p+1-row['N1'], p*p+1-row['N2']
            assert (s1*s1-s2) % 2 == 0
            row['frobenius_coefficients_descending'] = [1, -s1, (s1*s1-s2)//2, -p*s1, p*p]
            row['jacobian_special_fibre_order'] = sum(row['frobenius_coefficients_descending'])
            rows.append(row)
    assert [(r['curve'], r['prime'], r['N1'], r['N2']) for r in rows] == [
        ('H2', 5, 6, 36), ('H2', 7, 11, 61),
        ('H3', 5, 6, 12), ('H3', 7, 11, 61)]
    assert [r['jacobian_special_fibre_order'] for r in rows] == [31, 84, 19, 84]
    return {'status': 'PASS', 'method': 'Complete direct square-fibre enumeration in alternative quadratic field models; polynomial Euclidean algorithm for good-prime squarefreeness.',
            'scope': 'Four exact finite curve/prime counts. Frobenius interpretation, rational simplicity, torsion specialization and rank conclusions are ordinary mathematics, not proved by this script.',
            'rows': rows}


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    target = Path(__file__).parent / 'verification/quotient_counts.json'
    payload = (json.dumps(certificate(), sort_keys=True, indent=2) + '\n').encode()
    if args.check:
        assert target.read_bytes() == payload, 'certificate bytes differ'
    else:
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_bytes(payload)
    print('PASS', hashlib.sha256(payload).hexdigest())
