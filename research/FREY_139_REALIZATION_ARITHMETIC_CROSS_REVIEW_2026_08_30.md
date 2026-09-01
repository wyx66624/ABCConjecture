# Independent arithmetic review of the rational 139-adic realization

Author: ChatGPT. Research date: 2026-08-30.

Scope: independent mathematical review of
`FREY_139_TATE_210_REALIZATION_2026_08_30.md`, sections 1--7, and an
independent calculation for the direct Legendre curve in its new section 8.
No frozen manuscript, existing Lean module, aggregate entry point, or
verification record is changed by this review.

## 1. Review outcome and the material source qualification

The original curve

    C: y^2=x(x-139)(x+279)

passes the arithmetic checks in sections 1--6: the invariants, split
multiplicative reduction at 139, rational square root of its Tate parameter,
exact 210-torsion field, elementary mod-7 image argument over both Q and the
specified level field, and the numerical Tate window are correct.

The direct Legendre replacement

    D: y^2=x(x-1)(x+2362)

also passes all of those checks. Unlike C, it is already the Legendre
representative, with parameter -2362, over Q. It removes the twist issue in
the original section 7.

There is a stronger qualification than an unchecked exceptional-set
condition. With Q normalized as in Joshi IV v2, Definition 5.4.1 and
Theorem 5.7.1, both examples have sqrt(Q)<6. The small-Q step in the printed
construction of its exceptional set therefore adds these examples, if
their Legendre parameters belong to the chosen bounding domain. Section 6
below proves this without estimating a prime-number-theorem constant.
This concerns that particular constructed exceptional set, not every
possible finite exceptional set, and does not disprove the possibility of
checking initial theta data directly for these curves.

## 2. The original curve: checks that require more than numerics

For (a,b,c)=(139,279,418), expansion gives

    Delta=16(abc)^2,   c4=16(a^2+ab+b^2)=16*135943.

At 139 the reduction is y^2=x^2(x+1), whose tangent cone at the node is
y^2-x^2. The unit c4 proves the integral equation is minimal; hence the
reduction is split multiplicative and the Tate parameter has valuation 2.
The argument uses splitness, rather than merely the negative valuation
of j.

The rational-square-root argument is valid. The Tate class of any chosen
sqrt(q) is rational because all geometric 2-torsion points are rational.
For a Galois element sigma, its ratio sigma(sqrt(q))/sqrt(q) is in q^Z
and has valuation zero, so the ratio is 1. The identical zero-valuation
argument for the two Tate torsion generators proves equality, not just
inclusion, of

    Q_139(C[N])=Q_139(mu_N,q^(1/N)).

If b0=sqrt(q) and pi^105=b0, then Q_139(mu_210) is unramified quadratic,
X^105-b0 is Eisenstein, and adjoining pi gives degree 210, ramification
index 105, and residue degree 2. The unramified quadratic field contains
i. Thus no extra local extension is introduced by the i in
L'=Q(i,C[210]). This establishes the claimed completion of L' and does
not assume q=139^2.

The point count at 5 is 8, so Frobenius has polynomial X^2+2X+5 modulo 7.
Its discriminant is the nonsquare 5. A Tate inertia transvection T and
its conjugate by this Frobenius fix two different F7-lines. In the basis
of those lines they give upper and lower nonzero unipotents. Their powers
give all upper and lower elementary matrices over the prime field F7,
which generate SL2(F7).

Finally L=Q(i,C[30]) is Galois of degree dividing
2*6*48*480=276480, which is prime to 7. The image over L is normal with
prime-to-7 index, so it contains T and its conjugate and therefore SL2.
There is no need for, and no hidden use of, a subgroup classification or
an effective open-image theorem.

The point count and polynomial identities are finite certificates. Tate
uniformization and the good-reduction Frobenius theorem remain external
mathematical inputs; this review does not upgrade them to Lean theorems.

## 3. Direct Legendre example and its local field

Take

    (a,b,c)=(1,2362,2363),
    2362=2*1181,   2363=17*139,
    D: y^2=x(x-1)(x+2362),   lambda=-2362.

The triple is positive and primitive because consecutive integers are
coprime. Trial division by the primes at most sqrt(1181)<35 confirms
that 1181 is prime. Put M=2362*2363=5581406. Then

    a^2+ab+b^2=M+1=5581407,
    Delta(D)=16*M^2,
    c4(D)=16*(M+1),
    j(D)=256*(M+1)^3/M^2.

In particular gcd(M,M+1)=1.

Modulo 139, since 2362=-1, the equation is

    y^2=x(x-1)^2.

At the double root x=1, write X=x-1. The equation is
y^2=X^2(1+X), and the two tangent lines are y=+X and y=-X. The c4
valuation is zero and the discriminant valuation is 2. Thus this exact
Legendre representative has split multiplicative reduction and a Tate
parameter q_D in Q_139 with valuation 2.

All its 2-torsion is rational. The proof of section 2 therefore gives

    b0=sqrt(q_D) in Q_139,   v_139(b0)=1,
    E_D=Q_139(mu_210,pi),   pi^105=b0,
    Q_139(D[210])=E_D,
    [E_D:Q_139]=210,   e=105,   f=2.

For L_D=Q(i,D[30]) and L'_D=Q(i,D[210]), the chosen completion of L'_D
is exactly E_D. The local proof in
`IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md`, section 11,
applies with this b0. Its proof explicitly permits the rational unit
b0/139; it does not replace b0 by 139.

## 4. Direct verification of the mod-7 image for D

At 5, D reduces to y^2=x(x-1)(x+2). Its complete count is

| x | y-coordinates in F5 |
|---:|:---|
| 0 | 0 |
| 1 | 0 |
| 2 | none |
| 3 | 0 |
| 4 | none |

There are three affine points and the point at infinity. Thus
#D(F5)=4 and a_5=2. The characteristic polynomial modulo 7 is

    X^2-2X+5,

whose discriminant is 5. Its values at 0,...,6 are
5,4,5,1,6,6,1, so it has no root in F7. The inertia transvection at
139 and the two-line argument from section 2 prove

    image(G_Q on D[7]) contains SL2(F7).

The degree of L_D divides 276480 and is prime to 7. The same normality
argument proves the corresponding containment for image(G_(L_D)).
Also 7 does not divide the displayed discriminant, since
(a,b,c)=(1,3,4) modulo 7, so D has good reduction at 7.

## 5. Tate quantity and the numerical window for D

At each of 17,139,1181 the j-valuation is -2. At 2 it is
8-2v_2(M)=6. No other prime has negative j-valuation. Therefore the
base-change invariant, normalized Tate quantity is

    Q_D=2log(17*139*1181)=2log(2790703).

This is computed on a semistable splitting extension, or equivalently
as the sum of the negative finite j-valuations. The identification
with a Tate sum on L_D additionally uses the usual semistability theorem
at residue characteristic 2 after adjoining full level-3 torsion. Every
odd bad prime is already multiplicative over Q, and 3 is a good prime
for D; thus there is no use of a prime-to-residue-characteristic torsion
criterion at residue characteristic 3. This is a classical external
input, not a consequence of the finite point count alone.

Exact integer certificates are

    3^25 = 847288609443
         < 2790703^2 = 7788023234209
         < 2^49 = 562949953421312.

Since 2<e<3, they imply 25<Q_D<49. The field of moduli is Q, so
delta=2^12*3^3*5=552960. We have sqrt(Q_D)<7, and

    7 < 10*delta*sqrt(Q_D)*log(2*delta*log(Q_D)).

For example Q_D>25 and e<3 imply log(Q_D)>2, so the final logarithm
is greater than 1 and the right side is greater than 50. Thus ell=7
satisfies both numerical endpoints in Theorem 5.7.1.

Moreover the nonzero integral Tate orders at the odd multiplicative
places of L_D are 2e_w, with e_w dividing [L_D:Q]. Consequently none
is divisible by 7. Good reduction at 7 persists under extension. These
facts can be used in a later item-by-item source check; they do not
establish every initial-data hypothesis.

## 6. A rigorous small-Q limitation of the printed exceptional set

The primary source is
[Joshi IV, arXiv:2403.10430v2](https://arxiv.org/pdf/2403.10430v2):
Definition 5.4.1 on PDF page 51, Theorem 5.7.1 on page 53, and the
construction and Lemma 5.8.1 on page 54.

Let xi be any constant satisfying the lower bound in that lemma:

    theta(x)=sum_(prime p<=x) log p >= 2x/3
    for every real x>=xi.

At x=6, theta(6)=log(2*3*5)=log30<4. Here the strict inequality
follows, for example, from e>1+1+1/2+1/6=8/3 and
(8/3)^4=4096/81>30. Hence xi>6: if xi<=6, the asserted lower
bound applied at x=6 would be false.

For both examples their N=8105229 and N=2790703 satisfy N<2^24.
Also e^3>(8/3)^3>16, so e^18>16^6=2^24. It follows that

    Q=2log N<36,   sqrt(Q)<6<xi.

The construction on page 54 adds all bounded-degree parameters in
the chosen domain with sqrt(Q)<=xi to Exc. Thus both Legendre
parameters are added, if they lie in the chosen domain. In the original
twisted example the relevant Legendre parameter is -279/139; j and
the normalized Q are invariant under that twist. For the replacement
example it is exactly -2362.

There is also a uniform strengthening relevant to any proposed ell=7
example. At x=10,

    theta(10)=log(2*3*5*7)=log210<6<20/3.

Indeed e>8/3 gives e^6>(8/3)^6=262144/729>210. Thus every
constant for the printed uniform lower bound must satisfy xi>10.
Consequently, for any parameter in the chosen domain, the numerical
inequality sqrt(Q)<=7 already puts that parameter into this particular
small-Q exceptional set. Replacing the example while keeping ell=7
and the same normalized numerical window cannot avoid this step.
This strengthens the two explicit examples; it still says nothing
against checking actual initial theta data directly.

There is a printed normalization issue to keep separate: at the start
of section 5.8, the source writes Q=Tate as an unnormalized sum of
integral Tate orders. Definition 5.4.1 and Theorem 5.7.1 instead specify
the sum divided by the field degree. The conclusion in this section
uses the latter, expressly defined invariant. Reading the section 5.8
sum literally as a different, unnormalized Q would also invalidate use
of Q=2log N and the preceding numerical window for that different Q.
This review neither silently repairs that discrepancy nor uses it to
claim a contradiction in an abc statement.

Finally, Exc is not uniquely specified by the existence theorem.
Membership in the set constructed in this proof does not imply
membership in every set for which the theorem could be true. Nor
does membership assert that initial theta data fail: an existence
theorem stated off an exceptional set is silent on the points inside it.

## 7. Proven and still separate conditions

For D the arithmetic conclusions proved here are: the direct Legendre
model over Q; full rational 2-torsion; the prescribed level fields
containing i and full 15-torsion; good reduction at 7; a nonempty odd
split multiplicative place at 139; the exact local (e,f,d)=(105,2,210)
field; the tame inequality e<=p-2; SL2(F7) in both specified mod-7
images; the numerical ell-window; and applicability of the previously
proved local minimum-layer calculation with actual b0=sqrt(q_D).

The following are separate source obligations: selection of the
compact bounding domain and its stated 2-adic condition; all remaining
global initial theta choices; the exact published label/source-set and
Galois-arrow dictionary; the ordinary versus normalized Bloch--Kato
coefficient; the distinction between point hulls and fractional-ideal
pilots; and any global inter-universal comparison. The proof-constructed
exceptional-set condition cannot be certified for these fixed examples
under the defined normalized Q, by section 6. A direct check of actual
initial data need not rely on that sufficient existence theorem.

No full-Galois or Tate-uniformization theorem was assumed as a new Lean
axiom. This report is a mathematical cross-review; parent-owned Lean
certificates address only their expressly stated finite/algebraic scope.

## 8. Original sources checked

The unchanged local Tate-uniformization input is
[Kedlaya, Introduction: the Tate curve (2004), Theorems 1--2 and
Proposition 3, PDF pages 3--5](https://kskedlaya.org/18.727/tate-curve.pdf).
Its archived copy is
`sources/galois_lift_2026_08_30/Kedlaya_2004_Tate_Curve.pdf`.

The Joshi source is the unchanged 80-page version
`sources/iut_2026_08_30/Joshi_IV_2403.10430v2.pdf`.
The definition, theorem, and exception-set pages were read directly,
not inferred from a summary or from a different arXiv version.
The original pages 51 and 54 were also rendered and visually inspected;
the displayed normalization discrepancy is present in the PDF itself,
not an artifact of text extraction.
