# Fixed abscissas on the Frey family: exact height slope and an archimedean obstruction

**Author: ChatGPT**

## Abstract

For

\[
 E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c,
\]

the bounded-abscissa selector uses points

\[
 P_j=(j,\sqrt{j(j-a)(j+b)})
\]

over fields of degree at most two.  This note computes the global cost of
these points on the one-parameter subfamily \((a,b,c)=(1,b,b+1)\).
The duplication formula is

\[
 x(2P_j)=\frac{(j^2+ab)^2}{4j(j-a)(j+b)}.
\]

After the quadratic base change

\[
 s^2=j(j-1)(t+j),
\]

the associated elliptic surface has four fibres of type \(I_2\), one fibre
of type \(I_4\), and the section \((j,s)\) meets the opposite component of
the \(I_4\)-fibre.  Shioda's formula gives height pairing one, or standard
function-field canonical height \(1/2\).  Tate's variation theorem then
gives the exact leading term

\[
 \widehat h_{E_{1,b}}(P_j)=\frac14\log b+O_j(1).
\]

For every fixed finite set of nontrivial integral abscissas, we construct an
infinite primitive family on which all the points lie in the identity
component at every odd bad prime.  On that family the normalized finite and
archimedean parts are respectively

\[
 \sum_{v\nmid\infty}\lambda_v(P_j)
   =\frac13\log b+O_J(1),\qquad
 \sum_{v\mid\infty}\lambda_v(P_j)
   =-\frac1{12}\log b+O_J(1).
\]

Thus the archimedean term cancels exactly one quarter of the positive
finite leading term, but a canonical-height slope \(1/4\) remains for the
points \(P_j\) themselves.  In particular no choice among a fixed finite
list of these points can have canonical height \(o(\log c)\), or even slope
strictly below \(1/4\).  This is a canonical-height obstruction, not merely
a conductor obstruction.  It does not extend to bounded-degree division
points: over a fixed constant extension \(P_j\) is twice another section,
an important surviving refinement recorded in Section 6.1.

## 1. The exact duplication formula

Write the equation as

\[
 y^2=x^3+(b-a)x^2-abx.
\]

For a point \(P=(x,y)\) with \(y\ne0\), the tangent slope is

\[
 m=\frac{3x^2+2(b-a)x-ab}{2y},
\]

and

\[
 x(2P)=m^2-(b-a)-2x.
\]

Substitution of \(y^2=x(x-a)(x+b)\) and a polynomial simplification give

\[
 \begin{aligned}
 &\bigl(3x^2+2(b-a)x-ab\bigr)^2\\
 &\quad-4x(x-a)(x+b)\bigl((b-a)+2x\bigr)
   =(x^2+ab)^2.
 \end{aligned}
 \tag{1.1}
\]

Consequently

\[
 \boxed{
 x(2P)=\frac{(x^2+ab)^2}{4x(x-a)(x+b)}.}
 \tag{1.2}
\]

For the selector point this rationalizes the doubled abscissa even when
\(P_j\) itself is defined only over a quadratic field:

\[
 x(2P_j)=\frac{(j^2+ab)^2}{4j(j-a)(j+b)}\in\mathbf Q.
 \tag{1.3}
\]

On \(a=1\), the numerator in (1.3) has size \(b^2\), while the denominator
has size \(b\).  This already warns that bounded \(x(P_j)\) is not a
bounded-height condition.  The elliptic-surface calculation below makes
the resulting canonical slope exact and avoids any uncontrolled
naive-to-canonical height comparison.

## 2. The quadratic twist and field discriminant

Put

\[
 d_j=j(j-a)(j+b)=D_jr_j^2,
\]

where \(D_j\) is signed squarefree.  Then

\[
 K_j=\mathbf Q(\sqrt{D_j}),\qquad
 P_j=(j,r_j\sqrt{D_j}).
\]

The exact field discriminant is

\[
 |\operatorname{Disc}K_j|=
 \begin{cases}
 |D_j|,&D_j\equiv1\pmod4,\\
 4|D_j|,&D_j\not\equiv1\pmod4.
 \end{cases}
 \tag{2.1}
\]

For fixed \(j\) on \(a=1\), this gives

\[
 |\operatorname{Disc}K_j|
 \le4|j(j-1)(j+b)|=O_j(b).
 \tag{2.2}
\]

There is also an exact rational twist model

\[
 E_{a,b}^{D_j}:Y^2=X(X-D_ja)(X+D_jb)
 \tag{2.3}
\]

with rational point

\[
 Q_j=(D_jj,D_j^2r_j).
 \tag{2.4}
\]

Indeed,

\[
 (D_j^2r_j)^2
 =(D_jj)(D_jj-D_ja)(D_jj+D_jb).
 \tag{2.5}
\]

The isomorphism over \(K_j\) preserves the global canonical height:

\[
 \widehat h_{E_{a,b}}(P_j)
 =\widehat h_{E_{a,b}^{D_j}}(Q_j).
 \tag{2.6}
\]

Equation (2.6) is important for bookkeeping.  The field discriminant and
the new twist conductor are genuine costs for a modular or
restriction-of-scalars argument, but they are not extra positive summands
that may simply be added to a canonical-height identity.  Conversely,
making \(D_j\) unusually small does not force (2.6) to be small.

## 3. Exact function-field height

Fix \(j\in\mathbf Z\setminus\{0,1\}\), put

\[
 \kappa=j(j-1),
\]

and consider

\[
 \mathcal E_t:y^2=x(x-1)(x+t)
 \tag{3.1}
\]

over \(\mathbf Q(t)\).  On the degree-two base curve

\[
 C_j:\quad s^2=\kappa(t+j),
 \tag{3.2}
\]

there is a section

\[
 \mathcal P_j=(j,s).
 \tag{3.3}
\]

The curve \(C_j\) is rational, with coordinate \(s\) and

\[
 t=\frac{s^2}{\kappa}-j.
 \tag{3.4}
\]

### 3.1 Singular fibres

The discriminant and \(c_4\) of (3.1) are

\[
 \Delta=16t^2(t+1)^2,
 \qquad
 c_4=16(t^2+t+1).
 \tag{3.5}
\]

Before base change the finite singular fibres at \(t=0,-1\) have type
\(I_2\).  The map (3.2) is unramified there because \(j\ne0,1\), so there
are two \(I_2\)-fibres over each value.

The map is ramified at \(t=\infty\).  Put \(u=1/s\) and make the integral
change

\[
 X=u^2x,\qquad Y=u^3y.
\]

Using (3.4), the equation becomes

\[
 Y^2=X(X-u^2)
 \left(X+\kappa^{-1}-ju^2\right).
 \tag{3.6}
\]

Its discriminant has \(u\)-adic order four and its \(c_4\) is a unit.
Thus the fibre at \(u=0\) has type \(I_4\).  There are no further singular
fibres.  The total discriminant degree is

\[
 4\cdot2+4=12,
\]

so the relatively minimal surface has arithmetic genus \(\chi=1\).

### 3.2 The component met by the section

In the chart (3.6), the section is

\[
 (X,Y)=(ju^2,u^2).
 \tag{3.7}
\]

Over an algebraic closure, tangent coordinates at the nodal point put the
surface singularity in the form

\[
 UV=\text{a unit}\cdot u^4.
\]

Along (3.7), both tangent coordinates have order two.  Indeed their leading
coefficients are proportional to

\[
 1\pm\frac{j}{\sqrt\kappa},
\]

and neither vanishes: equality \(j^2=\kappa=j(j-1)\) would force \(j=0\).
It follows from the standard resolution of \(UV=u^4\) that the section
meets component \(2\) of the \(I_4\)-fibre.  It meets no nonidentity
component at the four \(I_2\)-fibres.  The sections \(\mathcal P_j\) and
\(O\) are disjoint, so \((\mathcal P_j\cdot O)=0\).

For component \(i\) of an \(I_n\)-fibre, Shioda's correction is

\[
 \operatorname{contr}_{I_n}(i)=\frac{i(n-i)}n.
\]

Hence the only nonzero correction is

\[
 \operatorname{contr}_{I_4}(2)=1.
\]

Shioda's formula gives

\[
 \langle\mathcal P_j,\mathcal P_j\rangle_{\mathrm{Sh}}
 =2\chi+2(\mathcal P_j\cdot O)-1=1.
 \tag{3.8}
\]

With the standard convention

\[
 \widehat h(P)=\frac12
 \lim_{n\to\infty}\frac{h(x(nP))}{n^2},
\]

the Shioda self-pairing is twice the function-field canonical height.
Therefore

\[
 \boxed{\widehat h_{\mathbf Q(C_j)}(\mathcal P_j)=\frac12.}
 \tag{3.9}
\]

As a direct consistency check, (1.3) and (3.4) give

\[
 x(2\mathcal P_j)
 =\frac{(s^2+\kappa^2)^2}{4\kappa^2s^2},
 \tag{3.10}
\]

a degree-four rational map in the parameter \(s\), exactly as required by
the value \(\widehat h(\mathcal P_j)=1/2\) under the standard half-
\(x\)-height normalization.

In particular the generic section is non-torsion.

## 4. Specialization and the unavoidable slope \(1/4\)

For a positive integer \(b\) with a smooth fibre, choose

\[
 s_b^2=\kappa(b+j).
\]

The absolute logarithmic height satisfies

\[
 h(s_b)=\frac12\log|\kappa(b+j)|
       =\frac12\log b+O_j(1).
 \tag{4.1}
\]

Tate's variation theorem says that the specialized canonical height differs
by a bounded amount from a Weil height on the base whose degree is the
generic canonical height.  Combining this with (3.9) and (4.1) yields

\[
 \boxed{
 \widehat h_{E_{1,b}}(P_j)
 =\frac12h(s_b)+O_j(1)
 =\frac14\log b+O_j(1).}
 \tag{4.2}
\]

The bounded term in (4.2) is uniform in \(b\) for fixed \(j\).  The weaker
Call--Silverman specialization theorem would already give the same leading
coefficient with \(o(\log b)\), but Tate's elliptic-surface theorem gives
the bounded-error form used here.

Equation (4.2) is both an upper and a lower asymptotic.  It is therefore not
an artifact of a coarse height comparison.

## 5. A simultaneous infinite family and its local-height ledger

### Theorem 5.1

Let

\[
 J\subset\mathbf Z\setminus\{0,1\}
\]

be finite and nonempty.  There are an odd prime \(\ell\), an even positive
integer \(N\), and an infinite family

\[
 (a_m,b_m,c_m)=(1,\ell^{Nm},\ell^{Nm}+1)
 \tag{5.1}
\]

such that, for every sufficiently large \(m\) and every \(j\in J\):

1. \(P_{j,m}\) is non-torsion and is defined over a field of degree at most
   two;
2. \(P_{j,m}\) belongs to the identity component at every odd bad prime;
3. the odd exponent-excess mass satisfies

   \[
   E_m\ge\log c_m-O_J(1);
   \tag{5.2}
   \]

4. uniformly for \(j\in J\),

   \[
   \widehat h(P_{j,m})
   =\frac14\log c_m+O_J(1);
   \tag{5.3}
   \]

5. in the local-height normalization for which an identity-component point
   at a fibre \(I_{2e_p}\) contributes \(e_p\log p/6\),

   \[
   \sum_{v\nmid\infty}\lambda_v(P_{j,m})
      =\frac13\log c_m+O_J(1),
   \tag{5.4}
   \]

   \[
   \sum_{v\mid\infty}\lambda_v(P_{j,m})
      =-\frac1{12}\log c_m+O_J(1).
   \tag{5.5}
   \]

All sums are normalized by the degree of the field of definition.

#### Proof

Choose an odd prime

\[
 \ell\nmid\prod_{j\in J}j(j-1).
\]

Let \(S\) be the finite set of odd primes dividing some \(j-1\), and choose
\(N\) to be an even common multiple of the orders of \(\ell\) in
\(\mathbf F_p^\times\) for \(p\in S\).  Put \(b_m=\ell^{Nm}\).

The triple in (5.1) is primitive.  The prime \(\ell\) occurs in \(b_m\)
with exponent \(Nm\), so

\[
 E_m\ge(Nm-1)\log\ell
      =\log b_m-O_J(1)
      =\log c_m-O_J(1),
\]

which proves (5.2).

The only prime dividing \(b_m\) is \(\ell\), and \(\ell\nmid j\).  If an
odd prime \(p\mid b_m+1\) also divided \(j-1\), then \(p\in S\), whereas

\[
 b_m=\ell^{Nm}\equiv1\pmod p,
\]

contradicting \(p\mid b_m+1\).  Thus \(j\) avoids the singular residue at
every odd bad prime.  The point is in the Neron identity component there,
also after passing to its quadratic field of definition.

Because \(N\) is even and \(\ell\) is odd,

\[
 b_m\equiv1\pmod8,
 \qquad v_2(b_m+1)=1.
\]

In particular the displayed discriminant has fixed valuation
\(v_2(\Delta)=6\).  The standard nonarchimedean local-height formula, with
integral fixed abscissa \(j\) and extension degree at most two, consequently
bounds the two-adic local contribution uniformly in \(m\) for fixed
\(J\).  At every good finite prime the curve has good
reduction and \(x(P_{j,m})=j\) is integral, so the local height is zero.
At an odd bad prime, identity-component membership gives exactly
\(e_p\log p/6\).  Therefore

\[
 \begin{aligned}
 \sum_{v\nmid\infty}\lambda_v(P_{j,m})
 &=\frac16\bigl(\log b_m+\log(b_m+1)-\log2\bigr)+O_J(1)\\
 &=\frac13\log c_m+O_J(1),
 \end{aligned}
\]

proving (5.4).  Formula (4.2), uniformly over the finite set \(J\), gives
(5.3) and non-torsion for all sufficiently large \(m\).  Finally the global
decomposition

\[
 \widehat h(P)=\sum_v\lambda_v(P)
\]

subtracts (5.4) from (5.3), giving (5.5). \(\square\)

## 6. The strict fixed-abscissa obstruction

Taking the minimum of (5.3) over the fixed finite set gives

\[
 \boxed{
 \min_{j\in J}\widehat h(P_{j,m})
 =\frac14\log c_m+O_J(1).}
 \tag{6.1}
\]

Consequently, for every \(\alpha<1/4\), all sufficiently large members of
the family satisfy

\[
 \widehat h(P_{j,m})>\alpha\log c_m
 \qquad(j\in J).
 \tag{6.2}
\]

Thus none of the following can hold uniformly for a selector restricted to
a fixed finite abscissa universe:

\[
 \widehat h(P_j)=o(\log c),
\]

or

\[
 \widehat h(P_j)\le\alpha\log c+O_J(1)
 \quad\text{with }\alpha<\frac14.
\]

On the same family, the selected deep-prime identity contribution is

\[
 \frac16(Nm)\log\ell
 =\frac16\log c_m+O_J(1).
\]

Hence a direct full-canonical-height budget has intrinsic slope \(1/4\),
strictly larger than the \(1/6\) coefficient with which the desired deep
prime enters the local height.  It cannot by itself provide a
below-critical upper budget.  The exact global ledger is instead

\[
 \underbrace{\frac13\log c_m}_{\text{all finite bad depth}}
 +
 \underbrace{-\frac1{12}\log c_m}_{\text{archimedean correction}}
 =
 \underbrace{\frac14\log c_m}_{\text{canonical height}}
 +O_J(1).
 \tag{6.3}
\]

This strengthens the earlier fixed-abscissa conductor obstruction: even if
the twist discriminant happens to be small, the canonical height still has
the positive slope (6.1).

### 6.1 A genuine surviving refinement: halve the selected point

The obstruction (6.1) applies to \(P_j\), not to all bounded-degree points
canonically derived from it.  In fact \(P_j\) is generically divisible by
two after a fixed extension of the constant field.

On the base curve of Section 3 choose

\[
 \alpha=\sqrt j,\qquad
 \beta=\sqrt{j-1},\qquad
 \gamma=\frac{s}{\alpha\beta}.
\]

Then

\[
 \alpha^2=x(P_j)-0,\qquad
 \beta^2=x(P_j)-1,\qquad
 \gamma^2=x(P_j)-(-t).
 \tag{6.4}
\]

The full-two-torsion halving criterion therefore gives a section \(R_j\)
over \(\mathbf Q(\alpha,\beta)(s)\) such that

\[
 2R_j=P_j.
 \tag{6.5}
\]

With compatible signs, the usual half-point formula has

\[
 x(R_j)=j+\alpha\beta+\beta\gamma+\gamma\alpha,
 \tag{6.6}
\]

which is linear in \(s\).  Quadraticity of the canonical height and (3.9)
give

\[
 \widehat h_{\mathbf Q(\alpha,\beta)(s)}(R_j)=\frac18.
 \tag{6.7}
\]

After specialization, \(R_{j,b}\) is defined over a number field of degree
at most eight and

\[
 \widehat h(R_{j,b})
 =\frac14\widehat h(P_{j,b})
 =\frac1{16}\log b+O_j(1).
 \tag{6.8}
\]

This also explains the Mordell--Weil lattice numerology.  The surface with
fibres \(I_2^4I_4\) has rank one; its primitive free generator has Shioda
norm \(1/4\), while \(P_j=2R_j\) has norm one.

The coefficient \(1/16\) is below the deep-prime coefficient \(1/6\), but
this observation is not yet a proof-producing inequality.  Halving changes
the component and Bernoulli terms in the local-height ledger, and one must
show that a single global half retains the required positive depth at the
selected bad primes.  That local-global division-point audit is a separate,
genuinely open task.  No conclusion about it is assumed here.

The theorem does **not** exclude:

1. the bounded-degree division-point refinement (6.4)--(6.8);
2. an unbounded abscissa chosen adaptively from the arithmetic of the
   triple;
3. cancellation using several points in the same quadratic-character
   space;
4. a new adelic functional which is not the full canonical height;
5. an auxiliary motive whose archimedean and conductor normalizations have
   different critical coefficients.

Those remain genuine open directions.  What is closed is the claim that
the original points \(P_j\) acquire a sublinear global canonical-height bill
merely because their abscissas are bounded.

## 7. Lean boundary

The companion module
`IUTThreeClosures/FreyBoundedAbscissaHeightObstruction.lean` formalizes only
the algebraic and scalar parts that do not require an elliptic-curve
library:

1. the cross-multiplied duplication identity (1.1);
2. the exact quadratic-twist point identity (2.5);
3. the \(1/3-1/12=1/4\) local-height ledger;
4. the passage from uniform bounded error to the strict slope obstruction;
5. the fact that a finite family of \(1/4\)-slope bounds gives the same
   lower bound for every candidate.

Lean does not formalize Tate's algorithm, the resolution of the \(I_4\)
fibre, Shioda's height formula, Tate's variation theorem, number fields, or
Neron local heights.  The halving criterion and half-point construction in
Section 6.1 are also paper-only.  Equations (3.8)--(6.8) are therefore
explicitly paper-only inputs, not hidden fields of a Lean structure.

## References

1. J. Tate, *Variation of the canonical height of a point depending on a
   parameter*, Amer. J. Math. 105 (1983), 287--294,
   DOI 10.2307/2374389.
2. T. Shioda, *On the Mordell--Weil lattices*, Comment. Math. Univ. St.
   Pauli 39 (1990), 211--240.
3. G. S. Call and J. H. Silverman, *Canonical heights on varieties with
   morphisms*, Compos. Math. 89 (1993), 163--205.
4. J. H. Silverman, *Computing heights on elliptic curves*, Math. Comp. 51
   (1988), 339--358, DOI 10.1090/S0025-5718-1988-0942161-4.
5. J. Tate, *Algorithm for determining the type of a singular fiber in an
   elliptic pencil*, Lecture Notes in Math. 476 (1975), 33--52.
