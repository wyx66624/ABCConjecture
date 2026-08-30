/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Tactic

/-!
# Signed prime-multiplicity excess on the large endpoints

For a positive integer `n`, the exact signed multiplicity excess is

`log n - 2 * log rad(n) = sum_p (v_p(n)-2) log p`.

Primes of exponent one contribute negatively, exponent-two primes contribute
zero, and exponents at least three contribute positively.  This is sharper
than retaining only the positive cubeful part.

For `n=max(a,b)*c`, the elementary inequality `c^2 ≤ 2n` gives

`2*height ≤ log 2 + 2*conductor + signedExcess(n)`.

No upper bound for the signed excess is assumed in this file.
-/

namespace IUTThreeClosures
namespace LargeEndpointSignedMultiplicityExcess

noncomputable section

/-- Signed logarithmic mass above the two-radical baseline. -/
def signedMultiplicityExcess (n : ℕ) : ℝ :=
  Real.log (n : ℝ) - 2 * Real.log (abcRadical n : ℝ)

end
end LargeEndpointSignedMultiplicityExcess

open LargeEndpointSignedMultiplicityExcess

noncomputable section

namespace ABCPoint

/-- Signed multiplicity excess of the product of the two large adjacent
endpoints. -/
def largeEndpointSignedMultiplicityExcess (P : ABCPoint) : ℝ :=
  signedMultiplicityExcess (P.largeEndpoint * P.c)

/-- Exact signed-excess height ledger. -/
theorem two_mul_height_le_log_two_add_two_mul_conductor_add_signedExcess
    (P : ABCPoint) :
    2 * P.height ≤
      Real.log 2 + 2 * P.conductor +
        P.largeEndpointSignedMultiplicityExcess := by
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hnpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast (mul_pos P.largeEndpoint_pos P.c_pos)
  have hradSmallPos :
      0 < (abcRadical (P.largeEndpoint * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.largeEndpoint * P.c)
  have hradBigPos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast P.c_sq_le_two_largeEndpoint_mul_c
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hnpos.ne'] at hlog
  have hradReal :
      (abcRadical (P.largeEndpoint * P.c) : ℝ) ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast P.radical_largeEndpoint_mul_c_le_abcRadical
  have hradLog := Real.log_le_log hradSmallPos hradReal
  rw [P.height_eq_log_c]
  unfold ABCPoint.conductor
  unfold largeEndpointSignedMultiplicityExcess
  unfold signedMultiplicityExcess
  linarith

/-- A subcritical upper bound for the signed excess gives the standard abc
slope. -/
theorem height_le_of_signedMultiplicityExcess_bound
    (P : ABCPoint) {epsilon K : ℝ}
    (hexcess :
      P.largeEndpointSignedMultiplicityExcess ≤
        2 * epsilon * P.conductor + K) :
    P.height ≤
      (1 + epsilon) * P.conductor +
        (K + Real.log 2) / 2 := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_signedExcess
  nlinarith

/-- Every abc violation forces positive conductor-scale signed multiplicity
excess on the two large endpoints. -/
theorem signedMultiplicityExcess_large_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.conductor + 2 * C - Real.log 2 <
      P.largeEndpointSignedMultiplicityExcess := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_signedExcess
  nlinarith

end ABCPoint

namespace LargeEndpointSignedMultiplicityExcess

/-- Uniform signed-excess control.  This is weaker than bounding the unsigned
cubeful quotient because exponent-one primes are allowed to cancel higher
multiplicity mass. -/
def UniformLargeEndpointSignedMultiplicityExcessBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ K : ℝ, ∀ P : ABCPoint,
      P.largeEndpointSignedMultiplicityExcess ≤
        2 * epsilon * P.conductor + K

/-- Uniform subcritical signed-excess control proves abc. -/
theorem abc_of_uniformLargeEndpointSignedMultiplicityExcessBound
    (hbound : UniformLargeEndpointSignedMultiplicityExcessBound) :
    ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨K, hK⟩ := hbound epsilon hepsilon
  refine ⟨(K + Real.log 2) / 2, ?_⟩
  intro a b c ha hb hc hsum hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcoprime }
  have hpoint :=
    ABCPoint.height_le_of_signedMultiplicityExcess_bound P (hK P)
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

#print axioms ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_signedExcess
#print axioms ABCPoint.height_le_of_signedMultiplicityExcess_bound
#print axioms ABCPoint.signedMultiplicityExcess_large_of_height_violation
#print axioms abc_of_uniformLargeEndpointSignedMultiplicityExcessBound

end LargeEndpointSignedMultiplicityExcess
end
end IUTThreeClosures
