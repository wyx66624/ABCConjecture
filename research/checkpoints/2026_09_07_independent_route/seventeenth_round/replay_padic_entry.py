"""Exact finite certificate for QL; no numerical rank or point completeness claim."""
from __future__ import annotations
import argparse
import hashlib
import json
from fractions import Fraction as F
from pathlib import Path

HERE = Path(__file__).resolve().parent
DEST = HERE / "verification" / "padic_entry_exact.json"


def add(P, Q, a, b, modulus=None):
    if P is None:
        return Q
    if Q is None:
        return P
    x, y = P
    u, v = Q
    red = (lambda z: z % modulus) if modulus else (lambda z: z)
    if x == u and red(y + v) == 0:
        return None
    num, den = (3*x*x+a, 2*y) if P == Q else (v-y, u-x)
    slope = red(num * pow(int(den), -1, modulus)) if modulus else F(num, den)
    xx = red(slope*slope-x-u)
    return xx, red(slope*(x-xx)-y)


def mul(P, n, a, b, modulus=None):
    R = None
    for _ in range(n):
        R = add(R, P, a, b, modulus)
    return R


def val(q, p):
    q = F(q)
    assert q
    r = 0
    n, d = abs(q.numerator), q.denominator
    while n % p == 0:
        n //= p
        r += 1
    while d % p == 0:
        d //= p
        r -= 1
    return r


def ratio(q):
    q = F(q)
    return [q.numerator, q.denominator]


def run():
    rows = []
    for a, b, P, expected in [(-9, -9, (-2, 1), 1), (-189, 999, (6, 9), 3)]:
        delta = -16*(4*a**3+27*b*b)
        assert delta % 5
        points = [(x, y) for x in range(5) for y in range(5)
                  if (y*y-x**3-a*x-b) % 5 == 0]
        modP = tuple(v % 5 for v in P)
        multiples = [mul(modP, n, a, b, 5) for n in range(9)]
        assert len(points) == 8 and len(set(multiples)) == 9
        assert mul(modP, 9, a, b, 5) is None
        R = mul(tuple(map(F, P)), 9, a, b)
        assert R is not None
        x, y = R
        assert y*y == x**3+a*x+b
        t = -x/y
        assert [val(x, 5), val(y, 5), val(t, 5)] == [-2, -3, 1]
        unit = t/5
        residue = unit.numerator * pow(unit.denominator, -1, 5) % 5
        assert residue == expected
        rows.append(dict(a=a, b=b, point=P, discriminant=delta,
                         affine_points_mod5=points, multiples_mod5=multiples,
                         nine_point=list(map(ratio, R)), parameter=ratio(t),
                         valuations=[-2, -3, 1], parameter_div5_mod5=residue))

    # Independent full field enumeration: F25=F5[w], w^2=2.
    ff = [(a, b) for a in range(5) for b in range(5)]
    def fadd(x, y):
        return ((x[0]+y[0]) % 5, (x[1]+y[1]) % 5)
    def fmul(x, y):
        return ((x[0]*y[0]+2*x[1]*y[1]) % 5,
                (x[0]*y[1]+x[1]*y[0]) % 5)
    def poly(x):
        r = (0, 0)
        for c in [1, 3, -3, -11, -3, 3, 1]:
            r = fadd(fmul(r, x), (c % 5, 0))
        return r
    square_fibres = {x: sum(fmul(y, y) == x for y in ff) for x in ff}
    n25 = 2 + sum(square_fibres[poly(x)] for x in ff)
    n5 = 2 + sum((y*y - poly((x, 0))[0]) % 5 == 0
                for x in range(5) for y in range(5))
    assert (n5, n25) == (12, 28)
    trace = 6-n5
    middle = (trace*trace-(26-n25))//2
    jac_order = 1-trace+middle-5*trace+25
    assert jac_order == 81
    # Phi([A-infinity+]), Phi([infinity--infinity+]) columns.
    image_matrix = [[0, -2], [2, 2]]
    log_matrix_div5_mod5 = [[0, 2], [4, 4]]
    det_mod5 = (-2*4) % 5
    assert det_mod5 == 2
    return dict(schema=1, scope="finite exact arithmetic only; not formal groups or QC roots",
                curves=rows, H1_counts={"F5": n5, "F25": n25, "J_F5": jac_order},
                divisor_image_matrix=image_matrix,
                log_matrix_div5_mod5=log_matrix_div5_mod5,
                divided_log_determinant_mod5=det_mod5)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    raw = (json.dumps(run(), sort_keys=True, indent=2) + "\n").encode()
    if args.check:
        assert DEST.read_bytes() == raw, "canonical certificate mismatch"
    else:
        DEST.parent.mkdir(parents=True, exist_ok=True)
        DEST.write_bytes(raw)
    print("PASS", hashlib.sha256(raw).hexdigest())


if __name__ == "__main__":
    main()
