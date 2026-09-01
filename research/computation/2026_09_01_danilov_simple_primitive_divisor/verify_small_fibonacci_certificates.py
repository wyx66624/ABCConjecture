#!/usr/bin/env python3
import csv,json,math,sys

def factor(n):
 d={}; x=abs(n); p=2
 while p*p<=x:
  while x%p==0:d[p]=d.get(p,0)+1;x//=p
  p=3 if p==2 else p+2
 if x>1:d[x]=d.get(x,0)+1
 return d

def fib(n,m):
 a,b=0,1
 # independent left-to-right matrix-free doubling
 for bit in bin(n)[2:]:
  c=(a*((2*b-a)%m))%m; d=(a*a+b*b)%m
  if bit=='0':a,b=c,d
  else:a,b=d,(c+d)%m
 return a

def prime_factors(n):return list(factor(n))
base='research/computation/2026_09_01_danilov_simple_primitive_divisor'
summary=json.load(open(base+'/small_fibonacci_search_summary.json'))
rows=list(csv.DictReader(open(base+'/small_fibonacci_certificates.csv',newline='',encoding='utf-8')))
assert len(rows)==summary['certified_count']==207
eligible=[]
for Q in range(1,summary['q_max']+1):
 if math.gcd(Q,30)==1 and all(e==1 for e in factor(Q).values()):eligible.append(Q)
assert len(eligible)==summary['eligible_Q_count']==252
certQ=[]
for row in rows:
 Q=int(row['Q']);n=int(row['n']);p=int(row['simple_primitive_p']);c=int(row['F_n_over_p_mod_p']);b=int(row['trial_division_bound'])
 assert n==10*Q and p<=summary['p_max'] and p%n==1
 pf=factor(p); assert pf=={p:1} and b==math.isqrt(p)
 assert fib(n,p)==0
 assert all(fib(n//r,p)!=0 for r in prime_factors(n))
 x=fib(n,p*p); assert x%p==0 and x%(p*p)!=0 and (x//p)%p==c
 certQ.append(Q)
unres=sorted(set(eligible)-set(certQ)); assert unres==summary['unresolved_Q']
out={'status':'PASS','certificates_verified':len(rows),'eligible_Q':len(eligible),'unresolved_Q':unres,'scope':'verifies every saved primality/rank/valuation-one certificate and the eligible-Q partition; exhaustive p<=p_max enumeration is replayed by the generator'}
print(json.dumps(out,indent=2))
