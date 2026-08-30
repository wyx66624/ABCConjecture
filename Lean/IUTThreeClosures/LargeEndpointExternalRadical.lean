/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EndpointBalanceCoefficientTransfer
import IUTThreeClosures.LargeEndpointCompensatedExcess
import Mathlib.Tactic

/-!
# Identification of the external radical quotient

For a primitive abc point, the radical omitted from `max(a,b)*c` is exactly
the radical of `min(a,b)`.  This converts the compensated-excess obstruction
into the fully explicit inequality

`Q_+(max(a,b)*c) > L(max(a,b)*c) * rad(min(a,b))^2`

for every remaining strong violation.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid
open LargeEndpointCubefulExcess
open LargeEndpointSignedExcess

noncomputable section

/-- Radical multiplicativity for coprime natural numbers, in the repository's
`abcRadical` normalization. -/
theorem abcRadical_mul_of_coprime
    {x y : ℕ} (hcop : Nat.Coprime x y) :
    abcRadical (x * y) = abcRadical x * abcRadical y := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical,
      abcRadical_eq_natRadical]
  first
  | exact radical_mul_of_coprime hcop.isCoprime
  | exact UniqueFactorizationMonoid.radical_mul_of_coprime hcop.isCoprime
  | exact hcop.radical_mul
  | exact Nat.Coprime.radical_mul hcop
  | simpa using (radical_mul_of_coprime hcop.isCoprime)
  | simpa using
      (UniqueFactorizationMonoid.radical_mul_of_coprime hcop.isCoprime)
  | simpa using hcop.radical_mul

namespace ABCPoint

/-- The smaller endpoint is coprime to the product of the two large
endpoints. -/
theorem endpointMin_coprime_largeEndpoint_mul_c (P : ABCPoint) :
    Nat.Coprime P.endpointMin (P.largeEndpoint * P.c) := by
  have hp :
      Nat.Coprime P.a P.b ∧
        Nat.Coprime P.a P.c ∧
        Nat.Coprime P.b P.c := by
    simpa [PairwiseCoprimeABC] using P.pairwise_coprime
  rcases hp with ⟨hab, hac, hbc⟩
  by_cases hle : P.a ≤ P.b
  · have hmin : P.endpointMin = P.a := by
      simp [endpointMin, hle]
    have hmax : P.largeEndpoint = P.b := by
      simp [largeEndpoint, hle]
    rw [hmin, hmax]
    exact hab.mul_right hac
  · have hba : P.b ≤ P.a := by omega
    have hmin : P.endpointMin = P.b := by
      simp [endpointMin, hba]
    have hmax : P.largeEndpoint = P.a := by
      simp [largeEndpoint, hba]
    rw [hmin, hmax]
    exact hab.symm.mul_right hbc

/-- Reordering identity for the small endpoint and the two large endpoints. -/
theorem endpointMin_mul_largeEndpoint_mul_c_eq_abcProduct
    (P : ABCPoint) :
    P.endpointMin * (P.largeEndpoint * P.c) =
      P.a * P.b * P.c := by
  by_cases hle : P.a ≤ P.b
  · have hmin : P.endpointMin = P.a := by
      simp [endpointMin, hle]
    have hmax : P.largeEndpoint = P.b := by
      simp [largeEndpoint, hle]
    rw [hmin, hmax]
  · have hba : P.b ≤ P.a := by omega
    have hmin : P.endpointMin = P.b := by
      simp [endpointMin, hba]
    have hmax : P.largeEndpoint = P.a := by
      simp [largeEndpoint, hba]
    rw [hmin, hmax]
    ring

/-- The external quotient is exactly the radical of the smaller summand. -/
theorem externalRadicalQuotient_eq_endpointMinRadical
    (P : ABCPoint) :
    P.externalRadicalQuotient = abcRadical P.endpointMin := by
  have hrad :
      abcRadical (P.a * P.b * P.c) =
        abcRadical P.endpointMin *
          abcRadical (P.largeEndpoint * P.c) := by
    rw [← P.endpointMin_mul_largeEndpoint_mul_c_eq_abcProduct]
    exact abcRadical_mul_of_coprime
      P.endpointMin_coprime_largeEndpoint_mul_c
  unfold externalRadicalQuotient
  rw [hrad]
  have hpos : 0 < abcRadical (P.largeEndpoint * P.c) :=
    abcRadical_pos _
  rw [mul_comm]
  exact Nat.mul_div_left _ hpos

/-- Strong coefficient-one closure written only in the original three
endpoints and their exponent layers. -/
theorem height_le_conductor_add_log_two_div_two_of_endpointCompensation
    (P : ABCPoint)
    (hcomp :
      cubefulExcess (P.largeEndpoint * P.c) ≤
        squarefreeDeficit (P.largeEndpoint * P.c) *
          abcRadical P.endpointMin ^ 2) :
    P.height ≤ P.conductor + Real.log 2 / 2 := by
  apply P.height_le_conductor_add_log_two_div_two_of_compensatedExcess
  simpa [P.externalRadicalQuotient_eq_endpointMinRadical] using hcomp

/-- Every strong violation has more cubeful mass than the combined
exponent-one layer and the square of the small-endpoint radical. -/
theorem endpointCompensation_strict_of_strong_violation
    (P : ABCPoint)
    (hviolation : P.conductor + Real.log 2 / 2 < P.height) :
    squarefreeDeficit (P.largeEndpoint * P.c) *
        abcRadical P.endpointMin ^ 2 <
      cubefulExcess (P.largeEndpoint * P.c) := by
  have h := P.compensatedExcess_strict_of_strong_violation hviolation
  simpa [P.externalRadicalQuotient_eq_endpointMinRadical] using h

end ABCPoint

#print axioms abcRadical_mul_of_coprime
#print axioms ABCPoint.endpointMin_coprime_largeEndpoint_mul_c
#print axioms ABCPoint.externalRadicalQuotient_eq_endpointMinRadical
#print axioms ABCPoint.height_le_conductor_add_log_two_div_two_of_endpointCompensation
#print axioms ABCPoint.endpointCompensation_strict_of_strong_violation

end
end IUTThreeClosures
