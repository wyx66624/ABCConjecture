# Powerful-core and square-kernel route to the abc conjecture

## 1. Purpose

This branch studies the multiplicity structure forced by a hypothetical family
of abc counterexamples.  It is independent of IUT, modularity, and the
auxiliary-prime construction.

For a positive integer `n`, put

\[
  \operatorname{rad}(n)=\prod_{p\mid n}p,
  \qquad
  \operatorname{exc}(n)=\frac{n}{\operatorname{rad}(n)}.
\]

The quantity `exc(n)` is the multiplicity excess of `n`: it is large exactly
when prime powers, rather than distinct prime support, account for a large part
of `n`.

## 2. Multiplicity excess forced by an abc violation

Let `a,b,c` be pairwise coprime positive integers with `a+b=c`, and write

\[
  R=\operatorname{rad}(abc).
\]

### Theorem 2.1 (global excess)

If, for some `epsilon>0`,

\[
  c>R^{1+\epsilon},
\]

then

\[
  \operatorname{exc}(a)\operatorname{exc}(b)
  \operatorname{exc}(c)
  >c^{\epsilon/(1+\epsilon)}.
\]

#### Proof

Pairwise coprimality gives

\[
  \operatorname{rad}(abc)
  =\operatorname{rad}(a)\operatorname{rad}(b)
   \operatorname{rad}(c).
\]

Hence

\[
  \operatorname{exc}(a)\operatorname{exc}(b)
  \operatorname{exc}(c)=\frac{abc}{R}\geq \frac cR.
\]

The assumed inequality gives `R<c^{1/(1+epsilon)}`, so

\[
  \frac cR>c^{1-1/(1+\epsilon)}
  =c^{\epsilon/(1+\epsilon)}.
\]

### Corollary 2.2

At least one of `a,b,c` satisfies

\[
  \operatorname{exc}(n)
  >c^{\epsilon/(3(1+\epsilon))}.
\]

This is immediate from Theorem 2.1.

## 3. A stronger two-large-term estimate

Let `x=max(a,b)`.  Then `x>=c/2`.

### Theorem 3.1

Under the hypotheses of Theorem 2.1,

\[
  \max\{\operatorname{exc}(x),\operatorname{exc}(c)\}
  >2^{-1/2}
   c^{(1+2\epsilon)/(2(1+\epsilon))}.
\]

#### Proof

Since `rad(x)rad(c)<=R`,

\[
 \operatorname{exc}(x)\operatorname{exc}(c)
 =\frac{xc}{\operatorname{rad}(x)\operatorname{rad}(c)}
 \geq \frac{c^2}{2R}.
\]

Using `R<c^{1/(1+epsilon)}` yields

\[
 \operatorname{exc}(x)\operatorname{exc}(c)
 >\frac12 c^{2-1/(1+\epsilon)}
 =\frac12 c^{(1+2\epsilon)/(1+\epsilon)}.
\]

Taking square roots proves the claim.

## 4. Large square divisor

Every positive integer has a canonical squarefree-square decomposition

\[
  n=s(n)t(n)^2,
\]

where

\[
 s(n)=\prod_{v_p(n)\text{ odd}}p,
 \qquad
 t(n)=\prod_p p^{\lfloor v_p(n)/2\rfloor}.
\]

### Lemma 4.1

\[
  t(n)^2\geq \operatorname{exc}(n).
\]

#### Proof

For every exponent `e>=1`,

\[
  2\lfloor e/2\rfloor\geq e-1.
\]

Apply this prime by prime.

### Corollary 4.2 (large square core)

A counterexample as in Theorem 2.1 has one of the two large terms
`n in {max(a,b),c}` containing a square divisor `t(n)^2` satisfying

\[
  t(n)^2
  >2^{-1/2}c^{(1+2\epsilon)/(2(1+\epsilon))}.
\]

Equivalently,

\[
  t(n)>2^{-1/4}c^{(1+2\epsilon)/(4(1+\epsilon))}.
\]

## 5. Diagonal-conic reduction

Write

\[
 a=A x^2,\qquad b=B y^2,\qquad c=C z^2,
\]

with `A,B,C` squarefree.  Then

\[
  A x^2+B y^2=C z^2.
\]

Because `a,b,c` are pairwise coprime, the prime supports of `Ax`, `By`, and
`Cz` are pairwise disjoint.  Moreover

\[
  \operatorname{rad}(abc)=\operatorname{rad}(AxByCz).
\]

Thus any infinite counterexample family produces an infinite family of
primitive diagonal-conic points with a polynomially large square coordinate,
while the radical of all coefficients and coordinates remains smaller than
`c^{1/(1+epsilon)}`.

This is a genuine reduction, not a proof of abc.  The route will be closed only
if one proves a uniform radical-height theorem for these varying squarefree
coefficient conics, or finds a counterexample to that proposed theorem.

## 6. Next mathematical targets

1. Prove a uniform height bound for primitive points on
   `A x^2+B y^2=C z^2` in which the dependence on the squarefree coefficients
   is through `rad(ABC)` rather than their absolute size.
2. Combine the large-square-core theorem with the determinant-method anatomy
   of current exceptional-set estimates.
3. Split the route according to the balance parameter

   \[
     \beta(a,b,c)=\frac{\log(ab)}{\log c}\in[1+o(1),2],
   \]

   since the required control on the weighted average prime exponent is
   strongest in the unbalanced regime and weakest in the balanced regime.
4. Retain this branch unless a concrete family disproves the proposed uniform
   conic radical-height bound.
