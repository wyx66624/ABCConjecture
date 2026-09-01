#!/usr/bin/env python3
"""Finite base-two Wieferich/depth scan with explicit scope metadata."""

from __future__ import annotations

import argparse
import json
from pathlib import Path


def primes_through(limit: int) -> list[int]:
    sieve = bytearray(b"\x01") * (limit + 1)
    if limit >= 0:
        sieve[0] = 0
    if limit >= 1:
        sieve[1] = 0
    for p in range(2, int(limit**0.5) + 1):
        if sieve[p]:
            start = p * p
            sieve[start : limit + 1 : p] = b"\x00" * (
                (limit - start) // p + 1
            )
    return [p for p in range(2, limit + 1) if sieve[p]]


def distinct_prime_factors(n: int, primes: list[int]) -> list[int]:
    result: list[int] = []
    residual = n
    for p in primes:
        if p * p > residual:
            break
        if residual % p == 0:
            result.append(p)
            while residual % p == 0:
                residual //= p
    if residual > 1:
        result.append(residual)
    return result


def multiplicative_order_two(p: int, primes: list[int]) -> tuple[int, list[int]]:
    order = p - 1
    factors = distinct_prime_factors(order, primes)
    for r in factors:
        while order % r == 0 and pow(2, order // r, p) == 1:
            order //= r
    return order, distinct_prime_factors(order, primes)


def canonical_depth(p: int, order: int) -> tuple[int, int]:
    depth = 1
    modulus = p * p
    while pow(2, order, modulus) == 1:
        depth += 1
        modulus *= p
    return depth, pow(2, order, modulus)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=10_000_000)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    if args.limit < 3:
        raise SystemExit("--limit must be at least 3")

    primes = primes_through(args.limit)
    hits: list[dict[str, object]] = []
    for p in primes:
        if p == 2 or pow(2, p - 1, p * p) != 1:
            continue
        order, order_prime_factors = multiplicative_order_two(p, primes)
        depth, first_failure_residue = canonical_depth(p, order)
        hits.append(
            {
                "prime": p,
                "exact_order": order,
                "order_is_odd": order % 2 == 1,
                "order_prime_factors": order_prime_factors,
                "proper_order_quotient_residues": {
                    str(r): pow(2, order // r, p)
                    for r in order_prime_factors
                },
                "canonical_depth": depth,
                "is_super_wieferich": depth >= 3,
                "pow_at_depth_modulus": pow(2, order, p**depth),
                "first_failure_modulus": p ** (depth + 1),
                "first_failure_residue": first_failure_residue,
            }
        )

    payload = {
        "schema": "base-two-super-wieferich-depth-scan-v1",
        "scope": {
            "prime_upper_bound_inclusive": args.limit,
            "strictly_finite_exploratory_scan": True,
            "no_asymptotic_inference": True,
            "no_claim_beyond_bound": True,
        },
        "method": {
            "prime_enumeration": "Eratosthenes bytearray sieve",
            "wieferich_test": "pow(2,p-1,p^2)==1",
            "order": "factor p-1 and divide by prime factors while possible",
            "depth": "increase k until pow(2,ord_p(2),p^k)!=1",
        },
        "prime_count": len(primes),
        "odd_prime_count": len(primes) - 1,
        "hits": hits,
        "summary": {
            "wieferich_primes": [row["prime"] for row in hits],
            "super_wieferich_primes": [
                row["prime"] for row in hits if row["is_super_wieferich"]
            ],
            "odd_exact_order_hits": [
                row["prime"] for row in hits if row["order_is_odd"]
            ],
        },
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )


if __name__ == "__main__":
    main()
