/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineResidualParametrization
import Mathlib.Tactic

/-!
# Degeneracy of the affine contact transform at gap one

For `R*A+1=S*B`, the canonical Bezout solution is

`x=-A`, `y=B`, `t=0`.

It reproduces the residuals exactly, while the two contact factors become
`A*B` and `-A*B`.  Hence the shared-support contact transform is tautological
on the unit-gap locus.  This identifies a genuine limitation: the contact
identities alone cannot settle the consecutive-endpoint core of abc.
-/

namespace IUTThreeClosures
namespace UnitGapContactDegeneracy

open AffineResidualParametrization

/-- The unit-gap equation itself supplies the canonical Bezout pair. -/
theorem unit_gap_bezout
    {R S A B : ℤ}
    (hgap : R * A + 1 = S * B) :
    R * (-A) + S * B = 1 := by
  linarith

/-- The affine left residual is unchanged at the canonical unit-gap point. -/
theorem unit_gap_left_residual
    {R S A B : ℤ}
    (hgap : R * A + 1 = S * B) :
    residualA 1 S (-A) 0 = A := by
  unfold residualA
  ring

/-- The affine right residual is unchanged. -/
theorem unit_gap_right_residual
    {R S A B : ℤ}
    (hgap : R * A + 1 = S * B) :
    residualB 1 R B 0 = B := by
  unfold residualB
  ring

/-- The positive left contact becomes the original residual product. -/
theorem unit_gap_left_contact
    {A B : ℤ} :
    0 - 1 * (-A) * B = A * B := by
  ring

/-- The right contact becomes the negative residual product. -/
theorem unit_gap_right_contact
    {A B : ℤ} :
    0 + 1 * (-A) * B = -(A * B) := by
  ring

/-- Complete unit-gap contact package. -/
theorem unit_gap_contact_degeneracy
    {R S A B : ℤ}
    (hgap : R * A + 1 = S * B) :
    R * (-A) + S * B = 1 ∧
      residualA 1 S (-A) 0 = A ∧
      residualB 1 R B 0 = B ∧
      0 - 1 * (-A) * B = A * B ∧
      0 + 1 * (-A) * B = -(A * B) := by
  exact ⟨unit_gap_bezout hgap,
    unit_gap_left_residual hgap,
    unit_gap_right_residual hgap,
    unit_gap_left_contact,
    unit_gap_right_contact⟩

#print axioms unit_gap_bezout
#print axioms unit_gap_left_residual
#print axioms unit_gap_right_residual
#print axioms unit_gap_left_contact
#print axioms unit_gap_right_contact
#print axioms unit_gap_contact_degeneracy

end UnitGapContactDegeneracy
end IUTThreeClosures
