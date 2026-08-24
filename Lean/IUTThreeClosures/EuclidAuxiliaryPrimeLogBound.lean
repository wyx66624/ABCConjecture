/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EuclidAuxiliaryPrimeAvoidOne
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# Logarithmic size of the two-stage Euclidean auxiliary prime

For fixed lower threshold `B`, the two-stage selector satisfies

`ell ≤ B! * N * (B! * N + 1) + 1`.

The right-hand side is at most

`((B! + 1) * (N + 1))^2`.

Consequently

`log ell ≤ 2 * (log(B! + 1) + log(N + 1))`.

Thus the logarithm of the selected prime grows only logarithmically in the
single local avoidance order `N`.  Combined with the linear height bound for
the Frey Tate order, this yields `log ell = O(log(1+height))`.
-/

namespace IUTThreeClosures

/-- Polynomial comparison used by the logarithmic estimate. -/
theorem euclidAvoidOneBound_le_square
    (B N : ℕ) :
    euclidAvoidOneBound B N ≤
      ((B.factorial + 1) * (N + 1)) ^ 2 := by
  let x := B.factorial * N
  let y := (B.factorial + 1) * (N + 1)
  have hxy : x + 1 ≤ y := by
    dsimp [x, y]
    nlinarith
  calc
    euclidAvoidOneBound B N = x * (x + 1) + 1 := by
      simp [euclidAvoidOneBound, euclidAuxiliaryNumber, x,
        Nat.mul_assoc]
    _ ≤ (x + 1) * (x + 1) := by
      nlinarith
    _ ≤ y * y := Nat.mul_le_mul hxy hxy
    _ = y ^ 2 := by ring
    _ = ((B.factorial + 1) * (N + 1)) ^ 2 := rfl

/-- Real-logarithmic upper bound for any positive integer below the common
Euclidean bound. -/
theorem log_le_of_le_euclidAvoidOneBound
    {B N ell : ℕ}
    (hell : 0 < ell)
    (hle : ell ≤ euclidAvoidOneBound B N) :
    Real.log ell ≤
      2 *
        (Real.log (B.factorial + 1) +
          Real.log (N + 1)) := by
  let y : ℕ := (B.factorial + 1) * (N + 1)
  have hy : 0 < y := by
    dsimp [y]
    exact Nat.mul_pos
      (Nat.succ_pos B.factorial)
      (Nat.succ_pos N)
  have hell_y : ell ≤ y ^ 2 :=
    hle.trans (euclidAvoidOneBound_le_square B N)
  have hell_real : 0 < (ell : ℝ) := by
    exact_mod_cast hell
  have hy_real : 0 < (y : ℝ) := by
    exact_mod_cast hy
  have hle_real : (ell : ℝ) ≤ (y : ℝ) ^ 2 := by
    exact_mod_cast hell_y
  have hlog :
      Real.log (ell : ℝ) ≤ Real.log ((y : ℝ) ^ 2) :=
    Real.strictMonoOn_log.monotoneOn
      hell_real (pow_pos hy_real 2) hle_real
  have hy_cast :
      (y : ℝ) =
        ((B.factorial + 1 : ℕ) : ℝ) * ((N + 1 : ℕ) : ℝ) := by
    norm_num [y]
  rw [Real.log_pow] at hlog
  rw [hy_cast,
    Real.log_mul
      (by positivity : (((B.factorial + 1 : ℕ) : ℝ)) ≠ 0)
      (by positivity : (((N + 1 : ℕ) : ℝ)) ≠ 0)] at hlog
  simpa [Nat.cast_add, Nat.cast_one] using hlog

/-- The actual two-stage selected prime has logarithmic growth in `N`. -/
theorem log_euclidAuxiliaryPrimeAvoidOne_le
    {B N p : ℕ}
    (hN : 0 < N) :
    Real.log (euclidAuxiliaryPrimeAvoidOne B N p) ≤
      2 *
        (Real.log (B.factorial + 1) +
          Real.log (N + 1)) := by
  apply log_le_of_le_euclidAvoidOneBound
  · exact (euclidAuxiliaryPrimeAvoidOne_prime hN).pos
  · exact euclidAuxiliaryPrimeAvoidOne_le hN

end IUTThreeClosures
