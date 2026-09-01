#!/usr/bin/env python3
"""Exact audit of the saved bounded Danilov recursive-lift chain.

This verifier checks every saved packet modulo p^2, the CRT transitions,
the Fibonacci valuation-one interpretation, and the state invariant.  The
absence of omitted primes below a search endpoint is verified by replaying
search_recursive_lifts.py as described in REPRODUCE.md, not by this audit.
"""

from __future__ import annotations

import hashlib
import json
import math
import sys
from pathlib import Path

if hasattr(sys, "set_int_max_str_digits"):
    sys.set_int_max_str_digits(0)

HERE = Path(__file__).resolve().parent
ALPHA0 = (682, 305)
ETA = (1_730_726_404_001, 774_004_377_960)
FIXED = 3375
INITIAL_FACTORS = [11, 89, 179, 199, 331, 661, 1069, 9791, 39161,
                   68531, 474541, 1801361]
FILES = [
    "search_stage0_1m.json",
    "search_stage1_1m.json",
    "search_stage2_1m.json",
    "search_stage3_1m.json",
    "search_stage4_1m.json",
    "search_stage5_1m.json",
    "search_stage6_1m.json",
    "search_stage7_10m.json",
    "search_stage8_10m.json",
    "search_stage9_10m.json",
    "search_stage10_50m.json",
    "search_stage11_50m.json",
    "search_stage12_100m.json",
    "search_stage13_100m.json",
]


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
    return qmul((ALPHA0[0] % m, ALPHA0[1] % m),
                qpow((ETA[0] % m, ETA[1] % m), t, m), m)


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


def is_prime_u64(n: int) -> bool:
    if n < 2:
        return False
    for p in (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37):
        if n % p == 0:
            return n == p
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


def crt_pair(a: int, m: int, b: int, p: int) -> tuple[int, int]:
    return a + m * ((b - a) * pow(m, -1, p) % p), m * p


def sha(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main() -> None:
    assert ALPHA0[0] ** 2 - 5 * ALPHA0[1] ** 2 == -1
    assert ETA[0] ** 2 - 5 * ETA[1] ** 2 == 1
    stages = [json.loads((HERE / f).read_text(encoding="utf-8")) for f in FILES]
    q0 = int(stages[0]["current_Q"])
    assert math.prod(INITIAL_FACTORS) == q0
    assert len(set(INITIAL_FACTORS)) == len(INITIAL_FACTORS)
    assert all(is_prime_u64(p) for p in INITIAL_FACTORS)

    packet_primes: list[int] = []
    stage_summary = []
    expected_q = q0
    for i, (name, data) in enumerate(zip(FILES, stages)):
        T, Q = int(data["current_T"]), int(data["current_Q"])
        assert Q == expected_q
        assert 0 < T < Q and math.gcd(T, Q) == 1
        assert (3 * T + 1) % Q == 0
        h = (3 * T + 1) // Q
        assert h in (1, 2)

        for row in data["divisors_of_L_T"]:
            p = int(row["p"])
            assert is_prime_u64(p) and math.gcd(p, FIXED * Q) == 1
            p2 = p * p
            L = (2 * orbit(T, p2)[0] + 11) % p2
            assert L == int(row["L_T_mod_p2"]) and L % p == 0
            assert (L // p % p) == int(row["L_T_over_p_mod_p"])
            assert bool(row["valuation_exactly_one"]) == (L != 0)

        r_batch, m_batch = 0, 1
        for row in data["recursive_lift_packets"]:
            p = int(row["p"])
            assert is_prime_u64(p) and math.gcd(p, FIXED * Q) == 1
            assert p not in packet_primes
            p2 = p * p
            base = orbit(T, p2)
            step = qpow((ETA[0] % p2, ETA[1] % p2), Q, p2)
            assert list(base) == row["alpha_T_mod_p2"]
            assert list(step) == row["eta_pow_Q_mod_p2"]
            assert (step[0] - 1) % p == 0 and step[1] % p == 0
            c = ((2 * base[0] + 11) % p2) // p % p
            d = step[1] // p % p
            slope = 10 * (base[1] % p) * d % p
            assert c == int(row["L_T_over_p_mod_p"])
            assert d == int(row["eta_step_im_over_p_mod_p"])
            assert slope == int(row["linear_slope"]) and slope != 0
            rho = -c * pow(slope, -1, p) % p
            assert row["classification"] == "unique_forced_residue"
            assert rho == int(row["forced_r_mod_p"])
            assert (h + 3 * rho) % p == 0
            assert int(row["next_T"]) == T + Q * rho
            assert int(row["next_Q"]) == Q * p
            f = fib_mod(10 * Q, p2)
            assert f % p == 0 and f != 0
            r_batch, m_batch = crt_pair(r_batch, m_batch, rho, p)
            packet_primes.append(p)

        assert r_batch == int(data["batch_forced_r"])
        assert m_batch == int(data["batch_forced_r_modulus"])
        assert T + Q * r_batch == int(data["batch_next_T"])
        assert Q * m_batch == int(data["batch_next_Q"])
        expected_q = Q * m_batch
        if i + 1 < len(stages):
            assert int(stages[i + 1]["current_T"]) == T + Q * r_batch
            assert int(stages[i + 1]["current_Q"]) == expected_q
        stage_summary.append({
            "stage": i,
            "file": name,
            "limit": int(data["limit"]),
            "h": h,
            "Q_digits": len(str(Q)),
            "divisor_rows": len(data["divisors_of_L_T"]),
            "lift_packets": len(data["recursive_lift_packets"]),
        })

    final = stages[-1]
    final_T, final_Q = int(final["current_T"]), int(final["current_Q"])
    assert len(packet_primes) == 626 == len(set(packet_primes))
    assert len(INITIAL_FACTORS) + len(packet_primes) == 638
    assert not final["recursive_lift_packets"]
    exact_one = [r for r in final["divisors_of_L_T"] if r["valuation_exactly_one"]]
    assert exact_one and exact_one[0]["p"] == 13

    output = {
        "scope": "exact audit of saved rows and transitions; exhaustive endpoints require generator replay",
        "canonical_stage_files": FILES,
        "stage_summary": stage_summary,
        "initial_Q_distinct_prime_factors": len(INITIAL_FACTORS),
        "new_distinct_lift_primes": len(packet_primes),
        "final_Q_distinct_prime_factors": len(INITIAL_FACTORS) + len(packet_primes),
        "final_T_digits": len(str(final_T)),
        "final_Q_digits": len(str(final_Q)),
        "final_h": (3 * final_T + 1) // final_Q,
        "final_search_limit": int(final["limit"]),
        "final_lift_packets_below_saved_endpoint": 0,
        "final_exact_valuation_one_divisor_primes": [int(r["p"]) for r in exact_one],
        "canonical_file_sha256": {name: sha(HERE / name) for name in FILES},
    }
    out = HERE / "recursive_chain_verification.json"
    out.write_text(json.dumps(output, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(output, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
