/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Convex-slope barrier for combining Frey-model inequalities

Suppose several Frey models give inequalities with conductor slope `sᵢ` and
only control the abc height through a lower growth exponent `rᵢ`.  Taking a
nonnegative linear combination cannot improve the best ratio `sᵢ / rᵢ`: the
combined ratio is a weighted average after reweighting by `rᵢ`.

For the two explicit models already present in this repository, the relevant
height-growth exponents are `4` and `5`, while the critical Szpiro slope is
`6` for both.  Consequently every nonzero nonnegative combination has ratio
at least `6/5`, and in fact strictly greater than `1`.  Simple averaging of the
two displayed discriminant inequalities therefore cannot reach the abc
coefficient.

This is an unconditional scalar barrier.  It does not rule out a new model,
a source height growing like `6 log c`, a valid cancellation identity using
additional signed information, or a genuinely stronger global estimate.
-/

namespace IUTThreeClosures
namespace FreyConvexSlopeBarrier

/-- Nonnegative combination preserves any common lower bound on the
slope-to-height ratios. -/
theorem nonnegative_two_model_combination_preserves_ratio
    (w₁ w₂ r₁ r₂ s₁ s₂ q : ℝ)
    (hw₁ : 0 ≤ w₁) (hw₂ : 0 ≤ w₂)
    (h₁ : q * r₁ ≤ s₁) (h₂ : q * r₂ ≤ s₂) :
    q * (w₁ * r₁ + w₂ * r₂) ≤ w₁ * s₁ + w₂ * s₂ := by
  have h₁' := mul_le_mul_of_nonneg_left h₁ hw₁
  have h₂' := mul_le_mul_of_nonneg_left h₂ hw₂
  nlinarith

/-- Combined height-growth exponent of the original (`4`) and quotient (`5`)
Frey discriminant models. -/
def combinedHeightExponent (w₄ w₅ : ℝ) : ℝ :=
  4 * w₄ + 5 * w₅

/-- Combined critical Szpiro exponent when both component inequalities have
slope `6`. -/
def combinedSzpiroExponent (w₄ w₅ : ℝ) : ℝ :=
  6 * (w₄ + w₅)

/-- A nonzero nonnegative combination has a positive height denominator. -/
theorem combinedHeightExponent_pos
    (w₄ w₅ : ℝ)
    (hw₄ : 0 ≤ w₄) (hw₅ : 0 ≤ w₅)
    (hnonzero : 0 < w₄ + w₅) :
    0 < combinedHeightExponent w₄ w₅ := by
  dsimp [combinedHeightExponent]
  nlinarith

/-- The best possible coefficient from nonnegative averaging is `6/5`; the
fourth-power model can only make the ratio worse. -/
theorem combined_ratio_ge_six_fifths
    (w₄ w₅ : ℝ)
    (hw₄ : 0 ≤ w₄) (hw₅ : 0 ≤ w₅)
    (hnonzero : 0 < w₄ + w₅) :
    (6 : ℝ) / 5 ≤
      combinedSzpiroExponent w₄ w₅ /
        combinedHeightExponent w₄ w₅ := by
  have hden := combinedHeightExponent_pos w₄ w₅ hw₄ hw₅ hnonzero
  apply (le_div_iff₀ hden).2
  dsimp [combinedSzpiroExponent, combinedHeightExponent]
  nlinarith

/-- In particular, no such combination reaches coefficient `1`. -/
theorem combined_ratio_strictly_above_one
    (w₄ w₅ : ℝ)
    (hw₄ : 0 ≤ w₄) (hw₅ : 0 ≤ w₅)
    (hnonzero : 0 < w₄ + w₅) :
    1 <
      combinedSzpiroExponent w₄ w₅ /
        combinedHeightExponent w₄ w₅ := by
  have hden := combinedHeightExponent_pos w₄ w₅ hw₄ hw₅ hnonzero
  apply (lt_div_iff₀ hden).2
  dsimp [combinedSzpiroExponent, combinedHeightExponent]
  nlinarith

/-- Negated formulation of the same barrier, useful as an audit target. -/
theorem no_nonnegative_two_model_average_reaches_abc_coefficient
    (w₄ w₅ : ℝ)
    (hw₄ : 0 ≤ w₄) (hw₅ : 0 ≤ w₅)
    (hnonzero : 0 < w₄ + w₅) :
    ¬ (combinedSzpiroExponent w₄ w₅ /
        combinedHeightExponent w₄ w₅ ≤ 1) := by
  exact not_le.mpr
    (combined_ratio_strictly_above_one w₄ w₅ hw₄ hw₅ hnonzero)

/-- The modified-height route succeeds at the scalar level precisely because
its source height has exponent `6`, matching the critical Szpiro slope. -/
theorem modified_height_critical_ratio :
    (6 : ℝ) / 6 = 1 := by
  norm_num

/-- The quotient model's limiting scalar coefficient is exactly `6/5`. -/
theorem quotient_model_limiting_ratio :
    (6 : ℝ) / 5 = 1 + (1 : ℝ) / 5 := by
  norm_num

/-- The original model's limiting scalar coefficient is exactly `3/2`. -/
theorem original_model_limiting_ratio :
    (6 : ℝ) / 4 = (3 : ℝ) / 2 := by
  norm_num

#print axioms nonnegative_two_model_combination_preserves_ratio
#print axioms combinedHeightExponent_pos
#print axioms combined_ratio_ge_six_fifths
#print axioms combined_ratio_strictly_above_one
#print axioms no_nonnegative_two_model_average_reaches_abc_coefficient
#print axioms modified_height_critical_ratio
#print axioms quotient_model_limiting_ratio
#print axioms original_model_limiting_ratio

end FreyConvexSlopeBarrier
end IUTThreeClosures
