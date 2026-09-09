# ABC multi-route research note v35c: corrected aggregate quartic frontier

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Exact aggregate `k`-th-root threshold

Let `h` be the abc height.  In the non-short-gap branch, use endpoint size
variables `Tm,TM,Tc`, radical weights `rm,rM,rc`, and canonical `k`-th-root
weights `qm,qM,qc`.  Assume

\[
(1+\varepsilon)(r_m+r_M+r_c)+C<h,
\]

\[
(2+\varepsilon)h-2(1+\varepsilon)L_m
\le2(1+\varepsilon)T_m,
\]

\[
h-L_M\le T_M,
\qquad
h-L_c\le T_c,
\]

and the exact residue budgets

\[
T_i\le(k-1)r_i+kq_i.
\]

Summing before selecting an endpoint gives

\[
\boxed{
(8+5\varepsilon-2k)h+2(k-1)C
<
2k(1+\varepsilon)(q_m+q_M+q_c)
+2(1+\varepsilon)L_\Sigma,
}
\]

where

\[
L_\Sigma=L_m+L_M+L_c.
\]

For `k=4` this becomes

\[
\boxed{
5\varepsilon h+6C
<8(1+\varepsilon)(q_m+q_M+q_c)
+2(1+\varepsilon)L_\Sigma.
}
\]

For `k=5`, the height coefficient is `5 epsilon - 2`.  Thus scalar residue
accounting alone cannot force fifth roots for small epsilon.

## 2. One selected fourth root

At least one endpoint satisfies

\[
\boxed{
24(1+\varepsilon)q_i
>
5\varepsilon h+6C-2(1+\varepsilon)L_\Sigma.
}
\]

Hence the selected fourth-power divisor has logarithmic size

\[
4q_i>
\frac{5\varepsilon}{6(1+\varepsilon)}h-O(1).
\]

## 3. Moving coefficient saving

Write the selected endpoint as

\[
n=A d^4,
\qquad
T=\log n,
\quad
K=\log A,
\quad
q=\log d.
\]

Since `T=K+4q` and `T<=h`,

\[
\boxed{
6(1+\varepsilon)K
<
(6+\varepsilon)h-6C+2(1+\varepsilon)L_\Sigma.
}
\]

Thus

\[
\frac Kh
<
1-rac{5\varepsilon}{6(1+\varepsilon)}+o(1).
\]

The quartic coefficient has genuine power-saving height.

## 4. Sharpness below exponent five

For every `0<epsilon<2/5`, the explicit scalar model

\[
h=2(1+\varepsilon),
\quad T_m=2+\varepsilon,
\quad T_M=T_c=2(1+\varepsilon),
\]

\[
r_m=(2+\varepsilon)/4,
\quad r_M=r_c=(1+\varepsilon)/2,
\quad q_m=q_M=q_c=0
\]

satisfies all fifth-power residue budgets and the scalar abc-violation
inequality.  Therefore any proof beyond the quartic frontier must exploit the
additive equation or arithmetic geometry, not only independent endpoint
budgets.

## 5. Split-square descent

If the two large endpoints are squares,

\[
M=x^2,
\qquad c=y^2,
\]

then

\[
m=(y-x)(y+x).
\]

Writing `Td=log(y-x)` and `hy=log y`, the short-gap inequality descends exactly
to

\[
\boxed{(1+\varepsilon)T_d<h_y.}
\]

This reduces the split-square branch to the smaller adjacent root equation

\[
(y-x)+x=y.
\]

## 6. Lean files

```text
Lean/IUTThreeClosures/ThreeEndpointAggregateKthRoot.lean
Lean/IUTThreeClosures/ThreeEndpointAggregateFourthRoot.lean
Lean/IUTThreeClosures/FourthPowerCoefficientSaving.lean
Lean/IUTThreeClosures/FifthRootAggregateSharpness.lean
Lean/IUTThreeClosures/SplitSquareEndpointDescent.lean
```

No file assumes the abc conjecture, an arithmetic-existence theorem, or a
height conclusion.
