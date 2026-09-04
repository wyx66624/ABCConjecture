#!/usr/bin/env python3
"""Certify every premise of the two exact Pell collision rows.

This is deliberately separate from the bounded search.  Primality is
checked by complete trial division, and each orbit coordinate is recomputed
in three ways: quadratic-ring binary powering, matrix binary powering, and
the defining linear recurrence.
"""

from __future__ import annotations

import argparse
import json
from math import isqrt
from pathlib import Path


ROWS = (
    {"index": 7, "prime": 13, "channel": "B", "sign": -1},
    {"index": 773_231, "prime": 1_546_463, "channel": "A", "sign": 1},
)


def trial_division_certificate(n: int) -> dict:
    bound = isqrt(n)
    tested = 0
    divisor = None
    if n % 2 == 0:
        divisor = 2 if n != 2 else None
    else:
        for d in range(3, bound + 1, 2):
            tested += 1
            if n % d == 0:
                divisor = d
                break
    return {
        "integer": n,
        "method": "complete odd trial division through floor(sqrt(n))",
        "upper_bound": bound,
        "odd_divisors_tested": tested,
        "first_divisor": divisor,
        "is_prime": n >= 2 and divisor is None,
    }


def quadratic_power(index: int, modulus: int) -> tuple[int, int]:
    a, b = 1, 0
    x, y = 1, 1
    n = index
    while n:
        if n & 1:
            a, b = (
                (a * x + 2 * b * y) % modulus,
                (a * y + b * x) % modulus,
            )
        x, y = (x * x + 2 * y * y) % modulus, (2 * x * y) % modulus
        n >>= 1
    return a, b


def mat_mul(
    x: tuple[int, int, int, int],
    y: tuple[int, int, int, int],
    modulus: int,
) -> tuple[int, int, int, int]:
    a, b, c, d = x
    e, f, g, h = y
    return (
        (a * e + b * g) % modulus,
        (a * f + b * h) % modulus,
        (c * e + d * g) % modulus,
        (c * f + d * h) % modulus,
    )


def matrix_power(index: int, modulus: int) -> tuple[int, int]:
    result = (1, 0, 0, 1)
    base = (1, 2, 1, 1)
    n = index
    while n:
        if n & 1:
            result = mat_mul(result, base, modulus)
        base = mat_mul(base, base, modulus)
        n >>= 1
    return result[0], result[2]


def recurrence_power(index: int, modulus: int) -> tuple[int, int]:
    a, b = 1, 0
    for _ in range(index):
        a, b = (a + 2 * b) % modulus, (a + b) % modulus
    return a, b


def certify(row: dict) -> dict:
    ell = row["index"]
    q = row["prime"]
    channel = row["channel"]
    sign = row["sign"]
    q2, q3, q4, q5 = q**2, q**3, q**4, q**5

    quadratic = quadratic_power(ell, q5)
    matrix = matrix_power(ell, q5)
    recurrence = recurrence_power(ell, q5)
    a, b = quadratic
    coordinate = a if channel == "A" else b
    opposite = b if channel == "A" else a
    derivative = (
        ell * b % q
        if channel == "A"
        else (ell * a - b) * pow(4, -1, q) % q
    )
    doubled_trace_from_square = (a * a + 2 * b * b) % q5
    doubled_trace_from_matrix = matrix_power(2 * ell, q5)[0]
    signed_shift = (
        (doubled_trace_from_square - 1) % q5
        if channel == "A"
        else (doubled_trace_from_square + 1) % q5
    )

    checks = {
        "index_is_odd": ell % 2 == 1,
        "index_is_prime": trial_division_certificate(ell)["is_prime"],
        "support_integer_is_prime": trial_division_certificate(q)["is_prime"],
        "minimal_residue_identity": q == 2 * ell + sign,
        "three_orbit_algorithms_agree": quadratic == matrix == recurrence,
        "odd_norm_identity_mod_q5": (a * a - 2 * b * b) % q5 == q5 - 1,
        "support_divisibility_q": coordinate % q == 0,
        "support_divisibility_q2": coordinate % q2 == 0,
        "coordinate_not_divisible_q3": coordinate % q3 != 0,
        "opposite_coordinate_not_divisible_q": opposite % q != 0,
        "fixed_parameter_derivative_nonzero": derivative != 0,
        "doubled_trace_algorithms_agree":
            doubled_trace_from_square == doubled_trace_from_matrix,
        "signed_trace_divisible_q4": signed_shift % q4 == 0,
        "signed_trace_not_divisible_q5": signed_shift % q5 != 0,
    }
    return {
        **row,
        "index_primality": trial_division_certificate(ell),
        "support_prime_primality": trial_division_certificate(q),
        "modulus_q5": q5,
        "A_index_mod_q5": a,
        "B_index_mod_q5": b,
        "coordinate_quotient_after_q2_mod_q": coordinate // q2 % q,
        "opposite_coordinate_mod_q": opposite % q,
        "fixed_parameter_derivative_mod_q": derivative,
        "doubled_trace_mod_q5": doubled_trace_from_square,
        "signed_trace_shift":
            "A_2ell-1" if channel == "A" else "A_2ell+1",
        "signed_trace_shift_mod_q5": signed_shift,
        "trace_quotient_after_q4_mod_q": signed_shift // q4 % q,
        "checks": checks,
        "status": "PASS" if all(checks.values()) else "FAIL",
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--output",
        type=Path,
        default=Path("exact_collision_certificates.json"),
    )
    args = parser.parse_args()
    rows = [certify(row) for row in ROWS]
    result = {
        "schema": "pell-signed-trace-exact-collisions-v1",
        "definition": "(1+sqrt(2))^n=A_n+B_n*sqrt(2)",
        "claim_boundary": (
            "These certificates establish local support collisions only.  "
            "The large row's full squarefull status is unresolved, and "
            "neither row is an abc counterexample."
        ),
        "rows": rows,
        "status": "PASS" if all(row["status"] == "PASS" for row in rows) else "FAIL",
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    if result["status"] != "PASS":
        raise SystemExit(1)


if __name__ == "__main__":
    main()
