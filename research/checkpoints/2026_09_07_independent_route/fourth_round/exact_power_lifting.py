"""Exact finite arithmetic replay for PL1--PL2; not a finiteness proof."""

from fractions import Fraction
from hashlib import sha256
from math import gcd
from pathlib import Path
import json


def factor(n: int) -> dict[int, int]:
    out: dict[int, int] = {}
    p = 2
    while p * p <= n:
        while n % p == 0:
            out[p] = out.get(p, 0) + 1
            n //= p
        p += 1 if p == 2 else 2
    if n > 1:
        out[n] = out.get(n, 0) + 1
    return out


def extraction(n: int, h: int) -> tuple[int, int]:
    residual, root = 1, 1
    for p, e in factor(n).items():
        q, r = divmod(e, h)
        residual *= p**r
        root *= p**q
    assert residual * root**h == n
    return residual, root


def quartic(a, b):
    return a**4 + 3 * a**3 * b + 5 * a**2 * b**2 + 3 * a * b**3 + b**4


def main():
    seed_count = 0
    lift_count = 0
    extracted_nonunit_count = 0
    for a in range(1, 31):
        for b in range(1, 31):
            if gcd(a, b) != 1:
                continue
            seed_count += 1
            value = quartic(a, b)
            for h in range(2, 13):
                delta = gcd(h, 4)
                m, k = h // delta, 4 // delta
                assert 4 * m == h * k
                residual, root = extraction(value, h)
                beta, denominator_root = extraction(b, m)
                x = Fraction(a, b)
                y = Fraction(root, denominator_root**k)
                assert y**h == beta**4 * quartic(x, 1) / residual
                recovered_root = y * denominator_root**k
                assert recovered_root.denominator == 1
                assert recovered_root.numerator == root
                assert quartic(a, b) == residual * recovered_root**h
                extracted_nonunit_count += root > 1
                lift_count += 1

    valuation_cases = 0
    genera = []
    for h in range(2, 65):
        delta = gcd(h, 4)
        m = h // delta
        for exponent in range(-4 * h, 4 * h + 1):
            assert ((4 * exponent) % h == 0) == (exponent % m == 0)
            valuation_cases += 1
        direct_numerator = 3 * h - 2 - delta
        assert direct_numerator % 2 == 0
        direct_genus = direct_numerator // 2
        descent_genus = 1 + h * h * (h - 2)
        assert 2 * direct_genus - 2 == -2 * h + 4 * (h - 1) + h - delta
        assert 2 * descent_genus - 2 == -2 * h**3 + 4 * h * h * (h - 1)
        assert (direct_genus > 1) == (h >= 3)
        assert (descent_genus > 1) == (h >= 3)
        if h <= 12:
            genera.append({"h": h, "direct_genus": direct_genus, "descent_genus": descent_genus})

    assert quartic(1, 2) == 67
    naive_value = quartic(Fraction(1, 2), 1) / 67
    assert naive_value == Fraction(1, 16)
    bad_h = [h for h in range(2, 65) if 4 % h]
    assert all(-4 % h for h in bad_h)
    results = {
        "scope": "Finite exact arithmetic replay only; not Kummer, class-group, Faltings, or ABC formalization.",
        "primitive_seeds": seed_count,
        "exact_lifts": lift_count,
        "lifts_with_nonunit_extracted_root": extracted_nonunit_count,
        "minimal_denominator_valuation_cases": valuation_cases,
        "naive_map_counterexample": {"a": 1, "b": 2, "F": 67, "D": 67, "W": 1, "F_x_over_D": "1/16", "fails_for": "every h not dividing 4"},
        "genera": genera,
        "status": "PASS",
    }
    data = (json.dumps(results, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode("utf-8")
    target = Path(__file__).with_name("exact_power_lifting_results.json")
    target.write_bytes(data)
    print(json.dumps({"output": str(target), "sha256": sha256(data).hexdigest(), "primitive_seeds": seed_count, "exact_lifts": lift_count, "status": "PASS"}))


if __name__ == "__main__":
    main()
