#!/usr/bin/env python3
"""Exact finite checks accompanying REPORT.md.

Only Python's standard library is used.  None of these finite checks is used
as a proof of an asymptotic lower bound.
"""

from fractions import Fraction
from math import gcd, isqrt


def factor(n: int) -> dict[int, int]:
    ans: dict[int, int] = {}
    p = 2
    while p * p <= n:
        while n % p == 0:
            ans[p] = ans.get(p, 0) + 1
            n //= p
        p += 1
    if n > 1:
        ans[n] = ans.get(n, 0) + 1
    return ans


def radical(n: int) -> int:
    ans = 1
    for p in factor(n):
        ans *= p
    return ans


def cofactors(a: int, b: int, c: int, q: int, h: int, k: int):
    return 1 + q * h, 1 + q * (h + c * k), 1 + q * (h + b * k)


def check_generalized_shear() -> None:
    cases = [(1, 8, 9), (5, 27, 32), (3, 4, 7)]
    checked = 0
    for a, b, c in cases:
        assert a + b == c and gcd(a, b) == 1
        pprod = a * b * c
        rseed = radical(pprod)
        for q in sorted({rseed, 2 * rseed, pprod}):
            assert q % rseed == 0
            uv_seen, uw_seen, vw_seen = {}, {}, {}
            for h in range(1, 51):
                for k in range(1, 51):
                    u, v, w = cofactors(a, b, c, q, h, k)
                    assert a * u + b * v == c * w
                    assert gcd(u * v * w, pprod) == 1
                    if gcd(u, k) != 1:
                        continue
                    assert gcd(u, v) == gcd(u, w) == gcd(v, w) == 1
                    A, B, C = a * u, b * v, c * w
                    assert gcd(A, B) == gcd(A, C) == gcd(B, C) == 1
                    for table, key in ((uv_seen, (u, v)),
                                       (uw_seen, (u, w)),
                                       (vw_seen, (v, w))):
                        assert key not in table or table[key] == (h, k)
                        table[key] = (h, k)
                    checked += 1

            # Every Q=s*rad(P) point is the minimal-support point at (s*h,s*k).
            s = q // rseed
            for h in range(1, 11):
                for k in range(1, 11):
                    assert cofactors(a, b, c, q, h, k) == \
                        cofactors(a, b, c, rseed, s * h, s * k)
                    u, _, _ = cofactors(a, b, c, q, h, k)
                    if gcd(u, k) == 1:
                        assert gcd(u, s * k) == 1

    print(f"generalized_shear_checked_admissible_points={checked}")


def check_raw_scale() -> None:
    a, b, c = 1, 8, 9
    pprod = a * b * c
    rseed = radical(pprod)
    m_min = c**6 // (4 * rseed)
    m_old = c**6 // (4 * pprod)
    assert (m_min, m_old) == (22143, 1845)
    print(f"seed=(1,8,9) P={pprod} radical={rseed}")
    print(f"K8_side_minimal={m_min} K8_side_old={m_old}")
    print(f"elementary_raw_lower_minimal={m_min*m_min//8} "
          f"elementary_raw_lower_old={m_old*m_old//8}")
    # Exact membership in the lambda=9/10 subcritical locus.
    assert rseed**10 < c**9
    print("seed_satisfies_radical_lt_c_pow_9_over_10=true")


def check_local_laws() -> None:
    a, b, c, q = 1, 8, 9, 6
    for p in (2, 3):
        for h in range(20):
            for k in range(20):
                assert all(x % p for x in cofactors(a, b, c, q, h, k))
    print("source_prime_avoidance_checked_for_p=2,3")

    for p in (5, 7, 11):
        mod = p * p
        admissible = 0
        square_counts = [0, 0, 0]
        intersections = 0
        for h in range(mod):
            for k in range(mod):
                u, v, w = cofactors(a, b, c, q, h, k)
                local_adm = not (u % p == 0 and k % p == 0)
                if not local_adm:
                    continue
                admissible += 1
                hits = [u % mod == 0, v % mod == 0, w % mod == 0]
                square_counts = [x + int(y) for x, y in zip(square_counts, hits)]
                intersections += int(sum(hits) >= 2)
        assert admissible == p**4 - p**2
        assert square_counts == [p**2 - p] * 3
        assert intersections == 0
        print(f"p={p} admissible={admissible} square_counts={square_counts} "
              f"pair_intersections={intersections}")


def check_prime_power_template() -> None:
    # Pairwise-coprime high-power moduli, all away from the seed support 2*3.
    a, b, c, q = 1, 8, 9, 6
    ds = (25, 49, 121)
    forms = (
        lambda h, k: 1 + q * h,
        lambda h, k: 1 + q * (h + c * k),
        lambda h, k: 1 + q * (h + b * k),
    )
    local_counts = []
    for d, form in zip(ds, forms):
        count = sum(form(h, k) % d == 0 for h in range(d) for k in range(d))
        assert count == d
        local_counts.append(count)
    D = ds[0] * ds[1] * ds[2]
    crt_count = local_counts[0] * local_counts[1] * local_counts[2]
    certified_excess = 1
    for d in ds:
        certified_excess *= d // radical(d)
    assert crt_count == D == 148225
    assert certified_excess == 385
    print(f"template_moduli={ds} local_counts={local_counts}")
    print(f"CRT_period={D} CRT_solutions={crt_count} density=1/{D} "
          f"certified_excess={certified_excess} "
          f"density_cost_over_excess={D//certified_excess}")


def check_exponent_ledgers() -> None:
    eta = Fraction(1, 4)
    eps = eta / 2
    assert eta - eps == Fraction(1, 8)
    # If lower constant is L and upper constant is U, cancellation gives
    # c^(eta-eps) <= U/L; hence c <= (U/L)^8 in this replayed example.
    print("gate_comparison_eta=1/4 upper_epsilon=1/8 residual_gap=1/8")
    # Positive contact gives c <= 2*R; on R<c^(9/10), c^(1/10)<2.
    assert 2**10 == 1024
    print("positive_contact_lambda=9/10_implies_c<1024")


def check_square_completion_is_insufficient() -> None:
    a, b, c, rseed = 1, 8, 9, 6
    rows = [(6, 840, 60), (72, 70, 5), (72, 1160, 798)]
    for q, h, k in rows:
        u, v, w = cofactors(a, b, c, q, h, k)
        assert gcd(u, k) == 1
        assert all(isqrt(x) ** 2 == x for x in (u, v, w))
        H = c * w
        rr = rseed * radical(u) * radical(v) * radical(w)
        assert rr**4 >= H**3
        print(f"square_cofactor_row=({q},{h},{k}) U={u} V={v} W={w} "
              f"H={H} radical={rr} exceptional=false")


if __name__ == "__main__":
    print("AFFINE_MATCHING_LOWER_GATE_EXACT_REPLAY")
    check_generalized_shear()
    check_raw_scale()
    check_local_laws()
    check_prime_power_template()
    check_exponent_ledgers()
    check_square_completion_is_insufficient()
    print("ALL_CHECKS_PASSED")
