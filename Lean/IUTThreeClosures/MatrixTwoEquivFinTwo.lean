/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SL2FromTransvectionAndIrreducibility
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

/-!
# Identification with Mathlib's `2 × 2` matrices

The explicit unipotent calculations were carried out in the lightweight type
`MatrixTwo`.  This module identifies it with Mathlib matrices indexed by
`Fin 2` and proves that the identification preserves multiplication and the
determinant.  It is therefore possible to transport the image criterion to an
actual mod-`ell` Galois representation valued in `GL₂(ZMod ell)`.
-/

namespace IUTThreeClosures

namespace MatrixTwo

universe u

variable {F : Type u}

/-- Convert a Mathlib `2 × 2` matrix to the explicit four-entry model. -/
def ofFinTwoMatrix (M : Matrix (Fin 2) (Fin 2) F) : MatrixTwo F :=
  { a11 := M 0 0
    a12 := M 0 1
    a21 := M 1 0
    a22 := M 1 1 }

/-- Convert the explicit model to a Mathlib matrix. -/
def toFinTwoMatrix [Zero F] (A : MatrixTwo F) :
    Matrix (Fin 2) (Fin 2) F :=
  fun i j =>
    if i = 0 then
      if j = 0 then A.a11 else A.a12
    else
      if j = 0 then A.a21 else A.a22

@[simp]
theorem toFinTwoMatrix_apply_zero_zero [Zero F] (A : MatrixTwo F) :
    A.toFinTwoMatrix 0 0 = A.a11 := by
  simp [toFinTwoMatrix]

@[simp]
theorem toFinTwoMatrix_apply_zero_one [Zero F] (A : MatrixTwo F) :
    A.toFinTwoMatrix 0 1 = A.a12 := by
  simp [toFinTwoMatrix]

@[simp]
theorem toFinTwoMatrix_apply_one_zero [Zero F] (A : MatrixTwo F) :
    A.toFinTwoMatrix 1 0 = A.a21 := by
  simp [toFinTwoMatrix]

@[simp]
theorem toFinTwoMatrix_apply_one_one [Zero F] (A : MatrixTwo F) :
    A.toFinTwoMatrix 1 1 = A.a22 := by
  simp [toFinTwoMatrix]

@[simp]
theorem ofFinTwoMatrix_toFinTwoMatrix [Zero F] (A : MatrixTwo F) :
    ofFinTwoMatrix A.toFinTwoMatrix = A := by
  ext <;> simp [ofFinTwoMatrix]

@[simp]
theorem toFinTwoMatrix_ofFinTwoMatrix [Zero F]
    (M : Matrix (Fin 2) (Fin 2) F) :
    (ofFinTwoMatrix M).toFinTwoMatrix = M := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [ofFinTwoMatrix]

/-- The explicit model is equivalent to Mathlib's `Fin 2` matrix type. -/
def finTwoMatrixEquiv [Zero F] :
    MatrixTwo F ≃ Matrix (Fin 2) (Fin 2) F where
  toFun := toFinTwoMatrix
  invFun := ofFinTwoMatrix
  left_inv := ofFinTwoMatrix_toFinTwoMatrix
  right_inv := toFinTwoMatrix_ofFinTwoMatrix

/-- Multiplication is preserved by the coordinate identification. -/
theorem ofFinTwoMatrix_mul
    [CommSemiring F]
    (A B : Matrix (Fin 2) (Fin 2) F) :
    ofFinTwoMatrix (A * B) =
      ofFinTwoMatrix A * ofFinTwoMatrix B := by
  ext <;>
    simp [ofFinTwoMatrix, Matrix.mul_apply, Fin.sum_univ_two] <;>
    ring

/-- The coordinate identification preserves the determinant. -/
theorem det_ofFinTwoMatrix
    [CommRing F]
    (A : Matrix (Fin 2) (Fin 2) F) :
    det (ofFinTwoMatrix A) = Matrix.det A := by
  simp [det, ofFinTwoMatrix, Matrix.det_fin_two]

/-- Standard Mathlib upper unipotent matrix. -/
def upperFinTwo [Zero F] [One F] (t : F) :
    Matrix (Fin 2) (Fin 2) F :=
  (upper t).toFinTwoMatrix

/-- Standard Mathlib lower unipotent matrix. -/
def lowerFinTwo [Zero F] [One F] (t : F) :
    Matrix (Fin 2) (Fin 2) F :=
  (lower t).toFinTwoMatrix

@[simp]
theorem ofFinTwoMatrix_upperFinTwo [Zero F] [One F] (t : F) :
    ofFinTwoMatrix (upperFinTwo t) = upper t := by
  simp [upperFinTwo]

@[simp]
theorem ofFinTwoMatrix_lowerFinTwo [Zero F] [One F] (t : F) :
    ofFinTwoMatrix (lowerFinTwo t) = lower t := by
  simp [lowerFinTwo]

end MatrixTwo

end IUTThreeClosures
