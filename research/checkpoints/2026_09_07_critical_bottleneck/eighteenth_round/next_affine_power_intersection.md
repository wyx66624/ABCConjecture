# AI1--AI4. Uniform intersection counts for affine outputs and the original root chart

Next-only ordinary candidate, 2026-09-07. Not part of the currently
reviewed LM paper. This examines the additional compression constraint
left open there. It proves a uniform finite intersection count for the
original one-parameter root chart, including bounded integer residuals.
It is not a statement about all primitive two-coordinate Eisenstein
roots, changing exponents, or nonlinear output maps.

Let O=Z[zeta], zeta^2-zeta+1=0, with the same coordinate determinant
and positive definite norm N as LM. Let n>=2 and B>=n be integers.
For real x>=B write

    Z(x)=(3x+zeta)^n=A(x)+C(x)zeta.

All real lines below are affine lines in the two real coordinates of O.

## AI1. A strict curvature identity on the entire real root chart

The two derivatives A'(x),C'(x) are positive, and

    det(Z'(x),Z''(x))
      =-27 n^2(n-1) N(3x+zeta)^(n-2) < 0.             (AI1)

Consequently every real affine line meets {Z(x):x>=B} in at most
two points. The same holds after any invertible real linear change
of its two coordinates.

Proof. As in LM5, theta(x)=arg(3x+zeta) is positive and less than
1/(3x). Hence (n-1)theta(x) lies strictly between zero and pi/3.
The identity Z'(x)=3n(3x+zeta)^(n-1) therefore has both coordinates
positive. Also Z''=9n(n-1)(3x+zeta)^(n-2). Multiplication by an
element W multiplies coordinate determinants by N(W), and
det(3x+zeta,1)=-1. This proves the exact identity (AI1), including
the constant 27 and the exponent n-2.

Since A'>0, use A as a real coordinate on this curve. Its other
coordinate is a smooth function C=F(A), with

    F''(A(x))=det(Z'(x),Z''(x))/A'(x)^3 < 0.

Thus it is strictly concave. A vertical line meets the graph once
at most. If a nonvertical line met it at three ordered abscissae,
strict concavity would place the middle point strictly above the
chord joining the two outer points, a contradiction. An invertible
linear map takes affine lines to affine lines under its inverse,
so the intersection count is unchanged. QED.

## AI2. The fixed-content selector has at most two pure intersections

Let Z1=Z(k1),Z2=Z(k2), B<=k2<k1, and D=Z1-Z2. Write
Delta=det(Z1,Z2)>0. In an LM fixed-content progression, the outputs

    V_j=(Z2+(t_*+Hj)D)/g,   j>=1,

lie on the single actual affine line

    det(D,V_j)=Delta/g.                               (AI2)

The outputs are distinct. At most two of them can equal Z(k) for
an integer k>=B. If g=1 and the selector has the LM nonempty disjoint
packets, there are NO such equalities.

For the complete collection of all CRT selectors t of these same
two roots, before content is frozen, there are at most

    2 tau(|Delta|)                                    (AI3)

parameters t whose primitive output equals Z(k), k>=B.

Proof. D has positive coordinates, H/g>0, and hence the outputs in
the progression are distinct. Taking the determinant with D gives
(AI2), because det(D,Z2)=Delta. AI1 bounds the line intersection
by two. If g=1, the two distinct known intersections are precisely
Z(k2) and Z(k1); there is no third real intersection in x>=B.
The equality Z2+tD=Z2 or Z1 forces t=0 or 1, both excluded by the
nonempty CRT packets. This proves emptiness in this case.

For arbitrary selector t, LM2 proves that g_t is a positive divisor
of |Delta|. For each such g the outputs lie on its one line, and
AI1 supplies at most two possible Z(k). For fixed g and fixed output,
the nonzero vector D determines t uniquely. Summing over the divisors
proves (AI3). This is only an upper bound; no existence of any of
these possible intersections is asserted. QED.

## AI3. A uniform bound allowing all small integer residuals

Let V_j=V_0+jV_1 be ANY affine integer progression in O with V_1!=0.
It need not come from LM or satisfy any content assumptions. Fix a real
X>=1. Then the number of positive integer parameters j for which

    V_j=tau(3k+zeta)^n,
    tau in O\{0},  N(tau)<=X,  integer k>=B             (AI4)

is at most

    2[(2 floor(sqrt(2X))+1)^2-1] < 30X.               (AI5)

If either (3k+zeta)^n OR its complex conjugate is allowed in AI4,
the bound is less than 60X. All six possible unit multipliers are
already included in tau. The constants are independent of n,B, the
affine line, the packet primes, and their depths.

Proof. For each nonzero tau, multiplication by tau is an invertible
real linear map with determinant N(tau)>0. By AI1 its image curve
meets the line of V_j at most twice. Since V_1!=0, each output fixes
j uniquely. Summing over tau is an upper bound even if different
representations yield the same output.

If tau=a+b zeta, then N(tau)>=(a^2+b^2)/2. Thus N(tau)<=X forces
|a|,|b|<=floor(sqrt(2X)), giving at most
(2 floor(sqrt(2X))+1)^2-1 nonzero possible integer pairs. For X>=1,

    (2 sqrt(2X)+1)^2 <= (9+4sqrt(2))X < 15X.

This proves AI5. Conjugation is another invertible real linear map;
the union of the two orientation counts gives the bound 60X. QED.

This is a statement about actual integer outputs and actual residuals,
not a formal assignment of prime labels. It does not require a residual
to be n-power-free or coprime to the input norm. Those restrictions
would only shrink the counted set.

## AI4. Consequence for transfer from the positive-density LM family

Apply AI3 to the fixed-data progression of LM4. For every real L>=0,
there are fewer than 60 exp(nL) parameters in the ENTIRE progression
with a representation in either orientation whose residual satisfies

    log N(tau) <= nL.                                 (AI6)

More generally, for any X(J)>=1 with X(J)=o(J), the number among
1<=j<=J with such a representation and N(tau)<=X(J) is o(J).
Since LM's good set has fixed-data density at least 1/4, all but
o(J) of its good indices up to J have no such representation.
For example, for each fixed 0<eta<1, all but a zero-density subset
of the good indices have no representation with N(tau)<=j^eta.

Proof. Use AI3 with X=exp(nL) for the first assertion. For the
second, the bound is 60X(J)=o(J). For the example, a parameter
j<=J with residual at most j^eta also has residual at most J^eta,
so at most 60J^eta indices are excluded. Intersecting with the
LM good set only decreases this count. Its positive density comes
from the independently proved complete squarefree sieve. QED.

The logarithmic residual budget in AI6 is written explicitly rather
than silently choosing between conventions for a compression parameter.
Any proposed small-parameter convention implying AI6 is subject to
this bound on this particular root chart.

This conclusion shows why the paid affine outputs cannot simply be
identified with many same-index outputs in the original root chart.
It does not preclude a finite useful intersection, a transfer between
different outputs, a varying exponent, a different root parameterization
with two independent coordinates, or a nonlinear selector. Although
the finite 60X bound is uniform, the LM positive-density asymptotic
has fixed-data thresholds; no uniform proportion for moving n and
moving packets follows without checking those thresholds separately.
Nothing here controls the original roots' far signed costs, their
exceptional set, or the complement of a multiplicatively independent
domain. No new finite computation, Lean or paper transcription is
claimed for this next-only note.
