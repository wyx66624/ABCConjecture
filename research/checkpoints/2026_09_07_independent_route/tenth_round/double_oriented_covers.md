# DC1--DC4. Two actual oriented norm profiles in the quadratic field

Status: complete ordinary proof independently reviewed by root,
critical_bottleneck and adversarial_audit, including the removal of the
g-free condition. This strengthens the reviewed MX construction, which
is retained with its original generic scope.
No existence of simultaneous small-residual profiles and no point-height
upper bound is asserted. No Lean verification is claimed here.

The additional input is not a conjecture: the quartic in this repository
is itself the norm of the actual primitive Eisenstein integer ab+M*zeta.
Thus its second residual coefficient can be chosen from actual small
Eisenstein residuals instead of arbitrary unit classes in the quartic
splitting field. This does not say that the generic QC coefficient bound
or its unit-class obstruction was false.

## Setup

Let O=Z[zeta], zeta^2-zeta+1=0, K0=Q(zeta), gamma=1+zeta.
Conjugation sends zeta to 1-zeta. Use the norm
N(r+s*zeta)=r^2+rs+s^2. The Eisenstein ring is Euclidean and hence a UFD,
as in the previously reviewed actual oriented factorization. A primitive
unramified element has no rational prime dividing both coordinates and
has norm prime to 3. Each rational prime in its norm splits, and exactly
one of its two conjugate prime orientations occurs.

Let a,b be positive coprime integers and put

    c=a+b, x=a/b, M=a^2+ab+b^2,
    F=a^4+3a^3*b+5a^2*b^2+3a*b^3+b^4.

Assume an actual first oriented profile

    z0=a+b*zeta=u0*gamma^e*v0*w0^h,
    e in {0,1}, h>=2,
    V0=N(v0), R=N(w0)>=7, M=3^e V0 R^h,          (DC1)

where v0,w0 are primitive oriented unramified elements. Their oriented
supports may overlap. Assume also a numerical second profile

    F=V1 Q^g,   g>=2, V1,Q positive integers, Q>1. (DC2)

All exponents are integers. The residual V1 need not be g-free: the
construction keeps its given exponents, allowing v1 and w1 to share
oriented factors. Taking a g-free residual is an optional canonical
convention, not a hypothesis. No condition relates h and g, or requires
either exponent to be coprime to six.

For reference F is odd and F=1 modulo 3. Modulo 5, f(r)=F(r,1) takes
values 1,3,2,2,1 for r=0,1,2,3,4; if 5|b, then F=a^4!=0 modulo 5.
Thus 2,3,5 do not divide F, and Q>1 implies Q>=7.

## DC1. A genuine second oriented profile

There are a unit u1 and primitive oriented unramified v1,w1 in O with

    z1=ab+M*zeta=u1*v1*w1^g,
    N(v1)=V1, N(w1)=Q.                           (DC3)

Proof. Direct expansion gives

    N(z1)=(ab)^2+ab*M+M^2=F.                     (DC4)

Also gcd(ab,M)=1: a prime dividing a or b and M would divide both a
and b. Thus z1 is primitive. Since 3 does not divide F it is unramified.
An inert rational prime dividing a primitive norm would divide both
coordinates, and two conjugate split factors in z1 would do the same.
Consequently its prime factorization has the form

    z1=u1*product_q pi_q^(E_q), N(pi_q)=q,

where for each rational prime q precisely one orientation pi_q occurs.
Equation DC2 says E_q=v_q(V1)+g*v_q(Q), with both summands
nonnegative. Define

    v1=product_q pi_q^v_q(V1),
    w1=product_q pi_q^v_q(Q).

These are actual elements in O by unique factorization. Their norms
and their product give DC3 exactly. Both inherit primitivity, absence
of ramification at 3, and the oriented-support condition. Overlap
between v1 and w1 is permitted. In particular there is no need to
factor the root of a numerical norm in an enlarged number field.

The assertion is mathematical and does not assume that a practical
factorization of the large integer F has already been computed.

## DC2. Two exact residual coefficients and a degree-hg cover

Put N(X)=X^2+X+1 and

    G(X)=X+zeta*N(X),
    Gbar(X)=X+bar(zeta)*N(X),
    beta_+=-zeta, beta_-=-bar(zeta).

Define coefficients in the fixed quadratic field K0 by

    eta0=(u0^2*zeta^e*v0/bar(v0))^(-1),
    eta1=(u1^2*v1/bar(v1))^(-1).                  (DC5)

The actual seed supplies K0-valued nonzero coordinates satisfying

    Y^h=eta0*(x-beta_+)/(x-beta_-), Y=w0/bar(w0),
    Z^g=eta1*G(x)/Gbar(x),         Z=w1/bar(w1).  (DC6)

Their coefficient heights are exactly

    height(eta0)=(1/2)log V0,
    height(eta1)=(1/2)log V1.                    (DC7)

The smooth projective normalization C of DC6 is geometrically connected
over K0, of degree D=hg over P1_x and genus

    genus(C)=1+hg*(2-1/h-2/g)
            =1+2hg-g-2h.                       (DC8)

Every actual profile (DC1)--(DC2) gives a K0-point of C above x=a/b.

Proof. The first identity is MX1, and its proof does not require g>=9.
For the second, z1/b^2=G(x) and bar(z1)/b^2=Gbar(x). Divide DC3 by
its conjugate. A unit satisfies u1/bar(u1)=u1^2. Rearranging proves
the second equation, with no g-th root of the unit being taken.
The exact oriented ratio height proved in LR1 is
height(v_i/bar(v_i))=(1/2)log N(v_i). Roots of unity and inversion
preserve height, which proves DC7. It includes the unit-residual case.

For the geometry, G/zeta=X^2+(2-zeta)X+1 has discriminant
-1-3*zeta of norm 13, so G has two distinct roots. The conjugate
quadratic likewise has two distinct roots. They have no common root:
G-Gbar=(zeta-bar(zeta))*N, while at a root of N both have value X,
which is nonzero. This also shows that their four roots are disjoint
from beta_+,beta_-. At infinity G/Gbar tends to zeta/bar(zeta), a
nonzero constant. Thus its cyclic geometric g-cover has exactly four
branch points, each with inertia g; its degree is g, since each zero
and pole is simple. This includes composite g.

The first ratio has one simple zero and one simple pole, at beta_+
and beta_-, so its geometric cover is cyclic of degree h, with inertia
h at those two points and no ramification at infinity.

Over an algebraic closure of K0 the two function-field extensions are
Galois, with disjoint branch sets. Their intersection is unramified
everywhere over P1. Riemann--Hurwitz excludes any nontrivial connected
unramified cover of P1 in characteristic zero. The extensions therefore
have trivial intersection, and their compositum is a field of degree
hg. This proves geometric connectedness without assuming gcd(h,g)=1
and without adjoining roots of unity to the arithmetic field K0.

The ramification contributions are 2D(1-1/h)+4D(1-1/g), and infinity
is unramified. Riemann--Hurwitz gives DC8. The actual x is finite
positive, hence is outside the two nonreal roots of N. Neither G(x)
nor Gbar(x) is zero, since their product is F/b^4>0. The actual nonzero
coordinates give a smooth affine point: the derivatives in Y and Z
are nonzero in characteristic zero. It lifts to the normalization
over K0. No converse from an arbitrary K0-point to a primitive seed
is asserted.

For h=g=2 the formula gives genus three, consistent with the earlier
two-square-class geometry. The construction does not assert a seed
in the already excluded two-unit-residual even-power subbranch.

## DC3. Actual residual counts and coefficient heights

For fixed h,g, all actual profiles with V0<=X0 and V1<=X1, where
X0,X1>=1, lift to at most

    C*X0*X1                                             (DC9)

models DC6 over K0, with an absolute constant C. This count covers
the whole two-residual range, not one fixed pair of norms.

Each model can be written as

    (x-beta_-)Y^h-eta0*(x-beta_+)=0,
    Gbar(x)Z^g-eta1*G(x)=0.                            (DC10)

The maximum height of an individual nonzero coefficient, and also the
projective height of all nonzero coefficients up to an absolute factor,
is bounded by

    Hcoef=C0*(1+log V0+log V1),                         (DC11)

where C0 is fixed. In particular no O(h) or O(g) term is introduced
into coefficient height. The degrees h and g remain explicit, and
are not being included in this coefficient-height claim.

Proof. The elementary coordinate count in MX1 gives at most 16X_i
Eisenstein integers of norm at most X_i. Each permits only finitely
many coefficients in DC5, from the six choices of a unit and the
two choices of e at the first norm. Multiplying the two cumulative
counts proves DC9. Restricting to actual compatible coefficients can
only reduce this count. No sum over residual norms and no independent
unit-class count is added to it.

All coefficients of G,Gbar and the beta values are fixed algebraic
numbers. The product-height inequality and DC7 bound the coefficients
of DC10 by DC11; there are a fixed number of nonzero coefficients
independent of h,g. This also bounds their projective height by a
constant multiple of DC11. This proves the assertions.

In particular, for L0,L1>=0 the union over V0<=exp(L0*h) and
V1<=exp(L1*g) has size at most

    C*exp(L0*h+L1*g).                                  (DC12)

The quadratic-field coefficient construction uses the actual norm
structure of F. It does not give a representative of height o(g)
for every class in K^*/K^{*g} in the generic QC list. The QC6 difficult
unit classes were not proved to have actual seeds. No generic
normalization theorem is contradicted or silently strengthened here.

## DC4. Height separation at arbitrary relative exponent growth

Put H=max(a,b), Hpoint=log H. Every profile satisfies the lower bound

    Hpoint >= max((h/2)log 7-log 2,
                  (g/4)log 7-(log 13)/4).              (DC13)

Indeed M>=7^h and M<c^2, while H>=c/2; also F>=7^g and F<=13H^4.

Consequently, for any sequence of actual profiles with

    T=max(h,g) -> infinity,
    log V0+log V1=o(T),                                (DC14)

the chosen model satisfies

    (Hcoef+log h+log g)/Hpoint -> 0.                    (DC15)

Proof. DC11 makes the numerator o(T), since log h+log g<=2log T.
The right side of DC13 is at least (T/4)log 7-log 2, a positive
constant times T for large T. Division gives DC15.

In particular DC14 holds whenever the actual residual proportions

    lambda0=max(1,log V0)/h -> 0,
    lambda1=max(1,log V1)/g -> 0.                       (DC16)

Both exponents then tend to infinity, and
(log V0+log V1)/T<=lambda0+lambda1 ->0. There is no condition on
the relative sizes or common divisors of h and g. The list in DC12,
with L_i=lambda_i, also satisfies log(max(1,#list))/T ->0.

These are necessary properties of any actual sequence, not an existence
claim. They do not contradict the existence of high points on varying
high-genus curves. A uniform estimate

    Hpoint<=A*(Hcoef+log h+log g+1)

for actual lifted points, with A independent of the profiles, would
exclude DC14. No such point-height bound is proved here. Neither
coefficient height, genus nor a small finite list alone supplies it.
In particular this reduction does not solve ABC or the fixed positive
two-step threshold on residual proportions.

## Dependencies and open branches

Actual Eisenstein UFD + gcd(ab,M)=1 + N(ab+M*zeta)=F -> DC1.
Actual first/second profiles + exact LR1 ratio height -> DC2 coefficients.
Six disjoint simple branch values + Riemann--Hurwitz -> DC2 geometry.
Two actual residual lattice counts -> DC3, independent of generic QC.
Actual norm growth + DC3 -> DC4.

The missing input is an upper bound or a different compatibility
obstruction for actual points of these degree-hg models. Moving roots,
nonunit residuals, unequal or coprime exponents, and the finite residual
threshold remain open. The earlier MX generic construction and the QC
class-normalization obstruction are retained with their precise scopes.
