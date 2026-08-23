/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualPilotWitness

/-!
# A standalone Corollary 3.12 statement and its inequality ledger

This module contains no abc target and no downstream height theorem. For one
public Corollary 3.12 data bundle `X`, the standalone proposition is exactly

`X.qPilot.lhs <= X.rhsData.rhs`.

Starting from an `ActualPilotWitness`, the proof is exposed as six named
steps rather than compressed into one calculation:

1. the native region lies in the generated theta-pilot region;
2. the theta-pilot region lies in its holomorphic hull;
3. hence the native region lies in the theta hull;
4. the native procession volume is the q-pilot left-hand side;
5. monotonicity bounds native volume by theta-hull volume;
6. theta-hull procession volume is definitionally the public right-hand side.

The final standalone theorem and the coefficient inequality `-1 <= CTheta`
are derived only after these ledger entries have been established. No field
of any structure has the standalone proposition, a q-bound, a height bound or
`ABCConjecture` as its codomain.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- The exact target-free numerical statement used in this formalization of
Corollary 3.12. -/
noncomputable def StandaloneCorollary312
    (X : Corollary312VariantData.{u, v} AG TG) : Prop :=
  X.qPilot.lhs ≤ X.rhsData.rhs

/-- The standalone statement is definitionally the public variant statement. -/
theorem standaloneCorollary312_iff_public
    (X : Corollary312VariantData.{u, v} AG TG) :
    StandaloneCorollary312 X ↔ Corollary312Variant X :=
  Iff.rfl

namespace Cor312InequalityLedger

variable {X : Corollary312VariantData.{u, v} AG TG}

/-- Ledger entry 1: the actual native q-pilot region lies in the supplied
actual theta-pilot region. -/
theorem native_le_thetaPilot (W : ActualPilotWitness X) :
    ∀ i, W.region i ≤ X.rhsData.thetaPilot i :=
  W.region_le_thetaPilot

/-- Ledger entry 2: every public theta-pilot region lies in its holomorphic
hull. -/
theorem thetaPilot_le_thetaHull :
    ∀ i, X.rhsData.thetaPilot i ≤ X.rhsData.thetaHull i := by
  intro i
  change X.rhsData.thetaPilot i ≤
    X.rhsData.hull.hullAdmissible (X.rhsData.thetaPilot i)
  exact X.rhsData.hull.le_hullAdmissible
    (X.rhsData.thetaPilot_hullAdmissible i)

/-- Ledger entry 3: the native q-pilot region lies in the public theta hull. -/
theorem native_le_thetaHull (W : ActualPilotWitness X) :
    ∀ i, W.region i ≤ X.rhsData.thetaHull i := by
  intro i vQ x hx
  exact thetaPilot_le_thetaHull (X := X) i vQ
    (native_le_thetaPilot W i vQ hx)

/-- Procession volume of the actual native q-pilot family. -/
noncomputable def nativeVolume (W : ActualPilotWitness X) : ℝ :=
  X.rhsData.vol.processionVol W.region

/-- Procession volume of the actual public theta-hull family. -/
noncomputable def thetaHullVolume : ℝ :=
  X.rhsData.vol.processionVol X.rhsData.thetaHull

/-- Ledger entry 4: native volume is exactly the public q-pilot left-hand
side. -/
theorem nativeVolume_eq_lhs (W : ActualPilotWitness X) :
    nativeVolume W = X.qPilot.lhs :=
  W.qVolume

/-- Ledger entry 5: monotonicity carries native-region inclusion to the
procession-volume inequality. -/
theorem nativeVolume_le_thetaHullVolume (W : ActualPilotWitness X) :
    nativeVolume W ≤ thetaHullVolume (X := X) := by
  exact W.processionVol_mono (native_le_thetaHull W)

/-- Ledger entry 6: the public right-hand side is definitionally the
procession volume of the actual holomorphic theta hull. -/
theorem thetaHullVolume_eq_rhs :
    thetaHullVolume (X := X) = X.rhsData.rhs :=
  rfl

/-- The complete target-free Corollary 3.12 inequality, assembled only from
the six ledger entries above. -/
theorem standalone (W : ActualPilotWitness X) : StandaloneCorollary312 X := by
  show X.qPilot.lhs ≤ X.rhsData.rhs
  calc
    X.qPilot.lhs = nativeVolume W := (nativeVolume_eq_lhs W).symm
    _ ≤ thetaHullVolume (X := X) := nativeVolume_le_thetaHullVolume W
    _ = X.rhsData.rhs := thetaHullVolume_eq_rhs (X := X)

/-- Public specialization of the same ledger proof. -/
theorem toPublic (W : ActualPilotWitness X) : Corollary312Variant X :=
  (standaloneCorollary312_iff_public X).mp (standalone W)

end Cor312InequalityLedger

/-- The canonical public theta coefficient attached to the standalone
inequality. -/
noncomputable def standaloneThetaCoefficient
    (X : Corollary312VariantData.{u, v} AG TG) : ℝ :=
  X.rhsData.rhs / X.qPilot.absLogQ

/-- The standalone Corollary 3.12 inequality gives the exact normalized
coefficient lower bound, provided the actual q-logarithm is positive. -/
theorem standaloneThetaCoefficient_ge_neg_one
    (X : Corollary312VariantData.{u, v} AG TG)
    (hq : 0 < X.qPilot.absLogQ)
    (h312 : StandaloneCorollary312 X) :
    -1 ≤ standaloneThetaCoefficient X := by
  rw [standaloneThetaCoefficient]
  apply (le_div_iff₀ hq).2
  simpa [StandaloneCorollary312, QPilotData.lhs] using h312

/-- An actual native-region witness produces the coefficient bound through the
standalone ledger, without any downstream target field. -/
theorem standaloneThetaCoefficient_ge_neg_one_of_witness
    {X : Corollary312VariantData.{u, v} AG TG}
    (W : ActualPilotWitness X)
    (hq : 0 < X.qPilot.absLogQ) :
    -1 ≤ standaloneThetaCoefficient X :=
  standaloneThetaCoefficient_ge_neg_one X hq
    (Cor312InequalityLedger.standalone W)

end IUTThreeClosures
