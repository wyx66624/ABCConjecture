/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualSplitSquareTransfer
import Mathlib.Tactic

/-!
# Same-epsilon descent in the actual split-square branch

The half-epsilon transfer is not the only useful choice.  Taking the omitted
radical threshold

`alpha = 1 / (1+epsilon)`

and the threshold loss `K = -log 2` makes the fixed overlap cancel exactly.
Every actual split-square violation at parameters `(epsilon,C)` then satisfies
one of:

* the primitive root triple is a violation for the same `(epsilon,C)`, at
  exactly half logarithmic height;
* the companion sum has multiplicity excess at least
  `epsilon/(1+epsilon)` times the root height, up to `log 2`.

Consequently a height-minimal counterexample for fixed `(epsilon,C)` cannot
lie in the first branch.  No abc estimate is assumed.
-/

namespace IUTThreeClosures
namespace ActualSplitSquareSameEpsilonDescent

open SplitSquareArithmeticBridge
open SplitSquareRadicalTransfer
open ActualSplitSquareTransfer

noncomputable section

/-- The critical omitted-radical share for a no-loss transfer of epsilon. -/
def sameEpsilonCriticalAlpha (epsilon : ℝ) : ℝ :=
  1 / (1 + epsilon)

/-- Exact coefficient identity for same-epsilon transfer. -/
theorem sameEpsilonCriticalAlpha_identity
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    (1 + epsilon) *
        (2 - (1 + epsilon) * sameEpsilonCriticalAlpha epsilon) =
      1 + epsilon := by
  unfold sameEpsilonCriticalAlpha
  have hne : 1 + epsilon ≠ 0 := by linarith
  field_simp [hne]
  ring

/-- Complementary gain coefficient. -/
theorem one_sub_sameEpsilonCriticalAlpha
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    1 - sameEpsilonCriticalAlpha epsilon =
      epsilon / (1 + epsilon) := by
  unfold sameEpsilonCriticalAlpha
  have hne : 1 + epsilon ≠ 0 := by linarith
  field_simp [hne]
  ring

/-- Same-epsilon actual split-square dichotomy. -/
theorem sameEpsilon_rootViolation_or_companionMultiplicityExcess
    (D : SplitSquareArithmeticBridge.Data)
    {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * D.squarePoint.conductor + C <
        D.squarePoint.height) :
    ((1 + epsilon) * D.rootPoint.conductor + C <
      D.rootPoint.height) ∨
      (epsilon / (1 + epsilon) * D.rootPoint.height - Real.log 2 <
        Real.log (D.sum : ℝ) -
          Real.log (abcRadical D.sum : ℝ)) := by
  have hH := D.rootPoint_height_nonneg
  have hheight :
      D.squarePoint.height = 2 * D.rootPoint.height := by
    rw [D.squarePoint_height_eq_two_log_y,
      D.rootPoint_height_eq_log_y]
  have hoverlap :=
    D.rootConductor_add_sumRadical_le_squareConductor_add_log_two
  have hone : 0 < 1 + epsilon := by linarith
  have hviolation' :
      (1 + epsilon) *
          (D.rootPoint.conductor +
            Real.log (abcRadical D.sum : ℝ)) +
          (C - (1 + epsilon) * Real.log 2) <
        2 * D.rootPoint.height := by
    rw [hheight] at hviolation
    nlinarith
  by_cases hlarge :
      sameEpsilonCriticalAlpha epsilon * D.rootPoint.height + Real.log 2 ≤
        Real.log (abcRadical D.sum : ℝ)
  · left
    have htransfer := rootConductor_transfer
      (epsilon := epsilon)
      (eta := epsilon)
      (alpha := sameEpsilonCriticalAlpha epsilon)
      (H := D.rootPoint.height)
      (Rroot := D.rootPoint.conductor)
      (Rsum := Real.log (abcRadical D.sum : ℝ))
      (C := C - (1 + epsilon) * Real.log 2)
      (K := -Real.log 2)
      (by linarith) (by linarith) hH hviolation'
      (by simpa using hlarge)
      (by rw [sameEpsilonCriticalAlpha_identity hepsilon])
    convert htransfer using 1 <;> ring
  · right
    have hsmall :
        Real.log (abcRadical D.sum : ℝ) <
          sameEpsilonCriticalAlpha epsilon * D.rootPoint.height +
            Real.log 2 :=
      lt_of_not_ge hlarge
    have hsum := D.rootPoint_height_le_log_sum
    rw [one_sub_sameEpsilonCriticalAlpha hepsilon]
    nlinarith

/-- The root height is strictly positive. -/
theorem rootPoint_height_pos
    (D : SplitSquareArithmeticBridge.Data) :
    0 < D.rootPoint.height := by
  rw [D.rootPoint_height_eq_log_y]
  apply Real.log_pos
  exact_mod_cast (show 1 < D.y by omega)

/-- The root point has strictly smaller height than the split-square point. -/
theorem rootPoint_height_lt_squarePoint_height
    (D : SplitSquareArithmeticBridge.Data) :
    D.rootPoint.height < D.squarePoint.height := by
  rw [D.squarePoint_height_eq_two_log_y,
    D.rootPoint_height_eq_log_y]
  have hpos := D.rootPoint_height_pos
  rw [D.rootPoint_height_eq_log_y] at hpos
  linarith

/-- A height-minimal violation for fixed `(epsilon,C)` is forced into the
companion multiplicity-excess branch. -/
theorem companionMultiplicityExcess_of_heightMinimalViolation
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
    epsilon / (1 + epsilon) * D.rootPoint.height - Real.log 2 <
      Real.log (D.sum : ℝ) -
        Real.log (abcRadical D.sum : ℝ) := by
  have hsplit :=
    sameEpsilon_rootViolation_or_companionMultiplicityExcess
      D hepsilon hviolation
  rcases hsplit with hroot | hexcess
  · have hmin := hminimal D.rootPoint hroot
    have hlt := D.rootPoint_height_lt_squarePoint_height
    linarith
  · exact hexcess

#print axioms sameEpsilonCriticalAlpha_identity
#print axioms sameEpsilon_rootViolation_or_companionMultiplicityExcess
#print axioms rootPoint_height_lt_squarePoint_height
#print axioms companionMultiplicityExcess_of_heightMinimalViolation

end
end ActualSplitSquareSameEpsilonDescent
end IUTThreeClosures
