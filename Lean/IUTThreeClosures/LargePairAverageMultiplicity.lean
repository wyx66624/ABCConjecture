/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointAggregatePartialABC
import Mathlib.Tactic

/-!
# Partial abc from the average multiplicity of the two large endpoints

If the logarithmic size of `max(a,b)*c` is at most `2+delta` times its
logarithmic radical, then the standard abc height coefficient is at most
`1+delta/2`.  This formulation is often easier to verify directly than a
signed-surplus inequality.
-/

namespace IUTThreeClosures
namespace LargePairAverageMultiplicity

open LargeEndpointAggregateSurplus
open LargeEndpointAggregatePartialABC

noncomputable section

namespace ABCPoint

/-- Transfer from a logarithmic average-prime-multiplicity bound on the two
large endpoints. -/
theorem height_le_of_largePair_averageMultiplicity_bound
    (P : ABCPoint) {delta K : ℝ}
    (hdelta : 0 ≤ delta)
    (hpair :
      P.largePairLog ≤
        (2 + delta) * P.largePairRadicalLog + K) :
    P.height ≤
      (1 + delta / 2) * P.conductor +
        (K + Real.log 2) / 2 := by
  have hrad := P.largePairRadicalLog_le_conductor
  have hscaled := mul_le_mul_of_nonneg_left hrad hdelta
  have hsurplus :
      P.largePairAggregateSurplus ≤ delta * P.conductor + K := by
    unfold ABCPoint.largePairAggregateSurplus
    nlinarith
  exact P.height_le_of_aggregateSurplus_linear_bound hsurplus

/-- Average multiplicity at most two gives coefficient one. -/
theorem height_le_conductor_of_largePairLog_le_two_radicalLog
    (P : ABCPoint) {K : ℝ}
    (hpair :
      P.largePairLog ≤ 2 * P.largePairRadicalLog + K) :
    P.height ≤ P.conductor + (K + Real.log 2) / 2 := by
  have h := P.height_le_of_largePair_averageMultiplicity_bound
    (delta := 0) (K := K) (by norm_num) (by simpa using hpair)
  norm_num at h ⊢
  linarith

/-- The exact epsilon specialization. -/
theorem height_le_one_add_epsilon_of_largePairLog_le
    (P : ABCPoint) {epsilon K : ℝ}
    (hepsilon : 0 ≤ epsilon)
    (hpair :
      P.largePairLog ≤
        (2 + 2 * epsilon) * P.largePairRadicalLog + K) :
    P.height ≤
      (1 + epsilon) * P.conductor +
        (K + Real.log 2) / 2 := by
  have h := P.height_le_of_largePair_averageMultiplicity_bound
    (delta := 2 * epsilon) (K := K)
    (mul_nonneg (by norm_num) hepsilon) hpair
  nlinarith

#print axioms ABCPoint.height_le_of_largePair_averageMultiplicity_bound
#print axioms ABCPoint.height_le_conductor_of_largePairLog_le_two_radicalLog
#print axioms ABCPoint.height_le_one_add_epsilon_of_largePairLog_le

end ABCPoint
end
end LargePairAverageMultiplicity
end IUTThreeClosures
