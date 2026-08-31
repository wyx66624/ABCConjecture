/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EndpointBalanceCoefficientTransfer
import Mathlib.Tactic

/-!
# A coefficient-three product estimate forces every abc violation into a short endpoint

For an abc point let

`S = log(a*b*c)`, `h = log c`, `R = log rad(abc)`, and
`m = min(a,b)`.

The elementary lower corridor is

`2h + log m - log 2 <= S`.

Combining a pointwise product estimate

`S <= 3R + eta*h + K`

with a violation

`(1+epsilon)R + C < h`

gives the exact endpoint bound

`(1+epsilon)log m <
 (1-2epsilon+eta(1+epsilon))h +(1+epsilon)(K+log2)-3C`.

Thus any coefficient-three theorem with relative error below
`2epsilon/(1+epsilon)` eliminates the balanced region and reduces the
remaining case to a strict power-saving additive endpoint.
-/

namespace IUTThreeClosures

open SymmetricProductCoefficientBarrier

noncomputable section

namespace ABCPoint

/-- Exact pointwise short-endpoint transfer from a coefficient-three product
estimate and an abc violation. -/
theorem coefficientThree_forces_endpointMin_bound
    (P : ABCPoint) {epsilon eta K C : ℝ}
    (hepsilon : 0 < epsilon)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor + eta * P.height + K)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    (1 + epsilon) * P.endpointMinLog <
      (1 - 2 * epsilon + eta * (1 + epsilon)) * P.height +
        (1 + epsilon) * (K + Real.log 2) - 3 * C := by
  have hlower :=
    P.two_height_add_endpointMinLog_sub_log_two_le_symmetricProductLog
  have hone : 0 < 1 + epsilon := by linarith
  nlinarith

/-- Convenient specialization: a relative product error
`epsilon/(1+epsilon)` still leaves a strict power saving. -/
theorem coefficientThree_with_epsilon_error_forces_short_endpoint
    (P : ABCPoint) {epsilon K C : ℝ}
    (hepsilon : 0 < epsilon)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor +
          (epsilon / (1 + epsilon)) * P.height + K)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    (1 + epsilon) * P.endpointMinLog <
      (1 - epsilon) * P.height +
        (1 + epsilon) * (K + Real.log 2) - 3 * C := by
  have hgeneral :=
    P.coefficientThree_forces_endpointMin_bound
      hepsilon hproduct hviolation
  have hone : 1 + epsilon ≠ 0 := by linarith
  have hcoeff :
      1 - 2 * epsilon +
          (epsilon / (1 + epsilon)) * (1 + epsilon) =
        1 - epsilon := by
    field_simp [hone]
    ring
  rw [hcoeff] at hgeneral
  exact hgeneral

/-- Once height dominates the additive constant, the preceding estimate gives
a denominator-free strict power-saving corridor. -/
theorem coefficientThree_forces_eventual_powerSaving_endpoint
    (P : ABCPoint) {epsilon K C : ℝ}
    (hepsilon : 0 < epsilon)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor +
          (epsilon / (1 + epsilon)) * P.height + K)
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height)
    (hheight :
      2 * |(1 + epsilon) * (K + Real.log 2) - 3 * C| ≤
        epsilon * P.height) :
    2 * (1 + epsilon) * P.endpointMinLog <
      (2 - epsilon) * P.height := by
  have hshort :=
    P.coefficientThree_with_epsilon_error_forces_short_endpoint
      hepsilon hproduct hviolation
  have habs :
      (1 + epsilon) * (K + Real.log 2) - 3 * C ≤
        |(1 + epsilon) * (K + Real.log 2) - 3 * C| :=
    le_abs_self _
  nlinarith

#print axioms coefficientThree_forces_endpointMin_bound
#print axioms coefficientThree_with_epsilon_error_forces_short_endpoint
#print axioms coefficientThree_forces_eventual_powerSaving_endpoint

end ABCPoint
end
end IUTThreeClosures
