"""Independent F13 table for the proposed 5-adic-log / reduction sieve.

No rational generator claim: the ordinary bridge uses the proven prime-to-5
index of the displayed rank-one points. This script supplies finite data.
"""
from argparse import ArgumentParser
from hashlib import sha256
import json
from pathlib import Path


Q = 13
HERE = Path(__file__).resolve().parent
OUT = HERE / "next_log_reduction_sieve_exact.json"


def require(c, why):
    if not c:
        raise ValueError(why)


def add(P, R, a):
    if P is None:
        return R
    if R is None:
        return P
    x, y = P
    u, v = R
    if x == u and (y+v) % Q == 0:
        return None
    if P == R:
        slope = (3*x*x+a)*pow(2*y, -1, Q) % Q
    else:
        slope = (v-y)*pow(u-x, -1, Q) % Q
    X = (slope*slope-x-u) % Q
    return X, (slope*(x-X)-y) % Q


def triple(P, a):
    return add(add(P, P, a), P, a)


def points(a, b):
    return [None]+[(x, y) for x in range(Q) for y in range(Q)
                   if (y*y-x**3-a*x-b) % Q == 0]


def gcd_poly(f, g):
    def trim(p):
        while p and p[-1] % Q == 0:
            p.pop()
        return p
    f, g = trim(f[:]), trim(g[:])
    while g:
        r = f[:]
        while len(r) >= len(g):
            c = r[-1]*pow(g[-1], -1, Q) % Q
            shift = len(r)-len(g)
            for j, v in enumerate(g):
                r[shift+j] = (r[shift+j]-c*v) % Q
            trim(r)
        f, g = g, r
    return [v*pow(f[-1], -1, Q) % Q for v in f]


def compute():
    a1, b1, a2, b2 = -9, -9, -189, 999
    E1, E2 = points(a1, b1), points(a2, b2)
    require(len(E1) == len(E2) == 15, "elliptic group sizes differ")
    require(all((4*a**3+27*b*b) % Q for a, b in [(a1,b1),(a2,b2)]),
            "bad elliptic reduction")
    f = [-9, 0, 99, 0, -27, 0, 1]
    df = [(j+1)*f[j+1] for j in range(len(f)-1)]
    require(gcd_poly(f, df) == [1], "sextic has repeated roots over algebraic closure")
    finite = [(z, w) for z in range(Q) for w in range(Q)
              if (w*w-z**6+27*z**4-99*z*z+9) % Q == 0]
    source = [("finite", z, w) for z, w in finite]+[("infinity", 0, eps) for eps in [1,-1]]
    target = triple((6,9), a2)
    require(target == (11,2), "target differs")
    rows = []
    for kind, z, w in source:
        if kind == "infinity":
            r1 = None
            r2 = (33*pow(4,-1,Q) % Q, -9*w*pow(8,-1,Q) % Q)
        else:
            r1 = ((z*z-9)*pow(4,-1,Q) % Q, w*pow(8,-1,Q) % Q)
            r2 = None if z == 0 else (
                (33-9*pow(z*z,-1,Q))*pow(4,-1,Q) % Q,
                -9*w*pow(8*z**3,-1,Q) % Q)
        require(r1 in E1 and r2 in E2, "projective quotient image off elliptic curve")
        t1, t2 = triple(r1,a1), triple(r2,a2)
        require(not (t1 is None and t2 in [target,(target[0],-target[1] % Q)]),
                "the proposed obstruction has an actual finite point")
        rows.append({"kind":kind,"z":z if kind=="finite" else None,"W_or_infinity_sign":w,
                     "R1":r1,"R2":r2,"three_R1":t1,"three_R2":t2})
    require(len(rows) == 16, "incomplete projective curve count")
    return {"status":"PASS","prime":Q,"E1_points":E1,"E2_points":E2,
            "sextic_gcd_with_derivative":[1],"C_projective_rows":rows,
            "three_P_prime":target,"excluded_pairs":[[None,target],[None,(target[0],-target[1] % Q)]],
            "scope":"complete F13 projective table and elementary group operations; ordinary prime-to-5-index/logarithm bridge remains separate; no global generator or rational-point theorem supplied by finite data alone"}


if __name__ == "__main__":
    ap = ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    data=(json.dumps(compute(),sort_keys=True,indent=2)+"\n").encode()
    if args.check:
        require(OUT.read_bytes()==data,"canonical finite table differs")
    else:
        OUT.write_bytes(data)
    print("PASS independent F13 complete projective sieve table; SHA256",sha256(data).hexdigest())
