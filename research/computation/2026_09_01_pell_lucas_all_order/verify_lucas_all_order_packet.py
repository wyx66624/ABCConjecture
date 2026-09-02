#!/usr/bin/env python3
"""Independent replay for lucas_all_order_packet.json.

The local certificate is recomputed by binary powering in
Z[T]/(T^2-6T+1), rather than by the producer's linear recurrence.  The
all-order sample rows are checked from independently generated Binet
recurrences and coefficient products.
"""

from __future__ import annotations

import json
import math
from pathlib import Path


ROOT = Path(__file__).resolve().parent
PACKET = ROOT / "lucas_all_order_packet.json"
OUTPUT = ROOT / "lucas_all_order_verification.json"


def pair_mul(x: tuple[int, int], y: tuple[int, int], modulus: int) -> tuple[int, int]:
    """Multiply x0+x1*T and y0+y1*T with T^2=6T-1."""
    x0, x1 = x
    y0, y1 = y
    return (
        (x0 * y0 - x1 * y1) % modulus,
        (x0 * y1 + x1 * y0 + 6 * x1 * y1) % modulus,
    )


def u_mod_binary(n: int, modulus: int) -> int:
    result = (1, 0)
    base = (0, 1)
    exponent = n
    while exponent:
        if exponent & 1:
            result = pair_mul(result, base, modulus)
        base = pair_mul(base, base, modulus)
        exponent >>= 1
    return result[1]


def uv_by_binet_recurrence(n: int) -> tuple[int, int]:
    """Simultaneously power alpha through (u_n,v_n) addition laws."""
    # Pair (u,v) represents alpha^n via (v + u*sqrt(32))/2.
    result_u, result_v = 0, 2
    base_u, base_v = 1, 6
    exponent = n
    while exponent:
        if exponent & 1:
            result_u, result_v = (
                (result_u * base_v + result_v * base_u) // 2,
                (result_v * base_v + 32 * result_u * base_u) // 2,
            )
        base_u, base_v = base_u * base_v, base_v * base_v - 2
        exponent >>= 1
    return result_u, result_v


def pell_by_binary(n: int) -> tuple[int, int]:
    result = (1, 0)
    base = (1, 1)
    exponent = n
    while exponent:
        if exponent & 1:
            a, b = result
            c, d = base
            result = (a * c + 2 * b * d, a * d + b * c)
        a, b = base
        base = (a * a + 2 * b * b, 2 * a * b)
        exponent >>= 1
    return result


def coeff(ell: int, r: int) -> int:
    factors = [ell * ell - (2 * j - 1) ** 2 for j in range(1, r + 1)]
    numerator = ell * math.prod(factors)
    denominator = 4**r * math.factorial(2 * r + 1)
    q, rem = divmod(numerator, denominator)
    assert rem == 0
    return q


def verify_local_rows(packet: dict[str, object]) -> None:
    for row in packet["all_residues_mod_5"]:
        modulus = row["modulus"]
        value = u_mod_binary(row["index"], modulus)
        assert value == row["u_index_mod_modulus"]
        assert row["k"] % 2 == 1 and row["k"] > 0
        assert row["k"] % (35 * 35) == 1
        assert value % 35 == 0
        q = (value // 35) % (5 * 35 * 35)
        assert q == row["quotient_mod_5u2"]
        # Modular division by 35 gives q modulo 5*35^2.  Check the second
        # exact divisibility before dividing by 35^2; Python's floor
        # division must not stand in for the mathematical quotient.
        assert (q - 1) % (35 * 35) == 0
        assert ((q - 1) // (35 * 35)) % 5 == row["target_residue"]


def verify_sample(row: dict[str, object]) -> None:
    ell = row["ell"]
    theta = (ell - 1) // 2
    a, b = pell_by_binary(ell)
    a2, _ = pell_by_binary(2 * ell)
    u, v = uv_by_binet_recurrence(ell)
    u_sq, v_sq = uv_by_binet_recurrence(ell * ell)
    assert (a, b, u, v) == (row["A_ell"], row["B_ell"], row["u_ell"], row["v_ell"])
    assert u == a * b and v == 2 * a2
    quotient, rem = divmod(u_sq, u)
    assert rem == 0

    weighted = [pow(32, r) * coeff(ell, r) for r in range(theta + 1)]
    assert weighted[-1] == pow(32, theta)
    assert quotient == sum(weighted[r] * pow(u, 2 * r) for r in range(theta + 1))
    prefix = 0
    for r, frozen_tail in enumerate(row["tails"]):
        d = quotient - prefix
        e, rem = divmod(d, pow(u, 2 * r))
        assert rem == 0
        assert math.gcd(e, u) == 1 == frozen_tail["normalized_tail_gcd_u"]
        assert e % (u * u) == weighted[r] % (u * u)
        prefix += weighted[r] * pow(u, 2 * r)

    w = (quotient - ell) // (u * u)
    s_corr = (v_sq - v) // (u * u)
    modulus = u * u
    assert w % modulus == row["W_mod_u2"] == row["W_expected_mod_u2"]
    assert s_corr % modulus == row["S_mod_u2"] == row["S_expected_mod_u2"]
    z = ell * s_corr * pow((6 * w) % modulus, -1, modulus) % modulus
    assert z == row["splitter_z"] == a2
    assert z * z % modulus == 1
    assert math.gcd(z - 1, u) == a == row["gcd_z_minus_1_u"]
    assert math.gcd(z + 1, u) == b == row["gcd_z_plus_1_u"]


def main() -> None:
    packet = json.loads(PACKET.read_text(encoding="utf-8"))
    verify_local_rows(packet)
    for row in packet["all_order_and_splitter_samples"]:
        verify_sample(row)
    result = {
        "verification": "PASS",
        "local_method": "binary powering in Z[T]/(T^2-6T+1)",
        "sample_method": "binary Binet and Pell powering",
        "local_rows": len(packet["all_residues_mod_5"]),
        "sample_indices": [row["ell"] for row in packet["all_order_and_splitter_samples"]],
    }
    OUTPUT.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(result, sort_keys=True))


if __name__ == "__main__":
    main()
