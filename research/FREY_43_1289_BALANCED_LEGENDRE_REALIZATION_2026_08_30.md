# A balanced rational Legendre realization at ell=43 and p=1289

Author: ChatGPT. Research date: 2026-08-30.

Status: mathematical proof before formalization. This report verifies a
particular rational curve, its local level-1290 field, its mod-43 image,
its normalized Tate quantity, and explicitly defined local point and
whole-product families. It neither asserts all published initial theta
data nor gives an abc proof or counterexample. No frozen artifact is
changed.

## 1. The integer construction

Set

    ell=43,  p=1289=30*ell-1,
    A=p*(p^16+428),
    a=A^2,  b=A^2+1,  c=2*A^2+1.

The primes at most sqrt(1289)<36 are
2,3,5,7,11,13,17,19,23,29,31. The remainders of 1289 upon division
by these primes are respectively

    1,2,4,1,2,2,14,16,1,13,18.

Thus p is prime. The primes at most sqrt(43)<7 are 2,3,5, and the
remainders are 1,1,3, so ell is prime as well. The constructed integer is

    A=74868579806480944071725091585781549527211569580176021.

It is odd. Modulo 5, p=-1, p^16+428=-1, and hence A=1. The same
calculation holds modulo 43, since 428=-2 there. Further

    v_p(A)=1,

because (p^16+428) modulo p is the nonzero residue 428. Since
0<428<p^16, one has

    p^17<A<2*p^17.                                  (1.1)

The triple is positive and primitive: a+b=c,
gcd(a,b)=gcd(a,a+1)=1, and
gcd(b,c)=gcd(a+1,2a+1)=1, while gcd(a,c)=1 as well.

## 2. A rational isomorphism to the Legendre representative

Consider

    D: y^2=x(x-a)(x+b).

The change x=A^2*X, y=A^3*Y is defined over Q and gives

    Y^2=X(X-1)(X-lambda),  lambda=-1-A^(-2).         (2.1)

It is an isomorphism over Q, not a quadratic twist. Consequently the
Legendre representative has the same torsion fields and local reduction
type as D. The nonunit nature of this coordinate change at p is not a
problem: the integral model used for reduction is the original D.

The visible roots 0,a,-b give full rational 2-torsion. Put

    S=a^2+a*b+b^2=3*A^4+3*A^2+1.

The standard Weierstrass calculation gives

    Delta=16*(abc)^2,  c4=16*S,
    j(D)=256*S^3/(abc)^2.                            (2.2)

Pairwise coprimality implies gcd(S,abc)=1: reducing S modulo a,b,c
gives b^2,a^2,a^2 respectively. At every odd prime dividing abc,
c4 is therefore a unit and the displayed model is minimal and
multiplicative.

In fact all those odd multiplicative places are split already over Q.
If an odd prime divides a, then a=0,b=1 in its residue field and the
nodal reduction is y^2=x^2(x+1). If it divides b, then b=0,a=-1,
giving the same equation. The tangents at the node are y=+x and y=-x.
If it divides c, then b=-a and the node is at x=a. Writing X=x-a
gives y^2=X^2(a+X), whose tangent slopes are +A and -A; these are
distinct units at that prime. This proves the splitness claim without
an additional quadratic extension.

At p, v_p(a)=2 and v_p(b)=v_p(c)=0, so v_p(Delta)=4 and c4 is a
unit. In particular D is a split Tate curve over Q_p with parameter
q satisfying

    v_p(q)=4.                                       (2.3)

This last step uses the classical split Tate uniformization theorem
and j(q)=q^(-1)+744+..., as recorded in
[Kedlaya, Introduction: the Tate curve, Theorems 1--2, PDF pp.3--4](https://kskedlaya.org/18.727/tate-curve.pdf).
It is an external mathematical theorem, not a new Lean axiom.

## 3. The exact local torsion field and its correct uniformizer

Full rational 2-torsion and the Galois-equivariant Tate quotient
Q_p^alg* / q^Z imply that a chosen b0=sqrt(q) is in Q_p. Indeed,
its Tate class is rational, so sigma(b0)/b0 is a power of q for every
Galois element. The ratio has valuation zero, whereas v_p(q^n)=4n;
the power is therefore zero. Thus

    b0 in Q_p,  b0^2=q,  v_p(b0)=2.                 (3.1)

More generally the same argument on the two torsion generators gives
the exact equality

    Q_p(D[N])=Q_p(mu_N,q^(1/N))                     (3.2)

for every positive N. An automorphism fixing the two Tate classes has
ratios in q^Z, and their valuations force each ratio to be 1. This
proves equality of Galois kernels, rather than only a field inclusion.

Set N=30*43=1290 and

    K0=Q_p(mu_1290),  pi^645=b0,  E=K0(pi).

Since p=-1 modulo 1290, its multiplicative order modulo 1290 is two.
Thus K0/Q_p is unramified quadratic. The element pi has valuation
2/645 and is **not** a uniformizer. The correct uniformizer is

    beta=pi^323/p.

Write eta=p^2/b0, a unit in Q_p. Direct calculation gives

    beta^645=p*(b0/p^2)^323=p*eta^(-323),
    pi=eta*beta^2.                                  (3.3)

The first equation is Eisenstein over K0. The second proves
K0(beta)=K0(pi). Therefore

    [E:Q_p]=1290,  e(E/Q_p)=645,  f(E/Q_p)=2,
    v_p(beta)=1/645.                                (3.4)

K0 contains the 645th roots of unity, so E is Galois. Also pi^1290=q,
and (3.2) identifies E with Q_p(D[1290]). Here p=1 modulo 4, so i is
already in Q_p; adjoining it does not enlarge E.

For the global fields

    L=Q(i,D[30]),  L'=Q(i,D[1290]),

the chosen completion of L' at p is precisely E. Define

    r=pi^15=q^(1/86)=eta^15*beta^30.

Then

    r^43=b0,  v_p(r)=2/43.                          (3.5)

The unit eta is retained throughout. Neither q=p^4 nor b0=p^2 is
assumed.

## 4. The mod-43 image over Q and over L

Since A=1 modulo 5, the reduced equation is y^2=x(x-1)(x+2).
The complete point count is

| x in F5 | y-coordinates |
|---:|:---|
| 0 | 0 |
| 1 | 0 |
| 2 | none |
| 3 | 0 |
| 4 | none |

There are four points including infinity, so a_5=2. The
good-reduction Frobenius characteristic-polynomial theorem gives an
element of the mod-43 image with polynomial

    X^2-2X+5.

Its discriminant is -16, a nonsquare modulo 43: 16 is a nonzero
square and -1 is a nonsquare since 43=3 modulo 4. Thus this element g
preserves no F43-line.

At p the Tate parameter has valuation 4, prime to 43. Over the
unramified extension adjoining mu_43, adjoining q^(1/43) gives a
totally ramified extension of degree 43. Its inertia therefore
supplies a nontrivial transvection T of order 43 in the mod-43
image. This is the direct Tate calculation of
[Kedlaya, Proposition 3, PDF p.5](https://kskedlaya.org/18.727/tate-curve.pdf).

If F is the fixed line of T, then gF differs from F. In the basis
of these two lines, T and gTg^(-1) are respectively upper and lower
nonzero unipotents. Their powers give every upper and lower elementary
unipotent over the prime field F43. Gaussian elimination then gives

    image(G_Q on D[43]) contains SL2(F43).           (4.1)

The field L/Q is Galois and its degree divides

    2*|GL2(Z/30)|=2*6*48*480=276480,

which is prime to 43. The image H over L is normal in the image G
over Q and [G:H] divides [L:Q]. Hence T belongs to H, and normality
puts gTg^(-1) in H. The same elementary argument proves

    image(G_L on D[43]) contains SL2(F43).           (4.2)

No classification of subgroups and no ineffective large-image
threshold is used. The Frobenius theorem and Tate uniformization
remain stated classical inputs. Finally (a,b,c)=(1,2,3) modulo 43,
so D has good reduction at 43, preserved under any field extension.

## 5. The normalized Tate quantity and the ell=43 window

Because A is odd, A^2=1 modulo 8. Thus v_2(b)=1 and v_2(a)=v_2(c)=0.
Also S is odd, so v_2(j)=8-2=6. At every odd prime l dividing abc,

    -v_l(j)=2*v_l(abc).

Every such reduction is already split, by section 2. The normalized,
base-change invariant Tate quantity is therefore

    Q=2log[ A^2*(A^2+1)*(2*A^2+1)/2 ].              (5.1)

One may compute this on any semistable splitting extension. For the
specific L, only the place 2 needs an additional semistability input:
adjoining full 3-torsion makes reduction there semistable, and the
nonnegative j-valuation then makes it good. This uses the classical
prime-to-residue-characteristic semistability theorem. All odd bad
primes were already split multiplicative, including 3. The factor
1/[L:Q] cancels the sum of e_w*f_w over each rational prime.

The exponential series gives 2<e<3 and e>8/3. Hence

    e^6<3^6=729<1289,
    e^8>(8/3)^8>1289,

so 6<log p<8. The second integer comparison can be checked as
8^8=16777216>1289*3^8=8457129.

For A>1,

    A^6 < A^2*(A^2+1)*(2*A^2+1)/2 < 3*A^6.

Together with (1.1), log2<1, and log3<2, this gives

    Q>12log A>12*17*6=1224,
    Q<2log3+12(log2+17log p)<4+12*(1+136)=1648.

Consequently

    1224<Q<1648<43^2=1849.                          (5.2)

The curve and its moduli point are defined over Q. Thus delta in
Joshi IV v2, Theorem 5.7.1, is 2^12*3^3*5=552960. The upper endpoint
of the printed numerical window is also satisfied:

    sqrt(Q)<43<10*delta*sqrt(Q)*log(2*delta*log Q).

For the second inequality, it already suffices that Q>25, delta>=1,
sqrt(Q)>5 and log(2*delta*log Q)>1. The latter follows from
log Q>2 and e<3<4. These are numerical inequalities only, not an
exceptional-set check.

## 6. Every nonzero Tate order is prime to 43, without large factorization

First obtain a uniform elementary bound. Since p<2^11, (1.1) gives
A<2^188 and a<2^376. Integrality then gives b<=2^376 and
c<=2^377-1. Thus

    0<a,b,c<2^377.                                  (6.1)

For every prime l>=512,

    l^43>=512^43=2^387>2^377,

so each nonzero valuation of an endpoint at l is less than 43.

For the remaining finite range, let P be the product of all primes
at most 511. There are exactly 97, namely

    2,3,5,7,11,13,17,19,23,29,31,37,41,43,47,53,59,61,67,71,
    73,79,83,89,97,101,103,107,109,113,127,131,137,139,149,151,
    157,163,167,173,179,181,191,193,197,199,211,223,227,229,233,
    239,241,251,257,263,269,271,277,281,283,293,307,311,313,317,
    331,337,347,349,353,359,367,373,379,383,389,397,401,409,419,
    421,431,433,439,443,449,457,461,463,467,479,487,491,499,
    503,509.

Exact integer arithmetic gives

    gcd(a,P)=3,  gcd(b,P)=2,  gcd(c,P)=17.            (6.2)

The nonzero valuations and their terminal nonzero residues are

| prime l | v_l(a) | v_l(b) | v_l(c) | residues of a/l^v, b/l^v, c/l^v modulo l |
|---:|---:|---:|---:|:---|
| 2 | 0 | 1 | 0 | 1,1,1 |
| 3 | 2 | 0 | 0 | 1,1,1 |
| 17 | 0 | 0 | 1 | 8,9,12 |

All other primes in the displayed list have zero valuation in all
three endpoints. Equations (6.2) are accompanied by exact Bezout
certificates u*a+v*P=3, u*b+v*P=2, and u*c+v*P=17, respectively,
in `GEOMETRY_43_1289_ARITHMETIC_CERTIFICATE_2026_08_30.json`.
Each certificate also records the endpoints, P, and the terminal
residues; its integers are stored as decimal strings without loss
of precision. The generating and checking code is
`../tmp/frey_43_1289_arithmetic_checks.py`. It enumerates primes only
up to 511 by trial division and uses Euclidean arithmetic; it does
not factor the large endpoints. The Bezout identities, divisibility
of their stated right sides, and the terminal residues constitute
finite exact arithmetic certificates, not a probabilistic test.

By pairwise coprimality, a prime divides at most one endpoint.
Sections (6.1)--(6.2) prove for every prime dividing abc that

    1<=v_l(abc)<43.                                 (6.3)

In particular 43 does not divide 2*v_l(abc). Since L/Q is Galois
of degree prime to 43, every ramification index e_w divides that
degree and is also prime to 43. The nonzero integral Tate orders
on L are exactly

    ord_w(q_w)=2*e_w*v_l(abc),  l odd.

Every one is therefore prime to 43. The place 2 contributes no
Tate order, and reduction at 43 is good. This proves all of these
order conditions simultaneously without knowing the large prime
factorization of A, b, or c.

## 7. The integral Galois-action framework for this actual E

Here and below the valuation is v_p(p)=1. The logarithmic lattice is

    I=p^(-1)*log(O_E^*)=beta^(-644)*O_E.             (7.1)

Indeed e=645<=p-2=1287, so log and exp are inverse on the maximal
ideal beta*O_E. The prime-to-p roots of unity do not affect the log
image. Multiplication by p^(-1) then gives (7.1), up to a unit,
using (3.3). The tame different is beta^644*O_E, so I is the
inverse different and Tr(I)=Z_p. Directly, Tr(I) is integral and
Tr(1/1290)=1, with 1/1290 in O_E. In particular Tr(O_E)=Z_p and
O_E is contained in beta*I.

We use the actual full-Galois integral image constructed from the
Jannsen--Wingberg presentation, the Hoshi--Nishio log generators,
and Kondo's even-degree trace-kernel and handle lifts. The precise
source versions, generator integrality proof, and verified free-word
lifts are recorded in

    IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md,
    IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md,
    IUT_THREE_LABEL_MINIMUM_LAYER_CROSS_REVIEW_2026_08_30.md.

Their parameter-dependent assumptions hold here: p>=5; E/Q_p is
Galois with even degree d=1290; e<=p-2; and E has no primitive p-th
root of unity. For the last assertion, adjoining such a root has
ramification index p-1=1288, which cannot divide 645. Thus the
tame cyclotomic character used in the integrality proof is nontrivial
modulo p. Abelianizing the Hoshi--Nishio word eliminates the extra
generator with coefficient

    1-g*(sum_(i=1)^(p-1) h^i)/(p-1)=1 modulo p,

where h is that nontrivial character. Consequently the normalized
wild generators are a Z_p-basis of I, not merely a Q_p-basis.

Write this basis as a_JW,b_JW and the 1288-dimensional symplectic
summand W. Kondo's even-degree trace-kernel result gives

    ker(Tr on I)=Z_p*a_JW plus W,
    Tr(b_JW) in Z_p^*.

The second assertion follows from the integral basis and Tr(I)=Z_p.
If B(z) is the b_JW-coordinate, then

    B(z)=Tr(z)/Tr(b_JW).                             (7.2)

The verified actual automorphisms include the symplectic matrices
with integer entries supplied by the handle construction, acting
on W and fixing a_JW,b_JW, and the cross and central maps

    N_w(a_JW)=a_JW,
    N_w(b_JW)=b_JW+w,
    N_w(x)=x+omega(w,x)*a_JW  (x in W),
    C_t(b_JW)=b_JW+t*a_JW,  C_t(a_JW)=a_JW, C_t(W)=W.

For every w with integer coordinates in the displayed basis, the
required cross map is obtained by products of basis cross maps
and a central correction with integer coefficient. These vectors
suffice to lift every residue vector used below. The identities

    N_w*N_v=C_(omega(w,v))*N_(w+v),
    N_w^n=N_(n*w)

hold in the canonical linear image (with integer n); no homomorphic section from
the linear group to automorphisms of the absolute Galois group is
asserted. The even-degree symplectic lifts use Kondo's construction
on PDF page 19 and Theorem 2.17 on page 20, before the subsequent
odd-degree restriction. This is the same verified mechanism as for
p=139, with rank 1288 instead of 208.

An automorphism of E over Q_p acts through an actual automorphism
of G_E=Gal(E^alg/E), after choosing an extension to E^alg. Inertia
in Gal(E/K0) may thus be composed with the preceding lifts. The
group used here consists of these actual automorphisms of G_E,
not arbitrary elements of GL_Zp(I), and not merely elements of
G_E acting trivially on E.

## 8. Forty-two normalized inputs and their traces

Let j range from 1 to 21, s=j^2, and define

    z_j=r^s,
    n_j=floor(2s/43),  k_j=n_j+1=ceil(2s/43),
    u=log(1+p)/p,
    tau_j=log(1+p*z_j)/p,
    T_j=tau_j/p^k_j,
    X_j=z_j*beta^(-644)/p^n_j.                      (8.1)

Since 43 does not divide s, k_j=floor(2s/43+644/645) as well.
The logarithm has its expected first-term valuation, so

    v_p(tau_j)=2s/43,
    645*v_p(T_j)=30s-645k_j,
    645*v_p(X_j)=30s-644-645n_j.                    (8.2)

Write 2s=43n_j+t_j with 1<=t_j<=42. Then the last two numerators
are 15t_j-645 and 15t_j-644. In particular both T_j and X_j
belong to beta*I but not to p*I. The rational element u is a unit,
belongs to beta*I, and has unit trace 1290*u.

Since r^43=b0 and gcd(s,43)=1, the norm over E/K0 gives

    Norm_(E/K0)(1+p*r^s)=(1+p^43*b0^s)^15.

Taking logs and then the degree-two trace gives

    Tr(T_j)=30*log(1+p^43*b0^s)/p^(k_j+1),
    v_p(Tr(T_j))=42+2s-k_j>=43.                    (8.3)

The factor 30 is a p-adic unit, and k_j<=s proves the displayed
lower bound. For X_j, use r=eta^15*beta^30. Its non-rational factor
is beta^(30s-644); this exponent is 1 modulo 15 and hence not
divisible by 645. Summing its conjugates over E/K0 therefore gives

    Tr(X_j)=0.                                     (8.4)

This geometric-sum argument also applies when the exponent is
negative. Thus all 42 inputs have B-coordinate zero modulo p,
while B(u) is a unit.

## 9. One actual Galois action puts all forty-two inputs at the minimum

Put V=I/pI and V_0=beta*I/pI. Then V has dimension 1290 over F_p
and V/V_0 has dimension two. The kernel of trace maps onto I/beta I:
for x in I, subtract Tr(x)/1290 in O_E, which lies in beta I.
This also proves the corresponding surjectivity after reduction.

Choose an inertia generator sigma with sigma(beta)=zeta_645*beta.
The intersections of the relevant roots of unity with F_p^* are
trivial because

    gcd(645,p-1)=gcd(645,1288)=1.

For T_j the first nonzero graded coefficient transforms by
zeta_645^(30s), which has order 43. Thus among h=0,...,644 at most
15 values can put sigma^h(T_j) on the fixed line F_p*a_JW in V:
equality of the lines forces equality of their leading projective
coefficients. There are at most 21*15=315 forbidden h in total
for these point inputs. This is an upper bound; the graded condition
is only necessary for equality of the full vectors.

For X_j the character exponent is

    30j^2-644=30j^2+1 modulo 645.

It is 1 modulo 15. Its gcd with 645 is therefore 1 or 43, and the
second possibility occurs precisely when j^2=10 modulo 43.
Within 1<=j<=21 this happens only at j=15: 15^2=10 modulo 43,
and the two roots in F43 are 15 and -15=28. The projective orbit
has length 15 for j=15 and length 645 for the other twenty labels.
These inputs therefore forbid at most 43+20=63 exponents h.

Altogether at most

    315+63=378<645                                  (9.1)

exponents are forbidden. Choose one common h avoiding them all.
After this one inertia action all 42 inputs are still in V_0 and
the trace kernel, are nonzero in V, and are off F_p*a_JW. Write
them as A_i*a_JW+w_i with w_i nonzero in W/pW. The element u is
unchanged by inertia and still has B(u) nonzero.

Here is the complete simultaneous parabolic step. Let lambda_0
denote the projection V to V/V_0.

If a_JW is not in V_0, select w in W/pW avoiding the 42 proper
hyperplanes omega(w,w_i)=0. There are at most 42*p^1287 excluded
vectors, fewer than p^1288. Lift w integrally and apply the actual
N_w. Each input now has nonzero projection

    omega(w,w_i)*lambda_0(a_JW).

If the transformed u already has nonzero projection, apply C_0;
otherwise apply C_1. This adds B(u)*lambda_0(a_JW), a nonzero
vector, and does not change any of the other 42 projections,
because their B-coordinates vanish modulo p.

If a_JW is in V_0, the restriction of lambda_0 to W/pW is onto
the two-dimensional quotient. Select w outside its kernel and
outside the same 42 symplectic hyperplanes. The excluded union
has at most

    p^1286+42*p^1287<p^1288

elements, since 1+42p<p^2 for p=1289. An integral lift defines
the symplectic transvection x maps to x+omega(w,x)*w on W,
fixing a_JW,b_JW. Its verified actual Galois lift puts all 42
inputs outside V_0: their initial W-projections vanish, and
their new projections are omega(w,w_i)*lambda_0(w), all nonzero.
If the resulting u is still in V_0, choose a basis direction w'
of W with lambda_0(w') nonzero and apply N_(w'). It moves u out
of V_0 by B(u)*lambda_0(w') while leaving every other projection
unchanged, because their B-coordinates are zero and a_JW is in
V_0. If u is already outside, no further action is needed.

In both cases, composing the chosen actual lifts gives one
canonical linear action M with

    v_p(Mu)=v_p(MT_j)=v_p(MX_j)=-644/645
    for all j=1,...,21.                             (9.2)

The inverse/unit convention for the integral Kummer arrow is
handled by taking the inverse actual Galois-group automorphism;
the remaining common Z_p-unit does not alter any valuation.
Thus (9.2) is an attained statement for the genuine integral
arrow family described in the cited construction. It is not a
claim that every integral linear automorphism is reachable.

## 10. Exact hulls for the two explicitly specified local families

For m=j+1, let B_m be the normalization of O_E tensor ... tensor O_E
over Z_p inside E tensor ... tensor E over Q_p. Since E/Q_p is
Galois,

    E^(tensor m) = product_(Gal(E/Q_p)^(m-1)) E,
    B_m = product_(Gal(E/Q_p)^(m-1)) O_E.

It is this maximal product order, not the generally smaller tensor
order, that acts on the hulls below. Every conjugate of an element
has the same valuation, so a pure tensor with factor valuations
v_1,...,v_m has valuation sum(v_i) in every product component.

The point family consists precisely of

    F(tau_j) tensor F(u) tensor ... tensor F(u)

as the same integral Kummer arrow F varies. Because tau_j belongs
to p^k_j*I and F preserves I and its p-power sublattices, every
component valuation is at least k_j-m*644/645. Equation (9.2)
attains equality in every component using a common F for all j.
Thus its B_m-span is the closed product fractional ideal

    H_j^point=beta^[645*k_j-644*(j+1)]*B_m.           (10.1)

The whole-product family is defined separately: its inputs range
over z_j*I in the first factor and I in every remaining factor,
with one and the same F in all factors. Since z_j*I is contained
in p^n_j*I, every resulting component valuation is at least
n_j-m*644/645. The particular first input z_j*beta^(-644)=p^n_j*X_j
and the remaining repeated inputs u attain that bound under the
same F of (9.2). Therefore

    H_j^whole=beta^[645*n_j-644*(j+1)]*B_m
             =p^(-1)*H_j^point.                    (10.2)

The unit in p=eta^323*beta^645 does not affect equality of these
B_m-ideals. One attaining tensor is a unit times the displayed
power of beta in every component, so it generates the entire
product ideal as a B_m-module. This proves both equality and
closedness, not just a valuation lower bound.

Here are the exact exponents, all attained by the same F:

| j | n_j | k_j | point exponent | whole exponent |
|---:|---:|---:|---:|---:|
| 1 | 0 | 1 | -643 | -1288 |
| 2 | 0 | 1 | -1287 | -1932 |
| 3 | 0 | 1 | -1931 | -2576 |
| 4 | 0 | 1 | -2575 | -3220 |
| 5 | 1 | 2 | -2574 | -3219 |
| 6 | 1 | 2 | -3218 | -3863 |
| 7 | 2 | 3 | -3217 | -3862 |
| 8 | 2 | 3 | -3861 | -4506 |
| 9 | 3 | 4 | -3860 | -4505 |
| 10 | 4 | 5 | -3859 | -4504 |
| 11 | 5 | 6 | -3858 | -4503 |
| 12 | 6 | 7 | -3857 | -4502 |
| 13 | 7 | 8 | -3856 | -4501 |
| 14 | 9 | 10 | -3210 | -3855 |
| 15 | 10 | 11 | -3209 | -3854 |
| 16 | 11 | 12 | -3208 | -3853 |
| 17 | 13 | 14 | -2562 | -3207 |
| 18 | 15 | 16 | -1916 | -2561 |
| 19 | 16 | 17 | -1915 | -2560 |
| 20 | 18 | 19 | -1269 | -1914 |
| 21 | 20 | 21 | -623 | -1268 |

Their negativity also has a uniform proof. For j<=21 one has
2j^2/43<j, so k_j<=j and

    645*k_j-644*(j+1)<=j-644<0.

This nonintegrality is relative to the expressly normalized I
and B_m. Ordinary logarithms in place of all m normalized log
entries multiply a point hull by p^m and change these exponents.
The intermediate pilot lattice z_j*B_m is not the same source
family as the whole product z_j*I times I^(m-1). No equality with
the upper endpoint in (10.2) is asserted for that intermediate
family or for an entire published inter-universal collation.

## 11. What has been verified, and what is not inferred

The verified arithmetic conditions include the primitive positive
triple; a rational isomorphism to the stated Legendre representative;
full rational 2-torsion; the prescribed fields L and L'; the exact
local field with (e,f,d)=(645,2,1290); its correct uniformizer beta;
the tame log/exp range; good reduction at 43; split multiplicative
reduction at p and indeed every odd bad place; the mod-43 SL2 image
over Q and L; the normalized numerical window; and every nonzero
Tate order being prime to 43. Equations (9.2)--(10.2) further give
the one-arrow local conclusions for the two specified families.

For the global source theorem, see
[Joshi IV v2, Definition 5.4.1, Theorem 5.7.1 and its proof, PDF
pp.51--57](https://arxiv.org/pdf/2403.10430v2).
No bounding domain Z, its full source conditions, or its exceptional
set has been silently chosen here. In particular the prime-number
threshold xi_prm in the printed small-Q construction is not specified.
The fact Q>1224 does not prove sqrt(Q)>xi_prm, and it does not prove
that this parameter lies outside the full constructed exceptional
set. The normalization conflict between Definition 5.4.1/Theorem
5.7.1 and the opening sum in section 5.8 is the one recorded in
`FREY_139_REALIZATION_ARITHMETIC_CROSS_REVIEW_2026_08_30.md`; this
report consistently uses the defined normalized Q.

The remaining global initial-data choices, exact published label and
source-family identification, ordinary versus normalized Bloch--Kato
dictionary, intermediate pilot action, and global comparison arrows
remain separate obligations. A sufficient existence theorem off an
exceptional set can be bypassed only by actually verifying its required
data, not by ignoring its hypothesis.

The full Tate uniformization, Frobenius theorem, full-Galois lifts,
and source comparison are mathematical inputs or paper proofs here,
not closed Lean results. The new exact finite certificate is neither
a substitute for those theorems nor an abc certificate. No new axiom
and no formalized full-Galois assertion has been introduced.

## 12. Reproduction and source versions

Run the small exact-arithmetic calculation from the repository root:

    C:\Users\Admin\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe -X utf8 tmp/frey_43_1289_arithmetic_checks.py

It regenerates only the new JSON certificate named in section 6.
The computation uses Python integers, trial division through 511,
Euclid's algorithm, and rational arithmetic. It performs no large
integer factorization, floating-point logarithm test, or full-library
build.

The unchanged original full-Galois inputs used through section 7 are:

- Jannsen--Wingberg (1982), the presentation on printed pp.74--76,
  [original PDF](https://epub.uni-regensburg.de/26689/1/jannsen17.pdf),
  archived at `sources/galois_lift_2026_08_30/Jannsen_Wingberg_1982_Inventiones.pdf`.
- Hoshi--Nishio, revised 2022 preprint, Proposition 1.1 and Lemma 1.3,
  [original revised PDF](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1931revised.pdf),
  archived at `sources/galois_lift_2026_08_30/Hoshi_Nishio_2022_revised.pdf`.
- Kondo, arXiv:2512.09231v2 (December 2025), even-degree trace-kernel
  statement and the even-degree construction preceding Theorem 2.17,
  [original version](https://arxiv.org/pdf/2512.09231v2),
  archived at `sources/galois_lift_2026_08_30/Kondo_2512.09231v2_Dec2025.pdf`.

The integral-basis argument and noncommutative cross lifts are proved
and independently audited in the prior new reports cited in section 7;
they are not attributed verbatim to a source that only states a
rational-basis or outer-action result.
