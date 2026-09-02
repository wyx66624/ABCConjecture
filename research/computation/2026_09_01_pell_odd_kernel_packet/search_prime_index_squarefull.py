#!/usr/bin/env python3
"""Search actual prime-index Pell packets for simple prime divisors.

The bounded scan is deliberately one-sided: a returned witness rigorously
excludes squarefullness at that index, while an unresolved index remains open.
For the small certificate range we additionally factor the exact coordinates.
"""

from __future__ import annotations

import argparse
import json
from math import isqrt
from pathlib import Path

from sympy import factorint


def prime_sieve(limit: int) -> bytearray:
    flags = bytearray(b"\x01") * (limit + 1)
    if limit >= 0:
        flags[0] = 0
    if limit >= 1:
        flags[1] = 0
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


def bounded_simple_witness(index: int, bound: int, prime_flags: bytearray):
    """Find the least scanned q=+/-1 mod 2*index with q||A or q||B."""
    for k in range(1, bound // (2 * index) + 2):
        for q in (2 * index * k - 1, 2 * index * k + 1):
            if q < 3 or q > bound or not prime_flags[q]:
                continue
            a, b = pell_pair(index, q * q)
            if a % q == 0 and a % (q * q) != 0:
                return {"index": index, "prime": q, "channel": "A"}
            if b % q == 0 and b % (q * q) != 0:
                return {"index": index, "prime": q, "channel": "B"}
    return None


def bounded_repeated_divisors(index: int, bound: int, prime_flags: bytearray):
    """Exhaust every necessary candidate and return all exponent >= 2 hits."""
    records = []
    tests = 0
    for k in range(1, bound // (2 * index) + 2):
        for q in (2 * index * k - 1, 2 * index * k + 1):
            if q < 3 or q > bound or not prime_flags[q]:
                continue
            tests += 1
            a, b = pell_pair(index, q * q * q)
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


def exact_small_certificate(index: int):
    a, b = pell_pair(index)
    factors_a = {int(p): int(e) for p, e in factorint(a).items()}
    factors_b = {int(p): int(e) for p, e in factorint(b).items()}
    candidates = [
        (p, "A") for p, e in factors_a.items() if e == 1
    ] + [
        (p, "B") for p, e in factors_b.items() if e == 1
    ]
    if not candidates:
        return None
    q, channel = min(candidates)
    coordinate = a if channel == "A" else b
    assert coordinate % q == 0 and coordinate % (q * q) != 0
    return {"index": index, "prime": q, "channel": channel}


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-index", type=int, default=5000)
    parser.add_argument("--trial-prime-bound", type=int, default=2_000_000)
    parser.add_argument("--certificate-max-index", type=int, default=191)
    parser.add_argument("--output", type=Path, default=Path("prime_index_squarefull_search.json"))
    args = parser.parse_args()

    sieve_limit = max(args.max_index, args.trial_prime_bound)
    flags = prime_sieve(sieve_limit)
    indices = [p for p in range(3, args.max_index + 1, 2) if flags[p]]

    bounded_hits = []
    unresolved = []
    for ell in indices:
        hit = bounded_simple_witness(ell, args.trial_prime_bound, flags)
        if hit is None:
            unresolved.append(ell)
        else:
            bounded_hits.append(hit)

    repeated_candidate_tests = 0
    repeated_hits = []
    for ell in indices:
        tests, rows = bounded_repeated_divisors(ell, args.trial_prime_bound, flags)
        repeated_candidate_tests += tests
        repeated_hits.extend(rows)

    certificate_indices = [p for p in indices if p <= args.certificate_max_index]
    exact_witnesses = []
    exact_unresolved = []
    for ell in certificate_indices:
        hit = exact_small_certificate(ell)
        if hit is None:
            exact_unresolved.append(ell)
        else:
            exact_witnesses.append(hit)

    result = {
        "schema": "pell-prime-index-squarefull-search-v1",
        "pell_definition": "(1+sqrt(2))^n=A_n+B_n*sqrt(2)",
        "policy": (
            "A simple-divisor hit excludes squarefullness at that exact index; "
            "an unresolved bounded-search row is not negative evidence."
        ),
        "parameters": {
            "max_index": args.max_index,
            "trial_prime_bound": args.trial_prime_bound,
            "certificate_max_index": args.certificate_max_index,
        },
        "bounded_scan": {
            "prime_index_count": len(indices),
            "hit_count": len(bounded_hits),
            "unresolved_count": len(unresolved),
            "hits": bounded_hits,
            "unresolved_indices": unresolved,
        },
        "bounded_repeated_scan": {
            "candidate_prime_tests": repeated_candidate_tests,
            "repeated_hit_count": len(repeated_hits),
            "depth_three_hit_count": sum(
                row["depth"] == "at_least_3" for row in repeated_hits
            ),
            "hits": repeated_hits,
        },
        "exact_certificate_range": {
            "prime_index_count": len(certificate_indices),
            "witness_count": len(exact_witnesses),
            "unresolved_count": len(exact_unresolved),
            "witnesses": exact_witnesses,
            "unresolved_indices": exact_unresolved,
        },
        "pocklington_certificates": {
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
        },
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "bounded_hits": len(bounded_hits),
        "bounded_unresolved": len(unresolved),
        "bounded_repeated_hits": len(repeated_hits),
        "exact_witnesses": len(exact_witnesses),
        "exact_unresolved": exact_unresolved,
        "output": str(args.output),
    }, indent=2))


if __name__ == "__main__":
    main()
