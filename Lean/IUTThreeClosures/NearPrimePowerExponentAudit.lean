/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Exponent audit for near-prime-power counterexample constructions

Consider a prospective family

`c = p^k + a`,  with  `a <= (p^k)^theta`.

If the radical of `c` contributes logarithmic slope at most `eta`, then the
radical budget has slope

`theta + 1/k + eta`.

To contradict the abc inequality with exponent `1 + epsilon`, the required
condition is therefore

`(1 + epsilon) * (theta + 1/k + eta) < 1`.

A condition of the form

`(theta + 1/k)^(1 + epsilon) < 1`

does not imply this: whenever the base lies in `(0,1)`, the displayed power
condition is largely automatic, while multiplication by `1 + epsilon` may
push the logarithmic slope above one.  This file records an exact rational
counterexample and the correct threshold algebra for `theta = 3/5`.
-/

namespace IUTThreeClosures
namespace NearPrimePowerExponentAudit

/-- Exact counterexample to replacing the logarithmic slope condition by a
power-of-the-slope condition.  Here `theta = 3/5`, `k = 5`, and
`epsilon = 1`: the square of `4/5` is below one, but the abc-weighted slope is
`8/5`, above one. -/
theorem displayed_power_condition_is_insufficient :
    (((3 : ℝ) / 5 + (1 : ℝ) / 5) ^ 2 < 1) ∧
      ¬ ((1 + (1 : ℝ)) * ((3 : ℝ) / 5 + (1 : ℝ) / 5) < 1) := by
  norm_num

/-- The same counterexample expressed as a negative logarithmic gap. -/
theorem displayed_power_condition_can_have_negative_log_gap :
    (((3 : ℝ) / 5 + (1 : ℝ) / 5) ^ 2 < 1) ∧
      1 - (1 + (1 : ℝ)) * ((3 : ℝ) / 5 + (1 : ℝ) / 5) < 0 := by
  norm_num

/-- Algebraic identity behind the exact `theta = 3/5` threshold. -/
theorem threeFifths_gap_identity
    (ε k : ℝ) (hk : k ≠ 0) :
    5 * k *
        (1 - (1 + ε) * ((3 : ℝ) / 5 + 1 / k)) =
      k * (2 - 3 * ε) - 5 * (1 + ε) := by
  field_simp [hk]
  ring

/-- Correct threshold for a `3/5`-length interval and prime-power exponent
`k`, before any additional smooth-radical loss is charged. -/
theorem threeFifths_slope_threshold
    (ε k : ℝ) (hk : 0 < k) :
    ((1 + ε) * ((3 : ℝ) / 5 + 1 / k) < 1 ↔
      5 * (1 + ε) < k * (2 - 3 * ε)) := by
  have hid := threeFifths_gap_identity ε k hk.ne'
  constructor
  · intro hsub
    have hgap :
        0 < 1 - (1 + ε) * ((3 : ℝ) / 5 + 1 / k) := by
      linarith
    have hcoef : 0 < (5 : ℝ) * k := mul_pos (by norm_num) hk
    have hprod :
        0 < 5 * k *
          (1 - (1 + ε) * ((3 : ℝ) / 5 + 1 / k)) :=
      mul_pos hcoef hgap
    rw [hid] at hprod
    linarith
  · intro hthreshold
    have hrhs :
        0 < k * (2 - 3 * ε) - 5 * (1 + ε) := by
      linarith
    have hprod :
        0 < 5 * k *
          (1 - (1 + ε) * ((3 : ℝ) / 5 + 1 / k)) := by
      rw [hid]
      exact hrhs
    have hcoef : 0 < (5 : ℝ) * k := mul_pos (by norm_num) hk
    have hgap :
        0 < 1 - (1 + ε) * ((3 : ℝ) / 5 + 1 / k) := by
      rcases (mul_pos_iff.mp hprod) with hpp | hnn
      · exact hpp.2
      · exact False.elim ((not_lt_of_ge (le_of_lt hcoef)) hnn.1)
    linarith

/-- Once `epsilon >= 2/3`, no positive prime-power exponent `k` can make a
`theta = 3/5` construction subcritical, even with zero smooth-radical loss. -/
theorem no_threeFifths_subcritical_slope_if_epsilon_ge_twoThirds
    (ε k : ℝ) (hε : (2 : ℝ) / 3 ≤ ε) (hk : 0 < k) :
    ¬ ((1 + ε) * ((3 : ℝ) / 5 + 1 / k) < 1) := by
  intro hsub
  have hthreshold := (threeFifths_slope_threshold ε k hk).mp hsub
  have hleft : 0 < 5 * (1 + ε) := by
    nlinarith
  have hfactor : 2 - 3 * ε ≤ 0 := by
    linarith
  have hright : k * (2 - 3 * ε) ≤ 0 :=
    mul_nonpos_of_nonneg_of_nonpos (le_of_lt hk) hfactor
  linarith

/-- For a genuinely small epsilon, an integer exponent can satisfy the correct
condition.  The concrete ledger `epsilon = 1/10`, `k = 4` gives slope
`187/200`. -/
theorem oneTenth_kFour_is_subcritical :
    (1 + (1 : ℝ) / 10) * ((3 : ℝ) / 5 + 1 / 4) =
      (187 : ℝ) / 200 ∧
    (187 : ℝ) / 200 < 1 := by
  norm_num

/-- Any correct subcritical condition supplies a fixed positive logarithmic
gap. -/
theorem correct_condition_has_positive_log_gap
    (ε q : ℝ) (hsub : (1 + ε) * q < 1) :
    0 < 1 - (1 + ε) * q := by
  linarith

/-- Exact upper budget left for the smooth-radical slope. -/
theorem smooth_radical_loss_must_fit_remaining_budget
    (ε theta primeSlope smoothLoss : ℝ)
    (hε : 0 < 1 + ε)
    (hsub :
      (1 + ε) * (theta + primeSlope + smoothLoss) < 1) :
    smoothLoss < 1 / (1 + ε) - theta - primeSlope := by
  have hdiv :
      theta + primeSlope + smoothLoss < 1 / (1 + ε) := by
    apply (lt_div_iff₀ hε).2
    nlinarith
  linarith

#print axioms displayed_power_condition_is_insufficient
#print axioms displayed_power_condition_can_have_negative_log_gap
#print axioms threeFifths_gap_identity
#print axioms threeFifths_slope_threshold
#print axioms no_threeFifths_subcritical_slope_if_epsilon_ge_twoThirds
#print axioms oneTenth_kFour_is_subcritical
#print axioms correct_condition_has_positive_log_gap
#print axioms smooth_radical_loss_must_fit_remaining_budget

end NearPrimePowerExponentAudit
end IUTThreeClosures
