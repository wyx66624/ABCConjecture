# MX1--MX4. Mixed exponent covers with an actual first-profile coefficient

Status: complete ordinary proof; independently reviewed by root,
critical_bottleneck and adversarial_audit. The two explicit QC-domain
and coefficient-convention clarifications were implemented and reviewed.
Not Lean formalized.
Ninth-round mathematical sources remain frozen. The two exponents here
need not have a common divisor, and the first residual need not be a unit.
No point-height upper bound is asserted.

Retain zeta^2-zeta+1=0, K0=Q(zeta), gamma=1+zeta, and the fixed
degree-eight splitting field K of

    f(X)=X^4+3X^3+5X^2+3X+1.

The reviewed QC1 field contains K0 and all four roots alpha_1,...,alpha_4.
Put beta_+=-zeta and beta_-=-bar(zeta), the roots of N(X)=X^2+X+1.
All six roots are distinct: N is separable, f is separable, and
f modulo N equals X^2, so Res(N,f)=1.

For an actual positive primitive seed a,b, put c=a+b, x=a/b,
M=a^2+ab+b^2 and F=b^4 f(x). Consider a genuine oriented first profile

    a+b*zeta=u*gamma^e*v*w^h,       e in {0,1}, h>=2,
    V0=N(v), R=N(w)>=7,            M=3^e V0 R^h,        (MX1)

with primitive oriented, unramified v,w as in the earlier profile theorem.
The residual v and root w may share oriented primes. Also suppose

    F=V1 Q^g,   g>=9,   V1,Q positive integers, Q>1,
    1<=V1<2^g.                                         (MX2)

The size restriction ensures v_q(V1)<g for every prime q, precisely
the residual-domain condition used by QC2--QC5. No assumption relates
h and g. In particular this includes gcd(h,g)=1.

The old QC setup's Q>=7 hypothesis is satisfied. For a primitive seed,
F is odd and F=1 modulo 3. If 5 does not divide b, the values of
f(r) modulo 5 for r=0,1,2,3,4 are respectively 1,3,2,2,1; if 5
divides b, primitivity gives F=a^4!=0 modulo 5. Thus no prime among
2,3,5 divides F, and the integer root Q>1 automatically satisfies Q>=7.

## MX1. The actual first Kummer coefficient has no h-sized unit ambiguity

Define

    xi0=(u^2*zeta^e*v/bar(v))^(-1).

Then the actual seed satisfies

    (w/bar(w))^h = xi0*(x-beta_+)/(x-beta_-),           (MX3)
    height(xi0)=(1/2)log V0.                           (MX4)

Here height is the absolute logarithmic Weil height, unchanged upon
extension from K0 to K. In particular when v is a unit, xi0 belongs
to a fixed finite group of roots of unity, even if h is divisible by
2 or 3. No h-th root of u is needed.

Proof. Conjugating (MX1) gives

    (a+b*zeta)/(a+b*bar(zeta))
      =u^2*zeta^e*(v/bar(v))*(w/bar(w))^h,

because u*bar(u)=1 and gamma/bar(gamma)=zeta. Divide by b and
rearrange. The exact primitive oriented ratio height is
height(v/bar(v))=(1/2)log N(v), proved in LR1: the archimedean
absolute values are one and the numerator and denominator ideals
are disjoint conjugates. Shared primes between v and w do not
change the absence of conjugate pairs within v. Multiplication
by a root of unity and inversion preserve height. This proves MX1.

There are at most C X possibilities for xi0 from all actual residuals
with N(v)<=X, for an absolute constant C and X>=1. Indeed
N(v)=r^2+rs+s^2>=3r^2/4,3s^2/4, so there are at most
(4sqrt(X)/sqrt(3)+1)^2<=16X integral coordinate pairs. The finitely
many unit and e choices change only the constant. This is a count
over all residual norms up to X; it must not be summed once more
over their possible norm values.

## MX2. The mixed cover, with arbitrary h and g

The reviewed second-norm lifting QC2--QC5 provides a finite choice of
xi_1,xi_2,xi_3 in K^* and actual K-valued coordinates Z_i such that

    Z_i^g=xi_i*(x-alpha_i)/(x-alpha_4),   i=1,2,3.       (MX5)

Here the coefficients of QC are replaced by their inverses: QC places
them in the denominator. Inversion preserves heights and the list size.

Combine this with

    Y^h=xi0*(x-beta_+)/(x-beta_-).                      (MX6)

Let C_{h,g,xi} be the smooth projective normalization of these four
equations. It is geometrically connected and the projection to P1_x
has degree

    D=h*g^3.

Its genus is

    genus(C)=1+D*(2-1/h-2/g)
            =1+2h g^3-g^3-2h g^2.                    (MX7)

The actual coordinates (x,w/bar(w),Z_1,Z_2,Z_3) give a K-point
on this curve above the original primitive positive seed.

Proof. Work first over an algebraic closure of K, so all needed
roots of unity and all roots of the nonzero twist coefficients
are present. The three quartic ratios are independent modulo
g-th powers, including composite g: valuation at alpha_i is one
for its own ratio and zero for the other two. The corresponding
cover has degree g^3. Its four branch points are the alpha_i,
each with inertia g; at alpha_4 the three poles share the same
local uniformizer root, giving diagonal cyclic inertia g. Infinity
is unramified. These are the previously proved PL/QC cover facts.

The new h-cover has degree h, by its simple zero at beta_+, and
is branched exactly at beta_+,beta_-, each with inertia h.
Its branch set is disjoint from the quartic cover's branch set.
Their intersection as function-field extensions is therefore
unramified everywhere over the projective line: each intermediate
extension can ramify only where its containing extension ramifies.
A nontrivial connected unramified cover of P1 in characteristic zero
is impossible by Riemann--Hurwitz. Hence the intersection is trivial.
Both extensions are Galois over the algebraic closure, so the
compositum has degree h*g^3 and is a field. This proves geometric
connectedness without assuming gcd(h,g)=1.

The six branch points have ramification contributions
2D(1-1/h)+4D(1-1/g), respectively. Infinity is still unramified.
Thus 2genus-2=-2D+2D(1-1/h)+4D(1-1/g), proving MX7.
The actual seed has finite positive x and lies outside all six
branch points; its four Kummer coordinates are nonzero. The affine
cover is smooth there, since h and g are nonzero in characteristic
zero, so the actual point lifts to the normalization over K.
No converse that every K-point is a primitive integer seed is asserted.

## MX3. A residual budget without an additional h-unit-class factor

For fixed h,g,V1 and all first residuals V0<=X, X>=1, the actual
seeds under (MX1)--(MX2) lift to a list of at most

    C_K X g^9 4^(8 omega(V1))                          (MX8)

mixed covers. For any L0>=0 and 0<=L1<log 2, the union over

    V0<=exp(L0*h), V1<=exp(L1*g)

is covered by at most

    C_K g^9 exp(L0*h+17L1*g)                           (MX9)

models. The defining equations can be chosen so that the maximum
absolute Weil height of their individual coefficients is at most

    C_K*(g+log V0+log V1+1).                           (MX10)

The degree in Y is h and the degrees in the Z_i are g. These
degrees have not been confused with coefficient height.

Proof. QC2--QC5 give at most C_K g^9 4^(8omega(V1)) second-norm
models for fixed g,V1. Their normalized ratio coefficients satisfy
height(xi_i)<=2log V1+C_K g. This accounts for the fixed field's
unit rank three, class-group choices, and the actual depth-one
prime 13. In particular its factor is not silently omitted.

For each such second model, MX1 contributes at most C X first
coefficients over all residual norms at most X. There is no
independent h^3 unit-class factor: the actual oriented first
profile already supplies its precise coefficient (MX3).
This proves MX8. Since V1>=2^omega(V1),
4^(8omega(V1))<=V1^16. Summing over integers V1<=Z yields at
most Z^17, where Z>=1. With X=exp(L0 h), Z=exp(L1 g), this
gives MX9, without an additional summation loss in X.

After clearing the linear denominators, the four equations are

    (x-beta_-)Y^h-xi0*(x-beta_+)=0,
    (x-alpha_4)Z_i^g-xi_i*(x-alpha_i)=0.

The six branch values are fixed. The height inequality for
products, MX4 and the QC5 coefficient bound prove MX10.
There are a fixed number of coefficients, so the corresponding
projective coefficient height has the same bound up to a fixed
constant as well. This supplies no bound on a point of these curves.

## MX4. An actual nonunit height separation in an unequal-exponent regime

Consider any sequence of genuine profiles (MX1)--(MX2) with

    h -> infinity, g/h -> 0,
    log V0/h -> 0, and log V1/g bounded.               (MX11)

For the chosen covers in MX3, let Hcoef be their coefficient-height
bound and let Hpoint=height(a/b)=log max(a,b). Then

    Hcoef/Hpoint -> 0,
    (Hcoef+log h+log g)/Hpoint -> 0.                   (MX12)

Proof. Equation (MX10) and MX11 imply Hcoef=o(h). On the other
hand (MX1) gives M>=R^h>=7^h, while M<c^2. Thus log c is
at least (h/2)log 7. Since c/2<=max(a,b)<c,
Hpoint>=log c-log 2 and is bounded below by a positive constant
times h for large h. The logarithmic degree terms are o(h) as
well: log h=o(h), and g=o(h) with g>=9 gives log g=o(h).
Division proves MX12.

This is a necessary separation for actual points and allows a
nonunit first residual, a nonunit second residual, and relatively
prime exponents. It is not the existence of such a sequence and
not a contradiction. A sufficient next step would be a uniform
upper bound

    Hpoint <= A*(Hcoef+log h+log g+1)

for the actual lifted points in this explicitly defined family,
with A independent of h,g and the actual residuals. No such
point-height statement is proved here; it is the remaining
geometric gate, not a premise renamed as a conclusion.

## Dependency graph and preserved alternatives

Actual first profile + LR1 ratio height -> MX1.
QC2--QC5 actual quartic lift + disjoint six branch values -> MX2/MX3.
Actual first norm growth + MX3 -> MX4.
Uniform point-height or a sharper compatibility theorem is still
needed to rule out profiles satisfying MX11.

This branch does not require a common exponent. The comparable
exponent regime, large moving second residual support and point
heights beyond a coefficient-height budget remain open. No
genus, finite list of twists, or coefficient bound is used alone
to infer a bound on rational points or to claim ABC.
