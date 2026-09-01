/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SquarePartExponentWeight
import Mathlib.Tactic

/-!
# Height violations force simultaneous square-root scale

This file isolates the scalar step needed after applying the canonical
square-root extraction theorem separately to the two large coprime endpoints
of an abc triple.

If `h > (1+epsilon) R + C`, an endpoint radical contribution `r <= R`, and a
canonical square-root weight `q` satisfies `h-r <= 2q`, then

`(epsilon*h+C)/(2*(1+epsilon)) < q`.

For the larger summand `M=max(a,b)` one only knows `log M >= h-log 2`; the same
argument loses exactly `log 2 / 2`.  No abc statement is assumed here: the
hypothesized height violation is used only to derive the structural
consequence that any counterexample would have to satisfy.
-/

namespace IUTThreeClosures
namespace HeightViolationSquareRootScale

noncomputable section

/-- Product-form endpoint estimate, avoiding any hidden division by the
positive factor `2*(1+epsilon)`. -/
theorem endpoint_squareRootScale_product
    {epsilon C h R r q : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradical : r ≤ R)
    (hroot : h - r ≤ 2 * q) :
    epsilon * h + C < 2 * (1 + epsilon) * q := by
  have hden : 0 < 1 + epsilon := by linarith
  have hrviol : (1 + epsilon) * r + C < h := by
    have hscaled := mul_le_mul_of_nonneg_left hradical (le_of_lt hden)
    nlinarith
  have hrootScaled :=
    mul_le_mul_of_nonneg_left hroot (le_of_lt hden)
  nlinarith

/-- Normalized form of the endpoint estimate. -/
theorem endpoint_squareRootScale
    {epsilon C h R r q : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradical : r ≤ R)
    (hroot : h - r ≤ 2 * q) :
    (epsilon * h + C) / (2 * (1 + epsilon)) < q := by
  have hprod := endpoint_squareRootScale_product
    hepsilon hviolation hradical hroot
  have hden : 0 < 2 * (1 + epsilon) := by positivity
  apply (div_lt_iff₀ hden).2
  nlinarith

/-- Product-form estimate when the endpoint logarithm is known only up to an
additive loss `L`, as for `log(max(a,b)) >= log c - log 2`. -/
theorem endpoint_squareRootScale_with_loss_product
    {epsilon C h R r q L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradical : r ≤ R)
    (hroot : h - L - r ≤ 2 * q) :
    epsilon * h + C <
      2 * (1 + epsilon) * (q + L / 2) := by
  have hden : 0 < 1 + epsilon := by linarith
  have hrviol : (1 + epsilon) * r + C < h := by
    have hscaled := mul_le_mul_of_nonneg_left hradical (le_of_lt hden)
    nlinarith
  have hroot' : h - r ≤ 2 * q + L := by linarith
  have hrootScaled :=
    mul_le_mul_of_nonneg_left hroot' (le_of_lt hden)
  nlinarith

/-- Normalized endpoint estimate with additive logarithmic loss. -/
theorem endpoint_squareRootScale_with_loss
    {epsilon C h R r q L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradical : r ≤ R)
    (hroot : h - L - r ≤ 2 * q) :
    (epsilon * h + C) / (2 * (1 + epsilon)) - L / 2 < q := by
  have hprod := endpoint_squareRootScale_with_loss_product
    hepsilon hviolation hradical hroot
  have hden : 0 < 2 * (1 + epsilon) := by positivity
  have hnormalized :
      (epsilon * h + C) / (2 * (1 + epsilon)) < q + L / 2 := by
    apply (div_lt_iff₀ hden).2
    nlinarith
  linarith

/-- Simultaneous consequence for two endpoint profiles: the first may incur an
additive logarithmic loss, while the second has the full source height. -/
theorem simultaneous_endpoint_squareRootScale
    {epsilon C h R r₁ r₂ q₁ q₂ L : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * R + C < h)
    (hradical₁ : r₁ ≤ R)
    (hradical₂ : r₂ ≤ R)
    (hroot₁ : h - L - r₁ ≤ 2 * q₁)
    (hroot₂ : h - r₂ ≤ 2 * q₂) :
    (epsilon * h + C) / (2 * (1 + epsilon)) - L / 2 < q₁ ∧
      (epsilon * h + C) / (2 * (1 + epsilon)) < q₂ := by
  constructor
  · exact endpoint_squareRootScale_with_loss
      hepsilon hviolation hradical₁ hroot₁
  · exact endpoint_squareRootScale
      hepsilon hviolation hradical₂ hroot₂

#print axioms endpoint_squareRootScale_product
#print axioms endpoint_squareRootScale
#print axioms endpoint_squareRootScale_with_loss_product
#print axioms endpoint_squareRootScale_with_loss
#print axioms simultaneous_endpoint_squareRootScale

end
end HeightViolationSquareRootScale
end IUTThreeClosures
