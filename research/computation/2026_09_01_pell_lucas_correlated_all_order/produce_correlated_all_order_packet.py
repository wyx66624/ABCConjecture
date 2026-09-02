#!/usr/bin/env python3
"""Produce independently replayable Pell--Lucas correlation evidence.

The finite search is one-sided.  An exponent-one witness proves that the
actual packet at that index is not squarefull.  Failure to find a bounded
witness, or failure to find a depth-three prime, is never interpreted as a
global exclusion.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from math import comb, isqrt, prod
from pathlib import Path

from sympy import factorint


FALLBACK_WITNESSES = {
    29: (44_560_482_149, "B"),
    53: (9_940_681, "A"),
    59: (13_558_774_610_046_711_780_701, "B"),
    73: (2_593_399, "A"),
    157: (1_096_384_693, "B"),
    167: (2_889_769, "A"),
}

POCKLINGTON_CERTIFICATES = {
    "13558774610046711780701": {
        "factorization_n_minus_one": {
            "2": 2,
            "5": 2,
            "7": 1,
            "29": 1,
            "31": 2,
            "41": 1,
            "269": 1,
            "63018038201": 1,
        },
        "bases": {
            "2": 2,
            "5": 3,
            "7": 2,
            "29": 2,
            "31": 2,
            "41": 2,
            "269": 2,
            "63018038201": 2,
        },
    }
}


def prime_sieve(limit: int) -> bytearray:
    flags = bytearray(b"\x01") * (limit + 1)
    flags[0:2] = b"\x00\x00"
    for p in range(2, isqrt(limit) + 1):
        if flags[p]:
            start = p * p
            flags[start : limit + 1 : p] = b"\x00" * (((limit - start) // p) + 1)
    return flags


def pell_pair(n: int, modulus: int | None = None) -> tuple[int, int]:
    """Return A_n,B_n for (1+sqrt(2))^n, optionally modulo modulus."""
    a, b = 1, 0
    x, y = 1, 1
    while n:
        if n & 1:
            a, b = a * x + 2 * b * y, a * y + b * x
            if modulus is not None:
                a %= modulus
                b %= modulus
        x, y = x * x + 2 * y * y, 2 * x * y
        if modulus is not None:
            x %= modulus
            y %= modulus
        n //= 2
    return a, b


def lucas_uv(n: int, modulus: int) -> tuple[int, int]:
    a, b = pell_pair(n, modulus)
    return (a * b) % modulus, (2 * (a * a + 2 * b * b)) % modulus


def legendre(a: int, p: int) -> int:
    z = pow(a % p, (p - 1) // 2, p)
    if z == p - 1:
        return -1
    if z in (0, 1):
        return z
    raise AssertionError("Euler criterion returned a non-sign")


def odd_kernel(factors: dict[int, int]) -> list[int]:
    return sorted(p for p, e in factors.items() if e & 1)


def multiplication_coefficients_from_product(ell: int) -> list[tuple[int, int]]:
    """Return (c_j,d_j), computing c_j from its product/factorial formula."""
    theta = (ell - 1) // 2
    factor_product = 1
    denominator = 1
    rows = []
    for j in range(theta + 1):
        if j:
            factor_product *= ell * ell - (2 * j - 1) ** 2
            # 4^j (2j+1)! / (4^(j-1) (2j-1)!).
            denominator *= 4 * (2 * j) * (2 * j + 1)
        numerator = ell * factor_product
        assert numerator % denominator == 0
        c = numerator // denominator
        d = comb(theta + j, 2 * j)
        rows.append((c, d))
    return rows


def scan_index(ell: int, bound: int, flags: bytearray) -> tuple[dict | None, int, list[dict]]:
    first_simple = None
    tests = 0
    repeated = []
    for k in range(1, bound // (2 * ell) + 2):
        for q in (2 * ell * k - 1, 2 * ell * k + 1):
            if q < 3 or q > bound or not flags[q]:
                continue
            tests += 1
            a, b = pell_pair(ell, q**3)
            for channel, coordinate in (("A", a), ("B", b)):
                if coordinate % q:
                    continue
                if coordinate % (q * q):
                    if first_simple is None:
                        first_simple = {"index": ell, "prime": q, "channel": channel,
                                        "source": "bounded_scan"}
                else:
                    repeated.append({
                        "index": ell,
                        "prime": q,
                        "channel": channel,
                        "depth": "at_least_3" if coordinate % (q**3) == 0 else "exactly_2",
                    })
    return first_simple, tests, repeated


def coefficient_audit(max_ell: int, flags: bytearray) -> dict:
    count = 0
    digest = hashlib.sha256()
    for ell in range(3, max_ell + 1, 2):
        if not flags[ell]:
            continue
        for j, (c, d) in enumerate(multiplication_coefficients_from_product(ell)):
            assert (2 * j + 1) * c == ell * d
            digest.update(f"{ell},{j},{c},{d}\n".encode("ascii"))
            count += 1
    return {"max_prime_index": max_ell, "coefficient_pairs": count,
            "sha256": digest.hexdigest()}


def polynomial_audit(max_ell: int, flags: bytearray, moduli: list[int]) -> dict:
    count = 0
    digest = hashlib.sha256()
    for ell in range(3, max_ell + 1, 2):
        if not flags[ell]:
            continue
        coefficients = multiplication_coefficients_from_product(ell)
        for modulus in moduli:
            u, v = lucas_uv(ell, modulus)
            u2, v2 = lucas_uv(ell * ell, modulus)
            pu = 0
            pv = 0
            t = (u * u) % modulus
            power = 1
            for j, (c, d) in enumerate(coefficients):
                pu = (pu + c * pow(32, j, modulus) * power) % modulus
                pv = (pv + d * pow(32, j, modulus) * power) % modulus
                power = (power * t) % modulus
            assert u2 == (u * pu) % modulus
            assert v2 == (v * pv) % modulus
            digest.update(f"{ell},{modulus},{u},{v},{u2},{v2},{pu},{pv}\n".encode("ascii"))
            count += 1
    return {"max_prime_index": max_ell, "moduli": moduli, "checks": count,
            "sha256": digest.hexdigest()}


def incidence_audit(indices: list[int]) -> list[dict]:
    rows = []
    for ell in indices:
        a, b = pell_pair(ell)
        fa = {int(p): int(e) for p, e in factorint(a).items()}
        fb = {int(p): int(e) for p, e in factorint(b).items()}
        oa = odd_kernel(fa)
        ob = odd_kernel(fb)
        matrix = [{"q": q, "r": r, "symbol": legendre(q, r)} for q in oa for r in ob]
        row_signs = []
        for r in ob:
            sign = prod(x["symbol"] for x in matrix if x["r"] == r)
            expected = legendre(2, r)
            assert sign == expected
            row_signs.append({"r": r, "product": sign, "two_symbol": expected})
        column_signs = []
        for q in oa:
            sign = prod(x["symbol"] for x in matrix if x["q"] == q)
            expected = legendre(b, q)
            assert sign == expected
            quartic_two = None
            if q % 8 == 1:
                residue = pow(2, (q - 1) // 4, q)
                quartic_two = -1 if residue == q - 1 else residue
                assert quartic_two == expected
            column_signs.append({"q": q, "product": sign, "B_symbol": expected,
                                 "quartic_two_symbol": quartic_two})
        global_sign = prod(x["symbol"] for x in matrix)
        assert global_sign == prod(x["two_symbol"] for x in row_signs)
        assert global_sign == prod(x["B_symbol"] for x in column_signs)
        rows.append({
            "index": ell,
            "A": str(a),
            "B": str(b),
            "A_factorization": {str(p): e for p, e in sorted(fa.items())},
            "B_factorization": {str(p): e for p, e in sorted(fb.items())},
            "A_odd_kernel": oa,
            "B_odd_kernel": ob,
            "edges": matrix,
            "row_signs": row_signs,
            "column_signs": column_signs,
            "global_sign": global_sign,
        })
    return rows


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-index", type=int, default=271)
    parser.add_argument("--trial-prime-bound", type=int, default=2_000_000)
    parser.add_argument("--coefficient-max-index", type=int, default=2000)
    parser.add_argument("--output", type=Path, default=Path("correlated_all_order_packet.json"))
    args = parser.parse_args()

    sieve_limit = max(args.max_index, args.trial_prime_bound, args.coefficient_max_index)
    flags = prime_sieve(sieve_limit)
    indices = [ell for ell in range(3, args.max_index + 1, 2) if flags[ell]]

    witnesses = []
    repeated_hits = []
    candidate_tests = 0
    bounded_unresolved = []
    for ell in indices:
        witness, tests, repeated = scan_index(ell, args.trial_prime_bound, flags)
        candidate_tests += tests
        repeated_hits.extend(repeated)
        if witness is None:
            bounded_unresolved.append(ell)
            q, channel = FALLBACK_WITNESSES[ell]
            witness = {"index": ell, "prime": q, "channel": channel,
                       "source": "frozen_exact_fallback"}
        witnesses.append(witness)

    incidence_indices = [3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43]
    moduli = [1_000_000_007, 1_000_000_009, 998_244_353, 2_147_483_647]
    result = {
        "schema": "pell-lucas-correlated-all-order-v1",
        "policy": (
            "Every exponent-one witness is an exact finite exclusion.  "
            "A bounded no-hit never retires the route or any unbounded statement."
        ),
        "parameters": {
            "max_index": args.max_index,
            "trial_prime_bound": args.trial_prime_bound,
            "coefficient_max_index": args.coefficient_max_index,
        },
        "finite_packet_exclusion": {
            "prime_index_count": len(indices),
            "all_indices_have_simple_witness": len(witnesses) == len(indices),
            "witnesses": witnesses,
            "bounded_unresolved_indices": bounded_unresolved,
        },
        "bounded_depth_scan": {
            "candidate_prime_tests": candidate_tests,
            "repeated_hits": repeated_hits,
            "depth_three_hits": [x for x in repeated_hits if x["depth"] == "at_least_3"],
        },
        "coefficient_audit": coefficient_audit(args.coefficient_max_index, flags),
        "polynomial_audit": polynomial_audit(args.max_index, flags, moduli),
        "incidence_audit": incidence_audit(incidence_indices),
        "pocklington_certificates": POCKLINGTON_CERTIFICATES,
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "prime_indices_excluded": len(indices),
        "largest_index": indices[-1],
        "bounded_unresolved": bounded_unresolved,
        "candidate_prime_tests": candidate_tests,
        "repeated_hits": repeated_hits,
        "depth_three_hit_count": len(result["bounded_depth_scan"]["depth_three_hits"]),
        "coefficient_pairs": result["coefficient_audit"]["coefficient_pairs"],
        "polynomial_checks": result["polynomial_audit"]["checks"],
        "incidence_indices": incidence_indices,
        "output": str(args.output),
    }, indent=2))


if __name__ == "__main__":
    main()
