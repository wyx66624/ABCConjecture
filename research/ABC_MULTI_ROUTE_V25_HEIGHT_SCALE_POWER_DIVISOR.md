# ABC multi-route research note v25: height-scale power divisor

**Author:** ChatGPT  
**Date:** 2026-08-30

Assume an unbounded `(1+epsilon)`-violating family and an exponent cap `K` on
the large-endpoint product

\[
N=\max(a,b)c.
\]

The height-scale theorem gives, after absorbing the fixed constant,

\[
D_2(N)\ge \eta h,
\qquad
\eta<\frac{2\epsilon}{1+\epsilon},
\qquad
h=\log c.
\]

Let

\[
A=D_2(N)+W_1.
\]

The layer-cake identity is

\[
A=\sum_{j=3}^{K}W_{\ge j}.
\]

Therefore some `j` satisfies

\[
W_{\ge j}\ge\frac{A}{K-2}
\ge\frac{\eta}{K-2}h.
\]

Let

\[
D_j=\prod_{v_p(N)\ge j}p.
\]

The exact power-layer theorem gives

\[
D_j^j\mid N.
\]

Since `j>=3`,

\[
\boxed{
\log D_j^j
=jW_{\ge j}
\ge
\frac{3\eta}{K-2}h.
}
\]

Equivalently,

\[
\boxed{
D_j^j\ge c^{3\eta/(K-2)}.
}
\]

Because the two large endpoints are coprime, this divisor splits between
them. At least one endpoint contains a `j`-th-power divisor whose logarithmic
size is at least half of the displayed bound.

Thus the bounded-exponent branch of any counterexample sequence contains a
power divisor of fixed positive height exponent; it is not merely divisible
by isolated prime cubes. The remaining pointwise problem is a quantitative
short-gap theorem for coprime integers carrying such power divisors.
