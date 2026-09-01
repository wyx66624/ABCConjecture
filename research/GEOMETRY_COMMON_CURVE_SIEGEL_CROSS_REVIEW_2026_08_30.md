# Independent review of the common curve and fixed-support Siegel argument

Reviewer: ChatGPT, analytic-route agent. Date: 2026-08-30.

Reviewed material: Sections 6, 10 and 11 of
`research/GEOMETRY_GLOBAL_UNIFORM_GATE_2026_08_30.md`, especially the new
common-curve, rational 3-torsion and fixed residual-support conclusions.
No file owned by the geometry agent was edited.

## Conclusion

The reviewed mathematical statements and their current scope pass this
independent check. No mandatory correction was found. The conclusion is
uniform for each fixed bound on the cube-residual support; it gives neither
a threshold uniform for a moving residual support nor an effective threshold
from the cited proof. It does not imply abc.

## 1. Common curve, signs and torsion

For `a=A u^3,b=B v^3,c=C w^3`, put `N=ABC`. Dividing the omit-endpoint
Mordell point by `t_i^2,t_i^3` is legitimate because every cube base is
positive and `s_i=N t_i^3`. The resulting points lie on the nonsingular
curve `Y^2=X^3+16N^2`; nonsingularity follows from `N>0`.

At `T_0=(0,4N)` the tangent slope is zero, its ordinate is nonzero, and
the addition law gives `2T_0=-T_0`. Since this is an affine point, its
order is exactly three. The two slopes through `Q_b` are, respectively,

\[
 \frac{Y(Q_b)-4N}{X(Q_b)}=\frac{2a}{uvw},\qquad
 \frac{Y(Q_b)+4N}{X(Q_b)}=\frac{2c}{uvw}.
\]

Substitution into both addition coordinates verifies
`Q_b+T_0=Q_c` and `Q_b-T_0=-Q_a`. In particular, the minus sign on `Q_a`
is necessary and is present in the report. The three points
`Q_b,Q_c,-Q_a` are distinct because they differ by the three distinct
elements of this torsion subgroup. All affine denominators used in the
calculation are nonzero, including for the seed `(1,1,2)` where the
omit-`c` point has ordinate zero.

The shared image under the auxiliary 3-isogeny has coordinates
`(4Q/(uvw)^2,4T/(uvw)^3)`, in agreement with the weight-two and
weight-three scaling of the source. This is a relation between two
auxiliary curves with `j=0`; it is not an assertion that the original
Frey curve is isogenous to one of them.

## 2. Exact denominator and height calculation

Primitivity gives `gcd(t_i,d_i r_i)=1`. Thus the only cancellation in
`x_i/t_i^2` comes from the coefficient `4`, and

\[
 \operatorname{den}(X_i)=
 \frac{t_i^2}{\gcd(t_i^2,4)}
 =\left(\frac{t_i}{\gcd(t_i,2)}\right)^2.
\]

For the smaller endpoint, assume by symmetry `a<=b` and set
`g=gcd(u,2)`. The positive reduced fraction is

\[
 X(Q_a)=\frac{4vwBC/g^2}{u^2/g^2}.
\]

Its cube is `64N^2 bc/a^2>=64`, so its numerator exceeds its denominator
and `h_x(Q_a)` is the logarithm of the numerator. Taking logarithms of
the two reduced integers gives precisely (11.5). Since
`c/2<=b<c`, `1<=g<=2`, and `BC<=N`, one obtains (11.6):

\[
 \frac23\log c-\frac13\log2
 \le h_x(Q_a)
 \le\frac23\log c+\log4+\frac23\log N,
 \qquad \log\operatorname{den}(X(Q_a))\le\frac23\log a.
\]

Using `h_x=log X+log den(X)` gives the correctly directed inequality

\[
 0\le\log c-\log a
 \le\frac32\log X(Q_a)+\frac12\log2.
\]

Both the lower and upper comparisons with `log c` are needed: the lower
one puts the points in the range of the local approximation theorem; the
upper one converts its error to `o(log c)`.

## 3. Direct check of the original Siegel statement

The source was independently read from the original book PDF, not from
the geometry report's paraphrase:

* Silverman, *The Arithmetic of Elliptic Curves*, second edition (2009),
  Theorem IX.3.1 on printed p. 276 / PDF index 289;
* the specialization of the local distance at infinity on printed p. 277;
* Example IX.3.3 on printed pp. 278--279 / PDF indices 291--292.

Local file:
`research/sources/global_uniform_gate_2026_08_30/Silverman_2009_Arithmetic_of_Elliptic_Curves_2nd.pdf`.
The theorem fixes an elliptic curve over a number field, an algebraic point,
a nonconstant even rational function, and a place. For an infinite rational
point group it states that the logarithm of the local distance, divided by
the function height, tends to zero as that height tends to infinity.
Taking `K=Q`, the algebraic point to be the point at infinity, `f=x`, and
the real place gives (11.1):

\[
 \frac{\log\max(1,|x(P)|)}{h_x(P)}\longrightarrow0.
\]

The coordinate `x` is indeed even and nonconstant. The local distance can
be taken proportional near infinity to `|x(P)|^(-1/2)`; the fixed bounded
comparison term disappears after division by `h_x(P)`. Bounded `x(P)`
also gives the same limit immediately. If the rational point group is
finite, no sequence with unbounded coordinate height exists. Therefore
the finite-group case creates no missing exception.

This use of Siegel is stronger than integral-point finiteness and correctly
allows the growing rational denominators in Section 6. The book's
archimedean example explicitly illustrates this distinction.

## 4. Uniformity and the remaining restriction

The exact quantifier order justified by the proof is

\[
 \forall R_*\in\mathbb N_{\ge1}\ \forall\epsilon>0\qquad
 \exists H_0(R_*,\epsilon)\ \forall(a,b,c):
 \quad R_0\le R_*,\ \log c\ge H_0
 \ \Longrightarrow\ \min(a,b)\ge c^{1-\epsilon},
\]

with positivity, primitivity and `a+b=c` understood as the stated domain
of the final universal quantifier. Cube-freeness gives
`N<=R_0^2<=R_*^2`, so only finitely many fixed curves occur. Taking the
maximum of their finitely many thresholds is legitimate, as is using
the explicit uniform upper height comparison above. There is no hidden
passage to a curve varying through an infinite set.

Dropping the bounded-support hypothesis would be false: for any prime
`p>2`, the primitive triple `(1,p-1,p)` has `R_0>=p` and
`log min(a,b)/log c=0`. This only demonstrates the need for a restriction
when the residual support moves; it does not disprove any proposed
quantitative theorem with an additional controlled dependence on `R_0`,
and is not an abc counterexample family.

The current geometry report explicitly preserves the fixed-curve
qualification, does not claim an effective `H_0`, and does not replace
the remaining denominator-radical problem by this qualitative result.

Book identifier: [DOI 10.1007/978-0-387-09494-6](https://doi.org/10.1007/978-0-387-09494-6).
The original was supplied by the geometry agent from an academic mirror;
the independent review used the local original PDF and did not redistribute
the book or copy extended passages into this report.
