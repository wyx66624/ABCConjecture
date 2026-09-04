#!/usr/bin/env python3
"""Independent validator for the frozen exact SCRT-0 computation.

This file intentionally does not import the producer.  On the genuinely hard
stratum it enumerates block families recursively and, at each leaf, enumerates
every exclusive sink-owner word directly.  That is independent of the
producer's reachable-union plus capped-state dynamic program.
"""

from __future__ import annotations

import argparse
import csv
import hashlib
import itertools
import json
import math
import subprocess
import sys
import tempfile
from collections import Counter
from decimal import Decimal, localcontext
from fractions import Fraction
from pathlib import Path
from typing import Dict, Iterator, List, Sequence, Tuple

import sympy


Factors = Tuple[Tuple[int, int], ...]
Source = Tuple[int, int, int, int]
Sink = Tuple[int, int, int]
Block = Tuple[int, int]


def spf_table(limit: int) -> List[int]:
    table = list(range(limit + 1))
    if limit >= 1:
        table[1] = 1
    for p in range(2, math.isqrt(limit) + 1):
        if table[p] != p:
            continue
        for n in range(p * p, limit + 1, p):
            if table[n] == n:
                table[n] = p
    return table


def factor_small(n: int, table: Sequence[int]) -> Factors:
    answer = []
    while n != 1:
        p = table[n]
        e = 0
        while n % p == 0:
            n //= p
            e += 1
        answer.append((p, e))
    return tuple(answer)


def factor_large(n: int) -> Factors:
    if n == 1:
        return tuple()
    answer = tuple(sorted((int(p), int(e)) for p, e in sympy.factorint(n).items()))
    assert math.prod(p**e for p, e in answer) == n
    assert all(sympy.isprime(p) for p, _ in answer)
    return answer


def rad(factors: Factors) -> int:
    return math.prod(p for p, _ in factors)


def source_rows(factors: Factors) -> Tuple[Source, ...]:
    return tuple((p, e, p ** (e - 1), p**e) for p, e in factors if e > 1)


def sink_rows(fa: Factors, fb: Factors) -> Tuple[Sink, ...]:
    rows = [(p, p**e, 1) for p, e in fa]
    rows += [(p, 1, p**e) for p, e in fb]
    return tuple(sorted(rows))


def product_for_mask(values: Sequence[int], mask: int) -> int:
    answer = 1
    for i, value in enumerate(values):
        if mask & (1 << i):
            answer *= value
    return answer


def reference_blocks(sources: Sequence[Source], sinks: Sequence[Sink]) -> Tuple[Tuple[Block, ...], Tuple[Block, ...]]:
    compatible = []
    saturated = []
    for smask in range(1, 1 << len(sources)):
        modulus = product_for_mask([row[3] for row in sources], smask)
        demand = product_for_mask([row[2] for row in sources], smask)
        for tmask in range(1, 1 << len(sinks)):
            left = product_for_mask([row[1] for row in sinks], tmask)
            right = product_for_mask([row[2] for row in sinks], tmask)
            if (left + right) % modulus:
                continue
            pair = (smask, tmask)
            compatible.append(pair)
            supply = product_for_mask([row[0] for row in sinks], tmask)
            if demand <= supply:
                saturated.append(pair)
    return tuple(compatible), tuple(saturated)


def direct_boundaries(
    sources: Sequence[Source], sinks: Sequence[Sink], saturated: Sequence[Block]
) -> Dict[str, object]:
    """Enumerate SCRT/FCRT block families and item-owner words directly."""
    scrt_optimum = Fraction(math.prod(row[2] for row in sources), 1)
    fcrt_optimum = scrt_optimum
    pbt_optimum = scrt_optimum
    union_states: set[Tuple[int, int]] = set()
    family_count = 0

    def token_delivery(block: Block, source_index: int) -> Fraction | None:
        smask, tmask = block
        if smask & (1 << source_index):
            return None
        demand = product_for_mask([row[2] for row in sources], smask)
        total_supply = product_for_mask([row[0] for row in sinks], tmask)
        surplus = Fraction(total_supply, demand)
        best = None
        umask = (tmask - 1) & tmask
        while umask:
            left = product_for_mask([row[1] for row in sinks], umask)
            right = product_for_mask([row[2] for row in sinks], umask)
            if (left + right) % sources[source_index][3] == 0:
                subset_supply = Fraction(
                    product_for_mask([row[0] for row in sinks], umask), 1
                )
                delivery = min(surplus, subset_supply)
                if best is None or delivery > best:
                    best = delivery
            umask = (umask - 1) & tmask
        return best

    def visit(start: int, path: Tuple[int, ...], used_s: int, used_t: int) -> None:
        nonlocal scrt_optimum, fcrt_optimum, pbt_optimum, family_count
        family_count += 1
        union_states.add((used_s, used_t))
        free_sources = [i for i in range(len(sources)) if not used_s & (1 << i)]
        free_sinks = [j for j in range(len(sinks)) if not used_t & (1 << j)]
        owner_alphabet = [-1] + free_sources
        for word in itertools.product(owner_alphabet, repeat=len(free_sinks)):
            packets = {i: 1 for i in free_sources}
            for j, owner in zip(free_sinks, word):
                if owner >= 0:
                    packets[owner] *= sinks[j][0]
            residual = Fraction(1, 1)
            for i in free_sources:
                residual *= max(Fraction(sources[i][2], packets[i]), Fraction(1, 1))
            if residual < scrt_optimum:
                scrt_optimum = residual
            if not path and residual < pbt_optimum:
                pbt_optimum = residual

        item_options: List[Tuple[Tuple[int, Fraction], ...]] = []
        for j in free_sinks:
            item_options.append(
                tuple([(-1, Fraction(1, 1))] + [(i, Fraction(sinks[j][0], 1)) for i in free_sources])
            )
        for block_index in path:
            block = saturated[block_index]
            options = [(-1, Fraction(1, 1))]
            for i in free_sources:
                delivery = token_delivery(block, i)
                if delivery is not None:
                    options.append((i, delivery))
            item_options.append(tuple(options))
        for word in itertools.product(*item_options):
            supplies = {i: Fraction(1, 1) for i in free_sources}
            for owner, weight in word:
                if owner >= 0:
                    supplies[owner] *= weight
            residual = Fraction(1, 1)
            for i in free_sources:
                residual *= max(Fraction(sources[i][2], 1) / supplies[i], Fraction(1, 1))
            if residual < fcrt_optimum:
                fcrt_optimum = residual
        for index in range(start, len(saturated)):
            smask, tmask = saturated[index]
            if used_s & smask or used_t & tmask:
                continue
            visit(index + 1, path + (index,), used_s | smask, used_t | tmask)

    visit(0, tuple(), 0, 0)
    return {
        "PBT": pbt_optimum,
        "SCRT": scrt_optimum,
        "FCRT": fcrt_optimum,
        "union_count": len(union_states),
        "family_count": family_count,
    }


def full_reference(a: int, b: int, c: int, fa: Factors, fb: Factors, fc: Factors) -> Dict[str, object]:
    assert a + b == c and math.gcd(a, b) == 1
    sources = source_rows(fc)
    sinks = sink_rows(fa, fb)
    compatible, saturated = reference_blocks(sources, sinks)
    direct = direct_boundaries(sources, sinks, saturated)
    residual = direct["SCRT"]
    core = c // rad(fc)
    external = rad(fa) * rad(fb)
    scalar = Fraction(core, external) if core > external else Fraction(1, 1)
    assert residual >= scalar
    assert scalar <= direct["FCRT"] <= residual <= direct["PBT"]
    return {
        "sources": sources,
        "sinks": sinks,
        "compatible_count": len(compatible),
        "saturated_count": len(saturated),
        "union_count": direct["union_count"],
        "family_count": direct["family_count"],
        "pbt_residual": direct["PBT"],
        "residual": residual,
        "fcrt_residual": direct["FCRT"],
        "scalar": scalar,
        "conductor": external * rad(fc),
    }


def fraction_from_json(row: Dict[str, int]) -> Fraction:
    return Fraction(int(row["numerator"]), int(row["denominator"]))


def exact_ratio_ge(value: Fraction, conductor: int, num: int, den: int) -> bool:
    return value.numerator**den >= value.denominator**den * conductor**num


def grid_floor(value: Fraction, conductor: int, denominator: int) -> int:
    if value == 1:
        return 0
    with localcontext() as ctx:
        ctx.prec = 60
        guess = int(
            (Decimal(value.numerator).ln() - Decimal(value.denominator).ln())
            / Decimal(conductor).ln()
            * denominator
        )
    guess = max(0, guess)
    while guess and not exact_ratio_ge(value, conductor, guess, denominator):
        guess -= 1
    while exact_ratio_ge(value, conductor, guess + 1, denominator):
        guess += 1
    return guess


def triples(cmax: int) -> Iterator[Tuple[int, int, int]]:
    for c in range(2, cmax + 1):
        for a in range(1, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) == 1:
                yield a, b, c


def validate_exhaustive(payload: Dict[str, object]) -> Dict[str, object]:
    frozen = payload["exhaustive_scan"]
    cmax = int(frozen["c_max"])
    denominator = int(payload["parameters"]["ratio_grid_denominator"])
    table = spf_table(cmax)
    factors = [tuple() for _ in range(cmax + 1)]
    for n in range(1, cmax + 1):
        factors[n] = factor_small(n, table)
    counts: Counter[str] = Counter()
    methods: Counter[str] = Counter()
    max_residual = (Fraction(0, 1), None)
    max_fragmentation = (Fraction(0, 1), None)
    max_grid = (-1, None)
    max_fcrt_residual = (Fraction(0, 1), None)
    max_fcrt_fragmentation = (Fraction(0, 1), None)
    max_fcrt_improvement = (Fraction(0, 1), None)
    max_fcrt_grid = (-1, None)
    hard_points = []
    for a, b, c in triples(cmax):
        fa, fb, fc = factors[a], factors[b], factors[c]
        sources = source_rows(fc)
        core = c // rad(fc)
        external = rad(fa) * rad(fb)
        scalar = Fraction(core, external) if core > external else Fraction(1, 1)
        if not sources:
            residual = Fraction(1, 1)
            fcrt_residual = residual
            method = "no_endpoint_sources"
        elif core <= external:
            residual = Fraction(1, 1)
            fcrt_residual = residual
            method = "full_block_saturated_X_le_Y"
        elif len(sources) == 1:
            residual = scalar
            fcrt_residual = residual
            method = "one_source_exact_scalar"
        else:
            reference = full_reference(a, b, c, fa, fb, fc)
            residual = reference["residual"]
            fcrt_residual = reference["fcrt_residual"]
            method = "complete_block_union_plus_exclusive_dp"
            hard_points.append([a, b, c])
        abc = (a, b, c)
        counts["triples"] += 1
        methods[method] += 1
        if sources:
            counts["endpoint_with_source"] += 1
        if len(sources) >= 2:
            counts["endpoint_with_at_least_two_sources"] += 1
        counts["positive_B" if residual > 1 else "zero_B"] += 1
        counts["strict_fragmentation_beyond_scalar" if residual > scalar else "equal_to_scalar"] += 1
        counts["FCRT_positive_B" if fcrt_residual > 1 else "FCRT_zero_B"] += 1
        counts["FCRT_strict_fragmentation_beyond_scalar" if fcrt_residual > scalar else "FCRT_equal_to_scalar"] += 1
        if fcrt_residual < residual:
            counts["FCRT_strict_improvement_over_SCRT"] += 1
        fragmentation = residual / scalar
        fcrt_fragmentation = fcrt_residual / scalar
        fcrt_improvement = residual / fcrt_residual
        if residual > max_residual[0] or (residual == max_residual[0] and (max_residual[1] is None or abc < max_residual[1])):
            max_residual = (residual, abc)
        if fragmentation > max_fragmentation[0] or (fragmentation == max_fragmentation[0] and (max_fragmentation[1] is None or abc < max_fragmentation[1])):
            max_fragmentation = (fragmentation, abc)
        if fcrt_residual > max_fcrt_residual[0] or (fcrt_residual == max_fcrt_residual[0] and (max_fcrt_residual[1] is None or abc < max_fcrt_residual[1])):
            max_fcrt_residual = (fcrt_residual, abc)
        if fcrt_fragmentation > max_fcrt_fragmentation[0] or (fcrt_fragmentation == max_fcrt_fragmentation[0] and (max_fcrt_fragmentation[1] is None or abc < max_fcrt_fragmentation[1])):
            max_fcrt_fragmentation = (fcrt_fragmentation, abc)
        if fcrt_improvement > max_fcrt_improvement[0] or (fcrt_improvement == max_fcrt_improvement[0] and (max_fcrt_improvement[1] is None or abc < max_fcrt_improvement[1])):
            max_fcrt_improvement = (fcrt_improvement, abc)
        cell = grid_floor(residual, external * rad(fc), denominator)
        if cell > max_grid[0] or (cell == max_grid[0] and (max_grid[1] is None or abc < max_grid[1])):
            max_grid = (cell, abc)
        fcrt_cell = grid_floor(fcrt_residual, external * rad(fc), denominator)
        if fcrt_cell > max_fcrt_grid[0] or (fcrt_cell == max_fcrt_grid[0] and (max_fcrt_grid[1] is None or abc < max_fcrt_grid[1])):
            max_fcrt_grid = (fcrt_cell, abc)

    assert dict(sorted(counts.items())) == frozen["counts"]
    assert dict(sorted(methods.items())) == frozen["solution_method_counts"]
    assert fraction_from_json(frozen["largest_exact_residual_factor"]["factor"]) == max_residual[0]
    assert frozen["largest_exact_residual_factor"]["abc"] == list(max_residual[1])
    assert fraction_from_json(frozen["largest_exact_fragmentation_factor"]["factor"]) == max_fragmentation[0]
    assert frozen["largest_exact_fragmentation_factor"]["abc"] == list(max_fragmentation[1])
    grid = frozen["largest_observed_B_over_log_radical_grid_cell"]
    assert grid["lower_numerator"] == max_grid[0]
    assert grid["example"] == list(max_grid[1])
    assert fraction_from_json(frozen["FCRT_largest_exact_residual_factor"]["factor"]) == max_fcrt_residual[0]
    assert frozen["FCRT_largest_exact_residual_factor"]["abc"] == list(max_fcrt_residual[1])
    assert fraction_from_json(frozen["FCRT_largest_exact_fragmentation_factor"]["factor"]) == max_fcrt_fragmentation[0]
    assert frozen["FCRT_largest_exact_fragmentation_factor"]["abc"] == list(max_fcrt_fragmentation[1])
    assert fraction_from_json(frozen["FCRT_largest_improvement_factor_over_SCRT"]["factor"]) == max_fcrt_improvement[0]
    assert frozen["FCRT_largest_improvement_factor_over_SCRT"]["abc"] == list(max_fcrt_improvement[1])
    fcrt_grid = frozen["FCRT_largest_observed_B_over_log_radical_grid_cell"]
    assert fcrt_grid["lower_numerator"] == max_fcrt_grid[0]
    assert fcrt_grid["example"] == list(max_fcrt_grid[1])
    return {"counts": dict(sorted(counts.items())), "hard_points_directly_enumerated": hard_points}


def validate_structured(directory: Path, payload: Dict[str, object]) -> Dict[str, object]:
    csv_path = directory / payload["structured_family_csv"]
    rows = list(csv.DictReader(csv_path.open(encoding="utf-8", newline="")))
    family_counts: Counter[str] = Counter()
    for row in rows:
        a, b, c = int(row["a"]), int(row["b"]), int(row["c"])
        reference = full_reference(a, b, c, factor_large(a), factor_large(b), factor_large(c))
        expected_residual = Fraction(int(row["residual_numerator"]), int(row["residual_denominator"]))
        expected_pbt = Fraction(int(row["pbt_residual_numerator"]), int(row["pbt_residual_denominator"]))
        expected_fcrt = Fraction(int(row["fcrt_residual_numerator"]), int(row["fcrt_residual_denominator"]))
        expected_scalar = Fraction(int(row["scalar_numerator"]), int(row["scalar_denominator"]))
        assert reference["residual"] == expected_residual, (row["family"], row["parameters"])
        assert reference["pbt_residual"] == expected_pbt
        assert reference["fcrt_residual"] == expected_fcrt
        assert reference["scalar"] == expected_scalar
        assert reference["compatible_count"] == int(row["compatible_blocks"])
        assert reference["saturated_count"] == int(row["saturated_blocks"])
        assert reference["union_count"] == int(row["reachable_disjoint_unions"])
        assert reference["family_count"] == int(row["fcrt_block_family_count"])
        family_counts[row["family"]] += 1
    frozen_summary = payload["structured_family_summary"]
    assert {name: int(info["rows"]) for name, info in frozen_summary.items()} == dict(sorted(family_counts.items()))
    return {"rows_directly_enumerated": len(rows), "family_counts": dict(sorted(family_counts.items()))}


def validate_details(payload: Dict[str, object]) -> int:
    for detail in payload["detailed_certificates"]:
        a, b, c = map(int, detail["abc"])
        reference = full_reference(a, b, c, factor_large(a), factor_large(b), factor_large(c))
        assert reference["residual"] == fraction_from_json(detail["optimal_residual_factor_exp_B"])
        assert reference["pbt_residual"] == fraction_from_json(detail["PBT"]["optimal_residual_factor_exp_B"])
        assert reference["fcrt_residual"] == fraction_from_json(detail["FCRT"]["optimal_residual_factor_exp_B"])
        block_info = detail["block_enumeration"]
        assert reference["compatible_count"] == block_info["compatible_count"]
        assert reference["saturated_count"] == block_info["compatible_saturated_count"]
        assert reference["union_count"] == block_info["reachable_pairwise_disjoint_union_count"]
        assert reference["family_count"] == detail["FCRT"]["complete_pairwise_disjoint_block_family_count"]
    return len(payload["detailed_certificates"])


def validate_forced_regressions(payload: Dict[str, object]) -> Dict[str, object]:
    expected = {
        "(1,675,676)": ((1, 675, 676), Fraction(2), Fraction(2), Fraction(26, 15), Fraction(26, 15)),
        "(1,224,225)": ((1, 224, 225), Fraction(3, 2), Fraction(3, 2), Fraction(3, 2), Fraction(15, 14)),
        "(343,625,968)": ((343, 625, 968), Fraction(11, 7), Fraction(11, 7), Fraction(44, 35), Fraction(44, 35)),
        "(1,65024,65025)": ((1, 65024, 65025), Fraction(15, 2), Fraction(3), Fraction(3, 2), Fraction(255, 254)),
    }
    report = {}
    frozen = payload["FCRT_model"]["forced_regressions"]
    for label, (abc, pbt, scrt, fcrt, scalar) in expected.items():
        a, b, c = abc
        reference = full_reference(a, b, c, factor_large(a), factor_large(b), factor_large(c))
        assert reference["pbt_residual"] == pbt
        assert reference["residual"] == scrt
        assert reference["fcrt_residual"] == fcrt
        assert reference["scalar"] == scalar
        assert fraction_from_json(frozen[label]["PBT_exp_B"]) == pbt
        assert fraction_from_json(frozen[label]["SCRT_exp_B"]) == scrt
        assert fraction_from_json(frozen[label]["FCRT_exp_B"]) == fcrt
        assert fraction_from_json(frozen[label]["scalar_exp_Delta"]) == scalar
        report[label] = {
            "PBT_exp_B": str(pbt),
            "SCRT_exp_B": str(scrt),
            "FCRT_exp_B": str(fcrt),
            "scalar_exp_Delta": str(scalar),
        }
    return report


def deterministic_replay(directory: Path, payload: Dict[str, object]) -> Dict[str, str]:
    producer = directory / "search_shared_crt_exact.py"
    original_json = directory / "OUTPUT.json"
    original_csv = directory / payload["structured_family_csv"]
    with tempfile.TemporaryDirectory(prefix="scrt_exact_replay_") as raw:
        temporary = Path(raw)
        output = temporary / "OUTPUT.json"
        structured = temporary / original_csv.name
        subprocess.run(
            [
                sys.executable,
                str(producer),
                "--cmax",
                str(payload["parameters"]["c_max"]),
                "--ratio-grid-denominator",
                str(payload["parameters"]["ratio_grid_denominator"]),
                "--generalized-base-max",
                str(payload["parameters"]["generalized_base_max"]),
                "--generalized-value-max",
                str(payload["parameters"]["generalized_value_max"]),
                "--output",
                str(output),
                "--structured-csv",
                str(structured),
            ],
            check=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            text=True,
        )
        assert output.read_bytes() == original_json.read_bytes()
        assert structured.read_bytes() == original_csv.read_bytes()
    return {
        "OUTPUT.json": hashlib.sha256(original_json.read_bytes()).hexdigest(),
        original_csv.name: hashlib.sha256(original_csv.read_bytes()).hexdigest(),
    }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("--directory", type=Path, required=True)
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    directory = args.directory.resolve()
    payload = json.loads((directory / "OUTPUT.json").read_text(encoding="utf-8"))
    assert payload["schema"] == "scrt_fcrt_exact_audit_v2"
    exhaustive = validate_exhaustive(payload)
    structured = validate_structured(directory, payload)
    details = validate_details(payload)
    regressions = validate_forced_regressions(payload)
    replay = deterministic_replay(directory, payload)
    report = {
        "status": "PASS",
        "independence": "validator does not import producer; direct block-family and owner-word enumeration",
        "exhaustive": exhaustive,
        "structured": structured,
        "detailed_certificates_checked": details,
        "forced_regressions": regressions,
        "deterministic_replay_sha256": replay,
        "logical_scope": "finite exact validation only; no quantified SCRT-0 conclusion",
    }
    print(json.dumps(report, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
