# ABC multi-route research note v20: positive cubeful excess forces a large cube part

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. General `k`-th-power extraction

For a finite prime-exponent profile with weights `w_i` and exponents `e_i`,
define

\[
T=\sum_i e_iw_i,
\qquad
R=\sum_iw_i,
\qquad
Q_k=\sum_i\left\lfloor\frac{e_i}{k}\right\rfloor w_i.
\]

The exact residue decomposition is

\[
e_i=(e_i\bmod k)+k\left\lfloor\frac{e_i}{k}\right\rfloor,
\]

and

\[
e_i\bmod k\le k-1.
\]

Therefore

\[
\boxed{
T\le(k-1)R+kQ_k.
}
\]

Equivalently,

\[
\boxed{
T-(k-1)R\le kQ_k.
}
\]

Thus any positive logarithmic mass remaining after `k-1` radical layers
forces a large canonical `k`-th-power root.

## 2. Cube specialization

At `k=3`, let `Q_3` be the logarithmic size of the canonical cube root.  Then

\[
\boxed{
T-2R\le3Q_3,
}
\]

and hence

\[
\boxed{
\frac{T-2R}{3}\le Q_3.
}
\]

The quantity `T-2R` is exactly the exponent mass that cannot be explained by
prime exponents zero, one, or two.  Positive cubeful excess therefore forces a
cube divisor of positive logarithmic size.

## 3. Consequence for putative abc counterexamples

For the two large endpoints `M=max(a,b)` and `c`, the v15 ledger gives

\[
\log(Mc)-2\log\operatorname{rad}(Mc)
\]

as the relevant cubeful mass, up to an explicitly controlled nonnegative
truncation.  An abc violation forces this mass to have a fixed positive height
slope.  Applying the present cube-extraction theorem shows that the product
`Mc` contains a cube divisor whose root also has a fixed positive height
exponent.

Together with v17 and v18, the remaining structure is now:

- both large nearby coprime endpoints have large square parts;
- at least one of them has a genuinely large cube part;
- in the non-small-gap branch the smaller endpoint also has a large square
  part.

Thus a bare Pythagorean-square family cannot model the final obstruction.  A
counterexample must carry a mixed square/cube exponent structure together
with unusually small squarefree residue coefficients.

## 4. Lean deliverable

```text
Lean/IUTThreeClosures/HigherPowerPartExponentWeight.lean
```

Main declarations:

```lean
totalWeight_le_radicalLayers_add_k_mul_kthRootWeight
excessAboveRadicalLayers_le_k_mul_kthRootWeight
cubefulExcessWeight_le_three_mul_cubeRootWeight
one_third_cubefulExcess_le_cubeRootWeight
cubeRootWeight_large_of_cubefulExcess_large
```

No abc estimate, modularity theorem, or gap theorem is assumed.
