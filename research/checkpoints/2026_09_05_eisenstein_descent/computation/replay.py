#!/usr/bin/env python3
"""Exact, dependency-free replay of the scoped Eisenstein checkpoint.
Author: ChatGPT. Finite checks are not a proof of ABC or of universal theorems.
"""
from __future__ import annotations
import argparse
import hashlib
import json
from functools import lru_cache
from math import gcd
from pathlib import Path
from typing import TypeAlias

Pair: TypeAlias = tuple[int, int]
ZERO: Pair = (0, 0)
ONE: Pair = (1, 0)
ALPHA: Pair = (2, 1)

def add(z: Pair, w: Pair) -> Pair:
    return z[0]+w[0], z[1]+w[1]

def neg(z: Pair) -> Pair:
    return -z[0], -z[1]

def mul(z: Pair, w: Pair) -> Pair:
    x,y=z; u,v=w
    return x*u-y*v, x*v+y*u+y*v

def conjugate(z: Pair) -> Pair:
    x,y=z
    return x+y,-y

def norm(z: Pair) -> int:
    x,y=z
    return x*x+x*y+y*y

def boundary(z: Pair) -> int:
    x,y=z
    return x*y*(x+y)

def height(z: Pair) -> int:
    x,y=z
    return max(abs(x),abs(y),abs(x+y))

def primitive(z: Pair) -> bool:
    return gcd(*z)==1

def division(z: Pair, w: Pair) -> tuple[Pair,Pair]:
    """Exact Euclidean division; nearest coordinate rounding, no floating point."""
    n=norm(w)
    if n==0:
        raise ZeroDivisionError('zero Eisenstein divisor')
    a,b=mul(z,conjugate(w))
    q=((2*a+n)//(2*n),(2*b+n)//(2*n))
    r=add(z,neg(mul(q,w)))
    assert mul(q,w)==add(z,neg(r))
    assert 4*norm(r)<=3*n
    assert norm(r)<n
    return q,r

def egcd(a: Pair, b: Pair) -> tuple[Pair,Pair,Pair]:
    """Return d,s,t with s*a+t*b=d, computed by Euclidean division."""
    r0,r1=a,b; s0,s1=ONE,ZERO; t0,t1=ZERO,ONE
    while r1!=ZERO:
        q,r2=division(r0,r1)
        r0,r1=r1,r2
        s0,s1=s1,add(s0,neg(mul(q,s1)))
        t0,t1=t1,add(t0,neg(mul(q,t1)))
    assert add(mul(s0,a),mul(t0,b))==r0
    return r0,s0,t0

def exact_quotient(z: Pair, w: Pair) -> Pair:
    n=norm(w)
    if n==0:
        raise ZeroDivisionError
    a,b=mul(z,conjugate(w))
    if a%n or b%n:
        raise ValueError('not an integral quotient')
    q=a//n,b//n
    assert mul(w,q)==z
    return q

@lru_cache(maxsize=None)
def factor(n: int) -> tuple[tuple[int,int],...]:
    n=abs(n)
    if n==0:
        raise ValueError('zero has no finite prime factorization')
    out=[]; p=2
    while p*p<=n:
        if n%p==0:
            e=0
            while n%p==0:
                n//=p; e+=1
            out.append((p,e))
        p=3 if p==2 else p+2
    if n>1:
        out.append((n,1))
    return tuple(out)

def radical(n: int) -> int:
    ans=1
    for p,_ in factor(n): ans*=p
    return ans

def descent(z: Pair) -> list[tuple[Pair,Pair,int]]:
    if not primitive(z):
        raise ValueError('primitive input required')
    out=[]
    while norm(z)>1:
        n=norm(z); p=factor(n)[0][0]
        assert p>=3
        pi,_,_=egcd((p,0),z)
        assert norm(pi)==p
        w=exact_quotient(z,pi)
        assert primitive(w)
        assert norm(w)*p==n
        assert 3*height(w)<=2*height(z)
        assert gcd(abs(boundary(w)),abs(boundary(z)))==gcd(abs(boundary(w)),abs(boundary(pi)))
        out.append((pi,w,p)); z=w
    assert norm(z)==height(z)==1
    return out

def run(box: int, max_c: int, orbit_limit: int, depth_count: int) -> dict:
    counts={}; digest=hashlib.sha256()
    def record(tag: str, *row: object) -> None:
        digest.update((tag+':'+repr(row)+'\n').encode())
    c=0
    for x in range(-box,box+1):
        for y in range(-box,box+1):
            w=(x,y)
            if not primitive(w): continue
            for u in range(-box,box+1):
                for v in range(-box,box+1):
                    z=(u,v); zw=mul(z,w)
                    assert norm(zw)==norm(z)*norm(w)
                    lhs=gcd(abs(boundary(w)),abs(boundary(zw)))
                    rhs=gcd(abs(boundary(w)),abs(boundary(z)))
                    assert lhs==rhs
                    record('gcd',z,w,lhs); c+=1
    counts['full_boundary_gcd_cases']=c
    triples=steps=0; longest=0
    for h in range(2,max_c+1):
        for a in range(1,h//2+1):
            b=h-a
            if gcd(a,b)!=1: continue
            z=(a,b)
            assert 3*height(z)**2<=4*norm(z)<=4*height(z)**2
            walk=descent(z)
            record('descent',z,walk)
            triples+=1; steps+=len(walk); longest=max(longest,len(walk))
    counts.update(complete_descent_triples=triples,descent_prime_steps=steps,longest_checked_descent=longest)
    orbit=[ONE]
    for k in range(1,max(orbit_limit,6*(depth_count-1)+1,10)+1):
        x,y=orbit[-1]
        orbit.append((2*x-y,x+3*y))
        z=orbit[-1]
        assert norm(z)==7**k and primitive(z)
        assert (z[0]-2*z[1])%7==0 and z[1]%7!=0
        assert boundary(z)!=0
        assert z[0]**3-z[1]**3==(z[0]-z[1])*7**k
    U=[0,1]
    for k in range(2,len(orbit)): U.append(20*U[-1]-343*U[-2])
    for k,z in enumerate(orbit):
        assert boundary(z)==6*U[k]
    counts['norm_and_lucas_indices']=len(orbit)
    masses=[abs(boundary(z)) for z in orbit]
    c=0
    for m in range(orbit_limit+1):
        for n in range(orbit_limit+1):
            g=gcd(masses[m],masses[n])
            assert g==masses[gcd(m,n)]
            record('strong',m,n,g); c+=1
    counts['strong_divisibility_pairs']=c
    c=0
    for j in range(depth_count):
        k=6*j+1; x,y=orbit[k]; h=max(abs(x),abs(y))
        assert x%4==2 and y%4==1
        assert abs(x)%4==2
        # Signed cubic triple. The entire quadratic quotient is one prime power.
        A=abs(x)**3; B=abs(y)**3; C=abs(x-y)*7**k
        triple=tuple(sorted((A,B,C)))
        assert triple[0]+triple[1]==triple[2]
        assert gcd(triple[0],triple[1])==1
        assert (x*y*(x-y))%7!=0
        # First-depth factor 7^(k-1) is at least h^2/28 (in fact 3h^2/28).
        assert 28*7**(k-1)>=3*h*h
        record('depth',k,x,y,triple); c+=1
    counts['normalized_single_prime_quotients']=c
    counter={}
    for k in (5,6):
        z=orbit[k]; P=abs(boundary(z)); R=radical(P)
        counter[str(k)]={'pair':z,'triple':sorted(map(abs,(z[0],z[1],z[0]+z[1]))),
                         'norm':norm(z),'height':height(z),'boundary':P,'factorization':factor(P),'radical':R}
    assert counter['5']['radical']==803706 and counter['6']['radical']==358530
    for m in range(101):
        assert 149**m*358530**(m+1)<360**m*803706**(m+1)
    counts['cleared_counterexample_exponents']=101
    # Exact prime-norm divisor alternatives of the counterexample.
    candidates=[]
    for u in range(-3,4):
        for v in range(-3,4):
            if norm((u,v))!=7: continue
            try: w=exact_quotient(orbit[6],(u,v))
            except ValueError: continue
            assert height(w)==149 and radical(abs(boundary(w)))==803706
            candidates.append((u,v,w))
    assert len(candidates)==6
    counter['all_prime_norm_parents']=candidates
    # A stronger K=1 obstruction: both factors satisfy the same exponent bound.
    z=(1,48); parents=[]
    assert norm(z)==13*181 and radical(abs(boundary(z)))==42
    assert mul((1,-4),(-15,4))==z
    for p in (13,181):
        for u in range(-16,17):
            for v in range(-16,17):
                if norm((u,v))!=p: continue
                try: w=exact_quotient(z,(u,v))
                except ValueError: continue
                h1=height((u,v)); r1=radical(abs(boundary((u,v))))
                h2=height(w); r2=radical(abs(boundary(w)))
                assert (h1,r1,h2,r2) in ((4,6,15,330),(15,330,4,6))
                assert h1**25<r1**26 and h2**25<r2**26
                parents.append((p,(u,v),w)); record('positive-parent',p,(u,v),w)
    assert len(parents)==12 and 49**25>42**26
    counter['positive_defect_factor_selection']={
        'triple':(1,48,49),'norm':2353,'radical':42,
        'epsilon':'1/25','constant':1,'all_prime_norm_factorizations':parents,
        'exact_cleared_excess':49**25-42**26}
    counts['positive_defect_factorizations']=len(parents)
    # Selected low-index checks of actual complete prime supports, not just norms.
    checks=0
    for k in range(1,11):
        x,y=orbit[k]
        seed=abs(x*y*(x-y))
        R=radical(abs(x**3*y**3*(x**3-y**3)))
        assert R==7*radical(seed)
        checks+=1
    counts['factored_cubic_radical_checks']=checks
    return {'status':'PASS: exact finite replay; not a proof of ABC',
            'parameters':{'box':box,'max_c':max_c,'orbit_limit':orbit_limit,'depth_count':depth_count},
            'counts':counts,'counterexample':counter,'ordered_digest':digest.hexdigest()}

def main() -> None:
    if not __debug__:
        raise RuntimeError('Run without -O: exact replay assertions must remain enabled')
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--box',type=int,default=12)
    ap.add_argument('--max-c',type=int,default=400)
    ap.add_argument('--orbit-limit',type=int,default=240)
    ap.add_argument('--depth-count',type=int,default=80)
    ap.add_argument('--output',type=Path)
    args=ap.parse_args()
    if min(args.box,args.max_c,args.orbit_limit,args.depth_count)<1:
        ap.error('all bounds must be positive')
    obj=run(args.box,args.max_c,args.orbit_limit,args.depth_count)
    text=json.dumps(obj,ensure_ascii=False,indent=2,sort_keys=True)+'\n'
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(text,encoding='utf-8')
    print(text,end='')
if __name__=='__main__':main()
