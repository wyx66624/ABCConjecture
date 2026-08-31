/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ExponentTwoSurplusDichotomy
import Mathlib.Tactic

/-!
# Quantitative high-exponent energy versus bounded cubed support

The qualitative alternative “some exponent exceeds `K`” may be caused by one
negligible prime.  This file replaces it by a weighted dichotomy.

The positive mass above exponent two is bounded by

`(K-2) * weight(3 <= e <= K) + surplusMass(K < e)`.

Hence conductor-scale signed surplus forces either conductor-scale
high-exponent energy or a quantitative bounded-exponent cubed-support layer.
-/

namespace IUTThreeClosures
namespace QuantitativeHighExponentEnergyDichotomy

open scoped BigOperators
open ExponentTwoSurplusDichotomy

noncomputable section

variable {ι : Type*}

/-- Radical weight of coordinates with exponent between three and `K`. -/
def exponentThreeToCutoffWeight
    (K : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i in s,
    if 3 ≤ exponent i ∧ exponent i ≤ K then weight i else 0

/-- Positive exponent surplus carried by coordinates above cutoff `K`. -/
def exponentAboveCutoffSurplus
    (K : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i in s,
    if K < exponent i then
      ((exponent i - 2 : ℕ) : ℝ) * weight i
    else 0

/-- The bounded cubed-support layer has nonnegative weight. -/
theorem exponentThreeToCutoffWeight_nonneg
    (K : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    0 ≤ exponentThreeToCutoffWeight K s weight exponent := by
  classical
  unfold exponentThreeToCutoffWeight
  apply Finset.sum_nonneg
  intro i hi
  by_cases hmid : 3 ≤ exponent i ∧ exponent i ≤ K
  · simpa [hmid] using hweight i hi
  · simp [hmid]

/-- The high-exponent surplus layer has nonnegative weight. -/
theorem exponentAboveCutoffSurplus_nonneg
    (K : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    0 ≤ exponentAboveCutoffSurplus K s weight exponent := by
  classical
  unfold exponentAboveCutoffSurplus
  apply Finset.sum_nonneg
  intro i hi
  by_cases hhigh : K < exponent i
  · have hfactor : 0 ≤ ((exponent i - 2 : ℕ) : ℝ) := by positivity
    simp only [if_pos hhigh]
    exact mul_nonneg hfactor (hweight i hi)
  · simp [hhigh]

/-- Exact deterministic upper split for positive exponent mass above two. -/
theorem aboveTwoWeight_le_bounded_mul_add_highEnergy
    {K : ℕ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentAboveTwoWeight s weight exponent ≤
      ((K - 2 : ℕ) : ℝ) *
          exponentThreeToCutoffWeight K s weight exponent +
        exponentAboveCutoffSurplus K s weight exponent := by
  classical
  unfold exponentAboveTwoWeight exponentThreeToCutoffWeight
    exponentAboveCutoffSurplus
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_le_sum
  intro i hi
  by_cases hhigh : K < exponent i
  · have hnotmid : ¬(3 ≤ exponent i ∧ exponent i ≤ K) := by omega
    simp [hhigh, hnotmid]
  · have hcap : exponent i ≤ K := by omega
    by_cases hthree : 3 ≤ exponent i
    · have hmid : 3 ≤ exponent i ∧ exponent i ≤ K := ⟨hthree, hcap⟩
      have hsub : exponent i - 2 ≤ K - 2 :=
        Nat.sub_le_sub_right hcap 2
      have hcast :
          ((exponent i - 2 : ℕ) : ℝ) ≤ (K - 2 : ℕ) := by
        exact_mod_cast hsub
      simp only [if_neg hhigh, if_pos hmid, add_zero]
      exact mul_le_mul_of_nonneg_right hcast (hweight i hi)
    · have hle : exponent i ≤ 2 := by omega
      have hzero : exponent i - 2 = 0 := Nat.sub_eq_zero_of_le hle
      have hnotmid : ¬(3 ≤ exponent i ∧ exponent i ≤ K) := by omega
      simp [hhigh, hnotmid, hzero]

/-- Quantitative route split.  Half of the forced positive mass lies either in
high-exponent surplus or, after division by `K-2`, in bounded cubed support. -/
theorem highEnergy_or_boundedCubedSupport
    {K : ℕ} (hK : 3 ≤ K)
    {delta : ℝ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hsurplus :
      delta * exponentRadicalWeight s weight ≤
        exponentSignedTwoSurplus s weight exponent) :
    let A :=
      delta * exponentRadicalWeight s weight +
        exponentOneLayerWeight s weight exponent
    A / 2 ≤ exponentAboveCutoffSurplus K s weight exponent ∨
      A / (2 * ((K - 2 : ℕ) : ℝ)) ≤
        exponentThreeToCutoffWeight K s weight exponent := by
  dsimp
  have hdecomp :=
    signedTwoSurplus_eq_aboveTwo_sub_one s weight exponent hpos
  have hsplit := aboveTwoWeight_le_bounded_mul_add_highEnergy
    (K := K) s weight exponent hweight
  have hdNat : 0 < K - 2 := by omega
  have hd : 0 < ((K - 2 : ℕ) : ℝ) := by exact_mod_cast hdNat
  by_cases hhigh :
      (delta * exponentRadicalWeight s weight +
          exponentOneLayerWeight s weight exponent) / 2 ≤
        exponentAboveCutoffSurplus K s weight exponent
  · exact Or.inl hhigh
  · right
    have hhigh_lt :
        exponentAboveCutoffSurplus K s weight exponent <
          (delta * exponentRadicalWeight s weight +
            exponentOneLayerWeight s weight exponent) / 2 :=
      lt_of_not_ge hhigh
    apply (div_le_iff₀ (mul_pos (by norm_num) hd)).2
    nlinarith

#print axioms exponentThreeToCutoffWeight_nonneg
#print axioms exponentAboveCutoffSurplus_nonneg
#print axioms aboveTwoWeight_le_bounded_mul_add_highEnergy
#print axioms highEnergy_or_boundedCubedSupport

end
end QuantitativeHighExponentEnergyDichotomy
end IUTThreeClosures
