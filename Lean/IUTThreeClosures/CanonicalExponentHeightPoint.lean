/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CanonicalExponentHeightLedger
import IUTThreeClosures.ABCPointLegendreCurve
import Mathlib.Tactic

/-!
# The exponent-height ledger on actual canonical abc data

This file instantiates the real-algebra ledger on the canonical decomposition
of a primitive abc point.  It proves the exact conductor splitting

`conductor = log rad(min(a,b)) + log rad(max(a,b)) + log rad(c)`

and the two endpoint logarithmic decompositions.  Consequently every actual
abc violation forces both canonical powerful moduli to have height-scale
logarithmic size.
-/

namespace IUTThreeClosures
namespace CanonicalExponentHeightPoint

open CanonicalExponentHeightLedger

noncomputable section

namespace ABCPoint

/-- Logarithmic radical of the small endpoint. -/
def canonicalGapRadicalLog (P : ABCPoint) : ℝ :=
  Real.log (abcRadical P.endpointMin : ℝ)

/-- Logarithmic squarefree residual on the large summand. -/
def canonicalLargeResidualLog (P : ABCPoint) : ℝ :=
  Real.log (P.canonicalLargeRadicalResidual : ℝ)

/-- Logarithmic squarefree residual on the sum endpoint. -/
def canonicalSumResidualLog (P : ABCPoint) : ℝ :=
  Real.log (P.canonicalSumRadicalResidual : ℝ)

/-- Weighted exponent height on the large summand. -/
def canonicalLargeModulusLog (P : ABCPoint) : ℝ :=
  Real.log (P.canonicalLargePowerfulModulus : ℝ)

/-- Weighted exponent height on the sum endpoint. -/
def canonicalSumModulusLog (P : ABCPoint) : ℝ :=
  Real.log (P.canonicalSumPowerfulModulus : ℝ)

@[simp]
theorem canonicalLargePowerfulModulus_pos (P : ABCPoint) :
    0 < P.canonicalLargePowerfulModulus := by
  have hfactor := P.canonicalLarge_factorization
  by_contra hnot
  have hzero : P.canonicalLargePowerfulModulus = 0 :=
    Nat.eq_zero_of_not_pos hnot
  rw [hzero, zero_mul] at hfactor
  omega

@[simp]
theorem canonicalSumPowerfulModulus_pos (P : ABCPoint) :
    0 < P.canonicalSumPowerfulModulus := by
  have hfactor := P.canonicalSum_factorization
  by_contra hnot
  have hzero : P.canonicalSumPowerfulModulus = 0 :=
    Nat.eq_zero_of_not_pos hnot
  rw [hzero, zero_mul] at hfactor
  omega

@[simp]
theorem canonicalLargeRadicalResidual_pos (P : ABCPoint) :
    0 < P.canonicalLargeRadicalResidual := by
  unfold canonicalLargeRadicalResidual
  exact abcRadical_pos P.largeEndpoint

@[simp]
theorem canonicalSumRadicalResidual_pos (P : ABCPoint) :
    0 < P.canonicalSumRadicalResidual := by
  unfold canonicalSumRadicalResidual
  exact abcRadical_pos P.c

/-- Reordering the two summands does not change their product. -/
theorem endpointMin_mul_largeEndpoint (P : ABCPoint) :
    P.endpointMin * P.largeEndpoint = P.a * P.b := by
  by_cases hab : P.a ≤ P.b
  · simp [endpointMin, largeEndpoint, hab]
  · have hba : P.b ≤ P.a := Nat.le_of_not_ge hab
    simp [endpointMin, largeEndpoint, hab, hba, Nat.mul_comm]

/-- The full abc radical is exactly the product of the gap radical and the two
canonical squarefree residuals. -/
theorem abcRadical_eq_gap_mul_canonicalResiduals (P : ABCPoint) :
    abcRadical (P.a * P.b * P.c) =
      abcRadical P.endpointMin *
        P.canonicalLargeRadicalResidual *
          P.canonicalSumRadicalResidual := by
  rw [P.abcRadical_abcProduct]
  by_cases hab : P.a ≤ P.b
  · simp [endpointMin, largeEndpoint,
      canonicalLargeRadicalResidual, canonicalSumRadicalResidual, hab]
  · have hba : P.b ≤ P.a := Nat.le_of_not_ge hab
    simp [endpointMin, largeEndpoint,
      canonicalLargeRadicalResidual, canonicalSumRadicalResidual,
      hab, hba, Nat.mul_comm]

/-- The sum endpoint has the exact logarithmic decomposition `h=v+b`. -/
theorem height_eq_sumModulusLog_add_sumResidualLog (P : ABCPoint) :
    P.height = P.canonicalSumModulusLog + P.canonicalSumResidualLog := by
  have hS : 0 < (P.canonicalSumPowerfulModulus : ℝ) := by
    exact_mod_cast P.canonicalSumPowerfulModulus_pos
  have hB : 0 < (P.canonicalSumRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalSumRadicalResidual_pos
  have hfactor :
      (P.c : ℝ) =
        (P.canonicalSumPowerfulModulus : ℝ) *
          (P.canonicalSumRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalSum_factorization.symm
  rw [P.height_eq_log_c, hfactor,
    Real.log_mul hS.ne' hB.ne']
  rfl

/-- The small and large summands imply `c <= 2*max(a,b)`. -/
theorem c_le_two_mul_largeEndpoint (P : ABCPoint) :
    P.c ≤ 2 * P.largeEndpoint := by
  have hminle : P.endpointMin ≤ P.largeEndpoint := by
    simpa [endpointMin, largeEndpoint] using
      (min_le_max P.a P.b)
  rw [← P.endpointMin_add_largeEndpoint_eq_c]
  omega

/-- The opposite large endpoint gives `h-log 2 <= u+a`. -/
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
    exact_mod_cast P.c_le_two_mul_largeEndpoint
  have hlog := Real.log_le_log hc hle
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hM.ne'] at hlog
  have hfactor :
      (P.largeEndpoint : ℝ) =
        (P.canonicalLargePowerfulModulus : ℝ) *
          (P.canonicalLargeRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalLarge_factorization.symm
  rw [P.height_eq_log_c]
  unfold canonicalLargeModulusLog canonicalLargeResidualLog
  rw [hfactor, Real.log_mul hR.ne' hA.ne']
  linarith

/-- Exact logarithmic splitting of the elementary abc conductor. -/
theorem conductor_eq_gap_add_residualLogs (P : ABCPoint) :
    P.conductor =
      P.canonicalGapRadicalLog +
        P.canonicalLargeResidualLog +
          P.canonicalSumResidualLog := by
  have hgap : 0 < (abcRadical P.endpointMin : ℝ) := by
    exact_mod_cast abcRadical_pos P.endpointMin
  have hA : 0 < (P.canonicalLargeRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalLargeRadicalResidual_pos
  have hB : 0 < (P.canonicalSumRadicalResidual : ℝ) := by
    exact_mod_cast P.canonicalSumRadicalResidual_pos
  have hfactor :
      (abcRadical (P.a * P.b * P.c) : ℝ) =
        (abcRadical P.endpointMin : ℝ) *
          (P.canonicalLargeRadicalResidual : ℝ) *
            (P.canonicalSumRadicalResidual : ℝ) := by
    exact_mod_cast P.abcRadical_eq_gap_mul_canonicalResiduals
  unfold ABCPoint.conductor canonicalGapRadicalLog
    canonicalLargeResidualLog canonicalSumResidualLog
  rw [hfactor,
    Real.log_mul (mul_pos hgap hA).ne' hB.ne',
    Real.log_mul hgap.ne' hA.ne']

/-- Logarithms of positive natural numbers are nonnegative. -/
theorem log_natCast_nonneg {n : ℕ} (hn : 0 < n) :
    0 ≤ Real.log (n : ℝ) := by
  apply Real.log_nonneg
  exact_mod_cast (Nat.one_le_iff_ne_zero.mpr hn.ne')

/-- Each squarefree residual contributes no more than the full conductor. -/
theorem largeResidualLog_le_conductor (P : ABCPoint) :
    P.canonicalLargeResidualLog ≤ P.conductor := by
  rw [P.conductor_eq_gap_add_residualLogs]
  have hgap := log_natCast_nonneg (abcRadical_pos P.endpointMin)
  have hB := log_natCast_nonneg P.canonicalSumRadicalResidual_pos
  unfold canonicalGapRadicalLog canonicalSumResidualLog at hgap hB
  linarith

/-- Sum-endpoint residual analogue. -/
theorem sumResidualLog_le_conductor (P : ABCPoint) :
    P.canonicalSumResidualLog ≤ P.conductor := by
  rw [P.conductor_eq_gap_add_residualLogs]
  have hgap := log_natCast_nonneg (abcRadical_pos P.endpointMin)
  have hA := log_natCast_nonneg P.canonicalLargeRadicalResidual_pos
  unfold canonicalGapRadicalLog canonicalLargeResidualLog at hgap hA
  linarith

/-- Every actual abc violation forces both canonical exponent vectors to be
height-scale. -/
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

/-- Refined cross-support bounds on both actual exponent vectors. -/
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
  have hviolation' :
      (1 + epsilon) *
          (P.canonicalGapRadicalLog +
            P.canonicalLargeResidualLog +
              P.canonicalSumResidualLog) + C < P.height := by
    rw [← P.conductor_eq_gap_add_residualLogs]
    exact hviolation
  exact ⟨rightModulus_crossSupport_lower
      P.height_eq_sumModulusLog_add_sumResidualLog hviolation',
    leftModulus_crossSupport_lower
      P.height_sub_log_two_le_largeModulusLog_add_largeResidualLog
      hviolation'⟩

/-- Total weighted exponent height forced by an actual violation. -/
theorem totalCanonicalModulus_crossSupport_of_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation : (1 + epsilon) * P.conductor + C < P.height) :
    (1 + 2 * epsilon) *
          (P.canonicalLargeResidualLog + P.canonicalSumResidualLog) +
        2 * (1 + epsilon) * P.canonicalGapRadicalLog +
          2 * C - Real.log 2 <
      P.canonicalLargeModulusLog + P.canonicalSumModulusLog := by
  have hviolation' :
      (1 + epsilon) *
          (P.canonicalGapRadicalLog +
            P.canonicalLargeResidualLog +
              P.canonicalSumResidualLog) + C < P.height := by
    rw [← P.conductor_eq_gap_add_residualLogs]
    exact hviolation
  exact totalModulus_crossSupport_lower
    P.height_eq_sumModulusLog_add_sumResidualLog
    P.height_sub_log_two_le_largeModulusLog_add_largeResidualLog
    hviolation'

#print axioms ABCPoint.abcRadical_eq_gap_mul_canonicalResiduals
#print axioms ABCPoint.height_eq_sumModulusLog_add_sumResidualLog
#print axioms ABCPoint.height_sub_log_two_le_largeModulusLog_add_largeResidualLog
#print axioms ABCPoint.conductor_eq_gap_add_residualLogs
#print axioms ABCPoint.bothCanonicalModuli_heightScale_of_violation
#print axioms ABCPoint.bothCanonicalModuli_crossSupport_of_violation
#print axioms ABCPoint.totalCanonicalModulus_crossSupport_of_violation

end ABCPoint
end
end CanonicalExponentHeightPoint
end IUTThreeClosures
