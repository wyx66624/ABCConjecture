# Exact p=31 norm/3-adic descent over-approximation and dyadic injection.
# Loads the separately frozen 20-dimensional K(S,2) basis verifier.  Neither
# source constructs a BNF, class group, unit group, or regulator.

load('p31_chebyshev_s_squareclass_verify.sage')

def chebyshev_T(n,z):
    if n == 0: return Qx(1)
    t0,t1 = Qx(1),Qx(z)
    for _ in range(2,n+1):
        t0,t1 = t1,2*z*t1-t0
    return t1

curvefm = Qx(2^30*(4*chebyshev_T(31,x/4)+5))
assert curvefm.is_monic() and curvefm.degree() == 31

# Exact endpoint square factorizations; no numerical root extraction.
qm = (curvefm-2^30)//(x+4)
qp = (curvefm-9*2^30)//(x-4)
assert (curvefm-2^30) % (x+4) == 0
assert (curvefm-9*2^30) % (x-4) == 0
assert qm.is_square() and qp.is_square()
Uminus = Qx(qm.sqrt())
Uplus = Qx(qp.sqrt())
assert curvefm-2^30 == (x+4)*Uminus^2
assert curvefm-9*2^30 == (x-4)*Uplus^2

dtheta = -(2*a+a^30)
d1 = a-1
d9 = 3*(a+1)
assert curvefm(dtheta) == 0
assert (((-1)^15)*Uminus(dtheta)/d1).is_square()
assert (((-1)^15)*Uplus(dtheta)/d9).is_square()

# Recover global coordinates solely through the already certified injective
# exact signature matrix, then confirm each candidate by a direct square test.
def full_signature(e):
    return vector(F2, norm_signature(e) +
        [hs(e,f,P) for P in P3s for f in reps] +
        [hs(e,f,P2s[0]) for f in B2])

def certified_coordinates(e):
    target = full_signature(e)
    c = detection.transpose().solve_right(target)
    assert c*detection == target
    product = prod(reps[i] for i in range(len(reps)) if c[i])
    assert (e/product).is_square()
    return vector(F2,c)

d1coord = certified_coordinates(d1)
d9coord = certified_coordinates(d9)
assert d1coord == vector(F2,[0,1]+[0]*18)

# At 3 the two local squareclass spaces have combined detected dimension four.
# For x^31-2, exact factorization modulo 3 has two irreducible factors, so the
# odd-degree local Kummer quotient has dimension one.  The nonzero endpoint
# line is therefore the entire local Kummer image, as in the accepted p29
# odd-degree descent interface.
assert H3.rank() == 4
ld1 = d1coord*H3
ld9 = d9coord*H3
L3 = span([ld1,ld9],F2)
assert L3.dimension() == 1

# W: rational norm square and localization at 3 in the endpoint line.
L3ann = matrix(F2,list(L3.basis())).right_kernel().basis_matrix()
constraints = NM.augment(H3*L3ann.transpose())
W = constraints.left_kernel()
WB = list(W.basis())
assert d1coord in W and d9coord in W

# Exact dyadic localization test.  Every local square pairs trivially with
# B2, so full row rank on W proves localization injective; completeness of B2
# as a local basis is not required for this implication.
W2sig = matrix(F2,WB)*H2
Gamma2sig = matrix(F2,[d1coord,d9coord])*H2
kernel_dim = W.dimension()-W2sig.rank()

print('CURVE_DEGREE',curvefm.degree(),'CURVE_DISCRIMINANT',curvefm.discriminant())
print('ENDPOINT_COORD_D1',d1coord)
print('ENDPOINT_COORD_D9',d9coord)
print('NORM_RANK',NM.rank())
print('P3COUNT',len(P3s),'P3_DEGREES',sorted(P.residue_class_degree() for P in P3s),
      'LOCAL3_PAIR_RANK',H3.rank(),'L3_DIM',L3.dimension())
print('COMBINED_CONSTRAINT_RANK',constraints.rank(),
      'W_DIM',W.dimension(),'W_COUNT',2^W.dimension(),'W_BASIS',WB)
print('DYADIC_TEST_CLASSES',len(B2),'GLOBAL_REP_DYADIC_RANK',H2.rank(),
      'W_DYADIC_RANK',W2sig.rank(),'KERNEL_DIM',kernel_dim,
      'GAMMA2_RANK',Gamma2sig.rank())
print('NO_BNF_OR_CLASS_GROUP_USED=1')
print('NO_UNIT_GROUP_OR_REGULATOR_USED=1')
if kernel_dim == 0:
    print('P31_GLOBAL_DYADIC_INJECTION_PASS')
else:
    print('P31_GLOBAL_DYADIC_INJECTION_FAIL')
