# Simultaneous multiplicity excess in both large terms

## 1. Statement

Let

\[
 a+b=c,
 \qquad
 \gcd(a,b)=\gcd(b,c)=\gcd(c,a)=1,
\]

and put

\[
 R=\operatorname{rad}(abc),
 \qquad
 \operatorname{exc}(n)=\frac{n}{\operatorname{rad}(n)}.
\]

Let

\[
 x=\max\{a,b\}.
\]

Assume that, for some `epsilon>0`,

\[
 c>R^{1+\epsilon}.
\tag{1.1}
\]

Set

\[
 \delta=\frac{\epsilon}{1+\epsilon}.
\]

### Theorem 1.1 (both large terms have multiplicity excess)

Both `x` and `c` satisfy

\[
 \boxed{
 \operatorname{exc}(x)>\frac12c^\delta,
 \qquad
 \operatorname{exc}(c)>\frac12c^\delta.}
\tag{1.2}
\]

This is stronger than the earlier conclusion that at least one of the two
large terms has a very large excess.

## 2. Proof

Since `x>=c/2` and pairwise coprimality gives

\[
 \operatorname{rad}(x)\operatorname{rad}(c)\le R,
\]

we have

\[
 \begin{aligned}
 \operatorname{exc}(x)\operatorname{exc}(c)
 &=\frac{xc}{\operatorname{rad}(x)\operatorname{rad}(c)}\\
 &\ge\frac{c^2}{2R}.
 \end{aligned}
\]

By (1.1),

\[
 R<c^{1/(1+\epsilon)},
\]

so

\[
 \operatorname{exc}(x)\operatorname{exc}(c)
 >\frac12c^{2-1/(1+\epsilon)}
 =\frac12c^{1+\delta}.
\tag{2.1}
\]

On the other hand

\[
 \operatorname{exc}(x)\le x\le c,
 \qquad
 \operatorname{exc}(c)\le c.
\]

Dividing (2.1) first by the upper bound for `exc(c)` and then by the upper
bound for `exc(x)` proves both inequalities in (1.2).

## 3. Simultaneous square cores

Write the canonical squarefree--square decompositions

\[
 x=A X^2,
 \qquad
 c=C Z^2,
\]

with `A,C` squarefree.  Primewise,

\[
 2\left\lfloor\frac{v_p(n)}2\right\rfloor
 \ge v_p(n)-1,
\]

hence the square part satisfies

\[
 X^2\ge\operatorname{exc}(x),
 \qquad
 Z^2\ge\operatorname{exc}(c).
\]

### Corollary 3.1

Every counterexample to (1.1) satisfies

\[
 \boxed{
 X>2^{-1/2}c^{\delta/2},
 \qquad
 Z>2^{-1/2}c^{\delta/2}.}
\tag{3.1}
\]

Moreover

\[
 AC\mid\operatorname{rad}(xc)
 \quad\text{and therefore}\quad
 AC\le R<c^{1/(1+\epsilon)}.
\tag{3.2}
\]

Thus the equation `a+b=c`, after choosing which of `a,b` is `x`, contains a
binary quadratic relation

\[
 \boxed{
 C Z^2-A X^2=\min\{a,b\},}
\tag{3.3}
\]

in which **both** square coordinates are polynomially large, while the product
of the two squarefree coefficients is radical-sized.

## 4. Asymmetric strengthening

The earlier product estimate also gives

\[
 \max\{\operatorname{exc}(x),\operatorname{exc}(c)\}
 >2^{-1/2}
 c^{(1+2\epsilon)/(2(1+\epsilon))}.
\]

Consequently one of `X,Z` is at least

\[
 2^{-1/4}
 c^{(1+2\epsilon)/(4(1+\epsilon))},
\]

while the other still satisfies the simultaneous lower bound (3.1).  A
prospective counterexample therefore has one very large square coordinate and
a second independently polynomially large square coordinate.

## 5. Research consequences

The strengthened reduction supports three retained subroutes.

1. **Pell/continued-fraction anatomy.**  In an unbalanced triple the right side
   of (3.3) is small, so `X/Z` is an unusually good rational approximation to
   `sqrt(C/A)`.  Pell families show that approximation alone cannot close the
   route; any proof must also use radical growth in the Pell coordinates.
2. **Uniform conic height.**  Prove a radical-height theorem for primitive
   points on `C Z^2-A X^2=b` with `AC` radical-sized and both coordinates
   satisfying (3.1).
3. **Exceptional-set concentration.**  The simultaneous lower bounds place
   every exceptional point inside a thinner determinant-method region than the
   earlier one-large-core reduction.

The Pell phenomenon is a counterexample only to a proof based solely on
quadratic irrational approximation.  It does not refute the strengthened
radical-sensitive conic route.

## 6. Formalization plan

The Lean development will separate:

1. the real inequality `R<c^(1/(1+epsilon))` from the assumed abc violation;
2. the product estimate for `exc(x)exc(c)`;
3. the elementary bounds `exc(n)<=n`;
4. the simultaneous conclusion (1.2);
5. the already formalized prime-exponent square-core inequality.

No uniform conic-height theorem is inserted as an assumption.
