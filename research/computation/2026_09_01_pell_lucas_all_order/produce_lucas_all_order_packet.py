#!/usr/bin/env python3
"""Produce exact finite checks for the Pell--Lucas all-order report.

This script uses direct integer recurrences and a linear modular recurrence.
It is not used as the proof of the general theorems.
"""

from __future__ import annotations

import json
import math
from pathlib import Path


ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "lucas_all_order_packet.json"


def lucas_uv(n: int) -> tuple[int, int]:
    """Return U_n,V_n for X^2-6X+1."""
    if n == 0:
        return 0, 2
    u0, u1 = 0, 1
    v0, v1 = 2, 6
    for _ in range(1, n):
        u0, u1 = u1, 6 * u1 - u0
        v0, v1 = v1, 6 * v1 - v0
    return u1, v1


def lucas_u_mod_iterative(n: int, modulus: int) -> int:
    a, b = 0, 1
    for _ in range(n):
        a, b = b % modulus, (6 * b - a) % modulus
    return a


def pell_coordinate(n: int) -> tuple[int, int]:
    """Return A_n,B_n from (1+sqrt(2))^n."""
    a, b = 1, 0
    for _ in range(n):
        a, b = a + 2 * b, a + b
    return a, b


def coefficient(ell: int, r: int) -> int:
    numerator = ell
    for j in range(1, r + 1):
        numerator *= ell * ell - (2 * j - 1) ** 2
    denominator = 4**r * math.factorial(2 * r + 1)
    assert numerator % denominator == 0
    return numerator // denominator


def local_residue_rows() -> list[dict[str, int]]:
    n, u, s, t = 3, 35, 5, 1
    rows: list[dict[str, int]] = []
    for c in range(s):
        # Since u^2 and s are odd, adding s flips parity.  This chooses the
        # least nonnegative even representative of c modulo s.
        r = c if c % 2 == 0 else c + s
        k = t + u * u * r
        index = n * k
        modulus = s * u**3
        value = lucas_u_mod_iterative(index, modulus)
        assert value % u == 0
        quotient_modulus = s * u * u
        quotient = (value // u) % quotient_modulus
        assert (quotient - t) % (u * u) == 0
        correction = ((quotient - t) // (u * u)) % s
        assert correction == c
        rows.append(
            {
                "target_residue": c,
                "r": r,
                "k": k,
                "index": index,
                "modulus": modulus,
                "u_index_mod_modulus": value,
                "quotient_mod_5u2": quotient,
                "correction_mod_5": correction,
            }
        )
    return rows


def all_order_row(ell: int) -> dict[str, object]:
    theta = (ell - 1) // 2
    a, b = pell_coordinate(ell)
    u, v = lucas_uv(ell)
    u_sq, v_sq = lucas_uv(ell * ell)
    assert u == a * b
    a2, _ = pell_coordinate(2 * ell)
    assert v == 2 * a2
    assert u_sq % u == 0
    quotient = u_sq // u

    coeffs = [coefficient(ell, r) for r in range(theta + 1)]
    weighted = [pow(32, r) * coeffs[r] for r in range(theta + 1)]
    reconstructed = sum(weighted[r] * pow(u, 2 * r) for r in range(theta + 1))
    assert reconstructed == quotient

    tails: list[dict[str, object]] = []
    prefix = 0
    for r in range(theta + 1):
        d_r = quotient - prefix
        divisor = pow(u, 2 * r)
        assert d_r % divisor == 0
        e_r = d_r // divisor
        assert e_r % (u * u) == weighted[r] % (u * u)
        assert math.gcd(e_r, u) == 1
        tails.append(
            {
                "r": r,
                "c_r": coeffs[r],
                "weighted_coefficient_mod_u2": weighted[r] % (u * u),
                "normalized_tail_gcd_u": math.gcd(e_r, u),
            }
        )
        prefix += weighted[r] * pow(u, 2 * r)

    w = (quotient - ell) // (u * u)
    assert (quotient - ell) % (u * u) == 0
    s_corr = (v_sq - v) // (u * u)
    assert (v_sq - v) % (u * u) == 0
    modulus = u * u
    assert math.gcd(6 * w, modulus) == 1
    z = (ell * s_corr * pow((6 * w) % modulus, -1, modulus)) % modulus
    assert z == a2
    assert z % (a * a) == 1
    assert z % (b * b) == b * b - 1
    assert z * z % modulus == 1
    assert math.gcd(z - 1, u) == a
    assert math.gcd(z + 1, u) == b

    return {
        "ell": ell,
        "theta": theta,
        "A_ell": a,
        "B_ell": b,
        "u_ell": u,
        "v_ell": v,
        "coefficient_count": len(coeffs),
        "last_coefficient": coeffs[-1],
        "tails": tails,
        "W_mod_u2": w % modulus,
        "W_expected_mod_u2": (4 * ell * (ell * ell - 1) // 3) % modulus,
        "S_mod_u2": s_corr % modulus,
        "S_expected_mod_u2": (4 * v * (ell * ell - 1)) % modulus,
        "splitter_z": z,
        "splitter_z_mod_A2": z % (a * a),
        "splitter_z_mod_B2": z % (b * b),
        "gcd_z_minus_1_u": math.gcd(z - 1, u),
        "gcd_z_plus_1_u": math.gcd(z + 1, u),
    }


def main() -> None:
    residue_rows = local_residue_rows()
    payload = {
        "producer": "direct integer recurrences and linear modular recurrence",
        "local_fixed_zero_counterexample": residue_rows[2],
        "all_residues_mod_5": residue_rows,
        "all_order_and_splitter_samples": [all_order_row(ell) for ell in (3, 5, 7, 11)],
        "claim_boundary": (
            "Finite checks validate formulas and refute only the exact fixed-zero subclaim; "
            "they do not prove or disprove abc or exclude all squarefull Pell packets."
        ),
    }
    OUTPUT.write_text(json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(f"wrote {OUTPUT}")
    print("fixed-zero counterexample: PASS")
    print("all five local residues: PASS")
    print("all-order and splitter samples: PASS")


if __name__ == "__main__":
    main()
