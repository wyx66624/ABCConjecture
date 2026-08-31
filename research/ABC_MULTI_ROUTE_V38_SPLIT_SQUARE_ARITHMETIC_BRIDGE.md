# ABC multi-route research note v38: the actual split-square arithmetic bridge

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Purpose

The previous split-square descent was stated as an exact scalar implication.
This note supplies the underlying primitive integer triples and proves the
coprimality and radical monotonicity required to attach that scalar analysis
to an actual abc point.

No ABC estimate is assumed.

## 2. Primitive roots

Let

\[
0<x<y,
\qquad
\gcd(x,y)=1,
\]

and define

\[
d=y-x,
\qquad
s=y+x.
\]

Then

\[
d+x=y
\]

and

\[
\boxed{ds+x^2=y^2}.
\]

Thus there are two associated positive abc triples:

\[
P_{\rm root}=(d,x,y)
\]

and

\[
P_{\rm sq}=(ds,x^2,y^2).
\]

## 3. Coprimality

Any common divisor of `d` and `x` also divides `d+x=y`; since `x` and `y`
are coprime,

\[
\gcd(d,x)=1.
\]

The same subtraction/addition argument gives

\[
\gcd(d,y)=\gcd(s,x)=\gcd(s,y)=1.
\]

Consequently

\[
\gcd(ds,x^2)=\gcd(x^2,y^2)=\gcd(y^2,ds)=1,
\]

so both displayed triples are primitive.

The only possible overlap between `d` and `s` is the prime two.  Indeed, if
`g` divides both, then

\[
g\mid s-d=2x,
\qquad
g\mid s+d=2y.
\]

Since \(\gcd(x,y)=1\),

\[
\boxed{\gcd(d,s)\mid2.}
\]

This is the precise arithmetic reason that the companion-sum radical differs
from the new radical contribution by at most a fixed factor two.

## 4. Radical and conductor monotonicity

The root product divides the split-square product:

\[
dxy\mid dsx^2y^2.
\]

Hence radical monotonicity gives

\[
\boxed{
\operatorname{rad}(dxy)\mid
\operatorname{rad}(dsx^2y^2)
}
\]

and therefore

\[
\log\operatorname{rad}(dxy)
\le
\log\operatorname{rad}(dsx^2y^2).
\]

In repository notation,

\[
\boxed{
\operatorname{conductor}(P_{\rm root})
\le
\operatorname{conductor}(P_{\rm sq}).
}
\]

The heights are exactly

\[
h(P_{\rm root})=\log y,
\qquad
h(P_{\rm sq})=2\log y.
\]

Thus the root triple is an actual half-height primitive abc point, not an
auxiliary scalar model.

## 5. Lean module

```text
Lean/IUTThreeClosures/SplitSquareArithmeticBridge.lean
```

Core declarations:

```lean
Data.gap_mul_sum_add_x_sq_eq_y_sq
Data.gap_coprime_x
Data.gap_coprime_y
Data.sum_coprime_x
Data.sum_coprime_y
Data.gcd_gap_sum_dvd_two
Data.rootPoint
Data.squarePoint
Data.rootRadical_dvd_squareRadical
Data.rootPoint_conductor_le_squarePoint_conductor
Data.squarePoint_height_eq_two_log_y
```

The module contains no `axiom`, `sorry`, or `admit`.

## 6. Remaining exact bridge

The next step is to turn

\[
\gcd(d,s)\mid2
\]

into the logarithmic overlap estimate

\[
\log\operatorname{rad}(dxy)
+
\log\operatorname{rad}(s)
\le
\log\operatorname{rad}(dsxy)+\log2.
\]

That will instantiate the v36b radical-transfer dichotomy on the actual
objects above, with no free radical variables.
