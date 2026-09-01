#!/usr/bin/env python3
"""Deterministically factor prime-index Mersenne numbers below 2^64.

The scan is deliberately finite and exploratory.  Its output is not used to
infer squarefreeness, a density statement, or any asymptotic estimate.
"""

from __future__ import annotations

import argparse
import json
import math
from pathlib import Path


# Jim Sinclair's seven-base deterministic Miller--Rabin set for n < 2^64.
MR_BASES_64 = (2, 325, 9375, 28178, 450775, 9780504, 1795265022)


def is_prime_64(n: int) -> bool:
    """Return primality for 0 <= n < 2^64 using deterministic MR bases."""
    if n < 2:
        return False
    for p in (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37):
        if n % p == 0:
            return n == p
    d = n - 1
    s = 0
    while d % 2 == 0:
        s += 1
        d //= 2
    for a in MR_BASES_64:
        if a % n == 0:
            continue
        x = pow(a, d, n)
        if x in (1, n - 1):
            continue
        for _ in range(s - 1):
            x = x * x % n
            if x == n - 1:
                break
        else:
            return False
    return True


def pollard_rho(n: int) -> int:
    """Find a nontrivial factor using a fixed, reproducible parameter order."""
    if n % 2 == 0:
        return 2
    if n % 3 == 0:
        return 3
    for c in range(1, 256):
        for seed in (2, 3, 5, 7, 11):
            x = seed
            y = seed
            d = 1
            for _ in range(2_000_000):
                x = (x * x + c) % n
                y = (y * y + c) % n
                y = (y * y + c) % n
                d = math.gcd(abs(x - y), n)
                if d != 1:
                    break
            if 1 < d < n:
                return d
    raise RuntimeError(f"fixed Pollard-rho schedule failed on {n}")


def factor_64(n: int, out: list[int]) -> None:
    if n == 1:
        return
    if is_prime_64(n):
        out.append(n)
        return
    d = pollard_rho(n)
    factor_64(d, out)
    factor_64(n // d, out)


def primes_through(limit: int) -> list[int]:
    return [n for n in range(2, limit + 1) if is_prime_64(n)]


def multiplicities(prime_factors: list[int]) -> list[dict[str, int]]:
    answer: list[dict[str, int]] = []
    for q in sorted(set(prime_factors)):
        answer.append({"prime": q, "exponent": prime_factors.count(q)})
    return answer


def row(ell: int) -> dict[str, object]:
    m = (1 << ell) - 1
    flat: list[int] = []
    factor_64(m, flat)
    fac = multiplicities(flat)
    product = math.prod(f["prime"] ** f["exponent"] for f in fac)
    radical = math.prod(f["prime"] for f in fac)
    congruences = [
        {
            "prime": f["prime"],
            "q_mod_2ell": f["prime"] % (2 * ell),
            "two_pow_ell_mod_q": pow(2, ell, f["prime"]),
            "exact_order_ell": (
                pow(2, ell, f["prime"]) == 1 and 2 % f["prime"] != 1
            ),
        }
        for f in fac
    ]
    composite = len(fac) != 1 or fac[0]["exponent"] != 1
    lower = (2 * ell + 1) ** 2
    return {
        "index": ell,
        "mersenne": m,
        "status": "composite" if composite else "prime",
        "factorization": fac,
        "factorization_product_verified": product == m,
        "support_count": len(fac),
        "radical": radical,
        "power_loss": m // radical,
        "max_prime_factor": max(f["prime"] for f in fac),
        "factor_checks": congruences,
        "composite_square_lower_bound": lower if composite else None,
        "composite_square_bound_verified": (radical >= lower) if composite else None,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--max-index", type=int, default=61)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    if not 2 <= args.max_index <= 61:
        raise SystemExit("--max-index must lie in [2,61] so every value is < 2^64")

    rows = [row(ell) for ell in primes_through(args.max_index) if ell != 2]
    payload = {
        "schema": "mersenne-prime-layer-radical-v1",
        "scope": {
            "minimum_index": 3,
            "prime_indices_at_most": args.max_index,
            "strictly_finite_exploratory_scan": True,
            "no_asymptotic_inference": True,
        },
        "primality_method": {
            "name": "deterministic Miller-Rabin for unsigned 64-bit integers",
            "bases": list(MR_BASES_64),
        },
        "factorization_method": "fixed-schedule Pollard rho plus recursive MR",
        "rows": rows,
        "summary": {
            "indices_scanned": len(rows),
            "prime_mersenne_indices": [
                r["index"] for r in rows if r["status"] == "prime"
            ],
            "composite_indices": [
                r["index"] for r in rows if r["status"] == "composite"
            ],
            "exactly_two_support_indices": [
                r["index"] for r in rows
                if r["status"] == "composite" and r["support_count"] == 2
            ],
            "repeated_prime_factor_indices": [
                r["index"] for r in rows
                if any(f["exponent"] > 1 for f in r["factorization"])
            ],
        },
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(payload, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )


if __name__ == "__main__":
    main()
