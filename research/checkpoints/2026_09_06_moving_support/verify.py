#!/usr/bin/env python3
"""Deterministic finite checks; neither an analytic theorem nor an ABC proof."""
from __future__ import annotations
import hashlib
import itertools
import json
import math
import random
from pathlib import Path


def mul(z: tuple[int, int], w: tuple[int, int]) -> tuple[int, int]:
    x,y=z; u,v=w
    return x*u-y*v, x*v+y*u+y*v


def norm(z: tuple[int, int]) -> int:
    x,y=z
    return x*x+x*y+y*y


def boundary(z: tuple[int, int]) -> int:
    x,y=z
    return x*y*(x+y)


def height(z: tuple[int, int]) -> int:
    return max(abs(z[0]), abs(z[1]), abs(sum(z)))


def power(z: tuple[int, int], n: int, m: int | None=None) -> tuple[int, int]:
    out=(1,0)
    while n:
        if n&1:
            out=mul(out,z)
            if m: out=tuple(v%m for v in out)
        z=mul(z,z)
        if m: z=tuple(v%m for v in z)
        n//=2
    return out


def spf_table(n: int) -> list[int]:
    s=list(range(n+1))
    for p in range(2, math.isqrt(n)+1):
        if s[p]==p:
            for j in range(p*p,n+1,p):
                if s[j]==j: s[j]=p
    return s


def factors(n: int, s: list[int]) -> dict[int,int]:
    f={}
    while n>1:
        p=s[n]; f[p]=f.get(p,0)+1; n//=p
    return f


def check() -> dict:
    rng=random.Random(20260906)
    digest=hashlib.sha256()
    counts={"signed_primitive_pairs":0,"positive_abc_triples":0,
            "mixed_factorizations":0,"list_truncation_identities":0,
            "boundary_gcd_pairs":0,"modular_certificates":0}
    def record(*row):
        digest.update((json.dumps(row,separators=(',',':'))+'\n').encode())
    for x in range(-80,81):
        for y in range(-80,81):
            if math.gcd(x,y)!=1: continue
            z=x,y; m=norm(z); t=abs(boundary(z)); h=height(z)
            assert math.gcd(m,t)==1
            assert 3*h*h<=4*m<=4*h*h
            assert 4*t<=h**3
            u=mul(mul(z,z),z); zb=(x+y,-y); v=mul(mul(zb,zb),zb)
            assert (u[0]-v[0],u[1]-v[1])==(-3*boundary(z),6*boundary(z))
            counts["signed_primitive_pairs"]+=1
            record(x,y,m,t)
    s=spf_table(600*600)
    for c in range(2,601):
        for a in range(1,c//2+1):
            b=c-a
            if math.gcd(a,b)!=1: continue
            f={}
            for v in (a,b,c):
                for p,e in factors(v,s).items():
                    assert p not in f
                    f[p]=e
            R=math.prod(f)
            T=a*b*c
            E=math.prod(p**max(e-3,0) for p,e in f.items())
            C=math.prod(p**max(3-e,0) for p,e in f.items())
            assert T*C==R**3*E and T<=R**3*E
            nf=factors(a*a+a*b+b*b,s)
            assert nf.get(3,0)<=1
            assert all(p==3 or p%3==1 for p in nf)
            counts["positive_abc_triples"]+=1
            record(a,b,c,R,E,C)
    gens=[(2,1),(3,1),(3,2),(5,1),(4,3)]
    qs=[7,13,19,31,37]
    for e0 in range(2):
        for es in itertools.product(range(4),repeat=5):
            z=power((1,1),e0)
            for g,e in zip(gens,es): z=mul(z,power(g,e))
            assert norm(z)==3**e0*math.prod(q**e for q,e in zip(qs,es))
            assert math.gcd(*z)==1 and math.gcd(norm(z),boundary(z))==1
            counts["mixed_factorizations"]+=1
            record(e0,es,z)
    for _ in range(10000):
        data=[(rng.randrange(1,40),rng.randrange(0,16),rng.randrange(0,9))
              for _ in range(rng.randrange(0,8))]
        k=rng.randrange(0,10)
        V=math.prod(p**(v+l) for p,v,l in data)
        R=math.prod(p for p,v,l in data)
        L=math.prod(p**l for p,v,l in data)
        E=math.prod(p**max(v-k,0) for p,v,l in data)
        C=math.prod(p**max(k-v,0) for p,v,l in data)
        assert V*C==R**k*L*E and V<=R**k*L*E
        counts["list_truncation_identities"]+=1
        record(data,k,V*C)
    for _ in range(10000):
        z=(rng.randrange(-500,501),rng.randrange(-500,501))
        if math.gcd(*z)!=1: continue
        w=(rng.randrange(-500,501),rng.randrange(-500,501))
        assert math.gcd(boundary(z),boundary(mul(z,w)))==math.gcd(boundary(z),boundary(w))
        counts["boundary_gcd_pairs"]+=1
        record(z,w)
    p=38629; d=12876
    assert all(p%j for j in range(2,math.isqrt(p)+1))
    expected=[(d,p,(1,0)),(d//2,p,(25926,25406)),
        (d//3,p,(38628,1)),(d//29,p,(10564,19690)),
        (d//37,p,(23253,26998)),(d,p*p,(89232991,0)),
        (d,p**3,(43039603478354,40547540844893))]
    for n,m,w in expected:
        assert power((1,18),n,m)==w
        # Independent ordinary recurrence, not repeated squaring.
        u0,u1=0,1
        for j in range(n): u0,u1=u1%m,(20*u1-343*u0)%m
        assert (18*u0)%m==w[1]
        counts["modular_certificates"]+=1
        record(n,m,w)
    return {"status":"PASS: exact finite replay, not an ABC proof",
            "counts":counts,"ordered_digest":digest.hexdigest(),
            "not_tested":"The effective logarithmic-form constant and unrestricted asymptotics are not finite-test claims."}


if __name__=='__main__':
    result=check()
    text=json.dumps(result,indent=2,sort_keys=True)+'\n'
    expected=Path(__file__).parent/'verification'/'exact_results.json'
    if expected.exists():
        if expected.read_text()!=text: raise SystemExit('FAIL: exact output differs from sealed result')
    print(text,end='')
