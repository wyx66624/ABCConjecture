#!/usr/bin/env python3
"""Exact small-index audit of both new coupling formulae, without SymPy."""

import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / "coupling_examples_verification.json"


def primes_through(n: int) -> list[int]:
    sieve = [True] * (n + 1)
    sieve[0:2] = [False, False]
    for p in range(2, int(n**0.5) + 1):
        if sieve[p]:
            sieve[p * p : n + 1 : p] = [False] * (((n - p * p) // p) + 1)
    return [p for p in range(2, n + 1) if sieve[p]]


def factor(n: int) -> dict[int, int]:
    result: dict[int, int] = {}
    p = 2
    while p * p <= n:
        while n % p == 0:
            result[p] = result.get(p, 0) + 1
            n //= p
        p = 3 if p == 2 else p + 2
    if n > 1:
        result[n] = result.get(n, 0) + 1
    return result


def pell_coordinates(n: int) -> tuple[int, int]:
    a, b = 1, 0
    x, y = 1, 1
    while n:
        if n & 1:
            a, b = a * x + 2 * b * y, a * y + b * x
        x, y = x * x + 2 * y * y, 2 * x * y
        n >>= 1
    return a, b


def legendre(a: int, p: int) -> int:
    value = pow(a % p, (p - 1) // 2, p)
    if value == p - 1:
        return -1
    assert value in (0, 1)
    return value


def pair_coefficient(weighted: list[tuple[int, int]]) -> int:
    # weighted entries are (multiplicity, quotient coordinate)
    diagonal = sum(e * (e - 1) // 2 * t * t for e, t in weighted)
    cross = sum(
        weighted[i][0] * weighted[j][0] * weighted[i][1] * weighted[j][1]
        for i in range(len(weighted))
        for j in range(i + 1, len(weighted))
    )
    return diagonal + cross


rows = []
for ell in [p for p in primes_through(43) if p % 2]:
    A, B = pell_coordinates(ell)
    assert A * A - 2 * B * B == -1
    fA, fB = factor(A), factor(B)
    assert A == __import__("math").prod(q**e for q, e in fA.items())
    assert B == __import__("math").prod(r**e for r, e in fB.items())

    wa = []
    for q, e in fA.items():
        assert (q - 1) % (2 * ell) == 0
        wa.append((e, (q - 1) // (2 * ell)))
    wb = []
    sign_product = 1
    for r, e in fB.items():
        s = legendre(2, r)
        assert (r - s) % (2 * ell) == 0
        assert r % 4 == 1
        wb.append((e, s * ((r - s) // (2 * ell))))
        sign_product *= s**e

    s_ell = legendre(2, ell)
    assert sign_product == s_ell
    a = (A - 1) // (2 * ell)
    b = (s_ell * B - 1) // (2 * ell)
    KA = sum(e * t for e, t in wa)
    KB = sum(e * t for e, t in wb)
    CA = pair_coefficient(wa)
    CB = pair_coefficient(wb)
    modulus = 4 * ell * ell
    second_order = (
        KA - 2 * KB
        + ell * (KA * KA - 2 * KB * KB)
        + 2 * ell * (CA - 2 * CB)
    ) % modulus
    assert a % modulus == (KA + 2 * ell * CA) % modulus
    assert b % modulus == (KB + 2 * ell * CB) % modulus
    assert second_order == 0

    cross = 1
    for q, e in fA.items():
        for r, f in fB.items():
            cross *= legendre(q, r) ** (e * f)
    assert cross == s_ell
    rows.append(
        {
            "ell": ell,
            "A_factorization": {str(q): e for q, e in fA.items()},
            "B_factorization": {str(r): e for r, e in fB.items()},
            "second_order_residue": second_order,
            "cross_character_product": cross,
            "s_ell": s_ell,
        }
    )

result = {
    "algorithm": "binary Pell coordinates, complete trial division, Euler criterion",
    "indices": [row["ell"] for row in rows],
    "rows": rows,
    "verification": "PASS",
}
OUT.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8", newline="\n")
print(json.dumps(result, indent=2, sort_keys=True))
