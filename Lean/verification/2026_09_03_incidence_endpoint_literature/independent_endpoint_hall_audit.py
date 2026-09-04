#!/usr/bin/env python3
"""Independent exact-integer audit of the endpoint headline counts.

This deliberately does not import the primary search implementation.  It uses
the upper-tail Hall criterion directly for both cardinality matching and
log-weighted fractional feasibility; the latter is compared as integer prime
products, so no floating-point threshold is involved.
"""

from __future__ import annotations

import argparse
import json
import math


EXPECTED_LIMIT = 5000
EXPECTED = {
    "triples_scanned": 3_795_230,
    "exact_identity_failures": 0,
    "full_integral_dominance_matching_failures": 113_086,
    "core_le_external_but_integral_matching_fails": 113_027,
    "exact_zero_unmatched_fractional_monotone_flows": 3_792_836,
}


def smallest_prime_factors(limit: int) -> list[int]:
    spf = list(range(limit + 1))
    if limit >= 1:
        spf[1] = 1
    for prime in range(2, math.isqrt(limit) + 1):
        if spf[prime] != prime:
            continue
        for multiple in range(prime * prime, limit + 1, prime):
            if spf[multiple] == multiple:
                spf[multiple] = prime
    return spf


def factor_data(limit: int) -> tuple[list[tuple[int, ...]], list[tuple[int, ...]], list[int]]:
    spf = smallest_prime_factors(limit)
    supports: list[tuple[int, ...]] = [()] * (limit + 1)
    excesses: list[tuple[int, ...]] = [()] * (limit + 1)
    radicals = [1] * (limit + 1)
    for original in range(2, limit + 1):
        n = original
        support: list[int] = []
        excess: list[int] = []
        radical = 1
        while n > 1:
            prime = spf[n]
            exponent = 0
            while n % prime == 0:
                n //= prime
                exponent += 1
            support.append(prime)
            excess.extend([prime] * (exponent - 1))
            radical *= prime
        supports[original] = tuple(support)
        excesses[original] = tuple(excess)
        radicals[original] = radical
    return supports, excesses, radicals


def integral_hall(source: tuple[int, ...], sinks: tuple[int, ...]) -> bool:
    """Exact Hall test for one-use tokens with edges p -> q iff p <= q."""
    if len(source) > len(sinks):
        return False
    source_descending = sorted(source, reverse=True)
    sink_descending = sorted(sinks, reverse=True)
    return all(p <= q for p, q in zip(source_descending, sink_descending))


def weighted_hall(source: tuple[int, ...], sinks: tuple[int, ...]) -> bool:
    """Exact log-mass Hall test, converted to integer product inequalities."""
    for cutoff in set(source):
        source_product = math.prod(prime for prime in source if prime >= cutoff)
        sink_product = math.prod(prime for prime in sinks if prime >= cutoff)
        if source_product > sink_product:
            return False
    return True


def totient_count(limit: int) -> int:
    phi = list(range(limit + 1))
    for prime in range(2, limit + 1):
        if phi[prime] == prime:
            for multiple in range(prime, limit + 1, prime):
                phi[multiple] -= phi[multiple] // prime
    return sum(phi[c] // 2 - 1 for c in range(4, limit + 1))


def audit(limit: int) -> dict[str, object]:
    supports, excesses, radicals = factor_data(limit)
    triples = 0
    identity_failures = 0
    integral_failures = 0
    favorable_integral_failures = 0
    exact_zero_weighted = 0
    first_integral_failure: list[int] | None = None
    first_favorable_integral_failure: list[int] | None = None

    for c in range(4, limit + 1):
        c_support = supports[c]
        source = excesses[c]
        c_radical = radicals[c]
        core = c // c_radical
        for a in range(2, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) != 1:
                continue
            triples += 1
            sinks = supports[a] + supports[b]
            external = radicals[a] * radicals[b]
            total_radical = external * c_radical
            if external * c != total_radical * core:
                identity_failures += 1
            if not integral_hall(source, sinks):
                integral_failures += 1
                if first_integral_failure is None:
                    first_integral_failure = [a, b, c]
                if core <= external:
                    favorable_integral_failures += 1
                    if first_favorable_integral_failure is None:
                        first_favorable_integral_failure = [a, b, c]
            if weighted_hall(source, sinks):
                exact_zero_weighted += 1

    summary = {
        "triples_scanned": triples,
        "exact_identity_failures": identity_failures,
        "full_integral_dominance_matching_failures": integral_failures,
        "core_le_external_but_integral_matching_fails": favorable_integral_failures,
        "exact_zero_unmatched_fractional_monotone_flows": exact_zero_weighted,
    }
    return {
        "algorithm": "independent exact upper-tail Hall audit",
        "limit": limit,
        "summary": summary,
        "totient_count": totient_count(limit),
        "first_integral_failure": first_integral_failure,
        "first_core_favorable_integral_failure": first_favorable_integral_failure,
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=EXPECTED_LIMIT)
    args = parser.parse_args()
    if args.limit != EXPECTED_LIMIT:
        raise SystemExit(f"checkpoint requires --limit {EXPECTED_LIMIT}")
    result = audit(args.limit)
    if result["summary"] != EXPECTED:
        raise SystemExit(
            f"headline mismatch: observed={result['summary']!r}, expected={EXPECTED!r}"
        )
    if result["totient_count"] != EXPECTED["triples_scanned"]:
        raise SystemExit("totient count disagrees with enumeration")
    if result["first_integral_failure"] != [3, 13, 16]:
        raise SystemExit("first integral failure changed")
    if result["first_core_favorable_integral_failure"] != [3, 13, 16]:
        raise SystemExit("first favorable integral failure changed")
    print(json.dumps(result, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
