/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Signed multiplicity and the cubic-layer/high-exponent dichotomy

For a finite positive exponent profile, the exact signed multiplicity excess
splits as

`positive mass above exponent two - exponent-one mass`.

If all exponents are bounded by `B`, the positive excess is at most
`(B-2)` times the weight of the support occurring to exponent at least three.
Consequently any profile with positive conductor-scale signed excess has the
following rigorous dichotomy:

* some prime exponent exceeds `B`; or
* the cubic support has positive conductor-scale weight.

This is a finite combinatorial reduction only.  It supplies neither a modular
level-lowering theorem nor a uniform Diophantine estimate.
-/

namespace IUTThreeClosures
namespace SignedMultiplicityExponentLayerDichotomy

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- Signed exponent mass relative to the radical-square baseline. -/
def exponentSignedMultiplicityExcessWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  exponentTotalWeight s weight exponent -
    2 * exponentRadicalWeight s weight

/-- Unsigned exponent mass above level two. -/
def exponentPositiveMultiplicityExcessWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, ((exponent i - 2 : ℕ) : ℝ) * weight i

/-- Weight of the exact exponent-one layer. -/
def exponentOneLayerWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, if exponent i = 1 then weight i else 0

/-- Weight of primes occurring to exponent at least three. -/
def exponentAtLeastThreeWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, if 3 ≤ exponent i then weight i else 0

/-- Exact layer identity for a positive exponent profile. -/
theorem exponentSignedMultiplicityExcessWeight_eq_positive_sub_one
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hpos : ∀ i ∈ s, 0 < exponent i) :
    exponentSignedMultiplicityExcessWeight s weight exponent =
      exponentPositiveMultiplicityExcessWeight s weight exponent -
        exponentOneLayerWeight s weight exponent := by
  classical
  unfold exponentSignedMultiplicityExcessWeight
  unfold exponentPositiveMultiplicityExcessWeight
  unfold exponentOneLayerWeight
  unfold exponentTotalWeight exponentRadicalWeight
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib,
      ← Finset.sum_sub_distrib]
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

/-- The exact exponent-one layer has nonnegative weight. -/
theorem exponentOneLayerWeight_nonneg
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    0 ≤ exponentOneLayerWeight s weight exponent := by
  classical
  unfold exponentOneLayerWeight
  apply Finset.sum_nonneg
  intro i hi
  split_ifs
  · exact hweight i hi
  · exact le_rfl

/-- Under an exponent ceiling `B`, all positive excess is charged to cubic
support with multiplicity at most `B-2`. -/
theorem positiveExcess_le_bound_mul_atLeastThreeWeight
    {B : ℕ} (hB : 3 ≤ B)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hbound : ∀ i ∈ s, exponent i ≤ B) :
    exponentPositiveMultiplicityExcessWeight s weight exponent ≤
      ((B - 2 : ℕ) : ℝ) *
        exponentAtLeastThreeWeight s weight exponent := by
  classical
  unfold exponentPositiveMultiplicityExcessWeight
  unfold exponentAtLeastThreeWeight
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  by_cases hthree : 3 ≤ exponent i
  · simp [hthree]
    have hsubNat : exponent i - 2 ≤ B - 2 := by omega
    have hsubReal :
        ((exponent i - 2 : ℕ) : ℝ) ≤ (B - 2 : ℕ) := by
      exact_mod_cast hsubNat
    exact mul_le_mul_of_nonneg_right hsubReal (hweight i hi)
  · have hle : exponent i ≤ 2 := by omega
    have hzero : exponent i - 2 = 0 := by omega
    simp [hthree, hzero]

/-- A profile with positive signed excess either has an exponent above `B`,
or has a large cubic support. -/
theorem highExponent_or_largeCubicSupport
    {B : ℕ} (hB : 3 ≤ B)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (delta : ℝ)
    (hexcess :
      delta * exponentRadicalWeight s weight <
        exponentSignedMultiplicityExcessWeight s weight exponent) :
    (∃ i ∈ s, B < exponent i) ∨
      delta * exponentRadicalWeight s weight <
        ((B - 2 : ℕ) : ℝ) *
          exponentAtLeastThreeWeight s weight exponent := by
  classical
  by_cases hhigh : ∃ i ∈ s, B < exponent i
  · exact Or.inl hhigh
  · right
    have hbound : ∀ i ∈ s, exponent i ≤ B := by
      intro i hi
      by_contra hnot
      have hlt : B < exponent i := by omega
      exact hhigh ⟨i, hi, hlt⟩
    have hlayers :=
      exponentSignedMultiplicityExcessWeight_eq_positive_sub_one
        s weight exponent hpos
    have hone := exponentOneLayerWeight_nonneg s weight exponent hweight
    have hpositive :
        delta * exponentRadicalWeight s weight <
          exponentPositiveMultiplicityExcessWeight s weight exponent := by
      rw [hlayers] at hexcess
      linarith
    have hupper :=
      positiveExcess_le_bound_mul_atLeastThreeWeight
        hB s weight exponent hweight hbound
    exact hpositive.trans_le hupper

#print axioms exponentSignedMultiplicityExcessWeight_eq_positive_sub_one
#print axioms positiveExcess_le_bound_mul_atLeastThreeWeight
#print axioms highExponent_or_largeCubicSupport

end
end SignedMultiplicityExponentLayerDichotomy
end IUTThreeClosures
