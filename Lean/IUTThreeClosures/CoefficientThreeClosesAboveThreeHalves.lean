/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CoefficientThreeForcesShortEndpoint
import Mathlib.Tactic

/-!
# A sublinear coefficient-three product bound closes every exponent above 3/2

The proposition `UniformCoefficientThreeSublinearProduct` gives, for every
positive relative error `eta`, an eventual bound

`log(a*b*c) <= 3*conductor + eta*height + K`.

This file proves that for every fixed `epsilon > 1/2`, there is a uniform
constant `C` with

`height <= (1+epsilon)*conductor + C`.

No balance assumption remains in the conclusion.
-/

namespace IUTThreeClosures

open SymmetricProductCoefficientBarrier
open EndpointBalanceCoefficientTransfer

noncomputable section

namespace ABCPoint

/-- The smaller endpoint has nonnegative logarithm. -/
theorem endpointMinLog_nonneg_for_coefficientThree (P : ABCPoint) :
    0 ≤ P.endpointMinLog := by
  unfold endpointMinLog
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr P.endpointMin_pos.ne')

/-- Every positive abc point has positive height. -/
theorem height_pos_for_coefficientThree (P : ABCPoint) :
    0 < P.height := by
  have hc : 1 < P.c := by
    rw [← P.sum_eq]
    omega
  rw [P.height_eq_log_c]
  apply Real.log_pos
  exact_mod_cast hc

end ABCPoint

namespace CoefficientThreeClosesAboveThreeHalves

/-- Pointwise logarithmic abc statement at one fixed exponent. -/
def ABCPointBoundAt (epsilon : ℝ) : Prop :=
  ∃ C : ℝ, ∀ P : ABCPoint,
    P.height ≤ (1 + epsilon) * P.conductor + C

/-- A uniform sublinear coefficient-three product estimate proves the abc
bound at every fixed `epsilon > 1/2`. -/
theorem abcPointBoundAt_of_uniformCoefficientThreeSublinearProduct
    (hproduct : UniformCoefficientThreeSublinearProduct)
    {epsilon : ℝ} (hhalf : (1 : ℝ) / 2 < epsilon) :
    ABCPointBoundAt epsilon := by
  have hepsilon : 0 < epsilon := by linarith
  have hone : 0 < 1 + epsilon := by linarith
  let eta : ℝ :=
    (2 * epsilon - 1) / (2 * (1 + epsilon))
  have heta : 0 < eta := by
    dsimp [eta]
    positivity
  obtain ⟨H, K, hK⟩ := hproduct eta heta
  let Ccrit : ℝ := (1 + epsilon) * (K + Real.log 2) / 3
  let C : ℝ := max H Ccrit
  refine ⟨C, ?_⟩
  intro P
  by_cases hheight : H ≤ P.height
  · by_contra hnot
    have hviolation :
        (1 + epsilon) * P.conductor + C < P.height :=
      lt_of_not_ge hnot
    have hshort :=
      P.coefficientThree_forces_endpointMin_bound
        hepsilon (hK P hheight) hviolation
    have hlogm := P.endpointMinLog_nonneg_for_coefficientThree
    have hhpos := P.height_pos_for_coefficientThree
    have hCcrit : Ccrit ≤ C := le_max_right _ _
    have hcoeff :
        1 - 2 * epsilon + eta * (1 + epsilon) =
          (1 - 2 * epsilon) / 2 := by
      dsimp [eta]
      field_simp [hone.ne']
      ring
    rw [hcoeff] at hshort
    have hslope : (1 - 2 * epsilon) / 2 < 0 := by
      linarith
    dsimp [Ccrit] at hCcrit
    nlinarith
  · have hlt : P.height < H := lt_of_not_ge hheight
    have hHC : H ≤ C := le_max_left _ _
    have hcond := P.conductor_nonneg
    have hcoef : 0 ≤ 1 + epsilon := hone.le
    nlinarith

#print axioms ABCPoint.endpointMinLog_nonneg_for_coefficientThree
#print axioms ABCPoint.height_pos_for_coefficientThree
#print axioms abcPointBoundAt_of_uniformCoefficientThreeSublinearProduct

end CoefficientThreeClosesAboveThreeHalves
end
end IUTThreeClosures
