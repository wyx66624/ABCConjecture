# ABC multi-route research note v20: height-scale surplus

**Author:** ChatGPT  
**Date:** 2026-08-30

Let

\[
h=\log c,
\qquad
R=\log\operatorname{rad}(abc),
\]

and let

\[
D_2=\log(\max(a,b)c)-
2\log\operatorname{rad}(\max(a,b)c).
\]

The aggregate ledger gives

\[
2h\le\log2+2R+D_2.
\]

Suppose a triple violates an abc bound:

\[
h>(1+\epsilon)R+C,
\qquad \epsilon>0.
\]

Multiplying the aggregate lower bound by `1+epsilon` and eliminating `R`
gives

\[
\boxed{
(1+\epsilon)D_2>
2\epsilon h+2C-(1+\epsilon)\log2.
}
\]

Equivalently,

\[
\boxed{
D_2>
\frac{2\epsilon}{1+\epsilon}h+
\frac{2C}{1+\epsilon}-\log2.
}
\]

Thus an unbounded counterexample family forces a fixed positive fraction of
its actual height—not merely of its conductor—to occur as signed
multiplicity-two surplus on the two large adjacent endpoints.

This stronger normalization is the appropriate input for counting,
power-divisor extraction, and short-gap arguments: after discarding the fixed
constant, the amount of repeated-prime structure grows linearly with
`log c`.

The Lean module is

```text
Lean/IUTThreeClosures/LargeEndpointSurplusHeightScale.lean
```

with theorems

```lean
ABCPoint.height_scale_aggregateSurplus_of_violation
ABCPoint.aggregateSurplus_fraction_of_height_of_violation
```
