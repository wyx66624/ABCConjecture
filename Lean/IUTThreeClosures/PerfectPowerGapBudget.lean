/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Exponent budget for generalized perfect-power disproofs

If a radical estimate has exponent `alpha < 1`, one can choose one fixed
positive `epsilon` such that `alpha * (1 + epsilon) < 1`.  This is the
quantifier step needed to turn an infinite close-perfect-power family into a
disproof of the logarithmic abc conjecture.
-/

namespace IUTThreeClosures

/-- A strict exponent below one admits one fixed positive abc-violation
margin.  The explicit choice is `(1-alpha)/2`. -/
theorem exists_positive_epsilon_mul_one_add_lt_one
    {α : ℝ} (hα0 : 0 ≤ α) (hα1 : α < 1) :
    ∃ ε : ℝ, 0 < ε ∧ α * (1 + ε) < 1 := by
  refine ⟨(1 - α) / 2, by linarith, ?_⟩
  have hprod : α * (1 - α) < 1 - α := by
    nlinarith
  nlinarith

/-- Version with the three exponents occurring in the generalized
perfect-power construction. -/
theorem perfectPowerGap_exponent_budget
    {θ invM invN : ℝ}
    (hθ : 0 ≤ θ) (hM : 0 ≤ invM) (hN : 0 ≤ invN)
    (hcritical : θ + invM + invN < 1) :
    ∃ ε : ℝ, 0 < ε ∧
      (θ + invM + invN) * (1 + ε) < 1 := by
  exact exists_positive_epsilon_mul_one_add_lt_one
    (by positivity) hcritical

/-- The square--cube reciprocal contribution is exactly `5/6`. -/
theorem squareCube_reciprocal_sum :
    (1 / 2 : ℝ) + 1 / 3 = 5 / 6 := by
  norm_num

/-- A fixed gap exponent strictly below `1/6` lies below the square--cube
critical exponent. -/
theorem squareCube_gap_below_critical
    {θ : ℝ} (hθ : θ < 1 / 6) :
    θ + 1 / 2 + 1 / 3 < 1 := by
  norm_num at hθ ⊢
  linarith

end IUTThreeClosures
