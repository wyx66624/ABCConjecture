#!/usr/bin/env python3
"""Independent replay of the Pell prime-index squarefull search evidence."""

from __future__ import annotations

import argparse
import json
import math
from math import isqrt
from pathlib import Path


def is_prime_by_trial_division(n: int) -> bool:
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    if n % 3 == 0:
        return n == 3
    d = 5
    while d * d <= n:
        if n % d == 0 or n % (d + 2) == 0:
            return False
        d += 6
    return True


def verify_pocklington(n: int, cert: dict) -> bool:
    factors = {int(p): int(e) for p, e in cert["factorization_n_minus_one"].items()}
    bases = {int(p): int(a) for p, a in cert["bases"].items()}
    if math.prod(p ** e for p, e in factors.items()) != n - 1:
        return False
    known_part = math.prod(p ** e for p, e in factors.items())
    if known_part <= isqrt(n):
        return False
    if set(factors) != set(bases):
        return False
    for p in factors:
        if not is_prime_by_trial_division(p):
            return False
        a = bases[p]
        if pow(a, n - 1, n) != 1:
            return False
        if math.gcd(pow(a, (n - 1) // p, n) - 1, n) != 1:
            return False
    return True


def prime_sieve(limit: int) -> bytearray:
    flags = bytearray(b"\x01") * (limit + 1)
    flags[0:2] = b"\x00\x00"
    for p in range(2, isqrt(limit) + 1):
        if flags[p]:
            start = p * p
            flags[start : limit + 1 : p] = b"\x00" * (((limit - start) // p) + 1)
    return flags


def pell_pair_mod(n: int, modulus: int) -> tuple[int, int]:
    a, b = 1, 0
    x, y = 1, 1
    while n:
        if n & 1:
            a, b = (a * x + 2 * b * y) % modulus, (a * y + b * x) % modulus
        x, y = (x * x + 2 * y * y) % modulus, (2 * x * y) % modulus
        n //= 2
    return a, b


def bounded_simple_witness(index: int, bound: int, flags: bytearray):
    for k in range(1, bound // (2 * index) + 2):
        for q in (2 * index * k - 1, 2 * index * k + 1):
            if q < 3 or q > bound or not flags[q]:
                continue
            a, b = pell_pair_mod(index, q * q)
            if a % q == 0 and a % (q * q) != 0:
                return {"index": index, "prime": q, "channel": "A"}
            if b % q == 0 and b % (q * q) != 0:
                return {"index": index, "prime": q, "channel": "B"}
    return None


def bounded_repeated_divisors(index: int, bound: int, flags: bytearray):
    records = []
    tests = 0
    for k in range(1, bound // (2 * index) + 2):
        for q in (2 * index * k - 1, 2 * index * k + 1):
            if q < 3 or q > bound or not flags[q]:
                continue
            tests += 1
            a, b = pell_pair_mod(index, q * q * q)
            for channel, coordinate in (("A", a), ("B", b)):
                if coordinate % (q * q) == 0:
                    records.append({
                        "index": index,
                        "prime": q,
                        "channel": channel,
                        "depth": "at_least_3" if coordinate % (q * q * q) == 0
                            else "exactly_2",
                    })
    return tests, records


def verify_simple_witness(row: dict, pocklington: dict) -> tuple[bool, str]:
    ell = int(row["index"])
    q = int(row["prime"])
    channel = row["channel"]
    if not is_prime_by_trial_division(ell) or ell % 2 == 0:
        return False, f"index {ell} is not an odd prime"
    if q < 10**12:
        q_prime = is_prime_by_trial_division(q)
    else:
        cert = pocklington.get(str(q))
        q_prime = cert is not None and verify_pocklington(q, cert)
    if not q_prime:
        return False, f"factor {q} lacks a valid primality proof"
    a, b = pell_pair_mod(ell, q * q)
    coordinate = a if channel == "A" else b if channel == "B" else None
    if coordinate is None:
        return False, f"invalid channel at index {ell}"
    if coordinate % q != 0 or coordinate % (q * q) == 0:
        return False, f"{q} is not an exact exponent-one divisor at index {ell}"
    return True, "ok"


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, default=Path("prime_index_squarefull_search.json"))
    parser.add_argument("--output", type=Path, default=Path("prime_index_squarefull_verification.json"))
    args = parser.parse_args()
    data = json.loads(args.input.read_text(encoding="utf-8"))
    errors: list[str] = []
    if data.get("schema") != "pell-prime-index-squarefull-search-v1":
        errors.append("schema mismatch")
    params = data["parameters"]
    expected_params = {
        "max_index": 5000,
        "trial_prime_bound": 2000000,
        "certificate_max_index": 191,
    }
    if params != expected_params:
        errors.append("parameter triple mismatch")
    max_index = int(params["max_index"])
    bound = int(params["trial_prime_bound"])
    cert_max = int(params["certificate_max_index"])
    flags = prime_sieve(max(max_index, bound))
    indices = [p for p in range(3, max_index + 1, 2) if flags[p]]

    replay_hits = []
    replay_unresolved = []
    for ell in indices:
        row = bounded_simple_witness(ell, bound, flags)
        if row is None:
            replay_unresolved.append(ell)
        else:
            replay_hits.append(row)
    bounded = data["bounded_scan"]
    if replay_hits != bounded["hits"]:
        errors.append("bounded hit list mismatch")
    if replay_unresolved != bounded["unresolved_indices"]:
        errors.append("bounded unresolved list mismatch")
    if bounded["prime_index_count"] != len(indices):
        errors.append("bounded prime-index count mismatch")
    if bounded["hit_count"] != len(replay_hits):
        errors.append("bounded hit count mismatch")
    if bounded["unresolved_count"] != len(replay_unresolved):
        errors.append("bounded unresolved count mismatch")

    repeated_tests = 0
    repeated_hits = []
    for ell in indices:
        tests, rows = bounded_repeated_divisors(ell, bound, flags)
        repeated_tests += tests
        repeated_hits.extend(rows)
    repeated = data["bounded_repeated_scan"]
    if repeated["candidate_prime_tests"] != repeated_tests:
        errors.append("repeated-scan candidate count mismatch")
    if repeated["hits"] != repeated_hits:
        errors.append("repeated-scan hit list mismatch")
    if repeated["repeated_hit_count"] != len(repeated_hits):
        errors.append("repeated-scan hit count mismatch")
    depth_three_count = sum(row["depth"] == "at_least_3" for row in repeated_hits)
    if repeated["depth_three_hit_count"] != depth_three_count:
        errors.append("repeated-scan depth-three count mismatch")

    pocklington = data.get("pocklington_certificates", {})
    exact = data["exact_certificate_range"]
    expected_exact_indices = [p for p in indices if p <= cert_max]
    rows = exact["witnesses"]
    if [int(row["index"]) for row in rows] != expected_exact_indices:
        errors.append("exact certificate does not cover every prime index in range")
    for row in rows:
        ok, message = verify_simple_witness(row, pocklington)
        if not ok:
            errors.append(message)
    if exact["unresolved_indices"] or exact["unresolved_count"] != 0:
        errors.append("exact certificate range contains unresolved indices")
    if exact["witness_count"] != len(expected_exact_indices):
        errors.append("exact witness count mismatch")
    if exact["prime_index_count"] != len(expected_exact_indices):
        errors.append("exact prime-index count mismatch")

    result = {
        "schema": "pell-prime-index-squarefull-verification-v1",
        "status": "PASS" if not errors else "FAIL",
        "input": str(args.input),
        "verified": {
            "bounded_prime_indices": len(indices),
            "bounded_hits": len(replay_hits),
            "bounded_unresolved": len(replay_unresolved),
            "bounded_repeated_candidate_tests": repeated_tests,
            "bounded_repeated_hits": len(repeated_hits),
            "bounded_depth_three_hits": depth_three_count,
            "all_prime_indices_through": cert_max,
            "exact_simple_divisor_certificates": len(rows),
            "pocklington_certificates": len(pocklington),
        },
        "logical_boundary": (
            "Every exact certificate refutes squarefullness only at its listed index; "
            "bounded unresolved indices remain open and no asymptotic claim is made."
        ),
        "errors": errors,
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    raise SystemExit(0 if not errors else 1)


if __name__ == "__main__":
    main()
