/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointAggregateSurplus
import Mathlib.Tactic

/-!
# Unconditional abc bounds from the signed large-endpoint surplus

The aggregate ledger immediately yields strong unconditional partial abc
results. In particular, nonpositive signed multiplicity-two surplus gives a
coefficient-one estimate, even when individual prime exponents exceed two.
This strictly extends the pointwise cube-free large-endpoint class.
-/

namespace IUTThreeClosures
namespace LargeEndpointAggregatePartialABC

open LargeEndpointAggregateSurplus

noncomputable section

namespace ABCPoint

/-- General slope transfer from a linear aggregate-surplus estimate. -/
theorem height_le_of_aggregateSurplus_linear_bound
    (P : ABCPoint) {delta K : ℝ}
    (hsurplus :
      P.largePairAggregateSurplus ≤ delta * P.conductor + K) :
    P.height ≤
      (1 + delta / 2) * P.conductor +
        (K + Real.log 2) / 2 := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_aggregateSurplus
  nlinarith

/-- Nonpositive aggregate surplus gives a strong coefficient-one abc bound. -/
theorem height_le_conductor_add_log_two_div_two_of_aggregateSurplus_nonpos
    (P : ABCPoint)
    (hsurplus : P.largePairAggregateSurplus ≤ 0) :
    P.height ≤ P.conductor + Real.log 2 / 2 := by
  have h := P.height_le_of_aggregateSurplus_linear_bound
    (delta := 0) (K := 0) hsurplus
  norm_num at h ⊢
  linarith

/-- A fixed upper bound on aggregate surplus is absorbed into the abc
constant without any epsilon loss. -/
theorem height_le_conductor_add_constant_of_aggregateSurplus_bounded
    (P : ABCPoint) {K : ℝ}
    (hsurplus : P.largePairAggregateSurplus ≤ K) :
    P.height ≤ P.conductor + (K + Real.log 2) / 2 := by
  simpa using P.height_le_of_aggregateSurplus_linear_bound
    (delta := 0) (K := K) hsurplus

/-- If the aggregate surplus has conductor slope `delta`, the resulting abc
height slope is exactly `1+delta/2`. -/
theorem height_le_one_add_half_delta
    (P : ABCPoint) {delta K : ℝ}
    (hsurplus :
      P.largePairAggregateSurplus ≤ delta * P.conductor + K) :
    P.height ≤
      (1 + delta / 2) * P.conductor +
        (K + Real.log 2) / 2 :=
  P.height_le_of_aggregateSurplus_linear_bound hsurplus

#print axioms ABCPoint.height_le_of_aggregateSurplus_linear_bound
#print axioms ABCPoint.height_le_conductor_add_log_two_div_two_of_aggregateSurplus_nonpos
#print axioms ABCPoint.height_le_conductor_add_constant_of_aggregateSurplus_bounded
#print axioms ABCPoint.height_le_one_add_half_delta

end ABCPoint
end
end LargeEndpointAggregatePartialABC
end IUTThreeClosures
