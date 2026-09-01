#!/usr/bin/env python3
"""Independent arbitrary-precision replay of every row in the 1e9 hit CSV."""

import csv
import hashlib
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
CSV = HERE / "depth3_scan_1b.csv"
OUT = HERE / "depth3_scan_1b_verification.json"


def quotient_mul(x: tuple[int, int], y: tuple[int, int], modulus: int) -> tuple[int, int]:
    """Multiply a*T+b modulo T^2-6*T+1 and the integer modulus."""
    a, b = x
    c, d = y
    return ((6 * a * c + a * d + b * c) % modulus, (b * d - a * c) % modulus)


def balancing_mod(n: int, modulus: int) -> int:
    result = (0, 1)
    base = (1, 0)
    while n:
        if n & 1:
            result = quotient_mul(result, base, modulus)
        base = quotient_mul(base, base, modulus)
        n >>= 1
    return result[0]


def main() -> None:
    rows = []
    with CSV.open(newline="", encoding="ascii") as handle:
        for row in csv.DictReader(handle):
            q = int(row["q"])
            index = int(row["canonical_index"])
            q2 = q * q
            residue = balancing_mod(index, q2 * q)
            assert residue == int(row["u_mod_q3"])
            assert residue // q2 == int(row["u_over_q2_mod_q"])
            assert residue % q2 == 0
            assert residue != 0
            assert row["status"] == "valuation_exactly_2"
            rows.append({"q": q, "canonical_index": index, "u_mod_q3": residue})

    assert [row["q"] for row in rows] == [13, 31, 1546463]
    result = {
        "algorithm": "independent arbitrary-precision quotient-ring binary powering",
        "csv_sha256": hashlib.sha256(CSV.read_bytes()).hexdigest(),
        "rows": rows,
        "verification": "PASS",
    }
    OUT.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n", encoding="utf-8", newline="\n")
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
