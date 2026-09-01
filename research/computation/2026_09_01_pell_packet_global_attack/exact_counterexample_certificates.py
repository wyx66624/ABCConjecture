#!/usr/bin/env python3
"""Produce exact certificates for the two minimal-class BW counterexamples.

No probable-prime oracle is used: all four integers whose primality is claimed
are below 1.6 million and are proved prime by exhaustive trial division.
"""

from __future__ import annotations

import json
import math
from pathlib import Path


def is_prime_trial(n: int) -> bool:
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    for d in range(3, math.isqrt(n) + 1, 2):
        if n % d == 0:
            return False
    return True


def balancing_mod(n: int, modulus: int) -> int:
    a, b = 0, 1
    for bit in bin(n)[2:]:
        c = a * (2 * b - 6 * a) % modulus
        d = (b * b - a * a) % modulus
        if bit == "0":
            a, b = c, d
        else:
            a, b = d, (6 * d - c) % modulus
    return a


def sqrt_two_power_mod(n: int, modulus: int) -> tuple[int, int]:
    ra, rb = 1, 0
    aa, ab = 1, 1
    while n:
        if n & 1:
            ra, rb = (ra * aa + 2 * rb * ab) % modulus, (ra * ab + rb * aa) % modulus
        aa, ab = (aa * aa + 2 * ab * ab) % modulus, 2 * aa * ab % modulus
        n >>= 1
    return ra, rb


def lucas_polynomial_value_and_derivative(n: int, x: int, modulus: int) -> tuple[int, int]:
    """F_n(x),F'_n(x) modulo m for F_0=0,F_1=1,F_{n+2}=xF_{n+1}-F_n."""
    u0, u1 = 0, 1
    d0, d1 = 0, 0
    for _ in range(n):
        u0, u1, d0, d1 = u1, (x * u1 - u0) % modulus, d1, (u1 + x * d1 - d0) % modulus
    return u0, d0


def certificate(q: int, ell: int, expected_channel: str) -> dict[str, object]:
    assert is_prime_trial(q)
    assert is_prime_trial(ell)
    assert q in (2 * ell - 1, 2 * ell + 1)
    q2, q3 = q * q, q * q * q
    u = balancing_mod(ell, q3)
    A, B = sqrt_two_power_mod(ell, q3)
    assert u == A * B % q3
    assert u % q2 == 0 and u != 0
    channel = "A" if A % q == 0 else "B" if B % q == 0 else "?"
    assert channel == expected_channel
    assert (A if channel == "A" else B) % q2 == 0
    assert (B if channel == "A" else A) % q != 0
    f, derivative = lucas_polynomial_value_and_derivative(ell, 6, q)
    assert f == 0 and derivative != 0
    return {
        "A_mod_q3": A,
        "B_mod_q3": B,
        "channel": channel,
        "derivative_F_ell_at_6_mod_q": derivative,
        "ell": ell,
        "ell_prime_by_exhaustive_trial_division": True,
        "e_q": 2,
        "minimal_channel_bound_equality": f"q=2*ell{'-1' if q == 2 * ell - 1 else '+1'}",
        "q": q,
        "q_prime_by_exhaustive_trial_division": True,
        "u_ell_mod_q3": u,
        "u_ell_over_q2_mod_q": u // q2,
        "valuation_checks": {
            "q2_divides_u_ell": u % q2 == 0,
            "q3_does_not_divide_u_ell": u != 0,
        },
        "z_q": ell,
        "z_q_reason": "q divides u_ell; ell is prime; u_1=1; strong divisibility gives z(q)|ell",
    }


def main() -> None:
    small = certificate(13, 7, "B")
    large = certificate(1_546_463, 773_231, "A")

    # Completely explicit polynomial check for the smallest counterexample.
    f7 = 6**6 - 5 * 6**4 + 6 * 6**2 - 1
    f7prime = 6 * 6**5 - 20 * 6**3 + 12 * 6
    assert f7 == 40_391 == 13**2 * 239
    assert f7prime == 42_408 and f7prime % 13 == 2

    result = {
        "certificates": [small, large],
        "explicit_derivative_counterexample": {
            "F_7_X": "X^6 - 5 X^4 + 6 X^2 - 1",
            "F_7_6": f7,
            "F_7_6_factorization": "13^2 * 239",
            "F_7_prime_6": f7prime,
            "F_7_prime_6_mod_13": f7prime % 13,
            "refuted_implication": "q|F_ell(6) and F'_ell(6) nonzero mod q imply q^2 does not divide F_ell(6)",
        },
        "verification": "PASS",
    }
    out = Path(__file__).resolve().parent / "exact_counterexample_certificates.json"
    out.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
