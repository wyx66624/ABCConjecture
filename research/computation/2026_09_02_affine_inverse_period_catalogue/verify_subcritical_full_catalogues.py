#!/usr/bin/env python3
"""Exact optimized replay of a subcritical canonical T=1 cross-singleton fibre."""
import json
from itertools import product
from math import gcd

def factor(n):
 out={};p=2
 while p*p<=n:
  while n%p==0:out[p]=out.get(p,0)+1;n//=p
  p=3 if p==2 else p+2
 if n>1:out[n]=out.get(n,0)+1
 return out
def rad(n):
 r=1
 for p in factor(n):r*=p
 return r
def pk(n):
 r=1
 for p,e in factor(n).items():
  if e>=2:r*=p**e
 return r
def phi(n):
 r=n
 for p in factor(n):r-=r//p
 return r
def divs(n):
 out=[1]
 for p,e in factor(n).items():
  old=out[:];z=1
  for _ in range(e):z*=p;out += [z*x for x in old]
 return sorted(out)
def arms(B,C,R,p):
 h,k=p;return 1+R*h,1+R*(h+C*k),1+R*(h+B*k)
def tail(ker,T):
 out=[]
 for d in product(*(divs(x) for x in ker)):
  if d[0]*d[1]*d[2]>T:out.append((d,phi(d[0])*phi(d[1])*phi(d[2])))
 return out

B,C=8,9;R=rad(B*C);M=C**6//(4*R);N=M-1
lam=(137**2,173**2,1);D=lam[0]*lam[1]
assert (R,M,N,D,N*N)==(6,22143,22142,561737401,490268164)
# Exact fibre enumeration costs only 2*M tests: U divisibility first leaves two h values.
hs=[h for h in range(1,M+1) if (1+R*h)%lam[0]==0]
assert hs==[3128,21897]
fibre=[]
for h in hs:
 for k in range(1,M+1):
  vals=arms(B,C,R,(h,k))
  if vals[1]%lam[1]==0 and gcd(vals[0],k)==1:
   assert all(gcd(vals[i],vals[j])==1 for i,j in ((0,1),(0,2),(1,2)))
   fibre.append((h,k))
assert fibre==[(3128,10183),(21897,11423)]
rows=[arms(B,C,R,p) for p in fibre]
facts=[[sorted(factor(v).items()) for v in row] for row in rows]
kers=[tuple(pk(v) for v in row) for row in rows]
assert kers==[(18769,29929,1),(18769,748225,1)] and kers[0]!=kers[1]
# Any point in either exact kernel class lies in the lam fibre.  Since the
# fibre has two points with distinct kernels, both classes have multiplicity one.
s,t=fibre[1][0]-fibre[0][0],fibre[1][1]-fibre[0][1]
assert gcd(s,t)==1 and (s,t)==(18769,1240)
coeff=(s,s+C*t,s+B*t);assert coeff==(18769,29929,28689) and all(coeff)
caps=tuple(gcd(d,abs(a)) for d,a in zip(lam,coeff));assert caps==lam
capture=caps[0]*caps[1]*caps[2];period=D//capture;assert period==1
assert N*max(s,t)==415583198<capture
tails=[tail(k,N*N) for k in kers];Ls=[sum(w for _,w in z) for z in tails]
assert Ls==[554413792,13860344800]
union={};supp={}
for z in tails:
 for d,w in z:union[d]=w;supp[d]=supp.get(d,0)+1
assert len(union)==3 and supp[lam]==2 and all(n==1 for d,n in supp.items() if d!=lam)
W=sum(union.values());W1=sum(union[d] for d,n in supp.items() if n==1)
I=sum(union[d]*n for d,n in supp.items());E=sum(union[d]*n**3 for d,n in supp.items())
Esh=sum(union[d]*(n-1)**3 for d,n in supp.items());J=I-W;S=phi(lam[0])*phi(lam[1])
assert (W,W1,I,E,Esh,J,S)==(13860344800,13305931008,14414758592,17741241344,554413792,554413792,554413792)
assert E==W+7*Esh==I+6*Esh==W1+8*Esh
assert 1000*S>986*D and S*N>D and S*S*N>D*D
result={'parameters':{'B':B,'C':C,'R':R,'R_lt_C':R<C,'M':M,'N':N,'N2':N*N},
 'label':lam,'D':D,'fibre':fibre,'arms':rows,'factorizations':facts,'kernels':kers,
 'class_multiplicities':[1,1],'direction':[s,t],'coefficients':coeff,'capture':capture,'T':period,
 'weight':S,'weight_over_common_D':f'{S}/{D}','class_catalogues':tails,'class_tails':Ls,
 'W':W,'W1':W1,'I':I,'J':J,'E':E,'Esh':Esh,'S_non':S,
 'false':{'S_le_D_div_N':S*N<=D,'S_le_D_div_sqrtN':S*S*N<=D*D,'S_le_0.986_common_D':1000*S<=986*D,
          'S_charged_only_to_m_ge_2':S<=0}}
assert not any(result['false'].values())
print(json.dumps(result,indent=2));print('PASS: subcritical canonical B=8 T=1 cross-singleton fibre')
