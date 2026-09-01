/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.RingTheory.TensorProduct.Basic
import Mathlib.LinearAlgebra.LinearIndependent.Basic

/-!
# A tensor point inside a hull over its full coefficient ring

The mathematical proofs precede this file in
`research/IUT_REACHABILITY_CONTINUATION_2026_08_30.md`.

The local holomorphic hull described in Joshi III, section 9.10.7, is a module
over the product of the integer rings of the field factors of a finite-etale
tensor algebra. It is generally larger than ordinary convex closure.

This module formalizes the algebraic core: a tensor of units is a unit; a
submodule containing a tensor point contains its multiples by its coefficient
ring; and this includes the integer span of the scaled pure integral tensors.
No field decomposition, integral-closure identification, Kummer transport,
Haar-volume formula, actual IUT output, or ABC conclusion is assumed as an axiom
or claimed to be formalized by these declarations.
-/

namespace IUTThreeClosures.IUTReachabilityContinuation20260830

open scoped TensorProduct

section PrincipalHull

variable {T : Type*} [CommRing T]

/-- The singleton hull over a specified coefficient subring consists exactly
of scalar multiples by that subring. -/
theorem mem_principalHull_iff (O : Subring T) (t x : T) :
    x ∈ Submodule.span O ({t} : Set T) ↔ ∃ b : O, (b : T) * t = x := by
  rw [Submodule.mem_span_singleton]
  rfl

/-- A hull containing a point contains that point times its whole coefficient
ring. This uses closure under `O`, not merely closure under integer scalars. -/
theorem coefficient_multiple_mem (O : Subring T) (H : Submodule O T)
    {t : T} (ht : t ∈ H) (b : O) : (b : T) * t ∈ H := by
  exact H.smul_mem b ht

/-- The point's principal hull is included in every `O`-module containing it. -/
theorem principalHull_le (O : Subring T) (H : Submodule O T)
    {t : T} (ht : t ∈ H) : Submodule.span O ({t} : Set T) ≤ H := by
  exact (Submodule.span_singleton_le_iff_mem t H).mpr ht

/-- Multiplication by an ambient unit does not collapse the coefficient
ring, even when that element is not a unit of the coefficient ring itself. -/
theorem coefficient_multiple_injective (O : Subring T) {t : T} (ht : IsUnit t) :
    Function.Injective (fun b : O => (b : T) * t) := by
  intro b c h
  apply Subtype.ext
  exact ht.mul_right_cancel h

end PrincipalHull

section TensorUnits

variable {K A B : Type*} [CommRing K] [CommRing A] [CommRing B]
variable [Algebra K A] [Algebra K B]

/-- The inverse of a tensor of units is the tensor of their inverses. -/
def tensorUnit (a : Aˣ) (b : Bˣ) : (A ⊗[K] B)ˣ where
  val := (a : A) ⊗ₜ[K] (b : B)
  inv := ((a⁻¹ : Aˣ) : A) ⊗ₜ[K] ((b⁻¹ : Bˣ) : B)
  val_inv := by simp [Algebra.TensorProduct.one_def]
  inv_val := by simp [Algebra.TensorProduct.one_def]

/-- A pure tensor of units is a unit in the actual tensor algebra. -/
theorem isUnit_tmul {a : A} {b : B} (ha : IsUnit a) (hb : IsUnit b) :
    IsUnit (a ⊗ₜ[K] b) := by
  rcases ha with ⟨a, rfl⟩
  rcases hb with ⟨b, rfl⟩
  exact (tensorUnit a b).isUnit

/-- The inverse formula can also be checked directly without constructing a
unit object. It can be iterated for a finite tensor packet. -/
theorem tmul_mul_inverse {a ai : A} {b bi : B}
    (ha : a * ai = 1) (hb : b * bi = 1) :
    (a ⊗ₜ[K] b) * (ai ⊗ₜ[K] bi) = 1 := by
  rw [Algebra.TensorProduct.tmul_mul_tmul, ha, hb]
  rfl

/-- Invertible multiplication preserves linear independence; thus a full
integral basis stays independent when multiplied by the tensor point. -/
theorem linearIndependent_tmul_mul {ι : Type*}
    (v : ι → A ⊗[K] B) (hv : LinearIndependent K v)
    {a : A} {b : B} (ha : IsUnit a) (hb : IsUnit b) :
    LinearIndependent K (fun i => (a ⊗ₜ[K] b) * v i) := by
  have ht : IsUnit (a ⊗ₜ[K] b) := isUnit_tmul ha hb
  exact hv.map' (LinearMap.mulLeft K (a ⊗ₜ[K] b))
    (LinearMap.ker_eq_bot_of_injective fun _ _ h => ht.mul_left_cancel h)

end TensorUnits

section IntegralGenerators

variable {K A B : Type*} [CommRing K] [CommRing A] [CommRing B]
variable [Algebra K A] [Algebra K B]

/-- The additive span of all pure integral generators. The coefficient
subrings contain all of their integral scalars, so no claim that they are
`K`-subalgebras is made. In the local application they are valuation rings. -/
def integralTensorSpan (OA : Subring A) (OB : Subring B) :
    Submodule ℤ (A ⊗[K] B) :=
  Submodule.span ℤ (Set.range fun xy : OA × OB =>
    (xy.1 : A) ⊗ₜ[K] (xy.2 : B))

/-- The same pure generators after multiplication in each factor. -/
def scaledIntegralTensorSpan (OA : Subring A) (OB : Subring B) (a : A) (b : B) :
    Submodule ℤ (A ⊗[K] B) :=
  Submodule.span ℤ (Set.range fun xy : OA × OB =>
    (a * (xy.1 : A)) ⊗ₜ[K] (b * (xy.2 : B)))

/-- The scaled tensor span is exactly the image of the original span under
multiplication by the single tensor point. -/
theorem scaledIntegralTensorSpan_eq_map
    (OA : Subring A) (OB : Subring B) (a : A) (b : B) :
    scaledIntegralTensorSpan OA OB a b =
      (integralTensorSpan OA OB).map (LinearMap.mulLeft ℤ (a ⊗ₜ[K] b)) := by
  simp only [scaledIntegralTensorSpan, integralTensorSpan, Submodule.map_span,
    ← Set.range_comp, Function.comp_def, LinearMap.mulLeft_apply,
    Algebra.TensorProduct.tmul_mul_tmul]

/-- Integral pure tensors belong to the target coefficient subring when
the two integral factor embeddings do. -/
theorem integral_tmul_mem (OA : Subring A) (OB : Subring B)
    (O : Subring (A ⊗[K] B))
    (hA : ∀ x : OA, (x : A) ⊗ₜ[K] (1 : B) ∈ O)
    (hB : ∀ y : OB, (1 : A) ⊗ₜ[K] (y : B) ∈ O)
    (x : OA) (y : OB) : (x : A) ⊗ₜ[K] (y : B) ∈ O := by
  simpa only [Algebra.TensorProduct.tmul_mul_tmul, mul_one, one_mul]
    using O.mul_mem (hA x) (hB y)

/-- A module over the entire coefficient ring contains every scaled pure
integral tensor as soon as it contains the one tensor point. -/
theorem scaled_integral_tmul_mem (OA : Subring A) (OB : Subring B)
    (O : Subring (A ⊗[K] B)) (H : Submodule O (A ⊗[K] B))
    (hA : ∀ x : OA, (x : A) ⊗ₜ[K] (1 : B) ∈ O)
    (hB : ∀ y : OB, (1 : A) ⊗ₜ[K] (y : B) ∈ O)
    {a : A} {b : B} (ht : a ⊗ₜ[K] b ∈ H)
    (x : OA) (y : OB) : (a * (x : A)) ⊗ₜ[K] (b * (y : B)) ∈ H := by
  have hxy := integral_tmul_mem OA OB O hA hB x y
  have hm := coefficient_multiple_mem O H ht
    (⟨(x : A) ⊗ₜ[K] (y : B), hxy⟩ : O)
  simpa only [Algebra.TensorProduct.tmul_mul_tmul, mul_comm (x : A) a,
    mul_comm (y : B) b] using hm

/-- Consequently the hull contains the whole additive tensor lattice, not
merely one point in each factor. The actual coefficient-ring embeddings are
explicit hypotheses, not supplied by an assumed IUT theorem. -/
theorem scaledIntegralTensorSpan_le_hull (OA : Subring A) (OB : Subring B)
    (O : Subring (A ⊗[K] B)) (H : Submodule O (A ⊗[K] B))
    (hA : ∀ x : OA, (x : A) ⊗ₜ[K] (1 : B) ∈ O)
    (hB : ∀ y : OB, (1 : A) ⊗ₜ[K] (y : B) ∈ O)
    {a : A} {b : B} (ht : a ⊗ₜ[K] b ∈ H) :
    scaledIntegralTensorSpan OA OB a b ≤ H.restrictScalars ℤ := by
  apply Submodule.span_le.mpr
  rintro _ ⟨⟨x, y⟩, rfl⟩
  exact scaled_integral_tmul_mem OA OB O H hA hB ht x y

end IntegralGenerators

end IUTThreeClosures.IUTReachabilityContinuation20260830
