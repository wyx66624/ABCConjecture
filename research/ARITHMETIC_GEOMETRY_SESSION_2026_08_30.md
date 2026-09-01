# Effective concentration of the Pell–Chebyshev residual

Author: ChatGPT. Date: 30 August 2026.

This note gives two effective necessary-condition arguments for a precisely
specified Pell subfamily, followed by an applicability audit of two 2026
papers. It does not prove or disprove abc. In particular, no statement below
asserts that every potential abc counterexample belongs to this Pell family.
The proofs precede the companion Lean formalization.

## 1. The residual packet and the existing exact inequality

Fix positive integers

\[
b,A,B,u,v,r,s,X,\qquad p\ge37\text{ prime},
\]

with the following data:

\[
 b=Au^2,\quad b+1=Bv^2,\quad b+2=3r^2,\quad b+3=s^2,
 \tag{1}
\]

\[
 D=3AB,\quad Z=b^2+3b+1=T_p(X),\quad
 D+1\le X^2,\quad X^p\le Z.                              \tag{2}
\]

Here \(T_p\) is the first Chebyshev polynomial. In the repository's active
branch, \(A,B\) are squarefree and satisfy \(A\equiv22\), \(B\equiv23\pmod{24}\);
the new estimates do not need squarefreeness or these residue restrictions.
The latter restrictions imply \(D\ge1518\). The two inequalities in (2) are
explicit packet data; no new proof of the original reduction is claimed here.

Write

\[
 H=\log(b+2),\quad L=\log(D+1),\quad
 C_0=12^{331776},\quad K_0=\log(2C_0).
\]

All logarithms are natural. Since \(b\ge1\), \(H>1\).
The packet gives

\[
 (D+1)^p\le X^{2p}\le Z^2<(b+2)^4,
 \qquad pL<4H.                                             \tag{3}
\]

Indeed \((b+2)^2-Z=b+3>0\). This is the variable-index form of the
repository's already checked post-p31 power threshold. Retaining \(p\), rather
than replacing it by 37, is essential in what follows.

The existing fixed-index certificates have separately recorded external
computation boundaries. Nothing in this note strengthens those trust claims.

## 2. The published effective input

We use the following specialization to \(\mathbf Q\), integral variables,
and exponent two of Bérczes–Evertse–Győry, Theorem 2.2. If
\(f\in\mathbf Z[t]\) has degree \(n\ge3\), no repeated roots, coefficient
height \(\widehat h=\log\max(1,|a_0|,\ldots,|a_n|)\), and
\(f(x)=y^2\), then

\[
 \max\{h(x),h(y)\}
 \le (4n)^{4096n^4}\exp(50n^4\widehat h).                  \tag{4}
\]

Here \(h(m)=\log\max(1,|m|)\). In the original theorem these choices mean
\(K=\mathbf Q\), \(S=\{\infty\}\), \(d=s=1\), \(|D_K|=Q_S=1\), and the
coefficient multiplying \(y^2\) is one. Formula (4) is a published theorem,
not an abc-conditional hypothesis. It is not formalized in the local Lean
library; its numerical consequences remain explicit arguments there.
[Original article, Theorem 2.2 and the preceding definitions, p. 730](https://publi.math.unideb.hu/paper/1797/download/10_5486_PMD_2013_5748.pdf).

## 3. Attempt I: moving-degree effective height forces the index to grow

**Proposition 1.** Every packet (1)–(2) satisfies

\[
 H\le\exp(4300p^5),\qquad \log H\le4300p^5.                 \tag{5}
\]

**Proof.** Put \(f_p(t)=4T_p(t)+5\). By (2),

\[
 f_p(X)=4(b^2+3b+1)+5=(2b+3)^2.                            \tag{6}
\]

The polynomial \(f_p\) has degree \(p\). It is squarefree in characteristic
zero: at a common root of \(f_p\) and \(f'_p=4pU_{p-1}\), the identity
\(T_p^2-1=(t^2-1)U_{p-1}^2\) would give \(T_p=\pm1\), whereas
\(4T_p+5\) is respectively 9 or 1.

Let \(M_n\) be the sum of the absolute values of the coefficients of \(T_n\).
The recurrence gives \(M_{n+2}\le2M_{n+1}+M_n\), with \(M_0=M_1=1\).
Induction proves \(M_n\le3^n\): the inductive upper bound is
\(2\cdot3^{n+1}+3^n=7\cdot3^n\le3^{n+2}\).
Consequently every coefficient of \(f_p\) is at most
\(4\cdot3^p+5\le3^{p+2}\) in absolute value. Thus

\[
 \widehat h\le(p+2)\log3\le4p\qquad(p\ge3).
\]

Also \(\log(4p)\le p\) for \(p\ge3\): the function
\(t-\log(4t)\) is increasing for \(t>1\) and is positive at 3.
Applying (4) to (6) yields

\[
 \begin{aligned}
 H&\le\log(2b+3)\\
  &\le\exp\bigl(4096p^4\log(4p)+50p^4\widehat h\bigr)\\
  &\le\exp(4296p^5)\le\exp(4300p^5).
 \end{aligned}
\]

Taking logarithms proves (5). All constants here are independent of the
packet, its support, the Pell field, and the prime index. ∎

Combining (3) and (5) gives the explicit upper corridor

\[
 p\ge\left(\frac{\log H}{4300}\right)^{1/5},\qquad
 \boxed{\quad
 L<4\cdot4300^{1/5}\frac{H}{(\log H)^{1/5}}.
 \quad}                                                    \tag{7}
\]

For a scalar formalization which avoids fractional powers, the same
implication can be written

\[
 (\log H)L^5\le4300(4H)^5.                                \tag{8}
\]

To prove (8), multiply \(\log H\le4300p^5\) by \(L^5\ge0\), use
\(p^5L^5=(pL)^5\), and raise \(pL\le4H\) to the fifth power.

This attempt proves a uniform restriction. It does not exclude any actual
packet satisfying that restriction; no failed proof step is described as a
counterexample.

## 4. Attempt II: a fixed-degree elliptic model forces the kernel to grow

**Proposition 2.** Every packet (1)–(2) satisfies

\[
 \boxed{\quad H\le2C_0D^{4050}.\quad}                       \tag{9}
\]

**Proof.** The first three equations in (1) give

\[
 b(b+1)(b+2)=D(uvr)^2.
\]

Set \(x=b+1\), \(Y=Duvr\). Then these are integers and

\[
 Y^2=D\bigl(x^3-x\bigr).                                  \tag{10}
\]

For each positive \(D\), the cubic \(f_D(t)=D(t^3-t)\) has degree three,
three distinct roots \(-1,0,1\), and coefficient height \(\log D\).
Its smooth projective hyperelliptic model has genus one and a single
rational point at infinity. In particular it satisfies the positive-genus
case of Siegel's theorem; there is no appeal to a two-pole Runge condition.
More strongly, (4), with \(n=3\), gives

\[
 \log(b+1)\le
 12^{4096\cdot3^4}\exp(50\cdot3^4\log D)
 =C_0D^{4050}.
\]

For \(b\ge1\), \(b+2\le(b+1)^2\), hence
\(H\le2\log(b+1)\), proving (9). ∎

The map to (10) has no hidden infinite fibre: its first coordinate is
\(b+1\), so an integral point fixes \(b\). For fixed \(D\), (9) bounds
\(b\); (3) subsequently bounds \(p\), and \(X^p\le Z\) bounds \(X\).
There are finitely many positive factor pairs \((A,B)\) with \(3AB=D\),
and each square root in (1) has at most one positive value. Thus even the
full positive packet fibre over a fixed \(D\) is finite.

The elementary consequences of (9) are

\[
 D\ge\left(\frac{H}{2C_0}\right)^{1/4050},\qquad
 \log H\le K_0+4050\log D.                                \tag{11}
\]

Together with (3), this gives a complementary restriction on the index:

\[
 p(\log H-K_0)<16200H.                                    \tag{12}
\]

Indeed, multiply the second inequality in (11) by \(p>0\), use
\(\log D<\log(D+1)\), then apply (3). If \(\log H\ge2K_0\), (12) implies

\[
 p<32400\frac{H}{\log H}.                                 \tag{13}
\]

The large numerical constant is deliberately not optimized. Unlike an
unspecified fixed-field Siegel bound, (9) displays all dependence on \(D\).

## 5. Consequence for any infinite residual sequence

The squarefree part, rather than the unreduced integer \(D\), determines
the quadratic field. The following descent is needed before drawing any
conclusion about variation of that field.

**Proposition 2a (square-factor descent).** Write uniquely
\(D=d t^2\), where \(d,t\) are positive integers and \(d\) is squarefree.
Every packet (1)–(2) satisfies the stronger bound

\[
 H\le 2C_0d^{4050},\qquad
 d\ge\left(\frac{H}{2C_0}\right)^{1/4050}.                 \tag{9a}
\]

**Proof.** Take the integral point \((x,Y)\) from (10). Its equation is
\(Y^2=d t^2(x^3-x)\), so \(t^2\mid Y^2\). For integers, this implies
\(t\mid Y\): for every prime \(q\mid t\), comparison of valuations gives
\(2v_q(t)\le2v_q(Y)\), hence \(v_q(t)\le v_q(Y)\). The case \(Y=0\)
is immediate. Thus \(Y=t y\) for an integer \(y\). Since \(t\ne0\),
cancelling \(t^2\) gives

\[
 y^2=d(x^3-x).                                             \tag{10a}
\]

The polynomial \(d(z^3-z)\) has degree three, distinct roots
\(-1,0,1\), and coefficient height \(\log d\). Applying (4) to (10a)
therefore gives \(\log(b+1)\le C_0d^{4050}\). The same elementary
inequality \(b+2\le(b+1)^2\) as before proves (9a). No estimate for
the varying square factor \(t\) is required. ∎

**Corollary.** Let a sequence of packets (1)–(2) have strictly increasing
\(b_n\), and write \(D_n=d_nt_n^2\) as above. Then

\[
 p_n\longrightarrow\infty,\qquad d_n\longrightarrow\infty,
 \qquad D_n\longrightarrow\infty,
 \qquad \frac{\log(D_n+1)}{\log(b_n+2)}\longrightarrow0.    \tag{14}
\]

**Proof.** Strictly increasing positive integers \(b_n\) tend to infinity,
so \(H_n\to\infty\) and \(\log H_n\to\infty\). Apply respectively the
first inequality of (7), (9a), \(D_n\ge d_n\), and the boxed inequality
of (7). ∎

Equivalently, every fixed \(\delta>0\) eventually satisfies
\(D_n+1<(b_n+2)^\delta\), while even the squarefree part \(d_n\)
tends to infinity. Moreover,

\[
 0\le\frac{\log d_n}{H_n}
 \le\frac{\log(D_n+1)}{H_n}\longrightarrow0.
\]

The field \(\mathbf Q(\sqrt{D_n})=\mathbf Q(\sqrt{d_n})\) cannot be
fixed, or lie in any finite set of quadratic fields. Indeed each real
quadratic field has a unique positive squarefree radicand, whereas
\(d_n\to\infty\). Eventually \(d_n>1\), and the field discriminant is
\(d_n\) or \(4d_n\); its logarithm divided by \(H_n\) also tends to
zero. This conclusion uses the descent (10a), not just \(D_n\to\infty\),
which alone would allow a fixed squareclass and a growing square factor.

For comparison, the qualitative argument using Siegel is also sound when
stated with the correct fibres. The curve \(y^2=4T_p(X)+5\) is smooth of
genus \((p-1)/2\) and has one point at infinity. For fixed \(p\), it has
finitely many integral \((X,y)\), and \(y=2b+3\) fixes \(b\). A finite
union over bounded \(p\) therefore contains only finitely many \(b\).
The fixed-squareclass argument uses (10a), whose first coordinate still
fixes \(b\). It therefore bounds \(b\) for fixed \(d\), without asserting
that a varying elliptic curve is fixed. The quantitative proof above avoids
needing either finiteness theorem as an unstated formal premise.

There is no contradiction between (7) and (11). Their permitted corridor is
very wide: a lower power of \(\log b\) and an upper bound
\(\exp(O(\log b/(\log\log b)^{1/5}))\) are compatible. A fixed-field
constant cannot be substituted into this moving-field situation. Tatuzawa
class-number estimates do not by themselves provide the missing bound on
the integral points or the new square-base radical mass. A sufficiently
strong pointwise kernel bound could close the route, but it is not proved
by this note.

## 6. Latest source audit: Pasten, 24 August 2026

Pasten's new preprint *Power-saving bounds for Thue–Mahler and Mordell
equations* was submitted on 24 August 2026, before this note's cutoff.
It is a preprint, and is not promoted here to a completed formal proof or
an independently refereed input. The relevant precise result is Theorem
1.3: for \(k\ne0\), \(y^2=x^3+k\), and
\(\underline{k}=\prod_{q\mid k}q^{\min(2,v_q(k))}\),

\[
 \log\max(|x|,|y|)\ll
 \underline{k}^{1/2}\log^2(2\underline{k})\log(2|k|)
 \log\bigl(\underline{k}\log(3|k|)\bigr),                  \tag{15}
\]

with an effective absolute constant. Theorem 1.6 controls the **curve's**
Faltings height by \(N^{1/2}(\log N)^4\) when \(j\) is integral. It does
not bound the height of a variable rational or integral point on that curve.
[Original preprint, Theorems 1.3 and 1.6](https://arxiv.org/html/2608.23559v1).

### 6.1 Direct substitution of Frey invariants does not yield abc

For \(E:y^2=x(x-a)(x+b)\), \(a+b=c\), let \(c_4,c_6,\Delta\) be its
integral invariants. They satisfy

\[
 c_6^2=c_4^3-1728\Delta,\qquad
 \Delta=16(abc)^2.
\]

Thus (15) applies with \(k=-27648(abc)^2\). If
\(R=\operatorname{rad}(abc)\), then
\(\underline{k}^{1/2}\ll R\),
\(\log(2|k|)\asymp\log c\), and
\(\log\max(|c_4|,|c_6|)\asymp\log c\), with absolute constants.
Consequently the resulting upper bound has the shape

\[
 \log c\ll R\log^2(2R)\,\log c\,
 \log\bigl(2R\log(3c)\bigr).
\]

The height still appears multiplicatively on the right; cancelling it
gives no upper bound for \(c\) in terms of \(R\). This is an applicability
calculation, not a counterexample to Pasten's theorem.

### 6.2 A precise obstruction to a proposed fixed-Mordell morphism

Equation (10) is isomorphic over \(\mathbf Q\) to
\(E_D:V^2=U^3-D^2U\) via \(U=Dx\), \(V=DY\). Its \(j\)-invariant is
1728. One possible strategy would turn all its points into points of a
single nonsingular Mordell curve \(M_k:v^2=u^3+k\), with \(k\) depending
only on \(D\), by a nonconstant algebraic morphism. That specific strategy
is impossible.

**Proof.** Over \(\overline{\mathbf Q}\), \(E_D\) has endomorphism algebra
\(\mathbf Q(i)\), whereas \(M_k\) has endomorphism algebra
\(\mathbf Q(\sqrt{-3})\). One sees the respective quadratic actions from
\((x,y)\mapsto(-x,iy)\) and \((x,y)\mapsto(\zeta_3x,y)\); in
characteristic zero the endomorphism algebra of an elliptic curve has
dimension at most two over \(\mathbf Q\). A nonconstant morphism between
elliptic curves, after translating its value at the origin, is an isogeny.
For an isogeny \(\phi\), conjugation by \(\phi\) and its rational inverse
identifies the two endomorphism algebras. The displayed imaginary quadratic
fields are not isomorphic, a contradiction. ∎

This proof excludes a nonconstant morphism to a fixed Mordell curve. It does
**not** exclude piecewise arithmetic encodings, a finite collection of other
Diophantine equations, or a new extension of the preprint's logarithmic-form
method to this different family. Those remain unproved possibilities.

There is a further literal hypothesis check for the new cubic Thue–Mahler
bound: the homogenization of our cubic is
\(D(U^3-UV^2)=DU(U-V)(U+V)\), which is reducible over \(\mathbf Q\).
Theorem 1.8 of the preprint assumes an irreducible binary cubic. Moreover,
the square \(Y^2\) in (10) does not have prime support fixed by \(D\).
Thus one cannot apply that theorem directly to (10) by merely renaming its
variables.

## 7. Latest source audit: Pasten's small-denominator theorem

The published May 2026 paper *Szpiro's conjecture when the denominator of
the j-invariant is small* proves, for fixed \(A_0,B_0>0\),

\[
 \operatorname{den}(j_E)\le A_0\log^{B_0}\operatorname{num}(j_E)
 \ \Longrightarrow\
 |\Delta_E|\le A_0 16^{B_0+1}N_E^{B_0+5}\log^{B_0}N_E.
\]

The special case \(B_0=1\) gives the sharp Szpiro exponent up to a
logarithm. The denominator condition is essential.
[Original published article, Theorem 1.2 and Corollary 1.3](https://www.scielo.cl/pdf/cubo/v28n2/0719-0646-cubo-28-02-383.pdf).

**Proposition 3.** For every positive primitive abc triple and its Frey
curve, writing \(n=\operatorname{num}(j_E)\),
\(d=\operatorname{den}(j_E)\) in lowest terms,

\[
 \boxed{\quad c^4\le1024d,\qquad n\le256c^6.\quad}         \tag{16}
\]

**Proof.** Put \(Q=a^2+ab+b^2\). The identity
\(j_E=256Q^3/(abc)^2\) holds. Primitivity implies
\(\gcd(Q,abc)=1\): reduction modulo a prime divisor of any one of
\(a,b,c\) leaves the square of a nonzero other coordinate. Hence
\(g=\gcd(256Q^3,(abc)^2)\) divides 256, so
\((abc)^2=gd\le256d\). Since
\((a-1)(b-1)\ge0\), \(ab\ge c-1\); since \(c\ge2\),
\(2ab\ge c\). Squaring \(2abc\ge c^2\) yields
\(c^4\le4(abc)^2\le1024d\). Finally \(Q=c^2-ab\le c^2\),
so \(n\le256Q^3\le256c^6\). ∎

It follows that for each fixed \(A_0,B_0\), only finitely many positive
primitive Frey triples satisfy the published theorem's denominator
condition. Indeed it would imply

\[
 c^4\le1024A_0(\log256+6\log c)^{B_0},
\]

which fails for sufficiently large \(c\); only finitely many positive
\(a,b\) have bounded sum. Thus this theorem cannot be applied to an
unbounded Frey family by simply asserting its hypothesis. The conclusion
does not discard other Szpiro approaches, isogenies, or different auxiliary
curves.

## 8. Formal scope and next mathematical target

The companion module is
`Lean/IUTThreeClosures/FreyPellEffectiveResidualCorridor20260830.lean`.
It checks the exact integer map (10), the general integer square-factor
descent (10a), the elementary scalar combination of (3), (5), and (11),
and the new denominator lower bound in (16) using the repository's existing
reduced-Frey-invariant data. The descent is proved for arbitrary integers
\(d,t,x,Y\) with \(t\ne0\); squarefreeness is only needed in the
mathematical application to identify the quadratic field.
The effective Diophantine estimate (4), Siegel's theorem, and the
endomorphism-algebra argument are not silently imported as Lean axioms.
Numerical consequences of (4) are explicit theorem arguments.

Validation completed on 30 August 2026:

```text
lake env lean IUTThreeClosures/FreyPellEffectiveResidualCorridor20260830.lean
exit code: 0
```

The reported axioms are only `propext`, `Classical.choice`, and `Quot.sound`
(the integral genus-one identity needs only `propext`). No `sorryAx` or
new axiom occurs in the checked conclusions. The command checks the new
module, not the complete repository. Local copies of the three audited
original PDFs are under `research/sources/arithmetic_geometry_2026_08_30/`.

A potentially useful next step would be an estimate for this moving
elliptic family strong enough to contradict (7), or a new bound on the
radical of the square bases \(u,v\) retaining both endpoint contributions.
The latter distinction matters: a small parity kernel does not imply a
small radical, and controlling one endpoint alone does not supply the
required cancellation. The arguments here locate this issue more precisely;
they do not close it.
