# GD1--GD5. Two quadratic cube descents and the exact elliptic ranks

Status: complete ordinary proof, independently reviewed in full by root,
critical_bottleneck and adversarial_audit. Fifteenth-round continuation;
not part of the frozen fourteenth-round SS publication.
No GP rank upper bound or generator output is used. Fix

    E:  Y^2=X^3-9X-9,
    E': V^2=T^3-189T+999,
    epsilon=2+sqrt(3).

The earlier SS proof established the three-isogeny phi:E->E'. We prove
an explicit converse for a second three-isogeny and then a three-class
descent for phi. The result concerns the elliptic groups. It does not
determine the rational points of the simultaneous SS quartic.

## GD1. Every rational point on E has a genuine Gaussian cube root

For every finite (X,Y) in E(Q), there is a UNIQUE alpha+i*beta in Q(i)
such that

    (alpha+i*beta)^3=Y+3i(X+2).                  (GD1)

Proof. Choose primitive integral Weierstrass coordinates

    X=A/d^2, Y=B/d^3, d>0,
    gcd(A,d)=gcd(B,d)=1,
    B^2=A^3-9Ad^4-9d^6.

First 3 does not divide B. Otherwise reduction modulo 3 gives 3|A,
so gcd(A,d)=1 gives 3 not dividing d. Reducing the displayed equation
modulo 27 then gives B^2 congruent to -9d^6 congruent to 18 modulo 27.
This is impossible: writing B=3b would imply b^2 congruent to 2 modulo 3.

Put K=A+2d^2 and S=B+3idK. Exact expansion gives

    N(S)=B^2+9d^2K^2=(A+3d^2)^3.               (GD2)

This is positive since B is nonzero, so S is nonzero and A+3d^2>0.
For every prime q>3 dividing dK one has q not dividing B, by the
actual-curve boundary-unit proof in SS: q|d gives B^2 congruent to
A^3, a unit; q|K gives B^2 congruent to d^6, a unit. Thus a q>3
cannot divide both integer coefficients of S.

Use the Euclidean ring Z[i]. Its only ramified rational prime is 2.
At 2 the unique Gaussian prime has norm 2, so its exponent in S
is exactly v_2(N(S)), a multiple of three. There is no prime above
3 in S because 3 does not divide B. At an inert prime q>3, divisibility
of S would force q to divide both coefficients, which was excluded.
At a split prime q>3, both conjugate Gaussian primes cannot divide S:
their product is associated to q, again forcing divisibility of both
coefficients. Hence at most one orientation occurs, and its exponent
equals v_q(N(S)), a multiple of three. Every prime exponent in S
is therefore divisible by three.

For clarity, unique factorization here follows from the Euclidean
norm: round the real and imaginary coordinates of a quotient to
nearest integers; the norm of its difference from that Gaussian
integer is at most 1/2<1. The units are the four fourth roots of
unity, and cubing permutes them. It follows that S=W^3 for a
Gaussian integer W. Dividing by d^3 proves (GD1).

The field Q(i) has no nontrivial cube root of unity: a primitive one
has imaginary part plus or minus sqrt(3)/2, not rational. Thus two
nonzero cube roots cannot differ, giving uniqueness. No positivity
choice or denominator normalization beyond the actual d is hidden
in this argument. QED.

In particular the Gaussian cube condition is automatic on E(Q).
It is not a further exclusion test on its rational points.

## GD2. A rational inverse for the opposite three-isogeny

Define

    G(T)=(T+108/(T-9)+108/(T-9)^2)/9,
    c(T)=(1-108/(T-9)^2-216/(T-9)^3)/27.         (GD3)

The map psi:E'->E, (T,V)->(G(T),V*c(T)), extends to a
degree-three isogeny over Q. It induces a BIJECTION E'(Q)->E(Q).

For a finite point on E, take the cube root alpha+i beta in GD1.
Its unique rational preimage under psi is

    T=9+3/(beta-1), V=9alpha/(beta-1).           (GD4)

Proof. The rational-function identity

    (T^3-189T+999)c(T)^2=G(T)^3-9G(T)-9

proves the map between affine charts. It extends to the smooth
projective curves, maps O to O, and is therefore a group homomorphism.
Writing u=T-9 gives

    G=1+u/9+12/u+12/u^2.

Its numerator has degree three and is nonzero at u=0. The abscissa
degree diagram, as in SS, gives degree three. Its geometric kernel
is O and (9,+3sqrt(3)), (9,-3sqrt(3)), because G has its only finite
pole at T=9. In particular its kernel on Q-points is trivial.

Equation (GD1), after comparing its norm and its imaginary coordinate,
gives

    alpha^2+beta^2=X+3,
    beta(3alpha^2-beta^2)=3(X+2).                (GD5)

The value beta=1 is impossible: the first equation gives
alpha^2=X+2 and the second would give 3X+5=3X+6.
Thus (GD4) is defined and rational. Substitution of (GD5) into
(GD4) verifies the E' equation and psi(T,V)=(X,Y).
One can check these inverse identities without extracting radicals:
if u=T-9, put beta=1+3/u and alpha=V/(3u). Then

    alpha^2=(T^3-189T+999)/(9u^2),
    alpha^2+beta^2=G(T)+3,                      (GD6)
    beta(3alpha^2-beta^2)=3(G(T)+2),
    alpha(alpha^2-3beta^2)=V*c(T).

These are rational-function identities after using the E' equation.
Conversely eliminating alpha^2 from (GD5) gives
4beta^3-3(X+3)beta+3(X+2)=0; with beta not equal to 1 this
solves for X exactly as G in (GD4). The other identity recovers Y.
Thus all finite E(Q) points have a rational preimage.
The point O has O as its only rational preimage. The already proved
trivial rational kernel gives uniqueness on all E(Q). QED.

The scaling by 1/9 and 1/27 in (GD3) is part of the map; it is
not discarded as an implicit change of Weierstrass model.

Moreover psi phi=[3] on E. For a fully explicit verification, put

    f=X^3-9X-9,
    x2=(3X^2-9)^2/(4f)-2X,
    b2=(3X^2-9)(X-x2)/(2f)-1,
    l=(b2-1)/(x2-X),
    x3=f*l^2-X-x2, b3=l(X-x3)-1.

The addition law gives [3](X,Y)=(x3,Y*b3) on this dense chart.
With F and F' from SS, clearing denominators proves

    G(F(X))=x3, F'(X)c(F(X))=b3.                (GD7)

Both sides are morphisms on the smooth curve, so the equality
extends over the omitted chart points. This also identifies psi
as the dual isogeny in the required orientation.

## GD3. Three unit classes for every point on E'

For a finite (T,V) in E'(Q), set

    theta(T,V)=V+3sqrt(3)(T-8).

This is nonzero and has norm

    N(theta)=(T-9)^3.                           (GD8)

Its class modulo cubes in Q(sqrt(3))* is one of the three classes

    1, epsilon, epsilon^2.                     (GD9)

These three classes are distinct.

Proof. Write T=A/d^2,V=B/d^3 in primitive integral Weierstrass
coordinates with d>0. Then

    B^2=A^3-189Ad^4+999d^6.
    S=B+3sqrt(3)d(A-8d^2)
    N(S)=(A-9d^2)^3.                           (GD10)

The value T=9 is not a rational E' point, since it would give
V^2=27. Thus S is nonzero. Its norm need not be positive;
valuations of its nonzero integer norm still have their usual meaning.

If q>3 divides d, B^2 is congruent to A^3 and is a unit. If q>3
divides A-8d^2, then d is a unit and the elliptic equation gives

    B^2 congruent to (8^3-189*8+999)d^6
                  congruent to -d^6 modulo q.

Thus q does not divide both coefficients of S. In Z[sqrt(3)],
the rational primes 2 and 3 are ramified, each with one prime above
it of norm the rational prime. Their exponents in S are multiples
of three by (GD10). For q>3 an inert prime cannot divide S, and
at a split prime only one conjugate orientation can occur. Its
exponent is again v_q(N(S)), a multiple of three.

The ring of integers here is Z[sqrt(3)]. It is norm-Euclidean:
round the two rational coefficients of a field element to integers.
For the resulting differences a,b of absolute value at most 1/2,
one has |a^2-3b^2|<=3/4<1. Hence it is a UFD.

Its units are exactly plus or minus epsilon^j for j in Z.
A unit has norm +1 because norm -1 would give a square congruent
to -1 modulo 3. After changing its sign, it is positive in the
chosen real embedding. Dividing by a suitable epsilon power
reduces it to [1,epsilon). Any such unit strictly above 1 has
integer coordinates x>=2,y>=1, since its conjugate is its positive
reciprocal; it is therefore at least 2+sqrt(3), a contradiction.
This proves the claimed unit group.

The prime-exponent conclusion now gives S=epsilon^j W^3 after
absorbing a possible minus sign and a multiple of three from j
into W. Dividing by d^3 proves (GD9). Finally epsilon cannot be
a cube in the field: any such cube root would be an integral unit
(as follows from all prime valuations) with unit exponent one third,
contradicting the just-proved unit group. The same argument shows
that none of epsilon or epsilon^2 is a cube. QED.

## GD4. The class is a homomorphism, with exact kernel phi(E(Q))

Extend theta's cube class by delta(O)=1. Then

    delta:E'(Q)->Q(sqrt(3))*/Q(sqrt(3))*^3

is a group homomorphism, its image consists of all three classes in
(GD9), and its kernel is phi(E(Q)). Therefore

    |E'(Q)/phi(E(Q))|=3.                        (GD11)

Proof of the homomorphism, including the chord exceptions.
Work over K=Q(sqrt(3)), and put
T0=(9,-3sqrt(3)). Its tangent is
Y=m0 X+b0 with m0=-3sqrt(3), b0=24sqrt(3).
Its line function is theta=Y-m0 X-b0. The exact flex identity is

    X^3-189X+999-(m0 X+b0)^2=(X-9)^3.          (GD12)

For finite rational points P,Q whose joining line is not vertical,
write that line Y=mX+b, including a tangent when P=Q. Its three
intersections P,Q,R, counted with multiplicity, satisfy
P+Q+R=O. Their abscissas are the three roots of the monic polynomial

    F_line(X)=X^3-189X+999-(mX+b)^2.

If m not equal to m0, put x0=-(b-b0)/(m-m0). At x0 the line
equals the flex tangent, so F_line(x0)=(x0-9)^3. It follows by
multiplying the three linear evaluations at the roots that

    theta(P)theta(Q)theta(R)
          =[b-b0+9(m-m0)]^3.                   (GD13)

If m=m0 the evaluations all equal b-b0 and the same conclusion
holds. This argument is a polynomial root identity and remains
valid at repeated intersection points.
The right side is nonzero: a rational line cannot contain T0,
since its value at the rational abscissa 9 is rational while
the ordinate of T0 is not. No finite rational point equals T0
or has theta zero. On the other hand,

    theta(P)theta(-P)=(9-X(P))^3.               (GD14)

The value X(P)=9 is impossible for a rational point. Equations
(GD13)--(GD14) give delta(P+Q)=delta(P)delta(Q).
Vertical lines are covered directly by (GD14), and any case involving
O uses delta(O)=1. This proves the homomorphism on every rational point.

To determine its kernel, suppose theta(T,V)=(u+v sqrt(3))^3
with u,v rational. Norm and imaginary coordinate comparison give

    u^2-3v^2=T-9, v(u^2+v^2)=T-8.              (GD15)

Here the first equality follows from equality of rational cubes
of the norms, even when the norm is negative. The value v=1 is
impossible: the equations would give u^2=T-6 and u^2=T-9.
Define

    X=-3+3/(1-v), Y=3u/(1-v).                   (GD16)

Substitution shows that this point belongs to E(Q) and that
phi(X,Y)=(T,V). Explicitly with z=X+3 and v=1-3/z,
one has u=Y/z, and the rational-function identities are

    u^2-3v^2=F(X)-9,
    v(u^2+v^2)=F(X)-8,
    u(u^2+9v^2)=Y F'(X).

The converse is given by those same formulas: every finite phi
image has theta equal to (Y/(X+3)+(1-3/(X+3))*sqrt(3))^3.
The value X=-3 is not in E(Q), because it would give Y^2=-9.
The identity and its preimage O handle the point at infinity.
Thus the kernel is exactly phi(E(Q)).

Finally P'=(6,9) satisfies

    theta(P')=9-6sqrt(3)
             =epsilon^2 (3-2sqrt(3))^3.

Its class is epsilon^2, which is nontrivial and has order three.
Since the image was already contained in the three-element set
(GD9), it equals that set. The group homomorphism and exact kernel
prove (GD11). QED.

## GD5. An ordinary exact-rank certificate, not a generator theorem

The Mordell--Weil ranks of E(Q) and E'(Q) are both exactly one.
The rank of Jac(H1)(Q) for the earlier nontrivial-unit genus-two
quotient is exactly two.

Proof. The rational group isomorphism psi in GD2, with psi phi=[3],
identifies the quotient in (GD11) with E(Q)/3E(Q). Thus

    |E(Q)/3E(Q)|=3.

By the Mordell--Weil theorem E(Q) is finitely generated. If its
rank is r and its finite torsion subgroup is T, the displayed
cardinality is 3^r |T/3T|. The ordinary EQ proof already supplied
the infinite-order point P=(-2,1), using its exact doubling and the
strictly decreasing 2-adic valuations of repeated doublings.
Consequently r>=1. It follows that r=1 and |T/3T|=1.
The group isomorphism psi gives rank E'=1 as well.
The already proved Q-isogeny Jac(H1)~E x E gives exact rank two.
No program's rank output is used. QED.

This does NOT establish that P or P' is a generator of its entire
Mordell--Weil group. In particular it does not replace an index
calculation or an integral/rational-point computation. The SS
same-source quartic and positive inequalities remain necessary
and their complete rational solution set remains unknown here.
The automatic Gaussian cube in GD1 is a reversible descent,
not an extra obstruction to points satisfying SS.

Standard inputs are the elementary splitting/ramification laws
for Q(i) and Q(sqrt(3)), norm-Euclidean unique factorization,
the elementary chord law on an elliptic curve, the already cited
smooth-projective extension and origin-preserving morphism theorem,
and Mordell--Weil as used in EQ. The Euclidean and unit calculations
needed in this proof are given explicitly above. A diagnostic GP
script next_gaussian_probe.gp actually checked nine exact rational-
function identities, including (GD7); this finite software check
is separate from the ordinary proof and is not a rank certificate.
