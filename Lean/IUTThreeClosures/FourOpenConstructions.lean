/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NonCircularDownstream

/-!
# The four-stage non-circular closure programme

This file states the four rows in the research status table with the correct dependent
quantifiers. It proves the fourth row from the first three. It does not construct the
first three rows.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}

/-- The three genuine construction stages preceding the final theorem. -/
structure FourStageProgram : Type
    (max (u + 1) (v + 1) (w + 1) (z + 1)) where
  /-- Stage 1: a pointwise actual initial-theta family and q-pilot data. -/
  upstream : UpstreamCertificate.{u, v, w, z}
    (AG := AG) (TG := TG) (Input := Input)
  /-- Stage 2 is already part of `upstream`: the actual IUT III output source family. -/
  /-- Stage 3: a non-circular uniform IUT IV geometric bridge. -/
  downstream : NonCircularIUTIVBridge upstream.family

namespace FourStageProgram

/-- Stage 1 projected explicitly. -/
noncomputable def actualInitialThetaDataOf
    (P : FourStageProgram.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) :
    Input → InitialThetaData AG TG :=
  P.upstream.actualInitialThetaDataOf

/-- The associated q-pilot data family. -/
noncomputable def actualQPilotDataOf
    (P : FourStageProgram.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) :
    ∀ x, QPilotData (P.actualInitialThetaDataOf x) :=
  P.upstream.actualQPilotDataOf

/-- Stage 2 projected explicitly. -/
noncomputable def actualIUTIIIOutputSourceOf
    (P : FourStageProgram.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) :
    ∀ x, GeneratedNativeSource.{u, v, w}
      (P.actualInitialThetaDataOf x) (P.actualQPilotDataOf x) :=
  P.upstream.actualIUTIIIOutputSourceOf

/-- Stage 4: the unparameterized abc theorem follows from a completed programme. -/
theorem abc_conjecture
    (P : FourStageProgram.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) :
    ABCConjecture :=
  P.downstream.abc

end FourStageProgram

/-- Exact remaining inhabitation proposition. -/
def FourStagesInhabited : Prop :=
  Nonempty (FourStageProgram.{u, v, w, z}
    (AG := AG) (TG := TG) (Input := Input))

/-- Inhabitation of all three construction stages gives the fourth row. -/
theorem abc_of_four_stages_inhabited
    (h : FourStagesInhabited.{u, v, w, z}
      (AG := AG) (TG := TG) (Input := Input)) :
    ABCConjecture := by
  rcases h with ⟨P⟩
  exact P.abc_conjecture

end IUTThreeClosures
