/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MatrixTwoGroupAlgebra
import IUTThreeClosures.MatrixTwoEquivFinTwo
import IUTThreeClosures.SL2IrreducibleTransvectionCriterion

/-!
# The explicit image of a `GL₂`-valued representation

This file connects an actual group representation

`rho : G ->* GL (Fin 2) (ZMod p)`

to the concrete `MatrixTwo` image used by the elementary transvection
criterion.  The carrier is the range of the underlying matrices in the fixed
basis.  It is closed under multiplication and explicit adjugate inverses, and
all its matrices have nonzero determinant.

Thus the remaining arithmetic source theorems can be stated directly for the
actual representation:

* an inertia element has upper-unipotent matrix;
* irreducibility means that some image matrix moves the upper fixed line.
-/

namespace IUTThreeClosures

namespace MatrixTwo

universe u

variable {G : Type u} [Group G]
variable {p : ℕ} [Fact p.Prime]

/-- Underlying explicit matrix of one representation value. -/
def representationMatrix
    (rho : G →* GL (Fin 2) (ZMod p))
    (g : G) : MatrixTwo (ZMod p) :=
  ofFinTwoMatrix (rho g : Matrix (Fin 2) (Fin 2) (ZMod p))

/-- The representation matrix of a product is the product of the representation
matrices. -/
theorem representationMatrix_mul
    (rho : G →* GL (Fin 2) (ZMod p))
    (g h : G) :
    representationMatrix rho (g * h) =
      representationMatrix rho g * representationMatrix rho h := by
  rw [representationMatrix, representationMatrix, representationMatrix,
    map_mul]
  exact ofFinTwoMatrix_mul _ _

/-- The representation matrix of the identity is the explicit identity. -/
theorem representationMatrix_one
    (rho : G →* GL (Fin 2) (ZMod p)) :
    representationMatrix rho 1 = upper 0 := by
  unfold representationMatrix upper ofFinTwoMatrix
  simp

/-- Every representation matrix has nonzero determinant. -/
theorem representationMatrix_det_ne_zero
    (rho : G →* GL (Fin 2) (ZMod p))
    (g : G) :
    det (representationMatrix rho g) ≠ 0 := by
  intro hzero
  have hmul := representationMatrix_mul rho g g⁻¹
  rw [mul_inv_cancel, representationMatrix_one] at hmul
  have hdet := congrArg det hmul
  rw [det_mul, hzero, zero_mul, det_upper] at hdet
  exact zero_ne_one hdet

/-- Representation matrices carry group inverses to the explicit adjugate
inverse. -/
theorem representationMatrix_inv
    (rho : G →* GL (Fin 2) (ZMod p))
    (g : G) :
    representationMatrix rho g⁻¹ =
      inverse (representationMatrix rho g) := by
  apply eq_inverse_of_mul_eq_one
    (representationMatrix_det_ne_zero rho g)
  rw [← representationMatrix_mul, mul_inv_cancel,
    representationMatrix_one]
  rfl

/-- Concrete image carrier of the representation. -/
def representationImage
    (rho : G →* GL (Fin 2) (ZMod p)) :
    Set (MatrixTwo (ZMod p)) :=
  Set.range (representationMatrix rho)

/-- The concrete image is a `PrimeFieldMatrixImage`. -/
def primeFieldMatrixImageOfRepresentation
    (rho : G →* GL (Fin 2) (ZMod p)) :
    PrimeFieldMatrixImage p where
  carrier := representationImage rho
  mul_mem := by
    rintro A B ⟨g, rfl⟩ ⟨h, rfl⟩
    exact ⟨g * h, representationMatrix_mul rho g h⟩
  one_mem :=
    ⟨1, representationMatrix_one rho⟩
  inverse_mem := by
    rintro A ⟨g, rfl⟩ hdet
    exact ⟨g⁻¹, representationMatrix_inv rho g⟩
  det_ne_zero := by
    rintro A ⟨g, rfl⟩
    exact representationMatrix_det_ne_zero rho g

@[simp]
theorem carrier_primeFieldMatrixImageOfRepresentation
    (rho : G →* GL (Fin 2) (ZMod p)) :
    (primeFieldMatrixImageOfRepresentation rho).carrier =
      representationImage rho :=
  rfl

/-- An actual upper transvection in the representation image becomes the
transvection field required by the elementary criterion. -/
theorem transvection_mem_image_iff
    (rho : G →* GL (Fin 2) (ZMod p))
    (s : ZMod p) :
    upper s ∈
        (primeFieldMatrixImageOfRepresentation rho).carrier ↔
      ∃ g : G, representationMatrix rho g = upper s := by
  rfl

/-- Basis-level irreducibility is exactly the assertion that some
representation matrix moves the upper coordinate line. -/
theorem upperLineIrreducible_iff
    (rho : G →* GL (Fin 2) (ZMod p)) :
    (primeFieldMatrixImageOfRepresentation rho).UpperLineIrreducible ↔
      ∃ g : G,
        (representationMatrix rho g).a21 ≠ 0 := by
  constructor
  · intro h
    rcases (primeFieldMatrixImageOfRepresentation rho).exists_movingMatrix h with
      ⟨A, ⟨g, rfl⟩, hmove⟩
    exact ⟨g, hmove⟩
  · rintro ⟨g, hg⟩ htriangular
    exact hg <| htriangular (representationMatrix rho g) ⟨g, rfl⟩

end MatrixTwo

end IUTThreeClosures
