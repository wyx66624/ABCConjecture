#!/usr/bin/env python3
"""Exact Euler-factor tests and canonical boundary certificates.

This implementation is independent of the two full-box witness scripts.
All rational comparisons use Fraction; no floating-point comparison is used.
"""

from __future__ import annotations

import json
from fractions import Fraction
from itertools import product
from math import gcd
from pathlib import Path


HERE = Path(__file__).resolve().parent


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


def divisors(n: int) -> list[int]:
    ans = [1]
    for p, e in factor(n).items():
        base = ans[:]
        pe = 1
        for _ in range(e):
            pe *= p
            ans.extend(d * pe for d in base)
    return sorted(ans)


def phi(n: int) -> int:
    ans = n
    for p in factor(n):
        ans -= ans // p
    return ans


def radical(n: int) -> int:
    ans = 1
    for p in factor(n):
        ans *= p
    return ans


def powerful_kernel(n: int) -> int:
    ans = 1
    for p, e in factor(n).items():
        if e >= 2:
            ans *= p**e
    return ans


def arms(B: int, C: int, R: int, h: int, k: int) -> tuple[int, int, int]:
    return 1 + R * h, 1 + R * (h + C * k), 1 + R * (h + B * k)


def local_direct(k: int, a: int) -> Fraction:
    return sum(
        (Fraction(phi(d) * gcd(d, abs(a)) ** 2, d**2) for d in divisors(k)),
        Fraction(0),
    )


def local_closed(k: int, a: int) -> Fraction:
    capture = gcd(k, abs(a))
    reduced = k // capture
    ans = Fraction(capture)
    for p, r in factor(reduced).items():
        ans *= Fraction(1) + Fraction(1, p) - Fraction(1, p ** (r + 1))
    return ans


def full_inverse(top: tuple[int, int, int], coeff: tuple[int, int, int]) -> Fraction:
    ans = Fraction(1)
    for k, a in zip(top, coeff):
        ans *= local_direct(k, a)
    return ans


def tail_inverse(
    top: tuple[int, int, int], coeff: tuple[int, int, int], N: int
) -> tuple[Fraction, int]:
    ans = Fraction(0)
    count = 0
    for d in product(*(divisors(k) for k in top)):
        D = d[0] * d[1] * d[2]
        if D <= N * N:
            continue
        capture = 1
        weight = 1
        for dz, az in zip(d, coeff):
            capture *= gcd(dz, abs(az))
            weight *= phi(dz)
        T = D // capture
        ans += Fraction(weight, T * T)
        count += 1
    return ans, count


def H(n: int) -> Fraction:
    return sum((Fraction(phi(d), d) for d in divisors(n)), Fraction(0))


def psi(n: int) -> Fraction:
    ans = Fraction(1)
    for p in factor(n):
        ans *= Fraction(p + 1, p)
    return ans


def exhaustive_euler_tests() -> dict:
    prime_power_cases = 0
    for p in (2, 3, 5, 7, 11, 13):
        for e in range(1, 8):
            k = p**e
            for b in range(0, e + 3):
                for unit in (1, 2):
                    a = p**b * unit
                    assert local_direct(k, a) == local_closed(k, a)
                    assert local_direct(k, a) <= gcd(k, a) * Fraction(p + 1, p)
                    prime_power_cases += 1
            assert local_direct(k, 0) == local_closed(k, 0) == k

    general_cases = 0
    for k in range(1, 401):
        for a in range(0, 121):
            assert local_direct(k, a) == local_closed(k, a)
            assert local_direct(k, a) <= gcd(k, a) * psi(k)
            general_cases += 1

    bridge_cases = 0
    for n in range(0, 10001):
        a = max(n - 1, 0)
        assert n**3 <= n + 6 * a**3
        if n >= 3:
            assert n**3 <= n + 3 * a**3
        if n >= 2:
            assert n**3 <= 8 * a**3
        bridge_cases += 1
    assert 2**3 == 2 + 6 * (2 - 1) ** 3
    assert 3**3 == 3 + 3 * (3 - 1) ** 3
    assert 2**3 == 8 * (2 - 1) ** 3
    return {
        "prime_power_cases": prime_power_cases,
        "general_euler_cases": general_cases,
        "occupancy_bridge_cases": bridge_cases,
        "optimal_constants": {"incidence_all": 6, "incidence_n_ge_3": 3, "no_singleton": 8},
    }


def q_factor_witness() -> dict:
    B, C, R, M, N = 10, 11, 110, 30, 29
    pts = [(14, 8), (29, 20)]
    rows = [arms(B, C, R, *p) for p in pts]
    for (_, k), row in zip(pts, rows):
        assert gcd(row[0], k) == 1
        assert all(gcd(row[i], row[j]) == 1 for i, j in ((0, 1), (0, 2), (1, 2)))
    kernels = [tuple(powerful_kernel(v) for v in row) for row in rows]
    assert kernels == [(1, 49, 27), (1, 49, 81)]
    top = tuple(gcd(x, y) for x, y in zip(*kernels))
    assert top == (1, 49, 27)
    dx, dy = pts[1][0] - pts[0][0], pts[1][1] - pts[0][1]
    q = gcd(abs(dx), abs(dy))
    s, t = dx // q, dy // q
    coeff = (s, s + C * t, s + B * t)
    assert (q, s, t, coeff) == (3, 5, 4, (5, 49, 45))
    captures = tuple(gcd(k, abs(a)) for k, a in zip(top, coeff))
    Cg = captures[0] * captures[1] * captures[2]
    G = top[0] * top[1] * top[2]
    Tg = G // Cg
    P0 = 49 * 9
    assert (G, Cg, Tg, P0) == (1323, 441, 3, 441)
    exact = full_inverse(top, coeff)
    assert exact == 539 > Cg
    assert G == q * P0 and P0 % G != 0
    tail, tail_count = tail_inverse(top, coeff, N)
    bound_G = Fraction(Cg**2 * G, N**4)
    bound_reduced = Fraction(q * P0**3, N**4)
    bound_H = Fraction(Cg**2, N**2) * H(G)
    assert tail <= exact and tail < bound_G and tail < bound_reduced and tail < bound_H
    return {
        "parameters": [B, C, R, M, N],
        "points": pts,
        "arms": rows,
        "kernels": kernels,
        "top": top,
        "q_s_t": [q, s, t],
        "coefficients": coeff,
        "G_Cg_Tg_P0": [G, Cg, Tg, P0],
        "full_euler_mass": str(exact),
        "large_tail_mass": str(tail),
        "large_tail_labels": tail_count,
        "false_F_le_Cg": bool(exact <= Cg),
        "false_G_dvd_P0": bool(P0 % G == 0),
        "hybrid_bounds": {
            "Cg2G_over_N4": str(bound_G),
            "q0P0_cubed_over_N4": str(bound_reduced),
            "Cg2H_over_N2": str(bound_H),
        },
    }


def subcritical_witness() -> dict:
    B, C = 8, 9
    R = radical(B * C)
    M = C**6 // (4 * R)
    N = M - 1
    label = (137**2, 173**2, 1)
    D = label[0] * label[1]
    assert (R, M, N, D, N**2) == (6, 22143, 22142, 561737401, 490268164)
    assert R < C and D > N**2

    # U congruence has exactly these h-values in the box.
    h_values = [h for h in range(1, M + 1) if (1 + R * h) % label[0] == 0]
    assert h_values == [3128, 21897]
    fibre = []
    for h in h_values:
        k_values = [
            k for k in range(1, M + 1)
            if (1 + R * (h + C * k)) % label[1] == 0
        ]
        assert len(k_values) == 1
        fibre.append((h, k_values[0]))
    assert fibre == [(3128, 10183), (21897, 11423)]

    rows = [arms(B, C, R, *p) for p in fibre]
    expected_rows = [
        (18769, 568651, 507553),
        (131383, 748225, 679687),
    ]
    assert rows == expected_rows
    for (_, k), row in zip(fibre, rows):
        assert gcd(row[0], k) == 1
        assert all(gcd(row[i], row[j]) == 1 for i, j in ((0, 1), (0, 2), (1, 2)))
    expected_factors = [
        [{137: 2}, {19: 1, 173: 2}, {47: 1, 10799: 1}],
        [{7: 1, 137: 2}, {5: 2, 173: 2}, {19: 1, 83: 1, 431: 1}],
    ]
    assert [[factor(v) for v in row] for row in rows] == expected_factors
    kernels = [tuple(powerful_kernel(v) for v in row) for row in rows]
    assert kernels == [(18769, 29929, 1), (18769, 748225, 1)]
    assert kernels[0] != kernels[1]

    dx, dy = fibre[1][0] - fibre[0][0], fibre[1][1] - fibre[0][1]
    q = gcd(abs(dx), abs(dy))
    s, t = dx // q, dy // q
    coeff = (s, s + C * t, s + B * t)
    assert (q, s, t, coeff) == (1, 18769, 1240, (18769, 29929, 28689))
    L = max(abs(s), abs(t))
    captures = tuple(gcd(d, abs(a)) for d, a in zip(label, coeff))
    capture = captures[0] * captures[1] * captures[2]
    period = D // capture
    assert (L, capture, period, N * L) == (18769, D, 1, 415583198)
    assert N * L < capture
    weight = phi(label[0]) * phi(label[1])
    assert weight == 554413792

    # The proper divisor with largest product divides the top by 137.
    proper_max = D // 137
    assert proper_max < N**2
    tail, tail_count = tail_inverse(label, coeff, N)
    assert (tail, tail_count) == (weight, 1)
    return {
        "parameters": {"B": B, "C": C, "R": R, "M": M, "N": N, "R_lt_C": R < C},
        "label": label,
        "D": D,
        "N_squared": N**2,
        "fibre_points": fibre,
        "arms": rows,
        "arm_factorizations": expected_factors,
        "kernel_classes": kernels,
        "class_multiplicities_in_selected_subset": [1, 1],
        "primitive_direction": [s, t],
        "coefficients": coeff,
        "L": L,
        "capture": capture,
        "period": period,
        "N_times_L": N * L,
        "weight_and_S_non": weight,
        "weight_over_D": str(Fraction(weight, D)),
        "common_large_tail_count": tail_count,
        "common_large_tail_inverse_mass": str(tail),
        "false_T_ge_2": period >= 2,
        "false_strict_saving_against_common_tail": tail < weight,
    }


def main() -> None:
    report = {
        "schema": "affine-inverse-period-catalogue-v1",
        "exhaustive_identities": exhaustive_euler_tests(),
        "q_factor_boundary": q_factor_witness(),
        "subcritical_cross_singleton_boundary": subcritical_witness(),
    }
    text = json.dumps(report, indent=2, sort_keys=True)
    (HERE / "verification.json").write_text(text + "\n", encoding="utf-8")
    print(text)
    print("PASS: exact Euler factors, hybrid tails, and canonical boundary witnesses")


if __name__ == "__main__":
    main()
