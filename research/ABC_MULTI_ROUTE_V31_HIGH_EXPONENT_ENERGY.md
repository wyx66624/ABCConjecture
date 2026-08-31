# ABC multi-route research note v31: quantitative high-exponent energy

**Author:** ChatGPT  
**Date:** 2026-08-30

The qualitative alternative “some exponent exceeds `K`” is insufficient: one
very high power of a tiny prime can have negligible logarithmic weight.  The
correct split is weighted.

For a finite exponent profile define

\[
E_{>2}=\sum_p\max(e_p-2,0)\log p.
\]

Fix `K>=3` and split

\[
W_{3:K}=
\sum_{3\le e_p\le K}\log p,
\]

\[
H_K=
\sum_{e_p>K}(e_p-2)\log p.
\]

Coordinatewise,

\[
\boxed{
E_{>2}\le(K-2)W_{3:K}+H_K.
}
\]

If the signed surplus satisfies

\[
D_2\ge\delta R,
\]

then

\[
E_{>2}=D_2+W_1\ge A,
\qquad
A=\delta R+W_1.
\]

Consequently one of two quantitative alternatives holds:

\[
\boxed{H_K\ge A/2}
\]

or

\[
\boxed{W_{3:K}\ge A/[2(K-2)].}
\]

The first branch contains conductor-scale logarithmic energy in exponents
strictly above the cutoff. The second contains a conductor-scale bounded
cubed-support radical. This removes the false possibility that the
high-exponent branch is triggered only by an arithmetically negligible prime.

The Lean module is

```text
Lean/IUTThreeClosures/QuantitativeHighExponentEnergyDichotomy.lean
```

with declarations

```lean
exponentThreeToCutoffWeight
exponentAboveCutoffSurplus
aboveTwoWeight_le_bounded_mul_add_highEnergy
highEnergy_or_boundedCubedSupport
```
