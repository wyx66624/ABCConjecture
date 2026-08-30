# ABC multi-route research note v19: small gap or three multiplicity-heavy coordinates

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Setup

Let

\[
a+b=c,\qquad
m=\min(a,b),\qquad
M=\max(a,b),
\]

and write

\[
h=\log c,\qquad
R=\log\operatorname{rad}(abc),\qquad
E(n)=\log n-\log\operatorname{rad}(n).
\]

Assume that for some `epsilon>0` and constant `C`,

\[
(1+\varepsilon)R+C<h.
\]

The v17 theorem already forces positive-height multiplicity excess in `c`
and `M`.

## 2. The smaller endpoint

Because `m` divides `abc`,

\[
\log\operatorname{rad}(m)\le R.
\]

Hence

\[
(1+\varepsilon)\log\operatorname{rad}(m)+C<h.
\]

Subtracting from `(1+epsilon)log m` gives

\[
\boxed{
(1+\varepsilon)\log m-h+C
  <(1+\varepsilon)E(m).
}
\]

If a balance exponent `tau` satisfies

\[
\tau h\le\log m,
\]

then

\[
\boxed{
\bigl((1+\varepsilon)\tau-1\bigr)h+C
  <(1+\varepsilon)E(m).
}
\]

Whenever

\[
\tau>\frac1{1+\varepsilon},
\]

the coefficient of `h` on the left is strictly positive.

## 3. Exact dichotomy

For every real `tau`, every violation satisfies one of the following.

### Small-gap branch

\[
\boxed{
\log m<\tau h,
}
\]

or equivalently

\[
m<c^\tau.
\]

### Three-coordinate multiplicity branch

All three coordinates satisfy explicit repeated-prime lower bounds:

\[
\varepsilon h+C<(1+\varepsilon)E(c),
\]

\[
\varepsilon h+C-(1+\varepsilon)\log2
  <(1+\varepsilon)E(M),
\]

and

\[
\bigl((1+\varepsilon)\tau-1\bigr)h+C
  <(1+\varepsilon)E(m).
\]

Thus, by choosing any

\[
\frac1{1+\varepsilon}<\tau<1,
\]

a counterexample must be either a genuinely power-saving additive gap or a
triple in which every coordinate contains a square divisor of positive height
exponent.

## 4. Research consequence

This separates the remaining arithmetic into two sharply different problems.

1. **Small-gap branch:** control two multiplicity-heavy coprime integers at
distance below `c^tau`.
2. **Three-heavy branch:** write
   \[
   a=u x^2,\quad b=v y^2,\quad c=w z^2
   \]
   with all three square roots of positive height exponent, and attack the
   resulting moving-coefficient ternary quadratic equation
   \[
   u x^2+v y^2=w z^2.
   \]

Neither branch is closed by an ordinary density theorem.  A pointwise theorem
must use the simultaneous coprimality, the additive relation, and the large
square parts.

## 5. Lean deliverable

```text
Lean/IUTThreeClosures/SmallEndpointMultiplicityDichotomy.lean
```

Main declarations:

```lean
ABCPoint.radical_endpointMin_le_abcRadical
ABCPoint.log_radical_endpointMin_le_conductor
ABCPoint.multiplicityExcess_endpointMin_lower_of_abc_violation
ABCPoint.multiplicityExcess_endpointMin_large_of_balance
ABCPoint.small_gap_or_all_three_have_multiplicityExcess
ABCPoint.endpointMin_positive_slope_of_supercritical_balance
```

No abc estimate or distribution theorem is assumed.
