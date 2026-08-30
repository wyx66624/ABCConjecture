/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointSignedExcessClosure
import Mathlib.Tactic

/-!
# Exact compensation of cubeful mass by the remaining radical

For the large-endpoint product `n = max(a,b)*c`, its radical divides the full
abc radical.  The quotient is the radical contribution omitted from `n`
(and, for a primitive abc point, is the radical of the smaller summand).

This file proves an exact coefficient-one closure criterion:

`cubefulExcess(n) <= squarefreeDeficit(n) * externalRadicalQuotient^2`

implies

`height <= conductor + log 2 / 2`.

Consequently every violation of that strong estimate forces the strict reverse
inequality.  This is a concrete prime-exponent classification, not an assumed
height theorem.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid
open LargeEndpointCubefulExcess
open LargeEndpointSignedExcess

noncomputable section

namespace ABCPoint

/-- Radical mass outside the product of the two large endpoints. -/
def externalRadicalQuotient (P : ABCPoint) : ℕ :=
  abcRadical (P.a * P.b * P.c) /
    abcRadical (P.largeEndpoint * P.c)

/-- The large-endpoint radical divides the full abc radical. -/
theorem largeEndpointProductRadical_dvd_abcRadical (P : ABCPoint) :
    abcRadical (P.largeEndpoint * P.c) ∣
      abcRadical (P.a * P.b * P.c) := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical]
  have htarget : P.a * P.b * P.c ≠ 0 :=
    (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos).ne'
  exact radical_dvd_radical P.largeEndpoint_mul_c_dvd_abcProduct htarget

/-- Exact reconstruction of the full radical from the external quotient. -/
theorem largeEndpointProductRadical_mul_externalRadicalQuotient
    (P : ABCPoint) :
    abcRadical (P.largeEndpoint * P.c) * P.externalRadicalQuotient =
      abcRadical (P.a * P.b * P.c) := by
  unfold externalRadicalQuotient
  exact Nat.mul_div_cancel' P.largeEndpointProductRadical_dvd_abcRadical

@[simp]
theorem externalRadicalQuotient_pos (P : ABCPoint) :
    0 < P.externalRadicalQuotient := by
  unfold externalRadicalQuotient
  apply Nat.div_pos
  · exact P.radical_largeEndpoint_mul_c_le_abcRadical
  · exact abcRadical_pos (P.largeEndpoint * P.c)

/-- Exact compensation of the positive exponent-above-two layer gives
`max(a,b)*c <= rad(abc)^2`. -/
theorem largeEndpoint_mul_c_le_abcRadical_sq_of_compensatedExcess
    (P : ABCPoint)
    (hcomp :
      cubefulExcess (P.largeEndpoint * P.c) ≤
        squarefreeDeficit (P.largeEndpoint * P.c) *
          P.externalRadicalQuotient ^ 2) :
    P.largeEndpoint * P.c ≤
      abcRadical (P.a * P.b * P.c) ^ 2 := by
  let n := P.largeEndpoint * P.c
  let L := squarefreeDeficit n
  let Q := cubefulExcess n
  let E := P.externalRadicalQuotient
  have hn : 0 < n := by
    dsimp [n]
    exact mul_pos P.largeEndpoint_pos P.c_pos
  have hLpos : 0 < L := by
    dsimp [L]
    exact squarefreeDeficit_pos hn
  have hident : n * L = abcRadical n ^ 2 * Q := by
    dsimp [L, Q]
    exact mul_squarefreeDeficit_eq_radical_sq_mul_cubefulExcess n
  have hcomp' : Q ≤ L * E ^ 2 := by
    simpa [n, L, Q, E] using hcomp
  have hmul :
      abcRadical n ^ 2 * Q ≤
        abcRadical n ^ 2 * (L * E ^ 2) :=
    Nat.mul_le_mul_left _ hcomp'
  have hreconstruct :
      abcRadical n * E = abcRadical (P.a * P.b * P.c) := by
    simpa [n, E] using
      P.largeEndpointProductRadical_mul_externalRadicalQuotient
  have hprod :
      n * L ≤ abcRadical (P.a * P.b * P.c) ^ 2 * L := by
    rw [hident]
    calc
      abcRadical n ^ 2 * Q ≤
          abcRadical n ^ 2 * (L * E ^ 2) := hmul
      _ = (abcRadical n * E) ^ 2 * L := by ring
      _ = abcRadical (P.a * P.b * P.c) ^ 2 * L := by
        rw [hreconstruct]
  exact (Nat.mul_le_mul_right L).mp (by
    simpa [mul_comm, mul_left_comm, mul_assoc] using hprod)

/-- Strong coefficient-one abc on the full compensated-excess region. -/
theorem height_le_conductor_add_log_two_div_two_of_compensatedExcess
    (P : ABCPoint)
    (hcomp :
      cubefulExcess (P.largeEndpoint * P.c) ≤
        squarefreeDeficit (P.largeEndpoint * P.c) *
          P.externalRadicalQuotient ^ 2) :
    P.height ≤ P.conductor + Real.log 2 / 2 := by
  have hproduct :=
    P.largeEndpoint_mul_c_le_abcRadical_sq_of_compensatedExcess hcomp
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hradpos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hnat :
      P.c ^ 2 ≤ 2 * abcRadical (P.a * P.b * P.c) ^ 2 := by
    calc
      P.c ^ 2 ≤ 2 * (P.largeEndpoint * P.c) :=
        P.c_sq_le_two_largeEndpoint_mul_c
      _ ≤ 2 * abcRadical (P.a * P.b * P.c) ^ 2 :=
        Nat.mul_le_mul_left 2 hproduct
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * (abcRadical (P.a * P.b * P.c) : ℝ) ^ 2 := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0)
        (pow_pos hradpos 2).ne',
      Real.log_pow] at hlog
  rw [P.height_eq_log_c]
  unfold ABCPoint.conductor
  nlinarith

/-- Every violation of the strong coefficient-one estimate has uncompensated
cubeful mass. -/
theorem compensatedExcess_strict_of_strong_violation
    (P : ABCPoint)
    (hviolation : P.conductor + Real.log 2 / 2 < P.height) :
    squarefreeDeficit (P.largeEndpoint * P.c) *
        P.externalRadicalQuotient ^ 2 <
      cubefulExcess (P.largeEndpoint * P.c) := by
  by_contra hnot
  have hcomp :
      cubefulExcess (P.largeEndpoint * P.c) ≤
        squarefreeDeficit (P.largeEndpoint * P.c) *
          P.externalRadicalQuotient ^ 2 :=
    Nat.le_of_not_gt hnot
  have hbound :=
    P.height_le_conductor_add_log_two_div_two_of_compensatedExcess hcomp
  linarith

end ABCPoint

#print axioms ABCPoint.largeEndpointProductRadical_dvd_abcRadical
#print axioms ABCPoint.largeEndpointProductRadical_mul_externalRadicalQuotient
#print axioms ABCPoint.largeEndpoint_mul_c_le_abcRadical_sq_of_compensatedExcess
#print axioms ABCPoint.height_le_conductor_add_log_two_div_two_of_compensatedExcess
#print axioms ABCPoint.compensatedExcess_strict_of_strong_violation

end
end IUTThreeClosures
