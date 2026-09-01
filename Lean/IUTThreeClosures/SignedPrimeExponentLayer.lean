/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SignedEndpointSquareRadicalDefect
import IUTThreeClosures.EndpointBalanceCoefficientTransfer
import IUTThreeClosures.LargeEndpointPrimePowerLocalization
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.RingTheory.Radical.NatInt
import Mathlib.Tactic

/-!
# Signed prime-exponent layers at an abc endpoint

The positive cubeful layer by itself is not the correct residual obstruction:
primes of exponent one contribute with the opposite sign relative to the
square of the radical.  For any finite positive exponent profile this file
proves the exact identity

`total weight - 2 * radical weight = above-two weight - exponent-one weight`.

For an actual positive primitive abc point, the signed endpoint defect splits
as the sum of the signed defects of the two large coprime endpoints, minus
twice the radical log of the small endpoint.  Consequently every abc violation
forces one of the two large endpoints to have a quantitatively positive signed
prime-exponent defect.

No distribution theorem or abc estimate is assumed.
-/

namespace IUTThreeClosures

open scoped BigOperators
open UniqueFactorizationMonoid

noncomputable section

namespace SignedPrimeExponentLayer

variable {ι : Type*}

/-- Weight supported on coordinates whose exponent is exactly one. -/
def exponentOneWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, if exponent i = 1 then weight i else 0

/-- Weight in the exponent mass above level two. -/
def exponentAboveTwoWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, ((exponent i - 2 : ℕ) : ℝ) * weight i

/-- Exact signed exponent-layer identity.  Exponent two contributes zero;
exponent one contributes negatively; exponent `e >= 3` contributes `e-2`. -/
theorem total_sub_two_radical_eq_aboveTwo_sub_one
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hpos : ∀ i ∈ s, 0 < exponent i) :
    exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight =
      exponentAboveTwoWeight s weight exponent -
        exponentOneWeight s weight exponent := by
  classical
  unfold exponentTotalWeight exponentRadicalWeight
    exponentAboveTwoWeight exponentOneWeight
  rw [Finset.mul_sum, ← Finset.sum_sub_distrib,
    ← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  have hei : 0 < exponent i := hpos i hi
  by_cases hone : exponent i = 1
  · simp [hone]
    ring
  · have htwo : 2 ≤ exponent i := by omega
    rw [if_neg hone, Nat.cast_sub htwo]
    ring

end SignedPrimeExponentLayer

namespace ABCPoint

/-- Signed square-radical defect of one positive integer. -/
def singleEndpointSquareRadicalDefect (n : ℕ) : ℝ :=
  Real.log (n : ℝ) - 2 * Real.log (abcRadical n : ℝ)

/-- The ordered summands have the original product. -/
theorem signedLayer_endpointMin_mul_largeEndpoint_eq_ab (P : ABCPoint) :
    P.endpointMin * P.largeEndpoint = P.a * P.b := by
  by_cases hab : P.a ≤ P.b
  · simp [endpointMin, largeEndpoint, hab]
  · have hba : P.b ≤ P.a := by omega
    simp [endpointMin, largeEndpoint, hba, Nat.mul_comm]

/-- The small endpoint is coprime to the large endpoint. -/
theorem signedLayer_endpointMin_coprime_largeEndpoint (P : ABCPoint) :
    Nat.Coprime P.endpointMin P.largeEndpoint := by
  by_cases hab : P.a ≤ P.b
  · simpa [endpointMin, largeEndpoint, hab] using P.pairwise_coprime.1
  · have hba : P.b ≤ P.a := by omega
    simpa [endpointMin, largeEndpoint, hba] using P.pairwise_coprime.1.symm

/-- The small endpoint is coprime to the sum. -/
theorem signedLayer_endpointMin_coprime_c (P : ABCPoint) :
    Nat.Coprime P.endpointMin P.c := by
  by_cases hab : P.a ≤ P.b
  · simpa [endpointMin, hab] using P.pairwise_coprime.2.2.symm
  · have hba : P.b ≤ P.a := by omega
    simpa [endpointMin, hba] using P.pairwise_coprime.2.1

/-- The small endpoint is coprime to the product of the two large endpoints. -/
theorem signedLayer_endpointMin_coprime_largePair (P : ABCPoint) :
    Nat.Coprime P.endpointMin (P.largeEndpoint * P.c) :=
  P.signedLayer_endpointMin_coprime_largeEndpoint.mul_right
    P.signedLayer_endpointMin_coprime_c

/-- Exact radical factorization into all three ordered endpoints. -/
theorem abcRadical_eq_signedLayer_threeFactors (P : ABCPoint) :
    abcRadical (P.a * P.b * P.c) =
      abcRadical P.endpointMin *
        (abcRadical P.largeEndpoint * abcRadical P.c) := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical,
    abcRadical_eq_natRadical, abcRadical_eq_natRadical]
  have habc :
      P.a * P.b * P.c =
        P.endpointMin * (P.largeEndpoint * P.c) := by
    rw [← P.signedLayer_endpointMin_mul_largeEndpoint_eq_ab]
    ring
  rw [habc]
  rw [UniqueFactorizationMonoid.radical_mul
    (Nat.coprime_iff_isRelPrime.mp
      P.signedLayer_endpointMin_coprime_largePair)]
  rw [UniqueFactorizationMonoid.radical_mul
    (Nat.coprime_iff_isRelPrime.mp P.largeEndpoint_coprime_c)]

/-- The conductor is exactly the sum of the three ordered endpoint radical
logs. -/
theorem conductor_eq_signedLayer_threeRadicalLogs (P : ABCPoint) :
    P.conductor =
      Real.log (abcRadical P.endpointMin : ℝ) +
        Real.log (abcRadical P.largeEndpoint : ℝ) +
          Real.log (abcRadical P.c : ℝ) := by
  have hsmall : 0 < (abcRadical P.endpointMin : ℝ) := by
    exact_mod_cast abcRadical_pos P.endpointMin
  have hlarge : 0 < (abcRadical P.largeEndpoint : ℝ) := by
    exact_mod_cast abcRadical_pos P.largeEndpoint
  have hc : 0 < (abcRadical P.c : ℝ) := by
    exact_mod_cast abcRadical_pos P.c
  unfold ABCPoint.conductor
  rw [P.abcRadical_eq_signedLayer_threeFactors]
  push_cast
  rw [Real.log_mul hsmall.ne' (mul_pos hlarge hc).ne',
    Real.log_mul hlarge.ne' hc.ne']
  ring

/-- The logarithm of the large endpoint product splits additively. -/
theorem largeEndpointProductLog_eq_signedLayer_add (P : ABCPoint) :
    P.largeEndpointProductLog =
      Real.log (P.largeEndpoint : ℝ) + Real.log (P.c : ℝ) := by
  have hlarge : 0 < (P.largeEndpoint : ℝ) := by
    exact_mod_cast P.largeEndpoint_pos
  have hc : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  unfold largeEndpointProductLog
  push_cast
  exact Real.log_mul hlarge.ne' hc.ne'

/-- Exact decomposition of the signed abc endpoint defect into one-integer
signed defects and the small-endpoint radical charge. -/
theorem signedEndpointSquareRadicalDefect_eq_endpoint_sum
    (P : ABCPoint) :
    P.signedEndpointSquareRadicalDefect =
      singleEndpointSquareRadicalDefect P.largeEndpoint +
        singleEndpointSquareRadicalDefect P.c -
          2 * Real.log (abcRadical P.endpointMin : ℝ) := by
  unfold signedEndpointSquareRadicalDefect
    singleEndpointSquareRadicalDefect
  rw [P.largeEndpointProductLog_eq_signedLayer_add,
    P.conductor_eq_signedLayer_threeRadicalLogs]
  ring

/-- Every abc violation forces a large signed defect on at least one of the two
large coprime endpoints. -/
theorem endpoint_signed_defect_large_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    let T :=
      Real.log (abcRadical P.endpointMin : ℝ) +
        epsilon * P.conductor + C - Real.log 2 / 2
    T < singleEndpointSquareRadicalDefect P.largeEndpoint ∨
      T < singleEndpointSquareRadicalDefect P.c := by
  dsimp
  have hlower :=
    (P.signedEndpointSquareRadicalDefect_corridor).1
  have hlarge :
      2 * epsilon * P.conductor + 2 * C - Real.log 2 <
        P.signedEndpointSquareRadicalDefect := by
    nlinarith
  rw [P.signedEndpointSquareRadicalDefect_eq_endpoint_sum] at hlarge
  by_cases hM :
      Real.log (abcRadical P.endpointMin : ℝ) +
          epsilon * P.conductor + C - Real.log 2 / 2 <
        singleEndpointSquareRadicalDefect P.largeEndpoint
  · exact Or.inl hM
  · right
    have hMle := le_of_not_gt hM
    nlinarith

end ABCPoint

namespace SignedPrimeExponentLayer

#print axioms total_sub_two_radical_eq_aboveTwo_sub_one
#print axioms ABCPoint.abcRadical_eq_signedLayer_threeFactors
#print axioms ABCPoint.conductor_eq_signedLayer_threeRadicalLogs
#print axioms ABCPoint.signedEndpointSquareRadicalDefect_eq_endpoint_sum
#print axioms ABCPoint.endpoint_signed_defect_large_of_height_violation

end SignedPrimeExponentLayer
end
end IUTThreeClosures
