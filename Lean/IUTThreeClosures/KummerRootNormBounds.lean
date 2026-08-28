/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Uniform norm bounds for Kummer roots

Let `a >= 0` and suppose `a^(n+1)=b`.  Bounds on `b` give bounds on `a`
without introducing real roots:

* if `b <= M`, then `a <= max 1 M`;
* if `0 < m <= b`, then `min 1 m <= a`.

Applied to `a=‖y‖` and `b=‖f(x)‖`, these estimates place every Kummer root
`y^(n+1)=f(x)` in one fixed closed annulus whenever `f` is uniformly bounded
above and away from zero.  This is the algebraic compactness input for the
closed theta-root fundamental strip.
-/

namespace IUTThreeClosures

/-- On `[0,1]`, every positive natural power is at most the base. -/
theorem pow_succ_le_self_of_mem_unitInterval
    {a : ℝ} (ha0 : 0 ≤ a) (ha1 : a ≤ 1) :
    ∀ n : ℕ, a ^ (n + 1) ≤ a := by
  intro n
  induction n with
  | zero => simp
  | succ n ih =>
      rw [pow_succ]
      have hpow0 : 0 ≤ a ^ (n + 1) := pow_nonneg ha0 _
      nlinarith

/-- On `[1,∞)`, every positive natural power is at least the base. -/
theorem self_le_pow_succ_of_one_le
    {a : ℝ} (ha1 : 1 ≤ a) :
    ∀ n : ℕ, a ≤ a ^ (n + 1) := by
  intro n
  induction n with
  | zero => simp
  | succ n ih =>
      rw [pow_succ]
      have hpow0 : 0 ≤ a ^ (n + 1) :=
        pow_nonneg (zero_le_one.trans ha1) _
      nlinarith

/-- An upper bound on a positive power bounds the root by `max 1 M`. -/
theorem le_max_one_of_pow_succ_le
    {a M : ℝ} (ha0 : 0 ≤ a)
    {n : ℕ} (hpow : a ^ (n + 1) ≤ M) :
    a ≤ max 1 M := by
  by_contra hnot
  have hgt : max 1 M < a := lt_of_not_ge hnot
  have ha1 : 1 ≤ a := (le_max_left 1 M).trans hgt.le
  have hMa : M < a := (le_max_right 1 M).trans_lt hgt
  have hale : a ≤ a ^ (n + 1) :=
    self_le_pow_succ_of_one_le ha1 n
  linarith

/-- A positive lower bound on a positive power bounds the root away from zero
by `min 1 m`. -/
theorem min_one_le_of_le_pow_succ
    {m a : ℝ} (hm : 0 < m) (ha0 : 0 ≤ a)
    {n : ℕ} (hpow : m ≤ a ^ (n + 1)) :
    min 1 m ≤ a := by
  by_contra hnot
  have halt : a < min 1 m := lt_of_not_ge hnot
  have ha1 : a ≤ 1 := halt.le.trans (min_le_left 1 m)
  have ham : a < m := halt.trans_le (min_le_right 1 m)
  have hpowa : a ^ (n + 1) ≤ a :=
    pow_succ_le_self_of_mem_unitInterval ha0 ha1 n
  linarith

/-- Field-norm specialization of the uniform upper Kummer-root bound. -/
theorem norm_le_max_one_of_norm_pow_succ_le
    {K : Type*} [NormedField K]
    {y : K} {M : ℝ} {n : ℕ}
    (hpow : ‖y ^ (n + 1)‖ ≤ M) :
    ‖y‖ ≤ max 1 M := by
  rw [norm_pow] at hpow
  exact le_max_one_of_pow_succ_le (norm_nonneg y) hpow

/-- Field-norm specialization of the lower Kummer-root bound. -/
theorem min_one_le_norm_of_le_norm_pow_succ
    {K : Type*} [NormedField K]
    {y : K} {m : ℝ} {n : ℕ}
    (hm : 0 < m)
    (hpow : m ≤ ‖y ^ (n + 1)‖) :
    min 1 m ≤ ‖y‖ := by
  rw [norm_pow] at hpow
  exact min_one_le_of_le_pow_succ hm (norm_nonneg y) hpow

/-- A Kummer equation together with upper and positive lower bounds on the
right-hand side puts every root in a fixed closed annulus. -/
theorem norm_mem_closedAnnulus_of_kummer
    {K : Type*} [NormedField K]
    {y f : K} {m M : ℝ} {n : ℕ}
    (hy : y ^ (n + 1) = f)
    (hm : 0 < m)
    (hlower : m ≤ ‖f‖)
    (hupper : ‖f‖ ≤ M) :
    min 1 m ≤ ‖y‖ ∧ ‖y‖ ≤ max 1 M := by
  constructor
  · apply min_one_le_norm_of_le_norm_pow_succ hm
    rw [hy]
    exact hlower
  · apply norm_le_max_one_of_norm_pow_succ_le
    rw [hy]
    exact hupper

end IUTThreeClosures
