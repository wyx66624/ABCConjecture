# ABC multi-route research note v18: prime refinement of the adaptive modulus

**Author:** ChatGPT  
**Date:** 2026-08-30

The modulus selected by the finite coverage argument may be composite. Let
`n` be such a modulus and let

\[
\ell=P^-(n)
\]

be its least prime factor. Then

\[
\ell\mid n,
\qquad
\ell\le n.
\]

For every exponent `e_p`,

\[
n\mid e_p\Longrightarrow\ell\mid e_p.
\]

Consequently the detected radical weights satisfy

\[
\boxed{W_n\le W_\ell.}
\]

Since the adaptive selector has `3<=n<=K`, the prime refinement satisfies

\[
\ell\le K.
\]

Thus the bounded-exponent positive-surplus branch produces an actual prime
exponent modulus whose divisibility class carries the same quantitative lower
bound obtained for the composite selector.

This is the exact deterministic input needed before applying a modular or
level-lowering argument. The remaining arithmetic theorem is no longer the
existence of a useful prime: it is to turn the conductor-scale mass of primes
with

\[
\ell\mid v_p(Mc)
\]

into a source-uniform height or level contradiction.

The Lean module is

```text
Lean/IUTThreeClosures/PrimeExponentModulusSelector.lean
```

with theorems

```lean
exists_prime_refinement_of_selected_modulus
exists_prime_modulus_of_surplus_budget
```

No modularity, level-lowering, or abc theorem is assumed.
