/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CanonicalExponentHeightLedger
import IUTThreeClosures.ABCPointLegendreCurve
import Mathlib.Tactic

/-! Canonical point specialization of the two-sided exponent-height ledger. -/

namespace IUTThreeClosures

open CanonicalExponentHeightLedger

noncomputable section

namespace ABCPoint

def canonicalGapRadicalLog (P : ABCPoint) : ℝ :=
  Real.log (abcRadical P.endpointMin : ℝ)

def canonicalLargeResidualLog (P : ABCPoint) : ℝ :=
  Real.log (P.canonicalLargeRadicalResidual : ℝ)

def canonicalSumResidualLog (P : ABCPoint) : ℝ :=
  Real.log (P.canonicalSumRadicalResidual : ℝ)

def canonicalLargeModulusLog (P : ABCPoint) : ℝ :=
  Real.log (P.canonicalLargePowerfulModulus : ℝ)

def canonicalSumModulusLog (P : ABCPoint) : ℝ :=
  Real.log (P.canonicalSumPowerfulModulus : ℝ)

@[simp] theorem canonicalLargePowerfulModulus_pos (P : ABCPoint) :
    0 < P.canonicalLargePowerfulModulus := by
  have hprod : 0 < P.canonicalLargePowerfulModulus *
      P.canonicalLargeRadicalResidual := by
    rw [P.canonicalLarge_factorization]
    exact P.largeEndpoint_pos
  exact pos_of_mul_pos_left hprod (Nat.zero_le _)

@[simp] theorem canonicalSumPowerfulModulus_pos (P : ABCPoint) :
    0 < P.canonicalSumPowerfulModulus := by
  have hprod : 0 < P.canonicalSumPowerfulModulus *
      P.canonicalSumRadicalResidual := by
    rw [P.canonicalSum_factorization]
    exact P.c_pos
  exact pos_of_mul_pos_left hprod (Nat.zero_le _)

@[simp] theorem canonicalLargeRadicalResidual_pos (P : ABCPoint) :
    0 < P.canonicalLargeRadicalResidual := by
  unfold canonicalLargeRadicalResidual
  exact abcRadical_pos P.largeEndpoint

@[simp] theorem canonicalSumRadicalResidual_pos (P : ABCPoint) :
    0 < P.canonicalSumRadicalResidual := by
  unfold canonicalSumRadicalResidual
  exact abcRadical_pos P.c

theorem abcRadical_eq_gap_mul_canonicalResiduals (P : ABCPoint) :
    abcRadical (P.a * P.b * P.c) =
      abcRadical P.endpointMin * P.canonicalLargeRadicalResidual *
        P.canonicalSumRadicalResidual := by
  rw [P.abcRadical_abcProduct]
  by_cases hab : P.a ≤ P.b
  · simp [endpointMin, largeEndpoint, canonicalLargeRadicalResidual,
      canonicalSumRadicalResidual, hab]
  · have hba : P.b ≤ P.a := Nat.le_of_not_ge hab
    simp [endpointMin, largeEndpoint, canonicalLargeRadicalResidual,
      canonicalSumRadicalResidual, hba, Nat.mul_comm, Nat.mul_assoc]

theorem height_eq_sumModulusLog_add_sumResidualLog (P : ABCPoint) :
    P.height = P.canonicalSumModulusLog + P.canonicalSumResidualLog := by
  have hS : 0 < (P.canonicalSumPowerfulModulus : ℝ) := by
    exact_mod_cast P.canonicalSumPowerfulModulus_pos
  have hB : 0 < (P.canonicalSumRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalSumRadicalResidual_pos
  have hfactor : (P.c : ℝ) =
      (P.canonicalSumPowerfulModulus : ℝ) *
        (P.canonicalSumRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalSum_factorization.symm
  rw [P.height_eq_log_c, hfactor, Real.log_mul hS.ne' hB.ne']
  rfl

theorem canonical_c_le_two_mul_largeEndpoint (P : ABCPoint) :
    P.c ≤ 2 * P.largeEndpoint := by
  have hminle : P.endpointMin ≤ P.largeEndpoint := by
    unfold endpointMin largeEndpoint
    exact min_le_max
  rw [← P.endpointMin_add_largeEndpoint_eq_c]
  omega

theorem height_sub_log_two_le_largeModulusLog_add_largeResidualLog
    (P : ABCPoint) :
    P.height - Real.log 2 ≤
      P.canonicalLargeModulusLog + P.canonicalLargeResidualLog := by
  have hc : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hM : 0 < (P.largeEndpoint : ℝ) := by
    exact_mod_cast P.largeEndpoint_pos
  have hR : 0 < (P.canonicalLargePowerfulModulus : ℝ) := by
    exact_mod_cast P.canonicalLargePowerfulModulus_pos
  have hA : 0 < (P.canonicalLargeRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalLargeRadicalResidual_pos
  have hle : (P.c : ℝ) ≤ 2 * (P.largeEndpoint : ℝ) := by
    exact_mod_cast P.canonical_c_le_two_mul_largeEndpoint
  have hlog := Real.log_le_log hc hle
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hM.ne'] at hlog
  have hfactor : (P.largeEndpoint : ℝ) =
      (P.canonicalLargePowerfulModulus : ℝ) *
        (P.canonicalLargeRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalLarge_factorization.symm
  rw [hfactor, Real.log_mul hR.ne' hA.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold canonicalLargeModulusLog canonicalLargeResidualLog
  linarith

theorem conductor_eq_gap_add_residualLogs (P : ABCPoint) :
    P.conductor = P.canonicalGapRadicalLog +
      P.canonicalLargeResidualLog + P.canonicalSumResidualLog := by
  have hgap : 0 < (abcRadical P.endpointMin : ℝ) := by
    exact_mod_cast abcRadical_pos P.endpointMin
  have hA : 0 < (P.canonicalLargeRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalLargeRadicalResidual_pos
  have hB : 0 < (P.canonicalSumRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalSumRadicalResidual_pos
  have hfactor : (abcRadical (P.a * P.b * P.c) : ℝ) =
      (abcRadical P.endpointMin : ℝ) *
        (P.canonicalLargeRadicalResidual : ℝ) *
          (P.canonicalSumRadicalResidual : ℝ) := by
    exact_mod_cast P.abcRadical_eq_gap_mul_canonicalResiduals
  unfold ABCPoint.conductor canonicalGapRadicalLog
    canonicalLargeResidualLog canonicalSumResidualLog
  rw [hfactor, Real.log_mul (mul_pos hgap hA).ne' hB.ne',
    Real.log_mul hgap.ne' hA.ne']

theorem log_natCast_nonneg {n : ℕ} (hn : 0 < n) :
    0 ≤ Real.log (n : ℝ) := by
  apply Real.log_nonneg
  exact_mod_cast (Nat.one_le_iff_ne_zero.mpr hn.ne')

theorem largeResidualLog_le_conductor (P : ABCPoint) :
    P.canonicalLargeResidualLog ≤ P.conductor := by
  rw [P.conductor_eq_gap_add_residualLogs]
  have hgap : 0 ≤ P.canonicalGapRadicalLog := by
    unfold canonicalGapRadicalLog
    exact log_natCast_nonneg (abcRadical_pos P.endpointMin)
  have hB : 0 ≤ P.canonicalSumResidualLog := by
    unfold canonicalSumResidualLog
    exact log_natCast_nonneg P.canonicalSumRadicalResidual_pos
  linarith

theorem sumResidualLog_le_conductor (P : ABCPoint) :
    P.canonicalSumResidualLog ≤ P.conductor := by
  rw [P.conductor_eq_gap_add_residualLogs]
  have hgap : 0 ≤ P.canonicalGapRadicalLog := by
    unfold canonicalGapRadicalLog
    exact log_natCast_nonneg (abcRadical_pos P.endpointMin)
  have hA : 0 ≤ P.canonicalLargeResidualLog := by
    unfold canonicalLargeResidualLog
    exact log_natCast_nonneg P.canonicalLargeRadicalResidual_pos
  linarith

theorem bothCanonicalModuli_heightScale_of_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hepsilon : 0 < epsilon)
    (hviolation : (1 + epsilon) * P.conductor + C < P.height) :
    (epsilon * P.height + C <
        (1 + epsilon) * P.canonicalSumModulusLog) ∧
      (epsilon * P.height + C - (1 + epsilon) * Real.log 2 <
        (1 + epsilon) * P.canonicalLargeModulusLog) := by
  exact bothModuli_heightScale hepsilon
    P.largeResidualLog_le_conductor P.sumResidualLog_le_conductor
    P.height_eq_sumModulusLog_add_sumResidualLog
    P.height_sub_log_two_le_largeModulusLog_add_largeResidualLog
    hviolation

theorem bothCanonicalModuli_crossSupport_of_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation : (1 + epsilon) * P.conductor + C < P.height) :
    ((1 + epsilon) *
          (P.canonicalGapRadicalLog + P.canonicalLargeResidualLog) +
        epsilon * P.canonicalSumResidualLog + C <
          P.canonicalSumModulusLog) ∧
      (epsilon * P.canonicalLargeResidualLog +
          (1 + epsilon) *
            (P.canonicalGapRadicalLog + P.canonicalSumResidualLog) +
          C - Real.log 2 < P.canonicalLargeModulusLog) := by
  have hv : (1 + epsilon) *
      (P.canonicalGapRadicalLog + P.canonicalLargeResidualLog +
        P.canonicalSumResidualLog) + C < P.height := by
    rw [← P.conductor_eq_gap_add_residualLogs]
    exact hviolation
  exact ⟨rightModulus_crossSupport_lower
      P.height_eq_sumModulusLog_add_sumResidualLog hv,
    leftModulus_crossSupport_lower
      P.height_sub_log_two_le_largeModulusLog_add_largeResidualLog hv⟩

theorem totalCanonicalModulus_crossSupport_of_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation : (1 + epsilon) * P.conductor + C < P.height) :
    (1 + 2 * epsilon) *
          (P.canonicalLargeResidualLog + P.canonicalSumResidualLog) +
        2 * (1 + epsilon) * P.canonicalGapRadicalLog +
          2 * C - Real.log 2 <
      P.canonicalLargeModulusLog + P.canonicalSumModulusLog := by
  have hv : (1 + epsilon) *
      (P.canonicalGapRadicalLog + P.canonicalLargeResidualLog +
        P.canonicalSumResidualLog) + C < P.height := by
    rw [← P.conductor_eq_gap_add_residualLogs]
    exact hviolation
  exact totalModulus_crossSupport_lower
    P.height_eq_sumModulusLog_add_sumResidualLog
    P.height_sub_log_two_le_largeModulusLog_add_largeResidualLog hv

end ABCPoint

namespace CanonicalExponentHeightPoint

#print axioms ABCPoint.abcRadical_eq_gap_mul_canonicalResiduals
#print axioms ABCPoint.height_eq_sumModulusLog_add_sumResidualLog
#print axioms ABCPoint.height_sub_log_two_le_largeModulusLog_add_largeResidualLog
#print axioms ABCPoint.conductor_eq_gap_add_residualLogs
#print axioms ABCPoint.bothCanonicalModuli_heightScale_of_violation
#print axioms ABCPoint.bothCanonicalModuli_crossSupport_of_violation
#print axioms ABCPoint.totalCanonicalModulus_crossSupport_of_violation

end CanonicalExponentHeightPoint
end
end IUTThreeClosures
