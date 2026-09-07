"""Exact arithmetic replay for next-only GD; no rank or point completeness."""
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



def cast_substitute(a, x):
    def polyval(coeffs):
        out=Rat(0)
        for c in reversed(coeffs):out=out*x+c
        return out
    return polyval(a.num)/polyval(a.den)


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--check',action='store_true')
    args=parser.parse_args()
    checks=[]
    def test(name,a,b):
        assert a==b,name
        checks.append(name)
    x=Rat((0,1)); f=x**3-9*x-9; fp=x**3-189*x+999
    ph=x+36/(x+3)-36/(x+3)**2
    dph=1-36/(x+3)**2+72/(x+3)**3
    ps=(x+108/(x-9)+108/(x-9)**2)/9
    cps=(1-108/(x-9)**2-216/(x-9)**3)/27
    test('opposite_isogeny_curve',fp*cps**2,ps**3-9*ps-9)
    x2=(3*x*x-9)**2/(4*f)-2*x
    b2=(3*x*x-9)*(x-x2)/(2*f)-1
    slope=(b2-1)/(x2-x)
    x3=f*slope**2-x-x2
    b3=slope*(x-x3)-1
    test('psi_phi_tripling_x',cast_substitute(ps,ph),x3)
    test('psi_phi_tripling_y_factor',dph*cast_substitute(cps,ph),b3)
    beta=1+3/(x-9); alpha2=fp/(9*(x-9)**2)
    test('gaussian_norm_inverse',alpha2+beta**2,ps+3)
    test('gaussian_imaginary_inverse',beta*(3*alpha2-beta**2),3*(ps+2))
    test('gaussian_real_inverse',(alpha2-3*beta**2)/(3*(x-9)),cps)
    v=1-3/(x+3);u2=f/(x+3)**2
    test('real_quadratic_norm_inverse',u2-3*v*v,ph-9)
    test('real_quadratic_imaginary_inverse',v*(u2+v*v),ph-8)
    test('real_quadratic_real_inverse',(u2+9*v*v)/(x+3),dph)
    test('gaussian_affine_norm',f+9*(x+2)**2,(x+3)**3)
    test('real_quadratic_affine_norm',fp-27*(x-8)**2,(x-9)**3)
    # Exact arithmetic in Q(sqrt(3)) for the nontrivial class witness.
    def qmul(z,w):return(z[0]*w[0]+3*z[1]*w[1],z[0]*w[1]+z[1]*w[0])
    eps=(2,1);z=(3,-2)
    witness=qmul(qmul(eps,eps),qmul(qmul(z,z),z))
    assert witness==(9,-6)
    # Complete mod-27 table for the primitive model, no curve point search.
    residue_count=0
    for A in range(27):
      for d in range(27):
        if A%3==0 and d%3==0:continue
        for B in range(27):
          if (B*B-A**3+9*A*d**4+9*d**6)%27==0:
            residue_count+=1
            assert B%3!=0,(A,B,d)
    result={'status':'PASS','method':'Python standard-library exact integer polynomial cross-products; no floating point or rank API','rational_function_identities':checks,'rational_function_identity_count':len(checks),'unit_class_witness':[list(eps),list(z),list(witness)],'mod27_primitive_curve_residue_hits':residue_count,'mod27_primitive_curve_hits_with_3_dividing_B':0,'scope':'Exact identities and complete specified modular table only. Not a proof of UFD, the Mordell-Weil theorem, rank or all rational points.'}
    encoded=(json.dumps(result,sort_keys=True,indent=2)+'\n').encode()
    dst=Path(__file__).with_name('verification')/'gaussian_descent.json'
    if args.check:
       assert dst.read_bytes()==encoded,'canonical result mismatch'
    else:dst.write_bytes(encoded)
    print('PASS',len(checks),'identities;',residue_count,'primitive mod27 hits;',hashlib.sha256(encoded).hexdigest())

if __name__=='__main__':main()
