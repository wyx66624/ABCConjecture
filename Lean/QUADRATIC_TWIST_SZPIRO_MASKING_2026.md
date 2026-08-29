# Quadratic-twist masking in the Frey–Szpiro route

**Author:** ChatGPT  
**Date:** 2026-08-28  
**Status:** unconditional algebraic audit; not a proof of Szpiro or the abc conjecture

## 1. Question

A natural amplification proposal starts with the Frey curve attached to a primitive triple `a+b=c`, takes many quadratic twists, applies an almost-all Szpiro theorem to the twist family, and tries to transfer one good twisted inequality back to the original Frey curve.

The proposal has a real advantage: it creates an arbitrarily large fibre over a single source curve. It also has a hidden danger: a large twist changes the discriminant and conductor in fixed proportions and can make the twisted Szpiro ratio look typical even when the base curve has a large Szpiro excess.

This note computes that effect exactly.

## 2. Clean logarithmic twist model

Away from the finitely many primes where local minimalization requires corrections, a squarefree quadratic twist has the characteristic logarithmic transformation

`D_d = D + 6 t`,

`N_d = N + 2 t`,

where

- `D = log |Delta_min(E)|`,
- `N = log N(E)`,
- `t = log |d|`,
- `D_d` and `N_d` are the corresponding twisted logarithms.

The detailed local behavior, including residue characteristics `2` and the various Kodaira types, is governed by Tate's algorithm. Barrios–Roy–Sahajpal–Tallana–Tobin–Wiersema, *Local data of elliptic curves under quadratic twist*, arXiv:2501.03209, gives necessary and sufficient local criteria for the minimal discriminant valuation and conductor exponent of a twist. The Lean module accompanying this note does **not** assume a global exact formula; it studies the algebra after any local argument has supplied the clean terms, with fixed-prime corrections absorbed into an additive constant.

For an affine Szpiro inequality

`D <= q N + C`,

define the base excess

`Exc_q(E;C) = D - q N - C`.

Then the twisted inequality

`D_d <= q N_d + C`

is equivalent to

`Exc_q(E;C) <= (2q-6)t`.

This identity is the entire masking mechanism.

## 3. Three exponent regimes

### 3.1. The critical exponent `q=3`

When `q=3`, the twist term cancels:

`2q-6 = 0`.

Therefore

`D_d <= 3 N_d + C`

if and only if

`D <= 3 N + C`.

At exponent three, quadratic twisting is logically neutral. No amount of twisting can manufacture a good curve from a bad base curve, and one good twist immediately proves the same bound for the base curve.

### 3.2. Exponents below three

When `q<3` and `t>=0`, the masking coefficient is negative. A good nonnegative twist implies

`Exc_q(E;C) <= (2q-6)t <= 0`,

so the base curve was already good. Twisting cannot hide a violation.

### 3.3. Exponents above three

When `q>3`, the coefficient is positive. A good twist must satisfy

`t >= Exc_q(E;C)/(2q-6)`.

Conversely, once this threshold is reached, the clean twisted inequality holds. Thus a sufficiently large twist can absorb an arbitrarily large positive base excess.

This is why the statement

> for every fixed elliptic curve, almost all sufficiently large twists have ratio close to three

cannot by itself imply a uniform theorem for the original curves. The threshold at which the twist becomes good may already encode the entire unknown base excess.

## 4. Exact transferred error from a small good twist

Suppose a good twist is found with

`t <= eta H`,

where `H` is the logarithmic height scale of the base curve. Then

`D <= qN + C + (2q-6) eta H`.

The residual slope is exact.

Two specializations are important.

### 4.1. Near the twist-critical exponent

For `q=3+epsilon`,

`2q-6 = 2epsilon`.

A uniformly sublinear twist, `t=o(H)`, transfers the twisted bound to

`D <= (3+epsilon)N + C + o(H)`.

This would be extremely strong, but the useful content lies precisely in proving that a good twist occurs before the masking threshold. An almost-all theorem whose constants and starting point depend arbitrarily on the base curve is insufficient.

### 4.2. At the classical Szpiro exponent

For `q=6+epsilon`,

`2q-6 = 6+2epsilon`.

The transferred error is

`(6+2epsilon)t`.

Even a polynomially sized twist can consume a substantial fraction of the base height. A successful classical-Szpiro transfer therefore needs a quantitatively small twist and a uniform treatment of the local correction terms.

## 5. Relation to current almost-all results

Stephanie Chan's revised paper *Almost all elliptic curves with prescribed torsion have Szpiro ratio close to the expected value*, arXiv:2407.13850 (version dated March 22, 2026), explicitly warns that an almost-all theorem in the ambient family does not automatically apply to thin families. It also records Wong's theorem that Frey curves

`y^2 = x(x+a)(x+b)`

have Szpiro ratio at most `2+epsilon` outside a density-zero exceptional set in the Frey family when ordered by naive height.

These results are genuine evidence that high Szpiro ratios are statistically rare, but they do not give a uniform statement for every Frey curve. Quadratic-twist amplification would need to establish all of the following simultaneously:

1. a twist fibre attached to every source Frey curve;
2. a relative exceptional bound inside that fibre;
3. a good twist with `log |d|` bounded in terms of the base height;
4. uniform additive constants and uniform control of the primes `2`, `3`, and primes dividing the base conductor;
5. a transfer exponent whose residual term is absorbable in the final abc budget.

Without item 3, large twists can be good solely because they mask the base excess.

## 6. A precise surviving theorem target

A non-circular twist-amplification theorem can be stated as follows.

For every `epsilon>0`, construct constants `C_epsilon` and a function `eta(H)->0` such that for every Frey curve `E` of logarithmic height `H`, there exists a squarefree twist parameter `d`, satisfying the required local coprimality conditions, with

`log |d| <= eta(H) H`,

and

`log |Delta_min(E^d)| <= (3+epsilon) log N(E^d) + C_epsilon`.

The masking identity then yields

`log |Delta_min(E)| <= (3+epsilon) log N(E) + C_epsilon + o(H)`.

This target is much stronger than a nonuniform density-one theorem in each fixed twist family. It asks for a uniform small good twist. The repository retains this strengthened route; the present note only eliminates the naive inference from unrestricted large twists.

A weaker target at exponent `6+epsilon` is also possible, but the permitted twist size must be correspondingly smaller because the masking coefficient is `6+2epsilon`.

## 7. Lean formalization

`IUTThreeClosures/QuadraticTwistSzpiroMasking.lean` proves:

- the exact equivalence between a twisted bound and the base-excess masking inequality;
- exact invariance at exponent `3`;
- transfer from a good twist to the base for every `q<=3`;
- the necessary and sufficient excess-ratio threshold for `q>3`;
- the residual base-height error produced by a small good twist;
- the coefficients `2epsilon` at `3+epsilon` and `6+2epsilon` at `6+epsilon`.

No elliptic-curve local theorem, almost-all theorem, Szpiro conjecture, or abc conjecture is postulated as a Lean axiom.

## 8. Verdict

The unrestricted quadratic-twist amplification argument does not close the Frey–Szpiro route. Above exponent three, large twists can hide an arbitrarily bad base curve; at exponent three they are exactly neutral. The route remains viable only in the quantitatively stronger form of a **uniform small-good-twist theorem** with controlled local corrections.
