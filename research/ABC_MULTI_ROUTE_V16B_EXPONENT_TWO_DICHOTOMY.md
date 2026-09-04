# ABC multi-route research note v16b: exponent-two surplus dichotomy

**Author:** ChatGPT  
**Date:** 2026-08-30

Let a finite prime support carry nonnegative logarithmic weights `w_p` and
positive exponents `e_p`. Define

\[
D_2=\sum_p(e_p-2)w_p,
\qquad
E_{>2}=\sum_p\max(e_p-2,0)w_p,
\qquad
W_1=\sum_{e_p=1}w_p.
\]

Coordinatewise,

\[
e-2=\max(e-2,0)-\mathbf 1_{e=1},
\]

so

\[
\boxed{D_2=E_{>2}-W_1.}
\]

This is the exact compensation identity behind the signed large-pair surplus.

Let

\[
W_{\ge3}=\sum_{e_p\ge3}w_p,
\qquad
R=\sum_p w_p.
\]

If all exponents are at most `K`, then

\[
E_{>2}\le(K-2)W_{\ge3}.
\]

Hence, if

\[
D_2\ge\delta R,
\]

then

\[
\boxed{
\delta R+W_1\le(K-2)W_{\ge3}.
}
\]

For every cutoff `K`, a positive-surplus exponent profile therefore satisfies
one of two alternatives:

1. some exponent is greater than `K`;
2. the bounded-exponent cubed-support budget above holds.

Applied to the two large endpoints of a hypothetical abc counterexample, this
splits the remaining arithmetic work into:

- a high-exponent generalized-Fermat/local-lifting branch;
- a bounded-exponent branch in which a fixed conductor-scale amount of radical
  support occurs cubically.

The Lean module is

```text
Lean/IUTThreeClosures/ExponentTwoSurplusDichotomy.lean
```

and contains no modularity theorem, distribution theorem, `axiom`, `sorry`, or
`admit`.
