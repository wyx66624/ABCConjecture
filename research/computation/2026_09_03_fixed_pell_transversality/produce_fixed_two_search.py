#!/usr/bin/env python3
"""Bounded counterexample search for the fixed-T=2 Pell displacement gate.

The search is deliberately finite.  It enumerates every odd prime index
ell <= max_index and every prime q <= prime_bound in the necessary residue
classes q = +/-1 (mod 2*ell).  It then computes

    (1 + sqrt(2))**ell = A_ell + B_ell*sqrt(2)

modulo q**3.  A q**2 hit is exactly a zero first displacement at the
already-proved transverse support root; a q**3 hit is a zero second
displacement.  Absence outside the finite rectangle is never inferred.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path


def sieve(limit: int) -> bytearray:
    flags = bytearray(b"\x01") * (limit + 1)
    flags[:2] = b"\x00\x00"
    p = 2
    while p * p <= limit:
        if flags[p]:
            start = p * p
            flags[start : limit + 1 : p] = b"\x00" * (
                (limit - start) // p + 1
            )
        p += 1
    return flags


def quadratic_power(index: int, modulus: int) -> tuple[int, int]:
    """Binary powering in Z[U]/(U^2-2), returning A_index,B_index."""
    a, b = 1, 0
    x, y = 1, 1
    n = index
    while n:
        if n & 1:
            a, b = (a * x + 2 * b * y) % modulus, (a * y + b * x) % modulus
        x, y = (x * x + 2 * y * y) % modulus, (2 * x * y) % modulus
        n >>= 1
    return a, b


def run(max_index: int, prime_bound: int) -> dict:
    flags = sieve(max(max_index, prime_bound))
    indices = [ell for ell in range(3, max_index + 1, 2) if flags[ell]]
    candidate_tests = 0
    support_hits = 0
    first_simple_by_index: dict[int, dict] = {}
    repeated: list[dict] = []

    for ell in indices:
        for k in range(1, prime_bound // (2 * ell) + 2):
            for q in (2 * ell * k - 1, 2 * ell * k + 1):
                if q < 3 or q > prime_bound or not flags[q]:
                    continue
                candidate_tests += 1
                q2 = q * q
                q3 = q2 * q
                a, b = quadratic_power(ell, q3)
                for channel, value in (("A", a), ("B", b)):
                    if value % q:
                        continue
                    support_hits += 1
                    if value % q2:
                        first_simple_by_index.setdefault(
                            ell, {"index": ell, "prime": q, "channel": channel}
                        )
                    else:
                        repeated.append(
                            {
                                "index": ell,
                                "prime": q,
                                "channel": channel,
                                "valuation": (
                                    "at_least_3" if value % q3 == 0 else "exactly_2"
                                ),
                            }
                        )

    repeated_channels: dict[int, set[str]] = {}
    for row in repeated:
        repeated_channels.setdefault(row["index"], set()).add(row["channel"])
    opposite = sorted(
        ell for ell, channels in repeated_channels.items() if channels == {"A", "B"}
    )
    unresolved = [ell for ell in indices if ell not in first_simple_by_index]

    return {
        "schema": "fixed-two-pell-transversality-search-v1",
        "definition": "(1+sqrt(2))^ell=A_ell+B_ell*sqrt(2)",
        "interpretation": {
            "q2": "zero first Hensel displacement at a transverse support root",
            "q3": "zero second Hensel displacement",
        },
        "parameters": {"max_prime_index": max_index, "support_prime_bound": prime_bound},
        "counts": {
            "prime_indices": len(indices),
            "candidate_prime_tests": candidate_tests,
            "support_hits": support_hits,
            "indices_with_bounded_simple_witness": len(first_simple_by_index),
            "bounded_unresolved_indices": len(unresolved),
            "repeated_hits": len(repeated),
            "depth_at_least_3_hits": sum(
                row["valuation"] == "at_least_3" for row in repeated
            ),
            "opposite_channel_repeated_indices": len(opposite),
        },
        "repeated_hits": repeated,
        "opposite_channel_repeated_indices": opposite,
        "bounded_unresolved_indices": unresolved,
        "logical_decisions": {
            "no_individual_zero_displacement": {
                "status": "REFUTED",
                "witness": {"index": 7, "prime": 13, "channel": "B"},
            },
            "bounded_opposite_channel_pair": {
                "status": "NO_HIT_IN_FINITE_RECTANGLE" if not opposite else "HIT",
                "scope": f"prime ell <= {max_index}, support prime q <= {prime_bound}",
            },
            "fixed_all_support_zero_exclusion": {
                "status": "OPEN",
                "reason": "unresolved rows and support primes above the finite bound remain",
            },
        },
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-index", type=int, default=20_000)
    parser.add_argument("--prime-bound", type=int, default=10_000_000)
    parser.add_argument("--output", type=Path, default=Path("fixed_two_search.json"))
    args = parser.parse_args()
    result = run(args.max_index, args.prime_bound)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(args.output), **result["counts"]}, indent=2))


if __name__ == "__main__":
    main()
