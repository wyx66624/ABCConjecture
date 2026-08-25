/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Exact.Sequence

/-!
# Finite-dimensional balance for a four-term exact sequence

The corrected cyclic-line evaluation object is a four-term exact sequence

`0 -> H0(O) -> H0(L) -> H0(L|D) -> H1(O) -> 0`.

Its determinant-of-cohomology construction requires the corresponding Euler
characteristic identity.  This module proves the finite-dimensional dimension
balance directly from exactness and rank-nullity.

No elliptic curve or abc statement is assumed here.
-/

namespace IUTThreeClosures

open Function Module

universe u v₀ v₁ v₂ v₃

/-- The Euler-characteristic balance of a four-term exact sequence. -/
theorem fourTermExact_finrank_balance
    {K : Type u} [DivisionRing K]
    {A : Type v₀} [AddCommGroup A] [Module K A] [FiniteDimensional K A]
    {B : Type v₁} [AddCommGroup B] [Module K B] [FiniteDimensional K B]
    {C : Type v₂} [AddCommGroup C] [Module K C] [FiniteDimensional K C]
    {D : Type v₃} [AddCommGroup D] [Module K D] [FiniteDimensional K D]
    (f : A →ₗ[K] B) (g : B →ₗ[K] C) (h : C →ₗ[K] D)
    (hf : Injective f)
    (hfg : Exact f g)
    (hgh : Exact g h)
    (hh : Surjective h) :
    finrank K B + finrank K D = finrank K A + finrank K C := by
  have hfRange : finrank K (LinearMap.range f) = finrank K A :=
    LinearMap.finrank_range_of_inj hf
  have hgRank := g.finrank_range_add_finrank_ker
  have hhRank := h.finrank_range_add_finrank_ker
  have hkerG : finrank K (LinearMap.ker g) =
      finrank K (LinearMap.range f) :=
    congrArg (fun S : Submodule K B => finrank K S)
      hfg.linearMap_ker_eq
  have hkerH : finrank K (LinearMap.ker h) =
      finrank K (LinearMap.range g) :=
    congrArg (fun S : Submodule K C => finrank K S)
      hgh.linearMap_ker_eq
  have hhRange : LinearMap.range h = ⊤ :=
    LinearMap.range_eq_top.mpr hh
  have hhRangeFinrank : finrank K (LinearMap.range h) = finrank K D := by
    rw [hhRange, Submodule.finrank_top]
  omega

/-- If the two endpoint spaces have the same dimension, then the two middle
spaces have the same dimension.  In the elliptic evaluation sequence both
endpoint spaces are one-dimensional. -/
theorem fourTermExact_middle_finrank_eq
    {K : Type u} [DivisionRing K]
    {A : Type v₀} [AddCommGroup A] [Module K A] [FiniteDimensional K A]
    {B : Type v₁} [AddCommGroup B] [Module K B] [FiniteDimensional K B]
    {C : Type v₂} [AddCommGroup C] [Module K C] [FiniteDimensional K C]
    {D : Type v₃} [AddCommGroup D] [Module K D] [FiniteDimensional K D]
    (f : A →ₗ[K] B) (g : B →ₗ[K] C) (h : C →ₗ[K] D)
    (hf : Injective f)
    (hfg : Exact f g)
    (hgh : Exact g h)
    (hh : Surjective h)
    (hend : finrank K A = finrank K D) :
    finrank K B = finrank K C := by
  have hbal := fourTermExact_finrank_balance f g h hf hfg hgh hh
  omega

/-- Exactness identifies the kernel of the middle evaluation map with the
image of the left endpoint. -/
theorem fourTermExact_kernel_finrank
    {K : Type u} [DivisionRing K]
    {A : Type v₀} [AddCommGroup A] [Module K A] [FiniteDimensional K A]
    {B : Type v₁} [AddCommGroup B] [Module K B] [FiniteDimensional K B]
    {C : Type v₂} [AddCommGroup C] [Module K C]
    (f : A →ₗ[K] B) (g : B →ₗ[K] C)
    (hf : Injective f)
    (hfg : Exact f g) :
    finrank K (LinearMap.ker g) = finrank K A := by
  rw [hfg.linearMap_ker_eq]
  exact LinearMap.finrank_range_of_inj hf

end IUTThreeClosures
