#!/usr/bin/env python3
"""Independent matrix replay of the signed-trace Pell search."""

from __future__ import annotations

import argparse
import json
from math import isqrt
from pathlib import Path


def sieve(limit: int) -> bytearray:
    flags = bytearray(b"\x01") * (limit + 1)
    flags[:2] = b"\x00\x00"
    for p in range(2, isqrt(limit) + 1):
        if flags[p]:
            flags[p * p : limit + 1 : p] = b"\x00" * ((limit - p * p) // p + 1)
    return flags


def mat_mul(x: tuple[int, int, int, int], y: tuple[int, int, int, int], modulus: int):
    a, b, c, d = x
    e, f, g, h = y
    return (
        (a * e + b * g) % modulus,
        (a * f + b * h) % modulus,
        (c * e + d * g) % modulus,
        (c * f + d * h) % modulus,
    )


def matrix_power(index: int, modulus: int) -> tuple[int, int]:
    result = (1, 0, 0, 1)
    base = (1, 2, 1, 1)
    n = index
    while n:
        if n & 1:
            result = mat_mul(result, base, modulus)
        base = mat_mul(base, base, modulus)
        n >>= 1
    return result[0], result[2]


def scan(max_index: int, prime_bound: int) -> tuple[int, int, int, set[int], list[dict]]:
    flags = sieve(max(max_index, prime_bound))
    indices = [ell for ell in range(3, max_index + 1, 2) if flags[ell]]
    candidate_tests = 0
    support_hits = 0
    simple_indices: set[int] = set()
    repeated: list[dict] = []
    for ell in indices:
        for k in range(1, prime_bound // (2 * ell) + 2):
            for sign, q in ((-1, 2 * ell * k - 1), (1, 2 * ell * k + 1)):
                if q < 3 or q > prime_bound or not flags[q]:
                    continue
                candidate_tests += 1
                q2 = q * q
                a2, b2 = matrix_power(ell, q2)
                for channel, value in (("A", a2), ("B", b2)):
                    if value % q:
                        continue
                    support_hits += 1
                    if value % q2:
                        simple_indices.add(ell)
                        continue
                    q3, q4, q5 = q**3, q**4, q**5
                    a, b = matrix_power(ell, q5)
                    trace = (a * a + 2 * b * b) % q5
                    coordinate = a if channel == "A" else b
                    derivative = (
                        ell * b % q
                        if channel == "A"
                        else (ell * a - b) * pow(4, -1, q) % q
                    )
                    shift = (trace - 1) % q5 if channel == "A" else (trace + 1) % q5
                    coordinate_depth = "at_least_3" if coordinate % q3 == 0 else "exactly_2"
                    trace_depth = "at_least_5" if shift % q5 == 0 else "exactly_4"
                    assert coordinate % q2 == 0 and derivative != 0 and shift % q4 == 0
                    repeated.append(
                        {
                            "index": ell,
                            "prime": q,
                            "residue_sign": sign,
                            "residue_multiplier": k,
                            "channel": channel,
                            "coordinate_depth": coordinate_depth,
                            "coordinate_quotient_mod_prime": (coordinate // q2) % q,
                            "derivative_mod_prime": derivative,
                            "trace_shift_depth": trace_depth,
                            "trace_shift_quotient_mod_prime": (shift // q4) % q,
                        }
                    )
    return len(indices), candidate_tests, support_hits, simple_indices, repeated


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path, default=Path("signed_trace_projector_search.json"))
    parser.add_argument("--output", type=Path, default=Path("signed_trace_projector_verification.json"))
    args = parser.parse_args()
    source = json.loads(args.input.read_text(encoding="utf-8"))
    params = source["parameters"]
    nindices, tests, support, simple, replay = scan(
        params["max_prime_index"], params["support_prime_bound"]
    )
    expected = [
        {
            "index": row["index"],
            "prime": row["prime"],
            "residue_sign": row["residue_sign"],
            "residue_multiplier": row["residue_multiplier"],
            "channel": row["channel"],
            "coordinate_depth": row["coordinate_depth"],
            "coordinate_quotient_mod_prime": row["coordinate_quotient_mod_prime"],
            "derivative_mod_prime": row["derivative_mod_prime"],
            "trace_shift_depth": row["trace_shift_depth"],
            "trace_shift_quotient_mod_prime": row["trace_shift_quotient_mod_prime"],
        }
        for row in source["repeated_hits"]
    ]
    counts = source["counts"]
    checks = {
        "prime_index_count": nindices == counts["prime_indices"],
        "candidate_count": tests == counts["candidate_prime_tests"],
        "support_count": support == counts["support_hits"],
        "simple_index_count": len(simple) == counts["indices_with_bounded_simple_witness"],
        "repeated_rows_exact": replay == expected,
        "only_complete_counterexamples_retired": all(
            item["status"] == "REFUTED"
            for key, item in source["logical_decisions"].items()
            if key not in {"prime_index_simultaneous_squarefull_packet", "prime_index_depth_three_collision"}
        ),
        "global_gates_remain_open": all(
            source["logical_decisions"][key]["status"] == "OPEN"
            for key in ("prime_index_simultaneous_squarefull_packet", "prime_index_depth_three_collision")
        ),
    }
    result = {
        "schema": "pell-signed-trace-projector-verification-v1",
        "algorithm": "independent binary powering of [[1,2],[1,1]]",
        "checks": checks,
        "replayed_repeated_hits": replay,
        "status": "PASS" if all(checks.values()) else "FAIL",
    }
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
    if result["status"] != "PASS":
        raise SystemExit(1)


if __name__ == "__main__":
    main()
