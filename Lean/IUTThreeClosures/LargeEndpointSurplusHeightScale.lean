/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointAggregateSurplus
import Mathlib.Tactic

/-!
# Height-scale aggregate surplus forced by an abc violation

The basic aggregate-surplus contrapositive is naturally stated relative to the
full conductor.  An abc violation also converts it into a fixed positive
fraction of the height itself.  The multiplication form proved here avoids any
loss from division by `1+epsilon`.
-/

namespace IUTThreeClosures
namespace LargeEndpointSurplusHeightScale

open LargeEndpointAggregateSurplus

noncomputable section

namespace ABCPoint

/-- Every `(1+epsilon)` abc violation forces height-scale signed exponent
surplus on the two large adjacent endpoints. -/
theorem height_scale_aggregateSurplus_of_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.height + 2 * C -
        (1 + epsilon) * Real.log 2 <
      (1 + epsilon) * P.largePairAggregateSurplus := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_aggregateSurplus
  have hlower :
      2 * P.height - Real.log 2 - 2 * P.conductor ≤
        P.largePairAggregateSurplus := by
    linarith
  have hone_nonneg : 0 ≤ 1 + epsilon := by linarith
  have hscaled := mul_le_mul_of_nonneg_left hlower hone_nonneg
  nlinarith

/-- Division form of the same height-scale lower bound. -/
theorem aggregateSurplus_fraction_of_height_of_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    (2 * epsilon * P.height + 2 * C) / (1 + epsilon) -
        Real.log 2 < P.largePairAggregateSurplus := by
  have hmul := P.height_scale_aggregateSurplus_of_violation
    hepsilon hviolation
  have honepos : 0 < 1 + epsilon := by linarith
  apply (div_lt_iff₀ honepos).2
  have hid :
      ((2 * epsilon * P.height + 2 * C) / (1 + epsilon) -
          Real.log 2) * (1 + epsilon) =
        2 * epsilon * P.height + 2 * C -
          (1 + epsilon) * Real.log 2 := by
    field_simp [honepos.ne']
    ring
  rw [hid]
  exact hmul

#print axioms ABCPoint.height_scale_aggregateSurplus_of_violation
#print axioms ABCPoint.aggregateSurplus_fraction_of_height_of_violation

end ABCPoint
end
end LargeEndpointSurplusHeightScale
end IUTThreeClosures
