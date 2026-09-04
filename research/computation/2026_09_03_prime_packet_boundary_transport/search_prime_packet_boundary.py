#!/usr/bin/env python3
"""Exact finite audit of Prime-Packet Boundary Transport (PBT).

The optimization is performed in the multiplicative model.  A source
attached to p^e has capacity p^(e-1), a sink attached to q has item q, and
the exponential of the total logarithmic residual is

    product_i max(capacity_i / packet_product_i, 1).

Dynamic programming enumerates every assignment after replacing each packet
product by min(packet_product, capacity).  All optimizer choices, identities,
ratio threshold tests, and ratio-grid cells use exact Python integers.  Decimal
logarithms are emitted only as diagnostics after the exact choices are fixed.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import itertools
import json
import math
from collections import Counter
from decimal import Decimal, localcontext
from fractions import Fraction
from pathlib import Path
from typing import Dict, Iterable, List, Optional, Sequence, Tuple


Factorization = Tuple[Tuple[int, int], ...]
Source = Tuple[int, int, int]  # prime, endpoint exponent, p^(exponent-1)
State = Tuple[int, ...]
Owners = Tuple[int, ...]  # -1 means unused; otherwise a source index


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


def primes_up_to(limit: int) -> List[int]:
    if limit < 2:
        return []
    sieve = bytearray(b"\x01") * (limit + 1)
    sieve[0:2] = b"\x00\x00"
    for p in range(2, math.isqrt(limit) + 1):
        if sieve[p]:
            sieve[p * p : limit + 1 : p] = b"\x00" * (
                (limit - p * p) // p + 1
            )
    return [p for p in range(2, limit + 1) if sieve[p]]


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


def factor_trial(n: int, trial_primes: Sequence[int]) -> Factorization:
    if n < 1:
        raise ValueError("factor_trial requires a positive integer")
    out: List[Tuple[int, int]] = []
    remaining = n
    for p in trial_primes:
        if p * p > remaining:
            break
        if remaining % p == 0:
            e = 0
            while remaining % p == 0:
                remaining //= p
                e += 1
            out.append((p, e))
    if remaining > 1:
        out.append((remaining, 1))
    return tuple(out)


def radical(factors: Factorization) -> int:
    return math.prod(p for p, _ in factors)


def source_packets(factors_c: Factorization) -> Tuple[Source, ...]:
    return tuple((p, e, p ** (e - 1)) for p, e in factors_c if e >= 2)


def sink_primes(factors_a: Factorization, factors_b: Factorization) -> Tuple[int, ...]:
    return tuple(sorted({p for p, _ in factors_a} | {p for p, _ in factors_b}))


def primitive_triples(limit: int) -> Iterable[Tuple[int, int, int]]:
    """One representative a<=b of every positive primitive abc point."""
    for c in range(2, limit + 1):
        for a in range(1, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) == 1:
                yield a, b, c


def packet_optimum(
    sources: Sequence[Source], sinks: Sequence[int]
) -> Tuple[Fraction, Owners, State, int, int]:
    """Return the exact optimum and a deterministic attaining assignment.

    The fourth and fifth return values are the number of distinct final states
    and the sum of layer-state counts.  Equal states retain the lexicographically
    least ownership word, and equal optima choose the least ownership word.
    """
    capacities = tuple(source[2] for source in sources)
    source_product = math.prod(capacities)
    if not capacities:
        return Fraction(1, 1), tuple(-1 for _ in sinks), tuple(), 1, len(sinks) + 1
    if len(capacities) == 1:
        packet_product = math.prod(sinks)
        capped = min(packet_product, capacities[0])
        return (
            Fraction(capacities[0], capped),
            tuple(0 for _ in sinks),
            (capped,),
            1,
            len(sinks) + 1,
        )

    initial = tuple(1 for _ in capacities)
    dp: Dict[State, Owners] = {initial: tuple()}
    state_layers = 1
    for q in sinks:
        nxt: Dict[State, Owners] = {}
        for state, owners in dp.items():
            candidates = [(-1, state)]
            for i, capacity in enumerate(capacities):
                changed = list(state)
                changed[i] = min(capacity, changed[i] * q)
                candidates.append((i, tuple(changed)))
            for owner, new_state in candidates:
                word = owners + (owner,)
                old = nxt.get(new_state)
                if old is None or word < old:
                    nxt[new_state] = word
        dp = nxt
        state_layers += len(dp)

    best_reward = max(math.prod(state) for state in dp)
    best_words = [
        (owners, state)
        for state, owners in dp.items()
        if math.prod(state) == best_reward
    ]
    owners, state = min(best_words)
    residual = Fraction(source_product, best_reward)
    return residual, owners, state, len(dp), state_layers


def brute_packet_optimum(
    capacities: Sequence[int], sinks: Sequence[int]
) -> Fraction:
    best_reward = 0
    for owners in itertools.product(range(-1, len(capacities)), repeat=len(sinks)):
        products = [1 for _ in capacities]
        for q, owner in zip(sinks, owners):
            if owner >= 0:
                products[owner] *= q
        reward = math.prod(min(capacity, product) for capacity, product in zip(capacities, products))
        best_reward = max(best_reward, reward)
    return Fraction(math.prod(capacities), best_reward)


def run_optimizer_regressions() -> None:
    examples = [
        (((2, 2, 2), (3, 2, 3)), (5,)),
        (((2, 3, 4), (3, 3, 9)), (2, 3, 5)),
        (((2, 4, 8), (3, 3, 9), (5, 2, 5)), (2, 7, 11)),
    ]
    for sources, sinks in examples:
        dynamic, _, _, _, _ = packet_optimum(sources, sinks)
        brute = brute_packet_optimum(tuple(s[2] for s in sources), sinks)
        assert dynamic == brute
    # The multiplicative counterpart of the two-bin/one-item noncollapse.
    residual, _, _, _, _ = packet_optimum(((2, 2, 2), (3, 2, 2)), (3,))
    assert residual == 2


def fraction_json(value: Fraction) -> Dict[str, int]:
    return {"numerator": value.numerator, "denominator": value.denominator}


def factor_json(factors: Factorization) -> List[List[int]]:
    return [[p, e] for p, e in factors]


def decimal_log_ratio(residual: Fraction, conductor: int) -> str:
    if residual == 1:
        return "0"
    with localcontext() as ctx:
        ctx.prec = 60
        numerator = Decimal(residual.numerator).ln() - Decimal(residual.denominator).ln()
        denominator = Decimal(conductor).ln()
        return format(numerator / denominator, ".40f")


def exact_ratio_ge(residual: Fraction, conductor: int, num: int, den: int) -> bool:
    """Exactly test log(residual)/log(conductor) >= num/den."""
    if num < 0 or den <= 0 or conductor <= 1 or residual < 1:
        raise ValueError("invalid exact logarithmic-ratio comparison")
    return (
        residual.numerator**den
        >= residual.denominator**den * conductor**num
    )


def exact_ratio_floor(
    residual: Fraction, conductor: int, grid_denominator: int
) -> int:
    """Exact floor of grid_denominator*log(residual)/log(conductor).

    Decimal arithmetic supplies only an initial guess.  The returned integer
    is corrected and certified solely by exact power comparisons.
    """
    if residual == 1:
        return 0
    with localcontext() as ctx:
        ctx.prec = 60
        guess = int(
            (
                (Decimal(residual.numerator).ln() - Decimal(residual.denominator).ln())
                / Decimal(conductor).ln()
                * Decimal(grid_denominator)
            )
        )
    k = max(0, guess)
    while k > 0 and not exact_ratio_ge(residual, conductor, k, grid_denominator):
        k -= 1
    while exact_ratio_ge(residual, conductor, k + 1, grid_denominator):
        k += 1
    assert exact_ratio_ge(residual, conductor, k, grid_denominator)
    assert not exact_ratio_ge(residual, conductor, k + 1, grid_denominator)
    return k


def is_square(n: int) -> bool:
    root = math.isqrt(n)
    return root * root == n


def is_prime_power_factorization(factors: Factorization) -> bool:
    return len(factors) == 1 and factors[0][1] >= 2


def point_core_data(
    a: int,
    b: int,
    c: int,
    factors_a: Factorization,
    factors_b: Factorization,
    factors_c: Factorization,
) -> Dict[str, object]:
    sources = source_packets(factors_c)
    sinks = sink_primes(factors_a, factors_b)
    rad_a = radical(factors_a)
    rad_b = radical(factors_b)
    rad_c = radical(factors_c)
    external = rad_a * rad_b
    conductor = external * rad_c
    core = c // rad_c
    assert math.gcd(a, b) == 1 and a + b == c
    assert core == math.prod(source[2] for source in sources)
    assert conductor == radical(factors_a) * radical(factors_b) * radical(factors_c)
    residual, owners, capped_state, final_states, state_layers = packet_optimum(sources, sinks)
    scalar = Fraction(core, external) if core > external else Fraction(1, 1)
    assert residual >= scalar

    packet_products = [1 for _ in sources]
    unused: List[int] = []
    for q, owner in zip(sinks, owners):
        if owner < 0:
            unused.append(q)
        else:
            packet_products[owner] *= q
    recomputed_state = tuple(
        min(source[2], packet_product)
        for source, packet_product in zip(sources, packet_products)
    )
    assert recomputed_state == capped_state
    local_residuals = tuple(
        Fraction(source[2], capped)
        for source, capped in zip(sources, capped_state)
    )
    assert math.prod(local_residuals, start=Fraction(1, 1)) == residual

    return {
        "abc": (a, b, c),
        "factorizations": (factors_a, factors_b, factors_c),
        "radicals": (rad_a, rad_b, rad_c, conductor),
        "core": core,
        "external": external,
        "sources": sources,
        "sinks": sinks,
        "owners": owners,
        "packet_products": tuple(packet_products),
        "capped_state": capped_state,
        "local_residuals": local_residuals,
        "residual": residual,
        "scalar": scalar,
        "unused": tuple(unused),
        "final_states": final_states,
        "state_layers": state_layers,
    }


def detailed_record(data: Dict[str, object], coarse_denominator: int) -> Dict[str, object]:
    a, b, c = data["abc"]
    fa, fb, fc = data["factorizations"]
    rad_a, rad_b, rad_c, conductor = data["radicals"]
    sources: Tuple[Source, ...] = data["sources"]
    sinks: Tuple[int, ...] = data["sinks"]
    owners: Owners = data["owners"]
    residual: Fraction = data["residual"]
    scalar: Fraction = data["scalar"]
    packet_products: Tuple[int, ...] = data["packet_products"]
    capped_state: State = data["capped_state"]
    local_residuals: Tuple[Fraction, ...] = data["local_residuals"]
    assignments = []
    for q, owner in zip(sinks, owners):
        assignments.append(
            {"sink_prime": q, "owner_prime": None if owner < 0 else sources[owner][0]}
        )
    source_rows = []
    for source, packet_product, capped, local in zip(
        sources, packet_products, capped_state, local_residuals
    ):
        p, e, capacity = source
        source_rows.append(
            {
                "prime": p,
                "endpoint_exponent": e,
                "capacity_product": capacity,
                "assigned_sink_product": packet_product,
                "capped_reward": capped,
                "local_residual_factor": fraction_json(local),
            }
        )
    coarse_floor = exact_ratio_floor(residual, conductor, coarse_denominator)
    return {
        "abc": [a, b, c],
        "factorization": {
            "a": factor_json(fa),
            "b": factor_json(fb),
            "c": factor_json(fc),
        },
        "radicals": {"a": rad_a, "b": rad_b, "c": rad_c, "abc": conductor},
        "endpoint_core": data["core"],
        "external_radical": data["external"],
        "source_packets": source_rows,
        "sink_primes": list(sinks),
        "assignment": assignments,
        "unused_sink_primes": list(data["unused"]),
        "optimal_residual_factor": fraction_json(residual),
        "scalar_positive_defect_factor": fraction_json(scalar),
        "fragmentation_factor_over_scalar": fraction_json(residual / scalar),
        "optimizer_certificate": {
            "final_distinct_capped_states": data["final_states"],
            "sum_of_dynamic_program_state_counts": data["state_layers"],
            "optimal_capped_reward_product": math.prod(capped_state),
            "source_capacity_product": math.prod(source[2] for source in sources),
        },
        "residual_to_conductor_ratio": {
            "diagnostic_decimal": decimal_log_ratio(residual, conductor),
            "exact_coarse_grid_lower_numerator": coarse_floor,
            "exact_coarse_grid_denominator": coarse_denominator,
            "exact_coarse_grid_upper_numerator": coarse_floor + 1,
        },
    }


def categories_for(data: Dict[str, object]) -> Tuple[str, ...]:
    a, b, c = data["abc"]
    fa, fb, fc = data["factorizations"]
    sources: Tuple[Source, ...] = data["sources"]
    categories = ["all"]
    if sources:
        categories.append("endpoint_has_powerful_prime")
    else:
        categories.append("endpoint_squarefree")
    if len(sources) >= 2:
        categories.append("multiple_powerful_endpoint_primes")
    if a == 1:
        categories.append("unit_arm")
        if len(fb) == 1 and fb[0][0] == b and fb[0][1] == 1 and len(sources) >= 2:
            categories.append("unit_prime_predecessor_multiple_sources")
    if is_prime_power_factorization(fc):
        categories.append("endpoint_prime_power")
        if fc[0][1] == 2:
            categories.append("endpoint_prime_square")
    if all(p <= 7 for p, _ in fc):
        categories.append("endpoint_7_smooth")
    if is_square(a) and is_square(b) and is_square(c):
        categories.append("pythagorean_square")
    if len(fa) <= 1 and len(fb) <= 1:
        categories.append("two_prime_power_arms")
    return tuple(categories)


def new_category_stats() -> Dict[str, object]:
    return {
        "triples": 0,
        "zero_residual": 0,
        "positive_residual": 0,
        "positive_fragmentation_gap": 0,
        "scalar_defect_zero_but_packet_residual_positive": 0,
        "maximum_exact_coarse_ratio_grid_cell": 0,
        "example_in_maximum_cell": None,
    }


def structured_csv_record(
    family: str,
    parameters: str,
    data: Dict[str, object],
    coarse_denominator: int,
) -> Dict[str, object]:
    a, b, c = data["abc"]
    _, _, factors_c = data["factorizations"]
    sources: Tuple[Source, ...] = data["sources"]
    sinks: Tuple[int, ...] = data["sinks"]
    owners: Owners = data["owners"]
    residual: Fraction = data["residual"]
    scalar: Fraction = data["scalar"]
    conductor = data["radicals"][3]
    assignment = ";".join(
        f"{q}->{sources[owner][0] if owner >= 0 else 'unused'}"
        for q, owner in zip(sinks, owners)
    )
    return {
        "family": family,
        "parameters": parameters,
        "a": a,
        "b": b,
        "c": c,
        "factorization_c": ";".join(f"{p}^{e}" for p, e in factors_c),
        "source_capacities": ";".join(f"{p}:{capacity}" for p, _, capacity in sources),
        "sink_primes": ";".join(str(q) for q in sinks),
        "source_count": len(sources),
        "sink_count": len(sinks),
        "residual_numerator": residual.numerator,
        "residual_denominator": residual.denominator,
        "scalar_numerator": scalar.numerator,
        "scalar_denominator": scalar.denominator,
        "fragmentation_numerator": (residual / scalar).numerator,
        "fragmentation_denominator": (residual / scalar).denominator,
        "conductor": conductor,
        "coarse_ratio_floor": exact_ratio_floor(
            residual, conductor, coarse_denominator
        ),
        "assignment": assignment,
        "assigned_packet_products": ";".join(
            f"{source[0]}:{product}"
            for source, product in zip(sources, data["packet_products"])
        ),
        "optimal_capped_reward_product": math.prod(data["capped_state"]),
        "source_capacity_product": math.prod(source[2] for source in sources),
    }


def structured_rows(
    prime_limit: int,
    smooth_power_limit: int,
    trial_primes: Sequence[int],
    coarse_denominator: int,
) -> List[Dict[str, object]]:
    rows: List[Dict[str, object]] = []
    small_primes = [p for p in trial_primes if p <= prime_limit]

    # The ordered and edge-cost obstruction family; one aggregate source.
    for p in small_primes:
        a, b, c = 1, p * p - 1, p * p
        data = point_core_data(
            a,
            b,
            c,
            tuple(),
            factor_trial(b, trial_primes),
            ((p, 2),),
        )
        rows.append(
            structured_csv_record(
                "unit_prime_square", f"p={p}", data, coarse_denominator
            )
        )

    # Prime-hypotenuse Pythagorean squares; again one aggregate source.
    for m in range(2, math.isqrt(prime_limit) + 2):
        for n in range(1, m):
            if math.gcd(m, n) != 1 or (m - n) % 2 == 0:
                continue
            p = m * m + n * n
            if p > prime_limit:
                continue
            fp = factor_trial(p, trial_primes)
            if fp != ((p, 1),):
                continue
            x = m * m - n * n
            y = 2 * m * n
            a, b, c = sorted((x * x, y * y)) + [p * p]
            data = point_core_data(
                a,
                b,
                c,
                factor_trial(a, trial_primes),
                factor_trial(b, trial_primes),
                ((p, 2),),
            )
            rows.append(
                structured_csv_record(
                    "prime_hypotenuse_pythagorean_square",
                    f"m={m};n={n};p={p}",
                    data,
                    coarse_denominator,
                )
            )

    # Multi-source smooth endpoints c=N^k with the unit arm a=1.
    for base in (6, 10, 12, 18, 30):
        for exponent in range(2, smooth_power_limit + 1):
            c = base**exponent
            if c > 10**12:
                continue
            a, b = 1, c - 1
            data = point_core_data(
                a,
                b,
                c,
                tuple(),
                factor_trial(b, trial_primes),
                factor_trial(c, trial_primes),
            )
            rows.append(
                structured_csv_record(
                    "smooth_power_unit_endpoint",
                    f"base={base};exponent={exponent}",
                    data,
                    coarse_denominator,
                )
            )

    # Small complete-premise representatives of the progression mechanism
    # c = t M_k^2, b=c-1 prime, with M_k the product of the first k primes.
    # The finite search is only a sanity check; existence for all k requires
    # an external prime-in-progressions theorem.
    primorial = 1
    for k, p in enumerate(small_primes[:7], start=1):
        primorial *= p
        if k < 2:
            continue
        modulus = primorial * primorial
        found = None
        for multiplier in range(1, 1001):
            c = multiplier * modulus
            if c > 10**12:
                break
            b = c - 1
            fb = factor_trial(b, trial_primes)
            if fb == ((b, 1),):
                found = (multiplier, b, c, fb)
                break
        if found is None:
            continue
        multiplier, b, c, fb = found
        data = point_core_data(
            1,
            b,
            c,
            tuple(),
            fb,
            factor_trial(c, trial_primes),
        )
        rows.append(
            structured_csv_record(
                "prime_predecessor_square_primorial_sanity",
                f"k={k};M={primorial};multiplier={multiplier};prime={b}",
                data,
                coarse_denominator,
            )
        )
    return rows


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--cmax", type=int, default=3000)
    parser.add_argument("--coarse-ratio-denominator", type=int, default=120)
    parser.add_argument("--fine-ratio-denominator", type=int, default=12000)
    parser.add_argument("--structured-prime-limit", type=int, default=5000)
    parser.add_argument("--smooth-power-limit", type=int, default=8)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--structured-csv", type=Path, required=True)
    args = parser.parse_args()
    if args.cmax < 2:
        raise SystemExit("require cmax >= 2")
    if args.coarse_ratio_denominator <= 0:
        raise SystemExit("require a positive coarse ratio denominator")
    if args.fine_ratio_denominator % args.coarse_ratio_denominator != 0:
        raise SystemExit("fine ratio denominator must be a multiple of coarse")
    if args.structured_prime_limit < 2 or args.smooth_power_limit < 2:
        raise SystemExit("structured limits are too small")

    run_optimizer_regressions()
    spf = smallest_prime_factors(args.cmax)
    factors: List[Factorization] = [tuple() for _ in range(args.cmax + 1)]
    radicals = [1 for _ in range(args.cmax + 1)]
    for n in range(2, args.cmax + 1):
        factors[n] = factor_from_spf(n, spf)
        radicals[n] = radical(factors[n])

    summary = Counter()
    source_count_distribution = Counter()
    sink_count_distribution = Counter()
    threshold_numerators = {
        "1/20": 6,
        "1/15": 8,
        "1/12": 10,
        "1/10": 12,
        "1/8": 15,
        "1/6": 20,
        "1/5": 24,
        "1/4": 30,
        "1/3": 40,
        "1/2": 60,
        "2/3": 80,
        "3/4": 90,
        "1": 120,
    }
    if args.coarse_ratio_denominator != 120:
        threshold_numerators = {}
    threshold_counts = Counter()
    category_stats: Dict[str, Dict[str, object]] = {}
    first_positive_key: Optional[Tuple[int, int, int]] = None
    first_fragmentation_key: Optional[Tuple[int, int, int]] = None
    first_pure_fragmentation_key: Optional[Tuple[int, int, int]] = None
    exact_largest_residual = Fraction(1, 1)
    largest_residual_keys: List[Tuple[int, int, int]] = []
    max_coarse_cell = 0
    max_coarse_keys: List[Tuple[int, int, int]] = []
    point_cache: Dict[Tuple[int, int, int], Dict[str, object]] = {}
    total_final_states = 0
    total_state_layers = 0
    maximum_final_states = 0
    maximum_state_layers = 0
    maximum_state_key: Optional[Tuple[int, int, int]] = None

    for a, b, c in primitive_triples(args.cmax):
        summary["primitive_triples"] += 1
        data = point_core_data(a, b, c, factors[a], factors[b], factors[c])
        residual: Fraction = data["residual"]
        scalar: Fraction = data["scalar"]
        sources: Tuple[Source, ...] = data["sources"]
        sinks: Tuple[int, ...] = data["sinks"]
        conductor = data["radicals"][3]
        source_count_distribution[len(sources)] += 1
        sink_count_distribution[len(sinks)] += 1
        total_final_states += int(data["final_states"])
        total_state_layers += int(data["state_layers"])
        if int(data["state_layers"]) > maximum_state_layers:
            maximum_state_layers = int(data["state_layers"])
            maximum_final_states = int(data["final_states"])
            maximum_state_key = (a, b, c)

        if not sources:
            summary["source_free_points"] += 1
        elif len(sources) == 1:
            summary["one_source_points"] += 1
        else:
            summary["multiple_source_points"] += 1
        if residual == 1:
            summary["zero_optimal_residual"] += 1
        else:
            summary["positive_optimal_residual"] += 1
            if first_positive_key is None:
                first_positive_key = (a, b, c)
        if scalar > 1:
            summary["positive_scalar_defect"] += 1
        if residual > scalar:
            summary["positive_fragmentation_gap"] += 1
            if first_fragmentation_key is None:
                first_fragmentation_key = (a, b, c)
            if scalar == 1:
                summary["scalar_zero_but_packet_positive"] += 1
                if first_pure_fragmentation_key is None:
                    first_pure_fragmentation_key = (a, b, c)
        else:
            summary["packet_optimum_equals_scalar_positive_part"] += 1

        cell = exact_ratio_floor(residual, conductor, args.coarse_ratio_denominator)
        for name, threshold in threshold_numerators.items():
            if cell >= threshold:
                threshold_counts[name] += 1
        key = (a, b, c)
        if cell > max_coarse_cell:
            max_coarse_cell = cell
            max_coarse_keys = [key]
        elif cell == max_coarse_cell and residual > 1:
            max_coarse_keys.append(key)

        if residual > exact_largest_residual:
            exact_largest_residual = residual
            largest_residual_keys = [key]
        elif residual == exact_largest_residual and residual > 1:
            largest_residual_keys.append(key)

        for category in categories_for(data):
            stats = category_stats.setdefault(category, new_category_stats())
            stats["triples"] += 1
            if residual == 1:
                stats["zero_residual"] += 1
            else:
                stats["positive_residual"] += 1
            if residual > scalar:
                stats["positive_fragmentation_gap"] += 1
                if scalar == 1:
                    stats["scalar_defect_zero_but_packet_residual_positive"] += 1
            if cell > stats["maximum_exact_coarse_ratio_grid_cell"]:
                stats["maximum_exact_coarse_ratio_grid_cell"] = cell
                stats["example_in_maximum_cell"] = [a, b, c]

        keep = (
            key in {first_positive_key, first_fragmentation_key, first_pure_fragmentation_key}
            or cell == max_coarse_cell
            or residual == exact_largest_residual
        )
        if keep:
            point_cache[key] = data
        # Discard stale cached extrema after a strict improvement.
        live_keys = set(max_coarse_keys) | set(largest_residual_keys)
        live_keys.update(
            k
            for k in (first_positive_key, first_fragmentation_key, first_pure_fragmentation_key)
            if k is not None
        )
        for stale in tuple(point_cache):
            if stale not in live_keys:
                del point_cache[stale]

    # Refine every member of the globally maximal coarse cell.  A point in a
    # lower coarse cell cannot enter the maximal fine cell because the fine
    # denominator is an integral multiple of the coarse denominator.
    fine_cells: Dict[Tuple[int, int, int], int] = {}
    for key in max_coarse_keys:
        data = point_cache.get(key)
        if data is None:
            a, b, c = key
            data = point_core_data(a, b, c, factors[a], factors[b], factors[c])
            point_cache[key] = data
        fine_cells[key] = exact_ratio_floor(
            data["residual"], data["radicals"][3], args.fine_ratio_denominator
        )
    max_fine_cell = max(fine_cells.values(), default=0)
    max_fine_keys = sorted(key for key, cell in fine_cells.items() if cell == max_fine_cell)

    def get_data(key: Optional[Tuple[int, int, int]]) -> Optional[Dict[str, object]]:
        if key is None:
            return None
        data = point_cache.get(key)
        if data is None:
            a, b, c = key
            data = point_core_data(a, b, c, factors[a], factors[b], factors[c])
            point_cache[key] = data
        return data

    structured_max_c = max(
        10**12,
        args.structured_prime_limit**2,
        max(base**args.smooth_power_limit for base in (6, 10, 12, 18, 30) if base**args.smooth_power_limit <= 10**12),
    )
    trial_primes = primes_up_to(math.isqrt(structured_max_c) + 1)
    family_rows = structured_rows(
        args.structured_prime_limit,
        args.smooth_power_limit,
        trial_primes,
        args.coarse_ratio_denominator,
    )
    family_summary: Dict[str, Dict[str, object]] = {}
    for row in family_rows:
        family = str(row["family"])
        stats = family_summary.setdefault(
            family,
            {
                "rows": 0,
                "zero_residual": 0,
                "positive_residual": 0,
                "maximum_exact_coarse_ratio_grid_cell": 0,
                "example_parameters": None,
            },
        )
        stats["rows"] += 1
        if row["residual_numerator"] == row["residual_denominator"]:
            stats["zero_residual"] += 1
        else:
            stats["positive_residual"] += 1
        if row["coarse_ratio_floor"] > stats["maximum_exact_coarse_ratio_grid_cell"]:
            stats["maximum_exact_coarse_ratio_grid_cell"] = row["coarse_ratio_floor"]
            stats["example_parameters"] = row["parameters"]

    args.structured_csv.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = [
        "family",
        "parameters",
        "a",
        "b",
        "c",
        "factorization_c",
        "source_capacities",
        "sink_primes",
        "source_count",
        "sink_count",
        "residual_numerator",
        "residual_denominator",
        "scalar_numerator",
        "scalar_denominator",
        "fragmentation_numerator",
        "fragmentation_denominator",
        "conductor",
        "coarse_ratio_floor",
        "assignment",
        "assigned_packet_products",
        "optimal_capped_reward_product",
        "source_capacity_product",
    ]
    with args.structured_csv.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames, lineterminator="\n")
        writer.writeheader()
        writer.writerows(family_rows)

    def detail_or_none(key: Optional[Tuple[int, int, int]]) -> Optional[Dict[str, object]]:
        data = get_data(key)
        return None if data is None else detailed_record(data, args.coarse_ratio_denominator)

    max_fine_records = [
        detailed_record(get_data(key), args.coarse_ratio_denominator)
        for key in max_fine_keys[:20]
    ]
    for record, key in zip(max_fine_records, max_fine_keys[:20]):
        record["residual_to_conductor_ratio"]["exact_fine_grid_lower_numerator"] = fine_cells[key]
        record["residual_to_conductor_ratio"]["exact_fine_grid_denominator"] = args.fine_ratio_denominator
        record["residual_to_conductor_ratio"]["exact_fine_grid_upper_numerator"] = fine_cells[key] + 1

    script_sha = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    output = {
        "parameters": {
            "cmax": args.cmax,
            "normalized_scope": "1 <= a <= b, a+b=c, gcd(a,b)=1",
            "coarse_ratio_grid_denominator": args.coarse_ratio_denominator,
            "fine_ratio_grid_denominator": args.fine_ratio_denominator,
            "structured_prime_limit": args.structured_prime_limit,
            "smooth_power_exponent_range": [2, args.smooth_power_limit],
        },
        "script_sha256": script_sha,
        "arithmetic_policy": {
            "factorization_radicals_and_assignments": "exact Python integers",
            "optimizer": "exhaustive dynamic programming on capped integer packet products",
            "ratio_grid_and_threshold_decisions": "exact integer power comparisons",
            "decimal_logs": "60-digit diagnostics only; never used without an exact correction or as a theorem",
        },
        "packet_semantics": {
            "source_capacity": "p^(v_p(c)-1) for each p with v_p(c)>=2",
            "sink_item": "one indivisible prime q for each q|ab",
            "assignment": "each sink is unused or owned by exactly one source",
            "residual_factor": "product over sources of max(capacity/assigned_sink_product,1)",
            "log_residual": "natural logarithm of residual_factor",
        },
        "summary": dict(sorted(summary.items())),
        "source_count_distribution": {str(k): v for k, v in sorted(source_count_distribution.items())},
        "sink_count_distribution": {str(k): v for k, v in sorted(sink_count_distribution.items())},
        "optimizer_work": {
            "sum_final_distinct_states": total_final_states,
            "sum_layer_state_counts": total_state_layers,
            "maximum_layer_state_counts": maximum_state_layers,
            "final_states_at_maximum_layer_case": maximum_final_states,
            "maximum_layer_state_case": list(maximum_state_key) if maximum_state_key else None,
            "brute_force_regressions_passed": True,
        },
        "exact_residual_ratio_audit": {
            "threshold_counts": dict(threshold_counts),
            "global_maximum_coarse_grid_cell": max_coarse_cell,
            "coarse_grid_denominator": args.coarse_ratio_denominator,
            "points_in_global_maximum_coarse_cell": len(max_coarse_keys),
            "global_maximum_fine_grid_cell": max_fine_cell,
            "fine_grid_denominator": args.fine_ratio_denominator,
            "points_in_global_maximum_fine_cell": len(max_fine_keys),
            "certified_global_ratio_enclosure": {
                "lower": f"{max_fine_cell}/{args.fine_ratio_denominator}",
                "upper_strict": f"{max_fine_cell + 1}/{args.fine_ratio_denominator}",
            },
            "cases_in_maximum_fine_cell_first_twenty": max_fine_records,
        },
        "exact_largest_residual_factor": {
            "factor": fraction_json(exact_largest_residual),
            "number_of_cases": len(largest_residual_keys),
            "cases_first_twenty": [
                detailed_record(get_data(key), args.coarse_ratio_denominator)
                for key in sorted(largest_residual_keys)[:20]
            ],
        },
        "first_certificates": {
            "positive_packet_residual": detail_or_none(first_positive_key),
            "positive_fragmentation_gap": detail_or_none(first_fragmentation_key),
            "scalar_defect_zero_but_packet_residual_positive": detail_or_none(first_pure_fragmentation_key),
        },
        "overlapping_category_statistics": category_stats,
        "structured_family_summary": family_summary,
        "structured_family_csv": args.structured_csv.name,
        "claim_discipline": {
            "standard_abc": "not proved or disproved by this computation",
            "PBT_finite_computation": "no finite frequency or growth pattern is used to decide the uniform gate",
            "PBT_global_status": (
                "refuted independently by the complete-premise Linnik family in "
                "ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md"
            ),
            "finite_scope": "all null results remain diagnostics with no asymptotic force",
            "route_policy": "an exact gate is retired only by a complete-premise counterexample family, not by difficulty",
        },
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_bytes(
        (json.dumps(output, indent=2, sort_keys=True) + "\n").encode("utf-8")
    )
    headline = {
        "primitive_triples": summary["primitive_triples"],
        "positive_optimal_residual": summary["positive_optimal_residual"],
        "positive_fragmentation_gap": summary["positive_fragmentation_gap"],
        "scalar_zero_but_packet_positive": summary["scalar_zero_but_packet_positive"],
        "max_coarse_ratio_cell": max_coarse_cell,
        "max_fine_ratio_cell": max_fine_cell,
        "structured_rows": len(family_rows),
        "script_sha256": script_sha,
    }
    print(json.dumps(headline, sort_keys=True, separators=(",", ":")))


if __name__ == "__main__":
    main()
