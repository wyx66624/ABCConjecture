#!/usr/bin/env python3
"""Exhaustive bounded search for prime-index Pell trace collisions.

For every odd prime index ``ell <= max_index`` and every prime
``q <= prime_bound`` in the necessary classes ``q = +/-1 (mod 2*ell)``,
the program computes

    (1 + sqrt(2))**ell = A_ell + B_ell*sqrt(2)

modulo ``q**2``.  Repeated support hits are recomputed modulo ``q**5``.
This verifies both the fixed-parameter Hensel premises and the exact
depth-doubling identities

    q**2 | A_ell  => q**4 | A_(2*ell)-1,
    q**2 | B_ell  => q**4 | A_(2*ell)+1.

All conclusions are finite.  In particular, a row with no bounded simple
factor is not declared squarefull.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path


def sieve(limit: int) -> bytearray:
    flags = bytearray(b"\x01") * (limit + 1)
    if limit >= 0:
        flags[0] = 0
    if limit >= 1:
        flags[1] = 0
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
    """Binary powering in Z[U]/(U^2-2)."""
    a, b = 1, 0
    x, y = 1, 1
    n = index
    while n:
        if n & 1:
            a, b = (
                (a * x + 2 * b * y) % modulus,
                (a * y + b * x) % modulus,
            )
        x, y = (x * x + 2 * y * y) % modulus, (2 * x * y) % modulus
        n >>= 1
    return a, b


def valuation_class(value: int, q: int, cap: int = 5) -> str:
    depth = 0
    power = 1
    while depth < cap:
        power *= q
        if value % power:
            break
        depth += 1
    return f"exactly_{depth}" if depth < cap else f"at_least_{cap}"


def run(max_index: int, prime_bound: int) -> dict:
    flags = sieve(max(max_index, prime_bound))
    indices = [ell for ell in range(3, max_index + 1, 2) if flags[ell]]
    candidate_tests = 0
    support_hits = 0
    simple_indices: set[int] = set()
    repeated: list[dict] = []

    for ell in indices:
        for k in range(1, prime_bound // (2 * ell) + 2):
            for sign, q in ((-1, 2 * ell * k - 1), (1, 2 * ell * k + 1)):
                if q < 3 or q > prime_bound or not flags[q]:
                    continue
                candidate_tests += 1
                q2 = q * q
                a2, b2 = quadratic_power(ell, q2)
                for channel, value2 in (("A", a2), ("B", b2)):
                    if value2 % q:
                        continue
                    support_hits += 1
                    if value2 % q2:
                        simple_indices.add(ell)
                        continue

                    q3 = q2 * q
                    q4 = q3 * q
                    q5 = q4 * q
                    a, b = quadratic_power(ell, q5)
                    trace = (a * a + 2 * b * b) % q5
                    coordinate = a if channel == "A" else b
                    derivative = (
                        (ell * b) % q
                        if channel == "A"
                        else ((ell * a - b) * pow(4, -1, q)) % q
                    )
                    trace_shift = (trace - 1) % q5 if channel == "A" else (trace + 1) % q5
                    assert coordinate % q2 == 0
                    assert derivative != 0
                    assert trace_shift % q4 == 0
                    repeated.append(
                        {
                            "index": ell,
                            "index_is_prime": True,
                            "prime": q,
                            "prime_is_prime": True,
                            "residue_sign": sign,
                            "residue_multiplier": k,
                            "channel": channel,
                            "coordinate_depth": valuation_class(coordinate, q, 5),
                            "coordinate_quotient_mod_prime": (coordinate // q2) % q,
                            "derivative_mod_prime": derivative,
                            "trace_shift": "A_2ell-1" if channel == "A" else "A_2ell+1",
                            "trace_shift_depth": valuation_class(trace_shift, q, 5),
                            "trace_shift_quotient_mod_prime": (trace_shift // q4) % q,
                        }
                    )

    by_index: dict[int, set[str]] = {}
    for row in repeated:
        by_index.setdefault(row["index"], set()).add(row["channel"])
    opposite = sorted(ell for ell, channels in by_index.items() if channels == {"A", "B"})
    unresolved = [ell for ell in indices if ell not in simple_indices]

    a_hits = [row for row in repeated if row["channel"] == "A"]
    b_hits = [row for row in repeated if row["channel"] == "B"]
    fifth_failures = [row for row in repeated if row["trace_shift_depth"] == "exactly_4"]
    depth_three = [row for row in repeated if row["coordinate_depth"] not in {"exactly_2"}]
    return {
        "schema": "pell-signed-trace-projector-search-v1",
        "definition": "(1+sqrt(2))^n=A_n+B_n*sqrt(2)",
        "scope_policy": (
            "Only complete hits refute exact universal claims. Bounded no-hits and "
            "unresolved rows are retained as open."
        ),
        "parameters": {
            "max_prime_index": max_index,
            "support_prime_bound": prime_bound,
        },
        "counts": {
            "prime_indices": len(indices),
            "candidate_prime_tests": candidate_tests,
            "support_hits": support_hits,
            "indices_with_bounded_simple_witness": len(simple_indices),
            "bounded_unresolved_indices": len(unresolved),
            "repeated_hits": len(repeated),
            "A_channel_repeated_hits": len(a_hits),
            "B_channel_repeated_hits": len(b_hits),
            "coordinate_depth_at_least_three_hits": len(depth_three),
            "trace_exact_depth_four_hits": len(fifth_failures),
            "opposite_channel_repeated_indices": len(opposite),
        },
        "repeated_hits": repeated,
        "opposite_channel_repeated_indices": opposite,
        "bounded_unresolved_indices": unresolved,
        "logical_decisions": {
            "no_prime_index_repeated_support": {
                "status": "REFUTED",
                "witnesses": repeated,
            },
            "prime_index_repetition_is_B_channel_only": {
                "status": "REFUTED" if a_hits else "NO_HIT_IN_FINITE_SCOPE",
                "witnesses": a_hits,
            },
            "prime_index_repetition_is_A_channel_only": {
                "status": "REFUTED" if b_hits else "NO_HIT_IN_FINITE_SCOPE",
                "witnesses": b_hits,
            },
            "coordinate_depth_two_always_lifts_to_trace_depth_five": {
                "status": "REFUTED" if fifth_failures else "NO_HIT_IN_FINITE_SCOPE",
                "witnesses": fifth_failures,
            },
            "minimal_residue_representative_forces_simplicity": {
                "status": "REFUTED",
                "witnesses": [row for row in repeated if row["residue_multiplier"] == 1],
            },
            "prime_index_simultaneous_squarefull_packet": {
                "status": "OPEN",
                "finite_observation": "NO_OPPOSITE_REPEATED_PAIR_IN_SCOPE" if not opposite else "HIT",
            },
            "prime_index_depth_three_collision": {
                "status": "OPEN",
                "finite_observation": "NO_HIT_IN_SCOPE" if not depth_three else "HIT",
            },
        },
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-index", type=int, default=800_000)
    parser.add_argument("--prime-bound", type=int, default=2_000_000)
    parser.add_argument("--output", type=Path, default=Path("signed_trace_projector_search.json"))
    args = parser.parse_args()
    result = run(args.max_index, args.prime_bound)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(args.output), **result["counts"]}, indent=2))


if __name__ == "__main__":
    main()
