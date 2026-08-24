/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.NumberTheory.PrimeNumberTheorem
import Mathlib.NumberTheory.Chebyshev

/-!
# Chebyshev estimates extracted from the prime number theorem

This module turns Mathlib's prime number theorem for the Chebyshev function
into the two inequalities used in GenEll Lemma 4.1.

For every `eta > 0`, eventually

`(1-eta) * n < theta n < (1+eta) * n`.

The eventual upper estimate is also converted into a global affine estimate
by absorbing the finitely many small natural numbers with Mathlib's explicit
bound `theta n <= log 4 * n`.

No analytic estimate is introduced as a structure field or axiom.
-/

namespace IUTThreeClosures

open Filter Set Nat Real
open scoped Topology Nat.Prime

/-- Ratio form of the prime number theorem for the Chebyshev theta function. -/
theorem chebyshevTheta_ratio_tendsto_one :
    Tendsto
      (fun n : ℕ => Chebyshev.theta n / (n : ℝ))
      atTop (𝓝 1) := by
  exact?

/-- Eventual two-sided Chebyshev estimate with an arbitrary positive relative
error. -/
theorem eventually_chebyshevTheta_twoSided
    {η : ℝ} (hη : 0 < η) :
    ∃ N : ℕ, ∀ n ≥ N,
      (1 - η) * (n : ℝ) < Chebyshev.theta n ∧
        Chebyshev.theta n < (1 + η) * (n : ℝ) := by
  have hnhds : Ioo (1 - η) (1 + η) ∈ 𝓝 (1 : ℝ) :=
    Ioo_mem_nhds (by linarith) (by linarith)
  have hev := chebyshevTheta_ratio_tendsto_one.eventually hnhds
  rcases eventually_atTop.1 hev with ⟨N, hN⟩
  refine ⟨max N 1, ?_⟩
  intro n hn
  have hnN : N ≤ n := (Nat.le_max_left N 1).trans hn
  have hn1 : 1 ≤ n := (Nat.le_max_right N 1).trans hn
  have hnpos : (0 : ℝ) < n := by exact_mod_cast hn1
  have hrange := hN n hnN
  rcases hrange with ⟨hlower, hupper⟩
  constructor
  · exact (lt_div_iff₀ hnpos).mp hlower
  · exact (div_lt_iff₀ hnpos).mp hupper

/-- Eventual lower Chebyshev estimate alone. -/
theorem eventually_chebyshevTheta_lower
    {η : ℝ} (hη : 0 < η) :
    ∃ N : ℕ, ∀ n ≥ N,
      (1 - η) * (n : ℝ) < Chebyshev.theta n := by
  obtain ⟨N, hN⟩ := eventually_chebyshevTheta_twoSided hη
  exact ⟨N, fun n hn => (hN n hn).1⟩

/-- Eventual upper Chebyshev estimate alone. -/
theorem eventually_chebyshevTheta_upper
    {η : ℝ} (hη : 0 < η) :
    ∃ N : ℕ, ∀ n ≥ N,
      Chebyshev.theta n < (1 + η) * (n : ℝ) := by
  obtain ⟨N, hN⟩ := eventually_chebyshevTheta_twoSided hη
  exact ⟨N, fun n hn => (hN n hn).2⟩

/-- The finitely many values below the PNT threshold can be absorbed into one
explicit affine constant. -/
theorem exists_global_chebyshevTheta_affine_upper
    {η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ, ∀ n : ℕ,
      Chebyshev.theta n < (1 + η) * (n : ℝ) + C := by
  obtain ⟨N, hN⟩ := eventually_chebyshevTheta_upper hη
  let C : ℝ := Real.log 4 * (N : ℝ) + 1
  refine ⟨C, ?_⟩
  intro n
  by_cases hn : N ≤ n
  · have h := hN n hn
    have hCpos : 0 < C := by
      dsimp [C]
      have hlog : 0 ≤ Real.log 4 :=
        Real.log_nonneg (by norm_num)
      positivity
    linarith
  · have hnN : n ≤ N := Nat.le_of_lt (Nat.lt_of_not_ge hn)
    have htheta :
        Chebyshev.theta n ≤ Real.log 4 * (n : ℝ) :=
      Chebyshev.theta_le_log4_mul_x (by positivity)
    have hlog : 0 ≤ Real.log 4 :=
      Real.log_nonneg (by norm_num)
    have hcast : (n : ℝ) ≤ N := by exact_mod_cast hnN
    have hsmall :
        Real.log 4 * (n : ℝ) ≤ Real.log 4 * (N : ℝ) :=
      mul_le_mul_of_nonneg_left hcast hlog
    dsimp [C]
    have hcoef : 0 ≤ (1 + η) * (n : ℝ) := by positivity
    linarith

/-- The precise global upper coefficient used in the printed GenEll scalar
calculation, with all small inputs absorbed into a constant. -/
theorem exists_global_chebyshevTheta_nineEighths_upper :
    ∃ C : ℝ, ∀ n : ℕ,
      Chebyshev.theta n < (9 / 8 : ℝ) * (n : ℝ) + C := by
  simpa [show (1 + (1 / 8 : ℝ)) = 9 / 8 by norm_num] using
    (exists_global_chebyshevTheta_affine_upper
      (η := (1 / 8 : ℝ)) (by norm_num))

end IUTThreeClosures
