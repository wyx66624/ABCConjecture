from __future__ import annotations

import hashlib,json
from collections import defaultdict
from fractions import Fraction
from itertools import combinations,product
from math import gcd


def factor(n):
    z=n;p=2;out=[]
    while p*p<=z:
        if z%p==0:
            e=0
            while z%p==0:z//=p;e+=1
            out.append((p,e))
        p += 1 if p==2 else 2
    if z>1:out.append((z,1))
    return out

def rad(n):
    z=1
    for p,e in factor(n):z*=p
    return z
def pk(n):
    z=1
    for p,e in factor(n):
        if e>=2:z*=p**e
    return z
def phi(n):
    z=n
    for p,e in factor(n):z-=z//p
    return z
def divs(n):
    ds=[1]
    for p,e in factor(n):
        old=ds[:];q=1
        for _ in range(e):q*=p;ds += [x*q for x in old]
    return sorted(ds)
def prod3(x):return x[0]*x[1]*x[2]
def gcd3(a,b):return tuple(gcd(x,y) for x,y in zip(a,b))
def div3(a,b):return all(y%x==0 for x,y in zip(a,b))

def canon_line(points):
    (h0,k0),(h1,k1)=points[:2]
    dh,dk=h1-h0,k1-k0;q=gcd(abs(dh),abs(dk));s,t=dh//q,dk//q
    if s<0 or (s==0 and t<0):s,t=-s,-t
    z=t*h0-s*k0
    assert all(t*h-s*k==z for h,k in points)
    return s,t,z,q

def qterm(label,weight,coeff):
    cap=1
    for d,a in zip(label,coeff):cap*=gcd(d,abs(a))
    T=prod3(label)//cap
    return Fraction(weight,T*T),cap,T

def tail(kernel,N):
    for label in product(*(divs(x) for x in kernel)):
        if prod3(label)>N*N:
            yield label,phi(label[0])*phi(label[1])*phi(label[2])

def replay(B,M):
    C=B+1;R=rad(B*C);N=M-1;K=(B+1)*(C+1);c=K*N
    records=[];classes=defaultdict(list)
    for h,k in product(range(1,M+1),repeat=2):
        arms=(1+R*h,1+R*(h+C*k),1+R*(h+B*k))
        admissible=gcd(arms[0],k)==1
        if admissible:
            assert gcd(arms[0],arms[1])==gcd(arms[0],arms[2])==gcd(arms[1],arms[2])==1
        ker=tuple(pk(x) for x in arms)
        lhs=(R*rad(arms[0])*rad(arms[1])*rad(arms[2]))**4
        rhs=(C*arms[2])**3
        records.append({'point':(h,k),'admissible':admissible,'arms':arms,
                        'factorizations':[factor(x) for x in arms],'kernel':ker,
                        'exceptional':lhs<rhs})
        if admissible:classes[ker].append((h,k))

    fibres=defaultdict(lambda:{'n':0,'classes':[],'points':[],'w':0})
    Lt={}
    for ker,pts in classes.items():
        lt=0
        for label,w in tail(ker,N):
            lt+=w;f=fibres[label];f['n']+=len(pts);f['classes'].append(ker);f['points']+=pts;f['w']=w
        Lt[ker]=lt
    A0=sum(Lt.values());A1=sum((len(classes[k])-1)*Lt[k] for k in classes)
    W=sum(f['w'] for f in fibres.values());Omega=A0-W
    J=A1+Omega
    assert J==sum(f['w']*(f['n']-1) for f in fibres.values())
    Esh=sum(f['w']*(f['n']-1)**3 for f in fibres.values())

    actual={};actual_rows=[]
    for label,f in fibres.items():
        if f['n']<2:continue
        pts=sorted(set(f['points']));line=canon_line(pts);s,t=line[:2]
        coeff=(s,s+C*t,s+B*t)
        if not all(coeff):continue
        qv,cap,T=qterm(label,f['w'],coeff);actual[label]=qv
        actual_rows.append({'label':label,'weight':f['w'],'occupancy':f['n'],'points':pts,
                            'line':line[:3],'coeff':coeff,'capture':cap,'T':T,'q':str(qv)})
    S=sum(actual.values(),Fraction())
    Wnon=sum(fibres[x]['w'] for x in actual)
    Jnon=sum(fibres[x]['w']*(fibres[x]['n']-1) for x in actual)
    Enon=sum(fibres[x]['w']*(fibres[x]['n']-1)**3 for x in actual)

    edges={}
    def add(top,pts,kind,kernels):
        if prod3(top)<=N*N:return
        line=canon_line(pts);s,t=line[:2];coeff=(s,s+C*t,s+B*t)
        if not all(coeff):return
        key=(line[:3],top)
        if key not in edges:edges[key]={'top':top,'line':line[:3],'coeff':coeff,'generators':[],'kinds':set()}
        edges[key]['generators'].append((pts[0],pts[1],kernels));edges[key]['kinds'].add(kind)
    for ker,pts in classes.items():
        if len(pts)>=2:add(ker,pts[:2],'loop',(ker,))
    items=list(classes.items())
    for (ka,pa),(kb,pb) in combinations(items,2):add(gcd3(ka,kb),(pa[0],pb[0]),'pair',(ka,kb))
    es=list(edges.values())
    maximal=[e for e in es if not any(e['top']!=f['top'] and div3(e['top'],f['top']) for f in es)]

    H3=Fraction();union={};tops=[]
    for e in maximal:
        support=[k for k in classes if div3(e['top'],k)]
        rmu=sum(len(classes[k]) for k in support);Q=Fraction();cat=[]
        for label,w in tail(e['top'],N):
            qv,cap,T=qterm(label,w,e['coeff']);Q+=qv;union[label]=qv
            cat.append({'label':label,'D':prod3(label),'weight':w,'capture':cap,'T':T,'q':str(qv)})
        wmu=phi(e['top'][0])*phi(e['top'][1])*phi(e['top'][2]);beta=Q/wmu
        H3 += Q/(rmu-1)**3
        tops.append({'top':e['top'],'D':prod3(e['top']),'line':e['line'],'coeff':e['coeff'],
                     'coeff_factors':[factor(abs(x)) for x in e['coeff']],
                     'support_points':rmu,'support':[(k,classes[k]) for k in support],
                     'generators':e['generators'],'kinds':sorted(e['kinds']),
                     'weight':wmu,'Q':str(Q),'beta':str(beta),'catalogue':cat})
    assert union==actual
    assert S*S<=Enon*H3
    assert not S or S<c*H3
    assert not S or Enon<c*c*H3
    normalized=Fraction(c*c)*H3*W*W/(J**3) if J else None
    return {'parameters':{'B':B,'C':C,'R':R,'M':M,'N':N,'K':K,'c':c,
                          'factor_B':factor(B),'factor_C':factor(C),'factor_R':factor(R)},
            'all_box_points':records,
            'classes':[{'kernel':k,'points':v,'tail':Lt[k]} for k,v in sorted(classes.items())],
            'ledger':{'admissible_points':sum(x['admissible'] for x in records),'classes':len(classes),
                      'A0':A0,'A1':A1,'W':W,'Omega':Omega,'J':J,'Esh':Esh,
                      'W_non':Wnon,'J_non':Jnon,'E_non':Enon,'S_non':str(S)},
            'actual_nonarm_labels':actual_rows,
            'all_pair_maximal':{'raw_tops':len(edges),'maximal_tops':len(maximal),'tops':tops,
                                'H3':str(H3),'H3/W':str(H3/W),'H3/J':str(H3/J),
                                'normalized_c2H3_over_theta3W':str(normalized),
                                'S2_le_EnonH3':S*S<=Enon*H3,
                                'S_lt_cH3':S<c*H3,'Enon_lt_c2H3':Enon<c*c*H3}}

cases=[replay(351,2),replay(55123,3)]
assert cases[0]['ledger']=={'admissible_points':4,'classes':4,'A0':272,'A1':0,'W':248,
                            'Omega':24,'J':24,'Esh':24,'W_non':24,'J_non':24,
                            'E_non':24,'S_non':'24'}
assert cases[0]['all_pair_maximal']['tops'][0]['beta']=='6/5'
assert cases[1]['ledger']=={'admissible_points':8,'classes':4,'A0':93657366,'A1':0,'W':93602244,
                            'Omega':55122,'J':55122,'Esh':55122,'W_non':55122,'J_non':55122,
                            'E_non':55122,'S_non':'55122'}
assert cases[1]['all_pair_maximal']['tops'][0]['beta']=='9187/4200'
print(json.dumps({'status':'PASS','cases':cases},indent=2,default=str))
