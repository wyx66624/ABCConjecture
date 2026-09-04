from __future__ import annotations

import csv
import json
import math
from decimal import Decimal, localcontext
from functools import cmp_to_key, lru_cache
from fractions import Fraction
from pathlib import Path
from typing import Any


ROOT = Path(__file__).resolve().parent
EPSILONS = ((1, 100), (1, 20), (1, 10), (1, 4), (1, 2))
EXPECTED_FAMILY_COUNTS = {
    "balanced_two_prime_r_1_12": 12,
    "balancing_pell_square_n_1_14": 14,
    "danilov_hall_orbit_t_0_fully_factored": 1,
    "mersenne_neighbour_n_2_40": 39,
    "named_exact_benchmark_singleton": 1,
    "prime_square_endpoint_p_le_100000": 9592,
    "primitive_pythagorean_squares_m_le_1000": 202861,
    "two_plus_fifteen_power_neighbour_n_1_8": 8,
    "two_power_plus_three_k_0_36": 37,
}


def parse_key_values(path: Path) -> dict[str, str]:
    result: dict[str, str] = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line:
            continue
        key, value = line.split("=", 1)
        result[key] = value
    return result


def radical_trial(n: int) -> int:
    result = 1
    p = 2
    while p * p <= n:
        if n % p == 0:
            result *= p
            while n % p == 0:
                n //= p
        p = 3 if p == 2 else p + 2
    if n > 1:
        result *= n
    return result


def read_hits() -> list[dict[str, int]]:
    with (ROOT / "ABC_HITS.csv").open(newline="", encoding="utf-8") as handle:
        rows = [{key: int(value) for key, value in row.items()} for row in csv.DictReader(handle)]
    assert len(rows) == 419
    assert rows == sorted(rows, key=lambda row: (row["c"], row["a"]))
    for row in rows:
        a, b, c = row["a"], row["b"], row["c"]
        assert 1 <= a < b and a + b == c and 3 <= c <= 100_000
        assert math.gcd(a, b) == 1
        ra, rb, rc = radical_trial(a), radical_trial(b), radical_trial(c)
        assert (ra, rb, rc) == (row["rad_a"], row["rad_b"], row["rad_c"])
        assert ra * rb * rc == row["radical_abc"] < c
    return rows


def score(row: dict[str, Any], epsilon: tuple[int, int] | None) -> Decimal:
    with localcontext() as context:
        context.prec = 220
        h = Decimal(row["c"]).ln()
        r = Decimal(row["radical_abc"]).ln()
        if epsilon is None:
            return h / r
        num, den = epsilon
        return h - Decimal(den + num) * r / Decimal(den)


def ordered(rows: list[dict[str, int]], epsilon: tuple[int, int] | None) -> list[dict[str, int]]:
    if epsilon is not None:
        num, den = epsilon

        def compare(x: dict[str, int], y: dict[str, int]) -> int:
            left = pow(x["c"], den) * pow(y["radical_abc"], den + num)
            right = pow(y["c"], den) * pow(x["radical_abc"], den + num)
            if left != right:
                return -1 if left > right else 1
            tie_x = (x["c"], x["a"], x["b"])
            tie_y = (y["c"], y["a"], y["b"])
            return (tie_x > tie_y) - (tie_x < tie_y)

        return sorted(rows, key=cmp_to_key(compare))
    return sorted(
        rows,
        key=lambda row: (score(row, epsilon), -row["c"], -row["a"], -row["b"]),
        reverse=True,
    )


def abc_projection(row: dict[str, Any]) -> tuple[int, int, int, int]:
    return row["a"], row["b"], row["c"], row["radical_abc"]


def atanh_log_interval(numerator: int, denominator: int, terms: int) -> tuple[Fraction, Fraction]:
    """Rigorous interval for log(numerator/denominator), ratio in [1,2)."""
    assert denominator <= numerator <= 2 * denominator
    z = Fraction(numerator - denominator, numerator + denominator)
    z_squared = z * z
    term = z
    partial = Fraction(0)
    for j in range(terms):
        partial += term / (2 * j + 1)
        term *= z_squared
    lower = 2 * partial
    # The remaining positive series is bounded by replacing every later odd
    # denominator by the first omitted denominator.
    upper = lower + 2 * term / ((2 * terms + 1) * (1 - z_squared))
    return lower, upper


@lru_cache(maxsize=None)
def log_interval(n: int, terms: int = 120) -> tuple[Fraction, Fraction]:
    """Exact-rational enclosure for log(n), based on the atanh series."""
    assert n >= 1
    if n == 1:
        return Fraction(0), Fraction(0)
    exponent = n.bit_length() - 1
    power_two = 1 << exponent
    lower, upper = atanh_log_interval(n, power_two, terms)
    log_two_lower, log_two_upper = atanh_log_interval(2, 1, terms)
    return lower + exponent * log_two_lower, upper + exponent * log_two_upper


def quality_interval(row: dict[str, int]) -> tuple[Fraction, Fraction]:
    h_lower, h_upper = log_interval(row["c"])
    r_lower, r_upper = log_interval(row["radical_abc"])
    assert r_lower > 0
    return h_lower / r_upper, h_upper / r_lower


def certify_complete_quality_order(rows: list[dict[str, int]]) -> None:
    for first, second in zip(rows, rows[1:], strict=False):
        if first["c"] == second["c"] and first["radical_abc"] == second["radical_abc"]:
            # The quality is then exactly equal; the output's integer tuple
            # provides the deterministic secondary ordering.
            assert (first["c"], first["a"], first["b"]) <= (
                second["c"], second["a"], second["b"]
            )
            continue
        first_lower, _ = quality_interval(first)
        _, second_upper = quality_interval(second)
        assert first_lower > second_upper


def verify_factorization_record(row: dict[str, Any]) -> None:
    radicals = []
    for name in ("a", "b", "c"):
        factors = {int(p): int(e) for p, e in row["factorizations"][name].items()}
        product = 1
        radical = 1
        for p, exponent in factors.items():
            assert p >= 2 and exponent >= 1
            # Trial division is independent of the structured producer's prime sieve.
            assert radical_trial(p) == p
            product *= p**exponent
            radical *= p
        assert product == row[name]
        assert radical == row[f"rad_{name}"]
        radicals.append(radical)
    assert row["a"] + row["b"] == row["c"]
    assert math.gcd(row["a"], row["b"]) == 1
    assert math.gcd(radicals[0], radicals[1]) == 1
    assert math.gcd(radicals[0], radicals[2]) == 1
    assert math.gcd(radicals[1], radicals[2]) == 1
    assert math.prod(radicals) == row["radical_abc"]
    for num, den in EPSILONS:
        label = f"{num}/{den}"
        exact = pow(row["c"], den) > pow(row["radical_abc"], den + num)
        field = row["epsilon_excesses"][label]
        claimed = field.get(
            "positive_exact_power_comparison",
            field.get("positive_exactly_iff_c_pow_den_gt_radical_pow_den_plus_num"),
        )
        assert exact is claimed


def main() -> None:
    summary = parse_key_values(ROOT / "SCAN_SUMMARY.txt")
    assert summary["status"] == "PASS"
    assert int(summary["max_c"]) == 100_000
    assert int(summary["primitive_triples"]) == 1_519_825_376
    assert int(summary["abc_hits_c_gt_radical"]) == 419

    cpp_validation = parse_key_values(ROOT / "VALIDATION.log")
    assert cpp_validation["status"] == "PASS"
    assert cpp_validation["all_csv_rows_exactly_reproduced"] == "true"
    assert int(cpp_validation["primitive_triples"]) == 1_519_825_376
    assert int(cpp_validation["abc_hits_c_gt_radical"]) == 419

    hits = read_hits()
    output = json.loads((ROOT / "OUTPUT.json").read_text(encoding="utf-8"))
    assert output["status"] == "PASS"
    assert output["conclusion"]["rigorous_standard_abc_disproof_found"] is False
    assert output["scope"]["primitive_triples"] == 1_519_825_376
    assert output["abc_hits_c_gt_radical"] == 419

    expected_quality = ordered(hits, None)[:20]
    certify_complete_quality_order(ordered(hits, None))
    assert [abc_projection(row) for row in output["top_standard_quality"]] == [
        abc_projection(row) for row in expected_quality
    ]
    for row in output["top_standard_quality"]:
        verify_factorization_record(row)

    for epsilon in EPSILONS:
        num, den = epsilon
        label = f"{num}/{den}"
        expected_count = sum(pow(row["c"], den) > pow(row["radical_abc"], den + num) for row in hits)
        assert output["positive_fixed_epsilon_counts"][label] == expected_count
        expected_top = ordered(hits, epsilon)[:20]
        observed_top = output["top_fixed_epsilon_excess"][label]
        assert [abc_projection(row) for row in observed_top] == [
            abc_projection(row) for row in expected_top
        ]
        for row in observed_top:
            verify_factorization_record(row)

    structured = output["structured_family_search"]
    assert structured["status"] == "PASS"
    assert {name: family["rows_tested"] for name, family in structured["families"].items()} == (
        EXPECTED_FAMILY_COUNTS
    )
    seen: set[str] = set()
    for family in structured["families"].values():
        collections = [family["top_standard_quality"], *family["top_fixed_epsilon_excess"].values()]
        for collection in collections:
            for row in collection:
                identity = json.dumps(row, sort_keys=True)
                if identity not in seen:
                    verify_factorization_record(row)
                    seen.add(identity)

    strongest = structured["strongest_structured_row_by_standard_quality"]
    assert abc_projection(strongest) == (2, 6_436_341, 6_436_343, 15_042)
    assert strongest["factorizations"] == {
        "a": {"2": 1},
        "b": {"3": 10, "109": 1},
        "c": {"23": 5},
    }
    assert 2 + 3**10 * 109 == 23**5
    verify_factorization_record(strongest)

    print(
        json.dumps(
            {
                "status": "PASS",
                "complete_scan_max_c": 100_000,
                "primitive_triples": 1_519_825_376,
                "abc_hits": 419,
                "direct_rankings_recomputed_at_decimal_digits": 220,
                "complete_quality_order_certified_by_exact_rational_log_intervals_terms": 120,
                "distinct_serialized_structured_rows_checked": len(seen),
                "standard_abc_disproof_found": False,
            },
            indent=2,
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()
