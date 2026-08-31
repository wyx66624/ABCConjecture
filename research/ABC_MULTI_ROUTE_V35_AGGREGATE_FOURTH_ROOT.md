# ABC multi-route research note v35: aggregate fourth-root gain

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Purpose

The previous three-endpoint fourth-root argument first selected an endpoint
with a small share of the radical and then applied the fourth-power residue
budget there.  That procedure is valid, but it discards the other two endpoint
budgets.  Summing all three first yields a stronger and cleaner quantitative
frontier.

This note proves the aggregate inequality and records its consequence for the
remaining non-short-gap branch.  It does not assert that the resulting moving
quartic equation has already been solved.

## 2. Endpoint data

Write

\[
m=\min(a,b),\qquad M=\max(a,b),\qquad m+M=c,
\]

and put

\[
h=\log c.
\]

Let

\[
T_m=\log m,\qquad T_M=\log M,\qquad T_c=h
\]

and let

\[
r_m+r_M+r_c=R=\log\operatorname{rad}(abc).
\]

For the canonical fourth-power decomposition of each endpoint, let
\(q_m,q_M,q_c\) denote the logarithmic sizes of the extracted fourth roots.
The exact exponent-residue decomposition gives, endpoint by endpoint,

\[
T_i\le 3r_i+4q_i.
\]

No conjectural estimate is used here.

## 3. Non-short-gap lower bounds

In the non-short-gap branch used in the existing reduction, the small endpoint
satisfies a lower bound of the form

\[
(2+\varepsilon)h-2(1+\varepsilon)L_m
\le 2(1+\varepsilon)T_m.
\]

The two large endpoints satisfy

\[
h-L_M\le T_M,
\qquad
h-L_c\le T_c.
\]

Normally \(L_c=0\) and \(L_M\) is at most the fixed \(\log2\) loss, but the
formal theorem keeps all three losses explicit.

Assume a violation

\[
(1+\varepsilon)R+C<h.
\]

## 4. Aggregate derivation

Adding the three endpoint lower bounds after multiplication by
\(2(1+\varepsilon)\) gives

\[
(6+5\varepsilon)h
-2(1+\varepsilon)(L_m+L_M+L_c)
\le
2(1+\varepsilon)(T_m+T_M+T_c).
\]

The fourth-power residue budgets give

\[
T_m+T_M+T_c
\le
3R+4(q_m+q_M+q_c).
\]

Finally, multiplying the violation by six gives

\[
6(1+\varepsilon)R
<6h-6C.
\]

Combining these inequalities yields the exact aggregate gain

\[
\boxed{
5\varepsilon h+6C
<
8(1+\varepsilon)(q_m+q_M+q_c)
+2(1+\varepsilon)(L_m+L_M+L_c).
}
\]

Equivalently,

\[
q_m+q_M+q_c
>
\frac{
5\varepsilon h+6C
-2(1+\varepsilon)(L_m+L_M+L_c)
}{8(1+\varepsilon)}.
\]

This improves the earlier one-endpoint-first accounting because the full
height of both large endpoints and the power-saving height of the small
endpoint are retained before radical allocation.

## 5. One-endpoint extraction

At least one endpoint \(i\in\{m,M,c\}\) satisfies

\[
\boxed{
24(1+\varepsilon)q_i
>
5\varepsilon h+6C
-2(1+\varepsilon)(L_m+L_M+L_c).
}
\]

When the losses and \(C\) are bounded independently of the point, this becomes

\[
q_i
>
\left(
\frac{5\varepsilon}{24(1+\varepsilon)}-o(1)
\right)h.
\]

If the extracted root is \(d_i\), so that \(q_i=\log d_i\), then

\[
\log(d_i^4)
>
\left(
\frac{5\varepsilon}{6(1+\varepsilon)}-o(1)
\right)h.
\]

Thus every hypothetical non-short-gap counterexample contains an actual
fourth-power divisor of one endpoint whose logarithmic size is a fixed
positive proportion of the total height.

## 6. Interaction with the cube selector

The existing square-cube reduction also produces a height-scale cube root on
one of the two large endpoints.  The new quartic estimate therefore yields a
sharp two-case frontier:

1. the large cube root and the fourth root lie on different endpoints, giving
   a moving generalized-Fermat signature of type \((2,3,4)\) after the
   square decomposition of the third endpoint;
2. they lie on the same endpoint, forcing simultaneous height-scale cube and
   fourth-power concentration in one integer.

The next arithmetic task is to use coefficient support, pairwise coprimality,
and the moving-Pell residue constraints to rule out both cases.  Signature
information alone is insufficient because moving coefficients can carry the
remaining radical.

## 7. Lean module

The formalization is

```text
Lean/IUTThreeClosures/ThreeEndpointAggregateFourthRoot.lean
```

with declarations

```lean
fourthRootWeight
totalWeight_le_three_mul_radical_add_four_mul_fourthRootWeight
aggregate_fourthRoot_gain
one_of_three_fourthRoots_carries_aggregate_gain
one_endpoint_fourthRoot_gain
```

The module contains no `axiom`, `sorry`, or `admit` and assumes no ABC or
Diophantine height conclusion.
