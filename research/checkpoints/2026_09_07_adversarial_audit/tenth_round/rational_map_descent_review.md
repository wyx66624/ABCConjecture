# Independent review of the rational-map descent

Date: 2026-09-07. RD1--RD3 ordinary proof read in full: PASS.
Source: `2026_09_07_independent_route/tenth_round/rational_map_descent.md`.
Reviewed SHA256:
`0c5071dd7161723efd996e334e68549c0e81db4a9fd60cc5c4e3a7d3869b5cf3`.

## The projective maps

The coordinate polynomials of tau*(T+S*zeta)^n have no common
geometric projective zero. Their two coefficient-conjugate equations
would force both T+S*zeta and T+S*bar(zeta) to vanish, hence T=S=0.
Consequently [A:B] defines an everywhere-defined degree-n morphism.
The rho identity conjugates it to a power map followed by a nonzero
scaling. Its critical points and values are the two beta points for
n>=2; the scale does not move zero or infinity in the rho coordinate.

The degree-two map [XY:X^2+XY+Y^2] has no base point. Its critical
points 1,-1 and values 1/3,-1 are correct. Both poles are simple, and
the infinity chart r(1/t)=t/(1+t+t^2) is unramified at t=0. Thus the
composite has exactly the three displayed branch values. The h inverse
images of each of 1 and -1 are distinct, because these target values
avoid the two branch values of L. The total ramification 4h-2 agrees
with degree 2h. No projective exceptional point was dropped.

## Fiber product and actual points

The two maps to the s-line have disjoint branch-value sets. At each
geometric point of their fiber product, one map is etale. The local
equation therefore has a nonzero derivative in one coordinate, proving
smoothness also over poles and infinity. The homogeneous equation has
the stated bidegree because each defining coordinate pair has no common
zero and each map has its established degree.

The dense-open change of coordinates x=L0(t0), Y=rho(t0), Z=rho(t1)
has the displayed constants in the correct direction. In particular
tau0/bar(tau0)=eta0^(-1), and rho(r(x))=G(x)/Gbar(x).
Inverting rho recovers both t coordinates, so this is a birational
identification with the already reviewed geometrically connected DC
cover. No additional curve component can be supported on the removed
finite set, because the original maps, hence the projections of the
fiber product, are finite. Its smooth connected projective model is
therefore the DC curve after base extension to K0.

The direct Riemann--Hurwitz computation is consistent: there are 4h
distinct branch points on the t0-line, each of inertia g, giving genus
(2h-1)(g-1)=1+2hg-g-2h. No gcd(h,g) condition is needed.

For an actual primitive root with norm greater than one, a zero second
coordinate would force the first coordinate to be a unit. Thus both
actual parameters r_i/s_i exist in Q. Their two images are respectively
a/b and ab/M, with nonzero actual denominators. These give actual
Q-points of the full fiber product. The theorem does not assert that
arbitrary Q-points yield primitive positive integer seeds; no inverse
integrality, positivity, or numerical extraction claim has been inserted.

## Model height and scope

The norm inequality gives the stated coordinate bounds for tau0 and
tau1, including the ramified factor of norm three. The coordinate
coefficients of a power are bounded by 2^n; the product of two degree-h
binary forms introduces at most h+1 summands per coefficient. Therefore
the maximum coefficient bound C(h+1)V0 sqrt(V1) 2^(2h+g) is valid.
For an integral coefficient vector its absolute projective logarithmic
height is at most the logarithm of its maximum absolute coefficient.
This proves the stated O(h+g+log V0+log V1+1) bound.

The expanded rational model has a different height budget from the
sparse quadratic-field model. The proof neither transfers an
exponent-free coefficient bound to the expanded model nor derives an
upper bound for an actual point. It proves a projective compatibility
description and rational descent, not existence of simultaneous profiles,
their impossibility, or ABC. This record contains ordinary mathematical
review only, with no new finite replay or Lean verification claimed.
