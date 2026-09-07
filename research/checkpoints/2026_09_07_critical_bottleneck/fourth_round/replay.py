"""Exact finite SE checks; not a proof of orbit uniformity or ABC.

Probability and the exponentiated entropy identity use fractions only.
No floating-point entropy estimate is treated as a certificate.
"""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
from fractions import Fraction
from hashlib import sha256
from json import dumps, loads
from math import comb, gcd
from pathlib import Path


def boundary(a, b):
    return a * b * (a + b)


def capped_depth(n, p, cap):
    e = 0
    while e < cap and n % p == 0:
        e += 1
        n //= p
    return e


def primitive_atoms(p, cap):
    return [Fraction(p - 2, p + 1)] + [
        Fraction(3 * (p - 1), (p + 1) * p**e)
        if e < cap else Fraction(3, (p + 1) * p ** (e - 1))
        for e in range(1, cap + 1)
    ]


def signed(e):
    return e - 3 if e else 0


def local_checks():
    rows = []
    for p, cap in [(5, 1), (5, 2), (5, 3), (5, 4),
                   (7, 1), (7, 2), (11, 1), (11, 2), (17, 1)]:
        modulus = p**cap
        counts = Counter()
        for a in range(modulus):
            for b in range(modulus):
                if a % p or b % p:
                    counts[capped_depth(boundary(a, b), p, cap)] += 1
        total = sum(counts.values())
        assert total == p ** (2 * cap - 2) * (p * p - 1)
        atoms = primitive_atoms(p, cap)
        assert sum(atoms) == 1
        assert all(Fraction(counts[e], total) == atoms[e]
                   for e in range(cap + 1))
        positive_count = total - counts[0]
        conditional = [Fraction(counts[e], positive_count)
                       for e in range(1, cap + 1)]
        assert all(q == (Fraction(p - 1, p**e) if e < cap
                         else Fraction(1, p ** (e - 1)))
                   for e, q in enumerate(conditional, 1))
        # Exact rational generating-function evaluations; u=p^theta is
        # rational here, and 1<u<p ensures the infinite series converges.
        moments = []
        for u in (2, 3, 4):
            finite = sum(q * Fraction(u)**(e - 3)
                         for e, q in enumerate(conditional, 1))
            infinite = Fraction(u)**(-2) * Fraction(p - 1, p - u)
            assert finite <= infinite
            unconditioned = sum(q * Fraction(u)**signed(e)
                                for e, q in enumerate(atoms))
            assert unconditioned == atoms[0] + (1-atoms[0])*finite
            moments.append([u, str(finite), str(infinite)])
        rows.append(dict(p=p, cap=cap, actual_states=total,
                         counts=[counts[e] for e in range(cap + 1)],
                         rational_moments=moments))
    return rows


def joint_check():
    modulus = 5**2 * 7
    counts = Counter()
    for a in range(modulus):
        for b in range(modulus):
            if any(a % p == b % p == 0 for p in (5, 7)):
                continue
            value = boundary(a, b)
            counts[(capped_depth(value, 5, 2),
                    capped_depth(value, 7, 1))] += 1
    total = sum(counts.values())
    q5, q7 = primitive_atoms(5, 2), primitive_atoms(7, 1)
    for e in range(3):
        for f in range(2):
            assert Fraction(counts[e, f], total) == q5[e]*q7[f]
    return dict(modulus=modulus, actual_states=total,
                joint_counts=[[e, f, counts[e, f]]
                              for e in range(3) for f in range(2)])


def factor(n):
    answer = []
    p = 2
    while p*p <= n:
        if n % p == 0:
            e = 0
            while n % p == 0:
                n //= p
                e += 1
            answer.append((p, e))
        p += 1
    if n > 1:
        answer.append((n, 1))
    return answer


def actual_entropy_check():
    seeds = [(a, b) for a in range(1, 13) for b in range(a, 13)
             if gcd(a, b) == 1]
    # Same retained support {7}, but depths one, two, four: nonzero
    # actual conditional entropy, including both signs of signed cost.
    seeds += [(1, 6), (1, 48), (1, 2400), (7**4, 11)]
    assert all(gcd(a, b) == 1 for a, b in seeds)
    groups = defaultdict(Counter)
    max_boundary = max(boundary(a, b) for a, b in seeds)
    for a, b in seeds:
        profile = [(p, e) for p, e in factor(boundary(a, b)) if p > 5]
        groups[tuple(p for p, _ in profile)][tuple(e for _, e in profile)] += 1
    entropy_exponential = Fraction(1)
    relative_entropy_exponential = Fraction(1)
    radical_exponential = Fraction(1)
    correction_exponential = Fraction(1)
    signed_exponential = Fraction(1)
    nontrivial_groups = 0
    for support, cells in sorted(groups.items()):
        support_size = sum(cells.values())
        if len(cells) > 1:
            nontrivial_groups += 1
        for depths, count in sorted(cells.items()):
            reference = Fraction(1)
            radical = 1
            correction = Fraction(1)
            signed_weight = Fraction(1)
            for p, e in zip(support, depths):
                # Choose an exact strict cap without taking logarithms.
                cap, power = 1, p
                while power <= max_boundary:
                    cap += 1
                    power *= p
                assert e < cap
                reference *= Fraction(p - 1, p**e)
                radical *= p
                correction *= Fraction(p, p - 1)
                signed_weight *= Fraction(p)**(e - 3)
            actual_conditional = Fraction(count, support_size)
            entropy_exponential *= actual_conditional**(-count)
            relative_entropy_exponential *= (actual_conditional/reference)**count
            radical_exponential *= radical**count
            correction_exponential *= correction**count
            signed_exponential *= signed_weight**count
    assert nontrivial_groups >= 1
    # These are exponentials of K times the named expectations/entropies.
    assert signed_exponential == (
        relative_entropy_exponential * entropy_exponential
        / radical_exponential**2 / correction_exponential)
    return dict(actual_seeds=len(seeds), max_boundary=max_boundary,
                support_groups=len(groups), nontrivial_conditional_groups=nontrivial_groups,
                identity="exp(K*S)=exp(K*D)*exp(K*H)/(exp(K*r)^2*exp(K*c))",
                exact_identity=True,
                signed_fraction_sha256=sha256(str(signed_exponential).encode()).hexdigest())


def count_vectors(remaining, coordinates):
    if coordinates == 0:
        return 1
    return sum(count_vectors(remaining - e, coordinates - 1)
               for e in range(1, remaining - coordinates + 2))


def height_counts():
    rows = []
    for maximum in range(13):
        counts = [count_vectors(maximum, r) for r in range(maximum + 1)]
        assert counts == [comb(maximum, r) for r in range(maximum + 1)]
        assert sum(counts) == 2**maximum
        rows.append([maximum, counts])
    return rows


def payload():
    return dict(scope="Exact finite arithmetic/probability checks, not an ABC certificate",
                local=local_checks(), joint=joint_check(),
                actual_entropy=actual_entropy_check(), height_counts=height_counts())


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    options = parser.parse_args()
    result = payload()
    canonical = dumps(result, sort_keys=True, separators=(",", ":"))
    output = dict(payload=result, canonical_sha256=sha256(canonical.encode()).hexdigest())
    path = Path(__file__).with_name("finite_replay.json")
    if options.check:
        assert loads(path.read_text(encoding="utf-8")) == output
    else:
        path.write_bytes((dumps(output, indent=2, sort_keys=True)+"\n").encode("utf-8"))
    print(dumps(dict(status="PASS", canonical_sha256=output["canonical_sha256"],
                     local_rows=len(result["local"]),
                     enumerated_local_states=sum(r["actual_states"] for r in result["local"]),
                     joint_states=result["joint"]["actual_states"],
                     actual_entropy=result["actual_entropy"]), sort_keys=True))


if __name__ == "__main__":
    main()
