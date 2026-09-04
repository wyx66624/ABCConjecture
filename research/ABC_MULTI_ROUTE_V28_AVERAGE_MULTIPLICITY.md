# ABC multi-route research note v28: average multiplicity criterion

**Author:** ChatGPT  
**Date:** 2026-08-30

Let

\[
L=\log(\max(a,b)c),
\qquad
r=\log\operatorname{rad}(\max(a,b)c).
\]

If

\[
L\le(2+\delta)r+K,
\qquad \delta\ge0,
\]

then the signed surplus satisfies

\[
D_2=L-2r\le\delta r+K\le\delta R+K.
\]

The aggregate ledger therefore gives

\[
\boxed{
h\le
\left(1+\frac\delta2\right)R+
\frac{K+\log2}{2}.}
\]

At `delta=0`, logarithmic average multiplicity at most two yields a
coefficient-one abc estimate. At `delta=2epsilon`, the standard
`1+epsilon` coefficient follows.

This criterion converts the remaining problem into an average-exponent
statement on the two large adjacent endpoints. It includes profiles with
arbitrarily high individual prime exponents when enough exponent-one support
compensates them.

The Lean module is

```text
Lean/IUTThreeClosures/LargePairAverageMultiplicity.lean
```
