/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SquareCubeResidualSixthPower
import IUTThreeClosures.SignedPrimeExponentLayer
import Mathlib.RingTheory.Radical.NatInt
import Mathlib.Tactic

/-!
# Natural-number exponent profiles and the endpoint square--cube--sixth split

The square--cube residual theorems are formulated for arbitrary finite
weighted exponent profiles.  This file identifies the profile attached to an
actual positive integer:

* the total exponent weight is `log n`;
* the radical weight is `log (rad n)`;
* prime logarithms are nonnegative on the factorization support.

It then applies the sharp modulo-six ledger to the one-endpoint signed defect
localized from a hypothetical abc violation.  Every such violation forces,
on one of the two large coprime endpoints, either a large canonical sixth-power
root, a large parity-residual radical, or a large cubic-residual radical.

No estimate excluding those three alternatives is assumed.
-/

namespace IUTThreeClosures
namespace NatExponentProfileBridge

open scoped BigOperators
open UniqueFactorizationMonoid
open CoprimeModuliResidualProductCore
open SquareCubeResidualSixthPower

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
  apply Finset.sum_congr rfl
  intro p hp
  rw [Real.log_pow]
  ring

/-- The radical-weight profile is the logarithm of the natural radical. -/
theorem exponentRadicalWeight_primeFactorization_eq_log_radical
    (n : ℕ) :
    exponentRadicalWeight n.primeFactors
        (fun p => Real.log (p : ℝ)) =
      Real.log (radical n : ℝ) := by
  have hprodNat := Nat.radical_eq_prod_primeFactors (n := n)
  have hprodReal :
      (∏ p ∈ n.primeFactors, (p : ℝ)) =
        (radical n : ℝ) := by
    exact_mod_cast hprodNat.symm
  rw [← hprodReal]
  unfold exponentRadicalWeight
  rw [Real.log_prod]

/-- Prime logarithms are nonnegative on the actual support. -/
theorem primeLog_nonneg_on_primeFactors (n : ℕ) :
    ∀ p ∈ n.primeFactors, 0 ≤ Real.log (p : ℝ) := by
  intro p hp
  apply Real.log_nonneg
  exact_mod_cast (Nat.prime_of_mem_primeFactors hp).one_le

/-- Canonical logarithmic sixth-root weight of a positive integer. -/
def naturalSixthRootWeight (n : ℕ) : ℝ :=
  exponentQuotientWeight 6 n.primeFactors
    (fun p => Real.log (p : ℝ)) n.factorization

/-- Radical weight of prime coordinates whose exponents survive modulus `k`. -/
def naturalResidualRadicalWeight (k n : ℕ) : ℝ :=
  residualRadicalWeight k n.primeFactors
    (fun p => Real.log (p : ℝ)) n.factorization

/-- The signed square-radical defect of a positive integer is exactly the
signed total/radical defect of its finite prime-exponent profile. -/
theorem singleEndpointSquareRadicalDefect_eq_profile
    (n : ℕ) (hn : 0 < n) :
    ABCPoint.singleEndpointSquareRadicalDefect n =
      exponentTotalWeight n.primeFactors
          (fun p => Real.log (p : ℝ)) n.factorization -
        2 * exponentRadicalWeight n.primeFactors
          (fun p => Real.log (p : ℝ)) := by
  unfold ABCPoint.singleEndpointSquareRadicalDefect
  rw [abcRadical_eq_natRadical,
    exponentTotalWeight_primeFactorization_eq_log n hn,
    exponentRadicalWeight_primeFactorization_eq_log_radical n]

/-- Actual-integer form of the sharp square--cube--sixth-power trichotomy. -/
theorem natural_signed_defect_forces_square_cube_sixth_split
    (n : ℕ) (hn : 0 < n) {L : ℝ}
    (hlarge : L < ABCPoint.singleEndpointSquareRadicalDefect n) :
    L / 18 < naturalSixthRootWeight n ∨
      L / 3 < naturalResidualRadicalWeight 2 n ∨
        L / 6 < naturalResidualRadicalWeight 3 n := by
  have hprofile :
      L < exponentTotalWeight n.primeFactors
          (fun p => Real.log (p : ℝ)) n.factorization -
        2 * exponentRadicalWeight n.primeFactors
          (fun p => Real.log (p : ℝ)) := by
    rw [← singleEndpointSquareRadicalDefect_eq_profile n hn]
    exact hlarge
  simpa [naturalSixthRootWeight, naturalResidualRadicalWeight] using
    positive_signedSurplus_forces_quantitative_square_cube_sixth_split
      n.primeFactors (fun p => Real.log (p : ℝ)) n.factorization
      (primeLog_nonneg_on_primeFactors n) hprofile

end NatExponentProfileBridge

namespace ABCPoint

/-- Every abc-height violation forces the explicit square--cube--sixth split
on one of the two large coprime endpoints. -/
theorem endpoint_square_cube_sixth_split_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    let T :=
      Real.log (abcRadical P.endpointMin : ℝ) +
        epsilon * P.conductor + C - Real.log 2 / 2
    ((T / 18 < NatExponentProfileBridge.naturalSixthRootWeight
          P.largeEndpoint ∨
        T / 3 < NatExponentProfileBridge.naturalResidualRadicalWeight
          2 P.largeEndpoint ∨
        T / 6 < NatExponentProfileBridge.naturalResidualRadicalWeight
          3 P.largeEndpoint) ∨
      (T / 18 < NatExponentProfileBridge.naturalSixthRootWeight P.c ∨
        T / 3 < NatExponentProfileBridge.naturalResidualRadicalWeight 2 P.c ∨
        T / 6 < NatExponentProfileBridge.naturalResidualRadicalWeight 3 P.c)) := by
  dsimp
  have hlocalized :=
    P.endpoint_signed_defect_large_of_height_violation hviolation
  rcases hlocalized with hlarge | hc
  · exact Or.inl
      (NatExponentProfileBridge.natural_signed_defect_forces_square_cube_sixth_split
        P.largeEndpoint P.largeEndpoint_pos hlarge)
  · exact Or.inr
      (NatExponentProfileBridge.natural_signed_defect_forces_square_cube_sixth_split
        P.c P.c_pos hc)

end ABCPoint

namespace NatExponentProfileBridge

#print axioms prod_primeFactorPowers_eq_self
#print axioms exponentTotalWeight_primeFactorization_eq_log
#print axioms exponentRadicalWeight_primeFactorization_eq_log_radical
#print axioms singleEndpointSquareRadicalDefect_eq_profile
#print axioms natural_signed_defect_forces_square_cube_sixth_split
#print axioms ABCPoint.endpoint_square_cube_sixth_split_of_height_violation

end NatExponentProfileBridge
end IUTThreeClosures
