from __future__ import annotations

import argparse
import heapq
import json
import math
from decimal import Decimal, localcontext
from pathlib import Path
from typing import Any


EPSILONS: tuple[tuple[int, int], ...] = (
    (1, 100),
    (1, 20),
    (1, 10),
    (1, 4),
    (1, 2),
)
POOL_SIZE = 64
OUTPUT_TOP = 10


def prime_sieve(limit: int) -> list[int]:
    flags = bytearray(b"\x01") * (limit + 1)
    flags[0:2] = b"\x00\x00"
    for p in range(2, math.isqrt(limit) + 1):
        if flags[p]:
            start = p * p
            flags[start : limit + 1 : p] = b"\x00" * (((limit - start) // p) + 1)
    return [p for p in range(2, limit + 1) if flags[p]]


def factor_trial(n: int, primes: list[int]) -> dict[int, int]:
    if n < 1:
        raise ValueError("factorization domain is positive")
    original = n
    factors: dict[int, int] = {}
    for p in primes:
        if p * p > n:
            break
        if n % p:
            continue
        exponent = 0
        while n % p == 0:
            n //= p
            exponent += 1
        factors[p] = exponent
    if n > 1:
        # Every input used below has sqrt(original) below the prime-sieve limit.
        assert n * n > original or n <= primes[-1]
        factors[n] = factors.get(n, 0) + 1
    product = 1
    for p, exponent in factors.items():
        product *= p**exponent
    assert product == original
    return factors


def merge_factors(*parts: dict[int, int]) -> dict[int, int]:
    result: dict[int, int] = {}
    for part in parts:
        for p, exponent in part.items():
            result[p] = result.get(p, 0) + exponent
    return dict(sorted(result.items()))


def scaled_factors(factors: dict[int, int], scale: int) -> dict[int, int]:
    return {p: scale * exponent for p, exponent in factors.items()}


def radical_of_factors(factors: dict[int, int]) -> int:
    result = 1
    for p in factors:
        result *= p
    return result


def make_row(
    family: str,
    parameters: dict[str, int],
    a: int,
    b: int,
    c: int,
    factors_a: dict[int, int],
    factors_b: dict[int, int],
    factors_c: dict[int, int],
) -> dict[str, Any]:
    assert a + b == c and math.gcd(a, b) == 1 and a > 0 and b > 0
    for value, factors in ((a, factors_a), (b, factors_b), (c, factors_c)):
        product = 1
        for p, exponent in factors.items():
            product *= p**exponent
        assert product == value
    ra, rb, rc = map(radical_of_factors, (factors_a, factors_b, factors_c))
    # Primitivity makes the three supports disjoint.
    assert math.gcd(ra, rb) == math.gcd(ra, rc) == math.gcd(rb, rc) == 1
    return {
        "family": family,
        "parameters": parameters,
        "a": a,
        "b": b,
        "c": c,
        "rad_a": ra,
        "rad_b": rb,
        "rad_c": rc,
        "radical_abc": ra * rb * rc,
        "factorizations": {
            "a": {str(p): e for p, e in factors_a.items()},
            "b": {str(p): e for p, e in factors_b.items()},
            "c": {str(p): e for p, e in factors_c.items()},
        },
    }


class Accumulator:
    def __init__(self, name: str) -> None:
        self.name = name
        self.count = 0
        self.quality_hits = 0
        self.positive_counts = {f"{n}/{d}": 0 for n, d in EPSILONS}
        self.heaps: dict[str, list[tuple[float, int, dict[str, Any]]]] = {
            "quality": [],
            **{f"epsilon_{n}/{d}": [] for n, d in EPSILONS},
        }
        self.serial = 0

    def _push(self, label: str, score: float, row: dict[str, Any]) -> None:
        heap = self.heaps[label]
        item = (score, self.serial, row)
        if len(heap) < POOL_SIZE:
            heapq.heappush(heap, item)
        elif item[:2] > heap[0][:2]:
            heapq.heapreplace(heap, item)

    def add(self, row: dict[str, Any]) -> None:
        self.count += 1
        self.serial += 1
        c = row["c"]
        radical = row["radical_abc"]
        h = math.log(c)
        r = math.log(radical)
        self._push("quality", h / r, row)
        hit = c > radical
        if hit:
            self.quality_hits += 1
        for num, den in EPSILONS:
            label = f"{num}/{den}"
            self._push(f"epsilon_{label}", h - ((den + num) / den) * r, row)
            if hit and pow(c, den) > pow(radical, den + num):
                self.positive_counts[label] += 1

    @staticmethod
    def _decimal_score(row: dict[str, Any], label: str, precision: int) -> Decimal:
        with localcontext() as context:
            context.prec = precision
            h = Decimal(row["c"]).ln()
            r = Decimal(row["radical_abc"]).ln()
            if label == "quality":
                return h / r
            fraction = label.removeprefix("epsilon_")
            num, den = map(int, fraction.split("/"))
            return h - (Decimal(den + num) / Decimal(den)) * r

    @classmethod
    def _decorate(cls, row: dict[str, Any]) -> dict[str, Any]:
        answer = dict(row)
        answer["quality_log_c_over_log_radical"] = format(
            cls._decimal_score(row, "quality", 140), ".60f"
        )
        answer["epsilon_excesses"] = {}
        for num, den in EPSILONS:
            label = f"{num}/{den}"
            answer["epsilon_excesses"][label] = {
                "value": format(cls._decimal_score(row, f"epsilon_{label}", 140), ".60f"),
                "positive_exact_power_comparison": pow(row["c"], den)
                > pow(row["radical_abc"], den + num),
            }
        return answer

    def finish(self) -> dict[str, Any]:
        rankings: dict[str, list[dict[str, Any]]] = {}
        for label, heap in self.heaps.items():
            candidates: dict[tuple[int, int, int, str], dict[str, Any]] = {}
            for _, _, row in heap:
                key = (row["a"], row["b"], row["c"], json.dumps(row["parameters"], sort_keys=True))
                candidates[key] = row
            ordered_100 = sorted(
                candidates.values(),
                key=lambda row: (self._decimal_score(row, label, 100), -row["c"], -row["a"]),
                reverse=True,
            )
            ordered_160 = sorted(
                candidates.values(),
                key=lambda row: (self._decimal_score(row, label, 160), -row["c"], -row["a"]),
                reverse=True,
            )
            assert [row["parameters"] for row in ordered_100] == [
                row["parameters"] for row in ordered_160
            ]
            rankings[label] = [self._decorate(row) for row in ordered_160[:OUTPUT_TOP]]
        return {
            "family": self.name,
            "rows_tested": self.count,
            "quality_gt_one_exact_count": self.quality_hits,
            "positive_fixed_epsilon_exact_counts": self.positive_counts,
            "top_standard_quality": rankings.pop("quality"),
            "top_fixed_epsilon_excess": {
                label.removeprefix("epsilon_"): rows for label, rows in rankings.items()
            },
        }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=Path(__file__).with_name("STRUCTURED_OUTPUT.json"))
    args = parser.parse_args()

    sieve_limit = 2_000_001
    primes = prime_sieve(sieve_limit)
    accumulators: dict[str, Accumulator] = {}

    def acc(name: str) -> Accumulator:
        return accumulators.setdefault(name, Accumulator(name))

    # Mersenne neighbours: 1 + (2^n-1) = 2^n.
    for n in range(2, 41):
        b = (1 << n) - 1
        row = make_row(
            "mersenne_neighbour",
            {"n": n},
            1,
            b,
            1 << n,
            {},
            factor_trial(b, primes),
            {2: n},
        )
        acc("mersenne_neighbour_n_2_40").add(row)

    # A fixed-small-arm family used in the incidence ledger.
    for k in range(0, 37):
        a = 1 << (k + 4)
        c = a + 3
        row = make_row(
            "power_of_two_plus_three",
            {"k": k},
            a,
            3,
            c,
            {2: k + 4},
            {3: 1},
            factor_trial(c, primes),
        )
        acc("two_power_plus_three_k_0_36").add(row)

    for r_index in range(1, 13):
        a = 1 << (2 * r_index)
        b = 3**r_index
        c = a + b
        row = make_row(
            "balanced_two_prime",
            {"r": r_index},
            a,
            b,
            c,
            {2: 2 * r_index},
            {3: r_index},
            factor_trial(c, primes),
        )
        acc("balanced_two_prime_r_1_12").add(row)

    for n in range(1, 9):
        c = 15**n
        b = c - 2
        row = make_row(
            "fifteen_power_neighbour",
            {"n": n},
            2,
            b,
            c,
            {2: 1},
            factor_trial(b, primes),
            {3: n, 5: n},
        )
        acc("two_plus_fifteen_power_neighbour_n_1_8").add(row)

    # Pell/balancing identity 1 + 8 U_n^2 = X_n^2.
    u_prev, u_now = 0, 1
    x_prev, x_now = 1, 3
    for n in range(1, 15):
        if n > 1:
            u_prev, u_now = u_now, 6 * u_now - u_prev
            x_prev, x_now = x_now, 6 * x_now - x_prev
        fu = factor_trial(u_now, primes)
        fx = factor_trial(x_now, primes)
        fb = merge_factors({2: 3}, scaled_factors(fu, 2))
        fc = scaled_factors(fx, 2)
        row = make_row(
            "balancing_pell_square",
            {"n": n, "U_n": u_now, "X_n": x_now},
            1,
            8 * u_now * u_now,
            x_now * x_now,
            {},
            fb,
            fc,
        )
        acc("balancing_pell_square_n_1_14").add(row)

    # First fully factorable member of the repository's Danilov orbit.
    z, w = 682, 305
    A = z * z + 6 * z + 4
    B = z * z + 9 * z + 19
    L = 2 * z + 11
    X, Y, K = A // 5, w * B // 5, 27 * L // 125
    assert X**3 + K == Y**2
    row = make_row(
        "danilov_hall_orbit",
        {"t": 0, "z": z, "w": w, "X": X, "Y": Y, "K": K},
        X**3,
        K,
        Y**2,
        scaled_factors(factor_trial(X, primes), 3),
        factor_trial(K, primes),
        scaled_factors(factor_trial(Y, primes), 2),
    )
    acc("danilov_hall_orbit_t_0_fully_factored").add(row)

    # Primitive Pythagorean squares, far beyond the complete c <= 100000 scan.
    pyth = acc("primitive_pythagorean_squares_m_le_1000")
    for m in range(2, 1001):
        for n in range(1, m):
            if ((m - n) & 1) == 0 or math.gcd(m, n) != 1:
                continue
            leg_a = m * m - n * n
            leg_b = 2 * m * n
            hypot = m * m + n * n
            a, b, c = leg_a * leg_a, leg_b * leg_b, hypot * hypot
            fa = factor_trial(leg_a, primes)
            fb = factor_trial(leg_b, primes)
            fc = factor_trial(hypot, primes)
            row = make_row(
                "primitive_pythagorean_square",
                {"m": m, "n": n},
                a,
                b,
                c,
                scaled_factors(fa, 2),
                scaled_factors(fb, 2),
                scaled_factors(fc, 2),
            )
            pyth.add(row)

    # Prime-square endpoint family 1 + (p^2-1) = p^2.
    prime_square = acc("prime_square_endpoint_p_le_100000")
    for p in primes:
        if p > 100_000:
            break
        b = p * p - 1
        fb = merge_factors(factor_trial(p - 1, primes), factor_trial(p + 1, primes))
        row = make_row(
            "prime_square_endpoint",
            {"p": p},
            1,
            b,
            p * p,
            {},
            fb,
            {p: 2},
        )
        prime_square.add(row)

    # A well-known exact adversarial benchmark.  It is included as a finite
    # point, not asserted to be a global quality record.
    benchmark = make_row(
        "named_high_quality_benchmark",
        {"instance": 1},
        2,
        (3**10) * 109,
        23**5,
        {2: 1},
        {3: 10, 109: 1},
        {23: 5},
    )
    acc("named_exact_benchmark_singleton").add(benchmark)

    families = {name: accumulator.finish() for name, accumulator in sorted(accumulators.items())}
    best_rows = [family["top_standard_quality"][0] for family in families.values()]
    best_rows.sort(
        key=lambda row: Decimal(row["quality_log_c_over_log_radical"]), reverse=True
    )
    result = {
        "status": "PASS",
        "exactness": {
            "identities_gcd_factorizations_radicals": "exact Python integers and full trial division",
            "trial_division_prime_bound": sieve_limit,
            "ranking": (
                "binary-log top-64 prefilter per metric followed by Decimal ranking stable at "
                "100 and 160 digits; reported values recomputed at 140 digits"
            ),
        },
        "families": families,
        "strongest_structured_row_by_standard_quality": best_rows[0],
        "scope_warning": (
            "Every family range is finite. A missing hit does not retire the family, and a finite "
            "hit does not disprove abc."
        ),
    }
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(
        json.dumps(
            {
                "status": "PASS",
                "family_row_counts": {name: value["rows_tested"] for name, value in families.items()},
                "strongest": best_rows[0],
            },
            indent=2,
            sort_keys=True,
        )
    )


if __name__ == "__main__":
    main()
