# ABC multi-route research note v20: dyadic companion excess and lift primes

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Why the dyadic family is the first irreducible test case

The family

\[
1+2^k=2^k+1
\]

satisfies the one-sided concentration condition automatically for every
`k>=3`.  Therefore all remaining arithmetic information lies in the companion
`2^k+1`.

Let

\[
N_k=2^k+1,
\qquad
E(N_k)=\log N_k-\log\operatorname{rad}(N_k).
\]

The corresponding abc point has

\[
h_k=\log N_k
\]

and exact conductor

\[
R_k=\log2+\log\operatorname{rad}(N_k).
\]

Consequently

\[
\boxed{h_k-R_k=E(N_k)-\log2.}
\]

Thus the full abc defect on this family is precisely the repeated-prime mass
of the companion, apart from the fixed prime-two term.

## 2. Exact restricted equivalence

Define dyadic-plus abc to mean that, for every `epsilon>0`, one constant works
for every positive exponent `k`:

\[
h_k\le(1+\epsilon)R_k+C_\epsilon.
\]

This is equivalent to the concrete estimate

\[
\boxed{
E(N_k)
\le
\epsilon\log\operatorname{rad}(N_k)+K_\epsilon
}
\]

uniformly in `k`.

The two directions differ only by a fixed multiple of `log 2`.  Hence even
this very special endpoint family already requires a sublinear weighted bound
on repeated prime factors of cyclotomic values.

## 3. Repeated factors are lift primes

If

\[
p^2\mid 2^k+1,
\]

then

\[
p^2\mid(2^k-1)(2^k+1)=2^{2k}-1.
\]

Define a base-two lift prime at index `n` by

\[
p^2\mid2^n-1.
\]

Every prime occurring to exponent at least two in `N_k` is therefore a lift
prime at index `2k`.

If additionally

\[
2k\mid p-1,
\]

then

\[
2^{2k}-1\mid2^{p-1}-1,
\]

and hence

\[
\boxed{p^2\mid2^{p-1}-1.}
\]

Thus repeated primitive companion factors are standard base-two Wieferich
primes once their multiplicative-order condition is supplied.  Nonprimitive
repeated factors must be analyzed through index lifting and LTE-type terms.

## 4. Exact remaining dyadic obstruction

The dyadic subproblem has now been reduced to a weighted statement:

> the total logarithmic mass
> \[
> \sum_{p^e\parallel N_k}(e-1)\log p
> \]
> carried by lift primes at index `2k` must be
> `o(log rad(N_k))` uniformly.

A proof must control both sources of repeated valuation:

1. first-order or Wieferich lifting at the primitive rank;
2. additional valuation caused by divisibility of the exponent index.

The second contribution is tied to the arithmetic of `k` and is expected to
be lower-order.  The first is the genuine weighted-Wieferich barrier already
visible in the repository's Mersenne route.

## 5. Lean formalization

The module

```text
Lean/IUTThreeClosures/DyadicPlusCompanionExcess.lean
```

contains:

```lean
dyadicPlusPoint_height
dyadicPlusPoint_conductor
dyadicPlusPoint_height_sub_conductor
repeated_plus_divisor_is_liftPrime
repeated_companion_prime_is_liftPrime
repeated_plus_divisor_is_wieferich
dyadicPlusABC_of_uniformRepeatedExcess
uniformRepeatedExcess_of_dyadicPlusABC
uniformRepeatedExcess_iff_dyadicPlusABC
dyadicPlusPoint_height_le_conductor_of_radical_eq
```

The target module and the complete pinned project were built locally.  No
`axiom`, `sorry`, or `admit` is introduced.

This closes the squarefree companion subcase and identifies the exact
repeated-prime obstruction; it does not yet prove the required weighted lift-
prime estimate.
