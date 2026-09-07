"""Finite exact supplements for CB1--CB3; no global-image inference."""
from argparse import ArgumentParser
from hashlib import sha256
from math import gcd, isqrt
from pathlib import Path
import json


def norm(a, b):
    return a*a + a*b + b*b


def quartic(a, b):
    return a**4 + 3*a**3*b + 5*a*a*b*b + 3*a*b**3 + b**4


def prime(q):
    return q >= 2 and all(q % d for d in range(2, isqrt(q)+1))


def compute():
    fields = []
    states = 0
    for q in range(7, 128, 12):
        if not prime(q):
            continue
        roots = [r for r in range(q) if (r*r+3) % q == 0]
        assert len(roots) == 2
        for r in roots:
            count = 1 + sum((Y*Y-X**3-12*r*X) % q == 0
                            for X in range(q) for Y in range(q))
            states += q*q
            assert count == q+1
            fields.append({"q": q, "r": r, "points": count, "trace": q+1-count})
    shadows = []
    for L in [1, 2, 3, 8, 13, 49, 7*19*31, (7*19)**2]:
        for k in [2, 3, 5, 11]:
            a, b = L*k-1, 1
            assert a > 0 and b > 0 and gcd(a, b) == 1
            N, F = norm(a, b), quartic(a, b)
            x, y = a*a+b*b, a+b
            assert (N-1) % L == (F-1) % L == 0
            assert (12*y) % L == (18*y*y) % L == (6*x-12) % L == 0
            assert gcd(a*b, N) == 1 and a*b+N == y*y
            assert 2*x-y*y == (a-b)**2
            assert 4*F == x*x+3*y**4
            assert isqrt(F)**2 != F
            shadows.append({"L": L, "k": k, "a": a, "b": b, "N": N, "F": F})
    return {"scope": "complete listed finite-field counts and actual finite congruence shadows; not CM newform membership or residual congruence",
            "field_rows": fields, "enumerated_affine_states": states, "actual_shadows": shadows}


def main():
    parser = ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    data = compute()
    payload = (json.dumps(data, indent=2, sort_keys=True)+"\n").encode("utf-8")
    path = Path(__file__).with_name("cm_shadow_results.json")
    if args.check:
        assert path.read_bytes() == payload, "canonical certificate differs"
    else:
        path.write_bytes(payload)
    print(json.dumps({"status": "PASS", "field_rows": len(data["field_rows"]),
                      "enumerated_affine_states": data["enumerated_affine_states"],
                      "actual_shadows": len(data["actual_shadows"]),
                      "sha256": sha256(payload).hexdigest()}, sort_keys=True))


if __name__ == "__main__":
    main()
