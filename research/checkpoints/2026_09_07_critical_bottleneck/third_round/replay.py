"""Exact finite checks for GC/OM ordinary proofs; not an ABC certificate."""
from __future__ import annotations

import argparse
from collections import Counter
from hashlib import sha256
from itertools import product
from json import dumps, loads
from math import gcd, isqrt, lcm, prod
from pathlib import Path


def mul(x, y):
    a, b = x
    c, d = y
    return a * c - b * d, a * d + b * c + b * d


def conjugate(x):
    a, b = x
    return a + b, -b


def norm(x):
    a, b = x
    return a * a + a * b + b * b


def boundary(x):
    a, b = x
    return a * b * (a + b)


def power(x, n):
    out = (1, 0)
    while n:
        if n & 1:
            out = mul(out, x)
        x = mul(x, x)
        n //= 2
    return out


def depth(n, p, cap=None):
    out = 0
    assert n != 0 or cap is not None
    while (cap is None or out < cap) and n % p == 0:
        out += 1
        n //= p
    return out


def ball(B):
    r = 2 * isqrt(B) + 2
    return [(a, b) for a in range(-r, r + 1) for b in range(-r, r + 1)
            if gcd(a, b) == 1 and norm((a, b)) <= B]


def replay():
    collision_pairs = gram = family_budgets = 0
    w = (2, 1)
    for g in range(1, 7):
        H = power(w, g)
        vs = [(a, b) for a in range(1, 8) for b in range(1, 8)
              if gcd(a, b) == 1 and gcd(*mul((a, b), H)) == 1]
        As = [abs(boundary(mul(v, H))) for v in vs]
        pair_product = 1
        for i, v in enumerate(vs):
            for j in range(i + 1, len(vs)):
                other = vs[j]
                D = abs(boundary(mul(other, conjugate(v))))
                assert D and gcd(As[i], As[j]) == gcd(As[i], D)
                assert D * D <= (norm(v) * norm(other)) ** 3
                pair_product *= gcd(As[i], As[j])
                collision_pairs += 1
                a, b = v
                c, d = other
                assert (4 * norm(v) * norm(other)
                        - (2 * a * c + a * d + b * c + 2 * b * d) ** 2
                        == 3 * (a * d - b * c) ** 2)
                gram += 1
        duplicate = prod(As) // lcm(*As)
        assert pair_product % duplicate == 0
        assert duplicate ** 2 <= prod(norm(v) ** (3 * (len(vs) - 1)) for v in vs)
        family_budgets += 1

    owner_rows = []
    for k in range(1, 6):
        g = 2 * 5 ** k
        H = power(w, g)
        first = depth(abs(boundary(H)), 5)
        second = depth(abs(boundary(mul((1, 5), H))), 5)
        assert first == k + 1 and second == 1
        owner_rows.append([k, g, first, second])

    local_rows = []
    for p, E in [(5, 1), (5, 2), (5, 3), (5, 4), (7, 1), (7, 2), (11, 1), (11, 2)]:
        q = p ** E
        chi = 1 if p % 3 == 1 else -1
        unit, primitive, unit_rotated, primitive_rotated = (Counter() for _ in range(4))
        for a in range(q):
            for b in range(q):
                if a % p == 0 and b % p == 0:
                    continue
                v = (a, b)
                s = depth(boundary(v), p, E)
                r = depth(boundary(mul(v, (3, 1))), p, E)
                primitive[s] += 1
                primitive_rotated[r] += 1
                if norm(v) % p:
                    unit[s] += 1
                    unit_rotated[r] += 1
        assert primitive == primitive_rotated and unit == unit_rotated
        np, nu = sum(primitive.values()), sum(unit.values())
        assert np == p ** (2 * E - 2) * (p * p - 1)
        assert nu == p ** (2 * E - 2) * (p - 1) * (p - chi)
        for e in range(1, E + 1):
            assert sum(n for s, n in primitive.items() if s >= e) * p ** (e - 1) * (p + 1) == 3 * np
            assert sum(n for s, n in unit.items() if s >= e) * p ** (e - 1) * (p - chi) == 3 * nu
        local_rows.append([p, E, np, nu, primitive[E], unit[E]])

    lattice_rows = []
    H = (3, 1)
    packets = [[(5, 1)], [(7, 1)], [(5, 2)], [(5, 1), (7, 1)]]
    for packet in packets:
        q = prod(p ** e for p, e in packet)
        for labels in product(range(3), repeat=len(packet)):
            count = 0
            for v in product(range(q), repeat=2):
                a, b = mul(v, H)
                arms = (a, b, a + b)
                if all(arms[label] % (p ** e) == 0 for (p, e), label in zip(packet, labels)):
                    count += 1
            assert count == q
            lattice_rows.append([q, list(labels), count])

    first_minimum_rows = []
    for packet in [[(5, 2)], [(7, 2)], [(5, 1), (7, 1)]]:
        q = prod(p ** e for p, e in packet)
        r = len(packet)
        labels = [i % 3 for i in range(r)]
        common_factors = [H for H in product(range(q), repeat=2) if gcd(norm(H), q) == 1]
        for B in (1, 3):
            residuals = ball(B)
            assert len(residuals) <= 25 * B
            annotated_hits = all_arm_hits = 0
            for H in common_factors:
                solutions = []
                annotated = False
                for v in residuals:
                    a, b = mul(v, H)
                    arms = (a, b, a + b)
                    if all(arms[label] % (p ** e) == 0 for (p, e), label in zip(packet, labels)):
                        annotated = True
                    if a * b * (a + b) % q == 0:
                        solutions.append(v)
                annotated_hits += annotated
                all_arm_hits += bool(solutions)
                assert len(solutions) % 6 == 0
                assert len(solutions) <= 2 * 3 ** r
            total = len(common_factors)
            assert annotated_hits * q * 4 ** r <= total * 25 * B * 5 ** r
            assert all_arm_hits * q * 4 ** r <= total * 25 * B * 15 ** r
            first_minimum_rows.append([q, B, total, annotated_hits, all_arm_hits])

    return {
        "schema": "abc_gc_om_finite_replay_v1",
        "scope": "Finite exact checks only; no global tail or ABC certificate.",
        "collision_pairs": collision_pairs,
        "gram_identities": gram,
        "whole_family_budgets": family_budgets,
        "owner_depth_rows": owner_rows,
        "finite_ring_rows": local_rows,
        "annotated_lattice_rows": lattice_rows,
        "first_minimum_reference_rows": first_minimum_rows,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    result = replay()
    canonical = dumps(result, sort_keys=True, separators=(",", ":"), ensure_ascii=True).encode()
    digest = sha256(canonical).hexdigest()
    output = {"canonical_sha256": digest, "result": result}
    target = Path(__file__).with_name("finite_replay.json")
    if args.check:
        assert loads(target.read_text(encoding="utf-8")) == output
    else:
        target.write_bytes((dumps(output, sort_keys=True, indent=2) + "\n").encode("utf-8"))
    print(f"PASS: {digest}; {result['collision_pairs']} collision pairs; "
          f"{len(result['finite_ring_rows'])} finite-ring rows; "
          f"{len(result['annotated_lattice_rows'])} exact-index rows; "
          f"{len(result['first_minimum_reference_rows'])} first-minimum rows")


if __name__ == "__main__":
    main()
