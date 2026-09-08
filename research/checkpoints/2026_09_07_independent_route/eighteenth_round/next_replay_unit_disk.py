"""Exact finite input to UD's ordinary full analytic zero certificate.

No floating point, Sage, PARI, zero sampling, or unbounded computation.
UD proves the entire Tate-ring tail and Hensel theorem applications.
"""
from argparse import ArgumentParser
from functools import lru_cache
from hashlib import sha256
import json
from pathlib import Path

import next_replay_zero_slope as zs

HERE = Path(__file__).resolve().parent
OUT = HERE / "next_unit_disk_exact.json"


def require(c, message):
    if not c:
        raise ValueError(message)


class Dual:
    p = 5
    def __init__(self, c, d=0):
        self.c, self.d = c % self.p, d % self.p
    @classmethod
    def cast(cls, x):
        return x if isinstance(x, cls) else cls(x)
    def __add__(self, x):
        x = self.cast(x)
        return Dual(self.c+x.c, self.d+x.d)
    __radd__ = __add__
    def __neg__(self):
        return Dual(-self.c, -self.d)
    def __sub__(self, x):
        return self+-self.cast(x)
    def __rsub__(self, x):
        return self.cast(x)+-self
    def __mul__(self, x):
        x = self.cast(x)
        return Dual(self.c*x.c, self.c*x.d+self.d*x.c)
    __rmul__ = __mul__
    def inverse(self):
        z = pow(self.c, -1, self.p)
        return Dual(z, -self.d*z*z)
    def __truediv__(self, x):
        return self*self.cast(x).inverse()
    def __rtruediv__(self, x):
        return self.cast(x)*self.inverse()
    def __pow__(self, n):
        if n < 0:
            return self.inverse()**(-n)
        v, b = Dual(1), self
        while n:
            if n & 1:
                v = v*b
            b, n = b*b, n//2
        return v
    def pair(self):
        return [self.c, self.d]


def division(a, b, x, y):
    require((y*y-x**3-a*x-b).pair() == [0, 0],
            "input point or derivative is off the actual curve")
    @lru_cache(None)
    def psi(n):
        if n == 0:
            return Dual(0)
        if n == 1:
            return Dual(1)
        if n == 2:
            return 2*y
        if n == 3:
            return 3*x**4+6*a*x**2+12*b*x-a*a
        if n == 4:
            return 4*y*(x**6+5*a*x**4+20*b*x**3-5*a*a*x*x
                        -4*a*b*x-8*b*b-a**3)
        m = n//2
        if n % 2:
            return psi(m+2)*psi(m)**3-psi(m-1)*psi(m+1)**3
        return psi(m)/(2*y)*(psi(m+2)*psi(m-1)**2
                             -psi(m-2)*psi(m+1)**2)
    # Check the curve equation for every computed multiplication jet.
    for n in range(2, 10):
        pn = x*psi(n)**2-psi(n+1)*psi(n-1)
        on = (psi(n+2)*psi(n-1)**2-psi(n-2)*psi(n+1)**2)/(4*y)
        require((on**2-pn**3-a*pn*psi(n)**4-b*psi(n)**6).pair()
                == [0, 0], "multiplication jet curve identity failed")
    phi = x*psi(9)**2-psi(10)*psi(8)
    omega = (psi(11)*psi(8)**2-psi(7)*psi(10)**2)/(4*y)
    require(phi.c % 5 != 0 and omega.c % 5 != 0,
            "ninefold regular denominator or numerator is not a unit")
    require(psi(9).c % 5 == 0, "ninefold parameter is not formal")
    delta = -phi/omega
    return {"psi": [psi(j).pair() for j in range(12)],
            "phi": phi.pair(), "omega": omega.pair(),
            "delta": delta.pair(),
            "formal_T": (delta*psi(9)).pair(),
            "log_delta_derivative":
                delta.d*pow(delta.c, -1, Dual.p) % Dual.p}


def local_rows(modulus):
    Dual.p = modulus
    z, W = Dual(1, 1), Dual(8, 6)
    x1, y1 = (z*z-9)/4, W/8
    x2, y2 = (33-9/z**2)/4, -9*W/(8*z**3)
    return [division(-9, -9, x1, y1), division(-189, 999, x2, y2)]


def compute():
    rows = local_rows(5)
    deriv = (81+rows[0]["log_delta_derivative"]
             -rows[1]["log_delta_derivative"])%5
    slope = -2*pow(81, -1, 5)*deriv%5
    # Recompute the global leading coefficients from exact Fraction
    # series and points; none are taken from the desired polynomial.
    leading = zs.compute()["rows"]
    logs = [row["log_div5_mod_5pow8"] % 5 for row in leading]
    alphas = [row["five_alpha0_mod_5pow8"] % 5 for row in leading]
    require(logs == [4, 2] and alphas == [1, 3],
            "global exact leading coefficients changed")
    # ell_1/5=logP/5+(1/4)s; ell_2/5=-logP'/5-(1/4)s.
    l1 = [logs[0], pow(4, -1, 5)]
    l2 = [-logs[1] % 5, -pow(4, -1, 5) % 5]
    sq1 = [l1[0]**2, 2*l1[0]*l1[1], l1[1]**2]
    sq2 = [l2[0]**2, 2*l2[0]*l2[1], l2[1]**2]
    quadratic = [(-alphas[0]*x+alphas[1]*y) % 5
                 for x, y in zip(sq1, sq2)]
    # The exact constant is zero by the rational center height identity.
    coefficients = [0, (quadratic[1]+slope) % 5, quadratic[2]]
    require(coefficients == [0, 2, 2], "full mod5 polynomial changed")
    roots = [s for s in range(5)
             if sum(c*s**j for j, c in enumerate(coefficients)) % 5 == 0]
    derivatives = [(coefficients[1]+2*coefficients[2]*s) % 5 for s in roots]
    require(roots == [0, 4] and derivatives == [2, 3],
            "the two simple residue roots changed")
    # A separate mod25 check ties the division-polynomial t coordinate
    # to the independent rational binary-addition ninefold points.
    rows25 = local_rows(25)
    for i, (a, P) in enumerate([(-9, [-2, 1]), (-189, [6, -9])]):
        Q = zs.nine(tuple(map(zs.F, P)), a)
        t = -Q[0]/Q[1]
        require(rows25[i]["formal_T"][0] == zs.integral_residue(t, 2),
                "division-polynomial t differs from exact binary group law")
    return {"status": "PASS",
            "scope": "finite dual-number table and exact global leading digits; UD supplies full analytic tails and complete one-disk Hensel argument; no rationality decision for the second zero",
            "rows_mod5": rows, "rows_mod25": rows25,
            "global_log_div5_mod5": logs, "global_five_alpha_mod5": alphas,
            "elliptic_log_linear_mod5": [l1, l2],
            "log_Xi_derivative": deriv,
            "local_height_linear_slope": slope,
            "normalized_f_mod5_coefficients": coefficients,
            "residue_roots": roots, "root_derivatives": derivatives,
            "ordinary_exact_center_zero": "LH rational height identity at (1,8)",
            "all_tail_theorem": "UD1 in Z5<s>, using the reviewed ZS coefficient bound",
            "primary_division_polynomial_source": "https://math.mit.edu/classes/18.783/2023/LectureNotes5.pdf#page=10"}


if __name__ == "__main__":
    ap = ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    data = (json.dumps(compute(), sort_keys=True, indent=2)+"\n").encode()
    if args.check:
        require(OUT.read_bytes() == data, "canonical certificate differs")
    else:
        OUT.write_bytes(data)
    print("PASS actual dual jets at mod5 and mod25; two simple mod5 roots; SHA256",
          sha256(data).hexdigest())
