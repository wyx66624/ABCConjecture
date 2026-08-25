/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Prime-exponent inequality for version 9 power cores

For one prime exponent `e`, rounding down to a multiple of `k` loses at most
`k - 1`.  This is the local arithmetic statement behind

`U_k(n)^k >= n / rad(n)^(k-1)`.

The module also formalizes the real algebra determining when the resulting
abc-violation exponent is positive.
-/

namespace IUTThreeClosures

/-- Rounding a natural exponent down to a multiple of `k` loses at most
`k - 1`. -/
theorem exponent_sub_pred_le_mul_div
    (e k : ℕ) (hk : 0 < k) :
    e - (k - 1) ≤ k * (e / k) := by
  have hmodLt : e % k < k := Nat.mod_lt e hk
  have hmodLe : e % k ≤ k - 1 := by omega
  apply (Nat.sub_le_iff_le_add).2
  calc
    e = e / k * k + e % k := (Nat.div_add_mod e k).symm
    _ ≤ e / k * k + (k - 1) := Nat.add_le_add_left hmodLe _
    _ = k * (e / k) + (k - 1) := by ring

/-- Equivalent additive form of the same exponent estimate. -/
theorem exponent_le_mul_div_add_pred
    (e k : ℕ) (hk : 0 < k) :
    e ≤ k * (e / k) + (k - 1) := by
  calc
    e = e / k * k + e % k := (Nat.div_add_mod e k).symm
    _ ≤ e / k * k + (k - 1) := by
      gcongr
      exact Nat.le_pred_of_lt (Nat.mod_lt e hk)
    _ = k * (e / k) + (k - 1) := by ring

/-- The real exponent produced by the elementary `k`-power-core argument. -/
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
    apply (div_lt_iff₀ hden).mp
    nlinarith
  · intro h
    apply (div_lt_iff₀ hden).mpr
    nlinarith

/-- For `0 < ε ≤ 1/2`, every fixed power `k ≥ 4` lies at or beyond the
nonpositive horizon. -/
theorem powerCoreViolationExponent_nonpos_of_four_le
    {k : ℕ} {ε : ℝ}
    (hk : 4 ≤ k) (hεpos : 0 < ε) (hεhalf : ε ≤ 1 / 2) :
    powerCoreViolationExponent k ε ≤ 0 := by
  have hnot : ¬ ((k : ℝ) < 3 + 2 * ε) := by
    norm_num at hεhalf ⊢
    exact_mod_cast hk
  have hε : -1 < ε := by linarith
  exact le_of_not_gt ((powerCoreViolationExponent_pos_iff hε).not.mpr hnot)

end IUTThreeClosures
