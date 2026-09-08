#!/usr/bin/env python3
"""Independent QS4 replay using actual F49 square fibres."""
from collections import Counter
from pathlib import Path
import json


def add(x, y):
    return ((x[0] + y[0]) % 7, (x[1] + y[1]) % 7)


def mul(x, y):
    return ((x[0] * y[0] + 3 * x[1] * y[1]) % 7,
            (x[0] * y[1] + x[1] * y[0]) % 7)


def cubic(t, x):
    z = (1, 0)
    for c in (3 * t, 3 * t - 3, -1):
        z = add(mul(z, x), (c % 7, 0))
    return z


def main():
    square_fibres = Counter(mul((a, b), (a, b))
                            for a in range(7) for b in range(7))
    rows = {}
    for name, ts in [('H2', (1, 4)), ('H3', (0, 4))]:
        table = [[square_fibres[mul(cubic(ts[0], (a, b)),
                                   cubic(ts[1], (a, b)))] - 1
                  for a in range(7)] for b in range(7)]
        count49 = 49 + sum(map(sum, table)) + 2
        count7 = sum(1 for a in range(7) for y in range(7)
                     if (y * y % 7, 0) ==
                     mul(cubic(ts[0], (a, 0)), cubic(ts[1], (a, 0)))) + 2
        assert count49 == 61 and count7 == 11
        s1, s2 = 8 - count7, 50 - count49
        polynomial = [1, -s1, (s1 * s1 - s2) // 2, -7 * s1, 49]
        assert polynomial == [1, 3, 10, 21, 49]
        rows[name] = dict(character_table_from_y_enumeration=table,
                          point_count_f7=count7, point_count_f49=count49,
                          frobenius_polynomial_descending=polynomial,
                          jacobian_order_f7=sum(polynomial))
    result = dict(status='PASS', method='Exact actual square-fibre enumeration; no rank API',
                  field='F7[omega]/(omega^2-3)', curves=rows,
                  scope='Finite good-prime arithmetic only; torsion and rank inference remain ordinary')
    Path(__file__).with_name('peer_qs_seven_review.json').write_bytes(
        (json.dumps(result, indent=2) + '\n').encode())
    print(json.dumps(result))


if __name__ == '__main__':
    main()
