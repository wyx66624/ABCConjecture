# Exact power-class lifting and finite Kummer descent for the second norm

Date: 2026-09-07. Fourth-round ordinary proof, submitted for independent review.
Third-round files and manuscript transcription remain frozen.

Let

    F(X,Y)=X^4+3X^3Y+5X^2Y^2+3XY^3+Y^4,
    F(x)=F(x,1).

For positive coprime integers a,b this is the second actual mixed norm M1.
Its discriminant is 117, so F has four distinct roots. All conclusions below
concern actual integer seeds. None asserts that the two-step ABC
counterexample threshold can be attained.

## 1. The denominator class required by a direct affine lift

For an integer h>=2, write

    delta=gcd(h,4), m=h/delta, k=4/delta.

A positive integer D is h-free if every prime valuation of D belongs to
{0,...,h-1}. Every positive rational class modulo h-th powers has exactly
one positive h-free integer representative, by reducing each of its finitely
many nonzero prime valuations modulo h. The analogous convention applies
to m-free representatives, including m=1, when the sole representative is 1.

**PL1 (exact direct lifting).** Fix h, a positive h-free integer D, and a
positive m-free integer beta. Primitive positive solutions

    F(a,b)=D W^h,     b=beta B^m,     W,B positive integers             (P1)

are in bijection with positive rational points (x,y) on

    y^h=beta^4 F(x)/D                                                (P2)

whose reduced denominator b in x=a/b satisfies b=beta B^m. The maps are

    x=a/b,       y=W/B^k;
    W=y B^k.                                                        (P3)

In the reverse direction B and W are automatically integers; this is part
of the statement, not an additional unproved lifting assumption.

Proof. The definitions give 4m=hk. Thus homogeneity and
b^4=beta^4(B^k)^h prove (P2) and (P3).
For the integrality step, if a positive rational q satisfies D q^h in Z
and D is h-free, then for every prime p

    h v_p(q)=v_p(Dq^h)-v_p(D)>=-(h-1).

As the left side is divisible by h, it is nonnegative. Hence q is an
integer. Apply this first to b=beta B^m, and then to F(a,b)=D W^h.
When m=1 the first assertion is immediate. The positive reduced fraction
x uniquely specifies a,b, and positive y uniquely specifies W, so these
maps are mutually inverse on the stated sets.

The preceding argument uses only the identity 4m=hk. In particular the
formula for y involves the integer exponent k=4/delta, not the generally
nonintegral exponent 4/h on b.

**Minimal denominator parameter.** The homomorphism

    Q_{>0}^*/(Q_{>0}^*)^m -> Q_{>0}^*/(Q_{>0}^*)^h,
    [b] -> [b^4],                                                   (P4)

is injective. Indeed h divides 4 v_p(b) exactly when m divides v_p(b),
for every p. Thus m is the exact quotient exponent needed to retain the
fourth-power denominator class, rather than just a convenient larger one.

**A strict counterexample to the naive affine map.** The actual primitive
seed (a,b)=(1,2) has F(a,b)=67. Set D=67 and W=1. Then

    F(1/2)/67=1/16.

If h does not divide 4, this is not an h-th power in Q, since its 2-adic
valuation is -4. Therefore the uncorrected map y=W/b^(4/h) does not yield
a rational point on y^h=F(x)/D for this seed. This refutes that map, not a
possible finiteness theorem for the underlying integer equation. For h=3,
the corrected data are beta=2, B=1, and y=1 in (P2).

## 2. The direct curve and its coupled class

**PL2 (direct-cover genus and finiteness).** Fix h>=2 and d>0 rational.
The smooth projective curve with function field

    Q(x)(y),    y^h=F(x)/d                                         (P5)

is geometrically connected of degree h over P1 and has genus

    g_h=(3h-2-gcd(h,4))/2.                                         (P6)

For h>=3 it has only finitely many rational points. Therefore, for fixed
h>=3 and a fixed finite set of classes in Q_{>0}^*/(Q_{>0}^*)^h, only
finitely many primitive positive seeds satisfying F(a,b)=V W^h can have

    [V b^(-4)]_h                                                 (P7)

in that set. In particular fixing [V]_h and [b]_m suffices. For h=4 the
denominator parameter is trivial, recovering the fourth-power boundary.

Proof. Over the algebraic closure a valuation one at any root of F
forces degree h. More explicitly the Kummer class of F has order h,
because its valuation at that root has order h modulo h. At each of the
four roots the ramification index is h, giving total contribution 4(h-1).
At infinity the pole order is four. There are delta=gcd(h,4) points over
infinity, each of ramification index h/delta, giving contribution h-delta.
No other point ramifies. Riemann--Hurwitz gives

    2g_h-2=-2h+4(h-1)+(h-delta)=3h-4-delta,

which is (P6). For h>=3 this genus is at least three, and Faltings's
theorem applies. If (P7)=[d]_h, write V b^(-4)=d q^h with q rational.
The actual equation gives F(a/b)=d(qW)^h, hence a rational point of (P5).
Each rational x=a/b determines its primitive positive seed uniquely.
There are finitely many twists under the stated hypothesis, proving the
claim. For h=2 the genus is one; the independently proved QG2 family
provides infinitely many primitive positive seeds with square M1.

PL2 gives the precise direct-lift bookkeeping. It is not the strongest
finiteness conclusion for fixed h and residual class: the next descent
uses primitivity to remove the denominator-class restriction completely.

## 3. Finite arithmetic descent into four-branch covers

We give the argument explicitly, so that fixed residual class finiteness
does not depend on an invalid direct affine normalization. This is a
specialization of the classical Kummer descent underlying the
Darmon--Granville theorem, not a new general finiteness theorem.

**PL3 (finite Kummer class lemma).** Let K be a number field, let S be a
finite set of its nonarchimedean primes, and let h>=2 be fixed. Then

    K(S,h)={z in K^*: v_P(z) in h Z for every P outside S}/K^{*h}     (P8)

is finite.

Proof. In the ring O_{K,S} of S-integers, (z)=a^h for a fractional ideal
a. Assign to z the class [a] in the h-torsion of Cl(O_{K,S}). This is
well-defined modulo h-th powers and its target is finite, since the
S-class group is a quotient of the finite ideal class group of K. Its
kernel consists exactly of S-units modulo h-th powers: if a=(t), then
z/t^h is an S-unit. Conversely an S-unit has a trivial fractional ideal.
The S-unit group is finitely generated, so its quotient by h-th powers
is finite. Finite kernel and finite image prove (P8) finite. No
principal-ideal assumption or unique factorization of elements is used.

**PL4 (fixed higher-power residual class: finite actual seeds).** Fix
h>=3 and a positive rational class [D]_h. There are only finitely many
primitive positive integers a,b for which

    F(a,b)=D W^h,     W positive rational.                          (P9)

Consequently the same is true for a fixed finite set of residual h-th
power classes. It is also true if D varies over all positive integers
whose prime support is contained in a fixed finite set S0. No
denominator-class condition is imposed in this theorem.

Proof. Choose the h-free positive integer representative D, absorbing an
h-th power into W. The integrality lemma in PL1 shows that W is then an
integer. Take K containing all four roots alpha_1,...,alpha_4 of F and
the h-th roots of unity. This is a fixed number field for the fixed h.
The alpha_i are algebraic integers because F is monic. Set

    L_i=a-alpha_i b,        product_i L_i=D W^h.                    (P10)

Let S contain every prime of K over a rational prime dividing 117D.
For P outside S, all differences alpha_i-alpha_j are P-units: their
squared product is the discriminant 117. If P divided L_i and L_j,
then P would divide (alpha_i-alpha_j)b, hence b and then a. This is
impossible because an integer Bezout relation between a and b remains
an identity in O_K. Thus at most one L_i has positive P-valuation.
Each L_i is integral. Taking the valuation of (P10) shows that its
valuation is divisible by h for every P outside S.

By PL3 the four classes [L_i] in K^*/K^{*h} range over a finite set.
In particular the three ratios L_i/L_4, i=1,2,3, range over finitely
many triples of classes. Choose a representative xi_i for each such
ratio class. Then every seed yields a K-rational point on one of the
finitely many curves

    y_i^h=(x-alpha_i)/(xi_i (x-alpha_4)),  i=1,2,3,    x=a/b.       (P11)

The roots of F are nonpositive-real or nonreal, and F(x)>0 for x>0;
in particular none of the denominators in (P11) vanishes at these seeds.

Here is the geometry of the smooth projective normalization of (P11).
Over an algebraic closure the constants xi_i may be removed. The three
Kummer classes (x-alpha_i)/(x-alpha_4) are independent modulo h: the
valuation at alpha_i of a product of their powers is precisely the i-th
exponent. If that product is an h-th power, each exponent is divisible
by h. This applies also when h is composite. Kummer theory therefore
gives a geometrically connected degree h^3 cover with group (Z/hZ)^3.

At alpha_i for i<=3, exactly one of the three functions has valuation
one and the others are units, so the inertia order is h. At alpha_4
all three have valuation -1. In the completed geometric local field,
each unit has an h-th root in characteristic zero, so adjoining all
three roots adjoins only one h-th root of a local uniformizer. The
inertia order at alpha_4 is again h, the diagonal cyclic subgroup,
rather than h^3. At infinity all three ratios are units, and the
cover is unramified there. Thus exactly four points of P1 branch,
each contributing h^2(h-1). Riemann--Hurwitz gives

    2G_h-2=-2h^3+4h^2(h-1)=2h^2(h-2),
    G_h=1+h^2(h-2).                                               (P12)

For h>=3, G_h>1. Each fixed curve (P11) has only finitely many
K-rational points by Faltings's theorem over number fields. There are
finitely many curves, and each positive reduced rational x determines
a,b uniquely. This proves finiteness for fixed [D]_h, and finite unions
prove the finite-class assertion. Finally, if D is supported on S0,
its h-free representative is one of at most h^{|S0|} integers, obtained
by choosing each prime exponent in {0,...,h-1}. This proves the final
assertion. Alternatively one may use S over 117 times the primes S0
directly in (P10).

The curves in (P11) need not give every rational point of a direct
twist (P5); they capture every actual primitive integer seed. This is
why the finite descent succeeds without fixing the direct denominator
class. The added input is integral primitivity outside a finite set,
not an assertion that b^(4/h) is rational.

## 4. Actual-profile consequences and the remaining moving branches

**PL5 (residual support or exponent escape).** Consider actual second
profiles of primitive positive seeds,

    M1=V1 Q1^{g1},      V1,Q1,g1 positive integers,

along a sequence whose seed height a+b tends to infinity.

(a) For every fixed integer h>=3, along the terms with h|g1, the class
[V1]_h eventually leaves every fixed finite set of h-th power classes.
In particular the prime support of V1 cannot remain in any fixed finite
set along such a height-tending-to-infinity subsequence.

(b) If the prime support of V1 is contained in one fixed finite set
throughout the sequence, then, for every fixed h>=3, h divides g1 only
finitely often. Hence eventually 4 does not divide g1, and for every
fixed bound B, no odd prime <=B divides g1 once the index is large enough.
If in addition g1 tends to infinity, its 2-adic valuation is eventually
at most one and its least odd prime factor tends to infinity.

Proof. When h|g1, put W=Q1^{g1/h} in PL4. A fixed finite class set
gives only finitely many seeds; a height-tending-to-infinity sequence
eventually leaves that finite set. The finite-support statement follows
from the last assertion of PL4. Apply it successively to h=4 and each
of the finitely many odd primes <=B. If g1 tends to infinity, after
excluding 4|g1 the only integers lacking an odd prime factor are 1 and
2, which no longer occur. This proves the final assertion.

The unit residual case V1=1 is included. In particular arbitrary moving
roots cannot produce an unbounded primitive family with pure second
exponents all divisible by one fixed h>=3. This excludes fixed odd
exponent subfamilies as well as fixed higher even divisibility. It says
only that each such subfamily is finite, not that it has no seeds.

**PL6 (finite total support, without fixing the exponent).** Fix a finite
set S of rational primes. There are only finitely many primitive positive
seeds for which the entire prime support of M1 is contained in S.
Consequently, in any sequence with seed height tending to infinity and
M1=V1 Q1^{g1}, if the prime support of Q1 is confined to one fixed finite
set S_Q, then the support of V1 eventually escapes every fixed finite set
S_V, in the precise sense that supp(V1) is not a subset of S_V for all
sufficiently large indices. No exponent-divisibility hypothesis is needed.

Proof. Fix h=3 and write M1=D W^3 with D cube-free. If supp(M1) is in S,
there are at most 3^{|S|} possible D. Apply PL4 to this finite set. If both
supp(Q1) is in S_Q and supp(V1) is in S_V, then supp(M1) is in the fixed
union S_Q union S_V, so there are only finitely many seeds. A sequence
whose height tends to infinity eventually leaves that finite collection.
This is a concrete Thue--Mahler finiteness consequence, not a new general
theorem or a quantitative prime-growth estimate.

No uniform bound as h varies has been proved. Thus pure second exponents
that are large odd primes, or twice large odd primes, remain possible
under these results. Moving residual support also remains open. For
general residuals, a small analytic parameter lambda1=max(1,log(V1))/g1 does
not bound the residual support or its h-th power class, so PL4--PL5 do
not settle the finite two-step threshold from NT4. The geometric
results identify exact subclasses that cannot support the proposed
unbounded sequence; they do not prove or disprove ABC.

## 5. Dependencies, source provenance, and verification scope

The direct map, integrality lemma, class map, factor coprimality, and
ramification calculations are proved above. PL3 uses finiteness of
number-field ideal class groups and finite generation of S-unit groups.
PL2 and PL4 use Faltings's theorem. None of those number-field or
geometric inputs is claimed to have been formalized in Lean here.

The higher-power finiteness in PL4 is an explicit instance of an
established result. Darmon and Granville, *On the equations z^m=F(x,y)
and Ax^p+By^q=Cz^r*, Bull. London Math. Soc. 27 (1995), 513--543,
Theorem 1 and its following consequence on printed p. 514, give the
fixed-exponent finiteness for a form with four simple roots and h>=3.
Their Section 2 develops the underlying ideal-theoretic descent.
Author-hosted primary PDF, actually opened for this note:

https://www.math.mcgill.ca/darmon/pub/Articles/Research/12.Granville/pub12.pdf

Faltings's original 1983 paper is separately sourced in the frozen QG
note; its original bibliographic record is https://eudml.org/doc/143051.
The 1984 correction must not be substituted for the original paper.

A repository search found previous Darmon--Granville applications to
three-term generalized Fermat equations and moving power kernels. This
note makes no claim to have discovered the general theorem. Its role
is the explicit second-norm denominator accounting and finite
four-branch descent, with the actual-profile consequences above.
