#!/usr/bin/env python3
"""Independent arbitrary-integer replay of the exhaustive q <= 10^8 scan.

The C++ producer first tests U_{q-(2/q)} modulo q^2 and computes modulo q^3
only for q^2 hits.  This verifier deliberately recomputes the same predicate
with Python arbitrary-precision integers, regenerates the prime sieve, derives
the exact rank and A/B channel of every hit, and compares every CSV field.
"""

from __future__ import annotations

import csv
import hashlib
import json
import math
import sys
from pathlib import Path


def balancing_mod(n: int, modulus: int) -> int:
    """U_n mod modulus for U_0=0,U_1=1,U_{n+2}=6U_{n+1}-U_n."""
    a, b = 0, 1
    for bit in bin(n)[2:]:
        c = a * (2 * b - 6 * a) % modulus
        d = (b * b - a * a) % modulus
        if bit == "0":
            a, b = c, d
        else:
            a, b = d, (6 * d - c) % modulus
    return a


def sqrt_two_power_mod(n: int, modulus: int) -> tuple[int, int]:
    """(A_n,B_n) mod modulus, where (1+sqrt(2))^n=A_n+B_n sqrt(2)."""
    ra, rb = 1, 0
    aa, ab = 1, 1
    while n:
        if n & 1:
            ra, rb = (ra * aa + 2 * rb * ab) % modulus, (ra * ab + rb * aa) % modulus
        aa, ab = (aa * aa + 2 * ab * ab) % modulus, 2 * aa * ab % modulus
        n >>= 1
    return ra, rb


def distinct_prime_factors(n: int) -> list[int]:
    ans: list[int] = []
    if n % 2 == 0:
        ans.append(2)
        while n % 2 == 0:
            n //= 2
    p = 3
    while p * p <= n:
        if n % p == 0:
            ans.append(p)
            while n % p == 0:
                n //= p
        p += 2
    if n > 1:
        ans.append(n)
    return ans


def rank_of_apparition(q: int, legendre_2: int) -> int:
    z = q - legendre_2
    for p in distinct_prime_factors(z):
        while z % p == 0 and balancing_mod(z // p, q) == 0:
            z //= p
    return z


def prime_sieve(limit: int) -> bytearray:
    sieve = bytearray(b"\x01") * (limit + 1)
    sieve[0:2] = b"\x00\x00"
    for p in range(2, math.isqrt(limit) + 1):
        if sieve[p]:
            start = p * p
            sieve[start : limit + 1 : p] = b"\x00" * (((limit - start) // p) + 1)
    return sieve


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1 << 20), b""):
            h.update(block)
    return h.hexdigest()


def main() -> None:
    here = Path(__file__).resolve().parent
    limit = int(sys.argv[1]) if len(sys.argv) > 1 else 100_000_000
    csv_path = here / "depth3_scan_100m.csv"
    expected = list(csv.DictReader(csv_path.open(newline="", encoding="utf-8")))

    sieve = prime_sieve(limit)
    rows: list[dict[str, str]] = []
    odd_prime_count = 0
    for q in range(3, limit + 1, 2):
        if not sieve[q]:
            continue
        odd_prime_count += 1
        legendre_2 = 1 if q % 8 in (1, 7) else -1
        index = q - legendre_2
        q2 = q * q
        if balancing_mod(index, q2) != 0:
            continue

        q3 = q2 * q
        residue = balancing_mod(index, q3)
        rank = rank_of_apparition(q, legendre_2)
        rank_factors = distinct_prime_factors(rank)
        rank_is_prime = len(rank_factors) == 1 and rank_factors[0] == rank
        A, B = sqrt_two_power_mod(rank, q)
        channel = "A" if A == 0 else "B" if B == 0 else "?"
        rows.append(
            {
                "q": str(q),
                "legendre_2": str(legendre_2),
                "canonical_index": str(index),
                "rank": str(rank),
                "rank_is_prime": "true" if rank_is_prime else "false",
                "channel": channel,
                "u_mod_q3": str(residue),
                "u_over_q2_mod_q": str(residue // q2),
                "status": "valuation_at_least_3" if residue == 0 else "valuation_exactly_2",
            }
        )

    assert rows == expected, (rows, expected)
    result = {
        "algorithm": "independent Python big-integer fast doubling and regenerated Eratosthenes sieve",
        "csv_sha256": sha256(csv_path),
        "depth3_hits": sum(row["status"] == "valuation_at_least_3" for row in rows),
        "limit": limit,
        "odd_primes_tested": odd_prime_count,
        "rows": rows,
        "verification": "PASS",
        "wieferich_hits": len(rows),
    }
    output = here / "depth3_scan_100m_verification.json"
    output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
