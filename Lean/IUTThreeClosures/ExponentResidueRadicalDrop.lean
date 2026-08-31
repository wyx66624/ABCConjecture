/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ExponentModulusCoverageSelector
import Mathlib.Tactic

/-!
# Radical saving in an exponent-residue coefficient

For a positive modulus `ell`, the residue coefficient in the canonical
`ell`-th-power decomposition retains exponent `e mod ell` at each coordinate.
Coordinates whose exponent is divisible by `ell` disappear completely.
Therefore the usual `(ell-1) * radicalWeight` coefficient budget improves by
exactly the radical weight detected by the divisible-exponent class:

`residueWeight <= (ell-1) * (radicalWeight - divisibleWeight)`.

This is a deterministic finite-profile theorem.  It assumes no modularity,
level lowering, Diophantine finiteness theorem, or abc estimate.
-/

namespace IUTThreeClosures
namespace ExponentResidueRadicalDrop

open scoped BigOperators
open ExponentModulusCoverageSelector

noncomputable section

variable {ι : Type*}

/-- The undetected radical weight is nonnegative. -/
theorem exponentDivisibleWeight_le_radicalWeight
    (ell : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentDivisibleWeight ell s weight exponent ≤
      exponentRadicalWeight s weight := by
  classical
  unfold exponentDivisibleWeight exponentRadicalWeight
  apply Finset.sum_le_sum
  intro i hi
  by_cases hdiv : ell ∣ exponent i
  · simp [hdiv]
  · simpa [hdiv] using hweight i hi

/-- Exact support identity: radical weight minus the detected divisible class
is the weight of the complementary class. -/
theorem radical_sub_divisibleWeight_eq_complement
    (ell : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) :
    exponentRadicalWeight s weight -
        exponentDivisibleWeight ell s weight exponent =
      ∑ i ∈ s, if ell ∣ exponent i then 0 else weight i := by
  classical
  unfold exponentRadicalWeight exponentDivisibleWeight
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  by_cases hdiv : ell ∣ exponent i <;> simp [hdiv]

/-- The residue coefficient loses every coordinate detected by `ell`, giving
an improved radical budget. -/
theorem residueWeight_le_pred_mul_radical_sub_detected
    {ell : ℕ} (hell : 0 < ell)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentResidueWeight ell s weight exponent ≤
      ((ell - 1 : ℕ) : ℝ) *
        (exponentRadicalWeight s weight -
          exponentDivisibleWeight ell s weight exponent) := by
  classical
  rw [radical_sub_divisibleWeight_eq_complement]
  unfold exponentResidueWeight
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  by_cases hdiv : ell ∣ exponent i
  · have hmod : exponent i % ell = 0 := Nat.mod_eq_zero_of_dvd hdiv
    simp [hdiv, hmod]
  · have hmod_lt : exponent i % ell < ell := Nat.mod_lt _ hell
    have hmod_le : exponent i % ell ≤ ell - 1 := by omega
    have hcast :
        ((exponent i % ell : ℕ) : ℝ) ≤ (ell - 1 : ℕ) := by
      exact_mod_cast hmod_le
    simp only [if_neg hdiv]
    exact mul_le_mul_of_nonneg_right hcast (hweight i hi)

/-- Threshold form: any lower bound on the detected class can be substituted
into the improved residue budget. -/
theorem residueWeight_le_pred_mul_radical_sub_threshold
    {ell : ℕ} (hell : 0 < ell)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {B : ℝ}
    (hB : B ≤ exponentDivisibleWeight ell s weight exponent) :
    exponentResidueWeight ell s weight exponent ≤
      ((ell - 1 : ℕ) : ℝ) *
        (exponentRadicalWeight s weight - B) := by
  have hbase :=
    residueWeight_le_pred_mul_radical_sub_detected
      hell s weight exponent hweight
  have hcoef : 0 ≤ ((ell - 1 : ℕ) : ℝ) := by positivity
  have hsub :
      exponentRadicalWeight s weight -
          exponentDivisibleWeight ell s weight exponent ≤
        exponentRadicalWeight s weight - B := by
    linarith
  exact hbase.trans (mul_le_mul_of_nonneg_left hsub hcoef)

#print axioms exponentDivisibleWeight_le_radicalWeight
#print axioms radical_sub_divisibleWeight_eq_complement
#print axioms residueWeight_le_pred_mul_radical_sub_detected
#print axioms residueWeight_le_pred_mul_radical_sub_threshold

end
end ExponentResidueRadicalDrop
end IUTThreeClosures
