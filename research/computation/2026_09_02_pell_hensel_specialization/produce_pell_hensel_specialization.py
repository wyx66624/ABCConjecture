#!/usr/bin/env python3
"""Produce the finite Pell polynomial/Hensel specialization packet.

The proof is in the preceding mathematics report.  This program freezes the
displayed exact examples and rare-prime exit digits; it is not an asymptotic
search and never promotes a finite absence to a theorem.
"""

from __future__ import annotations

import json
from math import prod
from pathlib import Path


HERE = Path(__file__).resolve().parent
OUT = HERE / "pell_hensel_specialization_packet.json"


def add(a: list[int], b: list[int]) -> list[int]:
    n = max(len(a), len(b))
    ans = [0] * n
    for i in range(n):
        ans[i] = (a[i] if i < len(a) else 0) + (b[i] if i < len(b) else 0)
    while len(ans) > 1 and ans[-1] == 0:
        ans.pop()
    return ans


def mul_x(a: list[int]) -> list[int]:
    return [0] + a


def deriv(a: list[int]) -> list[int]:
    return [i * a[i] for i in range(1, len(a))] or [0]


def eval_poly(a: list[int], x: int) -> int:
    value = 0
    for coeff in reversed(a):
        value = value * x + coeff
    return value


def fib_lucas_polys(n: int) -> tuple[list[int], list[int]]:
    fm, f = [0], [1]
    lm, l = [2], [0, 1]
    if n == 0:
        return fm, lm
    for _ in range(1, n):
        fm, f = f, add(mul_x(f), fm)
        lm, l = l, add(mul_x(l), lm)
    return f, l


def valuation(n: int, p: int) -> int:
    e = 0
    while n % p == 0:
        e += 1
        n //= p
    return e


def pell_pow(n: int, modulus: int) -> tuple[int, int]:
    """Binary powering of 1+sqrt(2), returned as an (A,B) pair."""
    ra, rb = 1, 0
    a, b = 1, 1
    while n:
        if n & 1:
            ra, rb = (ra * a + 2 * rb * b) % modulus, (ra * b + rb * a) % modulus
        a, b = (a * a + 2 * b * b) % modulus, (2 * a * b) % modulus
        n >>= 1
    return ra, rb


def crt_pair(a: int, m: int, b: int, n: int) -> int:
    return (a + m * (((b - a) * pow(m, -1, n)) % n)) % (m * n)


def rare_exit(p: int, rank: int) -> dict[str, int | str]:
    modulus = p**3
    A, B = pell_pow(rank, modulus)
    if A % (p * p) == 0:
        channel = "L/A"
        f = (2 * A) % modulus
        fp = (rank * B) % p
    elif B % (p * p) == 0:
        channel = "F/B"
        f = B
        fp = ((rank * A - B) * pow(4, -1, p)) % p
    else:
        raise AssertionError(f"{p} is not depth two at rank {rank}")
    quotient = (f // (p * p)) % p
    digit = (-quotient * pow(fp, -1, p)) % p
    return {
        "prime": p,
        "rank": rank,
        "channel": channel,
        "coordinate_mod_p3": f,
        "coordinate_over_p2_mod_p": quotient,
        "derivative_mod_p": fp,
        "level_two_exit_digit": digit,
    }


def main() -> None:
    f3, l3 = fib_lucas_polys(3)
    f7, l7 = fib_lucas_polys(7)
    assert f3 == [1, 0, 1]
    assert l3 == [0, 3, 0, 1]
    assert f7 == [1, 0, 6, 0, 5, 0, 1]

    f3p, l3p = deriv(f3), deriv(l3)
    q, r, t0 = 7, 5, 2
    hq = (-(eval_poly(l3, t0) // q) * pow(eval_poly(l3p, t0), -1, q)) % q
    hr = (-(eval_poly(f3, t0) // r) * pow(eval_poly(f3p, t0), -1, r)) % r
    q_lift = t0 + q * hq
    r_lift = t0 + r * hr
    t = crt_pair(q_lift, q * q, r_lift, r * r)
    F = eval_poly(f3, t)
    L = eval_poly(l3, t)
    A = L // 2
    D = (t * t + 4) // 4

    f7_at_2 = eval_poly(f7, 2)
    f7p_at_2 = eval_poly(deriv(f7), 2)
    second_digit = (-(f7_at_2 // 13**2) * pow(f7p_at_2, -1, 13)) % 13
    next_t = 2 + 13**2 * second_digit
    f7_next = eval_poly(f7, next_t)

    rare = [rare_exit(13, 7), rare_exit(31, 15), rare_exit(1546463, 773231)]

    packet = {
        "schema": "pell-polynomial-hensel-specialization-v1",
        "policy": (
            "Only a counterexample satisfying every premise retires its exact claim; "
            "finite no-hits and moving-parameter examples do not retire the fixed Pell route."
        ),
        "polynomials": {
            "F3_coefficients_low_to_high": f3,
            "L3_coefficients_low_to_high": l3,
            "F7_coefficients_low_to_high": f7,
            "F7_derivative_coefficients_low_to_high": deriv(f7),
        },
        "index_three_simultaneous_steering": {
            "base_parameter": t0,
            "L_prime": q,
            "F_prime": r,
            "L_first_digit": hq,
            "F_first_digit": hr,
            "L_lift_mod_49": q_lift,
            "F_lift_mod_25": r_lift,
            "crt_parameter_mod_1225": t,
            "F3_value": F,
            "F3_factorization": {"5": 2, "3181": 1},
            "half_L3_value": A,
            "half_L3_factorization": {"3": 2, "7": 2, "47": 1, "541": 1},
            "pell_coefficient": D,
            "pell_coefficient_factorization": {"2": 1, "9941": 1},
            "negative_pell_residual": A * A - D * F * F,
            "global_norm_residual": L * L - (t * t + 4) * F * F,
        },
        "index_seven_collision": {
            "F7_at_2": f7_at_2,
            "F7_derivative_at_2": f7p_at_2,
            "valuation_at_2": valuation(f7_at_2, 13),
            "level_two_exit_digit": second_digit,
            "next_parameter": next_t,
            "F7_at_next_parameter": f7_next,
            "valuation_at_next_parameter": valuation(f7_next, 13),
        },
        "rare_depth_two_exit_digits": rare,
        "counterexample_matrix": {
            "index_7_refutes_simple_polynomial_root_implies_simple_integer_valuation": True,
            "index_7_is_full_squarefull_packet": False,
            "index_3_moving_point_refutes_global_moving_opposite_repeat_exclusion": True,
            "index_3_moving_point_has_squarefree_pell_coefficient": True,
            "index_3_moving_point_has_both_channels_squarefull": False,
            "index_3_moving_point_has_fixed_pell_coefficient_2": False,
            "either_example_disproves_abc": False,
        },
        "sanity": {
            "displayed_factor_products": {
                "F3": prod(p**e for p, e in [(5, 2), (3181, 1)]),
                "half_L3": prod(p**e for p, e in [(3, 2), (7, 2), (47, 1), (541, 1)]),
                "D": 2 * 9941,
            }
        },
    }
    OUT.write_text(json.dumps(packet, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps({
        "status": "PASS",
        "output": OUT.name,
        "moving_parameter": t,
        "index_7_exit_digit": second_digit,
        "rare_exit_digits": [row["level_two_exit_digit"] for row in rare],
    }, indent=2))


if __name__ == "__main__":
    main()

