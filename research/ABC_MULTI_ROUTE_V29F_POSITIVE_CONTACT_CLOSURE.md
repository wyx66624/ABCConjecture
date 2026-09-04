# ABC multi-route research note v29f: the positive right-contact branch closes

**Author:** ChatGPT  
**Date:** 2026-08-31

## 1. Scaled contact

For canonical residual data

\[
RA+m=SB,
\]

choose a Bezout solution

\[
Rx+Sy=1
\]

and the corresponding affine parameter `t`.  Define

\[
g=t+mxy.
\]

The exact scaled right-contact identity is

\[
\boxed{Rg=B-mSy^2}.
\]

The shared-support identity also gives

\[
\operatorname{rad}(S)\mid g.
\]

## 2. Positive-contact closure

Assume `g>0`.  Since `mSy^2>=0`,

\[
Rg\le B.
\]

Because `rad(S)` is a positive divisor of `g`,

\[
R\operatorname{rad}(S)\le Rg\le B.
\]

The endpoint `RA` is the larger summand, hence

\[
SB=c\le2RA.
\]

Multiplying the first inequality by `S` and comparing with the second gives

\[
RS\operatorname{rad}(S)\le SB\le2RA.
\]

Canceling `R` yields

\[
\boxed{S\operatorname{rad}(S)\le2A}.
\]

Since `rad(S)>=1`,

\[
\boxed{S\le2A}.
\]

Therefore

\[
c=SB\le2AB.
\]

For a primitive abc triple,

\[
AB\le\operatorname{rad}(abc),
\]

so the branch satisfies the strong coefficient-one inequality

\[
\boxed{c\le2\operatorname{rad}(abc)}.
\]

No epsilon loss is needed.

## 3. Consequence

A genuine unbounded abc counterexample cannot remain in the positive
right-contact branch.  For every chosen Bezout representative it must instead
fall into one of the following cases:

1. `g=0`, where
   \[
   B=mSy^2
   \]
   is the exact square-collapse boundary;
2. `g<0`, where, writing `h=-g>0`,
   \[
   \boxed{B+Rh=mSy^2}
   \]
   is a positive square-bearing equation.

Thus the remaining exponent-height problem has been reduced to a definite
negative-contact Pell-type branch plus the exact square-collapse boundary.

## 4. Reduced Bezout representative

Every Bezout solution is of the form

\[
x_k=x+kS,\qquad y_k=y-kR.
\]

Choose `k` so that

\[
|y_k|\le R/2.
\]

Then a failure of the positive branch forces

\[
B\le mS y_k^2\le\frac14mSR^2.
\]

Hence every unresolved canonical solution satisfies the explicit necessary
condition

\[
\boxed{4B\le mSR^2}.
\]

This inequality is not yet sufficient to prove abc, but it is an archimedean
constraint absent from the original exponent-vector formulation.

## 5. Lean deliverable

The scalar closure is formalized in

```text
Lean/IUTThreeClosures/PositiveRightContactClosure.lean
```

with the theorems

```lean
right_support_le_two_left_residual
right_modulus_le_two_left_residual
right_endpoint_le_two_residual_product
positive_right_contact_strong_abc_ledger
```

The module assumes only the scaled-contact identity, positivity, and the
large-endpoint comparison.  It does not assume an abc estimate.
