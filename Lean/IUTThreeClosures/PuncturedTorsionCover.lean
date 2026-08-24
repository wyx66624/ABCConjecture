/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The punctured torsion cover underlying the orbicurve square

Let `A` be an additive commutative group and let

`A[n] = {x | n • x = 0}`.

The multiplication-by-`n` map sends the complement of `A[n]` to the
complement of the origin.  In fact one has the exact inverse-image identity

`[n]⁻¹(A \ {0}) = A \ A[n]`.

For an elliptic curve this is the object-level content of the cover

`E \ E[n]  --[n]-->  E \ {0}`

that underlies the type `(1,n-tors)` orbicurve.  The construction is invariant
under the sign involution, and multiplication by `n` commutes with sign.

This file proves the complete group-theoretic core.  The remaining geometric
work is to realize the same construction as a finite étale cover of curves or
orbicurves, retain the stacky sign stabilizers, and identify the corresponding
étale/tempered fundamental-group quotients.
-/

namespace IUTThreeClosures

universe u

namespace PuncturedTorsionCover

variable (A : Type u) [AddCommGroup A]
variable (n : ℕ)

/-- The set of `n`-torsion elements. -/
def torsionSet : Set A :=
  {x | n • x = 0}

/-- The base punctured at the origin. -/
def base : Set A :=
  {x | x ≠ 0}

/-- The source punctured at the complete `n`-torsion subgroup. -/
def source : Set A :=
  {x | x ∉ torsionSet A n}

@[simp]
theorem mem_torsionSet (x : A) :
    x ∈ torsionSet A n ↔ n • x = 0 :=
  Iff.rfl

@[simp]
theorem mem_base (x : A) :
    x ∈ base A ↔ x ≠ 0 :=
  Iff.rfl

@[simp]
theorem mem_source (x : A) :
    x ∈ source A n ↔ n • x ≠ 0 := by
  rfl

/-- The source is exactly the inverse image of the once-punctured base under
multiplication by `n`. -/
theorem source_eq_preimage_base :
    source A n = (fun x : A => n • x) ⁻¹' base A := by
  ext x
  rfl

/-- Multiplication by `n` restricts to the punctured source. -/
def map : source A n → base A :=
  fun x => ⟨n • (x : A), x.property⟩

@[simp]
theorem map_coe (x : source A n) :
    ((map A n x : base A) : A) = n • (x : A) :=
  rfl

/-- The sign involution preserves the full torsion set. -/
theorem neg_mem_torsionSet_iff (x : A) :
    -x ∈ torsionSet A n ↔ x ∈ torsionSet A n := by
  simp [torsionSet]

/-- The sign involution preserves the once-punctured base. -/
theorem neg_mem_base_iff (x : A) :
    -x ∈ base A ↔ x ∈ base A := by
  simp [base]

/-- The sign involution preserves the punctured source. -/
theorem neg_mem_source_iff (x : A) :
    -x ∈ source A n ↔ x ∈ source A n := by
  simp [source, torsionSet]

/-- The sign involution on the punctured source. -/
def sourceNeg : source A n ≃ source A n where
  toFun x := ⟨-(x : A), (neg_mem_source_iff A n x).2 x.property⟩
  invFun x := ⟨-(x : A), (neg_mem_source_iff A n x).2 x.property⟩
  left_inv := by
    intro x
    apply Subtype.ext
    simp
  right_inv := by
    intro x
    apply Subtype.ext
    simp

/-- The sign involution on the once-punctured base. -/
def baseNeg : base A ≃ base A where
  toFun x := ⟨-(x : A), (neg_mem_base_iff A x).2 x.property⟩
  invFun x := ⟨-(x : A), (neg_mem_base_iff A x).2 x.property⟩
  left_inv := by
    intro x
    apply Subtype.ext
    simp
  right_inv := by
    intro x
    apply Subtype.ext
    simp

@[simp]
theorem sourceNeg_coe (x : source A n) :
    ((sourceNeg A n x : source A n) : A) = -(x : A) :=
  rfl

@[simp]
theorem baseNeg_coe (x : base A) :
    ((baseNeg A x : base A) : A) = -(x : A) :=
  rfl

/-- Multiplication by `n` is equivariant for the sign involution. -/
theorem map_sourceNeg (x : source A n) :
    map A n (sourceNeg A n x) = baseNeg A (map A n x) := by
  apply Subtype.ext
  simp [map, sourceNeg, baseNeg]

/-- The sign actions are involutions. -/
theorem sourceNeg_involutive :
    Function.Involutive (sourceNeg A n) := by
  intro x
  apply Subtype.ext
  simp [sourceNeg]

/-- The base sign action is an involution. -/
theorem baseNeg_involutive :
    Function.Involutive (baseNeg A) := by
  intro x
  apply Subtype.ext
  simp [baseNeg]

/-- The source is empty exactly when every element is `n`-torsion.  This
records the extreme case that must be excluded in geometric applications. -/
theorem source_eq_empty_iff :
    source A n = ∅ ↔ ∀ x : A, n • x = 0 := by
  constructor
  · intro h x
    by_contra hx
    have : x ∈ source A n := hx
    rw [h] at this
    exact this
  · intro h
    ext x
    simp [source, torsionSet, h x]

/-- For `n = 1`, the punctured source is the once-punctured base. -/
theorem source_one :
    source A 1 = base A := by
  ext x
  simp [source, torsionSet, base]

/-- For `n = 0`, every element is torsion and the source is empty. -/
theorem source_zero :
    source A 0 = ∅ := by
  ext x
  simp [source, torsionSet]

end PuncturedTorsionCover

end IUTThreeClosures
