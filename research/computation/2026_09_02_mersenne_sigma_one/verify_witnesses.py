#!/usr/bin/env python3
from decimal import Decimal, getcontext
from fractions import Fraction
import json
getcontext().prec=90
D=Decimal
MR_BASES=(2,325,9375,28178,450775,9780504,1795265022)

def exp_rational_bounds(x:Fraction, terms:int=48):
    """Exact rational enclosure for exp(x), x >= 0.

    Write x=n*y with 0<=y<=1.  The lower endpoint is the Taylor sum through
    degree `terms`.  The omitted positive tail is bounded geometrically,
    since after its first term every successive ratio is at most
    y/(terms+2).  Raising the positive endpoints to n preserves the bounds.
    """
    assert x >= 0 and terms >= 1
    n=max(1,(x.numerator+x.denominator-1)//x.denominator)
    y=x/n
    term=Fraction(1)
    lower=Fraction(1)
    for j in range(1,terms+1):
        term=term*y/j
        lower+=term
    first_omitted=term*y/(terms+1)
    ratio=y/(terms+2)
    upper=lower+first_omitted/(1-ratio)
    return lower**n,upper**n

def rational_window_certificates():
    """Exact Fraction certificates for both logarithmic endpoint witnesses."""
    def exp_lt(x,target):
        _lo,hi=exp_rational_bounds(x)
        return hi<target
    def lt_exp(target,x):
        lo,_hi=exp_rational_bounds(x)
        return target<lo

    q1=10**12; d1=364; p1=1093
    A1lo=Fraction(69,2); A1hi=Fraction(35)
    L1lo=Fraction(177,50); L1hi=Fraction(89,25)
    q2=10**71; d2=1755; p2=3511
    A2lo=Fraction(172); A2hi=Fraction(1721,10)
    L2lo=Fraction(257,50); L2hi=Fraction(103,20)
    checks={
      'exp_34_5_lt_3m_1093':exp_lt(A1lo,Fraction(3*d1*q1)),
      '3m_1093_lt_exp_35':lt_exp(Fraction(3*d1*q1),A1hi),
      'exp_3_54_lt_34_5':exp_lt(L1lo,A1lo),
      '35_lt_exp_3_56':lt_exp(A1hi,L1hi),
      'q_1093_lt_34_5_pow_8':Fraction(q1)<A1lo**8,
      'p_1093_times_34_5_times_3_54_gt_d2':
        Fraction(p1)*A1lo*L1lo>d1*d1,
      '9_lt_34_5_div_3_56':Fraction(9)<A1lo/L1hi,
      '35_div_3_54_lt_16':A1hi/L1lo<Fraction(16),
      'exp_172_lt_3m_3511':exp_lt(A2lo,Fraction(3*d2*q2)),
      '3m_3511_lt_exp_172_1':lt_exp(Fraction(3*d2*q2),A2hi),
      'exp_5_14_lt_172':exp_lt(L2lo,A2lo),
      '172_1_lt_exp_5_15':lt_exp(A2hi,L2hi),
      'q_3511_lt_172_pow_32':Fraction(q2)<A2lo**32,
      'p_3511_times_172_times_5_14_gt_d2':
        Fraction(p2)*A2lo*L2lo>d2*d2,
      '25_lt_172_div_5_15':Fraction(25)<A2lo/L2hi,
      '172_1_div_5_14_lt_36':A2hi/L2lo<Fraction(36),
    }
    assert all(checks.values()), [name for name,passed in checks.items() if not passed]
    return {
      'method':'exact Fraction Taylor lower sum and geometric-tail upper bound',
      'taylor_degree':48,
      'all_checks_pass':True,
      'checks':checks,
      'deductions':{
        '1093':'34.5 < A < 35, 3.54 < L < 3.56, q < A^8, p*A*L > d^2, H=floor(sqrt(A/L))=3',
        '3511':'172 < A < 172.1, 5.14 < L < 5.15, q < A^32, p*A*L > d^2, H=floor(sqrt(A/L))=5',
      },
    }

def is_prime_u64(n:int)->bool:
    if n<2:return False
    small=(2,3,5,7,11,13,17,19,23,29,31,37)
    for p in small:
        if n%p==0:return n==p
    d=n-1;s=0
    while d%2==0:s+=1;d//=2
    for a in MR_BASES:
        if a%n==0:continue
        x=pow(a,d,n)
        if x in (1,n-1):continue
        for _ in range(s-1):
            x=x*x%n
            if x==n-1:break
        else:return False
    return True


def trial_prime(n:int)->bool:
    if n<2:return False
    if n%2==0:return n==2
    f=3
    while f*f<=n:
        if n%f==0:return False
        f+=2
    return True

LUCAS_DATA={
  1093:({2:2,3:1,7:1,13:1},5),
  4733:({2:2,7:1,13:2},5),
  8861085190774909:({2:2,3:2,7:1,13:1,1543:1,2953:1,593627:1},6),
  556338525912325157:({2:2,7:1,11:1,13:1,37:1,658303:1,5704499:1},3),
  3511:({2:1,3:3,5:1,13:1},7),
}
def lucas_certificate(n:int):
    fac,a=LUCAS_DATA[n]
    product=1
    for q,e in fac.items():
        assert trial_prime(q)
        product*=q**e
    assert product==n-1
    assert pow(a,n-1,n)==1
    gcds={str(q):__import__('math').gcd(pow(a,(n-1)//q,n)-1,n) for q in fac}
    assert all(g==1 for g in gcds.values())
    return {'p_minus_1_factorization':{str(q):e for q,e in fac.items()},
            'all_factor_primes_verified_by_trial_division':True,
            'lucas_base':a,'pow_base_p_minus_1_mod_p':pow(a,n-1,n),
            'proper_factor_power_residues':{str(q):pow(a,(n-1)//q,n) for q in fac},
            'gcds':gcds,'lucas_primality_certificate_pass':True}
def divisors(n:int):
    return [d for d in range(1,n+1) if n%d==0]

def mobius(n:int)->int:
    count=0;p=2
    while p*p<=n:
        if n%p==0:
            n//=p;count+=1
            if n%p==0:return 0
            while n%p==0:n//=p
        p+=1
    if n>1:count+=1
    return -1 if count%2 else 1

def phi_at_two(n:int)->int:
    num=den=1
    for d in divisors(n):
        mu=mobius(n//d)
        if mu==1:num*=2**d-1
        elif mu==-1:den*=2**d-1
    assert num%den==0
    return num//den

def order_row(p:int,d:int):
    qs=[];x=d;q=2
    while q*q<=x:
        if x%q==0:
            qs.append(q)
            while x%q==0:x//=q
        q+=1
    if x>1:qs.append(x)
    return {
      'p':p,'prime_u64_mr':is_prime_u64(p),'d':d,
      'p_minus_1_equals_d_times_r':p-1==d*((p-1)//d),'r':(p-1)//d,
      'pow_2_d_mod_p':pow(2,d,p),
      'proper_order_residues':{str(q):pow(2,d//q,p) for q in qs},
      'pow_2_d_mod_p2':pow(2,d,p*p),
      'pow_2_d_mod_p3':pow(2,d,p*p*p),
      'w':next(w for w in range(1,8) if pow(2,d,p**(w+1))!=1),
    }

def witness(p,d,q,k):
    m=d*q; A=D(3*m).ln();L=A.ln();F=A*L;Q=A**k;Hraw=(A/L).sqrt();H=int(Hraw)
    return {
      'p':p,'d':d,'q':str(q),'m':str(m),'k':k,
      'A_log_3m':str(A),'L_loglog_3m':str(L),'Q_A_pow_k':str(Q),
      'window_q_lt_Q':D(q)<Q,'Q_minus_q':str(Q-D(q)),
      'log_window_margin_kL_minus_logq':str(D(k)*L-D(q).ln()),
      'F_sigma1_A_times_L':str(F),'d2_over_F':str(D(d*d)/F),
      'B_p_gt_d2_over_F':D(p)>D(d*d)/F,
      'sqrt_pF':str((D(p)*F).sqrt()),'near_square_d_lt_sqrt_pF':D(d)<(D(p)*F).sqrt(),
      'H_raw':str(Hraw),'H_floor':H,'r':(p-1)//d,'r_ge_H':(p-1)//d>=H,
    }

fac={1093:2,4733:1,8861085190774909:1,556338525912325157:1}
phi=phi_at_two(364)
product=1
for p,e in fac.items():product*=p**e
rows=[order_row(p,364) for p in fac]
rows3511=order_row(3511,1755)
assert product==phi
assert all(row['prime_u64_mr'] and row['pow_2_d_mod_p']==1 and
           all(value!=1 for value in row['proper_order_residues'].values())
           for row in rows)
assert [row['w'] for row in rows]==[2,1,1,1]
assert rows3511['prime_u64_mr'] and rows3511['pow_2_d_mod_p']==1
assert all(value!=1 for value in rows3511['proper_order_residues'].values())
assert rows3511['w']==2 and rows3511['r']==2
scanpath=__file__.replace('verify_witnesses.py','scan_1b.json')
with open(scanpath,encoding='utf-8') as scanfile:
    scan=json.load(scanfile)
assert scan=={'limit':10**9,'prime_count':50847534,
             'hits':[{'p':1093,'d':364,'r':3},
                     {'p':3511,'d':1755,'r':2}]}
cert={
 'schema':'sigma-one-witness-independent-v1',
 'exact_rational_log_window_certificates':rational_window_certificates(),
 'scan_1b_crosscheck_pass':True,
 'miller_rabin_bases_for_n_lt_2_pow_64':list(MR_BASES),
 'lucas_primality_certificates':{str(p):lucas_certificate(p) for p in [1093,4733,8861085190774909,556338525912325157,3511]},
 'phi_364_at_2_via_mobius_product':phi,
 'factorization':{str(p):e for p,e in fac.items()},
 'factor_product_equals_phi':product==phi,
 'phi_364_rows':rows,
 'row_3511':rows3511,
 'witness_1093':witness(1093,364,10**12,8),
 'witness_3511':witness(3511,1755,10**71,32),
}
out=json.dumps(cert,indent=2,sort_keys=True)+'\n'
outpath=__file__.replace('verify_witnesses.py','verify_witnesses_output.json')
open(outpath,'w',encoding='utf-8',newline='\n').write(out)
print(out,end='')
