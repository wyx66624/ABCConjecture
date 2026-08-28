# Frey-model convex-slope barrier

**Author:** ChatGPT  
**Date:** 2026-08-28  
**Status:** unconditional scalar theorem; no claim of a modified-Szpiro proof

## 1. General principle

Suppose model `i` supplies a conductor inequality of asymptotic slope `s_i`
and its discriminant or model height controls the abc height only through

\[
r_i\log c\le H_i+O(1).
\]

Then the resulting abc coefficient is approximately `s_i/r_i`.

Take nonnegative weights `w_i`.  If every component ratio obeys

\[
q r_i\le s_i,
\]

then

\[
q\sum_i w_i r_i\le \sum_i w_i s_i.
\]

Therefore

\[
\frac{\sum_i w_i s_i}{\sum_i w_i r_i}\ge q.
\]

A nonnegative average cannot improve the best available component ratio.

The two-model form is Lean theorem

```lean
nonnegative_two_model_combination_preserves_ratio
```

in `FreyConvexSlopeBarrier.lean`.

## 2. Application to the two explicit Frey models

The repository's direct discriminant calculations give the asymptotic height
exponents

\[
r_4=4,\qquad r_5=5.
\]

The critical Szpiro slope is

\[
s_4=s_5=6.
\]

For nonnegative weights `w_4,w_5`, not both zero, the combined ratio is

\[
R(w_4,w_5)=
\frac{6(w_4+w_5)}{4w_4+5w_5}.
\]

Since

\[
R(w_4,w_5)\ge\frac65>1,
\]

no nonnegative averaging of the original and quotient discriminant estimates
can reach the abc coefficient `1`.  Equality `6/5` is approached only by
putting all weight on the fifth-power model; adding the fourth-power model
strictly worsens the ratio.

Lean theorems:

```lean
combined_ratio_ge_six_fifths
combined_ratio_strictly_above_one
no_nonnegative_two_model_average_reaches_abc_coefficient
```

## 3. Why the modified height is different

The modified integral height

\[
\log\max\{|c_4|^3,|\Delta|\}
\]

has an exact corridor

\[
6\log c\le H_{\mathrm{mod}}
\le6\log c+O(1)
\]

for the displayed Frey model.  Its scalar ratio is therefore

\[
\frac66=1.
\]

This explains why a uniform modified-Szpiro inequality at slope `6+o(1)`
would close abc, while direct inequalities for the two displayed
discriminants do not.

## 4. Consequences for route selection

The barrier rules out only **nonnegative scalar averaging** of the two existing
model inequalities.  A viable breakthrough must introduce at least one new
ingredient:

1. a source-derived model height with lower growth exponent `6`;
2. a new Frey model whose discriminant grows with exponent at least `6` while
   its conductor remains radical-controlled;
3. a cross-model identity with genuine cancellation not representable by
   nonnegative averaging;
4. a global estimate with slope strictly below `6` for a fifth-power model;
5. an arithmetic-geometric invariant, such as a Faltings or modular height,
   that controls `6 log c` directly.

Items 1 and 5 point back to the repository's modified-height gate.  The hard
problem remains proving its uniform global conductor estimate without
assuming abc, Szpiro, or an equivalent height inequality.

## 5. Route verdict

The two-model averaging subroute is closed by an explicit scalar obstruction.
The broader Frey--modified-Szpiro route remains open and should concentrate on
constructing or estimating a genuine exponent-six height rather than adding
more nonnegative combinations of exponent-four and exponent-five
 discriminants.
