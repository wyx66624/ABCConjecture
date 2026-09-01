# A rational Frey curve realizing the tame 210-torsion local field

Author: ChatGPT. Research date: 2026-08-30.

Status: mathematical proof written before formalization; independent
arithmetic and root reviews completed, with the accepted component audit
in `../Lean/verification/2026_08_30_galois_lifts/VALIDATION.md`.
This is a concrete local/global realization and a mod-7 image
calculation, not a verification of every IUT initial-data condition and
not an abc proof or counterexample.

## 1. The actual curve and its local reduction

Take the positive primitive triple

    (a,b,c)=(139,279,418),  a+b=c,

and the rational Frey curve

    C: y^2=x(x-139)(x+279)=x^3+140x^2-38781x.

Pairwise coprimality follows from
`279=3^2*31`, `418=2*11*19` and the primality of 139.
Its three nonzero rational 2-torsion points have x-coordinates
`0,139,-279`; these are distinct. The Weierstrass quantities are

    Delta = 16*(139*279*418)^2,
    c4 = 16*(139^2+139*279+279^2)=16*135943,
    j(C)=256*135943^3/(139*279*418)^2.                 (1.1)

Here is the polynomial verification used before formalization. For
the general model with `a1=a3=a6=0`, `a2=b-a`, `a4=-ab`, one has
`b2=4(b-a)`, `b4=-2ab`, `b6=0`, `b8=-a^2 b^2`. Therefore
`Delta=16 a^2 b^2((b-a)^2+4ab)=16(ab(a+b))^2`, and
`c4=16(b-a)^2+48ab=16(a^2+ab+b^2)`. Its affine equation is
`y^2=x(x-a)(x+b)` by expansion. These identities hold over every
commutative ring; ellipticity over a field additionally requires
the displayed discriminant to be nonzero.

At p=139, c4 is a unit and the discriminant has valuation 2.
The displayed integral equation is therefore minimal: an integral
model with smaller discriminant obtained by a nonunit scale would
require c4 to have positive valuation. Its reduction is

    y^2=x^2(x+1)

with a node at `(0,0)` and distinct tangent lines `y=x`, `y=-x`.
Thus C has split multiplicative reduction, not just potential
multiplicative reduction, over `Q_139`.

Tate's parametrization gives a q in Q_139 with v(q)=2 and a
Galois-equivariant isomorphism

    C(Q_139^alg) = (Q_139^alg)^*/q^Z.                (1.2)

The external uniformization and splitness criterion are recorded in
[Kedlaya, Introduction: the Tate curve, Theorems 1–2, pp.3–4](https://kskedlaya.org/18.727/tate-curve.pdf),
which cites Silverman's *Advanced Topics*, V.3.1 and V.5.3.
The equality v(q)=2 also follows from `j(q)=q^-1+744+...`
and (1.1). The note does not pretend to formalize uniformization.

## 2. A square root in the base field and the exact torsion field

Every 2-torsion point of C is rational. Choose a square root b0 of q
in the algebraic closure. The Tate class of b0 is a 2-torsion point,
so for every sigma in G_(Q_139),

    sigma(b0)/b0 in q^Z.

The ratio has valuation zero, whereas q^n has valuation 2n.
Consequently n=0 and sigma(b0)=b0. This proves

    b0 in Q_139,  b0^2=q,  v(b0)=1.                (2.1)

No claim that b0=139, or that q=139^2, is made.

For any positive N, the N-torsion of the Tate quotient is generated
by the classes of mu_N and q^(1/N). This yields the **exact** field

    Q_139(C[N])=Q_139(mu_N,q^(1/N)).                (2.2)

Indeed fixing the two displayed generators fixes all torsion classes.
Conversely, an automorphism fixing those classes has ratios in q^Z;
their valuations are zero, so each ratio is one. Thus the respective
Galois kernels agree, proving equality of the finite fixed fields.
This argument does not infer a field equality merely from one
inclusion of torsion coordinates.

Set N=210, choose pi with pi^105=b0, and put

    K0=Q_139(mu_210),  E=K0(pi).

The multiplicative order of 139 modulo 210 is 2:
139 is not 1 modulo 210 and 139^2 is 1 modulo 210.
Hence K0 is the unramified quadratic extension. The polynomial
`X^105-b0` is Eisenstein over K0 by (2.1), and K0 contains mu_105.
It follows that E is the splitting field, with

    [E:Q_139]=210,  e(E/Q_139)=105,  f(E/Q_139)=2.   (2.3)

Because `139^2=1 mod 4`, the unramified quadratic field already
contains i. If

    L=Q(i,C[30]),  L'=Q(i,C[210]),

then every chosen completion of L' at a place over 139 identifies
with E, under the same local embedding. This follows from (2.2)
and `pi^210=q`, not from an assumption about a generic splitting
field. In particular `105<=139-2`, the tame log/exp range required
by the new minimum-layer proof really holds for this full torsion
extension.

## 3. The mod-7 image over Q contains SL_2(F_7)

At 139, a nontrivial order-7 transvection occurs in the action on
C[7]. Here is the direct Tate proof. After the unramified extension
adjoining mu_7, adjoining q^(1/7) is a totally ramified extension
of degree 7, because v(q)=2 is prime to 7. Its inertia generator
sends q^(1/7) to zeta_7*q^(1/7) and fixes zeta_7. In the corresponding
basis of C[7] its matrix is a nontrivial unipotent matrix T.
This is the situation of
[Kedlaya, Proposition 3, p.5](https://kskedlaya.org/18.727/tate-curve.pdf).

The curve has good reduction at 5: the discriminant in (1.1) is
not divisible by 5. Its equation reduces to `y^2=x^3-x`. The full
finite point count is

| x in F5 | y-coordinates |
| ---: | --- |
| 0 | 0 |
| 1 | 0 |
| 2 | 1,4 |
| 3 | 2,3 |
| 4 | 0 |

There are seven affine points and one point at infinity. Thus
`#C(F5)=8` and the Frobenius trace is `5+1-8=-2`.
The good-reduction Frobenius theorem gives an element g of the
mod-7 image whose characteristic polynomial is

    X^2+2X+5 in F7[X].                              (3.1)

Its discriminant is `5 mod 7`, a nonsquare. Equivalently, its
values at 0,1,2,3,4,5,6 are respectively 5,1,6,6,1,5,4.
Thus g preserves no F7-line.

Write D for the fixed line of T. Then gD is a distinct line, and
`g T g^-1` is a nontrivial transvection fixing gD. Choose a basis
whose first vector spans D and whose second spans gD. The two
transvections have the shapes

    [[1,A],[0,1]],  [[1,0],[B,1]],  A B != 0.

Their integer powers give all upper and lower elementary unipotent
matrices over F7, because the additive group of a prime field is
cyclic. Gaussian elimination shows that these elementary matrices
generate SL_2(F7). Therefore

    image(G_Q -> GL(C[7])) contains SL_2(F7).        (3.2)

This avoids an appeal to an unverified classification of subgroups
of GL_2(F7). The external step here is the good-reduction Frobenius
characteristic-polynomial theorem; the table and the group argument
are explicit.

## 4. The SL_2 image survives over L=Q(i,C[30])

The extension L/Q is Galois, and its degree divides

    2 * |GL_2(Z/30)|
      =2*|GL_2(F2)|*|GL_2(F3)|*|GL_2(F5)|
      =2*6*48*480=276480.

This degree is prime to 7. Let G be the mod-7 image over Q and H
the image over L. Then H is normal in G and `[G:H]` divides
`[L:Q]`. The element T of order 7 has trivial image in G/H,
so T lies in H. Normality gives `g T g^-1 in H`, for the g in
section 3. The same elementary-matrix argument therefore proves

    image(G_L -> GL(C[7])) contains SL_2(F7).        (4.1)

This proves the particular representation condition directly.
It does not identify H with the whole GL_2(F7) and does not rely
on a general open-image assertion without an effective exception
check.

## 5. The normalized Tate quantity satisfies the numerical window

The numerator `135943` is coprime to `139*279*418`. At every odd
prime dividing that product the negative j-valuation is twice
the exponent of the prime in it. At 2 the j-valuation is 6,
which is nonnegative. Consequently the base-change invariant
Tate quantity, computed on a semistable splitting extension, is

    Q = sum_p max(0,-v_p(j(C))) log p
      =2 log(139*279*209)
      =2 log(8105229).                              (5.1)

For completeness, the interpretation via any semistable splitting
extension follows from v(q_w)=-v(j) at its multiplicative places
and zero Tate contribution at good places. The equality
`sum_(w|p) e_w f_w=[L:Q]` cancels the base-change normalization.
The usual level-3/level-5 semistability theorem can be used for L;
the identity itself is independent of which semistable splitting
extension is chosen. The reference definition is
[Joshi IV v2, Definition 5.4.1, PDF p.51](https://arxiv.org/pdf/2403.10430v2).

Here are exact rational/integer certificates for the bounds:

    3^25 = 847288609443
         < 8105229^2 = 65694737142441
         < 2^49 = 562949953421312.

Together with `2<exp(1)<3`, monotonicity gives

    25 < Q < 49.                                   (5.2)

In particular `sqrt(Q)<7`. For the rational field of moduli,
the delta in IV 5.7.1 is `2^12*3^3*5=552960`. Already delta>=1,
sqrt(Q)>5 and `log(2*delta*log Q)>1` make

    7 < 10*delta*sqrt(Q)*log(2*delta*log Q).

Thus ell=7 meets both **numerical** endpoints of that printed
window. This does not prove that this curve avoids the theorem's
finite exceptional set or satisfies all other initial-data
hypotheses. Such conclusions require separate checks.

## 6. Consequence for the actual local minimum-layer calculation

Put p=139, choose b0 and pi as in (2.1)–(2.3), and let

    r=pi^15=q^(1/14),  I=p^-1 log(O_E^*)=pi^-104 O_E,
    u=log(1+p)/p,
    tau_s=log(1+p*r^s)/p,  k_s=floor(s/7+104/105),
    t_s=tau_s/p^k_s.

For s=1,4,9, the integral contents k_s are 1,1,2.
The trace identity has its actual coefficient b0:

    Tr_E/Qp(t_s)=30*log(1+p^7*b0^s)/p^(k_s+1).

Its valuations are 6,9,13. Every field, trace and leading-layer
calculation in `IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md`
therefore applies with pi^105=b0; none requires b0=p.
That report's common full-Galois action reaches the minimum
layer for u and all three t_s simultaneously. The inverse/source
Kummer convention changes it only by a unit factor.

For the precisely defined same-carrier powered-root point family
with s=j^2 and m=j+1, its native normalized B-hulls are

    H_1=pi^-103 B_2,
    H_2=pi^-207 B_3,
    H_3=pi^-206 B_4.                                (6.1)

Equation (6.1) has the same family and normalization restrictions
as the cited local report. In particular, a literal family with
one unpowered root at every untilt is not silently replaced by
this powered-root family, and a fractional-ideal pilot is not
identified with a point.

## 7. Source and formalization boundaries

The Frey model here is a quadratic twist by 139 of the Legendre
model with parameter `-279/139`. This twist preserves j and Q,
but at p=139 it is not legitimate to infer the same splitness
or ramification index for the untwisted Legendre representative.
IV 5.7.1 is stated using its Legendre representative. The present
proof does not instantiate that existence theorem wholesale.

What is proved is the actual rational curve, exact local
210-torsion field, a concrete large mod-7 image over the specified
level field, and the numerical Tate window. All remaining global
initial theta data, inter-universal identifications, the pilot
versus ideal action and the cross-Frobenius comparison must still
be verified in the original definitions.

The Bloch–Kato normalization issue is audited separately: the
normalized coefficient `log(1+p*r^s)/p` differs by a factor p
from the ordinary Bloch–Kato inverse of the Kummer class. Replacing
every entry by its ordinary logarithm multiplies an m-fold point
hull by p^m; it cannot preserve (6.1) with the same fixed B-normalized
Haar measure. This is a dictionary issue, not an abc counterexample.

The mathematical proof above precedes its Lean components. The
complete Tate uniformization, Galois representation, Frobenius
theorem, local class field theory and local minimum-layer argument
are not yet closed Lean theorems. Numerical and polynomial
certificates do not replace these external inputs.

The original Kedlaya PDF is archived, unchanged, as
`research/sources/galois_lift_2026_08_30/Kedlaya_2004_Tate_Curve.pdf`:
108729 bytes, six pages, SHA-256
`92a836142364d520c947884b24dead6253901e842f10000ec883298662d752dd`.
The earlier Joshi source copy is unchanged. No source version,
core target, prior verified module or frozen manuscript was edited.

## 8. A direct Legendre realization and its precise remaining boundary

This section was added by the independent arithmetic reviewer. Its
separate review is
`FREY_139_REALIZATION_ARITHMETIC_CROSS_REVIEW_2026_08_30.md`.
Sections 1--7 were not edited by that reviewer.

### 8.1 The curve has no Legendre twist gate

Take the positive primitive triple

    (a,b,c)=(1,2362,2363),
    2362=2*1181,  2363=17*139,

and the curve

    D: y^2=x(x-1)(x+2362).

Here 1181 is prime (trial division by primes at most 31 suffices).
The two consecutive nontrivial entries are coprime. This equation is
already the Legendre equation over Q, with lambda=-2362; no quadratic
twist or change of ground field is needed. Its invariants are

    M=2362*2363=5581406,
    Delta(D)=16*M^2,
    c4(D)=16*(M+1)=16*5581407,
    j(D)=256*(M+1)^3/M^2.                            (8.1)

Thus gcd(M,M+1)=1. Modulo 139 the equation is y^2=x(x-1)^2.
Writing X=x-1 gives y^2=X^2(1+X), with distinct tangent lines
y=+X and y=-X. The c4 valuation is zero and the discriminant
valuation is 2. The displayed Legendre representative itself has
split multiplicative reduction at 139, with v_139(q_D)=2.

All three nonzero 2-torsion points are rational. The exact argument
of section 2 gives b0=sqrt(q_D) in Q_139 with valuation 1 and

    Q_139(D[210])=Q_139(mu_210,pi),  pi^105=b0,
    (d,e,f)=(210,105,2).                             (8.2)

The unramified quadratic factor contains i. Consequently for

    L_D=Q(i,D[30]),  L'_D=Q(i,D[210]),

the chosen completion of L'_D at 139 is precisely (8.2).
The rational unit b0/139 is retained; q_D=139^2 is not assumed.

### 8.2 The mod-7 image is verified over Q and L_D

At 5 the reduced equation is y^2=x(x-1)(x+2), and the finite
point table is

| x in F5 | y-coordinates |
| ---: | --- |
| 0 | 0 |
| 1 | 0 |
| 2 | none |
| 3 | 0 |
| 4 | none |

Including the point at infinity gives #D(F5)=4 and a_5=2.
Frobenius therefore has characteristic polynomial

    X^2-2X+5 in F7[X],

with nonsquare discriminant 5. The Tate inertia at 139 supplies
an order-7 transvection. The two-line elementary-matrix proof in
section 3, with this Frobenius, proves that the image over Q
contains SL2(F7).

Since [L_D:Q] divides 276480 and is prime to 7, the normal-subgroup
argument in section 4 proves the same containment over L_D. Also
(a,b,c)=(1,3,4) modulo 7, so D has good reduction at 7. Good
reduction persists under extension.

### 8.3 Exact Tate quantity and numerical ell=7 window

The negative finite j-valuations are -2 at 17,139,1181. At 2 the
j-valuation is 6; every other finite valuation is nonnegative.
The normalized, base-change invariant Tate quantity is therefore

    Q_D=2log(1181*2363)=2log(2790703).                (8.3)

As in section 5, interpreting this as the Tate sum on L_D uses
the standard semistability theorem at residue characteristic 2
after adjoining full level-3 torsion. The odd bad primes are
already multiplicative, and 3 is a good prime for D. The
negative-j-valuation formula itself may be computed on any
semistable splitting extension.

Exact integer certificates are

    3^25 = 847288609443
         < 2790703^2 = 7788023234209
         < 2^49 = 562949953421312.

Since 2<e<3, they imply 25<Q_D<49. Here L_mod=Q and
delta=2^12*3^3*5=552960. Thus ell=7 satisfies

    sqrt(Q_D)<7<10*delta*sqrt(Q_D)*log(2*delta*log(Q_D)).

The nonzero Tate orders at odd multiplicative places over L_D
are 2e_w, where e_w divides its prime-to-7 degree, so they are
not divisible by 7. This is an additional directly checked
arithmetic condition, not a substitute for the full definitions.

### 8.4 The same local minimum-layer parameters apply

Use the pi and b0 in (8.2) and put p=139. Then

    r=pi^15=q_D^(1/14),  I=pi^-104 O_(E_D),
    u=log(1+p)/p,
    tau_s=log(1+p*r^s)/p,
    k_s=floor(s/7+104/105),  t_s=tau_s/p^k_s.

For s=1,4,9, the k_s are 1,1,2 and

    Tr(t_s)=30log(1+p^7*b0^s)/p^(k_s+1)

has valuation 6,9,13 respectively. Section 11 of
`IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md` establishes
that its same-action and minimum-layer proof works for this
actual b0. Thus the precise local, same-carrier normalized point
families have the hulls (6.1). The source and normalization
restrictions in sections 6--7 still apply without change.

### 8.5 The constructed exceptional set still excludes this small-Q point

There is a separate limitation in
[Joshi IV v2, PDF page 54](https://arxiv.org/pdf/2403.10430v2).
The proof constructs Exc by adding, among other points, those
in the chosen domain with sqrt(Q)<=xi_prm, where Lemma 5.8.1
requires

    theta(x)=sum_(prime p<=x)log p >= 2x/3
    for every x>=xi_prm.

Necessarily xi_prm>6: theta(6)=log30<4, since
e>8/3 and (8/3)^4>30. For both 2790703 and the original
8105229, we have N<2^24<e^18; the second inequality follows
from e^3>(8/3)^3>16. Hence both normalized quantities satisfy

    Q=2log N<36,  sqrt(Q)<6<xi_prm.                 (8.4)

Thus, if the corresponding Legendre parameter lies in the chosen
bounding domain, it is included in that proof's constructed Exc.
The direct Legendre replacement removes the twist gate, but
does not remove this particular small-Q exclusion.

In fact the uniform prime bound forces xi_prm>10: at x=10,
theta(10)=log210<6<20/3, since
e^6>(8/3)^6=262144/729>210. Hence any ell=7 candidate
satisfying the same normalized numerical condition sqrt(Q)<=7
is added by this small-Q step, if its parameter belongs to the
chosen domain. The limitation is not special to the two N values
in (8.4); replacing the curve while retaining this ell does not
avoid the printed construction's exclusion.

The normalization is explicit here: Definition 5.4.1 (PDF page
51) and Theorem 5.7.1 (page 53) divide the Tate sum by the field
degree. The opening formula of section 5.8 displays an
unnormalized sum instead. Equation (8.4) uses the invariant
specified in the definition and theorem. Reading that later sum
as a different unnormalized Q would also prevent use of (8.3)
and the stated numerical window for that different quantity.
No silent correction of this source discrepancy is made.

The theorem only asserts the existence of a finite exceptional
set; it does not specify a unique smallest one. Membership in
the printed proof's set neither proves failure of actual initial
theta data nor rules out a different sufficient exceptional set.
One may still check initial data directly, without using this
off-exceptional-set existence theorem.

What has been proved for D is the direct rational Legendre model,
full rational 2-torsion, the stated level fields containing i and
full 15-torsion, good reduction at 7, split multiplicative reduction
at 139, the exact local tame field, SL2(F7) containment over Q
and L_D, the numerical window, and the applicable local minimum
layer calculation. A chosen compact bounding domain, all other
initial theta choices, the exact published powered-label/source
dictionary, the Bloch--Kato normalization, point versus ideal
pilots, and global comparison arrows are still separate source
obligations. No abc conclusion follows from these calculations.
