#!/usr/bin/env python3
"""Exact local branch analysis for the seven saved final-state divisors.

This script does not claim exhaustiveness beyond the source computation's
saved p <= 10^8 search.  For each known p || L_T it determines the complete
set of residue classes r modulo ord_p(eta^Q) for which
p | L_(T+Qr), and then determines their lifts modulo p^2.
"""

from __future__ import annotations

import json
import math
import sys
from pathlib import Path

if hasattr(sys, "set_int_max_str_digits"):
    sys.set_int_max_str_digits(0)

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
BASE = ROOT / "research" / "computation" / "2026_09_01_danilov_recursive_lift"
DATA = json.loads((BASE / "search_stage13_100m.json").read_text(encoding="utf-8"))

ALPHA0 = (682, 305)
ETA = (1_730_726_404_001, 774_004_377_960)


def mul(x: tuple[int, int], y: tuple[int, int], m: int) -> tuple[int, int]:
    return ((x[0] * y[0] + 5 * x[1] * y[1]) % m,
            (x[0] * y[1] + x[1] * y[0]) % m)


def power(x: tuple[int, int], e: int, m: int) -> tuple[int, int]:
    y = (1, 0)
    while e:
        if e & 1:
            y = mul(y, x, m)
        x = mul(x, x, m)
        e >>= 1
    return y


def orbit(t: int, m: int) -> tuple[int, int]:
    return mul(ALPHA0, power(ETA, t, m), m)


def factor(n: int) -> dict[int, int]:
    ans: dict[int, int] = {}
    d = 2
    while d * d <= n:
        while n % d == 0:
            ans[d] = ans.get(d, 0) + 1
            n //= d
        d = 3 if d == 2 else d + 2
    if n > 1:
        ans[n] = ans.get(n, 0) + 1
    return ans


def order(g: tuple[int, int], bound: int, p: int) -> int:
    d = bound
    for ell in factor(bound):
        while d % ell == 0 and power(g, d // ell, p) == (1, 0):
            d //= ell
    assert power(g, d, p) == (1, 0)
    return d


def inv(x: tuple[int, int], p: int) -> tuple[int, int]:
    norm = (x[0] * x[0] - 5 * x[1] * x[1]) % p
    ni = pow(norm, -1, p)
    return (x[0] * ni % p, -x[1] * ni % p)


def bsgs(g: tuple[int, int], h: tuple[int, int], d: int, p: int) -> int | None:
    """Return r in [0,d) with g^r=h, if one exists."""
    m = math.isqrt(d) + 1
    table: dict[tuple[int, int], int] = {}
    x = (1, 0)
    for j in range(m):
        table.setdefault(x, j)
        x = mul(x, g, p)
    giant = inv(power(g, m, p), p)
    y = h
    for i in range(m + 1):
        if y in table:
            r = i * m + table[y]
            if r < d and power(g, r, p) == h:
                return r
        y = mul(y, giant, p)
    return None


def lvalue(A: tuple[int, int], g: tuple[int, int], r: int, m: int) -> int:
    return (2 * mul(A, power(g, r, m), m)[0] + 11) % m


def main() -> None:
    T = int(DATA["current_T"])
    Q = int(DATA["current_Q"])
    rows = []
    for saved in DATA["divisors_of_L_T"]:
        p = int(saved["p"])
        p2 = p * p
        A1 = orbit(T, p)
        A2 = orbit(T, p2)
        g1 = power(ETA, Q, p)
        g2 = power(ETA, Q, p2)

        leg5 = pow(5, (p - 1) // 2, p)
        chi = 1 if leg5 == 1 else -1
        group_order = p - chi
        d = order(g1, group_order, p)
        target = mul((A1[0], -A1[1] % p), inv(A1, p), p)
        second = bsgs(g1, target, d, p)
        root_classes = sorted(set([0] + ([] if second is None else [second])))
        assert all(lvalue(A1, g1, r, p) == 0 for r in root_classes)

        # The two-point norm argument proves there are no further roots.
        # Brute force is a redundant finite check whenever the order is modest.
        if d <= 2_000_000:
            brute = [r for r in range(d) if lvalue(A1, g1, r, p) == 0]
            assert brute == root_classes

        gd2 = power(g2, d, p2)
        lifts = []
        for r0 in root_classes:
            v0 = lvalue(A2, g2, r0, p2) // p % p
            v1 = lvalue(A2, g2, r0 + d, p2) // p % p
            slope = (v1 - v0) % p
            if slope:
                s = -v0 * pow(slope, -1, p) % p
                assert lvalue(A2, g2, r0 + d * s, p2) == 0
                lifts.append({
                    "root_mod_order": r0,
                    "classification": "unique_lift",
                    "lift_parameter_mod_p": s,
                    "allowed_r_mod_order_times_p": r0 + d * s,
                })
            elif v0 == 0:
                lifts.append({"root_mod_order": r0, "classification": "all_lifts"})
            else:
                lifts.append({"root_mod_order": r0, "classification": "no_lift"})

        rows.append({
            "p": p,
            "chi5": chi,
            "norm_one_group_order": group_order,
            "step_order_mod_p": d,
            "step_order_factorization": factor(d),
            "zero_classes_mod_step_order": root_classes,
            "zero_class_count": len(root_classes),
            "zero_density_mod_p": f"{len(root_classes)}/{d}",
            "step_to_order_mod_p2": list(gd2),
            "p2_lifts": lifts,
        })

    result = {
        "scope": "exact analysis of the seven saved p<=1e8 divisors only",
        "state_Q_digits": len(str(Q)),
        "rows": rows,
    }
    (HERE / "final_branch_prime_analysis.json").write_text(
        json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
