/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MultiradialPresentationTransfer
import IUTThreeClosures.GeneratedSource

/-!
# Procession-level semantic transfer

A genuine IUT III output and the generated Ind1/Ind2/Ind3 syntax need not be
definitionally the same object. It is enough to compare the admissible regions
they represent, capsule by capsule.

Over an already constructed `GeneratedRHSData`, sound encoding and complete
decoding identify the genuine and generated possible-image unions at every
capsule and rational place. A genuine distinguished q-output with exact region
and procession-volume calibration then yields the existing
`GeneratedNativeSource`, hence `ActualPilotWitness` and the standalone public
Corollary 3.12 variant.

No Corollary 3.12 inequality, component upper estimate, q-bound, height bound
or abc statement occurs as a source field.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w x

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

structure ProcessionSemanticPresentation
    (G : GeneratedRHSData.{u, v, w} D) where
  Genuine : Type x
  genuineNonempty : Nonempty Genuine
  realize : Genuine → ∀ i, G.container.AdmissibleRegion i
  encode : Genuine → G.outputs.Output
  encode_sound :
    ∀ (g : Genuine) (i : Fin G.container.proc.length),
      realize g i ≤ G.outputs.realize (encode g) i
  decode : G.outputs.Output → Genuine
  decode_complete :
    ∀ (s : G.outputs.Output) (i : Fin G.container.proc.length),
      G.outputs.realize s i ≤ realize (decode s) i

namespace ProcessionSemanticPresentation

variable {G : GeneratedRHSData.{u, v, w} D}
variable (P : ProcessionSemanticPresentation.{u, v, w, x} G)

theorem genuineUnion_le_generatedUnion
    (i : Fin G.container.proc.length)
    (vQ : RationalPlace) :
    (⋃ g : P.Genuine, (P.realize g i).region vQ) ⊆
      (⋃ s : G.outputs.Output, (G.outputs.realize s i).region vQ) := by
  intro y hy
  rcases Set.mem_iUnion.mp hy with ⟨g, hgy⟩
  exact Set.mem_iUnion.mpr
    ⟨P.encode g, P.encode_sound g i vQ hgy⟩

theorem generatedUnion_le_genuineUnion
    (i : Fin G.container.proc.length)
    (vQ : RationalPlace) :
    (⋃ s : G.outputs.Output, (G.outputs.realize s i).region vQ) ⊆
      (⋃ g : P.Genuine, (P.realize g i).region vQ) := by
  intro y hy
  rcases Set.mem_iUnion.mp hy with ⟨s, hsy⟩
  exact Set.mem_iUnion.mpr
    ⟨P.decode s, P.decode_complete s i vQ hsy⟩

theorem genuineUnion_eq_generatedUnion
    (i : Fin G.container.proc.length)
    (vQ : RationalPlace) :
    (⋃ g : P.Genuine, (P.realize g i).region vQ) =
      (⋃ s : G.outputs.Output, (G.outputs.realize s i).region vQ) :=
  Set.Subset.antisymm
    (P.genuineUnion_le_generatedUnion i vQ)
    (P.generatedUnion_le_genuineUnion i vQ)

end ProcessionSemanticPresentation

structure SemanticGeneratedNativeSource
    (D : InitialThetaData AG TG)
    (Q : QPilotData D) where
  rhs : GeneratedRHSData.{u, v, w} D
  presentation :
    ProcessionSemanticPresentation.{u, v, w, x} rhs
  native : presentation.Genuine
  native_region_eq :
    ∀ i : Fin rhs.container.proc.length,
      presentation.realize native i =
        rhs.outputs.realize (presentation.encode native) i
  nativeVolume :
    rhs.vol.processionVol (presentation.realize native) = Q.lhs
  processionVol_mono :
    ∀ {R S : ∀ i, rhs.container.AdmissibleRegion i},
      (∀ i, R i ≤ S i) →
        rhs.vol.processionVol R ≤ rhs.vol.processionVol S

namespace SemanticGeneratedNativeSource

noncomputable def toGeneratedNativeSource
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    GeneratedNativeSource.{u, v, w} D Q where
  rhs := S.rhs
  native := S.presentation.encode S.native
  nativeVolume := by
    have hfamily :
        (fun i =>
          S.rhs.outputs.realize
            (S.presentation.encode S.native) i) =
          S.presentation.realize S.native := by
      funext i
      exact (S.native_region_eq i).symm
    rw [hfamily]
    exact S.nativeVolume
  processionVol_mono := S.processionVol_mono

noncomputable def toVariantData
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    Corollary312VariantData.{u, v} AG TG :=
  S.toGeneratedNativeSource.toVariantData

noncomputable def toActualPilotWitness
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    ActualPilotWitness S.toVariantData :=
  S.toGeneratedNativeSource.toActualPilotWitness

theorem corollary312Variant
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    Corollary312Variant S.toVariantData :=
  S.toGeneratedNativeSource.corollary312Variant

end SemanticGeneratedNativeSource

end IUTThreeClosures
