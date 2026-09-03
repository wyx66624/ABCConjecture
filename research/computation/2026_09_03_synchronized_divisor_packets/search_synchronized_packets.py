#!/usr/bin/env python3
"""Finite audit for synchronized divisor packets of primitive abc triples.

For a positive primitive triple a+b=c and divisors x|a, y|b, z|c with
x,y,z>1, a synchronized packet satisfies

    y^2 == z^2 (mod a),
    x^2 == z^2 (mod b),
    x^2 == y^2 (mod c).

The full packet (a,b,c) is automatic.  This script searches for proper
packets and stress-tests several stronger statements against full premises.
It uses only deterministic integer arithmetic.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
from pathlib import Path
from typing import Dict, Iterable, List, Sequence, Tuple


Factorization = Tuple[Tuple[int, int], ...]


def smallest_prime_factors(limit: int) -> List[int]:
    spf = list(range(limit + 1))
    if limit >= 1:
        spf[1] = 1
    for p in range(2, math.isqrt(limit) + 1):
        if spf[p] == p:
            for n in range(p * p, limit + 1, p):
                if spf[n] == n:
                    spf[n] = p
    return spf


def factor(n: int, spf: Sequence[int]) -> Factorization:
    out: List[Tuple[int, int]] = []
    while n > 1:
        p = spf[n]
        e = 0
        while n % p == 0:
            n //= p
            e += 1
        out.append((p, e))
    return tuple(out)


def radical_from_factorization(factors: Factorization) -> int:
    value = 1
    for p, _ in factors:
        value *= p
    return value


def divisors_from_factorization(factors: Factorization) -> List[int]:
    values = [1]
    for p, e in factors:
        old = list(values)
        power = 1
        for _ in range(e):
            power *= p
            values.extend(d * power for d in old)
    values.sort()
    return values


def square_gap(x: int, y: int) -> int:
    return abs(x * x - y * y)


def synchronized(a: int, b: int, c: int, x: int, y: int, z: int) -> bool:
    return (
        (y * y - z * z) % a == 0
        and (x * x - z * z) % b == 0
        and (x * x - y * y) % c == 0
    )


def canonically_oriented(a: int, b: int, c: int, x: int, y: int, z: int) -> bool:
    """Use the unsquared signs forced by a+b=c on the three opposite arms."""
    return (y - z) % a == 0 and (x - z) % b == 0 and (x + y) % c == 0


def packet_record(a: int, b: int, c: int, x: int, y: int, z: int) -> Dict[str, object]:
    gaps = (square_gap(y, z), square_gap(x, z), square_gap(x, y))
    pair_max_bound = max(y, z) ** 2 * max(x, z) ** 2 * max(x, y) ** 2
    maximum = max(x, y, z)
    modulus_product = a * b * c
    return {
        "abc": [a, b, c],
        "packet": [x, y, z],
        "proper": [x, y, z] != [a, b, c],
        "gaps": list(gaps),
        "gap_product_quotient": math.prod(gaps) // modulus_product,
        "pair_max_bound": pair_max_bound,
        "pair_max_ratio": pair_max_bound / modulus_product,
        "max_power_needed": math.log(modulus_product) / math.log(maximum),
        "cubic_bound_holds": modulus_product <= maximum**3,
        "quartic_bound_holds": modulus_product <= maximum**4,
        "product_square_bound_holds": modulus_product <= (x * y * z) ** 2,
    }


def packets_for_triple(
    a: int,
    b: int,
    c: int,
    factors: Sequence[Factorization],
    stop_after: int | None = None,
) -> List[Tuple[int, int, int]]:
    da = [d for d in divisors_from_factorization(factors[a]) if d > 1]
    db = [d for d in divisors_from_factorization(factors[b]) if d > 1]
    dc = [d for d in divisors_from_factorization(factors[c]) if d > 1]
    out: List[Tuple[int, int, int]] = []
    for x in da:
        for y in db:
            for z in dc:
                if synchronized(a, b, c, x, y, z):
                    out.append((x, y, z))
                    if stop_after is not None and len(out) >= stop_after:
                        return out
    return out


def primitive_triples(limit: int) -> Iterable[Tuple[int, int, int]]:
    for c in range(3, limit + 1):
        for a in range(2, (c // 2) + 1):
            b = c - a
            if a <= b and math.gcd(a, b) == 1:
                yield a, b, c


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=20_000)
    parser.add_argument("--exhaustive", type=int, default=700)
    parser.add_argument("--top-quality", type=int, default=120)
    parser.add_argument("--quality-threshold", type=float, default=1.0)
    parser.add_argument("--family-limit", type=int, default=100_000)
    parser.add_argument("--output", type=Path, default=Path("OUTPUT.json"))
    args = parser.parse_args()
    if not (3 <= args.exhaustive <= args.limit):
        raise SystemExit("require 3 <= exhaustive <= limit")

    spf = smallest_prime_factors(args.limit)
    factors = [tuple() for _ in range(args.limit + 1)]
    radicals = [1 for _ in range(args.limit + 1)]
    for n in range(2, args.limit + 1):
        factors[n] = factor(n, spf)
        radicals[n] = radical_from_factorization(factors[n])

    triples_seen = 0
    quality_rows: List[Tuple[float, int, int, int, int]] = []
    exhaustive_rows: List[Tuple[int, int, int]] = []
    for a, b, c in primitive_triples(args.limit):
        triples_seen += 1
        radical = radicals[a] * radicals[b] * radicals[c]
        quality = math.log(c) / math.log(radical)
        quality_rows.append((quality, a, b, c, radical))
        if c <= args.exhaustive:
            exhaustive_rows.append((a, b, c))

    quality_rows.sort(reverse=True)
    selected = set(exhaustive_rows)
    selected.update((a, b, c) for _, a, b, c, _ in quality_rows[: args.top_quality])
    selected.update(
        (a, b, c)
        for quality, a, b, c, _ in quality_rows
        if quality >= args.quality_threshold
    )

    packet_count = 0
    proper_count = 0
    first_proper = None
    first_cubic_failure = None
    first_quartic_failure = None
    first_product_square_failure = None
    first_canonical_orientation_rigidity_failure = None
    worst_power = None
    top_proper: List[Dict[str, object]] = []
    exact_gap_packets: List[Dict[str, object]] = []
    exhaustive_spectrum_rows: List[Dict[str, object]] = []

    for a, b, c in sorted(selected, key=lambda t: (t[2], t[0])):
        triple_packet_count = 0
        triple_proper_count = 0
        for x, y, z in packets_for_triple(a, b, c, factors):
            triple_packet_count += 1
            packet_count += 1
            row = packet_record(a, b, c, x, y, z)
            if row["proper"]:
                triple_proper_count += 1
                proper_count += 1
                if first_proper is None:
                    first_proper = row
                top_proper.append(row)
                if canonically_oriented(a, b, c, x, y, z):
                    if first_canonical_orientation_rigidity_failure is None:
                        first_canonical_orientation_rigidity_failure = row
            if row["gap_product_quotient"] == 1:
                exact_gap_packets.append(row)
            if not row["cubic_bound_holds"] and first_cubic_failure is None:
                first_cubic_failure = row
            if not row["quartic_bound_holds"] and first_quartic_failure is None:
                first_quartic_failure = row
            if not row["product_square_bound_holds"] and first_product_square_failure is None:
                first_product_square_failure = row
            if worst_power is None or row["max_power_needed"] > worst_power["max_power_needed"]:
                worst_power = row

            gaps = row["gaps"]
            modulus_product = a * b * c
            assert all(g > 0 for g in gaps)
            assert math.prod(gaps) % modulus_product == 0
            assert modulus_product <= (
                max(y, z) ** 2 * max(x, z) ** 2 * max(x, y) ** 2
            )
            assert modulus_product <= max(x, y, z) ** 6

        if c <= args.exhaustive:
            exhaustive_spectrum_rows.append(
                {
                    "abc": [a, b, c],
                    "radical": radicals[a] * radicals[b] * radicals[c],
                    "packet_count": triple_packet_count,
                    "proper_packet_count": triple_proper_count,
                }
            )

    same_support_spectrum_difference = None
    first_by_radical: Dict[int, Dict[str, object]] = {}
    for row in exhaustive_spectrum_rows:
        earlier = first_by_radical.get(row["radical"])
        if earlier is None:
            first_by_radical[row["radical"]] = row
        elif (
            earlier["packet_count"] != row["packet_count"]
            or earlier["proper_packet_count"] != row["proper_packet_count"]
        ):
            same_support_spectrum_difference = [earlier, row]
            break

    family_first_failure = None
    for t in range(2, args.family_limit + 1):
        a = 2 * t + 1
        b = t * (3 * t + 2)
        c = (t + 1) * (3 * t + 1)
        x, y, z = 2 * t + 1, t, t + 1
        ok = (
            a + b == c
            and math.gcd(a, b) == 1
            and a % x == 0
            and b % y == 0
            and c % z == 0
            and synchronized(a, b, c, x, y, z)
            and square_gap(y, z) == a
            and square_gap(x, z) == b
            and square_gap(x, y) == c
        )
        if not ok:
            family_first_failure = t
            break

    top_proper.sort(
        key=lambda row: (
            math.log(row["abc"][2])
            / math.log(
                radicals[row["abc"][0]]
                * radicals[row["abc"][1]]
                * radicals[row["abc"][2]]
            ),
            row["max_power_needed"],
        ),
        reverse=True,
    )

    top_quality = []
    for quality, a, b, c, radical in quality_rows[:20]:
        packets = packets_for_triple(a, b, c, factors)
        prime_logs = [
            math.log(p)
            for n in (a, b, c)
            for p, _ in factors[n]
        ]
        omega = len(prime_logs)
        arithmetic_mean = sum(prime_logs) / omega
        geometric_mean = math.exp(sum(math.log(value) for value in prime_logs) / omega)
        packing_efficiency = geometric_mean / arithmetic_mean
        dgm_quality = math.log(c) / (omega * geometric_mean)
        assert math.isclose(quality, packing_efficiency * dgm_quality, rel_tol=1e-12)
        packet_records = [
            packet_record(a, b, c, x, y, z) for x, y, z in packets
        ]
        min_pair_max_bound = min(row["pair_max_bound"] for row in packet_records)
        synchronization_energy = math.log(min_pair_max_bound) / math.log(radical)
        assert quality <= synchronization_energy + 1e-12
        top_quality.append(
            {
                "abc": [a, b, c],
                "radical": radical,
                "standard_quality": quality,
                "omega": omega,
                "packing_efficiency_eta": packing_efficiency,
                "dgm_quality": dgm_quality,
                "eta_times_dgm_quality": packing_efficiency * dgm_quality,
                "packet_count": len(packets),
                "proper_packet_count": sum((x, y, z) != (a, b, c) for x, y, z in packets),
                "minimum_pair_max_bound": min_pair_max_bound,
                "minimum_synchronization_energy": synchronization_energy,
            }
        )

    script_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    output = {
        "parameters": {
            "limit": args.limit,
            "exhaustive": args.exhaustive,
            "top_quality": args.top_quality,
            "quality_threshold": args.quality_threshold,
            "family_limit": args.family_limit,
        },
        "script_sha256": script_hash,
        "primitive_triples_scanned": triples_seen,
        "triples_packet_enumerated": len(selected),
        "packets_found": packet_count,
        "proper_packets_found": proper_count,
        "candidate_audit": {
            "corner_uniqueness_first_counterexample": first_proper,
            "cubic_bound_first_counterexample": first_cubic_failure,
            "quartic_bound_first_counterexample": first_quartic_failure,
            "product_square_bound_first_counterexample": first_product_square_failure,
            "canonical_orientation_rigidity_first_counterexample":
                first_canonical_orientation_rigidity_failure,
            "proved_pair_max_and_sixth_power_bounds_checked": True,
        },
        "exact_gap_packet_count": len(exact_gap_packets),
        "first_exact_gap_packets": exact_gap_packets[:20],
        "same_prime_support_different_packet_spectrum":
            same_support_spectrum_difference,
        "explicit_family": {
            "formula": ["2*t+1", "t*(3*t+2)", "(t+1)*(3*t+1)"],
            "packet": ["2*t+1", "t", "t+1"],
            "checked_t_range": [2, args.family_limit],
            "first_failure": family_first_failure,
        },
        "worst_observed_max_power_needed": worst_power,
        "highest_quality_triples": top_quality,
        "highest_quality_proper_packets": top_proper[:20],
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(output, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(output, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
