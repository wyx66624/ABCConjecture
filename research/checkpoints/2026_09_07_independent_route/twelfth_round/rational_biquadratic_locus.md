# RL1--RL4. An exact rational point domain on the biquadratic cover

Status: complete ordinary proof, independently reviewed in full by
root, critical_bottleneck and adversarial_audit. All
eleventh-round files are frozen. This note concerns the odd second
exponent and does not infer an upper height bound from a genus formula.

Write K_E=Q(zeta), zeta^2-zeta+1=0, K_G=Q(i), and K=K_E K_G.
Throughout, g>=3 is an odd integer. For an integer pair (S,T), define
homogeneous degree-g forms by

    (S+T zeta)^g=A_E(S,T)+B_E(S,T) zeta,
    (S+T i)^g=A_G(S,T)+B_G(S,T) i.

For a unit u in Z[zeta], let A_E,u and B_E,u be the coordinates of
u(S+T zeta)^g. Multiplication by -u gives the same projective map as u.
It therefore suffices to use u in {1,zeta,zeta^2}.

Use the rational functions from BK:

    a0=t^2-1, b0=2t+1, c0=t^2+2t, U0=t^2+t+1,
    A0=a0*b0, E=A0+zeta U0^2, G=A0+i U0 c0.          (RL1)

Their homogeneous forms in [T0:W0] have degree two for a0,b0,c0,U0,
where b0=W0(2T0+W0), and degree four for A0=a0*b0. Thus both ratios
A0/U0^2 and A0/(U0 c0) are projective rational maps of degree four.

## RL1. Rational norm-one coordinates

Define, on rational projective parameters,

    rho_E(s)=(s+zeta)/(s+bar(zeta)),
    rho_G(v)=(v+i)/(v-i),

with both values equal to one at infinity. Each is a bijection from
P1(Q) to the norm-one elements of the respective quadratic field.

Proof. The denominators do not vanish at a rational finite parameter,
and direct conjugation gives norm one. Conversely, for Y in K_E with
Y bar(Y)=1 and Y!=1, the unique inverse is

    s=(zeta-Y bar(zeta))/(Y-1).

Conjugating this expression and using bar(Y)=Y^-1 leaves it fixed,
so it is rational. The value Y=1 corresponds exactly to infinity.
For Z in K_G the same argument gives

    v=i(Z+1)/(Z-1)

when Z!=1, and infinity otherwise. These formulas also prove
injectivity, including the infinite parameter.

The g-power map on the Gaussian norm-one rational group is injective
for odd g. The g-power map on the Eisenstein norm-one rational group
is injective when gcd(g,6)=1. Indeed a quotient of two possible roots
is a g-th root of unity. The roots of unity in Q(i) are mu4, and in
Q(sqrt(-3)) are mu6. For completeness, the trace of a nonreal root
of unity in a quadratic imaginary field is a rational algebraic
integer in {-2,-1,0,1,2}, since its norm and complex absolute value
are one. The quadratic polynomials X^2-trace*X+1 give only orders
1,2,3,4,6. The two distinct fields exclude respectively orders 3,6
or order 4. This proves the claimed torsion bounds and injectivity.

## RL2. A complete curve defined over Q

For each u in {1,zeta,zeta^2}, let C_(g,u) be the smooth projective
normalization of the following fiber product in
P1_t x P1_s x P1_v:

    U0^2 A_E,u(s)-A0 B_E,u(s)=0,
    U0 c0 A_G(v)-A0 B_G(v)=0.                       (RL2)

All forms have rational integer coefficients. Its base change to K
is isomorphic to the BK cover

    Y^g=u^-2 E/bar(E),      Z^g=G/bar(G).           (RL3)

It is consequently geometrically connected of degree g^2 over P1_t,
and has genus 1+3g^2-4g. Its geometric structure is valid for every
odd g, including odd composite g; no coprimality of g with 3 is needed
for this statement.

Proof of the projective domain and isomorphism. The coordinate pairs
(A_E,u,B_E,u) and (A_G,B_G) have no common projective zero: otherwise
the powers of both distinct conjugate linear forms would vanish,
forcing S=T=0. Thus they are finite degree-g maps P1 -> P1. The target
pairs (A0,U0^2) and (A0,U0 c0) also have no common zero. In the affine
chart the numerator's roots are 1,-1,-1/2, while U0 has none of these
roots and c0 has roots 0,-2. At infinity the numerator vanishes and
both denominators are nonzero. Hence the target maps have degree four.
The fiber product is finite over P1_t, of total generic degree g^2,
with no vertical curve component.

On a dense open, apply the fractional linear coordinates
Y=rho_E(s), Z=rho_G(v). The power identities give

    rho_E(A_E,u/B_E,u)=u^2 rho_E(s)^g,
    rho_G(A_G/B_G)=rho_G(v)^g,

which turn (RL2) exactly into (RL3). Their fractional linear inverses
give the inverse function-field map. BK's odd-exponent relation
calculation proves geometric connectedness and the degree and genus;
the unique smooth projective model extends the birational map to
the stated isomorphism. The branch points of BK lie away from t>1,
because at a real t>1 the norm of E and G is F(a0,b0)>0. The raw
fiber product is therefore already smooth at every point with t>1.

The even-exponent two-component defect in BK has not been omitted:
this note assumes g odd. No such connectedness claim is extended
here to even g.

## RL3. A sufficient and exact Galois condition at a K-point

Suppose (t,Y,Z) is a point of (RL3) with t rational and t>1. Suppose
also

    Y in K_E,  Y bar(Y)=1,
    Z in K_G,  Z bar(Z)=1.                           (RL4)

These are sufficient conditions to reconstruct positive coprime
integers a,b and integers U,Q>=7 with

    a^2+ab+b^2=U^2,       F(a,b)=Q^g.               (RL5)

They are also exactly the rational-descent conditions on this
nonbranch chart of C_(g,u). Namely RL1 recovers s,v in P1(Q), so
(t,s,v) is a Q-point of (RL2); conversely every such Q-point satisfies
(RL4). These conditions can equivalently be tested with the two
generators of Gal(K/Q): if sigma_E conjugates K_E and fixes i, and
sigma_G conjugates i and fixes K_E, then

    sigma_E(Y)=Y^-1, sigma_G(Y)=Y,
    sigma_E(Z)=Z,    sigma_G(Z)=Z^-1.                (RL6)

Proof of the actual integer inverse. First x=a0/b0=(t^2-1)/(2t+1)
is finite positive, so write x=a/b in lowest positive terms. The
identity a0^2+a0 b0+b0^2=U0^2 shows

    a^2+ab+b^2=(b U0/b0)^2.

A rational square root of an integer is an integer: in a reduced
fraction its denominator would otherwise contribute a negative prime
valuation to its square. Thus U=bU0/b0 is a positive integer.

By RL1 the Eisenstein equation provides a rational power-map input s
with output ratio A0/U0^2=ab/(a^2+ab+b^2). Together with the first
map x=L_(1,2)(t), this is precisely the pure-coefficient RD fiber
product at exponents (2,g). CI1 therefore supplies the actual
primitive norm identity F=Q^g with Q>=7; its first ramified parity
is zero because the first exponent is two and its initial coefficient
is one. The same CI theorem gives U>=7. It includes ramified and
infinite projective inputs, so none was silently excluded here.
Alternatively, F prime to 3 and g odd force the second primitive
input to be unramified in CI's exact content calculation. The signs
of a,b and the primitive reduction are those of its full inverse.

The Gaussian equation is an actual additional coordinate on the
cover, but is not needed to establish the norm identity once this
positive rational Eisenstein input is supplied. This distinction is
important for interpreting the cover's arithmetic value.

## RL4. Unique rational Gaussian lifting and a single-curve bijection

Let D_(g,u) be the smooth projective normalization of the first
equation in (RL2). For every Q-point of D_(g,u) whose finite base
coordinate t is greater than one, there exists exactly one Q-point
of C_(g,u) above it.

Proof. Such a point gives an actual seed with first square and
F=Q^g by the same CI inverse just used. GE gives

    ab+iUc=uG*wG^g.

As g is odd, raising to g permutes mu4, so absorb uG into wG.
Then Z=wG/bar(wG) lies in K_G with norm one and is a g-th root of
the actual ratio. The positive rational scale from t to (a,b)
cancels from G/bar(G). RL1 gives a rational input v, yielding the
required point of (RL2), and the chart is smooth and nonbranch.
If two such v existed, their norm-one ratios would have quotient
a g-th root of unity in Q(i). By RL1 and oddness this quotient is
one and the v's are identical. The normalization has a unique point
over this smooth chart. This proves existence and uniqueness.

If gcd(g,6)=1, the positive rational points of the single curve
C_(g,1), with t>1, are in bijection with the ordered positive primitive
seeds satisfying (RL5). The norm Q and positive U are uniquely
determined by the seed.

Proof. The forward inverse is RL3. Conversely, for such a seed take
t=(a+U)/b>1, as in BK. The actual second Eisenstein decomposition
ab+U^2 zeta=uE*wE^g has uE in mu6. Since gcd(g,6)=1, absorb its unit
into wE. Likewise absorb the Gaussian unit since g is odd. The two
norm-one ratios then give rational s,v and a Q-point of C_(g,1).
The parameter t is the unique root greater than one of
t^2-2(a/b)t-a/b-1=0; the other root is negative. For fixed t, the
Eisenstein g-th root in the rational norm-one group is unique by
gcd(g,6)=1, and the Gaussian root is unique by oddness. This proves
injectivity as well as surjectivity.

For odd g divisible by 3 one retains the three unit choices in
C_(g,u), and does not claim this single-curve uniqueness. Every
actual seed still lifts to one of these curves, and the Gaussian
lift over each positive rational Eisenstein point remains unique.

## What has and has not been reduced

The explicit rationality and norm-one tests (RL4), or the equivalent
four Galois equations (RL6), close the inverse gap for the specified
positive chart of BK. No integrality assumption on its input root
coordinates is needed. For gcd(g,6)=1 this gives one completely
explicit Q-curve and a bijective actual-seed point domain at each
exponent. Here a curve over Q means a curve defined over Q, not an
elliptic Q-curve in the modularity terminology. Its degree and genus
grow quadratically in g.

The Gaussian cover does not remove positive rational Eisenstein
points: it lifts every one of them uniquely. It may still help a
rational-point computation on a higher cover. That use requires an
actual computation or a new theorem, not a conclusion from genus or
from the additional equation alone. No uniform point-height bound,
emptiness at odd exponent, or ABC theorem is obtained here. The
ramified first norm and nonunit residual branches remain active.

For a specified first exponent h>2 even, additionally require the
reconstructed integer U to equal R^(h/2) with R>1. The first-square
inverse does not silently preserve every larger even exponent.
