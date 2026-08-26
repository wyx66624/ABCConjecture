# Same-character rank-two twists: exact carrier and height-lattice audits

## Abstract

Let

\[
 E_{a,b}:y^2=f_{a,b}(x):=x(x-a)(x+b),\qquad a,b>0,
 \qquad a+b=c.
\]

Two rational abscissas lie in the same quadratic-character space exactly
when their cubic values have the same square class.  This is not merely a
square-class problem: it is the problem of finding two rational points on one
quadratic twist, and independence is a Mordell--Weil condition.

This note gives two exact audits.

First, the Rubin--Silverberg rank-two construction for a curve with rational
two-torsion specializes on the Frey coefficients to

\[
 D_v=(b-a)(1+v^2)(a+bv^2)(b+av^2).
\]

The two points are generically independent and have canonical-height Gram
matrix \(I_2\) over \(\mathbf Q(v)\).  At \(v=\pm1\), the carrier drops to
the square class of \(2(b-a)\), but the two points simultaneously collapse to
\(P=\pm Q\).  Away from this collision, a fixed rational \(v=p/q\) gives a
raw integral carrier of source-height order at most \(c^3\), not a uniform
linear carrier.  The exact factorization therefore exhibits a genuine
carrier-versus-rank tradeoff; it does not prove a lower bound for the
squarefree kernel.

Second, there is a strict infinite Pell family on which two independent
points do share the fixed twist \(D=6\).  On this family the elliptic-surface
calculation gives the exact canonical-height Gram matrix \(I_2\).  After
specialization the normalized Gram matrices converge to \(I_2\), so **every**
nonzero integral linear combination, even with coefficients chosen after
seeing the specialization, has asymptotic height at least

\[
 \left(\frac14-o(1)\right)\log b.
\]

At every odd bad prime outside \(6\), both generators are in the Neron
identity component.  Since that component is a subgroup, every integral
combination which is nonzero on the specialized curve retains the full
component baseline.  Thus rank two by itself
does not create global cancellation, even when the common twist and its field
discriminant are constant.

The result is deliberately limited.  It does not rule out a different
adaptive rank-two correspondence whose specialized height lattice becomes
nearly singular while its local component data stay favorable.

## 1. Quantifiers: what the universal rank results do and do not say

For a fixed elliptic curve \(E/\mathbf Q\), Mestre constructed (when
\(j(E)\ne0,1728\)) a degree-fourteen polynomial \(g(u)\) for which the twist
\(E_{g(u)}\) has function-field rank at least two.  Stewart--Top used this to
count infinitely many rank-at-least-two quadratic twists of that **fixed**
curve.  Their constants and the threshold from which the count applies depend
on \(E\).  Consequently this theorem cannot be read as follows:

> for every varying Frey curve \(E_{a,b}\), there is a rank-two twist of
> uniformly bounded height relative to \(c=a+b\).

Nor does the count control the Neron--Tate regulator or prescribe the
components met at primes dividing \(abc\).

Rubin--Silverberg give a more explicit construction.  In their convention
\(E_D\) is

\[
 D y^2=x^3+A x^2+B x.
\]

For \(AB(A^2-4B)\ne0\), Corollary 3.3 gives the degree-six twist polynomial

\[
 g(u)=-AB(u^2+B^2)
 \bigl(u^4+2B^2u^2-A^2Bu^2+B^4\bigr)                       \tag{1.1}
\]

and two independent points over \(\mathbf Q(u)\).  For each fixed curve,
specialization is injective outside a finite set.  The exceptional set is not
uniform as the curve varies, so this still does not supply a bounded-height
specialization for every Frey input.

The distinction is essential throughout this note:

* **function-field rank two** means independence before specializing the
  auxiliary parameter;
* **rank two for each input** requires a specialization theorem with uniform
  height and exceptional-set control;
* **useful rank two for the abc ledger** additionally requires a controlled
  twist carrier, a small eigenvalue of the height Gram matrix, and favorable
  local components.

No average-rank or twist-counting result supplies the latter two conclusions.

## 2. Direct square-ratio geometry

Suppose \(j_1,j_2\in\mathbf Q\) and neither cubic value is zero.  The condition

\[
 \frac{f_{a,b}(j_1)}{f_{a,b}(j_2)}\in\mathbf Q^{\times2}   \tag{2.1}
\]

is equivalent to the existence of a square class \(D\) and rational
\(w_1,w_2\) such that

\[
 f_{a,b}(j_i)=D w_i^2\qquad(i=1,2).                       \tag{2.2}
\]

Thus \((j_i,w_i)\) are points on the same twist

\[
 E^{D}_{a,b}:D y^2=f_{a,b}(x).                            \tag{2.3}
\]

Conversely, two points on (2.3) give (2.1).  Asking for a second independent
point is therefore exactly a rank problem on (2.3); rewriting it as a
square-ratio equation does not remove the Mordell--Weil difficulty.

Multiples of one point automatically give further solutions of (2.1), but
they give only a rank-one lattice.  A small multiple relation then belongs to
the division-point problem, not to genuine two-direction cancellation.

## 3. Exact Rubin--Silverberg specialization on the Frey cubic

Assume \(a\ne b\), put

\[
 A=b-a,\qquad B=-ab,
\]

and set \(u=Bv\).  Define

\[
 \begin{aligned}
 t_v&=\frac{ab(1+v^2)}{b-a},&
 h_v&=\frac{t_v}{v^2},\\
 D_v&=(b-a)(1+v^2)(a+bv^2)(b+av^2),&
 w&=\frac{ab}{(b-a)^2}.
 \end{aligned}                                             \tag{3.1}
\]

Direct multiplication gives

\[
 \boxed{
 f_{a,b}(t_v)=D_v w^2,\qquad
 f_{a,b}(h_v)=D_v\left(\frac{w}{v^3}\right)^2.}            \tag{3.2}
\]

Hence

\[
 P_v=(t_v,w),\qquad Q_v=(h_v,w/v^3)                        \tag{3.3}
\]

are rational points on \(D_vy^2=f_{a,b}(x)\).  In particular

\[
 \frac{f_{a,b}(h_v)}{f_{a,b}(t_v)}=v^{-6}.                 \tag{3.4}
\]

The coefficient identity behind (3.2) is

\[
 (b-a)^2v^2-(-ab)(1+v^2)^2
   =(a+bv^2)(b+av^2).                                      \tag{3.5}
\]

Substitution in (1.1) gives the stronger exact equality

\[
 \boxed{g(Bv)=B^6D_v.}                                    \tag{3.6}
\]

Thus (3.1)--(3.3) are precisely the Frey specialization of the
Rubin--Silverberg construction, with the irrelevant sixth-power factor
removed.

### 3.1 Exact function-field height Gram matrix

Fix \(a,b\) satisfying the nonsingularity and nonzero-denominator
conditions, and regard (2.3) with \(D=D_v\) as a curve over
\(\mathbf Q(v)\).  Its multiplication Lattes map on the \(x\)-line is the
same as that of the constant curve \(y^2=f_{a,b}(x)\).  The rational map
\(v\mapsto t_v\) has degree two.  Since the \(x\)-coordinate map of
\([n]\) has degree \(n^2\),

\[
 \deg_v x([n]P_v)=2n^2.
\]

With the convention

\[
 \widehat h(P)=\frac12\lim_{n\to\infty}
       \frac{\deg x([n]P)}{n^2},                            \tag{3.7}
\]

this proves \(\widehat h(P_v)=1\).  The base involution \(v\mapsto1/v\),
together with the square identification
\(D_{1/v}=D_v/v^6\), exchanges \(P_v\) and \(Q_v\), so
\(\widehat h(Q_v)=1\).

The involution \(v\mapsto-v\) fixes \(P_v\) and sends \(Q_v\) to
\(-Q_v\).  Invariance of the canonical pairing therefore gives

\[
 \langle P_v,Q_v\rangle
 =\langle P_v,-Q_v\rangle
 =-\langle P_v,Q_v\rangle=0.                               \tag{3.8}
\]

Consequently the exact function-field Gram matrix is

\[
 \boxed{
 G_{\rm RS}=\begin{pmatrix}1&0\\0&1\end{pmatrix},\qquad
 \widehat h(mP_v+nQ_v)=m^2+n^2.}                           \tag{3.9}
\]

This proves independence and shows that the universal rank-two construction
has no generic integral height cancellation.

### 3.2 The cheap carrier is exactly the rank-collision locus

At \(v=1\),

\[
 D_1=2(b-a)(a+b)^2\sim 2(b-a),\qquad P_1=Q_1.             \tag{3.10}
\]

At \(v=-1\), the same carrier identity holds and \(P_{-1}=-Q_{-1}\).
Thus the coefficient-independent specialization which makes the two large
linear carrier factors into a square simultaneously destroys rank two.
Indeed, as a binary quadratic form in \(a,b\), their product has middle
coefficient \(v^4+1\) and diagonal coefficient \(v^2\); the square condition
is

\[
 (v^4+1)^2-4v^4=(v^4-1)^2=0.
\]

For rational nonzero \(v\), this forces \(v=\pm1\).

For \(v=p/q\) with coprime nonzero integers \(p,q\), clearing the square
denominator \(q^6\) gives the integral carrier

\[
 \boxed{
 D_{p,q}=(b-a)(p^2+q^2)
 (q^2a+p^2b)(q^2b+p^2a).}                                 \tag{3.11}
\]

If \(|p|,|q|\le H\), then

\[
 |D_{p,q}|\le 8H^6c^3.                                    \tag{3.12}
\]

If \(d_{p,q}\) is the signed squarefree representative, then

\[
 |\operatorname{Disc}\mathbf Q(\sqrt{d_{p,q}})|
 \le4|d_{p,q}|\le32H^6c^3.                                \tag{3.13}
\]

The squarefree twist parameter divides the square class represented by
(3.11), so (3.12)--(3.13) are only upper bounds.  There may be input-dependent
square cancellation, and no lower bound for the squarefree kernel is claimed.
What is rigorous is the following tradeoff:

* the universal noncollision carrier has the displayed cubic source-height
  bound;
* the diagonal specialization \(p=\pm q\) reduces it to a linear square
  class but forces \(P=\pm Q\);
* choosing an unbounded \(H\) to escape a curve-dependent specialization
  exceptional set adds \(6\log H\) to the carrier-height budget.

At primes not already bad for \(E_{a,b}\), a squarefree prime of the twist
parameter generally also creates new conductor; the new bad-prime support is
contained in the primes dividing \(2\Delta(E_{a,b})d_{p,q}\).  Hence neither
Mestre's degree-fourteen family nor (3.11), by itself, gives a subcritical
conductor budget uniform in the varying Frey input.

## 4. A fixed-twist Pell family with two independent points

The previous section leaves open the possibility that a special arithmetic
family has both a small common twist and genuine rank two.  Such a family
does exist, but its height lattice is rigid.

Let

\[
 s^2-3r^2=1,\qquad b=3r^2-2,\qquad c=b+1=3r^2-1.          \tag{4.1}
\]

Then

\[
 f_{1,b}(2)=6r^2,\qquad f_{1,b}(3)=6s^2.                  \tag{4.2}
\]

Thus the fixed \(6\)-twist

\[
 \mathcal E_b:Y^2=X(X-6)(X+6b)                            \tag{4.3}
\]

has two rational points

\[
 \mathcal P=(12,36r),\qquad \mathcal Q=(18,36s).         \tag{4.4}
\]

On the original curve these points are defined over the single constant field
\(\mathbf Q(\sqrt6)\), whose discriminant is \(24\).  Equivalently, (4.3) is
the constant auxiliary twist \(D=6\); it introduces no varying bad-prime
support beyond the fixed primes \(2,3\).  Thus the obstruction below cannot be
attributed to a growing twist field or twist carrier.

There are infinitely many positive integral solutions of (4.1), generated by
\(s+r\sqrt3=(2+\sqrt3)^n\).  A convenient infinite subfamily is obtained
from

\[
 q^2-3p^2=1,\qquad
 r=2pq,\qquad s=q^2+3p^2.                                \tag{4.5}
\]

For this subfamily \(r\) is divisible by four, so \(v_2(b)=1\), while neither
\(b\) nor \(c\) is divisible by three.  The triples \((1,b,c)\) are primitive.

## 5. Exact elliptic-surface height pairing on the Pell family

Parametrize the Pell conic by

\[
 r=\frac{2u}{1-3u^2},\qquad
 s=\frac{1+3u^2}{1-3u^2},\qquad
 b=3r^2-2.                                                 \tag{5.1}
\]

We now regard (4.3) as an elliptic surface over \(\mathbf P^1_u\).  The
surface calculation is as follows.

1. Before base change, the surface
   \(y^2=x(x-1)(x+b)\) over the \(b\)-line has fibres \(I_2\) at
   \(b=0,-1\) and \(I_2^*\) at \(b=\infty\).
2. The map \(u\mapsto b(u)\) has degree four.  It is unramified over
   \(b=0,-1\), giving eight fibres of type \(I_2\).
3. It has two poles, \(u=\pm1/\sqrt3\), each of order two.  The ramified
   quadratic pullback and minimalization change each \(I_2^*\) into an
   \(I_4\) fibre.
4. Hence the complete configuration is

   \[
   8I_2+2I_4,\qquad 8\cdot2+2\cdot4=24,\qquad \chi=2.    \tag{5.2}
   \]

Both sections meet the identity component at all eight \(I_2\) fibres.  At
each \(I_4\) fibre, use a local parameter \(w\) at the pole and minimal
coordinates \(X_0=w^2X,\ Y_0=w^3Y\).  For each of \(\mathcal P,\mathcal Q\),
the two tangent coordinates at the node have order two.  Direct resolution
therefore places both sections on component \(2\).  The component table is

\[
\begin{array}{c|c|c|c}
\text{base locus}&\text{number and type}&\mathcal P&\mathcal Q\\ \hline
b=0&4I_2&0&0\\
b=-1&4I_2&0&0\\
u=\pm1/\sqrt3&2I_4&2&2.
\end{array}                                                \tag{5.3}
\]

The sections are disjoint from \(O\).  Since the diagonal correction of
component \(2\) in \(I_4\) is

\[
 \operatorname{contr}_{I_4}(2)=\frac{2(4-2)}4=1,           \tag{5.4}
\]

Shioda's formula gives

\[
 \langle\mathcal P,\mathcal P\rangle_{\rm Sh}
 =\langle\mathcal Q,\mathcal Q\rangle_{\rm Sh}
 =2\chi-2=2.                                               \tag{5.5}
\]

The base involution \(u\mapsto-u\) fixes the curve and \(\mathcal Q\), while
it sends \(\mathcal P\) to \(-\mathcal P\).  Therefore

\[
 \langle\mathcal P,\mathcal Q\rangle_{\rm Sh}=0.           \tag{5.6}
\]

The Shioda pairing is twice the standard function-field canonical pairing.
Consequently

\[
 \boxed{
 G_{\mathbf Q(u)}(\mathcal P,\mathcal Q)
 =\begin{pmatrix}1&0\\0&1\end{pmatrix}.}                 \tag{5.7}
\]

In particular, both points are non-torsion and independent.  This establishes
rank two directly; it is not inferred from an average-rank theorem.

As an algebraic check, on the original model over \(\mathbf Q(\sqrt6)\),

\[
 P=(2,r\sqrt6),\qquad Q=(3,s\sqrt6),
\]

and the addition formula gives

\[
 \begin{aligned}
 x(P+Q)&=21r^2+4-12rs,\\
 x(P-Q)&=21r^2+4+12rs.
 \end{aligned}                                             \tag{5.8}
\]

Iterated duplication has degree limits consistent with
\(\widehat h(P)=\widehat h(Q)=1\) and
\(\widehat h(P\pm Q)=2\).

## 6. Specialization: no adaptive integral cancellation

Let \(G(u_0)\) be the real Neron--Tate Gram matrix of the specialized points
at a rational value \(u_0\).  Tate's bounded-error variation theorem, applied
to the three fixed sections
\(\mathcal P,\mathcal Q,\mathcal P+\mathcal Q\), gives a constant \(C\),
depending only on this elliptic surface and these sections, such that

\[
 \boxed{G(u_0)=h(u_0)I_2+E(u_0),\qquad
        \lVert E(u_0)\rVert_{\rm op}\le C}                 \tag{6.1}
\]

for every smooth rational specialization.  Entrywise, the two diagonal
entries are \(h(u_0)+O(1)\), while the off-diagonal entry is \(O(1)\); the
operator-norm form in (6.1) follows because the matrix has fixed dimension
two.  This is a uniform matrix estimate, not merely two separate upper
bounds.  Hence

\[
 \boxed{\lambda_{\min}(G(u_0))\ge h(u_0)-C.}               \tag{6.2}
\]

For the integral subfamily (4.5), take \(u=p/q\).  Since \(p,q\) are coprime
and \(q^2-3p^2=1\),

\[
 h(u)=\log q,\qquad
 b=12p^2q^2-2,\qquad
 \log b=4h(u)+O(1).                                        \tag{6.3}
\]

Therefore, for **all** integer pairs \((m,n)\ne(0,0)\), including pairs which
depend on the specialization,

\[
\begin{aligned}
 \widehat h(m\mathcal P_{u}+n\mathcal Q_{u})
 &\ge (m^2+n^2)(h(u)-C)\\
 &\ge\left(\frac14-o(1)\right)\log b.                     \tag{6.4}
\end{aligned}
\]

Thus the specialized points are independent for all sufficiently large
members of this sequence, and no adaptive integral linear combination has a
below-\(1/4\) canonical-height slope.

## 7. Local component mass is retained by every combination

Let \(p\nmid6\) be a bad prime of (4.3).

* If \(p\mid b\), the colliding roots are \(0\) and \(-6b\).  The abscissas
  \(12,18\) reduce away from the node.
* If \(p\mid b+1\), the colliding roots are \(6\) and \(-6b\).  Again
  \(12,18\) reduce away from the node.

Thus \(\mathcal P,\mathcal Q\in\mathcal E_0(\mathbf Q_p)\).  Since
\(\mathcal E_0(\mathbf Q_p)\) is a subgroup,

\[
 m\mathcal P+n\mathcal Q\in\mathcal E_0(\mathbf Q_p)       \tag{7.1}
\]

for every \(m,n\in\mathbf Z\).  If \(e=v_p(b)\) or
\(e=v_p(b+1)\), the geometric fibre is \(I_{2e}\).  For a combination which
is nonzero on the specialized elliptic curve, the identity-component baseline
in the normalization used throughout the companion height audits is

\[
 \lambda_{p,\rm comp}(m\mathcal P+n\mathcal Q)
 =\frac e6\log p.                                          \tag{7.2}
\]

The Tate theta/formal-group term is **not** asserted to be constant under
linear combination.  When present it is an additional intersection term; it
does not alter the component/Bernoulli baseline (7.2).  The local statement
here concerns only that baseline.  Summing it on the subfamily (4.5) gives

\[
 \begin{aligned}
 \sum_{p\nmid6}\lambda_{p,\rm comp}
 &=\frac16\sum_{p\nmid6}
   \bigl(v_p(b)+v_p(b+1)\bigr)\log p\\
 &=\frac16\log\frac{b(b+1)}2
  =\frac13\log b+O(1).                                    \tag{7.3}
 \end{aligned}
\]

In particular, if one isolates the exponent-excess mass

\[
 W=\sum_{p\nmid6}(v_p(b(b+1))-1)_+\log p,
\]

every nonzero integral direction retains its full component contribution
\(W/6\).

For either generator separately, integral good-prime local terms vanish and
the places above \(2,3\) contribute only \(O(1)\).  Equations (6.3), (6.4),
and (7.3) recover the familiar leading ledger

\[
 \underbrace{\frac13\log b}_{\text{finite bad component mass}}
 +\underbrace{\left(-\frac1{12}\log b\right)}
       _{\text{archimedean term}}
 =\underbrace{\frac14\log b}_{\text{canonical height}}.   \tag{7.4}
\]

For a general combination there may be further nonnegative finite
intersection terms.  The assertion needed here is only the exact retained
component baseline (7.3).

## 8. What is closed, and what remains open

The calculations rigorously close the following proposed shortcut.

> Merely producing two independent points in one quadratic-character space,
> and then taking an arbitrary nonzero integral linear combination, does not
> force a small canonical-height direction.

It is closed in two strict senses.

1. The Rubin--Silverberg universal rank-two family has exact generic Gram
   matrix \(I_2\); its only coefficient-independent linear-carrier
   specialization is a rank collision.
2. The Pell family has constant twist \(D=6\), exact generic Gram matrix
   \(I_2\), specialized matrices converging to \(I_2\), and full retention of
   all bad-prime identity-component mass by every nonzero specialized
   integral combination.

The note does **not** prove any of the following stronger statements:

1. every rational specialization of the Rubin--Silverberg family has rank
   two;
2. the squarefree kernel of (3.11) is always of cubic size;
3. every conceivable rank-two twist family has a well-conditioned height
   lattice;
4. a carefully chosen input-dependent specialization cannot approach a
   rank-degeneration divisor at controlled conductor cost;
5. nonintegral division in the rank-two lattice cannot change the local
   Bernoulli distribution.

These are the precise surviving directions.  Any positive route must control
simultaneously the specialization exceptional set, the smallest eigenvalue of
the specialized height Gram matrix, the squarefree twist carrier and
conductor, and the local component vector.  Rank alone is insufficient.

## 9. Lean boundary

The companion module
`IUTThreeClosures/FreySameCharacterRankTwoObstruction.lean` formalizes only
the unconditional algebraic and scalar core:

1. the two same-square-class radicand identities (3.2)--(3.4);
2. the exact Rubin--Silverberg factorization (3.5)--(3.6);
3. collision and carrier identities (3.10)--(3.11);
4. the Pell radicand, twist-point, addition, and parametrization identities;
5. closure of an additive subgroup under integral combinations;
6. the elementary no-cancellation inequality for an explicitly supplied
   orthogonal Gram coefficient.

Lean does not assert the paper-only claims about function-field canonical
heights, the fibre configuration (5.2), component resolutions (5.3), Shioda's
formula, Call--Silverman/Tate specialization, Neron models, or local heights.
In particular the abstract Gram lemma is applied only after the genuine
surface calculation (5.2)--(5.7); it is not a substitute for that calculation.

## References

1. K. Rubin and A. Silverberg, *Rank Frequencies for Quadratic Twists of
   Elliptic Curves*, Experimental Mathematics **10** (2001), 559--569.
   <https://www.maths.tcd.ie/EMIS/journals/EM/expmath/volumes/10/10.4/Rubin.pdf>
2. C. L. Stewart and J. Top, *On Ranks of Twists of Elliptic Curves and
   Power-Free Values of Binary Forms*, J. Amer. Math. Soc. **8** (1995),
   943--973.
   <https://uwaterloo.ca/pure-mathematics/sites/default/files/uploads/documents/s0894-0347-1995-1290234-5_0.pdf>
3. J.-F. Mestre, *Rang de courbes elliptiques d'invariant donne*, C. R. Acad.
   Sci. Paris Ser. I Math. **314** (1992), 919--922.
4. T. Shioda, *On the Mordell--Weil lattices*, Comment. Math. Univ. St.
   Pauli **39** (1990), 211--240.
5. J. H. Silverman, *Heights and the specialization map for families of
   abelian varieties*, J. Reine Angew. Math. **342** (1983), 197--211.
6. J. Tate, *Variation of the canonical height of a point depending on a
   parameter*, Amer. J. Math. **105** (1983), 287--294.
