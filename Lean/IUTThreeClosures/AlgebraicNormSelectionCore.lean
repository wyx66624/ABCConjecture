/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Finite product-formula core for algebraic frame selection

A nonzero algebraic determinant is controlled simultaneously at all complex
embeddings by the number-field product formula.  The arithmetic application
partitions the logarithmic places into:

* archimedean places;
* exceptional finite places, where denominators are explicitly charged;
* ordinary finite places, where integrality makes the logarithmic norm
  nonpositive.

The theorem below kernel-checks the ordered finite-sum inequality after the
number-field product formula has supplied the displayed decomposition.  It is
independent of the still-unformalized pure-theta frame determinant.
-/

namespace IUTThreeClosures

/-- Finite real-sum core of the algebraic norm selection theorem.

If the total logarithmic sum is zero, the ordinary finite contribution is
nonpositive, and the exceptional contribution is charged by its positive
part, then the negative archimedean sum is bounded by that denominator charge.
-/
theorem algebraicNormSelection_finiteCore
    {ι : Type*} [DecidableEq ι]
    (arch exceptional ordinary : Finset ι)
    (f : ι → ℝ)
    (hdecomp :
      (∑ i in arch, f i) +
          (∑ i in exceptional, f i) +
          (∑ i in ordinary, f i) = 0)
    (hordinary : (∑ i in ordinary, f i) ≤ 0) :
    -(∑ i in arch, f i) ≤
      ∑ i in exceptional, max 0 (f i) := by
  have hexceptional :
      (∑ i in exceptional, f i) ≤
        ∑ i in exceptional, max 0 (f i) := by
    apply Finset.sum_le_sum
    intro i hi
    exact le_max_right 0 (f i)
  linarith

/-- Variant in which each ordinary finite logarithmic norm is known to be
nonpositive pointwise. -/
theorem algebraicNormSelection_finiteCore_of_pointwise
    {ι : Type*} [DecidableEq ι]
    (arch exceptional ordinary : Finset ι)
    (f : ι → ℝ)
    (hdecomp :
      (∑ i in arch, f i) +
          (∑ i in exceptional, f i) +
          (∑ i in ordinary, f i) = 0)
    (hordinary : ∀ i ∈ ordinary, f i ≤ 0) :
    -(∑ i in arch, f i) ≤
      ∑ i in exceptional, max 0 (f i) := by
  apply algebraicNormSelection_finiteCore
    arch exceptional ordinary f hdecomp
  exact Finset.sum_nonpos hordinary

/-- If there are no exceptional denominators, a nonzero integral determinant
has nonnegative total archimedean logarithmic norm. -/
theorem integralDeterminant_archimedeanLog_nonneg
    {ι : Type*} [DecidableEq ι]
    (arch ordinary : Finset ι)
    (f : ι → ℝ)
    (hdecomp :
      (∑ i in arch, f i) +
          (∑ i in ordinary, f i) = 0)
    (hordinary : ∀ i ∈ ordinary, f i ≤ 0) :
    0 ≤ ∑ i in arch, f i := by
  have h := algebraicNormSelection_finiteCore_of_pointwise
    arch ∅ ordinary f (by simpa using hdecomp) hordinary
  simpa using h

end IUTThreeClosures
