#!/usr/bin/env python3
"""Independent exact audit of the WSS-escape finite claims."""

from __future__ import annotations

import json
import hashlib
import csv
import math
import sys
from pathlib import Path

if hasattr(sys, "set_int_max_str_digits"):
    sys.set_int_max_str_digits(0)

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
RECURSIVE = ROOT / "research" / "computation" / "2026_09_01_danilov_recursive_lift"
SIMPLE = ROOT / "research" / "computation" / "2026_09_01_danilov_simple_primitive_divisor"
ALPHA0 = (682, 305)
ETA = (1_730_726_404_001, 774_004_377_960)
INITIAL_FACTORS = [11, 89, 179, 199, 331, 661, 1069, 9791, 39161,
                   68531, 474541, 1801361]


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def sha256_file(path: Path) -> str:
    return sha256_bytes(path.read_bytes())


def is_prime_u64(n: int) -> bool:
    """Deterministic Miller--Rabin for n < 2^64."""
    if n < 2:
        return False
    for q in (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37):
        if n % q == 0:
            return n == q
    d, s = n - 1, 0
    while d % 2 == 0:
        d //= 2
        s += 1
    for a in (2, 325, 9375, 28178, 450775, 9780504, 1795265022):
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


def qmul(a: tuple[int, int], b: tuple[int, int], m: int) -> tuple[int, int]:
    return ((a[0] * b[0] + 5 * a[1] * b[1]) % m,
            (a[0] * b[1] + a[1] * b[0]) % m)


def qpow(a: tuple[int, int], n: int, m: int) -> tuple[int, int]:
    out = (1, 0)
    while n:
        if n & 1:
            out = qmul(out, a, m)
        a = qmul(a, a, m)
        n >>= 1
    return out


def orbit(t: int, m: int) -> tuple[int, int]:
    return qmul(ALPHA0, qpow(ETA, t, m), m)


def lvalue(A: tuple[int, int], g: tuple[int, int], r: int, m: int) -> int:
    return (2 * qmul(A, qpow(g, r, m), m)[0] + 11) % m


def fib(n: int) -> int:
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return a


def fib_mod(n: int, m: int) -> int:
    a, b = 0, 1
    for bit in bin(n)[2:]:
        c = a * ((2 * b - a) % m) % m
        d = (a * a + b * b) % m
        if bit == "0":
            a, b = c, d
        else:
            a, b = d, (c + d) % m
    return a


def factor_small(n: int) -> dict[int, int]:
    ans: dict[int, int] = {}
    q = 2
    while q * q <= n:
        while n % q == 0:
            ans[q] = ans.get(q, 0) + 1
            n //= q
        q = 3 if q == 2 else q + 2
    if n > 1:
        ans[n] = ans.get(n, 0) + 1
    return ans


def main() -> None:
    upstream = json.loads((HERE / "UPSTREAM_INPUTS.json").read_text(encoding="utf-8"))
    for row in upstream["files"]:
        assert sha256_file(ROOT / row["path"]) == row["sha256"]
    source = json.loads((RECURSIVE / "search_stage13_100m.json").read_text())
    chain = json.loads((RECURSIVE / "recursive_chain_verification.json").read_text())
    simple = json.loads((SIMPLE / "final_state_constraints.json").read_text())
    cert = json.loads((HERE / "final_branch_prime_analysis.json").read_text())

    T, Q = int(source["current_T"]), int(source["current_Q"])
    assert 3 * T + 1 == Q
    assert len(str(Q)) == 4398 == chain["final_Q_digits"] == simple["Q_digits"]
    assert chain["final_Q_distinct_prime_factors"] == 638
    assert simple["Q_distinct_factors"] == 638
    assert simple["max_Q_factor"] == 99_966_059

    # Reconstruct the exact factorization from the twelve initial factors and
    # all saved recursive-lift packets.  Also bind every stage to the hashes
    # published by the source verifier.
    factors = list(INITIAL_FACTORS)
    for name in chain["canonical_stage_files"]:
        path = RECURSIVE / name
        assert sha256_file(path) == chain["canonical_file_sha256"][name]
        stage = json.loads(path.read_text(encoding="utf-8"))
        factors.extend(int(row["p"]) for row in stage["recursive_lift_packets"])
    assert len(factors) == 638 == len(set(factors))
    assert all(p < 2 ** 64 and is_prime_u64(p) for p in factors)
    assert math.prod(factors) == Q
    assert math.gcd(Q, 30) == 1
    assert max(factors) == 99_966_059
    factor_list_text = "".join(f"{p}\n" for p in factors).encode("ascii")
    endpoint_path = RECURSIVE / "search_stage13_100m.json"

    # Divisors e with 10e <= max prime factor are the only exceptions to the
    # stronger factor-bound amplification.  Enumerate them without ever
    # constructing the 2^638 full divisor set.
    small_limit = max(factors) // 10
    small_divisors = [1]
    for p in factors:
        small_divisors += [e * p for e in small_divisors if e * p <= small_limit]
    assert len(small_divisors) == len(set(small_divisors)) == 622
    assert all(10 * e <= max(factors) for e in small_divisors)
    small_divisor_text = "".join(f"{e}\n" for e in sorted(small_divisors)).encode("ascii")

    expected_primes = [int(row["p"]) for row in source["divisors_of_L_T"]]
    rows = cert["rows"]
    assert [row["p"] for row in rows] == expected_primes
    assert expected_primes == [13, 11621, 141961, 178093, 3561881, 10685641, 59127209]
    assert cert["state_Q_digits"] == 4398

    for row in rows:
        p = row["p"]
        p2 = p * p
        d = row["step_order_mod_p"]
        A1, A2 = orbit(T, p), orbit(T, p2)
        g1, g2 = qpow(ETA, Q, p), qpow(ETA, Q, p2)
        assert qpow(g1, d, p) == (1, 0)
        for ell in row["step_order_factorization"]:
            assert qpow(g1, d // int(ell), p) != (1, 0)
        roots = row["zero_classes_mod_step_order"]
        assert len(roots) == row["zero_class_count"] == 2
        assert all(0 <= r < d and lvalue(A1, g1, r, p) == 0 for r in roots)
        assert row["step_to_order_mod_p2"] == list(qpow(g2, d, p2))
        assert qpow(g2, d, p2) != (1, 0)

        # For each recorded root, check its p^2 lift and the nonzero affine
        # slope which makes that lift unique among r0+d*s, s mod p.
        for lift in row["p2_lifts"]:
            assert lift["classification"] == "unique_lift"
            r0 = lift["root_mod_order"]
            s = lift["lift_parameter_mod_p"]
            assert r0 in roots and 0 <= s < p
            v0 = lvalue(A2, g2, r0, p2) // p % p
            v1 = lvalue(A2, g2, r0 + d, p2) // p % p
            slope = (v1 - v0) % p
            assert slope != 0 and (v0 + slope * s) % p == 0
            allowed = r0 + d * s
            assert allowed == lift["allowed_r_mod_order_times_p"]
            assert lvalue(A2, g2, allowed, p2) == 0

    # Exact auxiliary counterexamples in the report.
    f_at_minus_three = (-3) ** 4 - (-3) ** 3 + (-3) ** 2 - (-3) + 1
    fp_at_minus_three = 4 * (-3) ** 3 - 3 * (-3) ** 2 + 2 * (-3) - 1
    assert f_at_minus_three == 121 == 11 ** 2
    assert fp_at_minus_three == -142
    assert math.gcd(f_at_minus_three, abs(fp_at_minus_three)) == 1
    assert 125 % 11 != 0

    # C_110 = product_{d|110} F_d^{mu(110/d)}; all nontrivial divisors here
    # are squarefree quotients, so the quotient below is exact.
    c110 = fib(110) * fib(11) * fib(5) * fib(2) // (
        fib(55) * fib(22) * fib(10) * fib(1))
    assert c110 == 142_585_201 == 11 * 331 * 39_161
    assert fib(10) % 11 == 0 and all(fib(k) % 11 for k in range(1, 10))

    # Full-hypothesis search at the actual top indices R=Q, t=(Q-1)/3.
    # A saved simple primitive divisor p || F_(10Q) rules out squarefull K_t
    # because gcd(F_(10Q), F_(10Q-5))=5 and p>5.
    cert_path = SIMPLE / "small_fibonacci_certificates.csv"
    cert_rows = list(csv.DictReader(cert_path.open(newline="", encoding="utf-8")))
    certificate_q = {int(row["Q"]): row for row in cert_rows}
    actual_top_q = [q for q in range(2, 1001)
                    if q % 3 == 1 and math.gcd(q, 30) == 1
                    and all(e == 1 for e in factor_small(q).values())]
    ruled_out_q = sorted(set(actual_top_q) & set(certificate_q))
    unresolved_top_q = sorted(set(actual_top_q) - set(certificate_q))
    assert len(actual_top_q) == 121
    assert len(ruled_out_q) == 105
    assert unresolved_top_q == [37, 67, 133, 331, 457, 541, 553, 589,
                                619, 721, 793, 817, 877, 907, 913, 919]
    for q in ruled_out_q:
        row = certificate_q[q]
        n, p = int(row["n"]), int(row["simple_primitive_p"])
        assert n == 10 * q and p % n == 1 and is_prime_u64(p)
        assert fib_mod(n, p) == 0
        assert all(fib_mod(n // ell, p) != 0 for ell in factor_small(n))
        assert fib_mod(n, p * p) % p == 0
        assert fib_mod(n, p * p) != 0

    count = 2 ** 637
    result = {
        "status": "PASS",
        "scope": "finite exact audit; no claim of a global cover or WSS nonexistence",
        "cross_bundle_input_hashes_verified": len(upstream["files"]),
        "final_state_relation": "3*T+1=Q",
        "final_Q_digits": len(str(Q)),
        "final_Q_distinct_prime_factors": 638,
        "final_Q_squarefree": True,
        "final_Q_gcd_30": math.gcd(Q, 30),
        "final_Q_max_factor": max(factors),
        "provenance": {
            "endpoint_relative_path": endpoint_path.relative_to(ROOT).as_posix(),
            "endpoint_file_sha256": sha256_file(endpoint_path),
            "decimal_Q_sha256": sha256_bytes(str(Q).encode("ascii")),
            "ordered_factor_list_sha256": sha256_bytes(factor_list_text),
            "canonical_stage_file_count": len(chain["canonical_stage_files"]),
            "factor_construction": "12 initial factors followed by 626 packet primes in canonical stage/row order",
        },
        "forced_WSS_lower_bound_expression": "2^637",
        "forced_WSS_lower_bound_digits": len(str(count)),
        "factor_bound_amplification": {
            "max_Q_prime_factor_B": max(factors),
            "small_divisor_threshold_floor_B_over_10": small_limit,
            "exceptional_divisors_e_with_10e_le_B": len(small_divisors),
            "forced_distinct_WSS_lower_bound_expression": "2^638-622",
            "forced_distinct_WSS_lower_bound_digits": len(str(2 ** 638 - 622)),
            "sorted_exceptional_divisor_list_sha256": sha256_bytes(small_divisor_text),
        },
        "saved_primes_checked": expected_primes,
        "all_saved_primes_have_two_classes": True,
        "all_classes_have_unique_p2_lifts": True,
        "cyclotomic_derivative_counterexample": {
            "Phi10(-3)": f_at_minus_three,
            "Phi10_prime(-3)": fp_at_minus_three,
            "discriminant_Phi10": 125,
        },
        "fibonacci_cyclotomic_C110": c110,
        "bounded_full_hypothesis_search": {
            "range": "2<=Q<=1000, Q squarefree, gcd(Q,30)=1, Q=1 mod 3",
            "actual_top_indices": len(actual_top_q),
            "ruled_out_by_exact_simple_primitive_certificate": len(ruled_out_q),
            "unresolved_not_counterexamples": unresolved_top_q,
            "certificate_file_sha256": sha256_file(cert_path),
        },
    }
    (HERE / "wss_escape_verification.json").write_text(
        json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
