# HG1--HG3. Three smaller Jacobians for the actual first-square locus

Status: complete ordinary proof, independently reviewed in full by
root, critical_bottleneck and adversarial_audit. This is a
separate twelfth-round exploration. It does not assert that the new
quotient curves have been solved or that the varying-exponent locus
is empty.

Fix an odd integer g>=3 and u in {1,zeta,zeta^2}. Let A=A_E,u(S,T)
and B=B_E,u(S,T) be the homogeneous degree-g integer forms in RL.
Thus A+B*zeta=u*(S+T*zeta)^g. Put r=A/B. The smooth projective
curve D=D_(g,u) in RL is the normalization of

    r(s)=a0(t)*b0(t)/U0(t)^2,
    a0=t^2-1, b0=2t+1, U0=t^2+t+1.               (HG1)

## HG1. A rational biquadratic presentation and all three quotients

Over Q the function field of D is

    Q(D)=Q(s)(v,w),
    v^2=1+r,        w^2=1-3r.                     (HG2)

It is a geometrically connected V4 cover of P1_s, of degree four,
with genus 3g-3. Its three degree-two quotient curves H1,H2,H3
have homogeneous hyperelliptic equations

    H1: y1^2=B(A+B),
    H2: y2^2=B(B-3A),
    H3: y3^2=(A+B)(B-3A).                         (HG3)

Each right side is a squarefree binary form of degree 2g. The y_j
have homogeneous weight g; the curves mean the corresponding smooth
projective models. Each H_j has genus g-1. On the dense affine
chart their quotient maps are

    y1=Bv,       y2=Bw,       y3=Bvw.             (HG4)

Proof of the function field. Put c0=t^2+2t and
d0=t^2-2t-2=a0-b0. The identities

    c0^2=U0^2+a0*b0,
    d0^2=U0^2-3a0*b0

give v=c0/U0 and w=d0/U0. Conversely,

    t=(v+w+2)/(v-w)                              (HG5)

is the inverse on a dense open. To check it, note first
w^2+3v^2=4 and set a_*=(v+w)/2, b_*=(v-w)/2.
Then a_*^2+a_*b_*+b_*^2=1. Substitution into (HG5) gives
a0/b0=a_*/b_* and U0/b0=1/b_*, recovering v and w as
well as r=a_*b_* on the dense open where these expressions are
defined. Thus this is an equality of function fields. The maps extend
to the unique smooth projective models; no point with a vanishing
denominator is discarded from that projective statement.

For completeness, all branch points in (HG3) can be verified without
factoring high-degree polynomials. Over K_E the power map r(s) is
conjugate under rho_E to a nonzero scalar times a g-th power. Its
only branch values are -zeta and -bar(zeta). The three rational
target values infinity, -1, 1/3 are distinct and avoid these branch
values. Their inverse images are therefore three disjoint sets of
g simple geometric points on P1_s. They are exactly the zeros of
B, A+B, and B-3A, including any zero at infinity in homogeneous
coordinates. Hence these three forms have simple disjoint zero
sets and degree g.

The square classes 1+r and 1-3r in the geometric rational function
field are independent: their valuations at a zero of A+B and at a
zero of B-3A respectively detect the two possible nontrivial
exponents modulo two. Thus the extension in (HG2) has degree four
and geometric group V4. At a zero of A+B only v ramifies, at a
zero of B-3A only w ramifies, and at a zero of B both have simple
poles and their inertia is the common order-two diagonal subgroup.
There are no other branch points. Riemann--Hurwitz consequently gives

    2 genus(D)-2=-8+(3g)*2=6g-8.

The three nontrivial square classes define its three index-two
subfields. Clearing denominators by the square B^2 gives (HG3)
and (HG4). Each double cover has exactly 2g simple branch points,
so 2 genus(H_j)-2=-4+2g. This proves every assertion, including
the points at infinity and the use of normalization where the raw
fiber product of H1 and H2 is singular at a common branch point.

## HG2. A Q-isogeny and transport of odd torsion

Let p_j:D->H_j be the quotient maps, and let J_D and J_j denote
their Jacobians. Define the homomorphisms over Q

    Phi:J_D -> J1 x J2 x J3,
        P |-> ((p1)_*P,(p2)_*P,(p3)_*P),
    Psi:J1 x J2 x J3 -> J_D,
        (P1,P2,P3) |-> p1^*P1+p2^*P2+p3^*P3.    (HG6)

Here pushforward is the norm homomorphism and pullback is the usual
pullback on degree-zero divisor classes. Then

    Psi Phi=[2] on J_D.                          (HG7)

In particular Psi is an isogeny over Q. For u=1, the class Theta
constructed in UG2 maps under Phi to a K-rational point of exact
order g on J1 x J2 x J3. For prime g at least one of its three
coordinates has exact order g. For composite odd g only the exact
order of the tuple is asserted; it need not be attained by a single
coordinate.

Proof. A finite map of smooth curves is finite locally free. Pullback
of line bundles and their norm therefore give functorial maps on
Picard schemes and hence the displayed homomorphisms of Jacobians.
Equivalently they act on divisors by pullback and pushforward; norms
of rational functions ensure that principal divisors map to principal
divisors. These constructions and the maps p_j are defined over Q.

Let sigma_j be the involution generating the group of D->H_j.
Over an algebraic closure, the divisor identity for a double quotient
is

    p_j^* (p_j)_*=1+sigma_j.

It holds at ramified points too: there the pullback multiplicity is
two and the two terms on the right coincide. Let q:D->P1_s be
the V4 quotient. The analogous full-group identity gives

    q^*q_*=1+sigma_1+sigma_2+sigma_3.

It is zero on the Jacobian because Pic^0(P1)=0. Summing the three
double-quotient identities proves (HG7) over an algebraic closure
and hence over Q. Multiplication by two on an abelian variety in
characteristic zero is surjective, so (HG7) makes Psi surjective.
Its source and target have equal dimension 3(g-1) by HG1. Therefore
its kernel has dimension zero and is finite, proving the isogeny.

For the torsion assertion Phi(Theta) is killed by g. If an integer
n kills it, (HG7) shows that 2n kills Theta. The exact order g in
UG2 and oddness imply g|n. This proves exact order g of the tuple.
If g is prime, a tuple of order g has at least one nonzero coordinate,
which then also has order g. This gives a concrete use of the UG
invariant on smaller Jacobians, without confusing an isogeny with an
isomorphism or suppressing its degree-two effects.

## HG3. The positive rational domain and an explicit genus-two entry

On the nonbranch rational chart, points of D with t>1 are exactly
the rational triples (s,v,w) satisfying (HG2) and

    0<r(s)<1/3,        v>0.                      (HG8)

The first inequality and (HG2) imply 1<v<2/sqrt(3) and |w|<1.
The reconstruction (HG5) is therefore well defined and greater than
one: v-w>0 and its numerator exceeds its denominator by 2(w+1)>0.
Conversely for rational t>1, v=c0/U0>0 and r=a0*b0/U0^2>0.
The inequality r<=1/3 follows from d0^2>=0. Equality would require
d0=t^2-2t-2=0, whose roots 1+-sqrt(3) are not rational. Thus it
is strict, giving (HG8). The map is inverse to (HG5), including the
ordered choice of the sign of w.

By RL, these positive rational points give actual primitive seeds
with first norm a square and second norm a g-th power. When
gcd(g,6)=1 the single u=1 curve gives the ordered-seed bijection.
For g divisible by three retain the three choices of u as in RL.
Testing one quotient H_j alone is only a necessary condition: the
rational points on H1 and H2 must have the same source coordinate s
and satisfy the real-domain condition (HG8). Their common source,
rather than arbitrary choices of points on the two curves, recovers D.

At the concrete exponent g=3 and u=1 one has in the chart T=1

    A=s^3-3s-1,          B=3s(s+1),
    A+B=s^3+3s^2-1,
    B-3A=-3s^3+3s^2+12s+3.                       (HG9)

Equations (HG3) with these forms define three explicit genus-two
curves, and their three Jacobians are isogenous in product to the
genus-six Jacobian of D_(3,1). The zero of B at infinity is retained
in its homogeneous degree-three form. The other u choices are
obtained by the same integer coordinate multiplication, not discarded.
No rank computation, rational-point enumeration, or emptiness result
for these genus-two curves is asserted by writing their equations.

## Sources and scope

The model extension and ramification arguments use the established
smooth-projective curve and Riemann--Hurwitz statements from the
Stacks Project, tags 0BXX and 0C1B. The Picard/Jacobian interpretation
and functorial homomorphisms use their usual construction, as in
Milne, Jacobian Varieties, Theorem 1.1, Remark 1.5 and Section 6:
https://www.jmilne.org/math/xnotes/JVs.pdf
For the general context of group-action decompositions, the primary
article by Lange and Recillas, Abelian varieties with group action,
was also actually opened:
https://arxiv.org/abs/math/0106055
Its exposition assumes complex base field. The Q-isogeny here is
proved directly by the Q-defined pullback and norm maps in (HG6),
not by silently treating that article as an arithmetic descent theorem.

This is a reduction in the dimension of the auxiliary Jacobians,
with an exact positive rational point domain and explicit transport
of the odd torsion invariant. It is not a solution of any of the
three rational-point problems. Uniform control as g varies, moving
residual coefficients, and the ramified first norm remain open.
