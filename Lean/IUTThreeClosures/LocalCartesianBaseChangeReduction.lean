/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.ThetaData.LocalConditions

/-!
# Local cartesian diagrams from one generic base-change law

The public `OrbicurveData` already contains a global cartesian covering square.
The public `LocalThetaData` repeats, at every selected finite place, the claim
that its base change to the completion remains cartesian.  In genuine
algebraic geometry this is not a new place-by-place theorem: pullback squares
are stable under base change.

The abstract `AnabelianGeometry` interface exposes a predicate
`IsCartesianSquare` and an operation `coverBaseChange`, but does not itself
state their compatibility.  This module isolates the missing generic law as
`CartesianCoverBaseChangeLaw`.  Once this one functorial law is supplied, every
local cartesian field is obtained automatically from the global square.

The final assembly theorem also uses the closed full subgroup for the current
under-specified public decomposition-group field.  Hence, under the generic
base-change law, the genuinely local obligations reduce to

* a valuation section;
* the bad-place type theorem;
* the theta-root-model theorem;
* canonical graph-cusp compatibility.

No assertion is made that the full subgroup is the genuine decomposition
group.  A stronger public interface must add the relevant stabilizer
characterization.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField WeierstrassCurve

universe u

/-- Base change of a cartesian covering square is cartesian.  This is a single
generic functorial law, not one hypothesis for each arithmetic place. -/
structure CartesianCoverBaseChangeLaw
    (AG : AnabelianGeometry.{u}) : Type (u + 1) where
  preserve :
    ∀ {k K : Type u} [Field k] [Field K]
      (f : k →+* K)
      {A B C D : AG.Orbicurve k}
      (AB : AG.Cover A B)
      (BD : AG.Cover B D)
      (AC : AG.Cover A C)
      (CD : AG.Cover C D),
      AG.IsCartesianSquare AB BD AC CD →
      AG.IsCartesianSquare
        (AG.coverBaseChange f AB)
        (AG.coverBaseChange f BD)
        (AG.coverBaseChange f AC)
        (AG.coverBaseChange f CD)

section LocalAssembly

variable (AG : AnabelianGeometry.{u})
variable (TG : TemperedGeometry AG)
variable (BC : CartesianCoverBaseChangeLaw AG)
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

/-- The genuinely local source fields after removing the automatic cartesian
and currently weak decomposition-group fields. -/
structure ReducedLocalThetaSource : Type u where
  sect : ValuationSection F E Fbar VBad P
  bad_type : ∀ v ∈ VBad,
    AG.IsTypeOneZModPM P.ℓ
      (localize (sect.sectFin v) O.XKu)
  bad_theta_model : ∀ v ∈ VBad,
    TG.IsThetaRootModel P.ℓ
      (localize (sect.sectFin v) O.XKu)
  epsilon_graph : ∀ v ∈ VBad,
    AG.cuspBaseChange
        (FinitePlace.embedding (sect.sectFin v).maximalIdeal)
        O.epsilon =
      TG.canonicalGraphCusp
        (localize (sect.sectFin v) O.CKu)

namespace ReducedLocalThetaSource

/-- The local covering square follows from the global square by the single
base-change law. -/
theorem local_diagram_cartesian
    (L : ReducedLocalThetaSource AG TG F E Fbar VBad P O)
    (v : FinitePlace ↥(fieldOfModuli F E)) :
    AG.IsCartesianSquare
      (AG.coverBaseChange
        (FinitePlace.embedding (L.sect.sectFin v).maximalIdeal)
        O.XKu_to_XK)
      (AG.coverBaseChange
        (FinitePlace.embedding (L.sect.sectFin v).maximalIdeal)
        O.XK_to_CK)
      (AG.coverBaseChange
        (FinitePlace.embedding (L.sect.sectFin v).maximalIdeal)
        O.XKu_to_CKu)
      (AG.coverBaseChange
        (FinitePlace.embedding (L.sect.sectFin v).maximalIdeal)
        O.CKu_to_CK) :=
  BC.preserve
    (FinitePlace.embedding (L.sect.sectFin v).maximalIdeal)
    O.XKu_to_XK O.XK_to_CK O.XKu_to_CKu O.CKu_to_CK
    O.diagram_cartesian

/-- Assemble the current public local theta-data.  The public decomposition
subgroup is filled by the closed full group because no stabilizer property is
present in the current type. -/
noncomputable def toLocalThetaData
    (L : ReducedLocalThetaSource AG TG F E Fbar VBad P O) :
    LocalThetaData AG TG F E Fbar VBad P O where
  sect := L.sect
  local_diagram_cartesian :=
    L.local_diagram_cartesian AG TG BC F E Fbar VBad P O
  decomp := fun _ => ⊤
  decomp_isClosed := by
    intro v
    simpa using
      (isClosed_univ :
        IsClosed (Set.univ : Set (Fbar ≃ₐ[↥P.torsionField] Fbar)))
  bad_type := L.bad_type
  bad_theta_model := L.bad_theta_model
  epsilon_graph := L.epsilon_graph

end ReducedLocalThetaSource

/-- Under a cartesian base-change law, inhabiting the reduced local source is
sufficient for inhabiting the public local theta package. -/
theorem localThetaData_nonempty_of_reducedSource
    (L : Nonempty
      (ReducedLocalThetaSource AG TG F E Fbar VBad P O)) :
    Nonempty (LocalThetaData AG TG F E Fbar VBad P O) := by
  rcases L with ⟨L⟩
  exact ⟨L.toLocalThetaData AG TG BC F E Fbar VBad P O⟩

end LocalAssembly

end IUTThreeClosures
