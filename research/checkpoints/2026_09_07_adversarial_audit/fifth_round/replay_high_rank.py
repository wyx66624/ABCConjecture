"""Exact actual homogeneous examples; no factorization of the whole boundary."""
from hashlib import sha256
from json import dumps
from math import gcd, isqrt
from pathlib import Path


def prime(n):
    return n>=2 and all(n%d for d in range(2,isqrt(n)+1))


def prime_factors(n):
    out=[]
    for d in range(2,isqrt(n)+1):
        if n%d==0:
            out.append(d)
            while n%d==0:
                n//=d
    if n>1:
        out.append(n)
    return out


def mul(v,w,mod=None):
    a,b=v;c,d=w
    z=(a*c-b*d,a*d+b*c+b*d)
    return z if mod is None else tuple(x%mod for x in z)


def power(w,n,mod=None):
    z=(1,0)
    while n:
        if n&1:z=mul(z,w,mod)
        w=mul(w,w,mod);n//=2
    return z


def boundary(z):
    a,b=z
    return a*b*(a+b)


def norm(z):
    a,b=z
    return a*a+a*b+b*b


def val(x,p):
    assert x
    e=0
    while x%p==0:e+=1;x//=p
    return e


def make(ell,s):
    p=6*ell+1
    while not prime(p):p+=6*ell
    factors=prime_factors(p-1)
    generator=next(x for x in range(2,p)
                   if all(pow(x,(p-1)//r,p)!=1 for r in factors))
    z=pow(generator,(p-1)//6,p);zb=(1-z)%p
    R=pow(generator,(p-1)//ell,p)
    assert (z*z-z+1)%p==0 and R!=1 and pow(R,ell,p)==1
    a0=(R*zb-z)*pow(1-R,-1,p)%p
    assert norm((a0,1))%p!=0
    assert ((a0+z)*pow(a0+zb,-1,p))%p==R
    ratio3=pow(R,3,p)
    assert pow(ratio3,ell,p)==1 and ratio3!=1
    root,mod=a0,p
    for _ in range(1,s):
        lifts=[root+j*mod for j in range(p)
               if boundary(power((root+j*mod,1),ell,mod*p))%(mod*p)==0]
        assert len(lifts)==1
        root,mod=lifts[0],mod*p
    j=next(j for j in [1,2]
           if boundary(power((root+j*mod,1),ell,mod*p))%(mod*p)!=0)
    A=root+j*mod
    a=next(A+k*mod*p for k in range(3) if (A+k*mod*p)%3==0)
    assert p**s<=a<3*p**(s+1)
    w=(a,1);Q=norm(w)
    assert gcd(Q,3*p)==1
    out=power(w,ell)
    assert gcd(*out)==1 and norm(out)==Q**ell
    assert val(abs(boundary(out)),p)==s
    assert all(boundary(power(w,k,p))%p for k in range(1,ell))
    units=[(1,0),(-1,0),(0,1),(0,-1),(-1,1),(1,-1)]
    positive=[mul(out,u) for u in units
              if min(mul(out,u))>0]
    assert len(positive)==1
    aa,bb=positive[0]
    assert gcd(aa,bb)==1
    assert abs(boundary(out))==aa*bb*(aa+bb)
    assert p>ell and Q>=p**(2*s)
    return {'g':ell,'p':p,'s':s,'a':str(a),'Q':str(Q),
            'positive_seed':[str(aa),str(bb)],
            'exact_rank':ell,'exact_first_depth':s,
            'marked_totient_mass_at_least':ell-1,
            'whole_net_signed_packet':'not factored or claimed'}


def main():
    rows=[make(ell,s) for ell in [5,7,11,13,17,19,23] for s in [4,7]]
    data={'status':'finite exact replay supplements the ordinary infinite construction',
          'rows':rows}
    raw=(dumps(data,sort_keys=True,indent=2)+'\n').encode('utf-8')
    path=Path(__file__).parent/'verification'/'high_rank_results.json'
    path.parent.mkdir(exist_ok=True)
    path.write_bytes(raw)
    print(dumps({'rows':len(rows),'sha256':sha256(raw).hexdigest()}))


if __name__=='__main__':main()
