#!/usr/bin/env python3
"""Exact finite replay of the constant-residue endpoint construction.

No third-party packages, floating point, probabilistic primality tests, or
factorization oracle are used. Labels depend only on subset cardinality;
checking all possible cardinalities is therefore exhaustive for packet labels.
This is not an abc counterexample search or an optimizer for FCRT.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from math import gcd, isqrt, prod
from pathlib import Path


def is_prime_trial(n: int) -> bool:
    """Certify primality by trial division through the integer square root."""
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    return all(n % d for d in range(3, isqrt(n) + 1, 2))


def valuation(n: int, p: int) -> int:
    if n <= 0 or p < 2:
        raise ValueError("valuation requires n > 0 and p >= 2")
    e = 0
    while n % p == 0:
        n //= p
        e += 1
    return e


def make_case(e: int) -> dict[str, object]:
    if not 2 <= e <= 6:
        raise ValueError("Finite replay supports 2 <= e <= 6")
    m, qmod = 3 ** (e - 1), 3 ** (e + 1)
    modulus = 8 * qmod
    residue = next(2 + k * qmod for k in range(8)
                   if (2 + k * qmod) % 8 == 3)
    assert 0 <= residue < modulus and gcd(residue, modulus) == 1
    primes: list[int] = []
    candidate = residue
    while len(primes) < m:
        if is_prime_trial(candidate):
            primes.append(candidate)
        candidate += modulus
    assert len(primes) == len(set(primes)) == m
    assert all(p % qmod == 2 and p % 8 == 3 for p in primes)
    b = prod(primes)
    c = b + 1
    assert valuation(c, 2) == 2
    assert valuation(c, 3) == e
    target_mod = 3 ** e
    g = pow(2, -1, target_mod)
    assert all(pow(p, -1, target_mod) == g for p in primes)
    labels = [pow(g, k, target_mod) for k in range(2 * m + 1)]
    assert labels[2 * m] == 1
    assert all(labels[k] != 1 for k in range(1, 2 * m))
    assert labels[m] == target_mod - 1
    assert all(labels[k] != target_mod - 1 for k in range(m))
    assert all(labels[k] != 1 for k in range(1, m + 1))
    # Squarefree b, gcd(b,c)=1, and 6|c imply rad(b*c) >= 6*b > c.
    assert gcd(b, c) == 1 and c % 6 == 0 and 6 * b > c
    return {
        "e": e, "m": m, "progression_modulus": modulus,
        "progression_residue": residue, "primes": primes,
        "b": str(b), "c": str(c), "c_decimal_digits": len(str(c)),
        "v2_c": 2, "v3_c": e, "group_order": 2 * m,
        "cube_size": str(2 ** m), "generator": g,
        "proper_compatible_cardinalities": [],
        "nonempty_identity_cardinalities": [],
        "radical_lower_bound": str(6 * b),
        "positive_abc_defect": 0,
        "optimized_FCRT_boundary": 0,
        "note": "Boundary zero follows from the proved full-block construction, not optimization."
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--max-e", type=int, default=5)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    if not 2 <= args.max_e <= 6:
        parser.error("--max-e must lie between 2 and 6")
    result = {"status": "finite exact replay; not an abc disproof",
              "cases": [make_case(e) for e in range(2, args.max_e + 1)]}
    text = json.dumps(result, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text, encoding="utf-8")
    else:
        print(text, end="")
    print("SHA256", hashlib.sha256(text.encode()).hexdigest())


if __name__ == "__main__":
    main()
