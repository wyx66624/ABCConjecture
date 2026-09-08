# AC3. The actual primitive square/cube branch and all three unit classes

Next-only complete ordinary connecting proposition. It depends on
the new ZD2 two-descent, whose independent review is being completed,
and on the already reviewed CL and CB classifications. No old source
or publication input is changed by this note.

The old sources were actually reread, including their exceptional
domains: DC1 in `tenth_round/double_oriented_covers.md`; RL1--RL4 in
`twelfth_round/rational_biquadratic_locus.md`; HG1/HG3 in
`twelfth_round/hyperelliptic_quotients.md`; CL1--CL3 in
`thirteenth_round/cubic_unit_local_gate.md`; and CB1--CB3 in
`eighteenth_round/next_cubic_same_source_boundary.md`.

## AC3.1. Exact arithmetic statement

There are no positive integers a,b,U,Q with gcd(a,b)=1 satisfying

    M=a^2+ab+b^2=U^2,
    F=a^4+3a^3*b+5a^2*b^2+3a*b^3+b^4=Q^3.        (AC3.1)

The displayed M and F are essential to the statement. This is an
exclusion for this precise primitive two-parameter family and these
two actual perfect-power conditions, not a claim about arbitrary
cubes, arbitrary rational points of another curve, or all ABC seeds.
Here Q>1 follows from F>=13 and does not need to be an extra assumption.

Proof, with the full extraction and ramification checks. Set c=a+b,
and let O=Z[zeta], where zeta^2-zeta+1=0 and conjugation sends zeta
to 1-zeta. The positive norm is N(x+y*zeta)=x^2+xy+y^2. The actual
second element is

    z=ab+M*zeta,
    N(z)=(ab)^2+ab*M+M^2=F.                       (AC3.2)

It is primitive, since a prime dividing both ab and M would divide
both a and b. Also F=1 modulo three: modulo three its polynomial is
(a^2+b^2)^2, which equals one whenever a,b are not both divisible by
three. Thus z has no ramified factor above three.

The Eisenstein ring is norm Euclidean. For example write any complex
quotient in the real basis 1,zeta, and round both coordinates to
integers. The error norm is at most 3/4<1, giving Euclidean division.
Thus O is a UFD. Its units are the six elements of norm one,
namely the powers of zeta. An inert rational prime dividing N(z)
would divide z itself as a rational integer and hence both its
coordinates. At a split rational prime, both conjugate prime factors
cannot occur in z for the same reason. Therefore every prime in
F splits, and z contains exactly one orientation above it. Its
exponent in that orientation is its exponent in the rational norm F.

Under (AC3.1) all those exponents are multiples of three. Consequently
there is an exact equality in O

    ab+M*zeta=epsilon*(S+T*zeta)^3,                 (AC3.3)

where S,T are integers, gcd(S,T)=1, and S+T*zeta is unramified at
three. Its norm is Q. The unit epsilon is a power of zeta. Write
its exponent as j+3e with j in {0,1,2}; absorbing (-1)^e in the
cube root gives (AC3.3) with exactly one of

    epsilon=1, zeta, zeta^2.

In particular this is an actual integral factorization, not an
arbitrary rational power-map output whose content might change
the desired residual. A numerical unit residual really gives an
Eisenstein unit here. No additional nonunit coefficient has been
introduced or discarded.

The first norm has no ramification at three either. Indeed if a is
not congruent to b modulo three, M is a unit. Otherwise primitivity
makes them units, and M=(a-b)^2+3ab has valuation exactly one at
three. Since M=U^2, this latter case cannot occur; hence 3 does not
divide M. Also a=b would imply the primitive seed (1,1), for which
M=3 is not a square. Therefore a!=b, and the actual rational numbers

    r=ab/M,
    v=c/U,
    w=(a-b)/U

satisfy exactly

    0<r<1/3, v>0,
    v^2=1+r, w^2=1-3r.                            (AC3.4)

The strict inequality follows from M-3ab=(a-b)^2>0. The equations
use c^2=M+ab and (a-b)^2=M-3ab. In particular both square roots
are nonzero. If the coordinates of epsilon*(S+T*zeta)^3 are A,B,
(AC3.3) gives B=M!=0 and A/B=r at the very same source [S:T].
Thus (AC3.4) gives a rational point on the positive smooth chart
of D_(3,epsilon). It is not a pairing of independently chosen
points on two quotient curves. Its actual conic parameter is

    t=(v+w+2)/(v-w)=(a+U)/b>1.                     (AC3.5)

The denominator equals 2b/U and cannot vanish. The positive chart
avoids all three target branch values -1,1/3,infinity, so the
normalization introduces no ambiguity. Sources at infinity remain
allowed throughout (AC3.3) and the projective constructions.

Each of the three unit possibilities is now excluded in its own
proved domain:

* epsilon=1: CL2 gives D_(3,1)(Q3) empty. In this integral setting
  one can also use the simpler check that the second coordinate
  of (S+T*zeta)^3 is 3ST(S+T), contradicting 3 not dividing M.
* epsilon=zeta: CB2 gives exactly twelve rational points, all
  with r=0 and t in {infinity,1,-1,-1/2}. None satisfies (AC3.4).
* epsilon=zeta^2: ZD2.6 gives exactly six rational points, all
  with r=-1 and t in {0,-2}. None satisfies (AC3.4).

This exhausts all six original units because their two signs were
absorbed into the integral cube root. It proves (AC3.1). No
conjugation between the two nontrivial unit classes is used.

## AC3.2. Geometric propagation for each odd multiple of three

For every odd g>=3 divisible by three and each epsilon in
{1,zeta,zeta^2}, the smooth projective curve D_(g,epsilon) has no
rational point with finite base parameter t>1. The identity-unit
curve has the stronger empty full Q3-locus already proved by CL.
Only the positive locus is asserted empty for the other two units.

Proof. Put k=g/3, a positive odd integer. Define L_(epsilon,n) as
the projective coordinate ratio of epsilon*(S+T*zeta)^n, exactly
as in RL/HG. Its two coordinate polynomials have no common
projective zero, so it is a morphism P1->P1 of degree n. The
actual algebraic power identity gives

    L_(epsilon,g)=L_(epsilon,3) composed with L_(1,k). (AC3.6)

On the dense chart of the normalized fiber product D_(g,epsilon),
send (t,s) to (t,L_(1,k)(s)). This defines a nonconstant rational
map to D_(3,epsilon); its t coordinate remains the same
nonconstant function. The source and target are the geometrically
connected smooth projective curves supplied by HG for odd indices.
The function-field map therefore extends to a morphism everywhere.
One can equivalently retain the two square roots v,w and replace
only the source coordinate using (AC3.6). This describes the same
map and verifies its common-source character.

Any rational point with finite t>1 maps to a rational point of the
cubic target with that same t. It lies in the positive domain
0<r<1/3, v>0 from HG3. The cubic exclusions just listed give a
contradiction. This also includes source parameters at infinity
or ramified inputs because the map has been extended projectively.
No count of all boundary preimages at larger g is claimed. The
higher Gaussian curve C_(g,epsilon) has no positive rational point
either, by its forgetful map to D_(g,epsilon); no extra Gaussian
obstruction is being asserted.

## AC3.3. Exact numerical propagation and remaining branches

As a direct numerical corollary, for any positive integer g
divisible by three there is no positive primitive pair a,b with
M a square and F=Q^g. Indeed write F=(Q^(g/3))^3 and apply
AC3.1. This numerical statement also permits even g; it does
not assert geometric connectedness of an even-index BK model.

In particular, if h is positive and even, g is positive with
3 dividing g, R,Q>1, and the actual norm equalities are

    M=R^h, F=Q^g,

they cannot hold for a positive primitive seed. The exponents
need not share a prime factor: the pair h=2,g=3 is included.
For more general written profiles the applicable conditions are
the actual total equalities M being a square and F being a cube,
not the labels or a chosen extraction convention for h and g.

This does not cover the ramified first shape M=3R^h with h even,
whose three-adic valuation is one and which is not a square.
It does not cover a nonunit residual V in F=VQ^g unless that
total F is itself a cube, nor a first residual making the total
M nonsquare. Odd indices not divisible by three and arbitrary
moving coefficients remain outside the propagation above.
No uniform height estimate or classification of all primitive
ABC triples is derived. The precise accomplishment is the
complete exclusion of the specified unramified square/cube
intersection inside the actual two-norm family.

Dependency snapshots actually read for this connection include
DC SHA256 `fe2b9bfa8a762d0478973a35d43a25a50fef7edb5d19f16f7caed62067c0ce87`,
CL `7155854c4ff116a07602aef08bfc2e505afb0bb9e83dd1f6a17a8e8076112a42`,
CB `e68c6dc1102248f1db9f3dcf772acc4bd79a679a122534efe6488e3986b90ff4`,
and ZD2 `ecbd3ace69864dd32541157d013f82c6260fda2eac2274a54c839f967bb55d5a`.
No new computation or Lean formalization is claimed in this connecting
proof. The smooth-projective extension input is the same Stacks
Project Section 53.2 (tag 0BXX) used in CL/CB/RL/HG.
