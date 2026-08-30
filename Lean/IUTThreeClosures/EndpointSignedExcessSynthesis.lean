/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EndpointBalanceCoefficientTransfer
import IUTThreeClosures.LargeEndpointSignedMultiplicityExcess
import Mathlib.Tactic

/-!
# Coefficient-three transfer plus endpoint signed-excess control

The signed multiplicity excess

`log(max(a,b)*c) - 2 log rad(max(a,b)*c)`

credits exponent-one primes negatively and is therefore a weaker, sharper
remaining target than the unsigned cubeful quotient.  This file proves that a
uniform coefficient-three product estimate only needs signed-excess control on
the endpoint-degenerate locus.
-/

namespace IUTThreeClosures
namespace EndpointSignedExcessSynthesis

open EndpointBalanceCoefficientTransfer
open LargeEndpointSignedMultiplicityExcess

noncomputable section

/-- Endpoint-local signed multiplicity control. -/
def EndpointDegenerateSignedMultiplicityExcessControl : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ H K : ℝ, ∀ P : ABCPoint,
      H ≤ P.height →
      ABCPoint.endpointMinLog P <
          (1 - epsilon / 2) * P.height →
        P.largeEndpointSignedMultiplicityExcess ≤
          2 * epsilon * P.conductor + K

/-- Coefficient three on all large points plus signed-excess control on only
the endpoint-degenerate points implies abc. -/
theorem abc_of_coefficientThreeProduct_and_endpointSignedExcessControl
    (hproduct : UniformCoefficientThreeSublinearProduct)
    (hexcess : EndpointDegenerateSignedMultiplicityExcessControl) :
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
  obtain ⟨He, Ke, hKe⟩ :=
    hexcess delta hdelta_pos
  let Cp : ℝ := (Kp + Real.log 2) / (3 - delta)
  let Ce : ℝ := (Ke + Real.log 2) / 2
  let H : ℝ := max Hp He
  let C : ℝ := max (max Cp Ce) H
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
  have hscaled :
      (1 + delta) * P.conductor ≤
        (1 + epsilon) * P.conductor := by
    apply mul_le_mul_of_nonneg_right _ hconductor
    linarith
  have hCpC : Cp ≤ C := by
    dsimp [C]
    exact (le_max_left Cp Ce).trans (le_max_left _ H)
  have hCeC : Ce ≤ C := by
    dsimp [C]
    exact (le_max_right Cp Ce).trans (le_max_left _ H)
  have hHC : H ≤ C := by
    dsimp [C]
    exact le_max_right _ _
  have hpoint :
      P.height ≤ (1 + epsilon) * P.conductor + C := by
    by_cases hhigh : H ≤ P.height
    · have hHp : Hp ≤ P.height :=
        (le_max_left Hp He).trans hhigh
      have hHe : He ≤ P.height :=
        (le_max_right Hp He).trans hhigh
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
        have hexcessP := hKe P hHe hunbalanced
        have hendpoint :=
          ABCPoint.height_le_of_signedMultiplicityExcess_bound P hexcessP
        dsimp [Ce] at hendpoint
        linarith
    · have hlow : P.height < H := lt_of_not_ge hhigh
      have hnonneg :
          0 ≤ (1 + epsilon) * P.conductor :=
        mul_nonneg (by linarith) hconductor
      linarith
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

#print axioms abc_of_coefficientThreeProduct_and_endpointSignedExcessControl

end
end EndpointSignedExcessSynthesis
end IUTThreeClosures
