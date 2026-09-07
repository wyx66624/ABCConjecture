"""Exact finite supplement to PC1--PC2; no geometric or ABC conclusion."""
from __future__ import annotations

import argparse
from hashlib import sha256
import json
from math import gcd
from pathlib import Path


def mul(x: tuple[int, int], y: tuple[int, int]) -> tuple[int, int]:
    r, s = x
    u, v = y
    return r*u-s*v, r*v+s*u+s*v


def norm(z: tuple[int, int]) -> int:
    a, b = z
    return a*a+a*b+b*b


def power(z: tuple[int, int], n: int) -> tuple[int, int]:
    result = (1, 0)
    for _ in range(n):
        result = mul(result, z)
    return result


def run() -> dict:
    multiplier_count = 0
    for r in range(-6, 7):
        for s in range(-6, 7):
            if (r, s) == (0, 0):
                continue
            n_tau = norm((r, s))
            for u in range(-7, 8):
                for v in range(-7, 8):
                    if gcd(u, v) != 1:
                        continue
                    A, B = mul((r, s), (u, v))
                    assert (r+s)*A+s*B == n_tau*u
                    assert -s*A+r*B == n_tau*v
                    content = gcd(A, B)
                    assert content > 0 and n_tau % content == 0
                    assert norm((A//content, B//content))*content**2 == n_tau*norm((u, v))
                    multiplier_count += 1

    units = [power((0, 1), j) for j in range(6)]
    assert len(set(units)) == 6 and all(norm(z) == 1 for z in units)
    pi, w = (2, 1), (3, -1)
    assert mul(pi, w) == (7, 0)
    rows = []
    for n in range(2, 130):
        previous = power(w, n-1)
        assert gcd(*previous) == 1 and norm(previous) == 7**(n-1)
        assert (previous[0]+5*previous[1]) % 7 == pow(-2, n-1, 7) != 0
        choices = [(j, unit, mul(unit, previous)) for j, unit in enumerate(units)
                   if all(c > 0 for c in mul(unit, previous))]
        assert len(choices) == 1
        j, unit, (a, b) = choices[0]
        tau = mul(unit, pi)
        raw = mul(tau, power(w, n))
        assert raw == (7*a, 7*b)
        assert gcd(*raw) == 7 and gcd(a, b) == 1
        assert norm(tau) == norm(w) == 7
        assert norm((a, b)) == 7**(n-1)
        # The same projective parameter is t=-3. Its homogeneous root
        # (-3,1) differs from w by a rational factor -1 only.
        map_output = mul(tau, power((-3, 1), n))
        assert map_output[0]*b == map_output[1]*a
        assert map_output == tuple((-1)**n*c for c in raw)
        # Pure support seven and depth n-1<n rule out a nonunit n-th root.
        assert (n-1)//n == 0
        if n == 5:
            assert j == 2 and tau == (-3, 2) and (a, b) == (16, 39)
            assert raw == (112, 273)
        rows.append({"n": n, "unit_power": j, "tau": list(tau),
                     "primitive_output": [a, b], "content": 7,
                     "norm_seven_depth": n-1})
    payload = {"scope": "Finite exact adjugate/content identities and actual single-map counterfamily; no double-fiber compatibility, no full ABC claim",
               "multiplier_rows": multiplier_count,
               "family_rows": len(rows), "indices": [2, 129], "rows": rows}
    packed = json.dumps(payload, sort_keys=True, separators=(",", ":")).encode("utf-8")
    return {"payload": payload, "payload_sha256": sha256(packed).hexdigest()}


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    result = run()
    data = (json.dumps(result, sort_keys=True, indent=2)+"\n").encode("utf-8")
    target = Path(__file__).with_name("projective_content_results.json")
    if args.check:
        assert target.read_bytes() == data, "canonical replay differs"
    else:
        target.write_bytes(data)
    print(json.dumps({"status": "PASS", "multiplier_rows": result["payload"]["multiplier_rows"],
                      "family_rows": result["payload"]["family_rows"],
                      "payload_sha256": result["payload_sha256"],
                      "file_sha256": sha256(data).hexdigest()}, sort_keys=True))


if __name__ == "__main__":
    main()
