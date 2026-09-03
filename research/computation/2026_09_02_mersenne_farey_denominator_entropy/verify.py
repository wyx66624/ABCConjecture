#!/usr/bin/env python3
"""Exact finite checks for the Farey denominator-entropy checkpoint.

The script has two deliberately separate roles.

1. It checks the finite denominator split with rational arithmetic on an
   abstract common-index saturation family.  This family keeps q | m,
   integral p = 1 + (m/q)r, and reduced (hence distinct) slopes, but it does
   not assert primality, exact order, or Wieferich depth.
2. It re-reads the frozen exhaustive base-two scan through 10^9 and checks
   that its only Wieferich hits have certified depth exactly two.  Hence that
   scan contains no full-premise row of the low-multiplier deep packet.

No finite output is used as an asymptotic theorem.
"""

from __future__ import annotations

import hashlib
import json
import math
import sys
from fractions import Fraction
from pathlib import Path


HERE = Path(__file__).resolve().parent
REPO = HERE.parents[2]
OLD = REPO / "research" / "computation" / "2026_09_02_mersenne_sigma_one"
sys.set_int_max_str_digits(0)


def log_bigint(n: int) -> float:
    """Return log(n) without converting a huge integer to float."""
    shift = max(0, n.bit_length() - 53)
    return math.log(n >> shift) + shift * math.log(2.0)


def lcm_upto(n: int) -> int:
    ans = 1
    for j in range(1, n + 1):
        ans = math.lcm(ans, j)
    return ans


def harmonic(t: int) -> Fraction:
    return sum((Fraction(1, q) for q in range(1, t + 1)), Fraction())


def abstract_model(n: int, eta: float = 0.25) -> dict[str, object]:
    """Build a common-index, divisor-compatible Farey saturation model."""
    m = lcm_upto(n)
    A = log_bigint(3 * m)
    L = math.log(A)
    H = math.floor(math.sqrt(A / L))
    # q <= n/2 is eventually inside Q=A for k=1 and every such q divides m.
    q_cap = n // 2
    assert q_cap < A
    assert H >= 2

    rows: list[tuple[int, int]] = []
    slopes: set[Fraction] = set()
    for q in range(1, q_cap + 1):
        assert m % q == 0
        for r in range(1, H):
            if math.gcd(q, r) != 1:
                continue
            slope = Fraction(r, q)
            assert slope not in slopes
            slopes.add(slope)
            rows.append((q, r))

    energy = sum((Fraction(r, q) for q, r in rows), Fraction())
    T = max(1, math.floor(A**eta))
    prefix = sum((Fraction(r, q) for q, r in rows if q <= T), Fraction())
    tail = energy - prefix
    tail_count = sum(q > T for q, _ in rows)
    triangular = H * (H - 1) // 2
    prefix_cap = triangular * harmonic(T)
    tail_cap = Fraction(tail_count * H, T)

    checks = {
        "all_q_divide_common_m": all(m % q == 0 for q, _ in rows),
        "all_r_below_H": all(0 < r < H for _, r in rows),
        "all_slopes_reduced": all(math.gcd(q, r) == 1 for q, r in rows),
        "slopes_pairwise_distinct": len(slopes) == len(rows),
        "integer_labels_pairwise_distinct":
            len({1 + (m // q) * r for q, r in rows}) == len(rows),
        "prefix_bound_exact": prefix <= prefix_cap,
        "tail_bound_exact": tail <= tail_cap,
        "tail_prime_cross_bound": all(
            T * ((m // q) * r) < m * H for q, r in rows if q > T
        ),
        "denominator_split_exact": energy == prefix + tail,
    }
    assert all(checks.values())
    return {
        "n": n,
        "m_decimal_digits": len(str(m)),
        "A_log_3m": A,
        "L_log_A": L,
        "H": H,
        "q_cap": q_cap,
        "row_count": len(rows),
        "eta": eta,
        "T_floor_A_pow_eta": T,
        "energy_numerator": str(energy.numerator),
        "energy_denominator": str(energy.denominator),
        "energy_float": float(energy),
        "energy_over_A": float(energy) / A,
        "prefix_float": float(prefix),
        "prefix_cap_float": float(prefix_cap),
        "tail_float": float(tail),
        "tail_cap_float": float(tail_cap),
        "tail_count": tail_count,
        "checks": checks,
        "missing_arithmetic_premises": [
            "p_is_prime",
            "ord_p_2_equals_m_over_q",
            "p_cubed_divides_2_pow_order_minus_1",
        ],
    }


def frozen_scan_check() -> dict[str, object]:
    scan_path = OLD / "scan_1b.json"
    witness_path = OLD / "verify_witnesses_output.json"
    scan = json.loads(scan_path.read_text(encoding="utf-8"))
    witness = json.loads(witness_path.read_text(encoding="utf-8"))
    rows = witness["phi_364_rows"] + [witness["row_3511"]]
    by_p = {row["p"]: row for row in rows}
    hits = scan["hits"]
    checks = {
        "scan_limit_is_1e9": scan["limit"] == 1_000_000_000,
        "scan_prime_count": scan["prime_count"] == 50_847_534,
        "only_two_hits": [h["p"] for h in hits] == [1093, 3511],
        "hit_orders_match": all(by_p[h["p"]]["d"] == h["d"] for h in hits),
        "hit_multipliers_match": all(by_p[h["p"]]["r"] == h["r"] for h in hits),
        "both_hits_depth_two": all(by_p[h["p"]]["w"] == 2 for h in hits),
        "both_square_residues_one": all(by_p[h["p"]]["pow_2_d_mod_p2"] == 1 for h in hits),
        "both_cube_residues_nonone": all(by_p[h["p"]]["pow_2_d_mod_p3"] != 1 for h in hits),
    }
    assert all(checks.values())
    return {
        "source_scan": str(scan_path.relative_to(REPO)).replace("\\", "/"),
        "source_witnesses": str(witness_path.relative_to(REPO)).replace("\\", "/"),
        "limit": scan["limit"],
        "prime_count": scan["prime_count"],
        "hits": hits,
        "depth_three_hits": [],
        "checks": checks,
        "logical_scope": "finite exclusion only; no asymptotic inference",
    }


def sha256(path: Path) -> str:
    h = hashlib.sha256()
    h.update(path.read_bytes())
    return h.hexdigest()


def main() -> None:
    models = [abstract_model(n) for n in (100, 300, 1000, 3000, 10_000)]
    result = {
        "schema": "mersenne-farey-denominator-entropy-v1",
        "all_checks_pass": True,
        "abstract_common_index_models": models,
        "frozen_scan_crosscheck": frozen_scan_check(),
        "interpretation": {
            "positive": "the exact denominator split survives exact rational replay",
            "negative": (
                "q|m, integrality, and distinct slopes alone allow energy comparable "
                "with log(m); primality, exact order, or depth must supply the saving"
            ),
            "counterexample_scope": (
                "the abstract models are not counterexamples to the Mersenne packet "
                "because three arithmetic premises are intentionally absent"
            ),
        },
    }
    out = HERE / "verification_output.json"
    out.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
