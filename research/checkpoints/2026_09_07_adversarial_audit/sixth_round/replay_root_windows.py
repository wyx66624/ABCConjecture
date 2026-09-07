"""Exact finite tests of real root blocks and the layer-count proof."""
from argparse import ArgumentParser
from fractions import Fraction
from hashlib import sha256
from json import dumps
from math import gcd, isqrt
from pathlib import Path


def prime(p):return p>=2 and all(p%d for d in range(2,isqrt(p)+1))


def mul(v,w,mod=None):
    a,b=v;c,d=w
    out=a*c-b*d,a*d+b*c+b*d
    return out if mod is None else tuple(x%mod for x in out)


def power(v,n,mod=None):
    out=(1,0)
    while n:
        if n&1:out=mul(out,v,mod)
        v=mul(v,v,mod);n//=2
    return out


def norm(v):
    a,b=v;return a*a+a*b+b*b


def boundary(v):
    a,b=v;return a*b*(a+b)


def val(x,p):
    assert x
    e=0
    while x%p==0:e+=1;x//=p
    return e


def cap(p,upper):
    e=0;powerp=p
    while powerp<=upper:e+=1;powerp*=p
    return e


def main():
    parser=ArgumentParser()
    parser.add_argument('--check',action='store_true',
                        help='compare the canonical result without rewriting it')
    args=parser.parse_args()
    primes=[p for p in range(7,32) if prime(p)]
    rows=[];individual=0;lift_checks=0;layer_checks=0
    units=[(1,0),(-1,0),(0,1),(0,-1),(-1,1),(1,-1)]
    for n in [1,2,3,5,6,7,11,14,21]:
        for B in [1,4,9]:
            actual={}
            for k in range(B,2*B):
                w=(3*k,1);out=power(w,n)
                assert gcd(*out)==1 and norm(out)==norm(w)**n
                positive=[mul(out,u) for u in units if min(mul(out,u))>0]
                assert len(positive)==1
                a,b=positive[0]
                assert a+b>=(3*B)**n
                actual[k]=abs(boundary(out))
            for p in primes:
                lifting=val(n,p);m=n//p**lifting
                roots=[r for r in range(p)
                       if boundary(power((3*r,1),m,p))%p==0]
                assert len(roots)<=3*m
                for r in roots:
                    lifted=[r+j*p for j in range(p)
                            if boundary(power((3*(r+j*p),1),m,p*p))%(p*p)==0]
                    assert len(lifted)==1
                    lift_checks+=1
                depths=[]
                for k in range(B,2*B):
                    small=abs(boundary(power((3*k,1),m)))
                    assert small<=(6*B+1)**(3*m)
                    first=val(small,p);full=val(actual[k],p)
                    assert full==(first+lifting if first else 0)
                    depths.append(first);individual+=1
                H=cap(p,(6*B+1)**(3*m))
                assert max(depths)<=H
                for e in range(1,H+1):
                    count=sum(d>=e for d in depths)
                    assert count<=len(roots)*(Fraction(B,p**e)+1)
                    layer_checks+=1
                excess=sum(max(d-3,0) for d in depths)
                assert excess<=len(roots)*(Fraction(B,p**3*(p-1))+H)
                rows.append({'n':n,'B':B,'p':p,'m':m,'roots':len(roots),
                             'depth_cap':H,'first_depths':depths,
                             'first_positive_excess':excess})
    data={'status':'finite exact diagnostics, not a full prime-tail certificate',
          'rows':rows,'individual_rank_lifting_checks':individual,
          'simple_lift_checks':lift_checks,'actual_layer_checks':layer_checks}
    raw=(dumps(data,sort_keys=True,indent=2)+'\n').encode('utf-8')
    path=Path(__file__).parent/'verification'/'root_window_results.json'
    if args.check:
        assert path.read_bytes()==raw, 'canonical finite result differs'
    else:
        path.parent.mkdir(exist_ok=True);path.write_bytes(raw)
    print(dumps({'blocks':27,'prime_rows':len(rows),'individual':individual,
                 'simple_lifts':lift_checks,'layers':layer_checks,
                 'sha256':sha256(raw).hexdigest()}))


if __name__=='__main__':main()
