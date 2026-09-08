# CB1--CB3. The complete unit-zeta cubic locus is boundary only

Next-only complete ordinary candidate, 2026-09-07. This uses the newly
assembled fixed-curve theorem SM and the previously reviewed exact
projective HG/RL/SS inverse. It does not identify the other nontrivial
cubic unit class with this one, or assert a uniform ABC estimate.

The old sources actually reread for this note are:

* `twelfth_round/rational_biquadratic_locus.md`, RL2--RL4;
* `twelfth_round/hyperelliptic_quotients.md`, HG1 and HG3;
* `thirteenth_round/elliptic_quotient_gate.md`, EQ1--EQ2;
* `thirteenth_round/cubic_unit_local_gate.md`, CL2--CL3;
* `fourteenth_round/simultaneous_elliptic_gate.md`, SS1--SS2.

## CB1. The six points really transfer to the original H1 model

For

    C: W^2=z^6-27z^4+99z^2-9,
    H: y^2=s^6+3s^5-3s^4-11s^3-3s^2+3s+1,

the exact rational chart transformations are

    z=(s-1)/(s+1),     W=8y/(s+1)^3,
    s=(1+z)/(1-z),     y=W/(1-z)^3.              (CB1)

They extend to an isomorphism of the smooth projective curves over Q.
These are not inferred just from the displayed equations: EQ1 proves
the intermediate chart t=(s+1)/(s-1), v=y(t-1)^3, with
v^2=-9t^6+99t^4-27t^2+1. Substitution z=1/t, W=v/t^3 gives
CB1 and its inverse. The underlying polynomial identity is

    (s+1)^6 S((s-1)/(s+1))=64 P(s),

where S and P are the displayed sextic right sides. Smooth projective
extension and the inverse dense charts give the isomorphism, as in EQ.

SM's complete list C(Q)={(+/-1,+/-8),infinity+,infinity-} therefore
gives exactly the following H points:

* z=-1, W=+/-8 maps to s=0, y=+/-1;
* z=1, W=+/-8 maps to s=infinity, y/s^3=+/-1;
* C infinity with W/z^3=epsilon maps to s=-1, y=-epsilon.

The second and third lines are actual chart limits: respectively
y/s^3=W/(1+z)^3 and y=(W/z^3)/(1/z-1)^3. They cover every apparent
zero denominator in CB1. Thus H(Q) consists exactly of its two points
over each of s=0,-1,infinity.

## CB2. The second square exists only at twelve boundary points

Use the actual homogeneous cubic forms of HG/SS:

    A0=S^3-3ST^2-T^3,       B0=3ST(S+T),
    A=-B0,                  B=A0+B0.

The curve D=D_(3,zeta) is the smooth projective normalization of

    v^2=1+A/B,       w^2=1-3A/B.                (CB2)

Its first quotient is precisely H above, with y1=Bv and
y1^2=A0(A0+B0). Its second quotient, at the SAME source [S:T],
has y2=Bw and

    y2^2=(A0+B0)(A0+4B0).                      (CB3)

Every D(Q) point maps to H(Q) under the projective quotient morphism.
By CB1 its source is one of [0:1],[-1:1],[1:0]. At these sources,

|source s|A0|B0|A|B|
|---|---|---|---|---|
|0|-1|0|0|-1|
|-1|1|0|0|1|
|infinity|1|0|0|1|

In particular B is nonzero and r=A/B=0. At each source the second
square in CB3 is exactly B^2. Thus it supplies the two rational
choices w=+/-1, while the two H points supply v=+/-1. No point of
one quotient is being paired with a different source on the other.

There are exactly four distinct rational D points at each of the
three sources, hence exactly twelve in total. The raw biquadratic
equations are smooth there: both square roots are nonzero and the
target value r=0 avoids the branch values -1,1/3,infinity of HG.
Normalization neither merges these points nor adds another branch.

Their actual seed parameter t has the following values:

|v|w|t|
|---|---|---|
|1|1|infinity|
|1|-1|1|
|-1|1|-1|
|-1|-1|-1/2|

For the two middle rows this follows directly from HG's inverse
t=(v+w+2)/(v-w). The first and last rows need their genuine
projective continuation, since the last is formally 0/0. Verify
them instead by the original formulas

    v=(t^2+2t)/(t^2+t+1),
    w=(t^2-2t-2)/(t^2+t+1).

At infinity both ratios tend to1. At t=-1/2 both equal -1.
The four roots of r(t)=0 are exactly infinity,1,-1,-1/2 and
are simple, so these are precisely the projective inverse values.

## CB3. Consequence for the actual pure-profile branch

The positive rational locus in HG/RL/SS requires finite t>1,
equivalently 0<r<1/3 and v>0. None of the twelve points in CB2
passes that domain. Therefore D_(3,zeta) has no positive rational
point of the exact actual-seed type, and neither does its Gaussian
cover C_(3,zeta) over that domain.

In terms of the homogeneous first-root output

    a0=T0^2-W0^2,       b0=W0(2T0+W0),

the four boundary t values give primitive signed pairs respectively
(1,0),(0,1),(0,-1),(-1,0). Thus ab=0 and M=F=1 on every primitive
boundary output. They are not positive seeds and do not have Q>1.
In particular there is no hidden ramified or infinite root input
that restores a positive seed: the exact CI/RL inverse included all
such projective inputs already, and the positive locus is empty.

Consequently no positive coprime integers a,b satisfy

    M=a^2+ab+b^2=U^2,
    F(a,b)=Q^3, Q>1,

in the second Eisenstein unit class zeta modulo cubes of units,
i.e. when the actual oriented decomposition has

    ab+M zeta=zeta w^3,

after absorbing a possible minus sign into w. Such a seed would
give t=(a+U)/b>1 and the actual same-source rational power-map
input by RL; it would contradict the preceding empty positive
locus. Conversely, the old CI/RL theorem was sufficient on this
positive domain, so this conclusion closes that actual branch,
not merely an auxiliary necessary square condition.

There is also a direct propagation within the SAME unit class. For
any odd g=3k, the projective power maps satisfy

    L_(zeta,g)=L_(zeta,3) composed with L_(1,k).

Thus (t,s) maps from D_(g,zeta) to D_(3,zeta) while retaining t.
It is a nonconstant rational map of the corresponding smooth
projective curves and extends everywhere as in CL2. Any rational
point with finite t>1 would map to the impossible positive locus
of CB2. Hence that locus is empty for all odd g divisible by three
in this same coefficient class. No count of all boundary preimages
for these larger exponents is asserted.

The identity unit class was already excluded in CL by a complete
3-adic obstruction. The distinct class zeta^2 is not discarded by
CB: conjugating the Eisenstein coordinates changes the target ratio
r to -1-r, which does not preserve the required positive interval.
One cannot silently treat this conjugation as a positive-domain
isomorphism. General second residuals, the ramified first norm,
exponents not covered here, and uniform point-height estimates
remain outside the present conclusion.
