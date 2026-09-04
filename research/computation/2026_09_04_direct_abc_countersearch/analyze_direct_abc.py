from __future__ import annotations

import argparse
import csv
import json
from decimal import Decimal, localcontext
from functools import cmp_to_key
from pathlib import Path
from typing import Any


EPSILONS: tuple[tuple[int, int], ...] = (
    (1, 100),
    (1, 20),
    (1, 10),
    (1, 4),
    (1, 2),
)
TOP_K = 20


def parse_summary(path: Path) -> dict[str, str]:
    result: dict[str, str] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        key, value = line.split("=", 1)
        result[key] = value
    return result


def read_hits(path: Path) -> list[dict[str, int]]:
    wanted = ("a", "b", "c", "rad_a", "rad_b", "rad_c", "radical_abc")
    with path.open(newline="", encoding="utf-8") as handle:
        reader = csv.DictReader(handle)
        if tuple(reader.fieldnames or ()) != wanted:
            raise AssertionError("unexpected ABC_HITS.csv schema")
        rows = [{key: int(value) for key, value in row.items()} for row in reader]
    assert rows == sorted(rows, key=lambda row: (row["c"], row["a"], row["b"]))
    return rows


def factor_trial(n: int) -> dict[int, int]:
    original = n
    factors: dict[int, int] = {}
    p = 2
    while p * p <= n:
        if n % p == 0:
            exponent = 0
            while n % p == 0:
                n //= p
                exponent += 1
            factors[p] = exponent
        p = 3 if p == 2 else p + 2
    if n > 1:
        factors[n] = 1
    product = 1
    for prime, exponent in factors.items():
        product *= prime**exponent
    assert product == original
    return factors


def radical_from_factorization(factors: dict[int, int]) -> int:
    answer = 1
    for prime in factors:
        answer *= prime
    return answer


def decimal_metrics(row: dict[str, int], precision: int) -> tuple[Decimal, tuple[Decimal, ...]]:
    with localcontext() as context:
        context.prec = precision
        h = Decimal(row["c"]).ln()
        r = Decimal(row["radical_abc"]).ln()
        quality = h / r
        excesses = tuple(h - (Decimal(den + num) / Decimal(den)) * r for num, den in EPSILONS)
    return quality, excesses


def ranking(rows: list[dict[str, int]], precision: int, metric_index: int | None) -> list[int]:
    if metric_index is not None:
        num, den = EPSILONS[metric_index]

        def compare(i: int, j: int) -> int:
            left = pow(rows[i]["c"], den) * pow(rows[j]["radical_abc"], den + num)
            right = pow(rows[j]["c"], den) * pow(rows[i]["radical_abc"], den + num)
            if left != right:
                return -1 if left > right else 1
            tie_i = (rows[i]["c"], rows[i]["a"], rows[i]["b"])
            tie_j = (rows[j]["c"], rows[j]["a"], rows[j]["b"])
            return (tie_i > tie_j) - (tie_i < tie_j)

        return sorted(range(len(rows)), key=cmp_to_key(compare))
    decorated: list[tuple[Decimal, int, int, int, int]] = []
    for index, row in enumerate(rows):
        quality, excesses = decimal_metrics(row, precision)
        score = quality if metric_index is None else excesses[metric_index]
        # Descending score; the remaining fields make any exact metric tie deterministic.
        decorated.append((score, -row["c"], -row["a"], -row["b"], index))
    decorated.sort(reverse=True)
    return [item[-1] for item in decorated]


def decorate(row: dict[str, int], precision: int = 120) -> dict[str, Any]:
    quality, excesses = decimal_metrics(row, precision)
    factors = {name: factor_trial(row[name]) for name in ("a", "b", "c")}
    assert row["a"] + row["b"] == row["c"]
    assert __import__("math").gcd(row["a"], row["b"]) == 1
    for name, radical_name in (("a", "rad_a"), ("b", "rad_b"), ("c", "rad_c")):
        assert radical_from_factorization(factors[name]) == row[radical_name]
    assert row["radical_abc"] == row["rad_a"] * row["rad_b"] * row["rad_c"]
    result: dict[str, Any] = {
        **row,
        "factorizations": {
            name: {str(prime): exponent for prime, exponent in factors[name].items()}
            for name in ("a", "b", "c")
        },
        "quality_log_c_over_log_radical": format(quality, ".60f"),
        "epsilon_excesses": {},
    }
    for (num, den), excess in zip(EPSILONS, excesses, strict=True):
        label = f"{num}/{den}"
        result["epsilon_excesses"][label] = {
            "value": format(excess, ".60f"),
            "positive_exactly_iff_c_pow_den_gt_radical_pow_den_plus_num": (
                pow(row["c"], den) > pow(row["radical_abc"], den + num)
            ),
        }
    return result


def main() -> None:
    parser = argparse.ArgumentParser()
    root = Path(__file__).resolve().parent
    parser.add_argument("--hits", type=Path, default=root / "ABC_HITS.csv")
    parser.add_argument("--summary", type=Path, default=root / "SCAN_SUMMARY.txt")
    parser.add_argument("--structured", type=Path, default=root / "STRUCTURED_OUTPUT.json")
    parser.add_argument("--output", type=Path, default=root / "OUTPUT.json")
    args = parser.parse_args()

    summary = parse_summary(args.summary)
    assert summary["status"] == "PASS"
    max_c = int(summary["max_c"])
    primitive_count = int(summary["primitive_triples"])
    rows = read_hits(args.hits)
    assert len(rows) == int(summary["abc_hits_c_gt_radical"])
    assert all(3 <= row["c"] <= max_c and row["c"] > row["radical_abc"] for row in rows)

    quality_order_120 = ranking(rows, 120, None)
    quality_order_180 = ranking(rows, 180, None)
    assert quality_order_120 == quality_order_180
    epsilon_orders: dict[str, list[int]] = {}
    positive_counts: dict[str, int] = {}
    for position, (num, den) in enumerate(EPSILONS):
        label = f"{num}/{den}"
        exact_order = ranking(rows, 120, position)
        epsilon_orders[label] = exact_order
        positive_counts[label] = sum(
            pow(row["c"], den) > pow(row["radical_abc"], den + num) for row in rows
        )
        # This makes the reduction to the c > rad hit list exhaustive for the
        # maximum epsilon excess over the whole scanned domain.
        assert positive_counts[label] > 0

    structured = json.loads(args.structured.read_text(encoding="utf-8"))
    assert structured["status"] == "PASS"
    result = {
        "status": "PASS",
        "scope": {
            "domain": "all unordered primitive positive triples 1 <= a < b, a+b=c",
            "c_range": [3, max_c],
            "primitive_triples": primitive_count,
            "ranking_reduction": (
                "All recorded maxima lie in c>rad(abc). This is exhaustive: a c>rad hit "
                "has quality>1 and beats every non-hit in quality; for each listed positive "
                "epsilon the scan contains an exactly positive excess, while every non-hit "
                "has strictly negative epsilon excess."
            ),
        },
        "exactness": {
            "enumeration_gcd_radicals_and_epsilon_signs": "exact integer arithmetic",
            "fixed_epsilon_excess_ranking": "exact integer cross multiplication",
            "quality_ranking": (
                "Python Decimal logarithms; the complete hit ordering was identical at 120 "
                "and 180 decimal digits; validate_results.py separately certifies every adjacent "
                "comparison with exact-rational atanh-series log intervals"
            ),
            "finite_scope_warning": (
                "A finite hit or non-hit cannot disprove or prove the standard abc conjecture."
            ),
        },
        "abc_hits_c_gt_radical": len(rows),
        "positive_fixed_epsilon_counts": positive_counts,
        "top_standard_quality": [decorate(rows[i]) for i in quality_order_180[:TOP_K]],
        "top_fixed_epsilon_excess": {
            label: [decorate(rows[i]) for i in order[:TOP_K]]
            for label, order in epsilon_orders.items()
        },
        "structured_family_search": structured,
        "conclusion": {
            "rigorous_standard_abc_disproof_found": False,
            "reason": (
                "The computation supplies finitely many triples only; it does not exhibit "
                "one epsilon with unbounded c/rad(abc)^(1+epsilon)."
            ),
        },
    }
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(
        json.dumps(
            {
                "status": "PASS",
                "max_c": max_c,
                "primitive_triples": primitive_count,
                "abc_hits": len(rows),
                "maximum_quality": result["top_standard_quality"][0],
                "positive_fixed_epsilon_counts": positive_counts,
            },
            indent=2,
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()
