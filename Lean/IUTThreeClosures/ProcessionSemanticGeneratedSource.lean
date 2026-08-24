/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneratedSource
import IUTThreeClosures.MultiradialPresentationTransfer

/-!
# Procession-level semantic transfer into generated Corollary 3.12 data

The genuine IUT III output type and the generated Ind1/Ind2/Ind3 syntax need
not be definitionally equal.  This module records the exact dependent
procession-level presentation required by the verified public downstream
construction.

A genuine output is represented by one admissible region in every capsule of
the public procession.  Sound encoding and complete decoding compare these
regions with the generated syntax regions.  They imply equality of the full
possible-image unions capsule by capsule and rational place by rational place.

A distinguished genuine native output is additionally required to agree with
its encoded syntax region and to have the calibrated q-pilot procession
volume.  These data construct `GeneratedNativeSource`, hence the existing
`ActualPilotWitness` and standalone Corollary 3.12 theorem.

No Corollary 3.12 inequality, upper component estimate, height inequality, or
abc conclusion is included as a source field.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- A sound and complete semantic presentation of complete procession outputs
by the generated public source syntax. -/
structure ProcessionSemanticPresentation
    {D : InitialThetaData AG TG}
    {C : LargeVolumeContainerData.{0, u, v} ℕ
      (Place ↥D.prime.torsionField)}
    (G : GeneratedOutputData.{u, v, w} C) :
    Type (max u (v + 1) (w + 1) (z + 1)) where
  Genuine : Type z
  genuineNonempty : Nonempty Genuine
  realize : Genuine → ∀ i, C.AdmissibleRegion i
  encode : Genuine → G.Output
  encode_sound :
    ∀ g i, realize g i ≤ G.realize (encode g) i
  decode : G.Output → Genuine
  decode_complete :
    ∀ s i, G.realize s i ≤ realize (decode s) i

namespace ProcessionSemanticPresentation

variable
  {D : InitialThetaData AG TG}
  {C : LargeVolumeContainerData.{0, u, v} ℕ
    (Place ↥D.prime.torsionField)}
  {G : GeneratedOutputData.{u, v, w} C}
  (P : ProcessionSemanticPresentation.{u, v, w, z} G)

/-- The genuine possible-image union in one capsule and rational place. -/
noncomputable def genuineUnion
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    Set ((C.packet i vQ).Total) :=
  ⋃ g : P.Genuine, (P.realize g i).region vQ

/-- The generated syntax possible-image union in one capsule and rational
place. -/
noncomputable def syntaxUnion
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    Set ((C.packet i vQ).Total) :=
  ⋃ s : G.Output, (G.realize s i).region vQ

/-- Soundness gives inclusion of the genuine union in the syntax union. -/
theorem genuineUnion_le_syntaxUnion
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    P.genuineUnion i vQ ⊆ P.syntaxUnion i vQ := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨g, hg⟩
  apply Set.mem_iUnion.mpr
  refine ⟨P.encode g, ?_⟩
  exact P.encode_sound g i vQ hg

/-- Completeness gives inclusion of the syntax union in the genuine union. -/
theorem syntaxUnion_le_genuineUnion
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    P.syntaxUnion i vQ ⊆ P.genuineUnion i vQ := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨s, hs⟩
  apply Set.mem_iUnion.mpr
  refine ⟨P.decode s, ?_⟩
  exact P.decode_complete s i vQ hs

/-- Genuine and generated possible-image unions are extensionally equal in
every capsule and rational place. -/
theorem genuineUnion_eq_syntaxUnion
    (i : Fin C.proc.length) (vQ : RationalPlace) :
    P.genuineUnion i vQ = P.syntaxUnion i vQ :=
  Set.Subset.antisymm
    (P.genuineUnion_le_syntaxUnion i vQ)
    (P.syntaxUnion_le_genuineUnion i vQ)

end ProcessionSemanticPresentation

/-- A genuine native output together with exactly the source-facing data
needed to construct the already verified generated native source. -/
structure SemanticGeneratedNativeSource
    (D : InitialThetaData AG TG)
    (Q : QPilotData D) :
    Type (max (u + 1) (v + 1) (w + 1) (z + 1)) where
  rhs : GeneratedRHSData.{u, v, w} D
  presentation :
    ProcessionSemanticPresentation.{u, v, w, z} rhs.outputs
  native : presentation.Genuine
  /-- The distinguished genuine output is represented exactly, not merely by
  an inclusion, by its encoded syntax output. -/
  native_region_eq :
    ∀ i,
      presentation.realize native i =
        rhs.outputs.realize (presentation.encode native) i
  /-- Genuine native q-volume calibration. -/
  nativeVolume :
    rhs.vol.processionVol (presentation.realize native) = Q.lhs
  processionVol_mono :
    ∀ {R S : ∀ i, rhs.container.AdmissibleRegion i},
      (∀ i, R i ≤ S i) →
        rhs.vol.processionVol R ≤ rhs.vol.processionVol S

namespace SemanticGeneratedNativeSource

/-- Convert a semantic genuine source to the generated source expected by the
public Corollary 3.12 construction. -/
noncomputable def toGeneratedNativeSource
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SemanticGeneratedNativeSource.{u, v, w, z} D Q) :
    GeneratedNativeSource.{u, v, w} D Q where
  rhs := S.rhs
  native := S.presentation.encode S.native
  nativeVolume := by
    have hregions :
        S.presentation.realize S.native =
          S.rhs.outputs.realize
            (S.presentation.encode S.native) := by
      funext i
      exact S.native_region_eq i
    rw [← hregions]
    exact S.nativeVolume
  processionVol_mono := S.processionVol_mono

/-- The semantic source constructs the actual public pilot witness. -/
noncomputable def toActualPilotWitness
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SemanticGeneratedNativeSource.{u, v, w, z} D Q) :
    ActualPilotWitness S.toGeneratedNativeSource.toVariantData :=
  S.toGeneratedNativeSource.toActualPilotWitness

/-- The genuine semantic source closes the standalone public Corollary 3.12
variant through the existing non-circular downstream theorem. -/
theorem corollary312Variant
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SemanticGeneratedNativeSource.{u, v, w, z} D Q) :
    Corollary312Variant S.toGeneratedNativeSource.toVariantData :=
  S.toGeneratedNativeSource.corollary312Variant

end SemanticGeneratedNativeSource

end IUTThreeClosures
