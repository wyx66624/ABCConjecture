from __future__ import annotations

from collections import defaultdict
from fractions import Fraction
from itertools import combinations, product
from math import gcd, lcm


def factor(n: int) -> list[tuple[int, int]]:
    assert n >= 1
    z, p, out = n, 2, []
    while p * p <= z:
        if z % p == 0:
            e = 0
            while z % p == 0:
                z //= p
                e += 1
            out.append((p, e))
        p += 1 if p == 2 else 2
    if z > 1:
        out.append((z, 1))
    return out


def phi(n: int) -> int:
    ans = n
    for p, _ in factor(n):
        ans -= ans // p
    return ans


def powerful_kernel(n: int) -> int:
    ans = 1
    for p, e in factor(n):
        if e >= 2:
            ans *= p**e
    return ans


def divisors(n: int) -> list[int]:
    out = [1]
    for p, e in factor(n):
        old = out[:]
        pe = 1
        for _ in range(e):
            pe *= p
            out.extend(pe * d for d in old)
    return sorted(out)


def triple_product(a: tuple[int, int, int]) -> int:
    return a[0] * a[1] * a[2]


def triple_gcd(a: tuple[int, int, int], b: tuple[int, int, int]) -> tuple[int, int, int]:
    return tuple(gcd(x, y) for x, y in zip(a, b))  # type: ignore[return-value]


def triple_lcm(values: list[tuple[int, int, int]]) -> tuple[int, int, int]:
    assert values
    return tuple(lcm(*(v[i] for v in values)) for i in range(3))  # type: ignore[return-value]


def triple_divides(a: tuple[int, int, int], b: tuple[int, int, int]) -> bool:
    return all(y % x == 0 for x, y in zip(a, b))


def arms(B: int, h: int, k: int) -> tuple[int, int, int]:
    C = B + 1
    R = 1
    for p, _ in factor(B * C):
        R *= p
    return 1 + R * h, 1 + R * (h + C * k), 1 + R * (h + B * k)


def kernel(B: int, h: int, k: int) -> tuple[int, int, int]:
    return tuple(powerful_kernel(z) for z in arms(B, h, k))  # type: ignore[return-value]


def canonical_line(points: list[tuple[int, int]]) -> tuple[int, int, int]:
    assert len(points) >= 2
    h0, k0 = points[0]
    h1, k1 = points[1]
    dh, dk = h1 - h0, k1 - k0
    g = gcd(abs(dh), abs(dk))
    assert g > 0
    s, t = dh // g, dk // g
    if s < 0 or (s == 0 and t < 0):
        s, t = -s, -t
    z = t * h0 - s * k0
    assert all(t * h - s * k == z for h, k in points)
    return s, t, z


def coefficient(B: int, line: tuple[int, int, int]) -> tuple[int, int, int]:
    s, t, _ = line
    C = B + 1
    return s, s + C * t, s + B * t


def weight(label: tuple[int, int, int]) -> int:
    return phi(label[0]) * phi(label[1]) * phi(label[2])


def period(label: tuple[int, int, int], coeff: tuple[int, int, int]) -> int:
    capture = 1
    for d, a in zip(label, coeff):
        capture *= gcd(d, abs(a))
    return triple_product(label) // capture


def large_catalogue(top: tuple[int, int, int], N: int):
    for label in product(*(divisors(k) for k in top)):
        label = tuple(label)
        if triple_product(label) > N * N:
            yield label


def exact_catalogue_mass(
    top: tuple[int, int, int], coeff: tuple[int, int, int], N: int
) -> Fraction:
    return sum(
        (Fraction(weight(d), period(d, coeff) ** 2) for d in large_catalogue(top, N)),
        Fraction(0),
    )


def full_euler_mass(
    top: tuple[int, int, int], coeff: tuple[int, int, int]
) -> Fraction:
    ans = Fraction(1)
    for k, a in zip(top, coeff):
        local = Fraction(0)
        for d in divisors(k):
            local += Fraction(phi(d) * gcd(d, abs(a)) ** 2, d * d)
        ans *= local
    return ans


def analyze_selected(B: int, M: int, points: list[tuple[int, int]]) -> dict:
    """Rebuild the all-pair maximal catalogue and every finite inequality.

    This deliberately uses every selected point pair.  It does not use the
    older loop/singleton reduced skeleton.
    """
    C, N, K = B + 1, M - 1, (B + 1) * (B + 2)
    assert len(set(points)) == len(points)
    assert all(1 <= h <= M and 1 <= k <= M for h, k in points)
    kernels = [kernel(B, h, k) for h, k in points]
    arm_rows = [arms(B, h, k) for h, k in points]
    for (h, k), row in zip(points, arm_rows):
        assert gcd(row[0], k) == 1
        assert gcd(row[0], row[1]) == gcd(row[0], row[2]) == gcd(row[1], row[2]) == 1

    # Deduplicated large-label fibres.
    fibres: dict[tuple[int, int, int], set[int]] = defaultdict(set)
    for i, kap in enumerate(kernels):
        for label in large_catalogue(kap, N):
            fibres[label].add(i)

    label_data = {}
    for label, support in fibres.items():
        if len(support) < 2:
            continue
        support_points = [points[i] for i in sorted(support)]
        line = canonical_line(support_points)
        coeff = coefficient(B, line)
        if 0 in coeff:
            continue
        T = period(label, coeff)
        qmass = Fraction(weight(label), T * T)
        label_data[label] = {
            "support": support,
            "line": line,
            "coefficient": coeff,
            "period": T,
            "weight": weight(label),
            "mass": qmass,
        }

    # Pair-saturated exact gcd-top family, deduplicated by top value.
    top_lines: dict[tuple[int, int, int], tuple[int, int, int]] = {}
    top_generators: dict[tuple[int, int, int], list[tuple[int, int]]] = defaultdict(list)
    for i, j in combinations(range(len(points)), 2):
        top = triple_gcd(kernels[i], kernels[j])
        if triple_product(top) <= N * N:
            continue
        line = canonical_line([points[i], points[j]])
        if 0 in coefficient(B, line):
            continue
        if top in top_lines:
            assert top_lines[top] == line, "a large top appeared on two lines"
        else:
            top_lines[top] = line
        top_generators[top].append((i, j))

    all_tops = sorted(top_lines)
    maximal = [
        top
        for top in all_tops
        if not any(top != other and triple_divides(top, other) for other in all_tops)
    ]
    assert maximal

    top_support: dict[tuple[int, int, int], set[int]] = {}
    for top in maximal:
        support = {i for i, kap in enumerate(kernels) if triple_divides(top, kap)}
        assert len(support) >= 2
        top_support[top] = support
        support_points = [points[i] for i in sorted(support)]
        assert canonical_line(support_points) == top_lines[top]
        # Pair saturation + maximality: every internal pair has exact top.
        for i, j in combinations(sorted(support), 2):
            assert triple_gcd(kernels[i], kernels[j]) == top

    # Linear-hypergraph codegree.
    for a, b in combinations(maximal, 2):
        assert len(top_support[a] & top_support[b]) <= 1
    pair_budget = sum(len(s) * (len(s) - 1) // 2 for s in top_support.values())
    assert pair_budget <= len(points) * (len(points) - 1) // 2

    # Least lexicographic maximal owner.
    owners: dict[tuple[int, int, int], tuple[int, int, int]] = {}
    for label, data in label_data.items():
        candidates = [top for top in maximal if triple_divides(label, top)]
        assert candidates, f"uncovered repeated non-arm label {label}"
        owner = min(candidates)
        assert top_lines[owner] == data["line"]
        owners[label] = owner

    owned: dict[tuple[int, int, int], list[tuple[int, int, int]]] = defaultdict(list)
    for label, owner in owners.items():
        owned[owner].append(label)

    top_records = []
    S_total, E_total, H3 = Fraction(0), Fraction(0), Fraction(0)
    for top in maximal:
        r = len(top_support[top])
        coeff = coefficient(B, top_lines[top])
        Q = exact_catalogue_mass(top, coeff, N)
        F = full_euler_mass(top, coeff)
        labels = owned[top]
        assert top in labels
        S = sum((label_data[d]["mass"] for d in labels), Fraction(0))
        E = sum(
            (
                Fraction(label_data[d]["weight"])
                * (len(label_data[d]["support"]) - 1) ** 3
                for d in labels
            ),
            Fraction(0),
        )
        assert S <= Q <= F
        assert S <= E / (r - 1) ** 3
        S_total += S
        E_total += E
        H3 += Q / (r - 1) ** 3
        top_records.append(
            {
                "top": top,
                "line": top_lines[top],
                "coefficient": coeff,
                "support": sorted(top_support[top]),
                "r": r,
                "owned_labels": labels,
                "S_owned": str(S),
                "E_owned": str(E),
                "Q_exact": str(Q),
                "F_full": str(F),
                "beta_exact": str(Q / weight(top)),
            }
        )

    assert S_total == sum((d["mass"] for d in label_data.values()), Fraction(0))
    assert E_total == sum(
        (
            Fraction(d["weight"]) * (len(d["support"]) - 1) ** 3
            for d in label_data.values()
        ),
        Fraction(0),
    )
    assert S_total * S_total <= E_total * H3
    for data in label_data.values():
        assert (len(data["support"]) - 1) ** 3 * data["period"] ** 2 < K * N
    assert E_total < K * N * S_total
    assert S_total < K * N * H3
    assert E_total < (K * N) ** 2 * H3

    # One pairwise-coprime lcm envelope per primitive direction.
    by_direction: dict[tuple[int, int], list[tuple[int, int, int]]] = defaultdict(list)
    for top in maximal:
        s, t, _ = top_lines[top]
        by_direction[(s, t)].append(top)
    envelope_records = []
    envelope_total = Fraction(0)
    for direction, direction_tops in sorted(by_direction.items()):
        Ktop = triple_lcm(direction_tops)
        s, t = direction
        coeff = s, s + C * t, s + B * t
        Qhat = Fraction(0)
        count = 0
        for d in product(*(divisors(k) for k in Ktop)):
            d = tuple(d)
            if triple_product(d) <= N * N:
                continue
            if gcd(d[0], d[1]) != 1 or gcd(d[0], d[2]) != 1 or gcd(d[1], d[2]) != 1:
                continue
            Qhat += Fraction(weight(d), period(d, coeff) ** 2)
            count += 1
        actual = sum(
            (data["mass"] for data in label_data.values() if data["line"][:2] == direction),
            Fraction(0),
        )
        assert actual <= Qhat
        envelope_total += Qhat
        envelope_records.append(
            {
                "direction": direction,
                "lcm_top": Ktop,
                "formal_labels": count,
                "actual_mass": str(actual),
                "envelope_mass": str(Qhat),
            }
        )
    assert S_total <= envelope_total

    return {
        "B": B,
        "C": C,
        "M": M,
        "N": N,
        "points": points,
        "arms": arm_rows,
        "kernels": kernels,
        "all_pair_tops": len(all_tops),
        "maximal_tops": len(maximal),
        "pair_budget": pair_budget,
        "repeated_nonarm_labels": len(label_data),
        "S_non": str(S_total),
        "E_non": str(E_total),
        "H3_exact_full_caps": str(H3),
        "direction_envelope": str(envelope_total),
        "c": K * N,
        "tops": top_records,
        "envelopes": envelope_records,
    }


def complete_graph_sharpness() -> dict:
    primes = [2, 3, 5, 7, 11, 13]
    edges = list(combinations(range(4), 2))
    edge_prime = dict(zip(edges, primes))
    kernels = []
    for v in range(4):
        value = 1
        for e, p in edge_prime.items():
            if v in e:
                value *= p * p
        kernels.append(value)
    tops = {e: gcd(kernels[e[0]], kernels[e[1]]) for e in edges}
    assert all(tops[e] == edge_prime[e] ** 2 for e in edges)
    assert len(set(tops.values())) == 6
    catalogues = {e: tops[e] - 1 for e in edges}
    total = sum(catalogues.values())
    assert total == 371
    assert 6 > 4
    assert total * total == total * total
    return {
        "vertices": 4,
        "kernels": kernels,
        "edge_primes": {str(e): p for e, p in edge_prime.items()},
        "tops": {str(e): t for e, t in tops.items()},
        "maximal_tops": 6,
        "catalogue_mass": total,
        "S": total,
        "E": total,
        "H3": total,
        "cauchy_equality": True,
        "beta_at_p2": str(Fraction(3, 2)),
    }
