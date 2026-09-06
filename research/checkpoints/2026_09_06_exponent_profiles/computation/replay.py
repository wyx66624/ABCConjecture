#!/usr/bin/env python3
"""Exact finite replay. No analytic constant or universal ABC bound is tested."""
from __future__ import annotations
import argparse
import hashlib
import json
from fractions import Fraction
from itertools import product
from math import gcd, isqrt, prod
from pathlib import Path
from typing import Iterator
Pair = tuple[int, int]

def mul(z: Pair, w: Pair) -> Pair:
    x,y=z; u,v=w
    return x*u-y*v, x*v+y*u+y*v

def norm(z: Pair) -> int:
    x,y=z
    return x*x+x*y+y*y

def power(z: Pair, n: int) -> Pair:
    assert n>=0
    out=(1,0)
    while n:
        if n&1: out=mul(out,z)
        z=mul(z,z); n//=2
    return out

def factor(n: int) -> dict[int,int]:
    assert n>0
    f: dict[int,int]={}
    p=2
    while p*p<=n:
        while n%p==0:
            f[p]=f.get(p,0)+1; n//=p
        p=3 if p==2 else p+2
    if n>1: f[n]=f.get(n,0)+1
    return f

def prime(n: int) -> bool:
    if n<2:return False
    if n%2==0:return n==2
    return all(n%d for d in range(3,isqrt(n)+1,2))

def radical(n: int) -> int:
    return prod(factor(n))

def parts(n:int) -> Iterator[tuple[tuple[int,...],...]]:
    """Each set partition once: append the largest label in canonical order."""
    if n==0:
        yield (); return
    for q in parts(n-1):
        for j in range(len(q)):
            yield q[:j]+(q[j]+(n-1,),)+q[j+1:]
        yield q+((n-1,),)

def prime_pair(q: int) -> Pair:
    assert q==3 or q%3==1
    for y in range(1,isqrt(q)+1):
        d=4*q-3*y*y
        if d<0: continue
        s=isqrt(d)
        if s*s==d and (s-y)%2==0 and s>=y:
            z=((s-y)//2,y)
            assert norm(z)==q
            return z
    raise AssertionError(('missing prime representation',q))

def divide(z:Pair,w:Pair) -> Pair|None:
    u,v=w; x,y=z; q=norm(w)
    r=x*(u+v)+y*v; s=y*u-x*v
    if r%q or s%q:return None
    return r//q,s//q

def decompose(z:Pair) -> tuple[Pair,int,list[tuple[int,int,Pair]]]:
    assert gcd(*z)==1
    f=factor(norm(z)); out=z; ram=f.pop(3,0)
    assert ram<=1
    if ram:
        div=divide(out,(1,1)); assert div is not None; out=div
    data=[]
    for q,e in f.items():
        w=prime_pair(q)
        if divide(out,w) is None:w=(w[0]+w[1],-w[1])
        for _ in range(e):
            div=divide(out,w); assert div is not None; out=div
        data.append((q,e,w))
    assert norm(out)==1
    return out,ram,data

def matrix_power_apply(z:Pair,n:int) -> Pair:
    """Independent 2x2 integer-matrix realization of multiplication."""
    a,b=z; M=(a,-b,b,a+b); R=(1,0,0,1)
    def mm(A,B):
        x,y,z,w=A; u,v,s,t=B
        return x*u+y*s,x*v+y*t,z*u+w*s,z*v+w*t
    while n:
        if n&1:R=mm(R,M)
        M=mm(M,M);n//=2
    return R[0],R[2]

def replay(max_c:int=240,max_p:int=47)->dict:
    triple_count=partition_count=block_count=0
    max_r=0; inverse_checks=0
    for c in range(2,max_c+1):
        for a in range(1,c//2+1):
            b=c-a
            if gcd(a,b)!=1:continue
            z=(a,b);T=a*b*c;M=norm(z)
            assert gcd(M,T)==1
            unit,ram,data=decompose(z)
            triple_count+=1;max_r=max(max_r,len(data))
            for partition in parts(len(data)):
                out=mul(unit,power((1,1),ram)); norm_product=3**ram
                for block in partition:
                    k=0
                    for i in block:k=gcd(k,data[i][1])
                    assert k>=1
                    w=(1,0);Q=1
                    for i in block:
                        q,e,v=data[i]; assert e%k==0
                        w=mul(w,power(v,e//k));Q*=q**(e//k)
                    assert norm(w)==Q and Q>=7
                    assert power(w,k)==matrix_power_apply(w,k)
                    out=mul(out,power(w,k));norm_product*=Q**k
                    block_count+=1
                assert out==z and norm_product==M
                partition_count+=1
            # cubic/shape equalities are checked independently on each triple
            assert c**3-4*T==c*(a-b)**2
            assert 3*c*c<=4*M<=4*c*c
            inverse_checks+=1
    # Universal progression statements are subjected to a separate bounded scan.
    progression_checks=0
    for p in range(2,151):
        for j in range(40):
            c=p**4*(1+p*j)
            assert c%p**4==0 and c%p**5!=0
            assert c-1==(p**4-1)+j*p**5
            progression_checks+=1
    # These are exact examples, not a numerical test of Linnik's constant.
    rows=[]
    for p in range(3,max_p+1,2):
        if not prime(p):continue
        j=0
        while True:
            ell=p**4-1+j*p**5
            if prime(ell):break
            j+=1
            if j>10000:raise RuntimeError('Finite search cap exceeded')
        c=ell+1; cf=factor(c)
        assert cf[p]==4 and prime(ell)
        R=ell*prod(cf)
        E=prod(q**max(e-3,0) for q,e in cf.items())
        C=ell**2*prod(q**max(3-e,0) for q,e in cf.items())
        T=ell*c
        assert R>c and E>=p and T*C==R**3*E
        assert Fraction(E,C)<=Fraction(c,ell**2)
        rows.append(dict(p=p,ell=ell,j=j,c=c,c_factorization=cf,R=R,E3=E,C3=C))
    # Moving q and two coprime block contents: no factoring of gigantic boundaries.
    profiles=[]
    for q in range(13,151):
        if q%3!=1 or not prime(q):continue
        w=prime_pair(q);k=q.bit_length()**3
        z=mul(power(w,k),power((2,1),k+1))
        assert gcd(*z)==1 and norm(z)==q**k*7**(k+1)
        assert gcd(k,k+1)==1 and z[0]*z[1]*(z[0]+z[1])!=0
        assert power(w,k)==matrix_power_apply(w,k)
        profiles.append(dict(q=q,k=k,common_content=1,norm_bits=norm(z).bit_length(),
                             coordinate_sha256=hashlib.sha256(str(z).encode()).hexdigest()))
    return dict(status='PASS: finite exact checks only; not ABC',
                bounds=dict(max_c=max_c,max_p=max_p),
                primitive_triples=triple_count,partitions=partition_count,
                reconstructed_blocks=block_count,max_split_prime_count=max_r,
                cubic_checks=inverse_checks,progression_checks=progression_checks,
                prime_neighbours=rows,moving_profiles=profiles,
                not_tested=['external logarithmic-form constants','Linnik existence theorem',
                            'uniform large-prime mass','standard ABC','prime factorization of huge boundaries'])

def main()->None:
    p=argparse.ArgumentParser();p.add_argument('--output',type=Path,required=True)
    p.add_argument('--max-c',type=int,default=240);p.add_argument('--max-p',type=int,default=47)
    args=p.parse_args(); result=replay(args.max_c,args.max_p)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k not in ('prime_neighbours','moving_profiles')},indent=2))
    print('prime-neighbour rows:',len(result['prime_neighbours']))
    print('moving profiles:',len(result['moving_profiles']))
if __name__=='__main__':main()
