#!/usr/bin/env python3
"""Independent verifier for the correlated all-order Pell--Lucas packet."""

from __future__ import annotations

import argparse
import hashlib
import json
import math
from math import comb, isqrt, prod
from pathlib import Path


EXPECTED_PARAMETERS = {
    "max_index": 271,
    "trial_prime_bound": 2_000_000,
    "coefficient_max_index": 2000,
}
EXPECTED_FALLBACK = {
    29: (44_560_482_149, "B"),
    53: (9_940_681, "A"),
    59: (13_558_774_610_046_711_780_701, "B"),
    73: (2_593_399, "A"),
    157: (1_096_384_693, "B"),
    167: (2_889_769, "A"),
}
EXPECTED_INCIDENCE_INDICES = [3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43]
EXPECTED_MODULI = [1_000_000_007, 1_000_000_009, 998_244_353, 2_147_483_647]


def prime_sieve(limit: int) -> bytearray:
    flags = bytearray(b"\x01") * (limit + 1)
    flags[0:2] = b"\x00\x00"
    for p in range(2, isqrt(limit) + 1):
        if flags[p]:
            start = p * p
            flags[start : limit + 1 : p] = b"\x00" * (((limit - start) // p) + 1)
    return flags


def is_prime_u64(n: int) -> bool:
    """Deterministic Miller--Rabin on n < 2^64."""
    if n < 2:
        return False
    small = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37)
    for p in small:
        if n % p == 0:
            return n == p
    d = n - 1
    s = 0
    while d % 2 == 0:
        d //= 2
        s += 1
    for a in (2, 325, 9375, 28178, 450775, 9780504, 1795265022):
        if a % n == 0:
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


def verify_pocklington(n: int, certificate: dict) -> bool:
    factors = {int(p): int(e) for p, e in certificate["factorization_n_minus_one"].items()}
    bases = {int(p): int(a) for p, a in certificate["bases"].items()}
    known = prod(p**e for p, e in factors.items())
    if known != n - 1 or known <= isqrt(n) or set(factors) != set(bases):
        return False
    for p, a in bases.items():
        if p >= 2**64 or not is_prime_u64(p):
            return False
        if pow(a, n - 1, n) != 1:
            return False
        if math.gcd(pow(a, (n - 1) // p, n) - 1, n) != 1:
            return False
    return True


def pell_pair(n: int, modulus: int | None = None) -> tuple[int, int]:
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
    return a * b % modulus, 2 * (a * a + 2 * b * b) % modulus


def legendre(a: int, p: int) -> int:
    value = pow(a % p, (p - 1) // 2, p)
    return -1 if value == p - 1 else value


def multiplication_coefficients_from_product(ell: int) -> list[tuple[int, int]]:
    """Rebuild c_j from the defining product, independently of d_j."""
    theta = (ell - 1) // 2
    factors_numerator = 1
    factorial_denominator = 1
    coefficients = []
    for j in range(theta + 1):
        if j > 0:
            factors_numerator *= ell**2 - (2 * j - 1) ** 2
            factorial_denominator *= 4 * (2 * j) * (2 * j + 1)
        scaled_numerator = ell * factors_numerator
        quotient, remainder = divmod(scaled_numerator, factorial_denominator)
        if remainder:
            raise AssertionError(f"nonintegral product coefficient at ({ell},{j})")
        companion = comb(theta + j, 2 * j)
        coefficients.append((quotient, companion))
    return coefficients


def scan_index(ell: int, bound: int, flags: bytearray) -> tuple[dict | None, int, list[dict]]:
    witness = None
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
                    if witness is None:
                        witness = {"index": ell, "prime": q, "channel": channel,
                                   "source": "bounded_scan"}
                else:
                    repeated.append({
                        "index": ell,
                        "prime": q,
                        "channel": channel,
                        "depth": "at_least_3" if coordinate % (q**3) == 0 else "exactly_2",
                    })
    return witness, tests, repeated


def verify_simple_witness(row: dict, certificates: dict) -> str | None:
    ell = int(row["index"])
    q = int(row["prime"])
    channel = row["channel"]
    if q < 2**64:
        prime_ok = is_prime_u64(q)
    else:
        cert = certificates.get(str(q))
        prime_ok = cert is not None and verify_pocklington(q, cert)
    if not prime_ok:
        return f"simple witness {q} at index {ell} has no valid primality proof"
    a, b = pell_pair(ell, q * q)
    coordinate = a if channel == "A" else b if channel == "B" else None
    if coordinate is None or coordinate % q or coordinate % (q * q) == 0:
        return f"row at index {ell} is not an exact exponent-one witness"
    residue = q % (2 * ell)
    expected = 1 if channel == "A" else legendre(2, q) % (2 * ell)
    if residue != expected:
        return f"rank-channel residue mismatch at index {ell}, prime {q}"
    return None


def coefficient_audit(max_ell: int, flags: bytearray) -> dict:
    digest = hashlib.sha256()
    count = 0
    for ell in range(3, max_ell + 1, 2):
        if not flags[ell]:
            continue
        for j, (c, d) in enumerate(multiplication_coefficients_from_product(ell)):
            if (2 * j + 1) * c != ell * d:
                raise AssertionError(f"coefficient correlation failed at ({ell},{j})")
            digest.update(f"{ell},{j},{c},{d}\n".encode("ascii"))
            count += 1
    return {"max_prime_index": max_ell, "coefficient_pairs": count,
            "sha256": digest.hexdigest()}


def polynomial_audit(max_ell: int, flags: bytearray) -> dict:
    digest = hashlib.sha256()
    count = 0
    for ell in range(3, max_ell + 1, 2):
        if not flags[ell]:
            continue
        coefficients = multiplication_coefficients_from_product(ell)
        for modulus in EXPECTED_MODULI:
            u, v = lucas_uv(ell, modulus)
            u2, v2 = lucas_uv(ell * ell, modulus)
            t = u * u % modulus
            power = 1
            pu = pv = 0
            for j, (c, d) in enumerate(coefficients):
                scale = pow(32, j, modulus)
                pu = (pu + c * scale * power) % modulus
                pv = (pv + d * scale * power) % modulus
                power = power * t % modulus
            if u2 != u * pu % modulus or v2 != v * pv % modulus:
                raise AssertionError(f"multiplication polynomial mismatch at ({ell},{modulus})")
            digest.update(f"{ell},{modulus},{u},{v},{u2},{v2},{pu},{pv}\n".encode("ascii"))
            count += 1
    return {"max_prime_index": max_ell, "moduli": EXPECTED_MODULI,
            "checks": count, "sha256": digest.hexdigest()}


def factor_dict(raw: dict) -> dict[int, int]:
    return {int(p): int(e) for p, e in raw.items()}


def verified_incidence_row(row: dict) -> tuple[dict, list[str]]:
    errors = []
    ell = int(row["index"])
    a, b = pell_pair(ell)
    fa = factor_dict(row["A_factorization"])
    fb = factor_dict(row["B_factorization"])
    if int(row["A"]) != a or int(row["B"]) != b:
        errors.append(f"coordinate mismatch at incidence index {ell}")
    if prod(p**e for p, e in fa.items()) != a or prod(p**e for p, e in fb.items()) != b:
        errors.append(f"factorization product mismatch at incidence index {ell}")
    if any(p >= 2**64 or not is_prime_u64(p) for p in (*fa, *fb)):
        errors.append(f"unproved factor primality at incidence index {ell}")
    if a * a - 2 * b * b != -1 or math.gcd(a, b) != 1:
        errors.append(f"Pell or coprimality identity failed at incidence index {ell}")
    oa = sorted(p for p, e in fa.items() if e % 2)
    ob = sorted(p for p, e in fb.items() if e % 2)
    if row["A_odd_kernel"] != oa or row["B_odd_kernel"] != ob:
        errors.append(f"odd-kernel mismatch at incidence index {ell}")
    edges = [{"q": q, "r": r, "symbol": legendre(q, r)} for q in oa for r in ob]
    if row["edges"] != edges:
        errors.append(f"edge matrix mismatch at incidence index {ell}")
    row_signs = []
    for r in ob:
        value = prod(x["symbol"] for x in edges if x["r"] == r)
        expected = legendre(2, r)
        if value != expected:
            errors.append(f"row parity law failed at ({ell},{r})")
        row_signs.append({"r": r, "product": value, "two_symbol": expected})
    column_signs = []
    for q in oa:
        value = prod(x["symbol"] for x in edges if x["q"] == q)
        expected = legendre(b, q)
        quartic = None
        if q % 8 == 1:
            z = pow(2, (q - 1) // 4, q)
            quartic = -1 if z == q - 1 else z
            if quartic != expected:
                errors.append(f"quartic-two column law failed at ({ell},{q})")
        column_signs.append({"q": q, "product": value, "B_symbol": expected,
                             "quartic_two_symbol": quartic})
    if row["row_signs"] != row_signs or row["column_signs"] != column_signs:
        errors.append(f"endpoint sign ledger mismatch at incidence index {ell}")
    global_sign = prod(x["symbol"] for x in edges)
    if global_sign != legendre(2, ell):
        errors.append(f"global character mismatch at incidence index {ell}")
    if row["global_sign"] != global_sign:
        errors.append(f"stored global sign mismatch at incidence index {ell}")
    return {
        "index": ell,
        "A_odd_kernel_size": len(oa),
        "B_odd_kernel_size": len(ob),
        "edge_count": len(edges),
        "global_sign": global_sign,
    }, errors


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, default=Path("correlated_all_order_packet.json"))
    parser.add_argument("--output", type=Path, default=Path("correlated_all_order_verification.json"))
    args = parser.parse_args()
    data = json.loads(args.input.read_text(encoding="utf-8"))
    errors: list[str] = []
    if data.get("schema") != "pell-lucas-correlated-all-order-v1":
        errors.append("schema mismatch")
    if data.get("parameters") != EXPECTED_PARAMETERS:
        errors.append("parameter mismatch")

    flags = prime_sieve(max(EXPECTED_PARAMETERS.values()))
    indices = [ell for ell in range(3, 272, 2) if flags[ell]]
    finite = data["finite_packet_exclusion"]
    stored_witnesses = finite["witnesses"]
    if len(stored_witnesses) != len(indices) or [x["index"] for x in stored_witnesses] != indices:
        errors.append("simple-witness index coverage mismatch")

    replay_witnesses = []
    replay_repeated = []
    replay_tests = 0
    replay_unresolved = []
    for ell in indices:
        witness, tests, repeated = scan_index(ell, 2_000_000, flags)
        replay_tests += tests
        replay_repeated.extend(repeated)
        if witness is None:
            replay_unresolved.append(ell)
            if ell not in EXPECTED_FALLBACK:
                errors.append(f"unexpected unresolved index {ell}")
                continue
            q, channel = EXPECTED_FALLBACK[ell]
            witness = {"index": ell, "prime": q, "channel": channel,
                       "source": "frozen_exact_fallback"}
        replay_witnesses.append(witness)
    if replay_witnesses != stored_witnesses:
        errors.append("independent simple-witness replay mismatch")
    if replay_unresolved != finite["bounded_unresolved_indices"]:
        errors.append("bounded unresolved list mismatch")
    if finite["prime_index_count"] != len(indices) or not finite["all_indices_have_simple_witness"]:
        errors.append("finite packet coverage metadata mismatch")

    certificates = data.get("pocklington_certificates", {})
    for row in stored_witnesses:
        error = verify_simple_witness(row, certificates)
        if error:
            errors.append(error)

    depth = data["bounded_depth_scan"]
    if depth["candidate_prime_tests"] != replay_tests:
        errors.append("candidate-prime count mismatch")
    if depth["repeated_hits"] != replay_repeated:
        errors.append("repeated-hit replay mismatch")
    replay_depth_three = [x for x in replay_repeated if x["depth"] == "at_least_3"]
    if depth["depth_three_hits"] != replay_depth_three:
        errors.append("depth-three list mismatch")

    try:
        coeff = coefficient_audit(2000, flags)
        poly = polynomial_audit(271, flags)
    except AssertionError as exc:
        errors.append(str(exc))
        coeff = {}
        poly = {}
    if coeff != data["coefficient_audit"]:
        errors.append("coefficient audit mismatch")
    if poly != data["polynomial_audit"]:
        errors.append("polynomial audit mismatch")

    incidence_rows = data["incidence_audit"]
    if [x["index"] for x in incidence_rows] != EXPECTED_INCIDENCE_INDICES:
        errors.append("incidence-index list mismatch")
    incidence_summary = []
    for row in incidence_rows:
        summary, row_errors = verified_incidence_row(row)
        incidence_summary.append(summary)
        errors.extend(row_errors)

    ell11 = next((x for x in incidence_rows if x["index"] == 11), None)
    if ell11 is None:
        errors.append("missing sharpness row at index eleven")
    else:
        signs = sorted(x["symbol"] for x in ell11["edges"] if x["r"] == 5741)
        if signs != [-1, 1]:
            errors.append("index-eleven sharpness counterexample mismatch")

    result = {
        "schema": "pell-lucas-correlated-all-order-verification-v1",
        "status": "PASS" if not errors else "FAIL",
        "errors": errors,
        "verified": {
            "prime_indices_with_exact_simple_witness": len(stored_witnesses),
            "all_prime_indices_through": 271,
            "candidate_prime_tests": replay_tests,
            "repeated_hits": replay_repeated,
            "depth_three_hit_count": len(replay_depth_three),
            "coefficient_pairs": coeff.get("coefficient_pairs"),
            "polynomial_checks": poly.get("checks"),
            "incidence_rows": incidence_summary,
            "index_eleven_row_has_both_signs": ell11 is not None and
                sorted(x["symbol"] for x in ell11["edges"] if x["r"] == 5741) == [-1, 1],
        },
        "claim_boundary": (
            "The exact witnesses exclude squarefull packets only at prime indices <=271.  "
            "The bounded absence of depth-three hits does not imply an unbounded exclusion."
        ),
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    raise SystemExit(0 if not errors else 1)


if __name__ == "__main__":
    main()
