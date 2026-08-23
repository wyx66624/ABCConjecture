/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.ThetaData.Basic

/-!
# Fixed initial-theta cores and orbicurve enhancements

The phrase "one fixed IUT core" must be interpreted carefully.  The torsion
field, the type `(1, ell-tors)`, and the local theta objects genuinely depend
on the selected admissible prime.  They cannot all be placed in data fixed
before `ell` is chosen.

This module gives the exact dependent split.

* `FixedIUTCore` contains precisely the global arithmetic data independent of
  the admissible prime: `F`, its algebraic closure, the elliptic curve, the bad
  moduli-place locus, and the global initial-theta conditions.
* `InitialThetaFiber C` contains the prime-dependent torsion field,
  `OrbicurveData`, and `LocalThetaData` over one fixed core `C`.

The module also decomposes the existing public `OrbicurveData` into:

* `OrbicurveGeometricCore`: the two chosen orbicurves and the four covering
  arrows;
* `OrbicurveAnabelianEnhancement`: type/core/cartesian proofs together with
  the rank-one quotient and distinguished cusp data.

Both decompositions are exact constructors/projections.  They do not assert
that either the fixed core or a prime-dependent enhancement is inhabited.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField WeierstrassCurve

universe u

/-- The part of initial theta-data that is genuinely independent of the
admissible prime. -/
structure FixedIUTCore : Type (u + 1) where
  F : Type u
  [fieldF : Field F]
  [numberFieldF : NumberField F]
  Fbar : Type u
  [fieldFbar : Field Fbar]
  [algebraFbar : Algebra F Fbar]
  [isAlgClosure : IsAlgClosure F Fbar]
  E : WeierstrassCurve F
  [isElliptic : E.IsElliptic]
  VBad : Set (FinitePlace ↥(fieldOfModuli F E))
  global : IsInitialThetaGlobalData F E Fbar VBad

namespace FixedIUTCore

attribute [instance]
  fieldF numberFieldF fieldFbar algebraFbar isAlgClosure isElliptic

end FixedIUTCore

/-- All prime-dependent data over one fixed global IUT core. -/
structure InitialThetaFiber
    (AG : AnabelianGeometry.{u})
    (TG : TemperedGeometry AG)
    (C : FixedIUTCore.{u}) : Type (u + 1) where
  prime : AdmissiblePrimeData C.F C.E C.Fbar C.VBad
  [numberFieldK : NumberField ↥prime.torsionField]
  [algebraModK :
    Algebra ↥(fieldOfModuli C.F C.E) ↥prime.torsionField]
  [towerModK :
    IsScalarTower ↥(fieldOfModuli C.F C.E) C.F ↥prime.torsionField]
  orb :
    Iut.OrbicurveDataSection.OrbicurveData
      AG C.F C.E C.Fbar C.VBad prime
  localData :
    LocalThetaData
      AG TG C.F C.E C.Fbar C.VBad prime orb

namespace InitialThetaFiber

attribute [instance] numberFieldK algebraModK towerModK

/-- Assemble a public `InitialThetaData` object from one fixed core and one
prime-dependent fiber. -/
noncomputable def assemble
    {AG : AnabelianGeometry.{u}}
    {TG : TemperedGeometry AG}
    {C : FixedIUTCore.{u}}
    (X : InitialThetaFiber AG TG C) :
    InitialThetaData AG TG where
  F := C.F
  fieldF := C.fieldF
  numberFieldF := C.numberFieldF
  Fbar := C.Fbar
  fieldFbar := C.fieldFbar
  algebraFbar := C.algebraFbar
  isAlgClosure := C.isAlgClosure
  E := C.E
  isElliptic := C.isElliptic
  VBad := C.VBad
  global := C.global
  prime := X.prime
  numberFieldK := X.numberFieldK
  algebraModK := X.algebraModK
  towerModK := X.towerModK
  orb := X.orb
  localData := X.localData

end InitialThetaFiber

namespace FixedIUTCore

/-- Project the fixed global core from public initial theta-data. -/
noncomputable def ofInitialThetaData
    {AG : AnabelianGeometry.{u}}
    {TG : TemperedGeometry AG}
    (D : InitialThetaData AG TG) :
    FixedIUTCore.{u} where
  F := D.F
  fieldF := D.fieldF
  numberFieldF := D.numberFieldF
  Fbar := D.Fbar
  fieldFbar := D.fieldFbar
  algebraFbar := D.algebraFbar
  isAlgClosure := D.isAlgClosure
  E := D.E
  isElliptic := D.isElliptic
  VBad := D.VBad
  global := D.global

end FixedIUTCore

namespace InitialThetaFiber

/-- Project the prime-dependent fiber from public initial theta-data. -/
noncomputable def ofInitialThetaData
    {AG : AnabelianGeometry.{u}}
    {TG : TemperedGeometry AG}
    (D : InitialThetaData AG TG) :
    InitialThetaFiber AG TG
      (FixedIUTCore.ofInitialThetaData D) where
  prime := D.prime
  numberFieldK := D.numberFieldK
  algebraModK := D.algebraModK
  towerModK := D.towerModK
  orb := D.orb
  localData := D.localData

/-- The fixed-core/fiber decomposition reconstructs the original public data
exactly. -/
@[simp]
theorem assemble_ofInitialThetaData
    {AG : AnabelianGeometry.{u}}
    {TG : TemperedGeometry AG}
    (D : InitialThetaData AG TG) :
    (ofInitialThetaData D).assemble = D := by
  cases D
  rfl

end InitialThetaFiber

/-- Existence of public initial theta-data is exactly existence of a fixed
core with an inhabited prime-dependent fiber. -/
theorem initialThetaData_nonempty_iff_fixedCore_fiber
    {AG : AnabelianGeometry.{u}}
    {TG : TemperedGeometry AG} :
    Nonempty (InitialThetaData AG TG) ↔
      ∃ C : FixedIUTCore.{u},
        Nonempty (InitialThetaFiber AG TG C) := by
  constructor
  · rintro ⟨D⟩
    exact ⟨FixedIUTCore.ofInitialThetaData D,
      ⟨InitialThetaFiber.ofInitialThetaData D⟩⟩
  · rintro ⟨C, ⟨X⟩⟩
    exact ⟨X.assemble⟩

/-! ## Exact decomposition of public `OrbicurveData` -/

section OrbicurveSplit

variable (AG : AnabelianGeometry.{u})
variable (F : Type u) [Field F] [NumberField F]
variable (E : WeierstrassCurve F) [E.IsElliptic]
variable (Fbar : Type u) [Field Fbar] [Algebra F Fbar]
variable (VBad : Set (FinitePlace ↥(fieldOfModuli F E)))
variable (P : AdmissiblePrimeData F E Fbar VBad)

/-- Underlying orbicurves and covering arrows, before imposing the anabelian
type, core, cartesian and cuspidal conditions. -/
structure OrbicurveGeometricCore : Type u where
  CKu : AG.Orbicurve ↥P.torsionField
  XKu : AG.Orbicurve ↥P.torsionField
  XKu_to_XK :
    AG.Cover XKu
      (Iut.OrbicurveDataSection.XK AG F E Fbar VBad P)
  XKu_to_CKu : AG.Cover XKu CKu
  XK_to_CK :
    AG.Cover
      (Iut.OrbicurveDataSection.XK AG F E Fbar VBad P)
      (Iut.OrbicurveDataSection.CK AG F E Fbar VBad P)
  CKu_to_CK :
    AG.Cover CKu
      (Iut.OrbicurveDataSection.CK AG F E Fbar VBad P)

/-- The genuinely anabelian/cuspidal enhancement of one geometric core. -/
structure OrbicurveAnabelianEnhancement
    (C : OrbicurveGeometricCore AG F E Fbar VBad P) : Type u where
  CKu_type : AG.IsTypeOneEllTorsPM P.ℓ C.CKu
  CKu_core :
    AG.HasCore C.CKu
      (Iut.OrbicurveDataSection.CK AG F E Fbar VBad P)
  XKu_type : AG.IsTypeOneEllTors P.ℓ C.XKu
  diagram_cartesian :
    AG.IsCartesianSquare
      C.XKu_to_XK C.XK_to_CK C.XKu_to_CKu C.CKu_to_CK
  QIso : AG.RankOneQuotient C.CKu P.ℓ ≃ ZMod P.ℓ
  q : AG.RankOneQuotient C.CKu P.ℓ
  q_ne_zero : QIso q ≠ 0
  epsilon : AG.Cusp C.CKu
  epsilon_spec : epsilon = AG.cuspOfQuotient C.CKu P.ℓ q

namespace OrbicurveGeometricCore

/-- Project the geometric core from the public orbicurve package. -/
def ofOrbicurveData
    (O : Iut.OrbicurveDataSection.OrbicurveData
      AG F E Fbar VBad P) :
    OrbicurveGeometricCore AG F E Fbar VBad P where
  CKu := O.CKu
  XKu := O.XKu
  XKu_to_XK := O.XKu_to_XK
  XKu_to_CKu := O.XKu_to_CKu
  XK_to_CK := O.XK_to_CK
  CKu_to_CK := O.CKu_to_CK

end OrbicurveGeometricCore

namespace OrbicurveAnabelianEnhancement

/-- Project the anabelian enhancement from the public orbicurve package. -/
def ofOrbicurveData
    (O : Iut.OrbicurveDataSection.OrbicurveData
      AG F E Fbar VBad P) :
    OrbicurveAnabelianEnhancement AG F E Fbar VBad P
      (OrbicurveGeometricCore.ofOrbicurveData AG F E Fbar VBad P O) where
  CKu_type := O.CKu_type
  CKu_core := O.CKu_core
  XKu_type := O.XKu_type
  diagram_cartesian := O.diagram_cartesian
  QIso := O.QIso
  q := O.q
  q_ne_zero := O.q_ne_zero
  epsilon := O.epsilon
  epsilon_spec := O.epsilon_spec

/-- Assemble the exact public orbicurve package from a geometric core and its
anabelian enhancement. -/
def assemble
    (C : OrbicurveGeometricCore AG F E Fbar VBad P)
    (A : OrbicurveAnabelianEnhancement AG F E Fbar VBad P C) :
    Iut.OrbicurveDataSection.OrbicurveData
      AG F E Fbar VBad P where
  CKu := C.CKu
  CKu_type := A.CKu_type
  CKu_core := A.CKu_core
  XKu := C.XKu
  XKu_type := A.XKu_type
  XKu_to_XK := C.XKu_to_XK
  XKu_to_CKu := C.XKu_to_CKu
  XK_to_CK := C.XK_to_CK
  CKu_to_CK := C.CKu_to_CK
  diagram_cartesian := A.diagram_cartesian
  QIso := A.QIso
  q := A.q
  q_ne_zero := A.q_ne_zero
  epsilon := A.epsilon
  epsilon_spec := A.epsilon_spec

/-- Projecting and reassembling public orbicurve data is definitionally exact. -/
@[simp]
theorem assemble_ofOrbicurveData
    (O : Iut.OrbicurveDataSection.OrbicurveData
      AG F E Fbar VBad P) :
    assemble AG F E Fbar VBad P
      (OrbicurveGeometricCore.ofOrbicurveData
        AG F E Fbar VBad P O)
      (ofOrbicurveData AG F E Fbar VBad P O) = O := by
  cases O
  rfl

end OrbicurveAnabelianEnhancement

/-- Public orbicurve data exist exactly when some geometric core admits an
anabelian enhancement. -/
theorem orbicurveData_nonempty_iff_core_enhancement :
    Nonempty
      (Iut.OrbicurveDataSection.OrbicurveData
        AG F E Fbar VBad P) ↔
      ∃ C : OrbicurveGeometricCore AG F E Fbar VBad P,
        Nonempty
          (OrbicurveAnabelianEnhancement
            AG F E Fbar VBad P C) := by
  constructor
  · rintro ⟨O⟩
    exact ⟨OrbicurveGeometricCore.ofOrbicurveData
      AG F E Fbar VBad P O,
      ⟨OrbicurveAnabelianEnhancement.ofOrbicurveData
        AG F E Fbar VBad P O⟩⟩
  · rintro ⟨C, ⟨A⟩⟩
    exact ⟨OrbicurveAnabelianEnhancement.assemble
      AG F E Fbar VBad P C A⟩

end OrbicurveSplit

end IUTThreeClosures
