#!/usr/bin/env python3
"""Exact finite audits for power-radical descent and pair-energy proximity.
Author: ChatGPT. Standard library only. No finite test proves ABC.
"""
from __future__ import annotations
from collections import deque
from fractions import Fraction as F
from functools import lru_cache, reduce
from hashlib import sha256
from itertools import combinations
from math import gcd, isqrt, prod
from pathlib import Path
import json
import random
import sys

if not __debug__:
    raise RuntimeError('Assertions are verification checks: do not use python -O')

def sieve(N: int) -> list[int]:
    b=bytearray(b'\x01')*(N+1); b[0:2]=b'\x00\x00'
    for p in range(2,isqrt(N)+1):
        if b[p]: b[p*p:N+1:p]=b'\x00'*((N-p*p)//p+1)
    return [i for i in range(2,N+1) if b[i]]

PRIMES=sieve(300000)
@lru_cache(None)
def factor(n: int) -> tuple[tuple[int,int],...]:
    if n<1: raise ValueError('positive integer required')
    original=n; fs=[]
    for p in PRIMES:
        if p*p>n: break
        e=0
        while n%p==0: n//=p; e+=1
        if e:fs.append((p,e))
    if n>1:
        # For the finite grid the fixed trial list is complete. Never silently
        # regard a large unsieved residual as prime.
        if PRIMES[-1]**2<n:
            p=PRIMES[-1]+2
            while p*p<=n:
                e=0
                while n%p==0:n//=p;e+=1
                if e:fs.append((p,e))
                p+=2
        if n>1:fs.append((n,1))
    assert prod(p**e for p,e in fs)==original
    return tuple(fs)

def rad(n: int) -> int:return prod(p for p,e in factor(n))
def val(n: int,p: int) -> int:
    if n<=0 or p<2:raise ValueError('valuation requires n>0, p>=2')
    e=0
    while n%p==0:n//=p;e+=1
    return e

def power_data(x: int,y: int,n: int,sign: int=-1) -> dict:
    if not (x>y>0 and gcd(x,y)==1 and n>=1 and sign in (-1,1)):
        raise ValueError('invalid power data')
    if sign==1 and n%2==0:raise ValueError('plus quotient requires odd n')
    b=x**n+sign*y**n; seed=x+sign*y; G=b//seed
    assert G*seed==b
    R0=rad(x)*rad(y)*rad(seed); R=rad(x)*rad(y)*rad(b)
    old={p for p,e in factor(seed)}
    fs=dict(factor(b)); L=prod(p**val(n,p) for p in fs)
    E2=2**(val(x+y,2)-1) if sign==-1 and n%2==0 and x%2==y%2==1 else 1
    T=1; details=[]
    for p,e in fs.items():
        if p in old:continue
        assert p!=2 and gcd(p,x*y)==1
        ds=[d for d in range(1,n+1) if n%d==0 and (pow(x,d,p)+sign*pow(y,d,p))%p==0]
        d=min(ds)
        assert (p-1)%d==0 and d>1
        alpha=val(x**d+sign*y**d,p)
        assert e==alpha+val(n,p)
        T*=p**(alpha-1);details.append((p,d,alpha))
    B=E2*L*T
    assert n%L==0 and R%R0==0 and R*B==R0*G
    assert G%(R//R0)==0 and G//(R//R0)==B
    return dict(x=x,y=y,n=n,sign=sign,R0=R0,R=R,G=G,L=L,T=T,E2=E2,B=B,first=details)

def phi(x: int)->int:return x*x+x+1
def step(x: int)->int:return x+32*phi(x)

def small_orbit(k: int)->int:
    modulus=4*7**(k+2);r=226%modulus
    for _ in range(k):r=step(r)%modulus
    return r

def hensel_representative(k: int)->int:
    r=2;M=7
    for _ in range(k+1):
        q=phi(r)//M
        digit=(-q*pow(2*r+1,-1,7))%7
        r+=M*digit;M*=7
        assert 0<=r<M and phi(r)%M==0
    x=r+M*(((2-r)*pow(M,-1,4))%4)
    assert 0<x<4*M
    return x

def nearest(q:F)->int:return (2*q.numerator+q.denominator)//(2*q.denominator)

def profile(fs:dict[int,int])->dict:
    ps=sorted(fs); k=reduce(gcd,fs.values());f={p:fs[p]//k for p in ps}
    n=prod(p**fs[p] for p in ps);r=prod(ps);rho=prod(p for p in ps if f[p]%p==0)
    s={p:F(1) if f[p]%p else F(1,p) for p in ps}
    m={p:int(f[p]*s[p]) for p in ps};S=sum(f.values())
    G=n//r*k*rho
    assert G==reduce(gcd,(n//p*fs[p] for p in ps))
    kappas={p:sum((F(f[q]*(f[p]+f[q]),2*S)*s[p]*s[q]/gcd(m[p],m[q])
                   for q in ps if q!=p),F(0)) for p in ps}
    kap=max(kappas.values());assert kap<=max(f.values())
    return dict(ps=ps,fs=fs,k=k,f=f,n=n,r=r,rho=rho,s=s,m=m,S=S,G=G,kap=kap)

def initial_lift(P:dict,d:int)->dict[int,int]:
    ps=P['ps']; f=P['f'];m=P['m'];q=F(d,P['n']*sum(P['fs'].values()))
    rp=P['r']//P['rho'];u=d//P['G'];lam={}
    assert d%P['G']==0
    for p in ps:
        if P['s'][p]==1:
            residue=u*pow(f[p]*(rp//p),-1,p)%p
            lam[p]=residue+p*nearest(q-F(residue,p))
        else:lam[p]=nearest(p*q)
    v=F(d,P['n']*P['k'])-sum((F(f[p]*lam[p],p) for p in ps),F(0));assert v.denominator==1
    anchor=min(ps,key=lambda p:(m[p],p));mod=m[anchor]
    parents={0:None};Q=deque([0])
    while Q:
        a=Q.popleft()
        for p in ps:
            b=(a+m[p])%mod
            if b not in parents:parents[b]=(a,p);Q.append(b)
    assert len(parents)==mod
    z={p:0 for p in ps};a=v.numerator%mod
    while a:
        a,p=parents[a];z[p]+=1
    z[anchor]+=(v.numerator-sum(m[p]*z[p] for p in ps))//mod
    for p in ps:lam[p]+=int(p*P['s'][p])*z[p]
    assert sum(P['n']//p*P['fs'][p]*lam[p] for p in ps)==d
    return lam

def proximity(P:dict,d:int,lam:dict[int,int])->dict:
    lam=dict(lam);ps=P['ps'];f=P['f'];s=P['s'];m=P['m'];q=F(d,P['n']*sum(P['fs'].values()))
    def energy():return sum((f[p]*(F(lam[p],p)-q)**2 for p in ps),F(0))
    initial=energy();iterations=0
    while True:
        improved=False
        for p,r in combinations(ps,2):
            gg=gcd(m[p],m[r]);v=s[p]*s[r]/gg
            diff=F(lam[p],p)-F(lam[r],r)
            t=nearest(-diff/(v*(f[p]+f[r])))
            change=2*f[p]*f[r]*v*diff*t+f[p]*f[r]*v*v*(f[p]+f[r])*t*t
            if change<0:
                old=energy()
                lam[p]+=t*int(p*s[p])*(m[r]//gg)
                lam[r]-=t*int(r*s[r])*(m[p]//gg)
                assert energy()==old+change and energy()<old
                iterations+=1;improved=True;break
        if not improved:break
        if iterations>100000:raise RuntimeError('iteration guard; no result certified')
    assert sum(P['n']//p*P['fs'][p]*lam[p] for p in ps)==d
    for p,r in combinations(ps,2):
        assert abs(F(lam[p],p)-F(lam[r],r))<=s[p]*s[r]*F(f[p]+f[r],2*gcd(m[p],m[r]))
    err=max(abs(F(lam[p],p)-q) for p in ps)
    assert err<=P['kap']
    return dict(iterations=iterations,error=err,bound=P['kap'],initial_energy=initial,
                final_energy=energy(),weights=lam)

def main()->dict:
    digest=sha256(); counts={}; examples=[]
    def feed(x):digest.update((json.dumps(x,default=str,sort_keys=True,separators=(',',':'))+'\n').encode())
    signed=0;transfers=0
    for x in range(2,33):
        for y in range(1,x):
            if gcd(x,y)!=1:continue
            for sign,ns in [(-1,range(1,8)),(1,(1,3,5,7))]:
                for n in ns:
                    P=power_data(x,y,n,sign);feed(P);signed+=1
                    H0=x if sign==-1 else x+y
                    H1=x**n if sign==-1 else x**n+y**n
                    scale=F(x**(n-1),P['G']) if sign==-1 else F(1)
                    for m in (1,2,3,5):
                        q0=F(H0**m,P['R0']**(m+1));q1=F(H1**m,P['R']**(m+1))
                        ratio=(F(x**(m*(n-1)),P['G']**(m+1)) if sign==-1 else F(1,P['G']))*P['B']**(m+1)
                        assert q1==q0*ratio
                        if P['B']**(m+1)<=(x**(n-1) if sign==-1 else P['G']):assert q1<=q0
                        transfers+=1
    counts['signed_radical_identities']=signed;counts['cleared_defect_transfers']=transfers
    cocycles=0;rebases=0
    for x in range(2,13):
        for y in range(1,x):
            if gcd(x,y)!=1:continue
            for m in (1,2,3):
                for n in (1,2,3):
                    P=power_data(x,y,m*n);A=power_data(x,y,m);B=power_data(x**m,y**m,n)
                    assert P['G']==A['G']*B['G'] and P['B']==A['B']*B['B'];cocycles+=1
                    if m%2 and n%2:
                        inflation=prod(p**val(m,p) for p,e in factor(x**(m*n)-y**(m*n)) if (x**m-y**m)%p)
                        assert P['T']%A['T']==0 and B['T']==P['T']//A['T']*inflation
                        assert m%inflation==0;rebases+=1
                    feed((x,y,m,n,P['B'],A['B'],B['B']))
    counts['cocycle_checks']=cocycles;counts['base_reallocation_checks']=rebases
    orbit_rows=[];r=226
    for k in range(13):
        ff=phi(r);e=val(ff,7)
        assert r%49==30 and r%4==2 and e==k+2 and val(r**3-1,7)==k+2
        blob=r.to_bytes((r.bit_length()+7)//8,'big')
        row=dict(k=k,bit_length=r.bit_length(),v7_phi=e,sha256=sha256(blob).hexdigest())
        if k<3:row['x']=str(r)
        feed(row);orbit_rows.append(row);r=step(r)
    small_rows=[]
    for k in range(129):
        r=small_orbit(k);rr=hensel_representative(k)
        assert r==rr and r%4==2 and r%7==2 and 2<=r<28*7**(k+1)
        assert phi(r)%7**(k+2)==0 and phi(r)>=7**(k+2)
        assert F(7**(k+1),r)>F(1,28)
        assert pow(r,3,7)==1 and pow(r,1,7)!=1 and pow(r,2,7)!=1
        row=dict(k=k,x=str(r),v7_phi=val(phi(r),7),exhibited_excess=str(7**(k+1)))
        feed(row)
        if k<8:small_rows.append(row)
    counts['orbit_exact_valuations']=13;counts['independent_small_representatives']=129
    cnt=0; max_steps=0; rng=random.Random(20260905);best=[]
    fs_list=[dict(factor(n)) for n in range(2,2001)]
    for _ in range(500):
        ps=sorted(rng.sample([2,3,5,7,11,13,17],rng.randrange(1,6)))
        fs_list.append({p:rng.randrange(1,18) for p in ps})
    for fs in fs_list:
        P=profile(fs)
        for u in (-17,1,100003):
            d=P['G']*u;ini=initial_lift(P,d);out=proximity(P,d,ini)
            cnt+=1;max_steps=max(max_steps,out['iterations'])
            feed((fs,u,out['error'],out['bound'],out['iterations']))
    counts['local_energy_lifts']=cnt;counts['max_energy_exchanges']=max_steps
    for fs in ({2:1,3:1,5:1,7:1},{2:1,3:100},{2:2,3:3},{2:64,3:41}):
        P=profile(fs);out=proximity(P,P['G'],initial_lift(P,P['G']))
        best.append(dict(factors=fs,previous_S=P['S'],max_f=max(P['f'].values()),new_envelope=out['bound'],realized_error=out['error']))
    return dict(status='PASS: exact finite tests, not an ABC proof',counts=counts,
                orbit=orbit_rows,small_representatives=small_rows,energy_examples=best,
                ordered_digest=digest.hexdigest(),two_adic_example=power_data(7,1,2),
                cubic_seed_example=power_data(30,1,3))

if __name__=='__main__':
    result=main();payload=json.dumps(result,default=str,sort_keys=True,indent=2)+'\n'
    if len(sys.argv)>1:Path(sys.argv[1]).write_text(payload)
    print(json.dumps(dict(status=result['status'],counts=result['counts'],ordered_digest=result['ordered_digest']),indent=2))
