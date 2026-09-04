from __future__ import annotations

import argparse
import json
import math
from dataclasses import dataclass, asdict
from pathlib import Path


@dataclass(frozen=True)
class Row:
    a: int
    b: int
    c: int
    radical: int
    product: int
    approximation_gain: float
    power_gain: float
    quality: float


def radicals(limit: int) -> list[int]:
    rad = [1] * (limit + 1)
    for p in range(2, limit + 1):
        if rad[p] == 1:
            for n in range(p, limit + 1, p):
                rad[n] *= p
    return rad


def row(a: int, b: int, c: int, rad: list[int]) -> Row:
    r = rad[a] * rad[b] * rad[c]
    n = a * b * c
    log_c, log_n, log_r = math.log(c), math.log(n), math.log(r)
    return Row(a, b, c, r, n, log_c / log_n, log_n / log_r, log_c / log_r)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-c", type=int, default=6000)
    parser.add_argument("--output", type=Path, default=Path(__file__).with_name("OUTPUT.json"))
    args = parser.parse_args()
    rad = radicals(args.max_c)

    count = 0
    power_over_three = 0
    hits = 0
    max_quality: Row | None = None
    max_power: Row | None = None
    first_power_over_three: Row | None = None
    corridor_failures = 0
    identity_error = 0.0

    for c in range(5, args.max_c + 1):
        for a in range(2, c // 2 + 1):
            b = c - a
            if math.gcd(a, b) != 1:
                continue
            count += 1
            q = row(a, b, c, rad)
            if not (1.0 / 3.0 < q.approximation_gain < 1.0 / 2.0):
                corridor_failures += 1
            identity_error = max(identity_error, abs(q.quality - q.approximation_gain * q.power_gain))
            if q.quality > 1.0:
                hits += 1
            if q.power_gain > 3.0:
                power_over_three += 1
                if first_power_over_three is None:
                    first_power_over_three = q
            if max_quality is None or q.quality > max_quality.quality:
                max_quality = q
            if max_power is None or q.power_gain > max_power.power_gain:
                max_power = q

    exact_counterexample = row(3, 125, 128, rad)
    if exact_counterexample.radical != 30:
        raise SystemExit("unexpected radical for 3+125=128")
    if not (exact_counterexample.product > exact_counterexample.radical**3):
        raise SystemExit("3+125=128 did not refute the power-gain-three bound")
    if corridor_failures:
        raise SystemExit(f"canonical approximation corridor failures: {corridor_failures}")

    result = {
        "status": "PASS",
        "max_c": args.max_c,
        "primitive_nonunit_triples": count,
        "abc_hits_quality_gt_one": hits,
        "power_gain_gt_three": power_over_three,
        "corridor_failures": corridor_failures,
        "max_factorization_roundoff": identity_error,
        "first_power_gain_gt_three": asdict(first_power_over_three) if first_power_over_three else None,
        "maximum_quality": asdict(max_quality) if max_quality else None,
        "maximum_power_gain": asdict(max_power) if max_power else None,
        "exact_counterexample_3_125_128": {
            **asdict(exact_counterexample),
            "exact_checks": {
                "sum": 3 + 125 == 128,
                "coprime": math.gcd(3, 125) == 1,
                "radical": exact_counterexample.radical == 30,
                "product_gt_radical_cubed": exact_counterexample.product > exact_counterexample.radical**3,
            },
        },
        "scope": "finite evidence only; no asymptotic abc conclusion",
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()

