/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PossibleImageGeneratorClosure
import IUTThreeClosures.HonestCountableGeneratedSource

/-!
# Measured possible-image processions

The source relation used by the honest Corollary 3.12 argument is naturally a
procession-indexed construction.  The same ordinary branches and the same
Ind1/Ind2/Ind3 words are realized in every capsule, but the local carrier and
region may depend on the capsule.

This module packages that source presentation and proves two facts:

* the distinguished ordinary q-pilot branch is contained in the literal union
  of all generated possible images in every capsule;
* if the ordinary branches and each of the three generators preserve one
  explicit envelope, then the whole possible-image union is contained in that
  envelope in every capsule.

A measured realization then turns these set-theoretic statements into an
`HonestCountableGeneratedSource`.  Consequently the numerical lower bound
`C_Theta >= -1` follows from finite-positive measure monotonicity.  No total
real-valued volume on arbitrary sets, IUT IV upper estimate, height inequality,
or abc statement is an input.

To instantiate this with genuine IUT objects one must still construct the
actual Hodge-theater operations and prove their generator-by-generator
compatibility with the displayed envelope.
-/

namespace IUTThreeClosures

open MeasureTheory

universe u v w₀ w₁ w₂ w₃

/-- A procession-indexed source presentation.  The operation types are shared
by all capsules, while each operation acts on the local carrier of the chosen
capsule. -/
structure PresentedPossibleImageProcession
    (I : Type v) [Fintype I]
    (α : I → Type u) :
    Type (max (u + 1) (v + 1) (w₀ + 1) (w₁ + 1) (w₂ + 1) (w₃ + 1)) where
  Ordinary : Type w₀
  Ind1 : Type w₁
  Ind2 : Type w₂
  Ind3 : Type w₃
  ordinaryRegion : Ordinary → ∀ i, Set (α i)
  act1 : Ind1 → ∀ i, Set (α i) → Set (α i)
  act2 : Ind2 → ∀ i, Set (α i) → Set (α i)
  act3 : Ind3 → ∀ i, Set (α i) → Set (α i)
  native : Ordinary
  envelope : ∀ i, Set (α i)
  ordinary_le_envelope : ∀ o i, ordinaryRegion o i ⊆ envelope i
  ind1_preserves_envelope :
    ∀ a i U, U ⊆ envelope i → act1 a i U ⊆ envelope i
  ind2_preserves_envelope :
    ∀ a i U, U ⊆ envelope i → act2 a i U ⊆ envelope i
  ind3_preserves_envelope :
    ∀ a i U, U ⊆ envelope i → act3 a i U ⊆ envelope i

namespace PresentedPossibleImageProcession

variable {I : Type v} [Fintype I]
variable {α : I → Type u}

/-- Possible images are finite words in the three source operations. -/
abbrev Output
    (S : PresentedPossibleImageProcession.{u, v, w₀, w₁, w₂, w₃} I α) :=
  PossibleImageWord S.Ordinary S.Ind1 S.Ind2 S.Ind3

/-- Realization of one possible-image word in one capsule. -/
def realization
    (S : PresentedPossibleImageProcession.{u, v, w₀, w₁, w₂, w₃} I α)
    (o : S.Output) (i : I) : Set (α i) :=
  o.realize
    (fun x => S.ordinaryRegion x i)
    (fun a U => S.act1 a i U)
    (fun a U => S.act2 a i U)
    (fun a U => S.act3 a i U)

/-- Literal union of all generated possible-image regions in one capsule. -/
def possibleUnion
    (S : PresentedPossibleImageProcession.{u, v, w₀, w₁, w₂, w₃} I α)
    (i : I) : Set (α i) :=
  ⋃ o : S.Output, S.realization o i

/-- Distinguished native q-pilot region in one capsule. -/
def nativeRegion
    (S : PresentedPossibleImageProcession.{u, v, w₀, w₁, w₂, w₃} I α)
    (i : I) : Set (α i) :=
  S.ordinaryRegion S.native i

/-- The native q-pilot is definitionally one of the generated possible
images. -/
theorem actualNativeImage
    (S : PresentedPossibleImageProcession.{u, v, w₀, w₁, w₂, w₃} I α)
    (i : I) :
    S.nativeRegion i ⊆ S.possibleUnion i := by
  intro z hz
  exact Set.mem_iUnion.mpr
    ⟨PossibleImageWord.ordinary S.native, hz⟩

/-- Generator-by-generator envelope preservation controls every possible-image
word in every capsule. -/
theorem realization_le_envelope
    (S : PresentedPossibleImageProcession.{u, v, w₀, w₁, w₂, w₃} I α)
    (o : S.Output) (i : I) :
    S.realization o i ⊆ S.envelope i := by
  exact PossibleImageWord.realize_subset_envelope
    (fun x => S.ordinaryRegion x i)
    (fun a U => S.act1 a i U)
    (fun a U => S.act2 a i U)
    (fun a U => S.act3 a i U)
    (S.envelope i)
    (fun x => S.ordinary_le_envelope x i)
    (fun a U h => S.ind1_preserves_envelope a i U h)
    (fun a U h => S.ind2_preserves_envelope a i U h)
    (fun a U h => S.ind3_preserves_envelope a i U h)
    o

/-- The full possible-image union is contained in the explicit multiradial
envelope in every capsule. -/
theorem actualPossibleImageEnvelope
    (S : PresentedPossibleImageProcession.{u, v, w₀, w₁, w₂, w₃} I α)
    (i : I) :
    S.possibleUnion i ⊆ S.envelope i := by
  intro z hz
  rcases Set.mem_iUnion.mp hz with ⟨o, hzo⟩
  exact S.realization_le_envelope o i hzo

/-- A finite-positive measured realization of a presented source. -/
structure MeasuredRealization
    (S : PresentedPossibleImageProcession.{u, v, w₀, w₁, w₂, w₃} I α)
    [∀ i, MeasurableSpace (α i)]
    (μ : ∀ i, Measure (α i)) :
    Type (max (u + 1) (v + 1) (w₀ + 1) (w₁ + 1) (w₂ + 1) (w₃ + 1)) where
  outputCountable : Countable S.Output
  realizeRegion : S.Output → ∀ i, FinitePositiveRegion (α i) (μ i)
  realizeRegion_carrier :
    ∀ o i, (realizeRegion o i : Set (α i)) = S.realization o i
  envelopeRegion : ∀ i, FinitePositiveRegion (α i) (μ i)
  envelopeRegion_carrier :
    ∀ i, (envelopeRegion i : Set (α i)) = S.envelope i
  qLog : ℝ
  qLog_pos : 0 < qLog
  nativeAverage :
    (∑ i, (realizeRegion (PossibleImageWord.ordinary S.native) i).logVolume) /
        Fintype.card I = -qLog

namespace MeasuredRealization

variable {S : PresentedPossibleImageProcession.{u, v, w₀, w₁, w₂, w₃} I α}
variable [∀ i, MeasurableSpace (α i)]
variable {μ : ∀ i, Measure (α i)}

instance (M : S.MeasuredRealization μ) : Countable S.Output :=
  M.outputCountable

/-- The measured presented source is an honest countably generated source. -/
noncomputable def toHonestCountableGeneratedSource
    (M : S.MeasuredRealization μ) :
    HonestCountableGeneratedSource I α μ where
  Output := S.Output
  outputCountable := M.outputCountable
  realize := M.realizeRegion
  envelope := M.envelopeRegion
  realize_le_envelope := by
    intro o i
    rw [M.realizeRegion_carrier o i, M.envelopeRegion_carrier i]
    exact S.realization_le_envelope o i
  native := PossibleImageWord.ordinary S.native
  qLog := M.qLog
  qLog_pos := M.qLog_pos
  nativeAverage := M.nativeAverage

/-- The honest theta region is the literal union of the presented possible
images, after forgetting the finite-positive proofs. -/
theorem theta_carrier_eq_possibleUnion
    (M : S.MeasuredRealization μ) (i : I) :
    ((M.toHonestCountableGeneratedSource.theta i :
        FinitePositiveRegion (α i) (μ i)) : Set (α i)) =
      S.possibleUnion i := by
  change (⋃ o : S.Output, (M.realizeRegion o i : Set (α i))) =
    ⋃ o : S.Output, S.realization o i
  apply Set.iUnion_congr
  intro o
  exact M.realizeRegion_carrier o i

/-- The actual native-image inclusion is inherited by the honest measured
source. -/
theorem native_le_theta
    (M : S.MeasuredRealization μ) (i : I) :
    S.nativeRegion i ⊆
      ((M.toHonestCountableGeneratedSource.theta i :
        FinitePositiveRegion (α i) (μ i)) : Set (α i)) := by
  rw [M.theta_carrier_eq_possibleUnion i]
  exact S.actualNativeImage i

/-- Corollary 3.12's numerical lower bound follows from the measured source
presentation. -/
theorem thetaCoefficient_ge_neg_one
    (M : S.MeasuredRealization μ) :
    -1 ≤ M.toHonestCountableGeneratedSource.thetaCoefficient :=
  M.toHonestCountableGeneratedSource.thetaCoefficient_ge_neg_one

end MeasuredRealization

end PresentedPossibleImageProcession

end IUTThreeClosures
