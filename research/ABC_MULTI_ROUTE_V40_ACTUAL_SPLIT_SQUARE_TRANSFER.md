# ABC multi-route research note v40: actual split-square violation transfer

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. From the square triple to actual radical variables

For coprime roots `0<x<y`, put

\[
d=y-x,
\qquad
s=y+x.
\]

The primitive split-square point and primitive root point are

\[
P_{\rm sq}=(ds,x^2,y^2),
\qquad
P_{\rm root}=(d,x,y).
\]

Their heights are

\[
h(P_{\rm sq})=2\log y,
\qquad
h(P_{\rm root})=\log y.
\]

Because prime support is unchanged by squaring,

\[
\operatorname{rad}(dsx^2y^2)
=
\operatorname{rad}(dsxy).
\]

The fixed-overlap theorem gives

\[
\log\operatorname{rad}(dxy)
+
\log\operatorname{rad}(s)
\le
\log\operatorname{rad}(dsxy)+\log2.
\]

Thus, in point notation,

\[
\boxed{
R_{\rm root}+R_s
\le
R_{\rm sq}+\log2.
}
\]

## 2. Actual dichotomy

Assume that the square point violates an abc inequality:

\[
(1+\varepsilon)R_{\rm sq}+C
< h(P_{\rm sq}),
\qquad \varepsilon>0.
\]

Let

\[
H=h(P_{\rm root})=\log y
\]

and

\[
\alpha_\varepsilon=
\frac{2}{(1+\varepsilon)(2+\varepsilon)}.
\]

For an arbitrary real threshold loss \(K\), at least one of the following
holds.

### Root-triple violation

\[
\boxed{
\left(1+\frac\varepsilon2\right)R_{\rm root}
+
\frac{1+\varepsilon/2}{1+\varepsilon}
\left(C-(1+\varepsilon)(K+\log2)\right)
<H.
}
\]

This is a genuine abc violation for the actual primitive point
\((d,x,y)\), with half logarithmic height and exponent \(\varepsilon/2\).

### Companion multiplicity excess

\[
\boxed{
(1-\alpha_\varepsilon)H+K
<
\log s-\log\operatorname{rad}(s).
}
\]

The right-hand side is an explicit prime-exponent statistic:

\[
\log s-\log\operatorname{rad}(s)
=
\sum_{p\mid s}(v_p(s)-1)\log p.
\]

No square-root witness or freely populated closure record appears.

## 3. Meaning of the second branch

Since

\[
1-\alpha_\varepsilon
=
\frac{\varepsilon(3+\varepsilon)}
{(1+\varepsilon)(2+\varepsilon)}>0,
\]

the companion sum must have repeated-prime mass at a fixed positive fraction
of the root height.  The existing finite-profile square-part theorem then
converts at least half of this multiplicity excess into the logarithmic size
of a canonical square root.

Therefore the split-square branch has now been reduced, on actual integers,
to:

1. a smaller-height primitive abc counterexample; or
2. a height-scale square divisor in the companion sum.

## 4. Lean module

```text
Lean/IUTThreeClosures/ActualSplitSquareTransfer.lean
```

Core declarations:

```lean
Data.squareRadical_eq_supportRadical
Data.squarePoint_conductor_eq_supportLog
Data.rootConductor_add_sumRadical_le_squareConductor_add_log_two
Data.rootPoint_height_nonneg
Data.rootPoint_height_le_log_sum
Data.rootViolation_or_companionMultiplicityExcess
```

The module contains no `axiom`, `sorry`, or `admit`.

## 5. Remaining step in this branch

The remaining arithmetic task is to attach the natural-number canonical
square decomposition of `s` to the explicit excess in the second branch, and
then to show that repeated descent or repeated companion-square concentration
cannot continue indefinitely under the inherited pairwise-coprime and local
residue constraints.
