/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.Ind3NormEnvelopeReduction

/-!
# Source generators controlled by pointwise norms

The source-level envelope theorem can be reduced to local analytic statements.
Suppose the Ind1 and Ind2 operations are represented by maps that do not
increase the packet norm, while an Ind3 target is upper semi-compatible with
the image of a norm-nonincreasing log-link map.  Then one fixed radial packet
contains every possible image generated from ordinary branches already lying
in that packet.

This module converts those pointwise norm estimates into an
`UpperSemicompatiblePossibleImageSystem`.  It therefore removes arbitrary
set-level envelope-preservation fields from the source construction.  To
instantiate it with genuine IUT data, the remaining source theorems are the
actual norm estimates for the procession isomorphisms, spectral-factor
automorphisms and log-links.
-/

namespace IUTThreeClosures

universe u v w x y

/-- A local possible-image presentation whose three source operations are
controlled pointwise by the packet norm. -/
structure NormControlledSourceGenerators
    (α : Type y) [SeminormedAddCommGroup α] :
    Type (max (u + 1) (v + 1) (w + 1) (x + 1) (y + 1)) where
  Ordinary : Type u
  Ind1 : Type v
  Ind2 : Type w
  Ind3 : Type x
  ordinaryRegion : Ordinary → Set α
  native : Ordinary
  radius : ℝ
  ordinary_le_radius :
    ∀ o, ordinaryRegion o ⊆ radialEnvelope (α := α) radius
  ind1Map : Ind1 → α → α
  ind2Map : Ind2 → α → α
  ind3Map : Ind3 → α → α
  ind1_norm : ∀ a z, ‖ind1Map a z‖ ≤ ‖z‖
  ind2_norm : ∀ a z, ‖ind2Map a z‖ ≤ ‖z‖
  ind3_norm : ∀ a z, ‖ind3Map a z‖ ≤ ‖z‖

namespace NormControlledSourceGenerators

variable {α : Type y} [SeminormedAddCommGroup α]

/-- Ind1 acts on regions by direct image. -/
def act1
    (S : NormControlledSourceGenerators.{u, v, w, x, y} α)
    (a : S.Ind1) (U : Set α) : Set α :=
  S.ind1Map a '' U

/-- Ind2 acts on regions by direct image. -/
def act2
    (S : NormControlledSourceGenerators.{u, v, w, x, y} α)
    (a : S.Ind2) (U : Set α) : Set α :=
  S.ind2Map a '' U

/-- Ind3 is relational: an actual target region need only be contained in the
image under the corresponding log-link map. -/
def step3
    (S : NormControlledSourceGenerators.{u, v, w, x, y} α)
    (a : S.Ind3) (U V : Set α) : Prop :=
  V ⊆ S.ind3Map a '' U

/-- The norm-controlled data generate an upper-semicompatible possible-image
system with the canonical radial envelope. -/
noncomputable def toUpperSemicompatibleSystem
    (S : NormControlledSourceGenerators.{u, v, w, x, y} α) :
    UpperSemicompatiblePossibleImageSystem.{u, v, w, x, y} α where
  Ordinary := S.Ordinary
  Ind1 := S.Ind1
  Ind2 := S.Ind2
  Ind3 := S.Ind3
  ordinaryRegion := S.ordinaryRegion
  act1 := S.act1
  act2 := S.act2
  step3 := S.step3
  native := S.native
  envelope := radialEnvelope (α := α) S.radius
  ordinary_le_envelope := S.ordinary_le_radius
  ind1_preserves_envelope := by
    intro a U hU
    exact image_radialEnvelope_le (S.ind1Map a)
      (S.ind1_norm a) S.radius |>.trans
        (by
          intro z hz
          rcases hz with ⟨x, hx, rfl⟩
          exact ⟨x, hU hx, rfl⟩)
  ind2_preserves_envelope := by
    intro a U hU
    intro z hz
    rcases hz with ⟨x, hx, rfl⟩
    exact (S.ind2_norm a x).trans (hU hx)
  ind3_preserves_envelope := by
    intro a U V hU hUV
    exact relational_step_preserves_radialEnvelope
      (S.ind3Map a) (S.ind3_norm a) hU hUV

/-- The native q-pilot region belongs to the generated possible-image union. -/
theorem actualNativeImage
    (S : NormControlledSourceGenerators.{u, v, w, x, y} α) :
    S.ordinaryRegion S.native ⊆
      S.toUpperSemicompatibleSystem.possibleUnion :=
  S.toUpperSemicompatibleSystem.actualNativeImage

/-- Every source-generated possible image lies in the radial envelope. -/
theorem actualPossibleImageEnvelope
    (S : NormControlledSourceGenerators.{u, v, w, x, y} α) :
    S.toUpperSemicompatibleSystem.possibleUnion ⊆
      radialEnvelope (α := α) S.radius :=
  S.toUpperSemicompatibleSystem.actualPossibleImageEnvelope

end NormControlledSourceGenerators

end IUTThreeClosures
