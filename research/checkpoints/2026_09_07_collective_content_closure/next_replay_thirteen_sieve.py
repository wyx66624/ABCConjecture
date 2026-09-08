"""Complete exact F13 input to the separate rational-point sieve proof."""

from argparse import ArgumentParser
from hashlib import sha256
import json
from pathlib import Path

P = 13
HERE = Path(__file__).resolve().parent
OUT = HERE / "next_verification" / "thirteen_sieve.json"


def require(condition, message):
    if not condition:
        raise ValueError(message)


def trim(f):
    f = [x % P for x in f]
    while f and not f[-1]:
        f.pop()
    return f


def plus(f, g):
    return trim([(f[i] if i < len(f) else 0)+(g[i] if i < len(g) else 0)
                 for i in range(max(len(f), len(g)))])


def times(f, g):
    if not f or not g:
        return []
    out = [0]*(len(f)+len(g)-1)
    for i, a in enumerate(f):
        for j, b in enumerate(g):
            out[i+j] += a*b
    return trim(out)


def minus(f, g):
    return plus(f, [-x for x in g])


def divrem(f, g):
    require(bool(g), "zero polynomial divisor")
    r, q = trim(f), [0]*max(0, len(f)-len(g)+1)
    while r and len(r) >= len(g):
        k = len(r)-len(g)
        c = r[-1]*pow(g[-1], -1, P) % P
        q[k] = c
        r = minus(r, [0]*k+[c*x for x in g])
    return trim(q), r


def bezout(f, g):
    r0, r1, u0, u1, v0, v1 = f, g, [1], [], [], [1]
    while r1:
        q, r2 = divrem(r0, r1)
        r0, r1 = r1, r2
        u0, u1 = u1, minus(u0, times(q, u1))
        v0, v1 = v1, minus(v0, times(q, v1))
    require(len(r0) == 1, "curve polynomial is not squarefree")
    c = pow(r0[0], -1, P)
    u, v = trim([c*x for x in u0]), trim([c*x for x in v0])
    require(plus(times(u, f), times(v, g)) == [1], "Bezout identity failed")
    return u, v


def on_curve(Q, a, b):
    return Q is None or (Q[1]**2-Q[0]**3-a*Q[0]-b) % P == 0


def add(Q, R, a):
    if Q is None:
        return R
    if R is None:
        return Q
    x, y = Q
    X, Y = R
    if x == X and (y+Y) % P == 0:
        return None
    m = ((3*x*x+a)*pow(2*y, -1, P) if Q == R else
         (Y-y)*pow(X-x, -1, P)) % P
    u = (m*m-x-X) % P
    return (u, (m*(x-u)-y) % P)


def mul(n, Q, a):
    R = None
    while n:
        if n & 1:
            R = add(R, Q, a)
        Q, n = add(Q, Q, a), n//2
    return R


def elliptic(a, b):
    disc = (-16*(4*a**3+27*b*b)) % P
    require(disc != 0, "bad elliptic reduction")
    points = [None]+[(x, y) for x in range(P) for y in range(P)
                    if on_curve((x, y), a, b)]
    require(len(points) == 15, "elliptic group order differs")
    require(all(mul(15, Q, a) is None for Q in points), "group exponent check failed")
    return {"a": a, "b": b, "discriminant_mod13": disc,
            "points": points, "cardinality": len(points)}


def compute():
    # Exact trial division proves that 13 is prime.
    require(all(P % d for d in [2, 3]), "modulus not proved prime")
    f = trim([-9, 0, 99, 0, -27, 0, 1])
    derivative = trim([i*f[i] for i in range(1, len(f))])
    u, v = bezout(f, derivative)
    curves = [elliptic(-9, -9), elliptic(-189, 999)]
    target = mul(3, (6, 9), -189)
    require(target == (11, 2), "target tripling differs")
    negative_target = (target[0], -target[1] % P)
    iv4, iv8 = pow(4, -1, P), pow(8, -1, P)
    rows = []

    def record(label, Q1, Q2):
        require(on_curve(Q1, -9, -9) and on_curve(Q2, -189, 999),
                "a quotient image is off its actual elliptic curve")
        pr1, pr2 = mul(3, Q1, -9), mul(3, Q2, -189)
        require(mul(5, pr1, -9) is None and mul(5, pr2, -189) is None,
                "projection is not killed by five")
        require(not (pr1 is None and pr2 in [target, negative_target]),
                "a forbidden projected pair actually occurs")
        rows.append({"curve_point": label, "R1": Q1, "R2": Q2,
                     "three_R1": pr1, "three_R2": pr2})

    for z in range(P):
        for W in range(P):
            if (W*W-z**6+27*z**4-99*z*z+9) % P:
                continue
            Q1 = ((z*z-9)*iv4 % P, W*iv8 % P)
            Q2 = None if z == 0 else (
                (33-9*pow(z*z, -1, P))*iv4 % P,
                -9*W*iv8*pow(z**3, -1, P) % P)
            record([z, W], Q1, Q2)
    for sign in [1, -1]:
        record(["infinity", sign], None, (33*iv4 % P, -9*sign*iv8 % P))
    require(len(rows) == 16, "complete genus-two point count differs")
    return {
        "status": "PASS",
        "scope": "all 16 projective F13 curve points and both forbidden five-primary projections; the rational saturation bridge and complete Q5 container are ordinary inputs",
        "prime": P, "curve_polynomial_mod13": f,
        "derivative_mod13": derivative,
        "smoothness_bezout_U": u, "smoothness_bezout_V": v,
        "elliptic_curves": curves, "three_Pprime": target,
        "negative_three_Pprime": negative_target, "curve_point_count": len(rows),
        "all_projective_quotient_rows": rows,
    }


if __name__ == "__main__":
    parser = ArgumentParser()
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    raw = (json.dumps(compute(), sort_keys=True, indent=2)+"\n").encode()
    if args.check:
        require(OUT.read_bytes() == raw, "canonical thirteen-sieve certificate changed")
    else:
        OUT.parent.mkdir(parents=True, exist_ok=True)
        OUT.write_bytes(raw)
    print("PASS all 16 projective F13 points, smoothness, orders and both signs; SHA256",
          sha256(raw).hexdigest())
