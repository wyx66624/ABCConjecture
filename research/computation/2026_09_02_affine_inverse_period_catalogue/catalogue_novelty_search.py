from __future__ import annotations

from collections import Counter, defaultdict
from fractions import Fraction
from itertools import product, combinations
from math import gcd
import json


def factor(n):
    z=n; p=2; out=[]
    while p*p<=z:
        if z%p==0:
            e=0
            while z%p==0: z//=p; e+=1
            out.append((p,e))
        p += 1 if p==2 else 2
    if z>1: out.append((z,1))
    return out

def rad(n):
    r=1
    for p,e in factor(n): r*=p
    return r

def pk(n):
    r=1
    for p,e in factor(n):
        if e>=2: r*=p**e
    return r

def phi(n):
    r=n
    for p,e in factor(n): r-=r//p
    return r

def divs(n):
    ds=[1]
    for p,e in factor(n):
        old=ds[:]; q=1
        for j in range(1,e+1):
            q*=p; ds += [x*q for x in old]
    return sorted(ds)

def primdir(ps):
    p0,p1=ps[0],ps[1]
    dx,dy=p1[0]-p0[0],p1[1]-p0[1]
    g=gcd(abs(dx),abs(dy)); s,t=dx//g,dy//g
    for x,y in ps:
        assert (x-p0[0])*t==(y-p0[1])*s
    return s,t,max(abs(s),abs(t))

def rho(n):
    z=Fraction(1)
    for p,e in factor(n): z*=Fraction(p+1,p)
    return z

def full_inverse_mass(kernel, coeff):
    # exact full divisor catalogue sum of w/T^2
    ans=Fraction(1)
    for k,a in zip(kernel,coeff):
        local=Fraction(0)
        for d in divs(k):
            local += Fraction(phi(d)*gcd(d,abs(a))**2,d*d)
        ans*=local
    return ans

def threshold_inverse_mass(kernel, coeff, nside):
    ans=Fraction(0); count=0
    for lab in product(*(divs(k) for k in kernel)):
        if lab[0]*lab[1]*lab[2] <= nside*nside: continue
        w=phi(lab[0])*phi(lab[1])*phi(lab[2])
        cap=1
        for d,a in zip(lab,coeff): cap*=gcd(d,abs(a))
        T=(lab[0]*lab[1]*lab[2])//cap
        ans += Fraction(w,T*T); count+=1
    return ans,count

def build(b,m,selection='all'):
    c=b+1; R=rad(b*c); nside=m-1
    classes=defaultdict(list); arms={}
    exceptional=0
    for h,k in product(range(1,m+1),repeat=2):
        u=1+R*h; v=1+R*(h+c*k); w=1+R*(h+b*k)
        if gcd(u,k)!=1: continue
        assert gcd(u,v)==gcd(u,w)==gcd(v,w)==1
        is_exc=(R*rad(u)*rad(v)*rad(w))**4 < (c*w)**3
        if is_exc: exceptional+=1
        if selection=='exceptional' and not is_exc: continue
        ker=(pk(u),pk(v),pk(w)); classes[ker].append((h,k)); arms[(h,k)]=(u,v,w)

    fibres=defaultdict(lambda: {'n':0,'classes':[],'points':[]})
    Lt={}
    for ker,ps in classes.items():
        lt=0
        for lab in product(*(divs(x) for x in ker)):
            D=lab[0]*lab[1]*lab[2]
            if D<=nside*nside: continue
            ww=phi(lab[0])*phi(lab[1])*phi(lab[2]); lt+=ww
            q=fibres[lab];q['n']+=len(ps);q['classes'].append(ker);q['points']+=ps
        Lt[ker]=lt

    A=sum(x*y*z for x,y,z in classes)
    A1=sum(x*y*z for (x,y,z),ps in classes.items() if len(ps)==1)
    L1=sum(Lt[k] for k,ps in classes.items() if len(ps)==1)
    I=sum(len(classes[k])*Lt[k] for k in classes)
    class_tail_total=sum(Lt.values())
    class_pressure=sum((len(classes[k])**3-len(classes[k]))*Lt[k] for k in classes)
    W=W1=Wrep=E=Esh=0
    S=Fraction(0); Sn=0; details=[]
    for lab,q in fibres.items():
        ww=phi(lab[0])*phi(lab[1])*phi(lab[2]); n=q['n']; a=n-1
        W+=ww; E+=ww*n**3; Esh+=ww*a**3
        if n==1: W1+=ww
        else:
            Wrep+=ww
            ps=sorted(set(q['points'])); s,t,L=primdir(ps)
            coeff=(s,s+c*t,s+b*t)
            if all(coeff):
                cap=1
                for d,x in zip(lab,coeff): cap*=gcd(d,abs(x))
                T=(lab[0]*lab[1]*lab[2])//cap
                S+=Fraction(ww,T*T);Sn+=1
                details.append((Fraction(ww,T*T),lab,n,ww,T,(s,t),tuple(q['classes'])))
    assert I==sum(phi(a)*phi(b0)*phi(c0)*q['n'] for (a,b0,c0),q in fibres.items())
    assert W==W1+Wrep
    assert W1<=L1<=A1
    assert E<=W1+8*Esh<=A1+8*Esh
    assert E<=I+6*Esh
    assert class_pressure<=E-I<=6*Esh
    assert S<=Wrep and 2*Wrep<=I

    # support skeleton: loops on repeated classes, pairs only among singleton classes
    cover=Fraction(0); cover_full=Fraction(0); cover_rho=Fraction(0); cover_shape=Fraction(0); cover_terms=[]
    for ker,ps in classes.items():
        if len(ps)<2 or ker[0]*ker[1]*ker[2]<=nside*nside: continue
        s,t,L=primdir(ps); coeff=(s,s+c*t,s+b*t)
        if not all(coeff): continue
        ex,cnt=threshold_inverse_mass(ker,coeff,nside)
        fu=full_inverse_mass(ker,coeff)
        cap=1
        for kk,aa in zip(ker,coeff): cap*=gcd(kk,abs(aa))
        pr=abs(coeff[0]*coeff[1]*coeff[2]); rr=rho(ker[0]*ker[1]*ker[2])
        assert fu<=cap*rr<=pr*rr<=(b+1)*(c+1)*L**3*rr
        cover+=ex;cover_full+=fu;cover_rho+=cap*rr;cover_shape+=(b+1)*(c+1)*L**3*rr
        cover_terms.append(('loop',ker,len(ps),(s,t),ex,fu,cap*rr))
    singles=[(ker,ps[0]) for ker,ps in classes.items() if len(ps)==1]
    for (ka,pa),(kb,pb) in combinations(singles,2):
        g=tuple(gcd(x,y) for x,y in zip(ka,kb))
        if g[0]*g[1]*g[2]<=nside*nside: continue
        s,t,L=primdir([pa,pb]);coeff=(s,s+c*t,s+b*t)
        if not all(coeff): continue
        ex,cnt=threshold_inverse_mass(g,coeff,nside)
        fu=full_inverse_mass(g,coeff)
        cap=1
        for kk,aa in zip(g,coeff): cap*=gcd(kk,abs(aa))
        pr=abs(coeff[0]*coeff[1]*coeff[2]); rr=rho(g[0]*g[1]*g[2])
        assert fu<=cap*rr<=pr*rr<=(b+1)*(c+1)*L**3*rr
        cover+=ex;cover_full+=fu;cover_rho+=cap*rr;cover_shape+=(b+1)*(c+1)*L**3*rr
        cover_terms.append(('pair',g,2,(s,t),ex,fu,cap*rr))
    assert S<=cover<=cover_full<=cover_rho<=cover_shape

    details.sort(reverse=True)
    return {
      'B':b,'C':c,'R':R,'M':m,'N':nside,'selection':selection,
      'admissible_selected':sum(map(len,classes.values())),'exceptional_in_full':exceptional,
      'classes':len(classes),'class_hist':dict(sorted(Counter(map(len,classes.values())).items())),
      'singleton_classes':sum(len(ps)==1 for ps in classes.values()),
      'multi_classes':sum(len(ps)>=2 for ps in classes.values()),
      'large_labels':len(fibres),'repeated_labels':sum(q['n']>=2 for q in fibres.values()),
      'sumD':A,'sumD_singleton_classes':A1,'sumLT_singleton_classes':L1,
      'sum_class_tails':class_tail_total,'class_pressure':class_pressure,
      'W':W,'W1':W1,'Wrep':Wrep,'I':I,'E':E,'Esh':Esh,
      'E_minus_I':E-I,
      'S_non':str(S),'nonarm_labels':Sn,
      'support_cover_exact':str(cover),'support_cover_full':str(cover_full),
      'support_cover_capture_rho':str(cover_rho),'support_cover_shape_rho':str(cover_shape),
      'support_terms':len(cover_terms),
      'ratios':{
        'W1/A1':str(Fraction(W1,A1)) if A1 else None,
        'S/A':str(S/A) if A else None,
        'S/Wrep':str(S/Wrep) if Wrep else None,
        '2S/I':str(2*S/I) if I else None,
        'S/cover':str(S/cover) if cover else None,
        'cover/A':str(cover/A) if A else None,
      },
      'top_nonarm':[(str(x[0]),x[1],x[2],x[3],x[4],x[5]) for x in details[:5]],
      'top_cover':[(x[0],x[1],x[2],x[3],str(x[4]),str(x[5]),str(x[6])) for x in sorted(cover_terms,key=lambda z:z[4],reverse=True)[:5]],
      '_classes':classes,'_Lt':Lt,'_fibres':fibres,
    }

def clean(x): return {k:v for k,v in x.items() if not k.startswith('_')}

if __name__=='__main__':
    cases=[]
    for b,m in [(1,8),(1,10),(2,10),(2,30),(3,30),(3,80),(3,170),(4,30),(4,100),(4,200),(4,390),(5,100),(5,200),(5,388),(6,100),(7,100),(8,100)]:
        print('RUN',b,m,flush=True)
        cases.append(clean(build(b,m)))
    print(json.dumps(cases,indent=2,default=str))
