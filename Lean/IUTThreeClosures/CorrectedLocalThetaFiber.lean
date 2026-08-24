/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EquivalentValuationSection
import IUTThreeClosures.FiberAutomaticChoices

/-!
# Corrected local theta-data over equivalent finite places

The public `Iut.ValuationSection` asks for literal equality of independently
normalized finite absolute values after restriction.  Arithmetic lying-over
naturally gives equivalence of absolute values, and the selected finite prime
ideal is already enough to form every local completion and base-changed
covering diagram used by `LocalThetaData`.

This module defines the invariant replacement of the complete local theta
package.  It proves two exact reductions.

* The weak decomposition-subgroup field remains automatic for the corrected
  package, exactly as for the current public package.
* Public strict local theta-data are equivalent to corrected local theta-data
  together with one additional strict-normalization certificate.

Thus strict normalization is isolated as an interface theorem.  It is not
mixed with the orbicurve, local-cartesian, theta-root, tempered, or graph-cusp
obligations.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField WeierstrassCurve

universe u

section CorrectedLocalTheta

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

/-- A certificate that an equivalent finite-place section happens to satisfy
the stronger literal normalization demanded by the current public interface. -/
structure StrictFiniteNormalization
    (S : EquivalentValuationSection
      ↥(fieldOfModuli F E) ↥P.torsionField) : Prop where
  liesOver : ∀ v, (S.sectFin v).1.LiesOver v.1

/-- Regard a public strict valuation section as an equivalent-place section. -/
noncomputable def equivalentSectionOfPublic
    (S : ValuationSection F E Fbar VBad P) :
    EquivalentValuationSection
      ↥(fieldOfModuli F E) ↥P.torsionField where
  sectFin := S.sectFin
  sectInf := S.sectInf
  sectFin_liesOver v :=
    finitePlaceEquivalentLiesOver_of_absoluteValueLiesOver
      v (S.sectFin v) (S.sectFin_liesOver v)
  sectInf_liesOver := S.sectInf_liesOver

/-- A public section supplies the strict-normalization certificate for its
underlying equivalent-place section. -/
def strictNormalizationOfPublic
    (S : ValuationSection F E Fbar VBad P) :
    StrictFiniteNormalization F E Fbar VBad P
      (equivalentSectionOfPublic F E Fbar VBad P S) where
  liesOver := S.sectFin_liesOver

/-- Upgrade an equivalent-place section to the public strict section when the
extra normalization theorem is available. -/
noncomputable def StrictFiniteNormalization.toValuationSection
    {S : EquivalentValuationSection
      ↥(fieldOfModuli F E) ↥P.torsionField}
    (N : StrictFiniteNormalization F E Fbar VBad P S) :
    ValuationSection F E Fbar VBad P where
  sectFin := S.sectFin
  sectInf := S.sectInf
  sectFin_liesOver := N.liesOver
  sectInf_liesOver := S.sectInf_liesOver

/-- The complete invariant local theta package, obtained from the public one
by replacing strict finite-place restriction by equivalence of places. -/
structure EquivalentLocalThetaData : Type u where
  sect : EquivalentValuationSection
    ↥(fieldOfModuli F E) ↥P.torsionField
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
  decomp :
    ∀ _ : FinitePlace ↥P.torsionField,
      Subgroup (Fbar ≃ₐ[↥P.torsionField] Fbar)
  decomp_isClosed :
    ∀ v,
      IsClosed
        ((decomp v) : Set (Fbar ≃ₐ[↥P.torsionField] Fbar))
  bad_type :
    ∀ v ∈ VBad,
      AG.IsTypeOneZModPM P.ℓ
        (localize (sect.sectFin v) O.XKu)
  bad_theta_model :
    ∀ v ∈ VBad,
      TG.IsThetaRootModel P.ℓ
        (localize (sect.sectFin v) O.XKu)
  epsilon_graph :
    ∀ v ∈ VBad,
      AG.cuspBaseChange
          (FinitePlace.embedding (sect.sectFin v).maximalIdeal)
          O.epsilon =
        TG.canonicalGraphCusp
          (localize (sect.sectFin v) O.CKu)

/-- The genuine geometric/tempered part after removing the currently
uncharacterized decomposition-subgroup choice. -/
structure EquivalentLocalThetaRealization : Type u where
  sect : EquivalentValuationSection
    ↥(fieldOfModuli F E) ↥P.torsionField
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
  bad_type :
    ∀ v ∈ VBad,
      AG.IsTypeOneZModPM P.ℓ
        (localize (sect.sectFin v) O.XKu)
  bad_theta_model :
    ∀ v ∈ VBad,
      TG.IsThetaRootModel P.ℓ
        (localize (sect.sectFin v) O.XKu)
  epsilon_graph :
    ∀ v ∈ VBad,
      AG.cuspBaseChange
          (FinitePlace.embedding (sect.sectFin v).maximalIdeal)
          O.epsilon =
        TG.canonicalGraphCusp
          (localize (sect.sectFin v) O.CKu)

namespace EquivalentLocalThetaRealization

/-- Complete a corrected realization by the canonical closed full subgroup in
the current weak decomposition-group interface. -/
noncomputable def toData
    (R : EquivalentLocalThetaRealization
      AG TG F E Fbar VBad P O) :
    EquivalentLocalThetaData
      AG TG F E Fbar VBad P O where
  sect := R.sect
  local_diagram_cartesian := R.local_diagram_cartesian
  decomp := fun _ => ⊤
  decomp_isClosed := by
    intro v
    change IsClosed
      (Set.univ : Set (Fbar ≃ₐ[↥P.torsionField] Fbar))
    exact isClosed_univ
  bad_type := R.bad_type
  bad_theta_model := R.bad_theta_model
  epsilon_graph := R.epsilon_graph

/-- Forget the weak decomposition-group choices. -/
noncomputable def ofData
    (L : EquivalentLocalThetaData
      AG TG F E Fbar VBad P O) :
    EquivalentLocalThetaRealization
      AG TG F E Fbar VBad P O where
  sect := L.sect
  local_diagram_cartesian := L.local_diagram_cartesian
  bad_type := L.bad_type
  bad_theta_model := L.bad_theta_model
  epsilon_graph := L.epsilon_graph

end EquivalentLocalThetaRealization

/-- Corrected local theta-data are inhabited exactly when the genuine
section/cartesian/tempered realization is inhabited. -/
theorem equivalentLocalThetaData_nonempty_iff_realization :
    Nonempty
      (EquivalentLocalThetaData
        AG TG F E Fbar VBad P O) ↔
      Nonempty
        (EquivalentLocalThetaRealization
          AG TG F E Fbar VBad P O) := by
  constructor
  · rintro ⟨L⟩
    exact ⟨EquivalentLocalThetaRealization.ofData
      AG TG F E Fbar VBad P O L⟩
  · rintro ⟨R⟩
    exact ⟨R.toData⟩

namespace EquivalentLocalThetaData

/-- Forget strict normalization in a public local theta package. -/
noncomputable def ofLocalThetaData
    (L : LocalThetaData AG TG F E Fbar VBad P O) :
    EquivalentLocalThetaData
      AG TG F E Fbar VBad P O where
  sect := equivalentSectionOfPublic F E Fbar VBad P L.sect
  local_diagram_cartesian := L.local_diagram_cartesian
  decomp := L.decomp
  decomp_isClosed := L.decomp_isClosed
  bad_type := L.bad_type
  bad_theta_model := L.bad_theta_model
  epsilon_graph := L.epsilon_graph

/-- Recover the public strict local package from corrected data plus the one
extra normalization certificate. -/
noncomputable def toLocalThetaData
    (L : EquivalentLocalThetaData
      AG TG F E Fbar VBad P O)
    (N : StrictFiniteNormalization F E Fbar VBad P L.sect) :
    LocalThetaData AG TG F E Fbar VBad P O where
  sect := N.toValuationSection
  local_diagram_cartesian := L.local_diagram_cartesian
  decomp := L.decomp
  decomp_isClosed := L.decomp_isClosed
  bad_type := L.bad_type
  bad_theta_model := L.bad_theta_model
  epsilon_graph := L.epsilon_graph

end EquivalentLocalThetaData

/-- Exact logical status of the normalization seam: public local theta-data
exist iff corrected local theta-data exist together with a strict finite-place
normalization certificate for the selected section. -/
theorem localThetaData_nonempty_iff_corrected_strict :
    Nonempty (LocalThetaData AG TG F E Fbar VBad P O) ↔
      ∃ L : EquivalentLocalThetaData
          AG TG F E Fbar VBad P O,
        StrictFiniteNormalization F E Fbar VBad P L.sect := by
  constructor
  · rintro ⟨L⟩
    let C := EquivalentLocalThetaData.ofLocalThetaData
      AG TG F E Fbar VBad P O L
    exact ⟨C, strictNormalizationOfPublic
      F E Fbar VBad P L.sect⟩
  · rintro ⟨L, N⟩
    exact ⟨L.toLocalThetaData N⟩

end CorrectedLocalTheta

end IUTThreeClosures
