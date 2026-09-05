#!/usr/bin/env python3
"""Deterministic exact replay, Python >=3.10, standard library only.
Finite tests validate implementation, not universal mathematical claims.
Author: ChatGPT.
"""
from __future__ import annotations
if not __debug__:
    raise RuntimeError("Run without Python optimization: assertions are required checks")
import argparse, hashlib, json
from fractions import Fraction as F
from functools import reduce
from itertools import combinations, product
from math import gcd, prod
from pathlib import Path
from random import Random
from lifting import construct, profile, local_lift, factor

def encoded(obj):
    if isinstance(obj,F): return f'{obj.numerator}/{obj.denominator}'
    if isinstance(obj,dict): return {str(k):encoded(v) for k,v in obj.items()}
    if isinstance(obj,(list,tuple)): return [encoded(v) for v in obj]
    return obj

def canonical(obj):
    return json.dumps(encoded(obj),sort_keys=True,separators=(',',':')).encode()

def independent_relaxation(a,b,c,I,oms):
    """Enumerate breakpoints of the convex piecewise-linear objective."""
    o=[F(0),F(I,a*b),F(I,a*c)]
    if 0 in oms:
        x=-o[oms.index(0)]
        return max(abs(x+oi)/w for w,oi in zip(oms,o) if w)
    candidates=[-oi for oi in o]
    for i,j in combinations(range(3),2):
        candidates.append(-(oms[j]*o[i]+oms[i]*o[j])/(oms[i]+oms[j]))
    return min(max(abs(x+oi)/w for w,oi in zip(oms,o)) for x in candidates)

def independent_global_check(result):
    a,b,c=result['a'],result['b'],result['c']
    ds=[]; G=[]; R=1; oms=[]
    for n in (a,b,c):
        fac=factor(n)
        coeff=[(n//p)*e for p,e in fac.items()]
        ds.append(sum((n//p)*e*result['weights'][p] for p,e in fac.items()))
        G.append(reduce(gcd,coeff,0)); R*=prod(fac); oms.append(sum(fac.values()))
    I=gcd(gcd(c*G[0]*G[1],b*G[0]*G[2]),a*G[1]*G[2])//reduce(gcd,G)
    assert I==result['I'] and R==result['R']
    assert ds[0]+ds[1]==ds[2] and a*ds[1]-b*ds[0]==result['level']*I
    h=independent_relaxation(a,b,c,I,oms)*abs(result['level'])
    assert h==result['real_min']
    assert max(F(abs(v),p) for p,v in result['weights'].items())==result['constructed_norm']
    assert h <= result['constructed_norm'] <= h+result['error_bound']

def run(cmax=600,nmax=30000):
    digest=hashlib.sha256()
    local_tests=0; max_scaled_error=F(0); worst_local=None; profile_tests=0
    for n in range(1,nmax+1):
        P=profile(n); profile_tests+=1
        digest.update(canonical([n,P['G'],P['h'],P['rho']]))
        if n>5000: continue
        for mult in ([0] if n==1 else [-17,-1,0,1,17,10**18+39]):
            d=P['G']*mult
            lam=local_lift(P,d); local_tests+=1
            if n>1:
                q=F(d,n*P['omega'])
                err=max(abs(F(v,p)-q) for p,v in lam.items())
                ratio=err/P['S']
                if ratio>max_scaled_error:
                    max_scaled_error=ratio; worst_local=dict(n=n,mult=mult,error=err,S=P['S'])
                assert sum((n//p)*e*lam[p] for p,e in P['fac'].items())==d
            digest.update(canonical([n,mult,lam]))
    rng=Random(20260905); primes=[2,3,5,7,11,13,17,19,23,29,31]
    random_tests=0; min_step_ge_two=0; all_resonant=0
    for _ in range(1200):
        selected=sorted(rng.sample(primes,rng.randint(1,6)))
        common=rng.randint(1,9)
        fac={p:common*rng.randint(1,30) for p in selected}
        n=prod(p**e for p,e in fac.items()); P=profile(n,fac)
        steps=[e//P['k']//(p if (e//P['k'])%p==0 else 1) for p,e in fac.items()]
        min_step_ge_two += min(steps)>=2; all_resonant += P['rho']==P['rad']
        for mult in [rng.randint(-100,100),10**30+7]:
            lam=local_lift(P,mult*P['G']); random_tests+=1
            digest.update(canonical([fac,mult,lam]))
    triples=0; levels=0; largest_overhead=F(0); worst=None
    for c in range(3,cmax+1):
        for a in range(1,c//2+1):
            b=c-a
            if gcd(a,b)!=1: continue
            result=construct(a,b); independent_global_check(result); triples+=1
            overhead=result['constructed_norm']-result['real_min']
            if overhead>largest_overhead:
                largest_overhead=overhead; worst=result
            digest.update(canonical(result))
            if triples%97==0:
                for m in [-19,-2,2,17]:
                    r=construct(b,a,level=m); independent_global_check(r); levels+=1
                    digest.update(canonical(r))
    benchmarks=[]
    for a,b in [(2,3**10*109),(5,7),(9,16),(1,3024),(3,125),(1,8)]:
        r=construct(a,b); independent_global_check(r); benchmarks.append(r)
    assert benchmarks[0]['constructed_norm']==F(1644,23)
    assert benchmarks[0]['real_min']==F(6561,92)
    points=[]
    for x2,x3,x5 in product(range(-2,3),range(-3,4),range(-5,6)):
        x7=12*x2+4*x3-x5
        if abs(x7)>7: continue
        w=5*x7-7*x5
        if not w: continue
        h=max(F(abs(x2),2),F(abs(x3),3),F(abs(x5),5),F(abs(x7),7))
        points.append((h,w,(x2,x3,x5,x7)))
    small_min=min(x[0] for x in points)
    primitive_min=min(x[0] for x in points if abs(x[1])==4)
    assert small_min==F(1,5) and primitive_min==F(2,5)
    minimizers=[x for x in points if x[0]==small_min]
    assert {abs(x[1]) for x in minimizers}=={12}
    gap_solutions=[]
    for x in range(-142,143):
        for m in [-1,0,1]:
            rhs=19683*m+23*x
            if rhs%10==0 and abs(rhs//10)<=1643: gap_solutions.append((x,rhs//10,m))
    assert all(m==0 for _,_,m in gap_solutions)
    return dict(status='PASS; finite exact replay, not an ABC proof',
        parameters=dict(cmax=cmax,nmax=nmax,seed=20260905),
        content_profiles=profile_tests,local_lifts=local_tests,
        randomized_large_factorizations=1200,randomized_local_lifts=random_tests,
        randomized_profiles_min_step_at_least_two=min_step_ge_two,
        randomized_profiles_all_resonant=all_resonant,
        primitive_triples=triples,additional_signed_levels=levels,
        maximum_local_error_over_S=max_scaled_error,worst_local=worst_local,
        largest_constructed_overhead=largest_overhead,worst_constructed_example=worst,
        small_example_nonzero_points_in_unit_ball=len(points),
        small_example_minimum=small_min,small_example_primitive_minimum=primitive_min,
        small_example_minimizers=minimizers,
        benchmark_gap_cell_solutions=len(gap_solutions),benchmark_gap_cell_nonzero_levels=0,
        benchmarks=benchmarks,ordered_check_digest=digest.hexdigest())

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path,required=True)
    parser.add_argument('--cmax',type=int,default=600)
    parser.add_argument('--nmax',type=int,default=30000)
    args=parser.parse_args()
    if args.cmax<3 or args.nmax<2: parser.error('bounds must be at least 3 and 2')
    result=run(args.cmax,args.nmax)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(encoded(result),indent=2,sort_keys=True)+'\n')
    print(json.dumps({k:encoded(result[k]) for k in ['status','content_profiles','local_lifts',
        'primitive_triples','additional_signed_levels','ordered_check_digest']},indent=2))
if __name__=='__main__': main()
