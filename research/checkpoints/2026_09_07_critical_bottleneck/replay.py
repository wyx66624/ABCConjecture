"""Exact finite checks for shared exponent generators, not an ABC proof."""

from __future__ import annotations

import hashlib
import json
import math
from pathlib import Path
import random


ROOT = Path(__file__).resolve().parent
Pair = tuple[int, int]
ONE: Pair = (1, 0)


def mul(a: Pair, b: Pair) -> Pair:
    x, y = a
    u, v = b
    return x * u - y * v, x * v + y * u + y * v


def norm(a: Pair) -> int:
    x, y = a
    return x * x + x * y + y * y


def power(a: Pair, n: int) -> Pair:
    result = ONE
    while n:
        if n & 1:
            result = mul(result, a)
        a = mul(a, a)
        n //= 2
    return result


def power_linear(a: Pair, n: int) -> Pair:
    result = ONE
    for _ in range(n):
        result = mul(result, a)
    return result


def product(xs: list[Pair]) -> Pair:
    result = ONE
    for a in xs:
        result = mul(result, a)
    return result


def prime(n: int) -> bool:
    return n >= 2 and all(n % d for d in range(2, math.isqrt(n) + 1))


def prime_pairs(count: int) -> list[Pair]:
    pairs = {}
    for x in range(1, 25):
        for y in range(1, x + 1):
            q = norm((x, y))
            if prime(q) and q % 3 == 1:
                pairs.setdefault(q, (x, y))
    return [pairs[q] for q in sorted(pairs)[:count]]


def partitions(n: int):
    blocks: list[list[int]] = []

    def visit(i: int):
        if i == n:
            yield tuple(tuple(block) for block in blocks)
            return
        for block in blocks:
            block.append(i)
            yield from visit(i + 1)
            block.pop()
        blocks.append([i])
        yield from visit(i + 1)
        blocks.pop()

    yield from visit(0)


def run() -> dict:
    if not __debug__:
        raise RuntimeError("Assertions are required; do not use python -O.")
    rng = random.Random(20260907)
    pis = prime_pairs(6)
    assert len(pis) == 6
    counts = {
        "matrix_reconstruction": 0,
        "quotient_remainder_reconstruction": 0,
        "primitive_norm_and_cubic_identity": 0,
        "partition_profiles": 0,
        "partition_blocks": 0,
        "large_block_bound": 0,
        "power_over_quadratic_bound": 0,
    }
    samples = []
    for _ in range(240):
        r = rng.randrange(1, 7)
        m = rng.randrange(1, 5)
        coefficients = [rng.randrange(1, 8) for _ in range(m)]
        matrix = [[rng.randrange(4) for _ in range(m)] for _ in range(r)]
        # A nonzero entry in every column is the analytic nonunit condition.
        for j in range(m):
            matrix[j % r][j] += 1
        exponents = [sum(k * f for k, f in zip(coefficients, row)) for row in matrix]
        direct = product([power_linear(pis[i], exponents[i]) for i in range(r)])
        columns = [
            product([power(pis[i], matrix[i][j]) for i in range(r)]) for j in range(m)
        ]
        shared = product([power(column, k) for column, k in zip(columns, coefficients)])
        assert direct == shared
        assert norm(direct) == math.prod(norm(pis[i]) ** exponents[i] for i in range(r))
        assert norm(shared) == math.prod(norm(w) ** k for w, k in zip(columns, coefficients))
        counts["matrix_reconstruction"] += 1
        x, y = direct
        assert math.gcd(x, y) == 1
        z3 = power(direct, 3)
        conjugate3 = (z3[0] + z3[1], -z3[1])
        boundary = x * y * (x + y)
        assert (z3[0] - conjugate3[0], z3[1] - conjugate3[1]) == (
            -3 * boundary, 6 * boundary
        )
        assert boundary != 0
        counts["primitive_norm_and_cubic_identity"] += 1
        if len(samples) < 3:
            samples.append({"matrix": matrix, "coefficients": coefficients,
                            "coordinate_sha256": hashlib.sha256(str(direct).encode()).hexdigest()})

    for r in range(1, 7):
        for g in range(1, 12):
            exponents = [g + i + 1 for i in range(r)]
            quotients = [e // g for e in exponents]
            remainders = [e % g for e in exponents]
            direct = product([power_linear(pis[i], exponents[i]) for i in range(r)])
            w = product([power(pis[i], quotients[i]) for i in range(r)])
            v = product([power(pis[i], remainders[i]) for i in range(r)])
            assert all(e == g * f + rem for e, f, rem in zip(exponents, quotients, remainders))
            assert direct == mul(power(w, g), v)
            assert norm(direct) == norm(w) ** g * norm(v)
            counts["quotient_remainder_reconstruction"] += 1

    for r in range(2, 9):
        for g in (r, r**4, 10 * r**4 + 1):
            exponents = [g + i + 1 for i in range(r)]
            assert math.gcd(*exponents) == 1
            for partition in partitions(r):
                counts["partition_profiles"] += 1
                m = len(partition)
                sizes = []
                for block in partition:
                    h = len(block)
                    sizes.append(h)
                    content = math.gcd(*(exponents[i] for i in block))
                    assert all(exponents[i] % content == 0 for i in block)
                    # Cleared-denominator form of the exact block-size bound.
                    if h >= 2:
                        assert content * (h - 1) <= r - 1
                        assert r * sum(exponents[i] // content for i in block) >= g * h * (h - 1)
                    counts["partition_blocks"] += 1
                if 2 * m <= r:
                    h = max(sizes)
                    assert h >= 2
                    assert 2 * m * m * h * (h - 1) >= r * r
                    counts["large_block_bound"] += 1

    for m in range(1, 1001):
        assert 2 ** (m + 1) >= m * m
        counts["power_over_quadratic_bound"] += 1
    return {
        "status": "exact finite verification only; no global ABC or asymptotic proof",
        "counts": counts,
        "prime_norm_pairs": [{"pair": p, "norm": norm(p)} for p in pis],
        "sample_reconstruction_hashes": samples,
        "seed": 20260907,
    }


if __name__ == "__main__":
    result = run()
    output = ROOT / "verification" / "exact_results.json"
    output.parent.mkdir(exist_ok=True)
    text = json.dumps(result, indent=2, sort_keys=True) + "\n"
    output.write_bytes(text.encode("utf-8"))
    print(json.dumps({"output": str(output), "counts": result["counts"],
                      "sha256": hashlib.sha256(text.encode()).hexdigest()}, sort_keys=True))
