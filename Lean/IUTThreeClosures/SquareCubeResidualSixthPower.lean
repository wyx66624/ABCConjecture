/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CoprimeModuliResidualProductCore
import Mathlib.Tactic

/-!
# Sharp square--cube residual control and sixth-power extraction

The generic coprime-moduli estimate controls the residue coefficient at the
product modulus, but its coefficient is not sharp.  For the square--cube pair
one can inspect the six exponent classes exactly.

For an exponent `e`, the three pointwise inequalities are

`e % 6 <= 3 * 1_(2 ∤ e) + 4 * 1_(3 ∤ e)`,

`floor(e/2) + floor(e/3)
  <= 5 * floor(e/6) + 2 * 1_(2 ∤ e) + 3 * 1_(3 ∤ e)`,

and, in signed exponent-two form,

`e - 2 <= 6 * floor(e/6) + 1_(2 ∤ e) + 2 * 1_(3 ∤ e)`.

After weighting and summing, these give a sharp three-way reduction: a large
signed exponent-two surplus forces either a large canonical sixth-power root,
a large parity-residual radical, or a large cubic-residual radical.

No abc estimate, generalized-Fermat theorem, or Diophantine gap theorem is
assumed.
-/

namespace IUTThreeClosures
namespace SquareCubeResidualSixthPower

open scoped BigOperators
open CoprimeModuliResidualProductCore

noncomputable section

variable {ι : Type*}

/-- Sharp support budget for a residue modulo six. -/
theorem mod_six_le_square_cube_residual_budget (e : ℕ) :
    e % 6 ≤
      (if ¬ 2 ∣ e then 3 else 0) +
        (if ¬ 3 ∣ e then 4 else 0) := by
  by_cases h2 : 2 ∣ e
  · by_cases h3 : 3 ∣ e
    · have h6 : 6 ∣ e :=
        (by norm_num : Nat.Coprime 2 3).mul_dvd_of_dvd_of_dvd h2 h3
      simp [h2, h3, Nat.mod_eq_zero_of_dvd h6]
    · have h2copy := h2
      obtain ⟨k, hk⟩ := h2
      have hsplit := Nat.mod_add_div e 6
      have hlt := Nat.mod_lt e (by norm_num : 0 < 6)
      simp [h2copy, h3]
      omega
  · by_cases h3 : 3 ∣ e
    · have h3copy := h3
      obtain ⟨k, hk⟩ := h3
      have hsplit := Nat.mod_add_div e 6
      have hlt := Nat.mod_lt e (by norm_num : 0 < 6)
      simp [h2, h3copy]
      omega
    · have hlt := Nat.mod_lt e (by norm_num : 0 < 6)
      simp [h2, h3]
      omega

/-- Sharp square-root plus cube-root quotient budget modulo six. -/
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
    · have h2copy := h2
      obtain ⟨k, hk⟩ := h2
      simp [h2copy, h3]
      omega
  · by_cases h3 : 3 ∣ e
    · have h3copy := h3
      obtain ⟨k, hk⟩ := h3
      simp [h2, h3copy]
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
    rcases he_cases with rfl | rfl
    · norm_num [hw]
    · norm_num
      nlinarith

/-- The sixth-power residue coefficient has the sharp square--cube support
budget `3 E₂ + 4 E₃`. -/
theorem sixthResidueWeight_le_three_squareResidual_add_four_cubeResidual
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentResidueWeight 6 s weight exponent ≤
      3 * residualRadicalWeight 2 s weight exponent +
        4 * residualRadicalWeight 3 s weight exponent := by
  classical
  unfold exponentResidueWeight residualRadicalWeight
    exponentResidualSupport
  simp only [Finset.sum_filter]
  calc
    (∑ i ∈ s, ((exponent i % 6 : ℕ) : ℝ) * weight i) ≤
        ∑ i ∈ s,
          (3 * (if ¬ 2 ∣ exponent i then weight i else 0) +
            4 * (if ¬ 3 ∣ exponent i then weight i else 0)) := by
      apply Finset.sum_le_sum
      intro i hi
      exact weighted_mod_six_le_square_cube_residual_budget
        (exponent i) (weight i) (hweight i hi)
    _ = 3 * (∑ i ∈ s, if ¬ 2 ∣ exponent i then weight i else 0) +
        4 * (∑ i ∈ s, if ¬ 3 ∣ exponent i then weight i else 0) := by
      rw [Finset.mul_sum, Finset.mul_sum,
        ← Finset.sum_add_distrib]

/-- The canonical square and cube roots overlap in a canonical sixth-power
root, up to the sharp residual correction `2 E₂ + 3 E₃`. -/
theorem squareRoot_add_cubeRoot_le_five_sixthRoot_add_residuals
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentQuotientWeight 2 s weight exponent +
        exponentQuotientWeight 3 s weight exponent ≤
      5 * exponentQuotientWeight 6 s weight exponent +
        2 * residualRadicalWeight 2 s weight exponent +
          3 * residualRadicalWeight 3 s weight exponent := by
  classical
  unfold exponentQuotientWeight residualRadicalWeight
    exponentResidualSupport
  simp only [Finset.sum_filter]
  rw [← Finset.sum_add_distrib]
  calc
    (∑ i ∈ s,
        (((exponent i / 2 : ℕ) : ℝ) * weight i +
          ((exponent i / 3 : ℕ) : ℝ) * weight i)) ≤
      ∑ i ∈ s,
        (5 * ((exponent i / 6 : ℕ) : ℝ) * weight i +
          (2 * (if ¬ 2 ∣ exponent i then weight i else 0) +
            3 * (if ¬ 3 ∣ exponent i then weight i else 0))) := by
      apply Finset.sum_le_sum
      intro i hi
      simpa [add_assoc] using
        weighted_div_two_add_div_three_le_sixth_budget
          (exponent i) (weight i) (hweight i hi)
    _ = 5 * (∑ i ∈ s, ((exponent i / 6 : ℕ) : ℝ) * weight i) +
        2 * (∑ i ∈ s, if ¬ 2 ∣ exponent i then weight i else 0) +
          3 * (∑ i ∈ s, if ¬ 3 ∣ exponent i then weight i else 0) := by
      simp only [mul_assoc]
      rw [Finset.sum_add_distrib, Finset.sum_add_distrib,
        ← Finset.mul_sum, ← Finset.mul_sum, ← Finset.mul_sum]
      ring

/-- Sharp finite-profile ledger for the signed exponent-two surplus. -/
theorem signedTwoSurplus_le_sixthRoot_add_residuals
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight ≤
      6 * exponentQuotientWeight 6 s weight exponent +
        residualRadicalWeight 2 s weight exponent +
          2 * residualRadicalWeight 3 s weight exponent := by
  classical
  unfold exponentTotalWeight exponentRadicalWeight
    exponentQuotientWeight residualRadicalWeight
    exponentResidualSupport
  simp only [Finset.sum_filter]
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib]
  calc
    (∑ i ∈ s,
        ((exponent i : ℝ) * weight i - 2 * weight i)) ≤
      ∑ i ∈ s,
        (6 * ((exponent i / 6 : ℕ) : ℝ) * weight i +
          ((if ¬ 2 ∣ exponent i then weight i else 0) +
            2 * (if ¬ 3 ∣ exponent i then weight i else 0))) := by
      apply Finset.sum_le_sum
      intro i hi
      simpa [add_assoc] using
        weighted_signed_surplus_le_sixth_budget
          (exponent i) (weight i) (hweight i hi)
    _ = 6 * (∑ i ∈ s, ((exponent i / 6 : ℕ) : ℝ) * weight i) +
        (∑ i ∈ s, if ¬ 2 ∣ exponent i then weight i else 0) +
          2 * (∑ i ∈ s, if ¬ 3 ∣ exponent i then weight i else 0) := by
      simp only [mul_assoc]
      rw [Finset.sum_add_distrib, Finset.sum_add_distrib,
        ← Finset.mul_sum, ← Finset.mul_sum]
      ring

/-- Flexible trichotomy: a surplus above the displayed combined budget forces
one of the three constituent quantities above its proposed threshold. -/
theorem signedSurplus_forces_sixth_or_squareResidual_or_cubeResidual
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {Q A B : ℝ}
    (hlarge :
      6 * Q + A + 2 * B <
        exponentTotalWeight s weight exponent -
          2 * exponentRadicalWeight s weight) :
    Q < exponentQuotientWeight 6 s weight exponent ∨
      A < residualRadicalWeight 2 s weight exponent ∨
        B < residualRadicalWeight 3 s weight exponent := by
  have hledger :=
    signedTwoSurplus_le_sixthRoot_add_residuals
      s weight exponent hweight
  by_cases hQ : Q < exponentQuotientWeight 6 s weight exponent
  · exact Or.inl hQ
  · right
    by_cases hA : A < residualRadicalWeight 2 s weight exponent
    · exact Or.inl hA
    · right
      have hQle := le_of_not_gt hQ
      have hAle := le_of_not_gt hA
      nlinarith

/-- Equal-contribution specialization. -/
theorem positive_signedSurplus_forces_quantitative_square_cube_sixth_split
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {L : ℝ}
    (hlarge :
      L < exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight) :
    L / 18 < exponentQuotientWeight 6 s weight exponent ∨
      L / 3 < residualRadicalWeight 2 s weight exponent ∨
        L / 6 < residualRadicalWeight 3 s weight exponent := by
  have h :=
    signedSurplus_forces_sixth_or_squareResidual_or_cubeResidual
      s weight exponent hweight
      (Q := L / 18) (A := L / 3) (B := L / 6)
      (by nlinarith)
  exact h

/-- If both the square and cube roots are collectively large, then either the
common sixth-power root is large or one residual radical is large. -/
theorem squareCubeRoots_force_sixth_or_residual
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {Q A B : ℝ}
    (hlarge :
      5 * Q + 2 * A + 3 * B <
        exponentQuotientWeight 2 s weight exponent +
          exponentQuotientWeight 3 s weight exponent) :
    Q < exponentQuotientWeight 6 s weight exponent ∨
      A < residualRadicalWeight 2 s weight exponent ∨
        B < residualRadicalWeight 3 s weight exponent := by
  have hledger :=
    squareRoot_add_cubeRoot_le_five_sixthRoot_add_residuals
      s weight exponent hweight
  by_cases hQ : Q < exponentQuotientWeight 6 s weight exponent
  · exact Or.inl hQ
  · right
    by_cases hA : A < residualRadicalWeight 2 s weight exponent
    · exact Or.inl hA
    · right
      have hQle := le_of_not_gt hQ
      have hAle := le_of_not_gt hA
      nlinarith

#print axioms mod_six_le_square_cube_residual_budget
#print axioms div_two_add_div_three_le_sixth_budget
#print axioms sub_two_le_sixth_signed_budget
#print axioms sixthResidueWeight_le_three_squareResidual_add_four_cubeResidual
#print axioms squareRoot_add_cubeRoot_le_five_sixthRoot_add_residuals
#print axioms signedTwoSurplus_le_sixthRoot_add_residuals
#print axioms signedSurplus_forces_sixth_or_squareResidual_or_cubeResidual
#print axioms positive_signedSurplus_forces_quantitative_square_cube_sixth_split
#print axioms squareCubeRoots_force_sixth_or_residual

end
end SquareCubeResidualSixthPower
end IUTThreeClosures
