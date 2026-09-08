#!/usr/bin/env python3
"""Independent QS certificate: count actual y roots in F5 and F25."""
from collections import Counter
from pathlib import Path
import json


def add(x, y):
    return ((x[0] + y[0]) % 5, (x[1] + y[1]) % 5)


def mul(x, y):
    return ((x[0] * y[0] + 2 * x[1] * y[1]) % 5,
            (x[0] * y[1] + x[1] * y[0]) % 5)


def cubic(t, x):
    z = (1, 0)
    for c in (3 * t, 3 * t - 3, -1):
        z = add(mul(z, x), (c % 5, 0))
    return z


def main():
    field = [(a, b) for b in range(5) for a in range(5)]
    square_fibres = Counter(mul(y, y) for y in field)
    rows = {}
    expected = {
        'H2': ([[1, 1, 1, 1, 1], [1, 1, -1, 1, 1],
                [1, -1, -1, -1, 1], [1, -1, -1, -1, 1],
                [1, 1, -1, 1, 1]], 36),
        'H3': ([[1, 1, 1, 1, 1]] + [[-1] * 5 for _ in range(4)], 12),
    }
    for name, ts in [('H2', (1, 4)), ('H3', (0, 4))]:
        table = [[square_fibres[mul(cubic(ts[0], (a, b)),
                                   cubic(ts[1], (a, b)))] - 1
                  for a in range(5)] for b in range(5)]
        count25 = 25 + sum(map(sum, table)) + 2
        count5 = sum(1 for a in range(5) for y in range(5)
                     if (y * y % 5, 0) ==
                     mul(cubic(ts[0], (a, 0)), cubic(ts[1], (a, 0)))) + 2
        assert table == expected[name][0]
        assert count25 == expected[name][1]
        assert count5 == 6
        s1, s2 = 6 - count5, 26 - count25
        assert (s1 * s1 - s2) % 2 == 0
        polynomial = [1, -s1, (s1 * s1 - s2) // 2, -5 * s1, 25]
        rows[name] = dict(character_table_from_y_enumeration=table,
                          point_count_f5=count5, point_count_f25=count25,
                          frobenius_polynomial_descending=polynomial)
    result = dict(status='PASS', method='Exact enumeration of actual square fibres; no rank API',
                  field='F5[omega]/(omega^2-2)', curves=rows,
                  scope='Finite point counts only; ordinary geometry and arithmetic inputs separate')
    output = Path(__file__).with_name('peer_qs_five_review.json')
    output.write_bytes((json.dumps(result, indent=2) + '\n').encode())
    print(json.dumps(result))


if __name__ == '__main__':
    main()
