# RS. The ramified first norm and all three actual cubic unit classes

New ordinary candidate, separate from the frozen AC3 square/cube
statement. No Lean or completed independent review is claimed here.
All integers called positive below are strictly positive.

Write O=Z[zeta], zeta^2-zeta+1=0, with conjugation
bar(zeta)=1-zeta and norm N(x+y*zeta)=x^2+xy+y^2.
For coprime positive integers a,b put

    c=a+b, d=a-b, M=a^2+ab+b^2,
    F=a^4+3*a^3*b+5*a^2*b^2+3*a*b^3+b^4.

The new family is M=3*U^2 and F=Q^3, with U,Q positive integers.
The coefficient 3 is retained throughout. The conclusions below do
not use the previously proved exclusion with M=U^2.

## RS1. Exact three-unit source and the ramified curves

Define homogeneous cubic polynomials

    A0=S^3-3*S*T^2-T^3,
    B0=3*S*T*(S+T),
    C0=A0+B0=S^3+3*S^2*T-T^3.                 (RS1)

The coordinates (A,B) of epsilon*(S+T*zeta)^3, for
epsilon=1,zeta,zeta^2 respectively, are

    (A0,B0), (-B0,C0), (-C0,A0).             (RS2)

These identities follow by multiplication using zeta^2=zeta-1.
For each epsilon, L_epsilon:[S:T] -> [A:B] is a degree-three
morphism of projective lines. In particular A and B have no common
projective zero. One way to check the entire projective statement is
to work over Q(zeta) and use

    rho(x)=(x+zeta)/(x+bar(zeta)),
    rho(L_epsilon(s))=epsilon^2*rho(s)^3.     (RS3)

Here s=S/T; the equation is an identity of rational maps, including
their projective extensions. The two branch values of L_epsilon
are -zeta and -bar(zeta). Hence each of the three distinct rational
targets infinity,-1,1/3 has three distinct preimages, and the three
fibres are pairwise disjoint.

Let K be the smooth projective conic

    3*V^2+W^2=12*L^2,
    r=(V^2-3*L^2)/(3*L^2).                  (RS4)

The expression for r defines a morphism K -> P1_r: if L=0 then
V is nonzero, so its two homogeneous coordinates cannot vanish
simultaneously. On the chart L=1 it is equivalent to

    v^2=3*(1+r), w^2=3*(1-3*r).            (RS5)

Define D^ram_(3,epsilon) as the smooth projective normalization of
the fibre product of L_epsilon:P1_[S:T] -> P1_r and K -> P1_r.
It is geometrically connected. Indeed the two functions
3*(A+B)/B and 3*(B-3*A)/B have independent square classes over
the geometric function field: each has three simple zeros absent
from the other. The extension over P1_[S:T] therefore has degree
four. It has nine branch points, at the three disjoint fibres just
listed, with inertia order two at each, including their common
poles above B=0. Riemann--Hurwitz gives genus six.

Its three genus-two quotients have the following homogeneous
equations, always interpreted by smooth projective normalization:

    H1^ram: Y1^2=3*B*(A+B),
    H2^ram: Y2^2=3*B*(B-3*A),
    H3^ram: Y3^2=(A+B)*(B-3*A).             (RS6)

On B!=0, Y1=B*v, Y2=B*w and Y3=B*v*w/3. The right sides
each have six distinct projective roots by (RS3). The third
quotient is unchanged by the ramified twist, whereas the first
two are twisted by 3. All three equations use the same source
[S:T]; separate points on different quotient curves do not supply
a point on D.

The definition by a projective fibre product is useful at the
exceptional fibres. Its normalization has morphisms to both the
source projective line and the whole smooth conic K. These are
defined at every point, not just on the affine equations (RS5).
Their two morphisms to P1_r agree everywhere, since they already
agree on the dense open chart.

For an actual solution M=3*U^2,F=Q^3, the ordinary integral
factorization proved in RS3 below supplies an equality

    ab+M*zeta=epsilon*(S+T*zeta)^3.          (RS7)

The rational numbers r=ab/M, v=c/U, w=d/U then satisfy (RS5),
at exactly that source, by c^2=M+ab and d^2=M-3ab.
Primitivity and positivity give 0<r<=1/3, v>0 and v>|w|,
or equivalently sqrt(3)<v<=2 on this conic. Equality r=1/3
would force a=b=1, U=1 and F=13, which is not a cube. Thus
an actual solution has 0<r<1/3 and sqrt(3)<v<2, avoiding all
three branch targets. Its point lifts to the smooth normalization.
No inverse from arbitrary points to integral seeds is assumed.

## RS2. Complete local exclusion of the three twisted curves

For every epsilon in {1,zeta,zeta^2},

    D^ram_(3,epsilon)(Q_3) is empty.          (RS8)

Proof. First consider the entire conic K over Q_3. At L=0 its
equation would give W^2=-3*V^2, impossible for nonzero V because
the valuation of -3 is odd. Thus every Q_3-point has L!=0.
Write a=v_3(v), b=v_3(w), with the usual convention that the
valuation of zero is infinity. The nonzero terms 3*v^2 and w^2
have valuations 1+2*a and 2*b, respectively, of opposite parity;
if both are nonzero they cannot cancel at their minimum.
Since their sum is 12 of valuation one, the minimum equals one.
It must be the first term, so a=0 and b>=1 (also allowing w=0).
The case v=0 is impossible because it would require a square of
valuation one. Consequently

    v is a 3-adic unit, w belongs to 3*Z_3,
    v_3(r)=v_3((v^2-3)/3)=-1.              (RS9)

Next take any [S:T] in P1(Q_3) and normalize its coordinates in
Z_3 with at least one a unit. This includes T=0.

If S is not congruent to T modulo three, then
A0=C0=(S-T)^3 modulo three, so A0 and C0 are units.
Moreover one of S,T,S+T vanishes modulo three: this is immediate
if one coordinate is zero, and otherwise the two distinct
nonzero residues are opposite. Thus B0 belongs to 9*Z_3.
In this case the three ratios A/B in (RS2) have valuations

    epsilon=1:      <=-2, or r=infinity if B0=0;
    epsilon=zeta:   >= 2, or r=0;
    epsilon=zeta^2:    0.                   (RS10)

If S is congruent to T modulo three, both are units. Write
S=T+3*K with K in Z_3. Direct expansion gives

    A0=-3*T^3+27*K^2*T+27*K^3,
    B0=3*S*T*(S+T),
    C0=3*(T^3+9*K*T^2+18*K^2*T+9*K^3).     (RS11)

The three polynomials now all have valuation exactly one:
their quotients by 3 are respectively -T^3, 2*T^3, T^3
modulo three. Each of the three ratios in (RS2) is a unit.

There is therefore no source in P1(Q_3), for any of the three
units, whose ratio r has valuation -1. If a Q_3-point of
D^ram_(3,epsilon) existed, its two everywhere defined projective
images would give such a source and a point of K with the same r.
Equation (RS9) contradicts (RS10)--(RS11). This also covers
points over branch fibres and infinity; the argument does not
discard them by using an affine presentation. This proves (RS8).

## RS3. A stronger actual arithmetic obstruction

For positive coprime integers a,b and a positive integer Q,

    F=Q^3 implies 3 does not divide M.       (RS12)

In fact the identity unit epsilon=1 can never occur in the
exact cubic extraction (RS7), for any such primitive pair.

Here is the full extraction argument. The actual element
z=ab+M*zeta has

    N(z)=(ab)^2+ab*M+M^2=F,
    gcd(ab,M)=1,
    F=(a^2+b^2)^2=1 modulo three.           (RS13)

For the last congruence, at least one of a,b is nonzero modulo
three; their squared sum is then 1 or 2. For the gcd claim,
a prime dividing ab and M would divide both a and b.

The ring O is norm Euclidean: rounding the two real coordinates
in the basis 1,zeta gives an error of norm at most 3/4<1.
Thus it is a UFD. Its units are the six powers of zeta.
An inert rational prime dividing N(z) would divide z as a
rational integer, contrary to primitivity. At a split rational
prime, both conjugate prime factors cannot occur in z, for their
product would divide both coordinates. The ramified prime above
three is absent by (RS13). Each occurring prime orientation
therefore has exponent exactly its rational exponent in N(z).

If N(z)=Q^3, all these exponents are multiples of three. This
gives (RS7), with integral S,T, gcd(S,T)=1 and
N(S+T*zeta)=Q. Absorbing a sign into the cube root reduces the
unit to exactly one of 1,zeta,zeta^2. Since 3 does not divide Q,

    S is not congruent to T modulo three.   (RS14)

There is no division by the content of a projective output and
no discarded nonunit residual in this equality.

On the other hand a primitive pair has v_3(M) either zero or
one. Indeed M=(a-b)^2+3*ab; if a is not congruent to b it is
a unit, and if a is congruent to b then a,b are units and the
second summand has valuation exactly one whereas the first
has valuation at least two.

Under (RS14), (RS10) shows more precisely that the second
coordinate B in (RS7) belongs to 9*Z_3 for epsilon=1, and is
a unit for epsilon=zeta or zeta^2. It can never have valuation
one. The identity unit is impossible because its second
coordinate is either zero or has valuation at least two,
whereas B=M is positive and has valuation at most one.
The remaining two units force M to be a unit. This proves
both assertions.

The usual other elementary local checks remain consistent:
F is odd for every primitive pair (check the three nonzero
pairs modulo two). Modulo five, F(S,1) takes the values
1,3,2,2,1 for S=0,1,2,3,4; when 5 divides b, F=a^4 is
nonzero. Thus 2,3,5 do not divide Q. Under M=3*U^2,
both U and Q would be odd and U would be a 3-adic unit.
None of these supplementary checks is being promoted to a
complete list of local conditions; (RS12) already supplies
the required contradiction.

It follows in particular that there are no positive integers
a,b,U,Q with gcd(a,b)=1 and M=3*U^2, F=Q^3. This conclusion
has two independent presentations above: the full projective
local gate (RS8) after actual extraction, and the stronger
integral-coordinate obstruction (RS12).

## RS4. Exact propagation and a local-versus-global distinction

The numerical statement (RS12) immediately extends to every
positive integer g divisible by three:

    F=Q^g, Q a positive integer, gcd(a,b)=1
    implies 3 does not divide M.           (RS15)

Simply rewrite Q^g=(Q^(g/3))^3. There is no parity condition
on g. In particular the ramified first profile M=3*R^h
is excluded together with F=Q^g for any positive integers
R,h,Q,g with 3|g and a,b positive coprime.

There is also an entire-projective geometric propagation.
For g=3*k with k a positive integer, define L_(epsilon,g)
by the coordinates of epsilon*(S+T*zeta)^g. Then

    L_(epsilon,g)=L_(epsilon,3) composed with L_(1,k).

The analogue of (RS3) is rho(L_(epsilon,g))=epsilon^2*rho(s)^g.
Thus each of infinity,-1,1/3 has g simple preimages, and these
three fibres are disjoint. The two square classes defining the
fibre product are still independent by their disjoint simple
zeros, so its normalization is geometrically connected, including
when g is even. Keeping the conic coordinates gives a map of projective fibre
products and a nonconstant rational map of their normalized
curves. It extends to their smooth projective normalizations.
Consequently the analogous ramified curves D^ram_(g,epsilon)
have no Q_3-points either. This assertion in particular covers
the previously considered odd exponents divisible by three.
It does not identify arbitrary unit classes modulo g-th
powers with the three displayed classes; it asserts the map
for these explicitly defined coefficients epsilon. The
numerical conclusion (RS15) does not require such an
identification.

It is essential not to replace the global integral extraction
by the claim that the two numerical norm equations alone have
no Q_3-solution. That claim is false. At a=1,b=4 one has
M=21 and F=541. In Q_3 there is U with U^2=7, by Hensel
at U=1 modulo three. There is also Q with Q^3=541:
put Q=1+3*t and solve

    t+3*t^2+3*t^3=60;

the left side minus 60 has a simple root t=0 modulo three.
Thus the two numerical equations are locally soluble at this
fixed primitive integer pair, although they have no common
global integral solution. The extra restriction used above
is the actual Eisenstein cube with one of three global units,
which follows from the integer norm cube and primitivity.
The full local emptiness in (RS8) concerns these exact
common-source covers.

## Scope and dependencies

The formulas and the 3-adic parity arguments above are
self-contained ordinary proofs. The passage to smooth
projective normalizations and extension of curve maps uses
the standard characteristic-zero curve facts already used
in RL/HG/CB; see Stacks, Curves, Section 53.2, especially
Lemma 53.2.2 and Theorem 53.2.6:
https://stacks.math.columbia.edu/tag/0BXX .
The extraction repeats the Euclidean argument from DC and
AC3 with its ramification and content assumptions included.

This is a new fixed exact-profile exclusion, not an ABC
proof. It supplies no uniform height bound for varying
residuals, no theorem that all possible ABC counterexamples
have these perfect-power profiles, and no classification
for exponents not divisible by three. Nonunit second
residuals can change the cubic-unit equations. Neither
their coverage nor a uniform point-height estimate is
claimed. The previous frozen unramified square/cube
result remains a separate theorem.
