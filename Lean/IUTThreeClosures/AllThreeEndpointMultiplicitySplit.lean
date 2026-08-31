/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.BothLargeEndpointMultiplicityExcess
import Mathlib.Tactic

/-!
# Short endpoint or multiplicity on all three abc endpoints

A violation already forces multiplicity excess on the two large adjacent
endpoints.  This file treats the remaining endpoint.  Quantitatively, either
`min(a,b)` lies in a power-saving range below `c`, or it too has a fixed
positive height slope in its multiplicity excess.

Thus every alleged abc counterexample lies in one of two concrete regimes:

1. a genuinely short additive gap;
2. simultaneous multiplicity on all three pairwise coprime endpoints.

No height estimate or distribution statement is assumed.
-/

namespace IUTThreeClosures

noncomputable section

namespace ABCPoint

/-- The radical log of the smaller summand is bounded by the full conductor. -/
theorem endpointMinRadicalLog_le_conductor (P : ABCPoint) :
    Real.log (abcRadical P.endpointMin : ℝ) ≤ P.conductor := by
  have hlarge := singleRadicalLog_nonneg P.largeEndpoint
  have hc := singleRadicalLog_nonneg P.c
  rw [P.conductor_eq_signedLayer_threeRadicalLogs]
  linarith

/-- General relative-size transfer for the smaller endpoint. -/
theorem endpointMin_multiplicityExcess_of_relative_height
    (P : ABCPoint) {epsilon C tau : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height)
    (hsize : tau * P.height ≤ P.endpointMinLog) :
    ((1 + epsilon) * tau - 1) * P.height + C <
      (1 + epsilon) *
        singleEndpointMultiplicityExcess P.endpointMin := by
  have hrad := P.endpointMinRadicalLog_le_conductor
  unfold singleEndpointMultiplicityExcess endpointMinLog at *
  nlinarith

/-- Denominator-free power-saving dichotomy for the smaller endpoint. -/
theorem endpointMin_short_or_multiplicityExcess_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * (1 + epsilon) * P.endpointMinLog <
        (2 + epsilon) * P.height ∨
      epsilon * P.height + 2 * C <
        2 * (1 + epsilon) *
          singleEndpointMultiplicityExcess P.endpointMin := by
  by_cases hshort :
      2 * (1 + epsilon) * P.endpointMinLog <
        (2 + epsilon) * P.height
  · exact Or.inl hshort
  · right
    have hsize :
        (2 + epsilon) * P.height ≤
          2 * (1 + epsilon) * P.endpointMinLog :=
      le_of_not_gt hshort
    have hrad := P.endpointMinRadicalLog_le_conductor
    unfold singleEndpointMultiplicityExcess endpointMinLog at *
    nlinarith

/-- Every abc violation is either a power-saving endpoint gap or has explicit
multiplicity excess on all three pairwise coprime endpoints. -/
theorem short_endpoint_or_all_three_multiplicityExcess
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * (1 + epsilon) * P.endpointMinLog <
        (2 + epsilon) * P.height ∨
      (epsilon * P.height + 2 * C <
          2 * (1 + epsilon) *
            singleEndpointMultiplicityExcess P.endpointMin ∧
        epsilon * P.height + C <
          (1 + epsilon) * singleEndpointMultiplicityExcess P.c ∧
        epsilon * P.height + C -
            (1 + epsilon) * Real.log 2 <
          (1 + epsilon) *
            singleEndpointMultiplicityExcess P.largeEndpoint) := by
  rcases P.endpointMin_short_or_multiplicityExcess_of_height_violation
      hepsilon hviolation with hshort | hsmall
  · exact Or.inl hshort
  · right
    have hlarge :=
      P.both_largeEndpoint_multiplicityExcess_scaled_of_height_violation
        hepsilon hviolation
    exact ⟨hsmall, hlarge.1, hlarge.2⟩

#print axioms endpointMinRadicalLog_le_conductor
#print axioms endpointMin_multiplicityExcess_of_relative_height
#print axioms endpointMin_short_or_multiplicityExcess_of_height_violation
#print axioms short_endpoint_or_all_three_multiplicityExcess

end ABCPoint
end
end IUTThreeClosures
