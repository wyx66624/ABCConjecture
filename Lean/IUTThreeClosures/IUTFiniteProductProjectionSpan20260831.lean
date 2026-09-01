/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.Pi
import Mathlib.LinearAlgebra.Span.Basic

/-!
# Finite product spans are determined by their projections

The mathematical proof precedes this file in
research/IUT_SELECTED_PLACE_PRODUCT_HULL_2026_08_31.md,
Proposition 2.1.

This module proves only the algebraic central-idempotent argument for a
finite product ring. It does not formalize any IUT reconstruction,
source membership, topology, Haar measure, or volume comparison.
-/

namespace IUTThreeClosures.IUTFiniteProductProjectionSpan20260831

open scoped BigOperators

variable {ι : Type*} {R : ι → Type*} [∀ i, CommRing (R i)]

/-- The span over the i-th ring of the i-th coordinates of a set in a
possibly heterogeneous finite product. -/
def coordinateSpan (S : Set (∀ i, R i)) (i : ι) : Submodule (R i) (R i) :=
  Submodule.span (R i) ((fun x : ∀ i, R i => x i) '' S)

/-- Projection of the span over the product ring is contained in the
corresponding coordinate span. -/
theorem mem_coordinateSpan_of_mem_productSpan
    {S : Set (∀ i, R i)} {x : ∀ i, R i}
    (hx : x ∈ Submodule.span (∀ i, R i) S) (i : ι) :
    x i ∈ coordinateSpan S i := by
  induction hx using Submodule.span_induction with
  | mem y hy =>
      exact Submodule.subset_span ⟨y, hy, rfl⟩
  | zero =>
      exact Submodule.zero_mem _
  | add y z _ _ hy hz =>
      exact Submodule.add_mem _ hy hz
  | smul a y _ hy =>
      exact Submodule.smul_mem _ (a i) hy

/-- A vector whose every coordinate is in the corresponding projected span
belongs to the span over the finite product ring. The proof isolates each
coordinate with the central idempotent Pi.single i 1. -/
theorem mem_productSpan_of_forall_mem_coordinateSpan
    [Finite ι] {S : Set (∀ i, R i)} {x : ∀ i, R i}
    (hx : ∀ i, x i ∈ coordinateSpan S i) :
    x ∈ Submodule.span (∀ i, R i) S := by
  classical
  letI := Fintype.ofFinite ι
  have hsingle : ∀ i, Pi.single i (x i) ∈ Submodule.span (∀ i, R i) S := by
    intro i
    refine Submodule.span_induction (R := R i) (M := R i)
        (p := fun y _ => Pi.single i y ∈ Submodule.span (∀ i, R i) S)
        (s := (fun z : ∀ i, R i => z i) '' S)
        ?_ ?_ ?_ ?_ (hx i)
    · intro y hy
      obtain ⟨z, hz, rfl⟩ := hy
      have hzspan : z ∈ Submodule.span (∀ i, R i) S :=
        Submodule.subset_span hz
      have hmul :=
        (Submodule.span (∀ i, R i) S).smul_mem (Pi.single i 1) hzspan
      have heq : Pi.single i (z i) = Pi.single i 1 * z := by
        ext k
        by_cases hki : k = i
        · subst k
          simp
        · simp [hki]
      rw [heq]
      exact hmul
    · have heq : Pi.single i (0 : R i) = (0 : ∀ i, R i) := by
        ext k
        by_cases hki : k = i
        · subst k
          simp
        · simp [hki]
      rw [heq]
      exact Submodule.zero_mem _
    · intro y z _ _ hy hz
      have heq : Pi.single i (y + z) =
          (Pi.single i y : ∀ i, R i) + Pi.single i z := by
        ext k
        by_cases hki : k = i
        · subst k
          simp
        · simp [hki]
      rw [heq]
      exact Submodule.add_mem (Submodule.span (∀ i, R i) S) hy hz
    · intro a y _ hy
      have hmul :=
        (Submodule.span (∀ i, R i) S).smul_mem (Pi.single i a) hy
      change Pi.single i (a * y) ∈ Submodule.span (∀ i, R i) S
      have heq :
          Pi.single i (a * y) =
            (Pi.single i a : ∀ i, R i) * Pi.single i y := by
        ext k
        by_cases hki : k = i
        · subst k
          simp
        · simp [hki]
      rw [heq]
      exact hmul
  have hsum :
      (∑ i, Pi.single i (x i)) ∈ Submodule.span (∀ i, R i) S :=
    Submodule.sum_mem _ fun i _ => hsingle i
  convert hsum using 1
  funext i
  simp

/-- Exact finite-product span criterion. This is the formal algebraic content
behind the use of central idempotents after taking the product-order hull. -/
theorem mem_productSpan_iff
    [Finite ι] {S : Set (∀ i, R i)} {x : ∀ i, R i} :
    x ∈ Submodule.span (∀ i, R i) S ↔
      ∀ i, x i ∈ coordinateSpan S i :=
  ⟨fun hx i => mem_coordinateSpan_of_mem_productSpan hx i,
    mem_productSpan_of_forall_mem_coordinateSpan⟩

/-- If every prescribed coordinate submodule lies in the projected span,
then every vector in their finite product lies in the span over the
product ring. -/
theorem mem_productSpan_of_mem_coordinateProduct
    [Finite ι] (S : Set (∀ i, R i))
    (P : ∀ i, Submodule (R i) (R i))
    (hP : ∀ i, P i ≤ coordinateSpan S i)
    {x : ∀ i, R i} (hx : ∀ i, x i ∈ P i) :
    x ∈ Submodule.span (∀ i, R i) S := by
  apply mem_productSpan_of_forall_mem_coordinateSpan
  intro i
  exact hP i (hx i)

/-- A finite weighted sum is monotone when every weight is nonnegative.
This is the abstract ordered-algebra step used after the independent local
coordinate bounds have been established. It carries no interpretation as a
Haar volume or an IUT normalization. -/
theorem finite_weighted_sum_mono
    {κ K : Type*} [Fintype κ] [Ring K] [LinearOrder K]
    [IsStrictOrderedRing K]
    (weight lower upper : κ → K)
    (hweight : ∀ k, 0 ≤ weight k)
    (hlocal : ∀ k, lower k ≤ upper k) :
    (∑ k, weight k * lower k) ≤ ∑ k, weight k * upper k := by
  apply Finset.sum_le_sum
  intro k _
  exact mul_le_mul_of_nonneg_left (hlocal k) (hweight k)

#print axioms mem_productSpan_iff
#print axioms mem_productSpan_of_mem_coordinateProduct
#print axioms finite_weighted_sum_mono

end IUTThreeClosures.IUTFiniteProductProjectionSpan20260831
