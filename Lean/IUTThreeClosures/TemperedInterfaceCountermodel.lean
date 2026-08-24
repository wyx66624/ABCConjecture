/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.ThetaData.LocalConditions

/-!
# A countermodel to uniform inhabitation of the tempered interface

`TemperedGeometry.IsThetaRootModel` is an interface predicate.  The remaining
fields of a `TemperedGeometry` do not force this predicate to hold: starting
from any tempered interface, one may keep all of its groups, topologies,
comparison maps and graph cusps while replacing `IsThetaRootModel` by the
constantly false predicate.

Consequently, when the bad-place locus is nonempty, `LocalThetaData` cannot be
constructed uniformly for every abstract `TemperedGeometry`.  This is a strict
counterexample to the route that attempts to inhabit the public local-theta
package from its type alone.  A valid proof must instead construct a specific
mathematical tempered geometry and prove its theta-root theorem, or strengthen
the interface by adding a genuine realization theorem.

The counterexample does not rule out the actual tempered-fundamental-group and
etale-theta direction.  It rules out only the logically invalid claim that the
current abstract interface fields already imply their own source conditions.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField WeierstrassCurve

universe u

namespace TemperedGeometry

variable {AG : AnabelianGeometry.{u}}

/-- Keep all structural tempered data but make the theta-root-model predicate
constantly false. -/
def withFalseThetaRootModel (TG : TemperedGeometry AG) :
    TemperedGeometry AG where
  tempPi1 := TG.tempPi1
  tempPi1Group := TG.tempPi1Group
  tempPi1Topology := TG.tempPi1Topology
  tempToEtale := TG.tempToEtale
  tempToEtale_continuous := TG.tempToEtale_continuous
  IsThetaRootModel := fun _ _ => False
  canonicalGraphCusp := TG.canonicalGraphCusp

/-- The modified interface has no theta-root models. -/
theorem not_isThetaRootModel_withFalse
    (TG : TemperedGeometry AG)
    {k : Type u} [Field k]
    (ell : ℕ) (X : AG.Orbicurve k) :
    ¬ (TG.withFalseThetaRootModel).IsThetaRootModel ell X := by
  intro h
  exact h

end TemperedGeometry

section LocalThetaCountermodel

variable (AG : AnabelianGeometry.{u})
variable (TG : TemperedGeometry AG)
variable (F : Type u) [Field F] [NumberField F]
variable (E : WeierstrassCurve F) [E.IsElliptic]
variable (Fbar : Type u) [Field Fbar] [Algebra F Fbar]
variable [IsAlgClosure F Fbar]
variable (VBad : Set (FinitePlace ↥(fieldOfModuli F E)))
variable (P : AdmissiblePrimeData F E Fbar VBad)
variable [NumberField ↥P.torsionField]
variable [Algebra ↥(fieldOfModuli F E) ↥P.torsionField]
variable
  (O : Iut.OrbicurveDataSection.OrbicurveData
    AG F E Fbar VBad P)

/-- If there is a bad place, the false-theta-root tempered interface admits no
public local theta-data. -/
theorem noLocalThetaData_withFalseThetaRootModel
    (hbad : VBad.Nonempty) :
    IsEmpty
      (LocalThetaData AG TG.withFalseThetaRootModel
        F E Fbar VBad P O) := by
  refine ⟨?_⟩
  intro L
  rcases hbad with ⟨v, hv⟩
  exact L.bad_theta_model v hv

/-- There is no construction of local theta-data that works uniformly for all
abstract tempered interfaces when the bad-place locus is nonempty. -/
theorem no_uniform_localThetaData_over_temperedInterfaces
    (hbad : VBad.Nonempty) :
    ¬ ∀ T : TemperedGeometry AG,
      Nonempty (LocalThetaData AG T F E Fbar VBad P O) := by
  intro h
  rcases h TG.withFalseThetaRootModel with ⟨L⟩
  exact
    (noLocalThetaData_withFalseThetaRootModel
      AG TG F E Fbar VBad P O hbad).false L

end LocalThetaCountermodel

end IUTThreeClosures
