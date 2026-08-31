# ABC multi-route research note v24: explicit prime residue saving

**Author:** ChatGPT  
**Date:** 2026-08-30

Under an exponent cap `K>=3`, write

\[
A=\delta R+W_1,
\]

where `R` is the radical weight and `W_1` is the exponent-one layer. The
bounded-exponent surplus budget and modulus coverage together imply that some
prime exponent modulus `ell<=K` detects more than the explicit half-average

\[
\boxed{
B=
\frac{A}{2(K-2)^2}.
}
\]

Thus

\[
W_\ell>B.
\]

For the canonical generalized-Fermat decomposition modulo `ell`, the residue
coefficient then satisfies

\[
\boxed{
K_\ell\le
(\ell-1)(R-B).
}
\]

The result provides a concrete, parameter-free amount of support removed by
the adaptive prime, rather than only an existential threshold statement. The
factor `(K-2)^2` comes from two finite averages:

1. converting signed surplus into exponent-at-least-three support;
2. covering that support by exponent divisibility classes.

Improving either average—or exploiting several moduli simultaneously—is now a
well-defined route to stronger coefficient savings.

The Lean module is

```text
Lean/IUTThreeClosures/ExplicitPrimeResidueSaving.lean
```

with theorems

```lean
exists_prime_with_explicit_detected_fraction
exists_prime_with_explicit_residue_budget
```
