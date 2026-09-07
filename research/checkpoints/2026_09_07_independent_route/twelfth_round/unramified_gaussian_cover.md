# UG1--UG3. An explicit unramified cover and a Jacobian torsion class

Status: complete ordinary proof, independently reviewed in full by
root, critical_bottleneck and adversarial_audit. This is a
separate twelfth-round note. All eleventh-round sources remain frozen.
The new conclusions concern a specified family of curves, not a uniform
height theorem or the existence of an ABC counterexample.

Let g>=3 be an odd integer. Use the curves D=D_(g,1) and C=C_(g,1)
defined over Q in RL2--RL4, and let pi:C->D forget the Gaussian
coordinate. Here “defined over Q” has no elliptic Q-curve meaning.
Put K=Q(i,sqrt(-3)), zeta=(1+i sqrt(3))/2 and
alpha=(sqrt(3)-i)/2. Thus alpha^2=bar(zeta), where bar(alpha)
denotes complex conjugation. On P1_t put

    c0=t^2+2t, U0=t^2+t+1,
    a0=t^2-1, b0=2t+1, A0=a0*b0,
    B1=c0-alpha U0,       B2=c0+alpha U0,
    B3=c0-bar(alpha) U0,  B4=c0+bar(alpha) U0.

The previously proved BK identities are

    E=A0+zeta U0^2=B1 B2,       bar(E)=B3 B4,
    G=A0+i U0 c0=B1 B4,        bar(G)=B2 B3.       (UG1)

The four B_j have degree two and eight distinct simple roots over
an algebraic closure of K. No root is infinity. These facts were
proved from their nonzero discriminants and pairwise coprimality in
BK1; they are hypotheses already discharged there, not inferred from
finite testing. The function fields after base change to K are

    K(D)=K(t,Y),          Y^g=E/bar(E),
    K(C)=K(t,Y,Z),        Z^g=G/bar(G).             (UG2)

BK2 and RL2 prove geometric degrees g and g^2 over P1_t. In
particular these are fields, not a choice of an unexamined component.

## UG1. The relative cover is finite etale of degree g

The morphism pi:C->D is a finite etale morphism defined over Q, of
degree g. The genera are

    genus(D)=3g-3,
    genus(C)=1+3g^2-4g=1+g*(genus(D)-1).          (UG3)

Proof. The forgetful map on function fields gives a nonconstant map
of the smooth projective models. It extends over every point and is
finite, as for any nonconstant morphism of smooth projective integral
curves. The degree quotient from (UG2) is g.

On the base P1_t over an algebraic closure, the function defining
D's Kummer equation has a simple zero at each root of B1 or B2 and a simple pole at each
root of B3 or B4. Thus each of these eight points has a unique point
above it, with ramification index g. Elsewhere the cover D->P1 is
unramified: at a unit the local Kummer polynomial has nonzero
derivative, and at infinity the rational function has order zero.
Riemann--Hurwitz gives

    2 genus(D)-2=-2g+8(g-1)=6g-8.

For C->P1 the BK local computation gives ramification index g at
each of the same eight branch points, and index one elsewhere. One
can see the index directly: at every branch point the two Kummer
valuations are one of (1,1),(1,-1),(-1,-1),(-1,1). After extracting
g-th roots of local units over the algebraically closed residue field,
both extensions lie in the same extension obtained by adjoining a
g-th root of a uniformizer. Its ramification index is exactly g.
Ramification indices multiply in the tower C->D->P1, so pi has
index one at every geometric point. In characteristic zero this
finite morphism of smooth curves is therefore etale. Etaleness
descends to Q, so no assertion that K contains mu_g is used.
The genus of C in (UG3) is BK2's odd-exponent formula; it also
follows by applying Riemann--Hurwitz to the unramified degree-g map.

## UG2. A single Kummer function and an exact torsion divisor

Set

    f=B4/B2 in K(D)^*,       m=(g+1)/2.

Then the extension in UG1 has the following explicit equation over K:

    W=(Z/Y)^m/f,       W^g=f,       W^2=Z/Y,
    K(C)=K(D)(W),      Z=Y W^2.                    (UG4)

For j=2,4 let R_j be the sum of the two geometric points of D above
the two roots of B_j. Each R_j is a divisor defined over K of degree
two. The degree-zero class

    Theta=[R4-R2]

has exact order g in Pic^0(D_K), and its image in Jac(D)(K) also
has exact order g. Its geometric order after base change to an
algebraic closure is still g.

Proof of (UG4). The factorization (UG1) gives

    (G/bar(G))/(E/bar(E))=(B4/B2)^2=f^2.

Hence (Z/Y)^g=f^2. Since 2m=g+1,

    W^g=f^(2m-g)=f,
    W^2=(Z/Y)^(g+1)/f^2=Z/Y.

Conversely Z=Y W^2 satisfies its original equation. These identities
give both inclusions of function fields in (UG4), over K itself.

The divisors R_j are defined over K because the two roots of B_j
form a Galois-stable set, and each root has a unique point of D above
it. The two sets are disjoint. Pulling the zeros and poles of f from
P1 to D multiplies their valuations by g, while infinity contributes
zero. Consequently

    div_D(f)=g(R4-R2).                             (UG5)

This proves g*Theta=0. To prove the exact order, work over an
algebraic closure k of K. If Theta had order d<g, then d divides g
and there would be h in k(D)^* with div(h)=d(R4-R2). The function
f/h^(g/d) would have zero divisor and hence be a nonzero constant,
since D is geometrically integral and projective. As k is
algebraically closed, write that constant as c^(g/d). Thus

    f=(c h)^(g/d).

Writing r=g/d>1, the polynomial T^g-f becomes the product of
T^d-xi*c*h as xi ranges over the r-th roots of unity. Every root
therefore has degree at most d over k(D). This contradicts the
geometrically connected extension k(C)/k(D) of degree g from UG1.
Thus the geometric order is exactly g, and the order over K is
also g because (UG5) already gives an upper bound over K.

For the Jacobian statement, use the standard natural map from
degree-zero line bundles to the Jacobian. The divisor R4-R2 is an
actual divisor defined over K, so it defines such a line bundle over
K and hence a K-rational Jacobian point. After base change to k the
map is the usual identification Pic^0(D_k)=Jac(D)(k). The exact
geometric order just proved therefore gives exact order g for its
K-rational image. No equality of all Pic^0(D_K) and Jac(D)(K), and
no rational base point on D, is needed for this argument.

There is also a precise arithmetic cover interpretation. Locally on
D, (UG5) writes f=s^g u, where s is a rational local equation for
R4-R2 and u is a regular unit. The normalization is locally obtained
by adjoining W/s with (W/s)^g=u. These equations are finite etale
because g is invertible and u is a unit; scaling W by mu_g gives a
mu_g-torsor over D_K. This is an action of the group scheme mu_g.
Only after base change to an algebraic closure is it a cyclic cover
with all g deck transformations given by scalar multiplication.
We do not assert that K contains all g-th roots of unity, or that the
arithmetic extension over K has a constant cyclic deck group of
order g.

## UG3. What this etale descent does on the actual rational locus

Let D(Q)_{>1} and C(Q)_{>1} denote the points whose finite rational
base coordinate t is greater than one. The restriction

    pi:C(Q)_{>1}->D(Q)_{>1}                        (UG6)

is a bijection. If gcd(g,6)=1, both sets are in bijection with the
ordered positive primitive integer seeds satisfying

    a^2+ab+b^2=U^2,       F(a,b)=Q^g,
    U,Q>=7.                                       (UG7)

Proof. The unique Gaussian lifting in RL4 is exactly the map pi
on this chart, so it proves (UG6). Its proof supplies a Gaussian
norm-one g-th root and uses mu_g intersect Q(i)={1} for odd g to
prove uniqueness; it does not mistake the geometric degree g for
the number of Q-rational lifts. The extra gcd(g,6)=1 hypothesis
is exactly RL4's single-curve, unit-absorption and Eisenstein-root
uniqueness hypothesis, giving (UG7).

In particular the nontrivial etale cover, and the exact-order
Jacobian class which defines it, do not remove any point of the
specified positive rational Eisenstein locus. Each such point has
a rational lift, so after base change to K the corresponding torsor
fiber has a K-rational point. This is compatible with a globally
nontrivial, geometrically connected torsor.

## Established inputs, independent scope, and remaining gate

The curve extension and characteristic-zero ramification statements
use the standard smooth-projective curve results in the Stacks
Project, Section 53.2 (tag 0BXX) and Section 53.12 (tag 0C1B):
https://stacks.math.columbia.edu/tag/0BXX
https://stacks.math.columbia.edu/tag/0C1B
The Jacobian interpretation uses J. S. Milne, Jacobian Varieties,
Theorem 1.1 and Remark 1.5, with their explicit treatment of the
natural Picard-to-Jacobian map without assuming a rational point:
https://www.jmilne.org/math/xnotes/JVs.pdf
The RH section and the Milne source were actually opened and the
stated portions read during this proof. The BK and RL inputs are
ordinary repository proofs, not Lean theorems about these curves.

The new invariant is a specified K-rational torsion class of order g
on a Jacobian whose dimension is 3g-3. It is available for an actual
fixed-exponent descent or Jacobian computation. No uniform torsion
bound in fixed dimension applies here, since the dimension grows.
Nor does the torsion construction provide a uniform point-height
upper bound, a computation of all rational points, or emptiness of
the odd-exponent positive locus. The ramified first norm, nonunit
residuals, and other exponent ratios remain separate active branches.
