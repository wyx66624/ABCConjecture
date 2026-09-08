"""Exact finite inputs for the separate squared-unit genus-two quotient.

No rank oracle, point-height cutoff, Sage, PARI or floating-point arithmetic.
The ordinary note supplies the Jacobian and rank interpretation.
"""
from argparse import ArgumentParser
from collections import Counter
from hashlib import sha256
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / "next_zeta_squared_reductions.json"


def require(condition, message):
    if not condition:
        raise ValueError(message)


def field_certificate(p, d):
    require(d % p not in {x*x % p for x in range(p)},
            "the displayed quadratic must be irreducible")
    elements = [(a, b) for a in range(p) for b in range(p)]

    def add(x, y):
        return ((x[0]+y[0]) % p, (x[1]+y[1]) % p)

    def mul(x, y):
        return ((x[0]*y[0]+d*x[1]*y[1]) % p,
                (x[0]*y[1]+x[1]*y[0]) % p)

    def scale(x, n):
        return (n*x[0] % p, n*x[1] % p)

    def rhs(x):
        cubic = add(add(mul(mul(x, x), x), scale(x, -3)), (-1, 0))
        return scale(mul(mul(x, add(x, (1, 0))), cubic), -3)

    squares = Counter(mul(y, y) for y in elements)
    require(squares[(0, 0)] == 1, "zero square fiber")
    require(all(n == 2 for x, n in squares.items() if x != (0, 0)),
            "nonzero square fibers")
    rows = [{"x": list(x), "rhs": list(rhs(x)),
             "number_of_y": squares[rhs(x)]} for x in elements]
    prime_rows = []
    for x in range(p):
        ys = [y for y in range(p) if mul((y, 0), (y, 0)) == rhs((x, 0))]
        prime_rows.append({"x": x, "rhs": rhs((x, 0))[0], "ys": ys})
    # The squarefree quintic has one smooth point at infinity over both fields.
    n1 = 1 + sum(len(row["ys"]) for row in prime_rows)
    n2 = 1 + sum(row["number_of_y"] for row in rows)
    a1 = p+1-n1
    numerator = n2-p*p-1+a1*a1
    require(numerator % 2 == 0, "integral second Frobenius coefficient")
    a2 = numerator // 2
    frobenius = [1, -a1, a2, -p*a1, p*p]
    return {"p": p, "quadratic_relation": [d, 0],
            "field_description": "pairs a+b*u with u^2=d",
            "prime_field_fibers": prime_rows,
            "quadratic_field_fibers_lexicographic": rows,
            "infinity_points_over_each_field": 1,
            "N_p": n1, "N_p_squared": n2,
            "frobenius_coefficients_descending": frobenius,
            "jacobian_order": sum(frobenius)}


def compute():
    cases = [field_certificate(5, 2), field_certificate(7, 3)]
    require([(c["N_p"], c["N_p_squared"], c["jacobian_order"])
             for c in cases] == [(3, 25, 12), (9, 37, 52)],
            "unexpected complete field counts")
    require(cases[0]["frobenius_coefficients_descending"] == [1, -3, 4, -15, 25],
            "Frobenius at five")
    require(cases[1]["frobenius_coefficients_descending"] == [1, 1, -6, 7, 49],
            "Frobenius at seven")
    # The smoothness proof uses cubic discriminant 81 and values -1,1 at 0,-1.
    a, b, c, e = 1, 0, -3, -1
    disc = b*b*c*c-4*a*c**3-4*b**3*e-27*a*a*e*e+18*a*b*c*e
    require(disc == 81, "cubic discriminant")
    for p in (5, 7):
        require(81 % p != 0 and (-1) % p != 0 and 1 % p != 0,
                "all component discriminants and resultants are units")
    from math import gcd, isqrt
    require(gcd(12, 52) == 4, "torsion common order")
    require(52 % 5 != 0 and 12 % 7 != 0, "separate bad-primary exclusions")
    require(isqrt(33)**2 != 33, "integer elliptic-trace factor obstruction")
    return {"schema": "zeta-squared-reductions-v1",
            "curve": "y^2=-3*s*(s+1)*(s^3-3*s-1)",
            "cases": cases, "cubic_discriminant": disc,
            "cubic_values_at_rational_roots": [-1, 1],
            "jacobian_order_gcd": 4,
            "elliptic_factor_trace_discriminant_at_five": 33,
            "scope": "complete finite fibers and arithmetic inputs only; no rank or rational-point classification"}


def main():
    parser = ArgumentParser()
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--write", action="store_true")
    mode.add_argument("--check", action="store_true")
    args = parser.parse_args()
    payload = (json.dumps(compute(), indent=2, sort_keys=True)+chr(10)).encode()
    if args.write:
        OUT.write_bytes(payload)
    else:
        require(OUT.read_bytes() == payload, "canonical finite result mismatch")
    print("PASS: F5/F25/F7/F49 complete fibers; SHA256 "+sha256(payload).hexdigest())


if __name__ == "__main__":
    main()
