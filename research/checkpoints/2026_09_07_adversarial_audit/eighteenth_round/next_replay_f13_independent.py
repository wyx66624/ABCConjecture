"""Independent exhaustive F13 input for the five-primary rational-point sieve.

No parent probe or group-law routine is imported. Enumeration uses every
(x,y) pair; tripling uses normalized division polynomials, rather than the
probe's successive affine additions. The index/log bridge is ordinary.
"""
from argparse import ArgumentParser
from hashlib import sha256
import json
from pathlib import Path

P = 13
HERE = Path(__file__).resolve().parent
OUT = HERE / 'next_verification/f13_independent.json'


def require(value, message):
    if not value:
        raise AssertionError(message)


def residue_div(a, b):
    return a * pow(b % P, -1, P) % P


def trim(f):
    f = [c % P for c in f]
    while f and f[-1] == 0:
        f.pop()
    return f


def remainder(f, g):
    f, g = trim(f), trim(g)
    require(g, 'zero polynomial divisor')
    while len(f) >= len(g):
        d = len(f) - len(g)
        c = residue_div(f[-1], g[-1])
        for j, v in enumerate(g):
            f[d+j] = (f[d+j] - c*v) % P
        f = trim(f)
    return f


def gcd_trace(f, g):
    f, g = trim(f), trim(g)
    trace = [f, g]
    while g:
        f, g = g, remainder(f, g)
        trace.append(g)
    monic = [residue_div(c, f[-1]) for c in f]
    return trace, monic


def on_curve(Q, a, b):
    return Q is None or (Q[1]**2-Q[0]**3-a*Q[0]-b) % P == 0


def triple(Q, a, b):
    if Q is None:
        return None
    x, y = Q
    require(on_curve(Q, a, b), 'tripling an off-curve point')
    if y == 0:
        # A finite y=0 point has order two, so 3Q=Q.
        return [x, y]
    ps2 = 2*y % P
    ps3 = (3*x**4+6*a*x*x+12*b*x-a*a) % P
    ps4 = 4*y*(x**6+5*a*x**4+20*b*x**3-5*a*a*x*x-4*a*b*x-a**3-8*b*b) % P
    if ps3 == 0:
        return None
    ps5 = (ps4*ps2**3-ps3**3) % P
    phi3 = (x*ps3**2-ps4*ps2) % P
    omega3 = residue_div(ps5*ps2**2-ps4**2, 4*y)
    R = [residue_div(phi3, ps3**2), residue_div(omega3, ps3**3)]
    require(on_curve(R, a, b), 'division-polynomial result off curve')
    return R


def elliptic_rows(a, b):
    points = [None] + [[x, y] for x in range(P) for y in range(P)
                       if (y*y-x**3-a*x-b) % P == 0]
    require((-16*(4*a**3+27*b*b)) % P != 0, 'elliptic bad reduction')
    return [{'point': Q, 'triple': triple(Q, a, b)} for Q in points]


def compute():
    coeff = [-9, 0, 99, 0, -27, 0, 1]
    deriv = [j*coeff[j] for j in range(1, len(coeff))]
    euclid, squarefree_gcd = gcd_trace(coeff, deriv)
    require(squarefree_gcd == [1], 'sextic has bad reduction')
    E1, E2 = elliptic_rows(-9, -9), elliptic_rows(-189, 999)
    require(len(E1) == len(E2) == 15, 'elliptic group cardinality differs')
    target1 = triple([11, 1], -9, -9)
    target2 = triple([6, 9], -189, 999)
    require(target2 == [11, 2], 'positive five-primary target differs')
    negative2 = [target2[0], -target2[1] % P]
    require(target1 is not None and target2 is not None, 'trivial five-primary generator')
    rows = []
    for z in range(P):
        for W in range(P):
            if (W*W-z**6+27*z**4-99*z*z+9) % P:
                continue
            R1 = [residue_div(z*z-9, 4), residue_div(W, 8)]
            R2 = None if z == 0 else [residue_div(33*z*z-9, 4*z*z),
                                      residue_div(-9*W, 8*z**3)]
            require(on_curve(R1, -9, -9) and on_curve(R2, -189, 999), 'quotient off curve')
            rows.append({'point': [z, W], 'R1': R1, 'R2': R2,
                         'triple_R1': triple(R1, -9, -9),
                         'triple_R2': triple(R2, -189, 999)})
    for sign in [1, -1]:
        R2 = [residue_div(33, 4), residue_div(-9*sign, 8)]
        require(on_curve(R2, -189, 999), 'infinity quotient off curve')
        rows.append({'point': ['infinity', sign], 'R1': None, 'R2': R2,
                     'triple_R1': None, 'triple_R2': triple(R2, -189, 999)})
    require(len(rows) == 16, 'full smooth projective curve point count differs')
    survivors = [row for row in rows if row['triple_R1'] is None and
                 row['triple_R2'] in [target2, negative2]]
    require(not survivors, 'a plus or minus five-primary survivor exists')
    return {
        'status': 'PASS', 'prime': P,
        'method': 'all residue pairs, polynomial Euclidean gcd, division-polynomial tripling; no parent probe imports',
        'scope': 'finite good-reduction and full F13 projection obstruction only; global index, logarithm and complete Q5 zero proofs are ordinary inputs',
        'sextic_euclidean_trace': euclid, 'sextic_gcd': squarefree_gcd,
        'elliptic_orders': [len(E1), len(E2)],
        'elliptic_1_complete_table': E1, 'elliptic_2_complete_table': E2,
        'triple_P': target1, 'triple_Pprime': target2,
        'negative_triple_Pprime': negative2,
        'curve_complete_table': rows, 'curve_order': len(rows),
        'survivors_for_either_sign': survivors,
    }


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    data = (json.dumps(compute(), indent=2, sort_keys=True)+'\n').encode()
    if args.check:
        require(OUT.read_bytes() == data, 'canonical byte mismatch')
    else:
        OUT.parent.mkdir(parents=True, exist_ok=True)
        OUT.write_bytes(data)
    print('PASS independent F13: 15+15 elliptic points, 16 curve points, no +/- survivor;',
          'SHA256', sha256(data).hexdigest())
