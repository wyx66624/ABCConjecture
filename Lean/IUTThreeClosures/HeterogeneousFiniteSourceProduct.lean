/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NormControlledSourceGenerators

/-!
# Finite products of heterogeneous norm-controlled sources

The actual IUT III multiradial source is assembled from many local factors,
not from a single Tate field.  This module proves the finite-product closure
needed to pass from pointwise local source theorems to one global packet.

Let `J` be finite and let the carrier at `j` be a seminormed additive group
`α j`.  Suppose each coordinate has a `NormControlledSourceGenerators (α j)`
and all coordinate radii are bounded by one common nonnegative radius `R`.
Then the dependent product

`∀ j, α j`

inherits a norm-controlled source:

* ordinary branches are coordinatewise products;
* the native branch is the tuple of native branches;
* Ind1, Ind2 and relational Ind3 maps act coordinatewise;
* the finite-product sup norm converts every coordinate norm estimate into a
  global norm estimate.

Consequently the product native region belongs to the generated possible-image
union and every generated image lies in the common product ball.

This theorem removes a purely formal global-packet obstruction.  The genuine
source problem still has to construct the local factors, identify the finite
index set and common coordinates, prove the local norm estimates, and connect
the resulting product packet to the procession and component-volume data.
-/

namespace IUTThreeClosures

universe u v w x y z

/-- A finite heterogeneous family of norm-controlled sources with one common
nonnegative radius. -/
structure NormControlledSourceFamily
    (J : Type z) [Fintype J]
    (α : J → Type y)
    [∀ j, SeminormedAddCommGroup (α j)] :
    Type (max (u + 1) (v + 1) (w + 1) (x + 1) (y + 1) (z + 1)) where
  source :
    ∀ j : J,
      NormControlledSourceGenerators.{u, v, w, x, y} (α j)
  commonRadius : ℝ
  commonRadius_nonneg : 0 ≤ commonRadius
  radius_le : ∀ j : J, (source j).radius ≤ commonRadius

namespace NormControlledSourceFamily

variable {J : Type z} [Fintype J]
variable {α : J → Type y}
variable [∀ j, SeminormedAddCommGroup (α j)]

/-- The coordinatewise product of all ordinary source regions. -/
def ordinaryProductRegion
    (F : NormControlledSourceFamily.{u, v, w, x, y, z} J α)
    (o : ∀ j : J, (F.source j).Ordinary) :
    Set (∀ j : J, α j) :=
  {a | ∀ j, a j ∈ (F.source j).ordinaryRegion (o j)}

@[simp]
theorem mem_ordinaryProductRegion
    (F : NormControlledSourceFamily.{u, v, w, x, y, z} J α)
    (o : ∀ j : J, (F.source j).Ordinary)
    (a : ∀ j : J, α j) :
    a ∈ F.ordinaryProductRegion o ↔
      ∀ j, a j ∈ (F.source j).ordinaryRegion (o j) :=
  Iff.rfl

/-- Assemble all local source generators into one source on the dependent
finite product. -/
noncomputable def productSource
    (F : NormControlledSourceFamily.{u, v, w, x, y, z} J α) :
    NormControlledSourceGenerators (∀ j : J, α j) where
  Ordinary := ∀ j : J, (F.source j).Ordinary
  Ind1 := ∀ j : J, (F.source j).Ind1
  Ind2 := ∀ j : J, (F.source j).Ind2
  Ind3 := ∀ j : J, (F.source j).Ind3
  ordinaryRegion := F.ordinaryProductRegion
  native := fun j => (F.source j).native
  radius := F.commonRadius
  ordinary_le_radius := by
    intro o a ha
    change ‖a‖ ≤ F.commonRadius
    rw [pi_norm_le_iff_of_nonneg F.commonRadius_nonneg]
    intro j
    exact ((F.source j).ordinary_le_radius (o j) (ha j)).trans
      (F.radius_le j)
  ind1Map := fun c a j => (F.source j).ind1Map (c j) (a j)
  ind2Map := fun c a j => (F.source j).ind2Map (c j) (a j)
  ind3Map := fun c a j => (F.source j).ind3Map (c j) (a j)
  ind1_norm := by
    intro c a
    rw [pi_norm_le_iff_of_nonneg (norm_nonneg a)]
    intro j
    exact ((F.source j).ind1_norm (c j) (a j)).trans
      (norm_le_pi_norm a j)
  ind2_norm := by
    intro c a
    rw [pi_norm_le_iff_of_nonneg (norm_nonneg a)]
    intro j
    exact ((F.source j).ind2_norm (c j) (a j)).trans
      (norm_le_pi_norm a j)
  ind3_norm := by
    intro c a
    rw [pi_norm_le_iff_of_nonneg (norm_nonneg a)]
    intro j
    exact ((F.source j).ind3_norm (c j) (a j)).trans
      (norm_le_pi_norm a j)

/-- The product source's native region is exactly the coordinatewise product
of the native local regions. -/
@[simp]
theorem productSource_nativeRegion
    (F : NormControlledSourceFamily.{u, v, w, x, y, z} J α) :
    F.productSource.ordinaryRegion F.productSource.native =
      {a : ∀ j : J, α j |
        ∀ j, a j ∈
          (F.source j).ordinaryRegion (F.source j).native} :=
  rfl

/-- The complete product-native region is an actual generated possible image. -/
theorem productNativeImage
    (F : NormControlledSourceFamily.{u, v, w, x, y, z} J α) :
    {a : ∀ j : J, α j |
        ∀ j, a j ∈
          (F.source j).ordinaryRegion (F.source j).native} ⊆
      F.productSource.toUpperSemicompatibleSystem.possibleUnion := by
  simpa using F.productSource.actualNativeImage

/-- Every possible image generated from the finite heterogeneous product lies
in the common product radial envelope. -/
theorem productPossibleImageEnvelope
    (F : NormControlledSourceFamily.{u, v, w, x, y, z} J α) :
    F.productSource.toUpperSemicompatibleSystem.possibleUnion ⊆
      radialEnvelope (α := ∀ j : J, α j) F.commonRadius :=
  F.productSource.actualPossibleImageEnvelope

/-- A family whose local source radii are all at most one yields the canonical
unit-ball packet used by the actual Tate/Kummer source. -/
noncomputable def ofRadiiLeOne
    (source :
      ∀ j : J,
        NormControlledSourceGenerators.{u, v, w, x, y} (α j))
    (hsource : ∀ j : J, (source j).radius ≤ 1) :
    NormControlledSourceFamily.{u, v, w, x, y, z} J α where
  source := source
  commonRadius := 1
  commonRadius_nonneg := by norm_num
  radius_le := hsource

end NormControlledSourceFamily

end IUTThreeClosures
