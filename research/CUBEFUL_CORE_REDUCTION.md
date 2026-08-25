# Cube-core reduction for prospective abc counterexamples

For a positive integer

\[
 n=\prod_pp^{e_p},
\]

define its `k`-th power core by

\[
 U_k(n)=\prod_pp^{\lfloor e_p/k\rfloor}.
\]

Then `U_k(n)^k` divides `n`.

## Theorem 1 (general power-core inequality)

For every `k>=2`,

\[
 U_k(n)^k\geq \frac{n}{\operatorname{rad}(n)^{k-1}}.
\]

### Proof

For every exponent `e>=1`,

\[
 k\lfloor e/k\rfloor\geq e-(k-1).
\]

Apply this inequality prime by prime.

## Theorem 2 (large cube core)

Let `a,b,c` be positive pairwise coprime integers with `a+b=c`. Put

\[
 R=\operatorname{rad}(abc),
 \qquad
 U=U_3(abc).
\]

If

\[
 c>R^{1+\epsilon}
\]

for some `epsilon>0`, then

\[
 U^3
 >c^{2\epsilon/(1+\epsilon)}(1-1/c).
\]

Consequently

\[
 U
 >c^{2\epsilon/(3(1+\epsilon))}(1-1/c)^{1/3}.
\]

### Proof

Since `a,b` are positive and `a+b=c`,

\[
 ab\geq c-1.
\]

Pairwise coprimality gives `rad(abc)=rad(a)rad(b)rad(c)`.  Applying Theorem 1
to `abc` with `k=3` yields

\[
 U^3\geq \frac{abc}{R^2}
 \geq\frac{c(c-1)}{R^2}.
\]

The assumed abc violation gives `R^2<c^{2/(1+epsilon)}`. Hence

\[
 U^3
 >c^{2-2/(1+\epsilon)}(1-1/c)
 =c^{2\epsilon/(1+\epsilon)}(1-1/c).
\]

## Corollary 3 (one large cubic coordinate)

Write the canonical cube-free decompositions

\[
 a=A x^3,\qquad b=B y^3,\qquad c=C z^3,
\]

where `A,B,C` are cube-free. Then

\[
 xyz=U_3(abc).
\]

At least one of `x,y,z` therefore satisfies

\[
 \max\{x,y,z\}
 >c^{2\epsilon/(9(1+\epsilon))}(1-1/c)^{1/9}.
\]

The triple lies on the primitive diagonal cubic

\[
 A x^3+B y^3=C z^3.
\]

Thus every hypothetical abc counterexample has both a large square-core
presentation on a diagonal conic and a large cube-core presentation on a
diagonal genus-one curve.

## Research consequence

The cube-core route is potentially better adapted to elliptic-curve descent,
Selmer groups, modularity, and integral-point estimates than the conic route.
The remaining theorem is a uniform radical-height estimate for primitive
points on the varying cube-free diagonal cubics above, exploiting the proven
lower bound on at least one cubic coordinate. The route is not discarded
unless such a proposed uniform theorem is refuted by a concrete family or
shown to be equivalent to abc without adding usable structure.
