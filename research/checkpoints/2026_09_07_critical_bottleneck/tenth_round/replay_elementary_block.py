"""Exact finite replay of EA2 and actual integer height prerequisites.

No floating-point angular inequality or logarithmic estimate is treated as
verified by this replay. EA1 and EA3 retain their ordinary proofs.
"""
from __future__ import annotations
import argparse
import hashlib
import json
from pathlib import Path


def mul(x: tuple[int, int], y: tuple[int, int]) -> tuple[int, int]:
    a, b = x
    c, d = y
    return a*c-b*d, a*d+b*c+b*d


def power(x: tuple[int, int], n: int) -> tuple[int, int]:
    result = (1, 0)
    while n:
        if n & 1:
            result = mul(result, x)
        x = mul(x, x)
        n >>= 1
    return result


def valuation(x: int, p: int) -> int:
    assert x != 0
    x = abs(x)
    depth = 0
    while x % p == 0:
        x //= p
        depth += 1
    return depth


def run() -> dict:
    rows = []
    parameters = sorted({(n, B, k)
                         for n in range(1, 97)
                         for B in (n, n*n, n**4)
                         for k in (B, 2*B-1)})
    for n, B, k in parameters:
        a = 3*k
        Q = a*a+a+1
        A, D = power((a, 1), n)
        T = abs(A*D*(A+D))
        c = max(abs(A), abs(D), abs(A+D))
        T1 = a*(a+1)
        A2, D2 = power((a, 1), 2)
        T2 = abs(A2*D2*(A2+D2))
        assert T2 == a*(a-1)*(a+1)*(a+2)*(2*a+1)
        assert T2 % 8 == 0
        assert Q % 2 == 1 and Q % 3 == 1
        assert A*A+A*D+D*D == Q**n
        assert Q**n <= c*c and 3*c*c <= 4*Q**n
        assert 0 < T <= c**3
        # The angle proof predicts this actual positive sector for B>=n.
        assert A > 0 and D > 0
        v2 = valuation(T, 2)
        v3 = valuation(T, 3)
        expected2 = (valuation(T1, 2) if n % 2 else
                     valuation(T2, 2)+valuation(n//2, 2))
        expected3 = valuation(T1, 3)+valuation(n, 3)
        assert v2 == expected2
        assert v3 == expected3
        rows.append({"n": n, "B": B, "k": k,
                     "v2_T1": valuation(T1, 2),
                     "v2_T2": valuation(T2, 2),
                     "v3_T1": valuation(T1, 3),
                     "v2_Tn": v2, "v3_Tn": v3})
    payload = {"scope": "Exact finite valuation identities EA5/EA6 and integer norm bounds; no floating-point proof, no full factorization, no global ABC assertion",
               "actual_rows": len(rows), "valuation_equalities": 2*len(rows),
               "indices": [1, 96], "rows": rows}
    packed = json.dumps(payload, sort_keys=True, separators=(",", ":")).encode()
    return {"payload": payload, "payload_sha256": hashlib.sha256(packed).hexdigest()}


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    data = (json.dumps(run(), sort_keys=True, indent=2)+"\n").encode("utf-8")
    output = Path(__file__).with_name("elementary_block_replay.json")
    if args.check:
        assert output.read_bytes() == data, "canonical finite replay differs"
    else:
        output.write_bytes(data)
    value = json.loads(data)
    print(json.dumps({"status": "PASS", "actual_rows": value["payload"]["actual_rows"],
                      "valuation_equalities": value["payload"]["valuation_equalities"],
                      "payload_sha256": value["payload_sha256"],
                      "file_sha256": hashlib.sha256(data).hexdigest()}, sort_keys=True))


if __name__ == "__main__":
    main()
