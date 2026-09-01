#!/usr/bin/env python3
"""Independently verify the integer certificates emitted by the scan."""

from __future__ import annotations

import argparse
import hashlib
import json
import math
from pathlib import Path


MR_BASES_64 = (2, 325, 9375, 28178, 450775, 9780504, 1795265022)


def is_prime_64(n: int) -> bool:
    if n < 2:
        return False
    small = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37)
    for p in small:
        if n % p == 0:
            return n == p
    odd_part = n - 1
    two_adic_order = 0
    while odd_part & 1 == 0:
        two_adic_order += 1
        odd_part >>= 1
    for base in MR_BASES_64:
        residue = pow(base % n, odd_part, n)
        if residue == 1 or residue == n - 1:
            continue
        witnessed_composite = True
        for _ in range(two_adic_order - 1):
            residue = pow(residue, 2, n)
            if residue == n - 1:
                witnessed_composite = False
                break
        if witnessed_composite:
            return False
    return True


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("input", type=Path)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    raw = args.input.read_bytes()
    data = json.loads(raw)
    failures: list[str] = []
    for row in data["rows"]:
        ell = row["index"]
        m = row["mersenne"]
        fac = row["factorization"]
        if not is_prime_64(ell):
            failures.append(f"index {ell} is not prime")
        if m != (1 << ell) - 1:
            failures.append(f"index {ell}: incorrect Mersenne value")
        if any(not is_prime_64(f["prime"]) for f in fac):
            failures.append(f"index {ell}: listed factor is not prime")
        product = math.prod(f["prime"] ** f["exponent"] for f in fac)
        radical = math.prod(f["prime"] for f in fac)
        if product != m:
            failures.append(f"index {ell}: factor product mismatch")
        if radical != row["radical"] or m // radical != row["power_loss"]:
            failures.append(f"index {ell}: radical/power-loss mismatch")
        if len(fac) != row["support_count"]:
            failures.append(f"index {ell}: support count mismatch")
        if row["max_prime_factor"] != max(f["prime"] for f in fac):
            failures.append(f"index {ell}: maximum factor mismatch")
        for f in fac:
            q = f["prime"]
            if q % (2 * ell) != 1:
                failures.append(f"index {ell}, factor {q}: q != 1 mod 2*ell")
            # Since ell is prime and 2 is not 1 modulo the odd prime q, this
            # equality certifies exact order ell.
            if pow(2, ell, q) != 1 or 2 % q == 1:
                failures.append(f"index {ell}, factor {q}: order check failed")
        composite = len(fac) != 1 or fac[0]["exponent"] != 1
        if composite and radical < (2 * ell + 1) ** 2:
            failures.append(f"index {ell}: proved square radical bound failed")

    verification = {
        "schema": "mersenne-prime-layer-radical-verification-v1",
        "input": args.input.name,
        "input_sha256": hashlib.sha256(raw).hexdigest(),
        "rows_verified": len(data["rows"]),
        "checks": [
            "prime index by deterministic 64-bit Miller-Rabin",
            "Mersenne value identity",
            "prime factor certificates and exact product",
            "radical and power-loss identities",
            "q congruent to 1 modulo 2*index",
            "exact multiplicative order at prime index",
            "square radical lower bound on every composite row",
        ],
        "failures": failures,
        "verified": not failures,
    }
    args.output.write_text(
        json.dumps(verification, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    if failures:
        raise SystemExit("verification failed: " + "; ".join(failures))


if __name__ == "__main__":
    main()
