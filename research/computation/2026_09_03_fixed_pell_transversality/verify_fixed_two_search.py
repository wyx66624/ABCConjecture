#!/usr/bin/env python3
"""Independent matrix-power replay of fixed_two_search.json."""

from __future__ import annotations

import argparse
import json
from math import isqrt
from pathlib import Path


def primes_up_to(limit: int) -> list[int]:
    flags = bytearray(b"\x01") * (limit + 1)
    flags[:2] = b"\x00\x00"
    for p in range(2, isqrt(limit) + 1):
        if flags[p]:
            for j in range(p * p, limit + 1, p):
                flags[j] = 0
    return [p for p in range(2, limit + 1) if flags[p]]


def matrix_mul(x: tuple[int, int, int, int], y: tuple[int, int, int, int], m: int):
    a, b, c, d = x
    e, f, g, h = y
    return (
        (a * e + b * g) % m,
        (a * f + b * h) % m,
        (c * e + d * g) % m,
        (c * f + d * h) % m,
    )


def matrix_coordinates(index: int, modulus: int) -> tuple[int, int]:
    """First column of [[1,2],[1,1]]^index by binary matrix powering."""
    result = (1, 0, 0, 1)
    base = (1, 2, 1, 1)
    n = index
    while n:
        if n & 1:
            result = matrix_mul(result, base, modulus)
        base = matrix_mul(base, base, modulus)
        n >>= 1
    return result[0], result[2]


def replay(data: dict) -> dict:
    max_index = data["parameters"]["max_prime_index"]
    bound = data["parameters"]["support_prime_bound"]
    primes = primes_up_to(max(max_index, bound))
    prime_set = set(primes)
    indices = [p for p in primes if 3 <= p <= max_index and p % 2]

    tests = 0
    support_hits = 0
    simple_indices: set[int] = set()
    repeated: list[dict] = []
    for ell in indices:
        for k in range(1, bound // (2 * ell) + 2):
            for q in (2 * ell * k - 1, 2 * ell * k + 1):
                if q < 3 or q > bound or q not in prime_set:
                    continue
                tests += 1
                q2, q3 = q * q, q * q * q
                a, b = matrix_coordinates(ell, q3)
                for channel, value in (("A", a), ("B", b)):
                    if value % q:
                        continue
                    support_hits += 1
                    if value % q2:
                        simple_indices.add(ell)
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

    channels: dict[int, set[str]] = {}
    for row in repeated:
        channels.setdefault(row["index"], set()).add(row["channel"])
    opposite = sorted(ell for ell, cs in channels.items() if cs == {"A", "B"})
    unresolved = [ell for ell in indices if ell not in simple_indices]
    expected_counts = {
        "prime_indices": len(indices),
        "candidate_prime_tests": tests,
        "support_hits": support_hits,
        "indices_with_bounded_simple_witness": len(simple_indices),
        "bounded_unresolved_indices": len(unresolved),
        "repeated_hits": len(repeated),
        "depth_at_least_3_hits": sum(r["valuation"] == "at_least_3" for r in repeated),
        "opposite_channel_repeated_indices": len(opposite),
    }
    errors = []
    if data.get("schema") != "fixed-two-pell-transversality-search-v1":
        errors.append("schema mismatch")
    if data.get("counts") != expected_counts:
        errors.append("count mismatch")
    if data.get("repeated_hits") != repeated:
        errors.append("repeated-hit list mismatch")
    if data.get("opposite_channel_repeated_indices") != opposite:
        errors.append("opposite-channel list mismatch")
    if data.get("bounded_unresolved_indices") != unresolved:
        errors.append("unresolved-index list mismatch")
    if 7 not in prime_set or 13 not in prime_set:
        errors.append("basic primality setup failed")
    if not any(r == {"index": 7, "prime": 13, "channel": "B", "valuation": "exactly_2"}
               for r in repeated):
        errors.append("index-seven full-premise repeated-root witness missing")
    return {
        "schema": "fixed-two-pell-transversality-verification-v1",
        "status": "PASS" if not errors else "FAIL",
        "algorithm": "independent 2x2 matrix binary powering",
        "verified_counts": expected_counts,
        "errors": errors,
        "logical_boundary": (
            "The replay decides only the displayed finite rectangle.  Unresolved indices and "
            "support primes above the bound remain open; no abc or global squarefull exclusion follows."
        ),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, default=Path("fixed_two_search.json"))
    parser.add_argument("--output", type=Path, default=Path("fixed_two_verification.json"))
    args = parser.parse_args()
    data = json.loads(args.input.read_text(encoding="utf-8"))
    result = replay(data)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    raise SystemExit(0 if result["status"] == "PASS" else 1)


if __name__ == "__main__":
    main()
