# Independent ordinary review of BK1--BK3

Date: 2026-09-07. Full ordinary proof review PASS.
Source: `2026_09_07_independent_route/eleventh_round/biquadratic_power_cover.md`.
Reviewed SHA256:
`99e9935bf703898e509677c0c9e65b52b7d814d8c1c725e622ea715a45172324`.

The fixed degree-four field contains both alpha and its conjugate, since
sqrt(3)=-i sqrt(-3). Their squares, difference, and product give exactly
the four polynomial identities for E, conjugate E, G, conjugate G.
The rational first-square parametrization also satisfies
c0^2-A0=U0^2 identically.

Every factor c0-s U0 is a genuine quadratic since s is not one, with
discriminant 4-3s^2 of nonzero quadratic norm 13. Distinct factors could
share a zero only if U0=c0=0, excluded by U0-c0=1-t and U0(1)=3.
Their leading coefficients also exclude infinity. This gives all eight
distinct simple branch points, not merely an upper bound on their number.

For the two Kummer functions the four valuation vectors are precisely
(1,1), (1,-1), (-1,-1), (-1,1). Over the algebraic closure, the relation
kernel modulo g is the solution set of u+v=u-v=0, of size gcd(g,2).
The displayed square relation realizes the nontrivial even kernel.
There are no further relations because the valuations already force
those congruences; divisors divisible by g on P1 give gth powers up to a
constant, which has a gth root over the algebraic closure. Consequently
the component count and the degree of each component are as stated.

At every branch point the primitive valuation vector gives inertia
order g, including on either even component; the other local unit has a
gth root over the algebraically closed completed residue field. Infinity
and all other points are unramified. Riemann--Hurwitz thus gives exactly
1+(3g^2-4g)/gcd(g,2). For the pure unit twists, etaE etaG lies in mu6 and
has square roots in mu12 contained in the fixed field. The two displayed
even components therefore descend to that field. The claim is correctly
restricted for general coefficients.

The actual lift uses t=(a+U)/b>1 and a positive rational scale k=b0/b;
the common norm identity and signs give U0=kU, not its negative. Both
actual quadratic-domain decompositions have their units retained, with
etaE in mu3 and etaG in mu2. The scale cancels in each ratio. Nonzero
actual norms keep Y,Z and the four factors away from zero, so the point
is on the smooth nonbranch locus and lifts to the normalization. Odd g
absorbs the Gaussian ratio unit, and gcd(g,6)=1 absorbs both in the same
fixed field. No adjoining of all gth roots of unity to the arithmetic
field is needed for these actual changes of coordinates; Kummer degree
calculations were explicitly geometric.

The result is a necessary cover for actual seeds. It asserts neither
a birational identification with DC nor a converse for arbitrary
K-points, nor a height upper bound uniform in g. In particular, genus
growth at varying exponent is not a nonexistence proof. The even seed
locus is excluded by the prior arithmetic CI theorem, not by absence
of the two even geometric components.
