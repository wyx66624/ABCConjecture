/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# Eventual absorption of the logarithmic prime-counting term

For every `A >= 0` and `epsilon > 0`, the function

`A * log(1+y)`

is bounded by `epsilon*y` for all sufficiently large nonnegative `y`.  The
proof is explicit: apply `log z <= z-1` to

`z = rho*(1+y)`, `rho = epsilon/(2*A)`,

and absorb the resulting constant beyond a concrete threshold.

This removes the logarithmic hypothesis from GenEll Lemma 4.1 once the printed
radius is chosen sufficiently large.
-/

namespace IUTThreeClosures

/-- Explicit scaled upper bound for `log(1+y)`. -/
theorem log_one_add_le_scaled
    {y ρ : ℝ} (hy : 0 ≤ y) (hρ : 0 < ρ) :
    Real.log (1 + y) ≤
      ρ * y + (ρ - 1 - Real.log ρ) := by
  have hy1 : 0 < 1 + y := by linarith
  have hprod : 0 < ρ * (1 + y) := mul_pos hρ hy1
  have hlog := Real.log_le_sub_one_of_pos hprod
  rw [Real.log_mul (ne_of_gt hρ) (ne_of_gt hy1)] at hlog
  nlinarith

/-- A nonnegative multiple of `log(1+y)` is eventually bounded by an arbitrary
positive multiple of `y`. -/
theorem exists_threshold_mul_log_one_add_le
    {A ε : ℝ} (hA : 0 ≤ A) (hε : 0 < ε) :
    ∃ Y : ℝ, 0 ≤ Y ∧
      ∀ y : ℝ, Y ≤ y →
        A * Real.log (1 + y) ≤ ε * y := by
  rcases hA.eq_or_lt with hA0 | hApos
  · refine ⟨0, le_rfl, ?_⟩
    intro y hy
    simp [hA0, mul_nonneg hε.le (le_trans (by norm_num) hy)]
  · let ρ : ℝ := ε / (2 * A)
    let C : ℝ := A * (ρ - 1 - Real.log ρ)
    let Y : ℝ := max 0 (2 * C / ε)
    have hρ : 0 < ρ := by
      dsimp [ρ]
      positivity
    refine ⟨Y, le_max_left _ _, ?_⟩
    intro y hy
    have hy0 : 0 ≤ y := (le_max_left 0 (2 * C / ε)).trans hy
    have hlog := log_one_add_le_scaled hy0 hρ
    have hmul := mul_le_mul_of_nonneg_left hlog hA
    have hYdiv : 2 * C / ε ≤ y :=
      (le_max_right 0 (2 * C / ε)).trans hy
    have hCY : 2 * C ≤ ε * y := by
      have := (div_le_iff₀ hε).1 hYdiv
      simpa [mul_comm] using this
    have hscaled : A * ρ = ε / 2 := by
      dsimp [ρ]
      field_simp [ne_of_gt hApos]
      ring
    dsimp [C] at hCY ⊢
    rw [hscaled] at hmul
    linarith

/-- The exact logarithmic term occurring in the several-prime form of GenEll
Lemma 4.1 is eventually absorbed. -/
theorem exists_threshold_genEll_logTerm
    (M : ℕ) {ε : ℝ} (hε : 0 < ε) :
    ∃ Y : ℝ, 0 ≤ Y ∧
      ∀ y : ℝ, Y ≤ y →
        (((M - 1 : ℕ) : ℝ) * Real.log (1 + y)) ≤ ε * y := by
  exact exists_threshold_mul_log_one_add_le
    (by positivity : 0 ≤ (((M - 1 : ℕ) : ℝ))) hε

end IUTThreeClosures
