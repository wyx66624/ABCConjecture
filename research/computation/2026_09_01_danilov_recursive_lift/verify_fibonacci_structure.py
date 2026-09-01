#!/usr/bin/env python3
"""Independent exact-integer checks for LOGIC_AUDIT.md.

This script uses only the Python standard library.  It does not import the
existing Danilov certificate generator.
"""

from __future__ import annotations

import hashlib
import json
import math
from pathlib import Path


HERE = Path(__file__).resolve().parent
CERT = HERE / "danilov_global_index_sieve_certificate.json"


def qmul(a: tuple[int, int], b: tuple[int, int], modulus: int | None = None) -> tuple[int, int]:
    x = a[0] * b[0] + 5 * a[1] * b[1]
    y = a[0] * b[1] + a[1] * b[0]
    if modulus is not None:
        x %= modulus
        y %= modulus
    return x, y


def qpow(a: tuple[int, int], n: int, modulus: int | None = None) -> tuple[int, int]:
    out = (1, 0)
    base = a
    while n:
        if n & 1:
            out = qmul(out, base, modulus)
        base = qmul(base, base, modulus)
        n >>= 1
    return out


def fib_pair(n: int, modulus: int | None = None) -> tuple[int, int]:
    if n == 0:
        return 0, 1
    a, b = fib_pair(n // 2, modulus)
    if modulus is None:
        c = a * (2 * b - a)
        d = a * a + b * b
    else:
        c = a * ((2 * b - a) % modulus) % modulus
        d = (a * a + b * b) % modulus
    if n & 1:
        if modulus is None:
            return d, c + d
        return d, (c + d) % modulus
    return c, d


def fib(n: int, modulus: int | None = None) -> int:
    return fib_pair(n, modulus)[0]


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> None:
    alpha0 = (682, 305)
    eta = (1730726404001, 774004377960)
    alpha326 = qmul(alpha0, qpow(eta, 326))
    l326 = 2 * alpha326[0] + 11
    f9790 = fib(9790)
    f9785 = fib(9785)

    eta979 = qpow(eta, 979)
    common_gcd = math.gcd(l326, math.gcd(eta979[1], eta979[0] - 1))

    certificate = json.loads(CERT.read_text(encoding="utf-8"))
    rows = []
    for packet in certificate["stage_primes"]:
        p = int(packet["p"])
        rho = int(packet["forced_r_mod_p"])
        residue_p2 = fib(9790, p * p)
        assert residue_p2 % p == 0
        rows.append(
            {
                "p": p,
                "F9790_div_p_mod_p": residue_p2 // p,
                "F9790_not_divisible_by_p2": residue_p2 != 0,
                "three_rho_plus_one_div_p": (3 * rho + 1) // p,
                "three_rho_plus_one_mod_p": (3 * rho + 1) % p,
            }
        )

    forced_t = int(certificate["forced_t"])
    forced_q = int(certificate["forced_t_modulus"])

    u = (9, 4)
    counter_eta = qpow(u, 8)
    counter_norm = counter_eta[0] ** 2 - 5 * counter_eta[1] ** 2
    counter_formula = True
    for r in range(7):
        alpha_r_mod_49 = qmul((19, 1), qpow(counter_eta, r, 49), 49)
        l_r_mod_49 = (2 * alpha_r_mod_49[0] + 11) % 49
        counter_formula &= l_r_mod_49 == (7 * r) % 49

    output = {
        "certificate_sha256": sha256(CERT),
        "danilov_unit_identities": {
            "alpha0_equals_phi15_coordinates": alpha0 == (fib(15) // 2 + fib(14), fib(15) // 2),
            "eta_equals_phi60_coordinates": eta == (fib(60) // 2 + fib(59), fib(60) // 2),
            "norm_eta": eta[0] ** 2 - 5 * eta[1] ** 2,
        },
        "base_state": {
            "three_times_326_plus_one": 3 * 326 + 1,
            "L326_equals_5_F9790_F9785": l326 == 5 * f9790 * f9785,
            "L326_decimal_digits": len(str(l326)),
            "F9790_decimal_digits": len(str(f9790)),
            "common_gcd_equals_F9790": common_gcd == f9790,
        },
        "ten_packets": rows,
        "final_state": {
            "three_T_plus_one_equals_two_Q": 3 * forced_t + 1 == 2 * forced_q,
            "three_T_plus_one_minus_two_Q": 3 * forced_t + 1 - 2 * forced_q,
        },
        "local_countermodel": {
            "eta": list(counter_eta),
            "norm_eta": counter_norm,
            "eta_mod_49": [counter_eta[0] % 49, counter_eta[1] % 49],
            "L0": 49,
            "slope_mod_7": (10 * 1 * 5) % 7,
            "forced_rho": 0,
            "Lr_equals_7r_mod_49_for_all_r_mod_7": counter_formula,
            "next_state": [0, 7],
            "fresh_prime_dividing_L0_exists": False,
        },
    }

    out_path = Path(__file__).with_name("fibonacci_structure_output.json")
    out_path.write_text(json.dumps(output, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(output, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
