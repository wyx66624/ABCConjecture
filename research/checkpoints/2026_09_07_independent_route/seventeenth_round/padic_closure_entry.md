# QL1--QL4. Exact five-adic closure and a rational divisor lattice for H1

Status: complete ordinary proof, independently reviewed in full by
critical_bottleneck and adversarial_audit, including primary-source checks
and independent exact replay. Root final review is recorded separately.
New seventeenth-round work; the published sources through round fifteen
and the sixteenth-round research files are unchanged. This proves a local
closure and saturation statement, not a global generator or rational-point
classification theorem. There is no new Lean claim.

Use the previously proved curves and points

    E: y^2=x^3-9x-9,          P=(-2,1),
    E': y^2=x^3-189x+999,     P'=(6,9),
    H: y^2=s^6+3s^5-3s^4-11s^3-3s^2+3s+1.

Write J=Jac(H), and let pi1:H->E, pi2:H->E' be EQ's degree-two
maps. Their norm and pullback maps are

    Phi=(pi1_*,pi2_*):J->E x E',
    Psi=pi1^*+pi2^*:E x E'->J.

The reviewed EQ theorem gives Psi Phi=[2]. Both maps are isogenies,
so also Phi Psi=[2]: compose the first identity with Phi and use the
surjectivity of Phi over the algebraic closure. All identities are over Q.
GD proves rank E(Q)=rank E'(Q)=1, rank J(Q)=2, and E(Q)[3]=0.

## QL1. An elementary formal-log criterion and two exact certificates

Both displayed Weierstrass curves have good ordinary reduction at 5.
The closures of the two cyclic rational groups are

    closure(<P>)=E(Q5),     closure(<P'>)=E'(Q5).        (QL1)

Here and below closure is in the five-adic topology. To prove this we
first record the precise formal-group input. For an integral smooth
Weierstrass model at an odd prime p, put t=-x/y on the kernel E1(Qp)
of reduction. For p=5 its formal logarithm gives a topological group
isomorphism E1(Q5)->5 Z5, with

    log_E(Q)=t(Q) mod 25,  if t(Q) belongs to 5 Z5.     (QL2)

For completeness this follows directly from the integral formal group
and its invariant differential. In parameter t the latter is
(1+sum_{m>=1} b_m t^m)dt, b_m in Z5. Termwise integration is
L(t)=t+sum b_m t^(m+1)/(m+1). For n>=2,
n-v5(n)>=2, so L(t)-t belongs to 25 Z5 on 5 Z5. For t,u in 5 Z5,
the difference of the degree-n term has valuation at least
v5(t-u)+(n-1)-v5(n)>=v5(t-u)+1. Thus L(t)-t is a strict contraction
relative to t, proving that L is a bijective isometry of 5 Z5 by
successive approximation. Invariance of the differential implies
L(F(t,u))=L(t)+L(u), by differentiating and checking the value at zero.
This proves (QL2), including the group and topology assertions.
The identification of E1 with the integral formal group is the standard
Weierstrass construction in Milne II.2.7 and II.4.4.

The discriminants are 11664 and 944784, both 5-adic units. Direct
enumeration gives nine points on each reduced elliptic curve. The
reductions of P and P' have order nine: their multiples from 0 to 8
are all distinct. The exact multiples are

    9P = (-1625193766960369990795405419794 /
                   1135192428045421857524125001025,
           1179179153363180072193201096933126009785708521 /
                   1209495420803976369128841727712564695256198625),

    9P' = (31544182486/4119714225,
                  -229868810028359/264423857531625).

In both rows v5(x)=-2 and v5(y)=-3. In particular the points are in
E1, respectively E1', and

    (-x(9P)/y(9P))/5 = 1 mod 5,
    (-x(9P')/y(9P'))/5 = 3 mod 5.                     (QL3)

These equalities are exact rational arithmetic, not floating-point
recognition. The script replay_padic_entry.py recomputes them using
only integer arithmetic and Fraction, together with the complete mod-5
point tables and successive additions. Its output is separate from the
ordinary formal-group proof.

By QL2, each logarithm in (QL3) is 5 times a unit. The integer multiples
of such an element are dense in 5 Z5, so <9P> and <9P'> are dense in
the respective kernels of reduction. The images of <P>,<P'> already
fill the respective groups modulo 5; the union of the nine cosets
therefore proves QL1. The Frobenius trace is 6-9=-3, not divisible by
5; thus the good reduction is ordinary, as asserted.

## QL2. Torsion, finite index, and genuine five-saturation

Both E(Q) and E'(Q) are torsion-free. The two cyclic subgroups generated
by P and P' have finite index, and those indices are prime to 5.

Indeed E1(Q5) is torsion-free by QL2. Every finite-order point of E(Q5)
therefore injects into the order-nine reduction group, so its order
divides nine. GD proved E(Q)[3]=0, which excludes all rational torsion.
The rational group isomorphism psi:E'(Q)->E(Q) in GD gives the same
conclusion for E'. The rank-one Mordell--Weil result gives finite index.

Neither P nor P' is divisible by 5 even in the corresponding local
group. If P=5R, then 0=red(9P)=5 red(9R) in a group of order nine;
thus 9R is in E1. Its formal logarithm would give
log_E(9P)=5 log_E(9R) in 25 Z5, contrary to QL3. The other curve is
identical. In a torsion-free rank-one rational group, divisibility of
the cyclic index by 5 would make its displayed generator divisible by
5. Hence both indices are prime to 5.

This does not determine the indices at every other prime. In particular
no assertion E(Q)=ZP or E'(Q)=ZP' is being inferred from local density.

## QL3. Two explicit rational divisor classes generate the entire local J

Let infinity+ and infinity- be the two rational points on H characterized
by y/s^3=+1 and -1. Put A=(0,1), and define

    D1=[A-infinity+],    D2=[infinity--infinity+] in J(Q).

Then

    Phi(D1)=(0,2P'),        Phi(D2)=(-2P,2P'),          (QL4)
    closure(ZD1+ZD2)=J(Q5).                           (QL5)

The group J(Q) is torsion-free, and ZD1+ZD2 has finite index in J(Q)
prime to 5. In particular the five-adic closure required by
Balakrishnan--Dogra Theorem 1.2 has index one for this H.

To verify (QL4), the exact EQ formulas give

    pi1(A)=P, pi1(infinity+)=P, pi1(infinity-)=-P;
    pi2(A)=P', pi2(infinity+)=-P', pi2(infinity-)=P'.

All six images are values of the projective morphisms; the limits at
infinity agree with their explicit leading terms. In the bases P,P',
the two columns in (QL4) form the matrix [[0,-2],[2,2]], determinant 4.

H has good reduction at 5 by QH's direct smoothness argument. Its
Jacobian has good reduction, and #J(F5)=81. This last equality follows
from the Q-isogeny J~E x E' and the good-reduction Frobenius polynomial,
or independently from the complete counts #H(F5)=12, #H(F25)=28 in
the finite certificate: trace=-6, middle coefficient 19, and
1+6+19+30+25=81. Consequently multiplication by 2 is a bijection on
J(Q5): it is bijective on its formal kernel (its linear coefficient
is a unit) and on the finite reduction group of odd order. There is
also no rational or local 2-torsion on J.

The relations Psi Phi=Phi Psi=[2] now show that Phi:J(Q5)->E(Q5)xE'(Q5)
is an isomorphism of topological groups. It is injective because its
kernel is killed by 2, and surjective because its image contains the
image of [2] on E(Q5)xE'(Q5); multiplication by 2 is bijective there
by the same formal-kernel and order-nine argument. The inverse is
continuous since the groups are compact and Hausdorff.

More precisely, Phi(D1)=(0,2P') and Phi(D2-D1)=(-2P,0).
Thus the generated image is exactly 2 ZP x 2 ZP'. Each factor is
dense by QL1 and the invertibility of doubling on that factor. This
proves QL5 without applying a cross-coordinate matrix to different
elliptic groups. Formula QL4 also proves that D1,D2 are independent. Their
subgroup has finite index since rank J(Q)=2.

For torsion, Phi sends rational torsion into E(Q)tors x E'(Q)tors=0,
and its kernel is killed by 2, while J has no rational 2-torsion.
For five-saturation, if 5D=mD1+nD2 with D in J(Q), apply Phi. QL2
implies 5|n and 5|(m+n); hence 5|m as well. Subtract the corresponding
integer combination of D1,D2 from D. The result is killed by 5, thus
zero. This proves saturation and the prime-to-5 index assertion.

A concrete logarithm certificate is also available. Extend the elliptic
formal logarithms to all local points by log_E(Q)=log_E(9Q)/9, and
similarly for E'. Then QL3 gives log_E(P)/5=4 mod 5 and
log_E'(P')/5=2 mod 5. In the product differential coordinates the
columns for D1,D2, divided by 5, are

    [[0,2],[4,4]] mod 5,    determinant=2 mod 5.       (QL6)

Thus their actual logarithm determinant is nonzero and has valuation
exactly two in these coordinates. No conjectural regulator is used.

## QL4. The now available QC input and the remaining computational gate

The QH abstract finite-container theorem has now received both peer
reviews. For H, the additional hypotheses of Balakrishnan--Dogra
Theorem 1.2(ii) are established: rank=genus=2, rho_Q>=3, and the
rational-point closure in J(Q5) has finite index (indeed index one).
The model has a rational basepoint infinity+ and good ordinary reduction
at 5. Therefore the theorem's explicit height expression applies once
its correspondence and local-height data are specified. Its conclusion
is a finite set containing the quadratic Chabauty locus on the specified
open chart, with its excluded finite correspondence-support set handled
separately. It is not an already computed rational-point classification.

For either rank-one elliptic curve, a fixed quadratic p-adic height h
and nonzero elliptic logarithm satisfy

    h(Q) = alpha log(Q)^2 on E(Q),
    alpha=h(P)/log(P)^2,                              (QL7)

and likewise for E'. This ratio is independent of choosing a generator:
write P=mG,Q=nG in the torsion-free rank-one group and use quadraticity
and additivity. Thus calculating these two ratios requires infinite-order
points, not a proof that P and P' generate. This agrees with BD Corollary
8.1(ii) and Algorithm 8.3 steps 1--3. It does not remove the need for
appropriate saturation at primes used by a later Mordell--Weil sieve.

Available bounded next operations are now concrete: compute the two
elliptic logarithms and canonical heights at certified precision; fix
the exact normalization between PARI and the BD local heights; determine
the finite local-height value sets at bad primes; build analytic
expressions in all necessary five-adic residue charts; and certify all
zeros and their multiplicities before applying an appropriate rational
or Mordell--Weil sieve. The current s-model of H is monic. The EQ even
chart t=(s+1)/(s-1), however, is v^2=-9t^6+99t^4-27t^2+1; that chart
must not simply be substituted into a formula whose hypotheses specify
a monic even-sextic model without checking the coordinate normalization.
Neither small-prime saturation nor agreement of two precision runs
by itself certifies the complete genus-two rational-point set.

The full D_(3,zeta) also requires the second square root at the same
source and its positive real inequalities. Even complete fixed-g=3
classification would leave varying exponents, nonunit residuals,
integral lifting/content, and the uniform point-height gap from DC
untouched. No ABC conclusion is claimed.

## Primary inputs, replay, and proposed formal scope

Actually read for this note:

* Milne, Elliptic Curves, II.2.7 (formal group), II.4.1/4.2 and II.4.4
  (reduction filtration, prime-to-p multiplication and formal kernel):
  https://www.jmilne.org/math/Books/EC2.pdf . The logarithm argument
  needed here is supplied above, rather than assumed from a numerical API.
* Balakrishnan--Dogra, arXiv:1601.00388, Theorem 1.2, Corollary 8.1 and
  Algorithm 8.3: https://arxiv.org/pdf/1601.00388 . The requirement on the
  closure concerns the ground-field rational group, as verified here.
* Official PARI functions ellmul, ellorder, ellpadiclog, ellpadicheight,
  ellpadics2 and ellsaturation:
  https://pari.math.u-bordeaux.fr/dochtml/html-stable/Elliptic_curves.html .
  Saturation up to a supplied bound does not prove complete saturation.

The standard good-reduction Jacobian/Frobenius input is the same Milne
AV/JV input already source-checked in QS, not a new rank assertion.

The canonical exact certificate is verification/padic_entry_exact.json;
replay_padic_entry.py --check regenerates and compares all bytes.
SHA256: 2bc0673769cc10abba959725e1683676d162918afa7fbf89a463f664c9b24696.
It covers two elliptic finite tables, exact ninefold coordinates, the
valuation/unit tests, a full F25 hyperelliptic count, and integer matrix
arithmetic. It does not formalize any p-adic or Jacobian assertion.

Useful bounded future Lean statements are actual finite mod-5 point
classification and the ninefold addition certificates, the two rational
valuation tests, the six quotient images including infinity represented
homogeneously, and the actual integer determinant/saturation matrix.
These connect directly to QL1--QL3. The formal logarithm, topological
closure, Jacobian functoriality and QC theorem would remain separately
named ordinary inputs until independently formalized.
