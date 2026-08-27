# Exact p=23 global squareclass and dyadic-injectivity certificate.
# SageMath 10.9.  The 17 frozen representatives are the PARI S-unit
# generators for S={places above 2,3,23}.  Their completeness uses the
# separate unconditional explicit-formula certificate proving Cl(K)[2]=0.

Qx.<x> = QQ[]
K.<a> = NumberField(x^23 - 2)
O = K.maximal_order()
assert K.discriminant() == -2^22 * 23^23
curvefm = Qx(x^23-92*x^21+3680*x^19-83904*x^17+1201152*x^15
    -11210752*x^13+68583424*x^11-269434880*x^9+646643712*x^7
    -862191616*x^5+530579456*x^3-96468992*x+20971520)
assert curvefm.discriminant() == -2^484 * 3^22 * 23^23

P2 = K.primes_above(2)[0]
P3 = K.primes_above(3)
P3degrees = sorted(P.residue_class_degree() for P in P3)
assert P3degrees == [1,11,11]
reppols = [
    -1,
    x - 1,
    -x^12 + x + 1,
    -x^22+x^20-x^18+x^16-x^14+x^12-x^11-x^10+x^9+x^8-x^7-x^6+x^5+x^4-x^3-x^2+2*x+1,
    x^21+x^19+x^17+x^15+x^13+x^11+x^9+x^7+x^5+x^3+x+1,
    -x^15-x^12-x^11-x^8+x^7+x^6+x^3+x^2+1,
    -x^21+x^19-x^17+x^15+x^10-x^8+x^6-x^4-x+1,
    -x^22-x^21-x^16-x^15-x^14+x^12+x^11+x^10-x^8-x^7-x^6+x^5+2*x^4+2*x^3+2*x^2-1,
    x^20-x^19-x^18+x^17-x^13+x^12+x^11-2*x^10+x^8+x^6-x^5-2*x^4+2*x^3-2*x+1,
    -x^22+x^21-x^20+x^18-x^17+x^16+x^15-x^14+x^13+x^12-x^11+x^10+x^9-2*x^8+x^7+x^6-3*x^5+x^4-3*x^2+2*x-1,
    x^22-x^20-x^19+2*x^18-x^16-x^15+x^14+x^13-x^12-x^10+x^9-x^6-x^5+2*x^4-2*x+1,
    x^20+x^19-2*x^17-x^16-2*x^13-3*x^12-x^11-2*x^8-x^7+x^6+2*x^5+x^4+2*x^2+3*x+3,
    x,
    x^2 - 1,
    x^21+x^20-x^19+x^18-x^17+x^16-x^15-x^14-x^13-x^12+x^11-3*x^10+2*x^9-x^8+x^7+x^6-2*x^5+x^4+2*x^2-x+1,
    -x^22+x^21+2*x^20+x^19+x^18-2*x^16-3*x^15+2*x^13+2*x^12+x^11+x^10-x^9-3*x^8-3*x^7+x^6+3*x^5+2*x^4+x^3+x^2-2*x-5,
    x^14+x^10+x+1
]
reps = [K(Qx(p)(a)) for p in reppols]
assert len(reps) == 17
for e in reps:
    assert e in O
    assert set(abs(ZZ(e.norm())).prime_divisors()).issubset({2,3,23})

F2 = GF(2)
n = len(reps)
V = VectorSpace(F2,n)
def hs(e,f,P):
    return F2(0 if K.hilbert_symbol(e,f,P) == 1 else 1)
def qsqclass(q):
    q = QQ(q)
    return [F2(q < 0), F2(q.valuation(2)%2),
            F2(q.valuation(3)%2), F2(q.valuation(23)%2)]

NM = matrix(F2,[qsqclass(e.norm()) for e in reps])
assert NM.rank() == 4

# Pairing against the 17 global generators detects the complete six-
# dimensional product of local squareclass quotients at the three places
# above 3 (the matrix has full ambient rank six).
LM = matrix(F2,[[hs(e,f,P) for P in P3 for f in reps] for e in reps])
assert len(P3) == 3 and LM.rank() == 6

d1 = a - 1
d9 = 3*(a + 1)
assert d1 == reps[1]
dtheta = -(2*a+a^22)
dU1 = Qx(x^11-2*x^10-40*x^9+72*x^8+576*x^7-896*x^6-3584*x^5
          +4480*x^4+8960*x^3-7680*x^2-6144*x+2048)
dU9 = Qx(x^11+2*x^10-40*x^9-72*x^8+576*x^7+896*x^6-3584*x^5
          -4480*x^4+8960*x^3+7680*x^2-6144*x-2048)
assert (((-1)^11*dU1(dtheta))/d1).is_square()
assert (((-1)^11*dU9(dtheta))/d9).is_square()
d9coord = vector(F2,[0,0,0,0,1,0,1,0,0,0,0,0,0,0,1,1,0])
d9prod = prod(reps[i] for i in range(n) if d9coord[i])
assert (d9/d9prod).is_square()
ld1 = vector(F2,[hs(d1,f,P) for P in P3 for f in reps])
ld9 = vector(F2,[hs(d9,f,P) for P in P3 for f in reps])
L3 = span([ld1,ld9],F2)
assert L3.dimension() == 2

# W is an unconditional over-approximation to the global 2-Selmer image
# once the separate class-group 2-torsion certificate is supplied: norm-square
# plus the exact local Kummer condition at 3.  No condition at 2 is imposed.
valid = []
for mask in range(2^n):
    c = V([(mask >> i)&1 for i in range(n)])
    if c*NM == 0 and c*LM in L3:
        valid.append(c)
W = span(valid,F2)
WB = list(W.basis())
assert len(valid) == 2048 and W.dimension() == 11
d1coord = vector(F2,[0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
assert d1coord in W and d9coord in W
Welts = []
for c in WB:
    e = K(1)
    for i in range(n):
        if c[i]:
            e *= reps[i]
    Welts.append(e)

# Exact dyadic Hilbert certificate.  The local squareclass quotient has
# dimension 23+2=25.  Nondegeneracy of the 25-by-25 pairing proves Bsq is
# a basis; the survivor signatures have rank 11, so W -> K_2*/K_2*^2 is
# injective.  This avoids deriving injectivity from finite p-adic samples.
Bsq = [a] + [1+a^i for i in range(1,46,2)] + [1+a^46]
HG = matrix(F2,[[hs(e,f,P2) for f in Bsq] for e in Bsq])
R2sig = matrix(F2,[[hs(e,f,P2) for f in Bsq] for e in reps])
W2sig = matrix(F2,[[hs(e,f,P2) for f in Bsq] for e in Welts])
Gamsig = matrix(F2,[[hs(e,f,P2) for f in Bsq] for e in [d1,d9]])
assert HG.rank() == 25
assert R2sig.rank() == 16
assert W2sig.rank() == W.dimension() == 11
assert Gamsig.rank() == 2

print('NORM_RANK',NM.rank())
print('P3COUNT',len(P3),'P3_DEGREES',P3degrees,
      'LOCAL3_PAIR_RANK',LM.rank(),'L3_DIM',L3.dimension())
print('W3DIM',W.dimension(),'COUNT',len(valid),'WB',WB)
print('HILBERT_BASIS_RANK',HG.rank(),'GLOBAL_REP_LOCAL_RANK',R2sig.rank(),
      'W2_SIGNATURE_RANK',W2sig.rank(),'KERNEL_DIM',W.dimension()-W2sig.rank(),
      'GAMMA2_RANK',Gamsig.rank())
print('W2_SIGNATURE_MATRIX')
print(W2sig)
print('P23_GLOBAL_DYADIC_OVERAPPROX_PASS')
