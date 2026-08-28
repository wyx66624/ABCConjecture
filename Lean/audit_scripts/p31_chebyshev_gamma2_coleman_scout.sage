# Prime-31 high-precision Coleman scout at 5.
#
# This is a local calculation only.  It does not assert a Mordell--Weil
# saturation, a Selmer bound, a Stoll shell result, or a rational-point
# theorem.  The exact endpoint classes are the two rational halves used in
# the separate global/dyadic certificate.

R.<x> = QQ[]
n = 31
T0 = R(1)
T1 = x
for _ in range(2, n + 1):
    T0, T1 = T1, 2*x*T1 - T0
F = 4*T1 + 5
f = F / 2^(n + 1)

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
assert sum(1 for P in pts if P[2] == 0) == 1

# A moderate precision is sufficient for the scout.  A frozen certificate
# must later rerun with a substantially larger margin and record hashes.
precision = 45
K = Qp(p, precision)
CK = C.change_ring(K)
O = CK(1, 0, 0)
Pm = CK(-1, QQ(1)/2^16, 1)
Pp = CK(1, QQ(3)/2^16, 1)
lm = vector(K, CK.coleman_integrals_on_basis(O, Pm)[:g])
lp = vector(K, CK.coleman_integrals_on_basis(O, Pp)[:g])
rows = [lm, lp]
contents = [min(z.valuation() for z in row if z != 0) for row in rows]

# Normalize each row independently by its exact 5-adic content.  Rank two is
# the only condition needed to construct an exact annihilator lift.
L = matrix(K, [rows[i]/(p^contents[i]) for i in range(2)])
M = matrix(k, [[k(z) for z in row] for row in L])
assert M.rank() == 2

# Find a reduced annihilator which is nonzero on every residue disk.  The
# search is deterministic and only explores a growing prefix of a kernel
# basis; it proves the displayed vector by direct checks after discovery.
N = M.right_kernel().basis_matrix()

def ev(c, z):
    return sum(c[j]*z^j for j in range(g))

def unit_on_every_disk(c):
    if c[g-1] == 0:
        return False
    for P in pts:
        if P[2] != 0 and ev(c, P[0]/P[2]) == 0:
            return False
    return True

cbar = None
for d in range(1, min(7, N.nrows()) + 1):
    for coeffs in cartesian_product_iterator([range(p)]*d):
        if all(a == 0 for a in coeffs):
            continue
        candidate = sum((k(coeffs[i])*N.row(i) for i in range(d)),
                        vector(k, [0]*g))
        if unit_on_every_disk(candidate):
            cbar = candidate
            break
    if cbar is not None:
        break
assert cbar is not None
assert M*cbar == 0
assert unit_on_every_disk(cbar)

# Choose the first unit 2-by-2 minor and lift the other coefficients by their
# ordinary integer representatives.  Solving in the minor columns constructs
# an actual Q_5 annihilator reducing to cbar.
pair = None
for i in range(g):
    for j in range(i + 1, g):
        if M.matrix_from_columns([i, j]).det() != 0:
            pair = (i, j)
            break
    if pair is not None:
        break
assert pair is not None
B = L.matrix_from_columns(list(pair))
assert B.det().valuation() == 0
rest = [j for j in range(g) if j not in pair]
rhs = -vector(K, [sum(L[i, j]*K(ZZ(cbar[j])) for j in rest)
                  for i in range(2)])
head = B.solve_right(rhs)
omega = vector(K, [head[list(pair).index(j)] if j in pair
                   else K(ZZ(cbar[j])) for j in range(g)])
assert vector(k, omega) == cbar
dots = list(L*omega)
assert all(z == 0 for z in dots)

roots = f.roots(K)

print('GOOD_REDUCTION_POINTS', pts, flush=True)
print('F5_WEIERSTRASS_ROOTS', f5_roots, flush=True)
print('LOG_CONTENTS', contents, flush=True)
print('NORMALIZED_LOG_REDUCTION', flush=True)
print(M, flush=True)
print('NORMALIZED_LOG_RANK', M.rank(), flush=True)
print('ANNIHILATOR_REDUCTION', cbar, flush=True)
print('ANNIHILATOR_DISK_EVALS',
      [('infinity', cbar[g-1])] +
      [(str(P), ev(cbar, P[0]/P[2])) for P in pts if P[2] != 0],
      flush=True)
print('UNIT_MINOR', pair, 'DET_REDUCTION', k(B.det()), flush=True)
print('DOT_PRECISIONS', [z.precision_absolute() for z in dots], flush=True)
print('Q5_ROOTS', len(roots), 'ROOT_REDUCTIONS', [k(z[0]) for z in roots],
      flush=True)
print('P31_GAMMA2_COLEMAN_LOCAL_SCOUT_PASS', flush=True)
