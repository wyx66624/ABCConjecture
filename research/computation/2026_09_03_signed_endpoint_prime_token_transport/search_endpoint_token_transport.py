#!/usr/bin/env python3
"""Deterministic audit for signed endpoint prime-token transport.

All membership, radical, valuation, and inequality checks are exact integer
computations.  Floating-point logarithms are used only to report weights and
rank examples.
"""

from __future__ import annotations

import argparse
import bisect
import hashlib
import json
import math
from pathlib import Path


def smallest_prime_factors(limit: int) -> list[int]:
    spf = list(range(limit + 1))
    if limit >= 1:
        spf[1] = 1
    for p in range(2, math.isqrt(limit) + 1):
        if spf[p] == p:
            for n in range(p * p, limit + 1, p):
                if spf[n] == n:
                    spf[n] = p
    return spf


def factorization(n: int, spf: list[int]) -> dict[int, int]:
    result: dict[int, int] = {}
    while n > 1:
        p = spf[n]
        e = 0
        while n % p == 0:
            n //= p
            e += 1
        result[p] = e
    return result


def radical_from_factors(factors: dict[int, int]) -> int:
    out = 1
    for p in factors:
        out *= p
    return out


def greedy_integral_dominance(source: list[int], sinks: list[int]):
    """Maximum-cardinality threshold matching, prioritizing larger sources."""
    available = sorted(sinks)
    pairs: list[tuple[int, int]] = []
    unmatched: list[int] = []
    for p in sorted(source, reverse=True):
        j = bisect.bisect_left(available, p)
        if j == len(available):
            unmatched.append(p)
        else:
            pairs.append((p, available.pop(j)))
    return pairs, sorted(unmatched), available


def greedy_fractional_dominance(source: list[int], sinks: list[int]):
    """Construct a deterministic feasible flow for the graph p <= q.

    Sources are processed from largest to smallest, and eligible sinks from
    smallest to largest. Each source layer and sink has logarithmic mass. No
    optimality claim for this procedure is used by the audit.
    """
    available = [[q, math.log(q)] for q in sorted(sinks)]
    flow: list[tuple[int, int, float]] = []
    unmatched_mass = 0.0
    for p in sorted(source, reverse=True):
        demand = math.log(p)
        for item in available:
            q, capacity = item
            if q < p or capacity <= 0.0:
                continue
            amount = min(demand, capacity)
            if amount > 0.0:
                flow.append((p, q, amount))
                item[1] -= amount
                demand -= amount
            if demand <= 1e-15:
                demand = 0.0
                break
        unmatched_mass += demand
    unused_capacity = sum(capacity for _, capacity in available)
    return flow, unmatched_mass, unused_capacity


def exact_zero_unmatched_hall(source: list[int], sinks: list[int]) -> bool:
    """Exact Hall test for a zero-unmatched fractional p <= q transport.

    The neighborhoods are nested upper tails.  At a source-prime cutoff p,
    the logarithmic Hall inequality is equivalent to comparing the integer
    products of all source and sink primes at least p.  Repeated source
    primes encode repeated valuation layers.
    """
    for cutoff in set(source):
        source_product = math.prod(p for p in source if p >= cutoff)
        sink_product = math.prod(q for q in sinks if q >= cutoff)
        if source_product > sink_product:
            return False
    return True


def valuation(n: int, p: int) -> int:
    e = 0
    while n % p == 0:
        n //= p
        e += 1
    return e


def point_record(a: int, b: int, c: int, spf: list[int]) -> dict:
    fa = factorization(a, spf)
    fb = factorization(b, spf)
    fc = factorization(c, spf)
    ra = radical_from_factors(fa)
    rb = radical_from_factors(fb)
    rc = radical_from_factors(fc)
    core = c // rc
    external = ra * rb
    total_radical = external * rc
    source = [p for p, e in fc.items() for _ in range(e - 1)]
    sinks = sorted(set(fa) | set(fb))
    pairs, unmatched, unused = greedy_integral_dominance(source, sinks)
    fractional_flow, fractional_unmatched, fractional_unused = (
        greedy_fractional_dominance(source, sinks)
    )
    exact_zero_unmatched = exact_zero_unmatched_hall(source, sinks)
    assert math.gcd(a, b) == 1 and a + b == c
    assert core * rc == c
    assert total_radical == radical_from_factors(
        {**fa, **fb, **fc}
    )
    assert external * c == total_radical * core
    assert all(p <= q for p, q in pairs)
    assert len({q for _, q in pairs}) == len(pairs)
    source_mass = sum(math.log(p) for p in source)
    sink_mass = sum(math.log(q) for q in sinks)
    unmatched_mass = sum(math.log(p) for p in unmatched)
    defect = math.log(core) - math.log(external)
    assert abs(fractional_unmatched - (defect + fractional_unused)) < 1e-9
    assert (fractional_unmatched <= 1e-12) == exact_zero_unmatched
    return {
        "triple": [a, b, c],
        "factorization": {"a": fa, "b": fb, "c": fc},
        "radicals": {"a": ra, "b": rb, "c": rc, "abc": total_radical},
        "endpoint_core": core,
        "external_radical": external,
        "source_tokens": source,
        "sink_tokens": sinks,
        "greedy_pairs": pairs,
        "unmatched_tokens": unmatched,
        "unused_sinks": unused,
        "full_integral_dominance_matching": not unmatched,
        "core_le_external_radical": core <= external,
        "source_mass": source_mass,
        "sink_mass": sink_mass,
        "signed_core_defect": defect,
        "unmatched_mass": unmatched_mass,
        "transport_bound_slack": unmatched_mass - defect,
        "fractional_monotone_flow": fractional_flow,
        "fractional_unmatched_mass": fractional_unmatched,
        "fractional_unused_capacity": fractional_unused,
        "exact_zero_unmatched_hall": exact_zero_unmatched,
        "fractional_accounting_error": (
            fractional_unmatched - defect - fractional_unused
        ),
        "quality": math.log(c) / math.log(total_radical),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=5000)
    parser.add_argument("--lte-k-limit", type=int, default=12)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    spf = smallest_prime_factors(args.limit)
    triples = 0
    exact_identity_failures = 0
    full_integral_failures = 0
    favorable_but_integral_failures = 0
    zero_unmatched_fractional_flows = 0
    first_integral_failure = None
    first_favorable_failure = None
    largest_unmatched_ratio: list[dict] = []

    for c in range(4, args.limit + 1):
        for a in range(2, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) != 1:
                continue
            triples += 1
            rec = point_record(a, b, c, spf)
            if rec["external_radical"] * c != rec["radicals"]["abc"] * rec["endpoint_core"]:
                exact_identity_failures += 1
            if not rec["full_integral_dominance_matching"]:
                full_integral_failures += 1
                if first_integral_failure is None:
                    first_integral_failure = rec
                if rec["core_le_external_radical"]:
                    favorable_but_integral_failures += 1
                    if first_favorable_failure is None:
                        first_favorable_failure = rec
            if rec["exact_zero_unmatched_hall"]:
                zero_unmatched_fractional_flows += 1
            conductor = math.log(rec["radicals"]["abc"])
            ratio = rec["fractional_unmatched_mass"] / conductor
            largest_unmatched_ratio.append({
                "triple": rec["triple"],
                "ratio": ratio,
                "fractional_unmatched_mass": rec["fractional_unmatched_mass"],
                "signed_core_defect": rec["signed_core_defect"],
                "quality": rec["quality"],
            })

    largest_unmatched_ratio.sort(key=lambda x: (-x["ratio"], x["triple"]))

    named = {
        "cardinality_obstruction": point_record(3, 13, 16, spf),
        "threshold_obstruction": point_record(9, 16, 25, spf),
        "positive_core_defect": point_record(5, 27, 32, spf),
    }

    lte_family = []
    for k in range(1, args.lte_k_limit + 1):
        m = 2 * (3**k)
        c = 2**m
        b = c - 1
        v3 = valuation(b, 3)
        assert v3 == k + 1
        core = c // 2
        assert 2 * core * (3**k) > b * (3**k)
        lte_family.append({
            "k": k,
            "m": m,
            "v3_2powm_minus_one": v3,
            "certified_core_over_external_lower_bound": f"> {3**k}/2",
            "certified_log_excess_lower_bound": k * math.log(3) - math.log(2),
            "log_c": m * math.log(2),
        })

    script_bytes = Path(__file__).read_bytes()
    output = {
        "command_parameters": {
            "limit": args.limit,
            "lte_k_limit": args.lte_k_limit,
        },
        "script_sha256": hashlib.sha256(script_bytes).hexdigest(),
        "scope": "normalized primitive nonunit triples 2 <= a <= b, a+b=c",
        "summary": {
            "triples_scanned": triples,
            "exact_identity_failures": exact_identity_failures,
            "full_integral_dominance_matching_failures": full_integral_failures,
            "core_le_external_but_integral_matching_fails": favorable_but_integral_failures,
            "exact_zero_unmatched_fractional_monotone_flows": zero_unmatched_fractional_flows,
        },
        "first_integral_failure": first_integral_failure,
        "first_core_favorable_integral_failure": first_favorable_failure,
        "named_complete_premise_certificates": named,
        "top_twenty_greedy_unmatched_to_conductor_ratios": largest_unmatched_ratio[:20],
        "lte_dyadic_unit_arm_audit": lte_family,
        "floating_point_policy": "logs only report weights/rankings; all identities, valuations, gcds, and inequalities are exact integers",
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    # Write bytes directly so the frozen artifact uses LF on every platform.
    output_bytes = (json.dumps(output, indent=2, sort_keys=True) + "\n").encode("utf-8")
    args.output.write_bytes(output_bytes)
    print(json.dumps(output["summary"], sort_keys=True))
    print("first_integral_failure", first_integral_failure["triple"] if first_integral_failure else None)
    print("first_core_favorable_integral_failure", first_favorable_failure["triple"] if first_favorable_failure else None)
    print("script_sha256", output["script_sha256"])


if __name__ == "__main__":
    main()
