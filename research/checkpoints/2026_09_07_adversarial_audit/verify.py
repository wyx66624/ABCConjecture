"""Exact independent finite replay; no float comparisons or ABC claims."""
from fractions import Fraction
from math import gcd
from pathlib import Path
import hashlib
import json


def factor(n):
    result = {}
    p = 2
    while p * p <= n:
        while n % p == 0:
            result[p] = result.get(p, 0) + 1
            n //= p
        p = 3 if p == 2 else p + 2
    if n > 1:
        result[n] = result.get(n, 0) + 1
    return result


def radical(n):
    r = 1
    for p in factor(n):
        r *= p
    return r


def roots(count):
    r, modulus = 2, 7
    for h in range(1, count + 1):
        x = next(r + j * modulus for j in range(4)
                 if (r + j * modulus) % 4 == 2)
        yield h, x
        digit = next(d for d in range(7)
                     if ((r * r + r + 1) // modulus
                         + d * (2 * r + 1)) % 7 == 0)
        r += digit * modulus
        modulus *= 7


def main():
    rows = []
    # Trial division of the actual factors, without a probabilistic primality
    # test. The six rows are bounded diagnostics only.
    for h, x in roots(6):
        g = x * x + x + 1
        assert 2 <= x < 4 * 7 ** h
        assert x % 4 == 2 and x % 7 == 2 and g % 7 ** h == 0
        assert gcd(x, x - 1) == 1 and gcd(1, x ** 3 - 1) == 1
        r1 = radical(x) * radical(x - 1)
        r3 = radical(x) * radical(x - 1) * radical(g)
        # GCD(x - 1,G) divides three, so account for it explicitly.
        r3 //= radical(gcd(x - 1, g))
        assert 7 ** (h - 1) * r3 <= r1 * g
        assert r3 < 84 * x * r1
        ratios = {}
        for m in (2, 3, 5):
            ratio = Fraction(x ** (2 * m) * r1 ** (m + 1),
                             r3 ** (m + 1))
            bound = Fraction(x ** (m - 1), 84 ** (m + 1))
            assert ratio > bound
            q_seed = Fraction(x ** m, r1 ** (m + 1))
            q_lift = Fraction(x ** (3 * m), r3 ** (m + 1))
            assert ratio == q_lift / q_seed
            ratios[str(m)] = {
                "actual_numerator": ratio.numerator,
                "actual_denominator": ratio.denominator,
                "lower_numerator": bound.numerator,
                "lower_denominator": bound.denominator,
            }
        rows.append({"h": h, "x": x, "G": g, "R1": r1, "R3": r3,
                     "factor_x": factor(x), "factor_x_minus_1": factor(x - 1),
                     "factor_G": factor(g), "ratios": ratios})
    lifts = list(roots(100))
    for h, x in lifts:
        assert 2 <= x < 4 * 7 ** h
        assert x % 4 == 2 and x % 7 == 2
        assert (x * x + x + 1) % 7 ** h == 0
        assert 7 ** h <= x * x + x + 1
    payload = {"status": "finite exact replay only", "factorized_rows": rows,
               "factorized_row_count": len(rows), "lift_count": len(lifts),
               "largest_lift_decimal_digits": len(str(lifts[-1][1]))}
    output = Path(__file__).parent / "verification" / "exact_results.json"
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_bytes((json.dumps(payload, indent=2) + "\n").encode("utf-8"))
    print(json.dumps({"ok": True, "factorized_rows": len(rows),
                      "lifts": len(lifts),
                      "sha256": hashlib.sha256(output.read_bytes()).hexdigest()}))


if __name__ == "__main__":
    main()
