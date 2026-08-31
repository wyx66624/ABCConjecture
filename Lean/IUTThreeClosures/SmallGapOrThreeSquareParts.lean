/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.HeightViolationSquareRootScale
import Mathlib.Tactic

/-!
# Small additive endpoint or three simultaneous square parts

For an abc-height violation, the two large endpoints always have
height-scale canonical square roots.  This file adds the smaller additive
endpoint to the analysis.

Let `h_m` be its logarithmic height, `r_m` its radical contribution, and `q_m`
the logarithmic weight of its canonical square root.  Then either

`2*(1+epsilon)*h_m < (2+epsilon)*h`,

so the additive gap is quantitatively smaller than the source height, or

`epsilon*h + 2*C < 4*(1+epsilon)*q_m`,

so the smaller endpoint also contains a height-scale square part.  Thus every
hypothetical counterexample lies in a precise short-gap branch or a
three-square-part branch.
-/

namespace IUTThreeClosures
namespace SmallGapOrThreeSquareParts

noncomputable section

/-- Quantitative dichotomy for the smaller endpoint. -/
theorem small_endpoint_or_squareRootScale
    {epsilon C h R hₘ rₘ qₘ : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradical : rₘ ≤ R)
    (hroot : hₘ - rₘ ≤ 2 * qₘ) :
    2 * (1 + epsilon) * hₘ < (2 + epsilon) * h ∨
      epsilon * h + 2 * C < 4 * (1 + epsilon) * qₘ := by
  by_cases hsmall :
      2 * (1 + epsilon) * hₘ < (2 + epsilon) * h
  · exact Or.inl hsmall
  · right
    have hden : 0 < 1 + epsilon := by linarith
    have hlarge :
        (2 + epsilon) * h ≤ 2 * (1 + epsilon) * hₘ :=
      le_of_not_gt hsmall
    have hrviol : (1 + epsilon) * rₘ + C < h := by
      have hscaled :=
        mul_le_mul_of_nonneg_left hradical (le_of_lt hden)
      nlinarith
    have hrootScaled :=
      mul_le_mul_of_nonneg_left hroot
        (show 0 ≤ 2 * (1 + epsilon) by positivity)
    nlinarith

/-- Normalized square-root lower bound in the non-small-gap branch. -/
theorem small_endpoint_or_normalized_squareRootScale
    {epsilon C h R hₘ rₘ qₘ : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradical : rₘ ≤ R)
    (hroot : hₘ - rₘ ≤ 2 * qₘ) :
    2 * (1 + epsilon) * hₘ < (2 + epsilon) * h ∨
      (epsilon * h + 2 * C) / (4 * (1 + epsilon)) < qₘ := by
  rcases small_endpoint_or_squareRootScale
      hepsilon hviolation hradical hroot with hsmall | hlarge
  · exact Or.inl hsmall
  · right
    have hden : 0 < 4 * (1 + epsilon) := by positivity
    apply (div_lt_iff₀ hden).2
    nlinarith

/-- Combined three-endpoint structural alternative.  The two large endpoints
have the square-root lower bounds from `HeightViolationSquareRootScale`; if the
small endpoint is not in the short-gap range, it has its own quantitative
square-root lower bound as well. -/
theorem shortGap_or_three_endpoint_squareRootScale
    {epsilon C h R hₘ rₘ r₁ r₂ qₘ q₁ q₂ L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradicalₘ : rₘ ≤ R)
    (hradical₁ : r₁ ≤ R)
    (hradical₂ : r₂ ≤ R)
    (hrootₘ : hₘ - rₘ ≤ 2 * qₘ)
    (hroot₁ : h - L - r₁ ≤ 2 * q₁)
    (hroot₂ : h - r₂ ≤ 2 * q₂) :
    2 * (1 + epsilon) * hₘ < (2 + epsilon) * h ∨
      ((epsilon * h + 2 * C) / (4 * (1 + epsilon)) < qₘ ∧
        (epsilon * h + C) / (2 * (1 + epsilon)) - L / 2 < q₁ ∧
        (epsilon * h + C) / (2 * (1 + epsilon)) < q₂) := by
  rcases small_endpoint_or_normalized_squareRootScale
      hepsilon hviolation hradicalₘ hrootₘ with hsmall | hqₘ
  · exact Or.inl hsmall
  · right
    have hlarge :=
      HeightViolationSquareRootScale.simultaneous_endpoint_squareRootScale
        hepsilon hviolation hradical₁ hradical₂ hroot₁ hroot₂
    exact ⟨hqₘ, hlarge.1, hlarge.2⟩

#print axioms small_endpoint_or_squareRootScale
#print axioms small_endpoint_or_normalized_squareRootScale
#print axioms shortGap_or_three_endpoint_squareRootScale

end
end SmallGapOrThreeSquareParts
end IUTThreeClosures
