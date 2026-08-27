"""Prime-19 closure-specific two-log Coleman ledger.

Run with SageMath 10.9.  This CAS input computes the two known rational
divisor logarithms, the unit minor, the all-six-disc differential, and its
high-precision numerical lift.  It never substitutes the third 2-Selmer
class for a Mordell--Weil logarithm.  The CAS output alone is not a rational-
point completeness proof: completeness follows only after combining the
separately certified Stoll saturation theorem with the mathematical Coleman
one-zero-per-unit-disc lemma.
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
# Exact bridge to the monic model used by the dyadic Stoll computation:
# X=4*x and Y=2^19*y_c.
fm = (x^19 - 76*x^17 + 2432*x^15 - 42560*x^13 + 442624*x^11
      - 2782208*x^9 + 10272768*x^7 - 20545536*x^5
      + 18677760*x^3 - 4980736*x + 1310720)
assert fm(4*x) == 2^18*F
assert 2^19*(QQ(1)/scale) == 512
assert 2^19*(QQ(3)/scale) == 1536
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

K = Qp(p, 60)
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
rhs = -vector(K, [sum(L[i,j]*K(ZZ(all_discs[j])) for j in range(2,g))
                  for i in range(2)])
head = B.solve_right(rhs)
exact_all_discs = vector(K, [head[0],head[1]] +
                          [K(ZZ(all_discs[j])) for j in range(2,g)])
assert all(z == 0 for z in L*exact_all_discs)
assert all((exact_all_discs[j]-K(ZZ(all_discs[j]))).valuation() >= 1
           for j in range(g))
print("EXACT_KNOWN_SUBGROUP_ANNIHILATOR_REDUCTION",
      vector(k,exact_all_discs))
print("EXACT_KNOWN_SUBGROUP_ANNIHILATOR_DOTS",
      list(L*exact_all_discs))

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
print("P19_GAMMA2_COLEMAN_CLOSURE_CERTIFICATE_PASS")
