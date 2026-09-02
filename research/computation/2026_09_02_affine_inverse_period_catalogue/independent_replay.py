#!/usr/bin/env python3
"""Independent arithmetic replay for the affine inverse-period report.

This script imports none of the search or certificate modules in this
directory.  It uses direct divisor enumeration and modular congruences to
recompute the two delicate boundary examples and the three sharp constants.
"""

from fractions import Fraction
from itertools import product
from json import dumps
from math import gcd


def factor_trial(n: int) -> dict[int, int]:
    ans: dict[int, int] = {}
    divisor = 2
    while divisor * divisor <= n:
        if n % divisor:
            divisor += 1
            continue
        exponent = 0
        while n % divisor == 0:
            n //= divisor
            exponent += 1
        ans[divisor] = exponent
        divisor += 1
    if n > 1:
        ans[n] = 1
    return ans


def divisors_from_factorization(n: int) -> list[int]:
    values = [1]
    for prime, exponent in factor_trial(n).items():
        values = [d * prime**e for d in values for e in range(exponent + 1)]
    return sorted(values)


def phi(n: int) -> int:
    return sum(1 for a in range(1, n + 1) if gcd(a, n) == 1)


def powerful_kernel(n: int) -> int:
    return product_int(p**e for p, e in factor_trial(n).items() if e >= 2)


def product_int(values) -> int:
    ans = 1
    for value in values:
        ans *= value
    return ans


def arms(B: int, C: int, R: int, h: int, k: int) -> tuple[int, int, int]:
    return 1 + R * h, 1 + R * (h + C * k), 1 + R * (h + B * k)


def large_tail(kernel: tuple[int, int, int], N: int):
    ans = []
    for label in product(*(divisors_from_factorization(k) for k in kernel)):
        if product_int(label) > N * N:
            ans.append((label, product_int(phi(d) for d in label)))
    return sorted(ans)


def sharp_constant_replay() -> dict:
    for n in range(0, 20001):
        shifted = max(n - 1, 0)
        assert n**3 <= n + 6 * shifted**3
        if n >= 3:
            assert n**3 <= n + 3 * shifted**3
        if n >= 2:
            assert n**3 <= 8 * shifted**3
    assert 8 == 2 + 6 and 27 == 3 + 3 * 8 and 8 == 8 * 1
    return {"checked_n": [0, 20000], "sharp_constants": [6, 3, 8]}


def euler_q_replay() -> dict:
    top = (1, 49, 27)
    coefficient = (5, 49, 45)
    N = 29
    full = Fraction(0)
    tail = Fraction(0)
    tail_labels = []
    for label in product(*(divisors_from_factorization(k) for k in top)):
        weight = product_int(phi(d) for d in label)
        capture = product_int(gcd(d, abs(a)) for d, a in zip(label, coefficient))
        period = product_int(label) // capture
        term = Fraction(weight, period * period)
        full += term
        if product_int(label) > N * N:
            tail += term
            tail_labels.append(label)
    assert full == 539
    assert tail == 84 and tail_labels == [top]
    assert 539 > 441 and 1323 == 3 * 441 and 1323 % 441 == 0
    return {
        "top": top,
        "coefficient": coefficient,
        "full_euler_mass": str(full),
        "large_tail_mass": str(tail),
        "Cg_Tg_q0_P0": [441, 3, 3, 441],
    }


def subcritical_replay() -> dict:
    B, C, R = 8, 9, 6
    M = C**6 // (4 * R)
    N = M - 1
    label = (137**2, 173**2, 1)
    D = product_int(label)
    assert (M, N, D, N * N) == (22143, 22142, 561737401, 490268164)
    assert R < C and D > N * N

    # Solve the two congruences directly, then list representatives in the box.
    h_modulus = label[0]
    h_residue = ((-1) * pow(R, -1, h_modulus)) % h_modulus
    hs = [h for h in range(h_residue, M + 1, h_modulus) if 1 <= h <= M]
    fibre = []
    for h in hs:
        k_modulus = label[1]
        k_residue = (-(1 + R * h) * pow(R * C, -1, k_modulus)) % k_modulus
        ks = [k for k in range(k_residue, M + 1, k_modulus) if 1 <= k <= M]
        assert len(ks) == 1
        fibre.append((h, ks[0]))
    assert fibre == [(3128, 10183), (21897, 11423)]

    rows = [arms(B, C, R, *point) for point in fibre]
    assert rows == [
        (18769, 568651, 507553),
        (131383, 748225, 679687),
    ]
    for (_, k), row in zip(fibre, rows):
        assert gcd(row[0], k) == 1
        assert all(gcd(row[i], row[j]) == 1 for i, j in ((0, 1), (0, 2), (1, 2)))
    kernels = [tuple(powerful_kernel(v) for v in row) for row in rows]
    assert kernels == [(18769, 29929, 1), (18769, 748225, 1)]
    assert kernels[0] != kernels[1]

    direction = tuple(fibre[1][i] - fibre[0][i] for i in (0, 1))
    assert gcd(*direction) == 1 and direction == (18769, 1240)
    coefficient = (direction[0], direction[0] + C * direction[1],
                   direction[0] + B * direction[1])
    assert coefficient == (18769, 29929, 28689)
    capture = product_int(gcd(d, a) for d, a in zip(label, coefficient))
    period = D // capture
    weight = phi(label[0]) * phi(label[1])
    assert capture == D and period == 1
    assert weight == 554413792
    assert Fraction(weight, D) == Fraction(23392, 23701)
    assert N * max(direction) == 415583198 < D

    tails = [large_tail(kernel, N) for kernel in kernels]
    assert tails == [
        [(label, 554413792)],
        [
            (label, 554413792),
            ((18769, 149645, 1), 2217655168),
            ((18769, 748225, 1), 11088275840),
        ],
    ]
    class_tail_masses = [sum(w for _, w in tail) for tail in tails]
    assert class_tail_masses == [554413792, 13860344800]
    return {
        "parameters": [B, C, R, M, N],
        "R_lt_C": R < C,
        "fibre": fibre,
        "kernel_classes": kernels,
        "class_multiplicities_in_complete_fibre": [1, 1],
        "label": label,
        "D": D,
        "period": period,
        "weight": weight,
        "weight_over_D": str(Fraction(weight, D)),
        "class_tail_masses": class_tail_masses,
    }


def main() -> None:
    result = {
        "sharp_constants": sharp_constant_replay(),
        "q_euler_boundary": euler_q_replay(),
        "subcritical_boundary": subcritical_replay(),
    }
    print(dumps(result, indent=2, sort_keys=True))
    print("PASS: independent direct-divisor and congruence replay")


if __name__ == "__main__":
    main()
