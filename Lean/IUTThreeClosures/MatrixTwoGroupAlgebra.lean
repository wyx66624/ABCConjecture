/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SL2FromOneMovedTransvection

/-!
# Monoid and inverse algebra for the explicit `2 × 2` matrix model

The finite-image bridge needs to transport inverses from an actual
`GL₂`-valued representation to the lightweight `MatrixTwo` model.  This file
proves associativity, identity laws, the adjugate inverse formulas, and
uniqueness of an inverse when the determinant is nonzero.
-/

namespace IUTThreeClosures

namespace MatrixTwo

universe u

variable {F : Type u}

instance [CommSemiring F] : Monoid (MatrixTwo F) where
  mul_assoc := by
    intro A B C
    ext <;> simp <;> ring
  one_mul := by
    intro A
    ext <;> simp
  mul_one := by
    intro A
    ext <;> simp

/-- The explicit adjugate is a right inverse when the determinant is nonzero. -/
theorem mul_inverse
    [Field F]
    (A : MatrixTwo F)
    (hdet : det A ≠ 0) :
    A * inverse A = 1 := by
  ext <;>
    simp [inverse, det] <;>
    field_simp [hdet] <;>
    ring

/-- The explicit adjugate is also a left inverse. -/
theorem inverse_mul
    [Field F]
    (A : MatrixTwo F)
    (hdet : det A ≠ 0) :
    inverse A * A = 1 := by
  ext <;>
    simp [inverse, det] <;>
    field_simp [hdet] <;>
    ring

/-- Right inverses are unique for a matrix of nonzero determinant. -/
theorem eq_inverse_of_mul_eq_one
    [Field F]
    {A B : MatrixTwo F}
    (hdet : det A ≠ 0)
    (hAB : A * B = 1) :
    B = inverse A := by
  calc
    B = 1 * B := by simp
    _ = (inverse A * A) * B := by rw [inverse_mul A hdet]
    _ = inverse A * (A * B) := by rw [mul_assoc]
    _ = inverse A := by rw [hAB, mul_one]

/-- Left inverses are unique as well. -/
theorem eq_inverse_of_mul_left_eq_one
    [Field F]
    {A B : MatrixTwo F}
    (hdet : det A ≠ 0)
    (hBA : B * A = 1) :
    B = inverse A := by
  calc
    B = B * 1 := by simp
    _ = B * (A * inverse A) := by rw [mul_inverse A hdet]
    _ = (B * A) * inverse A := by rw [mul_assoc]
    _ = inverse A := by rw [hBA, one_mul]

/-- Determinant is multiplicative in the explicit model. -/
theorem det_mul
    [CommRing F]
    (A B : MatrixTwo F) :
    det (A * B) = det A * det B := by
  simp [det]
  ring

@[simp]
theorem det_one [CommRing F] :
    det (1 : MatrixTwo F) = 1 := by
  simp [det]

end MatrixTwo

end IUTThreeClosures
