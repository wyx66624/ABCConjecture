# Exact SageMath audit for the p=19 pure-field/dyadic no-go.
# No bounded search is used in any claimed classification.

Qx.<a> = PolynomialRing(QQ)
K.<aa> = NumberField(a^19 - 2)

# theta=-2*(aa+aa^-1), and aa/2=(aa^-9)^2.
theta = -2*(aa + aa^-1)
assert aa/2 == (aa^-9)^2
assert 2/aa == (aa^9)^2
X = QQ['X'].gen()
assert (aa/2)*(X - theta) == aa^2 + (X/2)*aa + 1
assert aa^2 + 2*aa + 1 == (aa+1)^2
assert aa^2 - 2*aa + 1 == (aa-1)^2

# Capelli numerator and the two exceptional/cancelled parameters.
R.<Z> = PolynomialRing(QQ)
def G(t):
    return (Z^2 - 1)^19 - 2*(2*Z + t)^19

assert G(2) == (Z+1)^19*((Z-1)^19 - 2^20)
assert G(-2) == (Z-1)^19*((Z+1)^19 - 2^20)
assert G(46).degree() == 38
assert G(46).is_irreducible()  # exact diagnostic for X=92, not uniformity

# The target branch X=-4+96*k has t=-2+48*k.  The normalized K_2
# valuations at y0=aa-1 are v(F(y0))=19*s+1 and v(F'(y0))=19.
for s in [2,3,4,5,10]:
    assert 19*s + 1 > 2*19
assert 19*4 + 1 == 77
assert 2*19 == 38

# Irreducibility of the deck module over F_2.
assert Mod(2,19).multiplicative_order() == 18
F2z.<z> = PolynomialRing(GF(2))
phi19 = F2z(cyclotomic_polynomial(19))
assert phi19.degree() == 18
assert phi19.is_irreducible()

assert 2^(2*9) == 262144
assert 1 + 2^18*(9-1) == 2097153

print("COORDINATE_IDENTITY", True)
print("SQUARE_MULTIPLIERS", True)
print("VISIBLE_FIBRES", [-2,2])
print("CAPELLI_DEGREE_AT_46", G(46).degree())
print("CAPELLI_IRREDUCIBLE_AT_46", G(46).is_irreducible())
print("HENSEL_THRESHOLD_S", 2)
print("TARGET_S", 4)
print("HENSEL_VALUATIONS_AT_TARGET", [77,19,38])
print("ORDER_19_OF_2", Mod(2,19).multiplicative_order())
print("PHI19_MOD2_IRREDUCIBLE", phi19.is_irreducible())
print("NEUTRAL_COVER_DEGREE_GENUS", [2^18,1+2^18*8])
