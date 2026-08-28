/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCStatement
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# A local multiplicative exponent is at most linear in the abc height

Let `p` be a prime in the support of an abc point and suppose `p^n` divides
`abc`.  Since `a,b ≤ c` and `a+b=c`, one has

`abc ≤ c^3`.

Taking logarithms gives

`n * log 2 ≤ n * log p ≤ log(abc) ≤ 3 * log c`.

Thus any single local valuation exponent occurring in the multiplicative Tate
order is at most linear in the logarithmic abc height.  In particular, the
two-stage Euclidean selector, whose auxiliary prime is polynomial in one such
local order, has logarithm `O(log(1+height))`.

The file proves the elementary real-logarithmic inequalities.  Identifying the
actual Tate/discriminant order with a particular exponent `n` remains the
local reduction/valuation theorem.
-/

namespace IUTThreeClosures

/-- If `p^n` divides a positive natural number `M`, then
`n * log p ≤ log M`. -/
theorem exponent_mul_log_le_log_of_pow_dvd
    {p n M : ℕ}
    (hp : 0 < p)
    (hM : 0 < M)
    (hdiv : p ^ n ∣ M) :
    (n : ℝ) * Real.log p ≤ Real.log M := by
  have hpow_nat : p ^ n ≤ M :=
    Nat.le_of_dvd hM hdiv
  have hp_real : 0 < (p : ℝ) := by
    exact_mod_cast hp
  have hM_real : 0 < (M : ℝ) := by
    exact_mod_cast hM
  have hpow_real : (p : ℝ) ^ n ≤ (M : ℝ) := by
    exact_mod_cast hpow_nat
  have hlog :
      Real.log ((p : ℝ) ^ n) ≤ Real.log (M : ℝ) :=
    Real.strictMonoOn_log.monotoneOn
      (pow_pos hp_real n) hM_real hpow_real
  simpa [Real.log_pow] using hlog

/-- Replacing the prime base by `2` only weakens the exponent bound. -/
theorem exponent_mul_log_two_le_log_of_prime_pow_dvd
    {p n M : ℕ}
    (hp : Nat.Prime p)
    (hM : 0 < M)
    (hdiv : p ^ n ∣ M) :
    (n : ℝ) * Real.log 2 ≤ Real.log M := by
  have hmain := exponent_mul_log_le_log_of_pow_dvd
    hp.pos hM hdiv
  have hp_real : (2 : ℝ) ≤ p := by
    exact_mod_cast hp.two_le
  have hlog_base : Real.log 2 ≤ Real.log p := by
    exact Real.strictMonoOn_log.monotoneOn
      (by norm_num) (by positivity) hp_real
  have hn : 0 ≤ (n : ℝ) := by positivity
  have hmul :
      (n : ℝ) * Real.log 2 ≤
        (n : ℝ) * Real.log p :=
    mul_le_mul_of_nonneg_left hlog_base hn
  exact hmul.trans hmain

namespace ABCPoint

/-- The two summands of an abc point are bounded by their sum. -/
theorem a_le_c (P : ABCPoint) : P.a ≤ P.c := by
  omega

/-- The second summand is bounded by the sum. -/
theorem b_le_c (P : ABCPoint) : P.b ≤ P.c := by
  omega

/-- The support product is bounded by the cube of `c`. -/
theorem abcProduct_le_cube (P : ABCPoint) :
    P.a * P.b * P.c ≤ P.c ^ 3 := by
  calc
    P.a * P.b * P.c ≤ P.c * P.c * P.c := by
      exact Nat.mul_le_mul
        (Nat.mul_le_mul P.a_le_c P.b_le_c)
        (le_refl P.c)
    _ = P.c ^ 3 := by ring

/-- The logarithm of the complete support product is at most three times the
abc height. -/
theorem log_abcProduct_le_three_height (P : ABCPoint) :
    Real.log (P.a * P.b * P.c) ≤ 3 * P.height := by
  have habc_pos : 0 < P.a * P.b * P.c :=
    Nat.mul_pos (Nat.mul_pos P.a_pos P.b_pos) P.c_pos
  have hc_real : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hle_real :
      ((P.a * P.b * P.c : ℕ) : ℝ) ≤ (P.c : ℝ) ^ 3 := by
    exact_mod_cast P.abcProduct_le_cube
  have hlog :
      Real.log (P.a * P.b * P.c) ≤
        Real.log ((P.c : ℝ) ^ 3) :=
    Real.strictMonoOn_log.monotoneOn
      (by exact_mod_cast habc_pos)
      (pow_pos hc_real 3)
      hle_real
  rw [Real.log_pow] at hlog
  simpa [ABCPoint.height] using hlog

/-- A prime-power exponent supported on `abc` is linearly bounded by the
logarithmic abc height. -/
theorem localExponent_mul_log_two_le_three_height
    (P : ABCPoint)
    {p n : ℕ}
    (hp : Nat.Prime p)
    (hdiv : p ^ n ∣ P.a * P.b * P.c) :
    (n : ℝ) * Real.log 2 ≤ 3 * P.height := by
  have habc_pos : 0 < P.a * P.b * P.c :=
    Nat.mul_pos (Nat.mul_pos P.a_pos P.b_pos) P.c_pos
  exact
    (exponent_mul_log_two_le_log_of_prime_pow_dvd
      hp habc_pos hdiv).trans
      P.log_abcProduct_le_three_height

/-- Explicit real bound on the local exponent. -/
theorem localExponent_le_height_ratio
    (P : ABCPoint)
    {p n : ℕ}
    (hp : Nat.Prime p)
    (hdiv : p ^ n ∣ P.a * P.b * P.c) :
    (n : ℝ) ≤ 3 * P.height / Real.log 2 := by
  have hlog2 : 0 < Real.log 2 := Real.log_pos (by norm_num)
  apply (le_div_iff₀ hlog2).2
  simpa [mul_comm] using
    P.localExponent_mul_log_two_le_three_height hp hdiv

end ABCPoint

end IUTThreeClosures
