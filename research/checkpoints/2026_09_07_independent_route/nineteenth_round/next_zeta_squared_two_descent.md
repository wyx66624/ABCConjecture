# ZD2. A complete two-descent for the squared-unit cubic quotient

Next-only complete ordinary candidate. This file does not alter the
reviewed Z2.1--Z2.4 source or any publication input. The argument uses
an explicit odd-degree Jacobian descent, elementary number-field
arithmetic, and the already certified finite reductions. It uses no
software rank bound, analytic rank, generator search, or unproved
saturation claim. Independent full review is pending at creation.

The curve under consideration is exactly

    H: y^2=-3s(s+1)(s^3-3s-1).

The proposed conclusions are

    Jac(H)(Q) = (Z/2Z)^2,
    H(Q) = {the branch points s=0,-1,infinity}.       (ZD2.1)

The precise consequence for the actual squared-unit common-source
curve is stated only after the Jacobian argument, in ZD2.6 below.

## ZD2.1. The monic model and the whole-Jacobian descent input

The exact rational change of variables X=-3s, Y=9y gives

    C: Y^2=F(X),
    F(X)=X(X-3)g(X),       g(X)=X^3-27X+27.         (ZD2.2)

Both smooth projective curves have a single rational point O at
infinity, and this change extends to an isomorphism taking O to O.
Put K=Q(theta), where theta^3-3theta-1=0, and alpha=-3theta.
The relevant etale algebra and norm are

    L=Q[T]/(F(T)) = Q x Q x K,
    T -> (0,3,alpha),
    N(q0,q3,beta)=q0*q3*N_(K/Q)(beta).              (ZD2.3)

Here and below a square class is multiplicative. The external
odd-degree descent theorem is used in its full form: for each field
k of characteristic zero there is a natural homomorphism

    delta_k: J(k) -> ker(N:L_k^*/L_k^{*2}->k^*/k^{*2}),
    ker(delta_k)=2J(k),                            (ZD2.4)

where J=Jac(C). On a degree-zero k-rational divisor avoiding the
Weierstrass points and O it is evaluation of X-T with closed-point
norms and divisor multiplicities. This is a map on all J(k), not
only the classes of k-rational points of C. The rational point O
and divisor moving give such representatives for every class; this
representation and the induced map are part of the cited theorem.
For a nonbranch point P, delta_k(P-O)=X(P)-T. At a rational branch
point (a,0), the component at T=a is F'(a), and the other components
are a-T, all modulo squares.

These are precisely the construction preceding Lemma 4.1, Lemma
4.1, and Lemma 4.3 of Stoll, *Implementing 2-descent for Jacobians
of hyperelliptic curves*, Acta Arithmetica 98 (2001), pp.250--251.
The original odd-degree hypotheses apply to (ZD2.2). In particular,
no even-degree fake-descent kernel is being substituted here.

Let D0=[(0,0)-O], D3=[(3,0)-O]. These are the two independent
rational points of order two from Z2.3. Since

    g(0)=27, g(3)=-27, F'(0)=F'(3)=-81,

their actual descent images are

    delta(D0)=(-1,-3,3theta),
    delta(D3)=(3,-1,3(theta+1)),                    (ZD2.5)

modulo squares in the three factors. For example the first entry
before simplifying the first triple is -81, whose square class is
-1. The signs in both triples are essential.

## ZD2.2. Complete elementary arithmetic in the cubic field

The following facts are unconditional:

    O_K=Z[theta],  Disc(K)=81,  Cl(O_K)=1;
    pi=theta-1 generates the unique prime above 3,
    N(pi)=3;
    every totally positive unit of O_K is a square. (ZD2.6)

Proof. The cubic h(U)=U^3-3U-1 has no rational root, since its only
possible integral roots are 1 and -1 and neither vanishes. It has
three real roots, ordered for later use as

    1<theta_1<2,  -2<theta_2<-1,  -1<theta_3<0.

The intermediate value theorem gives one root in each interval,
which accounts for all roots. Its discriminant is 81. If the index
of Z[theta] in O_K were greater than one, the index-discriminant
identity would force Disc(K)<=9. For a totally real cubic field
the Minkowski bound is (2/9)*sqrt(Disc(K)). The asserted upper bound
would make it at most 2/3, whereas each ideal class has a nonzero
integral representative with positive integer norm at most that
bound. This is impossible. Hence the index is one and Disc(K)=81.

The actual Minkowski bound is now exactly two. The reduction of h
modulo two is U^3+U+1, which has no root in F2 and is irreducible.
As O_K=Z[theta], the prime two is inert and there is no ideal of
norm two. Every ideal class therefore has a representative of
norm one and is trivial. This proves the class-number assertion.

The shift h(1+U)=U^3+3U^2-3 is Eisenstein at three. Thus K has
one prime above three, with ramification degree three and residue
degree one. The element pi=theta-1 has norm three; it generates
that prime. This also proves the irreducibility of g over Q3.

The three units -1, theta, theta+1 have respective norms -1,1,-1.
Their sign vectors, in the ordering of the three roots above, are

    -1:       (-,-,-),
    theta:    (+,-,-),
    theta+1:  (+,-,+).                              (ZD2.7)

These are three linearly independent vectors in {+,-}^3. Dirichlet's
unit theorem gives O_K^* isomorphic to {+1,-1} times Z^2, so its
quotient by squares has dimension three over F2. Consequently its
signature map to {+,-}^3 is an isomorphism. Its kernel consists
exactly of square units. This proves the last assertion in (ZD2.6).
It does not assert that theta and theta+1 form a fundamental unit
basis over Z; their classes modulo squares suffice.

The only external number-field inputs here are the discriminant
index identity, prime decomposition for a monogenic maximal order,
Minkowski's ideal-class bound, Eisenstein's criterion, and Dirichlet's
unit theorem. In particular no class-group or regulator computation
has been accepted from a numerical package. Milne's *Algebraic Number
Theory*, Theorems 4.3 and 5.1, supply the two quantitative statements.

## ZD2.3. Even valuations away from three, including at two

For every Q in J(Q), every component of delta_Q(Q) has even ideal
valuation at all finite primes not lying above three. Thus it has
a representative of square classes of the form

    (q0,q3,u*pi^e),
    q0,q3 in {1,-1,3,-3},
    e in {0,1}, u in O_K^*.                         (ZD2.8)

We prove the assertion on the entire local Jacobian at each
prime ell !=3, before applying it to the global image. The
discriminant of the monic polynomial F is exactly 3^24: the
discriminants of X(X-3) and g are respectively 3^2 and 3^10,
and their resultant is g(0)g(3)=-3^6. Hence F has pairwise
distinct roots with unit differences in some finite unramified
extension U/Q_ell. This assertion is valid also for ell=2.

Let P be any closed point of C over Q_ell, with finite residue
field E/Q_ell, away from the excluded support in (ZD2.4). Write
x=X(P), y=Y(P). In the compositum E'=EU the roots r_1,...,r_5
of F are integral, their pairwise differences are units, and
E'/E is unramified. Use normalized integer-valued valuations in
E'. If v(x)<0, all five values v(x-r_i) equal v(x), and

    2v(y)=5v(x).

Thus v(x) and all five factor valuations are even. If v(x)>=0,
all five factors are integral and at most one is nonunit, since
the roots have unit differences. Its valuation, if it occurs,
is the whole valuation of F(x)=y^2 and is again even. Thus in
either case every factor x-r_i has even valuation.

For completeness the transfer to closed-point norms introduces
no parity loss. Each field factor M of L_(Q_ell) is an unramified
extension of Q_ell. Decompose E tensor_(Q_ell) M into its field
factors V_j. Each V_j/E is unramified. Extending V_j by U, still
unramified, splits all roots and reduces to the preceding argument.
Thus x-T in each V_j has even normalized valuation. Under the
norm V_j/M this valuation is multiplied by the residue degree
f(V_j/M), and remains even. The M-component of the closed-point
evaluation is the product of these norms. Integer multiplicities,
negative as well as positive, preserve evenness. Applying this
to a moved divisor for any class of J(Q_ell) proves the assertion
for all delta_(Q_ell)(J(Q_ell)). Naturality in (ZD2.4) proves the
global claim.

This argument asserts even ideal valuations, not that the associated
quadratic square-class extension is unramified at two. It neither
assumes good reduction of this hyperelliptic equation at two nor
omits two from a generic Selmer-prime list. The direct valuation
argument is what handles that prime.

In Q, even valuations away from three give precisely the first two
lists in (ZD2.8). For the K-component beta, write its fractional
principal ideal as

    (beta)=(pi)^e * a^2,

using e=0 or 1 and absorbing any even exponent at pi into a.
The trivial class group makes a=(gamma). Therefore
beta=u*pi^e*gamma^2 for a unit u, proving the full representation
(ZD2.8), including arbitrary denominators.

## ZD2.4. The entire three-adic local image is generated by D0,D3

The local image delta_(Q3)(J(Q3)) has four elements, and they
are the images of 0,D0,D3,D0+D3. In particular any global image
(q0,q3,beta) can be multiplied by one of these four actual
rational torsion images so that its first two components become
squares in Q itself.

Proof. Over Q3 the factorization F=X(X-3)g has exactly three
irreducible factors, since the cubic field is totally ramified
of degree three. The odd-degree branch-divisor description of
two-torsion gives

    dim_F2 J(Q3)[2]=3-1=2.

This is Stoll Lemma 4.3(3). The local group quotient also has
order four. One can either apply his Lemma 4.4(1), with the
odd prime three, or prove it directly as follows. There is a
compact open formal subgroup U of J(Q3) on which doubling is
a bijection. Indeed a sufficiently small formal-group chart
has linear term 2, a three-adic unit, so the usual contraction
argument constructs the inverse. The quotient A=J(Q3)/U is a
finite abelian group. Both J(Q3)/2J(Q3) and J(Q3)[2] identify
respectively with A/2A and A[2]: in the latter case any lift of
an element of A[2] can be uniquely corrected by a half in U.
Since |A/2A|=|A[2]|, the two local orders are equal to four.

The first components of (ZD2.5) are -1 and 3. These are
independent in Q3^*/Q3^{*2}: -1 is a nonsquare unit and 3 has
odd valuation. Thus the two displayed local descent images
are independent. By the exact kernel in (ZD2.4), they exhaust
the four-element local image.

The natural map from the four rational square classes
{1,-1,3,-3} to Q3^*/Q3^{*2} is injective, by the same unit
and valuation test. The first two global components must
therefore be exactly one of the following pairs modulo squares:

    (1,1), (-1,-3), (3,-1), (-3,3).                 (ZD2.9)

Multiplying by the corresponding torsion image gives another
actual global Jacobian image of the form (1,1,beta). By
(ZD2.8) it has beta=u*pi^e modulo squares. The norm condition
in (ZD2.4) now says N(beta) is a rational square. Since N(pi)=3
and N(u)=+1 or -1, it forces e=0 and N(u)=1. Hence the remaining
class is (1,1,u), with u an ordinary unit. The residue degree one
of the unique prime above three is used here explicitly.

## ZD2.5. Real signs kill the remaining unit, proving rank zero

Every actual global image of the form (1,1,u) in ZD2.4 is
trivial. Consequently

    delta_Q(J(Q))=<delta(D0),delta(D3)>,
    |J(Q)/2J(Q)|=4,
    rank J(Q)=0.                                    (ZD2.10)

Proof. Order the cubic-field roots as in ZD2.2, and write
alpha_i=-3theta_i. The five real roots of F are ordered as

    alpha_1 < 0 < alpha_3 < 3 < alpha_2.

Since F is monic of degree five, the finite real points occur
over the intervals [alpha_1,0], [alpha_3,3], [alpha_2,infinity).
Away from endpoints the signs of the evaluation vector

    (x,x-3; x-alpha_1,x-alpha_2,x-alpha_3)

are respectively

    lower:  (-,-; +,-,-),
    middle: (+,-; +,-,+),
    upper:  (+,+; +,+,+).                           (ZD2.11)

The first two sign pairs of the lower and middle vectors are
independent, and the full group generated by these vectors has
four elements. No nonidentity element of this sign group has
both of its first two signs positive.

This sign restriction applies to all J(R), not just points of
C(R). To see this directly, represent a class by a real divisor
avoiding the branch points and O as in (ZD2.4). Each real closed
point contributes one of (ZD2.11). Each nonreal closed point is
a complex conjugate pair; its norm of x-r is positive at every
real root r, being an absolute-value square. Products and inverse
powers of such contributions still lie in the same four-element
sign group. This also agrees with Stoll Lemma 4.8's explicit
description of the real descent image. Thus an actual image
with first components (1,1) has positive signs at all three
embeddings of K.

For the remaining unit u, multiplication by a K-square cannot
change its real signs. Hence u is totally positive. By (ZD2.7)
it is a square unit, proving the assertion. Both D0 and D3 have
independent descent images, so the global image has exactly
four elements, not merely at most four.

Mordell--Weil gives J(Q) finitely generated. For a finitely
generated abelian group of rank r, its quotient by doubling has
order 2^r times the size of its two-torsion subgroup. Here the
rational branch-factor calculation or Z2.3 gives |J(Q)[2]|=4.
Equation (ZD2.10) therefore forces r=0. Finally the independently
certified good-prime counts in Z2.4 give the full rational torsion
as (Z/2Z)^2; hence J(Q) itself is that four-element group.

This last full-torsion input is separate from the rank proof.
Rank zero has been proved by the actual descent, not inferred
from finite reduction orders or from the previously established
even-rank parity.

## ZD2.6. Complete point set and the actual common-source consequence

The Abel--Jacobi map C(Q)->J(Q), R->[(R)-O], is injective. A
principal difference of distinct points would otherwise give a
degree-one rational function and force genus zero. Three images
are 0,D0,D3. The fourth possible element D0+D3 is not the image
of a rational point. Indeed such a point R would imply

    R+O ~ (0,0)+(3,0).

The canonical class is 2O. The degree-two divisor on the right
is not linearly equivalent to 2O: the functions with sole pole
at O of order at most two are the span of 1,X, and no linear
function of X vanishes at both zero and three. This pole-space
description follows from the affine ring Q[X,Y], with pole
orders two and five at O; its unique expression a(X)+b(X)Y
has no cancellation between the even and odd pole orders.
Riemann--Roch now gives a one-dimensional space of sections
for (0,0)+(3,0). Its only effective representative is itself,
which cannot equal R+O. The fourth image is excluded. Returning
to s=-X/3 proves exactly (ZD2.1).

The previously proved Z2.1 same-source construction has first
quotient H and v=y/A0, with

    A0=S^3-3ST^2-T^3, B0=3ST(S+T),
    r=-(A0+B0)/A0,
    v^2=1+r, w^2=1-3r=4-3v^2.

At each of the three rational source points 0,-1,infinity,
B0=0, A0 is nonzero homogeneously, and v=0. The two second
square values are w=+2,-2. Each such lift is unramified in
the second square root, so there are precisely two points
over each source on the smooth projective normalization.
Conversely every rational point of the common-source curve
maps to H(Q). Consequently D_(3,zeta^2)(Q) has exactly these
six points. Their conic parameter t is -2 for w=2 and zero
for w=-2. They are all outside the actual positive range

    1<v<2/sqrt(3),  4-3v^2 a rational square.

This proves that the squared-unit cubic branch has no actual
positive point with first norm a square and the specified pure
second cubic norm. It does not impose positivity on the entire
curve or confuse this branch with conjugation of the unit-zeta
curve. The other identity and zeta branches have their separate
CL and CB proofs; combining the three fixed-unit conclusions is
legitimate only with the already established actual unit-class
extraction. None of these conclusions supplies a uniform theorem
for arbitrary residual coefficients or all moving exponents.

## Primary inputs, evidence and formal scope

The two primary PDFs were actually opened for this proof.

* Michael Stoll, *Implementing 2-descent for Jacobians of
  hyperelliptic curves*, Acta Arith. 98 (2001), 245--277,
  construction preceding Lemma 4.1 and Lemmas 4.1, 4.3,
  4.4, 4.8 (printed pp.250--251,254):
  https://www.impan.pl/shop/en/publication/transaction/download/product/83397
* J. S. Milne, *Algebraic Number Theory*, Theorems 4.3 and
  5.1, for the ideal-class Minkowski bound and unit rank:
  https://www.jmilne.org/math/CourseNotes/ANT.pdf

The already reviewed finite evidence used to bound full rational
torsion is `next_replay_zeta_squared_reductions.py`, with canonical
JSON SHA256
`66ce937b9a33a5300f08b128f630b3b47ddaeee80b28b7f5a77427ed30c06b6c`.
Its exhaustive good-five and good-seven counts give Jacobian orders
12 and 52. Those exact tables have already been independently
replayed by both peers. This note introduces no new software rank
calculation and does not claim the full descent is formalized in Lean.

The whole-Jacobian descent theorem and Mordell--Weil are standard
external ordinary inputs. All number-field, valuation, local-image,
signature and point-set deductions specific to this curve are proved
above. Useful later finite formal cores are the actual model identity,
discriminants and torsion vectors, the finite signature linear algebra,
and the precise valuation-parity implication. They are not substitutes
for (ZD2.4). This fixed curve's closure leaves ramified first norms,
moving residuals, general indices and uniform point-height estimates
as distinct obligations in the parent ABC problem.
