#!/usr/bin/env python3
"""Exact standalone replay of the canonical M=388 T=1 non-arm witness."""

from __future__ import annotations

import json
from itertools import product
from math import gcd, isqrt


def factor(n: int) -> dict[int, int]:
    out: dict[int, int] = {}
    p = 2
    while p * p <= n:
        while n % p == 0:
            out[p] = out.get(p, 0) + 1
            n //= p
        p = 3 if p == 2 else p + 2
    if n > 1:
        out[n] = out.get(n, 0) + 1
    return out


def radical(n: int) -> int:
    out = 1
    for p in factor(n):
        out *= p
    return out


def powerful_kernel(n: int) -> int:
    out = 1
    for p, e in factor(n).items():
        if e >= 2:
            out *= p**e
    return out


def divisors(n: int) -> list[int]:
    out = [1]
    for p, e in factor(n).items():
        old = out[:]
        power = 1
        for _ in range(e):
            power *= p
            out += [d * power for d in old]
    return sorted(out)


def totient(n: int) -> int:
    out = n
    for p in factor(n):
        out -= out // p
    return out


def arms(B: int, C: int, R: int, point: tuple[int, int]) -> tuple[int, int, int]:
    h, k = point
    return (1 + R * h, 1 + R * (h + C * k), 1 + R * (h + B * k))


def main() -> None:
    B, C = 5, 6
    R = radical(B * C)
    M = C**6 // (4 * R)
    N = M - 1
    label = (19**2, 29**2, 1)
    D = label[0] * label[1] * label[2]
    assert (R, M, N, D) == (30, 388, 387, 303_601)
    assert D > N**2 == 149_769

    # Exhaust the full canonical parameter box for this label fibre.  This
    # avoids constructing catalogues at the other 150542 parameter points.
    admissible_points = 0
    fibre: list[tuple[int, int]] = []
    for h, k in product(range(1, M + 1), repeat=2):
        values = arms(B, C, R, (h, k))
        if gcd(values[0], k) != 1:
            continue
        assert gcd(values[0], values[1]) == 1
        assert gcd(values[0], values[2]) == 1
        assert gcd(values[1], values[2]) == 1
        admissible_points += 1
        if all(value % d == 0 for value, d in zip(values, label)):
            fibre.append((h, k))
    assert admissible_points == 143_159
    assert fibre == [(12, 283), (373, 363)]

    arm_rows = [arms(B, C, R, point) for point in fibre]
    arm_factorizations = [[sorted(factor(v).items()) for v in row] for row in arm_rows]
    kernels = [tuple(powerful_kernel(v) for v in row) for row in arm_rows]
    assert kernels == [label, label]
    for (h, k), row in zip(fibre, arm_rows):
        assert gcd(row[0], k) == 1
        assert all(gcd(row[i], row[j]) == 1 for i, j in ((0, 1), (0, 2), (1, 2)))

    dx = fibre[1][0] - fibre[0][0]
    dy = fibre[1][1] - fibre[0][1]
    g = gcd(abs(dx), abs(dy))
    s, t = dx // g, dy // g
    assert (s, t, g) == (361, 80, 1)
    coeff = (s, s + C * t, s + B * t)
    assert coeff == (361, 841, 761) and all(coeff)
    L = max(abs(s), abs(t))
    H = 1
    assert H * L <= N

    captures = tuple(gcd(d, abs(a)) for d, a in zip(label, coeff))
    capture = captures[0] * captures[1] * captures[2]
    reduced_periods = tuple(d // q for d, q in zip(label, captures))
    period = reduced_periods[0] * reduced_periods[1] * reduced_periods[2]
    assert captures == label and capture == D and reduced_periods == (1, 1, 1) and period == 1
    assert period * capture == D
    assert N * L < capture

    # Enumerate the full downward catalogue of the selected kernel class.
    threshold = N**2
    large_catalogue = []
    for lab in product(*(divisors(k) for k in label)):
        product_lab = lab[0] * lab[1] * lab[2]
        if product_lab > threshold:
            weight = totient(lab[0]) * totient(lab[1]) * totient(lab[2])
            large_catalogue.append((lab, weight))
    assert large_catalogue == [(label, 277_704)]
    class_tail = sum(weight for _, weight in large_catalogue)
    assert class_tail == 277_704

    multiplicity = 2
    W = class_tail
    W_singleton = 0
    W_repeated = class_tail
    incidence = multiplicity * class_tail
    energy = multiplicity**3 * class_tail
    shifted_energy = (multiplicity - 1) ** 3 * class_tail
    inverse_period_charge = class_tail // period**2
    owner_mass = D
    assert (incidence, energy, shifted_energy, inverse_period_charge) == (
        555_408, 2_221_632, 277_704, 277_704
    )

    # All three sharp global bridges are equalities at occupancy two.
    assert energy == W + 7 * shifted_energy
    assert energy == incidence + 6 * shifted_energy
    assert energy == W_singleton + 8 * shifted_energy

    false_claims = {
        "S_le_owner_mass_div_N": inverse_period_charge * N <= owner_mass,
        "S_le_owner_mass_div_sqrt_N_squared_form": inverse_period_charge**2 * N <= owner_mass**2,
        "S_le_nine_tenths_owner_mass": 10 * inverse_period_charge <= 9 * owner_mass,
        "S_le_half_owner_mass": 2 * inverse_period_charge <= owner_mass,
        "singleton_deducted_coefficient_7": energy <= W_singleton + 7 * shifted_energy,
    }
    assert not any(false_claims.values())
    assert inverse_period_charge <= owner_mass  # the undivided owner bound survives

    report = {
        "parameters": {"B": B, "C": C, "R": R, "M": M, "N": N, "N_squared": N**2},
        "full_box_admissible_points": admissible_points,
        "fibre_points": fibre,
        "arms": arm_rows,
        "arm_factorizations": arm_factorizations,
        "powerful_kernels": kernels,
        "label": label,
        "label_product": D,
        "primitive_direction": [s, t],
        "direction_coefficients": coeff,
        "direction_scale_L": L,
        "index_span_H": H,
        "capture_factors": captures,
        "capture": capture,
        "reduced_periods": reduced_periods,
        "period": period,
        "totient_weight": class_tail,
        "large_catalogue": large_catalogue,
        "class_multiplicity": multiplicity,
        "class_tail_L": class_tail,
        "W": W,
        "W_singleton": W_singleton,
        "W_repeated": W_repeated,
        "I": incidence,
        "E": energy,
        "E_shifted": shifted_energy,
        "S_non": inverse_period_charge,
        "owner_mass_sum_D": owner_mass,
        "strict_capture_squeeze": {"lhs_N_times_L": N * L, "rhs_capture": capture},
        "false_claims": false_claims,
        "integer_failure_certificates": {
            "N_times_S_gt_owner_mass": [N * inverse_period_charge, owner_mass],
            "N_times_S_squared_gt_owner_mass_squared": [N * inverse_period_charge**2, owner_mass**2],
            "ten_S_gt_nine_owner_mass": [10 * inverse_period_charge, 9 * owner_mass],
            "two_S_gt_owner_mass": [2 * inverse_period_charge, owner_mass],
            "E_gt_7_Eshift_after_singleton_deduction": [energy, 7 * shifted_energy],
        },
    }
    print(json.dumps(report, indent=2))
    print("PASS: canonical M=388 T=1 non-arm witness and full selected catalogue")


if __name__ == "__main__":
    main()
