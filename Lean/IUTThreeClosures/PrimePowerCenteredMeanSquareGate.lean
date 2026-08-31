/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Prime-power-centred mean-square extraction

Ambient almost-all theorems are too weak for a sparse centre family unless
their exceptional set is controlled relative to that family. A cleaner target
is therefore a mean-square theorem evaluated directly on the desired centres.

This module proves the deterministic extraction step. If the squared error,
summed over a finite centre set, is strictly smaller than

`card(centres) * threshold^2`,

then some centre has error below `threshold`. A second theorem turns this into
a positivity statement for a short weighted count when a reference count has
a uniform positive lower bound.

The intended analytic application takes the centre set to be prime powers
`p^k`, the short mass to be a tilted smooth-number weight in
`[p^k, p^k + h]`, and the reference mass to be a longer local average. No
mean-value theorem is assumed in this file.
-/

namespace IUTThreeClosures
namespace PrimePowerCenteredMeanSquareGate

/-- A strict relative mean-square bound forces one centre below the prescribed
nonnegative error threshold. -/
theorem exists_cost_lt_of_sum_sq_lt_card_mul
    {α : Type*} [DecidableEq α]
    (centers : Finset α)
    (cost : α → ℝ)
    (threshold : ℝ)
    (hcost : ∀ x ∈ centers, 0 ≤ cost x)
    (hthreshold : 0 ≤ threshold)
    (hsum :
      (∑ x ∈ centers, (cost x) ^ 2) <
        (centers.card : ℝ) * threshold ^ 2) :
    ∃ x ∈ centers, cost x < threshold := by
  by_contra h
  push_neg at h
  have hpoint :
      ∀ x ∈ centers, threshold ^ 2 ≤ (cost x) ^ 2 := by
    intro x hx
    have hle : threshold ≤ cost x := h x hx
    have hprod :
        0 ≤ (cost x - threshold) * (cost x + threshold) :=
      mul_nonneg (sub_nonneg.mpr hle)
        (add_nonneg (hcost x hx) hthreshold)
    nlinarith
  have hsumLower :
      (∑ x ∈ centers, threshold ^ 2) ≤
        ∑ x ∈ centers, (cost x) ^ 2 := by
    exact Finset.sum_le_sum fun x hx => hpoint x hx
  have hconst :
      (∑ _x ∈ centers, threshold ^ 2) =
        (centers.card : ℝ) * threshold ^ 2 := by
    simp
  rw [hconst] at hsumLower
  linarith

/-- A direct centre-wise mean-square estimate yields a centre with positive
short mass. The reference mass is allowed to vary with the centre, provided it
is uniformly at least `mainTerm`. -/
theorem exists_positive_shortMass_of_centered_meanSquare
    {α : Type*} [DecidableEq α]
    (centers : Finset α)
    (shortMass referenceMass : α → ℝ)
    (mainTerm : ℝ)
    (hmain : 0 < mainTerm)
    (href : ∀ x ∈ centers, mainTerm ≤ referenceMass x)
    (hsum :
      (∑ x ∈ centers,
        |shortMass x - referenceMass x| ^ 2) <
        (centers.card : ℝ) * mainTerm ^ 2) :
    ∃ x ∈ centers, 0 < shortMass x := by
  obtain ⟨x, hx, hxsmall⟩ :=
    exists_cost_lt_of_sum_sq_lt_card_mul
      centers
      (fun z => |shortMass z - referenceMass z|)
      mainTerm
      (by
        intro z hz
        exact abs_nonneg _)
      (le_of_lt hmain)
      hsum
  have habs :
      -mainTerm < shortMass x - referenceMass x ∧
        shortMass x - referenceMass x < mainTerm :=
    abs_lt.mp hxsmall
  refine ⟨x, hx, ?_⟩
  linarith [href x hx, habs.1]

/-- Constant reference-mass specialization. -/
theorem exists_positive_shortMass_of_constant_reference
    {α : Type*} [DecidableEq α]
    (centers : Finset α)
    (shortMass : α → ℝ)
    (mainTerm : ℝ)
    (hmain : 0 < mainTerm)
    (hsum :
      (∑ x ∈ centers, |shortMass x - mainTerm| ^ 2) <
        (centers.card : ℝ) * mainTerm ^ 2) :
    ∃ x ∈ centers, 0 < shortMass x := by
  simpa using
    exists_positive_shortMass_of_centered_meanSquare
      centers shortMass (fun _ => mainTerm) mainTerm hmain
      (by
        intro x hx
        exact le_rfl)
      hsum

#print axioms exists_cost_lt_of_sum_sq_lt_card_mul
#print axioms exists_positive_shortMass_of_centered_meanSquare
#print axioms exists_positive_shortMass_of_constant_reference

end PrimePowerCenteredMeanSquareGate
end IUTThreeClosures
