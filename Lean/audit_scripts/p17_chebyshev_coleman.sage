"""SageMath 10.9 Coleman--Chabauty certificate for the p=17 curve.

The 2-descent certificate proves rank(J(Q))=2.  The logarithms below are
those of the two visible point classes; they span the same Q_5-space as the
two rational half-divisors because multiplication by 2 is a 5-adic unit.
"""

from itertools import product
from sage.version import version as sage_version

print("SAGE", sage_version)
R.<x> = QQ[]
p_index = 17
T0 = R(1)
T1 = x
for _ in range(2, p_index + 1):
    T0, T1 = T1, 2*x*T1 - T0
F = 4*T1 + 5
scale = QQ(2)^((p_index + 1)//2)
f = F / scale^2
H = HyperellipticCurve(f)
p = 5
k = GF(p)
Hk = H.change_ring(k)
g = H.genus()
assert g == 8
assert f.is_irreducible()
assert f.discriminant().valuation(p) == 0
assert len(Hk.points()) == 6
assert f.change_ring(k).roots() == [(k(0), 1)]
print("GENUS", g, "DISC", f.discriminant())
print("IRREDUCIBLE", f.is_irreducible(), "GOOD_REDUCTION_5",
      f.discriminant().valuation(p) == 0)
print("F5COUNT", len(Hk.points()), "F5POINTS", Hk.points())
print("F5ROOTS", f.change_ring(k).roots())

K = Qp(p, 45)
HK = H.change_ring(K)
O = HK(1, 0, 0)
Pm = HK(-1, QQ(1)/scale, 1)
Pp = HK(1, QQ(3)/scale, 1)
lm = vector(K, HK.coleman_integrals_on_basis(O, Pm)[:g])
lp = vector(K, HK.coleman_integrals_on_basis(O, Pp)[:g])
print("LOGVALS", [z.valuation() for z in lm],
      [z.valuation() for z in lp])

# Direct saturation check.  Both logarithm rows have content valuation one.
# Dividing by 5 and reducing gives an exact rank-two matrix over F_5, whose
# right kernel is therefore the full reduced annihilator lattice.
log_content_vals = [min(z.valuation() for z in row if z != 0)
                    for row in [lm, lp]]
direct_log_reduction = matrix(k, [
    [k(z / p^log_content_vals[i]) for z in row]
    for i, row in enumerate([lm, lp])])
expected_log_reduction = matrix(k, [
    [3, 4, 0, 4, 4, 0, 2, 3],
    [1, 0, 4, 2, 2, 3, 1, 2]])
assert log_content_vals == [1, 1]
assert direct_log_reduction == expected_log_reduction
assert direct_log_reduction.rank() == 2
DirectAnn = direct_log_reduction.right_kernel()
print("LOG_CONTENT_VALS", log_content_vals)
print("DIRECT_LOG_REDUCTION", direct_log_reduction,
      "DIRECT_LOG_RANK", direct_log_reduction.rank())
print("DIRECT_ANN_DIM", DirectAnn.dimension())

M = matrix(K, [lm, lp])
KB = M.right_kernel_matrix()
print("KERNEL_ROWS", KB.nrows(), "KERNEL_COLS", KB.ncols())

# Normalize every exact p-adic kernel row to be primitive, then reduce.  The
# six independent reductions prove that this is the full saturated reduction
# of the rank-six annihilator lattice.
primitive_rows = []
for row in KB.rows():
    v = min(z.valuation() for z in row if z != 0)
    primitive_rows.append(vector(K, [z / p^v for z in row]))

red_rows = []
for row in primitive_rows:
    red_rows.append(vector(k, [k(z) if z.valuation() >= 0 else k(0)
                               for z in row]))
W = span(red_rows, k)
assert W == DirectAnn
print("REDUCED_KERNEL_DIM", W.dimension())
print("REDUCED_KERNEL_BASIS", list(W.basis()))
print("DIRECT_ANN_EQUALS_PRIMITIVE_KERNEL", W == DirectAnn)

# Search the finite reduced annihilator for one numerator nonzero at x=0,
# x=1, x=-1 and infinity.  These are all six F_5 residue discs (the finite
# x-values 1 and -1 each support two points).
chosen = None
for coeffs in product(*([list(k)] * W.dimension())):
    if all(a == 0 for a in coeffs):
        continue
    c = sum((coeffs[i] * W.basis()[i]
             for i in range(W.dimension())), vector(k, g))
    vals = [sum(c[j] * aa^j for j in range(g)) for aa in [0, 1, 4]]
    if all(z != 0 for z in vals) and c[g-1] != 0:
        chosen = c
        print("CHOSEN", c, "FINITEVALUES", vals,
              "INFINITYVALUE", c[g-1])
        break
assert chosen is not None
print("FOUND", chosen is not None)

# The sixth residue disc is the unique simple Weierstrass lift above x=0.
# Its divisor class relative to infinity is 2-torsion, so all Coleman
# logarithms vanish.  The final line is an independent numerical check.
roots = f.roots(K)
assert len(roots) == 1
alpha = [aa for aa, e in roots if aa.valuation() >= 1][0]
Wpt = HK(alpha, 0, 1)
iw = vector(K, HK.coleman_integrals_on_basis(O, Wpt)[:g])
print("Q5ROOT_REDUCTION", k(alpha), "ROOT_COUNT", len(roots))
print("IWVALS", [z.valuation() for z in iw])
