/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ExponentModulusCoverageSelector
import Mathlib.Tactic

/-!
# Prime refinement of the adaptive exponent-modulus selector

A modulus selected by exponent-divisibility coverage may be composite. Passing
to any prime divisor can only enlarge the detected exponent weight. This file
uses the least prime factor to refine the adaptive modulus to a prime no larger
than the original cutoff.

No modularity or level-lowering theorem is used.
-/

namespace IUTThreeClosures
namespace PrimeExponentModulusSelector

open scoped BigOperators
open ExponentTwoSurplusDichotomy
open ExponentModulusCoverageSelector

noncomputable section

variable {ι : Type*}

/-- Every selected modulus in `[3,K]` has a prime divisor no larger than `K`,
and the corresponding prime-divisibility class detects at least as much
weight. -/
theorem exists_prime_refinement_of_selected_modulus
    {K : ℕ} {B : ℝ}
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {n : ℕ}
    (hn : n ∈ Finset.Icc 3 K)
    (hdetected : B < exponentDivisibleWeight n s weight exponent) :
    ∃ ell : ℕ,
      ell.Prime ∧ ell ≤ K ∧
        B < exponentDivisibleWeight ell s weight exponent := by
  have hn3 : 3 ≤ n := (Finset.mem_Icc.mp hn).1
  have hnK : n ≤ K := (Finset.mem_Icc.mp hn).2
  let ell : ℕ := n.minFac
  have hn_ne_one : n ≠ 1 := by omega
  have hell_prime : ell.Prime := by
    dsimp [ell]
    exact Nat.minFac_prime hn_ne_one
  have hell_dvd : ell ∣ n := by
    dsimp [ell]
    exact Nat.minFac_dvd n
  have hn_pos : 0 < n := by omega
  have hell_le_n : ell ≤ n := Nat.le_of_dvd hn_pos hell_dvd
  have hell_le_K : ell ≤ K := hell_le_n.trans hnK
  have hmono := exponentDivisibleWeight_mono_of_dvd
    hell_dvd s weight exponent hweight
  exact ⟨ell, hell_prime, hell_le_K, hdetected.trans_le hmono⟩

/-- Prime adaptive selector obtained by combining the coverage theorem with
least-prime-factor refinement. -/
theorem exists_prime_modulus_of_surplus_budget
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
    ∃ ell : ℕ,
      ell.Prime ∧ ell ≤ K ∧
        B < exponentDivisibleWeight ell s weight exponent := by
  obtain ⟨n, hn, hdetected⟩ := exists_modulus_of_surplus_budget
    hK s weight exponent hweight hpos hcap hsurplus hthreshold
  exact exists_prime_refinement_of_selected_modulus
    s weight exponent hweight hn hdetected

#print axioms exists_prime_refinement_of_selected_modulus
#print axioms exists_prime_modulus_of_surplus_budget

end
end PrimeExponentModulusSelector
end IUTThreeClosures
