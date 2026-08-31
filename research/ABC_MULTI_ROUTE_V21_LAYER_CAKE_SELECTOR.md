# ABC multi-route research note v21: layer-cake power selection

**Author:** ChatGPT  
**Date:** 2026-08-30

For a positive exponent `e`,

\[
e-2=\#\{j:3\le j\le e\}.
\]

Therefore a finite exponent profile satisfies the exact layer-cake identity

\[
\boxed{
E_{>2}=
\sum_{j=3}^{K}W_{\ge j}
}
\]

when all exponents are at most `K`, where

\[
E_{>2}=\sum_p\max(e_p-2,0)\log p,
\qquad
W_{\ge j}=\sum_{e_p\ge j}\log p.
\]

Using

\[
D_2=E_{>2}-W_1,
\]

this becomes

\[
\boxed{
D_2+W_1=
\sum_{j=3}^{K}W_{\ge j}.
}
\]

Consequently, if

\[
D_2\ge\delta R
\]

and

\[
\#\{3,\ldots,K\}\,B<\delta R+W_1,
\]

there exists a layer `j` with

\[
\boxed{W_{\ge j}>B.}
\]

The selected layer has a direct divisibility interpretation: the product of
its primes, raised to the `j`-th power, divides the original integer. Thus the
positive signed surplus yields either a large nested power divisor or, when no
finite exponent cap is available, the separate high-exponent branch.

This selector is distinct from exponent-divisibility selection. The latter is
adapted to level lowering modulo a prime; the layer selector is adapted to
powerful-divisor extraction, short-gap counting, and generalized Pell/Fermat
parametrizations.

The Lean module is

```text
Lean/IUTThreeClosures/ExponentLayerCakeSelector.lean
```

with declarations

```lean
exponentAtLeastLayerWeight
coordinate_aboveTwo_eq_layer_sum
aboveTwoWeight_eq_sum_layers
signedSurplus_add_one_eq_sum_layers
aboveTwoWeight_le_card_mul_of_each_layer_le
exists_power_layer_of_signedSurplus
```
