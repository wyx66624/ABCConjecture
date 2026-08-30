# ABC multi-route research note v17: finite Ind2 union overhead

**Author:** ChatGPT  
**Date:** 2026-08-30

## 1. Problem corrected

An Ind2/permutation construction often produces finitely many regions of equal
volume. Equal volume of every orbit piece does **not** imply that their union
has the same volume: overlaps may be partial, and disjoint pieces increase the
volume. The correct universal input is finite subadditivity.

For a finite set of indices `s`,

\[
\mu\left(\bigcup_{i\in s}U_i\right)
\le
\sum_{i\in s}\mu(U_i).
\]

## 2. Equal-volume orbit pieces

If every orbit region has the same finite positive measure as a reference
region `V`, then

\[
\mu\left(\bigcup_{i\in s}U_i\right)
\le
|s|\mu(V).
\]

Taking logarithms gives

\[
\boxed{
\log\mu\left(\bigcup_{i\in s}U_i\right)
\le
\log|s|+\log\mu(V).
}
\]

Thus a finite Ind2 orbit contributes an additive `log |s|` term, not zero
error and not an uncontrolled multiplicative height slope.

## 3. Uniform orbit-size bound

If the orbit cardinality is uniformly bounded by a fixed positive integer
`B`, then

\[
\boxed{
\log\mu\left(\bigcup_{i\in s}U_i\right)
\le
\log B+\log\mu(V).
}
\]

The term `log B` can be absorbed into the epsilon-dependent constant in an abc
inequality. This repairs the finite-union bookkeeping without asserting the
false equality ruled out by `PermutationOrbitUnionCounterexample.lean`.

## 4. Scope

This result removes one logical obstruction in a source-derived IUT/Ind2
pipeline. It does not construct the genuine theta possible-image region and
does not prove the global Corollary 3.12 estimate. Those source and comparison
theorems remain separate obligations.

## 5. Lean deliverable

```text
Lean/IUTThreeClosures/Ind2FiniteUnionOverhead.lean
```

Core declarations:

```lean
measurable_finset_iUnion
measure_finset_iUnion_le_sum
finsetUnionRegion
toReal_measure_finsetUnion_le_card_mul
logVolume_finsetUnion_le_log_card_add
logVolume_finsetUnion_le_of_card_le
```
