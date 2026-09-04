# ABC multi-route research note v16: exponent-two surplus dichotomy

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Finite exponent profile

Let a finite prime support carry nonnegative weights

\[
w_p=\log p
\]

and positive exponents `e_p`. Define

\[
D_2=\sum_p(e_p-2)w_p,
\]

\[
E_{>2}=\sum_p\max(e_p-2,0)w_p,
\]

and

\[
W_1=\sum_{e_p=1}w_p.
\]

Then, coordinate by coordinate,

\[
e-2=\max(e-2,0)-\mathbf 1_{e=1}.
\]

Therefore

\[
\boxed{D_2=E_{>2}-W_1.}
\]

This is the exact reason the signed aggregate surplus is better than the
primewise cubeful positive part: exponent-one primes pay directly against the
mass above exponent two.

## 2. Bounded-exponent branch

Let

\[
W_{\ge3}=\sum_{e_p\ge3}w_p,
\qquad
R=\sum_p w_p.
\]

If every exponent is at most `K`, then

\[
E_{>2}\le(K-2)W_{\ge3}.
\]

Consequently, whenever

\[
D_2\ge\delta R,
\]

we have the exact budget

\[
\boxed{
\delta R+W_1\le(K-2)W_{\ge3}.
}
\]

In particular,

\[
\boxed{
W_{\ge3}\ge\frac{\delta}{K-2}R
}
\]

when `K>2`.

Thus a positive conductor-scale aggregate surplus cannot be produced by a
negligible cubed support if all prime exponents remain bounded.

## 3. High-exponent/broad-cubed-support dichotomy

For every cutoff `K`, a profile with

\[
D_2\ge\delta R
\]

satisfies one of two alternatives:

1. there is a prime with exponent greater than `K`;
2. the cubed-support radical satisfies
   \[
   \delta R+W_1\le(K-2)W_{\ge3}.
   \]

This is the deterministic split needed for the remaining ABC route.

### High-exponent branch

A prime power of exponent larger than `K` occurs in one of the two large
adjacent endpoints.  This is the branch for generalized-Fermat, linear-forms,
local lifting, and modular methods.  The exponent cutoff can be taken as large
as required before the point is chosen.

### Broad cubed-support branch

If all exponents are bounded, a fixed positive fraction of the pair radical
lies on primes occurring at least cubically.  This branch is closer to a
powerful-number or orbifold-support problem and can be attacked by counting,
short-interval, and source-uniform height methods.

## 4. Relation to an ABC violation

The large-pair aggregate ledger gives

\[
2h\le\log2+2R+D_2.
\]

Hence a violation

\[
h>(1+\epsilon)R+C
\]

forces

\[
D_2>2\epsilon R+2C-\log2.
\]

After discarding the fixed constant at large height, the exponent profile of
the two large endpoints enters the dichotomy with `delta` arbitrarily close
to `2epsilon`.

Therefore every hypothetical unbounded counterexample sequence must choose
one of the following persistent mechanisms:

- unbounded individual prime exponents; or
- conductor-scale radical mass supported on cubed primes while exponents stay
  bounded.

This is a stricter structural statement than the qualitative assertion that
some prime cube occurs.

## 5. Lean deliverable

The corresponding module is

```text
Lean/IUTThreeClosures/ExponentTwoSurplusDichotomy.lean
```

with core declarations

```lean
exponentSignedTwoSurplus
exponentAboveTwoWeight
exponentOneLayerWeight
exponentAtLeastThreeWeight
signedTwoSurplus_eq_aboveTwo_sub_one
aboveTwoWeight_le_cap_mul_atLeastThreeWeight
signedTwoSurplus_nonpos_of_cap_two
cubedSupport_budget_of_signedSurplus_and_cap
highExponent_or_cubedSupport_budget
delta_radical_le_cap_mul_cubedSupport
```

No modularity theorem, distribution result, or ABC estimate is assumed.
