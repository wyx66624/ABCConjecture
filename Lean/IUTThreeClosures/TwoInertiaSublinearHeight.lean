/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TwoInertiaFullImageSelector

/-!
# Sublinear logarithmic growth of the two-inertia auxiliary prime

If the two positive local exponents satisfy

`2^m₁ ≤ c`, `2^m₂ ≤ c`,

then each exponent is at most `log c / log 2`.  The explicit Euclidean prime
therefore satisfies

`ell ≤ 1 + B! * (log c / log 2)^2`.

The logarithm of the right-hand side is sublinear in `log c`: for every
`eta > 0`, it is at most `eta * log c + C(B,eta)`.  Hence the selected
full-image prime has precisely the growth required by the sublinear source
absorption route.
-/

namespace IUTThreeClosures

/-- Scaled tangent-line bound for `log(1+x)`. -/
theorem log_one_add_le_scaled
    {x ρ : ℝ} (hx : 0 ≤ x) (hρ : 0 < ρ) :
    Real.log (1 + x) ≤
      ρ * x + (ρ - 1 - Real.log ρ) := by
  have hx1 : 0 < 1 + x := by linarith
  have hprod : 0 < ρ * (1 + x) := mul_pos hρ hx1
  have hlog := Real.log_le_sub_one_of_pos hprod
  rw [Real.log_mul (ne_of_gt hρ) (ne_of_gt hx1)] at hlog
  nlinarith

/-- A quadratic logarithm is uniformly sublinear on the nonnegative axis. -/
theorem log_one_add_mul_sq_sublinear
    {A η : ℝ} (hA : 0 ≤ A) (hη : 0 < η) :
    ∃ C : ℝ, ∀ h : ℝ, 0 ≤ h →
      Real.log (1 + A * h ^ 2) ≤ η * h + C := by
  let ρ : ℝ := η / 2
  have hρ : 0 < ρ := by
    dsimp [ρ]
    linarith
  let C : ℝ :=
    Real.log (1 + A) +
      2 * (ρ - 1 - Real.log ρ)
  refine ⟨C, ?_⟩
  intro h hh
  have hleftPos : 0 < 1 + A * h ^ 2 := by positivity
  have hrightPos : 0 < (1 + A) * (1 + h) ^ 2 := by positivity
  have hextra :
      0 ≤ 2 * h + h ^ 2 + A + 2 * A * h := by positivity
  have hdom :
      1 + A * h ^ 2 ≤ (1 + A) * (1 + h) ^ 2 := by
    calc
      1 + A * h ^ 2 ≤
          1 + A * h ^ 2 +
            (2 * h + h ^ 2 + A + 2 * A * h) :=
        le_add_of_nonneg_right hextra
      _ = (1 + A) * (1 + h) ^ 2 := by ring
  have hlogdom :
      Real.log (1 + A * h ^ 2) ≤
        Real.log ((1 + A) * (1 + h) ^ 2) :=
    Real.strictMonoOn_log.monotoneOn hleftPos hrightPos hdom
  have hdecomp :
      Real.log ((1 + A) * (1 + h) ^ 2) =
        Real.log (1 + A) + 2 * Real.log (1 + h) := by
    rw [Real.log_mul (ne_of_gt (by linarith : 0 < 1 + A))
      (ne_of_gt (by positivity : 0 < (1 + h) ^ 2))]
    rw [Real.log_pow]
    norm_num
  have hlogOne := log_one_add_le_scaled hh hρ
  have htwice :
      2 * Real.log (1 + h) ≤
        η * h + 2 * (ρ - 1 - Real.log ρ) := by
    dsimp [ρ] at hlogOne ⊢
    nlinarith
  rw [hdecomp] at hlogdom
  dsimp [C]
  linarith

/-- A natural exponent controlled by `2^m ≤ c` is at most
`log c / log 2`. -/
theorem exponent_le_log_div_log_two
    {m c : ℕ}
    (hc : 0 < c)
    (hpow : 2 ^ m ≤ c) :
    (m : ℝ) ≤ Real.log c / Real.log 2 := by
  have hpowR : (2 : ℝ) ^ m ≤ (c : ℝ) := by
    exact_mod_cast hpow
  have hlog :
      Real.log ((2 : ℝ) ^ m) ≤ Real.log (c : ℝ) :=
    Real.strictMonoOn_log.monotoneOn
      (by positivity) (by exact_mod_cast hc) hpowR
  rw [Real.log_pow] at hlog
  apply (le_div_iff₀ (Real.log_pos (by norm_num : (1 : ℝ) < 2))).2
  simpa [mul_comm] using hlog

/-- The Euclidean selected prime is bounded by a quadratic expression in the
logarithmic height. -/
theorem twoInertiaPrime_le_log_height_quadratic
    {B m₁ m₂ c : ℕ}
    (D : TwoInertiaPrimeData B m₁ m₂)
    (hc : 0 < c)
    (hpow₁ : 2 ^ m₁ ≤ c)
    (hpow₂ : 2 ^ m₂ ≤ c) :
    (D.ell : ℝ) ≤
      1 + (B.factorial : ℝ) *
        (Real.log c / Real.log 2) ^ 2 := by
  let H : ℝ := Real.log c / Real.log 2
  have hm₁ : (m₁ : ℝ) ≤ H := by
    dsimp [H]
    exact exponent_le_log_div_log_two hc hpow₁
  have hm₂ : (m₂ : ℝ) ≤ H := by
    dsimp [H]
    exact exponent_le_log_div_log_two hc hpow₂
  have hH : 0 ≤ H := by
    dsimp [H]
    have hcOne : (1 : ℝ) ≤ c := by exact_mod_cast (Nat.one_le_iff_ne_zero.mpr (Nat.ne_of_gt hc))
    exact div_nonneg (Real.log_nonneg hcOne)
      (Real.log_pos (by norm_num : (1 : ℝ) < 2)).le
  have hprod :
      (m₁ : ℝ) * (m₂ : ℝ) ≤ H ^ 2 := by
    have := mul_le_mul hm₁ hm₂ (by positivity) hH
    simpa [pow_two] using this
  have hraw :
      (D.ell : ℝ) ≤
        (B.factorial : ℝ) * ((m₁ : ℝ) * (m₂ : ℝ)) + 1 := by
    exact_mod_cast D.explicit_upper_bound
  dsimp [H] at hprod hH ⊢
  have hfac : (0 : ℝ) ≤ B.factorial := by positivity
  have hscaled := mul_le_mul_of_nonneg_left hprod hfac
  linarith

/-- **Sublinear auxiliary-prime theorem.**  At a fixed lower threshold, the
logarithm of the selected prime is bounded by an arbitrarily small multiple of
`log c`, up to a constant independent of the abc point. -/
theorem twoInertiaPrime_log_sublinear
    {B m₁ m₂ c : ℕ}
    (D : TwoInertiaPrimeData B m₁ m₂)
    (hc : 0 < c)
    (hpow₁ : 2 ^ m₁ ≤ c)
    (hpow₂ : 2 ^ m₂ ≤ c)
    {η : ℝ} (hη : 0 < η) :
    ∃ C : ℝ,
      Real.log D.ell ≤ η * Real.log c + C := by
  let H : ℝ := Real.log c / Real.log 2
  let A : ℝ := B.factorial
  have hH : 0 ≤ H := by
    dsimp [H]
    have hcOne : (1 : ℝ) ≤ c := by exact_mod_cast (Nat.one_le_iff_ne_zero.mpr (Nat.ne_of_gt hc))
    exact div_nonneg (Real.log_nonneg hcOne)
      (Real.log_pos (by norm_num : (1 : ℝ) < 2)).le
  have hηH : 0 < η * Real.log 2 :=
    mul_pos hη (Real.log_pos (by norm_num : (1 : ℝ) < 2))
  rcases log_one_add_mul_sq_sublinear
      (show 0 ≤ A by dsimp [A]; positivity) hηH with
    ⟨C, hC⟩
  refine ⟨C, ?_⟩
  have hEll :
      (D.ell : ℝ) ≤ 1 + A * H ^ 2 := by
    dsimp [A, H]
    exact twoInertiaPrime_le_log_height_quadratic
      D hc hpow₁ hpow₂
  have hEllPos : (0 : ℝ) < D.ell := by
    exact_mod_cast D.ell_prime.pos
  have hRightPos : 0 < 1 + A * H ^ 2 := by positivity
  have hlogEll :
      Real.log D.ell ≤ Real.log (1 + A * H ^ 2) :=
    Real.strictMonoOn_log.monotoneOn hEllPos hRightPos hEll
  have hquad := hC H hH
  have hslope :
      (η * Real.log 2) * H = η * Real.log c := by
    dsimp [H]
    field_simp [ne_of_gt (Real.log_pos (by norm_num : (1 : ℝ) < 2))]
    ring
  rw [hslope] at hquad
  exact hlogEll.trans hquad

end IUTThreeClosures
