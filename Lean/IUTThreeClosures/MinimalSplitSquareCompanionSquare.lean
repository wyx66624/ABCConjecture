/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualSplitSquareSameEpsilonDescent
import IUTThreeClosures.CanonicalSquareDivisor
import Mathlib.Tactic

/-!
# A genuine large square divisor in every minimal split-square counterexample

For fixed `(epsilon,C)`, a height-minimal split-square counterexample cannot
descend to the smaller root triple.  The resulting companion multiplicity
excess, combined with the factorization-based canonical square divisor,
produces an actual integer `q` such that

`q^2 | y+x`

and

`log q > (epsilon/(1+epsilon) * log y - log 2)/2`.

No square-root witness is assumed as data.
-/

namespace IUTThreeClosures
namespace MinimalSplitSquareCompanionSquare

open SplitSquareArithmeticBridge
open ActualSplitSquareSameEpsilonDescent
open CanonicalSquareDivisor

noncomputable section

/-- The canonical companion square root is quantitatively large in every
height-minimal split-square violation. -/
theorem canonicalCompanionSquare_large_of_heightMinimalViolation
    (D : SplitSquareArithmeticBridge.Data)
    {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * D.squarePoint.conductor + C <
        D.squarePoint.height)
    (hminimal :
      ∀ P : ABCPoint,
        (1 + epsilon) * P.conductor + C < P.height →
          D.squarePoint.height ≤ P.height) :
    canonicalSquareRoot D.sum ^ 2 ∣ D.sum ∧
      (epsilon / (1 + epsilon) * D.rootPoint.height - Real.log 2) / 2 <
        Real.log (canonicalSquareRoot D.sum : ℝ) := by
  constructor
  · exact canonicalSquareRoot_sq_dvd D.sum_pos.ne'
  · have hexcess :=
      companionMultiplicityExcess_of_heightMinimalViolation
        D hepsilon hviolation hminimal
    have hcapture :=
      log_sub_log_abcRadical_le_two_log_canonicalSquareRoot
        D.sum_pos
    nlinarith

/-- Equivalent coefficient form of the logarithmic lower bound. -/
theorem canonicalCompanionSquare_large_coefficient_form
    (D : SplitSquareArithmeticBridge.Data)
    {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * D.squarePoint.conductor + C <
        D.squarePoint.height)
    (hminimal :
      ∀ P : ABCPoint,
        (1 + epsilon) * P.conductor + C < P.height →
          D.squarePoint.height ≤ P.height) :
    epsilon / (2 * (1 + epsilon)) * D.rootPoint.height -
        Real.log 2 / 2 <
      Real.log (canonicalSquareRoot D.sum : ℝ) := by
  have h :=
    (canonicalCompanionSquare_large_of_heightMinimalViolation
      D hepsilon hviolation hminimal).2
  have hone : 1 + epsilon ≠ 0 := by linarith
  have hidentity :
      epsilon / (2 * (1 + epsilon)) * D.rootPoint.height -
          Real.log 2 / 2 =
        (epsilon / (1 + epsilon) * D.rootPoint.height -
          Real.log 2) / 2 := by
    field_simp [hone]
    ring
  rw [hidentity]
  exact h

#print axioms canonicalCompanionSquare_large_of_heightMinimalViolation
#print axioms canonicalCompanionSquare_large_coefficient_form

end
end MinimalSplitSquareCompanionSquare
end IUTThreeClosures
