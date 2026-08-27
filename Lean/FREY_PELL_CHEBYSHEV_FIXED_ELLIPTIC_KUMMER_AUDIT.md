# Fixed elliptic and modular-unit reconstruction of the prime-index Chebyshev square

## Scope and status

This note audits a new reduction of

\[
 y^2=4\mathcal T_p(T)+5,\qquad T>1,\qquad
 p=2g+1\text{ an odd prime},                                  \tag{0.1}
\]

where \(\mathcal T_p\) is the first-kind Chebyshev polynomial.  The reduction
is exact and uniform in \(p\): every putative solution maps to a Kummer point
on one fixed elliptic curve of conductor \(24\).  In the four-consecutive Pell
branch it also gives an explicit rational point on one quadratic twist of that
fixed curve.

This is a genuine new interface, not a proof that (0.1) has no solutions.  The
remaining condition is a prime-power value of a fixed modular unit at a
trace-rational quadratic point, while the quadratic field varies.  No accepted
theorem located in the 2020--2026 audit below has the required quantifiers.
Nothing here assumes \(abc\), GRH, BSD, finiteness of Sha, or another open
conjecture.

The companion Lean file
`IUTThreeClosures/FreyPellChebyshevFixedEllipticKummerAudit.lean` checks the
scalar identities only.  Its formal boundary is stated explicitly in Section
10.

## 1. A fixed elliptic curve

Let

\[
 K=\mathbf Q\!\left(\sqrt{T^2-1}\right),\qquad
 \epsilon=T+\sqrt{T^2-1},\qquad u=\epsilon^p.              \tag{1.1}
\]

Then \(N_{K/\mathbf Q}(\epsilon)=1\), and the Chebyshev identity is

\[
 u+u^{-1}=2\mathcal T_p(T).                               \tag{1.2}
\]

Consequently (0.1) is equivalent to

\[
 y^2=2(u+u^{-1})+5,
 \qquad
 y^2u=2u^2+5u+2.                                          \tag{1.3}
\]

Define the fixed elliptic curves

\[
 E:\quad V^2=U(U+2)(2U+1),                                \tag{1.4}
\]

and, by \(X=2U,\;Y=2V\),

\[
 E_0:\quad Y^2=X(X+1)(X+4).                               \tag{1.5}
\]

Equation (1.3) gives the point

\[
 P=(u,yu)\in E(K),\qquad
 P_0=(2u,2yu)\in E_0(K).                                  \tag{1.6}
\]

Indeed

\[
 (yu)^2=u^2y^2=u(2u^2+5u+2)=u(u+2)(2u+1).                \tag{1.7}
\]

Thus the changing genus has not disappeared, but its prime-index part is now
the single Kummer condition

\[
 U(P)=\epsilon^p                                           \tag{1.8}
\]

on a fixed elliptic base.

## 2. Galois involution and a rational twist coordinate

On \(E_0\), put

\[
 Q=(0,0),\qquad
 \iota(X,Y)=\left(\frac4X,\frac{4Y}{X^2}\right).          \tag{2.1}
\]

For a point \(S=(X,Y)\) with \(X\ne0\), the chord from \(Q\) to \(-S\)
has slope \(-Y/X\).  Since

\[
 \left(-\frac YX\right)^2-5-X=\frac4X,
\]

and the corresponding second coordinate is \(4Y/X^2\), the elliptic group
law gives the exact identity

\[
 \iota(S)=Q-S.                                             \tag{2.2}
\]

The rational point

\[
 H=(-2,-2)                                                 \tag{2.3}
\]

lies on \(E_0\), is fixed by \(\iota\), and satisfies \(2H=Q\).  This can
also be checked directly: the tangent slope at \(H\) is \(1\), and the
doubling formula gives \((0,0)\).

Let \(\sigma\) denote the nontrivial automorphism of \(K/\mathbf Q\).  Since
\(\sigma(u)=u^{-1}\) and \(y\in\mathbf Q\),

\[
 \sigma(P_0)=\iota(P_0)=Q-P_0.                             \tag{2.4}
\]

Translate by the rational half of \(Q\):

\[
 R=P_0-H.                                                  \tag{2.5}
\]

Then

\[
 \sigma(R)=-R.                                             \tag{2.6}
\]

The line from \(P_0=(2u,2yu)\) to \(-H=(-2,2)\) has slope

\[
 m=\frac{yu-1}{u+1}.
\]

Using only \(y^2u=2u^2+5u+2\), the addition formula simplifies to

\[
 \boxed{\quad x(R)=m^2-5-2u+2
       =-2\frac{y+1}{y-1}\in\mathbf Q.\quad}              \tag{2.7}
\]

If \(K=\mathbf Q(\sqrt D)\) with \(D\) squarefree, (2.6) says that the
second coordinate of \(R\) is \(\sqrt D\) times a rational number.  Hence
\(R\) is equivalently a rational point on the quadratic twist

\[
 E_0^{(D)}:\quad D W^2=X(X+1)(X+4),                       \tag{2.8}
\]

whose \(X\)-coordinate is the fixed Möbius transform (2.7).

Conversely, if \(R\in E_0(K)\) satisfies \(\sigma(R)=-R\), set
\(P_0=R+H\).  Then \(\sigma(P_0)=Q-P_0=\iota(P_0)\).  Writing
\(U=X(P_0)/2\) and \(y=Y(P_0)/(2U)\), one obtains

\[
 \sigma(U)=U^{-1},\qquad \sigma(y)=y,
\]

and the curve equation gives \(y^2=2(U+U^{-1})+5\).  Imposing
\(U=\epsilon^p\) recovers (0.1).  Thus the reconstruction is reversible;
the Kummer condition must not be discarded.

## 3. The split rational branch is already impossible

For rational \(T>1\), it is possible that \(T^2-1\) is a rational square.
Then \(\epsilon\in\mathbf Q\), so (1.6) would give

\[
 P_0=(2\epsilon^p,2y\epsilon^p)\in E_0(\mathbf Q),
 \qquad X(P_0)=2\epsilon^p>2.                              \tag{3.1}
\]

But \(E_0\) is carried by \(x=X+2\) to the minimal curve

\[
 y^2=x^3-x^2-4x+4,                                        \tag{3.2}
\]

the curve 24.a4 (Cremona 24a1).  Its exact Mordell--Weil group is
\(\mathbf Z/2\mathbf Z\oplus\mathbf Z/4\mathbf Z\), of rank zero.  In the
\(E_0\) coordinates its eight rational points have

\[
 X\in\{-4,-2,-1,0,2\}\quad\text{or are }O.                \tag{3.3}
\]

This contradicts (3.1).  Hence:

> **Split-branch lemma.** For every odd \(p\), equation (0.1) has no rational
> solution \(T>1\) for which \(T^2-1\) is a rational square.

The rank and torsion data, the minimal model, modular degree one, and the
identification as a model of \(X_0(24)\) are recorded in the
[LMFDB entry 24.a4](https://www.lmfdb.org/EllipticCurve/Q/24/a/4).
No BSD assertion is used: the Mordell--Weil rank shown there is the exact
algebraic rank, obtainable by descent.

For integral \(T>1\), the split branch never arises because
\((T-1)^2<T^2-1<T^2\).

## 4. Exact four-consecutive specialization

In the Pell branch of the repository, write the four consecutive integers as

\[
 b=Aa^2,\qquad b+1=Bv^2,\qquad b+2=3r^2,\qquad b+3=s^2,    \tag{4.1}
\]

where \(A,B\) are positive squarefree, coprime, and \(3\nmid AB\).  Put

\[
 D=3AB,\qquad y=2b+3.                                    \tag{4.2}
\]

From (2.7),

\[
 X_R=-2\frac{b+2}{b+1}.                                   \tag{4.3}
\]

For a general \(y\), set \(X=-2(y+1)/(y-1)\).  A direct factorization gives

\[
 X(X+1)(X+4)
 =\frac{4(y+1)(y+3)(y-3)}{(y-1)^3}.                       \tag{4.4}
\]

The four identities (4.1) turn (4.4) into

\[
\frac{X_R(X_R+1)(X_R+4)}{D}
 =\left(\frac{2ars}{B^2v^3}\right)^2.                    \tag{4.5}
\]

The sign is fixed by the addition law, not merely by taking a square root.
Writing \(Z=b^2+3b+1\) and \(u=Z+avrs\sqrt D\), so that
\(Z+1=3B(vr)^2\), one has

\[
 Y(R)=2\frac{y+1}{y-1}\frac{u-1}{u+1},\qquad
 \frac{u-1}{u+1}
 =\frac{avrs\sqrt D}{Z+1}
 =\frac{as\sqrt D}{3Bvr}.
\]

Since \((y+1)/(y-1)=(b+2)/(b+1)=3r^2/(Bv^2)\), this gives

\[
 Y(R)=\sqrt D\,\frac{2ars}{B^2v^3}.
\]

Therefore the putative Chebyshev solution supplies the explicit rational
twist point

\[
 \boxed{
  \left(X_R,W_R\right)
  =\left(-2\frac{b+2}{b+1},\frac{2ars}{B^2v^3}\right)
  \in E_0^{(3AB)}(\mathbf Q).}                            \tag{4.6}
\]

On the actual residue branch \(b\equiv22\pmod {24}\), one has
\(D\equiv6\pmod8\).  Equation (4.6) is stronger than merely exhibiting an
unspecified rational point on a moving twist: its abscissa lies just to the
left of `-2`;
indeed \(b\equiv22\pmod {24}\) gives \(X_R\in[-48/23,-2)\).  It has the
displayed four-consecutive factorization, and after translation by \(H\) the
modular-unit coordinate must be the \(p\)-th power of the positive fundamental
norm-one unit.

## 5. The prime-index curve is a Kummer cover of the fixed elliptic curve

Let \(p=2g+1\).  Pull back \(E\) by \(U=x^p\) and normalize.  An affine model
is

\[
 \widetilde C_p:\quad
 W^2=x(2x^p+1)(x^p+2),                                    \tag{5.1}
\]

with degree-\(p\) map

\[
 (x,W)\longmapsto
 (U,V)=\left(x^p,W x^g\right)\in E.                       \tag{5.2}
\]

Indeed \(V^2=x^{p-1}W^2=U(2U+1)(U+2)\).  A solution of
(0.1) lifts to

\[
 x=\epsilon,\qquad W=y\epsilon^{g+1}.                     \tag{5.3}
\]

The involution

\[
 j(x,W)=\left(x^{-1},W/x^{p+1}\right)                    \tag{5.4}
\]

has invariant functions

\[
 T=\frac{x+x^{-1}}2,\qquad y=\frac{W}{x^{g+1}}.          \tag{5.5}
\]

Their equation is exactly (0.1).  Hence the genus-\(g\) Chebyshev curve is
the quotient \(\widetilde C_p/\langle j\rangle\).

This also places the construction precisely in the family of
[Tautz--Top--Verberkmoes](https://pure.rug.nl/ws/portalfiles/portal/1054394337/explicit-hyperelliptic-curves-with-real-multiplication-and-permutation-polynomials.pdf).
Their cover is
\(w^2=x(x^{2p}+t x^p+1)\); (5.1) is its constant quadratic twist by \(2\)
at \(t=5/2\).  Their theorem supplies real multiplication on the quotient
Jacobian.  It does not classify rational points, bound the Mordell--Weil rank,
or give a uniform exclusion as \(p\) varies.

## 6. The exact modular unit on \(X_0(24)\)

The translation \(x=X+2\) identifies (1.5) with the minimal model (3.2).
The modular parametrization of degree one is normalized by
\(\varphi(\infty)=O\).  The explicit cusp table in Section 8.2 of
[Asakura--Chida, with an appendix by Brunault (2023)](https://eprints.lib.hokudai.ac.jp/repo/huscap/all/91491/Perrin-Riou-conj-v1.pdf)
gives

\[
 \varphi(1/12)=(2,0)\quad\text{on (3.2)}.                 \tag{6.1}
\]

Thus on (1.5),

\[
 O=\varphi(\infty),\qquad Q=(0,0)=\varphi(1/12).          \tag{6.2}
\]

The function \(X\) has a double zero at the two-torsion point \(Q\) and a
double pole at \(O\).  Therefore the exact function used above,

\[
 U=X/2,                                                    \tag{6.3}
\]

has divisor

\[
 \boxed{\operatorname{div}(U)=2[1/12]-2[\infty].}         \tag{6.4}
\]

Both support points are cusps, so \(U\) is a modular unit on \(X_0(24)\).
This conclusion uses the specific normalized modular parametrization and
cusp table; it is not inferred merely from an abstract isomorphism of elliptic
curves.  The general structure theorem of
[Wang--Yang (2020)](https://arxiv.org/abs/2007.06777) also implies that this
unit can be represented by their shifted eta products, but no eta-product
formula is needed for (6.4).

Because the valuations \(2,-2\) are prime to every odd \(p\), the Kummer
cover

\[
 z^p=U                                                       \tag{6.5}
\]

is connected and totally ramified exactly over \(1/12\) and \(\infty\).
Riemann--Hurwitz over the genus-one base gives

\[
 2g(\widetilde C_p)-2=2(p-1),\qquad g(\widetilde C_p)=p,   \tag{6.6}
\]

in agreement with (5.1).

## 7. The Kummer cover is noncongruence for every prime \(p\ge5\)

Over the open modular curve, (6.5) gives a normal index-\(p\) character
subgroup

\[
 \Gamma_p=\ker\!\left(\chi_p:\overline{\Gamma_0(24)}
                   \longrightarrow\mathbf Z/p\mathbf Z\right). \tag{7.1}
\]

Here bars mean passage to \(\mathrm{PSL}_2\).  This subgroup is not a
congruence subgroup.

The base cusp widths, in the order

\[
 \infty,0,1/2,1/3,1/4,1/6,1/8,1/12,
\]

are

\[
 1,24,6,8,3,2,3,1.                                       \tag{7.2}
\]

The Kummer monodromy is nontrivial only at \(\infty\) and \(1/12\), where
it is respectively \(-2\) and \(2\) modulo \(p\).  Their widths therefore
become \(p\); the other widths stay unchanged.  The Wohlfahrt level of
\(\Gamma_p\) is consequently

\[
 \operatorname{lcm}(p,24,6,8,3,2,3,p)=24p.               \tag{7.3}
\]

Suppose \(\Gamma_p\) were congruence.  Wohlfahrt's theorem would imply

\[
 \overline{\Gamma(24p)}\subseteq\Gamma_p.                 \tag{7.4}
\]

Thus \(\chi_p\) would factor through reduction modulo \(24p\).  By the
Chinese remainder theorem, the image of \(\Gamma_0(24)\) is

\[
 \bigl(B_0(24)\times\mathrm{SL}_2(\mathbf F_p)\bigr)
   /\langle(-I,-I)\rangle,                                \tag{7.5}
\]

where

\[
 B_0(24)=\left\{
 \begin{pmatrix}a&b\\0&d\end{pmatrix}
 \in\mathrm{SL}_2(\mathbf Z/24\mathbf Z)\right\}.
\]

Now \(|B_0(24)|=24\varphi(24)=192\), so it has no quotient of order
\(p\ge5\), and \(\mathrm{SL}_2(\mathbf F_p)\) is perfect for \(p\ge5\).
Therefore (7.5) has no quotient \(\mathbf Z/p\mathbf Z\), contradicting
(7.1).  We have proved:

> **Noncongruence lemma.** For every prime \(p\ge5\), the connected cyclic
> cover of \(X_0(24)\) defined by \(z^p=U\), with
> \(\operatorname{div}(U)=2[1/12]-2[\infty]\), is a noncongruence modular
> curve.

The only external group-theoretic input is the classical Fricke--Wohlfahrt
theorem identifying the congruence level with the least common multiple of
cusp widths.  A statement and proof are reproduced as Theorem 9 in these
[TIFR lectures on modular functions](https://mathweb.tifr.res.in/sites/default/files/publications/ln/tifr29.pdf);
the original reference is K. Wohlfahrt, *Illinois J. Math.* **8** (1964),
529--535.  The remaining finite-group argument is elementary.

This lemma is a useful negative result: one cannot identify (5.1) with a
standard congruence modular curve and then invoke a congruence-level
classification of low-degree points.

## 8. Quantifier audit of accepted and recent results

### 8.1 Uniform rational points

[Dimitrov--Gao--Habegger (Annals, 2021)](https://annals.math.princeton.edu/2021/194-1/p04)
bounds the number of points on a genus-\(g\) curve over a degree-\(d\)
number field in terms of \(g,d\), and the Mordell--Weil rank of its Jacobian.
For the curves in (0.1), \(g=(p-1)/2\) varies and no uniform rank bound is
known.  More importantly, a bound on the number of points does not show that
the known points exhaust the curve.

[Lemos--Torzewski (2022/2023)](https://arxiv.org/abs/2201.11077) gives a
uniform bound for curves of fixed genus over a fixed number field with good
reduction outside a fixed finite set \(S\).  Here the genus varies with \(p\),
and the Kummer cover acquires bad reduction at the varying prime \(p\).
Its quantifiers therefore do not yield an exclusion.

On the fixed elliptic base, allowing the quadratic field to vary does not by
itself produce a finite set: for every rational \(X\), adjoining
\(\sqrt{X(X+1)(X+4)}\) gives a quadratic point.  The arithmetic content is the
additional condition that the translated modular-unit coordinate is the
\(p\)-th power of the fundamental norm-one unit.

### 8.2 Perfect powers in elliptic divisibility sequences

[Nowroozi--Siksek (BLMS, 2024)](https://arxiv.org/abs/2312.08997) fixes an
elliptic curve \(E/\mathbf Q\) and a fixed nonintegral point
\(P\in E(\mathbf Q)\), then studies perfect powers among denominators of the
multiples \(nP\).  In the present problem the point lies over the moving field
\(\mathbf Q(\sqrt D)\), varies with \(T\), and the perfect power is the value
of the function \(U\) itself, not a denominator in one fixed EDS.  The theorem
does not specialize to (1.8).

### 8.3 Generalized Fermat modular methods

The 2026 preprint of
[Cazorla García--Koutsianas--Villagra-Torcomian](https://arxiv.org/abs/2605.02632)
develops Frey hyperelliptic representations for
\(Ax^2+By^r=Cz^p\).  In Section 3 it explicitly begins with fixed nonzero
integers \(A,B\); the fixed prime \(r\) controls the real multiplication,
while \(p\) is the variable exponent.  Our four-consecutive cores \(A,B\),
the quadratic field \(\mathbf Q(\sqrt{3AB})\), and the relevant algebraic
point all move, and (1.8) is not an integer generalized-Fermat equation of
their stated form.  Their construction is a promising template for a future
Frey representation, but it is not presently a theorem covering this family.

### 8.4 Chebyshev Jacobians and real multiplication

Tautz--Top--Verberkmoes supplies the geometric real multiplication explained
in Section 5.  The 2025 preprint
[Tafazolian--Top](https://arxiv.org/abs/2509.00273) studies maximality, complex
multiplication, Frobenius slopes, and 2-descent for Chebyshev curves over
finite fields.  It does not classify rational points on the shifted curve
\(y^2=4\mathcal T_p(T)+5\) over \(\mathbf Q\).  Real multiplication alone
does not give the needed Mordell--Weil rank inequality or a uniform Chabauty
annihilator.

### 8.5 Modular units and roots

Wang--Yang classifies modular units at levels including \(24\), but does not
classify rational or quadratic points on their prime-degree root covers.
The exact root cover here is noncongruence by Section 7.  Thus congruence
modular-curve torsion/isogeny classifications do not apply.

No accepted theorem found in this audit guarantees, for every index of an
integer Lucas sequence, a primitive prime divisor in a separately prescribed
quadratic-character class.  Existence or density results with the recurrence
fixed do not supply that per-index Frobenius prescription, and so they do not
repair the already-recorded primitive-divisor obstruction.

## 9. Exact residual after the reconstruction

For the four-consecutive branch, the unresolved statement can now be posed on
one fixed base.

> **Twisted modular-unit prime-power residual.** Let \(A,B\) be positive,
> coprime, squarefree integers with \(3\nmid AB\) and \(D=3AB\equiv6\pmod8\).
> Suppose (4.1) holds with \(b\equiv22\pmod {24}\), and let the point
> \(R\in E_0^{(D)}(\mathbf Q)\) be (4.6).  Translate its corresponding
> anti-invariant point by \(H=(-2,-2)\).  Prove that the resulting modular-unit
> value \(U\) cannot equal \(\epsilon^p\), where \(\epsilon\) is the positive
> fundamental norm-one unit of \(\mathbf Q(\sqrt D)\) and \(p\ge23\) is prime.

This residual is equivalent to the original four-consecutive Chebyshev
problem once the existing Pell identities are included; it is not claimed as
an established theorem.  It isolates three possible next attacks:

1. construct a Frey representation for the prime-power value of the fixed
   modular unit while controlling the moving quadratic twist;
2. prove a uniform height gap between the explicit twist point (4.6) and the
   translated fundamental-unit Kummer orbit;
3. use the noncongruence character and its explicit two-cusp ramification to
   derive a uniform obstruction unavailable from ordinary congruence modular
   curves.

The fixed-base reconstruction is materially sharper than the earlier moving
high-genus formulation, but none of these three final inputs is supplied by an
accepted theorem at present.

## 10. Lean boundary

The companion Lean module proves, over \(\mathbf Q\), the following scalar
claims:

* the embeddings (1.7) and the scaling to (1.5);
* preservation of (1.5) by (2.1);
* both chord-coordinate identities establishing the scalar formula behind
  \(\iota(P)=Q-P\);
* membership of \(H\), its tangent slope, and the scalar doubling coordinates;
* the translated abscissa (2.7);
* the cubic factorization (4.4) and four-consecutive square identity (4.5);
* the coordinate form of conjugation on (1.6).

It does not formalize elliptic-curve group schemes, the modular
parametrization, the cusp divisor, Riemann--Hurwitz, Wohlfahrt's theorem,
perfectness of finite special linear groups, quadratic-twist descent,
Mordell--Weil computations, or any literature theorem.  Accordingly, its
kernel proof is an audit of the algebraic interface and introduces no hidden
uniform rational-point assertion.
