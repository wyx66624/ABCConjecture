/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TwoInertiaLinearHeight

/-!
# Candidate local inertia parameters for the Frey curve

At an odd multiplicative boundary prime with valuation exponent `m`, the
minimal discriminant exponent is expected to be `2*m`.  In the unit-leg
`2`-adic case, after cancelling the fixed `2^8` scaling contribution, the
candidate exponent is `2*n-8`.

This module does not assert the local Tate/Picard--Lefschetz identification.
It proves the complete elementary and quantitative properties of these two
candidate formulas.
-/

namespace IUTThreeClosures

/-- Candidate Picard--Lefschetz parameter at an odd Frey boundary prime. -/
def oddFreyInertiaExponent (m : ℕ) : ℕ :=
  2 * m

/-- Candidate residual Picard--Lefschetz parameter at the unit-leg `2`-adic
boundary. -/
def twoAdicFreyInertiaExponent (n : ℕ) : ℕ :=
  2 * n - 8

/-- The odd-prime candidate is positive for a positive valuation exponent. -/
theorem oddFreyInertiaExponent_pos
    {m : ℕ} (hm : 0 < m) :
    0 < oddFreyInertiaExponent m := by
  unfold oddFreyInertiaExponent
  omega

/-- The residual two-adic candidate is positive once `n ≥ 5`. -/
theorem twoAdicFreyInertiaExponent_pos
    {n : ℕ} (hn : 5 ≤ n) :
    0 < twoAdicFreyInertiaExponent n := by
  unfold twoAdicFreyInertiaExponent
  omega

/-- The residual two-adic candidate is at most twice the original exponent. -/
theorem twoAdicFreyInertiaExponent_le_two_mul
    (n : ℕ) :
    twoAdicFreyInertiaExponent n ≤ 2 * n := by
  unfold twoAdicFreyInertiaExponent
  omega

/-- The universal logarithmic coefficient for both candidate parameters. -/
def freyInertiaHeightCoefficient : ℝ :=
  2 / Real.log 2

/-- The universal coefficient is positive. -/
theorem freyInertiaHeightCoefficient_pos :
    0 < freyInertiaHeightCoefficient := by
  unfold freyInertiaHeightCoefficient
  positivity

/-- An odd-prime candidate exponent is linearly bounded by `log c`. -/
theorem oddFreyInertiaExponent_le_log_height
    {m c : ℕ}
    (hc : 0 < c)
    (hpow : 2 ^ m ≤ c) :
    (oddFreyInertiaExponent m : ℝ) ≤
      freyInertiaHeightCoefficient * Real.log c := by
  have hm := exponent_le_log_div_log_two hc hpow
  unfold oddFreyInertiaExponent freyInertiaHeightCoefficient
  norm_num only [Nat.cast_mul, Nat.cast_ofNat]
  have hlog2 : Real.log 2 ≠ 0 :=
    ne_of_gt (Real.log_pos (by norm_num : (1 : ℝ) < 2))
  field_simp [hlog2] at hm ⊢
  nlinarith

/-- The residual two-adic candidate exponent is linearly bounded by `log c`. -/
theorem twoAdicFreyInertiaExponent_le_log_height
    {n c : ℕ}
    (hc : 0 < c)
    (hpow : 2 ^ n ≤ c) :
    (twoAdicFreyInertiaExponent n : ℝ) ≤
      freyInertiaHeightCoefficient * Real.log c := by
  have hn := exponent_le_log_div_log_two hc hpow
  have hcandidateNat := twoAdicFreyInertiaExponent_le_two_mul n
  have hcandidate :
      (twoAdicFreyInertiaExponent n : ℝ) ≤ 2 * (n : ℝ) := by
    exact_mod_cast hcandidateNat
  unfold freyInertiaHeightCoefficient
  have hlog2 : Real.log 2 ≠ 0 :=
    ne_of_gt (Real.log_pos (by norm_num : (1 : ℝ) < 2))
  field_simp [hlog2] at hn ⊢
  nlinarith

/-- Two odd boundary directions give a selected prime with sublinear logarithmic
height growth. -/
theorem odd_odd_selectedPrime_log_sublinear
    {B m n c : ℕ}
    (D : TwoInertiaPrimeData B
      (oddFreyInertiaExponent m)
      (oddFreyInertiaExponent n))
    (hc : 0 < c)
    (hpowm : 2 ^ m ≤ c)
    (hpown : 2 ^ n ≤ c)
    {η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ,
      Real.log D.ell ≤ η * Real.log c + C := by
  apply twoInertiaPrime_log_sublinear_of_linear_height
    D freyInertiaHeightCoefficient_pos.le
      (Real.log_nonneg (by
        exact_mod_cast (Nat.one_le_iff_ne_zero.mpr (Nat.ne_of_gt hc))))
  · exact oddFreyInertiaExponent_le_log_height hc hpowm
  · exact oddFreyInertiaExponent_le_log_height hc hpown
  · exact hη

/-- One odd boundary and one sufficiently deep unit-leg `2`-adic boundary also
give a selected prime with sublinear logarithmic height growth. -/
theorem odd_twoAdic_selectedPrime_log_sublinear
    {B m n c : ℕ}
    (D : TwoInertiaPrimeData B
      (oddFreyInertiaExponent m)
      (twoAdicFreyInertiaExponent n))
    (hc : 0 < c)
    (hpowm : 2 ^ m ≤ c)
    (hpown : 2 ^ n ≤ c)
    {η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ,
      Real.log D.ell ≤ η * Real.log c + C := by
  apply twoInertiaPrime_log_sublinear_of_linear_height
    D freyInertiaHeightCoefficient_pos.le
      (Real.log_nonneg (by
        exact_mod_cast (Nat.one_le_iff_ne_zero.mpr (Nat.ne_of_gt hc))))
  · exact oddFreyInertiaExponent_le_log_height hc hpowm
  · exact twoAdicFreyInertiaExponent_le_log_height hc hpown
  · exact hη

end IUTThreeClosures
