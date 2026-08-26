"""Exact SageMath transcript for the p=17 Chebyshev obstruction audit.

Run with SageMath 10.9.  Every test below is exact; there is no search
cutoff in the root-of-unity test.  Sage's ``is_cyclotomic`` is applied to
every irreducible factor of the complete off-diagonal ratio resultant.
"""

R.<x> = QQ[]
q17 = (-2*x^17 + 34*x^15 - 238*x^13 + 884*x^11 - 1870*x^9
       + 2244*x^7 - 1428*x^5 + 408*x^3 - 34*x + 5)

ell = 67
k = GF(ell)
qbar = q17.change_ring(k)
print("GOOD_REDUCTION_67", qbar.is_squarefree())

C = HyperellipticCurve(qbar)
P = C.frobenius_polynomial()
print("P67", P)
print("P67_IRREDUCIBLE", P.is_irreducible())

g = 8
print("MIDDLE_COEFFICIENT", ZZ(P[g]))
print("MIDDLE_MOD_67", ZZ(P[g]) % ell)
print("ORDINARY_67", ZZ(P[g]) % ell != 0)

# If alpha_i are the sixteen roots of P, the roots of this resultant are
# all ordered ratios alpha_j/alpha_i.  The diagonal contributes (z-1)^16.
S.<X,z> = PolynomialRing(QQ, 2)
PS = sum(QQ(P[i])*X^i for i in range(P.degree() + 1))
ratio_resultant = PS.resultant(PS(X=X*z), X)
Uz.<z> = QQ[]
ratio_resultant = Uz(ratio_resultant)
print("RATIO_RESULTANT_DEGREE", ratio_resultant.degree())
print("Z_MINUS_ONE_MULTIPLICITY", ratio_resultant.valuation(z - 1))

off_diagonal = ratio_resultant // ((z - 1)^16)
factorization = off_diagonal.factor()
print("OFF_DIAGONAL_FACTOR_DEGREES",
      [(h.degree(), e) for h, e in factorization])
print("OFF_DIAGONAL_IS_CYCLOTOMIC",
      [(h.is_cyclotomic(), e) for h, e in factorization])
print("NO_NONTRIVIAL_ROOT_OF_UNITY_RATIO",
      all(not h.is_cyclotomic() for h, e in factorization))
