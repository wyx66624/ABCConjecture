#!/usr/bin/env python3
"""Exact CRT lifting and aggregate Wronskian construction; no floating point.
Author: ChatGPT. Finite replays do not prove ABC or the general theorems.
"""
from __future__ import annotations
if not __debug__:
    raise RuntimeError("Run without Python optimization: assertions are required checks")
from collections import deque
from fractions import Fraction
from functools import reduce, lru_cache
from itertools import combinations
from math import gcd, lcm, prod
from typing import Dict, List, Tuple


@lru_cache(maxsize=200000)
def _factor_tuple(n: int) -> Tuple[Tuple[int, int], ...]:
    if n < 1:
        raise ValueError('factor expects a positive integer')
    out = {}
    p = 2
    while p*p <= n:
        while n % p == 0:
            out[p] = out.get(p, 0)+1
            n //= p
        p = 3 if p == 2 else p+2
    if n > 1:
        out[n] = out.get(n, 0)+1
    return tuple(out.items())


def factor(n: int) -> Dict[int, int]:
    return dict(_factor_tuple(n))


@lru_cache(maxsize=10000)
def is_prime(n: int) -> bool:
    return n >= 2 and _factor_tuple(n) == ((n, 1),)


def egcd(a: int, b: int) -> Tuple[int, int, int]:
    r0, r1, x0, x1, y0, y1 = a, b, 1, 0, 0, 1
    while r1:
        q = r0//r1
        r0, r1 = r1, r0-q*r1
        x0, x1 = x1, x0-q*x1
        y0, y1 = y1, y0-q*y1
    return (r0, x0, y0) if r0 >= 0 else (-r0, -x0, -y0)


def bezout(values: List[int]) -> Tuple[int, List[int]]:
    g, co = 0, []
    for v in values:
        newg, x, y = egcd(g, v)
        co = [x*c for c in co]+[y]
        g = newg
    assert sum(x*y for x,y in zip(values,co)) == g
    return g, co


def nearest(x: Fraction) -> int:
    return (2*x.numerator+x.denominator)//(2*x.denominator)


def profile(n: int, fac: Dict[int, int] | None = None) -> dict:
    if not isinstance(n, int) or isinstance(n, bool) or n < 1:
        raise ValueError("profile expects a positive integer")
    fac = factor(n) if fac is None else dict(fac)
    if any(not isinstance(p, int) or not isinstance(e, int) or e < 1 or not is_prime(p)
           for p, e in fac.items()):
        raise ValueError("factorization must use prime bases and positive integer exponents")
    fac = dict(sorted(fac.items()))
    if prod(p**e for p,e in fac.items()) != n:
        raise ValueError('factorization product mismatch')
    if n == 1:
        return dict(n=1, fac={}, rad=1, D=1, G=0, k=0, rho=1, omega=0, S=0, h=0)
    k = reduce(gcd, fac.values())
    rad = prod(fac)
    rho = prod(p for p,e in fac.items() if (e//k) % p == 0)
    directG = reduce(gcd, (n//p*e for p,e in fac.items()))
    G = n//rad*k*rho
    assert G == directG
    h = G//gcd(G,n)
    assert h == k//gcd(k,rad//rho)
    assert k % h == 0
    return dict(n=n, fac=fac, rad=rad, D=n//rad, G=G, k=k,
                rho=rho, omega=sum(fac.values()), S=sum(fac.values())//k, h=h)


def local_lift(P: dict, d: int) -> Dict[int, int]:
    """Realize d in G_n Z within S_n of the optimal constant real weights."""
    n, fac, G, k = P['n'], P['fac'], P['G'], P['k']
    if n == 1:
        if d != 0:
            raise ValueError('the derivative of one must vanish')
        return {}
    if d % G:
        raise ValueError('requested value is outside the derivative image')
    q = Fraction(d, n*P['omega'])
    f = {p:e//k for p,e in fac.items()}
    regular = [p for p in fac if f[p] % p != 0]
    Rprime = prod(regular)
    u = d//G
    assert Fraction(d,n*k) == Fraction(u,Rprime)
    lam = {}
    m = {}
    for p in fac:
        if p in regular:
            residue = (u*pow(f[p]*(Rprime//p),-1,p)) % p
            lam[p] = residue+p*nearest(q-Fraction(residue,p))
            m[p] = f[p]
        else:
            lam[p] = nearest(p*q)
            m[p] = f[p]//p
        assert abs(Fraction(lam[p],p)-q) <= Fraction(1,2)
    residual = Fraction(d,n*k)-sum((Fraction(f[p]*lam[p],p) for p in fac), Fraction(0))
    assert residual.denominator == 1
    r = residual.numerator
    assert 2*abs(r) <= P['S']
    distinguished = min(m, key=lambda p:(m[p],p))
    modulus = m[distinguished]
    parents = {0:None}
    queue = deque([0])
    while queue:
        x = queue.popleft()
        for p,step in m.items():
            y = (x+step)%modulus
            if y not in parents:
                parents[y] = (x,p)
                queue.append(y)
    assert len(parents) == modulus
    z = {p:0 for p in fac}
    x = r % modulus
    while x:
        x,p = parents[x]
        z[p] += 1
    assert sum(z.values()) <= modulus-1
    r0 = sum(m[p]*z[p] for p in fac)
    assert (r-r0)%modulus == 0
    z[distinguished] += (r-r0)//modulus
    for p in fac:
        lam[p] += p*z[p] if p in regular else z[p]
    assert sum(n//p*fac[p]*lam[p] for p in fac) == d
    assert max(abs(Fraction(lam[p],p)-q) for p in fac) <= P['S']
    if len(fac) == 1:
        assert max(abs(Fraction(lam[p],p)-q) for p in fac) == 0
    return lam


def ideal_and_values(a: int, b: int, c: int, Ps: List[dict]) -> Tuple[int,List[int]]:
    Gs = [P['G'] for P in Ps]
    common = reduce(gcd, Gs)
    A = [Gs[0]//common, Gs[1]//common, -Gs[2]//common]
    B = [-b*Gs[0], a*Gs[1], 0]
    pairs = list(combinations(range(3),2))
    minors = [A[i]*B[j]-A[j]*B[i] for i,j in pairs]
    I, co = bezout(minors)
    z = [0,0,0]
    for s,(i,j) in zip(co,pairs):
        z[i] -= s*A[j]
        z[j] += s*A[i]
    ds = [G*x for G,x in zip(Gs,z)]
    assert ds[0]+ds[1] == ds[2]
    assert a*ds[1]-b*ds[0] == I
    return I, ds


def construct(a: int, b: int, supplied: List[Dict[int,int]] | None = None, level: int = 1) -> dict:
    if a < 1 or b < 1 or gcd(a,b) != 1 or (a,b) == (1,1):
        raise ValueError('a,b must be a nontrivial positive coprime pair')
    if not isinstance(level, int) or level == 0:
        raise ValueError('Wronskian level must be a nonzero integer')
    c = a+b
    ns = [a,b,c]
    Ps = [profile(n, None if supplied is None else supplied[i]) for i,n in enumerate(ns)]
    I, ds = ideal_and_values(a,b,c,Ps)
    assert I > 0
    ds = [level*d for d in ds]
    requested_W = I*level
    R = prod(P['rad'] for P in Ps)
    D = prod(P['D'] for P in Ps)
    assert I % D == 0
    J = I//D
    oms = [P['omega'] for P in Ps]
    offsets = [Fraction(0), Fraction(requested_W,a*b), Fraction(requested_W,a*c)]
    realH = max(abs(offsets[i]-offsets[j])/ (oms[i]+oms[j])
                for i,j in combinations(range(3),2))
    lo = max(-om*realH-o for om,o in zip(oms,offsets))
    hi = min(om*realH-o for om,o in zip(oms,offsets))
    assert lo <= hi
    target = (lo+hi)/2
    if a>1 and b>1:
        period = lcm(*(P['h'] for P in Ps))
        shift = nearest((target-Fraction(ds[0],a))/period)
        ds = [d+n*period*shift for d,n in zip(ds,ns)]
        gauge_error = Fraction(period,2*min(oms))
    else:
        period = 0
        gauge_error = Fraction(0)
        assert Fraction(ds[0],a) == target
    assert ds[0]+ds[1] == ds[2]
    assert a*ds[1]-b*ds[0] == requested_W
    for d,P in zip(ds,Ps):
        assert (d==0 if P['G']==0 else d%P['G']==0)
    lam = {}
    for P,d in zip(Ps,ds):
        lam.update(local_lift(P,d))
    H = max(Fraction(abs(v),p) for p,v in lam.items())
    C = max(P['S'] if len(P['fac'])>1 else 0 for P in Ps)
    error = gauge_error+C
    assert realH <= H <= realH+error
    assert H-Fraction(abs(level)*J,R)*max(Fraction(c,oms[0]+oms[1]),
               Fraction(b,oms[0]+oms[2]),Fraction(a,oms[1]+oms[2])) <= error
    L = max(oms)
    assert error <= Fraction(L*L,2)+L
    return dict(a=a,b=b,c=c,R=R,D=D,I=I,J=J,level=level,omega=oms,
                exponent_gcds=[P['k'] for P in Ps],rho=[P['rho'] for P in Ps],
                period=period, derivative_values=ds,weights=lam,
                real_min=realH,constructed_norm=H,error_bound=error)


if __name__ == '__main__':
    import json
    for a,b in [(2,3**10*109),(9,16),(1,3024),(3,125),(1,8)]:
        print(json.dumps(construct(a,b),default=str,sort_keys=True))
