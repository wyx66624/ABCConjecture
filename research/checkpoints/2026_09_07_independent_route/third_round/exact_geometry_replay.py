"""Exact finite certificates for quartic_square_geometry.md; no rank oracle.

The infinite-order, density, descent, and genus arguments are ordinary proofs.
These checks replay arithmetic certificates, not a substitute for those proofs.
"""
from fractions import Fraction as R
from math import gcd, isqrt
from pathlib import Path
import json


def ec_add(P, Q, a=-1, b=-3):
    if P is None:
        return Q
    if Q is None:
        return P
    x, y = P
    z, w = Q
    if x == z and y == -w:
        return None
    slope = (3*x*x+2*a*x+b)/(2*y) if P == Q else (w-y)/(z-x)
    X = slope*slope-a-x-z
    return X, -y+slope*(x-X)


def valuation_integer(n, p):
    assert n
    v = 0
    while n % p == 0:
        n //= p
        v += 1
    return v


def valuation(q, p):
    return valuation_integer(q.numerator, p)-valuation_integer(q.denominator, p)


def F(a, b):
    return a**4+3*a**3*b+5*a*a*b*b+3*a*b**3+b**4


def trim(p):
    p = list(p)
    while len(p) > 1 and not p[-1]:
        p.pop()
    return p


def padd(p, q):
    return trim([(p[i] if i < len(p) else 0)+(q[i] if i < len(q) else 0)
                 for i in range(max(len(p), len(q)))])


def pmul(p, q):
    r = [0]*(len(p)+len(q)-1)
    for i, a in enumerate(p):
        for j, b in enumerate(q):
            r[i+j] += a*b
    return trim(r)


def pmod(p, q):
    p = [R(a) for a in trim(p)]
    q = trim(q)
    while len(p) >= len(q) and any(p):
        s, c = len(p)-len(q), p[-1]/q[-1]
        for i, a in enumerate(q):
            p[i+s] -= c*a
        p = trim(p)
    return p


def pgcd(p, q):
    while any(q):
        p, q = q, pmod(p, q)
    return [R(a)/p[-1] for a in p]


def main():
    P = (R(3), R(3))
    Q = None
    orbit = []
    for n in range(1, 13):
        Q = ec_add(Q, P)
        assert Q is not None
        X, Y = Q
        assert Y*Y == X**3-X*X-3*X
        row = {"n": n, "X": str(X), "Y": str(Y)}
        if X not in (0, 4):
            x = (2*Y+3*X)/(X*(X-4))
            y = 1+R(3, 2)*x+(1-X/2)*x*x
            assert y*y == F(x, 1)
            if x:
                u = (y-1-R(3, 2)*x)/(x*x)
                assert X == 2-2*u
                assert Y == X*((X-4)*x-3)/2
            row.update(x=str(x), y=str(y))
            if x > 0:
                a, b = x.numerator, x.denominator
                Z = y*b*b
                assert Z.denominator == 1 and Z*Z == F(a, b)
                assert gcd(a, b) == 1
                row.update(a=a, b=b, square_root=abs(Z.numerator))
        orbit.append(row)
    assert orbit[2]["a"] == 101 and orbit[2]["b"] == 355
    assert orbit[2]["square_root"] == 192529

    Q = (R(361, 144), R(2413, 1728))
    doubling_depths = []
    for j in range(7):
        s = valuation(Q[0], 2)
        assert s == -4-2*j
        doubling_depths.append(s)
        Q = ec_add(Q, Q)

    parity_classes = [(1, 0), (1, 1), (0, 1)]
    square16 = {n*n % 16 for n in range(16)}
    local = []
    for a, b, d in [(-4, 16, 2), (-12, 144, 2), (-12, 144, 6)]:
        residues = {}
        for i, j in parity_classes:
            vals = sorted({(d*u**4+a*u*u*v*v+(b//d)*v**4) % 16
                           for u in range(16) for v in range(16)
                           if u % 2 == i and v % 2 == j})
            assert not square16.intersection(vals)
            residues[str((i, j))] = vals
        local.append({"a": a, "b": b, "d": d, "residues_mod16": residues})
    mod3 = sorted({(u**4-u*u*v*v+v**4) % 3 for u in range(3)
                   for v in range(3) if u or v})
    assert mod3 == [1]

    reductions = []
    for a, b in [(2, -3), (6, -27)]:
        row = {"a": a, "b": b, "counts": {}}
        for p in (5, 7):
            assert (16*b*b*(a*a-4*b)) % p != 0
            points = [(x, y) for x in range(p) for y in range(p)
                      if (y*y-x*(x*x+a*x+b)) % p == 0]
            row["counts"][str(p)] = 1+len(points)
        reductions.append(row)
    assert reductions[0]["counts"] == {"5": 8, "7": 8}
    assert reductions[1]["counts"] == {"5": 4, "7": 8}

    torsion_lists = [
        [(0, 0), (1, 0), (-3, 0), (-1, 2), (-1, -2), (3, 6), (3, -6)],
        [(0, 0), (3, 0), (-9, 0)],
    ]
    for (a, b), pts in zip([(2, -3), (6, -27)], torsion_lists):
        for x, y in pts:
            assert y*y == x*(x*x+a*x+b)

    identities = 0
    for a in range(1, 80):
        for b in range(1, 80):
            c, U = a+b, a*b
            M0, M1 = a*a+a*b+b*b, F(a, b)
            S = 2*c*c-U
            assert S**4+2*S*S*U*U-3*U**4 == 16*c*c*M0*M1
            assert S >= 7*U
            product = M0*M1
            assert isqrt(product)**2 != product
            if product % 3 == 0:
                assert isqrt(product//3)**2 != product//3
            identities += 1

    A, B = [0, 1], [1]
    polys, tower = [], []
    for j in range(5):
        AA, AB, BB = pmul(A, A), pmul(A, B), pmul(B, B)
        A, B = AB, padd(padd(AA, AB), BB)
        assert len(B)-1 == 2**(j+1)
        derivative = [i*B[i] for i in range(1, len(B))]
        assert pgcd(B, derivative) == [1]
        for prev in polys:
            assert pgcd(B, prev) == [1]
        polys.append(B)
        k = j+1
        genus = R(1)+R(2)**(k-2)*(2**(k+1)-6)
        assert genus.denominator == 1
        tower.append({"j": j, "coefficients_low_first": B,
                      "degree": len(B)-1, "cover_genus": genus.numerator})
    assert polys[0] == [1, 1, 1]
    assert polys[1] == [1, 3, 5, 3, 1]
    assert [t["cover_genus"] for t in tower[:3]] == [0, 3, 21]

    report = {"status": "passed", "elliptic_multiples": orbit,
              "doubling_v2": doubling_depths, "descent_mod16": local,
              "dual_class3_mod3": mod3, "good_reductions": reductions,
              "combined_identity_integer_cases": identities,
              "dynamic_polynomials": tower,
              "scope": "Exact finite replay; infinite proofs and external theorems remain ordinary mathematics."}
    target = Path(__file__).with_name("exact_geometry_results.json")
    target.write_bytes((json.dumps(report, indent=2)+"\n").encode("utf-8"))
    print(json.dumps({"status": "passed", "elliptic_multiples": len(orbit),
                      "doubling_checks": len(doubling_depths),
                      "integer_identity_cases": identities,
                      "dynamic_levels": len(tower)}))


if __name__ == "__main__":
    main()
