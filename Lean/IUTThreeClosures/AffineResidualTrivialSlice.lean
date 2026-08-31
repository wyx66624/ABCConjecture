/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineResidualDiscriminant
import Mathlib.Tactic

/-!
# The trivial-modulus slice recovers every additive pair

The affine residual family is a genuine classification, but a uniform radical
theorem for all of its parameters would not be a simplification of abc.  At

`R=S=1`, `x=1`, `y=0`,

we have

`A_t=t-m`, `B_t=t`, `M_t=t-m`, `C_t=t`.

Thus every integral pair with difference `m` occurs in this single slice, and
the residual product is exactly `t*(t-m)`.  Any future positive argument must
therefore use the nontrivial large-modulus information extracted from a
hypothetical abc violation; the unrestricted affine-product radical target is
just the original additive problem in new notation.
-/

namespace IUTThreeClosures
namespace AffineResidualTrivialSlice

open AffineResidualParametrization
open AffineResidualDiscriminant

/-- The chosen coefficients form a Bezout identity. -/
theorem trivial_bezout : (1 : ℤ) * 1 + 1 * 0 = 1 := by norm_num

@[simp]
theorem residualA_trivial (m t : ℤ) :
    residualA m 1 1 t = t - m := by
  unfold residualA
  ring

@[simp]
theorem residualB_trivial (m t : ℤ) :
    residualB m 1 0 t = t := by
  unfold residualB
  ring

@[simp]
theorem leftEndpoint_trivial (m t : ℤ) :
    leftEndpoint 1 m 1 1 t = t - m := by
  unfold leftEndpoint
  rw [residualA_trivial]
  ring

@[simp]
theorem rightEndpoint_trivial (m t : ℤ) :
    rightEndpoint 1 m 1 0 t = t := by
  unfold rightEndpoint
  rw [residualB_trivial]
  ring

@[simp]
theorem residualProduct_trivial (m t : ℤ) :
    residualProduct m 1 1 1 0 t = (t - m) * t := by
  unfold residualProduct
  rw [residualA_trivial, residualB_trivial]

@[simp]
theorem residualDiscriminantLinear_trivial (m t : ℤ) :
    residualDiscriminantLinear m 1 1 1 0 t = 2 * t - m := by
  unfold residualDiscriminantLinear
  rw [residualA_trivial, residualB_trivial]
  ring

/-- The general discriminant relation specializes to the elementary identity
for two integers of difference `m`. -/
theorem trivial_discriminant_identity (m t : ℤ) :
    (2 * t - m) ^ 2 - 4 * ((t - m) * t) = m ^ 2 := by
  ring

/-- Every integral pair of prescribed difference occurs in the trivial slice. -/
theorem every_gap_pair_is_trivial_slice
    {M C m : ℤ} (hgap : C - M = m) :
    M = residualA m 1 1 C ∧
      C = residualB m 1 0 C := by
  constructor
  · rw [residualA_trivial]
    linarith
  · rw [residualB_trivial]

/-- Equivalent endpoint form of the same completeness statement. -/
theorem every_gap_pair_is_trivial_endpoint_slice
    {M C m : ℤ} (hgap : C - M = m) :
    M = leftEndpoint 1 m 1 1 C ∧
      C = rightEndpoint 1 m 1 0 C := by
  constructor
  · rw [leftEndpoint_trivial]
    linarith
  · rw [rightEndpoint_trivial]

/-- The product in an arbitrary additive pair is exactly the residual product
of the trivial slice. -/
theorem gap_pair_product_eq_trivial_residualProduct
    {M C m : ℤ} (hgap : C - M = m) :
    M * C = residualProduct m 1 1 1 0 C := by
  rw [residualProduct_trivial]
  have hM : M = C - m := by linarith
  rw [hM]

#print axioms trivial_bezout
#print axioms residualA_trivial
#print axioms residualB_trivial
#print axioms residualProduct_trivial
#print axioms residualDiscriminantLinear_trivial
#print axioms trivial_discriminant_identity
#print axioms every_gap_pair_is_trivial_slice
#print axioms every_gap_pair_is_trivial_endpoint_slice
#print axioms gap_pair_product_eq_trivial_residualProduct

end AffineResidualTrivialSlice
end IUTThreeClosures
