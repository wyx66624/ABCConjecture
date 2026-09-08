# Full ordinary review of the distinct squared-unit quotient

Reviewer: critical_bottleneck. Status: PASS after actual complete source
reading, including the entire next-step/scope paragraph.

Reviewed source:
research/checkpoints/2026_09_07_independent_route/nineteenth_round/
next_zeta_squared_quotient.md

Actual SHA256:
b377e669c64b050e5fffbda3b502b412cf92e3c3a90cb105f211a0b7871d679a.

The multiplication by zeta squared gives (-A0-B0,A0) with the stated
coordinate convention. The first quotient is exactly the squarefree
quintic -3s(s+1)(s^3-3s-1), including its single rational branch
at infinity. The original same-source second square is 4-3v^2.
The range 1<v<2/sqrt(3), both allowed nonzero ordinate signs, and
the inverse t=(v+w+2)/(v-w)>1 all use the actual positive domain.
The three rational hyperelliptic branches have v=0, w=+/-2 and
parameters t=0,-2; they are not incorrectly excluded by a
denominator restriction.

The homogeneous order-three transformation sends both A0 and B0
to their negatives. The minus sign on the y lift is essential and
correct. It fixes v, and its three distinct powers prove the
function-field degree is exactly three rather than leaving a
cubic irreducibility assumption. The only fixed sources satisfy
s^2+s+1=0; each has two fixed points with A0=-3s and B0=-3.
Their four v values are the simple roots of v^4-v^2+1.
The source triples at v=0 and v=infinity are explicitly
unramified, consistent with the actual projective morphism.
The discriminant formula 81(v^4-v^2+1)^2 has the correct sign
and does not replace this branch analysis.

The two rational two-torsion divisor classes are nonzero. Their
sum is nonzero by the literal one-infinity pole basis: the only
functions with pole at most two are the span of 1,s, which cannot
vanish at the two distinct required abscissas. This establishes
the subgroup (Z/2Z)^2 and makes no complete-torsion assertion.

The expansion S=T+3K has A0=-3(T^3-9K^2T-9K^3); after division
of -A0B0 by nine, its three-adic unit is 2T^6, a nonsquare.
This excludes the complete projective residue class, not a
finite collection of lifts. In each other primitive residue
class, A0 is a unit and exactly one of S,T,S+T has positive
valuation unless it is zero; the necessary odd valuation and
all branch exceptions are retained. The author correctly states
that S=T was already excluded by the actual unramified-root
condition and does not market it as a new global obstruction.

No source correction is requested. The rank upper bound,
rational-point sieve, full positive-locus classification and
varying-family uniformity are all left open. This record is a
mathematical source review, not a new finite replay, software
rank calculation, compiler run or PDF transcription review.

## Independent added Z2.4 audit and actual finite replay

The subsequently added Z2.4 was read in full; the earlier three
sections were not changed mathematically. Final reviewed ordinary
SHA256:
8175504e0746e69219401f123b81b822ba6ba0f7a036afc638425ec797e088d5.

The complete finite script was read and independently executed in
read-only --check mode. Its source SHA256 is
cf0563d5d31c67ce2c8d90fec0045eb38ca0050194b9c78f4f9c076a5ff9e661.
The actual execution passed and matched canonical SHA256
66ce937b9a33a5300f08b128f630b3b47ddaeee80b28b7f5a77427ed30c06b6c.
Both quadratic field presentations are checked irreducible; every
prime-field and quadratic-field square fiber is enumerated and
the single infinity included. The counts 3/25 and 9/37 give
the displayed characteristic polynomials and orders 12/52.

The ordinary interpretation is also PASS. A rational elliptic
factorization of the Jacobian would yield integer traces a+b=3,
ab=-6 at five, hence (a-b)^2=33, impossible. This establishes
Q-simplicity only. Prime-to-p reduction at both five and seven,
including their separate primary cases, bounds all rational
torsion by gcd(12,52)=4; the previously constructed subgroup
attains it. The rational order-three automorphism and genus-zero
quotient give 1+rho+rho^2=0, making the rational Mordell--Weil
space a Q(sqrt(-3)) vector space, so the rank is even.

Under the explicit additional rank-zero hypothesis, the fourth
torsion class cannot be the Abel--Jacobi image of a rational
point. The noncanonical effective degree-two divisor P0+Pm has
one-dimensional Riemann--Roch space, so its only effective
representative is itself; it cannot be R+Pinf. Together with
injectivity of the point embedding this proves the stated
conditional three-branch-point classification. No rank-zero
upper bound is supplied or assumed silently. The new finite
execution certifies the finite inputs, not that unproved rank.
