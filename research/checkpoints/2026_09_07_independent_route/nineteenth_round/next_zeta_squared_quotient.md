# Z2. The distinct squared-unit cubic quotient

Next-only ordinary candidate. This file is outside the fixed-curve
publication inputs. It specifies a separate rational curve and actual
positive domain; it does not classify its rational points or infer the
other unit class from conjugation. No new software rank or point search
is used.

Use zeta^2-zeta+1=0 and the reviewed RL/HG projective conventions. Put

    A0=S^3-3ST^2-T^3,       B0=3ST(S+T).

The actual identity is

    zeta^2 (S+T zeta)^3=-(A0+B0)+A0 zeta.

Thus for this unit the target ratio is r=-(A0+B0)/A0. The genuine
common-source curve D_(3,zeta^2) is the smooth projective normalization
of v^2=1+r, w^2=1-3r, using this r at the same [S:T]. Its positive
actual first-square domain is finite t>1, equivalently 0<r<1/3 and
v>0, as in the already proved HG inverse.

## Z2.1. A new quintic and its actual positive square conditions

The first hyperelliptic quotient is

    H2u: y^2=-3s(s+1)(s^3-3s-1),                    (Z2.1)

where s=S/T, and y=A0(s,1)v on the chart A0 !=0. Its complete
homogeneous equation is Y^2=-A0 B0, with Y of degree three. At
T=0 it has the single smooth projective branch point infinity.
The other rational branch points are s=0 and s=-1.

Proof of the model and exceptions. Multiplication by zeta^2 sends a
pair (A0,B0) to (-A0-B0,A0). Consequently 1+r=-B0/A0, and multiplying
v^2 by A0^2 gives precisely -A0B0. The cubic s^3-3s-1 has
discriminant 81 and has no rational root, by the monic rational-root
test. It has no common root with s(s+1), whose two evaluations are
-1 and 1. The quintic is therefore squarefree, so its smooth
projective model has genus two and one branch point over infinity.
These conclusions include the homogeneous T=0 chart rather than
discarding it as a denominator exception. At a zero of A0 the first
quotient has a branch point over a nonrational cubic source. Such a
source cannot underlie a rational point of the source projective
line. The ratio v=y/A0 below is nevertheless used projectively there.

Every rational point of D maps to H2u. For the converse at a
nonbranch rational source with A0 !=0, the second square is exactly

    w^2=4+3B0/A0=4-3v^2.                           (Z2.2)

The rational points of H2u which lift to the actual positive domain
are therefore exactly those satisfying

    1<v<2/sqrt(3),       4-3v^2 is a square in Q.    (Z2.3)

Both signs of its nonzero square root w are allowed and give the
two ordered seed orientations. This is a statement about the full
common source, not two independently selected quotient points.

Indeed (Z2.3) gives r=v^2-1 in (0,1/3) and the exact conic inverse

    t=(v+w+2)/(v-w).

Its denominator is nonzero since v>1>|w|, and t>1: after subtracting
the denominator from its numerator the difference is 2(w+1)>0.
Conversely the original positive parametrization gives precisely
this range, as proved in HG. All these points have A0B0 !=0 and are
unramified for the two square roots, so the normalization and the
dense-chart inverse add no branch at a discarded point.

The three rational branch points s=0,-1,infinity have v=0 and r=-1.
They do lift to D, with w=+/-2, but they are outside (Z2.3).
Their original parameter is t=0 or t=-2; for (v,w)=(0,-2), the
generic inverse is formally 0/2=0, while for (0,2) it is -2.
Substitution into the original conic formulas verifies both values.
No assertion that these are all H2u(Q) points is made.

## Z2.2. A degree-three rational map with all four branch values

On H2u the rational function v=y/A0 defines a morphism to P1_v of
degree three. Its function-field equation is

    v^2 s^3+3s^2+(3-3v^2)s-v^2=0.                (Z2.4)

It is a Galois degree-three cover over Q. An explicit generator is

    rho(s,y)=(-1/(s+1), -y/(s+1)^3).             (Z2.5)

The quotient is exactly P1_v. The branch values are the four simple
zeros of v^4-v^2+1, and their geometric ramification index is three.
The cubic discriminant in (Z2.4) is exactly

    81(v^4-v^2+1)^2.                             (Z2.6)

Proof. The homogeneous substitution (S,T)->(-T,S+T) sends both
A0 and B0 to their negatives. It preserves -A0B0 and gives (Z2.5).
The chosen minus sign on y is essential: the corresponding lift
without that sign has cube equal to the hyperelliptic involution.
Since the matrix has third power -I, the signed lift here has order
three. Both y and A0 transform by -1/(s+1)^3, so v is invariant.
The homogeneous transformations extend to smooth projective curves,
including the three rational branch points of the hyperelliptic map.

The cubic equation follows by rearranging v^2 A0+B0=0. It gives
[Q(H2u):Q(v)]<=3. The three distinct powers of rho are automorphisms
fixing v, so the degree is at least three. Equality proves that the
fixed field is Q(v), with no irreducibility hypothesis left implicit.

The fixed sources of rho satisfy s^2+s+1=0. At each source A0=-3s
and B0=-3, so -A0B0 is nonzero and there are two points above it.
Because (s+1)^3=-1, formula (Z2.5) fixes both ordinates. Thus there
are exactly four fixed geometric points. At these points
v^2=-1/s, whose two possibilities are the roots of u^2-u+1=0;
their four square roots are exactly the simple roots of
v^4-v^2+1. Each nontrivial inertia subgroup has order three.
There is no other ramification: away from fixed points the group
action is free. In particular v=0 is unramified with the three
rational points s=0,-1,infinity; v=infinity is unramified with the
three nonrational A0-source points. The discriminant formula follows
by substituting (a,b,c,d)=(v^2,3,3-3v^2,-v^2) in the ordinary cubic
discriminant; it is consistent with these projective exceptions and
does not by itself substitute for their verification.

## Z2.3. Two rational two-torsion classes and a limited local test

Let P0,Pm,Pinf denote the three rational branch points of H2u at
0,-1,infinity. In its Jacobian the two classes

    [P0-Pinf],       [Pm-Pinf]                   (Z2.7)

are independent points of exact order two. Thus their subgroup is
(Z/2Z)^2. No assertion about the remaining torsion, the rank, a
Mordell--Weil basis, or its saturation is made.

Indeed div(s)=2P0-2Pinf and div(s+1)=2Pm-2Pinf. A degree-one
principal difference would give a degree-one map to P1 and force
genus zero, so neither class vanishes. Their sum cannot vanish
either: the functions with sole pole at Pinf of order at most two
are exactly the span of 1,s. One way to see this directly is that
the smooth affine coordinate ring is Q[s,y], with pole orders two
and five at infinity. Every element has unique form a(s)+b(s)y;
the even and odd pole orders cannot cancel. Order at most two
therefore forces b=0 and deg(a)<=1. A linear function of s cannot
vanish at both distinct abscissas 0 and -1. This proves independence.

There is also a complete exclusion of the source residue S=T !=0
modulo three for H2u(Q3), after choosing integral homogeneous
coordinates with min(v3(S),v3(T))=0. If S=T+3K and T is a unit,

    A0=-3(T^3-9K^2T-9K^3),
    B0/3=ST(S+T)=2T^3 mod3.

The actual equation has v3(-A0B0)=2, but after division by nine
its unit is 2T^6=-1 mod3, a nonsquare. This excludes the whole
residue class, including every deeper K. The weighted coordinate
Y scales cubically with (S,T), so the normalization covers all
projective Q3 inputs rather than only affine integral s.

At all other primitive source residues, A0 is a unit. If none of
S,T,S+T vanishes identically, exactly one has positive three-adic
valuation, and a necessary square condition is that this valuation
be odd, since v3(-A0B0)=1+v3(ST(S+T)). The branch cases where one
is zero have already been retained above. These are necessary local
conditions only. In particular the excluded residue S=T is exactly
where S^2+ST+T^2 is divisible by three; the actual primitive
unramified root was already known to avoid it. It is not a new
global obstruction to the remaining positive unit class.

## Z2.4. Exact rational torsion, rational simplicity and an even rank

The Jacobian J of H2u is Q-simple, its rational torsion subgroup is
exactly (Z/2Z)^2, and its Mordell--Weil rank is even. In particular,
if a subsequent certified descent proves rank zero, then

    H2u(Q)={P0,Pm,Pinf}.                           (Z2.8)

This implication is useful, but rank zero is NOT established here.

Here are the complete finite inputs for the ordinary proof. The
curve has good reduction at five and seven: the cubic discriminant
81 and its values -1,1 at 0,-1 are units, the two linear factors
are distinct, the leading coefficient -3 is a unit, and the odd
degree gives a smooth single point at infinity. The complete counts
and Frobenius polynomials are

|p|#H2u(F_p)|#H2u(F_p^2)|characteristic polynomial|#J(F_p)|
|---|---|---|---|---|
|5|3|25|X^4-3X^3+4X^2-15X+25|12|
|7|9|37|X^4+X^3-6X^2+7X+49|52|

These counts are exhaustively replayed by
`next_replay_zeta_squared_reductions.py`, with canonical result
`next_zeta_squared_reductions.json`, SHA256
`66ce937b9a33a5300f08b128f630b3b47ddaeee80b28b7f5a77427ed30c06b6c`.
The author actually ran both --write and --check, which passed.
The code enumerates every y-square fiber over the prime fields
and over F25=F5[u]/(u^2-2), F49=F7[u]/(u^2-3), checking both
quadratics are irreducible. All 25 and 49 abscissa fibers, every
prime-field ordinate and the unique infinity point are retained
in the canonical JSON. The two Frobenius polynomials follow from
t=p+1-N_p, a2=(N_(p^2)-p^2-1+t^2)/2 and coefficients
(1,-t,a2,-pt,p^2); their values at one give the group orders.
These finite facts do not assert a rank or a rational point search.

If J had a proper nonzero abelian subvariety over Q, it would be
isogenous over Q to two elliptic curves. As in the previously
proved QS argument, good reduction of J at five implies good
reduction of the factors, and its Frobenius polynomial would be

    (X^2-aX+5)(X^2-bX+5),     a,b in Z.

The actual coefficients force a+b=3 and ab=-6, so (a-b)^2=33,
impossible for integers. This proves Q-simplicity, without a claim
of geometric simplicity over the algebraic closure.

For rational torsion, prime-to-p reduction is injective at a good
prime. Its five-primary part injects at seven into a group of order
52 and is zero; its seven-primary part injects at five into a group
of order 12 and is zero. Every other primary part is bounded by
both group orders. Thus the entire rational torsion order divides
gcd(12,52)=4. The four points already constructed in (Z2.7) attain
this bound, proving the exact structure.

The degree-three quotient map in Z2.2 has target P1. The divisor
norm-pullback identity, including ramified multiplicities, therefore
gives 1+rho_*+rho_*^2=0 on J, since Pic^0(P1)=0. This is the same
explicit identity used for the earlier HG quotient computations.
The irreducible rational polynomial X^2+X+1 consequently gives
an action of Q(sqrt(-3)) on J(Q) tensor Q. By Mordell--Weil this
is a finite-dimensional vector space, and its dimension over Q
is even. This proves the parity assertion without an analytic rank
or an isogeny to the previously solved bielliptic Jacobian.

Finally suppose rank zero. Every rational point R of H2u maps by
R->[(R)-(Pinf)] into the four-element torsion group. The map is
injective, because a principal difference of two distinct points
would have degree one. Three images come from Pinf,P0,Pm. The
fourth group element is [P0+Pm-2Pinf]. If it came from R, then
R+Pinf would be linearly equivalent to P0+Pm. However the complete
linear system of P0+Pm has dimension zero: its degree is two,
it is not equivalent to 2Pinf by the pole-basis argument in Z2.3,
and the canonical divisor is 2Pinf. Riemann--Roch gives dimension
of sections one. Thus its only effective representative is P0+Pm,
which cannot equal R+Pinf. This excludes the fourth element and
proves (Z2.8). Equivalently the same conclusion follows by applying
the elementary function-space argument to the branch divisors.
No rank-zero assumption is suppressed in this implication.

## Next bounded proof target and remaining uniformity

The explicit genus-two model, degree-three map and now exact rational
torsion supply inputs for a certified two-descent. A useful next
result is a rank-zero upper bound, which would prove (Z2.8) directly
and exclude (Z2.3). If the even rank is instead positive, a certified
description of the subgroup required for a rational-point method is
still needed. No upper bound has been proved here. In fact Q-simplicity
prevents copying the previously solved rational bielliptic splitting
to this different quotient.

Even a complete classification of H2u(Q) or its positive lift would
handle one fixed cubic unit branch. Ramified first norms, arbitrary
second residuals, other indices, their integral reconstruction and
uniform height estimates across the moving family remain separate
parts of the parent ABC problem.
