"""Independent F13 sieve replay using line/cubic intersection group law.

No parent probe, elliptic helper, PARI, or Sage is imported. Point counts
enumerate every square fiber. Addition divides the intersection cubic
by the two known roots, retaining tangency multiplicities.
"""
from argparse import ArgumentParser
from hashlib import sha256
import json
from pathlib import Path

P = 13
HERE = Path(__file__).resolve().parent
OUT = HERE / "next_thirteen_sieve_peer.json"


def require(c, message):
    if not c:
        raise ValueError(message)


def inv(n):
    return pow(n % P, -1, P)


def cubic_divide(coeffs, root):
    # Descending coefficients, monic in every call here.
    quotient = [coeffs[0] % P]
    for c in coeffs[1:-1]:
        quotient.append((c+root*quotient[-1]) % P)
    require((coeffs[-1]+root*quotient[-1]) % P == 0,
            "the known intersection root does not divide")
    return quotient


def elliptic_points(a, b):
    return [None]+[(x, y) for x in range(P) for y in range(P)
                   if (y*y-x**3-a*x-b) % P == 0]


def add(Q, R, a, b):
    if Q is None:
        return R
    if R is None:
        return Q
    x, y = Q
    X, Y = R
    if x == X and (y+Y) % P == 0:
        return None
    if Q == R:
        slope = (3*x*x+a)*inv(2*y) % P
    else:
        slope = (Y-y)*inv(X-x) % P
    intercept = (y-slope*x) % P
    # Intersection: x^3+a*x+b - (slope*x+intercept)^2.
    intersection = [1, -slope*slope, a-2*slope*intercept,
                    b-intercept*intercept]
    quotient = cubic_divide(cubic_divide(intersection, x), X)
    require(quotient[0] == 1 and len(quotient) == 2,
            "intersection quotient is not a monic line")
    third_x = -quotient[1] % P
    third_y = (slope*third_x+intercept) % P
    result = (third_x, -third_y % P)
    require((result[1]**2-result[0]**3-a*result[0]-b) % P == 0,
            "sum is not on the elliptic curve")
    return result


def triple(Q, a, b):
    return add(add(Q, Q, a, b), Q, a, b)


def f(z):
    return z**6-27*z**4+99*z*z-9


def trim(poly):
    poly = [c % P for c in poly]
    while poly and poly[0] == 0:
        poly.pop(0)
    return poly


def poly_remainder(a, b):
    a, b = trim(a), trim(b)
    require(bool(b), "polynomial divisor is zero")
    while a and len(a) >= len(b):
        factor = a[0]*inv(b[0]) % P
        for j, coefficient in enumerate(b):
            a[j] = (a[j]-factor*coefficient) % P
        a = trim(a)
    return a


def sextic_gcd_certificate():
    a, b = trim([1, 0, -27, 0, 99, 0, -9]), trim([6, 0, -108, 0, 198, 0])
    sequence = [a, b]
    while b:
        a, b = b, poly_remainder(a, b)
        sequence.append(b)
    gcd = [c*inv(a[0]) % P for c in a]
    require(gcd == [1], "the sextic is not geometrically square-free")
    return sequence


def map_point(point):
    if point[0] == "infinity":
        v = point[1]
        return None, (33*inv(4) % P, -9*v*inv(8) % P)
    z, W = point[1], point[2]
    R1 = ((z*z-9)*inv(4) % P, W*inv(8) % P)
    R2 = None if z == 0 else ((33-9*inv(z*z))*inv(4) % P,
                              -9*W*inv(8*z**3) % P)
    return R1, R2


def compute():
    E1, E2 = elliptic_points(-9, -9), elliptic_points(-189, 999)
    require(len(E1) == len(E2) == 15, "elliptic point count differs")
    # Good reduction of both displayed models and the full sextic.
    require((-16*(4*(-9)**3+27*(-9)**2)) % P != 0
            and (-16*(4*(-189)**3+27*999**2)) % P != 0,
            "bad elliptic reduction at thirteen")
    euclidean_sequence = sextic_gcd_certificate()
    finite = [("finite", z, W) for z in range(P) for W in range(P)
              if (W*W-f(z)) % P == 0]
    curve = finite+[("infinity", 1), ("infinity", -1)]
    require(len(curve) == 16, "full projective count differs")
    target1 = triple((-2 % P, 1), -9, -9)
    target2 = triple((6, 9), -189, 999)
    require(target2 == (11, 2), "target prime-order point differs")
    negtarget2 = (target2[0], -target2[1] % P)
    rows = []
    for point in curve:
        R1, R2 = map_point(point)
        require(R1 in E1 and R2 in E2, "projective quotient image is off curve")
        projected = (triple(R1, -9, -9), triple(R2, -189, 999))
        require(projected != (None, target2)
                and projected != (None, negtarget2),
                "a forbidden pair occurs on the actual source curve")
        rows.append({"source": point, "R1": R1, "R2": R2,
                     "three_R1": projected[0], "three_R2": projected[1]})
    # The target order is checked directly by repeated line intersection.
    orders = []
    for T, a, b in [(target1, -9, -9), (target2, -189, 999)]:
        Q = None
        multiples = []
        for _ in range(5):
            multiples.append(Q)
            Q = add(Q, T, a, b)
        require(Q is None and len(set(multiples)) == 5,
                "the projected target does not have order five")
        orders.append(multiples)
    return {"status": "PASS",
            "method": "complete square-fiber enumeration; chord/tangent intersection cubic divided by both known roots",
            "scope": "independent finite F13 table; the ordinary QL prime-to-five index and logarithm bridge are separate inputs",
            "modulus": P, "E1_points": E1, "E2_points": E2,
            "sextic_derivative_euclidean_sequence_mod13": euclidean_sequence,
            "projective_curve_count": len(curve),
            "three_P1": target1, "three_P2": target2,
            "order_five_multiples": orders,
            "rows": rows, "forbidden_pairs": [[None, target2], [None, negtarget2]],
            "forbidden_pair_hits": 0}


if __name__ == "__main__":
    ap = ArgumentParser()
    ap.add_argument("--check", action="store_true")
    args = ap.parse_args()
    raw = (json.dumps(compute(), indent=2, sort_keys=True)+"\n").encode()
    if args.check:
        require(OUT.read_bytes() == raw, "canonical table differs")
    else:
        OUT.write_bytes(raw)
    print("PASS independent full F13 table, no forbidden pair; SHA256",
          sha256(raw).hexdigest())
