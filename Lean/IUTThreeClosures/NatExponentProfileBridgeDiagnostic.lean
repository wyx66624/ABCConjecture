/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.RingTheory.Radical.NatInt
import Mathlib.Tactic

/-! Temporary kernel diagnostic for the actual natural-number exponent profile. -/

namespace IUTThreeClosures
namespace NatExponentProfileBridgeDiagnostic

open scoped BigOperators

noncomputable section

/-- Finite-product form of the prime factorization theorem. -/
theorem prod_primeFactorPowers_eq_self (n : ℕ) (hn : n ≠ 0) :
    (∏ p ∈ n.primeFactors, p ^ n.factorization p) = n := by
  simpa [Finsupp.prod, Nat.support_factorization] using
    (Nat.prod_factorization_pow_eq_self hn)

/-- The logarithmic total exponent profile is the ordinary logarithm. -/
theorem exponentTotalWeight_primeFactorization_eq_log
    (n : ℕ) (hn : 0 < n) :
    exponentTotalWeight n.primeFactors
        (fun p => Real.log (p : ℝ)) n.factorization =
      Real.log (n : ℝ) := by
  have hprodNat := prod_primeFactorPowers_eq_self n hn.ne'
  have hprodReal :
      (∏ p ∈ n.primeFactors,
        ((p : ℝ) ^ n.factorization p)) = (n : ℝ) := by
    exact_mod_cast hprodNat
  rw [← hprodReal]
  unfold exponentTotalWeight
  rw [Real.log_prod]
  · apply Finset.sum_congr rfl
    intro p hp
    rw [Real.log_pow]
    ring
  · intro p hp
    exact pow_ne_zero _ (by
      exact_mod_cast (Nat.prime_of_mem_primeFactors hp).ne_zero)

/-- The radical-weight profile is the logarithm of the natural radical. -/
theorem exponentRadicalWeight_primeFactorization_eq_log_radical
    (n : ℕ) :
    exponentRadicalWeight n.primeFactors
        (fun p => Real.log (p : ℝ)) =
      Real.log (Nat.radical n : ℝ) := by
  have hprodNat := Nat.radical_eq_prod_primeFactors (n := n)
  have hprodReal :
      (∏ p ∈ n.primeFactors, (p : ℝ)) =
        (Nat.radical n : ℝ) := by
    exact_mod_cast hprodNat.symm
  rw [← hprodReal]
  unfold exponentRadicalWeight
  rw [Real.log_prod]
  intro p hp
  exact_mod_cast (Nat.prime_of_mem_primeFactors hp).ne_zero

/-- Prime logarithms are nonnegative on the actual support. -/
theorem primeLog_nonneg_on_primeFactors (n : ℕ) :
    ∀ p ∈ n.primeFactors, 0 ≤ Real.log (p : ℝ) := by
  intro p hp
  apply Real.log_nonneg
  exact_mod_cast (Nat.prime_of_mem_primeFactors hp).one_le

#print axioms prod_primeFactorPowers_eq_self
#print axioms exponentTotalWeight_primeFactorization_eq_log
#print axioms exponentRadicalWeight_primeFactorization_eq_log_radical
#print axioms primeLog_nonneg_on_primeFactors

end
end NatExponentProfileBridgeDiagnostic
end IUTThreeClosures
