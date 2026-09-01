/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SignedPrimeExponentLayer

/-!
# Actual prime support in the coupled signed endpoint identity

The mathematical proof is recorded first in
`research/SIGNED_LAYER_ARITHMETIC_SESSION_2026_08_30.md`.

This module instantiates the abstract finite exponent profile at the actual
factorization of a natural number. It retains both large endpoints in the same
inequality. The final equivalence is a reformulation of abc, not a proof of
either side.
-/

namespace IUTThreeClosures
namespace SignedPrimeSupport

open scoped BigOperators
open SignedPrimeExponentLayer

noncomputable section

/-- Logarithmic mass of the actual exponent-one primes. -/
def exponentOneMass (n : ℕ) : ℝ :=
  exponentOneWeight n.primeFactors (fun p => Real.log (p : ℝ)) n.factorization

/-- Logarithmic mass of the actual prime exponents above two. -/
def exponentAboveTwoMass (n : ℕ) : ℝ :=
  exponentAboveTwoWeight n.primeFactors (fun p => Real.log (p : ℝ)) n.factorization

/-- Unique factorization identifies the total prime weight with `log n`. -/
theorem log_eq_actual_exponent_weight (n : ℕ) :
    Real.log (n : ℝ) =
      exponentTotalWeight n.primeFactors (fun p => Real.log (p : ℝ))
        n.factorization := by
  simpa [exponentTotalWeight, Finsupp.sum] using Real.log_nat_eq_sum_factorization n

/-- The actual radical contributes one logarithm per prime in the support. -/
theorem radical_log_eq_actual_support_weight (n : ℕ) :
    Real.log (abcRadical n : ℝ) =
      exponentRadicalWeight n.primeFactors (fun p => Real.log (p : ℝ)) := by
  unfold abcRadical exponentRadicalWeight
  push_cast
  apply Real.log_prod
  intro p hp
  exact_mod_cast (Nat.pos_of_mem_primeFactors hp).ne'

/-- The signed defect is exactly the difference of the two actual prime layers. -/
theorem single_defect_eq_actual_prime_layers (n : ℕ) :
    ABCPoint.singleEndpointSquareRadicalDefect n =
      exponentAboveTwoMass n - exponentOneMass n := by
  unfold ABCPoint.singleEndpointSquareRadicalDefect
    exponentAboveTwoMass exponentOneMass
  rw [log_eq_actual_exponent_weight, radical_log_eq_actual_support_weight]
  apply total_sub_two_radical_eq_aboveTwo_sub_one
  intro p hp
  have hp' : p ∈ n.factorization.support := by simpa using hp
  exact Nat.pos_of_ne_zero (Finsupp.mem_support_iff.mp hp')

/-- Coupled arithmetic identity for the actual primitive abc endpoints. -/
theorem coupled_defect_eq_actual_prime_layers (P : ABCPoint) :
    P.signedEndpointSquareRadicalDefect =
      exponentAboveTwoMass P.largeEndpoint + exponentAboveTwoMass P.c -
        exponentOneMass P.largeEndpoint - exponentOneMass P.c -
          2 * Real.log (abcRadical P.endpointMin : ℝ) := by
  rw [P.signedEndpointSquareRadicalDefect_eq_endpoint_sum,
    single_defect_eq_actual_prime_layers, single_defect_eq_actual_prime_layers]
  ring

/-- The full coupled prime-support estimate, with the uniform quantifiers of abc. -/
def UniformCoupledPrimeSupportBound : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ K : ℝ, ∀ P : ABCPoint,
    exponentAboveTwoMass P.largeEndpoint + exponentAboveTwoMass P.c ≤
      exponentOneMass P.largeEndpoint + exponentOneMass P.c +
        2 * Real.log (abcRadical P.endpointMin : ℝ) + 2 * ε * P.conductor + K

/-- The prime-support statement retains exactly the signed endpoint estimate. -/
theorem coupled_prime_support_iff_signed_defect :
    UniformCoupledPrimeSupportBound ↔
      SignedEndpointSquareRadicalDefect.UniformSignedEndpointSquareRadicalDefectBound := by
  constructor
  · intro h ε hε
    obtain ⟨K, hK⟩ := h ε hε
    refine ⟨K, fun P => ?_⟩
    rw [coupled_defect_eq_actual_prime_layers]
    have hP := hK P
    linarith
  · intro h ε hε
    obtain ⟨K, hK⟩ := h ε hε
    refine ⟨K, fun P => ?_⟩
    have hP := hK P
    rw [coupled_defect_eq_actual_prime_layers] at hP
    linarith

/-- Exact equivalence; neither endpoint of the equivalence is asserted. -/
theorem coupled_prime_support_iff_abc :
    UniformCoupledPrimeSupportBound ↔ ABCConjecture :=
  coupled_prime_support_iff_signed_defect.trans
    SignedEndpointSquareRadicalDefect.uniformSignedEndpointSquareRadicalDefectBound_iff_abc

#print axioms log_eq_actual_exponent_weight
#print axioms single_defect_eq_actual_prime_layers
#print axioms coupled_defect_eq_actual_prime_layers
#print axioms coupled_prime_support_iff_abc

end
end SignedPrimeSupport
end IUTThreeClosures
