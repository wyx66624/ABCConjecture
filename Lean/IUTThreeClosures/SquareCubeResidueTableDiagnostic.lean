/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-! Temporary kernel diagnostic for the sharp residue table modulo six. -/

namespace IUTThreeClosures
namespace SquareCubeResidueTableDiagnostic

/-- Sharp support bound for a residue modulo six. -/
theorem mod_six_le_square_cube_residual_budget (e : ℕ) :
    e % 6 ≤
      (if ¬ 2 ∣ e then 3 else 0) +
        (if ¬ 3 ∣ e then 4 else 0) := by
  by_cases h2 : 2 ∣ e
  · by_cases h3 : 3 ∣ e
    · have h6 : 6 ∣ e :=
        (by norm_num : Nat.Coprime 2 3).mul_dvd_of_dvd_of_dvd h2 h3
      simp [h2, h3, Nat.mod_eq_zero_of_dvd h6]
    · have hsplit := Nat.mod_add_div e 6
      have hlt := Nat.mod_lt e (by norm_num : 0 < 6)
      obtain ⟨k, hk⟩ := h2
      simp [h2, h3]
      omega
  · by_cases h3 : 3 ∣ e
    · have hsplit := Nat.mod_add_div e 6
      have hlt := Nat.mod_lt e (by norm_num : 0 < 6)
      obtain ⟨k, hk⟩ := h3
      simp [h2, h3]
      omega
    · have hlt := Nat.mod_lt e (by norm_num : 0 < 6)
      simp [h2, h3]
      omega

/-- Sharp square-root plus cube-root quotient bound modulo six. -/
theorem div_two_add_div_three_le_sixth_budget (e : ℕ) :
    e / 2 + e / 3 ≤
      5 * (e / 6) +
        (if ¬ 2 ∣ e then 2 else 0) +
          (if ¬ 3 ∣ e then 3 else 0) := by
  have hsplit2 := Nat.mod_add_div e 2
  have hsplit3 := Nat.mod_add_div e 3
  have hsplit6 := Nat.mod_add_div e 6
  have hlt2 := Nat.mod_lt e (by norm_num : 0 < 2)
  have hlt3 := Nat.mod_lt e (by norm_num : 0 < 3)
  have hlt6 := Nat.mod_lt e (by norm_num : 0 < 6)
  by_cases h2 : 2 ∣ e
  · have hmod2 : e % 2 = 0 := Nat.mod_eq_zero_of_dvd h2
    by_cases h3 : 3 ∣ e
    · have hmod3 : e % 3 = 0 := Nat.mod_eq_zero_of_dvd h3
      have h6 : 6 ∣ e :=
        (by norm_num : Nat.Coprime 2 3).mul_dvd_of_dvd_of_dvd h2 h3
      have hmod6 : e % 6 = 0 := Nat.mod_eq_zero_of_dvd h6
      simp [h2, h3]
      omega
    · simp [h2, h3]
      omega
  · by_cases h3 : 3 ∣ e
    · have hmod3 : e % 3 = 0 := Nat.mod_eq_zero_of_dvd h3
      simp [h2, h3]
      omega
    · simp [h2, h3]
      omega

/-- Sharp signed exponent-two surplus budget modulo six. -/
theorem sub_two_le_sixth_signed_budget (e : ℕ) :
    e - 2 ≤
      6 * (e / 6) +
        (if ¬ 2 ∣ e then 1 else 0) +
          2 * (if ¬ 3 ∣ e then 1 else 0) := by
  have hsplit6 := Nat.mod_add_div e 6
  have hlt6 := Nat.mod_lt e (by norm_num : 0 < 6)
  by_cases h2 : 2 ∣ e
  · by_cases h3 : 3 ∣ e
    · have h6 : 6 ∣ e :=
        (by norm_num : Nat.Coprime 2 3).mul_dvd_of_dvd_of_dvd h2 h3
      have hmod6 : e % 6 = 0 := Nat.mod_eq_zero_of_dvd h6
      simp [h2, h3]
      omega
    · obtain ⟨k, hk⟩ := h2
      simp [h2, h3]
      omega
  · by_cases h3 : 3 ∣ e
    · obtain ⟨k, hk⟩ := h3
      simp [h2, h3]
      omega
    · simp [h2, h3]
      omega

/-- Real weighted form of the residue-coefficient budget. -/
theorem weighted_mod_six_le_square_cube_residual_budget
    (e : ℕ) (w : ℝ) (hw : 0 ≤ w) :
    ((e % 6 : ℕ) : ℝ) * w ≤
      3 * (if ¬ 2 ∣ e then w else 0) +
        4 * (if ¬ 3 ∣ e then w else 0) := by
  have hnat := mod_six_le_square_cube_residual_budget e
  have hreal :
      ((e % 6 : ℕ) : ℝ) ≤
        ((if ¬ 2 ∣ e then 3 else 0 : ℕ) : ℝ) +
          ((if ¬ 3 ∣ e then 4 else 0 : ℕ) : ℝ) := by
    exact_mod_cast hnat
  have hmul := mul_le_mul_of_nonneg_right hreal hw
  by_cases h2 : 2 ∣ e <;> by_cases h3 : 3 ∣ e <;>
    simp [h2, h3] at hmul ⊢ <;> nlinarith

/-- Real weighted form of the square-root/cube-root quotient budget. -/
theorem weighted_div_two_add_div_three_le_sixth_budget
    (e : ℕ) (w : ℝ) (hw : 0 ≤ w) :
    ((e / 2 : ℕ) : ℝ) * w + ((e / 3 : ℕ) : ℝ) * w ≤
      5 * ((e / 6 : ℕ) : ℝ) * w +
        2 * (if ¬ 2 ∣ e then w else 0) +
          3 * (if ¬ 3 ∣ e then w else 0) := by
  have hnat := div_two_add_div_three_le_sixth_budget e
  have hreal :
      ((e / 2 : ℕ) : ℝ) + ((e / 3 : ℕ) : ℝ) ≤
        5 * ((e / 6 : ℕ) : ℝ) +
          ((if ¬ 2 ∣ e then 2 else 0 : ℕ) : ℝ) +
            ((if ¬ 3 ∣ e then 3 else 0 : ℕ) : ℝ) := by
    exact_mod_cast hnat
  have hmul := mul_le_mul_of_nonneg_right hreal hw
  by_cases h2 : 2 ∣ e <;> by_cases h3 : 3 ∣ e <;>
    simp [h2, h3] at hmul ⊢ <;> nlinarith

/-- Real weighted form of the signed surplus budget. -/
theorem weighted_signed_surplus_le_sixth_budget
    (e : ℕ) (w : ℝ) (hw : 0 ≤ w) :
    (e : ℝ) * w - 2 * w ≤
      6 * ((e / 6 : ℕ) : ℝ) * w +
        (if ¬ 2 ∣ e then w else 0) +
          2 * (if ¬ 3 ∣ e then w else 0) := by
  by_cases he : 2 ≤ e
  · have hnat := sub_two_le_sixth_signed_budget e
    have hreal :
        ((e - 2 : ℕ) : ℝ) ≤
          6 * ((e / 6 : ℕ) : ℝ) +
            ((if ¬ 2 ∣ e then 1 else 0 : ℕ) : ℝ) +
              2 * ((if ¬ 3 ∣ e then 1 else 0 : ℕ) : ℝ) := by
      exact_mod_cast hnat
    rw [Nat.cast_sub he] at hreal
    have hmul := mul_le_mul_of_nonneg_right hreal hw
    by_cases h2 : 2 ∣ e <;> by_cases h3 : 3 ∣ e <;>
      simp [h2, h3] at hmul ⊢ <;> nlinarith
  · have he_cases : e = 0 ∨ e = 1 := by omega
    rcases he_cases with rfl | rfl <;> norm_num [hw]

#print axioms mod_six_le_square_cube_residual_budget
#print axioms div_two_add_div_three_le_sixth_budget
#print axioms sub_two_le_sixth_signed_budget
#print axioms weighted_mod_six_le_square_cube_residual_budget
#print axioms weighted_div_two_add_div_three_le_sixth_budget
#print axioms weighted_signed_surplus_le_sixth_budget

end SquareCubeResidueTableDiagnostic
end IUTThreeClosures
