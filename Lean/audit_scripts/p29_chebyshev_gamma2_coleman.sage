# High-precision p=29 Coleman unit-minor certificate.
#
# SageMath 10.9.  This freezes the local Coleman calculation only.  It does
# not assert that the displayed endpoint classes generate (or saturate) the
# Mordell--Weil group, and it does not assert a rational-point theorem.

R.<x> = QQ[]
n = 29
T0 = R(1)
T1 = x
for _ in range(2, n + 1):
    T0, T1 = T1, 2*x*T1 - T0
F = 4*T1 + 5
f = F / 2^(n + 1)

# The scaling makes f monic.  The two rational endpoints are
# (-1, 2^-15) and (1, 3*2^-15).
assert f.is_monic()
assert f(-1) == 1/2^30
assert f(1) == 9/2^30

C = HyperellipticCurve(f)
g = C.genus()
p = 5
k = GF(p)
assert g == 14
assert f.is_irreducible()
assert f.discriminant().valuation(p) == 0

Ck = C.change_ring(k)
pts = Ck.points()
f5_roots = f.change_ring(k).roots()
assert len(pts) == 6
assert f5_roots == [(k(0), 1)]
assert sum(1 for P in pts if P[2] == 0) == 1
for z, mult in [(k(0), 1), (k(1), 2), (k(-1), 2)]:
    assert sum(1 for P in pts if P[2] != 0 and P[0]/P[2] == z) == mult

# Use substantially more precision than the original 25-digit pilot.  The
# assertions below depend only on stable reductions modulo 5 and on a unit
# determinant; the extra digits expose a large precision margin.
precision = 110
K = Qp(p, precision)
CK = C.change_ring(K)
O = CK(1, 0, 0)
Pm = CK(-1, QQ(1)/2^15, 1)
Pp = CK(1, QQ(3)/2^15, 1)
lm = vector(K, CK.coleman_integrals_on_basis(O, Pm)[:g])
lp = vector(K, CK.coleman_integrals_on_basis(O, Pp)[:g])
rows = [lm, lp]
contents = [min(z.valuation() for z in row if z != 0) for row in rows]
assert contents == [1, 1]

L = matrix(K, [lm/5, lp/5])
M = matrix(k, [[k(z) for z in row] for row in L])
assert M.rank() == 2

# The scout vector has length g=14.  It annihilates the two normalized
# endpoint logarithms and is a unit at each of the four residue types.
cbar = vector(k, [4, 1, 2] + [0]*10 + [1])
assert len(cbar) == g
assert M*cbar == 0

def ev(c, z):
    return sum(c[j]*z^j for j in range(g))

evals = [ev(cbar, z) for z in [k(0), k(1), k(-1)]] + [cbar[g - 1]]
assert evals == [k(4), k(3), k(4), k(1)]
for P in pts:
    if P[2] == 0:
        assert cbar[g - 1] != 0
    else:
        assert ev(cbar, P[0]/P[2]) != 0

# Columns 0 and 2 give the requested unit minor.  Keeping all other
# coefficients equal to their Teichmuller representatives and solving in
# these two columns lifts cbar to an exact Q_5 annihilator at the working
# precision.
pair = (0, 2)
B = L.matrix_from_columns(list(pair))
unit_minor_det = B.det()
assert unit_minor_det.valuation() == 0
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
assert min(dot_precisions) >= precision - 10

# The sole finite Weierstrass residue class contains exactly one Q_5 root.
roots = f.roots(K)
assert len(roots) == 1
assert k(roots[0][0]) == 0

print('GOOD_REDUCTION_POINTS', pts)
print('F5_WEIERSTRASS_ROOTS', f5_roots)
print('LOG_CONTENTS', contents)
print('NORMALIZED_LOG_REDUCTION')
print(M)
print('NORMALIZED_LOG_RANK', M.rank())
print('ANNIHILATOR_REDUCTION', cbar, 'EVALS', evals)
print('UNIT_MINOR', pair, 'DET_REDUCTION', k(unit_minor_det))
print('DOTS', dots, 'DOT_PRECISIONS', dot_precisions)
print('Q5_ROOTS', len(roots), 'ROOT_REDUCTIONS', [k(z[0]) for z in roots])
print('P29_GOOD_REDUCTION_F5_POINT_COUNT=6')
print('P29_ENDPOINT_LOG_CONTENTS_1_1')
print('P29_NORMALIZED_LOG_RANK_2')
print('P29_ANNIHILATOR_EVALS_4_3_4_1')
print('P29_UNIT_MINOR_COLUMNS_0_2')
print('P29_GAMMA2_COLEMAN_LOCAL_CERTIFICATE_PASS')
