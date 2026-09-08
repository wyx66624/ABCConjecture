"""Exact sufficient witnesses for DP; no factorization or floating logarithms."""
from __future__ import annotations

import argparse
import hashlib
import json
from math import gcd
from pathlib import Path

OUT = Path(__file__).resolve().parent / "verification" / "divisor_partition_exact.json"


def digest_integer(n: int) -> str:
    assert n >= 0
    return hashlib.sha256(n.to_bytes((n.bit_length() + 7) // 8, "big")).hexdigest()


def run() -> dict:
    # Candidate selection is not evidence. Every listed candidate is checked
    # below by exact integer inequalities, independently of its selection.
    candidates = [(2, 242, 153), (2, 811, 512), (2, 1296, 818)]
    rows = []
    for k, r, s in candidates:
        period = 12 * 35 ** (k - 1)
        u, v = period * r + period // 2, period * s
        a, b = 2 ** u, 3 ** v
        x = a * b
        M, N = a * a, b * b
        A, B = M // 2, N // 3
        assert x > 6 and u >= 1 and v >= 1
        assert M == 2 * A and N == 3 * B
        assert 3 * b <= 4 * a and 3 * a <= 4 * b
        assert (x - 1) % (7 ** k) == 0
        assert (x + 1) % (5 ** k) == 0
        assert gcd(x - 1, x + 1) == 1
        assert max(M, N) < 2 * min(M, N) - 1
        first_upper = (x - 1) // (7 ** (k - 1))
        second_upper = (x + 1) // (5 ** (k - 1))
        assert first_upper <= A and second_upper <= B
        assert first_upper * second_upper < A * B
        assert 6 * A * B == x * x
        assert (35 ** (k - 1)) * first_upper * second_upper == x * x - 1
        rows.append({
            "k": k, "r": r, "s": s, "u": u, "v": v,
            "endpoint_exponents": [2 * u, 2 * v],
            "x_bits": x.bit_length(), "c_bits": (x * x).bit_length(),
            "x_unsigned_big_endian_sha256": digest_integer(x),
            "balanced": True, "strict_no_face_condition": True,
            "coprime_complete_factors": True,
            "known_prime_power_divisibility": {"x_minus_one": [7, k], "x_plus_one": [5, k]},
            "first_radical_upper_at_most_A": True,
            "second_radical_upper_at_most_B": True,
            "radical_product_upper_strictly_below_AB": True,
        })

    residue_rows = []
    for k in range(2, 13):
        period = 12 * 35 ** (k - 1)
        for r in [0, 1, 7]:
            for s in [1, 3]:
                u, v = period * r + period // 2, period * s
                m7, m5 = 7 ** k, 5 ** k
                residues = [pow(2, u, m7) * pow(3, v, m7) % m7,
                            pow(2, u, m5) * pow(3, v, m5) % m5]
                assert residues == [1, m5 - 1]
                residue_rows.append([k, r, s, *residues])
    return {
        "schema": 1,
        "scope": "Exact integer sufficient witnesses only. No factorization of x±1, exact radical, logarithm, infinity or ABC certificate.",
        "actual_balanced_rows": rows,
        "residue_only_rows_not_claimed_balanced": residue_rows,
        "counts": {"actual_balanced_inputs": len(rows), "residue_only_inputs": len(residue_rows)},
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    result = run()
    raw = (json.dumps(result, ensure_ascii=True, indent=2, sort_keys=True) + "\n").encode()
    if args.check:
        assert OUT.read_bytes() == raw, "canonical DP evidence mismatch"
    else:
        OUT.parent.mkdir(parents=True, exist_ok=True)
        OUT.write_bytes(raw)
    print("PASS", json.dumps(result["counts"], sort_keys=True), hashlib.sha256(raw).hexdigest())


if __name__ == "__main__":
    main()
