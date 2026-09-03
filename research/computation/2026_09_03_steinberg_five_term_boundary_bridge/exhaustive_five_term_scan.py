#!/usr/bin/env python3
"""Finite pressure test for the Steinberg five-term boundary bridge.

This is evidence only for the displayed finite boxes.  The universal
boundary identity and the counterexamples reported by the checkpoint are
proved separately in Lean.
"""

from __future__ import annotations

from collections import Counter
from fractions import Fraction
from itertools import product
import json
import math


Vector = tuple[int, int]
Symbol = tuple[Vector, Vector]


def add(a: Vector, b: Vector) -> Vector:
    return tuple(x + y for x, y in zip(a, b))  # type: ignore[return-value]


def sub(a: Vector, b: Vector) -> Vector:
    return tuple(x - y for x, y in zip(a, b))  # type: ignore[return-value]


def wedge(a: Vector, b: Vector) -> int:
    return a[0] * b[1] - a[1] * b[0]


def five_symbols(X: Vector, U: Vector, Y: Vector, V: Vector, Z: Vector) -> list[Symbol]:
    return [
        (X, U),
        (Y, V),
        (sub(Y, X), sub(Z, X)),
        (sub(sub(add(Y, U), X), V), sub(sub(Z, X), V)),
        (sub(U, V), sub(Z, V)),
    ]


def signed_chain(symbols: list[Symbol]) -> dict[Symbol, int]:
    out: Counter[Symbol] = Counter()
    for coefficient, symbol in zip((1, -1, 1, -1, 1), symbols, strict=True):
        out[symbol] += coefficient
    return {s: n for s, n in out.items() if n}


def vector_box_scan() -> dict[str, object]:
    vectors = list(product(range(-1, 2), repeat=2))
    total = 0
    nonzero_chains = 0
    pairwise_distinct = 0
    all_individual_boundaries_nonzero = 0
    robust_witness = None

    for X, U, Y, V, Z in product(vectors, repeat=5):
        symbols = five_symbols(X, U, Y, V, Z)
        coefficients = (1, -1, 1, -1, 1)
        boundary = sum(c * wedge(*s) for c, s in zip(coefficients, symbols, strict=True))
        if boundary != 0:
            raise AssertionError((X, U, Y, V, Z, boundary))
        total += 1
        if signed_chain(symbols):
            nonzero_chains += 1
        if len(set(symbols)) == 5:
            pairwise_distinct += 1
            individual = [wedge(*s) for s in symbols]
            if all(value != 0 for value in individual):
                all_individual_boundaries_nonzero += 1
                if robust_witness is None:
                    robust_witness = {
                        "inputs": {"X": X, "U": U, "Y": Y, "V": V, "Z": Z},
                        "symbols": symbols,
                        "individual_wedges": individual,
                        "signed_boundary_sum": boundary,
                    }

    return {
        "coordinate_box": [-1, 0, 1],
        "dimension": 2,
        "tuples_checked": total,
        "boundary_failures": 0,
        "nonzero_formal_chains": nonzero_chains,
        "pairwise_distinct_symbol_tuples": pairwise_distinct,
        "pairwise_distinct_with_all_individual_boundaries_nonzero": all_individual_boundaries_nonzero,
        "first_robust_witness": robust_witness,
    }


def prime_valuation(q: Fraction, p: int) -> int:
    def val(n: int) -> int:
        ans = 0
        while n % p == 0:
            ans += 1
            n //= p
        return ans

    return val(abs(q.numerator)) - val(q.denominator)


def omega(q: Fraction, primes: tuple[int, ...]) -> dict[tuple[int, int], int]:
    qv = {p: prime_valuation(q, p) for p in primes}
    cv = {p: prime_valuation(1 - q, p) for p in primes}
    return {
        (p, r): qv[p] * cv[r] - qv[r] * cv[p]
        for p in primes
        for r in primes
    }


def rational_positive_scan() -> dict[str, object]:
    rationals = sorted({Fraction(a, c) for c in range(2, 21) for a in range(1, c)})
    candidates = 0
    distinct_candidates = 0
    best = None
    for y in rationals:
        for x in rationals:
            if not y < x:
                continue
            candidates += 1
            arguments = [
                x,
                y,
                y / x,
                y * (1 - x) / (x * (1 - y)),
                (1 - x) / (1 - y),
            ]
            if len(set(arguments)) != 5:
                continue
            distinct_candidates += 1
            score = (
                max(z.denominator for z in arguments),
                sum(z.denominator for z in arguments),
                max(z.numerator for z in arguments),
                x.denominator + y.denominator,
                x.numerator + y.numerator,
            )
            item = (score, x, y, arguments)
            if best is None or item < best:
                best = item

    assert best is not None
    _score, x, y, arguments = best
    expected = [Fraction(1, 2), Fraction(1, 6), Fraction(1, 3), Fraction(1, 5), Fraction(3, 5)]
    if arguments != expected:
        raise AssertionError((x, y, arguments))

    primes = (2, 3, 5)
    surfaces = [omega(z, primes) for z in arguments]
    signed_surface = {
        pair: sum(c * surface[pair] for c, surface in zip((1, -1, 1, -1, 1), surfaces, strict=True))
        for pair in product(primes, repeat=2)
    }
    if any(signed_surface.values()):
        raise AssertionError(signed_surface)

    return {
        "denominator_search_bound": 20,
        "ordered_pairs_checked": candidates,
        "five_distinct_argument_pairs": distinct_candidates,
        "best_score": best[0],
        "best_x": str(x),
        "best_y": str(y),
        "five_arguments": [str(z) for z in arguments],
        "prime_coordinates_checked": primes,
        "signed_surface": {f"{p},{q}": signed_surface[(p, q)] for p, q in product(primes, repeat=2)},
        "surface_failures": 0,
        "formal_symbols_pairwise_distinct": len({
            tuple(prime_valuation(z, p) for p in primes) +
            tuple(prime_valuation(1 - z, p) for p in primes)
            for z in arguments
        }) == 5,
    }


def common_denominator_scan() -> dict[str, object]:
    valid = []
    distinct = []
    for c in range(3, 101):
        for a in range(2, c):
            for b in range(1, a):
                conditions = (
                    math.gcd(a, c - a) == 1,
                    math.gcd(b, c - b) == 1,
                    math.gcd(b, a - b) == 1,
                    math.gcd(b * (c - a), c * (a - b)) == 1,
                    math.gcd(c - a, a - b) == 1,
                )
                if not all(conditions):
                    continue
                arguments = [
                    Fraction(a, c),
                    Fraction(b, c),
                    Fraction(b, a),
                    Fraction(b * (c - a), a * (c - b)),
                    Fraction(c - a, c - b),
                ]
                valid.append((a, b, c, arguments))
                if len(set(arguments)) == 5:
                    distinct.append((a, b, c, arguments))

    first = valid[0]
    first_distinct = distinct[0]
    return {
        "c_bound": 100,
        "valid_reduced_data": len(valid),
        "valid_with_five_distinct_arguments": len(distinct),
        "first_valid": {
            "a_b_c": first[:3],
            "arguments": [str(z) for z in first[3]],
        },
        "first_distinct": {
            "a_b_c": first_distinct[:3],
            "arguments": [str(z) for z in first_distinct[3]],
        },
        "odd_denominator_subfamily_verified_in_box": all(
            any((a, b, d) == (2, 1, c) for a, b, d, _ in valid)
            for c in range(3, 101, 2)
        ),
    }


def main() -> None:
    result = {
        "schema": "steinberg-five-term-boundary-scan-v1",
        "status": "PASS",
        "scope_warning": "Finite exhaustive evidence only; universal claims are proved in Lean.",
        "vector_box": vector_box_scan(),
        "positive_rational_box": rational_positive_scan(),
        "common_denominator_box": common_denominator_scan(),
    }
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
