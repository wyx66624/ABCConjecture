/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.BothSquareOneCubeDepth
import IUTThreeClosures.CoefficientThreeForcesShortEndpoint
import Mathlib.Tactic

/-!
# The exact coefficient-three residual: short gap plus cube depth

Combining the coefficient-three endpoint transfer with the factorization-free
multiplicity layers gives a concrete residual package.  Every point that both
satisfies

`S <= 3R + eta*h + K`

and violates

`(1+epsilon)R + C < h`

has an explicitly short smaller summand.  Moreover one of the two large
adjacent endpoints has an explicitly large cube-support layer, whose cube
divides that endpoint, or an equally large quotient beyond cube depth.
-/

namespace IUTThreeClosures

open SymmetricProductCoefficientBarrier
open ThirdLayerGCDRefinement

noncomputable section

namespace ABCPoint

/-- Endpoint radical logarithm is nonnegative. -/
theorem endpointMinRadicalLog_nonneg (P : ABCPoint) :
    0 ≤ Real.log (abcRadical P.endpointMin : ℝ) :=
  singleRadicalLog_nonneg P.endpointMin

/-- The smaller endpoint itself has nonnegative logarithm. -/
theorem endpointMinLog_nonneg (P : ABCPoint) :
    0 ≤ P.endpointMinLog := by
  unfold endpointMinLog
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr P.endpointMin_pos.ne')

/-- The pointwise coefficient-three residual capsule. -/
theorem coefficientThree_violation_short_and_cubeDepth
    (P : ABCPoint) {epsilon eta K C : ℝ}
    (hepsilon : 0 < epsilon)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor + eta * P.height + K)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    let U :=
      (epsilon * (2 - eta) / 3 * P.height + C -
        epsilon / 3 * K -
        (epsilon / 3 + 1 / 2) * Real.log 2) / 2
    (1 + epsilon) * P.endpointMinLog <
        (1 - 2 * epsilon + eta * (1 + epsilon)) * P.height +
          (1 + epsilon) * (K + Real.log 2) - 3 * C ∧
      (((U < Real.log (thirdSupportLayer P.largeEndpoint : ℝ) ∧
            thirdSupportLayer P.largeEndpoint ^ 3 ∣ P.largeEndpoint) ∨
          U < Real.log
            (thirdLayerExcessQuotient P.largeEndpoint : ℝ)) ∨
        ((U < Real.log (thirdSupportLayer P.c : ℝ) ∧
            thirdSupportLayer P.c ^ 3 ∣ P.c) ∨
          U < Real.log (thirdLayerExcessQuotient P.c : ℝ))) := by
  dsimp
  have hshort :=
    P.coefficientThree_forces_endpointMin_bound
      hepsilon hproduct hviolation
  have hlowerProduct :=
    P.two_height_add_endpointMinLog_sub_log_two_le_symmetricProductLog
  have hRlower :
      (2 - eta) * P.height + P.endpointMinLog - K - Real.log 2 ≤
        3 * P.conductor := by
    nlinarith
  have hlogm := P.endpointMinLog_nonneg
  have hradmin := P.endpointMinRadicalLog_nonneg
  let T : ℝ :=
    Real.log (abcRadical P.endpointMin : ℝ) +
      epsilon * P.conductor + C - Real.log 2 / 2
  let U : ℝ :=
    (epsilon * (2 - eta) / 3 * P.height + C -
      epsilon / 3 * K -
      (epsilon / 3 + 1 / 2) * Real.log 2) / 2
  have hUle : 2 * U ≤ T := by
    dsimp [U, T]
    nlinarith
  have hdepth :=
    P.one_largeEndpoint_cubeDepth_or_deeper_of_height_violation
      hviolation
  dsimp [T] at hdepth
  refine ⟨hshort, ?_⟩
  rcases hdepth with ((hM, hMdiv) | hMQ) | ((hc, hcdiv) | hcQ)
  · left
    left
    exact ⟨by nlinarith, hMdiv⟩
  · left
    right
    nlinarith
  · right
    left
    exact ⟨by nlinarith, hcdiv⟩
  · right
    right
    nlinarith

#print axioms endpointMinRadicalLog_nonneg
#print axioms endpointMinLog_nonneg
#print axioms coefficientThree_violation_short_and_cubeDepth

end ABCPoint
end
end IUTThreeClosures
