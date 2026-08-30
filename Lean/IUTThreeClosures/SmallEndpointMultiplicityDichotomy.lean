/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EndpointMultiplicityLocalization
import IUTThreeClosures.EndpointBalanceCoefficientTransfer
import Mathlib.Tactic

/-!
# Small-gap or three-coordinate multiplicity dichotomy

The two large coordinates of every abc violation have positive-height
multiplicity excess.  This file adds the smaller summand.

If `m=min(a,b)` and

`height > (1+epsilon) * conductor + C`,

then

`(1+epsilon) * log m - height + C
  < (1+epsilon) * excess(m)`.

Consequently, for any balance exponent `tau`, every violation satisfies a
strict dichotomy:

* either `log m < tau * height` (a power-saving additive gap), or
* all three coordinates have explicit multiplicity-excess lower bounds.

When `(1+epsilon)*tau>1`, the smaller coordinate also has a fixed positive
height slope.  No abc estimate or distribution theorem is assumed.
-/

namespace IUTThreeClosures

open EndpointMultiplicityLocalization
open UniqueFactorizationMonoid

noncomputable section

namespace ABCPoint

/-- The smaller summand divides the full abc product. -/
theorem endpointMin_dvd_abcProduct (P : ABCPoint) :
    P.endpointMin ∣ P.a * P.b * P.c := by
  by_cases hab : P.a ≤ P.b
  · have hmin : P.endpointMin = P.a := by
      simp [endpointMin, hab]
    rw [hmin]
    refine ⟨P.b * P.c, ?_⟩
    ring
  · have hba : P.b ≤ P.a := by omega
    have hmin : P.endpointMin = P.b := by
      simp [endpointMin, hba]
    rw [hmin]
    refine ⟨P.a * P.c, ?_⟩
    ring

/-- Radical monotonicity for the smaller summand. -/
theorem radical_endpointMin_le_abcRadical (P : ABCPoint) :
    abcRadical P.endpointMin ≤
      abcRadical (P.a * P.b * P.c) := by
  have htarget : P.a * P.b * P.c ≠ 0 :=
    (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos).ne'
  have hdiv :
      radical P.endpointMin ∣ radical (P.a * P.b * P.c) :=
    radical_dvd_radical P.endpointMin_dvd_abcProduct htarget
  have hle := Nat.le_of_dvd
    (Nat.radical_pos (P.a * P.b * P.c)) hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- The smaller endpoint radical logarithm is bounded by the abc conductor. -/
theorem log_radical_endpointMin_le_conductor (P : ABCPoint) :
    Real.log (abcRadical P.endpointMin : ℝ) ≤ P.conductor := by
  have hmpos : 0 < (abcRadical P.endpointMin : ℝ) := by
    exact_mod_cast abcRadical_pos P.endpointMin
  have habcpos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hreal :
      (abcRadical P.endpointMin : ℝ) ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast P.radical_endpointMin_le_abcRadical
  have hlog := Real.log_le_log hmpos hreal
  simpa [ABCPoint.conductor] using hlog

/-- General lower bound for multiplicity excess in the smaller summand. -/
theorem multiplicityExcess_endpointMin_lower_of_abc_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    (1 + epsilon) * P.endpointMinLog - P.height + C <
      (1 + epsilon) * multiplicityExcessLog P.endpointMin := by
  have hrad := P.log_radical_endpointMin_le_conductor
  have hone : 0 ≤ 1 + epsilon := by linarith
  have hscaled := mul_le_mul_of_nonneg_left hrad hone
  unfold multiplicityExcessLog endpointMinLog
  nlinarith

/-- If the smaller summand lies above a balance threshold, it also has an
explicit height-proportional multiplicity excess. -/
theorem multiplicityExcess_endpointMin_large_of_balance
    (P : ABCPoint) {epsilon C tau : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height)
    (hbalance : tau * P.height ≤ P.endpointMinLog) :
    ((1 + epsilon) * tau - 1) * P.height + C <
      (1 + epsilon) * multiplicityExcessLog P.endpointMin := by
  have hbase :=
    P.multiplicityExcess_endpointMin_lower_of_abc_violation
      hepsilon hviolation
  have hone : 0 ≤ 1 + epsilon := by linarith
  have hscaled := mul_le_mul_of_nonneg_left hbalance hone
  nlinarith

/-- Every abc violation is either a power-saving small-gap point or all three
coordinates have the displayed repeated-prime lower bounds. -/
theorem small_gap_or_all_three_have_multiplicityExcess
    (P : ABCPoint) {epsilon C tau : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    P.endpointMinLog < tau * P.height ∨
      (epsilon * P.height + C <
          (1 + epsilon) * multiplicityExcessLog P.c ∧
       epsilon * P.height + C -
            (1 + epsilon) * Real.log 2 <
          (1 + epsilon) * multiplicityExcessLog P.largeEndpoint ∧
       ((1 + epsilon) * tau - 1) * P.height + C <
          (1 + epsilon) * multiplicityExcessLog P.endpointMin) := by
  by_cases hsmall : P.endpointMinLog < tau * P.height
  · exact Or.inl hsmall
  · right
    have hbalance : tau * P.height ≤ P.endpointMinLog :=
      le_of_not_gt hsmall
    exact ⟨
      P.multiplicityExcess_c_large_of_abc_violation hepsilon hviolation,
      P.multiplicityExcess_largeEndpoint_large_of_abc_violation
        hepsilon hviolation,
      P.multiplicityExcess_endpointMin_large_of_balance
        hepsilon hviolation hbalance⟩

/-- In the balanced branch, a threshold above `1/(1+epsilon)` makes the
smaller-endpoint multiplicity slope strictly positive. -/
theorem endpointMin_positive_slope_of_supercritical_balance
    (P : ABCPoint) {epsilon C tau : ℝ}
    (hepsilon : 0 < epsilon)
    (htau : 1 < (1 + epsilon) * tau)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height)
    (hbalance : tau * P.height ≤ P.endpointMinLog) :
    0 < ((1 + epsilon) * tau - 1) ∧
      ((1 + epsilon) * tau - 1) * P.height + C <
        (1 + epsilon) * multiplicityExcessLog P.endpointMin := by
  constructor
  · linarith
  · exact P.multiplicityExcess_endpointMin_large_of_balance
      hepsilon hviolation hbalance

end ABCPoint

#print axioms ABCPoint.radical_endpointMin_le_abcRadical
#print axioms ABCPoint.log_radical_endpointMin_le_conductor
#print axioms ABCPoint.multiplicityExcess_endpointMin_lower_of_abc_violation
#print axioms ABCPoint.multiplicityExcess_endpointMin_large_of_balance
#print axioms ABCPoint.small_gap_or_all_three_have_multiplicityExcess
#print axioms ABCPoint.endpointMin_positive_slope_of_supercritical_balance

end
end IUTThreeClosures
