/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Iut.Cor312.LeftHandSide

/-!
# Canonical q-packets and tempered local-theta enhancements

The public initial-theta interface stores the Tate parameters in
`AdmissiblePrimeData`, not in `LocalThetaData`. Consequently the honest split
is as follows.

* For public `QPilotData`, the finite bad-place q-packet is a derived dependent
  function of the actual Tate parameters already pinned to the source
  elliptic curve by their j-invariants. It is not an additional family choice.
* `LocalThetaData` itself splits into an etale/local core (valuation section,
  cartesian base-change diagrams and decomposition groups) and a tempered
  enhancement (bad-place type, theta-root model and canonical graph-cusp
  conditions).

The constructions below are exact projections and reassembly theorems. They
do not construct the valuation section or the tempered/anabelian conditions.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField WeierstrassCurve

universe u

/-! ## The derived finite q-packet -/

section CanonicalQPacket

variable {AG : AnabelianGeometry.{u}}
variable {TG : TemperedGeometry AG}
variable (D : InitialThetaData AG TG)
variable (Q : QPilotData D)

/-- The finite index type of the actual bad-place q-packet. -/
abbrev CanonicalQPacketIndex := Q.badFinset.attach

/-- The dependent type of one Tate parameter at every enumerated bad place. -/
def CanonicalQPacket : Type u :=
  ∀ w : CanonicalQPacketIndex D Q,
    TateCurvesTheta.TateParameter (localCompletion w.1)

/-- The canonical packet is obtained directly from the Tate parameters in the
actual admissible-prime data. -/
noncomputable def canonicalQPacket : CanonicalQPacket D Q :=
  fun w => D.prime.tate w.1 (Q.mem_bad w.2)

/-- In particular, the complete finite q-packet is inhabited without any
additional family-level choice. -/
theorem canonicalQPacket_nonempty :
    Nonempty (CanonicalQPacket D Q) :=
  ⟨canonicalQPacket D Q⟩

/-- The actual Tate parameter at one packet coordinate. -/
noncomputable def canonicalQParameter
    (w : CanonicalQPacketIndex D Q) :
    TateCurvesTheta.TateParameter (localCompletion w.1) :=
  canonicalQPacket D Q w

/-- The actual normalized uniformizer at one packet coordinate. -/
noncomputable def canonicalQUniformizer
    (w : CanonicalQPacketIndex D Q) :
    localCompletion w.1 :=
  D.prime.unif w.1 (Q.mem_bad w.2)

/-- The packet uniformizer is genuinely a uniformizer. -/
theorem canonicalQUniformizer_isUniformizer
    (w : CanonicalQPacketIndex D Q) :
    TateCurvesTheta.IsUniformizer (canonicalQUniformizer D Q w) :=
  D.prime.unif_isUniformizer w.1 (Q.mem_bad w.2)

/-- The canonical positive integer order of the q-parameter. -/
noncomputable def canonicalQOrder
    (w : CanonicalQPacketIndex D Q) : ℕ :=
  D.prime.qOrder w.1 (Q.mem_bad w.2)

/-- Every canonical packet order is positive. -/
theorem canonicalQOrder_pos
    (w : CanonicalQPacketIndex D Q) :
    0 < canonicalQOrder D Q w :=
  D.prime.qOrder_pos w.1 (Q.mem_bad w.2)

/-- Each packet parameter is pinned to the actual source elliptic curve by the
Tate j-invariant identity. -/
theorem canonicalQParameter_tateJ_eq
    (w : CanonicalQPacketIndex D Q) :
    (canonicalQParameter D Q w).tateJ =
      FinitePlace.embedding w.1.maximalIdeal D.E.j :=
  D.prime.tateJ_eq w.1 (Q.mem_bad w.2)

end CanonicalQPacket

/-! ## Exact split of `LocalThetaData` -/

section LocalThetaSplit

variable (AG : AnabelianGeometry.{u})
variable (TG : TemperedGeometry AG)
variable (F : Type u) [Field F] [NumberField F]
variable (E : WeierstrassCurve F) [E.IsElliptic]
variable (Fbar : Type u) [Field Fbar] [Algebra F Fbar]
variable (VBad : Set (FinitePlace ↥(fieldOfModuli F E)))
variable (P : AdmissiblePrimeData F E Fbar VBad)
variable [NumberField ↥P.torsionField]
variable [Algebra ↥(fieldOfModuli F E) ↥P.torsionField]
variable
  (O : Iut.OrbicurveDataSection.OrbicurveData
    AG F E Fbar VBad P)

/-- The local etale/core layer before the theta-root and tempered conditions
are imposed. -/
structure LocalThetaEtaleCore : Type u where
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
  decomp :
    ∀ _ : FinitePlace ↥P.torsionField,
      Subgroup (Fbar ≃ₐ[↥P.torsionField] Fbar)
  decomp_isClosed :
    ∀ v,
      IsClosed
        ((decomp v) : Set (Fbar ≃ₐ[↥P.torsionField] Fbar))

/-- The genuinely theta-root/tempered enhancement of one local etale core. -/
structure LocalThetaTemperedEnhancement
    (C : LocalThetaEtaleCore AG F E Fbar VBad P O) : Type u where
  bad_type :
    ∀ v ∈ VBad,
      AG.IsTypeOneZModPM P.ℓ
        (localize (C.sect.sectFin v) O.XKu)
  bad_theta_model :
    ∀ v ∈ VBad,
      TG.IsThetaRootModel P.ℓ
        (localize (C.sect.sectFin v) O.XKu)
  epsilon_graph :
    ∀ v ∈ VBad,
      AG.cuspBaseChange
          (FinitePlace.embedding (C.sect.sectFin v).maximalIdeal)
          O.epsilon =
        TG.canonicalGraphCusp
          (localize (C.sect.sectFin v) O.CKu)

namespace LocalThetaEtaleCore

/-- Project the etale/core layer from public local theta-data. -/
def ofLocalThetaData
    (L : LocalThetaData AG TG F E Fbar VBad P O) :
    LocalThetaEtaleCore AG F E Fbar VBad P O where
  sect := L.sect
  local_diagram_cartesian := L.local_diagram_cartesian
  decomp := L.decomp
  decomp_isClosed := L.decomp_isClosed

end LocalThetaEtaleCore

namespace LocalThetaTemperedEnhancement

/-- Project the tempered enhancement from public local theta-data. -/
def ofLocalThetaData
    (L : LocalThetaData AG TG F E Fbar VBad P O) :
    LocalThetaTemperedEnhancement AG TG F E Fbar VBad P O
      (LocalThetaEtaleCore.ofLocalThetaData
        AG TG F E Fbar VBad P O L) where
  bad_type := L.bad_type
  bad_theta_model := L.bad_theta_model
  epsilon_graph := L.epsilon_graph

/-- Reassemble the exact public local theta-data. -/
def assemble
    (C : LocalThetaEtaleCore AG F E Fbar VBad P O)
    (T : LocalThetaTemperedEnhancement
      AG TG F E Fbar VBad P O C) :
    LocalThetaData AG TG F E Fbar VBad P O where
  sect := C.sect
  local_diagram_cartesian := C.local_diagram_cartesian
  decomp := C.decomp
  decomp_isClosed := C.decomp_isClosed
  bad_type := T.bad_type
  bad_theta_model := T.bad_theta_model
  epsilon_graph := T.epsilon_graph

/-- Projection followed by reassembly is exact. -/
@[simp]
theorem assemble_ofLocalThetaData
    (L : LocalThetaData AG TG F E Fbar VBad P O) :
    assemble AG TG F E Fbar VBad P O
      (LocalThetaEtaleCore.ofLocalThetaData
        AG TG F E Fbar VBad P O L)
      (ofLocalThetaData AG TG F E Fbar VBad P O L) = L := by
  cases L
  rfl

end LocalThetaTemperedEnhancement

/-- Public local theta-data exist exactly when an etale/core layer admits a
tempered enhancement. -/
theorem localThetaData_nonempty_iff_core_tempered :
    Nonempty (LocalThetaData AG TG F E Fbar VBad P O) ↔
      ∃ C : LocalThetaEtaleCore AG F E Fbar VBad P O,
        Nonempty
          (LocalThetaTemperedEnhancement
            AG TG F E Fbar VBad P O C) := by
  constructor
  · rintro ⟨L⟩
    exact ⟨LocalThetaEtaleCore.ofLocalThetaData
      AG TG F E Fbar VBad P O L,
      ⟨LocalThetaTemperedEnhancement.ofLocalThetaData
        AG TG F E Fbar VBad P O L⟩⟩
  · rintro ⟨C, ⟨T⟩⟩
    exact ⟨LocalThetaTemperedEnhancement.assemble
      AG TG F E Fbar VBad P O C T⟩

end LocalThetaSplit

end IUTThreeClosures
