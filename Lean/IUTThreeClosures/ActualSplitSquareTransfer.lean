/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SplitSquareRadicalOverlap
import IUTThreeClosures.SplitSquareRadicalTransfer
import Mathlib.Tactic

/-!
# Actual split-square transfer

The previous modules provide:

* actual primitive root and split-square `ABCPoint`s;
* a fixed `log 2` radical-overlap bound;
* the exact scalar root-transfer threshold.

This file combines them.  Every split-square abc violation either descends to
an `epsilon/2` violation for the primitive root triple, with an explicit
constant, or forces height-scale logarithmic multiplicity excess in the
companion sum `s=y+x`.

No abc estimate or square-part existence theorem is assumed.
-/

namespace IUTThreeClosures
namespace ActualSplitSquareTransfer

open SplitSquareArithmeticBridge
open SplitSquareRadicalTransfer

noncomputable section

namespace SplitSquareArithmeticBridge.Data

/-- The radical of the square triple equals the radical of its four-factor
support. -/
theorem squareRadical_eq_supportRadical (D : Data) :
    abcRadical ((D.gap * D.sum) * D.x ^ 2 * D.y ^ 2) =
      abcRadical ((D.gap * D.sum) * D.x * D.y) := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical]
  have hA_x2 : Nat.Coprime (D.gap * D.sum) (D.x ^ 2) :=
    D.gap_mul_sum_coprime_x.pow_right 2
  have hA_y2 : Nat.Coprime (D.gap * D.sum) (D.y ^ 2) :=
    D.gap_mul_sum_coprime_y.pow_right 2
  have hA_x2y2 :
      Nat.Coprime (D.gap * D.sum) (D.x ^ 2 * D.y ^ 2) :=
    hA_x2.mul_right hA_y2
  have hx2_y2 : Nat.Coprime (D.x ^ 2) (D.y ^ 2) :=
    (D.coprime.pow_left 2).pow_right 2
  have hA_xy : Nat.Coprime (D.gap * D.sum) (D.x * D.y) :=
    D.gap_mul_sum_coprime_x.mul_right D.gap_mul_sum_coprime_y
  rw [show (D.gap * D.sum) * D.x ^ 2 * D.y ^ 2 =
      (D.gap * D.sum) * (D.x ^ 2 * D.y ^ 2) by ring]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp hA_x2y2)]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp hx2_y2)]
  rw [show (D.gap * D.sum) * D.x * D.y =
      (D.gap * D.sum) * (D.x * D.y) by ring]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp hA_xy)]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp D.coprime)]
  simp

/-- The split-square point conductor is the logarithmic radical of the four
linear factors. -/
theorem squarePoint_conductor_eq_supportLog (D : Data) :
    D.squarePoint.conductor =
      Real.log (abcRadical ((D.gap * D.sum) * D.x * D.y) : ℝ) := by
  unfold ABCPoint.conductor squarePoint
  rw [D.squareRadical_eq_supportRadical]

/-- The actual root conductor plus the full companion-sum radical differs from
the split-square conductor by at most `log 2`. -/
theorem rootConductor_add_sumRadical_le_squareConductor_add_log_two
    (D : Data) :
    D.rootPoint.conductor + Real.log (abcRadical D.sum : ℝ) ≤
      D.squarePoint.conductor + Real.log 2 := by
  rw [D.rootPoint.height_eq_log_c] at * <;> clear_value D.rootPoint.height
  unfold ABCPoint.conductor rootPoint
  rw [D.squarePoint_conductor_eq_supportLog]
  exact D.log_rootRadical_add_log_sumRadical_le_log_supportRadical_add_log_two

/-- The root height is nonnegative. -/
theorem rootPoint_height_nonneg (D : Data) :
    0 ≤ D.rootPoint.height := by
  rw [D.rootPoint_height_eq_log_y]
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr
      (lt_trans D.x_pos D.x_lt_y).ne')

/-- The root height is no larger than the logarithmic size of the companion
sum. -/
theorem rootPoint_height_le_log_sum (D : Data) :
    D.rootPoint.height ≤ Real.log (D.sum : ℝ) := by
  rw [D.rootPoint_height_eq_log_y]
  have hypos : 0 < (D.y : ℝ) := by
    exact_mod_cast lt_trans D.x_pos D.x_lt_y
  apply Real.log_le_log hypos
  exact_mod_cast (show D.y ≤ D.sum by
    unfold sum
    omega)

/-- Actual split-square dichotomy.  The second branch is expressed by the
explicit multiplicity excess `log s - log rad(s)`; no freely populated square
root field occurs. -/
theorem rootViolation_or_companionMultiplicityExcess
    (D : Data) {epsilon C K : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation :
      (1 + epsilon) * D.squarePoint.conductor + C <
        D.squarePoint.height) :
    ((1 + epsilon / 2) * D.rootPoint.conductor +
        ((1 + epsilon / 2) / (1 + epsilon)) *
          (C - (1 + epsilon) * (K + Real.log 2)) <
      D.rootPoint.height) ∨
      ((1 - halfEpsilonCriticalAlpha epsilon) * D.rootPoint.height + K <
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
      halfEpsilonCriticalAlpha epsilon * D.rootPoint.height - K ≤
        Real.log (abcRadical D.sum : ℝ)
  · left
    have htransfer := halfEpsilon_rootTransfer
      (epsilon := epsilon)
      (H := D.rootPoint.height)
      (Rroot := D.rootPoint.conductor)
      (Rsum := Real.log (abcRadical D.sum : ℝ))
      (C := C - (1 + epsilon) * Real.log 2)
      (K := K)
      hepsilon hH hviolation' hlarge
    convert htransfer using 1 <;> ring
  · right
    have hsmall :
        Real.log (abcRadical D.sum : ℝ) <
          halfEpsilonCriticalAlpha epsilon * D.rootPoint.height - K :=
      lt_of_not_ge hlarge
    have hsum := D.rootPoint_height_le_log_sum
    nlinarith

#print axioms Data.squareRadical_eq_supportRadical
#print axioms Data.squarePoint_conductor_eq_supportLog
#print axioms Data.rootConductor_add_sumRadical_le_squareConductor_add_log_two
#print axioms Data.rootViolation_or_companionMultiplicityExcess

end SplitSquareArithmeticBridge.Data
end
end ActualSplitSquareTransfer
end IUTThreeClosures
