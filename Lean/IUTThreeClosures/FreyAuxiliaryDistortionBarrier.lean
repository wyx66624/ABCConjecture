/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# A sharp distortion criterion for auxiliary Frey families

An almost-all estimate on auxiliary curves is useful for a fixed Frey curve
only if it can be descended without introducing an unbounded parameter error.
This module isolates the exact linear bookkeeping.

Suppose an auxiliary operation changes logarithmic height and conductor by

`H' = H + alpha * D`,
`N' = N + beta * D`.

A slope-`lambda` estimate `H' <= lambda * N' + C` descends to

`H <= lambda * N + (lambda * beta - alpha) * D + C`.

Thus the operation is uniformly harmless precisely when
`lambda * beta <= alpha`.  A positive distortion penalty produces an explicit
countermodel to any claimed uniform descent based on the transformed estimate
alone.

The nominal quadratic-twist scaling `alpha = 6`, `beta = 2` has positive
penalty `6 + 2 * epsilon` at the modified-Szpiro slope `lambda = 6 + epsilon`.
This rules out the naive strategy of choosing larger and larger good twists and
then simply untwisting their inequalities.  It does not rule out twist methods
that add genuinely new arithmetic cancellation or retain bounded twist size.
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
  · dsimp [H]
    linarith

/-- Nominal logarithmic height scaling of a squarefree quadratic twist. -/
def quadraticTwistHeight (H D : ℝ) : ℝ :=
  transformedHeight H 6 D

/-- Nominal logarithmic conductor scaling of a squarefree quadratic twist at
new good primes. -/
def quadraticTwistConductor (N D : ℝ) : ℝ :=
  transformedConductor N 2 D

/-- Exact distortion coefficient for the nominal quadratic-twist model. -/
theorem quadraticTwist_distortionPenalty (epsilon : ℝ) :
    distortionPenalty (6 + epsilon) 6 2 = 6 + 2 * epsilon := by
  unfold distortionPenalty
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
#print axioms quadraticTwist_distortionPenalty
#print axioms quadraticTwist_penalty_pos
#print axioms quadraticTwist_transformed_bound_does_not_force_uniform_base_bound

end
end FreyAuxiliaryDistortionBarrier
end IUTThreeClosures
