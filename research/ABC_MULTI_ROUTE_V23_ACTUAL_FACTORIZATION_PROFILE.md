# ABC multi-route research note v23: actual factorization profile bridge

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Canonical profile of the large-endpoint product

For a positive primitive abc point, put

\[
N=\max(a,b)c.
\]

Let

\[
S_N=\{p:p\mid N\},
\qquad
e_p=v_p(N),
\qquad
w_p=\log p.
\]

Unique factorization gives

\[
N=\prod_{p\in S_N}p^{e_p}
\]

and

\[
\operatorname{rad}(N)=\prod_{p\in S_N}p.
\]

Taking logarithms,

\[
\log N=\sum_{p\in S_N}e_p w_p,
\qquad
\log\operatorname{rad}(N)=\sum_{p\in S_N}w_p.
\]

Therefore the signed large-pair surplus is exactly the abstract exponent-two
surplus:

\[
\boxed{
\log N-2\log\operatorname{rad}(N)
=
\sum_{p\in S_N}(e_p-2)w_p.
}
\]

All weights are nonnegative, and all exponents on the support are positive.
Thus every abstract selector and dichotomy in v16--v22 applies canonically to
the actual large-endpoint product; no arbitrary profile or external
realization hypothesis is required.

## 2. Concrete consequences for a hypothetical violation

The height-scale theorem forces

\[
D_2(N)\ge \eta\log c-O(1)
\]

for a fixed `eta>0` along any unbounded `(1+epsilon)`-violating family.
Applying the canonical factorization profile yields two concrete alternatives
for every chosen exponent cutoff `K`:

1. a prime divisor of `N` occurs to exponent greater than `K`; or
2. a conductor-scale amount of the radical of `N` lies in exponent-at-least
   three layers.

In the second branch, the adaptive selectors produce both:

- a prime exponent modulus `ell<=K` with a quantitative level-support drop;
- a power layer `j<=K` whose base product has a genuine `j`-th power dividing
  `N`.

## 3. Lean implementation target

The remaining formal bridge should instantiate the abstract profile with

```lean
s        := n.factorization.support
base p   := p
exponent := n.factorization
weight p := Real.log p
```

and prove the two logarithmic product identities from the canonical
factorization and radical product formulas. This is an implementation task,
not a new arithmetic assumption.
