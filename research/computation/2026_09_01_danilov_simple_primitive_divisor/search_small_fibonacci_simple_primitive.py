#!/usr/bin/env python3
"""Bounded exact search for simple primitive divisors of F_(10Q).
Every claimed prime is certified by trial division, rank by proper prime-index
quotients, and valuation one by fast doubling modulo p^2.
"""
import argparse, csv, json, math

def sieve(n):
    a=bytearray(b'\x01')*(n+1); a[:2]=b'\x00\x00'
    for p in range(2,math.isqrt(n)+1):
        if a[p]: a[p*p:n+1:p]=b'\x00'*(((n-p*p)//p)+1)
    return a,[i for i in range(2,n+1) if a[i]]

def factor_small(n,primes):
    fs=[]
    for p in primes:
        if p*p>n:break
        if n%p==0:
            fs.append(p)
            while n%p==0:n//=p
    if n>1:fs.append(n)
    return fs

def fib_pair(n,m):
    if n==0:return (0,1)
    a,b=fib_pair(n>>1,m)
    c=(a*((2*b-a)%m))%m; d=(a*a+b*b)%m
    return (d,(c+d)%m) if n&1 else (c,d)

def fib(n,m):return fib_pair(n,m)[0]

def squarefree(n,primes):
    for p in primes:
        if p*p>n:break
        if n%(p*p)==0:return False
    return True

def main():
    ap=argparse.ArgumentParser(); ap.add_argument('--q-max',type=int,default=1000); ap.add_argument('--p-max',type=int,default=5000000); ap.add_argument('--out',default='small_fibonacci_certificates.csv'); args=ap.parse_args()
    isprime,primes=sieve(args.p_max)
    rows=[]; unresolved=[]
    for Q in range(1,args.q_max+1):
        if math.gcd(Q,30)!=1 or not squarefree(Q,primes):continue
        n=10*Q; nf=factor_small(n,primes); hit=None
        # primitive p must be 1 mod n because 5|n
        for p in range(n+1,args.p_max+1,n):
            if not isprime[p]:continue
            if fib(n,p)!=0:continue
            if any(fib(n//r,p)==0 for r in nf):continue
            fnp2=fib(n,p*p)
            if fnp2%p==0 and fnp2%(p*p)!=0:
                hit=(p,fnp2//p % p,math.isqrt(p));break
        if hit: rows.append((Q,n,*hit))
        else: unresolved.append(Q)
    outpath=args.out
    with open(outpath,'w',newline='',encoding='utf-8') as f:
        w=csv.writer(f); w.writerow(['Q','n','simple_primitive_p','F_n_over_p_mod_p','trial_division_bound']); w.writerows(rows)
    summary={'q_max':args.q_max,'p_max':args.p_max,'eligible_Q_count':len(rows)+len(unresolved),'certified_count':len(rows),'unresolved_count':len(unresolved),'unresolved_Q':unresolved,'scope':'finite exact certificates only; unresolved means no certificate at p<=p_max, not a counterexample'}
    print(json.dumps(summary,indent=2))
if __name__=='__main__':main()
