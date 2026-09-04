# ABC multi-route research note v22: exact power-layer divisor

**Author:** ChatGPT  
**Date:** 2026-08-30

Let a finite exponent profile represent

\[
N=\prod_i b_i^{e_i}.
\]

For a layer `j`, define

\[
D_j=\prod_{e_i\ge j}b_i.
\]

Then

\[
\boxed{D_j^j\mid N.}
\]

The complementary quotient is explicit:

\[
Q_j=
\prod_{e_i\ge j}b_i^{e_i-j}
\prod_{e_i<j}b_i^{e_i},
\]

and

\[
\boxed{D_j^jQ_j=N.}
\]

No primality or unique-factorization hypothesis on the displayed bases is
needed for this formal identity.

Combined with the layer-cake selector, conductor-scale positive exponent
two-surplus yields a layer whose logarithmic prime weight is large and whose
corresponding power divides the large-endpoint product. This creates a direct
bridge from the abstract surplus ledger to powerful-divisor, short-gap, and
generalized Pell/Fermat analyses.

The Lean module is

```text
Lean/IUTThreeClosures/PowerLayerDivisorExtraction.lean
```

with declarations

```lean
exponentAtLeastLayerProduct
exponentLayerQuotient
layerProduct_pow_mul_quotient_eq_profile
layerProduct_pow_dvd_profile
layerProduct_pow_le_profile
layerProduct_ne_zero
```
