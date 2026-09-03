#!/usr/bin/env python3
"""Exact finite audit for refined tensor/place Haar normalizations.

This script uses only rational arithmetic.  It does not test IUT III,
Corollary 3.12, the same-pilot source map, or abc.
"""

from __future__ import annotations

import itertools
import json
from fractions import Fraction
from pathlib import Path


MAX_FACTORS = 4
MAX_E = 5
MAX_F = 5
PARENT_WEIGHTS = tuple(Fraction(a, 11) for a in range(1, 11))


def q(x: Fraction) -> str:
    return str(x.numerator) if x.denominator == 1 else f"{x.numerator}/{x.denominator}"


def packets(r: int):
    local_pairs = tuple(itertools.product(range(1, MAX_E + 1), range(1, MAX_F + 1)))
    return itertools.product(local_pairs, repeat=r)


def audit() -> dict:
    packet_count = 0
    factor_count_normalization_failures = 0
    copied_weight_failures = 0
    parent_weight_checks = 0
    first_factor_count_failure = None
    first_copied_weight_failure = None

    for r in range(1, MAX_FACTORS + 1):
        for packet in packets(r):
            packet_count += 1
            degrees = tuple(e * f for e, f in packet)
            total_degree = sum(degrees)
            assert total_degree > 0

            # Raw product Haar shift is N log(p), so division by N is exact.
            raw_prime_coefficient = Fraction(total_degree)
            normalized_prime_coefficient = raw_prime_coefficient / total_degree
            assert normalized_prime_coefficient == 1

            relative_weights = tuple(Fraction(n, total_degree) for n in degrees)
            assert sum(relative_weights) == 1
            assert all(weight > 0 for weight in relative_weights)

            # Test the factor formula with a nontrivial exact log-volume vector.
            logs = tuple(
                Fraction((index + 2) * (e + 3 * f), index + 1)
                for index, (e, f) in enumerate(packet)
            )
            factor_formula = sum(
                rho * (ell / n)
                for rho, ell, n in zip(relative_weights, logs, degrees)
            )
            product_formula = sum(logs) / total_degree
            assert factor_formula == product_formula

            # Dividing by the number of primitive factors is generally false.
            factor_count_coefficient = Fraction(total_degree, r)
            if factor_count_coefficient != 1:
                factor_count_normalization_failures += 1
                if first_factor_count_failure is None:
                    first_factor_count_failure = {
                        "local_pairs": packet,
                        "local_degrees": degrees,
                        "wrong_coefficient": q(factor_count_coefficient),
                        "correct_coefficient": "1",
                    }

            for parent_weight in PARENT_WEIGHTS:
                parent_weight_checks += 1
                refined = tuple(parent_weight * rho for rho in relative_weights)
                assert sum(refined) == parent_weight

                # Copying the parent weight to every factor fails exactly when
                # there is more than one factor and the parent weight is nonzero.
                copied_total = parent_weight * r
                if copied_total != parent_weight:
                    copied_weight_failures += 1
                    if first_copied_weight_failure is None:
                        first_copied_weight_failure = {
                            "factor_count": r,
                            "parent_weight": q(parent_weight),
                            "copied_total": q(copied_total),
                            "correct_refined_total": q(parent_weight),
                        }

    # The field-theoretic example K tensor K = K x K has two degree-two factors.
    galois_quadratic_degrees = (2, 2)
    galois_quadratic_weights = tuple(
        Fraction(n, sum(galois_quadratic_degrees)) for n in galois_quadratic_degrees
    )
    assert galois_quadratic_weights == (Fraction(1, 2), Fraction(1, 2))
    assert sum(galois_quadratic_weights) == 1
    assert sum((Fraction(1), Fraction(1))) == 2

    return {
        "arithmetic": "fractions.Fraction (exact)",
        "bounds": {
            "factor_count": [1, MAX_FACTORS],
            "ramification_index": [1, MAX_E],
            "residue_degree": [1, MAX_F],
            "parent_weights": [q(w) for w in PARENT_WEIGHTS],
        },
        "positive_results": {
            "packets_checked": packet_count,
            "total_degree_normalization_checks": packet_count,
            "relative_weight_sum_checks": packet_count,
            "dimension_weighted_factor_formula_checks": packet_count,
            "parent_weight_conservation_checks": parent_weight_checks,
        },
        "full_premise_formula_countersearch": {
            "factor_count_normalization_failures": factor_count_normalization_failures,
            "first_factor_count_failure": first_factor_count_failure,
            "copied_parent_weight_failures": copied_weight_failures,
            "first_copied_parent_weight_failure": first_copied_weight_failure,
            "quadratic_galois_tensor_example": {
                "local_degrees": galois_quadratic_degrees,
                "correct_relative_weights": [q(x) for x in galois_quadratic_weights],
                "copied_weights_total": "2",
            },
        },
        "scope": (
            "Finite algebraic audit only; no source-level theta transport, "
            "Ind3 openness, horizontal same-pilot theorem, IUT, or abc conclusion."
        ),
    }


def main() -> None:
    result = audit()
    output = Path(__file__).with_name("verification_output.json")
    output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
