# Independent review of mixed-exponent covers

Date: 2026-09-07. MX1--MX4 complete ordinary review: PASS.
Reviewed source:
`2026_09_07_independent_route/tenth_round/mixed_exponent_covers.md`,
SHA256 `263c08636f7c6559f54dd1f77f2201b94424a2a184b0cf7aa5dab3920916d37e`.
No correction was required.

## Exact first coefficient, including units and ramification

Conjugating the actual oriented profile gives the factor
u^2*zeta^e*v/bar(v), since gamma/bar(gamma)=zeta. Its inverse is
therefore the correct coefficient multiplying (x-beta+)/(x-beta-).
This identity takes no h-th root of a unit and remains valid when
h is divisible by two or three. The exact ratio height is one half
log V0, because the primitive unramified oriented numerator and its
conjugate denominator have disjoint ideals and archimedean absolute
value one. Shared oriented support between v and w is irrelevant to
this internal coprimality for v. Root-of-unity multiplication and
inversion preserve the height, as does extension to the fixed K.

The norm-ball coordinate bound gives O(X) residuals over all norms
at most X. The finite choices of u and e change only its constant.
This count is already cumulative over V0 and is not summed a second
time. Unit residuals produce a fixed finite coefficient set without
an additional h-dependent unit-class count.

## Geometric degree and genus for arbitrary common divisors

The two roots of N and the four roots of f are separable and disjoint.
The calculation f modulo N equals X^2 gives resultant one. Over the
algebraic closure, the three quartic ratio classes are independent:
the valuation at each alpha_i singles out its own class, even for
composite g. The quartic cover is Galois of degree g^3; at alpha_4
the poles share one uniformizer root and have diagonal inertia g,
not g^3. Infinity is unramified. The first ratio cover is cyclic of
degree h with just its two separate branch points.

Their intersection is unramified everywhere: an intermediate field
of either cover can ramify only in that cover's branch set. These
sets are disjoint, including infinity. A connected nontrivial
unramified cover of P1 in characteristic zero would have negative
genus by Riemann--Hurwitz and is impossible. There is no constant
extension over the algebraic closure. Since both extensions are
Galois, trivial intersection gives degree h*g^3 for the compositum.
Thus connectedness does not rely on gcd(h,g)=1.

The two first branch points contribute 2D(1-1/h) and the four
quartic points contribute 4D(1-1/g). Riemann--Hurwitz gives exactly
genus 1+2h*g^3-g^3-2h*g^2. The actual positive rational x is
outside the branch values. Its Kummer coordinates are nonzero, and
the derivatives in those four coordinates are nonzero in
characteristic zero. The affine cover is smooth there, so the
actual K-point lifts to the normalization over K. No reverse map
from every K-point to a primitive integer seed is claimed.

## Cover count and coefficient-height accounting

The QC inputs are applied within their proved domain: g>=9 exceeds
the fixed field degree eight, and V1<2^g forces every prime valuation
of V1 below g. The actual second norm supplies the previously
reviewed ramified/bad-prime conditions, including exact depth one
at thirteen. The fixed-field class and unit factors remain in the
QC constant and g^9 factor. Inversion of a coefficient, if needed
for the ratio convention, changes neither its height nor the count.

Multiplying the cumulative O(X) first-profile count by the QC list
gives MX8. Since V1>=2^omega(V1), the latter support factor is at
most V1^16; summing over at most Z integer values gives at most
Z^17. This yields MX9 without an extra norm summation factor in X.
All six branch values are fixed. Clearing only the linear rational
functions gives coefficients whose heights are bounded by the
actual first ratio and the QC coefficient bounds. Their number is
fixed even while the monomial degrees grow. The stated individual
and projective coefficient-height bounds therefore follow. These
are coefficient heights, not point heights.

## Unequal-exponent separation and the remaining gate

Under h tending to infinity, g=o(h), log V0=o(h), and bounded
log V1/g, the chosen coefficient-height bound is o(h). The actual
first norm is at least 7^h and is smaller than c^2. Primitivity
gives height(a/b)=log max(a,b)>=log c-log 2, hence a positive
linear lower bound in h. Both log h and log g are o(h). The two
ratios in MX12 consequently tend to zero with the stated quantifiers.

This includes nonunit residuals and relatively prime exponents, but
asserts no such sequence exists. The proposed uniform point-height
upper bound is clearly identified as an unproved sufficient next
step. Large genus, a finite list of twists and small coefficients
are not used to infer that bound. Comparable exponents and the
other stated residual regimes remain open. No new Lean formalization
or global ABC conclusion is asserted by this ordinary review.
