#!/usr/bin/env python3
"""Validate and deterministically replay the frozen PBT computation."""

from __future__ import annotations

import argparse
import csv
import hashlib
import json
import math
import subprocess
import sys
import tempfile
from fractions import Fraction
from pathlib import Path
from typing import Dict, List, Sequence, Tuple


EXPECTED_SUMMARY = {
    "primitive_triples": 1_368_094,
    "positive_optimal_residual": 624,
    "positive_fragmentation_gap": 572,
    "scalar_zero_but_packet_positive": 567,
    "zero_optimal_residual": 1_367_470,
}
EXPECTED_STRUCTURED_ROWS = 1_038
EXPECTED_MAX_COARSE_CELL = 54
EXPECTED_MAX_FINE_CELL = 5_468


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def exact_ratio_ge(residual: Fraction, conductor: int, num: int, den: int) -> bool:
    return residual.numerator**den >= residual.denominator**den * conductor**num


def exact_ratio_floor(residual: Fraction, conductor: int, grid_denominator: int) -> int:
    low = 0
    high = grid_denominator * max(
        1, conductor.bit_length(), residual.numerator.bit_length()
    )
    while low + 1 < high:
        middle = (low + high) // 2
        if exact_ratio_ge(residual, conductor, middle, grid_denominator):
            low = middle
        else:
            high = middle
    return low


def parse_factorization(text: str) -> List[Tuple[int, int]]:
    if not text:
        return []
    return [tuple(map(int, token.split("^"))) for token in text.split(";")]


def parse_key_values(text: str) -> Dict[int, int]:
    if not text:
        return {}
    return {
        int(token.split(":", 1)[0]): int(token.split(":", 1)[1])
        for token in text.split(";")
    }


def parse_assignment(text: str) -> Dict[int, str]:
    if not text:
        return {}
    return {
        int(token.split("->", 1)[0]): token.split("->", 1)[1]
        for token in text.split(";")
    }


def is_prime(n: int) -> bool:
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    p = 3
    while p * p <= n:
        if n % p == 0:
            return False
        p += 2
    return True


def independent_optimum(capacities: Sequence[int], sinks: Sequence[int]) -> Fraction:
    """A validator-side state-set DP, independent of archived assignments."""
    states = {tuple(1 for _ in capacities)}
    for q in sinks:
        next_states = set(states)
        for state in states:
            for i, capacity in enumerate(capacities):
                changed = list(state)
                changed[i] = min(capacity, changed[i] * q)
                next_states.add(tuple(changed))
        states = next_states
    reward = max((math.prod(state) for state in states), default=1)
    return Fraction(math.prod(capacities), reward)


def independent_spf(limit: int) -> List[int]:
    spf = list(range(limit + 1))
    if limit >= 1:
        spf[1] = 1
    p = 2
    while p * p <= limit:
        if spf[p] == p:
            multiple = p * p
            while multiple <= limit:
                if spf[multiple] == multiple:
                    spf[multiple] = p
                multiple += p
        p += 1
    return spf


def independent_factor(n: int, spf: Sequence[int]) -> Tuple[Tuple[int, int], ...]:
    out = []
    while n > 1:
        p = spf[n]
        e = 0
        while n % p == 0:
            n //= p
            e += 1
        out.append((p, e))
    return tuple(out)


def independent_full_scope(cmax: int) -> Dict[str, object]:
    """Recompute every frozen triple without loading or importing producer code."""
    spf = independent_spf(cmax)
    factors = [tuple() for _ in range(cmax + 1)]
    radicals = [1 for _ in range(cmax + 1)]
    for n in range(2, cmax + 1):
        factors[n] = independent_factor(n, spf)
        radicals[n] = math.prod(p for p, _ in factors[n])

    counts = {
        "primitive_triples": 0,
        "positive_optimal_residual": 0,
        "positive_fragmentation_gap": 0,
        "scalar_zero_but_packet_positive": 0,
        "zero_optimal_residual": 0,
    }
    first_positive = None
    first_fragmentation = None
    first_pure_fragmentation = None
    largest_residual = Fraction(1, 1)
    largest_residual_case = None
    max_coarse = 0
    coarse_candidates: List[Tuple[Fraction, int, Tuple[int, int, int]]] = []
    threshold_cells = {name: 0 for name in (
        "1/20", "1/15", "1/12", "1/10", "1/8", "1/6", "1/5",
        "1/4", "1/3", "1/2", "2/3", "3/4", "1"
    )}
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

    for c in range(2, cmax + 1):
        factors_c = factors[c]
        capacities = tuple(p ** (e - 1) for p, e in factors_c if e >= 2)
        core = math.prod(capacities)
        rad_c = radicals[c]
        for a in range(1, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) != 1:
                continue
            counts["primitive_triples"] += 1
            sinks = tuple(sorted(
                {p for p, _ in factors[a]} | {p for p, _ in factors[b]}
            ))
            residual = independent_optimum(capacities, sinks)
            external = radicals[a] * radicals[b]
            scalar = Fraction(core, external) if core > external else Fraction(1, 1)
            assert residual >= scalar
            key = (a, b, c)
            if residual == 1:
                counts["zero_optimal_residual"] += 1
            else:
                counts["positive_optimal_residual"] += 1
                if first_positive is None:
                    first_positive = key
                conductor = external * rad_c
                cell = exact_ratio_floor(residual, conductor, 120)
                for name, threshold in threshold_numerators.items():
                    if cell >= threshold:
                        threshold_cells[name] += 1
                if cell > max_coarse:
                    max_coarse = cell
                    coarse_candidates = [(residual, conductor, key)]
                elif cell == max_coarse:
                    coarse_candidates.append((residual, conductor, key))
            if residual > scalar:
                counts["positive_fragmentation_gap"] += 1
                if first_fragmentation is None:
                    first_fragmentation = key
                if scalar == 1:
                    counts["scalar_zero_but_packet_positive"] += 1
                    if first_pure_fragmentation is None:
                        first_pure_fragmentation = key
            if residual > largest_residual:
                largest_residual = residual
                largest_residual_case = key

    fine_cells = [
        (exact_ratio_floor(residual, conductor, 12000), key)
        for residual, conductor, key in coarse_candidates
    ]
    max_fine = max(cell for cell, _ in fine_cells)
    max_fine_cases = sorted(key for cell, key in fine_cells if cell == max_fine)
    return {
        "counts": counts,
        "first_positive": list(first_positive),
        "first_fragmentation": list(first_fragmentation),
        "first_pure_fragmentation": list(first_pure_fragmentation),
        "largest_residual": [largest_residual.numerator, largest_residual.denominator],
        "largest_residual_case": list(largest_residual_case),
        "max_coarse_cell": max_coarse,
        "max_fine_cell": max_fine,
        "max_fine_cases": [list(key) for key in max_fine_cases],
        "threshold_counts": threshold_cells,
    }


def validate_detail(record: Dict[str, object]) -> None:
    a, b, c = map(int, record["abc"])
    assert 1 <= a <= b and a + b == c and math.gcd(a, b) == 1
    source_rows = record["source_packets"]
    sinks = tuple(map(int, record["sink_primes"]))
    capacities = tuple(int(row["capacity_product"]) for row in source_rows)
    residual_dict = record["optimal_residual_factor"]
    residual = Fraction(
        int(residual_dict["numerator"]), int(residual_dict["denominator"])
    )
    assert independent_optimum(capacities, sinks) == residual
    source_product = math.prod(capacities)
    reward = int(record["optimizer_certificate"]["optimal_capped_reward_product"])
    assert Fraction(source_product, reward) == residual
    conductor = int(record["radicals"]["abc"])
    ratio = record["residual_to_conductor_ratio"]
    coarse_den = int(ratio["exact_coarse_grid_denominator"])
    coarse_floor = int(ratio["exact_coarse_grid_lower_numerator"])
    assert exact_ratio_floor(residual, conductor, coarse_den) == coarse_floor
    if "exact_fine_grid_denominator" in ratio:
        fine_den = int(ratio["exact_fine_grid_denominator"])
        fine_floor = int(ratio["exact_fine_grid_lower_numerator"])
        assert exact_ratio_floor(residual, conductor, fine_den) == fine_floor


def validate_structured_csv(path: Path, coarse_denominator: int) -> int:
    with path.open(encoding="utf-8", newline="") as handle:
        rows = list(csv.DictReader(handle))
    assert len(rows) == EXPECTED_STRUCTURED_ROWS
    for row in rows:
        a, b, c = int(row["a"]), int(row["b"]), int(row["c"])
        assert a + b == c and math.gcd(a, b) == 1 and 1 <= a <= b
        fc = parse_factorization(row["factorization_c"])
        assert math.prod(p**e for p, e in fc) == c
        assert all(is_prime(p) and e >= 1 for p, e in fc)
        expected_capacities = {p: p ** (e - 1) for p, e in fc if e >= 2}
        capacities = parse_key_values(row["source_capacities"])
        assert capacities == expected_capacities
        sinks = tuple(int(q) for q in row["sink_primes"].split(";") if q)
        assert len(sinks) == len(set(sinks)) and all(is_prime(q) for q in sinks)
        assert all((a * b) % q == 0 for q in sinks)
        assignment = parse_assignment(row["assignment"])
        assert set(assignment) == set(sinks)
        assert all(owner == "unused" or int(owner) in capacities for owner in assignment.values())
        packet_products = parse_key_values(row["assigned_packet_products"])
        recomputed_products = {p: 1 for p in capacities}
        for q, owner in assignment.items():
            if owner != "unused":
                recomputed_products[int(owner)] *= q
        assert packet_products == recomputed_products
        reward = math.prod(
            min(capacities[p], recomputed_products[p]) for p in capacities
        )
        assert reward == int(row["optimal_capped_reward_product"])
        assert math.prod(capacities.values()) == int(row["source_capacity_product"])
        residual = Fraction(
            int(row["residual_numerator"]), int(row["residual_denominator"])
        )
        assert Fraction(math.prod(capacities.values()), reward) == residual
        assert independent_optimum(tuple(capacities.values()), sinks) == residual
        scalar = Fraction(int(row["scalar_numerator"]), int(row["scalar_denominator"]))
        fragmentation = Fraction(
            int(row["fragmentation_numerator"]),
            int(row["fragmentation_denominator"]),
        )
        assert residual / scalar == fragmentation
        conductor = int(row["conductor"])
        assert exact_ratio_floor(residual, conductor, coarse_denominator) == int(
            row["coarse_ratio_floor"]
        )
    return len(rows)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--directory", type=Path, default=Path(__file__).parent)
    parser.add_argument("--skip-replay", action="store_true")
    args = parser.parse_args()
    directory = args.directory.resolve()
    producer = directory / "search_prime_packet_boundary.py"
    output_path = directory / "OUTPUT.json"
    csv_path = directory / "STRUCTURED_FAMILIES.csv"
    output = json.loads(output_path.read_text(encoding="utf-8"))

    assert output["script_sha256"] == sha256(producer)
    parameters = output["parameters"]
    assert parameters == {
        "cmax": 3000,
        "coarse_ratio_grid_denominator": 120,
        "fine_ratio_grid_denominator": 12000,
        "normalized_scope": "1 <= a <= b, a+b=c, gcd(a,b)=1",
        "smooth_power_exponent_range": [2, 8],
        "structured_prime_limit": 5000,
    }
    summary = output["summary"]
    assert "refuted independently" in output["claim_discipline"]["PBT_global_status"]
    for key, expected in EXPECTED_SUMMARY.items():
        assert int(summary[key]) == expected
    assert summary["primitive_triples"] == (
        summary["zero_optimal_residual"] + summary["positive_optimal_residual"]
    )
    assert summary["primitive_triples"] == (
        summary["source_free_points"]
        + summary["one_source_points"]
        + summary["multiple_source_points"]
    )
    assert sum(map(int, output["source_count_distribution"].values())) == summary[
        "primitive_triples"
    ]
    assert sum(map(int, output["sink_count_distribution"].values())) == summary[
        "primitive_triples"
    ]

    independent = independent_full_scope(3000)
    assert independent["counts"] == {
        key: int(summary[key]) for key in EXPECTED_SUMMARY
    }
    archived_first = output["first_certificates"]
    assert independent["first_positive"] == archived_first[
        "positive_packet_residual"
    ]["abc"]
    assert independent["first_fragmentation"] == archived_first[
        "positive_fragmentation_gap"
    ]["abc"]
    assert independent["first_pure_fragmentation"] == archived_first[
        "scalar_defect_zero_but_packet_residual_positive"
    ]["abc"]
    archived_largest = output["exact_largest_residual_factor"]
    assert independent["largest_residual"] == [
        archived_largest["factor"]["numerator"],
        archived_largest["factor"]["denominator"],
    ]
    assert independent["largest_residual_case"] == archived_largest[
        "cases_first_twenty"
    ][0]["abc"]

    ratio_audit = output["exact_residual_ratio_audit"]
    assert ratio_audit["global_maximum_coarse_grid_cell"] == EXPECTED_MAX_COARSE_CELL
    assert ratio_audit["global_maximum_fine_grid_cell"] == EXPECTED_MAX_FINE_CELL
    assert independent["max_coarse_cell"] == EXPECTED_MAX_COARSE_CELL
    assert independent["max_fine_cell"] == EXPECTED_MAX_FINE_CELL
    assert independent["max_fine_cases"] == [
        record["abc"]
        for record in ratio_audit["cases_in_maximum_fine_cell_first_twenty"]
    ]
    assert {
        key: value
        for key, value in independent["threshold_counts"].items()
        if value
    } == ratio_audit["threshold_counts"]
    for record in ratio_audit["cases_in_maximum_fine_cell_first_twenty"]:
        validate_detail(record)
    for record in output["exact_largest_residual_factor"]["cases_first_twenty"]:
        validate_detail(record)
    for record in output["first_certificates"].values():
        if record is not None:
            validate_detail(record)

    row_count = validate_structured_csv(csv_path, 120)
    assert sum(
        int(stats["rows"]) for stats in output["structured_family_summary"].values()
    ) == row_count

    replay_stdout = "skipped"
    if not args.skip_replay:
        with tempfile.TemporaryDirectory(prefix="pbt_exact_replay_") as temporary:
            temporary_path = Path(temporary)
            replay_output = temporary_path / "OUTPUT.json"
            replay_csv = temporary_path / "STRUCTURED_FAMILIES.csv"
            command = [
                sys.executable,
                str(producer),
                "--cmax",
                "3000",
                "--coarse-ratio-denominator",
                "120",
                "--fine-ratio-denominator",
                "12000",
                "--structured-prime-limit",
                "5000",
                "--smooth-power-limit",
                "8",
                "--output",
                str(replay_output),
                "--structured-csv",
                str(replay_csv),
            ]
            completed = subprocess.run(
                command,
                check=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                text=True,
                encoding="utf-8",
            )
            assert replay_output.read_bytes() == output_path.read_bytes()
            assert replay_csv.read_bytes() == csv_path.read_bytes()
            replay_stdout = completed.stdout.strip()

    result = {
        "status": "PASS",
        "primitive_triples": summary["primitive_triples"],
        "structured_rows": row_count,
        "output_sha256": sha256(output_path),
        "structured_csv_sha256": sha256(csv_path),
        "producer_sha256": sha256(producer),
        "independent_full_scope": True,
        "deterministic_replay": not args.skip_replay,
        "replay_stdout": replay_stdout,
    }
    print(json.dumps(result, sort_keys=True, separators=(",", ":")))


if __name__ == "__main__":
    main()
