/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.ThetaData.Basic

/-!
# A countermodel to interface-uniform initial theta-data existence

`InitialThetaData AG TG` is parametrized by an anabelian interface and a tempered
interface. Consequently, no theorem quantified over *arbitrary* interfaces can
construct initial theta-data: the interface predicates may themselves rule out every
core.

This module makes that obstruction kernel-checkable at universe zero. It constructs
an inhabited interface whose orbicurve, covering, fundamental-group, cusp and
tempered types are all trivial, but whose `HasCore` predicate is identically false.
The corresponding `InitialThetaData` type is empty because its
`OrbicurveData.CKu_core` field would be a proof of `False`.

This does not rule out initial theta-data for the intended concrete anabelian and
tempered geometries. It proves that an honest existence theorem must construct those
concrete interfaces first, or state their exact realization hypotheses; it cannot be
polymorphic in arbitrary `AG` and `TG`.
-/

namespace IUTThreeClosures

open Iut

/-- A deliberately hostile, but internally consistent, anabelian interface. All
underlying objects are trivial; only the core predicate is empty. -/
noncomputable def falseCoreAnabelianGeometry : AnabelianGeometry.{0} where
  Orbicurve := fun _ => PUnit
  Cover := fun _ _ => PUnit
  coverComp := fun _ _ => PUnit.unit
  baseChange := fun _ _ => PUnit.unit
  coverBaseChange := fun _ _ => PUnit.unit
  oncePunctured := fun _ => PUnit.unit
  pmQuotient := fun _ => PUnit.unit
  pi1 := fun _ => ProfiniteGrp.of PUnit
  pi1Cover := fun _ => MonoidHom.id PUnit
  pi1Cover_continuous := by
    intro k _ X Y f
    exact continuous_id
  pi1Cover_isOpenEmbedding := by
    intro k _ X Y f
    simpa using (Homeomorph.refl PUnit).isOpenEmbedding
  IsCartesianSquare := fun _ _ _ _ => True
  Cusp := fun _ => PUnit
  cuspBaseChange := fun _ _ => PUnit.unit
  HasCore := fun _ _ => False
  IsTypeOneEllTors := fun _ _ => True
  IsTypeOneEllTorsPM := fun _ _ => True
  IsTypeOneZModPM := fun _ _ => True
  RankOneQuotient := fun _ _ => PUnit
  cuspOfQuotient := fun _ _ _ => PUnit.unit

/-- A trivial tempered interface over `falseCoreAnabelianGeometry`. -/
noncomputable def falseCoreTemperedGeometry :
    TemperedGeometry falseCoreAnabelianGeometry where
  tempPi1 := fun _ => PUnit
  tempPi1Group := by
    intro k _ X
    infer_instance
  tempPi1Topology := by
    intro k _ X
    infer_instance
  tempToEtale := by
    intro k _ X
    exact MonoidHom.id PUnit
  tempToEtale_continuous := by
    intro k _ X
    exact continuous_id
  IsThetaRootModel := fun _ _ => True
  canonicalGraphCusp := fun _ => PUnit.unit

/-- Initial theta-data cannot exist uniformly for arbitrary interfaces. In this
countermodel its required core witness is literally a proof of `False`. -/
theorem falseCore_initialThetaData_isEmpty :
    IsEmpty
      (InitialThetaData
        falseCoreAnabelianGeometry
        falseCoreTemperedGeometry) := by
  constructor
  intro D
  have h := D.orb.CKu_core
  change False at h
  exact h

/-- Propositional form of the same obstruction. -/
theorem not_nonempty_initialThetaData_for_all_interfaces :
    ¬ Nonempty
      (InitialThetaData
        falseCoreAnabelianGeometry
        falseCoreTemperedGeometry) := by
  intro h
  exact falseCore_initialThetaData_isEmpty.false h.some

end IUTThreeClosures
