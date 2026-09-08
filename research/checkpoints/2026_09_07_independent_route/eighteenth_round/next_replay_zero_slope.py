"""Exact rational zero-slope recursions; next-only and no zero search.

The infinite tail bound is the ordinary ZS proof. This finite checker
recomputes the exact ODE and leading digits, without PARI or Frobenius.
"""
from argparse import ArgumentParser
from fractions import Fraction as F
from hashlib import sha256
import json
from pathlib import Path

HERE = Path(__file__).resolve().parent
OUT = HERE / "next_zero_slope_exact.json"
DEGREE = 40


def require(c, message):
    if not c:
        raise ValueError(message)


def mul(a, b):
    n = len(a) - 1
    return [sum((a[k] * b[j-k] for k in range(j+1)), F(0))
            for j in range(n+1)]


def inv(a):
    n = len(a) - 1
    require(a[0] != 0, "inverse constant is zero")
    b = [1/a[0]] + [F(0)] * n
    for j in range(1, n+1):
        b[j] = -sum((a[k]*b[j-k] for k in range(1, j+1)), F(0))/a[0]
    return b


def v5(a):
    a = F(a)
    if not a:
        return 10**6
    n, d = abs(a.numerator), a.denominator
    v = 0
    while n % 5 == 0:
        n //= 5
        v += 1
    while d % 5 == 0:
        d //= 5
        v -= 1
    return v


def floor_log5(n):
    k = 0
    while n >= 5:
        n //= 5
        k += 1
    return k


def integral_residue(x, prec):
    x = F(x)
    require(v5(x) >= 0, "requested residue of nonintegral element")
    mod = 5**prec
    return x.numerator * pow(x.denominator, -1, mod) % mod


def series(a, b, n):
    # w=t^3 U, so U=1+a t^4 U^2+b t^6 U^3.
    U = [F(1)] + [F(0)] * n
    for _ in range(n+1):
        U2 = mul(U, U)
        U3 = mul(U2, U)
        new = [F(1)] + [F(0)] * n
        for j in range(4, n+1):
            new[j] += a*U2[j-4]
        for j in range(6, n+1):
            new[j] += b*U3[j-6]
        if new == U:
            break
        U = new
    else:
        raise ValueError("formal fixed point failed to stabilize")
    require(all(x.denominator == 1 for x in U), "w is not integral")
    Uinv = inv(U)
    tUprime = [j*U[j] for j in range(n+1)]
    half_tlogUprime = [x/2 for x in mul(tUprime, Uinv)]
    A = half_tlogUprime
    A[0] += 1
    f = mul(A, Uinv)  # x A=t^-2 f.
    require(f[1] == 0, "Laurent primitive has logarithmic residue")
    L = [F(0)] + [A[j-1]/j for j in range(1, n+1)]
    R = [F(0)] + [
        -sum((A[j-k]*f[k]/(k-1) for k in range(j+1) if k != 1),
             F(0))/j for j in range(1, n+1)]
    # Check the zero-slope differential equation:
    # Dlog(sigma_0)=(1/t+R')/A, so tB'-B=-f for B=(1+tR')/A.
    numerator = [F(1)] + [j*R[j] for j in range(1, n+1)]
    B = mul(numerator, inv(A))
    require(all((j-1)*B[j] == -f[j] for j in range(n+1)),
            "exact logarithmic sigma ODE failed")
    require(all(R[j] == 0 for j in range(1, n+1, 2)), "R is not even")
    require(all(L[j] == 0 for j in range(0, n+1, 2)), "L is not odd")
    require(R[4] == F(5*a, 12) and R[6] == F(13*b, 30),
            "first exact rational coefficients differ")
    require(all(v5(R[j]) >= -2*floor_log5(j) for j in range(1, n+1)),
            "finite sigma coefficient bound failed")
    require(all(v5(L[j]) >= -floor_log5(j) for j in range(1, n+1)),
            "finite log coefficient bound failed")
    return L, R


def add(P, Q, a):
    if P is None:
        return Q
    if Q is None:
        return P
    x, y = P
    X, Y = Q
    if x == X and y == -Y:
        return None
    slope = (3*x*x+a)/(2*y) if P == Q else (Y-y)/(X-x)
    r = slope*slope-x-X
    return r, slope*(x-r)-y


def nine(P, a):
    Q = P
    for _ in range(3):
        Q = add(Q, Q, a)
    return add(Q, P, a)


def evaluate(c, t):
    z = F(0)
    for x in reversed(c):
        z = z*t+x
    return z


def log_unit_truncated(q, n):
    s = q**4-1
    require(v5(s) >= 1, "unit fourth power outside logarithm disk")
    term, z = F(1), F(0)
    for j in range(1, n+1):
        term *= s
        z += (-1)**(j+1)*term/j
    return z/4


def point_row(a, b, P, expected_log_unit, expected_height):
    L, R = series(a, b, DEGREE)
    Q = nine(tuple(map(F, P)), a)
    x, y = Q
    require(y*y == x*x*x+a*x+b, "ninefold point is off curve")
    t = -x/y
    require(v5(t) == 1, "formal parameter lacks depth one")
    # Recover d from x=A/d^2; q=t/d=-A/B.
    from math import isqrt
    d = isqrt(x.denominator)
    require(d*d == x.denominator, "denominator is not a square")
    q = t/d
    Lval = evaluate(L, t)/9
    H0 = -F(2, 81)*(log_unit_truncated(q, DEGREE)+evaluate(R, t))
    require(v5(Lval) == 1 and v5(H0) == 1, "actual leading valuations differ")
    require(integral_residue(Lval/5, 1) == expected_log_unit,
            "QL logarithm unit differs")
    require(integral_residue(H0, 2) == expected_height,
            "HT leading height differs")
    alpha0 = H0/(Lval*Lval)
    require(v5(alpha0) == -1, "alpha valuation differs")
    return {
        "curve": [a, b], "base_point": P, "degree": DEGREE,
        "exact_R_nonzero_coefficients": [
            [j, str(R[j].numerator), str(R[j].denominator)]
            for j in range(1, DEGREE+1) if R[j]],
        "exact_L_nonzero_coefficients": [
            [j, str(L[j].numerator), str(L[j].denominator)]
            for j in range(1, DEGREE+1) if L[j]],
        "formal_t_valuation": v5(t), "log_valuation": v5(Lval),
        "height0_valuation": v5(H0), "alpha0_valuation": v5(alpha0),
        "height0_mod_5pow8": integral_residue(H0, 8),
        "log_div5_mod_5pow8": integral_residue(Lval/5, 8),
        "five_alpha0_mod_5pow8": integral_residue(5*alpha0, 8),
        "ordinary_all_tail_bound_at_degree40": 21,
        "alpha_computation_absolute_precision_at_least": 19,
    }


def compute():
    rows = [point_row(-9, -9, [-2, 1], 4, 5),
            point_row(-189, 999, [6, 9], 2, 10)]
    # A secondary comparison only: the exact recursions above use no
    # PARI outputs. Compare their proved digits to the old pinned audit.
    prior_path = HERE / "verification/height_transport.json"
    prior_bytes = prior_path.read_bytes()
    require(sha256(prior_bytes).hexdigest() ==
            "70ec75594f205336757496605750b1302e5f3b271afd6acf5b12275a36c9de05",
            "prior source-audit certificate changed")
    comparisons = []
    for raw in json.loads(prior_bytes)["rows"]:
        i, requested = raw[0]-1, raw[1]
        v, prec, unit = raw[3][0]
        require(prec >= 8 and v >= 0, "insufficient prior absolute precision")
        residue = unit * 5**v % 5**8
        require(residue == rows[i]["height0_mod_5pow8"],
                "prior PARI raw a differs from exact zero-slope computation")
        comparisons.append([i+1, requested, residue])
    return {
        "status": "PASS",
        "scope": "exact finite rational recursions and actual point leading digits; ordinary ZS supplies infinite tail theorem; no roots or rational point classification",
        "rows": rows,
        "secondary_prior_PARI_a_mod_5pow8": comparisons,
        "secondary_prior_certificate_sha256": sha256(prior_bytes).hexdigest(),
    }


if __name__ == "__main__":
    ap = ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    data = (json.dumps(compute(), sort_keys=True, indent=2)+"\n").encode()
    if args.check:
        require(OUT.read_bytes() == data, "canonical certificate differs")
    else:
        OUT.write_bytes(data)
    print("PASS two curves; exact degree-40 ODE and all finite coefficient bounds;",
          "SHA256", sha256(data).hexdigest())
