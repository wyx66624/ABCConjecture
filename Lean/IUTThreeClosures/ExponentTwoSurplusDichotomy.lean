/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Signed exponent-two surplus and the bounded/high-exponent dichotomy

For a finite positive exponent profile with nonnegative logarithmic weights,
define the signed multiplicity-two surplus

`sum_i (e_i - 2) w_i`.

It decomposes exactly as

`positive mass above exponent two - exponent-one mass`.

If the exponents are bounded by `K`, then positive surplus forces a definite
amount of radical weight on primes occurring to exponent at least three. In
general, either such a bounded-exponent cubed-support conclusion holds or an
exponent larger than `K` occurs.
-/

namespace IUTThreeClosures
namespace ExponentTwoSurplusDichotomy

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- Signed aggregate multiplicity surplus above the average level two. -/
def exponentSignedTwoSurplus
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, ((exponent i : ℝ) - 2) * weight i

/-- Positive prime-exponent mass above level two. -/
def exponentAboveTwoWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, ((exponent i - 2 : ℕ) : ℝ) * weight i

/-- Radical weight carried by exponent-one coordinates. -/
def exponentOneLayerWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, if exponent i = 1 then weight i else 0

/-- Radical weight carried by coordinates of exponent at least three. -/
def exponentAtLeastThreeWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, if 3 ≤ exponent i then weight i else 0

/-- Exact positive-part/minus-exponent-one decomposition. -/
theorem signedTwoSurplus_eq_aboveTwo_sub_one
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hpos : ∀ i ∈ s, 0 < exponent i) :
    exponentSignedTwoSurplus s weight exponent =
      exponentAboveTwoWeight s weight exponent -
        exponentOneLayerWeight s weight exponent := by
  classical
  unfold exponentSignedTwoSurplus exponentAboveTwoWeight
    exponentOneLayerWeight
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  by_cases hone : exponent i = 1
  · simp [hone]
  · have htwo : 2 ≤ exponent i := by
      have hpositive := hpos i hi
      omega
    rw [Nat.cast_sub htwo]
    simp [hone]
    ring

/-- The exponent-one layer has nonnegative weight. -/
theorem exponentOneLayerWeight_nonneg
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    0 ≤ exponentOneLayerWeight s weight exponent := by
  classical
  unfold exponentOneLayerWeight
  apply Finset.sum_nonneg
  intro i hi
  by_cases hone : exponent i = 1
  · simpa [hone] using hweight i hi
  · simp [hone]

/-- The exponent-at-least-three layer has nonnegative weight. -/
theorem exponentAtLeastThreeWeight_nonneg
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    0 ≤ exponentAtLeastThreeWeight s weight exponent := by
  classical
  unfold exponentAtLeastThreeWeight
  apply Finset.sum_nonneg
  intro i hi
  by_cases hthree : 3 ≤ exponent i
  · simpa [hthree] using hweight i hi
  · simp [hthree]

/-- Under exponent cap `K`, the positive mass above two is bounded by
`(K-2)` times the radical weight of the cubed support. -/
theorem aboveTwoWeight_le_cap_mul_atLeastThreeWeight
    {K : ℕ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hcap : ∀ i ∈ s, exponent i ≤ K) :
    exponentAboveTwoWeight s weight exponent ≤
      ((K - 2 : ℕ) : ℝ) *
        exponentAtLeastThreeWeight s weight exponent := by
  classical
  unfold exponentAboveTwoWeight exponentAtLeastThreeWeight
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  by_cases hthree : 3 ≤ exponent i
  · have htwo : 2 ≤ exponent i := by omega
    have hsub : exponent i - 2 ≤ K - 2 :=
      Nat.sub_le_sub_right (hcap i hi) 2
    have hcast :
        ((exponent i - 2 : ℕ) : ℝ) ≤ (K - 2 : ℕ) := by
      exact_mod_cast hsub
    simp only [if_pos hthree]
    exact mul_le_mul_of_nonneg_right hcast (hweight i hi)
  · have hle : exponent i ≤ 2 := by omega
    have hzero : exponent i - 2 = 0 := Nat.sub_eq_zero_of_le hle
    simp [hthree, hzero]

/-- With all exponents at most two, the signed surplus is nonpositive. -/
theorem signedTwoSurplus_nonpos_of_cap_two
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hcap : ∀ i ∈ s, exponent i ≤ 2) :
    exponentSignedTwoSurplus s weight exponent ≤ 0 := by
  have habove :=
    aboveTwoWeight_le_cap_mul_atLeastThreeWeight
      (K := 2) s weight exponent hweight hcap
  have hdecomp :=
    signedTwoSurplus_eq_aboveTwo_sub_one s weight exponent hpos
  have hone_nonneg :=
    exponentOneLayerWeight_nonneg s weight exponent hweight
  norm_num at habove
  linarith

/-- If the signed surplus is at least `delta` times the full radical weight and
all exponents are bounded by `K`, the cubed-support radical must pay the exact
budget displayed below. -/
theorem cubedSupport_budget_of_signedSurplus_and_cap
    {K : ℕ} {delta : ℝ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hcap : ∀ i ∈ s, exponent i ≤ K)
    (hsurplus :
      delta * exponentRadicalWeight s weight ≤
        exponentSignedTwoSurplus s weight exponent) :
    delta * exponentRadicalWeight s weight +
        exponentOneLayerWeight s weight exponent ≤
      ((K - 2 : ℕ) : ℝ) *
        exponentAtLeastThreeWeight s weight exponent := by
  have habove :=
    aboveTwoWeight_le_cap_mul_atLeastThreeWeight
      (K := K) s weight exponent hweight hcap
  have hdecomp :=
    signedTwoSurplus_eq_aboveTwo_sub_one s weight exponent hpos
  linarith

/-- Deterministic route split: either an exponent above `K` occurs, or the
bounded-exponent cubed-support budget holds. -/
theorem highExponent_or_cubedSupport_budget
    {K : ℕ} {delta : ℝ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hsurplus :
      delta * exponentRadicalWeight s weight ≤
        exponentSignedTwoSurplus s weight exponent) :
    (∃ i ∈ s, K < exponent i) ∨
      delta * exponentRadicalWeight s weight +
          exponentOneLayerWeight s weight exponent ≤
        ((K - 2 : ℕ) : ℝ) *
          exponentAtLeastThreeWeight s weight exponent := by
  classical
  by_cases hhigh : ∃ i ∈ s, K < exponent i
  · exact Or.inl hhigh
  · right
    have hcap : ∀ i ∈ s, exponent i ≤ K := by
      intro i hi
      by_contra hnot
      apply hhigh
      exact ⟨i, hi, lt_of_not_ge hnot⟩
    exact cubedSupport_budget_of_signedSurplus_and_cap
      s weight exponent hweight hpos hcap hsurplus

/-- A convenient lower bound after discarding the nonnegative exponent-one
term. -/
theorem delta_radical_le_cap_mul_cubedSupport
    {K : ℕ} {delta : ℝ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hcap : ∀ i ∈ s, exponent i ≤ K)
    (hsurplus :
      delta * exponentRadicalWeight s weight ≤
        exponentSignedTwoSurplus s weight exponent) :
    delta * exponentRadicalWeight s weight ≤
      ((K - 2 : ℕ) : ℝ) *
        exponentAtLeastThreeWeight s weight exponent := by
  have hbudget := cubedSupport_budget_of_signedSurplus_and_cap
    s weight exponent hweight hpos hcap hsurplus
  have hone_nonneg :=
    exponentOneLayerWeight_nonneg s weight exponent hweight
  linarith

#print axioms signedTwoSurplus_eq_aboveTwo_sub_one
#print axioms exponentOneLayerWeight_nonneg
#print axioms exponentAtLeastThreeWeight_nonneg
#print axioms aboveTwoWeight_le_cap_mul_atLeastThreeWeight
#print axioms signedTwoSurplus_nonpos_of_cap_two
#print axioms cubedSupport_budget_of_signedSurplus_and_cap
#print axioms highExponent_or_cubedSupport_budget
#print axioms delta_radical_le_cap_mul_cubedSupport

end
end ExponentTwoSurplusDichotomy
end IUTThreeClosures
