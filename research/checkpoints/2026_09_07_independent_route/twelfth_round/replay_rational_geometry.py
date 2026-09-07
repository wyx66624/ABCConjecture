"""Exact finite RL/UG/HG checks; no curve, Jacobian, or point-completeness claim."""
from __future__ import annotations

import argparse
from fractions import Fraction as Q
from hashlib import sha256
from itertools import combinations
from math import comb, gcd, lcm
from pathlib import Path
import json


HERE = Path(__file__).resolve().parent
OUT = HERE / "verification" / "rational_geometry_replay.json"


def trim(a):
    a = list(a)
    while len(a) > 1 and a[-1] == 0:
        a.pop()
    return a


def add(a, b):
    c = [0] * max(len(a), len(b))
    for i, x in enumerate(a):
        c[i] += x
    for i, x in enumerate(b):
        c[i] += x
    return trim(c)


def scale(a, c):
    return trim([c * x for x in a])


def sub(a, b):
    return add(a, scale(b, -1))


def mul(a, b):
    c = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            c[i + j] += x * y
    return trim(c)


def power(a, n):
    r = [1]
    for _ in range(n):
        r = mul(r, a)
    return r


def derivative(a):
    return trim([i * a[i] for i in range(1, len(a))] or [0])


def primitive(a):
    a = trim(a)
    den = lcm(*(Q(x).denominator for x in a))
    vals = [int(Q(x) * den) for x in a]
    common = 0
    for x in vals:
        common = gcd(common, abs(x))
    if not common:
        return [0]
    if vals[-1] < 0:
        common = -common
    return [x // common for x in vals]


def remainder(a, b):
    a, b = list(map(Q, a)), list(map(Q, b))
    assert b != [0]
    while a != [0] and len(a) >= len(b):
        c, d = a[-1] / b[-1], len(a) - len(b)
        for j, x in enumerate(b):
            a[j + d] -= c * x
        a = trim(a)
    return primitive(a)


def pgcd(a, b):
    a, b = primitive(a), primitive(b)
    while b != [0]:
        a, b = b, remainder(a, b)
    return primitive(a)


def evaluate(a, x):
    out = Q(0)
    for c in reversed(a):
        out = out * x + c
    return out


def qadd(x, y):
    return x[0] + y[0], x[1] + y[1]


def qneg(x):
    return -x[0], -x[1]


def qmul(x, y, tr):
    # theta^2=tr*theta-1: tr=1 is zeta and tr=0 is i.
    a, b = x
    c, d = y
    return a * c - b * d, a * d + b * c + tr * b * d


def qconj(x, tr):
    return x[0] + tr * x[1], -x[1]


def qdiv(x, y, tr):
    n = y[0] ** 2 + tr * y[0] * y[1] + y[1] ** 2
    assert n != 0
    z = qmul(x, qconj(y, tr), tr)
    return z[0] / n, z[1] / n


def qpow(x, n, tr):
    out = (1, 0)
    for _ in range(n):
        out = qmul(out, x, tr)
    return out


def pair_poly_mul(x, y):
    a, b = x
    c, d = y
    return sub(mul(a, c), mul(b, d)), add(add(mul(a, d), mul(b, c)), mul(b, d))


def coordinate_forms(g, u):
    out = ([1], [0])
    for _ in range(g):
        out = pair_poly_mul(out, ([0, 1], [1]))
    for _ in range(u):
        out = pair_poly_mul(out, ([0], [1]))
    # Independent binomial expansion using scalar zeta powers.
    aa, bb = [0] * (g + 1), [0] * (g + 1)
    for j in range(g + 1):
        z = qpow((0, 1), u + j, 1)
        aa[g - j] += comb(g, j) * z[0]
        bb[g - j] += comb(g, j) * z[1]
    assert out == (trim(aa), trim(bb))
    return out


def homogeneous_simple(a, degree):
    assert degree - (len(a) - 1) in (0, 1), "infinity multiplicity"
    assert pgcd(a, derivative(a)) == [1], "multiple finite root"


def homogeneous_coprime(a, b, degree):
    assert pgcd(a, b) == [1]
    assert not (len(a) <= degree and len(b) <= degree), "shared infinity"


def polynomial_checks():
    t, one = [0, 1], [1]
    a, b, c, u = [-1, 0, 1], [1, 2], [0, 2, 1], [1, 1, 1]
    d = sub(a, b)
    ab = mul(a, b)
    tests = {
        "first_norm_square": sub(add(add(power(a, 2), ab), power(b, 2)), power(u, 2)),
        "c_square": sub(power(c, 2), add(power(u, 2), ab)),
        "d_square": sub(power(d, 2), sub(power(u, 2), scale(ab, 3))),
        "conic_relation": sub(add(power(d, 2), scale(power(c, 2), 3)), scale(power(u, 2), 4)),
        "inverse_t": sub(add(add(c, d), scale(u, 2)), mul(t, sub(c, d))),
        "positive_c_minus_u": sub(sub(c, u), sub(t, one)),
    }
    assert all(x == [0] for x in tests.values())
    homogeneous_simple(ab, 4)
    for f in (power(u, 2), mul(u, c)):
        homogeneous_coprime(ab, f, 4)
    return {name: "zero polynomial" for name in tests}


def branch_forms():
    rows = []
    for g in range(3, 16, 2):
        for unit in range(3):
            a, b = coordinate_forms(g, unit)
            forms = (b, add(a, b), sub(b, scale(a, 3)))
            homogeneous_coprime(a, b, g)
            for f in forms:
                homogeneous_simple(f, g)
            for x, y in combinations(forms, 2):
                homogeneous_coprime(x, y, g)
                homogeneous_simple(mul(x, y), 2 * g)
            rows.append({
                "g": g, "unit_zeta_power": unit,
                "A": a, "B": b,
                "three_branch_forms": forms,
                "infinity_multiplicities": [g + 1 - len(f) for f in forms],
                "quotient_genus": g - 1,
            })
    a, b = coordinate_forms(3, 0)
    assert a == [-1, -3, 0, 1] and b == [0, 3, 3]
    assert add(a, b) == [-1, 0, 3, 1]
    assert sub(b, scale(a, 3)) == [3, 12, 3, -3]
    return rows


def norm_one_checks():
    vals = sorted({Q(num, den) for den in range(1, 13) for num in range(-20, 21)})
    digest_rows = []
    for tr in (0, 1):
        for s in vals:
            y = qdiv((s, Q(1)), (s + tr, Q(-1)), tr)
            assert qmul(y, qconj(y, tr), tr) == (1, 0)
            assert y != (1, 0)
            if tr == 1:
                numerator = qadd((0, 1), qneg(qmul(y, (1, -1), 1)))
            else:
                numerator = qmul((0, 1), qadd(y, (1, 0)), 0)
            inverse = qdiv(numerator, qadd(y, (-1, 0)), tr)
            assert inverse == (s, 0)
            digest_rows.append([tr, str(s), [str(x) for x in y]])
        # The missing projective parameter is explicitly infinity -> one.
        assert qmul((1, 0), qconj((1, 0), tr), tr) == (1, 0)
    return {
        "finite_parameters_per_field": len(vals),
        "finite_inverse_checks": len(digest_rows),
        "infinity_branches": 2,
        "exact_rows_sha256": sha256(canonical(digest_rows)).hexdigest(),
    }


def positive_chart_checks():
    vals = sorted({Q(num, den) for den in range(1, 16) for num in range(den + 1, 6 * den + 1)})
    rows = []
    for t in vals:
        a0, b0 = t * t - 1, 2 * t + 1
        c0, u0 = t * t + 2 * t, t * t + t + 1
        v, w, r = c0 / u0, (a0 - b0) / u0, a0 * b0 / u0 ** 2
        assert v > 0 and 0 < r < Q(1, 3)
        assert v ** 2 == 1 + r and w ** 2 == 1 - 3 * r
        assert (v + w + 2) / (v - w) == t
        x = a0 / b0
        a, b = x.numerator, x.denominator
        uu = b * u0 / b0
        assert uu.denominator == 1
        uu = int(uu)
        assert gcd(a, b) == 1 and a > 0 and b > 0
        assert a * a + a * b + b * b == uu * uu
        assert uu >= 7
        assert v == Q(a + b, uu) and w == Q(a - b, uu)
        swap_t = (v - w + 2) / (v + w)
        assert swap_t == (t + 2) / (t - 1) and swap_t > 1
        rows.append({"t": str(t), "a": a, "b": b, "U": uu})
    return rows


def ug_and_jacobian_arithmetic():
    rows = []
    for g in range(3, 102, 2):
        m = (g + 1) // 2
        # In the Laurent exponent lattice of (T,f), T^g=f^2.
        relation = (g, -2)
        w = (m, -1)
        assert (g * w[0], g * w[1] - 1) == (m * relation[0], m * relation[1])
        assert (2 * w[0] - 1, 2 * w[1]) == relation
        gd, gc = 3 * g - 3, 1 + 3 * g * g - 4 * g
        assert 2 * gd - 2 == -2 * g + 8 * (g - 1)
        assert 2 * gc - 2 == g * (2 * gd - 2)
        assert gd == 3 * (g - 1)
        rows.append([g, m, gd, gc])
    # Sum of three double-quotient traces minus full V4 trace.
    traces = ([1, 1, 0, 0], [1, 0, 1, 0], [1, 0, 0, 1])
    assert [sum(row[j] for row in traces) - 1 for j in range(4)] == [2, 0, 0, 0]
    return {
        "odd_exponent_lattice_and_RH_rows": rows,
        "V4_integral_group_ring_identity": [2, 0, 0, 0],
    }


def canonical(data):
    return (json.dumps(data, sort_keys=True, ensure_ascii=True, indent=2) + "\n").encode("utf-8")


def run():
    poly = polynomial_checks()
    branches = branch_forms()
    norm = norm_one_checks()
    chart = positive_chart_checks()
    ug = ug_and_jacobian_arithmetic()
    return {
        "schema": 1,
        "source_sha256": sha256(Path(__file__).read_bytes()).hexdigest(),
        "method": "Python standard library: exact integers, Fraction, polynomial Euclidean algorithm",
        "scope": {
            "proves_infinite_geometric_theorems": False,
            "enumerates_all_rational_points": False,
            "asserts_second_power_for_chart_samples": False,
            "computes_Jacobian_rank_or_torsion": False,
            "claims_Lean_formalization": False,
        },
        "summary": {
            "polynomial_identities": len(poly),
            "homogeneous_branch_cases": len(branches),
            "rho_finite_inverse_checks": norm["finite_inverse_checks"],
            "rho_infinity_branches": 2,
            "actual_first_square_chart_samples": len(chart),
            "odd_exponent_lattice_and_RH_cases": len(ug["odd_exponent_lattice_and_RH_rows"]),
            "integral_group_ring_identities": 1,
        },
        "polynomial_identities": poly,
        "branch_cases": branches,
        "norm_one_inverse": norm,
        "positive_chart_samples": chart,
        "UG_HG_arithmetic": ug,
    }


def main():
    parser = argparse.ArgumentParser()
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--write", action="store_true")
    mode.add_argument("--check", action="store_true")
    args = parser.parse_args()
    result = run()
    data = canonical(result)
    if args.write:
        OUT.parent.mkdir(parents=True, exist_ok=True)
        OUT.write_bytes(data)
    else:
        if not OUT.exists() or OUT.read_bytes() != data:
            raise SystemExit("FAIL: immutable canonical certificate differs or is absent")
    print(json.dumps({"status": "PASS", "sha256": sha256(data).hexdigest(), "summary": result["summary"]}, sort_keys=True))


if __name__ == "__main__":
    main()
