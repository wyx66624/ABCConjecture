/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MultiradialLabelScaleCalibration

/-!
# Cross-label integer-effect obstruction

The pointwise scale `1 / j^2` removes the square exponent from the logarithmic
degree of the concrete theta point `q^(j^2)`.  The tensor packets in the proof
of IUT III, Corollary 3.12 are also claimed to identify the log-volume effect
of multiplication by integers at different labels.  This module proves the
precise scalar obstruction between those two requirements.

If one nonzero integer effect is identified across two labels, cancellation
forces their scalar coefficients to agree.  Distinct square labels cannot then
both be calibrated to the same nonzero q-degree.  Conversely, if a second
weight repairs the integer effect after applying `1 / j^2`, that weight is
forced to be `j^2`, and the theta square reappears exactly.

These are diagnostic theorems for fixed-place scalar models.  They do not
formalize the genuine IUT tensor packets or exclude a construction using
different arithmetic holomorphic structures or untilts.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

/-- Equality of one nonzero multiplicative log-volume effect forces equality
of the two scalar coefficients. -/
theorem integer_effect_forces_equal_coefficients
    {M a b : ℝ} (hM : M ≠ 0) (h : a * M = b * M) :
    a = b := by
  apply mul_right_cancel₀ hM
  exact h

/-- Distinct theta exponents cannot both be calibrated to one nonzero q-degree
while the same nonzero integer effect is identified across the two labels. -/
theorem no_calibration_with_identified_integer_effect
    {L M a b e₁ e₂ : ℝ}
    (hL : L ≠ 0) (he : e₁ ≠ e₂) (hM : M ≠ 0)
    (h₁ : a * (e₁ * L) = L)
    (h₂ : b * (e₂ * L) = L)
    (hint : a * M = b * M) : False := by
  have hab : a = b :=
    integer_effect_forces_equal_coefficients hM hint
  subst b
  exact no_common_scale_of_distinct_exponents hL he h₁ h₂

/-- The canonical pointwise scales at two distinct square labels cannot
identify any fixed nonzero integer log-volume effect. -/
theorem multiradialLabelScale_integer_effect_ne
    {L M : ℝ} {j k : ℕ}
    (hL : L ≠ 0) (hM : M ≠ 0)
    (hj : 0 < j) (hk : 0 < k)
    (hjk : (j : ℝ) ^ 2 ≠ (k : ℝ) ^ 2) :
    multiradialLabelScale j * M ≠
      multiradialLabelScale k * M := by
  intro hint
  exact no_calibration_with_identified_integer_effect
    hL hjk hM
    (multiradialLabelScale_calibrates L hj)
    (multiradialLabelScale_calibrates L hk)
    hint

/-- If a further scalar weight repairs the integer effect after the pointwise
`1 / j^2` calibration, that weight is uniquely forced to be `j^2`. -/
theorem integer_repair_forces_square_weight
    {M w : ℝ} {j : ℕ}
    (hM : M ≠ 0) (hj : 0 < j)
    (hrepair :
      w * (multiradialLabelScale j * M) = M) :
    w = (j : ℝ) ^ 2 := by
  have hws : w * multiradialLabelScale j = 1 := by
    apply mul_right_cancel₀ hM
    simpa [mul_assoc] using hrepair
  have hj0 : (j : ℝ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hj)
  have hsq : (j : ℝ) ^ 2 ≠ 0 := pow_ne_zero _ hj0
  unfold multiradialLabelScale at hws
  calc
    w = w * (((j : ℝ) ^ 2)⁻¹ * (j : ℝ) ^ 2) := by
      simp [hsq]
    _ = (w * ((j : ℝ) ^ 2)⁻¹) * (j : ℝ) ^ 2 := by
      ring
    _ = 1 * (j : ℝ) ^ 2 := by rw [hws]
    _ = (j : ℝ) ^ 2 := one_mul _

/-- Repairing the integer response by a scalar weight restores the complete
theta square exponent.  For a nontrivial label `j > 1` and nonzero theta
log-degree, this is the precise reason scalar reweighting cannot both erase
the square and preserve the integer response. -/
theorem integer_repair_restores_theta_square
    {L M w : ℝ} {j : ℕ}
    (hM : M ≠ 0) (hj : 0 < j)
    (hrepair :
      w * (multiradialLabelScale j * M) = M) :
    w * (multiradialLabelScale j * ((j : ℝ) ^ 2 * L)) =
      (j : ℝ) ^ 2 * L := by
  rw [integer_repair_forces_square_weight hM hj hrepair]
  rw [multiradialLabelScale_calibrates L hj]

/-- Actual fixed-field theta points at labels `1` and `2` cannot be calibrated
to the q-degree by two coefficients that also identify a nonzero integer
effect. -/
theorem KummerTorsor.no_integer_effect_compatible_calibration_one_two
    {K : Type u} [NormedField K]
    (t : TateParameter K) {M a b : ℝ} (hM : M ≠ 0)
    (h₁ :
      a * Real.log
          ‖((KummerTorsor.thetaPoint t 1 : Kˣ) : K)‖ =
        Real.log ‖(t.q : K)‖)
    (h₂ :
      b * Real.log
          ‖((KummerTorsor.thetaPoint t 2 : Kˣ) : K)‖ =
        Real.log ‖(t.q : K)‖)
    (hint : a * M = b * M) : False := by
  have hL : Real.log ‖(t.q : K)‖ ≠ 0 :=
    (Real.log_neg t.norm_q_pos t.norm_lt_one).ne
  rw [KummerTorsor.log_norm_thetaPoint] at h₁ h₂
  norm_num at h₁ h₂
  exact no_calibration_with_identified_integer_effect
    hL (by norm_num : (1 : ℝ) ≠ 4) hM
    (by simpa using h₁) (by simpa using h₂) hint

end IUTThreeClosures
