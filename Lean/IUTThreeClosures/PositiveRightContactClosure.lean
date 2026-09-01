/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# The positive right-contact branch is already abc-safe

In the canonical contact system the right scaled identity is

`R*g = B - m*S*y^2`.

If `g` is positive and contains the shared right support `r`, then
`R*r <= B`.  Since the larger summand `R*A` is at least half of `S*B`, this
forces `S*r <= 2*A`, hence `S <= 2*A` as soon as `r >= 1`.  Consequently
`c=S*B <= 2*A*B`, a coefficient-one abc bound even before the gap radical is
used.

Thus every unresolved family must lie in the nonpositive right-contact branch
(or the exact square-collapse boundary).  The theorem below is purely scalar
and assumes no abc estimate.
-/

namespace IUTThreeClosures
namespace PositiveRightContactClosure

/-- Positive right contact plus large-endpoint comparison forces the right
modulus support under twice the opposite residual. -/
theorem right_support_le_two_left_residual
    {R S A B m y g r : ℝ}
    (hR : 0 < R)
    (hS : 0 ≤ S)
    (hm : 0 ≤ m)
    (hr : 0 ≤ r)
    (hrg : r ≤ g)
    (hscaled : R * g = B - m * S * y ^ 2)
    (hlarge : S * B ≤ 2 * (R * A)) :
    S * r ≤ 2 * A := by
  have hterm : 0 ≤ m * S * y ^ 2 := by positivity
  have hRg : R * g ≤ B := by nlinarith
  have hRr : R * r ≤ R * g :=
    mul_le_mul_of_nonneg_left hrg hR.le
  have hmul : S * (R * r) ≤ S * B :=
    mul_le_mul_of_nonneg_left (hRr.trans hRg) hS
  have hcancel : R * (S * r) ≤ R * (2 * A) := by
    calc
      R * (S * r) = S * (R * r) := by ring
      _ ≤ S * B := hmul
      _ ≤ 2 * (R * A) := hlarge
      _ = R * (2 * A) := by ring
  nlinarith [hcancel]

/-- If the shared support is a positive integer-sized quantity, the full right
modulus is at most twice the opposite residual. -/
theorem right_modulus_le_two_left_residual
    {R S A B m y g r : ℝ}
    (hR : 0 < R)
    (hS : 0 ≤ S)
    (hm : 0 ≤ m)
    (hrone : 1 ≤ r)
    (hrg : r ≤ g)
    (hscaled : R * g = B - m * S * y ^ 2)
    (hlarge : S * B ≤ 2 * (R * A)) :
    S ≤ 2 * A := by
  have hsupport := right_support_le_two_left_residual
    hR hS hm (le_trans (by norm_num) hrone) hrg hscaled hlarge
  have hSr : S ≤ S * r := by nlinarith
  exact hSr.trans hsupport

/-- The corresponding endpoint itself has a coefficient-one radical bound. -/
theorem right_endpoint_le_two_residual_product
    {R S A B m y g r : ℝ}
    (hR : 0 < R)
    (hS : 0 ≤ S)
    (hB : 0 ≤ B)
    (hm : 0 ≤ m)
    (hrone : 1 ≤ r)
    (hrg : r ≤ g)
    (hscaled : R * g = B - m * S * y ^ 2)
    (hlarge : S * B ≤ 2 * (R * A)) :
    S * B ≤ 2 * (A * B) := by
  have hSbound := right_modulus_le_two_left_residual
    hR hS hm hrone hrg hscaled hlarge
  have hmul := mul_le_mul_of_nonneg_right hSbound hB
  nlinarith

/-- If `A*B` is already below the full radical budget, the usual strong abc
bound follows immediately. -/
theorem positive_right_contact_strong_abc_ledger
    {R S A B m y g r fullRadical : ℝ}
    (hR : 0 < R)
    (hS : 0 ≤ S)
    (hB : 0 ≤ B)
    (hm : 0 ≤ m)
    (hrone : 1 ≤ r)
    (hrg : r ≤ g)
    (hscaled : R * g = B - m * S * y ^ 2)
    (hlarge : S * B ≤ 2 * (R * A))
    (hresidual : A * B ≤ fullRadical) :
    S * B ≤ 2 * fullRadical := by
  have hendpoint := right_endpoint_le_two_residual_product
    hR hS hB hm hrone hrg hscaled hlarge
  nlinarith

#print axioms right_support_le_two_left_residual
#print axioms right_modulus_le_two_left_residual
#print axioms right_endpoint_le_two_residual_product
#print axioms positive_right_contact_strong_abc_ledger

end PositiveRightContactClosure
end IUTThreeClosures
