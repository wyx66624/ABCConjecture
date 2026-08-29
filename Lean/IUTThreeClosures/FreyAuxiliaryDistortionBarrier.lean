/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# A sharp distortion criterion for auxiliary Frey families

An almost-all estimate on auxiliary curves is useful for a fixed Frey curve
only if it can be descended without introducing an uncontrolled auxiliary
parameter.  This module isolates the exact linear bookkeeping.

Suppose an auxiliary operation changes logarithmic height and conductor by

`H' = H + alpha * D`,
`N' = N + beta * D`.

A slope-`lambda` estimate `H' <= lambda * N' + C` descends to

`H <= lambda * N + (lambda * beta - alpha) * D + C`.

Thus the operation is uniformly harmless precisely when
`lambda * beta <= alpha`.  A positive distortion penalty produces an explicit
countermodel to any claimed uniform descent based on the transformed estimate
alone.

For the nominal squarefree quadratic-twist scaling

`alpha = 6`, `beta = 2`,

the exact neutral slope is three.  At slope `3 + eta` the residual distortion
is only `2 eta D`; consequently a good twist whose logarithmic size is at most
`3 N / (2 eta) + K` gives a slope-`6 + eta` estimate for the untwisted curve.
This is a genuine quantitative target, not an assumption hidden in a data
structure.
-/

namespace IUTThreeClosures
namespace FreyAuxiliaryDistortionBarrier

noncomputable section

/-- Logarithmic height after an auxiliary operation. -/
def transformedHeight (H alpha D : ℝ) : ℝ :=
  H + alpha * D

/-- Logarithmic conductor after an auxiliary operation. -/
def transformedConductor (N beta D : ℝ) : ℝ :=
  N + beta * D

/-- The coefficient of the auxiliary size left after descending a
slope-`lambda` estimate. -/
def distortionPenalty (lambda alpha beta : ℝ) : ℝ :=
  lambda * beta - alpha

/-- Exact descent identity for an auxiliary height/conductor estimate. -/
theorem descend_bound
    {H N alpha beta D lambda C : ℝ}
    (htransformed :
      transformedHeight H alpha D ≤
        lambda * transformedConductor N beta D + C) :
    H ≤ lambda * N + distortionPenalty lambda alpha beta * D + C := by
  dsimp [transformedHeight, transformedConductor, distortionPenalty]
    at htransformed ⊢
  nlinarith

/-- A nonpositive distortion penalty gives a uniform base-curve estimate for
all nonnegative auxiliary sizes. -/
theorem descend_uniform_of_nonpositive_penalty
    {H N alpha beta D lambda C : ℝ}
    (hD : 0 ≤ D)
    (hpenalty : distortionPenalty lambda alpha beta ≤ 0)
    (htransformed :
      transformedHeight H alpha D ≤
        lambda * transformedConductor N beta D + C) :
    H ≤ lambda * N + C := by
  have hdescended := descend_bound htransformed
  have hterm : distortionPenalty lambda alpha beta * D ≤ 0 :=
    mul_nonpos_of_nonpos_of_nonneg hpenalty hD
  linarith

/-- The criterion is sharp: with positive distortion penalty, for every
proposed uniform base constant there are nonnegative auxiliary data satisfying
the transformed inequality but violating that base bound. -/
theorem positive_penalty_prevents_uniform_descent
    {alpha beta lambda C transformedBaseConstant N : ℝ}
    (hpenalty : 0 < distortionPenalty lambda alpha beta) :
    ∃ H D : ℝ,
      0 ≤ D ∧
      transformedHeight H alpha D ≤
        lambda * transformedConductor N beta D + C ∧
      lambda * N + transformedBaseConstant < H := by
  let penalty : ℝ := distortionPenalty lambda alpha beta
  have hpenalty' : 0 < penalty := by
    simpa [penalty] using hpenalty
  let D : ℝ :=
    (|transformedBaseConstant - C| + 1) / penalty
  have hD : 0 ≤ D := by
    dsimp [D]
    exact div_nonneg (by positivity) hpenalty'.le
  have hpenalty_ne : penalty ≠ 0 := ne_of_gt hpenalty'
  have hpenaltyD :
      penalty * D = |transformedBaseConstant - C| + 1 := by
    dsimp [D]
    field_simp [hpenalty_ne]
  have hlarge : transformedBaseConstant - C < penalty * D := by
    rw [hpenaltyD]
    have habs :
        transformedBaseConstant - C ≤
          |transformedBaseConstant - C| :=
      le_abs_self _
    linarith
  let H : ℝ := lambda * N + penalty * D + C
  refine ⟨H, D, hD, ?_, ?_⟩
  · dsimp [H, penalty, transformedHeight,
      transformedConductor, distortionPenalty]
    ring_nf
    norm_num
  · dsimp [H]
    linarith

/-- Nominal logarithmic height scaling of a squarefree quadratic twist. -/
def quadraticTwistHeight (H D : ℝ) : ℝ :=
  transformedHeight H 6 D

/-- Nominal logarithmic Néron-conductor scaling of a squarefree quadratic
 twist at new good primes. -/
def quadraticTwistConductor (N D : ℝ) : ℝ :=
  transformedConductor N 2 D

/-- Exact quadratic-twist distortion at an arbitrary slope. -/
theorem quadraticTwist_distortionPenalty_formula (lambda : ℝ) :
    distortionPenalty lambda 6 2 = 2 * lambda - 6 := by
  unfold distortionPenalty
  ring

/-- The neutral quadratic-twist slope is exactly three. -/
theorem quadraticTwist_nonpositive_penalty_iff
    {lambda : ℝ} :
    distortionPenalty lambda 6 2 ≤ 0 ↔ lambda ≤ 3 := by
  rw [quadraticTwist_distortionPenalty_formula]
  constructor <;> intro h <;> nlinarith

/-- At slope `3 + eta`, the residual twist penalty is exactly `2 eta`. -/
theorem quadraticTwist_penalty_at_three_add (eta : ℝ) :
    distortionPenalty (3 + eta) 6 2 = 2 * eta := by
  rw [quadraticTwist_distortionPenalty_formula]
  ring

/-- A transformed slope-three estimate descends with no auxiliary loss. -/
theorem quadraticTwist_slope_three_descends
    {H N D C : ℝ}
    (hD : 0 ≤ D)
    (htransformed :
      quadraticTwistHeight H D ≤
        3 * quadraticTwistConductor N D + C) :
    H ≤ 3 * N + C := by
  apply descend_uniform_of_nonpositive_penalty
    (alpha := (6 : ℝ)) (beta := (2 : ℝ))
    (D := D) (lambda := (3 : ℝ)) hD
  · rw [quadraticTwist_nonpositive_penalty_iff]
  · simpa [quadraticTwistHeight, quadraticTwistConductor] using htransformed

/-- Exact descent at the near-neutral slope `3 + eta`. -/
theorem quadraticTwist_descend_at_three_add
    {H N D eta C : ℝ}
    (htransformed :
      quadraticTwistHeight H D ≤
        (3 + eta) * quadraticTwistConductor N D + C) :
    H ≤ (3 + eta) * N + 2 * eta * D + C := by
  have hdescended := descend_bound
    (alpha := (6 : ℝ)) (beta := (2 : ℝ))
    (lambda := 3 + eta) (D := D)
    (by simpa [quadraticTwistHeight, quadraticTwistConductor] using htransformed)
  rw [quadraticTwist_penalty_at_three_add] at hdescended
  exact hdescended

/-- A good near-neutral twist of controlled logarithmic size yields the
slope-six estimate required by the Frey route. -/
theorem quadraticTwist_small_good_twist_gives_slope_six
    {H N D eta C K : ℝ}
    (heta : 0 < eta)
    (hsize : D ≤ (3 * N) / (2 * eta) + K)
    (htransformed :
      quadraticTwistHeight H D ≤
        (3 + eta) * quadraticTwistConductor N D + C) :
    H ≤ (6 + eta) * N + C + 2 * eta * K := by
  have hdescended := quadraticTwist_descend_at_three_add htransformed
  have hcoef : 0 ≤ 2 * eta := by positivity
  have hscaled := mul_le_mul_of_nonneg_left hsize hcoef
  have hden : 2 * eta ≠ 0 := mul_ne_zero (by norm_num) heta.ne'
  have hidentity :
      (2 * eta) * ((3 * N) / (2 * eta) + K) =
        3 * N + 2 * eta * K := by
    field_simp [hden]
    ring
  rw [hidentity] at hscaled
  nlinarith

/-- Exact distortion coefficient at the usual modified-Szpiro slope
`6 + epsilon`. -/
theorem quadraticTwist_distortionPenalty (epsilon : ℝ) :
    distortionPenalty (6 + epsilon) 6 2 = 6 + 2 * epsilon := by
  rw [quadraticTwist_distortionPenalty_formula]
  ring

/-- The nominal quadratic-twist distortion is strictly positive at every
modified-Szpiro slope `6 + epsilon` with `epsilon >= 0`. -/
theorem quadraticTwist_penalty_pos
    {epsilon : ℝ} (hepsilon : 0 ≤ epsilon) :
    0 < distortionPenalty (6 + epsilon) 6 2 := by
  rw [quadraticTwist_distortionPenalty]
  nlinarith

/-- Explicit no-go theorem for naive unbounded-twist descent. -/
theorem quadraticTwist_transformed_bound_does_not_force_uniform_base_bound
    {epsilon C transformedBaseConstant N : ℝ}
    (hepsilon : 0 ≤ epsilon) :
    ∃ H D : ℝ,
      0 ≤ D ∧
      quadraticTwistHeight H D ≤
        (6 + epsilon) * quadraticTwistConductor N D + C ∧
      (6 + epsilon) * N + transformedBaseConstant < H := by
  obtain ⟨H, D, hD, htransformed, hbase⟩ :=
    positive_penalty_prevents_uniform_descent
      (alpha := (6 : ℝ)) (beta := (2 : ℝ))
      (lambda := 6 + epsilon) (C := C)
      (transformedBaseConstant := transformedBaseConstant) (N := N)
      (quadraticTwist_penalty_pos hepsilon)
  exact ⟨H, D, hD,
    (by simpa [quadraticTwistHeight, quadraticTwistConductor] using htransformed),
    hbase⟩

#print axioms descend_bound
#print axioms descend_uniform_of_nonpositive_penalty
#print axioms positive_penalty_prevents_uniform_descent
#print axioms quadraticTwist_distortionPenalty_formula
#print axioms quadraticTwist_nonpositive_penalty_iff
#print axioms quadraticTwist_penalty_at_three_add
#print axioms quadraticTwist_slope_three_descends
#print axioms quadraticTwist_descend_at_three_add
#print axioms quadraticTwist_small_good_twist_gives_slope_six
#print axioms quadraticTwist_distortionPenalty
#print axioms quadraticTwist_penalty_pos
#print axioms quadraticTwist_transformed_bound_does_not_force_uniform_base_bound

end
end FreyAuxiliaryDistortionBarrier
end IUTThreeClosures
