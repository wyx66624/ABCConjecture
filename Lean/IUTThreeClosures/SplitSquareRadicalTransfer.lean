/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Radical transfer in the split-square endpoint branch

Suppose the two large endpoints are squares,

`M = x^2`, `c = y^2`, `d = y-x`, `s = y+x`.

For any `epsilon>0`, put

`alpha(epsilon) = 2 / ((1+epsilon)*(2+epsilon))`.

If the `s`-radical is at least `alpha*h` up to a fixed loss, the original ABC
violation transfers to the root triple with exponent `epsilon/2`. If it is
smaller, the canonical square root extracted from `s` has a fixed positive
height slope.
-/

namespace IUTThreeClosures
namespace SplitSquareRadicalTransfer

noncomputable section

/-- General transfer from an original two-height violation to a one-height
root triple when the omitted radical has a specified lower bound. -/
theorem rootConductor_transfer
    {epsilon eta alpha H Rroot Rsum C K : ℝ}
    (hepsilon : -1 < epsilon)
    (heta : -1 < eta)
    (hH : 0 ≤ H)
    (hviolation :
      (1 + epsilon) * (Rroot + Rsum) + C < 2 * H)
    (hsumRadical : alpha * H - K ≤ Rsum)
    (hcoefficient :
      (1 + eta) * (2 - (1 + epsilon) * alpha) ≤
        1 + epsilon) :
    (1 + eta) * Rroot +
        ((1 + eta) / (1 + epsilon)) *
          (C - (1 + epsilon) * K) < H := by
  have hepspos : 0 < 1 + epsilon := by linarith
  have hetapos : 0 < 1 + eta := by linarith
  have hsumScaled :=
    mul_le_mul_of_nonneg_left hsumRadical hepspos.le
  have hbase :
      (1 + epsilon) * Rroot + C - (1 + epsilon) * K <
        (2 - (1 + epsilon) * alpha) * H := by
    nlinarith
  have hscaled := mul_lt_mul_of_pos_left hbase hetapos
  have hcoefficientScaled :=
    mul_le_mul_of_nonneg_right hcoefficient hH
  have hchain :
      (1 + eta) *
          ((1 + epsilon) * Rroot + C - (1 + epsilon) * K) <
        (1 + epsilon) * H := by
    nlinarith
  have hleftIdentity :
      (1 + epsilon) *
          ((1 + eta) * Rroot +
            ((1 + eta) / (1 + epsilon)) *
              (C - (1 + epsilon) * K)) =
        (1 + eta) *
          ((1 + epsilon) * Rroot + C - (1 + epsilon) * K) := by
    field_simp [hepspos.ne']
    ring
  have hmultiplied :
      (1 + epsilon) *
          ((1 + eta) * Rroot +
            ((1 + eta) / (1 + epsilon)) *
              (C - (1 + epsilon) * K)) <
        (1 + epsilon) * H := by
    rw [hleftIdentity]
    exact hchain
  exact (mul_lt_mul_left hepspos).mp hmultiplied

/-- Critical omitted-radical exponent for transfer from `epsilon` to
`epsilon/2`. -/
def halfEpsilonCriticalAlpha (epsilon : ℝ) : ℝ :=
  2 / ((1 + epsilon) * (2 + epsilon))

/-- The critical exponent is positive for positive `epsilon`. -/
theorem halfEpsilonCriticalAlpha_pos
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    0 < halfEpsilonCriticalAlpha epsilon := by
  unfold halfEpsilonCriticalAlpha
  positivity

/-- The critical exponent is strictly below one for positive `epsilon`. -/
theorem halfEpsilonCriticalAlpha_lt_one
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    halfEpsilonCriticalAlpha epsilon < 1 := by
  unfold halfEpsilonCriticalAlpha
  have h1 : 0 < 1 + epsilon := by linarith
  have h2 : 0 < 2 + epsilon := by linarith
  apply (div_lt_iff₀ (mul_pos h1 h2)).2
  nlinarith

/-- Exact coefficient identity behind the `epsilon/2` transfer. -/
theorem halfEpsilonCriticalAlpha_identity
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    (1 + epsilon / 2) *
        (2 - (1 + epsilon) * halfEpsilonCriticalAlpha epsilon) =
      1 + epsilon := by
  unfold halfEpsilonCriticalAlpha
  have h1 : 1 + epsilon ≠ 0 := by linarith
  have h2 : 2 + epsilon ≠ 0 := by linarith
  field_simp [h1, h2]
  ring

/-- Exact transfer to the root triple with exponent `epsilon/2`. -/
theorem halfEpsilon_rootTransfer
    {epsilon H Rroot Rsum C K : ℝ}
    (hepsilon : 0 < epsilon)
    (hH : 0 ≤ H)
    (hviolation :
      (1 + epsilon) * (Rroot + Rsum) + C < 2 * H)
    (hsumRadical :
      halfEpsilonCriticalAlpha epsilon * H - K ≤ Rsum) :
    (1 + epsilon / 2) * Rroot +
        ((1 + epsilon / 2) / (1 + epsilon)) *
          (C - (1 + epsilon) * K) < H := by
  apply rootConductor_transfer
    (epsilon := epsilon) (eta := epsilon / 2)
    (alpha := halfEpsilonCriticalAlpha epsilon)
    (H := H) (Rroot := Rroot) (Rsum := Rsum)
    (C := C) (K := K)
  · linarith
  · linarith
  · exact hH
  · exact hviolation
  · exact hsumRadical
  · rw [halfEpsilonCriticalAlpha_identity hepsilon]

/-- If the omitted sum radical lies below the transfer threshold, then the
canonical square root of the sum endpoint has a positive quantitative gain. -/
theorem squareRoot_gain_of_small_sumRadical
    {epsilon H Rsum Ts q K L : ℝ}
    (hepsilon : 0 < epsilon)
    (hsumSize : H - L ≤ Ts)
    (hsquareBudget : Ts ≤ Rsum + 2 * q)
    (hsmall :
      Rsum < halfEpsilonCriticalAlpha epsilon * H - K) :
    (1 - halfEpsilonCriticalAlpha epsilon) * H + K - L <
      2 * q := by
  nlinarith

/-- Complete scalar dichotomy for the split-square branch: either the root
triple is itself an `epsilon/2` violation, or the omitted sum endpoint contains
a height-scale square part. -/
theorem rootViolation_or_sumSquareGain
    {epsilon H Rroot Rsum Ts q C K L : ℝ}
    (hepsilon : 0 < epsilon)
    (hH : 0 ≤ H)
    (hviolation :
      (1 + epsilon) * (Rroot + Rsum) + C < 2 * H)
    (hsumSize : H - L ≤ Ts)
    (hsquareBudget : Ts ≤ Rsum + 2 * q) :
    ((1 + epsilon / 2) * Rroot +
        ((1 + epsilon / 2) / (1 + epsilon)) *
          (C - (1 + epsilon) * K) < H) ∨
      ((1 - halfEpsilonCriticalAlpha epsilon) * H + K - L <
        2 * q) := by
  by_cases hlarge :
      halfEpsilonCriticalAlpha epsilon * H - K ≤ Rsum
  · exact Or.inl
      (halfEpsilon_rootTransfer hepsilon hH hviolation hlarge)
  · have hsmall :
        Rsum < halfEpsilonCriticalAlpha epsilon * H - K :=
      lt_of_not_ge hlarge
    exact Or.inr
      (squareRoot_gain_of_small_sumRadical
        hepsilon hsumSize hsquareBudget hsmall)

/-- Closed form for the positive square-gain coefficient. -/
theorem one_sub_halfEpsilonCriticalAlpha
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    1 - halfEpsilonCriticalAlpha epsilon =
      epsilon * (3 + epsilon) /
        ((1 + epsilon) * (2 + epsilon)) := by
  unfold halfEpsilonCriticalAlpha
  have h1 : 1 + epsilon ≠ 0 := by linarith
  have h2 : 2 + epsilon ≠ 0 := by linarith
  field_simp [h1, h2]
  ring

/-- The square-gain coefficient is strictly positive. -/
theorem one_sub_halfEpsilonCriticalAlpha_pos
    {epsilon : ℝ} (hepsilon : 0 < epsilon) :
    0 < 1 - halfEpsilonCriticalAlpha epsilon := by
  have hlt := halfEpsilonCriticalAlpha_lt_one hepsilon
  linarith

#print axioms rootConductor_transfer
#print axioms halfEpsilonCriticalAlpha_identity
#print axioms halfEpsilon_rootTransfer
#print axioms squareRoot_gain_of_small_sumRadical
#print axioms rootViolation_or_sumSquareGain
#print axioms one_sub_halfEpsilonCriticalAlpha

end
end SplitSquareRadicalTransfer
end IUTThreeClosures
