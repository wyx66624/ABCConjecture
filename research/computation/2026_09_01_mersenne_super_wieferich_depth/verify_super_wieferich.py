#!/usr/bin/env python3
"""Independent segmented-sieve verifier for the finite depth scan."""

from __future__ import annotations

import argparse
import json
import math
from pathlib import Path


def small_primes(limit: int) -> list[int]:
    flags = [True] * (limit + 1)
    flags[:2] = [False, False]
    for p in range(2, math.isqrt(limit) + 1):
        if flags[p]:
            for n in range(p * p, limit + 1, p):
                flags[n] = False
    return [p for p, flag in enumerate(flags) if flag]


def segmented_primes(limit: int, segment_size: int = 131_072):
    base = small_primes(math.isqrt(limit))
    for low in range(2, limit + 1, segment_size):
        high = min(limit + 1, low + segment_size)
        flags = bytearray(b"\x01") * (high - low)
        for p in base:
            start = max(p * p, ((low + p - 1) // p) * p)
            if start >= high:
                continue
            flags[start - low : high - low : p] = b"\x00" * (
                (high - 1 - start) // p + 1
            )
        for offset, flag in enumerate(flags):
            if flag:
                yield low + offset


def prime_divisors(n: int) -> list[int]:
    answer: list[int] = []
    p = 2
    residual = n
    while p * p <= residual:
        if residual % p == 0:
            answer.append(p)
            while residual % p == 0:
                residual //= p
        p = 3 if p == 2 else p + 2
    if residual > 1:
        answer.append(residual)
    return answer


def verify(path: Path) -> dict[str, object]:
    data = json.loads(path.read_text(encoding="utf-8"))
    assert data["schema"] == "base-two-super-wieferich-depth-scan-v1"
    scope = data["scope"]
    assert scope["strictly_finite_exploratory_scan"] is True
    assert scope["no_asymptotic_inference"] is True
    assert scope["no_claim_beyond_bound"] is True
    limit = int(scope["prime_upper_bound_inclusive"])

    hits: list[int] = []
    prime_count = 0
    for p in segmented_primes(limit):
        prime_count += 1
        if p != 2 and pow(2, p - 1, p * p) == 1:
            hits.append(p)

    rows = data["hits"]
    assert prime_count == data["prime_count"]
    assert [row["prime"] for row in rows] == hits
    assert data["odd_prime_count"] == prime_count - 1

    for row in rows:
        p = int(row["prime"])
        order = int(row["exact_order"])
        factors = prime_divisors(order)
        assert factors == row["order_prime_factors"]
        assert (p - 1) % order == 0
        assert pow(2, order, p) == 1
        residues = {str(r): pow(2, order // r, p) for r in factors}
        assert residues == row["proper_order_quotient_residues"]
        assert all(value != 1 for value in residues.values())

        depth = int(row["canonical_depth"])
        assert depth >= 2
        assert pow(2, order, p**depth) == 1
        failure = pow(2, order, p ** (depth + 1))
        assert failure != 1
        assert failure == row["first_failure_residue"]
        assert p ** (depth + 1) == row["first_failure_modulus"]
        assert row["is_super_wieferich"] == (depth >= 3)
        assert row["order_is_odd"] == (order % 2 == 1)

    assert data["summary"]["wieferich_primes"] == hits
    assert data["summary"]["super_wieferich_primes"] == [
        row["prime"] for row in rows if row["canonical_depth"] >= 3
    ]
    assert data["summary"]["odd_exact_order_hits"] == [
        row["prime"] for row in rows if row["exact_order"] % 2 == 1
    ]
    return {
        "status": "pass",
        "input": path.name,
        "limit": limit,
        "prime_count": prime_count,
        "wieferich_hits": hits,
        "super_wieferich_hits": data["summary"]["super_wieferich_primes"],
        "finite_only": True,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    result = verify(args.input)
    args.output.write_text(
        json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(json.dumps(result, sort_keys=True))


if __name__ == "__main__":
    main()
