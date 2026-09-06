#!/usr/bin/env python3
"""Exact finite checks only; no test of analytic constants or standard ABC.
Run with Python >= 3.10. No third-party dependency or probable-prime oracle.
"""
from __future__ import annotations
from fractions import Fraction
from math import gcd, isqrt, prod
from pathlib import Path
import hashlib, json

HERE=Path(__file__).resolve().parent

def primes_upto(n: int) -> list[int]:
    flags=bytearray(b'\1')*(n+1)
    if n>=0: flags[0]=0
    if n>=1: flags[1]=0
    for p in range(2,isqrt(n)+1):
        if flags[p]: flags[p*p:n+1:p]=b'\0'*(((n-p*p)//p)+1)
    return [i for i in range(2,n+1) if flags[i]]

def valuation(n: int,p: int) -> int:
    if n==0 or p<2: raise ValueError('nonzero integer and base >= 2 required')
    n=abs(n); e=0
    while n%p==0: n//=p; e+=1
    return e

def check_certificates(data: dict) -> tuple[set[int],int]:
    nodes=data['prime_certificates']; proved=set(); checks=0
    for n in sorted(map(int,nodes)):
        node=nodes[str(n)]
        assert node['n']==n
        if n==2:
            assert node['factors']==[];proved.add(2);continue
        assert n>2 and n%2==1
        fs=node['factors'];assert len(fs)==len({p for p,e in fs})
        assert all(p in proved and e>=1 for p,e in fs)
        assert prod(p**e for p,e in fs)==n-1
        a=node['base'];assert 1<a<n
        assert pow(a,n-1,n)==1;checks+=1
        for p,e in fs:
            assert gcd(pow(a,(n-1)//p,n)-1,n)==1;checks+=1
        proved.add(n)
    return proved,checks

def check_examples(data: dict,proved: set[int]) -> list[dict]:
    result=[]
    for ex in data['examples']:
        a,b,c=ex['a'],ex['b'],ex['c'];assert a+b==c and gcd(a,b)==1
        q=a*a+a*b+b*b;assert q==ex['norm']
        powers={};arm_factors=[]
        for n,fs in zip((a,b,c),ex['factors']):
            assert len(fs)==len({p for p,e in fs})
            assert all(p in proved and e>=1 for p,e in fs)
            assert prod(p**e for p,e in fs)==n
            f=dict(fs);arm_factors.append(f)
            for p,e in fs:
                assert p not in powers;powers[p]=e
        specified={p:(k,arm) for p,k,arm in ex['pattern']}
        G=prod(p**(k-1) for p,(k,arm) in specified.items())
        for p,(k,arm) in specified.items():
            assert arm_factors['abc'.index(arm)].get(p,0)==k
        assert all(e==1 for p,e in powers.items() if p not in specified)
        R=prod(powers);T=a*b*c
        E=prod(p**max(e-3,0) for p,e in powers.items())
        C=prod(p**max(3-e,0) for p,e in powers.items())
        assert T==G*R and T*C==R**3*E
        assert Fraction(c,R)==Fraction(G,a*b)
        assert c<R
        if ex['kind']=='prime_norm': assert q in proved
        else: assert a==1 and q%49==7
        result.append({'a':a,'b':b,'c':c,'norm':q,'kind':ex['kind'],
            'G':G,'radical':R,'E3':E,'C3':C,
            'c_over_R':[Fraction(c,R).numerator,Fraction(c,R).denominator]})
    return result

def local_residue_counts() -> tuple[list[dict],int]:
    result=[];pairs=0
    for p in [5,7,11,13,17,19]:
        m=p*p;unit=bad=0;separate=[0,0,0]
        for a in range(m):
            for b in range(m):
                pairs+=1
                if (a*a+a*b+b*b)%p==0: continue
                unit+=1
                flags=[a==0,b==0,(a+b)%m==0]
                assert sum(flags)<=1
                for i,x in enumerate(flags):separate[i]+=int(x)
                bad+=int(any(flags))
        chi=1 if p%3==1 else -1
        assert unit==p*p*(p-1)*(p-chi)
        assert separate==[p*p-p]*3 and bad==3*(p*p-p)
        assert Fraction(bad,unit)==Fraction(3,p*(p-chi))
        # A different mod-p calculation: every unit pair has p^2 lifts.
        mod_p_units=sum((a*a+a*b+b*b)%p!=0 for a in range(p) for b in range(p))
        assert unit==mod_p_units*p*p
        result.append({'p':p,'unit_residues':unit,'bad_residues':bad,
                       'density':[Fraction(bad,unit).numerator,Fraction(bad,unit).denominator]})
    return result,pairs

# Low-first coefficient exact polynomial arithmetic, separate from pair evaluation.
def trim(a):
    a=list(map(Fraction,a))
    while len(a)>1 and a[-1]==0:a.pop()
    return a

def add(a,b):return trim([(a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0) for i in range(max(len(a),len(b)))])
def neg(a):return [-x for x in a]
def mul(a,b):
    c=[Fraction(0)]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]+=x*y
    return trim(c)
def power(a,n):
    r=[Fraction(1)]
    for _ in range(n):r=mul(r,a)
    return r

def derivative(a):return trim([i*a[i] for i in range(1,len(a))] or [0])
def remainder(a,b):
    a=trim(a);b=trim(b)
    if b==[0]:raise ZeroDivisionError
    while a!=[0] and len(a)>=len(b):
        k=len(a)-len(b);q=a[-1]/b[-1]
        for j,x in enumerate(b):a[j+k]-=q*x
        a=trim(a)
    return a

def polygcd(a,b):
    a=trim(a);b=trim(b)
    while b!=[0]:a,b=b,remainder(a,b)
    return trim([x/a[-1] for x in a])

def maps() -> list[dict]:
    A=[Fraction(1)];B=[Fraction(0)];rows=[]
    for g in range(1,13):
        A,B=add(mul(A,[0,1]),neg(B)),add(A,mul(B,[1,1]))
        assert polygcd(A,B)==[1]
        N=add(add(mul(A,A),mul(A,B)),mul(B,B))
        assert N==power([1,1,1],g)
        F=mul(mul(A,B),add(A,B))
        roots_finite=len(F)-len(polygcd(F,derivative(F)))
        roots_infinity=int(len(F)-1<3*g)
        s=roots_finite+roots_infinity
        assert s==3*g
        J=add(mul(derivative(A),B),neg(mul(A,derivative(B))))
        # J has exactly the norm roots for g>1.
        assert len(J)-1==2*g-2
        if g>=2:
            assert remainder(J,power([1,1,1],g-1))==[0]
            assert s==3*g-2+2
            assert s-3>=g+1
        rows.append({'degree':g,'finite_boundary_roots':roots_finite,
            'infinity_boundary_roots':roots_infinity,'total_boundary_roots':s,
            'new_boundary_degree':s-3,'jacobian_degree':len(J)-1})
    return rows

def progression_sieve() -> dict:
    m=1764
    r=next(r for r in range(m) if r%36==6 and r%49==2)
    X=400*m*m
    start=(X-r)//m+1;end=(2*X-1-r)//m
    first=r+m*start;length=end-start+1
    remaining=bytearray(b'\1')*length
    ps=primes_upto(isqrt(2*X+1))
    used=0
    for p in ps:
        if m%p==0:continue
        used+=1;step=p*p;inv=pow(m,-1,step)
        for offset in [0,1]:
            j=(-(first+offset)*inv)%step
            if j<length:remaining[j:length:step]=b'\0'*(((length-1-j)//step)+1)
    count=sum(remaining)
    assert 4*m*count>=X
    # Independently factor a bounded selection of the actual surviving integers.
    sampled=0
    for i,flag in enumerate(remaining):
        if not flag:continue
        b=first+m*i
        assert b%36==6 and (b*b+b+1)%49==7
        for n in [b,b+1]:
            x=n
            for p in ps:
                if p*p>x:break
                if x%p==0:
                    x//=p;assert x%p!=0
                    while x%p==0:x//=p
        sampled+=1
        if sampled==100:break
    return {'m':m,'residue':r,'X':X,'progression_points':length,
            'prime_square_sieve_bases':used,'survivors':count,
            'theorem_lower_bound':X//(4*m),'independently_factored_pairs':sampled,
            'bitmap_sha256':hashlib.sha256(remaining).hexdigest()}

def main():
    data=json.loads((HERE/'certificates.json').read_text())
    proved,checks=check_certificates(data)
    residues,npairs=local_residue_counts()
    result={'status':'PASS: exact finite tests only; not an ABC proof',
        'certificate_nodes':len(proved),'modular_certificate_conditions':checks,
        'examples':check_examples(data,proved),
        'local_residue_pairs_examined':npairs,'local_residue_counts':residues,
        'power_maps':maps(),'progression_sieve':progression_sieve(),
        'not_tested':['Kai analytic constants or effective thresholds','all-point ABC',
                      'full analytic theorem in Lean','general ramification theorem in Lean']}
    print(json.dumps(result,sort_keys=True,indent=2))
if __name__=='__main__':main()
