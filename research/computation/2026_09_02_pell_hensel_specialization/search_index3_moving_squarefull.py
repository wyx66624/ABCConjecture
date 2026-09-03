#!/usr/bin/env python3
"""Exhaust powerful F3 values for even |T| <= 20,000,000.

For T=2s, F3(T)=4s^2+1.  Every positive powerful integer has the unique
form a^2 b^3 with b squarefree.  Enumerating those representations gives a
complete bounded search without factoring every polynomial value.
"""

from __future__ import annotations

import json
from math import isqrt
from pathlib import Path


HERE = Path(__file__).resolve().parent
OUT = HERE / "index3_moving_squarefull_search.json"
S_MAX = 10_000_000


def squarefree_table(n: int) -> bytearray:
    table = bytearray(b"\x01") * (n + 1)
    table[0] = 0
    for d in range(2, isqrt(n) + 1):
        dd = d * d
        for k in range(dd, n + 1, dd):
            table[k] = 0
    return table


def factor_trial(n: int) -> dict[str, int]:
    ans: dict[str, int] = {}
    d = 2
    while d * d <= n:
        while n % d == 0:
            ans[str(d)] = ans.get(str(d), 0) + 1
            n //= d
        d = 3 if d == 2 else d + 2
    if n > 1:
        ans[str(n)] = ans.get(str(n), 0) + 1
    return ans


def main() -> None:
    value_max = 4 * S_MAX * S_MAX + 1
    b_max = 1
    while (b_max + 1) ** 3 <= value_max:
        b_max += 1
    sf = squarefree_table(b_max)
    representations = 0
    candidates: list[dict] = []
    for b in range(1, b_max + 1):
        if not sf[b]:
            continue
        b3 = b**3
        a_max = isqrt(value_max // b3)
        representations += a_max
        for a in range(1, a_max + 1):
            value = a * a * b3
            if value % 4 != 1:
                continue
            s2 = (value - 1) // 4
            s = isqrt(s2)
            if not (1 <= s <= S_MAX and s * s == s2):
                continue
            A = s * (4 * s * s + 3)
            A_factorization = factor_trial(A)
            candidates.append({
                "s": s,
                "T": 2 * s,
                "F3": value,
                "powerful_representation_a": a,
                "powerful_representation_b": b,
                "F3_factorization": factor_trial(value),
                "half_L3": A,
                "half_L3_factorization": A_factorization,
                "half_L3_is_squarefull": all(e >= 2 for e in A_factorization.values()),
            })
    candidates.sort(key=lambda row: row["s"])
    result = {
        "schema": "index3-moving-squarefull-search-v1",
        "parameter_scope": {"s_min": 1, "s_max": S_MAX, "T_equals_2s": True},
        "method": "unique powerful representation n=a^2*b^3 with squarefree b",
        "powerful_representations_tested": representations,
        "F3_squarefull_candidates": candidates,
        "F3_squarefull_candidate_count": len(candidates),
        "full_two_channel_squarefull_hits": [
            row for row in candidates if row["half_L3_is_squarefull"]
        ],
        "policy": "The bounded absence of a two-channel hit is not an unbounded theorem.",
    }
    OUT.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps({
        "status": "PASS",
        "representations": representations,
        "F3_candidates": len(candidates),
        "full_hits": len(result["full_two_channel_squarefull_hits"]),
        "candidate_s": [row["s"] for row in candidates],
    }, indent=2))


if __name__ == "__main__":
    main()

