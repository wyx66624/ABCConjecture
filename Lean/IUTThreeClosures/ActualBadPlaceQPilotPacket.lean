/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualBadPlaceHaarNormalization
import IUTThreeClosures.CorrectedQPilotDivisor

/-!
# The finite actual bad-place q-pilot Haar packet

This module assembles the genuine local Tate/Haar entries over the finite bad
locus and identifies their sum with the degree of the explicit arithmetic
q-divisor.  All entries are definitions from the existing initial theta data;
there is no stored component formula, procession bound, error, or target
inequality.

The essential local-to-global bridge is also proved here: the residue field of
the finite-place completion has cardinality equal to the absolute norm of the
original prime ideal.  Consequently the local Haar logarithm contains the
full residue-degree factor.
-/

namespace IUTThreeClosures

noncomputable section

open Iut NumberField TateCurvesTheta
open MeasureTheory
open scoped BigOperators ENNReal NNReal NormedField Pointwise Valued WithZero

universe u

namespace LocalCompletionNormValuationBridge

open IsDedekindDomain Valued.integer

variable {F : Type u} [Field F] [NumberField F]
variable (v : HeightOneSpectrum (𝓞 F))

/-- A global integer reduces to zero in the completed residue field exactly
when it belongs to the original finite-place prime.  The reverse implication
is the missing kernel calculation behind the residue-field comparison. -/
theorem globalIntegerToNativeResidue_eq_zero_iff_mem (r : 𝓞 F) :
    globalIntegerToNativeResidue v r = 0 ↔ r ∈ v.asIdeal := by
  constructor
  · intro hr
    rw [globalIntegerToNativeResidue, RingHom.comp_apply,
      IsLocalRing.residue_eq_zero_iff, mem_nativeMaximalIdeal_iff] at hr
    change (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
      ((algebraMap (𝓞 F) F r : F) : v.adicCompletion F) < 1 at hr
    rw [HeightOneSpectrum.valuedAdicCompletion_eq_valuation'] at hr
    exact (v.valuation_lt_one_iff_mem (K := F) r).mp hr
  · exact globalIntegerToNativeResidue_eq_zero_of_mem v r

/-- The quotient reduction map is injective; surjectivity was obtained from
density in `LocalCompletionNormValuationBridge`. -/
theorem globalResidueQuotientToNativeResidue_injective :
    Function.Injective (globalResidueQuotientToNativeResidue v) := by
  rw [RingHom.injective_iff_ker_eq_bot]
  apply le_antisymm
  · intro x hx
    obtain ⟨r, rfl⟩ := Ideal.Quotient.mk_surjective x
    change globalIntegerToNativeResidue v r = 0 at hx
    rw [globalIntegerToNativeResidue_eq_zero_iff_mem] at hx
    change (Ideal.Quotient.mk v.asIdeal) r = 0
    exact Ideal.Quotient.eq_zero_iff_mem.mpr hx
  · exact bot_le

/-- The global residue quotient and the native completed residue field are
canonically equivalent. -/
def globalResidueEquivNativeResidue :
    (𝓞 F ⧸ v.asIdeal) ≃+*
      IsLocalRing.ResidueField (v.adicCompletionIntegers F) :=
  RingEquiv.ofBijective (globalResidueQuotientToNativeResidue v)
    ⟨globalResidueQuotientToNativeResidue_injective v,
      globalResidueQuotientToNativeResidue_surjective v⟩

/-- The native completed residue field has cardinality equal to the absolute
norm of the original finite-place ideal. -/
theorem natCard_nativeResidue_eq_absNorm :
    Nat.card (IsLocalRing.ResidueField (v.adicCompletionIntegers F)) =
      Ideal.absNorm v.asIdeal := by
  calc
    Nat.card (IsLocalRing.ResidueField (v.adicCompletionIntegers F)) =
        Nat.card (𝓞 F ⧸ v.asIdeal) :=
      Nat.card_congr (globalResidueEquivNativeResidue v).symm.toEquiv
    _ = Ideal.absNorm v.asIdeal := by
      simp only [Ideal.absNorm_apply, Submodule.cardQuot_apply]

/-- The characteristic of the global residue quotient is prime. -/
theorem residueRingChar_prime :
    Nat.Prime (ringChar (𝓞 F ⧸ v.asIdeal)) := by
  exact CharP.char_is_prime (𝓞 F ⧸ v.asIdeal)
    (ringChar (𝓞 F ⧸ v.asIdeal))

/-- The honest residue degree of the finite place over its prime field. -/
noncomputable def residueDegree
    (v : HeightOneSpectrum (𝓞 F)) : ℕ := by
  letI : Fact (Nat.Prime (ringChar (𝓞 F ⧸ v.asIdeal))) :=
    ⟨residueRingChar_prime v⟩
  letI : Algebra (ZMod (ringChar (𝓞 F ⧸ v.asIdeal)))
      (𝓞 F ⧸ v.asIdeal) :=
    ZMod.algebra (𝓞 F ⧸ v.asIdeal)
      (ringChar (𝓞 F ⧸ v.asIdeal))
  exact Module.finrank (ZMod (ringChar (𝓞 F ⧸ v.asIdeal)))
    (𝓞 F ⧸ v.asIdeal)

/-- The absolute norm includes exactly the residue-degree exponent. -/
theorem absNorm_eq_residueRingChar_pow_residueDegree :
    Ideal.absNorm v.asIdeal =
      ringChar (𝓞 F ⧸ v.asIdeal) ^ residueDegree v := by
  letI : Fact (Nat.Prime (ringChar (𝓞 F ⧸ v.asIdeal))) :=
    ⟨residueRingChar_prime v⟩
  letI : Algebra (ZMod (ringChar (𝓞 F ⧸ v.asIdeal)))
      (𝓞 F ⧸ v.asIdeal) :=
    ZMod.algebra (𝓞 F ⧸ v.asIdeal)
      (ringChar (𝓞 F ⧸ v.asIdeal))
  calc
    Ideal.absNorm v.asIdeal = Nat.card (𝓞 F ⧸ v.asIdeal) := by
      simp only [Ideal.absNorm_apply, Submodule.cardQuot_apply]
    _ = Nat.card (ZMod (ringChar (𝓞 F ⧸ v.asIdeal))) ^
          Module.finrank (ZMod (ringChar (𝓞 F ⧸ v.asIdeal)))
            (𝓞 F ⧸ v.asIdeal) :=
      Module.natCard_eq_pow_finrank
        (K := ZMod (ringChar (𝓞 F ⧸ v.asIdeal)))
        (V := 𝓞 F ⧸ v.asIdeal)
    _ = ringChar (𝓞 F ⧸ v.asIdeal) ^
          Module.finrank (ZMod (ringChar (𝓞 F ⧸ v.asIdeal)))
            (𝓞 F ⧸ v.asIdeal) := by
      rw [Nat.card_zmod]

/-- Equivalently, the logarithm of the absolute norm is the residue degree
times the logarithm of the residue characteristic. -/
theorem log_absNorm_eq_residueDegree_mul_log_residueRingChar :
    Real.log (Ideal.absNorm v.asIdeal : ℝ) =
      (residueDegree v : ℝ) *
        Real.log (ringChar (𝓞 F ⧸ v.asIdeal) : ℝ) := by
  rw [absNorm_eq_residueRingChar_pow_residueDegree]
  rw [Nat.cast_pow, Real.log_pow]

end LocalCompletionNormValuationBridge

namespace ActualBadPlaceQPilotPacket

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- The finite dependent index type of the actual bad-place packet. -/
abbrev Index (Q : QPilotData D) :=
  {w : FinitePlace D.F // w ∈ Q.badFinset}

/-- The actual bad Hodge-theater place at one enumerated coordinate.  This is
derived from `Q.badFinset_spec`; it is not an additional local choice. -/
def place (Q : QPilotData D) (w : Index Q) :
    ActualBadHodgeTheaterPlace D :=
  ⟨w.1, Q.mem_bad w.2⟩

@[simp]
theorem place_w (Q : QPilotData D) (w : Index Q) :
    (place Q w).w = w.1 :=
  rfl

@[simp]
theorem place_qOrder (Q : QPilotData D) (w : Index Q) :
    (place Q w).qOrder =
      D.prime.qOrder w.1 (Q.mem_bad w.2) :=
  rfl

/-- The genuine distributive Haar character of the actual Tate parameter.
Local compactness is derived from the completed finite place. -/
noncomputable def localHaarCharacter
    (H : ActualBadHodgeTheaterPlace D) : ℝ≥0 := by
  letI : NontriviallyNormedField H.TateField :=
    Valued.toNontriviallyNormedField H.TateField ℤᵐ⁰
  letI : Valued H.TateField ℝ≥0 := NormedField.toValued
  letI : IsUltrametricDist H.TateField :=
    LocalCompletionNormValuationBridge.completionIsUltrametricDist
      H.w.maximalIdeal
  letI : ProperSpace H.TateField :=
    LocalCompletionNormValuationBridge.completionProperSpace
      H.w.maximalIdeal
  exact distribHaarChar H.TateField H.tate.q

/-- The signed logarithmic Haar-volume entry at one actual bad place. -/
noncomputable def localHaarLog
    (H : ActualBadHodgeTheaterPlace D) : ℝ :=
  Real.log (localHaarCharacter H : ℝ)

/-- The completion residue field retains exactly the absolute norm of the
global finite place. -/
theorem normResidueCard_eq_absNorm
    (H : ActualBadHodgeTheaterPlace D) :
    letI : NontriviallyNormedField H.TateField :=
      Valued.toNontriviallyNormedField H.TateField ℤᵐ⁰
    letI : Valued H.TateField ℝ≥0 := NormedField.toValued
    letI : IsDiscreteValuationRing 𝒪[H.TateField] := by
      change IsDiscreteValuationRing
        (LocalCompletionNormValuationBridge.normIntegerRing
          H.w.maximalIdeal)
      exact
        LocalCompletionNormValuationBridge.normIntegerRingIsDiscreteValuationRing
          H.w.maximalIdeal
    letI : Finite 𝓀[H.TateField] := by
      letI : IsDiscreteValuationRing
          (LocalCompletionNormValuationBridge.normIntegerRing
            H.w.maximalIdeal) :=
        LocalCompletionNormValuationBridge.normIntegerRingIsDiscreteValuationRing
          H.w.maximalIdeal
      change Finite
        (IsLocalRing.ResidueField
          (LocalCompletionNormValuationBridge.normIntegerRing
            H.w.maximalIdeal))
      exact LocalCompletionNormValuationBridge.normResidueFinite
        H.w.maximalIdeal
    Nat.card 𝓀[H.TateField] =
      Ideal.absNorm H.w.maximalIdeal.asIdeal := by
  letI : NontriviallyNormedField H.TateField :=
    Valued.toNontriviallyNormedField H.TateField ℤᵐ⁰
  letI : Valued H.TateField ℝ≥0 := NormedField.toValued
  letI : IsDiscreteValuationRing 𝒪[H.TateField] := by
    change IsDiscreteValuationRing
      (LocalCompletionNormValuationBridge.normIntegerRing
        H.w.maximalIdeal)
    exact
      LocalCompletionNormValuationBridge.normIntegerRingIsDiscreteValuationRing
        H.w.maximalIdeal
  letI : Finite 𝓀[H.TateField] := by
    letI : IsDiscreteValuationRing
        (LocalCompletionNormValuationBridge.normIntegerRing
          H.w.maximalIdeal) :=
      LocalCompletionNormValuationBridge.normIntegerRingIsDiscreteValuationRing
        H.w.maximalIdeal
    change Finite
      (IsLocalRing.ResidueField
        (LocalCompletionNormValuationBridge.normIntegerRing
          H.w.maximalIdeal))
    exact LocalCompletionNormValuationBridge.normResidueFinite
      H.w.maximalIdeal
  calc
    Nat.card 𝓀[H.TateField] =
        Nat.card
          (IsLocalRing.ResidueField
            (H.w.maximalIdeal.adicCompletionIntegers D.F)) :=
      Nat.card_congr
        (LocalCompletionNormValuationBridge.normResidueEquivNative
          H.w.maximalIdeal).toEquiv
    _ = Ideal.absNorm H.w.maximalIdeal.asIdeal :=
      LocalCompletionNormValuationBridge.natCard_nativeResidue_eq_absNorm
        H.w.maximalIdeal

/-- Exact local formula with all signs and the full residue-degree weight:
the smaller region `q O_K` has negative logarithmic volume. -/
theorem localHaarLog_eq_neg_qOrder_arithmeticPlaceWeight
    (H : ActualBadHodgeTheaterPlace D) :
    localHaarLog H =
      -(H.qOrder : ℝ) *
        Iut4Sec1.arithmeticPlaceWeight (.inl H.w) := by
  letI : NontriviallyNormedField H.TateField :=
    Valued.toNontriviallyNormedField H.TateField ℤᵐ⁰
  letI : Valued H.TateField ℝ≥0 := NormedField.toValued
  letI : IsUltrametricDist H.TateField :=
    LocalCompletionNormValuationBridge.completionIsUltrametricDist
      H.w.maximalIdeal
  letI : IsDiscreteValuationRing 𝒪[H.TateField] := by
    change IsDiscreteValuationRing
      (LocalCompletionNormValuationBridge.normIntegerRing
        H.w.maximalIdeal)
    exact
      LocalCompletionNormValuationBridge.normIntegerRingIsDiscreteValuationRing
        H.w.maximalIdeal
  letI : Finite 𝓀[H.TateField] := by
    letI : IsDiscreteValuationRing
        (LocalCompletionNormValuationBridge.normIntegerRing
          H.w.maximalIdeal) :=
      LocalCompletionNormValuationBridge.normIntegerRingIsDiscreteValuationRing
        H.w.maximalIdeal
    change Finite
      (IsLocalRing.ResidueField
        (LocalCompletionNormValuationBridge.normIntegerRing
          H.w.maximalIdeal))
    exact LocalCompletionNormValuationBridge.normResidueFinite
      H.w.maximalIdeal
  letI : ProperSpace H.TateField :=
    LocalCompletionNormValuationBridge.completionProperSpace
      H.w.maximalIdeal
  letI : MeasurableSpace H.TateField := borel H.TateField
  letI : BorelSpace H.TateField := ⟨rfl⟩
  have hlocal :=
    ActualBadHodgeTheaterPlace.log_distribHaarChar_q_eq_qOrder_residueCard H
  have hcard := normResidueCard_eq_absNorm H
  simpa [localHaarLog, localHaarCharacter,
    Iut4Sec1.arithmeticPlaceWeight, hcard] using hlocal

/-- The derived local log entry at an enumerated bad place. -/
noncomputable def entry (Q : QPilotData D) (w : Index Q) : ℝ :=
  localHaarLog (place Q w)

/-- Pointwise packet formula.  It uses the source Tate order and the complete
arithmetic place weight `log(absNorm w)`. -/
theorem entry_eq_neg_qOrder_arithmeticPlaceWeight
    (Q : QPilotData D) (w : Index Q) :
    entry Q w =
      -(D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
        Iut4Sec1.arithmeticPlaceWeight (.inl w.1) := by
  change localHaarLog (place Q w) = _
  rw [← place_qOrder Q w]
  exact localHaarLog_eq_neg_qOrder_arithmeticPlaceWeight (place Q w)

/-- The finite-place arithmetic weight explicitly contains the residue
degree. -/
theorem arithmeticPlaceWeight_eq_residueDegree_mul_log_residueChar
    (w : FinitePlace D.F) :
    Iut4Sec1.arithmeticPlaceWeight (.inl w) =
      (LocalCompletionNormValuationBridge.residueDegree
        w.maximalIdeal : ℝ) *
        Real.log (Iut.residueChar w : ℝ) := by
  simpa [Iut4Sec1.arithmeticPlaceWeight, Iut.residueChar] using
    (LocalCompletionNormValuationBridge.log_absNorm_eq_residueDegree_mul_log_residueRingChar
        w.maximalIdeal)

/-- Fully expanded pointwise formula, displaying the residue degree rather
than silently replacing the residue-field cardinality by its prime. -/
theorem entry_eq_neg_qOrder_mul_residueDegree_mul_logResidueChar
    (Q : QPilotData D) (w : Index Q) :
    entry Q w =
      -(D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
        (LocalCompletionNormValuationBridge.residueDegree
          w.1.maximalIdeal : ℝ) *
          Real.log (Iut.residueChar w.1 : ℝ) := by
  rw [entry_eq_neg_qOrder_arithmeticPlaceWeight,
    arithmeticPlaceWeight_eq_residueDegree_mul_log_residueChar]
  ring

/-- The genuine finite signed Haar-log packet sum. -/
noncomputable def signedHaarLogSum (Q : QPilotData D) : ℝ :=
  ∑ w ∈ Q.badFinset.attach, entry Q w

/-- The positive raw arithmetic mass of the q-divisor. -/
noncomputable def arithmeticMass (Q : QPilotData D) : ℝ :=
  ∑ w ∈ Q.badFinset.attach,
    (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
      Iut4Sec1.arithmeticPlaceWeight (.inl w.1)

/-- Summing the pointwise formula gives the expected negative sign. -/
theorem signedHaarLogSum_eq_neg_arithmeticMass (Q : QPilotData D) :
    signedHaarLogSum Q = -arithmeticMass Q := by
  classical
  rw [signedHaarLogSum, arithmeticMass, ← Finset.sum_neg_distrib]
  apply Finset.sum_congr rfl
  intro w hw
  rw [entry_eq_neg_qOrder_arithmeticPlaceWeight]
  ring

private theorem arithmeticDivisorDegree_single
    (w : Iut4Sec1.ArithmeticPlace D.F) (c : ℝ) :
    Iut4Sec1.arithmeticDivisorDegree
        (Finsupp.single w c : Iut4Sec1.ArithmeticDivisor D.F) =
      c * Iut4Sec1.arithmeticPlaceWeight w := by
  classical
  simp [Iut4Sec1.arithmeticDivisorDegree]

/-- The raw Haar mass is exactly the degree of the explicit effective
arithmetic q-divisor. -/
theorem arithmeticDivisorDegree_qArithmeticDivisor_eq_arithmeticMass
    (Q : QPilotData D) :
    Iut4Sec1.arithmeticDivisorDegree (qArithmeticDivisor Q) =
      arithmeticMass Q := by
  classical
  rw [qArithmeticDivisor, arithmeticMass]
  change
    Iut4Sec1.arithmeticDivisorDegreeHom
      (∑ w ∈ Q.badFinset.attach,
        Finsupp.single (.inl w.1)
          (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ)) = _
  simp only [map_sum, Iut4Sec1.arithmeticDivisorDegreeHom_apply,
    arithmeticDivisorDegree_single]

/-- Unnormalized finite-packet identity. -/
theorem neg_signedHaarLogSum_eq_arithmeticDivisorDegree
    (Q : QPilotData D) :
    -signedHaarLogSum Q =
      Iut4Sec1.arithmeticDivisorDegree (qArithmeticDivisor Q) := by
  rw [signedHaarLogSum_eq_neg_arithmeticMass,
    neg_neg,
    arithmeticDivisorDegree_qArithmeticDivisor_eq_arithmeticMass]

/-- The normalized positive logarithm reconstructed from the actual Haar
packet, with the number-field degree normalization made explicit. -/
noncomputable def normalizedHaarLogQ (Q : QPilotData D) : ℝ :=
  -signedHaarLogSum Q / (Module.finrank ℚ D.F : ℝ)

/-- The actual finite Haar packet reconstructs the normalized degree of the
arithmetic q-divisor unconditionally. -/
theorem normalizedHaarLogQ_eq_arithmeticLogQ (Q : QPilotData D) :
    normalizedHaarLogQ Q = arithmeticLogQ Q := by
  rw [normalizedHaarLogQ, neg_signedHaarLogSum_eq_arithmeticDivisorDegree,
    arithmeticLogQ, Iut4Sec1.normalizedArithmeticDivisorDegree]

/-- Identification with the public scalar is exactly conditional on the
public arbitrary weights having the arithmetic-degree normalization. -/
theorem normalizedHaarLogQ_eq_publicLogQ
    (Q : QPilotData D) (hcompat : QPilotWeightDegreeCompatible Q) :
    normalizedHaarLogQ Q = Q.logQ := by
  rw [normalizedHaarLogQ_eq_arithmeticLogQ,
    arithmeticLogQ_eq_publicLogQ Q hcompat]

end ActualBadPlaceQPilotPacket

end
end IUTThreeClosures
