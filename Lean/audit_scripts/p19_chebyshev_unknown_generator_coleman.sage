"""Prime-19 Coleman ledger with a possible unknown third MW generator.

Run with SageMath 10.9.  The script computes only logarithms of the two
known rational divisor classes.  It never substitutes the third 2-Selmer
class for a Mordell--Weil logarithm.  Its output supplies the exact finite
linear algebra used in the proof of #C_19(Q) <= 7; it deliberately does not
claim that the five visible rational points are complete.
"""

from sage.version import version as sage_version

print("SAGE", sage_version)
R.<x> = QQ[]
n = 19
T0 = R(1)
T1 = x
for _ in range(2, n + 1):
    T0, T1 = T1, 2*x*T1 - T0
F = 4*T1 + 5
scale = QQ(2)^((n + 1)//2)
f = F / scale^2
C = HyperellipticCurve(f)
g = C.genus()
p = 5
k = GF(p)
Ck = C.change_ring(k)

assert g == 9
assert f.is_irreducible()
assert f.discriminant().valuation(p) == 0
assert len(Ck.points()) == 6
assert f.change_ring(k).roots() == [(k(0), 1)]
print("GENUS", g, "IRREDUCIBLE", f.is_irreducible(),
      "GOOD_REDUCTION_5", f.discriminant().valuation(p) == 0)
print("F5COUNT", len(Ck.points()), "F5POINTS", Ck.points())
print("F5ROOTS", f.change_ring(k).roots())

K = Qp(p, 45)
CK = C.change_ring(K)
O = CK(1, 0, 0)
Pm = CK(-1, QQ(1)/scale, 1)
Pp = CK(1, QQ(3)/scale, 1)
lm = vector(K, CK.coleman_integrals_on_basis(O, Pm)[:g])
lp = vector(K, CK.coleman_integrals_on_basis(O, Pp)[:g])
rows = [lm, lp]
contents = [min(z.valuation() for z in row if z != 0) for row in rows]
logred = matrix(k, [[k(z / p^contents[i]) for z in row]
                    for i, row in enumerate(rows)])
normalized_precision = min((z / p^contents[i]).precision_absolute()
                           for i, row in enumerate(rows) for z in row)
expected = matrix(k, [[3,3,0,2,2,0,3,4,4],
                      [1,3,4,3,1,2,3,2,3]])
assert contents == [1,1]
assert normalized_precision >= 30
assert logred == expected
assert logred.rank() == 2
W = logred.right_kernel()
assert W.dimension() == 7
print("LOGVALS", [z.valuation() for z in lm],
      [z.valuation() for z in lp])
print("LOG_CONTENT_VALS", contents)
print("NORMALIZED_MIN_ABSOLUTE_PRECISION", normalized_precision)
print("DIRECT_LOG_REDUCTION", logred, "DIRECT_LOG_RANK", logred.rank())
print("KNOWN_REDUCED_ANNIHILATOR_DIM", W.dimension())

def evalvec(aa):
    return vector(k, [aa^j for j in range(g)])

def dervec(aa):
    return vector(k, [0] + [k(j)*aa^(j-1) for j in range(1,g)])

# This numerator is nonzero at x=0, x=1, x=-1, and infinity.  Hence each
# evaluation kernel inside W has dimension six.
all_discs = vector(k, [1,0,0,0,0,0,0,0,3])
assert all_discs in W
assert all(all_discs*evalvec(aa) != 0 for aa in [k(0),k(1),k(-1)])
assert all_discs[g-1] != 0
print("ALL_DISC_WITNESS", all_discs,
      "VALUES_X0_X1_XM1_INFINITY",
      [all_discs*evalvec(aa) for aa in [k(0),k(1),k(-1)]] +
      [all_discs[g-1]])

# Lift the all-disc witness to a characteristic-zero differential that
# annihilates both known logarithms exactly.  The first two columns form a
# unit 2-by-2 minor modulo 5.  Keeping the other seven coefficients fixed
# and solving those two equations gives an exact lift congruent to the
# witness.  This is useful after a separate Selmer-group Chabauty argument
# has confined a point to the saturation of the known horizontal direction.
L = matrix(K, [lm/p, lp/p])
B = L.matrix_from_columns([0,1])
assert B.det().valuation() == 0
rhs = -vector(K, [sum(L[i,j]*K(all_discs[j]) for j in range(2,g))
                  for i in range(2)])
head = B.solve_right(rhs)
exact_all_discs = vector(K, [head[0],head[1]] +
                          [K(all_discs[j]) for j in range(2,g)])
assert all(z == 0 for z in L*exact_all_discs)
assert all((exact_all_discs[j]-K(all_discs[j])).valuation() >= 1
           for j in range(g))
print("EXACT_KNOWN_SUBGROUP_ANNIHILATOR_REDUCTION",
      vector(k,exact_all_discs))
print("EXACT_KNOWN_SUBGROUP_ANNIHILATOR_DOTS",
      list(L*exact_all_discs))

# If the true reduced annihilator is one of the evaluation kernels, the
# following witnesses give reduced differential order 1 at x=+/-1 and
# order 2 at the simple Weierstrass point and infinity.
data = [
    ("X=1", evalvec(k(1)), dervec(k(1)), 1,
     vector(k,[1,0,0,0,0,0,4,3,2])),
    ("X=-1", evalvec(k(-1)), dervec(k(-1)), 1,
     vector(k,[1,0,0,0,4,0,0,3,3])),
    ("WEIERSTRASS_X=0", evalvec(k(0)),
     vector(k,[0,1,0,0,0,0,0,0,0]), 2,
     vector(k,[0,1,0,0,0,0,0,2,1])),
    ("INFINITY", vector(k,[0,0,0,0,0,0,0,0,1]),
     vector(k,[0,0,0,0,0,0,0,1,0]), 2,
     vector(k,[1,0,0,0,0,0,2,4,0]))]

exceptional_kernels = []
for label, ev, lead, diff_order, witness in data:
    KW = W.intersection(matrix(k,[ev]).right_kernel())
    assert KW.dimension() == 6
    assert witness in KW
    assert witness*lead != 0
    assert diff_order + 1 < p
    print("EXCEPTION", label, "KERNEL_DIM", KW.dimension(),
          "WITNESS", witness, "LEADING_UNIT", witness*lead,
          "DIFFERENTIAL_ORDER", diff_order,
          "INTEGRAL_ORDER", diff_order+1)
    exceptional_kernels.append(KW)
for i in range(len(exceptional_kernels)):
    for j in range(i+1,len(exceptional_kernels)):
        assert exceptional_kernels[i] != exceptional_kernels[j]
print("FOUR_EXCEPTIONAL_KERNELS_PAIRWISE_DISTINCT", True)

# The otherwise empty mod-5 disc has a Q_5-rational Weierstrass lift.  Its
# divisor class relative to O is 2-torsion, hence all Coleman logs vanish.
roots = f.roots(K)
assert len(roots) == 1
alpha = roots[0][0]
assert k(alpha) == 0
Wpt = CK(alpha, 0, 1)
iw = vector(K, CK.coleman_integrals_on_basis(O, Wpt)[:g])
assert all(z == 0 for z in iw)
print("Q5ROOT_REDUCTION", k(alpha), "ROOT_COUNT", len(roots))
print("WEIERSTRASS_LOG_VALS", [z.valuation() for z in iw])

# These are the four possible exceptional-type point-count ledgers:
# x=+/-1, the Weierstrass disc, and infinity.  The no-exception case is 5.
case_bounds = [2*2 + 2 + 1, 2*2 + 2 + 1, 2 + 2 + 2 + 1,
               2 + 2 + 0 + 3]
assert case_bounds == [7,7,7,7]
print("AT_MOST_SEVEN_CASE_LEDGER", case_bounds)

# Exact warning against upgrading reduced differential order to uniqueness.
S.<t> = QQ[]
F1 = 5*t + t^2/2
F2 = t^3 - 25*t
assert F1(0) == F1(-10) == 0 and -10 != 0
assert F2(0) == F2(5) == F2(-5) == 0
print("LIFT_COUNTEREXAMPLE_ORDER1_ROOTS", [0,-10])
print("LIFT_COUNTEREXAMPLE_ORDER2_ROOTS", [0,5,-5])
print("MOD5_UNIFORM_COMPLETENESS", False)
