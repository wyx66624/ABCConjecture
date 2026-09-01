#!/usr/bin/env python3
import json,math
P,Q=2,-3
u=[0,1]
for _ in range(2,11):u.append(P*u[-1]-Q*u[-2])
assert u==[0,1,2,7,20,61,182,547,1640,4921,14762]
assert P*P-4*Q==16 and math.gcd(P,Q)==1
assert 14762==2*11*11*61
assert all(x%11 for x in u[1:10]) and u[10]%(11*11)==0
assert u[2]%2==0 and u[5]%61==0
out={'status':'PASS','P':P,'Q':Q,'discriminant':16,'roots':[3,-1],'terms_u0_to_u10':u,'U10_factorization':{'2':1,'11':2,'61':1},'primitive_divisors_at_10':{'11':2},'cyclotomic_factor_C10':121,'scope':'complete counterexample to a sequence-uniform simple-primitive claim; not a Fibonacci counterexample'}
print(json.dumps(out,indent=2))
