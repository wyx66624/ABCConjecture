/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# The exact one-sided coefficient ledger

If `h = s + b`, then

`h <= (1+epsilon)*(m+a+b)+C`

is equivalent to

`s <= (1+epsilon)*(m+a)+epsilon*b+C`.

This elementary identity records the critical coefficient allocation for the
canonical decomposition `c=S*B`.  It prevents a full extra copy of the right
residual radical from being hidden in an intermediate estimate.
-/

namespace IUTThreeClosures
namespace OneSidedContactCoefficientLedger

/-- Exact equivalence between the abc height budget and the right-modulus
exponent-height budget. -/
theorem height_bound_iff_right_exponent_bound
    {height rightExponent gapSupport leftSupport rightSupport
      epsilon C : ℝ}
    (hdecomp : height = rightExponent + rightSupport) :
    height ≤
        (1 + epsilon) *
          (gapSupport + leftSupport + rightSupport) + C ↔
      rightExponent ≤
        (1 + epsilon) * (gapSupport + leftSupport) +
          epsilon * rightSupport + C := by
  constructor <;> intro h
  · rw [hdecomp] at h
    nlinarith
  · rw [hdecomp]
    nlinarith

/-- Forward closure in the form used after a contact-depth estimate. -/
theorem height_bound_of_right_exponent_bound
    {height rightExponent gapSupport leftSupport rightSupport
      epsilon C : ℝ}
    (hdecomp : height = rightExponent + rightSupport)
    (hbound :
      rightExponent ≤
        (1 + epsilon) * (gapSupport + leftSupport) +
          epsilon * rightSupport + C) :
    height ≤
      (1 + epsilon) *
        (gapSupport + leftSupport + rightSupport) + C :=
  (height_bound_iff_right_exponent_bound hdecomp).2 hbound

/-- Charging a full copy of the right support before reconstructing the height
produces a coefficient-two loss at epsilon zero. -/
theorem full_right_support_charge_has_coefficient_loss
    {rightExponent gapSupport leftSupport rightSupport C : ℝ}
    (hbound :
      rightExponent ≤ gapSupport + leftSupport + rightSupport + C) :
    rightExponent + rightSupport ≤
      gapSupport + leftSupport + 2 * rightSupport + C := by
  linarith

#print axioms height_bound_iff_right_exponent_bound
#print axioms height_bound_of_right_exponent_bound
#print axioms full_right_support_charge_has_coefficient_loss

end OneSidedContactCoefficientLedger
end IUTThreeClosures
