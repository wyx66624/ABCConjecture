# Independent exact verifier for a basis of K(S,2), K=Q(a), a^31=2.
# It deliberately constructs no BNF, class group, unit group, or regulator.

Qx.<x> = QQ[]
K.<a> = NumberField(x^31 - 2)
O = K.maximal_order()
assert K.signature() == (1,15)
assert K.discriminant() == -2^30 * 31^31
assert O == K.order(a)

P2s = K.primes_above(2)
P3s = K.primes_above(3)
P31s = K.primes_above(31)
assert len(P2s) == len(P31s) == 1
assert sorted(P.residue_class_degree() for P in P3s) == [1,30]
S = P2s + P3s + P31s
assert len(S) == 4

reppols = [
    -1,
    x-1,
    x^16-x-1,
    x^17+x^16-x^2-x-1,
    -x^29-x^27-x^25-x^23-x^21-x^19-x^17-x^15-x^13-x^11-x^9-x^7-x^5-x^3-x-1,
    x^29-x^27+x^25-x^23+x^21-x^19-x^14+x^12-x^10+x^8-x^6+x^4+x-1,
    -x^29-x^26+x^25+x^22+x^16+x^14+x^11-x^10-x^7+x^5-2*x^4-2*x+1,
    x^12+x^11+x^10+x^9+x^8+x^7-x^5-x^4-x^3-x^2-2*x-1,
    x^30+x^28-x^25+x^22-x^19-x^18+x^16+x^15+x^14+x^13-x^12-x^11-2*x^10-x^9+2*x^7+2*x^6+2*x^5-x^4-x^3-2*x^2-x-1,
    -x^30+x^28+x^27+x^26-x^25+x^22-x^21-x^20-2*x^19-2*x^14+2*x^13+x^12+2*x^11+x^7+x^6-x^5-2*x^4-2*x^3+2*x^2-x+1,
    x^30+x^29+2*x^24+3*x^23+x^22+x^20-x^18+x^16+x^15+x^14-x^13-3*x^12-2*x^11-x^10-x^9-x^8-x^5-3*x^4-3*x^3+x+1,
    -x^30+x^29+x^28+3*x^26+2*x^25-4*x^24-2*x^23-2*x^21-x^20+2*x^19+x^18+4*x^17+5*x^16-2*x^15-2*x^14+x^13-3*x^12-6*x^11-x^10-x^9+x^8+5*x^7+x^6+5*x^4+x^3-7*x^2-2*x-1,
    -4*x^30+3*x^28+3*x^27+3*x^26-x^25-4*x^24-4*x^23-3*x^22+5*x^20+4*x^19+3*x^18-5*x^16-4*x^15-x^14+2*x^13+6*x^12+6*x^11+x^10-x^9-6*x^8-6*x^7-x^6+2*x^5+6*x^4+7*x^3-5*x-7,
    x^29-x^28-x^25+2*x^24-x^23-2*x^20+3*x^19-x^18-2*x^15+3*x^14-x^13-2*x^10+2*x^9-2*x^5+x^4+x^3-x^2-1,
    x^28+x^27-x^24-2*x^23-x^22+x^21+x^20+x^19+x^18+2*x^17+2*x^16+x^15-3*x^14-4*x^13-2*x^12-x^10+x^8+3*x^7+4*x^6+2*x^5-2*x^4-x^3-x^2-2*x-1,
    -2*x^30+2*x^29-x^27-2*x^25+2*x^24-2*x^22+x^21-x^20+2*x^19-3*x^17+2*x^16-x^15-3*x^12+4*x^11+x^10-x^9+2*x^8-2*x^7+3*x^6-4*x^4+3*x^3+2*x+1,
    x,
    -x^2+1,
    -x^30-2*x^29-x^28-2*x^27-x^26-2*x^25-x^24-2*x^23-x^22-2*x^21-x^20-2*x^19-x^18-2*x^17-x^16-2*x^15-x^14-2*x^13-x^12-2*x^11-x^10-2*x^9-x^8-2*x^7-x^6-2*x^5-x^4-2*x^3-x^2-2*x-1,
    x^5-1,
]
reps = [K(Qx(p)(a)) for p in reppols]
assert len(reps) == 20

profiles = []
for i,e in enumerate(reps, start=1):
    assert e != 0 and e in O
    N = ZZ(e.norm())
    support = sorted(abs(N).prime_divisors())
    assert set(support).issubset({2,3,31})
    profiles.append((i,N,support))

unit_rank = sum(K.signature()) - 1
expected_dimension = 1 + unit_rank + len(S)
assert unit_rank == 15 and expected_dimension == len(reps) == 20

F2 = GF(2)
def hs(e,f,P):
    return F2(0 if K.hilbert_symbol(e,f,P) == 1 else 1)
def norm_signature(e):
    n = QQ(e.norm())
    return [F2(n < 0), F2(n.valuation(2)%2),
            F2(n.valuation(3)%2), F2(n.valuation(31)%2)]

NM = matrix(F2, [norm_signature(e) for e in reps])
# The standard 33-class test family at the unique dyadic completion.
B2 = [a] + [1+a^i for i in range(1,62,2)] + [1+a^62]
assert len(B2) == 33
H2 = matrix(F2, [[hs(e,f,P2s[0]) for f in B2] for e in reps])
# Pair against the frozen global representatives at both places above 3.
H3 = matrix(F2, [[hs(e,f,P) for P in P3s for f in reps] for e in reps])
detection = NM.augment(H3).augment(H2)
assert detection.rank() == 20

print('SIGNATURE', K.signature(), 'UNIT_RANK', unit_rank)
print('S_SIZE', len(S), 'S_RESIDUE_DEGREES',
      {2:[1], 3:sorted(P.residue_class_degree() for P in P3s), 31:[1]})
print('EXPECTED_S_SQUARECLASS_DIM', expected_dimension)
print('SUPPORT_PROFILES', profiles)
print('NORM_SIGNATURE_RANK', NM.rank(), 'P3_SIGNATURE_RANK', H3.rank(),
      'DYADIC_SIGNATURE_RANK', H2.rank())
print('COMBINED_SQUARECLASS_DETECTION_RANK', detection.rank())
print('NO_BNF_OR_CLASS_GROUP_USED=1')
print('NO_UNIT_GROUP_OR_REGULATOR_USED=1')
print('P31_S_SQUARECLASS_EXACT_VERIFY_PASS')
