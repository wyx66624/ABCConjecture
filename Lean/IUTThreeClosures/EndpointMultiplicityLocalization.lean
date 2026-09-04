/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Tactic

/-!
# Coordinatewise localization of repeated-prime mass

For a positive integer `n`, its logarithmic multiplicity excess is

`log n - log rad(n)`.

This file proves an unconditional localization theorem for every abc
violation.  If

`height > (1 + epsilon) * conductor + C`, `epsilon > 0`,

then both `c` and `max(a,b)` carry a fixed positive height proportion of
multiplicity excess.  In denominator-free form,

`epsilon * height + C < (1+epsilon) * excess(c)`

and

`epsilon * height + C - (1+epsilon) * log 2
  < (1+epsilon) * excess(max(a,b))`.

Thus one isolated powerful endpoint cannot create an abc counterexample; both
large nearby coprime endpoints must contain substantial repeated-prime mass.
No distribution theorem or abc estimate is assumed.
-/

namespace IUTThreeClosures
namespace EndpointMultiplicityLocalization

noncomputable section

/-- Logarithmic prime-multiplicity mass of a positive integer. -/
def multiplicityExcessLog (n : ℕ) : ℝ :=
  Real.log (n : ℝ) - Real.log (abcRadical n : ℝ)

end
end EndpointMultiplicityLocalization

open EndpointMultiplicityLocalization
open UniqueFactorizationMonoid

noncomputable section

namespace ABCPoint

/-- The `c` coordinate divides the full abc product. -/
theorem c_dvd_abcProduct (P : ABCPoint) :
    P.c ∣ P.a * P.b * P.c := by
  refine ⟨P.a * P.b, ?_⟩
  ring

/-- The larger summand divides the full abc product. -/
theorem largeEndpoint_dvd_abcProduct (P : ABCPoint) :
    P.largeEndpoint ∣ P.a * P.b * P.c := by
  by_cases hab : P.a ≤ P.b
  · have hmax : P.largeEndpoint = P.b := by
      simp [largeEndpoint, hab]
    rw [hmax]
    refine ⟨P.a * P.c, ?_⟩
    ring
  · have hba : P.b ≤ P.a := by omega
    have hmax : P.largeEndpoint = P.a := by
      simp [largeEndpoint, hba]
    rw [hmax]
    refine ⟨P.b * P.c, ?_⟩
    ring

/-- Radical monotonicity for the `c` coordinate. -/
theorem radical_c_le_abcRadical (P : ABCPoint) :
    abcRadical P.c ≤ abcRadical (P.a * P.b * P.c) := by
  have htarget : P.a * P.b * P.c ≠ 0 :=
    (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos).ne'
  have hdiv :
      radical P.c ∣ radical (P.a * P.b * P.c) :=
    radical_dvd_radical P.c_dvd_abcProduct htarget
  have hle := Nat.le_of_dvd
    (Nat.radical_pos (P.a * P.b * P.c)) hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- Radical monotonicity for the larger summand. -/
theorem radical_largeEndpoint_le_abcRadical (P : ABCPoint) :
    abcRadical P.largeEndpoint ≤
      abcRadical (P.a * P.b * P.c) := by
  have htarget : P.a * P.b * P.c ≠ 0 :=
    (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos).ne'
  have hdiv :
      radical P.largeEndpoint ∣ radical (P.a * P.b * P.c) :=
    radical_dvd_radical P.largeEndpoint_dvd_abcProduct htarget
  have hle := Nat.le_of_dvd
    (Nat.radical_pos (P.a * P.b * P.c)) hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- The radical logarithm of `c` is bounded by the abc conductor. -/
theorem log_radical_c_le_conductor (P : ABCPoint) :
    Real.log (abcRadical P.c : ℝ) ≤ P.conductor := by
  have hcpos : 0 < (abcRadical P.c : ℝ) := by
    exact_mod_cast abcRadical_pos P.c
  have habcpos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hreal :
      (abcRadical P.c : ℝ) ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast P.radical_c_le_abcRadical
  have hlog := Real.log_le_log hcpos hreal
  simpa [ABCPoint.conductor] using hlog

/-- The radical logarithm of the larger summand is bounded by the conductor. -/
theorem log_radical_largeEndpoint_le_conductor (P : ABCPoint) :
    Real.log (abcRadical P.largeEndpoint : ℝ) ≤ P.conductor := by
  have hMpos : 0 < (abcRadical P.largeEndpoint : ℝ) := by
    exact_mod_cast abcRadical_pos P.largeEndpoint
  have habcpos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hreal :
      (abcRadical P.largeEndpoint : ℝ) ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast P.radical_largeEndpoint_le_abcRadical
  have hlog := Real.log_le_log hMpos hreal
  simpa [ABCPoint.conductor] using hlog

/-- The larger summand has logarithmic size at least `height-log 2`. -/
theorem height_sub_log_two_le_log_largeEndpoint (P : ABCPoint) :
    P.height - Real.log 2 ≤ Real.log (P.largeEndpoint : ℝ) := by
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hMpos : 0 < (P.largeEndpoint : ℝ) := by
    exact_mod_cast P.largeEndpoint_pos
  have hreal :
      (P.c : ℝ) ≤ 2 * (P.largeEndpoint : ℝ) := by
    exact_mod_cast P.c_le_two_mul_largeEndpoint
  have hlog := Real.log_le_log hcpos hreal
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hMpos.ne'] at hlog
  rw [P.height_eq_log_c]
  linarith

/-- Every abc violation forces positive-height multiplicity excess in `c`. -/
theorem multiplicityExcess_c_large_of_abc_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    epsilon * P.height + C <
      (1 + epsilon) * multiplicityExcessLog P.c := by
  have hrad := P.log_radical_c_le_conductor
  have hone : 0 ≤ 1 + epsilon := by linarith
  have hscaled := mul_le_mul_of_nonneg_left hrad hone
  unfold multiplicityExcessLog
  rw [← P.height_eq_log_c]
  nlinarith

/-- Every abc violation forces positive-height multiplicity excess in the
larger summand as well. -/
theorem multiplicityExcess_largeEndpoint_large_of_abc_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    epsilon * P.height + C -
        (1 + epsilon) * Real.log 2 <
      (1 + epsilon) * multiplicityExcessLog P.largeEndpoint := by
  have hsize := P.height_sub_log_two_le_log_largeEndpoint
  have hrad := P.log_radical_largeEndpoint_le_conductor
  have hone : 0 ≤ 1 + epsilon := by linarith
  have hsizescaled := mul_le_mul_of_nonneg_left hsize hone
  have hradscaled := mul_le_mul_of_nonneg_left hrad hone
  unfold multiplicityExcessLog
  nlinarith

/-- Combined two-endpoint localization theorem. -/
theorem both_large_coordinates_have_multiplicityExcess_of_abc_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    epsilon * P.height + C <
        (1 + epsilon) * multiplicityExcessLog P.c ∧
      epsilon * P.height + C -
          (1 + epsilon) * Real.log 2 <
        (1 + epsilon) * multiplicityExcessLog P.largeEndpoint := by
  exact ⟨
    P.multiplicityExcess_c_large_of_abc_violation hepsilon hviolation,
    P.multiplicityExcess_largeEndpoint_large_of_abc_violation
      hepsilon hviolation⟩

end ABCPoint

namespace EndpointMultiplicityLocalization

#print axioms ABCPoint.radical_c_le_abcRadical
#print axioms ABCPoint.radical_largeEndpoint_le_abcRadical
#print axioms ABCPoint.log_radical_c_le_conductor
#print axioms ABCPoint.log_radical_largeEndpoint_le_conductor
#print axioms ABCPoint.height_sub_log_two_le_log_largeEndpoint
#print axioms ABCPoint.multiplicityExcess_c_large_of_abc_violation
#print axioms ABCPoint.multiplicityExcess_largeEndpoint_large_of_abc_violation
#print axioms ABCPoint.both_large_coordinates_have_multiplicityExcess_of_abc_violation

end EndpointMultiplicityLocalization
end
end IUTThreeClosures
