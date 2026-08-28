/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PossibleImageGeneratorClosure
import Iut.Cor312.ThetaData.Basic

/-!
# A generated actual-theta source system

The source relation needed by IUT III should not be represented by an unrelated
output type equipped with an arbitrary realization map.  The possible images are
generated from ordinary theta-pilot images by the three source operations.  Ind1 and
Ind2 are equivalence-type operations, while Ind3 is used only through preservation of
an explicit upper envelope.

This module packages precisely that source-level generation data and proves the two
relations needed downstream:

* the distinguished native q-pilot image belongs to the possible-image union;
* every generated possible image, hence their entire union, lies in the explicit
  multiradial envelope.

The proofs are formal consequences of the constructors and generator-by-generator
envelope preservation.  No volume, height estimate, Corollary 3.12 statement or abc
conclusion is a field.  Constructing this structure from the genuine Hodge theaters,
log-links and Kummer correspondences remains the geometric realization theorem.
-/

namespace IUTThreeClosures

open Iut

universe u v w x y z

/-- Source-faithful generation data for actual theta possible images attached to one
collection of initial theta-data. -/
structure ActualThetaSourceSystem
    {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
    (D : InitialThetaData AG TG)
    (I : Type v) (Carrier : I → Type w) :
    Type (max (u + 1) (v + 1) (w + 1) (x + 1) (y + 1) (z + 1)) where
  /-- Ordinary theta-pilot branches before indeterminacies. -/
  Ordinary : Type x
  /-- Indeterminacy-1 operations. -/
  Ind1 : Type y
  /-- Indeterminacy-2 operations. -/
  Ind2 : Type z
  /-- Indeterminacy-3 operations. -/
  Ind3 : Type z
  /-- The ordinary region in every capsule/component. -/
  ordinaryRegion : Ordinary → ∀ i : I, Set (Carrier i)
  /-- Distinguished ordinary branch giving the native q-pilot image. -/
  native : Ordinary
  /-- Region transformations induced by the three source operations. -/
  act1 : Ind1 → ∀ i : I, Set (Carrier i) → Set (Carrier i)
  act2 : Ind2 → ∀ i : I, Set (Carrier i) → Set (Carrier i)
  act3 : Ind3 → ∀ i : I, Set (Carrier i) → Set (Carrier i)
  /-- Explicit multiradial envelope in every capsule/component. -/
  envelope : ∀ i : I, Set (Carrier i)
  /-- Every ordinary branch is contained in the envelope. -/
  ordinary_le_envelope : ∀ o i, ordinaryRegion o i ⊆ envelope i
  /-- Ind1 preserves containment in the envelope. -/
  ind1_preserves_envelope :
    ∀ a i U, U ⊆ envelope i → act1 a i U ⊆ envelope i
  /-- Ind2 preserves containment in the envelope. -/
  ind2_preserves_envelope :
    ∀ a i U, U ⊆ envelope i → act2 a i U ⊆ envelope i
  /-- Ind3 upper semi-compatibility preserves the explicit envelope. -/
  ind3_preserves_envelope :
    ∀ a i U, U ⊆ envelope i → act3 a i U ⊆ envelope i

namespace ActualThetaSourceSystem

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}
variable {I : Type v} {Carrier : I → Type w}

/-- The generated possible-image type. -/
abbrev Output
    (S : ActualThetaSourceSystem.{u, v, w, x, y, z} D I Carrier) :=
  PossibleImageWord S.Ordinary S.Ind1 S.Ind2 S.Ind3

/-- Realization of a generated possible image. -/
def realize
    (S : ActualThetaSourceSystem.{u, v, w, x, y, z} D I Carrier)
    (W : S.Output) (i : I) : Set (Carrier i) :=
  W.realize
    (fun o => S.ordinaryRegion o i)
    (fun a => S.act1 a i)
    (fun a => S.act2 a i)
    (fun a => S.act3 a i)

/-- Literal union of all generated possible images. -/
def possibleImageUnion
    (S : ActualThetaSourceSystem.{u, v, w, x, y, z} D I Carrier)
    (i : I) : Set (Carrier i) :=
  ⋃ W : S.Output, S.realize W i

/-- The distinguished native q-pilot region. -/
def nativeQPilotRegion
    (S : ActualThetaSourceSystem.{u, v, w, x, y, z} D I Carrier)
    (i : I) : Set (Carrier i) :=
  S.ordinaryRegion S.native i

/-- The native q-pilot is one of the actual generated possible images.  This is the
source relation needed for the lower-bound direction of Corollary 3.12. -/
theorem actualNativeImage
    (S : ActualThetaSourceSystem.{u, v, w, x, y, z} D I Carrier)
    (i : I) :
    S.nativeQPilotRegion i ⊆ S.possibleImageUnion i := by
  intro a ha
  exact Set.mem_iUnion.mpr ⟨PossibleImageWord.ordinary S.native, ha⟩

/-- Every generated possible image lies in the explicit multiradial envelope. -/
theorem output_le_envelope
    (S : ActualThetaSourceSystem.{u, v, w, x, y, z} D I Carrier)
    (W : S.Output) (i : I) :
    S.realize W i ⊆ S.envelope i := by
  exact PossibleImageWord.realize_subset_envelope
    (fun o => S.ordinaryRegion o i)
    (fun a => S.act1 a i)
    (fun a => S.act2 a i)
    (fun a => S.act3 a i)
    (S.envelope i)
    (fun o => S.ordinary_le_envelope o i)
    (fun a U hU => S.ind1_preserves_envelope a i U hU)
    (fun a U hU => S.ind2_preserves_envelope a i U hU)
    (fun a U hU => S.ind3_preserves_envelope a i U hU)
    W

/-- The complete generated possible-image union lies in the explicit multiradial
envelope.  This is the source relation needed for the IUT IV upper-bound direction. -/
theorem actualPossibleImageEnvelope
    (S : ActualThetaSourceSystem.{u, v, w, x, y, z} D I Carrier)
    (i : I) :
    S.possibleImageUnion i ⊆ S.envelope i := by
  intro a ha
  rcases Set.mem_iUnion.mp ha with ⟨W, ha⟩
  exact S.output_le_envelope W i ha

end ActualThetaSourceSystem

end IUTThreeClosures
