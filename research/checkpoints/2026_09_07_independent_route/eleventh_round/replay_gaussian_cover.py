"""Exact supplemental GE/BK checks; not a proof of the geometric theorems."""
from pathlib import Path
from math import gcd, isqrt
import argparse
import hashlib
import itertools
import json

# K=Q(alpha), alpha^4-alpha^2+1=0, alpha=exp(-pi*i/6).
ZERO=(0,0,0,0)
ONE=(1,0,0,0)
ALPHA=(0,1,0,0)
def add(x,y): return tuple(a+b for a,b in zip(x,y))
def neg(x): return tuple(-a for a in x)
def sub(x,y): return add(x,neg(y))
def scale(x,k): return tuple(k*a for a in x)
def mul(x,y):
    z=[0]*7
    for i,a in enumerate(x):
        for j,b in enumerate(y): z[i+j]+=a*b
    for k in range(6,3,-1):
        z[k-2]+=z[k]; z[k-4]-=z[k]
    return tuple(z[:4])
def power(x,n):
    out=ONE
    for _ in range(n): out=mul(out,x)
    return out
def padd(x,y):
    n=max(len(x),len(y))
    return [add(x[k] if k<len(x) else ZERO,y[k] if k<len(y) else ZERO) for k in range(n)]
def pmul(x,y):
    out=[ZERO]*(len(x)+len(y)-1)
    for i,a in enumerate(x):
        for j,b in enumerate(y):out[i+j]=add(out[i+j],mul(a,b))
    return out
def ps(x,a):return [mul(c,a) for c in x]
def determinant(mat):
    n=len(mat); out=ZERO
    for perm in itertools.permutations(range(n)):
        term=ONE
        for i,j in enumerate(perm):term=mul(term,mat[i][j])
        parity=sum(perm[i]>perm[j] for i in range(n) for j in range(i+1,n))%2
        out=add(out,neg(term) if parity else term)
    return out
def resultant_quadratics(f,g):
    c,b,a=f;z,y,x=g
    return determinant([[a,b,c,ZERO],[ZERO,a,b,c],[x,y,z,ZERO],[ZERO,x,y,z]])
def factor(n):
    out=[];p=2
    while p*p<=n:
        if n%p==0:
            e=0
            while n%p==0:n//=p;e+=1
            out.append([p,e])
        p+=1
    if n>1:out.append([n,1])
    return out

def generate():
    abar=sub(ALPHA,power(ALPHA,3));ii=neg(power(ALPHA,3))
    zeta=sub(ONE,power(ALPHA,2))
    assert mul(ALPHA,abar)==ONE and power(ii,2)==neg(ONE)
    assert power(abar,2)==zeta
    U=[ONE,ONE,ONE];c=[ZERO,scale(ONE,2),ONE]
    A=pmul([neg(ONE),ZERO,ONE],[ONE,scale(ONE,2)])
    E=padd(A,ps(pmul(U,U),zeta))
    Eb=padd(A,ps(pmul(U,U),power(ALPHA,2)))
    G=padd(A,ps(pmul(U,c),ii))
    Gb=padd(A,ps(pmul(U,c),neg(ii)))
    roots=[ALPHA,neg(ALPHA),abar,neg(abar)]
    Bs=[padd(c,ps(U,neg(s))) for s in roots]
    assert pmul(Bs[0],Bs[1])==E
    assert pmul(Bs[2],Bs[3])==Eb
    assert pmul(Bs[0],Bs[3])==G
    assert pmul(Bs[1],Bs[2])==Gb
    assert pmul(E,Eb)==pmul(G,Gb)
    discriminants=[]
    for B,s in zip(Bs,roots):
        c0,b0,a0=B
        disc=sub(power(b0,2),scale(mul(a0,c0),4))
        expected=sub(scale(ONE,4),scale(power(s,2),3))
        assert disc==expected and disc!=ZERO and a0!=ZERO
        discriminants.append(list(disc))
    assert mul(discriminants[0],discriminants[2])==scale(ONE,13)
    resultants=[]
    for j,k in itertools.combinations(range(4),2):
        res=resultant_quadratics(Bs[j],Bs[k]);assert res!=ZERO
        resultants.append({'pair':[j+1,k+1],'value':res})
    kernels=[]
    for g in range(2,121):
        ker=[[u,v] for u in range(g) for v in range(g)
             if (u+v)%g==0 and (u-v)%g==0]
        assert len(ker)==gcd(g,2)
        kernels.append({'g':g,'kernel':ker})
    seeds=[]
    for a in range(1,301):
        for b in range(a,301):
            if gcd(a,b)!=1:continue
            M=a*a+a*b+b*b;u=isqrt(M)
            if u*u!=M:continue
            cc=a+b;aa=a*b;F=M*M+aa*cc*cc
            assert F==aa*aa+(u*cc)**2==u**4-u*u*cc*cc+cc**4
            assert (a-b)**2==4*u*u-3*cc*cc and gcd(aa,u*cc)==1
            fac=factor(F);assert all(p%12==1 for p,_ in fac)
            seeds.append({'a':a,'b':b,'U':u,'c':cc,'F':F,'factorization':fac})
    inverse=0
    for cc in range(1,601):
        for u in range(1,cc):
            if gcd(u,cc)!=1:continue
            s=4*u*u-3*cc*cc
            if s<0:continue
            d=isqrt(s)
            if d*d!=s or d>=cc:continue
            assert (cc+d)%2==0
            a=(cc+d)//2;b=(cc-d)//2
            assert a>0 and b>0 and gcd(a,b)==1 and a*a+a*b+b*b==u*u
            inverse+=1
    return {'status':'PASS','coefficient_field':'alpha^4-alpha^2+1',
            'discriminants':discriminants,'pair_resultants':resultants,
            'relation_kernel_rows':kernels,'actual_square_first_seeds':seeds,
            'inverse_rows':inverse,
            'scope':'Exact polynomial identities, bounded group relations and actual integer examples; no rational-point completeness or ABC proof.'}

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--check',action='store_true');args=parser.parse_args()
    path=Path(__file__).with_name('gaussian_cover_replay.json')
    data=generate();raw=(json.dumps(data,ensure_ascii=False,sort_keys=True,indent=2)+'\n').encode('utf-8')
    if args.check:
        if path.read_bytes()!=raw:raise SystemExit('FAIL: canonical artifact mismatch')
    else:path.write_bytes(raw)
    print(json.dumps({'status':'PASS','sha256':hashlib.sha256(raw).hexdigest(),
                     'kernel_rows':len(data['relation_kernel_rows']),
                     'seed_rows':len(data['actual_square_first_seeds']),
                     'inverse_rows':data['inverse_rows']}))
if __name__=='__main__':main()
