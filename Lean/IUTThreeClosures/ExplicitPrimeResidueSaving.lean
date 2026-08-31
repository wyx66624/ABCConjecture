/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ExponentResidueRadicalDrop
import IUTThreeClosures.ExponentLayerCakeSelector
import IUTThreeClosures.PrimeExponentModulusSelector
import Mathlib.Tactic

/-!
# Explicit averaged prime-modulus saving

The threshold form of the adaptive selector can be specialized to a concrete
half-average. Under exponent cap `K>=3`, let

`A = delta * radicalWeight + exponentOneWeight`.

If `A>0`, some prime modulus `ell<=K` detects more than

`A / (2*(K-2)^2)`

radical weight. The corresponding residue coefficient loses at least that
amount from its support budget.
-/

namespace IUTThreeClosures
namespace ExplicitPrimeResidueSaving

open ExponentTwoSurplusDichotomy
open ExponentModulusCoverageSelector
open PrimeExponentModulusSelector
open ExponentResidueRadicalDrop
open ExponentLayerCakeSelector

noncomputable section

variable {ι : Type*}

/-- Explicit half-average prime selector under a bounded exponent profile. -/
theorem exists_prime_with_explicit_detected_fraction
    {K : ℕ} {delta : ℝ}
    (hK : 3 ≤ K)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hcap : ∀ i ∈ s, exponent i ≤ K)
    (hsurplus :
      delta * exponentRadicalWeight s weight ≤
        exponentSignedTwoSurplus s weight exponent)
    (hpositive :
      0 < delta * exponentRadicalWeight s weight +
        exponentOneLayerWeight s weight exponent) :
    ∃ ell : ℕ,
      ell.Prime ∧ ell ≤ K ∧
      (delta * exponentRadicalWeight s weight +
          exponentOneLayerWeight s weight exponent) /
          (2 * (((K - 2 : ℕ) : ℝ) ^ 2)) <
        exponentDivisibleWeight ell s weight exponent := by
  let A : ℝ :=
    delta * exponentRadicalWeight s weight +
      exponentOneLayerWeight s weight exponent
  let d : ℝ := ((K - 2 : ℕ) : ℝ)
  have hdNat : 0 < K - 2 := by omega
  have hd : 0 < d := by
    dsimp [d]
    exact_mod_cast hdNat
  let B : ℝ := A / (2 * d ^ 2)
  have hcard : (Finset.Icc 3 K).card = K - 2 :=
    card_Icc_three hK
  have hid :
      d * ((Finset.Icc 3 K).card : ℝ) * B = A / 2 := by
    rw [hcard]
    dsimp [B, d]
    field_simp [show (((K - 2 : ℕ) : ℝ)) ≠ 0 by exact_mod_cast hdNat.ne']
  have hthreshold :
      ((K - 2 : ℕ) : ℝ) *
          ((Finset.Icc 3 K).card : ℝ) * B < A := by
    change d * ((Finset.Icc 3 K).card : ℝ) * B < A
    rw [hid]
    dsimp [A] at hpositive ⊢
    linarith
  obtain ⟨ell, hellPrime, hellK, hdetected⟩ :=
    exists_prime_modulus_of_surplus_budget
      hK s weight exponent hweight hpos hcap hsurplus hthreshold
  refine ⟨ell, hellPrime, hellK, ?_⟩
  simpa [B, A, d] using hdetected

/-- Explicit prime selector together with the resulting residue-coefficient
support saving. -/
theorem exists_prime_with_explicit_residue_budget
    {K : ℕ} {delta : ℝ}
    (hK : 3 ≤ K)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hcap : ∀ i ∈ s, exponent i ≤ K)
    (hsurplus :
      delta * exponentRadicalWeight s weight ≤
        exponentSignedTwoSurplus s weight exponent)
    (hpositive :
      0 < delta * exponentRadicalWeight s weight +
        exponentOneLayerWeight s weight exponent) :
    ∃ ell : ℕ,
      ell.Prime ∧ ell ≤ K ∧
      let B :=
        (delta * exponentRadicalWeight s weight +
          exponentOneLayerWeight s weight exponent) /
          (2 * (((K - 2 : ℕ) : ℝ) ^ 2))
      B < exponentDivisibleWeight ell s weight exponent ∧
      exponentResidueWeight ell s weight exponent ≤
        ((ell - 1 : ℕ) : ℝ) *
          (exponentRadicalWeight s weight - B) := by
  obtain ⟨ell, hellPrime, hellK, hdetected⟩ :=
    exists_prime_with_explicit_detected_fraction
      hK s weight exponent hweight hpos hcap hsurplus hpositive
  refine ⟨ell, hellPrime, hellK, ?_⟩
  dsimp
  refine ⟨hdetected, ?_⟩
  exact residueWeight_le_pred_mul_radical_sub_threshold
    hellPrime.pos s weight exponent hweight hdetected.le

#print axioms exists_prime_with_explicit_detected_fraction
#print axioms exists_prime_with_explicit_residue_budget

end
end ExplicitPrimeResidueSaving
end IUTThreeClosures
