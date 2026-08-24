/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneratedSource

/-!
# One-sided semantic soundness for the Corollary 3.12 source

Exact equality between genuine Hodge-theater outputs and the generated
Ind1/Ind2/Ind3 syntax is desirable but stronger than the lower native-witness
argument requires.

Suppose every genuine output has a sound generated representation, and a
distinguished genuine q-output is represented exactly and has the calibrated
native procession volume.  Then the existing generated syntax itself already
produces `GeneratedNativeSource` and `ActualPilotWitness`; no decoding or
completeness theorem is needed for this implication.

This one-sided route is valid when the generated over-approximation is also
controlled by the independently proved log-shell/component envelope.  Exact
semantic completeness remains a separate route for identifying the generated
union with the paper's literal possible-image union.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w x

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- A genuine source with only a sound map into the generated syntax. -/
structure SoundSemanticGeneratedNativeSource
    (D : InitialThetaData AG TG)
    (Q : QPilotData D) where
  rhs : GeneratedRHSData.{u, v, w} D
  Genuine : Type x
  genuineNonempty : Nonempty Genuine
  realize : Genuine → ∀ i, rhs.container.AdmissibleRegion i
  encode : Genuine → rhs.outputs.Output
  encode_sound :
    ∀ (g : Genuine) (i : Fin rhs.container.proc.length),
      realize g i ≤ rhs.outputs.realize (encode g) i
  native : Genuine
  native_region_eq :
    ∀ i : Fin rhs.container.proc.length,
      realize native i = rhs.outputs.realize (encode native) i
  nativeVolume :
    rhs.vol.processionVol (realize native) = Q.lhs
  processionVol_mono :
    ∀ {R S : ∀ i, rhs.container.AdmissibleRegion i},
      (∀ i, R i ≤ S i) →
        rhs.vol.processionVol R ≤ rhs.vol.processionVol S

namespace SoundSemanticGeneratedNativeSource

noncomputable def toGeneratedNativeSource
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SoundSemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    GeneratedNativeSource.{u, v, w} D Q where
  rhs := S.rhs
  native := S.encode S.native
  nativeVolume := by
    have hfamily :
        (fun i => S.rhs.outputs.realize (S.encode S.native) i) =
          S.realize S.native := by
      funext i
      exact (S.native_region_eq i).symm
    rw [hfamily]
    exact S.nativeVolume
  processionVol_mono := S.processionVol_mono

noncomputable def toVariantData
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SoundSemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    Corollary312VariantData.{u, v} AG TG :=
  S.toGeneratedNativeSource.toVariantData

noncomputable def toActualPilotWitness
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SoundSemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    ActualPilotWitness S.toVariantData :=
  S.toGeneratedNativeSource.toActualPilotWitness

theorem corollary312Variant
    {D : InitialThetaData AG TG} {Q : QPilotData D}
    (S : SoundSemanticGeneratedNativeSource.{u, v, w, x} D Q) :
    Corollary312Variant S.toVariantData :=
  S.toGeneratedNativeSource.corollary312Variant

end SoundSemanticGeneratedNativeSource

end IUTThreeClosures
