/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Prime-exponent inequality for version 9 power cores

For one prime exponent `e`, rounding down to a multiple of `k` loses at most
`k - 1`. This is the local arithmetic statement behind the general power-core
bound. The file also formalizes the real positivity horizon of the exponent
produced by a hypothetical abc violation.
-/

namespace IUTThreeClosures

/-- Rounding a natural exponent down to a multiple of `k` loses at most
`k - 1`, in additive form. -/
theorem exponent_le_mul_div_add_pred
    (e k : ℕ) (hk : 0 < k) :
    e ≤ k * (e / k) + (k - 1) := by
  have hmodLe : e % k ≤ k - 1 := by
    have hmodLt : e % k < k := Nat.mod_lt e hk
    omega
  calc
    e = e / k * k + e % k := (Nat.div_add_mod e k).symm
    _ ≤ e / k * k + (k - 1) := Nat.add_le_add_left hmodLe _
    _ = k * (e / k) + (k - 1) := by ring

/-- Equivalent subtraction form of the exponent estimate. -/
theorem exponent_sub_pred_le_mul_div
    (e k : ℕ) (hk : 0 < k) :
    e - (k - 1) ≤ k * (e / k) := by
  have h := exponent_le_mul_div_add_pred e k hk
  omega

/-- Real exponent produced by the elementary `k`-power-core argument. -/
noncomputable def powerCoreViolationExponent (k : ℕ) (ε : ℝ) : ℝ :=
  2 - ((k : ℝ) - 1) / (1 + ε)

/-- The power-core exponent is positive exactly below the horizon
`k < 3 + 2 ε`. -/
theorem powerCoreViolationExponent_pos_iff
    {k : ℕ} {ε : ℝ} (hε : -1 < ε) :
    0 < powerCoreViolationExponent k ε ↔
      (k : ℝ) < 3 + 2 * ε := by
  unfold powerCoreViolationExponent
  have hden : 0 < 1 + ε := by linarith
  constructor
  · intro h
    have hdiv : ((k : ℝ) - 1) / (1 + ε) < 2 := by linarith
    have hmul : (k : ℝ) - 1 < 2 * (1 + ε) :=
      (div_lt_iff₀ hden).mp hdiv
    linarith
  · intro h
    have hmul : (k : ℝ) - 1 < 2 * (1 + ε) := by linarith
    have hdiv : ((k : ℝ) - 1) / (1 + ε) < 2 :=
      (div_lt_iff₀ hden).mpr hmul
    linarith

/-- For `0 < ε ≤ 1/2`, every fixed power `k ≥ 4` has nonpositive elementary
power-core exponent. -/
theorem powerCoreViolationExponent_nonpos_of_four_le
    {k : ℕ} {ε : ℝ}
    (hk : 4 ≤ k) (hεpos : 0 < ε) (hεhalf : ε ≤ 1 / 2) :
    powerCoreViolationExponent k ε ≤ 0 := by
  unfold powerCoreViolationExponent
  have hden : 0 < 1 + ε := by linarith
  have hkReal : (4 : ℝ) ≤ k := by exact_mod_cast hk
  have hmul : 2 * (1 + ε) ≤ (k : ℝ) - 1 := by
    norm_num at hεhalf
    linarith
  have hdiv : 2 ≤ ((k : ℝ) - 1) / (1 + ε) :=
    (le_div_iff₀ hden).mpr hmul
  linarith

end IUTThreeClosures
