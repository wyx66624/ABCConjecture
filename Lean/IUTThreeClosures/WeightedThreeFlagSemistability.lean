/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Scalar semistability of the three Legendre boundary weights

For positive integers `a+b=c`, the logarithmic weights

`log a`, `log b`, `log c`

satisfy the triangle inequality up to the absolute defect `log 2`.  If both
legs are at least two, the triangle inequality is exact.  These are the scalar
Hilbert--Mumford inequalities behind the globally labelled three-cusp
parabolic route.
-/

namespace IUTThreeClosures

/-- Every positive integral decomposition `c=a+b` satisfies `c <= 2ab`. -/
theorem sum_le_two_mul
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (h : a + b = c) :
    c ≤ 2 * a * b := by
  have ha1 : 1 ≤ a := ha
  have hb1 : 1 ≤ b := hb
  have hleft : a ≤ a * b := by
    simpa using Nat.mul_le_mul_left a hb1
  have hright : b ≤ a * b := by
    simpa [Nat.mul_comm] using Nat.mul_le_mul_left b ha1
  rw [← h]
  calc
    a + b ≤ a * b + a * b := Nat.add_le_add hleft hright
    _ = 2 * a * b := by ring

/-- If both legs are at least two, then `a+b <= ab`. -/
theorem sum_le_mul_of_two_le
    {a b c : ℕ}
    (ha : 2 ≤ a) (hb : 2 ≤ b)
    (h : a + b = c) :
    c ≤ a * b := by
  rw [← h]
  by_cases hab : a ≤ b
  · calc
      a + b ≤ b + b := Nat.add_le_add_right hab b
      _ = 2 * b := by ring
      _ ≤ a * b := Nat.mul_le_mul_right b ha
  · have hba : b ≤ a := Nat.le_of_lt (Nat.lt_of_not_ge hab)
    calc
      a + b ≤ a + a := Nat.add_le_add_left hba a
      _ = a * 2 := by ring
      _ ≤ a * b := Nat.mul_le_mul_left a hb

/-- Logarithmic form of the uniform defect `log c <= log a + log b + log 2`. -/
theorem log_sum_le_log_mul_add_log_two
    {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b)
    (h : a + b = c) :
    Real.log c ≤ Real.log a + Real.log b + Real.log 2 := by
  have hc : 0 < c := by omega
  have hmul : (c : ℝ) ≤ 2 * (a : ℝ) * (b : ℝ) := by
    exact_mod_cast sum_le_two_mul ha hb h
  have hpos2 : (0 : ℝ) < 2 := by norm_num
  have hposa : (0 : ℝ) < a := by exact_mod_cast ha
  have hposb : (0 : ℝ) < b := by exact_mod_cast hb
  have hlog := Real.log_le_log (by exact_mod_cast hc) hmul
  rw [Real.log_mul
      (mul_ne_zero (ne_of_gt hpos2) (ne_of_gt hposa))
      (ne_of_gt hposb),
    Real.log_mul (ne_of_gt hpos2) (ne_of_gt hposa)] at hlog
  simpa [add_comm, add_left_comm, add_assoc] using hlog

/-- Exact semistability away from the unit-leg cases. -/
theorem log_sum_le_log_mul_of_two_le
    {a b c : ℕ}
    (ha : 2 ≤ a) (hb : 2 ≤ b)
    (h : a + b = c) :
    Real.log c ≤ Real.log a + Real.log b := by
  have hc : 0 < c := by omega
  have hmul : (c : ℝ) ≤ (a : ℝ) * (b : ℝ) := by
    exact_mod_cast sum_le_mul_of_two_le ha hb h
  have hposa : (0 : ℝ) < a := by positivity
  have hposb : (0 : ℝ) < b := by positivity
  have hlog := Real.log_le_log (by exact_mod_cast hc) hmul
  rw [Real.log_mul (ne_of_gt hposa) (ne_of_gt hposb)] at hlog
  exact hlog

end IUTThreeClosures
