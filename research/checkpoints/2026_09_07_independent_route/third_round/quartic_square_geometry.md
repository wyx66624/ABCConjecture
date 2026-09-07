# A positive elliptic family, exact parity obstructions, and a dynamic square-class tower

Date: 2026-09-07. Author: ChatGPT.

Third-round ordinary proofs, independently reviewed. The second-round
manuscript and verification files are frozen and unchanged. QG1--QG5 have
passed independent mathematical review; the precise external theorem inputs
and formalization limits are identified below. Nothing here asserts the
existence of the NT4 counterexample family or proves ABC.

## 1. A rational elliptic parametrization of square second norms

For primitive positive a,b put c=a+b and

    M0=a^2+ab+b^2,
    M1=(ab)^2+ab*M0+M0^2
      =a^4+3a^3*b+5a^2*b^2+3ab^3+b^4.

Write N(x)=x^2+x+1 and F(x)=x^4+3x^3+5x^2+3x+1.

**QG1 (explicit rational maps).** The smooth projective curve with affine
equation y^2=F(x) is birational over Q to

    E: Y^2=X^3-X^2-3X.                                    (Q1)

On the indicated open sets the maps are

    u=(y-1-3x/2)/x^2, X=2-2u,
    Y=X*((X-4)*x-3)/2,                                    (Q2)

and

    x=(2Y+3X)/(X*(X-4)),
    y=1+3x/2+(1-X/2)*x^2.                                (Q3)

For (Q2) require x nonzero. For the inverse require X not in {0,4} and
x nonzero. These exclude only finitely many points of the smooth curves.

Proof: substituting y=1+3x/2+u*x^2 into y^2=F(x), then dividing by x^2,
gives

    (u^2-1)x^2+3(u-1)x+2u-11/4=0.

The discriminant of this quadratic in x is
-8u^3+20u^2-10u-2. With X=2-2u this is X^3-X^2-3X, and the quadratic
completion gives exactly (Q2). Equivalently, after u=1-X/2 the original
quartic difference equals

    x^2/4 * [X(X-4)x^2-6Xx-4X-3].                        (Q4)

The definition of Y converts this bracket to the equation (Q1).
Solving for x yields (Q3), proving the inverse on the open sets. The
discriminant of F is 117, so the quartic curve is smooth after projective
normalization and has genus one; the cubic in (Q1) has distinct roots.

**QG2 (infinitely many actual positive square second norms).** There are
infinitely many primitive positive pairs (a,b), of unbounded a+b, with
M1 a perfect integer square. Every such pair admits an actual second
Eisenstein extraction of exponent two with unit residual. This supplies
lambda_1=1/2 for that extraction, not a small-lambda NT4 family.

Proof: on E take P=(3,3). Exact rational group operations give

    2P=(4,-6), 3P=(75,645),
    4P=(361/144,2413/1728).                              (Q5)

The doubling formula for its X coordinate is

    X(2Q)=(X(Q)^2+3)^2/[4X(Q)(X(Q)^2-X(Q)-3)].            (Q6)

If s=v_2(X(Q))<0, the numerator of (Q6) has valuation 4s and its denominator
has valuation 2+3s. Hence v_2(X(2Q))=s-2. Since v_2(X(4P))=-4, all successive
doubles of 4P are distinct. Thus P has infinite order, without assuming a
database rank computation.

The real identity component E(R)^0 is the compact oval containing the point
at infinity and the branch X >= (1+sqrt(13))/2. It contains P. As a compact
connected one-dimensional real Lie group it is a circle: integrating a
nonzero invariant differential identifies it with R/Omega Z. An infinite
order point corresponds to an irrational angle, so its integer multiples
are dense. The rational inverse (Q3) is continuous near 3P, where

    x=101/355 >0, y=-192529/126025.                        (Q7)

An open neighborhood therefore maps to x>0 and avoids the exceptional
denominators. Infinitely many distinct integer multiples of P lie in this
neighborhood. The map is birational, and each rational x has at most two y,
so it produces infinitely many distinct positive rational x=a/b in reduced
form. Here a,b are positive and coprime. Since

    (y*b^2)^2=F(a,b) is an integer,

the rational number y*b^2 is an integer (write it in lowest terms). Hence
M1=F(a,b) is an integer square. Infinitely many reduced positive ratios have
unbounded numerator plus denominator. The exact example is

    F(101,355)=192529^2.

Finally the primitive first mixed output (ab,M0,c^2) has Eisenstein norm M1
and has no ramified factor three. In its oriented factorization a square norm
means every split exponent is even. Unique factorization therefore yields
z1=unit*W^2. With residual norm one the displayed parameter is lambda_1=1/2.
This is much larger than NT4's sufficient threshold. Other extractions may
exist for an individual point, but this theorem makes no claim about them.

Repository check: exact searches for the example 192529, pair (101,355),
model label 312.b1, and coordinate 361/144 found no previous matching theorem
in research/ or paper/. A live LMFDB search identified the familiar elliptic
model, but no database rank or generator assertion enters the proof above.
No claim of literature novelty is made. Local SageMath was not available;
the accompanying computations use exact Python integers and Fraction only.

## 2. A direct two-isogeny descent for two small twists

The next argument uses the standard rational elliptic-curve group law,
Mordell--Weil finite generation, and injectivity of prime-to-p torsion under
good reduction. Its descent maps and all local exclusions are explicit.

For integers a,b, let E(a,b): y^2=x^3+a*x^2+b*x with b(a^2-4b) nonzero. The two-isogenous
curve is E'(-2a,a^2-4b). The map phi has affine formulas

    phi(x,y)=(x+a+b/x, y*(1-b/x^2)).                       (Q8)

It extends at the omitted points to an isogeny with kernel {O,(0,0)}.
Applying the same formula to E' and scaling coordinates by 1/4,1/8 gives
the dual psi, with psi*phi=[2]. These statements can be checked by the
cubic equation and the rational doubling formula.

The homomorphism alpha:E(Q)->Q*/Q*^2 is the square class of x away from O
and (0,0), with alpha(O)=1 and alpha((0,0))=b. Its kernel is psi(E'(Q)).
One elementary explanation is that a nonzero target x is in the image of
the relevant isogeny exactly when it is a rational square: (Q8)'s first
coordinate is (y/x)^2; conversely, when a target X=t^2 is square, solving
x^2+(a-X)x+b=0 has discriminant (X-a)^2-4b=(Y/t)^2 and produces a rational
preimage. Exceptional points are checked separately. The homomorphism law
also follows from the line-intersection identity: the product of the three
x coordinates cut out by a line y=m*x+n is n^2. Tangency and the exceptional
torsion points follow by the same group-law formulas.

For precision in the converse, choose one quadratic root x and set y=t*x;
choose the root or sign so t*(x-b/x) equals the prescribed Y. At a target
(0,0) on E' a nonkernel preimage is a nonzero two-torsion point of E, so it
exists exactly when a^2-4b is a rational square. This is exactly the
condition alpha'((0,0))=1. The dual statement is the same after scaling.
When the line has intercept n=0, its other two roots have product b, which
matches alpha((0,0))=b and proves the homomorphism identity in that case.
Explicitly, for T=(0,0) on E, T lies in psi(E'(Q)) if and only if b is a
rational square; O always lies in the image. For a nonexceptional P,
x(P+T)=b/x(P), giving the required class identity on lines through T.
Vertical lines give alpha(P)*alpha(-P)=1. These formulas also cover the
exceptional points in the kernel and homomorphism assertions.

The established group and reduction inputs are documented in the author-hosted
J. S. Milne, Elliptic Curves, second edition (2020), Chapter IV opening
finite-basis theorem (printed p.105), Chapter II Corollary 4.2 (printed p.64,
prime-to-p torsion under good reduction), and Chapter II Proposition 1.5
(origin-preserving morphisms are homomorphisms):
https://www.jmilne.org/math/Books/EC2.pdf .
These inputs were checked by both the authoring and independent review agents.

Each alpha class is represented by a signed squarefree divisor d of b.
Indeed a prime outside b cannot have odd positive valuation in x, while a
negative valuation in x is even by comparing y^2 with the monic cubic.
A nontrivial class d in alpha(E(Q)) forces a primitive integer solution of

    W^2=d*U^4+a*U^2*V^2+(b/d)*V^4,
    gcd(U,V)=1.                                          (Q9)

This follows by writing x=d*U^2/V^2 in lowest square-class form and clearing
the cubic equation. The resulting W is rational with W^2 integral, hence
is integral. The cases O and (0,0) are already assigned explicitly.

**Descent lemma.** The complete rational points of

    E_1: y^2=x(x-1)(x+3)

are O,(0,0),(1,0),(-3,0),(-1,2),(-1,-2),(3,6),(3,-6).
The complete rational points of

    E_3: y^2=x(x-3)(x+9)

are O,(0,0),(3,0),(-9,0).

Proof for E_1: here a=2,b=-3 and E_1' has a'=-4,b'=16. The alpha image
on E_1 consists of the four classes {1,-1,3,-3}, all realized by the listed
points. On E_1', x>=0 because x^2-4x+16=(x-2)^2+12>0. Thus the only
possible alpha' classes are 1 and 2. Class 2 would force

    W^2=2U^4-4U^2V^2+8V^4.

For the primitive parity cases (U odd,V even), (U odd,V odd), and
(U even,V odd), the right side is respectively 2,6,8 modulo 16. None is a
square modulo 16. Hence alpha'(E_1')={1} and E_1'=phi(E_1).
It follows that kernel(alpha)=psi(E_1')=[2]E_1 and |E_1/2E_1|=4.
Since E_1 has four rational points of order dividing two, Mordell--Weil
finite generation gives rank zero.

At the good primes five and seven both reductions have eight points. Their
prime-to-p torsion injections eliminate odd torsion and bound the two-primary
torsion order by eight. All eight listed rational points are present, so
the list is complete. This does not infer rank from finite point counts;
rank zero was proved by descent before using the counts.

For E_3 one has a=6,b=-27 and its dual has a'=-12,b'=144. The four classes
{1,-1,3,-3} on E_3 are already represented by its four rational two-torsion
points. On its dual x>=0 because x^2-12x+144=(x-6)^2+108>0, and possible
squarefree classes are 1,2,3,6. For class 2, the quartic in (Q9) is

    2U^4-12U^2V^2+72V^4;

its three primitive parity residues modulo 16 are 2,14,8. For class 6 the
quartic is 6U^4-12U^2V^2+24V^4, with residues 6,2,8. Both are excluded.
For class 3, the equation is

    W^2=3U^4-12U^2V^2+48V^4.

It forces 3|W. After writing W=3W0 and dividing by three, reduction modulo
three gives 0=U^4-U^2V^2+V^4. Unless both U,V are divisible by three, the
right side is one modulo three. This contradicts gcd(U,V)=1. Therefore the
dual image is again trivial, |E_3/2E_3|=4, and E_3 has rank zero.
Its good reductions at five and seven have four and eight points, so its
torsion order divides four. The displayed four points exhaust it.

## 3. An exact combined-norm obstruction

**QG3 (exact combined-norm obstruction).** For any positive rational
x, neither N(x)F(x) nor N(x)F(x)/3 is a rational square. Consequently, for
primitive positive integers a,b, neither M0*M1 nor (M0*M1)/3 is a rational
square. In particular the two actual norm representations cannot both have
even extraction exponent and unit residual, even when both roots move.

Proof: suppose N(x)F(x)=d*h^2, d in {1,3}, and put

    u=x+1/x, v=2u+3, t=4*h*(x+1)/x^2.

Since F(x)/x^2=u^2+3u+3 and N(x)/x=u+1,

    d*t^2=16*(u+2)*(u+1)*(u^2+3u+3)
         =v^4+2v^2-3=(v^2-1)*(v^2+3).                   (Q10)

Thus (X,Y)=(v^2,v*t) is a rational point on

    d*Y^2=X(X-1)(X+3).

For d=1 this is E_1. For d=3 the change (x_E,y_E)=(3X,9Y) gives E_3.
Because x>0, u>=2 and v>=7. The resulting x coordinate on E_1 is at
least 49, or on E_3 at least 147. Both contradict the complete point lists
proved above. Finally M0*M1=b^6*N(a/b)*F(a/b), and b^6 is a square.

For the actual first profile M0=3^e*V0*Q0^g0 and second profile
M1=V1*Q1^g1, if V0=V1=1 and both g0,g1 are even, their product is 3^e
times a square. This is excluded by QG3. The statement applies to all
moving Q0,Q1 and does not use Faltings or an ineffective height bound.
It does not exclude odd extraction exponents or arbitrary nonunit residuals.
More generally it excludes both residual norms being squares, even when they
are nonunits: the same product is then 3^e times a square. Thus an actual
two-even-exponent profile must have a nonsquare residual norm at one step.
This is a parity obstruction, not a quantitative lower bound for lambda.

## 4. Fixed residual square classes lead to genus three

**QG4 (fixed-class finiteness).** Fix any positive rational square classes
d0,d1. Only finitely many primitive positive pairs (a,b) can satisfy

    M0=d0*A^2, M1=d1*B^2

with A,B rational. No effective height bound is asserted here.

Proof: take the smooth projective normalization with function field

    Q(x)(sqrt(N(x)/d0),sqrt(F(x)/d1)).                    (Q11)

Both polynomials are squarefree: their discriminants are -3 and 117.
They have no common root since F modulo N is x^2 and N(0)=1; in fact
Res(N,F)=1. Their classes are independent in Qbar(x)*/Qbar(x)*^2 by looking
at their disjoint simple zeros. Thus (Q11) is geometrically connected and
is a degree-four cover of P1. There are six finite branch points. At each,
the inertia group has order two, so there are two points of ramification
index two and the total ramification contribution is two. Infinity is
unramified because the two polynomial degrees are even. Riemann--Hurwitz
therefore gives

    2g-2 = 4*(-2)+6*2 = 4,  hence g=3.

Faltings's theorem gives finitely many rational points on this fixed smooth
projective curve. Every seed gives x=a/b and square coordinates A/b and
B/b^2. A reduced positive rational x determines its primitive pair uniquely.
Hence only finitely many seeds exist.

The primary Faltings paper was inspected directly:
G. Faltings, Endlichkeitssatze fur abelsche Varietaten uber Zahlkorpern,
Inventiones Mathematicae 73 (1983), 349--366, with the 1984 erratum.
Primary scan:
https://math.uchicago.edu/~drinfeld/Deligne%27s_conjecture_Manin_conf/Faltings_argument/Faltings.pdf

For actual two-step profiles with g0,g1 even, the two square classes are

    d0=[3^e V0], d1=[V1].                                 (Q12)

Consequently, along a sequence of these profiles whose seed height tends to
infinity, the
*pair* of square classes must eventually leave every fixed finite product
D0 x D1. This is a joint escape condition: it does not assert that one
particular coordinate must escape along the entire sequence, since the
coordinates could alternate. From a merely unbounded-height family one first
passes to a subsequence with height tending to infinity. Moving square classes and odd exponents remain
outside this obstruction. QG3 strengthens the special pair with unit
residuals from mere finiteness to nonexistence.

## 5. A dynamic square-class tower

Define integer polynomials recursively by

    A0=x, B0=1,
    A_{j+1}=A_j B_j,
    B_{j+1}=A_j^2+A_j B_j+B_j^2,
    f_j=B_{j+1}.                                         (Q13)

Then A_j/B_j is the jth iterate of r(x)=x/(x^2+x+1), and f_0=N,f_1=F.

**QG5 (dynamic square-class tower).** The polynomials f_j
are squarefree, have degree 2^(j+1), and have pairwise disjoint root sets.
For fixed nonzero rational d_0,...,d_{k-1}, the smooth projective cover with
function field

    Q(x)(sqrt(f_0/d_0),...,sqrt(f_{k-1}/d_{k-1}))          (Q14)

is geometrically connected of degree 2^k and has genus

    G_k=1+2^(k-2)*(2^(k+1)-6),   k>=1.                    (Q15)

Thus G_1=0,G_2=3,G_3=21. For any k>=2, fixing the vector of these square
classes gives only finitely many primitive positive integer seeds for k
successive mixed transforms.

Proof: the homogeneous map r has degree two. Its only critical points are
1 and -1, since its affine derivative is (1-x^2)/(x^2+x+1)^2. Neither has
a forward iterate equal to infinity: -1 is fixed, while the forward orbit
of 1 stays positive and finite. Infinity itself maps to zero, which is
fixed. Therefore infinity is not in the postcritical set. Every iterated
preimage of infinity is unramified, so the equation r^(j+1)(x)=infinity has
exactly 2^(j+1) distinct roots. They are finite, since infinity maps to zero.
These are the roots of f_j. Coprimality of the recursion's numerator and
denominator follows inductively: a common zero of A_jB_j and
A_j^2+A_jB_j+B_j^2 would be a common zero of A_j,B_j. The degrees are
deg A_j=2^j-1, deg B_j=2^j for j>=1, with monic leading coefficients, so
deg f_j=2^(j+1).

If a point were a root of f_i and f_j with i<j, an iterate of infinity
would equal infinity, contradicting infinity->0->0. Thus the root sets are
disjoint. In any nonempty product of distinct f_j, a root belonging to one
chosen polynomial has odd valuation. Their geometric square classes are
therefore independent, proving geometric connectedness and degree 2^k.
There are sum_{j<k}2^(j+1)=2^(k+1)-2 finite branch points. At each only
one square root ramifies and its inertia group has order two. Hence the
ramification contribution at each is 2^(k-1). At infinity all polynomial
degrees are even, so the geometric extension is unramified. Thus

    2G_k-2=-2*2^k+(2^(k+1)-2)*2^(k-1),

which is (Q15). The final finiteness assertion is again Faltings's theorem.
Homogenizing (Q13) to evaluate at a/b multiplies f_j(a/b) by
b^(2^(j+1)), a square, so the displayed square classes are exactly those
of the actual successive norm integers, not auxiliary approximate norms.

This construction supplies explicit higher-genus objects and a rigorous
fixed-class restriction. It does not by itself provide uniform control over
the twists, a bound on their rational points, or the moving-class NT4 family.

## Review and dependency ledger

QG1--QG2: independently checked by adversarial_audit, including the rational
inverse, exact multiples, negative two-adic doubling valuation, real identity
component, positive open set, rational-to-integer square step, and unbounded
primitive heights.

QG4: independently checked by adversarial_audit, including six disjoint
branch points, absence of infinity ramification, genus three, and the joint
escape quantifier. Faltings finiteness is an explicit external theorem and
is not an effective height estimate.

QG3 and the complete two-isogeny descent: full independent review passed by
critical_bottleneck, adversarial_audit, and root. The source checks, integral
coefficients, exceptional isogeny points, alpha identities through torsion,
and rational-to-integral covering coordinate are now explicit.
QG5: full independent review passed by root and adversarial_audit, including
the postcritical orbit, pairwise root disjointness, genus formula, and actual
norm homogenization. Adversarial_audit's requested sequence quantifier in
QG4 is corrected to height tending to infinity, not merely unbounded height.

The exact replay is separate from these infinite proofs. No elliptic curve
rank in this note is accepted solely from a database or numerical analytic
calculation. No new Lean verification is claimed for these geometric results.
