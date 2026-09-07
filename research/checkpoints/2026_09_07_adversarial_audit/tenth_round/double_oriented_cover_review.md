# Independent review of two actual oriented norm profiles

Date: 2026-09-07. DC1--DC4 complete ordinary review: PASS.
The initial complete source had SHA256
`71c7dd907b69e3fb5fea39b602ef706fdf4700d9ceed37cfd1a6df81d200d374`.
The subsequent removal of the unnecessary g-free assumption was
independently checked, and all changed passages were actually reread.
Final reviewed source:
`2026_09_07_independent_route/tenth_round/double_oriented_covers.md`,
SHA256 `94d6c47a9a44ac6682e6285e17bc7dd6942d9cc69f1ab93fa1a60f14017dd884`.

## Numerical second profile to actual Eisenstein factors

The norm identity N(ab+M*zeta)=F is exact. Primitivity of a,b implies
gcd(ab,M)=1, and the actual quartic is prime to three. Thus z1 is an
actual primitive unramified Eisenstein integer. Its norm has no inert
prime factor, and only one orientation at each split prime can divide
z1. Euclidean factorization in the quadratic ring gives the stated
actual product, with a single overall unit and norm-q prime generators.

Given F=V1*Q^g, each exponent is exactly v_q(V1)+g*v_q(Q). Both
summands are nonnegative; no upper bound on v_q(V1) is necessary.
They can therefore be assigned directly to v1 and w1 in the same
actual orientation. Their norms are exactly V1 and Q, and they inherit
primitivity and unramified support. Their supports may overlap, as the
statement allows. Removing the g-free restriction is consequently a
valid strengthening; it was not needed elsewhere in the proof.

The proof gives actual mathematical elements without claiming a
practical factorization algorithm has already factored every seed.
It works for g>=2 and does not require the degree-eight QC domain.
The elementary 2,3,5 exclusions justify Q>=7 from Q>1.

## Exact coefficients and geometric cover

Dividing the two actual factorizations by their conjugates produces
the stated inverse coefficients eta0 and eta1. The unit quotients
are u_i^2 and the first ramified factor contributes zeta^e. No h-th
or g-th root of a unit is taken. The exact oriented ratio-height
formula gives half log V_i, including unit residuals. The arithmetic
field is the fixed quadratic field; no generic quartic unit-class
representative is needed.

For G/zeta the discriminant is -1-3zeta, whose norm is thirteen.
Thus its two roots and their conjugate pair are each simple.
The difference G-Gbar equals (zeta-bar(zeta))*N. At a root of N
both G and Gbar equal the nonzero coordinate X. Hence the four
zeros/poles of G/Gbar are distinct and disjoint from the two first
branch values. Its value at infinity is nonzero, so infinity is
unramified. A simple valuation gives geometric degree g even for
composite g; all four inertia indices are g.

The first cover has degree h and just its two simple branch values.
Over the algebraic closure both covers are Galois. Their intersection
can ramify only in the intersection of the two branch sets, which is
empty. Riemann--Hurwitz excludes a nontrivial connected unramified
cover of P1, and the algebraically closed constants exclude a constant
extension. The two fields are therefore disjoint and the compositum
has degree hg for arbitrary gcd(h,g). The total ramification gives
genus 1+2hg-g-2h exactly. Arithmetic roots of unity are not silently
adjoined to K0 in this geometric argument.

The actual x is outside every zero and pole; its Kummer coordinates
are nonzero. The corresponding partial derivatives are units in
characteristic zero, so this actual affine point is smooth and lifts
over K0 to the normalization. No converse for arbitrary curve points
is asserted. The h=g=2 genus-three check is consistent with the older
two-square-class geometry and does not assert an excluded seed exists.

## Cumulative counts, coefficient heights, and exponent regimes

The norm-ball bounds count O(X_i) actual residual elements over each
whole range, including all possible norms. Unit choices contribute
only fixed constants. Their product is O(X0*X1); neither a second
norm summation nor an exponent-dependent unit-class factor is required.
The factors chosen above belong to those residual balls, irrespective
of whether the numerical V1 is g-free.

After clearing the linear and quadratic denominators, the coefficients
are fixed algebraic numbers times eta0 or eta1. Their count is fixed
independently of h,g. Thus both the individual and projective coefficient
heights have the stated O(1+log V0+log V1) bound. This does not construct
small representatives of every generic class in the earlier QC list;
it uses actual compatible quadratic norm profiles. The QC6 obstruction
for unrestricted generic unit classes is unaffected.

The actual first and second norm bounds imply the two height lower
bounds in DC13. With T=max(h,g), their maximum is at least
(T/4)log 7-log 2; in the second case this uses log(13)/4<log 2.
The coefficient bound and log h+log g<=2log T give DC15 under DC14.
Both lambda_i tending to zero force both exponents to infinity and
sum log V_i/T<=lambda0+lambda1. They also make the logarithm of the
cumulative model count sublinear in T. These conclusions require no
restriction on h/g or on their common divisors.

## Scope

This is a genuine simplification of the actual coefficient construction
and a necessary height separation. It proves no actual sequence exists
and gives no point-height upper bound. Large genus or a small model list
alone does not exclude high points. The proposed uniform point-height
inequality remains a clearly marked unproved sufficient input. The
fixed residual threshold, arbitrary roots and the general ABC problem
remain open. No Lean verification of the cover theory is claimed.
