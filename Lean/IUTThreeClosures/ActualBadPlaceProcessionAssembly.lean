/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualBadPlaceQPilotPacket
import IUTThreeClosures.ActualTateRelationalSource
import IUTThreeClosures.SourceFaithfulTheorem110

/-!
# The actual finite bad-place procession assembly

This module is the next source-faithful layer above the actual bad-place Haar
packet.  It never uses the inconsistent total `LogVolumeData` interface and it
does not contain a component formula, an error term, a desired upper bound, or
an abc statement as structure data.

## Mathematical statement and proof

Put `n = (ell - 1) / 2`.  Initial theta data have `ell >= 5`, hence `n > 0`.
The distinguished new label of the `m`-th standard capsule is `m+1`.  For
this label (`0 <= m < n`) and an actual bad place `w`, take the genuine
finite-positive Haar region

`U_(m,w) = q_w^((m+1)^2) O_w`.

The normalized additive Haar measure of `O_w` is one.  Haar scaling and the
local Tate calculation therefore give

`log mu_w(U_(m,w)) = (m+1)^2 log chi_w(q_w)`

`= -(m+1)^2 ord_w(q_w) log N(w)`.

Summing first over the finite bad locus and then over these distinguished
labels of the procession gives

`L_proc = (sum_(m=1)^n m^2) L_q`,

where `L_q` is the signed actual q-packet Haar sum.  Dividing by `n` and using
the elementary square-average identity yields

`L_proc / n = ((2n+1)(n+1)/6) L_q`.

After changing sign and dividing by `[F:Q]`, this is exactly the same square
average times the normalized arithmetic degree of the explicit q-divisor.
Every `U_(m,w)` is contained in `O_w`, so finite-positive log-volume
monotonicity also gives the honest local component upper estimate
`log mu_w(U_(m,w)) <= 0`.

Finally, the canonical divisor-compatible weight in the public interface is
constructed, rather than assumed:

`weight_can(w) = f_w / [F:Q]`,

where `f_w` is the actual residue degree.  This is the residue-degree branch
of the normalization fork for an integer uniformizer order; it is not the
documented local-degree weight `e_w f_w / [F:Q]`.  Since
`log N(w) = f_w log p_w`, these weights satisfy the public degree
compatibility equation by proof.  This produces a canonically reweighted
`QPilotData` whose public `logQ` agrees unconditionally with the actual Haar
packet normalization.

## Boundary

This is a real finite-positive distinguished-label slice of the standard
procession and a real local Ind1/Ind2/Ind3 upper estimate for the explicit
Tate/Kummer source.  It is not the complete product over every label in every
capsule.  It does **not** prove that this source exhausts the possible images
of IUT III, Theorem 3.11; it does not construct the global mono-analytic hull;
and it does not supply the different, conductor, or archimedean estimates of
IUT IV, Theorem 1.10.  The canonical reweighting constructs a new `QPilotData`;
it does not prove that the arbitrary weight field of the input `Q` is
compatible.
-/

namespace IUTThreeClosures

noncomputable section

open Iut NumberField TateCurvesTheta
open MeasureTheory
open scoped BigOperators ENNReal NNReal NormedField Pointwise Valued WithZero

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

namespace ActualBadHodgeTheaterPlace

variable (H : ActualBadHodgeTheaterPlace D)

/- The following local instances are all derived from the actual finite-place
completion.  They are local to this module and are not fields of a source
record. -/
local instance processionNontriviallyNormedTateField :
    NontriviallyNormedField H.TateField :=
  Valued.toNontriviallyNormedField H.TateField ℤᵐ⁰

local instance processionNormValuedTateField : Valued H.TateField ℝ≥0 :=
  NormedField.toValued

local instance processionTateFieldIsUltrametricDist :
    IsUltrametricDist H.TateField :=
  LocalCompletionNormValuationBridge.completionIsUltrametricDist
    H.w.maximalIdeal

local instance processionTateFieldProperSpace : ProperSpace H.TateField :=
  LocalCompletionNormValuationBridge.completionProperSpace H.w.maximalIdeal

local instance processionTateFieldMeasurableSpace : MeasurableSpace H.TateField :=
  borel H.TateField

local instance processionTateFieldBorelSpace : BorelSpace H.TateField :=
  ⟨rfl⟩

/-- The actual finite-positive component at square label `j^2`. -/
noncomputable def squareLabelRegion (j : ℕ) :
    FinitePositiveRegion H.TateField
      (MaximalValuationRingHull.normalizedIntegerHaar (K := H.TateField)) :=
  SourceFaithfulTheorem110.tatePowerFinitePositiveRegion H.tate (j ^ 2)

@[simp]
theorem coe_squareLabelRegion (j : ℕ) :
    (H.squareLabelRegion j : Set H.TateField) =
      H.tate.qPowerRegion (j ^ 2) :=
  SourceFaithfulTheorem110.coe_tatePowerFinitePositiveRegion H.tate (j ^ 2)

/-- The square-label component is a genuine subregion of the normalized
integer ball. -/
theorem squareLabelRegion_le_unitRegion (j : ℕ) :
    (H.squareLabelRegion j : Set H.TateField) ⊆
      (H.squareLabelRegion 0 : Set H.TateField) := by
  rw [H.coe_squareLabelRegion, H.coe_squareLabelRegion]
  simpa using H.tate.qPowerRegion_antitone (Nat.zero_le (j ^ 2))

/-- Exact log-volume of the square-label region, proved by Haar scaling. -/
theorem squareLabelRegion_logVolume (j : ℕ) :
    (H.squareLabelRegion j).logVolume =
      (j : ℝ) ^ 2 *
        Real.log ((distribHaarChar H.TateField H.tate.q : ℝ≥0) : ℝ) := by
  rw [squareLabelRegion]
  rw [SourceFaithfulTheorem110.tatePower_component_logVolume]
  push_cast
  rfl

/-- The same calculation written in the signed local-Haar notation of the
actual bad-place packet. -/
theorem squareLabelRegion_logVolume_eq_sq_mul_localHaarLog (j : ℕ) :
    (H.squareLabelRegion j).logVolume =
      (j : ℝ) ^ 2 * ActualBadPlaceQPilotPacket.localHaarLog H := by
  rw [H.squareLabelRegion_logVolume]
  rfl

/-- The normalized integer ball has logarithmic Haar volume zero. -/
theorem unitRegion_logVolume :
    (H.squareLabelRegion 0).logVolume = 0 := by
  simpa using H.squareLabelRegion_logVolume 0

/-- Honest finite-positive local component upper estimate.  It is a theorem
of region containment, not a stored numerical component formula. -/
theorem squareLabelRegion_logVolume_le_zero (j : ℕ) :
    (H.squareLabelRegion j).logVolume ≤ 0 := by
  rw [← H.unitRegion_logVolume]
  exact FinitePositiveRegion.logVolume_mono
    (H.squareLabelRegion_le_unitRegion j)

/-- Every finite-positive region that is genuinely reachable in the explicit
local relational Ind1/Ind2/Ind3 source has log-volume at most zero. -/
theorem reachableFinitePositiveRegion_logVolume_le_zero
    (U : FinitePositiveRegion H.TateField
      (MaximalValuationRingHull.normalizedIntegerHaar (K := H.TateField)))
    (hU : H.actualTateRelationalSource.toUpperSemicompatibleSystem.Reachable
      (U : Set H.TateField)) :
    U.logVolume ≤ 0 := by
  rw [← H.unitRegion_logVolume]
  apply FinitePositiveRegion.logVolume_mono
  have henv :=
    H.actualTateRelationalSource.toUpperSemicompatibleSystem.reachable_le_envelope hU
  change (U : Set H.TateField) ⊆
    radialEnvelope H.actualTateRelationalSource.radius at henv
  rw [H.actualTateRelational_radialEnvelope] at henv
  simpa [H.coe_squareLabelRegion] using henv

/-- The bad moduli place selected from the actual source has odd residue
characteristic, as required by initial theta data. -/
theorem modPlace_residueChar_odd : Odd (Iut.residueChar H.modPlace) :=
  D.global.bad_odd H.modPlace H.modPlace_mem

end ActualBadHodgeTheaterPlace

namespace ActualBadPlaceProcessionAssembly

open ActualBadPlaceQPilotPacket

/- The logarithmic-volume projection needs the canonical Borel measurable
space of the completed local field at the packet coordinate. -/
local instance packetTateFieldMeasurableSpace
    (Q : QPilotData D) (w : Index Q) :
    MeasurableSpace (place Q w).TateField :=
  borel (place Q w).TateField

private theorem range_succ_sq_sum (n : ℕ) :
    ∑ m ∈ Finset.range n, (((m + 1 : ℕ) : ℝ) ^ 2) =
      (n : ℝ) * ((n : ℝ) + 1) * (2 * (n : ℝ) + 1) / 6 := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [Finset.sum_range_succ, ih]
      push_cast
      ring

private theorem average_range_sq_sum (n : ℕ) (hn : 0 < n) :
    (1 / (n : ℝ)) *
        ∑ m ∈ Finset.range n, (((m + 1 : ℕ) : ℝ) ^ 2) =
      ((2 * (n : ℝ) + 1) * ((n : ℝ) + 1)) / 6 := by
  have hsum := range_succ_sq_sum n
  rw [hsum]
  have hn0 : (n : ℝ) ≠ 0 := by exact_mod_cast hn.ne'
  field_simp

/-- The number of nontrivial members of the standard procession. -/
abbrev processionLength (D : InitialThetaData AG TG) : ℕ :=
  (D.ℓ - 1) / 2

/-- The standard procession attached to the admissible prime. -/
def procession (D : InitialThetaData AG TG) : Iut.Procession ℕ :=
  Iut.Procession.standard (processionLength D)

@[simp]
theorem procession_length : (procession D).length = processionLength D :=
  rfl

/-- Admissibility (`ell >= 5`) makes the standard procession nonempty. -/
theorem processionLength_pos : 0 < processionLength D := by
  have htwo : 2 ≤ D.ℓ - 1 := by
    have hfive : 5 ≤ D.ℓ := by
      simpa [InitialThetaData.ℓ] using D.prime.five_le
    omega
  exact Nat.div_pos htwo (by norm_num)

/-- The source-derived field-of-moduli place at every packet coordinate is
odd. -/
theorem packet_modPlace_residueChar_odd
    (Q : QPilotData D) (w : Index Q) :
    Odd (Iut.residueChar (place Q w).modPlace) :=
  (place Q w).modPlace_residueChar_odd

/-- Log-volume scalar of the actual component at procession index `m` and bad
place `w`.  Its equality with the concrete finite-positive region is the
preceding local Haar theorem, not a field of this definition. -/
noncomputable def componentLog
    (Q : QPilotData D) (m : ℕ) (w : Index Q) : ℝ :=
  (((m + 1 : ℕ) : ℝ) ^ 2) * entry Q w

/-- Pointwise component formula derived from the actual finite-positive Haar
region and the actual q-packet entry. -/
theorem componentLog_eq_sq_mul_entry
    (Q : QPilotData D) (m : ℕ) (w : Index Q) :
    componentLog Q m w = ((m + 1 : ℕ) : ℝ) ^ 2 * entry Q w :=
  rfl

/-- The procession scalar is literally the logarithmic Haar volume of the
corresponding actual finite-positive square-label Tate region. -/
theorem componentLog_eq_squareLabelRegion_logVolume
    (Q : QPilotData D) (m : ℕ) (w : Index Q) :
    componentLog Q m w =
      ((place Q w).squareLabelRegion (m + 1)).logVolume := by
  rw [componentLog_eq_sq_mul_entry,
    ActualBadHodgeTheaterPlace.squareLabelRegion_logVolume_eq_sq_mul_localHaarLog]
  rfl

/-- The total actual bad-place log-volume at the distinguished new label of
the `m`-th procession capsule. -/
noncomputable def distinguishedLabelPacketLog
    (Q : QPilotData D) (m : ℕ) : ℝ :=
  ∑ w ∈ Q.badFinset.attach, componentLog Q m w

/-- Each distinguished label slice is its square label times the signed
q-packet Haar sum. -/
theorem distinguishedLabelPacketLog_eq_sq_mul_signedHaarLogSum
    (Q : QPilotData D) (m : ℕ) :
    distinguishedLabelPacketLog Q m =
      ((m + 1 : ℕ) : ℝ) ^ 2 * signedHaarLogSum Q := by
  classical
  rw [distinguishedLabelPacketLog, signedHaarLogSum, Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro w hw
  exact componentLog_eq_sq_mul_entry Q m w

/-- Sum of actual distinguished-label component log-volumes over the
standard procession. -/
noncomputable def processionLogSum (Q : QPilotData D) : ℝ :=
  ∑ m ∈ Finset.range (processionLength D),
    distinguishedLabelPacketLog Q m

/-- Procession-normalized actual component log-volume. -/
noncomputable def processionAverage (Q : QPilotData D) : ℝ :=
  (1 / (processionLength D : ℝ)) * processionLogSum Q

/-- The square-average coefficient occurring in IUT IV, equation (E2). -/
noncomputable def squareAverage (D : InitialThetaData AG TG) : ℝ :=
  ((2 * (processionLength D : ℝ) + 1) *
      ((processionLength D : ℝ) + 1)) / 6

/-- Exact finite procession assembly. -/
theorem processionAverage_eq_squareAverage_mul_signedHaarLogSum
    (Q : QPilotData D) :
    processionAverage Q = squareAverage D * signedHaarLogSum Q := by
  classical
  rw [processionAverage, processionLogSum]
  simp_rw [distinguishedLabelPacketLog_eq_sq_mul_signedHaarLogSum]
  rw [← Finset.sum_mul]
  calc
    (1 / (processionLength D : ℝ)) *
          ((∑ i ∈ Finset.range (processionLength D),
              (((i + 1 : ℕ) : ℝ) ^ 2)) * signedHaarLogSum Q) =
        ((1 / (processionLength D : ℝ)) *
          ∑ i ∈ Finset.range (processionLength D),
            (((i + 1 : ℕ) : ℝ) ^ 2)) * signedHaarLogSum Q := by ring
    _ = squareAverage D * signedHaarLogSum Q := by
      rw [average_range_sq_sum
        (processionLength D) processionLength_pos]
      rfl

/-- The positive, degree-normalized mass extracted from the actual
procession. -/
noncomputable def normalizedProcessionMass (Q : QPilotData D) : ℝ :=
  -processionAverage Q / (Module.finrank ℚ D.F : ℝ)

/-- The actual procession mass is the square average times the normalized
degree of the explicit arithmetic q-divisor. -/
theorem normalizedProcessionMass_eq_squareAverage_mul_arithmeticLogQ
    (Q : QPilotData D) :
    normalizedProcessionMass Q = squareAverage D * arithmeticLogQ Q := by
  rw [normalizedProcessionMass,
    processionAverage_eq_squareAverage_mul_signedHaarLogSum,
    ← ActualBadPlaceQPilotPacket.normalizedHaarLogQ_eq_arithmeticLogQ Q]
  rw [ActualBadPlaceQPilotPacket.normalizedHaarLogQ]
  ring

/-! ## Canonical, source-derived public weights -/

/-- The actual residue degree is positive. -/
theorem residueDegree_pos (w : FinitePlace D.F) :
    0 < LocalCompletionNormValuationBridge.residueDegree w.maximalIdeal := by
  letI : Fact
      (Nat.Prime (ringChar (𝓞 D.F ⧸ w.maximalIdeal.asIdeal))) :=
    ⟨LocalCompletionNormValuationBridge.residueRingChar_prime
      w.maximalIdeal⟩
  letI : Algebra
      (ZMod (ringChar (𝓞 D.F ⧸ w.maximalIdeal.asIdeal)))
      (𝓞 D.F ⧸ w.maximalIdeal.asIdeal) :=
    ZMod.algebra (𝓞 D.F ⧸ w.maximalIdeal.asIdeal)
      (ringChar (𝓞 D.F ⧸ w.maximalIdeal.asIdeal))
  exact Module.finrank_pos

/-- Canonical arithmetic-divisor-compatible weight `f_w / [F:Q]`, derived
from the residue extension rather than supplied as an arbitrary real field.
For the integer uniformizer order used by `QPilotData`, this is the corrected
residue-degree normalization, not the local-degree weight `e_w f_w/[F:Q]`. -/
noncomputable def canonicalWeight (w : FinitePlace D.F) : ℝ :=
  (LocalCompletionNormValuationBridge.residueDegree
      w.maximalIdeal : ℝ) /
    (Module.finrank ℚ D.F : ℝ)

theorem canonicalWeight_pos (w : FinitePlace D.F) :
    0 < canonicalWeight w := by
  exact div_pos
    (Nat.cast_pos.mpr (residueDegree_pos w))
    (Nat.cast_pos.mpr Module.finrank_pos)

/-- Replace only the arbitrary public weight field by the canonical residue
degree weights.  The actual bad locus and all Tate data remain unchanged. -/
noncomputable def canonicalQPilot (Q : QPilotData D) : QPilotData D where
  badFinset := Q.badFinset
  badFinset_spec := Q.badFinset_spec
  weight := canonicalWeight
  weight_pos := by
    intro w hw
    exact canonicalWeight_pos w

/-- The canonical weights satisfy the exact public arithmetic-degree
compatibility equation by construction. -/
theorem canonicalQPilot_weightDegreeCompatible (Q : QPilotData D) :
    QPilotWeightDegreeCompatible (canonicalQPilot Q) := by
  intro w hw
  change canonicalWeight w * Real.log (Iut.residueChar w) = _
  rw [canonicalWeight]
  rw [ActualBadPlaceQPilotPacket.arithmeticPlaceWeight_eq_residueDegree_mul_log_residueChar]
  ring

/-- Consequently the public q scalar of the canonically reweighted packet is
identified with its actual Haar normalization without any compatibility
hypothesis. -/
theorem canonicalQPilot_normalizedHaarLogQ_eq_publicLogQ
    (Q : QPilotData D) :
    normalizedHaarLogQ (canonicalQPilot Q) = (canonicalQPilot Q).logQ :=
  ActualBadPlaceQPilotPacket.normalizedHaarLogQ_eq_publicLogQ
    (canonicalQPilot Q) (canonicalQPilot_weightDegreeCompatible Q)

/-- The finite-positive procession identity expressed in the public scalar of
the canonically normalized packet. -/
theorem canonicalQPilot_normalizedProcessionMass_eq_squareAverage_mul_publicLogQ
    (Q : QPilotData D) :
    normalizedProcessionMass (canonicalQPilot Q) =
      squareAverage D * (canonicalQPilot Q).logQ := by
  rw [normalizedProcessionMass_eq_squareAverage_mul_arithmeticLogQ]
  rw [arithmeticLogQ_eq_publicLogQ
    (canonicalQPilot Q) (canonicalQPilot_weightDegreeCompatible Q)]

end ActualBadPlaceProcessionAssembly

end
end IUTThreeClosures
