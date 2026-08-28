/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# Explicit sublinear bounds for `log (1 + x)`

The quantitative auxiliary-prime route naturally produces logarithmic terms
such as `log ell` and, under polynomial effective-open-image estimates,
`log (1 + height)`.  This module records the elementary analytic absorption
needed by that route.

For every `rho > 0` and `x >= 0`, the inequality `log y <= y - 1`, applied to
`y = rho * (1 + x)`, gives

`log (1 + x) <= rho * x + (rho - 1 - log rho)`.

Consequently every nonnegative multiple of `log (1 + x)`, and every affine
function of that logarithm, is bounded by an arbitrarily small positive
multiple of `x` plus a constant.  All constants are explicit.
-/

namespace IUTThreeClosures

/-- Explicit scaled form of the sublinearity of `log (1 + x)`. -/
theorem log_one_add_le_scaled
    {x ρ : ℝ} (hx : 0 ≤ x) (hρ : 0 < ρ) :
    Real.log (1 + x) ≤
      ρ * x + (ρ - 1 - Real.log ρ) := by
  have hx1 : 0 < 1 + x := by
    linarith
  have hprod : 0 < ρ * (1 + x) :=
    mul_pos hρ hx1
  have hlog := Real.log_le_sub_one_of_pos hprod
  rw [Real.log_mul (ne_of_gt hρ) (ne_of_gt hx1)] at hlog
  nlinarith

/-- A nonnegative multiple of `log (1 + x)` is uniformly sublinear on the
nonnegative real axis. -/
theorem mul_log_one_add_sublinear
    {A η : ℝ} (hA : 0 ≤ A) (hη : 0 < η) :
    ∃ C : ℝ, ∀ x : ℝ, 0 ≤ x →
      A * Real.log (1 + x) ≤ η * x + C := by
  rcases hA.eq_or_lt with hA0 | hApos
  · refine ⟨0, ?_⟩
    intro x hx
    simp [hA0]
  · let ρ : ℝ := η / A
    have hρ : 0 < ρ := by
      dsimp [ρ]
      exact div_pos hη hApos
    refine ⟨A * (ρ - 1 - Real.log ρ), ?_⟩
    intro x hx
    have hlog := log_one_add_le_scaled hx hρ
    have hmul := mul_le_mul_of_nonneg_left hlog hA
    calc
      A * Real.log (1 + x) ≤
          A * (ρ * x + (ρ - 1 - Real.log ρ)) := hmul
      _ = η * x + A * (ρ - 1 - Real.log ρ) := by
        dsimp [ρ]
        field_simp [ne_of_gt hApos]
        ring

/-- Every affine function of a nonnegative multiple of `log (1 + x)` is
uniformly sublinear on the nonnegative real axis. -/
theorem affine_log_one_add_sublinear
    {A B η : ℝ} (hA : 0 ≤ A) (hη : 0 < η) :
    ∃ C : ℝ, ∀ x : ℝ, 0 ≤ x →
      A * Real.log (1 + x) + B ≤ η * x + C := by
  rcases mul_log_one_add_sublinear hA hη with ⟨C, hC⟩
  refine ⟨C + B, ?_⟩
  intro x hx
  linarith [hC x hx]

end IUTThreeClosures
