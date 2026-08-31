# ABC multi-route research note v35: aggregate quartic gain and split-square descent

**Author:** ChatGPT  
**Date:** 2026-08-31

## Status

This note proves new unconditional reductions inside the remaining endpoint
problem. It does not assert a complete proof of the ABC conjecture.

## 1. Aggregate fourth-root gain

Write

\[
m=\min(a,b),\qquad M=\max(a,b),\qquad m+M=c,
\qquad h=\log c.
\]

Let \(T_m,T_M,T_c\) be the endpoint logarithmic sizes, let
\(r_m+r_M+r_c=R\) be the full radical weight, and let
\(q_m,q_M,q_c\) be the logarithmic sizes of the canonical fourth roots.
The exact fourth-power residue decomposition gives

\[
T_i\le 3r_i+4q_i.
\]

In the non-short-gap branch, retain explicit losses \(L_m,L_M,L_c\):

\[
(2+\varepsilon)h-2(1+\varepsilon)L_m
\le 2(1+\varepsilon)T_m,
\]

\[
h-L_M\le T_M,
\qquad
h-L_c\le T_c.
\]

If

\[
(1+\varepsilon)R+C<h,
\]

then summing before selecting an endpoint gives

\[
\boxed{
5\varepsilon h+6C
<
8(1+\varepsilon)(q_m+q_M+q_c)
+2(1+\varepsilon)(L_m+L_M+L_c).
}
\]

Hence one endpoint satisfies

\[
\boxed{
24(1+\varepsilon)q_i
>
5\varepsilon h+6C
-2(1+\varepsilon)(L_m+L_M+L_c).
}
\]

For bounded losses, the corresponding fourth-power divisor has logarithmic
size at least

\[
\left(\frac{5\varepsilon}{6(1+\varepsilon)}-o(1)\right)h.
\]

## 2. Explicit saving for the moving quartic coefficient

Suppose the selected endpoint is written

\[
n=A d^4,
\qquad
T=\log n,
\quad
K=\log A,
\quad
q=\log d.
\]

Then \(T=K+4q\) and \(T\le h\). Substitution into the preceding lower bound
gives

\[
\boxed{
6(1+\varepsilon)K
<
(6+\varepsilon)h-6C
+2(1+\varepsilon)(L_m+L_M+L_c).
}
\]

Thus the fourth-power-free coefficient satisfies the power-saving exponent

\[
\frac{K}{h}
<
\frac{6+\varepsilon}{6(1+\varepsilon)}+o(1)
=
1-rac{5\varepsilon}{6(1+\varepsilon)}+o(1).
\]

The quartic branch therefore has both a height-scale fourth-power divisor and
a genuinely smaller moving coefficient.

## 3. Sharpness: scalar budgets cannot force a fifth root

For every

\[
0<\varepsilon<\frac25,
\]

set

\[
h=2(1+\varepsilon),
\qquad
T_m=2+\varepsilon,
\qquad
T_M=T_c=2(1+\varepsilon),
\]

\[
r_m=\frac{2+\varepsilon}{4},
\qquad
r_M=r_c=\frac{1+\varepsilon}{2},
\qquad
q_m=q_M=q_c=0.
\]

All three fifth-power budgets

\[
T_i\le4r_i+5q_i
\]

hold with equality. The non-short-gap lower bound and both large-endpoint
bounds also hold with equality. Finally,

\[
(1+\varepsilon)(r_m+r_M+r_c)<h
\]

is exactly the condition \(5\varepsilon<2\).

Therefore no method using only endpoint sizes, the total radical, and
independent residue budgets can force exponent five for the small
\(\varepsilon\) range. Crossing the quartic frontier requires the additive
equation or genuinely arithmetic consequences of it.

## 4. Split-square descent

In the branch where the two large endpoints are exact squares,

\[
M=x^2,
\qquad
c=y^2,
\qquad
x<y,
\]

the small endpoint factors as

\[
\boxed{
m=(y-x)(y+x).}
\]

Let

\[
T_m=\log m,
\qquad
T_d=\log(y-x),
\qquad
h_y=\log y.
\]

Since \(y+x\ge y\),

\[
T_d+h_y\le T_m.
\]

The original short-gap inequality, with \(h=2h_y\), is

\[
2(1+\varepsilon)T_m<(2+\varepsilon)h.
\]

It follows without loss that

\[
\boxed{
(1+\varepsilon)T_d<h_y.
}
\]

Thus the square-endpoint short gap descends to a power-saving gap between the
square roots. This produces a smaller adjacent equation

\[
x+(y-x)=y
\]

whose radical support is contained in the original four-factor support

\[
xy(y-x)(x+y).
\]

The remaining split-square problem is consequently a four-linear-factor
radical problem rather than an unconstrained Pell equation.

## 5. Lean files

```text
Lean/IUTThreeClosures/ThreeEndpointAggregateFourthRoot.lean
Lean/IUTThreeClosures/FourthPowerCoefficientSaving.lean
Lean/IUTThreeClosures/FifthRootAggregateSharpness.lean
Lean/IUTThreeClosures/SplitSquareEndpointDescent.lean
```

The modules contain no `axiom`, `sorry`, or `admit`. Their theorems are
unconditional scalar, factorization, or finite-profile statements; none stores
an ABC conclusion as input.

## 6. Next core target

The remaining arithmetic split is now:

1. **nonsplit moving-quadratic branch:** exploit the coefficient-supported
   norm equation together with the height-scale quartic divisor and local
   splitting constraints;
2. **split-square branch:** control the radical of
   \(xy(y-x)(x+y)\), using the descended root gap and any inherited cube or
   fourth-power concentration.

A complete proof still requires a pointwise theorem closing both branches.
