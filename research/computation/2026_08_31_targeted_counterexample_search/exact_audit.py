#!/usr/bin/env python3
"""Independent exact audit of the two finite counterexample searches.

No conclusion beyond the printed finite ranges is encoded here.  The script
recomputes all recurrences with Python integers, checks every exponent-one
certificate modulo p^2, verifies the Hall identities and gcd conditions, and
emits transparent factor/Pocklington certificates for the few auxiliary
primality claims not covered by deterministic 64-bit Miller--Rabin.
"""

from __future__ import annotations

import csv
import hashlib
import json
import math
import random
from collections import Counter
from pathlib import Path

from factordb_fallback import balancing, balancing_mod, is_prime_u64

HERE = Path(__file__).resolve().parent


def sha256_text(value: int) -> str:
    return hashlib.sha256(str(value).encode("ascii")).hexdigest()


def pollard_brent(n: int) -> int:
    if n % 2 == 0:
        return 2
    if n % 3 == 0:
        return 3
    # Fixed seeds make the artifact reproducible.
    for seed in range(1, 100):
        rng = random.Random((n & ((1 << 64) - 1)) ^ seed)
        y = rng.randrange(1, n - 1)
        c = rng.randrange(1, n - 1)
        m = 128
        g = r = q = 1
        x = ys = 0
        while g == 1:
            x = y
            for _ in range(r):
                y = (y * y + c) % n
            k = 0
            while k < r and g == 1:
                ys = y
                for _ in range(min(m, r - k)):
                    y = (y * y + c) % n
                    q = q * abs(x - y) % n
                g = math.gcd(q, n)
                k += m
            r <<= 1
        if g == n:
            while True:
                ys = (ys * ys + c) % n
                g = math.gcd(abs(x - ys), n)
                if g > 1:
                    break
        if g != n:
            return g
    raise RuntimeError(f"Pollard--Brent failed on {n}")


def factor_u64(n: int) -> Counter[int]:
    assert 0 < n < 2**64
    out: list[int] = []

    def rec(q: int) -> None:
        if q == 1:
            return
        if is_prime_u64(q):
            out.append(q)
            return
        d = pollard_brent(q)
        rec(d)
        rec(q // d)

    rec(n)
    return Counter(sorted(out))


def factor_small_supported(n: int) -> Counter[int]:
    """Factor the selected Danilov K values whose factors are all small.

    Trial division is deliberately simple and independently reproducible.
    The call sites are restricted to t=0,1,2,3 and assert completion.
    """
    out: Counter[int] = Counter()
    while n % 2 == 0:
        out[2] += 1
        n //= 2
    p = 3
    while p * p <= n:
        while n % p == 0:
            out[p] += 1
            n //= p
        p += 2
    if n > 1:
        out[n] += 1
    return out


def factor_product(factors: Counter[int]) -> int:
    ans = 1
    for p, e in factors.items():
        ans *= p**e
    return ans


def pocklington_certificate(n: int, n_minus_one_factors: Counter[int]) -> dict:
    assert factor_product(n_minus_one_factors) == n - 1
    witnesses = {}
    for q in sorted(n_minus_one_factors):
        assert q < 2**64 and is_prime_u64(q)
        for a in range(2, 100000):
            if pow(a, n - 1, n) == 1 and math.gcd(pow(a, (n - 1) // q, n) - 1, n) == 1:
                witnesses[str(q)] = a
                break
        else:
            raise AssertionError(f"no Pocklington witness for q={q}, n={n}")
    assert n - 1 > math.isqrt(n)
    return {
        "n": str(n),
        "n_minus_one_factorization": {str(p): e for p, e in sorted(n_minus_one_factors.items())},
        "witnesses_by_prime_divisor": witnesses,
        "F": str(n - 1),
        "F_gt_sqrt_n": True,
        "verification": "all modular and gcd conditions rechecked locally",
    }


def make_large_prime_certificates() -> dict[int, dict]:
    p59 = 13558774610046711780701
    f59 = Counter({2: 2, 5: 2, 7: 1, 29: 1, 31: 2, 41: 1, 269: 1, 63018038201: 1})
    p937 = 27633725151978798737
    f937 = Counter({2: 4, 13: 1, 937: 1, 6641359: 1, 21349099: 1})
    certs = {
        p59: pocklington_certificate(p59, f59),
        p937: pocklington_certificate(p937, f937),
    }
    (HERE / "pocklington_certificates.json").write_text(
        json.dumps({str(p): c for p, c in certs.items()}, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    return certs


def audit_balancing() -> dict:
    pocklington = make_large_prime_certificates()
    base_rows = list(csv.DictReader((HERE / "balancing_certificates.csv").open(newline="", encoding="utf-8")))
    fallback_rows = {
        int(r["n"]): r for r in csv.DictReader(
            (HERE / "balancing_factordb_certificates.csv").open(newline="", encoding="utf-8")
        )
    }
    deep_rows = {}
    for name in (
        "balancing_deep_prime_index_certificates_500m_10b.csv",
        "balancing_deep_prime_index_certificates_10b_50b.csv",
    ):
        for r in csv.DictReader((HERE / name).open(newline="", encoding="utf-8")):
            if r["status"] == "not_squarefull":
                deep_rows[int(r["n"])] = r
    inherited_rows = {
        # 1711 = 29*59.  The exponent-one prime already found at index 29
        # survives at index 1711; the exact modulus-p^2 check below is the
        # certificate, so no valuation formula is assumed by the verifier.
        1711: {"p": "44560482149"},
    }
    merged = []
    prime_indices = 0
    methods: Counter[str] = Counter()
    for row in base_rows:
        n = int(row["n"])
        if n > 1000:
            continue
        if row["status"] == "not_squarefull":
            p = int(row["p"])
            residue = int(row["residue_mod_p2"])
            method = row["method"]
            prime_basis = "local deterministic Miller-Rabin (<2^64)"
        else:
            f = fallback_rows[n]
            p = int(f["p"])
            residue = int(f["residue_mod_p2"])
            method = "FactorDB candidate discovery + local modular verification"
            prime_basis = f["prime_basis"]
        if p < 2**64:
            assert is_prime_u64(p)
            prime_basis = "local deterministic Miller-Rabin (<2^64)"
        else:
            assert p in pocklington
            prime_basis = "local Pocklington certificate"
        local_residue = balancing_mod(n, p * p)
        assert local_residue == residue
        assert local_residue % p == 0 and local_residue != 0
        is_prime_index = is_prime_u64(n)
        prime_indices += int(is_prime_index)
        methods[method] += 1
        merged.append({
            "n": n,
            "is_prime_index": int(is_prime_index),
            "p": str(p),
            "u_n_mod_p2": str(local_residue),
            "u_n_over_p_mod_p": str(local_residue // p),
            "prime_basis": prime_basis,
            "candidate_discovery": method,
            "conclusion": "v_p(u_n)=1; u_n is not squarefull",
        })
    assert len(merged) == 999
    assert {r["n"] for r in merged} == set(range(2, 1001))

    fields = list(merged[0])
    with (HERE / "balancing_certificates_2_1000.csv").open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=fields)
        writer.writeheader()
        writer.writerows(merged)

    complete = {}
    for n in range(2, 27):
        u = balancing(n)
        assert u < 2**64
        factors = factor_u64(u)
        assert factor_product(factors) == u
        assert all(is_prime_u64(p) for p in factors)
        complete[str(n)] = {
            "u_n": str(u),
            "factorization": {str(p): e for p, e in sorted(factors.items())},
            "all_primes_locally_deterministic": True,
            "squarefull": all(e >= 2 for e in factors.values()),
        }
    (HERE / "balancing_complete_factorizations_2_26.json").write_text(
        json.dumps(complete, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    assert not any(v["squarefull"] for v in complete.values())

    extended = []
    extended_unresolved = []
    extended_prime_indices = 0
    for row in base_rows:
        n = int(row["n"])
        is_prime_index = is_prime_u64(n)
        extended_prime_indices += int(is_prime_index)
        if row["status"] == "not_squarefull":
            p = int(row["p"])
            residue = int(row["residue_mod_p2"])
            method = row["method"]
        elif n in fallback_rows:
            f = fallback_rows[n]
            p = int(f["p"])
            residue = int(f["residue_mod_p2"])
            method = "FactorDB candidate discovery + local modular verification"
        elif n in deep_rows:
            f = deep_rows[n]
            p = int(f["p"])
            residue = int(f["residue_mod_p2"])
            method = "deep prime-index congruence search"
        elif n in inherited_rows:
            p = int(inherited_rows[n]["p"])
            residue = balancing_mod(n, p * p)
            method = "composite-index inheritance from n=29 + local modular verification"
        else:
            extended_unresolved.append(n)
            continue
        if p < 2**64:
            assert is_prime_u64(p)
            prime_basis = "local deterministic Miller-Rabin (<2^64)"
        else:
            assert p in pocklington
            prime_basis = "local Pocklington certificate"
        local_residue = balancing_mod(n, p * p)
        assert local_residue == residue
        assert local_residue % p == 0 and local_residue != 0
        extended.append({
            "n": n,
            "is_prime_index": int(is_prime_index),
            "p": str(p),
            "u_n_mod_p2": str(local_residue),
            "u_n_over_p_mod_p": str(local_residue // p),
            "prime_basis": prime_basis,
            "candidate_discovery": method,
            "conclusion": "v_p(u_n)=1; u_n is not squarefull",
        })
    assert len(extended) + len(extended_unresolved) == 1999
    with (HERE / "balancing_certificates_resolved_2_2000.csv").open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(extended[0]))
        writer.writeheader()
        writer.writerows(extended)
    inherited_output = [r for r in extended if r["n"] in inherited_rows]
    with (HERE / "balancing_composite_inheritance_certificates.csv").open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(extended[0]))
        writer.writeheader()
        writer.writerows(inherited_output)

    summary = {
        "definition": "u_0=0, u_1=1, u_{n+2}=6u_{n+1}-u_n",
        "searched_nonunit_range": "2 <= n <= 1000",
        "terms_checked": 999,
        "prime_indices_checked": prime_indices,
        "squarefull_nonunit_hits": [],
        "trivial_positive_hit": {"n": 1, "u_n": 1, "qualification": "1 is squarefull vacuously"},
        "complete_local_factorization_range": "2 <= n <= 26",
        "complete_local_factorizations": 25,
        "exponent_one_certificates": 999,
        "certificate_discovery_methods": dict(methods),
        "verification": (
            "Every p is prime by deterministic 64-bit Miller-Rabin or one of two "
            "saved local Pocklington certificates; every recurrence is recomputed "
            "modulo p^2 and satisfies p | u_n but p^2 does not divide u_n."
        ),
        "scope_limit": (
            "This proves only that u_n is non-squarefull for 2<=n<=1000. "
            "It does not imply eventual non-squarefullness or close the Pell route."
        ),
        "extended_exploratory_range": "2 <= n <= 2000",
        "extended_terms_with_verified_exponent_one_certificate": len(extended),
        "extended_prime_indices_total": extended_prime_indices,
        "extended_unresolved_indices": extended_unresolved,
        "extended_qualification": (
            "The unresolved indices are not hits and not misses: no complete "
            "factorization or exponent-one prime was obtained within the stated "
            "search windows."
        ),
    }
    (HERE / "balancing_exact_audit.json").write_text(
        json.dumps(summary, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    return summary


def mul_unit(x: tuple[int, int], y: tuple[int, int]) -> tuple[int, int]:
    a, b = x
    c, d = y
    return a * c + 5 * b * d, a * d + b * c


def unit_power(k: int) -> tuple[int, int]:
    r, q = (1, 0), (9, 4)
    while k:
        if k & 1:
            r = mul_unit(r, q)
        q = mul_unit(q, q)
        k >>= 1
    return r


def poly_mul(f: list[int], g: list[int]) -> list[int]:
    out = [0] * (len(f) + len(g) - 1)
    for i, a in enumerate(f):
        for j, b in enumerate(g):
            out[i + j] += a * b
    while len(out) > 1 and out[-1] == 0:
        out.pop()
    return out


def poly_pow(f: list[int], n: int) -> list[int]:
    out = [1]
    for _ in range(n):
        out = poly_mul(out, f)
    return out


def audit_danilov() -> dict:
    # Coefficients are in increasing powers of z.
    A_poly, B_poly, norm_poly = [4, 6, 1], [19, 9, 1], [1, 0, 1]
    left = poly_pow(A_poly, 3)
    right_product = poly_mul(norm_poly, poly_pow(B_poly, 2))
    width = max(len(left), len(right_product))
    identity_difference = [
        (left[i] if i < len(left) else 0)
        - (right_product[i] if i < len(right_product) else 0)
        for i in range(width)
    ]
    while len(identity_difference) > 1 and identity_difference[-1] == 0:
        identity_difference.pop()
    assert identity_difference == [-297, -54]
    eta = unit_power(10)
    assert eta == (1730726404001, 774004377960)
    assert eta[0] * eta[0] - 5 * eta[1] * eta[1] == 1
    assert (eta[0] % 125, eta[1] % 125) == (1, 85)

    first_returns = []
    unit_rows = []
    for k in range(1, 11):
        a, b = unit_power(k)
        zk = a * 682 + 5 * b * 305
        wk = b * 682 + a * 305
        unit_rows.append({
            "k": k, "a_mod_125": a % 125, "b_mod_125": b % 125,
            "z_k_mod_125": zk % 125, "w_k_mod_125": wk % 125,
            "returns_z_congruence_57": int(zk % 125 == 57),
        })
        if zk % 125 == 57:
            first_returns.append(k)
    assert first_returns == [10]
    with (HERE / "danilov_unit_residues_1_10.csv").open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(unit_rows[0]))
        writer.writeheader()
        writer.writerows(unit_rows)
    order = None
    residue = (1, 0)
    for k in range(1, 1001):
        residue = ((9 * residue[0] + 20 * residue[1]) % 125,
                   (4 * residue[0] + 9 * residue[1]) % 125)
        if residue == (1, 0):
            order = k
            break
    assert order == 250

    cert_rows = {
        int(r["t"]): r for r in csv.DictReader(
            (HERE / "danilov_certificates.csv").open(newline="", encoding="utf-8")
        )
    }
    points = []
    z, w = 682, 305
    complete = {}
    for t in range(81):
        assert z > 0 and w > 0
        assert z * z - 5 * w * w == -1
        assert z % 125 == 57
        assert w % 5 == 0
        A = z * z + 6 * z + 4
        B = z * z + 9 * z + 19
        L = 2 * z + 11
        assert A % 5 == 0 and w * B % 5 == 0 and L % 125 == 0
        X, Y, K = A // 5, w * B // 5, 27 * L // 125
        assert X**3 + K == Y**2
        assert math.gcd(X, Y) == math.gcd(X, K) == math.gcd(Y, K) == 1
        assert K * K <= X

        c = cert_rows[t]
        assert c["status"] == "K_not_squarefull"
        p = int(c["p"])
        assert p not in (3, 5) and is_prime_u64(p)
        assert L % p == 0 and L % (p * p) != 0
        assert K % p == 0 and K % (p * p) != 0
        assert L % (p * p) == int(c["L_mod_p2"])
        points.append({
            "t": t,
            "z": str(z),
            "w": str(w),
            "X": str(X),
            "Y": str(Y),
            "K": str(K),
            "decimal_digits_K": len(str(K)),
            "exponent_one_prime_p": p,
            "K_mod_p2": str(K % (p * p)),
            "K_over_p_mod_p": str((K % (p * p)) // p),
            "pell_verified": 1,
            "hall_identity_verified": 1,
            "pairwise_coprime_verified": 1,
            "K_squared_le_X_verified": 1,
            "conclusion": "v_p(K)=1; K is not squarefull",
        })
        if t <= 3:
            factors = factor_small_supported(K)
            assert factor_product(factors) == K
            assert all(p0 < 2**64 and is_prime_u64(p0) for p0 in factors)
            complete[str(t)] = {
                "K": str(K),
                "factorization": {str(p0): e for p0, e in sorted(factors.items())},
                "all_primes_locally_deterministic": True,
                "squarefull": all(e >= 2 for e in factors.values()),
            }
        z, w = eta[0] * z + 5 * eta[1] * w, eta[1] * z + eta[0] * w

    with (HERE / "danilov_points_0_80.csv").open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(points[0]))
        writer.writeheader()
        writer.writerows(points)
    (HERE / "danilov_complete_factorizations_0_3.json").write_text(
        json.dumps(complete, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    assert not any(v["squarefull"] for v in complete.values())

    selected_primes = sorted({int(r["exponent_one_prime_p"]) for r in points})
    periodic = {}
    period_cover = {}
    for p in selected_primes:
        modulus = p * p
        z0, w0 = 682 % modulus, 305 % modulus
        zz, ww = z0, w0
        covered = []
        for tt in range(1, 10_000_001):
            ll = (2 * zz + 11) % modulus
            if ll % p == 0 and ll != 0:
                covered.append(tt - 1)
            zz, ww = ((eta[0] * zz + 5 * eta[1] * ww) % modulus,
                      (eta[1] * zz + eta[0] * ww) % modulus)
            if (zz, ww) == (z0, w0):
                period = tt
                break
        else:
            raise AssertionError(f"period search failed for p={p}")
        periodic[str(p)] = {"state_period_mod_p2": period, "covered_residues": covered}
        period_cover[p] = (period, set(covered))
    joint_period = math.lcm(*(period for period, _ in period_cover.values()))
    first_uncovered = None
    for tt in range(joint_period):
        if not any(tt % period in covered for period, covered in period_cover.values()):
            first_uncovered = tt
            break
    assert first_uncovered == 326
    periodic_diagnostic = {
        "selected_primes": selected_primes,
        "per_prime": periodic,
        "joint_period": joint_period,
        "first_index_not_covered_by_these_five_periodic_sieves": first_uncovered,
        "qualification": (
            "The five primes certify t=0..80 but do not cover all t; this "
            "periodic calculation is a guard against extrapolating the finite search."
        ),
    }
    (HERE / "danilov_small_prime_periods.json").write_text(
        json.dumps(periodic_diagnostic, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )

    summary = {
        "pell_equation": "z^2 - 5 w^2 = -1",
        "base_point": [682, 305],
        "base_congruence": "z == 57 (mod 125)",
        "norm_one_generator": [9, 4],
        "least_positive_power_returning_the_base_point_z_congruence": 10,
        "chosen_step_eta": [str(eta[0]), str(eta[1])],
        "eta_mod_125": [1, 85],
        "full_ring_order_mod_125": order,
        "searched_orbit_range": "0 <= t <= 80",
        "points_checked": 81,
        "squarefull_K_hits": [],
        "certificate_primes": selected_primes,
        "selected_prime_sieve_first_uncovered_index": first_uncovered,
        "complete_local_factorization_range": "0 <= t <= 3",
        "complete_local_factorizations": 4,
        "exponent_one_certificates": 81,
        "all_points_verified": [
            "symbolic Danilov polynomial identity", "Pell equation", "z congruence", "integrality of X,Y,K",
            "X^3+K=Y^2", "pairwise gcd 1", "K^2<=X",
            "p prime and v_p(K)=1",
        ],
        "scope_limit": (
            "This proves only that the first 81 points of this forward orbit "
            "have non-squarefull K. It does not rule out a later or different "
            "squarefull subsequence and does not close the Danilov route."
        ),
    }
    (HERE / "danilov_exact_audit.json").write_text(
        json.dumps(summary, indent=2, sort_keys=True) + "\n", encoding="utf-8"
    )
    return summary


def main() -> None:
    b = audit_balancing()
    d = audit_danilov()
    print(json.dumps({"balancing": b, "danilov": d}, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
