/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneratedSource
import IUTThreeClosures.MultiradialPresentationTransfer

/-!
# Semantic transfer for procession-indexed multiradial sources

The genuine output of IUT III, Theorem 3.11 is naturally described by
Hodge-theater, log-Kummer and Frobenioid objects, while the downstream Lean
proof uses a generated Ind1/Ind2/Ind3 syntax.  Equality of the two output types
is neither expected nor required.  What is required is a capsule-wise semantic
presentation that is sound and complete at every rational place.

This module lifts `MultiradialSemanticPresentation` to the complete public
procession interface.  It proves that a sound/complete presentation identifies
all genuine and generated possible-image unions, capsule by capsule and place
by place.  Consequently the generated public theta-pilot is extensionally the
union of the genuine outputs.

A second structure packages one genuine native q-output whose encoded syntax
region is exactly the same region and whose procession volume is the public
q-pilot left-hand side.  From this source-facing information we construct the
existing `GeneratedNativeSource`, hence an `ActualPilotWitness` and the
standalone Corollary 3.12 inequality.

No Corollary 3.12 inequality, component upper estimate, height estimate or abc
statement is stored as a field.  The remaining source theorem is now precisely
to construct the genuine output family and prove the soundness, completeness
and native-volume calibration fields below.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField

universe u v w x

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- A sound and complete semantic presentation of genuine procession outputs
by a generated output syntax.  The comparisons are made as inclusions of
public admissible regions in every capsule. -/
structure ProcessionMultiradialSemanticPresentation
    {D : InitialThetaData AG TG}
    (C : LargeVolumeContainerData.{0, u, v} ℕ
      (Place ↥D.prime.torsionField))
    (Genuine : Type w)
    (Syntax : Type x)
    (genuineRealize : Genuine → ∀ i, C.AdmissibleRegion i)
    (syntaxRealize : Syntax → ∀ i, C.AdmissibleRegion i) where
  encode : Genuine → Syntax
  encode_sound :
    ∀ (g : Genuine) (i : Fin C.proc.length),
      genuineRealize g i ≤ syntaxRealize (encode g) i
  decode : Syntax → Genuine
  decode_complete :
    ∀ (s : Syntax) (i : Fin C.proc.length),
      syntaxRealize s i ≤ genuineRealize (decode s) i

namespace ProcessionMultiradialSemanticPresentation

variable {D : InitialThetaData AG TG}
variable {C : LargeVolumeContainerData.{0, u, v} ℕ
  (Place ↥D.prime.torsionField)}
variable {Genuine : Type w} {Syntax : Type x}
variable
  {genuineRealize : Genuine → ∀ i, C.AdmissibleRegion i}
variable
  {syntaxRealize : Syntax → ∀ i, C.AdmissibleRegion i}
variable
  (P : ProcessionMultiradialSemanticPresentation
    C Genuine Syntax genuineRealize syntaxRealize)

/-- The raw genuine possible-image union at one capsule and rational place. -/
def genuineUnionSet
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    Set (C.packet i vQ).Total :=
  ⋃ g : Genuine, (genuineRealize g i).region vQ

/-- The corresponding generated-syntax possible-image union. -/
def syntaxUnionSet
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    Set (C.packet i vQ).Total :=
  ⋃ s : Syntax, (syntaxRealize s i).region vQ

@[simp]
theorem mem_genuineUnionSet
    {i : Fin C.proc.length} {vQ : RationalPlace}
    {a : (C.packet i vQ).Total} :
    a ∈ P.genuineUnionSet i vQ ↔
      ∃ g : Genuine, a ∈ (genuineRealize g i).region vQ := by
  simp [genuineUnionSet]

@[simp]
theorem mem_syntaxUnionSet
    {i : Fin C.proc.length} {vQ : RationalPlace}
    {a : (C.packet i vQ).Total} :
    a ∈ P.syntaxUnionSet i vQ ↔
      ∃ s : Syntax, a ∈ (syntaxRealize s i).region vQ := by
  simp [syntaxUnionSet]

/-- Soundness carries every genuine possible image into the syntax union. -/
theorem genuineUnion_le_syntaxUnion
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    P.genuineUnionSet i vQ ⊆ P.syntaxUnionSet i vQ := by
  rintro a ⟨g, ha⟩
  exact ⟨P.encode g, P.encode_sound g i vQ ha⟩

/-- Completeness carries every generated output back to a genuine output. -/
theorem syntaxUnion_le_genuineUnion
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    P.syntaxUnionSet i vQ ⊆ P.genuineUnionSet i vQ := by
  rintro a ⟨s, ha⟩
  exact ⟨P.decode s, P.decode_complete s i vQ ha⟩

/-- The genuine and generated possible-image unions agree at every capsule
and rational place. -/
theorem unionSet_eq
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    P.genuineUnionSet i vQ = P.syntaxUnionSet i vQ :=
  Set.Subset.antisymm
    (P.genuineUnion_le_syntaxUnion i vQ)
    (P.syntaxUnion_le_genuineUnion i vQ)

/-- A convenient stronger constructor when encoding and decoding preserve the
complete admissible region exactly. -/
def ofRegionEqualities
    (encode : Genuine → Syntax)
    (hencode :
      ∀ (g : Genuine) (i : Fin C.proc.length),
        genuineRealize g i = syntaxRealize (encode g) i)
    (decode : Syntax → Genuine)
    (hdecode :
      ∀ (s : Syntax) (i : Fin C.proc.length),
        syntaxRealize s i = genuineRealize (decode s) i) :
    ProcessionMultiradialSemanticPresentation
      C Genuine Syntax genuineRealize syntaxRealize where
  encode := encode
  encode_sound := fun g i => (hencode g i).le
  decode := decode
  decode_complete := fun s i => (hdecode s i).le

end ProcessionMultiradialSemanticPresentation

/-- A genuine multiradial source presented by the already verified generated
public-output interface, together with one genuine native q-output.

The equality `native_encode_eq` is a semantic identification of the native
source region, not a numerical inequality or downstream target. -/
structure SemanticGeneratedNativeSource
    (D : InitialThetaData AG TG)
    (Q : QPilotData D) : Type (max (u + 1) (v + 1) (w + 1) (x + 1)) where
  rhs : GeneratedRHSData.{u, v, w} D
  Genuine : Type x
  genuineRealize :
    Genuine → ∀ i, rhs.container.AdmissibleRegion i
  presentation :
    ProcessionMultiradialSemanticPresentation
      rhs.container Genuine rhs.outputs.Output
      genuineRealize rhs.outputs.realize
  native : Genuine
  native_encode_eq :
    ∀ i,
      rhs.outputs.realize (presentation.encode native) i =
        genuineRealize native i
  nativeVolume :
    rhs.vol.processionVol (genuineRealize native) = Q.lhs
  processionVol_mono :
    ∀ {R S : ∀ i, rhs.container.AdmissibleRegion i},
      (∀ i, R i ≤ S i) →
        rhs.vol.processionVol R ≤ rhs.vol.processionVol S

namespace SemanticGeneratedNativeSource

variable {D : InitialThetaData AG TG} {Q : QPilotData D}

/-- The raw union of genuine source outputs is exactly the public generated
theta-pilot union. -/
theorem genuineUnionSet_eq_thetaPilot
    (S : SemanticGeneratedNativeSource.{u, v, w, x} D Q)
    (i : Fin S.rhs.container.proc.length)
    (vQ : RationalPlace) :
    S.presentation.genuineUnionSet i vQ =
      (S.rhs.outputs.unionRegion i).region vQ := by
  calc
    S.presentation.genuineUnionSet i vQ =
        S.presentation.syntaxUnionSet i vQ :=
      S.presentation.unionSet_eq i vQ
    _ = (S.rhs.outputs.unionRegion i).region vQ := rfl

/-- The semantic source constructs the already audited generated native
source. -/
noncomputable def toGeneratedNativeSource
    (S : SemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    GeneratedNativeSource.{u, v, w} D Q where
  rhs := S.rhs
  native := S.presentation.encode S.native
  nativeVolume := by
    have hregions :
        S.rhs.outputs.realize
            (S.presentation.encode S.native) =
          S.genuineRealize S.native := by
      funext i
      exact S.native_encode_eq i
    rw [hregions]
    exact S.nativeVolume
  processionVol_mono := S.processionVol_mono

/-- The associated public Corollary 3.12 data bundle. -/
noncomputable def toVariantData
    (S : SemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    Corollary312VariantData.{u, v} AG TG :=
  S.toGeneratedNativeSource.toVariantData

/-- A genuine sound/complete multiradial presentation with calibrated native
volume produces an actual public pilot witness. -/
noncomputable def toActualPilotWitness
    (S : SemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    ActualPilotWitness S.toVariantData :=
  S.toGeneratedNativeSource.toActualPilotWitness

/-- Hence the standalone public Corollary 3.12 variant follows from the
semantic source data, with no target proposition stored in the source. -/
theorem corollary312Variant
    (S : SemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    Corollary312Variant S.toVariantData :=
  S.toActualPilotWitness.corollary312Variant

end SemanticGeneratedNativeSource

end IUTThreeClosures
