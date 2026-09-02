#!/usr/bin/env python3
"""Replay the finite residue and Wieferich checks for the slow-slack gate."""

from __future__ import annotations

import argparse
import json
from pathlib import Path


LIMIT = 100_000
OUTPUT = Path(__file__).with_name("critical_slow_slack_verification.json")


def primes_through(limit: int) -> list[int]:
    sieve = bytearray(b"\x01") * (limit + 1)
    sieve[:2] = b"\x00\x00"
    for p in range(2, int(limit**0.5) + 1):
        if sieve[p]:
            sieve[p * p : limit + 1 : p] = b"\x00" * (
                ((limit - p * p) // p) + 1
            )
    return [p for p in range(2, limit + 1) if sieve[p]]


def prime_factors(n: int) -> list[int]:
    ans: list[int] = []
    q = 2
    while q * q <= n:
        if n % q == 0:
            ans.append(q)
            while n % q == 0:
                n //= q
        q += 1 if q == 2 else 2
    if n > 1:
        ans.append(n)
    return ans


def exact_order_two(p: int) -> int:
    d = p - 1
    for q in prime_factors(d):
        while d % q == 0 and pow(2, d // q, p) == 1:
            d //= q
    assert pow(2, d, p) == 1
    assert all(pow(2, d // q, p) != 1 for q in prime_factors(d))
    return d


def canonical_depth(p: int, d: int) -> int:
    depth = 1
    modulus = p * p
    while pow(2, d, modulus) == 1:
        depth += 1
        modulus *= p
    return depth


def character_sign(p: int) -> int:
    value = pow(2, (p - 1) // 2, p)
    if value == 1:
        return 1
    if value == p - 1:
        return -1
    raise AssertionError((p, value))


def allowed_residue_table() -> dict[str, list[int]]:
    table: dict[str, list[int]] = {}
    for d_mod_8 in range(8):
        allowed: list[int] = []
        for r_mod_8 in range(8):
            p_mod_8 = (1 + d_mod_8 * r_mod_8) % 8
            if p_mod_8 % 2 == 0:
                continue
            supplementary = 1 if p_mod_8 in (1, 7) else -1
            if r_mod_8 % 2 == 0:
                exact_order_sign = 1
            elif d_mod_8 % 2 == 0:
                exact_order_sign = -1
            else:
                continue
            if supplementary == exact_order_sign:
                allowed.append(r_mod_8)
        table[str(d_mod_8)] = allowed
    return table


def build_certificate() -> dict[str, object]:
    primes = primes_through(LIMIT)
    checked_odd = 0
    hits: list[dict[str, object]] = []
    for p in primes:
        if p == 2:
            continue
        checked_odd += 1
        d = exact_order_two(p)
        r = (p - 1) // d
        sign = character_sign(p)
        assert sign == (1 if r % 2 == 0 else -1)
        assert r % 8 in allowed_residue_table()[str(d % 8)]
        if pow(2, p - 1, p * p) == 1:
            depth = canonical_depth(p, d)
            hits.append(
                {
                    "p": p,
                    "exact_order": d,
                    "canonical_depth": depth,
                    "multiplier": r,
                    "d_mod_8": d % 8,
                    "r_mod_8": r % 8,
                    "legendre_two": sign,
                    "square_divides": pow(2, d, p * p) == 1,
                    "cube_divides": pow(2, d, p * p * p) == 1,
                }
            )

    expected_hits = [
        {
            "p": 1093,
            "exact_order": 364,
            "canonical_depth": 2,
            "multiplier": 3,
            "d_mod_8": 4,
            "r_mod_8": 3,
            "legendre_two": -1,
            "square_divides": True,
            "cube_divides": False,
        },
        {
            "p": 3511,
            "exact_order": 1755,
            "canonical_depth": 2,
            "multiplier": 2,
            "d_mod_8": 3,
            "r_mod_8": 2,
            "legendre_two": 1,
            "square_divides": True,
            "cube_divides": False,
        },
    ]
    assert hits == expected_hits
    table = allowed_residue_table()
    assert table == {
        "0": [0, 2, 4, 6],
        "1": [0, 6],
        "2": [0, 1, 4, 5],
        "3": [0, 2],
        "4": [0, 1, 2, 3, 4, 5, 6, 7],
        "5": [0, 6],
        "6": [0, 3, 4, 7],
        "7": [0, 2],
    }
    return {
        "schema": "mersenne-critical-slow-slack-v1",
        "scan_limit": LIMIT,
        "prime_count": len(primes),
        "odd_prime_count": checked_odd,
        "all_odd_primes_satisfy_character_identity": True,
        "allowed_multiplier_residues_mod_8": table,
        "wieferich_hits": hits,
        "retired_exact_claim": (
            "every repeated base-two exact-order prime has even multiplier"
        ),
        "retirement_witness": 1093,
        "asymptotic_inference": (
            "finite no-hit beyond the two rows is not used"
        ),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--write", action="store_true")
    parser.add_argument("--verify", action="store_true")
    args = parser.parse_args()
    if args.write == args.verify:
        parser.error("choose exactly one of --write or --verify")

    certificate = build_certificate()
    rendered = json.dumps(certificate, indent=2, sort_keys=True) + "\n"
    if args.write:
        OUTPUT.write_text(rendered, encoding="utf-8", newline="\n")
        print(f"wrote {OUTPUT}")
        return

    recorded = OUTPUT.read_text(encoding="utf-8")
    if recorded != rendered:
        raise SystemExit("recorded certificate differs from exact recomputation")
    print(
        "PASS: residue table, 9591 odd-prime character checks, and exact "
        "Wieferich rows through 100000"
    )


if __name__ == "__main__":
    main()
