#!/usr/bin/env python3
"""Exact finite replay for the all-square affine-conic subroute.

This is a finite stress test only.  It does not assert an asymptotic density,
and a no-hit does not refute the eventual affine matching lower bound.
"""
from __future__ import annotations

import argparse
from math import gcd
from pathlib import Path

BOUND = 500
SEEDS = [
    (1, 4374, 4375, 210), (1, 2400, 2401, 210),
    (3, 125, 128, 30), (625, 2048, 2673, 330),
    (289, 6272, 6561, 714), (1, 5831, 5832, 714),
    (1, 512, 513, 114), (1, 242, 243, 66),
    (5, 1024, 1029, 210), (1, 80, 81, 30),
    (10, 2187, 2197, 390), (13, 243, 256, 78),
    (125, 2187, 2312, 510), (81, 1250, 1331, 330),
    (1, 6560, 6561, 1230), (1, 6859, 6860, 1330),
    (1, 8, 9, 6), (1, 288, 289, 102),
    (11, 3125, 3136, 770), (49, 576, 625, 210),
]


def radical(n: int) -> int:
    assert n > 0
    ans = 1
    if n % 2 == 0:
        ans *= 2
        while n % 2 == 0:
            n //= 2
    p = 3
    while p * p <= n:
        if n % p == 0:
            ans *= p
            while n % p == 0:
                n //= p
        p += 2
    if n > 1:
        ans *= n
    return ans


def row_from_parameter(a: int, b: int, p: int, q: int):
    # Parametrization from the rational point (1,1,1) on
    # a*x^2 + b*y^2 = (a+b)*z^2.
    # Each coordinate may be independently negated because the conic is
    # diagonal in x^2,y^2,z^2.  Taking absolute values prevents the finite
    # replay from silently dropping another sign chart.
    x = abs(b * p * p - 2 * b * p * q - a * q * q)
    y = abs(a * q * q - 2 * a * p * q - b * p * p)
    z = abs(a * q * q + b * p * p)
    if not (0 < x < z < y):
        return None
    d = gcd(x, gcd(y, z))
    return x // d, y // d, z // d


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--write-output",
        action="store_true",
        help="replace OUTPUT.txt with the newly generated exact result",
    )
    args = parser.parse_args()
    lines = [
        f"bound={BOUND}",
        f"seed_count={len(SEEDS)}",
        "parameter_domain=-BOUND<=p<=BOUND, 1<=q<=BOUND, gcd(|p|,q)=1",
    ]
    parameters = [
        (p, q)
        for p in range(-BOUND, BOUND + 1)
        if p != 0
        for q in range(1, BOUND + 1)
        if gcd(abs(p), q) == 1
    ]
    total_rows = 0
    total_hits = 0
    best = None  # (H^3 / radical^4, exact data), compared by cross multiplication

    for a, b, c, R in SEEDS:
        assert a + b == c and gcd(a, b) == 1
        assert radical(a * b * c) == R and R < c
        seen = set()
        rows = 0
        hits = 0
        for p, q in parameters:
            row = row_from_parameter(a, b, p, q)
            if row is None or row in seen:
                continue
            seen.add(row)
            x, y, z = row
            U, V, W = x * x, y * y, z * z
            if (U - 1) % R or (V - 1) % R or (W - 1) % R:
                continue
            if (V - W) % (a * R):
                continue
            h = (U - 1) // R
            k = (V - W) // (a * R)
            if h <= 0 or k <= 0 or gcd(U, k) != 1:
                continue
            assert U == 1 + R * h
            assert V == 1 + R * (h + c * k)
            assert W == 1 + R * (h + b * k)
            assert a * U + b * V == c * W
            assert gcd(U, V) == gcd(U, W) == gcd(V, W) == 1
            assert gcd(U * V * W, a * b * c) == 1
            rx, ry, rz = radical(x), radical(y), radical(z)
            full_rad = R * rx * ry * rz
            # The preceding pairwise-coprimality checks make radical
            # multiplicative across these six components.  Factor them
            # separately instead of trial-dividing their enormous product.
            assert full_rad == (
                radical(a) * radical(b) * radical(c) * rx * ry * rz
            )
            H = c * W
            num, den = H**3, full_rad**4
            is_exception = den < num
            rows += 1
            hits += int(is_exception)
            if is_exception:
                lines.append(
                    "HIT "
                    f"seed=({a},{b},{c}) R={R} p={p} q={q} "
                    f"xyz=({x},{y},{z}) h={h} k={k} "
                    f"rad={full_rad} H={H}"
                )
            if best is None or num * best[1] > best[0] * den:
                best = (num, den, (a, b, c, R, p, q, x, y, z, h, k, full_rad, H))
        total_rows += rows
        total_hits += hits
        lines.append(f"seed=({a},{b},{c}) R={R} rows={rows} exceptions={hits}")

    assert best is not None
    num, den, data = best
    a, b, c, R, p, q, x, y, z, h, k, full_rad, H = data
    g = gcd(num, den)
    lines.extend([
        f"total_rows={total_rows}",
        f"total_exceptions={total_hits}",
        "best_H3_over_rad4=" + str(num // g) + "/" + str(den // g),
        "best_row="
        f"seed=({a},{b},{c}) R={R} p={p} q={q} "
        f"xyz=({x},{y},{z}) h={h} k={k} rad={full_rad} H={H}",
        "scope=finite_no_hit_only",
    ])
    out = "\n".join(lines) + "\n"
    print(out, end="")
    expected = Path(__file__).with_name("OUTPUT.txt")
    if args.write_output:
        expected.write_text(out, encoding="utf-8", newline="\n")
        print("captured_output_written=true")
    elif expected.exists():
        assert expected.read_text(encoding="utf-8") == out, "OUTPUT.txt mismatch"
        print("captured_output_match=true")


if __name__ == "__main__":
    main()
