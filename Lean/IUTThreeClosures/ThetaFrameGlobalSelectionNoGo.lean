/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Pointwise theta-frame selection does not control one global kernel

A finite frame inequality may select a non-small row separately at every
complex embedding.  This does not imply that one fixed row has a non-small
product over all embeddings.  The two-embedding/two-kernel counterexample in
this file is quantitative: both embeddings have a coordinate of size one,
while the product attached to either fixed kernel can be made arbitrarily
small.

Therefore a pointwise archimedean frame requires an additional algebraic norm,
Pluecker, or invariant-section argument before it can enter a number-field
product formula.  No arithmetic-geometric conclusion is assumed here.
-/

namespace IUTThreeClosures

namespace ThetaFrameGlobalSelectionNoGo

/-- For every positive target `delta`, two embeddings can prefer opposite
kernels: each embedding has pointwise maximum at least one, but the product
for either fixed kernel is smaller than `delta`. -/
theorem pointwise_selection_does_not_bound_common_kernel_product
    {delta : ℝ} (hdelta : 0 < delta) :
    ∃ x₁₁ x₁₂ x₂₁ x₂₂ : ℝ,
      1 ≤ max |x₁₁| |x₁₂| ∧
      1 ≤ max |x₂₁| |x₂₂| ∧
      |x₁₁ * x₂₁| < delta ∧
      |x₁₂ * x₂₂| < delta := by
  refine ⟨1, delta / 2, delta / 2, 1, ?_, ?_, ?_, ?_⟩
  · simpa using (le_max_left (1 : ℝ) |delta / 2|)
  · simpa using (le_max_right |delta / 2| (1 : ℝ))
  · have hhalf : 0 < delta / 2 := by linarith
    calc
      |(1 : ℝ) * (delta / 2)| = delta / 2 := by
        rw [one_mul, abs_of_pos hhalf]
      _ < delta := by linarith
  · have hhalf : 0 < delta / 2 := by linarith
    calc
      |(delta / 2) * (1 : ℝ)| = delta / 2 := by
        rw [mul_one, abs_of_pos hhalf]
      _ < delta := by linarith

/-- The same example satisfies a uniform pointwise squared-norm lower bound,
so replacing maxima by a frame `L²` estimate does not repair the global
selection problem. -/
theorem pointwise_frame_energy_does_not_bound_common_kernel_product
    {delta : ℝ} (hdelta : 0 < delta) :
    ∃ x₁₁ x₁₂ x₂₁ x₂₂ : ℝ,
      1 ≤ x₁₁ ^ 2 + x₁₂ ^ 2 ∧
      1 ≤ x₂₁ ^ 2 + x₂₂ ^ 2 ∧
      |x₁₁ * x₂₁| < delta ∧
      |x₁₂ * x₂₂| < delta := by
  refine ⟨1, delta / 2, delta / 2, 1, ?_, ?_, ?_, ?_⟩
  · nlinarith [sq_nonneg (delta / 2)]
  · nlinarith [sq_nonneg (delta / 2)]
  · have hhalf : 0 < delta / 2 := by linarith
    calc
      |(1 : ℝ) * (delta / 2)| = delta / 2 := by
        rw [one_mul, abs_of_pos hhalf]
      _ < delta := by linarith
  · have hhalf : 0 < delta / 2 := by linarith
    calc
      |(delta / 2) * (1 : ℝ)| = delta / 2 := by
        rw [mul_one, abs_of_pos hhalf]
      _ < delta := by linarith

#print axioms pointwise_selection_does_not_bound_common_kernel_product
#print axioms pointwise_frame_energy_does_not_bound_common_kernel_product

end ThetaFrameGlobalSelectionNoGo

end IUTThreeClosures
