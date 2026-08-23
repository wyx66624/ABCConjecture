/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FixedCoreOrbicurveDecomposition
import IUTThreeClosures.LocalThetaQPacketTemperedSplit

/-!
# Automatic choices inside an initial-theta fiber

Two portions of the public `OrbicurveData`/`LocalThetaData` packages look like
geometric existence problems but are in fact automatic once the preceding
structural data are available.

First, after choosing an identification

`Q ≃ ZMod ell`

of the rank-one quotient, the distinguished nonzero quotient element may be
taken to be the inverse image of `1`; its cusp is then definitionally
`cuspOfQuotient` of this element. Thus the quotient element and cusp do not
form an independent existence seam.

Second, the public `LocalThetaData.decomp` field currently asks only for a
closed subgroup at every finite place and imposes no characterizing
relationship with a place. The full subgroup is therefore a canonical closed
choice. Thus decomposition-group choice is not an independent obstruction in
the present public interface; any stronger arithmetic meaning must be added as
an explicit future condition.

This module packages both reductions and proves exact nonemptiness
equivalences. It does not construct orbicurves, coverings, cores, valuation
sections, cartesian local diagrams, theta-root models, tempered groups or the
IUT III source.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField WeierstrassCurve

universe u

/-! ## Canonical quotient element and distinguished cusp -/

section OrbicurveAutomaticChoices

variable (AG : AnabelianGeometry.{u})
variable (F : Type u) [Field F] [NumberField F]
variable (E : WeierstrassCurve F) [E.IsElliptic]
variable (Fbar : Type u) [Field Fbar] [Algebra F Fbar]
variable (VBad : Set (FinitePlace ↥(fieldOfModuli F E)))
variable (P : AdmissiblePrimeData F E Fbar VBad)
variable
  (C : OrbicurveGeometricCore AG F E Fbar VBad P)

/-- The non-cuspidal structural content of the anabelian enhancement. -/
structure OrbicurveStructuralEnhancement : Type u where
  CKu_type : AG.IsTypeOneEllTorsPM P.ℓ C.CKu
  CKu_core :
    AG.HasCore C.CKu
      (Iut.OrbicurveDataSection.CK AG F E Fbar VBad P)
  XKu_type : AG.IsTypeOneEllTors P.ℓ C.XKu
  diagram_cartesian :
    AG.IsCartesianSquare
      C.XKu_to_XK C.XK_to_CK C.XKu_to_CKu C.CKu_to_CK
  QIso : AG.RankOneQuotient C.CKu P.ℓ ≃ ZMod P.ℓ

namespace OrbicurveStructuralEnhancement

/-- The inverse image of `1` under the chosen quotient identification is the
canonical nonzero quotient element. -/
noncomputable def canonicalQ
    (A : OrbicurveStructuralEnhancement AG F E Fbar VBad P C) :
    AG.RankOneQuotient C.CKu P.ℓ :=
  A.QIso.symm 1

/-- The canonical quotient element is nonzero in the chosen coordinates. -/
theorem canonicalQ_ne_zero
    (A : OrbicurveStructuralEnhancement AG F E Fbar VBad P C) :
    A.QIso A.canonicalQ ≠ 0 := by
  letI : Fact P.ℓ.Prime := ⟨P.ℓ_prime⟩
  simpa [canonicalQ] using (one_ne_zero : (1 : ZMod P.ℓ) ≠ 0)

/-- The distinguished cusp derived from the canonical quotient element. -/
noncomputable def canonicalCusp
    (A : OrbicurveStructuralEnhancement AG F E Fbar VBad P C) :
    AG.Cusp C.CKu :=
  AG.cuspOfQuotient C.CKu P.ℓ A.canonicalQ

/-- Complete the public anabelian enhancement by canonical quotient/cusp
choices. -/
noncomputable def toAnabelianEnhancement
    (A : OrbicurveStructuralEnhancement AG F E Fbar VBad P C) :
    OrbicurveAnabelianEnhancement AG F E Fbar VBad P C where
  CKu_type := A.CKu_type
  CKu_core := A.CKu_core
  XKu_type := A.XKu_type
  diagram_cartesian := A.diagram_cartesian
  QIso := A.QIso
  q := A.canonicalQ
  q_ne_zero := A.canonicalQ_ne_zero
  epsilon := A.canonicalCusp
  epsilon_spec := rfl

/-- Forget the automatic quotient/cusp choices. -/
def ofAnabelianEnhancement
    (A : OrbicurveAnabelianEnhancement AG F E Fbar VBad P C) :
    OrbicurveStructuralEnhancement AG F E Fbar VBad P C where
  CKu_type := A.CKu_type
  CKu_core := A.CKu_core
  XKu_type := A.XKu_type
  diagram_cartesian := A.diagram_cartesian
  QIso := A.QIso

end OrbicurveStructuralEnhancement

/-- A geometric core admits a full public anabelian enhancement exactly when
it admits the smaller structural enhancement. -/
theorem orbicurveAnabelianEnhancement_nonempty_iff_structural :
    Nonempty
      (OrbicurveAnabelianEnhancement AG F E Fbar VBad P C) ↔
      Nonempty
        (OrbicurveStructuralEnhancement AG F E Fbar VBad P C) := by
  constructor
  · rintro ⟨A⟩
    exact ⟨OrbicurveStructuralEnhancement.ofAnabelianEnhancement
      AG F E Fbar VBad P C A⟩
  · rintro ⟨A⟩
    exact ⟨OrbicurveStructuralEnhancement.toAnabelianEnhancement
      AG F E Fbar VBad P C A⟩

end OrbicurveAutomaticChoices

/-! ## Automatic closed subgroup choice -/

section LocalAutomaticChoices

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

/-- The genuine portion of the public local etale core after removing the
uncharacterized decomposition-group choice. -/
structure LocalThetaSectionCore : Type u where
  sect : ValuationSection F E Fbar VBad P
  local_diagram_cartesian :
    ∀ v : FinitePlace ↥(fieldOfModuli F E),
      AG.IsCartesianSquare
        (AG.coverBaseChange
          (FinitePlace.embedding (sect.sectFin v).maximalIdeal)
          O.XKu_to_XK)
        (AG.coverBaseChange
          (FinitePlace.embedding (sect.sectFin v).maximalIdeal)
          O.XK_to_CK)
        (AG.coverBaseChange
          (FinitePlace.embedding (sect.sectFin v).maximalIdeal)
          O.XKu_to_CKu)
        (AG.coverBaseChange
          (FinitePlace.embedding (sect.sectFin v).maximalIdeal)
          O.CKu_to_CK)

namespace LocalThetaSectionCore

/-- Complete the public etale core using the full Galois group as its closed
subgroup at every finite place. -/
noncomputable def toEtaleCore
    (C : LocalThetaSectionCore AG F E Fbar VBad P O) :
    LocalThetaEtaleCore AG F E Fbar VBad P O where
  sect := C.sect
  local_diagram_cartesian := C.local_diagram_cartesian
  decomp := fun _ => ⊤
  decomp_isClosed := by
    intro v
    change IsClosed
      (Set.univ : Set (Fbar ≃ₐ[↥P.torsionField] Fbar))
    exact isClosed_univ

/-- Forget the automatic full-subgroup choices. -/
noncomputable def ofEtaleCore
    (C : LocalThetaEtaleCore AG F E Fbar VBad P O) :
    LocalThetaSectionCore AG F E Fbar VBad P O where
  sect := C.sect
  local_diagram_cartesian := C.local_diagram_cartesian

end LocalThetaSectionCore

/-- The public etale core is inhabited exactly when the section/cartesian core
is inhabited. -/
theorem localThetaEtaleCore_nonempty_iff_sectionCore :
    Nonempty (LocalThetaEtaleCore AG F E Fbar VBad P O) ↔
      Nonempty (LocalThetaSectionCore AG F E Fbar VBad P O) := by
  constructor
  · rintro ⟨C⟩
    exact ⟨LocalThetaSectionCore.ofEtaleCore
      AG TG F E Fbar VBad P O C⟩
  · rintro ⟨C⟩
    exact ⟨LocalThetaSectionCore.toEtaleCore
      AG TG F E Fbar VBad P O C⟩

end LocalAutomaticChoices

end IUTThreeClosures
