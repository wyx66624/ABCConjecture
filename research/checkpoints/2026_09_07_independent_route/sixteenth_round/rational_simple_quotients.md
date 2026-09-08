# QS1--QS4. Rational simplicity of the two remaining genus-two factors

Status: complete ordinary proof, fully reviewed by root and both peers.
Both peers independently recomputed all finite-field point counts.
This is separate sixteenth-round research; the fifteenth GD manuscript and
formal arithmetic are not changed. No rank upper bound or complete rational
point set is claimed.

Put f_t(s)=s^3+3t s^2+(3t-3)s-1. In the previously proved HG presentation
for g=3 and u=zeta the three genus-two curves are

    H1: y^2=f_0 f_1,   H2: y^2=f_1 f_4,   H3: y^2=f_0 f_4.

All curves below mean their smooth projective models. Let J_j=Jac(H_j).

## QS1. The actual order-three symmetry has a genus-zero quotient

Each H_j has the automorphism over Q

    sigma(s,y)=(-1/(s+1), -y/(s+1)^3).

It has exact order three and extends over all projective chart exceptions.
Its quotient has genus zero, and J_j admits an action of Q(sqrt(-3)) over Q.
Consequently rank J_j(Q) is even.

Proof. Direct homogeneous substitution gives

    (s+1)^3 f_t(-1/(s+1))=-f_t(s)

for every t. Thus sigma preserves each displayed curve. The Mobius matrix
[[0,-1],[1,1]] has cube -I, and the weight-three ordinate transformation
has precisely the corresponding sign, so sigma^3 is the identity. Its
nontrivial action on s proves exact order. The birational map extends to an
automorphism of the smooth projective curve, including s=-1 and infinity.

Write A=-3s(s+1), B=f_1(s), r=A/B as in HG. Both homogeneous cubic
coordinates transform by the same factor. On H1, H2 and H3 respectively,
the invariant ordinate y/B satisfies

    v^2=1+r,   w^2=1-3r,   z^2=(1+r)(1-3r).

The map s -> r has degree three. The fixed fields are therefore exactly
the three displayed conic function fields: the invariant extension has
degree at most three and the order-three automorphism forces equality.
Each conic is smooth projective of genus zero and has a rational point
(r,ordinate)=(0,1). The norm followed by pullback to J_j is
1+sigma_*+sigma_*^2 and factors through the zero Jacobian of this conic.
Hence sigma_* satisfies X^2+X+1=0. Sending the root of this irreducible
rational polynomial to sigma_* defines a unital embedding of the field
Q(sqrt(-3)) into End_Q(J_j) tensor Q. The induced action on J_j(Q) tensor Q
makes that finite-dimensional rational vector space a vector space over a
quadratic field. Its Q-dimension, the Mordell--Weil rank, is even. This
argument includes rank zero and supplies no upper bound. QED.

## QS2. Complete good-prime certificates at five

H2 and H3 have good reduction at five. Their exact point counts are

                 #H(F5)       #H(F25)
    H2               6             36
    H3               6             12.

In particular their Jacobian Frobenius characteristic polynomials at five
are, respectively,

    P2(X)=X^4+5X^2+25,     P3(X)=X^4-7X^2+25.       (QS1)

Proof of smoothness. The discriminant of f_t is
81(t^2-t+1)^2, which is nonzero modulo five for t=0,1,4. Two distinct
chosen cubic factors differ by 3(t-u)s(s+1), with nonzero constant
3(t-u) modulo five. Neither factor vanishes at s=0 or s=-1: its values
are -1 and 1. Thus each sextic has six distinct geometric roots in
characteristic five. Its leading coefficient is one; in the infinity
chart the two points have ordinates +1 and -1 and are smooth. The two
standard hyperelliptic charts consequently give a smooth proper model
over Z_5, so its Jacobian has good reduction as well.

Here is the entire finite certificate. At s=0,1,2,3,4 the sextic values
modulo five are [1,3,2,3,1] for H2 and [1,2,3,2,1] for H3. In each row there are two squares and three
nonsquares. Thus the affine fibre count is 5-1=4 and the complete
projective count is 4+2=6.

For avoidance of a normalization shortcut, the character sum in F5 is
explicitly 1-1-1-1+1=-1 in both rows. In F25=F5[omega], omega^2=2,
the quadratic character of a+b omega is the Legendre symbol of
(a^2-2b^2) modulo five. For b=0,1,2,3,4 and columns a=0,1,2,3,4,
the full character tables of the sextic values are

    H2:
     1  1  1  1  1
     1  1 -1  1  1
     1 -1 -1 -1  1
     1 -1 -1 -1  1
     1  1 -1  1  1

    H3:
     1  1  1  1  1
    -1 -1 -1 -1 -1
    -1 -1 -1 -1 -1
    -1 -1 -1 -1 -1
    -1 -1 -1 -1 -1.

The sums are 9 and -15. Adding 25 for the affine fibre baseline and
the two infinity points gives 36 and 12. The norm-character rule is
exact since chi_25(x)=x^12=Norm_25/5(x)^2; no zero entry occurs here.
These finite tables can be checked directly, independently of software.

Let S1=5+1-#H(F5), S2=25+1-#H(F25). The curve/Jacobian Frobenius trace
formula and Newton's identity give

    P(X)=X^4-S1 X^3+((S1^2-S2)/2)X^2-5S1 X+25.

Here S1=0 and S2=-10 or 14, proving (QS1). QED.

## QS3. No rational elliptic quotient for either remaining factor

Both J2 and J3 are simple over Q. In particular H2 and H3 admit no
nonconstant morphism over Q to any genus-one curve, and neither
Jacobian is Q-isogenous to a product of elliptic curves. Moreover J2
and J3 are not Q-isogenous to each other.

Proof. If a dimension-two abelian variety over Q is not simple over Q,
Poincare reducibility gives a Q-isogeny to E_a times E_b with elliptic
curves E_a,E_b. Since J_j has good reduction at five, its rational
Tate module is unramified there. The isogeny decomposition and the
Neron--Ogg--Shafarevich criterion give good reduction of both E_a and
E_b at five. Their integer Frobenius traces a,b then imply

    P_j(X)=(X^2-aX+5)(X^2-bX+5).

The X^3 coefficient forces b=-a. The X^2 coefficient is 10-a^2.
For P2 this would give a^2=5; for P3 it gives a^2=17. Neither equation
has an integer solution, a contradiction. This uses only one good prime,
not a guess from a finite collection of primes.

A nonconstant map from H_j to a genus-one curve induces a surjection
from J_j to its dimension-one Jacobian, and hence contradicts simplicity.
Equivalently one can use a rational point at infinity on H_j to reduce
the image curve to its elliptic Jacobian. Distinct polynomials at the
same good prime prohibit an isogeny J2 -> J3, since an isogeny identifies
the rational Tate modules and their Frobenius actions.

This is simplicity over Q, not absolute simplicity. The simplicity argument
does not itself bound the ranks; QS4 below supplies lower bounds. With HG
and GD the known Q-isogeny now reads

    Jac(D_(3,zeta)) ~ E^2 x J2 x J3,
    rank Jac(D_(3,zeta))(Q) = 2 + rank J2(Q) + rank J3(Q).

The two remaining ranks and the simultaneous positive source locus are
still undetermined. The new conclusion rules out replacing J2 or J3 by
Q-defined elliptic factors; it does not rule out passing to an extension
field or working directly with the two-dimensional factors. QED.

## QS4. Torsion vanishes and the genus-six rank is at least six

Both J2(Q) and J3(Q) have trivial torsion and rank at least two.
Consequently rank Jac(D_(3,zeta))(Q) is at least six, its genus.

Proof. Seven is another good prime. The discriminants 81(t^2-t+1)^2
and the differences 3(t-u)s(s+1), for the same t,u, remain nonzero as
needed modulo seven. Thus the smoothness proof in QS2 applies verbatim.
The sextic values at s=0,...,6 modulo seven are

    H2: [1,0,1,0,3,0,1],   H3: [1,0,3,0,1,0,1].

In each case the character sum is two and #H(F7)=7+2+2=11.
In F49=F7[omega], omega^2=3, the complete sextic character tables,
with rows the coefficient b and columns the coefficient a, are

    H2:
     1  0  1  0  1  0  1
     1 -1  1  1  1 -1  1
     1 -1 -1 -1  1  1  1
    -1 -1  1 -1  1  1 -1
    -1 -1  1 -1  1  1 -1
     1 -1 -1 -1  1  1  1
     1 -1  1  1  1 -1  1

    H3:
     1  0  1  0  1  0  1
     1 -1  1  1  1 -1  1
     1  1  1 -1 -1 -1  1
    -1  1  1 -1  1 -1 -1
    -1  1  1 -1  1 -1 -1
     1  1  1 -1 -1 -1  1
     1 -1  1  1  1 -1  1.

Both sums are ten, so both counts are #H(F49)=49+10+2=61.
Newton's identities give, for both Jacobians,

    P7(X)=X^4+3X^3+10X^2+21X+49,
    #J(F7)=P7(1)=84.

At five, QS2 gives #J2(F5)=31 and #J3(F5)=19. For good reduction
at p, the prime-to-p rational torsion injects into the finite special
fibre. This is the prime-to-p torsion specialization underlying the
Tate-module good-reduction criterion; it follows also from smooth proper
base change for the finite etale multiplication-by-m kernels, m coprime
to p. For each torsion prime ell other than five and seven its order
must divide both 84 and respectively 31 or 19, whose gcd is one.
Five-primary torsion is excluded by 5 not dividing 84, and seven-primary
torsion by 7 dividing neither 31 nor 19. Thus all rational torsion is zero.

Each H_j has the rational points P=(0,1) and the infinity point Q=inf_+,
with leading ordinate +1. They are distinct. Their divisor class [P-Q]
is nonzero: if it were principal, a function with exactly the single
simple pole Q would give a degree-one morphism to P1, making a genus-two
curve rational. It therefore has infinite order, since torsion is zero.
Thus each remaining rank is positive. QS1 proves both ranks even, so
each is at least two. The already proved rank E(Q)=1 and the HG isogeny
give the claimed lower bound 2+2+2=6 for D. QED.

This proves only lower bounds. It excludes using the classical strict
rank-less-than-genus hypothesis directly on D or either H2,H3. It is
not a proof that elliptic Chabauty after extension, quadratic Chabauty,
a further descent, or another method cannot determine the points.
In particular no upper rank, Mordell--Weil basis, height bound or actual
positive seed has been constructed by this argument.

## Primary inputs actually consulted

- Milne, Abelian Varieties, Course Notes, Chapter I Proposition 10.1
  (printed p.42 / PDF p.48): reducibility over the ground field.
  Chapter IV Theorem 3.5 and Corollary 3.6 (printed pp.141--142 /
  PDF pp.147--148): good reduction and rational Tate modules.
  https://www.jmilne.org/math/CourseNotes/AVc.pdf
- Milne, Jacobian Varieties, Theorem 11.1 and Corollary 11.4
  (printed pp.35--37): curve counts and Jacobian Frobenius.
  Corollary 12.3 proof (printed p.39): smooth curve reduction gives
  good Jacobian reduction.
  https://www.jmilne.org/math/xnotes/JVs.pdf
- The previously checked HG divisor norm/pullback identity and the
  smooth-projective extension theorem from Stacks 53.2.2/53.2.6.

The table is exact finite arithmetic feeding an ordinary argument through
these explicit standard inputs. No complete Lean Jacobian or Frobenius
formalization is claimed.

Exact standard-library replay: `replay_rational_simple_quotients.py --check`.
Its canonical four curve/prime certificate is
`verification/rational_simple_quotients.json`, SHA-256
`6ba65a743aa190819b6d3b43c7e357d0f5aacb1e53508078cab882a46f240883`.
It directly counts all square fibres in both fields and independently
compares with norm-character tables; finite arithmetic only.
