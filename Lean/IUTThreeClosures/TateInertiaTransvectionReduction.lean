/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SL2IrreducibleTransvectionCriterion

/-!
# From a Tate inertia character to a nonzero transvection

For a split multiplicative Tate curve at a place of residue characteristic
unequal to `ell`, the mod-`ell` inertia action has upper-unipotent form.  Its
upper-right entry is the product of

* the Tate/discriminant order, reduced modulo `ell`, and
* a surjective tame inertia character to `ZMod ell`.

The local analytic/Kummer theorem is the assertion that the genuine inertia
representation has this form.  Once that source theorem is available, the
remaining algebra is elementary: if the Tate order is nonzero modulo `ell`,
the scaled tame character is surjective, hence the image contains the standard
transvection `U(1)`.

This module proves that algebraic reduction independently of local-field
formalization.
-/

namespace IUTThreeClosures

namespace MatrixTwo

universe u

variable {I : Type u}
variable {ell : ℕ} [Fact ell.Prime]

/-- The upper-unipotent inertia matrix attached to an additive character. -/
def inertiaMatrix (c : I → ZMod ell) (σ : I) :
    MatrixTwo (ZMod ell) :=
  upper (c σ)

/-- Scaling a surjective prime-field-valued character by a nonzero scalar
preserves surjectivity. -/
theorem surjective_mul_character
    (tame : I → ZMod ell)
    (htame : Function.Surjective tame)
    (order : ZMod ell)
    (horder : order ≠ 0) :
    Function.Surjective (fun σ => order * tame σ) := by
  intro y
  rcases htame (y / order) with ⟨σ, hσ⟩
  refine ⟨σ, ?_⟩
  rw [hσ]
  exact mul_div_cancel_right₀ y horder

/-- A nonzero Tate order and a surjective tame character produce the standard
nontrivial transvection. -/
theorem exists_inertiaMatrix_eq_upper_one
    (tame : I → ZMod ell)
    (htame : Function.Surjective tame)
    (order : ZMod ell)
    (horder : order ≠ 0) :
    ∃ σ : I,
      inertiaMatrix (fun τ => order * tame τ) σ = upper 1 := by
  rcases surjective_mul_character tame htame order horder 1 with
    ⟨σ, hσ⟩
  exact ⟨σ, by simpa [inertiaMatrix, hσ]⟩

/-- The set of inertia matrices contains a nonzero transvection. -/
theorem upper_one_mem_inertiaImage
    (tame : I → ZMod ell)
    (htame : Function.Surjective tame)
    (order : ZMod ell)
    (horder : order ≠ 0) :
    upper 1 ∈ Set.range
      (inertiaMatrix (fun τ => order * tame τ)) := by
  rcases exists_inertiaMatrix_eq_upper_one
      tame htame order horder with ⟨σ, hσ⟩
  exact ⟨σ, hσ⟩

/-- Source-facing package for the genuine Tate-inertia theorem.  The analytic
input is isolated as equality of the actual representation matrix with the
scaled tame-character formula. -/
structure TateInertiaMatrixData
    (ActualMatrix : I → MatrixTwo (ZMod ell)) where
  tameCharacter : I → ZMod ell
  tame_surjective : Function.Surjective tameCharacter
  tateOrderModEll : ZMod ell
  tateOrder_ne_zero : tateOrderModEll ≠ 0
  actual_formula :
    ∀ σ : I,
      ActualMatrix σ =
        inertiaMatrix
          (fun τ => tateOrderModEll * tameCharacter τ) σ

namespace TateInertiaMatrixData

/-- The genuine inertia image contains the standard transvection once the
Tate formula and nondivisibility are supplied. -/
theorem upper_one_mem_actualImage
    (ActualMatrix : I → MatrixTwo (ZMod ell))
    (D : TateInertiaMatrixData ActualMatrix) :
    upper 1 ∈ Set.range ActualMatrix := by
  rcases exists_inertiaMatrix_eq_upper_one
      D.tameCharacter D.tame_surjective
      D.tateOrderModEll D.tateOrder_ne_zero with
    ⟨σ, hσ⟩
  refine ⟨σ, ?_⟩
  rw [D.actual_formula]
  exact hσ

end TateInertiaMatrixData

end MatrixTwo

end IUTThreeClosures
