/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TwoInertiaEuclidPrime

/-!
# Sublinear logarithmic growth from two local inertia exponents

Suppose two positive local inertia exponents `m₁`, `m₂` satisfy

`2^m₁ ≤ c`, `2^m₂ ≤ c`.

Taking logarithms gives

`mᵢ ≤ log(c)/log(2)`.

The Euclid-selected full-image prime therefore satisfies

`ell ≤ 1 + B! * (log(c)/log(2))^2`.

The logarithm of this quadratic expression is sublinear in `log(c)`: for every
`eta > 0` it is bounded by

`eta * log(c) + C(B,eta)`.

This is the exact quantitative shape required by the sublinear-height source
absorption route.  It improves the naive bound by the underlying integers
`a,b,c`, whose logarithm would only be linear in the ABC height.

No assertion is made here that the genuine Frey local inertia exponents
satisfy the two power-divisibility estimates; that is the remaining local
arithmetic theorem.
-/

namespace IUTThreeClosures

open TwoInertiaEuclidPrime
open TwoInertiaEuclidPrime.UniformTwoInertiaAbove
open TransvectionLargeImage
open TransvectionLargeImage.Matrix2

namespace TwoInertiaSublinearHeight

/-- A power bound on a natural exponent gives the corresponding logarithmic
bound. -/
theorem exponent_le_log_div_log_two
    {m c : ℕ} (hpow : 2 ^ m ≤ c) :
    (m : ℝ) ≤ Real.log c / Real.log 2 := by
  have hpowReal : (2 : ℝ) ^ m ≤ (c : ℝ) := by
    exact_mod_cast hpow
  have hlog :
      Real.log ((2 : ℝ) ^ m) ≤ Real.log (c : ℝ) :=
    Real.log_le_log (by positivity) hpowReal
  have hlog' :
      (m : ℝ) * Real.log 2 ≤ Real.log (c : ℝ) := by
    simpa [Real.log_pow] using hlog
  have hlogTwo : 0 < Real.log (2 : ℝ) :=
    Real.log_pos (by norm_num)
  exact (le_div_iff₀ hlogTwo).2 hlog'

/-- Scaled elementary sublinearity of `log(1+x)`. -/
theorem log_one_add_le_scaled
    {x rho : ℝ} (hx : 0 ≤ x) (hrho : 0 < rho) :
    Real.log (1 + x) ≤
      rho * x + (rho - 1 - Real.log rho) := by
  have hx1 : 0 < 1 + x := by linarith
  have hprod : 0 < rho * (1 + x) :=
    mul_pos hrho hx1
  have hlog := Real.log_le_sub_one_of_pos hprod
  rw [Real.log_mul (ne_of_gt hrho) (ne_of_gt hx1)] at hlog
  nlinarith

/-- The logarithm of a positive quadratic polynomial is uniformly sublinear
on the nonnegative real axis. -/
theorem log_one_add_mul_sq_sublinear
    {A : ℝ} (hA : 0 < A)
    {eta : ℝ} (heta : 0 < eta) :
    ∃ C : ℝ, ∀ h : ℝ, 0 ≤ h →
      Real.log (1 + A * h ^ 2) ≤ eta * h + C := by
  let s : ℝ := Real.sqrt A
  have hs : 0 < s := Real.sqrt_pos.2 hA
  have hsSq : s ^ 2 = A := by
    simpa [s] using Real.sq_sqrt hA.le
  let rho : ℝ := eta / (2 * s)
  have hrho : 0 < rho := by
    dsimp [rho]
    positivity
  refine ⟨2 * (rho - 1 - Real.log rho), ?_⟩
  intro h hh
  have hsh : 0 ≤ s * h := mul_nonneg hs.le hh
  have harg : 0 < 1 + A * h ^ 2 := by
    have : 0 ≤ A * h ^ 2 := mul_nonneg hA.le (sq_nonneg h)
    linarith
  have hbase : 0 < 1 + s * h := by linarith
  have hpoly :
      1 + A * h ^ 2 ≤ (1 + s * h) ^ 2 := by
    rw [← hsSq]
    nlinarith [mul_nonneg hs.le hh]
  have hlogMono :
      Real.log (1 + A * h ^ 2) ≤
        Real.log ((1 + s * h) ^ 2) :=
    Real.log_le_log harg hpoly
  have hlogPow :
      Real.log ((1 + s * h) ^ 2) =
        2 * Real.log (1 + s * h) := by
    rw [Real.log_pow]
    norm_num
  have hscaled := log_one_add_le_scaled hsh hrho
  have hcoefficient : 2 * rho * s = eta := by
    dsimp [rho]
    field_simp [ne_of_gt hs]
    ring
  calc
    Real.log (1 + A * h ^ 2) ≤
        Real.log ((1 + s * h) ^ 2) := hlogMono
    _ = 2 * Real.log (1 + s * h) := hlogPow
    _ ≤ 2 *
        (rho * (s * h) +
          (rho - 1 - Real.log rho)) := by
      nlinarith
    _ = eta * h +
        2 * (rho - 1 - Real.log rho) := by
      rw [← hcoefficient]
      ring

/-- The Euclid-selected full-image prime has a quadratic bound in the ABC
logarithmic height. -/
theorem exists_full_SL2_prime_quadratic_log_height
    {B exponent₁ exponent₂ c : ℕ}
    (h₁ : 0 < exponent₁)
    (h₂ : 0 < exponent₂)
    (hpow₁ : 2 ^ exponent₁ ≤ c)
    (hpow₂ : 2 ^ exponent₂ ≤ c)
    (D : UniformTwoInertiaAbove B exponent₁ exponent₂) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      (ell : ℝ) ≤
        1 + (B.factorial : ℝ) *
          (Real.log c / Real.log 2) ^ 2 ∧
      (∀ M : Matrix2 (ZMod ell),
        det M = 1 → M ∈ (D.image ell).carrier) := by
  rcases D.exists_bounded_full_SL2_prime h₁ h₂ with
    ⟨ell, hell, hBell, hBound, hfull⟩
  have hm₁ := exponent_le_log_div_log_two hpow₁
  have hm₂ := exponent_le_log_div_log_two hpow₂
  have hcpos : 0 < c :=
    lt_of_lt_of_le (Nat.pow_pos (by norm_num) exponent₁) hpow₁
  have hcone : (1 : ℝ) ≤ c := by exact_mod_cast hcpos
  have hlogc : 0 ≤ Real.log (c : ℝ) :=
    Real.log_nonneg hcone
  have hlogTwo : 0 < Real.log (2 : ℝ) :=
    Real.log_pos (by norm_num)
  have hL : 0 ≤ Real.log c / Real.log 2 :=
    div_nonneg hlogc hlogTwo.le
  have hprod :
      ((exponent₁ : ℝ) * (exponent₂ : ℝ)) ≤
        (Real.log c / Real.log 2) ^ 2 := by
    have := mul_le_mul hm₁ hm₂ (by positivity) hL
    nlinarith
  have hfac : 0 ≤ (B.factorial : ℝ) := by positivity
  have hscaled := mul_le_mul_of_nonneg_left hprod hfac
  have hBoundReal :
      (ell : ℝ) ≤
        (B.factorial : ℝ) *
          ((exponent₁ : ℝ) * (exponent₂ : ℝ)) + 1 := by
    exact_mod_cast hBound
  refine ⟨ell, hell, hBell, ?_, hfull⟩
  nlinarith

/-- **Sublinear logarithmic full-image prime theorem.**  For every positive
slope, the selected auxiliary prime has logarithm at most that slope times the
ABC height `log c`, up to a point-independent constant. -/
theorem exists_full_SL2_prime_sublinear_log_height
    {B exponent₁ exponent₂ c : ℕ}
    (h₁ : 0 < exponent₁)
    (h₂ : 0 < exponent₂)
    (hpow₁ : 2 ^ exponent₁ ≤ c)
    (hpow₂ : 2 ^ exponent₂ ≤ c)
    (D : UniformTwoInertiaAbove B exponent₁ exponent₂)
    {eta : ℝ} (heta : 0 < eta) :
    ∃ C : ℝ, ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      Real.log ell ≤ eta * Real.log c + C ∧
      (∀ M : Matrix2 (ZMod ell),
        det M = 1 → M ∈ (D.image ell).carrier) := by
  let logTwo : ℝ := Real.log 2
  have hlogTwo : 0 < logTwo := by
    dsimp [logTwo]
    exact Real.log_pos (by norm_num)
  let A : ℝ := (B.factorial : ℝ) / logTwo ^ 2
  have hA : 0 < A := by
    dsimp [A]
    positivity
  rcases log_one_add_mul_sq_sublinear hA heta with
    ⟨C, hC⟩
  rcases D.exists_full_SL2_prime_quadratic_log_height
      h₁ h₂ hpow₁ hpow₂ with
    ⟨ell, hell, hBell, hEll, hfull⟩
  have hcpos : 0 < c :=
    lt_of_lt_of_le (Nat.pow_pos (by norm_num) exponent₁) hpow₁
  have hcone : (1 : ℝ) ≤ c := by exact_mod_cast hcpos
  have hlogc : 0 ≤ Real.log (c : ℝ) :=
    Real.log_nonneg hcone
  have hpolyEq :
      1 + (B.factorial : ℝ) *
          (Real.log c / Real.log 2) ^ 2 =
        1 + A * (Real.log c) ^ 2 := by
    dsimp [A, logTwo]
    field_simp [ne_of_gt hlogTwo]
    ring
  have hEll' :
      (ell : ℝ) ≤ 1 + A * (Real.log c) ^ 2 := by
    rwa [← hpolyEq]
  have hEllPos : (0 : ℝ) < ell := by
    exact_mod_cast hell.pos
  have hlogEll :
      Real.log ell ≤
        Real.log (1 + A * (Real.log c) ^ 2) :=
    Real.log_le_log hEllPos hEll'
  have hsub := hC (Real.log c) hlogc
  refine ⟨C, ell, hell, hBell, ?_, hfull⟩
  exact hlogEll.trans hsub

end TwoInertiaSublinearHeight

end IUTThreeClosures
