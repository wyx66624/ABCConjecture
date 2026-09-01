#!/usr/bin/env python3
"""Independent double-precision replay of Hong arXiv:2312.04354v2 Appendix A1.
The formulas are evaluated in logarithmic form to avoid overflow.  This is
supporting computation only; reported source-table values remain the cited theorem evidence.
"""
import math, json, sys

def primes_upto(n):
    s=bytearray(b'\x01')*(n+1); s[:2]=b'\x00\x00'
    for p in range(2,int(n**0.5)+1):
        if s[p]: s[p*p:n+1:p]=b'\x00'*(((n-p*p)//p)+1)
    return [p for p in range(2,n+1) if s[p]]
P=primes_upto(1000)
alpha=(1+math.sqrt(5))/2
la=math.log(alpha)

def dsn_for_X(X,ka):
    o=sorted([p for p in P if p<=X and p%5 in (1,4)], reverse=True)
    k=len(o)
    small=o[1:]
    logsum=sum(la+math.log(p) for p in small)
    # theta=(2loga+logsum)*prod(log(alpha*p))
    logtheta=math.log(2*la+logsum)+sum(math.log(math.log(alpha*p)) for p in small)
    loginner=math.log1p(0.5**k)+math.log(50233.5)+(k+2)*math.log(k+1)+math.log(ka)+math.log(ka+1)+logtheta-math.lgamma(k)
    logLambda=math.log(7)+math.log(k)+loginner/(k-1)
    Lambda=math.exp(logLambda)
    dsn=Lambda*math.exp(math.log(2*logLambda)/(k-1))
    return dsn,k,X,logLambda

def best(ka): return min((dsn_for_X(X,ka) for X in range(100,1000)),key=lambda x:x[0])
vals={str(k):best(k) for k in list(range(1,101))+[1000,10000,100000,1000000]}
# actual final n log, computed from archived exact state
sys.set_int_max_str_digits(10000)
state=json.load(open('research/computation/2026_09_01_danilov_recursive_lift/search_stage13_100m.json'))
n=10*int(state['current_Q']); lnn=math.log(n)
eligible=[k for k in range(1,1001) if best(k)[0] <= lnn]
out={'actual_log_n':lnn,'max_kappa_le_1000_passing':max(eligible),'selected':{k:vals[str(k)] for k in ['1','10','20','30','40','41','42','43','44','45','46','47','48','49','50','100','1000','10000','100000','1000000']}}
print(json.dumps(out,indent=2))
