/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.Procession

/-!
# Ind1 procession automorphisms preserve normalized averages

The Ind1 ambiguity in IUT III, Theorem 3.11 is induced by automorphisms of the
procession of prime strips.  At the numerical level this is a finite
reindexing, not a new volume error.

This module proves the precise finite-combinatorial statement.  Reindexing the
labels of one capsule by an equivalence preserves its cardinality-normalized
average.  Reindexing all capsules by an equivalence, together with label
equivalences in every capsule, preserves the procession-normalized average.
Consequently the Ind1 contribution to the component/procession comparison is
exactly zero once the geometric automorphism is known to transport the local
component value equivariantly.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

/-- Reindexing a finite capsule preserves its normalized average. -/
theorem capsuleAverage_equiv
    {α : Type u} {β : Type v}
    [Fintype α] [Fintype β]
    (e : α ≃ β) (f : β → ℝ) :
    (∑ a : α, f (e a)) / (Fintype.card α : ℝ) =
      (∑ b : β, f b) / (Fintype.card β : ℝ) := by
  rw [e.sum_comp]
  congr 1
  exact_mod_cast Fintype.card_congr e

/-- A combinatorial automorphism of a procession: capsules are reindexed and
each source label type is identified with the corresponding target label
type.  Compatibility with the inclusion maps is irrelevant for the average
calculation and remains part of the actual geometric procession
isomorphism. -/
structure ProcessionReindexing
    {ι : Type u} (P : Iut.Procession ι) where
  capsulePerm : Equiv.Perm (Fin P.length)
  labelEquiv : ∀ i,
    (P.capsule i).LabelType ≃
      (P.capsule (capsulePerm i)).LabelType

namespace ProcessionReindexing

variable {ι : Type u} {P : Iut.Procession ι}

/-- The normalized value of one capsule. -/
noncomputable def capsuleAverage
    (value : ∀ i, (P.capsule i).LabelType → ℝ)
    (i : Fin P.length) : ℝ :=
  (∑ j, value i j) / (Fintype.card (P.capsule i).LabelType : ℝ)

/-- Transporting a component value along a label equivalence preserves the
capsule average. -/
theorem capsuleAverage_transport
    (A : ProcessionReindexing P)
    (value : ∀ i, (P.capsule i).LabelType → ℝ)
    (i : Fin P.length) :
    (∑ j : (P.capsule i).LabelType,
        value (A.capsulePerm i) (A.labelEquiv i j)) /
          (Fintype.card (P.capsule i).LabelType : ℝ) =
      A.capsuleAverage value (A.capsulePerm i) := by
  simpa [capsuleAverage] using
    capsuleAverage_equiv (A.labelEquiv i)
      (value (A.capsulePerm i))

/-- Reindexing all capsules and all of their labels preserves the sum of
normalized capsule values. -/
theorem sum_capsuleAverage_transport
    (A : ProcessionReindexing P)
    (value : ∀ i, (P.capsule i).LabelType → ℝ) :
    (∑ i : Fin P.length,
      ((∑ j : (P.capsule i).LabelType,
          value (A.capsulePerm i) (A.labelEquiv i j)) /
        (Fintype.card (P.capsule i).LabelType : ℝ))) =
      ∑ i : Fin P.length, A.capsuleAverage value i := by
  calc
    _ = ∑ i : Fin P.length,
        A.capsuleAverage value (A.capsulePerm i) := by
      apply Finset.sum_congr rfl
      intro i hi
      exact A.capsuleAverage_transport value i
    _ = ∑ i : Fin P.length, A.capsuleAverage value i :=
      A.capsulePerm.sum_comp _

/-- Hence the procession-normalized average is exactly invariant under Ind1
reindexing. -/
theorem processionAverage_transport
    (A : ProcessionReindexing P)
    (value : ∀ i, (P.capsule i).LabelType → ℝ) :
    ((∑ i : Fin P.length,
      ((∑ j : (P.capsule i).LabelType,
          value (A.capsulePerm i) (A.labelEquiv i j)) /
        (Fintype.card (P.capsule i).LabelType : ℝ))) /
        (P.length : ℝ)) =
      ((∑ i : Fin P.length, A.capsuleAverage value i) /
        (P.length : ℝ)) := by
  rw [A.sum_capsuleAverage_transport value]

end ProcessionReindexing

end IUTThreeClosures
