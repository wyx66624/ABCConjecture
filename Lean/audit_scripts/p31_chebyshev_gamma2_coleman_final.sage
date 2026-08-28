# Prime-31 high-precision Coleman local certificate at 5.
#
# SageMath 10.9.  This freezes a local calculation only.  It does not assert
# Mordell--Weil generation or saturation, a Selmer bound, a Stoll shell
# result, or a rational-point theorem.

R.<x> = QQ[]
n = 31
T0 = R(1)
T1 = x
for _ in range(2, n + 1):
    T0, T1 = T1, 2*x*T1 - T0
F = 4*T1 + 5
f = F / 2^(n + 1)

# The scaling makes f monic.  The two positive rational endpoints are
# (-1, 2^-16) and (1, 3*2^-16).
assert f.is_monic()
assert f(-1) == 1/2^32
assert f(1) == 9/2^32

C = HyperellipticCurve(f)
g = C.genus()
p = 5
k = GF(p)
assert g == 15
assert f.is_irreducible()
assert f.discriminant().valuation(p) == 0

Ck = C.change_ring(k)
pts = Ck.points()
f5_roots = f.change_ring(k).roots()
assert len(pts) == 6
assert f5_roots == [(k(0), 1)]
assert sum(1 for P in pts if P[2] == 0) == 1
for z, mult in [(k(0), 1), (k(1), 2), (k(-1), 2)]:
    assert sum(1 for P in pts
               if P[2] != 0 and P[0]/P[2] == z) == mult

# Precision 120 leaves more than one hundred absolute 5-adic digits after
# the Coleman computation and the two-by-two solve.  Only stable reductions
# modulo 5, a unit determinant, and the explicit precision margin are used
# as certificate data.
precision = 120
K = Qp(p, precision)
CK = C.change_ring(K)
O = CK(1, 0, 0)
Pm = CK(-1, QQ(1)/2^16, 1)
Pp = CK(1, QQ(3)/2^16, 1)
lm = vector(K, CK.coleman_integrals_on_basis(O, Pm)[:g])
lp = vector(K, CK.coleman_integrals_on_basis(O, Pp)[:g])
rows = [lm, lp]
contents = [min(z.valuation() for z in row if z != 0) for row in rows]
assert contents == [1, 1]

L = matrix(K, [lm/5, lp/5])
M = matrix(k, [[k(z) for z in row] for row in L])
expected_M = matrix(k, [
    [3, 1, 2, 2, 3, 4, 1, 4, 1, 4, 1, 4, 3, 3, 4],
    [1, 3, 4, 0, 2, 3, 4, 2, 3, 3, 3, 4, 1, 2, 2],
])
assert M == expected_M
assert M.rank() == 2

# This fixed vector was discovered by the precision-45 scout.  Every datum
# below is independently recomputed and asserted at precision 120.
cbar = vector(k, [1] + [0]*12 + [1, 1])
assert len(cbar) == g
assert M*cbar == 0

def ev(c, z):
    return sum(c[j]*z^j for j in range(g))

type_evals = [ev(cbar, z) for z in [k(0), k(1), k(-1)]] \
             + [cbar[g - 1]]
assert type_evals == [k(1), k(3), k(1), k(1)]
point_evals = []
for P in pts:
    if P[2] == 0:
        value = cbar[g - 1]
    else:
        value = ev(cbar, P[0]/P[2])
    assert value != 0
    point_evals.append((str(P), value))
assert len(point_evals) == 6

# Columns 0 and 1 form a unit minor with determinant 3 modulo 5.  Keep all
# other coefficients at their ordinary integer lifts and solve in these two
# columns.  The unit minor proves that an exact Q_5 annihilator lift exists.
# The displayed finite-precision zeros below record numerical stability;
# they are not presented as symbolic exact equalities in Q_5.
pair = (0, 1)
B = L.matrix_from_columns(list(pair))
unit_minor_det = B.det()
assert unit_minor_det.valuation() == 0
assert k(unit_minor_det) == k(3)
rest = [j for j in range(g) if j not in pair]
rhs = -vector(K, [sum(L[i, j]*K(ZZ(cbar[j])) for j in rest)
                  for i in range(2)])
head = B.solve_right(rhs)
omega = vector(K, [head[list(pair).index(j)] if j in pair
                   else K(ZZ(cbar[j])) for j in range(g)])
assert vector(k, omega) == cbar
dots = list(L*omega)
assert all(z == 0 for z in dots)
dot_precisions = [z.precision_absolute() for z in dots]
assert min(dot_precisions) >= 110

# The sole finite Weierstrass residue disk contains exactly one simple Q_5
# root.  This is a local statement and does not assert that the root is
# rational over Q.
roots = f.roots(K)
assert len(roots) == 1
assert roots[0][1] == 1
assert k(roots[0][0]) == 0

print('GOOD_REDUCTION_POINTS', pts, flush=True)
print('F5_WEIERSTRASS_ROOTS', f5_roots, flush=True)
print('LOG_CONTENTS', contents, flush=True)
print('NORMALIZED_LOG_REDUCTION', flush=True)
print(M, flush=True)
print('NORMALIZED_LOG_RANK', M.rank(), flush=True)
print('ANNIHILATOR_REDUCTION', cbar, flush=True)
print('ANNIHILATOR_TYPE_EVALS_X0_X1_XNEG1_INFINITY', type_evals,
      flush=True)
print('ANNIHILATOR_POINT_EVALS', point_evals, flush=True)
print('UNIT_MINOR', pair, 'DET_REDUCTION', k(unit_minor_det), flush=True)
print('DOTS', dots, 'DOT_PRECISIONS', dot_precisions, flush=True)
print('Q5_ROOTS', len(roots), 'ROOT_REDUCTIONS',
      [k(z[0]) for z in roots], 'MULTIPLICITIES', [z[1] for z in roots],
      flush=True)
print('P31_GOOD_REDUCTION_F5_POINT_COUNT=6', flush=True)
print('P31_UNIQUE_SIMPLE_WEIERSTRASS_ROOT_X0', flush=True)
print('P31_ENDPOINT_LOG_CONTENTS_1_1', flush=True)
print('P31_NORMALIZED_LOG_RANK_2', flush=True)
print('P31_ANNIHILATOR_FIXED_VECTOR_PASS', flush=True)
print('P31_ANNIHILATOR_ALL_SIX_DISKS_UNIT', flush=True)
print('P31_UNIT_MINOR_COLUMNS_0_1_DET_3', flush=True)
print('P31_DOT_PRECISION_MARGIN_AT_LEAST_110', flush=True)
print('P31_Q5_UNIQUE_ROOT_REDUCTION_0', flush=True)
print('P31_GAMMA2_COLEMAN_LOCAL_FINAL_CERTIFICATE_PASS', flush=True)
