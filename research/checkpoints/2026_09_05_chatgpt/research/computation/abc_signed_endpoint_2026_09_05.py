#!/usr/bin/env python3
"""Exact replay of the signed-endpoint supplement. No Lean execution is implied.

Uses only Python's standard library and the supplied previous-round engine.
All optimization and acceptance decisions use integers or rational numbers.
Prime-certificate generation used a separate discovery program; THIS verifier
uses no probable-prime oracle or factorization library.
"""
from __future__ import annotations
import argparse, hashlib, itertools, json, math
from fractions import Fraction
from pathlib import Path
import fcrt_unit_gap_2026_09_05 as prev

BASE_COMMIT = prev.BASE_COMMIT
require = prev.require
fj = prev.fraction_json

def fr(x: dict) -> Fraction:
    return Fraction(x['numerator'], x['denominator'])

class SignedPoint(prev.Point):
    """Positive target n=x+sign*y; sink packets retain their two arm labels."""
    def __init__(self, x: int, y: int, fx: dict, fy: dict, fn: dict, sign: int = 1):
        require(sign in (-1, 1), 'sign must be +1 or -1')
        self.sign = sign
        super().__init__(x, y, fx, fy, fn)
    @property
    def c(self) -> int:
        return self.a + self.sign * self.b
    def compatible(self, source_mask: int, sink_mask: int) -> bool:
        x, y, _ = self.packet(sink_mask)
        return (x + self.sign*y) % self.source_modulus(source_mask) == 0

def verify_prime_certificate(obj: dict) -> dict:
    """Full-factor Lucas order criterion; recursion strictly decreases n."""
    nodes = obj['nodes']; done: set[int] = set(); visiting: set[int] = set()
    modular_tests = 0
    def verify(n: int) -> None:
        nonlocal modular_tests
        if n in done:
            return
        require(n not in visiting and str(n) in nodes, 'cycle or missing node')
        visiting.add(n); node = nodes[str(n)]
        require(node['n'] == n, 'node value mismatch')
        if n == 2:
            require(node['factors'] == {} and node['witnesses'] == {}, 'base node')
        else:
            require(n > 2 and n % 2 == 1, 'nontrivial prime candidate must be odd')
            factors = {int(p): e for p, e in node['factors'].items()}
            require(factors and all(isinstance(e,int) and e >= 1 for e in factors.values()), 'exponents')
            require(math.prod(p**e for p,e in factors.items()) == n-1, 'n-1 factorization')
            require(set(node['witnesses']) == {str(p) for p in factors}, 'witness keys')
            for p in factors:
                require(2 <= p < n, 'strict induction')
                verify(p)
                a = node['witnesses'][str(p)]
                require(1 < a < n, 'base range')
                require(pow(a,n-1,n) == 1, 'Fermat congruence')
                require(math.gcd(pow(a,(n-1)//p,n)-1,n) == 1, 'order gcd')
                modular_tests += 1
        visiting.remove(n); done.add(n)
    verify(obj['root']); verify(13)
    require(len(done) == len(nodes), 'unverified extra nodes')
    return {'root': obj['root'], 'certified_primes': len(done), 'order_witness_checks': modular_tests,
            'all_checks_passed': True}

def loss_factors(point: SignedPoint, optimized: dict) -> dict:
    """Independently recompute U*S*O and the EXACT multiplicative loss identity."""
    cert = optimized['certificate']; blocks = cert['blocks']
    used_i = used_j = 0
    for s,t in blocks:
        require(s and t and not(s&used_i) and not(t&used_j), 'overlap')
        require(point.compatible(s,t), 'block congruence')
        require(point.source_product(s) <= point.packet(t)[2], 'saturation')
        used_i |= s; used_j |= t
    credits = {i: Fraction(1) for i in range(len(point.sources)) if not(used_i>>i&1)}
    owners = {int(j):i for j,i in cert['owners'].items()}
    for j,i in owners.items():
        require(not(used_j>>j&1) and i in credits, 'owner')
        credits[i] *= point.sinks[j]
    surplus = Fraction(1)
    for (s,t),flag in zip(blocks,cert['flags']):
        emitted = Fraction(1)
        if flag is not None:
            i = flag['target_index']; u = flag['witness_mask']; emitted = fr(flag['factor'])
            require(i in credits and 0 < u < t and u&t == u, 'proper face')
            require(point.compatible(1<<i,u), 'face congruence')
            require(emitted == min(Fraction(point.packet(t)[2],point.source_product(s)),
                                  Fraction(point.packet(u)[2])), 'cap')
            credits[i] *= emitted
        surplus *= Fraction(point.packet(t)[2],point.source_product(s)) / emitted
    unused = math.prod(q for j,q in enumerate(point.sinks) if not(used_j>>j&1) and j not in owners)
    overflow = math.prod((max(k/point.d[i],Fraction(1)) for i,k in credits.items()),start=Fraction(1))
    boundary = math.prod((max(Fraction(point.d[i])/k,Fraction(1)) for i,k in credits.items()),start=Fraction(1))
    require(unused >= 1 and surplus >= 1 and overflow >= 1, 'negative loss')
    require(boundary == fr(optimized['factor']), 'independent boundary mismatch')
    require(boundary == Fraction(point.c,point.radical)*unused*surplus*overflow,
            'exact loss identity failed')
    return {'unused':fj(unused),'discarded_surplus':fj(surplus),'overfill':fj(overflow)}

def optimum(point: SignedPoint) -> dict:
    obj = prev.optimize_exact(point,'FCRT')
    obj['exact_loss_factors'] = loss_factors(point,obj)
    return obj

def two_endpoint(a: int,b: int,fa: dict,fb: dict,fc: dict) -> dict:
    require(a <= b, 'normalized triple')
    c=a+b; pp=SignedPoint(a,b,fa,fb,fc); pm=SignedPoint(c,a,fc,fa,fb,-1)
    plus=optimum(pp); minus=optimum(pm)
    adapted=min(fr(plus['factor']),Fraction(c,b)*fr(minus['factor']))
    scalar=max(Fraction(c,pp.radical),Fraction(1))
    require(scalar <= adapted <= fr(plus['factor']), 'adaptive sandwich')
    return {'a':a,'b':b,'c':c,'R':pp.radical,'plus':plus,'minus':minus,
            'adaptive_factor':fj(adapted),'scalar_factor':fj(scalar),
            'adaptive_waste_factor':fj(adapted/scalar)}

def signed_deletion_scan(limit: int, spf: list[int]) -> dict:
    """Brute force checks both nonempty sides, especially the minus-sign trap."""
    checks = nonempty_identity_full = 0
    for n in range(2,limit+1):
        fn=prev.factor_spf(n,spf)
        for y in range(1,limit-n+1):
            x=n+y
            if math.gcd(x,y)!=1: continue
            pt=SignedPoint(x,y,prev.factor_spf(x,spf),prev.factor_spf(y,spf),fn,-1)
            for i in range(len(pt.sources)):
                mod=pt.moduli[i]
                for t in prev.submasks(pt.j_all):
                    faces=[u for u in prev.submasks(t) if u!=t and pt.compatible(1<<i,u)]
                    # For the signed difference, deletion target is Phi(T), but D=T MUST be excluded.
                    deletions=[d for d in prev.submasks(t) if d!=t and pt.label(i,d)==pt.label(i,t)]
                    require(bool(faces)==bool(deletions), 'signed deletion existence')
                    if faces:
                        require(max(pt.packet(u)[2] for u in faces)*min(pt.packet(d)[2] for d in deletions)
                                == pt.packet(t)[2], 'signed deletion optimum')
                    if pt.label(i,t)==1: nonempty_identity_full+=1
                    checks+=1
    return {'max_input_x':limit,'face_deletion_comparisons':checks,
            'full_identity_packets_requiring_empty_face_exclusion':nonempty_identity_full}

def minus_threshold_scan(limit: int, spf: list[int]) -> dict:
    cases=packets=0
    for n in range(2,limit+1):
        fn=prev.factor_spf(n,spf)
        mods=[(p,p**e) for p,e in fn.items() if e>=2 and
              n < p**e*((4*p**e+5) if p==3 else (2*p**e+3))]
        if not mods: continue
        powers=[p**e for p,e in prev.factor_spf(n+1,spf).items()]
        products=[1]
        for v in powers: products += [v*u for u in products]
        for p,m in mods:
            cases+=1
            for u in products:
                if 1<u<n+1:
                    require((u-1)%m != 0,'minus threshold counterexample')
                    packets+=1
    sharp=[]
    for p in (2,3,5,7,11,13):
        for e in range(2,7):
            m=p**e; k=4 if p==3 else 2
            n=m*(k*m+k+1);d=m+1;u=k*m+1
            require(d*u==n+1 and math.gcd(d,u)==1 and (u-1)%m==0,'sharpness')
            require(n%m==0 and n%(p*m)!=0,'exact source valuation')
            sharp.append({'p':p,'e':e,'M':m,'n':n,'factors_of_n_plus_one':[d,u]})
    return {'target_n_bound':limit,'eligible_target_modulus_pairs':cases,
            'proper_packets_checked':packets,'counterexamples':0,'sharp_examples':sharp}

def main() -> None:
    ap=argparse.ArgumentParser(description=__doc__)
    ap.add_argument('--output',type=Path,required=True)
    ap.add_argument('--certificate',type=Path,required=True)
    ap.add_argument('--triple-bound',type=int,default=3000)
    ap.add_argument('--endpoint-bound',type=int,default=1000000)
    ap.add_argument('--threshold-bound',type=int,default=200000)
    args=ap.parse_args()
    limit=max(args.triple_bound,args.endpoint_bound,args.threshold_bound+1,100)
    spf=prev.sieve_spf(limit);rad=[1]*(limit+1)
    for p in range(2,limit+1):
        if spf[p]==p:
            for k in range(p,limit+1,p):rad[k]*=p
    def fac(n: int) -> dict: return prev.factor_spf(n,spf)
    result={'base_commit':BASE_COMMIT,'scope':'Ordinary theorems and finite exact computations; no ABC proof and no Lean execution.',
            'prime_certificate':verify_prime_certificate(json.loads(args.certificate.read_text()))}
    result['difference_threshold']=minus_threshold_scan(args.threshold_bound,spf)
    result['signed_deletions']=signed_deletion_scan(100,spf)
    norm=0;rows=[]
    for c in range(2,args.triple_bound+1):
        for a in range(1,c//2+1):
            b=c-a
            if math.gcd(a,b)!=1:continue
            norm+=1;R=rad[a]*rad[b]*rad[c]
            if R>=b:continue
            rows.append(two_endpoint(a,b,fac(a),fac(b),fac(c)))
    result['normalized_scan']={'c_bound':args.triple_bound,'primitive_triples_filtered':norm,
      'hard_triples_R_lt_b_optimized':len(rows),'nonzero_adaptive_waste':sum(fr(r['adaptive_waste_factor'])>1 for r in rows),'rows':rows}
    consecutive=[]
    for c in range(3,args.endpoint_bound+1):
        b=c-1
        if rad[b]*rad[c] < b:
            consecutive.append(two_endpoint(1,b,{},fac(b),fac(c)))
    result['consecutive_scan']={'c_bound':args.endpoint_bound,'hard_triples_optimized':len(consecutive),
      'nonzero_adaptive_waste':sum(fr(r['adaptive_waste_factor'])>1 for r in consecutive),'rows':consecutive}
    q=3981112602195296746201614890054671463;c=2**64*3**41
    require(c-1==13**2*q,'large exact factorization')
    require(max(2**64,3**41)<2*min(2**64,3**41)-1,'balance')
    large=two_endpoint(1,c-1,{}, {13:2,q:1},{2:64,3:41})
    require(fr(large['plus']['factor'])==Fraction(2**63,13),'large plus optimum')
    require(fr(large['minus']['factor'])==Fraction(13,6),'large minus optimum')
    require(fr(large['adaptive_waste_factor'])==1,'large repair')
    large['original_waste_factor']=fj(fr(large['plus']['factor'])/fr(large['scalar_factor']))
    require(fr(large['original_waste_factor']) > 3*10**17, 'large loss magnitude')
    large['prime_q']=q;large['source_exponents']={'2':64,'3':41}
    result['large_repair']=large
    ce=two_endpoint(1,3024,{},fac(3024),fac(3025))
    require(fr(ce['plus']['factor'])==Fraction(11,7),'counterexample plus')
    require(fr(ce['minus']['factor'])==Fraction(8,5),'counterexample minus')
    require(fr(ce['adaptive_waste_factor'])==Fraction(6,5),'counterexample waste')
    result['noncollapse_witness']=ce
    result['program_sha256']=hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    result['engine_sha256']=hashlib.sha256(Path(prev.__file__).read_bytes()).hexdigest()
    result['certificate_sha256']=hashlib.sha256(args.certificate.read_bytes()).hexdigest()
    result['all_checks_passed']=True
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k in ('prime_certificate','signed_deletions','all_checks_passed')},indent=2))
    for k in ('normalized_scan','consecutive_scan'):
        print(k,{a:b for a,b in result[k].items() if a!='rows'})
    print('threshold',{a:b for a,b in result['difference_threshold'].items() if a!='sharp_examples'})
if __name__=='__main__': main()
