"""Exact polynomial and bounded-point replay for SS; no point completeness."""
import argparse
from fractions import Fraction as F
import hashlib
import json
from math import isqrt
from pathlib import Path


def trim(p):
    p = list(p)
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return tuple(p)


def add(p, q):
    out = [0] * max(len(p), len(q))
    for i, x in enumerate(p):
        out[i] += x
    for i, x in enumerate(q):
        out[i] += x
    return trim(out)


def mul(p, q):
    out = [0] * (len(p) + len(q) - 1)
    for i, x in enumerate(p):
        for j, y in enumerate(q):
            out[i+j] += x*y
    return trim(out)


class Rat:
    def __init__(self, num, den=(1,)):
        self.num = (num,) if isinstance(num, int) else trim(num)
        self.den = trim(den)
        assert self.den != (0,)

    @staticmethod
    def cast(x):
        return x if isinstance(x, Rat) else Rat(x)

    def __add__(self, other):
        other = self.cast(other)
        return Rat(add(mul(self.num, other.den), mul(other.num, self.den)),
                   mul(self.den, other.den))

    __radd__ = __add__

    def __neg__(self):
        return Rat(tuple(-x for x in self.num), self.den)

    def __sub__(self, other):
        return self + -self.cast(other)

    def __rsub__(self, other):
        return self.cast(other) + -self

    def __mul__(self, other):
        other = self.cast(other)
        return Rat(mul(self.num, other.num), mul(self.den, other.den))

    __rmul__ = __mul__

    def __truediv__(self, other):
        other = self.cast(other)
        return Rat(mul(self.num, other.den), mul(self.den, other.num))

    def __rtruediv__(self, other):
        return self.cast(other) / self

    def __pow__(self, n):
        assert isinstance(n, int) and n >= 0
        out = Rat(1)
        for _ in range(n):
            out = out*self
        return out

    def __eq__(self, other):
        other = self.cast(other)
        return mul(self.num, other.den) == mul(other.num, self.den)


def eadd(P, Q, a):
    if P is None:
        return Q
    if Q is None:
        return P
    x, y = P
    u, v = Q
    if x == u and y == -v:
        return None
    slope = (3*x*x+a)/(2*y) if P == Q else (v-y)/(u-x)
    xx = slope*slope-x-u
    return xx, slope*(x-xx)-y


def square_root(x):
    if x < 0:
        return None
    n, d = isqrt(x.numerator), isqrt(x.denominator)
    return F(n, d) if n*n == x.numerator and d*d == x.denominator else None


def phi(P):
    if P is None:
        return None
    x, y = P
    den = x+3
    assert den != 0
    return x+36/den-36/den**2, y*(1-36/den**2+72/den**3)


def canonical(data):
    return (json.dumps(data, sort_keys=True, indent=2)+'\n').encode()


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--check', action='store_true')
    args = parser.parse_args()
    identities = []

    def verify(name, lhs, rhs):
        assert lhs == rhs, name
        identities.append(name)

    x = Rat((0, 1))
    f, h = x**3-9*x-9, x+2
    H, R, J, d = f+18*h**2, f-108*h**2, 6*x*h, 4*x+9
    verify('quartic_discriminant_factor', H**2-f*R, J**2*d)
    fp = x+36/(x+3)-36/(x+3)**2
    derivative = 1-36/(x+3)**2+72/(x+3)**3
    verify('degree_three_isogeny', f*derivative**2, fp**3-189*fp+999)

    s = x
    a0, b0 = s**3-3*s-1, 3*s*(s+1)
    xx = -(2*s**2+5*s+2)/(s+1)**2
    hh = xx+2
    kappa, gamma = (s-1)/(s+1), (a0+b0)/(s+1)**3
    f_s = xx**3-9*xx-9
    y_square = a0*(a0+b0)/(s+1)**6
    z_square = (a0+b0)*(a0+4*b0)/(s+1)**6
    verify('kappa_square', kappa**2, 4*xx+9)
    verify('normalized_b0', b0/(s+1)**3, -3*hh)
    verify('gamma_formula', gamma, (-xx*kappa-3*hh)/2)
    verify('first_quotient', y_square, f_s)
    verify('first_gamma_square', y_square, gamma**2+3*hh*gamma)
    verify('second_gamma_square', z_square, gamma**2-9*hh*gamma)
    verify('second_square_branch', z_square, f_s+18*hh**2+6*xx*hh*kappa)
    verify('common_source_quartic',
           z_square**2-2*(f_s+18*hh**2)*z_square+f_s*(f_s-108*hh**2), 0)
    verify('difference_gamma', y_square-z_square, 12*hh*gamma)
    verify('weighted_conic', (y_square-z_square)**2,
           36*hh**2*(3*y_square+z_square))
    verify('inverse_kappa', (z_square-f_s-18*hh**2)/(6*xx*hh), kappa)
    verify('inverse_source', (1+kappa)/(1-kappa), s)
    verify('positive_ratio_expression', -b0/(a0+b0),
           36*hh**2/(y_square-z_square))

    P = F(-2), F(1)
    Q = F(6), F(9)
    Q2 = eadd(Q, Q, -189)
    Q3 = eadd(Q2, Q, -189)
    assert Q2 == (F(33, 4), F(9, 8))
    assert Q3 == (F(-2), F(-37))
    assert phi(P) == (Q3[0], -Q3[1])
    signed_points = []
    source_square_hits = []
    quartic_hits = []
    positive_hits = []
    current = None
    for n in range(1, 41):
        current = eadd(current, P, -9)
        assert current is not None
        for sign in (1, -1):
            xx, yy = current[0], sign*current[1]
            assert yy*yy == xx**3-9*xx-9
            image = phi((xx, yy))
            assert image[1]**2 == image[0]**3-189*image[0]+999
            signed_points.append([sign*n, str(xx), str(yy),
                                  str(image[0]), str(image[1])])
            kk = square_root(4*xx+9)
            if kk is None:
                continue
            source_square_hits.append(sign*n)
            ff, hh = yy*yy, xx+2
            HH, RR, JJ = ff+18*hh*hh, ff-108*hh*hh, 6*xx*hh
            for k in sorted({kk, -kk}):
                zz = square_root(HH+JJ*k)
                if zz is None:
                    continue
                for z in sorted({zz, -zz}):
                    assert z**4-2*HH*z*z+ff*RR == 0
                    row = [sign*n, str(k), str(z)]
                    quartic_hits.append(row)
                    if 0 < z*z < RR and yy*hh > 0:
                        positive_hits.append(row)
    result = {
        'status': 'PASS',
        'arithmetic': 'Python standard-library integer polynomials and Fraction',
        'polynomial_identity_count': len(identities),
        'polynomial_identities': identities,
        'isogeny_point_relation': {
            'P': ['-2', '1'], 'Q': ['6', '9'],
            'two_Q': ['33/4', '9/8'], 'three_Q': ['-2', '-37'],
            'phi_P': ['-2', '37']},
        'bounded_point_scope': 'Only the 80 signed multiples nP with 1<=n<=40; no basis or all-point claim.',
        'signed_multiple_count': len(signed_points),
        'signed_points_and_images_sha256': hashlib.sha256(canonical(signed_points)).hexdigest(),
        'source_square_hits': source_square_hits,
        'quartic_hits_with_kappa': quartic_hits,
        'positive_hits': positive_hits,
        'scope': 'Exact identities and a bounded check of specified rational points; not a complete rational-point computation or a Lean proof.'}
    base = Path(__file__).resolve().parent
    output = base/'verification'/'simultaneous_gate.json'
    data = canonical(result)
    if args.check:
        assert output.read_bytes() == data, 'canonical evidence differs'
    else:
        output.parent.mkdir(parents=True, exist_ok=True)
        output.write_bytes(data)
    print(json.dumps({'status': 'PASS', 'identities': len(identities),
                      'signed_points': len(signed_points),
                      'positive_hits': len(positive_hits),
                      'sha256': hashlib.sha256(data).hexdigest()}))


if __name__ == '__main__':
    main()
