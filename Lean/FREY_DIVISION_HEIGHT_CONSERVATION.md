# Division points on the Frey family: a local--global conservation law

**Author: ChatGPT**

## Abstract

Let

\[
 E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c,
\]

and consider the quadratic selector point

\[
 P_j=(j,\sqrt{j(j-a)(j+b)}).
\]

Because canonical height satisfies
\(\widehat h(Q)=\widehat h(P_j)/m^2\) whenever \([m]Q=P_j\), division
points appear to offer a way around the positive height slope of bounded
abscissas.  We show that division alone does not improve the relevant
local/global ratio.

First, on the one-parameter family \(a=1\), choose
\(\alpha^2-\beta^2=1\), put \(j=\alpha^2\), and let
\(\gamma^2=b+j\).  An explicit half is

\[
 x(R)=j+\alpha\beta+(\alpha+\beta)\gamma,
 \qquad [2]R=P_j
\]

up to the harmless sign of \(P_j\).  Its rational elliptic surface has
four fibres of type \(I_2\), one fibre of type \(I_4\), and Mordell--Weil
height pairing \(1/4\).  Thus

\[
 \widehat h(R_b)=\frac1{16}\log b+O_{\alpha,\beta}(1).
\]

At every sufficiently large odd prime dividing either \(b\) or \(b+1\),
the quadratic half-field splits.  The two places above that rational prime
put the same global half on the identity and opposite components.  Their
degree-normalized local contribution is

\[
 \frac12\left(\frac{e_p}{6}-\frac{e_p}{12}\right)\log p
 =\frac{e_p}{24}\log p,
\]

exactly one quarter of the contribution of \(P_j\).

Second, one can kill this conjugate-place averaging by forcing the relevant
pair of square roots to be rational.  The natural adaptive choice

\[
 j=\frac{(a+1)^2}{4},\qquad
 j-a=\frac{(a-1)^2}{4}
\]

does produce a half which is on the identity component at every odd prime
dividing \(a\).  On the infinite family \((a,b,c)=(A,1,A+1)\), however,
the half is the section

\[
 Q=(z,z+1),\qquad a=z-z^{-1}-1,
\]

of a K3 elliptic surface with fibres \(4I_2+2I_2^*\).  Shioda's formula
gives function-field canonical height \(1/2\), and specialization at
\(A=\ell^{Nm}\) gives

\[
 \widehat h(Q_A)=\frac14\log A+O(1).
\]

The local gain from \(e_p/24\) back to \(e_p/6\) is therefore accompanied
by exactly the reciprocal factor four in global height.

Finally, the Bernoulli multiplication formula

\[
 \sum_{k=0}^{m-1}B_2\!\left(\frac{x+k}{m}\right)
 =\frac1m B_2(x)
\]

shows the same conservation law for arbitrary division.  Averaged over the
\(m^2\) division branches, the Tate component/Bernoulli depth term and the
global canonical height both scale by \(m^{-2}\).  This rules out **division
by itself** as an improvement of the branch-averaged retained-depth versus
canonical-height coefficient.  It does not rule out a branch-bias theorem
coupled to new global cancellation, several points in one character space,
or a different auxiliary motive.

## 1. The half-point formula

We begin with the elementary full-two-torsion identity.  For

\[
 E:y^2=(x-e_1)(x-e_2)(x-e_3)
\]

and \(P=(x_P,y_P)\), choose square roots

\[
 r_i^2=x_P-e_i,\qquad r_1r_2r_3=-y_P.
\]

Then a point \(R\) satisfying \([2]R=P\) is given by

\[
 \begin{aligned}
 x(R)&=x_P+r_1r_2+r_1r_3+r_2r_3,\\
 y(R)&=-(r_1+r_2)(r_1+r_3)(r_2+r_3).
 \end{aligned}
 \tag{1.1}
\]

The four choices modulo simultaneous sign change are the four points
\(R+T\), \(T\in E[2]\).

Now set \(a=1\), take rational numbers \(\alpha,\beta\) satisfying

\[
 \alpha^2-\beta^2=1,
 \tag{1.2}
\]

and put

\[
 j=\alpha^2,
 \qquad \gamma^2=b+\alpha^2.
 \tag{1.3}
\]

For \(P_j=(j,-\alpha\beta\gamma)\), formula (1.1) gives

\[
 \begin{aligned}
 x(R)&=\alpha^2+\alpha\beta+(\alpha+\beta)\gamma,\\
 y(R)&=-(\alpha+\beta)(\alpha+\gamma)(\beta+\gamma).
 \end{aligned}
 \tag{1.4}
\]

The verification does not require the elliptic-curve group law.  If
\(x=x(R)\), then

\[
 \begin{aligned}
 x&=(\alpha+\beta)(\alpha+\gamma),\\
 x-1&=(\alpha+\beta)(\beta+\gamma),\\
 x+b&=(\alpha+\gamma)(\beta+\gamma).
 \end{aligned}
 \tag{1.5}
\]

These identities prove the curve equation.  They also give

\[
 x^2+b
 =2\alpha(\alpha+\beta)(\alpha+\gamma)(\beta+\gamma),
 \tag{1.6}
\]

and hence

\[
 (x^2+b)^2=4\alpha^2x(x-1)(x+b).
 \tag{1.7}
\]

Since the Frey duplication formula at \(a=1\) is

\[
 x([2]R)=\frac{(x(R)^2+b)^2}
 {4x(R)(x(R)-1)(x(R)+b)},
 \tag{1.8}
\]

(1.7) proves \(x([2]R)=\alpha^2\).  Direct substitution into the tangent
formula gives the chosen ordinate of \(P_j\); changing its sign has no effect
on any height or component calculation below.

The half-field is only

\[
 K_b=\mathbf Q(\gamma)=\mathbf Q(\sqrt{b+j}).
\tag{1.9}
\]

Thus halving introduces no extension beyond the quadratic field already
needed for \(P_j\), because \(j(j-1)=\alpha^2\beta^2\) is a rational square.
Writing \(b+j=D_br_b^2\) with \(D_b\) signed squarefree gives

\[
 |\operatorname{Disc}K_b|\le 4|D_b|\le O_{\alpha,\beta}(b).
 \tag{1.10}
\]

At every odd good prime dividing \(D_b\), the corresponding rational
quadratic twist has conductor exponent two.  Hence halving adds no *second*
quadratic discriminant or twist conductor, but it also does not turn the
existing source-height cost into an \(o(\log b)\) cost.

## 2. Exact surface height of the half

Use \(\gamma\) as coordinate on the base, so

\[
 b=\gamma^2-\alpha^2.
 \tag{2.1}
\]

The base-changed elliptic surface is rational.  Away from the finite set of
constants excluded by \(\alpha\beta(\alpha+\beta)=0\), its singular fibres
are

\[
 \begin{array}{c|c|c}
 \text{base point}&\text{fibre}&\text{component met by }R\\ \hline
 \gamma=\alpha&I_2&0\\
 \gamma=-\alpha&I_2&1\\
 \gamma=\beta&I_2&0\\
 \gamma=-\beta&I_2&1\\
 \gamma=\infty&I_4&1\text{ or }3.
 \end{array}
 \tag{2.2}
\]

At the finite fibres this follows immediately from (1.5): one sign is a
smooth reduction and the conjugate sign is the double root.  At infinity,
doubling sends the component of \(R\) to component \(2\), the component met
by \(P_j\), so \(R\) meets component \(1\) or \(3\).

The surface has \(\chi=1\), and \((R\cdot O)=0\).  The Shioda corrections
are

\[
 2\cdot\frac12+\frac{1\cdot3}{4}=\frac74.
\]

Consequently

\[
 \langle R,R\rangle_{\rm Sh}
 =2-\frac74=\frac14,
 \qquad
 \widehat h_{\mathbf Q(\gamma)}(R)=\frac18.
 \tag{2.3}
\]

This also follows from the lattice discriminant.  The configuration
\(4I_2+I_4\) gives a trivial-lattice discriminant of absolute value
\(2^4\cdot4=64\).  A rational elliptic surface has unimodular
Neron--Severi lattice, and the full rational two-torsion has order four.
Shioda's discriminant formula therefore gives

\[
 \operatorname{disc}(\operatorname{MW}_{\rm free})
 =\frac{4^2}{64}=\frac14.
\]

Shioda--Tate gives rank one.  Thus \(R\) is a generator and the previously
constructed section \(P_j\), whose pairing is one, is twice a generator.

Tate's variation theorem now yields

\[
 \widehat h(R_b)
 =\frac18h(\gamma)+O_{\alpha,\beta}(1)
 =\frac1{16}\log b+O_{\alpha,\beta}(1),
 \tag{2.4}
\]

because \(h(\gamma)=\frac12\log|b+j|+O_{\alpha,\beta}(1)\).

## 3. Why the two conjugate places cannot be discarded

Let \(p\) be an odd prime outside the finite set determined by the
denominators and numerators of

\[
 2\alpha\beta(\alpha+\beta).
\]

Assume that \(K_b\) in (1.9) is genuinely quadratic.

If \(p\mid b\), then

\[
 \gamma^2\equiv\alpha^2\pmod p.
\]

Thus \(p\) splits in \(K_b\).  At its two places,
\(\gamma\equiv\alpha\) and \(\gamma\equiv-\alpha\), and (1.5) gives

\[
 x(R)\equiv2\alpha(\alpha+\beta),\quad 0\pmod p.
 \tag{3.1}
\]

The first is smooth and the second is the singular abscissa.

If \(p\mid c=b+1\), then

\[
 \gamma^2\equiv\alpha^2-1=\beta^2\pmod p.
\]

Again \(p\) splits, and the two reductions are

\[
 x(R)\equiv(\alpha+\beta)^2,\quad
 (\alpha+\beta)(\alpha-\beta)=1\pmod p.
 \tag{3.2}
\]

The second is the singular abscissa, while the first is smooth outside the
fixed exceptional set.

At a split multiplicative fibre of type \(I_{2e_p}\), an identity-component
point contributes

\[
 \frac{e_p}{6}\log p,
\]

whereas a point on the opposite component contributes

\[
 -\frac{e_p}{12}\log p.
\]

Both places have local degree one.  The normalized contribution of the
single global point \(R\) above the rational prime \(p\) is therefore

\[
 \boxed{
 \Lambda_p(R)=
 \frac12\left(\frac{e_p}{6}-\frac{e_p}{12}\right)\log p
 =\frac{e_p}{24}\log p.}
 \tag{3.3}
\]

Choosing a different one of the four halves only exchanges the two places.
It cannot remove the adverse place from the global height sum.

### 3.1 The numerical family

Take

\[
 \alpha=\frac54,\qquad \beta=\frac34,
 \qquad j=\frac{25}{16},
\]

and write

\[
 d^2=16b+25.
\]

Then

\[
 x(R)=\frac{5+d}{2},
 \qquad
 y(R)=-\frac{(5+d)(3+d)}8.
 \tag{3.4}
\]

At \(p\mid b\), the conjugate residues \(d=\pm5\) give \(x=5,0\).
At \(p\mid b+1\), the residues \(d=\pm3\) give \(x=4,1\).  This locates
the identity and opposite components without an abstract Galois argument.

For example, put

\[
 b_m=7^{4m},\qquad c_m=7^{4m}+1.
 \tag{3.5}
\]

Then \(16b_m+25\) lies strictly between
\((4\cdot7^{2m})^2\) and \((4\cdot7^{2m}+1)^2\) for all sufficiently
large \(m\), so the half-field is genuinely quadratic.  Moreover
\(c_m\) is divisible by neither \(3\) nor \(5\), and its two-adic valuation
is one.  Hence every odd bad prime is covered by (3.1) or (3.2), and

\[
 \sum_{v\nmid\infty}\lambda_v(R_m)
 =\frac1{24}\bigl(\log b_m+\log c_m\bigr)+O(1)
 =\frac1{12}\log c_m+O(1).
 \tag{3.6}
\]

Together with (2.4), this forces

\[
 \sum_{v\mid\infty}\lambda_v(R_m)
 =-\frac1{48}\log c_m+O(1).
 \tag{3.7}
\]

Equations (3.6)--(3.7) are exactly one quarter of the finite and
archimedean leading terms for \(P_j\).

## 4. Removing the conjugate split and the price of doing so

The splitting in Section 3 is not accidental.  At a prime \(p\mid a\)
where \(j\) and \(j-a\) are units, the ratio

\[
 \frac{j}{j-a}\equiv1\pmod{p^{e_p}}
\]

is a square in \(\mathbf Q_p\) for odd \(p\).  Hence the quadratic
subfield generated by \(\sqrt{j(j-a)}\) is locally split.  Unless this
squareclass is already trivial globally, the two primes above \(p\) carry
the two opposite half-component choices.  A natural way to make it globally
trivial is

\[
 j=\frac{(a+1)^2}{4},\qquad
 j-a=\frac{(a-1)^2}{4}.
 \tag{4.1}
\]

For \(b=1\), put

\[
 D=(a+1)^2+4,\qquad
 z=\frac{a+1+\sqrt D}{2}.
 \tag{4.2}
\]

Choosing opposite signs for the two rational square roots in (4.1), formula
(1.1) gives the small half

\[
 Q=(z,z+1).
 \tag{4.3}
\]

Indeed,

\[
 z^2-(a+1)z-1=0,\qquad
 a=z-z^{-1}-1,
 \tag{4.4}
\]

and therefore

\[
 (z+1)^2=z(z-a)(z+1).
\]

The duplication formula gives

\[
 x([2]Q)=\frac{(z^2+a)^2}{4z(z-a)(z+1)}
 =\frac{(a+1)^2}{4}=j.
 \tag{4.5}
\]

For every odd \(p\mid a\), equation (4.4) reduces to
\(z^2-z-1=0\).  In particular \(z\ne0\), so \(Q\) is on the identity
component at every place above \(p\).  The desired branch bias is real.

### 4.1 The K3 height calculation

Consider (4.3) over \(\mathbf Q(z)\).  The map

\[
 a=z-z^{-1}-1
\]

has degree two and is ramified only above smooth fibres.  The relatively
minimal elliptic surface has

\[
 4I_2+2I_2^*,\qquad \chi=2.
 \tag{4.6}
\]

More explicitly, the four \(I_2\)-fibres occur at

\[
 z^2-z-1=0,\qquad z=1,\qquad z=-1,
\]

and the two \(I_2^*\)-fibres occur at \(z=0,\infty\).

The section \(Q\) meets the identity component at both roots of
\(z^2-z-1\) and at \(z=1\).  At \(z=-1\) it meets the nonidentity
component, contributing \(1/2\).  Direct resolution of the two
\(I_2^*\)-fibres gives the following table.  With local parameter \(w=1/z\)
at infinity, use the minimal coordinates \(X=w^2x,Y=w^3y\); at zero use
\(X=z^2x,Y=z^3y\).

\[
\begin{array}{c|c|c|c}
 \text{place}&v(X)&v(Y)&\operatorname{contr}_v(Q)\\ \hline
 z=\infty&1&2&1\\
 z=0&3&3&3/2.
\end{array}
\tag{4.7}
\]

The values \(1,3/2,3/2\) are the three nonzero diagonal corrections for
the \(D_6\) root lattice of an \(I_2^*\)-fibre.  The section is disjoint
from \(O\).  Shioda's formula therefore gives

\[
 \begin{aligned}
 \langle Q,Q\rangle_{\rm Sh}
 &=2\chi+2(Q\cdot O)-
   \left(\frac12+1+\frac32\right)\\
 &=4-3=1.
 \end{aligned}
 \tag{4.8}
\]

Thus

\[
 \widehat h_{\mathbf Q(z)}(Q)=\frac12.
 \tag{4.9}
\]

For a positive integer \(A\), let \(z_A\) be the positive root in (4.2).
Its conjugate is \(-z_A^{-1}\), so its absolute logarithmic height is

\[
 h(z_A)=\frac12\log z_A
 =\frac12\log A+O(1).
 \tag{4.10}
\]

Tate variation and (4.9) give

\[
 \boxed{
 \widehat h_{E_{A,1}}(Q_A)
 =\frac14\log A+O(1).}
 \tag{4.11}
\]

Taking \(A_m=\ell^{Nm}\), with odd \(\ell\) and fixed positive \(N\),
produces an infinite primitive abc family with

\[
 \sum_{p\mid A_m}\Lambda_p(Q_A)
 =\frac16\log A_m,
 \qquad
 \widehat h(Q_A)=\frac14\log A_m+O(1).
 \tag{4.12}
\]

Thus removing the split-place average multiplies the selected local term by
four, from \(1/24\) to \(1/6\), but it also multiplies the global-height
slope by four, from \(1/16\) to \(1/4\).  The ratio is unchanged.

The field in (4.2) has degree two and discriminant at most
\(4((A+1)^2+4)\), so the degree remains bounded but its available absolute
discriminant bound is still of source-height size.  No sublinear conductor
or discriminant estimate follows from this alignment.

## 5. Arbitrary division and the Bernoulli distribution law

Let

\[
 B_2(x)=x^2-x+\frac16.
\]

For every integer \(m\ge1\), direct use of the sums of the first powers and
squares gives

\[
 \boxed{
 \sum_{k=0}^{m-1}B_2\!\left(\frac{x+k}{m}\right)
 =\frac1m B_2(x).}
 \tag{5.1}
\]

On a split Tate curve, the component parameters of the \(m^2\) points above
one point with parameter \(x\) are

\[
 \frac{x+k}{m},\qquad 0\le k<m,
\]

each with multiplicity \(m\); the second coordinate is the \(m\)-th root
of unity direction.  In the Bernoulli component-term normalization

\[
 \lambda_{\rm comp}(u)=\frac{v(\Delta)}2 B_2(u)\log N(v),
\]

(5.1) says

\[
 \sum_{[m]Q=P}\lambda_{\rm comp}(Q)
 =\lambda_{\rm comp}(P).
 \tag{5.2}
\]

Consequently the branch average is

\[
 \frac1{m^2}\lambda_{\rm comp}(P).
 \tag{5.3}
\]

For \(m=2\), \(P\) on the identity component of \(I_{2e}\), the four
branches consist of two component-zero points and two opposite-component
points:

\[
 \frac{2(e/6)+2(-e/12)}4=\frac e{24}.
 \tag{5.4}
\]

Globally every branch satisfies

\[
 \widehat h(Q)=\frac1{m^2}\widehat h(P).
 \tag{5.5}
\]

Thus (5.3) and (5.5) have the same scaling factor.  Any homogeneous linear
budget of the form

\[
 L(P)\le C\widehat h(P)
\]

is unchanged after branch averaging.  Iterating division cannot change its
critical coefficient.

## 6. Exact scope of the obstruction

The calculations prove the following negative statement.

> Starting from a bounded-abscissa quadratic selector, replacing the point by
> division points and using only branch averaging, Galois-normalized Bernoulli
> component terms, or the natural square-pair alignment cannot improve the
> coefficient relating retained Tate depth to canonical height.

The obstruction is strict in two complementary senses:

1. the family (3.5) realizes exact \(m^{-2}\) scaling through conjugate
   places for a genuinely quadratic half-field;
2. the growing family (4.12) removes the conjugate average but realizes the
   compensating height growth exactly.

It does **not** prove that every possible adaptive abscissa or every single
division branch has the averaged local distribution.  In particular it does
not exclude:

1. an arithmetic theorem forcing a favorable branch bias while separately
   controlling all adverse finite and archimedean places;
2. cancellation between several points in the same Galois-character space;
3. a non-homogeneous adelic functional not governed by (5.1);
4. an auxiliary motive with a different conductor/height normalization.

Those are the surviving directions.  What is eliminated is the tempting but
incorrect inference that the identity
\(\widehat h(P/m)=\widehat h(P)/m^2\) by itself supplies an abc gain.

## 7. Lean boundary

The companion module
`IUTThreeClosures/FreyDivisionHeightConservation.lean` checks:

1. the factorization (1.5), the curve equation, and the cross-multiplied
   duplication identity (1.7);
2. the numerical formulas (3.4) and the four conjugate reductions;
3. the adaptive square-pair identities (4.1), (4.3), and (4.5);
4. the general Bernoulli multiplication formula (5.1);
5. the half-branch ledger (5.4) and preservation of homogeneous linear
   budgets.

Lean does not formalize the elliptic-curve group law used to interpret a
cross-multiplied identity as division, quadratic splitting of rational
primes, Neron models, Tate local heights, Kodaira fibres, the K3 resolution,
Shioda's pairing, or Tate's specialization theorem.  Equations
(2.2)--(4.12) are explicit paper mathematics, not hidden structure fields.

## References

1. T. Shioda, *On the Mordell--Weil lattices*, Comment. Math. Univ. St.
   Pauli **39** (1990), 211--240.
2. J. Tate, *Variation of the canonical height of a point depending on a
   parameter*, Amer. J. Math. **105** (1983), 287--294,
   DOI 10.2307/2374389.
3. J. Tate, *Algorithm for determining the type of a singular fiber in an
   elliptic pencil*, Lecture Notes in Math. **476** (1975), 33--52.
4. J. H. Silverman, *Advanced Topics in the Arithmetic of Elliptic Curves*,
   Graduate Texts in Mathematics **151**, Springer, 1994, Chapters VI and
   IV.
