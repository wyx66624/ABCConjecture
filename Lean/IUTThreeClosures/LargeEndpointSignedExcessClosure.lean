/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointSignedExcess
import Mathlib.Tactic

/-!
# Unconditional signed-excess partial closure

The cube-free theorem is stronger than necessary.  It is enough that the
positive exponent mass above two in `max(a,b)*c` be compensated by the primes
which occur exactly once.  Equivalently, the large-endpoint product need only
satisfy

`max(a,b)*c <= rad(max(a,b)*c)^2`.

This file proves the corresponding coefficient-one abc estimate and derives it
from the exact cubeful-excess versus squarefree-deficit comparison.
-/

namespace IUTThreeClosures

open LargeEndpointCubefulExcess
open LargeEndpointSignedExcess

noncomputable section

namespace ABCPoint

/-- A product whose positive exponent-above-two mass is compensated by its
exponent-one layer already satisfies the strong coefficient-one abc bound. -/
theorem c_sq_le_two_abcRadical_sq_of_largeProduct_le_radical_sq
    (P : ABCPoint)
    (hproduct :
      P.largeEndpoint * P.c ≤
        abcRadical (P.largeEndpoint * P.c) ^ 2) :
    P.c ^ 2 ≤ 2 * abcRadical (P.a * P.b * P.c) ^ 2 := by
  calc
    P.c ^ 2 ≤ 2 * (P.largeEndpoint * P.c) :=
      P.c_sq_le_two_largeEndpoint_mul_c
    _ ≤ 2 * abcRadical (P.largeEndpoint * P.c) ^ 2 :=
      Nat.mul_le_mul_left 2 hproduct
    _ ≤ 2 * abcRadical (P.a * P.b * P.c) ^ 2 := by
      exact Nat.mul_le_mul_left 2
        (Nat.pow_le_pow_left P.radical_largeEndpoint_mul_c_le_abcRadical 2)

/-- Strong logarithmic abc on the full signed-nonpositive large-product
region.  This strictly contains the cube-free region. -/
theorem height_le_conductor_add_log_two_div_two_of_largeProduct_le_radical_sq
    (P : ABCPoint)
    (hproduct :
      P.largeEndpoint * P.c ≤
        abcRadical (P.largeEndpoint * P.c) ^ 2) :
    P.height ≤ P.conductor + Real.log 2 / 2 := by
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hradpos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * (abcRadical (P.a * P.b * P.c) : ℝ) ^ 2 := by
    exact_mod_cast
      P.c_sq_le_two_abcRadical_sq_of_largeProduct_le_radical_sq hproduct
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0)
        (pow_pos hradpos 2).ne',
      Real.log_pow] at hlog
  rw [P.height_eq_log_c]
  unfold ABCPoint.conductor
  nlinarith

/-- The exact positive/negative exponent-layer comparison implies the same
strong coefficient-one bound. -/
theorem height_le_conductor_add_log_two_div_two_of_cubefulExcess_le_deficit
    (P : ABCPoint)
    (hcomp :
      cubefulExcess (P.largeEndpoint * P.c) ≤
        squarefreeDeficit (P.largeEndpoint * P.c)) :
    P.height ≤ P.conductor + Real.log 2 / 2 := by
  let n := P.largeEndpoint * P.c
  have hn : 0 < n := by
    dsimp [n]
    exact mul_pos P.largeEndpoint_pos P.c_pos
  have hident :=
    mul_squarefreeDeficit_eq_radical_sq_mul_cubefulExcess n
  have hmul :
      abcRadical n ^ 2 * cubefulExcess n ≤
        abcRadical n ^ 2 * squarefreeDeficit n :=
    Nat.mul_le_mul_left _ hcomp
  have hprod :
      n * squarefreeDeficit n ≤
        abcRadical n ^ 2 * squarefreeDeficit n := by
    rw [hident]
    exact hmul
  have hnle : n ≤ abcRadical n ^ 2 := by
    exact (Nat.mul_le_mul_right (squarefreeDeficit n)).mp (by
      simpa [mul_comm, mul_left_comm, mul_assoc] using hprod)
  exact
    P.height_le_conductor_add_log_two_div_two_of_largeProduct_le_radical_sq
      (by simpa [n] using hnle)

end ABCPoint

#print axioms ABCPoint.c_sq_le_two_abcRadical_sq_of_largeProduct_le_radical_sq
#print axioms ABCPoint.height_le_conductor_add_log_two_div_two_of_largeProduct_le_radical_sq
#print axioms ABCPoint.height_le_conductor_add_log_two_div_two_of_cubefulExcess_le_deficit

end
end IUTThreeClosures
