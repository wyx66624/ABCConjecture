# ABC multi-route research note v17: adaptive exponent-modulus coverage

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. From broad cubed support to a useful modulus

The exponent-two surplus dichotomy shows that, under an exponent cap `K`, a
positive signed surplus forces a large radical weight

\[
W_{\ge3}=\sum_{e_p\ge3}\log p
\]

on primes occurring at least cubically.  To connect this information to
modular and level-lowering methods, one must select an exponent modulus which
actually detects a large portion of that support.

For an integer modulus `n`, define

\[
W_n=\sum_{n\mid e_p}\log p.
\]

Every exponent `e_p` in the interval `[3,K]` is divisible by at least one
modulus in the same interval: by `e_p` itself. Therefore

\[
\boxed{
W_{\ge3}
\le
\sum_{n=3}^{K}W_n.
}
\]

This is a finite covering statement, not a modularity theorem.

## 2. Adaptive selector

If every `W_n` were at most `B`, then

\[
W_{\ge3}\le
\#\{3,\ldots,K\}\,B.
\]

Hence, whenever

\[
\#\{3,\ldots,K\}\,B<W_{\ge3},
\]

there exists some `n` with

\[
3\le n\le K,
\qquad
W_n>B.
\]

Combining this with the bounded-exponent surplus budget

\[
\delta R+W_1\le(K-2)W_{\ge3}
\]

gives the quantitative condition

\[
(K-2)\#\{3,\ldots,K\}\,B
<
\delta R+W_1
\]

under which an adaptive modulus detects more than `B` logarithmic radical
weight.

Thus the bounded-exponent branch does not merely contain many cubed primes in
aggregate. It contains a single exponent-divisibility class carrying a
quantitatively large amount of radical mass.

## 3. Why the modulus is initially allowed to be composite

The elementary covering argument naturally selects an integer modulus in
`[3,K]`. If `n` is composite, any prime divisor `ell|n` detects every
coordinate detected by `n`, because

\[
n\mid e_p\Longrightarrow\ell\mid e_p.
\]

Therefore a later local refinement can replace the selected modulus by a
prime divisor without losing detected mass. The present Lean module already
formalizes monotonicity under passage to a divisor; the prime-selector wrapper
is separated to avoid importing any arithmetic geometry before it is needed.

## 4. Remaining arithmetic input

The selector turns the bounded-exponent route into a concrete modular target:

> for a primitive endpoint-degenerate abc family, show that a prime exponent
> modulus detecting conductor-scale radical mass produces enough conductor or
> level drop to contradict the required positive signed surplus.

The high-exponent branch remains separate and is directed toward
large-exponent generalized-Fermat, local lifting, and linear-form methods.

## 5. Lean deliverable

The new module is

```text
Lean/IUTThreeClosures/ExponentModulusCoverageSelector.lean
```

with declarations

```lean
exponentDivisibleWeight
exponentDivisibleWeight_nonneg
exponentDivisibleWeight_mono_of_dvd
coordinate_weight_le_modulus_cover
atLeastThreeWeight_le_sum_divisibleWeight_Icc
atLeastThreeWeight_le_card_mul_of_each_le
exists_modulus_of_surplus_budget
Icc_three_nonempty
```

No modularity, level-lowering, distribution, or abc theorem is assumed.
