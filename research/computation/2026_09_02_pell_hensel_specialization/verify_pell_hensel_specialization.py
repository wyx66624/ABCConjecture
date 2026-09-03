#!/usr/bin/env python3
"""Independent verifier for the Pell polynomial/Hensel packet.

This verifier does not import the producer.  It uses closed coefficient
formulas, 2x2 matrix powering, a separate CRT search, and deterministic
primality checks for the displayed small factors.
"""

from __future__ import annotations

import json
from math import comb
from pathlib import Path


HERE = Path(__file__).resolve().parent
PACKET = HERE / "pell_hensel_specialization_packet.json"
OUT = HERE / "pell_hensel_specialization_verification.json"


def fib_coeffs(n: int) -> list[int]:
    ans = [0] * n
    for j in range((n - 1) // 2 + 1):
        ans[n - 1 - 2 * j] = comb(n - 1 - j, j)
    return ans


def eval_coeffs(coeffs: list[int], x: int) -> int:
    return sum(c * x**i for i, c in enumerate(coeffs))


def mat_mul(a: tuple[int, int, int, int], b: tuple[int, int, int, int], m: int) -> tuple[int, int, int, int]:
    a00, a01, a10, a11 = a
    b00, b01, b10, b11 = b
    return (
        (a00 * b00 + a01 * b10) % m,
        (a00 * b01 + a01 * b11) % m,
        (a10 * b00 + a11 * b10) % m,
        (a10 * b01 + a11 * b11) % m,
    )


def matrix_pell(n: int, m: int) -> tuple[int, int]:
    # Multiplication by 1+sqrt(2) on the basis (1,sqrt(2)).
    result = (1, 0, 0, 1)
    base = (1, 2, 1, 1)
    while n:
        if n & 1:
            result = mat_mul(result, base, m)
        base = mat_mul(base, base, m)
        n >>= 1
    return result[0], result[2]


def is_prime(n: int) -> bool:
    if n < 2:
        return False
    for p in (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37):
        if n % p == 0:
            return n == p
    d = n - 1
    s = 0
    while d % 2 == 0:
        s += 1
        d //= 2
    for a in (2, 3, 5, 7, 11):
        if a >= n:
            continue
        x = pow(a, d, n)
        if x in (1, n - 1):
            continue
        for _ in range(s - 1):
            x = x * x % n
            if x == n - 1:
                break
        else:
            return False
    return True


def v_p(n: int, p: int) -> int:
    e = 0
    while n % p == 0:
        n //= p
        e += 1
    return e


def verify_rare(row: dict) -> list[str]:
    errors: list[str] = []
    p, n = row["prime"], row["rank"]
    modulus = p**3
    A, B = matrix_pell(n, modulus)
    if row["channel"] == "L/A":
        f = 2 * A % modulus
        fp = n * B % p
    elif row["channel"] == "F/B":
        f = B
        fp = (n * A - B) * pow(4, -1, p) % p
    else:
        return [f"unknown channel for {p}"]
    quotient = f // (p * p) % p
    digit = -quotient * pow(fp, -1, p) % p
    expected = (f, quotient, fp, digit)
    stored = (
        row["coordinate_mod_p3"],
        row["coordinate_over_p2_mod_p"],
        row["derivative_mod_p"],
        row["level_two_exit_digit"],
    )
    if expected != stored:
        errors.append(f"rare row mismatch for {p}: {expected} != {stored}")
    if quotient == 0 or digit == 0:
        errors.append(f"rare row {p} is not exact depth two")
    return errors


def main() -> None:
    data = json.loads(PACKET.read_text(encoding="utf-8"))
    errors: list[str] = []

    f3 = fib_coeffs(3)
    f7 = fib_coeffs(7)
    if f3 != data["polynomials"]["F3_coefficients_low_to_high"]:
        errors.append("F3 closed coefficient mismatch")
    if f7 != data["polynomials"]["F7_coefficients_low_to_high"]:
        errors.append("F7 closed coefficient mismatch")

    move = data["index_three_simultaneous_steering"]
    candidates = [x for x in range(1225) if x % 49 == 37 and x % 25 == 7]
    if candidates != [282] or move["crt_parameter_mod_1225"] != 282:
        errors.append("CRT solution mismatch")
    t = 282
    F = t * t + 1
    L = t**3 + 3 * t
    A = L // 2
    D = (t * t + 4) // 4
    if (F, A, D) != (move["F3_value"], move["half_L3_value"], move["pell_coefficient"]):
        errors.append("moving values mismatch")
    factorizations = {
        F: {5: 2, 3181: 1},
        A: {3: 2, 7: 2, 47: 1, 541: 1},
        D: {2: 1, 9941: 1},
    }
    for value, fac in factorizations.items():
        if value != __import__("math").prod(p**e for p, e in fac.items()):
            errors.append(f"factor product mismatch for {value}")
        if not all(is_prime(p) for p in fac):
            errors.append(f"nonprime displayed factor for {value}")
    if A * A - D * F * F != -1 or L * L - (t * t + 4) * F * F != -4:
        errors.append("global moving norm identity mismatch")
    if not (A % 49 == 0 and F % 25 == 0):
        errors.append("opposite repeated carriers missing")
    if all(e >= 2 for e in factorizations[A].values()) or all(e >= 2 for e in factorizations[F].values()):
        errors.append("moving channels unexpectedly recorded as squarefull")

    seven = data["index_seven_collision"]
    f7_at_2 = eval_coeffs(f7, 2)
    f7_prime_at_2 = sum(i * f7[i] * 2 ** (i - 1) for i in range(1, len(f7)))
    if (f7_at_2, f7_prime_at_2) != (169, 376):
        errors.append("index-seven evaluation mismatch")
    if v_p(f7_at_2, 13) != 2 or f7_prime_at_2 % 13 == 0:
        errors.append("index-seven transverse collision mismatch")
    f171 = eval_coeffs(f7, 171)
    if f171 != seven["F7_at_next_parameter"] or v_p(f171, 13) != 3:
        errors.append("index-seven next-level exit mismatch")

    for row in data["rare_depth_two_exit_digits"]:
        errors.extend(verify_rare(row))
    rare_digits = [row["level_two_exit_digit"] for row in data["rare_depth_two_exit_digits"]]
    if rare_digits != [1, 8, 400849]:
        errors.append("rare exit digit list mismatch")

    matrix = data["counterexample_matrix"]
    required_matrix = {
        "index_7_refutes_simple_polynomial_root_implies_simple_integer_valuation": True,
        "index_7_is_full_squarefull_packet": False,
        "index_3_moving_point_refutes_global_moving_opposite_repeat_exclusion": True,
        "index_3_moving_point_has_squarefree_pell_coefficient": True,
        "index_3_moving_point_has_both_channels_squarefull": False,
        "index_3_moving_point_has_fixed_pell_coefficient_2": False,
        "either_example_disproves_abc": False,
    }
    if matrix != required_matrix:
        errors.append("logical counterexample matrix mismatch")

    result = {
        "status": "PASS" if not errors else "FAIL",
        "errors": errors,
        "checks": {
            "closed_coefficient_formulas": 2,
            "global_norm_identities": 2,
            "displayed_prime_factorizations": 3,
            "rare_depth_two_rows": 3,
            "counterexample_matrix_entries": len(required_matrix),
        },
        "logical_boundary": (
            "The moving point retires only the moving-parameter exclusion; "
            "the index-seven point retires only the simple-specialization claim. "
            "Neither is a fixed full squarefull packet or an abc counterexample."
        ),
    }
    OUT.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2, sort_keys=True))
    if errors:
        raise SystemExit(1)


if __name__ == "__main__":
    main()

