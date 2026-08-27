# Exact p=29 global squareclass and dyadic-injectivity certificate.
# SageMath 10.9.  The 19 representatives below were discovered with PARI
# bnfinit/bnfsunit, but this verifier constructs no BNF or class group.  It
# checks every representative directly.  Completeness uses the separate
# unconditional certificate Cl(Q(2^(1/29)))=1 and the standard S-unit rank
# theorem: 1 torsion class + unit rank 14 + four finite places = 19.

Qx.<x> = QQ[]
K.<a> = NumberField(x^29 - 2)
O = K.maximal_order()
assert K.signature() == (1,14)
assert K.discriminant() == 2^28 * 29^29
assert O == K.order(a)


def chebyshev_T(n, z):
    """Return T_n(z) by the exact three-term recurrence."""
    if n == 0:
        return Qx(1)
    t0 = Qx(1)
    t1 = Qx(z)
    for _ in range(2, n + 1):
        t0, t1 = t1, 2*z*t1 - t0
    return t1


curvefm = Qx(2^28 * (4*chebyshev_T(29, x/4) + 5))
assert curvefm.is_monic() and curvefm.degree() == 29
assert curvefm.discriminant() == 2^784 * 3^28 * 29^29

Uminus = Qx(
    x^14 - 2*x^13 - 52*x^12 + 96*x^11 + 1056*x^10 - 1760*x^9
    - 10560*x^8 + 15360*x^7 + 53760*x^6 - 64512*x^5
    - 129024*x^4 + 114688*x^3 + 114688*x^2 - 57344*x - 16384)
Uplus = Qx(Uminus(-x))
assert curvefm - 2^28 == (x + 4)*Uminus^2
assert curvefm - 9*2^28 == (x - 4)*Uplus^2

P2s = K.primes_above(2)
P3 = K.primes_above(3)
P29s = K.primes_above(29)
assert len(P2s) == 1 and len(P29s) == 1
P2 = P2s[0]
P3degrees = sorted(P.residue_class_degree() for P in P3)
assert P3degrees == [1,28]
S = P2s + P3 + P29s
assert len(S) == 4

# Frozen order: -1, fourteen ordinary units, then four finite-place
# generators.  Coefficients are in the certified power integral basis.
reppols = [
    -1,
    -x + 1,
    x^15 + x + 1,
    -x^16 - x^15 - x^2 - x - 1,
    -x^27 - x^25 - x^23 - x^21 - x^19 - x^17 - x^15 - x^13
      - x^11 - x^9 - x^7 - x^5 - x^3 - x - 1,
    x^27 - x^25 + x^23 - x^21 + x^19 - x^17 + x^16 + x^15
      - x^14 + x^12 - x^10 + x^8 - x^6 + x^4 + x - 1,
    x^26 - x^25 + x^24 - x^23 - x^21 + 2*x^20 - 2*x^19 + x^18
      - x^17 + x^16 - 2*x^15 + 3*x^14 - x^13 - x^11 + 2*x^10
      - 2*x^9 + x^8 - 2*x^5 + x^4 + x - 1,
    x^28 - 2*x^26 + x^25 + x^24 - x^22 - x^21 + 3*x^20 - x^19
      - x^18 + x^16 + 2*x^15 - 3*x^14 + 2*x^12 - 3*x^9 + 3*x^8
      + x^7 - 2*x^6 - x^5 + 3*x^3 - 2*x^2 - 2*x + 1,
    -x^28 - 2*x^27 - 2*x^26 + 2*x^24 + x^23 - x^22 - 3*x^21
      - 2*x^20 + x^19 + 2*x^18 + x^17 - 2*x^16 - 4*x^15 - x^14
      + x^13 + 3*x^12 - 3*x^10 - 3*x^9 - 2*x^8 + 3*x^7 + 2*x^6
      - 4*x^4 - 4*x^3 + 2*x + 3,
    x^28 - x^23 + x^20 - x^17 - x^15 + x^13 + x^12 - x^11
      - x^10 + x^5 + x^4 - 2*x^2 - x + 1,
    -x^28 - x^26 - x^25 - x^24 - x^23 - x^22 - x^21 - 2*x^19
      - x^18 + x^16 - x^15 + 2*x^13 + x^12 + x^11 + x^10 + 2*x^9
      + 2*x^7 + 2*x^6 + x^5 + x^3 + 2*x^2 - x - 1,
    2*x^28 - x^27 + x^26 - x^24 + x^23 - 2*x^22 + 3*x^21 - 3*x^20
      + 3*x^19 - 3*x^18 + x^17 + x^14 - 2*x^13 + 3*x^12 - 4*x^11
      + 4*x^10 - 3*x^9 + 3*x^8 - 2*x^7 - x^6 + x^5 - x^4
      + 3*x^3 - 4*x^2 + 5*x - 5,
    -x^28 + 2*x^26 + x^25 - 2*x^24 - 2*x^23 + x^22 + 2*x^21
      - x^20 - 2*x^19 + x^18 + 3*x^17 - 3*x^15 - x^14 + 2*x^13
      + x^12 - 2*x^11 - x^10 + 2*x^9 + 2*x^8 - x^7 - x^6
      - 2*x^3 + 2*x + 1,
    -x^28 - 3*x^27 - x^26 + x^25 + 2*x^23 + 3*x^22 + 3*x^21
      + x^20 + 3*x^19 - 2*x^17 - 2*x^16 - 3*x^15 - 5*x^14
      - 4*x^13 - x^12 - 3*x^11 + x^10 + 3*x^9 + 4*x^8 + 3*x^7
      + 6*x^6 + 4*x^5 + 2*x^3 - 2*x^2 - 4*x - 5,
    x^28 + 3*x^27 - x^26 + x^25 - x^24 + 3*x^20 - x^19 + 2*x^18
      - x^16 + 2*x^15 - x^14 + 2*x^13 + x^11 - 2*x^9 + 4*x^8
      - x^7 + 2*x^6 + 3*x^5 - x^4 - 3*x^2 + 3*x - 1,
    x,
    -x^2 + 1,
    -x^28 - 2*x^27 - x^26 - 2*x^25 - x^24 - 2*x^23 - x^22
      - 2*x^21 - x^20 - 2*x^19 - x^18 - 2*x^17 - x^16 - 2*x^15
      - x^14 - 2*x^13 - x^12 - 2*x^11 - x^10 - 2*x^9 - x^8
      - 2*x^7 - x^6 - 2*x^5 - x^4 - 2*x^3 - x^2 - 2*x - 1,
    -x^27 + x^25 - x^23 + x^21 - x^19 + x^17 + x^16 - x^15
      - x^14 + x^13 + x^12 - x^11 - x^10 + x^9 + x^8 - x^7
      - x^6 + x^4 - x^2 + 1,
]
reps = [K(Qx(p)(a)) for p in reppols]
assert len(reps) == 19

# Directly check integrality and finite support, one frozen representative at
# a time.  For an integral element, prime factors of its absolute norm are
# exactly the rational primes below the support of its principal ideal.
support_profiles = []
for index, e in enumerate(reps, start=1):
    assert e != 0 and e in O
    norm = ZZ(e.norm())
    support = sorted(abs(norm).prime_divisors())
    assert set(support).issubset({2,3,29})
    support_profiles.append((index, norm, support))

unit_rank = K.signature()[0] + K.signature()[1] - 1
expected_s_squareclass_dimension = 1 + unit_rank + len(S)
assert unit_rank == 14
assert expected_s_squareclass_dimension == len(reps) == 19

F2 = GF(2)
n = len(reps)


def hs(e, f, P):
    return F2(0 if K.hilbert_symbol(e, f, P) == 1 else 1)


def symmetric_hilbert_matrix(elements, P):
    """Hilbert Gram matrix, computing each symmetric entry only once."""
    size = len(elements)
    result = matrix(F2, size, size)
    for i in range(size):
        for j in range(i, size):
            value = hs(elements[i], elements[j], P)
            result[i,j] = value
            result[j,i] = value
    return result


def qsqclass(q):
    q = QQ(q)
    return [F2(q < 0), F2(q.valuation(2) % 2),
            F2(q.valuation(3) % 2), F2(q.valuation(29) % 2)]


NM = matrix(F2, [qsqclass(e.norm()) for e in reps])
assert NM.rank() == 4

# Pairing against all frozen representatives detects the exact image at the
# two places above 3.  Its ambient image has rank four.
H3 = [symmetric_hilbert_matrix(reps, P) for P in P3]
LM = H3[0].augment(H3[1])
assert len(P3) == 2 and LM.rank() == 4

# The two rational endpoint divisor classes.  The displayed factorizations
# above and these exact square tests identify them as a-1 and 3(a+1).
d1 = a - 1
d9 = 3*(a + 1)
dtheta = -(2*a + a^28)
assert curvefm(dtheta) == 0
assert (Uminus(dtheta)/d1).is_square()
assert (Uplus(dtheta)/d9).is_square()

d1coord = vector(F2, [1,1] + [0]*17)
d9coord = vector(F2, [0,1] + [0]*15 + [1,0])
d1prod = prod(reps[i] for i in range(n) if d1coord[i])
d9prod = prod(reps[i] for i in range(n) if d9coord[i])
assert (d1/d1prod).is_square()
assert (d9/d9prod).is_square()

# Bilinearity and the exact square identities above let the frozen global
# coordinates supply the endpoint local rows without repeating pairings.
ld1 = d1coord*LM
ld9 = d9coord*LM
L3 = span([ld1, ld9], F2)
assert L3.dimension() == 1

# W is the norm-square subspace whose 3-adic image lies in L3.  Convert local
# membership into homogeneous equations by pairing with the right annihilator
# of L3.  This avoids enumerating all 2^19 coefficient vectors.
L3matrix = matrix(F2, list(L3.basis()))
L3ann = L3matrix.right_kernel().basis_matrix()
constraints = NM.augment(LM * L3ann.transpose())
W = constraints.left_kernel()
WB = list(W.basis())
assert constraints.rank() == n - W.dimension() == 5
assert W.dimension() == 14
assert d1coord in W and d9coord in W

# Exact dyadic Hilbert certificate.  The first 18 explicit test classes from
# the standard 31-class family already detect all 14 dimensions of W.  Full
# row rank is itself enough for injectivity: a local square pairs trivially
# with every test class, so no nonzero element of W can localize to a square.
Bsq = [a] + [1 + a^i for i in range(1,58,2)] + [1 + a^58]
assert len(Bsq) == 31
Btest = Bsq[:18]
R2sig = matrix(F2, [[hs(e, f, P2) for f in Btest] for e in reps])
W2sig = matrix(F2, WB)*R2sig
Gamsig = matrix(F2, [d1coord,d9coord])*R2sig
assert W2sig.rank() == W.dimension() == 14
assert Gamsig.rank() == 2

# Full rank of a collection of exact squareclass signatures proves that the
# 19 supported representatives are independent modulo squares.  Combined
# with Cl(K)=1 and the S-unit rank theorem, they are therefore complete.
detection = NM.augment(LM).augment(R2sig)
assert detection.rank() == 19

print('S_SIZE', len(S), 'SIGNATURE', K.signature(), 'UNIT_RANK', unit_rank,
      'EXPECTED_S_SQUARECLASS_DIM', expected_s_squareclass_dimension)
print('SUNIT_SUPPORT_PROFILES', support_profiles)
print('SQUARECLASS_DETECTION_RANK', detection.rank())
print('NORM_RANK', NM.rank())
print('P3COUNT', len(P3), 'P3_DEGREES', P3degrees,
      'LOCAL3_PAIR_RANK', LM.rank(), 'L3_DIM', L3.dimension())
print('COMBINED_CONSTRAINT_RANK', constraints.rank(),
      'W3DIM', W.dimension(), 'COUNT', 2^W.dimension(), 'WB', WB)
print('DYADIC_TEST_CLASSES', len(Btest),
      'GLOBAL_REP_DYADIC_TEST_RANK', R2sig.rank(),
      'W2_SIGNATURE_RANK', W2sig.rank(),
      'KERNEL_DIM', W.dimension() - W2sig.rank(),
      'GAMMA2_RANK', Gamsig.rank())
print('W2_SIGNATURE_MATRIX')
print(W2sig)
print('P29_GLOBAL_DYADIC_OVERAPPROX_PASS')
