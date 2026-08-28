/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.ThetaData.Basic

/-!
# Actual bad-place local theta-theater data

This module does not postulate a new local model.  Starting from an already
constructed `InitialThetaData`, it projects the concrete objects used at a bad
finite place: the field-of-moduli place, the selected torsion-field place, the
localized theta-root orbicurve, its tempered fundamental group, the canonical
cusp, and the genuine Tate parameter and normalized uniformizer.

It is deliberately only a projection theorem.  The pointwise existence of
`InitialThetaData` remains a separate global arithmetic-geometric problem.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField TateCurvesTheta

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- A bad finite place occurring in actual initial theta data. -/
structure ActualBadHodgeTheaterPlace
    (D : InitialThetaData AG TG) where
  w : FinitePlace D.F
  hw : w ∈ badPlacesOver D.F D.E D.VBad

namespace ActualBadHodgeTheaterPlace

variable {D : InitialThetaData AG TG}
variable (H : ActualBadHodgeTheaterPlace D)

/-- A field-of-moduli bad place below the chosen global bad place. -/
theorem exists_modPlace :
    ∃ v : FinitePlace ↥(fieldOfModuli D.F D.E),
      v ∈ D.VBad ∧ H.w.1.LiesOver v.1 := by
  simpa [badPlacesOver] using H.hw

/-- Source-derived field-of-moduli bad place. -/
noncomputable def modPlace :
    FinitePlace ↥(fieldOfModuli D.F D.E) :=
  Classical.choose H.exists_modPlace

/-- The derived place belongs to the selected bad-place set. -/
theorem modPlace_mem : H.modPlace ∈ D.VBad :=
  (Classical.choose_spec H.exists_modPlace).1

/-- The original global place lies over the derived moduli place. -/
theorem liesOver_modPlace : H.w.1.LiesOver H.modPlace.1 :=
  (Classical.choose_spec H.exists_modPlace).2

/-- Place of the torsion field selected by the actual valuation section. -/
noncomputable def selectedKPlace : FinitePlace ↥D.prime.torsionField :=
  D.localData.sect.sectFin H.modPlace

/-- Actual localized theta-root orbicurve. -/
noncomputable def localThetaOrbicurve :
    AG.Orbicurve (localCompletion H.selectedKPlace) :=
  localize H.selectedKPlace D.orb.XKu

/-- Actual tempered fundamental group at the bad place. -/
noncomputable def temperedPi : Type u :=
  D.localData.PivBad H.modPlace

/-- The localized model has the required `(1,Z/ell Z)^±` type. -/
theorem local_type_one_zmod :
    AG.IsTypeOneZModPM D.prime.ℓ H.localThetaOrbicurve :=
  D.localData.bad_type H.modPlace H.modPlace_mem

/-- The localized model is an actual theta-root model. -/
theorem local_isThetaRootModel :
    TG.IsThetaRootModel D.prime.ℓ H.localThetaOrbicurve :=
  D.localData.bad_theta_model H.modPlace H.modPlace_mem

/-- The distinguished cusp is the canonical graph cusp. -/
theorem local_epsilon_graph :
    AG.cuspBaseChange
        (FinitePlace.embedding H.selectedKPlace.maximalIdeal) D.orb.epsilon =
      TG.canonicalGraphCusp (localize H.selectedKPlace D.orb.CKu) :=
  D.localData.epsilon_graph H.modPlace H.modPlace_mem

/-- Completed local field at the original bad place. -/
noncomputable abbrev TateField := localCompletion H.w

/-- Genuine local Tate parameter. -/
noncomputable def tate : TateParameter H.TateField :=
  D.prime.tate H.w H.hw

/-- Genuine normalized uniformizer. -/
noncomputable def uniformizer : H.TateField :=
  D.prime.unif H.w H.hw

/-- The selected local element is a uniformizer. -/
theorem uniformizer_isUniformizer : IsUniformizer H.uniformizer :=
  D.prime.unif_isUniformizer H.w H.hw

/-- Actual positive normalized order of the Tate parameter. -/
noncomputable def qOrder : ℕ := D.prime.qOrder H.w H.hw

/-- Positivity of the actual Tate order. -/
theorem qOrder_pos : 0 < H.qOrder :=
  D.prime.qOrder_pos H.w H.hw

end ActualBadHodgeTheaterPlace

end IUTThreeClosures
