#!/usr/bin/env python3
"""Exact finite audit of radical-excess constraints for synchronized packets.

All membership, divisibility, radical, and power comparisons use Python
integers.  The exhaustive scan contains every normalized primitive triple
2 <= a <= b, a+b=c, c <= limit and every divisor triple satisfying the full
synchronized-packet premises.  No floating-point arithmetic is used.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
from pathlib import Path
from typing import Dict, Iterable, List, Sequence, Tuple


Factorization = Tuple[Tuple[int, int], ...]
Packet = Tuple[int, int, int]


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


def factor_from_spf(n: int, spf: Sequence[int]) -> Factorization:
    out: List[Tuple[int, int]] = []
    while n > 1:
        p = spf[n]
        e = 0
        while n % p == 0:
            n //= p
            e += 1
        out.append((p, e))
    return tuple(out)


def factor_trial(n: int) -> Factorization:
    out: List[Tuple[int, int]] = []
    p = 2
    while p * p <= n:
        if n % p == 0:
            e = 0
            while n % p == 0:
                n //= p
                e += 1
            out.append((p, e))
        p = 3 if p == 2 else p + 2
    if n > 1:
        out.append((n, 1))
    return tuple(out)


def radical(factors: Factorization) -> int:
    out = 1
    for p, _ in factors:
        out *= p
    return out


def divisors(factors: Factorization) -> List[int]:
    out = [1]
    for p, e in factors:
        old = tuple(out)
        power = 1
        for _ in range(e):
            power *= p
            out.extend(d * power for d in old)
    return sorted(out)


def square_gap(r: int, s: int) -> int:
    return abs(r * r - s * s)


def synchronized(a: int, b: int, c: int, x: int, y: int, z: int) -> bool:
    return (
        x > 1
        and y > 1
        and z > 1
        and a % x == 0
        and b % y == 0
        and c % z == 0
        and square_gap(y, z) % a == 0
        and square_gap(x, z) % b == 0
        and square_gap(x, y) % c == 0
    )


def packets_for_factors(
    a: int,
    b: int,
    c: int,
    fa: Factorization,
    fb: Factorization,
    fc: Factorization,
) -> List[Packet]:
    out: List[Packet] = []
    for x in divisors(fa):
        if x == 1:
            continue
        for y in divisors(fb):
            if y == 1:
                continue
            for z in divisors(fc):
                if z > 1 and synchronized(a, b, c, x, y, z):
                    out.append((x, y, z))
    return out


def primitive_triples(limit: int) -> Iterable[Tuple[int, int, int]]:
    for c in range(4, limit + 1):
        for a in range(2, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) == 1:
                yield a, b, c


def packet_record(
    a: int,
    b: int,
    c: int,
    rad_abc: int,
    rad_x: int,
    rad_y: int,
    rad_z: int,
    q: Packet,
) -> Dict[str, object]:
    x, y, z = q
    gaps = (square_gap(y, z), square_gap(x, z), square_gap(x, y))
    gap_product = math.prod(gaps)
    modulus_product = a * b * c
    root = max(y, z) * max(x, z) * max(x, y)
    bound = root * root
    height = max(x, y, z)
    minimum = min(x, y, z)
    coordinate_radical = rad_x * rad_y * rad_z
    assert math.gcd(a, b) == 1 and a + b == c and a > 1 and b > 1
    assert synchronized(a, b, c, x, y, z)
    assert math.gcd(x, y) == math.gcd(x, z) == math.gcd(y, z) == 1
    assert modulus_product > 0 and rad_abc > 0 and modulus_product % rad_abc == 0
    assert gap_product % modulus_product == 0
    assert modulus_product <= gap_product <= bound <= height**6
    assert minimum * root == x * y * z * height
    assert minimum**2 * bound == (x * y * z * height) ** 2
    assert coordinate_radical > 0 and rad_abc % coordinate_radical == 0
    full_bound = max(b, c) ** 2 * max(a, c) ** 2 * max(a, b) ** 2
    assert bound <= full_bound
    excess = modulus_product // rad_abc
    for m, n in ((1, 0), (2, 1), (3, 1), (3, 2), (4, 1)):
        if bound**m <= rad_abc ** (m + n):
            assert excess**m <= rad_abc**n
        if bound**m <= (a * b) ** m * rad_abc ** (m + n):
            assert c**m <= rad_abc ** (m + n)
    return {
        "abc": [a, b, c],
        "packet": [x, y, z],
        "proper": q != (a, b, c),
        "radical": rad_abc,
        "radical_excess": excess,
        "coordinate_radical": coordinate_radical,
        "gaps": list(gaps),
        "synchronization_index": gap_product // modulus_product,
        "pair_max_root": root,
        "pair_max_bound": bound,
        "full_packet_bound": full_bound,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=3000)
    parser.add_argument("--dyadic-limit", type=int, default=20)
    parser.add_argument("--output", type=Path, default=Path("OUTPUT.json"))
    args = parser.parse_args()
    if args.limit < 5 or args.dyadic_limit < 0:
        raise SystemExit("require limit >= 5 and dyadic-limit >= 0")

    spf = smallest_prime_factors(args.limit)
    factors: List[Factorization] = [tuple() for _ in range(args.limit + 1)]
    radicals = [1 for _ in range(args.limit + 1)]
    for n in range(2, args.limit + 1):
        factors[n] = factor_from_spf(n, spf)
        radicals[n] = radical(factors[n])

    triple_count = 0
    packet_count = 0
    proper_count = 0
    first_pointwise_four_thirds_failure = None
    first_pointwise_three_halves_failure = None
    first_compensated_four_thirds_failure = None
    compensated_four_thirds_success_count = 0
    first_proper_support_deficit = None
    first_proper_equal_full_bound = None
    first_exact_gap_not_minimal = None
    first_minimizer_not_exact_when_exact_exists = None
    largest_four_thirds_ratio = None

    for a, b, c in primitive_triples(args.limit):
        triple_count += 1
        fa, fb, fc = factors[a], factors[b], factors[c]
        rad_abc = radicals[a] * radicals[b] * radicals[c]
        modulus_product = a * b * c
        qs = packets_for_factors(a, b, c, fa, fb, fc)
        assert qs and (a, b, c) in qs
        rows: List[Dict[str, object]] = []
        for q in qs:
            x, y, z = q
            row = packet_record(
                a,
                b,
                c,
                rad_abc,
                radicals[x],
                radicals[y],
                radicals[z],
                q,
            )
            rows.append(row)
            packet_count += 1
            if row["proper"]:
                proper_count += 1
                if (
                    row["coordinate_radical"] != rad_abc
                    and first_proper_support_deficit is None
                ):
                    first_proper_support_deficit = row
                if (
                    row["pair_max_bound"] == row["full_packet_bound"]
                    and first_proper_equal_full_bound is None
                ):
                    first_proper_equal_full_bound = row

        min_bound = min(int(row["pair_max_bound"]) for row in rows)
        min_rows = [row for row in rows if row["pair_max_bound"] == min_bound]
        exact_rows = [row for row in rows if row["synchronization_index"] == 1]
        if min_bound**3 > rad_abc**4 and first_pointwise_four_thirds_failure is None:
            first_pointwise_four_thirds_failure = {
                "abc": [a, b, c],
                "radical": rad_abc,
                "radical_excess": modulus_product // rad_abc,
                "minimum_pair_max_bound": min_bound,
                "minimizers": min_rows,
            }
        if min_bound**2 > rad_abc**3 and first_pointwise_three_halves_failure is None:
            first_pointwise_three_halves_failure = {
                "abc": [a, b, c],
                "radical": rad_abc,
                "radical_excess": modulus_product // rad_abc,
                "minimum_pair_max_bound": min_bound,
                "minimizers": min_rows,
            }
        if min_bound**3 <= (a * b) ** 3 * rad_abc**4:
            compensated_four_thirds_success_count += 1
        elif first_compensated_four_thirds_failure is None:
            first_compensated_four_thirds_failure = {
                "abc": [a, b, c],
                "radical": rad_abc,
                "minimum_pair_max_bound": min_bound,
                "left_min_B_cubed": min_bound**3,
                "right_ab_cubed_times_R_fourth": (a * b) ** 3 * rad_abc**4,
                "minimizers": min_rows,
            }
        if exact_rows:
            if (
                any(int(row["pair_max_bound"]) > min_bound for row in exact_rows)
                and first_exact_gap_not_minimal is None
            ):
                first_exact_gap_not_minimal = {
                    "abc": [a, b, c],
                    "minimum_pair_max_bound": min_bound,
                    "exact_gap_packets": exact_rows,
                    "minimizers": min_rows,
                }
            if (
                all(row["synchronization_index"] != 1 for row in min_rows)
                and first_minimizer_not_exact_when_exact_exists is None
            ):
                first_minimizer_not_exact_when_exact_exists = {
                    "abc": [a, b, c],
                    "minimum_pair_max_bound": min_bound,
                    "exact_gap_packets": exact_rows,
                    "minimizers": min_rows,
                }

        ratio = (min_bound**3, rad_abc**4)
        if (
            largest_four_thirds_ratio is None
            or ratio[0] * largest_four_thirds_ratio[1]
            > largest_four_thirds_ratio[0] * ratio[1]
        ):
            largest_four_thirds_ratio = (
                ratio[0],
                ratio[1],
                [a, b, c],
                rad_abc,
                min_bound,
                len(qs),
            )

    dyadic_rows = []
    for k in range(args.dyadic_limit + 1):
        a = 2 ** (k + 4)
        b = 3
        c = a + b
        fa, fb, fc = factor_trial(a), factor_trial(b), factor_trial(c)
        rad_abc = radical(fa) * radical(fb) * radical(fc)
        modulus_product = a * b * c
        assert math.gcd(a, b) == 1 and a + b == c and a > 1 and b > 1
        qs = packets_for_factors(a, b, c, fa, fb, fc)
        assert qs and (a, b, c) in qs
        bounds = []
        for q in qs:
            x, y, z = q
            row = packet_record(
                a,
                b,
                c,
                rad_abc,
                radical(factor_trial(x)),
                radical(factor_trial(y)),
                radical(factor_trial(z)),
                q,
            )
            bounds.append(int(row["pair_max_bound"]))
        excess = modulus_product // rad_abc
        half_arm = 2 ** (k + 3)
        assert rad_abc <= 6 * c
        assert half_arm <= excess
        assert rad_abc < excess**3
        assert all(rad_abc**4 < bound**3 for bound in bounds)
        dyadic_rows.append(
            {
                "k": k,
                "abc": [a, b, c],
                "factorization_c": [list(pair) for pair in fc],
                "radical": rad_abc,
                "radical_upper_bound_6c": 6 * c,
                "radical_excess": excess,
                "half_dyadic_arm": half_arm,
                "packet_count": len(qs),
                "minimum_pair_max_bound": min(bounds),
                "all_packets_fail_B_cubed_le_R_fourth": True,
            }
        )

    output = {
        "parameters": {
            "limit": args.limit,
            "dyadic_k_range": [0, args.dyadic_limit],
        },
        "arithmetic": "exact Python integers only; no floating point",
        "scope": (
            "every normalized primitive nonunit triple 2 <= a <= b, "
            "a+b=c, c<=limit, and every synchronized divisor packet"
        ),
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "primitive_triples_exhausted": triple_count,
        "packets_exhausted": packet_count,
        "proper_packets_exhausted": proper_count,
        "proved_invariants_checked_on_every_packet": {
            "positive_full_premises_and_pairwise_coprimality": True,
            "abc_divides_gap_product": True,
            "abc_le_gapProduct_le_pairMaxBound_le_height_pow_six": True,
            "min_times_pairMaxRoot_eq_xyz_times_height": True,
            "coordinate_radical_divides_abc_radical": True,
            "pairMaxBound_le_fullPacket_pairMaxBound": True,
            "compression_power_implies_radical_excess_power": True,
            "compensated_compression_power_implies_c_power": True,
        },
        "candidate_audit": {
            "pointwise_exists_B_cubed_le_R_fourth_first_counterexample":
                first_pointwise_four_thirds_failure,
            "pointwise_exists_B_squared_le_R_cubed_first_counterexample":
                first_pointwise_three_halves_failure,
            "pointwise_exists_compensated_B_cubed_le_ab_cubed_R_fourth_first_counterexample":
                first_compensated_four_thirds_failure,
            "pointwise_compensated_four_thirds_success_count":
                compensated_four_thirds_success_count,
            "every_proper_packet_has_full_radical_support_first_counterexample":
                first_proper_support_deficit,
            "every_proper_packet_strictly_lowers_full_B_first_counterexample":
                first_proper_equal_full_bound,
            "every_exact_gap_packet_minimizes_B_first_counterexample":
                first_exact_gap_not_minimal,
            "if_exact_gap_exists_some_B_minimizer_is_exact_first_counterexample":
                first_minimizer_not_exact_when_exact_exists,
        },
        "largest_observed_min_B_cubed_over_R_fourth_exact_pair": {
            "numerator": largest_four_thirds_ratio[0],
            "denominator": largest_four_thirds_ratio[1],
            "abc": largest_four_thirds_ratio[2],
            "radical": largest_four_thirds_ratio[3],
            "minimum_pair_max_bound": largest_four_thirds_ratio[4],
            "packet_count": largest_four_thirds_ratio[5],
        },
        "dyadic_family_exact_audit": dyadic_rows,
        "claim_discipline": {
            "four_thirds_packet_gate": (
                "refuted by the proved infinite dyadic family; finite rows are checks"
            ),
            "abc_conjecture": "not proved or disproved",
            "null_search_results": "retained as open; never treated as proofs",
        },
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(output, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    print(json.dumps(output, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
