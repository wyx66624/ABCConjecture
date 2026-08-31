/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Descent in the split-square endpoint branch

When the two large endpoints are exact squares,

`M = x^2`, `c = y^2`,

then the small endpoint factors as `m = (y-x)(y+x)`. The short-gap threshold
descends from the endpoint height `2*log y` to the root gap `log(y-x)`.
-/

namespace IUTThreeClosures
namespace SplitSquareEndpointDescent

noncomputable section

/-- Difference-of-squares identity underlying the split-square branch. -/
theorem squareDifference_add_square
    (x y : ℤ) :
    (y - x) * (y + x) + x ^ 2 = y ^ 2 := by
  ring

/-- The factor `y-x` times `y` is bounded by the full difference of squares. -/
theorem rootGap_mul_root_le_squareDifference
    {x y : ℝ} (hx : 0 ≤ x) (hxy : x ≤ y) :
    (y - x) * y ≤ (y - x) * (y + x) := by
  have hgap : 0 ≤ y - x := by linarith
  have hy : 0 ≤ y := by linarith
  have hy_le : y ≤ y + x := by linarith
  exact mul_le_mul_of_nonneg_left hy_le hgap

/-- Scalar logarithmic descent from a short square gap to the gap between the
square roots. -/
theorem shortGap_descends_to_rootGap
    {epsilon Tm Td hy : ℝ}
    (hepsilon : -1 < epsilon)
    (hfactor : Td + hy ≤ Tm)
    (hshort : (1 + epsilon) * Tm < (2 + epsilon) * hy) :
    (1 + epsilon) * Td < hy := by
  have hone : 0 < 1 + epsilon := by linarith
  have hscaled := mul_le_mul_of_nonneg_left hfactor hone.le
  nlinarith

/-- Version written with the original square-endpoint height `h = 2*hy`. -/
theorem original_shortGap_descends_to_rootGap
    {epsilon h Tm Td hy : ℝ}
    (hepsilon : -1 < epsilon)
    (hheight : h = 2 * hy)
    (hfactor : Td + hy ≤ Tm)
    (hshort : 2 * (1 + epsilon) * Tm < (2 + epsilon) * h) :
    (1 + epsilon) * Td < hy := by
  apply shortGap_descends_to_rootGap hepsilon hfactor
  rw [hheight] at hshort
  nlinarith

/-- If the logarithmic root gap is nonnegative, the descended estimate is a
strict power saving relative to the root height. -/
theorem rootGap_powerSaving_positive
    {epsilon hy Td : ℝ}
    (hepsilon : 0 < epsilon)
    (hTd : 0 ≤ Td)
    (hdescent : (1 + epsilon) * Td < hy) :
    Td < hy := by
  have hprod : 0 ≤ epsilon * Td :=
    mul_nonneg hepsilon.le hTd
  nlinarith

#print axioms squareDifference_add_square
#print axioms rootGap_mul_root_le_squareDifference
#print axioms shortGap_descends_to_rootGap
#print axioms original_shortGap_descends_to_rootGap
#print axioms rootGap_powerSaving_positive

end
end SplitSquareEndpointDescent
end IUTThreeClosures
