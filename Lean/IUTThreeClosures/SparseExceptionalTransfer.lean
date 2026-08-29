/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Sparse exceptional-set transfer

An ``almost all'' theorem on a large ambient set does not automatically give a
point on a much sparser arithmetic subfamily.  The correct finite statement is
relative: the number of exceptional points *inside the sparse family* must be
strictly smaller than the family itself.

This module isolates that combinatorial step.  It is intended for two current
abc routes:

* short-interval smooth-number theorems whose centres must be specialized to
  prime powers;
* almost-all Szpiro estimates whose parameter boxes must be specialized to the
  Frey locus.

No analytic number theory or Szpiro estimate is assumed here.
-/

namespace IUTThreeClosures
namespace SparseExceptionalTransfer

/-- If an exceptional set is smaller than the set of candidate centres, one
candidate centre lies outside it. -/
theorem exists_center_outside_exceptional
    {α : Type*} [DecidableEq α]
    (centers exceptional : Finset α)
    (hcard : exceptional.card < centers.card) :
    ∃ x ∈ centers, x ∉ exceptional := by
  by_contra h
  have hsubset : centers ⊆ exceptional := by
    intro x hx
    by_contra hxexceptional
    exact h ⟨x, hx, hxexceptional⟩
  have hle : centers.card ≤ exceptional.card :=
    Finset.card_le_card hsubset
  omega

/-- Only exceptional points lying in the sparse family matter. -/
theorem exists_center_outside_exceptional_of_inter_card_lt
    {α : Type*} [DecidableEq α]
    (centers exceptional : Finset α)
    (hcard : (exceptional ∩ centers).card < centers.card) :
    ∃ x ∈ centers, x ∉ exceptional := by
  obtain ⟨x, hxcenter, hxoutside⟩ :=
    exists_center_outside_exceptional centers (exceptional ∩ centers) hcard
  refine ⟨x, hxcenter, ?_⟩
  intro hxexceptional
  exact hxoutside (by simp [hxexceptional, hxcenter])

/-- If every failure belongs to an exceptional set, a relative cardinality
bound supplies a good sparse centre. -/
theorem exists_good_center_of_exceptional_cover
    {α : Type*} [DecidableEq α]
    (centers exceptional : Finset α)
    (Good : α → Prop)
    (hcover : ∀ x ∈ centers, ¬ Good x → x ∈ exceptional)
    (hcard : (exceptional ∩ centers).card < centers.card) :
    ∃ x ∈ centers, Good x := by
  classical
  obtain ⟨x, hxcenter, hxoutside⟩ :=
    exists_center_outside_exceptional_of_inter_card_lt
      centers exceptional hcard
  refine ⟨x, hxcenter, ?_⟩
  by_contra hbad
  exact hxoutside (hcover x hxcenter hbad)

/-- A proper sparse family may itself be the whole exceptional set.  Thus a
mere ambient-density statement, even with a strict exceptional-set saving,
does not force a hit on the sparse family. -/
theorem sparse_centers_can_be_entirely_exceptional
    {α : Type*} [DecidableEq α]
    (centers ambient : Finset α)
    (hsubset : centers ⊆ ambient)
    (hproper : centers.card < ambient.card) :
    ∃ exceptional : Finset α,
      exceptional ⊆ ambient ∧
      exceptional.card < ambient.card ∧
      centers ⊆ exceptional := by
  refine ⟨centers, hsubset, hproper, ?_⟩
  intro x hx
  exact hx

/-- Fibre-amplification form: if a source point has more candidate images than
exceptional images, at least one image is good. -/
theorem exists_good_image_of_exceptional_fiber_bound
    {α : Type*} [DecidableEq α]
    (fiber exceptional : Finset α)
    (Good : α → Prop)
    (hcover : ∀ x ∈ fiber, ¬ Good x → x ∈ exceptional)
    (hcard : (exceptional ∩ fiber).card < fiber.card) :
    ∃ x ∈ fiber, Good x :=
  exists_good_center_of_exceptional_cover
    fiber exceptional Good hcover hcard

#print axioms exists_center_outside_exceptional
#print axioms exists_center_outside_exceptional_of_inter_card_lt
#print axioms exists_good_center_of_exceptional_cover
#print axioms sparse_centers_can_be_entirely_exceptional
#print axioms exists_good_image_of_exceptional_fiber_bound

end SparseExceptionalTransfer
end IUTThreeClosures
