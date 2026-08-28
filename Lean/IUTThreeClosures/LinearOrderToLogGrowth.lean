/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LogarithmicFamilySublinear

/-!
# From a linear local-order bound to logarithmic height growth

The Euclidean auxiliary-prime selector has logarithmic size in a positive local
order `N`.  The Frey calculation bounds that local order linearly in the abc
height.  This file supplies the elementary analytic bridge.

If

`0 <= H`, `0 <= N`, and `N <= A*H + D`

with `A,D >= 0`, then

`1 + N <= (A + D + 1) * (1 + H)`

and hence

`log(1+N) <= log(A+D+1) + log(1+H)`.

Therefore any source term affine in `log(1+N)` is affine logarithmic in the
height and is uniformly sublinear by the preceding module.
-/

namespace IUTThreeClosures

universe u

/-- Elementary product majorant for a linearly bounded nonnegative quantity. -/
theorem one_add_le_product_one_add_of_linear_bound
    {H N A D : ℝ}
    (hH : 0 ≤ H)
    (hN : 0 ≤ N)
    (hA : 0 ≤ A)
    (hD : 0 ≤ D)
    (hbound : N ≤ A * H + D) :
    1 + N ≤ (A + D + 1) * (1 + H) := by
  have hAH : 0 ≤ A * H := mul_nonneg hA hH
  nlinarith

/-- Logarithmic form of the linear-order bound. -/
theorem log_one_add_le_log_constant_add_log_height
    {H N A D : ℝ}
    (hH : 0 ≤ H)
    (hN : 0 ≤ N)
    (hA : 0 ≤ A)
    (hD : 0 ≤ D)
    (hbound : N ≤ A * H + D) :
    Real.log (1 + N) ≤
      Real.log (A + D + 1) + Real.log (1 + H) := by
  have hleft : 0 < 1 + N := by linarith
  have hconstant : 0 < A + D + 1 := by linarith
  have hheight : 0 < 1 + H := by linarith
  have hright : 0 < (A + D + 1) * (1 + H) :=
    mul_pos hconstant hheight
  have hle := one_add_le_product_one_add_of_linear_bound
    hH hN hA hD hbound
  have hlog :
      Real.log (1 + N) ≤
        Real.log ((A + D + 1) * (1 + H)) :=
    Real.strictMonoOn_log.monotoneOn hleft hright hle
  rw [Real.log_mul (ne_of_gt hconstant) (ne_of_gt hheight)] at hlog
  exact hlog

/-- A family of local orders linearly bounded in height yields an affine
logarithmic family bound for `log(1+N)`. -/
def logarithmicOrderFamilyBound
    {X : Type u}
    (height order : X → ℝ)
    (A D : ℝ)
    (hheight : ∀ x, 0 ≤ height x)
    (horder : ∀ x, 0 ≤ order x)
    (hA : 0 ≤ A)
    (hD : 0 ≤ D)
    (hbound : ∀ x, order x ≤ A * height x + D) :
    AffineLogarithmicFamilyBound X height
      (fun x => Real.log (1 + order x)) where
  coefficient := 1
  coefficient_nonneg := by norm_num
  constant := Real.log (A + D + 1)
  height_nonneg := hheight
  source_le := by
    intro x
    have h := log_one_add_le_log_constant_add_log_height
      (hheight x) (horder x) hA hD (hbound x)
    linarith

/-- An affine function of `log(1+N)` inherits an affine logarithmic height
bound from a linear order estimate. -/
def affineLogOrderFamilyBound
    {X : Type u}
    (height order : X → ℝ)
    (A D C E : ℝ)
    (hheight : ∀ x, 0 ≤ height x)
    (horder : ∀ x, 0 ≤ order x)
    (hA : 0 ≤ A)
    (hD : 0 ≤ D)
    (hC : 0 ≤ C)
    (hbound : ∀ x, order x ≤ A * height x + D) :
    AffineLogarithmicFamilyBound X height
      (fun x => C * Real.log (1 + order x) + E) := by
  let L := logarithmicOrderFamilyBound
    height order A D hheight horder hA hD hbound
  let LC := L.nonnegSMul C hC
  exact {
    coefficient := LC.coefficient
    coefficient_nonneg := LC.coefficient_nonneg
    constant := LC.constant + E
    height_nonneg := LC.height_nonneg
    source_le := by
      intro x
      have hx := LC.source_le x
      exact add_le_add_right hx E
  }

end IUTThreeClosures
