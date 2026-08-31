/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ExponentTwoSurplusDichotomy
import Mathlib.Tactic

/-!
# Adaptive exponent-modulus coverage selector

On a finite exponent profile with exponents at most `K`, every coordinate of
exponent at least three is detected by at least one modulus in the interval
`[3,K]`: namely by its own exponent.  Summing the corresponding divisible
weights therefore covers the full cubed-support radical weight.

Combining this coverage with the exponent-two surplus budget shows that a
bounded-exponent profile with conductor-scale positive surplus admits an
adaptive modulus which detects a quantitatively large amount of radical
weight.  This is the deterministic selector needed before any modular or
level-lowering theorem is applied.

No modularity, level lowering, or distribution theorem is assumed here.
-/

namespace IUTThreeClosures
namespace ExponentModulusCoverageSelector

open scoped BigOperators
open ExponentTwoSurplusDichotomy

noncomputable section

variable {ι : Type*}

/-- Weight of coordinates whose exponent is divisible by `n`. -/
def exponentDivisibleWeight
    (n : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i in s, if n ∣ exponent i then weight i else 0

/-- Divisible-exponent weights are nonnegative when all coordinate weights are
nonnegative. -/
theorem exponentDivisibleWeight_nonneg
    (n : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    0 ≤ exponentDivisibleWeight n s weight exponent := by
  classical
  unfold exponentDivisibleWeight
  apply Finset.sum_nonneg
  intro i hi
  by_cases hdiv : n ∣ exponent i
  · simpa [hdiv] using hweight i hi
  · simp [hdiv]

/-- Passing to a divisor of the modulus can only enlarge the detected weight. -/
theorem exponentDivisibleWeight_mono_of_dvd
    {m n : ℕ} (hmn : m ∣ n)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentDivisibleWeight n s weight exponent ≤
      exponentDivisibleWeight m s weight exponent := by
  classical
  unfold exponentDivisibleWeight
  apply Finset.sum_le_sum
  intro i hi
  by_cases hn : n ∣ exponent i
  · have hm : m ∣ exponent i := dvd_trans hmn hn
    simp [hn, hm]
  · simp only [if_neg hn]
    by_cases hm : m ∣ exponent i
    · simpa [hm] using hweight i hi
    · simp [hm]

/-- Pointwise coverage: a coordinate of exponent in `[3,K]` contributes its
full weight to the sum over divisible moduli in `[3,K]`. -/
theorem coordinate_weight_le_modulus_cover
    {K : ℕ} {i : ι}
    (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : 0 ≤ weight i)
    (hthree : 3 ≤ exponent i)
    (hcap : exponent i ≤ K) :
    weight i ≤
      ∑ n in Finset.Icc 3 K,
        if n ∣ exponent i then weight i else 0 := by
  classical
  have hmem : exponent i ∈ Finset.Icc 3 K := by
    exact Finset.mem_Icc.mpr ⟨hthree, hcap⟩
  have hnonneg :
      ∀ n ∈ Finset.Icc 3 K,
        0 ≤ if n ∣ exponent i then weight i else 0 := by
    intro n hn
    by_cases hdiv : n ∣ exponent i
    · simpa [hdiv] using hweight
    · simp [hdiv]
  have hsingle :
      (if exponent i ∣ exponent i then weight i else 0) ≤
        ∑ n in Finset.Icc 3 K,
          if n ∣ exponent i then weight i else 0 := by
    exact Finset.single_le_sum hnonneg hmem
  simpa using hsingle

/-- The moduli `3,...,K` cover the complete exponent-at-least-three radical
weight whenever all exponents are at most `K`. -/
theorem atLeastThreeWeight_le_sum_divisibleWeight_Icc
    {K : ℕ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hcap : ∀ i ∈ s, exponent i ≤ K) :
    exponentAtLeastThreeWeight s weight exponent ≤
      ∑ n in Finset.Icc 3 K,
        exponentDivisibleWeight n s weight exponent := by
  classical
  unfold exponentAtLeastThreeWeight exponentDivisibleWeight
  calc
    (∑ i ∈ s, if 3 ≤ exponent i then weight i else 0) ≤
        ∑ i ∈ s,
          ∑ n in Finset.Icc 3 K,
            if n ∣ exponent i then weight i else 0 := by
      apply Finset.sum_le_sum
      intro i hi
      by_cases hthree : 3 ≤ exponent i
      · simp only [if_pos hthree]
        exact coordinate_weight_le_modulus_cover weight exponent
          (hweight i hi) hthree (hcap i hi)
      · simp only [if_neg hthree]
        exact Finset.sum_nonneg fun n hn => by
          by_cases hdiv : n ∣ exponent i
          · simpa [hdiv] using hweight i hi
          · simp [hdiv]
    _ = ∑ n in Finset.Icc 3 K,
          ∑ i ∈ s, if n ∣ exponent i then weight i else 0 := by
      rw [Finset.sum_comm]

/-- If every modulus in `[3,K]` detects at most `B`, then the entire cubed
support is bounded by the cardinality of that interval times `B`. -/
theorem atLeastThreeWeight_le_card_mul_of_each_le
    {K : ℕ} {B : ℝ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hcap : ∀ i ∈ s, exponent i ≤ K)
    (heach : ∀ n ∈ Finset.Icc 3 K,
      exponentDivisibleWeight n s weight exponent ≤ B) :
    exponentAtLeastThreeWeight s weight exponent ≤
      ((Finset.Icc 3 K).card : ℝ) * B := by
  have hcover := atLeastThreeWeight_le_sum_divisibleWeight_Icc
    s weight exponent hweight hcap
  have hsum :
      (∑ n in Finset.Icc 3 K,
        exponentDivisibleWeight n s weight exponent) ≤
          ((Finset.Icc 3 K).card : ℝ) * B := by
    calc
      (∑ n in Finset.Icc 3 K,
        exponentDivisibleWeight n s weight exponent) ≤
          ∑ _n in Finset.Icc 3 K, B := by
        exact Finset.sum_le_sum fun n hn => heach n hn
      _ = ((Finset.Icc 3 K).card : ℝ) * B := by simp
  exact hcover.trans hsum

/-- Quantitative adaptive-modulus selector. If a threshold `B` is too small to
pay the bounded-exponent surplus budget after averaging over `[3,K]`, some
modulus in that interval detects more than `B` radical weight. -/
theorem exists_modulus_of_surplus_budget
    {K : ℕ} {delta B : ℝ}
    (hK : 3 ≤ K)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hcap : ∀ i ∈ s, exponent i ≤ K)
    (hsurplus :
      delta * exponentRadicalWeight s weight ≤
        exponentSignedTwoSurplus s weight exponent)
    (hthreshold :
      ((K - 2 : ℕ) : ℝ) *
          ((Finset.Icc 3 K).card : ℝ) * B <
        delta * exponentRadicalWeight s weight +
          exponentOneLayerWeight s weight exponent) :
    ∃ n ∈ Finset.Icc 3 K,
      B < exponentDivisibleWeight n s weight exponent := by
  classical
  have hbudget := cubedSupport_budget_of_signedSurplus_and_cap
    s weight exponent hweight hpos hcap hsurplus
  by_contra hnot
  push_neg at hnot
  have hcovered := atLeastThreeWeight_le_card_mul_of_each_le
    s weight exponent hweight hcap hnot
  have hcoef_nonneg : 0 ≤ ((K - 2 : ℕ) : ℝ) := by positivity
  have hscaled := mul_le_mul_of_nonneg_left hcovered hcoef_nonneg
  nlinarith

/-- The interval of candidate moduli is nonempty at every cutoff at least
three. -/
theorem Icc_three_nonempty {K : ℕ} (hK : 3 ≤ K) :
    (Finset.Icc 3 K).Nonempty := by
  exact ⟨3, Finset.mem_Icc.mpr ⟨le_rfl, hK⟩⟩

#print axioms exponentDivisibleWeight_nonneg
#print axioms exponentDivisibleWeight_mono_of_dvd
#print axioms coordinate_weight_le_modulus_cover
#print axioms atLeastThreeWeight_le_sum_divisibleWeight_Icc
#print axioms atLeastThreeWeight_le_card_mul_of_each_le
#print axioms exists_modulus_of_surplus_budget
#print axioms Icc_three_nonempty

end
end ExponentModulusCoverageSelector
end IUTThreeClosures
