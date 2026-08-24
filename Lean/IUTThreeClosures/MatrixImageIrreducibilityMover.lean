/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TransvectionIrreducibleImage

/-!
# Standard irreducibility supplies a matrix moving the transvection line

The transvection criterion uses a basis in which the known transvection is
upper unipotent.  Its fixed line is the first coordinate line `F e₁`.
For a concrete matrix `A`, this line is invariant exactly when the lower-left
entry `A.c` is zero.

We formalize the usual notion that a matrix image has no nonzero proper common
invariant subspace.  Since the first coordinate line is nonzero and proper,
irreducibility rules out invariance of that line.  Hence some image matrix has
nonzero lower-left entry and supplies the mover required by the previous
large-image theorem.
-/

namespace IUTThreeClosures

open TransvectionLargeImage
open TransvectionLargeImage.Matrix2
open TransvectionIrreducibleImage

namespace MatrixImageIrreducibility

universe u

variable {F : Type u} [Field F]

/-- The natural linear action of a concrete matrix on column vectors. -/
def toLinearMap (A : Matrix2 F) : (F × F) →ₗ[F] (F × F) where
  toFun v :=
    (A.a * v.1 + A.b * v.2,
      A.c * v.1 + A.d * v.2)
  map_add' x y := by
    ext <;> simp <;> ring
  map_smul' a x := by
    ext <;> simp <;> ring

@[simp]
theorem toLinearMap_apply
    (A : Matrix2 F) (v : F × F) :
    toLinearMap A v =
      (A.a * v.1 + A.b * v.2,
        A.c * v.1 + A.d * v.2) :=
  rfl

/-- The fixed line of an upper transvection. -/
def upperLine : Submodule F (F × F) where
  carrier := {v | v.2 = 0}
  zero_mem' := rfl
  add_mem' := by
    intro x y hx hy
    simp only [Set.mem_setOf_eq, Prod.fst_add, Prod.snd_add] at hx hy ⊢
    rw [hx, hy, add_zero]
  smul_mem' := by
    intro a x hx
    simp only [Set.mem_setOf_eq, Prod.smul_snd] at hx ⊢
    rw [hx, smul_zero]

@[simp]
theorem mem_upperLine_iff (v : F × F) :
    v ∈ upperLine (F := F) ↔ v.2 = 0 :=
  Iff.rfl

/-- The upper line is nonzero. -/
theorem upperLine_ne_bot :
    upperLine (F := F) ≠ ⊥ := by
  intro h
  have he1 : ((1 : F), 0) ∈ upperLine (F := F) := by
    rfl
  rw [h, Submodule.mem_bot] at he1
  have hfirst := congrArg Prod.fst he1
  simpa using hfirst

/-- The upper line is proper. -/
theorem upperLine_ne_top :
    upperLine (F := F) ≠ ⊤ := by
  intro h
  have he2 : ((0 : F), 1) ∈ upperLine (F := F) := by
    rw [h]
    trivial
  exact one_ne_zero he2

/-- One matrix preserves the upper line exactly when its lower-left entry is
zero. -/
theorem preserves_upperLine_iff_c_eq_zero
    (A : Matrix2 F) :
    (∀ v ∈ upperLine (F := F),
      toLinearMap A v ∈ upperLine (F := F)) ↔
      A.c = 0 := by
  constructor
  · intro h
    have he1 : ((1 : F), 0) ∈ upperLine (F := F) := by
      rfl
    have himage := h ((1 : F), 0) he1
    simpa [toLinearMap] using himage
  · intro hc v hv
    change A.c * v.1 + A.d * v.2 = 0
    rw [hc, (mem_upperLine_iff v).mp hv]
    simp

/-- Common invariance of a subspace under a matrix carrier. -/
def IsInvariant
    (C : Set (Matrix2 F)) (L : Submodule F (F × F)) : Prop :=
  ∀ A ∈ C, ∀ v ∈ L, toLinearMap A v ∈ L

/-- Standard irreducibility: no nonzero proper common invariant submodule. -/
def IsIrreducible
    (C : Set (Matrix2 F)) : Prop :=
  ∀ L : Submodule F (F × F),
    L ≠ ⊥ → L ≠ ⊤ → ¬ IsInvariant C L

/-- If every image matrix has zero lower-left entry, then the upper line is
common invariant. -/
theorem upperLine_invariant_of_all_c_eq_zero
    (C : Set (Matrix2 F))
    (hc : ∀ A ∈ C, A.c = 0) :
    IsInvariant C (upperLine (F := F)) := by
  intro A hA
  exact (preserves_upperLine_iff_c_eq_zero A).2 (hc A hA)

/-- An irreducible image contains a matrix moving the upper line. -/
theorem exists_c_ne_zero_of_irreducible
    (C : Set (Matrix2 F))
    (hirr : IsIrreducible C) :
    ∃ A : Matrix2 F, A ∈ C ∧ A.c ≠ 0 := by
  by_contra hnone
  push_neg at hnone
  have hinv : IsInvariant C (upperLine (F := F)) :=
    upperLine_invariant_of_all_c_eq_zero C hnone
  exact hirr (upperLine (F := F))
    upperLine_ne_bot upperLine_ne_top hinv

/-- Standard irreducibility supplies the mover predicate of an invertible
image carrier. -/
theorem movesUpperFixedLine_of_irreducible
    (C : InvertibleImageCarrier F)
    (hirr : IsIrreducible C.carrier) :
    C.MovesUpperFixedLine := by
  rcases exists_c_ne_zero_of_irreducible C.carrier hirr with
    ⟨g, hg, hgc⟩
  exact ⟨g, hg, hgc⟩

/-- **Standard irreducibility form of the full-`SL₂` criterion.** -/
theorem all_det_one_mem_of_transvection_and_irreducible
    (p : ℕ) [Fact p.Prime]
    (C : InvertibleImageCarrier (ZMod p))
    {u : ZMod p} (hu : u ≠ 0)
    (htransvection : upper u ∈ C.carrier)
    (hirr : IsIrreducible C.carrier) :
    ∀ A : Matrix2 (ZMod p),
      det A = 1 → A ∈ C.carrier := by
  apply C.all_det_one_mem_of_transvection_and_irreducible
    p hu htransvection
  exact movesUpperFixedLine_of_irreducible C hirr

end MatrixImageIrreducibility

end IUTThreeClosures
