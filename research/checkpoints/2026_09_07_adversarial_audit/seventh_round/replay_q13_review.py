"""Independent exact checks supplementing the ordinary Q13 review.

No rank routine, point-height bound, or finite search is used to conclude
rational-point completeness.  That conclusion is the reviewed descent.
"""
from fractions import Fraction as Q
from itertools import product
import json


def add(a, b):
    c = dict(a)
    for k, v in b.items():
        c[k] = c.get(k, 0) + v
    return {k: v for k, v in c.items() if v}


def mul(a, b):
    c = {}
    for (i, j), v in a.items():
        for (k, l), w in b.items():
            key = (i + k, j + l)
            c[key] = c.get(key, 0) + v * w
    return {k: v for k, v in c.items() if v}


def scale(a, v):
    return {k: x * v for k, x in a.items() if x * v}


def power(a, n):
    out = {(0, 0): Q(1)}
    for _ in range(n):
        out = mul(out, a)
    return out


def const(x):
    return {(0, 0): Q(x)} if x else {}


def main():
    u, t = {(1, 0): Q(1)}, {(0, 1): Q(1)}
    A = add(power(u, 2), const(Q(-1, 13)))
    B = add(scale(u, 2), const(Q(-7, 13)))
    xx = add(const(91), scale(u, -338))
    lhs = add(add(power(xx, 3), scale(power(xx, 2), -13)), scale(xx, -507))
    rhs = scale(add(power(B, 2), scale(mul(A, B), -4)), 13 ** 6)
    assert lhs == rhs

    x = add(const(1), t)
    y = add(x, mul(u, power(t, 2)))
    f = add(add(add(add(power(x, 4), scale(power(x, 3), 3)),
                    scale(power(x, 2), 5)), scale(x, 3)), const(1))
    left = add(scale(power(y, 2), 13), scale(f, -1))
    right = scale(mul(power(t, 2), add(add(mul(A, power(t, 2)), mul(B, t)), B)), 13)
    assert left == right
    assert Q(7, 26) ** 2 - Q(1, 13) == Q(-3, 676)

    square16 = {i * i % 16 for i in range(16)}
    parity = {"odd-even": set(), "even-odd": set(), "odd-odd": set()}
    for U, V in product(range(16), repeat=2):
        if U % 2 == V % 2 == 0:
            continue
        label = ("odd" if U % 2 else "even") + "-" + ("odd" if V % 2 else "even")
        z = (-U ** 4 - 13 * U * U * V * V + 507 * V ** 4) % 16
        parity[label].add(z)
        assert z not in square16
    assert parity == {"odd-even": {15, 11}, "even-odd": {11, 7}, "odd-odd": {13, 5}}
    square13 = {i * i % 13 for i in range(13)}
    assert 6 not in square13 and 7 not in square13
    for sign in [-1, 1]:
        for U, V in product(range(13), repeat=2):
            if U == V == 0:
                continue
            assert (U ** 4 + sign * U * U * V * V - 3 * V ** 4) % 13 != 0
    counts = {}
    for p in [5, 7]:
        fibers = [sum((Y * Y - (X ** 3 - 13 * X * X - 507 * X)) % p == 0
                      for Y in range(p)) for X in range(p)]
        counts[str(p)] = {"fibers": fibers, "total": 1 + sum(fibers)}
    assert counts["5"] == {"fibers": [1, 2, 0, 2, 0], "total": 6}
    assert counts["7"] == {"fibers": [1, 0, 0, 0, 0, 2, 0], "total": 4}
    print(json.dumps({"status": "PASS", "exact_polynomial_identities": 2,
                      "primitive_mod16_pairs": 192, "nonzero_mod13_pairs_per_cover": 168,
                      "cover_count": 2, "good_reduction_counts": counts}, sort_keys=True))


if __name__ == "__main__":
    main()
