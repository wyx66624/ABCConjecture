/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SL2ElementaryGeneration

/-!
# From opposite transvections to containment of all determinant-one matrices

This module turns the constructive elementary-generation theorem into the
exact closure statement used by a Galois image.  If a set of two-by-two
matrices

* contains every upper transvection;
* contains every lower transvection; and
* is closed under matrix multiplication,

then it contains every determinant-one matrix.

For an actual representation image, multiplication closure is automatic.  The
remaining source-facing theorem is therefore only the production of both
opposite transvection families from Tate inertia and irreducibility.
-/

namespace IUTThreeClosures

universe u

namespace SL2ElementaryGeneration
namespace Mat2

variable {F : Type u} [Field F]

/-- Every syntactically elementary-generated matrix belongs to any
multiplicatively closed set containing the two elementary root families. -/
theorem ElementaryGenerated.mem_of_closed
    {S : Set (Mat2 F)}
    (hupper : ∀ x : F, upper x ∈ S)
    (hlower : ∀ x : F, lower x ∈ S)
    (hmul : ∀ {A B : Mat2 F}, A ∈ S → B ∈ S → mul A B ∈ S)
    {A : Mat2 F}
    (hA : ElementaryGenerated A) :
    A ∈ S := by
  induction hA with
  | upper x => exact hupper x
  | lower x => exact hlower x
  | mul hA hB ihA ihB => exact hmul ihA ihB

/-- Opposite elementary root subgroups force containment of every
`determinant = 1` matrix. -/
theorem detOne_mem_of_contains_transvections
    {S : Set (Mat2 F)}
    (hupper : ∀ x : F, upper x ∈ S)
    (hlower : ∀ x : F, lower x ∈ S)
    (hmul : ∀ {A B : Mat2 F}, A ∈ S → B ∈ S → mul A B ∈ S)
    (A : Mat2 F)
    (hdet : det A = 1) :
    A ∈ S := by
  exact (elementaryGenerated_of_det_one A hdet).mem_of_closed
    hupper hlower hmul

/-- Set-theoretic form of the same containment theorem. -/
theorem detOne_set_subset_of_contains_transvections
    {S : Set (Mat2 F)}
    (hupper : ∀ x : F, upper x ∈ S)
    (hlower : ∀ x : F, lower x ∈ S)
    (hmul : ∀ {A B : Mat2 F}, A ∈ S → B ∈ S → mul A B ∈ S) :
    {A : Mat2 F | det A = 1} ⊆ S := by
  intro A hA
  exact detOne_mem_of_contains_transvections
    hupper hlower hmul A hA

end Mat2
end SL2ElementaryGeneration

end IUTThreeClosures
