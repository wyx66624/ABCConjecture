/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualHodgeTheaterOutput
import IUTThreeClosures.TateHaarResidueNormalization

/-!
# Residue-normalized Haar volume at an actual bad Hodge-theater place

This is the thin global-data wrapper around the source-derived local theorem.
It introduces no local formula field: the Tate parameter, uniformizer and
integer order are all the existing objects derived from `InitialThetaData`.
-/

namespace IUTThreeClosures

noncomputable section

open Iut NumberField TateCurvesTheta
open MeasureTheory
open scoped ENNReal NNReal NormedField Pointwise Valued

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

namespace ActualBadHodgeTheaterPlace

variable {D : InitialThetaData AG TG}
variable (H : ActualBadHodgeTheaterPlace D)

/-- The public `qOrder` at an actual bad place is definitionally the canonical
uniformizer-normalized order of its genuine Tate parameter. -/
theorem qOrder_eq_tate_orderNat :
    H.qOrder =
      (H.tate.toOrdered H.uniformizer_isUniformizer).orderNat :=
  rfl

/-- Use the norm-derived rank-one valuation in the numerical Haar formula.
The adic completion also carries its construction valuation in `ℤᵐ⁰`; fixing this
local instance prevents the two integer-ring presentations from being mixed. -/
local instance normValuedTateField : Valued H.TateField ℝ≥0 :=
  NormedField.toValued

variable [IsUltrametricDist H.TateField]
variable [IsDiscreteValuationRing 𝒪[H.TateField]] [Finite 𝓀[H.TateField]]
variable [ProperSpace H.TateField]
variable [MeasurableSpace H.TateField] [BorelSpace H.TateField]

/-- The actual bad-place Tate parameter satisfies the residue-normalized Haar
character formula, with no supplied component-volume datum.  The explicit
local-field typeclasses record the current API boundary for adic completions. -/
theorem log_distribHaarChar_q_eq_qOrder_residueCard :
    Real.log ((distribHaarChar H.TateField H.tate.q : ℝ≥0) : ℝ) =
      -(H.qOrder : ℝ) *
        Real.log (Nat.card 𝓀[H.TateField] : ℝ) := by
  rw [H.qOrder_eq_tate_orderNat]
  exact TateHaarResidueNormalization.log_distribHaarChar_tateParameter
    (K := H.TateField) H.tate H.uniformizer H.uniformizer_isUniformizer

end ActualBadHodgeTheaterPlace
end
end IUTThreeClosures
