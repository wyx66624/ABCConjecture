from pathlib import Path
from fractions import Fraction as F
import json, hashlib
import argparse

def trim(a):
    while len(a)>1 and a[-1]==0: a.pop()
    return a

def add(a,b):
    c=[0]*max(len(a),len(b))
    for i,v in enumerate(a): c[i]+=v
    for i,v in enumerate(b): c[i]+=v
    return trim(c)

def scale(a,c): return trim([x*c for x in a])
def sub(a,b): return add(a,scale(b,-1))
def mul(a,b):
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b): c[i+j]+=x*y
    return trim(c)
def power(a,n):
    r=[1]
    for _ in range(n): r=mul(r,a)
    return r

def total(*xs):
    r=[0]
    for x in xs:r=add(r,x)
    return r

checks=[]
def eq(name,a,b):
    assert trim(a)==trim(b),(name,a,b)
    checks.append({'identity':name,'cleared_difference':[0]})
x=[0,1]; h=[2,1]; f=[-9,-9,0,1]
H=add(f,scale(power(h,2),18)); R=sub(f,scale(power(h,2),108))
J=scale(mul(x,h),6); d=[9,4]
eq('SS6 H^2-fR=J^2d',sub(power(H,2),mul(f,R)),mul(power(J,2),d))
z=[3,1]; N=total(mul(x,power(z,2)),scale(z,36),[-36])
Dp=total(power(z,3),scale(z,-36),[72])
eq('SS17 cleared 3-isogeny',mul(f,power(Dp,2)),total(power(N,3),scale(mul(N,power(z,4)),-189),scale(power(z,6),999)))
s=[0,1]; sp=[1,1]; sm=[-1,1]; xd=power(sp,2)
X=[-2,-5,-2]; hn=add(X,scale(xd,2)); A0=[-1,-3,0,1]; B0=[0,3,3]; B=add(A0,B0)
eq('SS5 kappa^2=4X+9',power(sm,2),add(scale(X,4),scale(xd,9)))
eq('SS5 B0 normalized=-3h',B0,scale(mul(hn,sp),-3))
eq('SS5 gamma normalized',scale(B,2),total(scale(mul(X,sm),-1),scale(mul(hn,sp),-3)))
eq('SS5 first quotient Y^2=f',mul(A0,B),total(power(X,3),scale(mul(X,power(xd,2)),-9),scale(power(xd,3),-9)))
Hn=total(power(X,3),scale(mul(power(X,2),xd),18),scale(mul(X,power(xd,2)),63),scale(power(xd,3),63))
eq('SS5 second quotient Z^2=H+Jkappa',mul(B,add(A0,scale(B0,4))),add(Hn,scale(mul(mul(mul(X,hn),sm),sp),6)))
eq('SS11 normalized factorization',power(sub(mul(A0,B),mul(B,add(A0,scale(B0,4)))),2),scale(mul(mul(power(hn,2),power(sp,2)),add(scale(mul(A0,B),3),mul(B,add(A0,scale(B0,4))))),36))

def plus(P,Q,a):
    if P is None:return Q
    if Q is None:return P
    x,y=P;u,v=Q
    if x==u and y==-v:return None
    m=(3*x*x+a)/(2*y) if P==Q else (v-y)/(u-x)
    xx=m*m-x-u
    return xx,m*(x-xx)-y
P=(F(6),F(9)); P2=plus(P,P,F(-189)); P3=plus(P2,P,F(-189))
assert P2==(F(33,4),F(9,8)) and P3==(F(-2),F(-37))
Q=(F(-2),F(1)); xx,yy=Q
phi=(xx+36/(xx+3)-36/(xx+3)**2,yy*(1-36/(xx+3)**2+72/(xx+3)**3))
assert phi==(P3[0],-P3[1])
result={'reviewer':'adversarial_audit','status':'PASS','polynomial_identity_count':len(checks),'polynomial_identities':checks,'exact_group_law_checks':3,'group_law_results':{'2P':[str(v) for v in P2],'3P':[str(v) for v in P3],'phi_Q':[str(v) for v in phi]},'scope':'Independent stdlib integer polynomial coefficient equalities and rational group-law checks only. Not rational-point completeness, geometry or Lean verification.'}
p=Path(__file__).parent/'verification/elliptic_gate_identity_review.json'
parser=argparse.ArgumentParser(description='Exact finite elliptic-gate identity replay')
parser.add_argument('--check',action='store_true',help='Compare canonical bytes without rewriting')
args=parser.parse_args()
canonical=(json.dumps(result,indent=2)+'\n').encode()
if args.check:
    if p.read_bytes()!=canonical:
        raise SystemExit('FAIL: canonical certificate differs')
else:
    p.parent.mkdir(exist_ok=True)
    p.write_bytes(canonical)
print(json.dumps({'status':'PASS','polynomial_identities':len(checks),'group_law_checks':3,'sha256':hashlib.sha256(p.read_bytes()).hexdigest()}))
