# SS1--SS4. A same-source elliptic square gate for the nontrivial cubic unit

Status: complete ordinary proof, independently reviewed in full by root,
critical_bottleneck and adversarial_audit.
New fourteenth-round work; all thirteenth-round publication sources remain
frozen. No rank upper bound or rational-point completeness output is used.

Throughout this note the unit is u=zeta and the exponent is g=3. This is
one of the two nonidentity unit classes left open by CL. Use the established
HG and EQ models, but distinguish the power-map parameter s from the
positive seed parameter t. Put

    A0=s^3-3s-1, B0=3s(s+1), A=-B0, B=A0+B0.

The smooth projective curve D=D_(3,zeta) is the normalization of

    v^2=1+r(s), w^2=1-3r(s), r=A/B.                 (SS1)

It is geometrically connected of genus six by HG. Its positive rational
locus means the rational points with 0<r<1/3 and v>0. On this locus

    t=(v+w+2)/(v-w)>1                              (SS2)

recovers the seed parameter. The first genus-two quotient is
H1:y1^2=A0(A0+B0), with y1=Bv, and the second is
H2:y2^2=(A0+B0)(A0+4B0), with y2=Bw. The two square roots must have
the SAME parameter s. No assertion below replaces this by two separately
chosen quotient points.

## SS1. A degree-four equation over the fixed elliptic curve

Define the following polynomials, all in Q[X]:

    f=X^3-9X-9,             h=X+2,
    H=f+18h^2=X^3+18X^2+63X+63,
    R=f-108h^2=X^3-108X^2-441X-441,
    J=6Xh,                 d=4X+9.

Over the elliptic curve E:Y^2=f, the equation

    Z^4-2H Z^2+fR=0                               (SS3)

defines, after normalization and smooth projective completion, a curve
isomorphic over Q to D. In particular it is geometrically connected,
has genus six, and its map to E has degree four.

Proof. On the chart s not equal to -1 put

    X=-(2s^2+5s+2)/(s+1)^2,
    Y=y1/(s+1)^3, Z=y2/(s+1)^3,
    kappa=(s-1)/(s+1), gamma=(A0+B0)/(s+1)^3.     (SS4)

The established first quotient identity gives Y^2=f. The following
identities can also be verified by clearing powers of s+1:

    kappa^2=d, B0/(s+1)^3=-3h,
    gamma=(-X*kappa-3h)/2,
    Y^2=gamma^2+3h*gamma,
    Z^2=gamma^2-9h*gamma=H+J*kappa.              (SS5)

For example A0/(s+1)^3=gamma+3h; the two formulas for the square
coordinates follow directly by multiplying the corresponding two cubic
factors. The sum of these two normalized cubic coordinates is -X*kappa,
which gives the formula for gamma.

Direct polynomial expansion gives

    H^2-fR=J^2 d.                               (SS6)

Thus eliminating kappa from Z^2=H+J*kappa and kappa^2=d gives (SS3).
Conversely, on the open where J and 1-kappa are nonzero, define

    kappa=(Z^2-H)/J, s=(1+kappa)/(1-kappa),
    y1=Y(s+1)^3, y2=Z(s+1)^3.                   (SS7)

Equations (SS3) and (SS6) give kappa^2=d. The first identity of (SS4)
then holds, and the polynomial identities (SS5) recover the two original
hyperelliptic equations and the common parameter s. These are inverse
maps of nonempty dense opens.

To justify that the quartic equation has the claimed single function
field, note that D->H1 and H1->E each have degree two, by HG and EQ.
Hence Q(D) has degree four over Q(E). Formulas (SS4) put Z in Q(D),
while (SS7) recover all of Q(D) from Q(E)(Z). Thus (SS3), which is
monic of degree four, is the minimal polynomial of Z. The same argument
over the algebraic closure applies to the geometrically connected
curves and their degree-two maps, proving geometric irreducibility.
The smooth projective models are therefore isomorphic, by the standard
extension theorem for maps of nonsingular projective curves. QED.

## SS2. The exact positive rational domain, with all chart exceptions

The positive rational locus of D is in bijection with the rational triples
(X,Y,Z) satisfying

    Y^2=f(X), Z^4-2H(X)Z^2+f(X)R(X)=0,
    0<Z^2<R(X), Y(X+2)>0.                       (SS8)

This is a bijection of points on the indicated curves with their marked
power-map parameter. It does not assert a unique power-map point above
each integer seed when g=3.

Proof of the forward direction. On the positive rational locus, s=-1
and s=infinity do not occur: their homogeneous r values are respectively
0 and 0. Thus (SS4) is defined. Also r=3h/gamma, v=Y/gamma,
w=Z/gamma. Subtracting the last two equations of (SS5) gives

    Delta:=Y^2-Z^2=12h*gamma,
    r=36h^2/Delta.                              (SS9)

Here h is nonzero: h=0 forces s=0 or infinity in the projective
abscissa relation of EQ, and those have r=0. Since 0<r<1/3,
Delta>108h^2>0. Consequently Z^2<f-108h^2=R. Moreover w cannot
vanish at a rational positive point: w=0 would give 3v^2=4, impossible
for rational v. Thus Z^2>0. Delta>0 implies that gamma and h have
the same sign, so v>0 is exactly Yh>0. This proves (SS8).

Conversely suppose (SS8). The value X=0 is impossible because f(0)=-9.
The value X=-2 is impossible because then f=H=R=1, J=0, and (SS3)
becomes (Z^2-1)^2=0, inconsistent with 0<Z^2<R=1. Hence J is
nonzero. Define kappa by (SS7). Identity (SS6) gives kappa^2=4X+9.
If kappa=1 or -1 then X=-2, already excluded. In particular s in
(SS7) is finite and is not -1. The equations of H1 and H2 therefore
hold at this same rational s. Define

    Delta=f-Z^2,
    gamma=Delta/(12h), v=Y/gamma, w=Z/gamma.     (SS10)

The inequality in (SS8) implies Delta>108h^2>0, so these expressions
are all defined. Identities (SS5), or equivalently the identity

    (f-Z^2)^2=36h^2(3f+Z^2)                    (SS11)

obtained by rearranging (SS3), show that these are exactly B-normalized
coordinates satisfying (SS1). More explicitly (SS7) and (SS5) recover
gamma=(-X*kappa-3h)/2; subtracting the two square equations recovers
(SS10). Then r=36h^2/Delta lies strictly between 0 and 1/3, and
Yh>0 makes v positive. This produces the required positive point.
The two constructions are inverse by (SS4)--(SS7). QED.

All points on this real rational domain are away from the branch values
in HG, so passage to the normalization does not introduce an extra
choice of local branch in this bijection. The elliptic point O corresponds
under EQ to s=-1, and has already been excluded by positivity. The
potential discriminant-zero value X=-9/4 is also not an E(Q) point,
since f(-9/4)=-9/64. Thus no missing infinity or repeated-root branch
can supply a positive rational point omitted from (SS8).

Together with CI and RL this is an effective sufficient as well as
necessary test for the actual unit-zeta first-square/second-cube branch:
a rational triple passing (SS8) reconstructs t by (SS2) and hence a
primitive positive integer seed with those pure norm profiles. It is
not asserted that such a triple exists. The two choices of sign of Z
retain the two ordered seed directions.

## SS3. An integral factorization and exact prime-depth consequence

Write a point of (SS8) in primitive integral Weierstrass coordinates

    X=A/d0^2, Y=B/d0^3,
    d0>0, gcd(A,d0)=gcd(B,d0)=1.                 (SS12)

Such coordinates exist for every rational point on a short integral
Weierstrass equation: at a prime of negative X-valuation the leading
cubic term has uniquely smallest valuation, so that valuation is even
and the Y denominator has the corresponding exponent three. At all
other primes the equation makes Y integral too. Define K=A+2d0^2.
Then C=Z*d0^3 is an integer, and the following identities hold:

    B^2=A^3-9A*d0^4-9d0^6,
    (B^2-C^2)^2=36d0^2 K^2(3B^2+C^2),
    L:=(B^2-C^2)/(6d0 K) is an integer,
    L^2=3B^2+C^2.                              (SS13)

For every prime p>3 dividing d0*K there is the exact equality

    v_p(B^2-C^2)=v_p(d0*K),                     (SS14)

and p does not divide B, C or L. Thus the entire p-primary part of
d0*K divides exactly one of B-C and B+C, with no excess depth in
that factor. No assertion about primes 2 and 3 is included in (SS14).

Proof. Let H0=d0^6 H(A/d0^2) and R0=d0^6 R(A/d0^2); these are
integers. On multiplying (SS3) by d0^12, the rational number C is
a root of the monic integer polynomial

    C^4-2H0 C^2+B^2 R0=0.

A rational algebraic integer is an integer, proving the claim about C.
Clearing denominators in (SS11) gives the second identity of (SS13).
The nonzero integer 6d0*K has its square dividing (B^2-C^2)^2;
comparison at every prime gives 6d0*K dividing B^2-C^2. This proves
L is integral and its displayed square equation. K is nonzero by SS2.

Since gcd(d0,K)=1, a prime p>3 dividing d0*K has two disjoint cases.
If p divides d0 then B^2 is congruent to A^3, a unit modulo p. If p
divides K then d0 is a unit, A is congruent to -2d0^2 and the first
identity of (SS13) gives B^2 congruent to d0^6, again a unit. The
second identity forces C^2 congruent to B^2 modulo p. Thus C is a
unit and 3B^2+C^2 is congruent to 4B^2, a unit. Taking valuations
in that identity gives (SS14), and the L equation gives p not dividing
L. Since p is odd and B is a unit, p cannot divide both B-C and B+C.
Their product is B^2-C^2, proving the complete allocation statement.
QED.

This is an exact necessary factorization on actual candidate points.
It does not give an upper bound for d0, A or the point height, and it
does not force the existence of a prime violating the allocation.

## SS4. A rational three-isogeny between the two elliptic quotients

The two elliptic curves in EQ are already isogenous over Q by degree
three. More explicitly, let

    F3(X)=X+36/(X+3)-36/(X+3)^2,
    F3'(X)=1-36/(X+3)^2+72/(X+3)^3.

Then the chart map

    phi:E -> E', (X,Y) |-> (F3(X), Y*F3'(X))    (SS15)

extends to a degree-three isogeny over Q. Its geometric kernel consists
of O and (-3,+3i), (-3,-3i). Consequently the previously established
isogeny Jac(H1)~E x E' strengthens to

    Jac(H1) ~ E x E over Q.                     (SS16)

Proof. Clearing (X+3)^6 verifies the rational-function identity

    f(X) F3'(X)^2 = F3(X)^3-189F3(X)+999.        (SS17)

Thus (SS15) is a nonconstant rational map between the smooth projective
elliptic curves and extends everywhere. As X tends to the pole at O,
F3(X) has the same leading term X, so O maps to O. The standard
origin-preserving morphism theorem makes the extension a homomorphism.
The rational map F3 on P1 has degree three: its numerator is cubic,
its denominator is (X+3)^2, and the numerator at X=-3 is -36, so
there is no cancellation. Since the two elliptic abscissa maps each
have degree two, their commutative diagram with F3 shows that phi
has degree three. The only poles of F3(X) on E are O and the two
points X=-3, for which Y^2=-9. These are exactly the preimages of O
under phi, giving the stated kernel in characteristic zero. Composition
with the EQ isogeny proves (SS16). QED.

As a check useful for the arithmetic orientation, for the points from
EQ one has

    phi((-2,1))=(-2,37)=-3(6,9) on E'.          (SS18)

Indeed 2(6,9)=(33/4,9/8); its secant with (6,9) has slope -7/2,
giving 3(6,9)=(-2,-37). This identity is proved by the rational
addition law, independently of any GP rank or generator assertion.

The isogeny identifies the two rank contributions; it does not prove
rank one for E, a Mordell--Weil basis, or that the simultaneous gate
has no points. Even after (SS16), the same-source condition (SS3)
and the real-domain inequalities cannot be discarded.

## Dependencies and next unresolved step

The ordinary arguments use the already reviewed HG, CI/RL and EQ
statements. The two newly invoked standard facts were checked in
their primary sources: the Stacks Project, Lemma 53.2.2 and Theorem
53.2.6 (https://stacks.math.columbia.edu/tag/0BXX), for extension and
smooth projective models; Milne, Elliptic Curves, Chapter II,
Proposition 1.5 (https://www.jmilne.org/math/Books/EC2.pdf), for the
group-homomorphism property of an origin-preserving morphism.

The note provides a concrete rational-point problem on one fixed
elliptic curve with a quartic auxiliary equation, a reversible positive
chart, and an integral factor-allocation condition. Solving that
simultaneous rational-point problem remains open here. It is not a
proof of emptiness for the nontrivial cubic units or of the ABC
conjecture.

The twelve declarations in Lean/SimultaneousEllipticArithmetic.lean
have now passed fresh compilation against the pinned Mathlib cache and
all twelve axiom queries, with only the standard axioms. They prove the
actual polynomial identities, the homogeneous elliptic/quartic-to-conic
implication, integer square divisibility and its quotient, the boundary
unit from Int.gcd, and the exact product padicValInt equality directly
from those actual hypotheses. They also prove the rational three-isogeny
formula satisfies its target equation. The geometric degree/kernel,
Jacobian isogeny, positive projective bijection, Q-to-integer monic
bridge and all-point questions remain ordinary-only or open, as detailed
in ordinary_formal_scope.md. The exact finite replay separately checks
15 identities and 80 specified signed elliptic multiples, not all points.
