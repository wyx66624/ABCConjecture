/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ExponentTwoSurplusDichotomy
import Mathlib.Tactic

/-!
# Layer-cake selection for exponent-two surplus

For a positive exponent `e`, the amount `e-2` is exactly the number of
integer layers `j=3,...,e`. Consequently the positive exponent mass above two
is the sum of the nested `j`-full radical layers.

Under an exponent cap `K`, positive signed surplus therefore selects a single
power layer in `[3,K]` carrying a quantitative amount of radical weight. This
is complementary to exponent-divisibility selection: the selected layer gives
an actual `j`-th-power divisor rather than a residue-class modulus.
-/

namespace IUTThreeClosures
namespace ExponentLayerCakeSelector

open scoped BigOperators
open ExponentTwoSurplusDichotomy

noncomputable section

variable {ι : Type*}

/-- Radical weight of coordinates whose exponent is at least `j`. -/
def exponentAtLeastLayerWeight
    (j : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i in s, if j ≤ exponent i then weight i else 0

/-- Each nested exponent layer has nonnegative weight. -/
theorem exponentAtLeastLayerWeight_nonneg
    (j : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    0 ≤ exponentAtLeastLayerWeight j s weight exponent := by
  classical
  unfold exponentAtLeastLayerWeight
  apply Finset.sum_nonneg
  intro i hi
  by_cases hj : j ≤ exponent i
  · simpa [hj] using hweight i hi
  · simp [hj]

/-- The interval `[3,e]` has exactly `e-2` elements when `e>=3`. -/
theorem card_Icc_three {e : ℕ} (he : 3 ≤ e) :
    (Finset.Icc 3 e).card = e - 2 := by
  rw [Nat.card_Icc]
  omega

/-- Coordinatewise layer-cake identity under the global exponent cap. -/
theorem coordinate_aboveTwo_eq_layer_sum
    {K e : ℕ} (w : ℝ)
    (hcap : e ≤ K) :
    ((e - 2 : ℕ) : ℝ) * w =
      ∑ j in Finset.Icc 3 K, if j ≤ e then w else 0 := by
  classical
  by_cases hthree : 3 ≤ e
  · have hfilter :
        (Finset.Icc 3 K).filter (fun j => j ≤ e) =
          Finset.Icc 3 e := by
      ext j
      simp only [Finset.mem_filter, Finset.mem_Icc]
      constructor
      · rintro ⟨⟨hj3, hjK⟩, hje⟩
        exact ⟨hj3, hje⟩
      · rintro ⟨hj3, hje⟩
        exact ⟨⟨hj3, hje.trans hcap⟩, hje⟩
    have hsum_filter :
        (∑ j in (Finset.Icc 3 K).filter (fun j => j ≤ e), w) =
          ∑ j in Finset.Icc 3 K, if j ≤ e then w else 0 := by
      rw [Finset.sum_filter]
    rw [← hsum_filter, hfilter]
    have hcard := card_Icc_three hthree
    simp [hcard]
  · have hle : e ≤ 2 := by omega
    have hsub : e - 2 = 0 := Nat.sub_eq_zero_of_le hle
    rw [hsub]
    simp only [Nat.cast_zero, zero_mul]
    apply Finset.sum_eq_zero
    intro j hj
    have hj3 : 3 ≤ j := (Finset.mem_Icc.mp hj).1
    have hnot : ¬ j ≤ e := by omega
    simp [hnot]

/-- Exact layer-cake identity for the positive exponent mass above two. -/
theorem aboveTwoWeight_eq_sum_layers
    {K : ℕ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hcap : ∀ i ∈ s, exponent i ≤ K) :
    exponentAboveTwoWeight s weight exponent =
      ∑ j in Finset.Icc 3 K,
        exponentAtLeastLayerWeight j s weight exponent := by
  classical
  unfold exponentAboveTwoWeight exponentAtLeastLayerWeight
  calc
    (∑ i ∈ s, ((exponent i - 2 : ℕ) : ℝ) * weight i) =
        ∑ i ∈ s,
          ∑ j in Finset.Icc 3 K,
            if j ≤ exponent i then weight i else 0 := by
      apply Finset.sum_congr rfl
      intro i hi
      exact coordinate_aboveTwo_eq_layer_sum
        (weight i) (hcap i hi)
    _ = ∑ j in Finset.Icc 3 K,
          ∑ i ∈ s,
            if j ≤ exponent i then weight i else 0 := by
      rw [Finset.sum_comm]

/-- Signed surplus plus the exponent-one layer equals the sum of all nested
power layers. -/
theorem signedSurplus_add_one_eq_sum_layers
    {K : ℕ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hcap : ∀ i ∈ s, exponent i ≤ K) :
    exponentSignedTwoSurplus s weight exponent +
        exponentOneLayerWeight s weight exponent =
      ∑ j in Finset.Icc 3 K,
        exponentAtLeastLayerWeight j s weight exponent := by
  have hdecomp :=
    signedTwoSurplus_eq_aboveTwo_sub_one s weight exponent hpos
  have hlayers := aboveTwoWeight_eq_sum_layers
    s weight exponent hcap
  linarith

/-- If every power layer is at most `B`, the total positive exponent mass is
bounded by the number of available layers times `B`. -/
theorem aboveTwoWeight_le_card_mul_of_each_layer_le
    {K : ℕ} {B : ℝ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hcap : ∀ i ∈ s, exponent i ≤ K)
    (heach : ∀ j ∈ Finset.Icc 3 K,
      exponentAtLeastLayerWeight j s weight exponent ≤ B) :
    exponentAboveTwoWeight s weight exponent ≤
      ((Finset.Icc 3 K).card : ℝ) * B := by
  rw [aboveTwoWeight_eq_sum_layers s weight exponent hcap]
  calc
    (∑ j in Finset.Icc 3 K,
      exponentAtLeastLayerWeight j s weight exponent) ≤
        ∑ _j in Finset.Icc 3 K, B := by
      exact Finset.sum_le_sum fun j hj => heach j hj
    _ = ((Finset.Icc 3 K).card : ℝ) * B := by simp

/-- Adaptive power-layer selector from a signed surplus lower bound. -/
theorem exists_power_layer_of_signedSurplus
    {K : ℕ} {delta B : ℝ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hcap : ∀ i ∈ s, exponent i ≤ K)
    (hsurplus :
      delta * exponentRadicalWeight s weight ≤
        exponentSignedTwoSurplus s weight exponent)
    (hthreshold :
      ((Finset.Icc 3 K).card : ℝ) * B <
        delta * exponentRadicalWeight s weight +
          exponentOneLayerWeight s weight exponent) :
    ∃ j ∈ Finset.Icc 3 K,
      B < exponentAtLeastLayerWeight j s weight exponent := by
  classical
  by_contra hnot
  push_neg at hnot
  have hsum := signedSurplus_add_one_eq_sum_layers
    s weight exponent hpos hcap
  have hupper :
      (∑ j in Finset.Icc 3 K,
        exponentAtLeastLayerWeight j s weight exponent) ≤
          ((Finset.Icc 3 K).card : ℝ) * B := by
    calc
      (∑ j in Finset.Icc 3 K,
        exponentAtLeastLayerWeight j s weight exponent) ≤
          ∑ _j in Finset.Icc 3 K, B := by
        exact Finset.sum_le_sum fun j hj => hnot j hj
      _ = ((Finset.Icc 3 K).card : ℝ) * B := by simp
  linarith

#print axioms exponentAtLeastLayerWeight_nonneg
#print axioms card_Icc_three
#print axioms coordinate_aboveTwo_eq_layer_sum
#print axioms aboveTwoWeight_eq_sum_layers
#print axioms signedSurplus_add_one_eq_sum_layers
#print axioms aboveTwoWeight_le_card_mul_of_each_layer_le
#print axioms exists_power_layer_of_signedSurplus

end
end ExponentLayerCakeSelector
end IUTThreeClosures
