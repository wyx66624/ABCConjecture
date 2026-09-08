"""Exact leading-digit audit plus PARI source-transport congruences.

The mod-25 height proof uses the sigma integrality theorem stated in the
ordinary note, not PARI heights. Full precision rows remain PARI evidence.
"""
from __future__ import annotations
import argparse
import ast
from fractions import Fraction as F
import hashlib
import json
from math import isqrt
import os
from pathlib import Path
import subprocess

HERE = Path(__file__).resolve().parent
DEST = HERE / "verification" / "height_transport.json"


def add(P, Q, a):
    if P is None: return Q
    if Q is None: return P
    x,y=P; u,v=Q
    if x==u and y+v==0: return None
    m=F(3*x*x+a,2*y) if P==Q else F(v-y,u-x)
    z=m*m-x-u
    return z,m*(x-z)-y


def mul(P,n,a):
    R=None
    while n:
        if n&1: R=add(R,P,a)
        P=add(P,P,a); n//=2
    return R


def residue(x,m):
    x=F(x)
    return x.numerator*pow(x.denominator,-1,m)%m


def vp(x):
    x=F(x)
    if not x: return 10**9
    n,d=abs(x.numerator),x.denominator; v=0
    while n%5==0: n//=5; v+=1
    while d%5==0: d//=5; v-=1
    return v


def ball(z):
    v,ap,u=z
    assert ap>v and u%5 and 0<=u<5**(ap-v)
    return F(u)*F(5)**v


def exact_leading():
    rows=[]
    for a,b,P in [(-9,-9,(-2,1)),(-189,999,(6,9))]:
        x,y=mul(tuple(map(F,P)),9,a)
        assert y*y==x**3+a*x+b
        d=isqrt(x.denominator)
        assert d*d==x.denominator and y.denominator==d**3
        A=x.numerator; B=y.numerator
        assert all((d%p==0 or (2*residue(y,p))%p or
                    (3*residue(x,p)**2+a)%p) for p in [2,3])
        t=-x/y
        assert vp(t)==1
        q=-F(A,B)  # t/d, a 5-adic unit
        assert vp(q)==0
        # log(q)=(q^4-1)/4 mod25, with all omitted terms in25Z5.
        logq=(pow(residue(q,25),4,25)-1)*pow(4,-1,25)%25
        h=-2*logq*pow(81,-1,25)%25
        assert h in [5,10,15,20]
        rows.append(dict(curve=[a,b],nine_point=[[z.numerator,z.denominator] for z in [x,y]],
                         sigma_argument_unit_mod25=residue(q,25),
                         log_unit_mod25=logq,height_mod25=h,
                         height_div5_mod5=h//5,
                         naive_minus_intrinsic_mod25=(pow(2,-1,25)-1)*h%25))
    assert [r["height_div5_mod5"] for r in rows]==[1,2]
    return rows


def main():
    ap=argparse.ArgumentParser(); ap.add_argument("--check",action="store_true")
    args=ap.parse_args(); source=HERE/"replay_height_transport.gp"
    cmd=(["wsl.exe","-d","Ubuntu-24.04","--","/usr/bin/gp","-q","-f"]
         if os.name=="nt" else ["/usr/bin/gp","-q","-f"])
    proc=subprocess.run(cmd,input=source.read_text(),text=True,capture_output=True,
                        timeout=120,check=True)
    if proc.stderr.strip(): raise RuntimeError(proc.stderr)
    rows=[ast.literal_eval(z) for z in proc.stdout.splitlines() if z.strip()]
    assert len(rows)==5 and rows[-1]==[99,1]
    exact=exact_leading()
    for z in rows[:-1]:
        j,n,ch,aa,bb,ss,tt,ll,mm=z
        u,r,_,_=ch; a,b=map(ball,aa); A,B=map(ball,bb)
        s,t,L,M=map(ball,[ss,tt,ll,mm])
        precision=min(v[1] for v in aa+bb+[ss,tt,ll,mm])
        assert precision>=n
        errors=[A-(a+r*b)/u,B-u*b,t-(u*u*s-r),M-L/u,
                u*A-(r+s)*B/u-(a-s*b)]
        assert all(vp(e)>=precision for e in errors)
        h=a-s*b
        assert residue(h,25)==exact[j-1]["height_mod25"]
        naive=A-t*B
        assert residue(naive-h,25)==exact[j-1]["naive_minus_intrinsic_mod25"]
        assert vp(naive-h)==1
        assert vp(h/(M*M)-4*h/(L*L))>=precision-2
    # Independent exact inverse matrix arithmetic, with u=2 and both r.
    for r in [9,-33]:
        T=[[F(1,2),F(r,2)],[F(0),F(2)]]
        U=[[F(2),F(-r,2)],[F(0),F(1,2)]]
        assert [[sum(U[i][k]*T[k][j] for k in range(2)) for j in range(2)]
                for i in range(2)]==[[1,0],[0,1]]
    data=dict(schema=1,pari_version="2.15.4",scope="exact mod25 leading proof and source-aware finite p-adic congruences; not QC zeros",
              gp_sha256=hashlib.sha256(source.read_bytes()).hexdigest(),
              exact_leading=exact,rows=rows[:-1],
              checks=["source vector transform","unit-root slope transport","log differential transport",
                      "inverse transform recovers minimal scalar","independent sigma-integrality leading digit",
                      "naive scalar discrepancy has exact valuation one","BD alpha scale four"])
    raw=(json.dumps(data,sort_keys=True,indent=2)+"\n").encode()
    if args.check: assert DEST.read_bytes()==raw,"certificate changed"
    else:
        DEST.parent.mkdir(parents=True,exist_ok=True); DEST.write_bytes(raw)
    print("PASS",hashlib.sha256(raw).hexdigest())


if __name__=="__main__": main()
