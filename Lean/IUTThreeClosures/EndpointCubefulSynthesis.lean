/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EndpointBalanceCoefficientTransfer
import IUTThreeClosures.LargeEndpointCubefulExcess
import Mathlib.Tactic

/-!
# Synthesis of coefficient-three balance transfer and cubeful excess

A coefficient-three symmetric-product estimate closes the balanced locus.
The cubeful-excess ledger closes the complementary endpoint locus once its
excess is subcritical relative to the conductor.  This file combines the two
statements with their exact quantifiers and constants.

No coefficient-three product estimate and no endpoint excess estimate is
asserted in this file; both difficult inputs remain explicit hypotheses.
-/

namespace IUTThreeClosures
namespace EndpointCubefulSynthesis

open EndpointBalanceCoefficientTransfer
open LargeEndpointCubefulExcess

noncomputable section

/-- Pointwise joint obstruction: under a coefficient-three product estimate,
every violation of its balanced abc bound is simultaneously endpoint-degenerate
and has quantitatively large cubeful excess. -/
theorem endpointDegenerate_and_cubefulExcessLarge_of_violation
    (P : ABCPoint) {epsilon K : ℝ}
    (hepsilon : 0 < epsilon)
    (hepsilon_one : epsilon ≤ 1)
    (hproduct :
      SymmetricProductCoefficientBarrier.ABCPoint.symmetricProductLog P ≤
        3 * P.conductor + (epsilon / 2) * P.height + K)
    (hviolation :
      (1 + epsilon) * P.conductor +
          (K + Real.log 2) / (3 - epsilon) < P.height) :
    ABCPoint.endpointMinLog P <
        (1 - epsilon / 2) * P.height ∧
      2 * epsilon * P.conductor +
          2 * ((K + Real.log 2) / (3 - epsilon)) - Real.log 2 <
        Real.log (P.largeEndpointCubefulExcess : ℝ) := by
  constructor
  · exact ABCPoint.endpoint_unbalanced_of_coefficient_three_violation
      P hepsilon hepsilon_one hproduct hviolation
  · exact ABCPoint.cubefulExcess_large_of_height_violation
      P hviolation

/-- The genuinely endpoint-local arithmetic target left after a uniform
coefficient-three product estimate. -/
def EndpointDegenerateCubefulExcessControl : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ H K : ℝ, ∀ P : ABCPoint,
      H ≤ P.height →
      ABCPoint.endpointMinLog P <
          (1 - epsilon / 2) * P.height →
        Real.log (P.largeEndpointCubefulExcess : ℝ) ≤
          2 * epsilon * P.conductor + K

/-- A uniform coefficient-three product estimate together with subcritical
cubeful-excess control only on the endpoint-degenerate locus proves abc. -/
theorem abc_of_coefficientThreeProduct_and_endpointCubefulExcessControl
    (hproduct : UniformCoefficientThreeSublinearProduct)
    (hexcess : EndpointDegenerateCubefulExcessControl) :
    ABCConjecture := by
  intro epsilon hepsilon
  let delta : ℝ := min epsilon 1
  have hdelta_pos : 0 < delta := by
    dsimp [delta]
    exact lt_min hepsilon (by norm_num)
  have hdelta_one : delta ≤ 1 := by
    dsimp [delta]
    exact min_le_right _ _
  have hdelta_epsilon : delta ≤ epsilon := by
    dsimp [delta]
    exact min_le_left _ _
  obtain ⟨Hp, Kp, hKp⟩ :=
    hproduct (delta / 2) (by positivity)
  obtain ⟨Hq, Kq, hKq⟩ :=
    hexcess delta hdelta_pos
  let Cp : ℝ := (Kp + Real.log 2) / (3 - delta)
  let Cq : ℝ := (Kq + Real.log 2) / 2
  let H : ℝ := max Hp Hq
  let C : ℝ := max (max Cp Cq) H
  refine ⟨C, ?_⟩
  intro a b c ha hb hc hsum hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcoprime }
  have hconductor : 0 ≤ P.conductor := ABCPoint.conductor_nonneg P
  have hcoefficient : 1 + delta ≤ 1 + epsilon := by
    linarith
  have hscaled :
      (1 + delta) * P.conductor ≤
        (1 + epsilon) * P.conductor :=
    mul_le_mul_of_nonneg_right hcoefficient hconductor
  have hCpC : Cp ≤ C := by
    dsimp [C]
    exact (le_max_left Cp Cq).trans (le_max_left _ H)
  have hCqC : Cq ≤ C := by
    dsimp [C]
    exact (le_max_right Cp Cq).trans (le_max_left _ H)
  have hHC : H ≤ C := by
    dsimp [C]
    exact le_max_right _ _
  have hpoint :
      P.height ≤ (1 + epsilon) * P.conductor + C := by
    by_cases hhigh : H ≤ P.height
    · have hHp : Hp ≤ P.height := by
        exact (le_max_left Hp Hq).trans hhigh
      have hHq : Hq ≤ P.height := by
        exact (le_max_right Hp Hq).trans hhigh
      by_cases hbalance :
          (1 - delta / 2) * P.height ≤
            ABCPoint.endpointMinLog P
      · have hbalanced :=
          ABCPoint.height_le_one_add_epsilon_of_coefficient_three_balanced
            P hdelta_pos hdelta_one hbalance (hKp P hHp)
        dsimp [Cp] at hbalanced
        linarith
      · have hunbalanced :
          ABCPoint.endpointMinLog P <
            (1 - delta / 2) * P.height :=
          lt_of_not_ge hbalance
        have hexcessP := hKq P hHq hunbalanced
        have hendpoint :=
          ABCPoint.height_le_of_cubefulExcess_bound P hexcessP
        dsimp [Cq] at hendpoint
        linarith
    · have hlow : P.height < H := lt_of_not_ge hhigh
      have hnonneg :
          0 ≤ (1 + epsilon) * P.conductor := by
        exact mul_nonneg (by linarith) hconductor
      linarith
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

#print axioms endpointDegenerate_and_cubefulExcessLarge_of_violation
#print axioms abc_of_coefficientThreeProduct_and_endpointCubefulExcessControl

end
end EndpointCubefulSynthesis
end IUTThreeClosures
