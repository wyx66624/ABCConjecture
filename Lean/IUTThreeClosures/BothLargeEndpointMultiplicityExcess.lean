/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SignedPrimeExponentLayer
import Mathlib.Tactic

/-!
# Both large endpoints carry multiplicity excess in every abc violation

For a positive primitive abc point write `M = max(a,b)` and `h = log c`.
A violation

`(1+epsilon) * conductor + C < h`

forces positive logarithmic multiplicity excess separately on both `M` and
`c`. Each endpoint radical is bounded by the full conductor, while
`M >= c/2`.

No abc estimate, distribution theorem, or Pell bound is assumed.
-/

namespace IUTThreeClosures

noncomputable section

namespace ABCPoint

/-- Logarithmic multiplicity beyond the first radical layer of one integer. -/
def singleEndpointMultiplicityExcess (n : ℕ) : ℝ :=
  Real.log (n : ℝ) - Real.log (abcRadical n : ℝ)

/-- Every elementary radical logarithm is nonnegative. -/
theorem singleRadicalLog_nonneg (n : ℕ) :
    0 ≤ Real.log (abcRadical n : ℝ) := by
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr (abcRadical_pos n).ne')

/-- The radical log of the larger summand is bounded by the full conductor. -/
theorem largeEndpointRadicalLog_le_conductor (P : ABCPoint) :
    Real.log (abcRadical P.largeEndpoint : ℝ) ≤ P.conductor := by
  have hsmall := singleRadicalLog_nonneg P.endpointMin
  have hc := singleRadicalLog_nonneg P.c
  rw [P.conductor_eq_signedLayer_threeRadicalLogs]
  linarith

/-- The radical log of `c` is bounded by the full conductor. -/
theorem cRadicalLog_le_conductor (P : ABCPoint) :
    Real.log (abcRadical P.c : ℝ) ≤ P.conductor := by
  have hsmall := singleRadicalLog_nonneg P.endpointMin
  have hlarge := singleRadicalLog_nonneg P.largeEndpoint
  rw [P.conductor_eq_signedLayer_threeRadicalLogs]
  linarith

/-- Since `c <= 2*max(a,b)`, the larger summand has logarithm at least
`height-log 2`. -/
theorem height_sub_log_two_le_largeEndpointLog (P : ABCPoint) :
    P.height - Real.log 2 ≤ Real.log (P.largeEndpoint : ℝ) := by
  have hcorridor := P.two_height_sub_log_two_le_largeEndpointProductLog
  rw [P.largeEndpointProductLog_eq_signedLayer_add,
    P.height_eq_log_c] at hcorridor
  linarith

/-- A single abc violation forces height-scale multiplicity excess on both
large adjacent endpoints. The scaled form avoids division and preserves the
exact additive constants. -/
theorem both_largeEndpoint_multiplicityExcess_scaled_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    epsilon * P.height + C <
        (1 + epsilon) * singleEndpointMultiplicityExcess P.c ∧
      epsilon * P.height + C - (1 + epsilon) * Real.log 2 <
        (1 + epsilon) *
          singleEndpointMultiplicityExcess P.largeEndpoint := by
  have hcRad := P.cRadicalLog_le_conductor
  have hlargeRad := P.largeEndpointRadicalLog_le_conductor
  have hlargeLog := P.height_sub_log_two_le_largeEndpointLog
  have hheight := P.height_eq_log_c
  constructor
  · unfold singleEndpointMultiplicityExcess
    nlinarith
  · unfold singleEndpointMultiplicityExcess
    nlinarith

/-- Once height dominates the fixed constant, both multiplicity excesses have
the same explicit positive height slope. -/
theorem both_largeEndpoint_multiplicityExcess_positiveSlope_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height)
    (hheight :
      2 * (|C| + (1 + epsilon) * Real.log 2) ≤
        epsilon * P.height) :
    epsilon * P.height / 2 <
        (1 + epsilon) * singleEndpointMultiplicityExcess P.c ∧
      epsilon * P.height / 2 <
        (1 + epsilon) *
          singleEndpointMultiplicityExcess P.largeEndpoint := by
  have hscaled :=
    P.both_largeEndpoint_multiplicityExcess_scaled_of_height_violation
      hepsilon hviolation
  have hC : -|C| ≤ C := neg_abs_le C
  have hlog : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have hscale : 0 ≤ 1 + epsilon := by linarith
  have hscaleLog : 0 ≤ (1 + epsilon) * Real.log 2 :=
    mul_nonneg hscale hlog.le
  constructor
  · nlinarith [hscaled.1]
  · nlinarith [hscaled.2]

#print axioms singleRadicalLog_nonneg
#print axioms largeEndpointRadicalLog_le_conductor
#print axioms cRadicalLog_le_conductor
#print axioms height_sub_log_two_le_largeEndpointLog
#print axioms both_largeEndpoint_multiplicityExcess_scaled_of_height_violation
#print axioms both_largeEndpoint_multiplicityExcess_positiveSlope_of_height_violation

end ABCPoint
end
end IUTThreeClosures
