/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyJReducedData

/-!
# Elementary certificates for the absolute Pell index bound

The complete mathematical proof was written and cross-reviewed in
`research/MATVEEV_PELL_FINITE_PACKET_2026_08_30.md` before this module.

The actual positive square-root expressions below satisfy the strict
approximation used there. The scalar theorems check the numerical
absorption of explicitly supplied logarithmic-form bounds. Matveev's
theorem, the number-field height calculation, and the integral-point
theorem are not declared as axioms or implicitly asserted here.
-/

namespace IUTThreeClosures

noncomputable section

/-- The positive real root of `u + u⁻¹ = 2t` when `t > 1`. -/
def pellMatveevRoot (t : ℝ) : ℝ :=
  t + Real.sqrt (t ^ 2 - 1)

theorem pellMatveevRoot_bounds (t : ℝ) (ht : 1 < t) :
    2 * t - 1 < pellMatveevRoot t ∧ pellMatveevRoot t < 2 * t := by
  have hr : 0 ≤ t ^ 2 - 1 := by nlinarith
  have hs := Real.sq_sqrt hr
  have hn := Real.sqrt_nonneg (t ^ 2 - 1)
  dsimp [pellMatveevRoot]
  constructor <;> nlinarith

theorem pellMatveevRoot_sq (t : ℝ) (ht : 1 < t) :
    (pellMatveevRoot t) ^ 2 = pellMatveevRoot (2 * t ^ 2 - 1) := by
  have hr : 0 ≤ t ^ 2 - 1 := by nlinarith
  have hs := Real.sq_sqrt hr
  have heq : (2 * t ^ 2 - 1) ^ 2 - 1 =
      (2 * t * Real.sqrt (t ^ 2 - 1)) ^ 2 := by
    calc
      _ = 4 * t ^ 2 * (t ^ 2 - 1) := by ring
      _ = _ := by rw [mul_pow, mul_pow, hs]; ring
  have hnon : 0 ≤ 2 * t * Real.sqrt (t ^ 2 - 1) := by positivity
  dsimp [pellMatveevRoot]
  rw [heq, Real.sqrt_sq hnon]
  nlinarith [hs]

/-- The fixed Pell unit in its specified positive real embedding. -/
def pellMatveevEta (b : ℝ) : ℝ :=
  Real.sqrt (b + 3) + Real.sqrt (b + 2)

/-- The four-consecutive product unit in its positive real embedding. -/
def pellMatveevW (b : ℝ) : ℝ :=
  pellMatveevRoot (b ^ 2 + 3 * b + 1)

/-- The real expression really equals the positive Pell unit when the
specified square equations hold. -/
theorem pellMatveevEta_of_packet
    (b r s : ℝ) (hr : 0 ≤ r) (hs : 0 ≤ s)
    (hrsq : b + 2 = 3 * r ^ 2) (hssq : b + 3 = s ^ 2) :
    pellMatveevEta b = s + r * Real.sqrt 3 := by
  dsimp [pellMatveevEta]
  rw [hssq, hrsq, Real.sqrt_sq hs,
    Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 3), Real.sqrt_sq hr]
  ring

theorem pellMatveevEta_sq (b : ℝ) (hb : 0 < b) :
    (pellMatveevEta b) ^ 2 = pellMatveevRoot (2 * b + 5) := by
  have h3 := Real.sq_sqrt (show 0 ≤ b + 3 by linarith)
  have h2 := Real.sq_sqrt (show 0 ≤ b + 2 by linarith)
  have heq : (2 * b + 5) ^ 2 - 1 =
      (2 * Real.sqrt (b + 3) * Real.sqrt (b + 2)) ^ 2 := by
    calc
      _ = 4 * (b + 3) * (b + 2) := by ring
      _ = _ := by rw [mul_pow, mul_pow, h3, h2]; ring
  have hnon : 0 ≤ 2 * Real.sqrt (b + 3) * Real.sqrt (b + 2) := by positivity
  dsimp [pellMatveevEta, pellMatveevRoot]
  rw [heq, Real.sqrt_sq hnon]
  nlinarith [h3, h2]

theorem pellMatveevEta_fourth (b : ℝ) (hb : 0 < b) :
    (pellMatveevEta b) ^ 4 = pellMatveevRoot (8 * b ^ 2 + 40 * b + 49) := by
  calc
    _ = ((pellMatveevEta b) ^ 2) ^ 2 := by ring
    _ = (pellMatveevRoot (2 * b + 5)) ^ 2 := by rw [pellMatveevEta_sq b hb]
    _ = pellMatveevRoot (2 * (2 * b + 5) ^ 2 - 1) :=
      pellMatveevRoot_sq _ (by linarith)
    _ = _ := by congr 1; ring

/-- The approximation is for the actual square-root expressions, and is
strict on both sides. No abstract height or radical model is substituted. -/
theorem pellMatveev_actualApproximation (b : ℝ) (hb : 22 ≤ b) :
    1 < (pellMatveevEta b) ^ 4 / (8 * pellMatveevW b) ∧
      (pellMatveevEta b) ^ 4 / (8 * pellMatveevW b) < 1 + 2 / b ∧
      (pellMatveevEta b) ^ 2 < pellMatveevW b := by
  have hbp : 0 < b := by linarith
  have hW := pellMatveevRoot_bounds (b ^ 2 + 3 * b + 1) (by nlinarith)
  have hE := pellMatveevRoot_bounds (8 * b ^ 2 + 40 * b + 49) (by nlinarith)
  have hE2 := pellMatveevRoot_bounds (2 * b + 5) (by linarith)
  rw [← pellMatveevEta_fourth b hbp] at hE
  rw [← pellMatveevEta_sq b hbp] at hE2
  change 2 * (b ^ 2 + 3 * b + 1) - 1 < pellMatveevW b ∧
    pellMatveevW b < 2 * (b ^ 2 + 3 * b + 1) at hW
  have hWp : 0 < pellMatveevW b := by nlinarith [hW.1]
  have hden : 0 < 8 * pellMatveevW b := by positivity
  refine ⟨(one_lt_div hden).mpr ?_, ?_, ?_⟩
  · nlinarith [hE.1, hW.2]
  · have hcross : (pellMatveevEta b) ^ 4 * b <
        (b + 2) * (8 * pellMatveevW b) := by
      have hleft := mul_lt_mul_of_pos_right hE.2 hbp
      have hright := mul_lt_mul_of_pos_right hW.1
        (show 0 < 8 * (b + 2) by linarith)
      nlinarith [hleft, hright]
    apply (div_lt_iff₀ hden).mpr
    have hcancel : (1 + 2 / b) * (8 * pellMatveevW b) =
        ((b + 2) * (8 * pellMatveevW b)) / b := by
      field_simp
    rw [hcancel]
    exact (lt_div_iff₀ hbp).mpr hcross
  · nlinarith [hE2.2, hW.1]

/-- Positivity and the exponential accuracy used by the mathematical
linear-form argument, still without invoking any approximation theorem. -/
theorem pellMatveev_actualLogLower (b : ℝ) (hb : 22 ≤ b) :
    let Λ := Real.log ((pellMatveevEta b) ^ 4 / (8 * pellMatveevW b))
    0 < Λ ∧ Λ < 2 / b ∧ Real.log (b + 2) / 2 < -Real.log Λ := by
  dsimp only
  have hbp : 0 < b := by linarith
  have h := pellMatveev_actualApproximation b hb
  let γ := (pellMatveevEta b) ^ 4 / (8 * pellMatveevW b)
  have hγ : 1 < γ := h.1
  have hγpos : 0 < γ := by linarith
  have hΛpos : 0 < Real.log γ := Real.log_pos hγ
  have hΛlt : Real.log γ < 2 / b := by
    have hlog := Real.log_le_sub_one_of_pos hγpos
    have hglt : γ < 1 + 2 / b := h.2.1
    linarith
  refine ⟨hΛpos, hΛlt, ?_⟩
  have hlog := Real.log_lt_log hΛpos hΛlt
  rw [Real.log_div (by norm_num : (2 : ℝ) ≠ 0) hbp.ne'] at hlog
  have hsquare : b + 2 < (b / 2) ^ 2 := by nlinarith
  have hheight := Real.log_lt_log (by linarith : 0 < b + 2) hsquare
  rw [Real.log_pow, Real.log_div hbp.ne' (by norm_num : (2 : ℝ) ≠ 0)] at hheight
  norm_num at hheight
  change Real.log (b + 2) / 2 < -Real.log (Real.log γ)
  linarith

theorem pellMatveev_actualLogHeight (b : ℝ) (hb : 22 ≤ b) :
    Real.log (pellMatveevW b) < 3 * Real.log (b + 2) := by
  have hW := pellMatveevRoot_bounds (b ^ 2 + 3 * b + 1) (by nlinarith)
  change 2 * (b ^ 2 + 3 * b + 1) - 1 < pellMatveevW b ∧
    pellMatveevW b < 2 * (b ^ 2 + 3 * b + 1) at hW
  have hWp : 0 < pellMatveevW b := by nlinarith [hW.1]
  have hu : pellMatveevW b < 2 * (b + 2) ^ 2 := by nlinarith [hW.2]
  have hlog := Real.log_lt_log hWp hu
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) (by positivity : (b + 2) ^ 2 ≠ 0),
    Real.log_pow] at hlog
  have htwo := Real.log_lt_log (by norm_num : (0 : ℝ) < 2)
    (show 2 < b + 2 by linarith)
  norm_num at hlog
  linarith

/-- Keeping the height of the final generator in the denominator
removes the large fixed-Pell exponent from the normalized parameter.
All logarithmic identities and inequalities are explicit arguments. -/
theorem pellMatveev_normalizedExponentBound
    (m p leps ldelta leta lW : ℝ) (hp : 2 ≤ p) (hdelta : 0 < ldelta)
    (hunit : m * leps = leta) (hpower : p * ldelta = lW)
    (hgap : 2 * leta < lW) (hfixed : 6 * Real.log 2 < 4 * ldelta) :
    max 1 (max (4 * m * (2 * leps) / (2 * ldelta))
      (max (3 * (4 * Real.log 2) / (2 * ldelta)) p)) ≤ 2 * p := by
  have hden : 0 < 2 * ldelta := by positivity
  have hfirst : 4 * m * (2 * leps) / (2 * ldelta) < 2 * p := by
    apply (div_lt_iff₀ hden).mpr
    nlinarith [hunit, hpower, hgap]
  have hsecond : 3 * (4 * Real.log 2) / (2 * ldelta) < 4 := by
    apply (div_lt_iff₀ hden).mpr
    nlinarith
  exact max_le (by linarith) (max_le hfirst.le
    (max_le (by linarith) (by linarith)))

private theorem pellMatveev_log_le_half (t : ℝ) (ht : 0 < t) :
    Real.log t ≤ t / 2 := by
  have h := Real.log_le_sub_one_of_pos (div_pos ht (by norm_num : (0 : ℝ) < 2))
  rw [Real.log_div ht.ne' (by norm_num : (2 : ℝ) ≠ 0)] at h
  have htwo := Real.log_le_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
  linarith

/-- An explicit real-variable absorption; the logarithmic-form conclusion
is an argument, not a new theorem or axiom concerning algebraic numbers. -/
theorem pellMatveev_indexAbsorption (p : ℝ) (hp : 0 < p)
    (h : p < (2 : ℝ) ^ 52 * Real.log (2 * Real.exp 1 * p)) :
    p < (2 : ℝ) ^ 59 := by
  let t := p / (2 : ℝ) ^ 52
  have ht : 0 < t := div_pos hp (by positivity)
  have hpeq : p = (2 : ℝ) ^ 52 * t := by dsimp [t]; field_simp
  have hlogp : Real.log p = 52 * Real.log 2 + Real.log t := by
    rw [hpeq, Real.log_mul (by positivity : (2 : ℝ) ^ 52 ≠ 0) ht.ne', Real.log_pow]
    norm_num
  have hsplit : Real.log (2 * Real.exp 1 * p) =
      53 * Real.log 2 + 1 + Real.log t := by
    rw [Real.log_mul (by positivity : 2 * Real.exp (1 : ℝ) ≠ 0) hp.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) (Real.exp_ne_zero _), Real.log_exp, hlogp]
    ring
  have hdiv : t < Real.log (2 * Real.exp 1 * p) :=
    (div_lt_iff₀ (by positivity : (0 : ℝ) < 2 ^ 52)).mpr (by simpa [mul_comm] using h)
  rw [hsplit] at hdiv
  have hhalf := pellMatveev_log_le_half t ht
  have htwo : Real.log (2 : ℝ) < 1 := by
    have ht := Real.log_lt_sub_one_of_pos (by norm_num : (0 : ℝ) < 2)
      (by norm_num : (2 : ℝ) ≠ 1)
    norm_num at ht
    exact ht
  have htbound : t < 128 := by linarith
  rw [hpeq]
  have hprod := mul_lt_mul_of_pos_left htbound (by positivity : (0 : ℝ) < 2 ^ 52)
  norm_num at hprod ⊢
  exact hprod

/-- Explicit numerical consequences of the upper and lower logarithmic
estimates. Both analytic estimates remain supplied hypotheses. -/
theorem pellMatveev_explicitEstimate_indexBound
    (H p ell : ℝ) (hH : 0 < H) (hp : 0 < p)
    (hlower : H / 2 < ell)
    (hupper : ell < (2 : ℝ) ^ 38 * 16 * 3 * 96 * (H / p) *
      Real.log (2 * Real.exp 1 * p)) :
    p < (2 : ℝ) ^ 59 := by
  let q := Real.log (2 * Real.exp 1 * p)
  have hineq : H / 2 < ((2 : ℝ) ^ 38 * 16 * 3 * 96 * H * q) / p := by
    calc
      _ < ell := hlower
      _ < _ := by convert hupper using 1; dsimp [q]; ring
  have hmul := (lt_div_iff₀ hp).mp hineq
  have hcancel : H * p < H * (9 * (2 : ℝ) ^ 48 * q) := by
    norm_num at hmul ⊢
    nlinarith
  have hsmall : p < 9 * (2 : ℝ) ^ 48 * q := (mul_lt_mul_iff_of_pos_left hH).mp hcancel
  have hq : 0 < q := by norm_num at hsmall; nlinarith
  have hbig : p < (2 : ℝ) ^ 52 * q := by norm_num at hsmall ⊢; nlinarith
  exact pellMatveev_indexAbsorption p hp hbig

/-- The published integral-point bound is supplied explicitly. This is
only its elementary combination with the established numerical index cap. -/
theorem pellMatveev_effectiveHeightCap
    (H p : ℝ) (hp : 0 < p) (hindex : p < (2 : ℝ) ^ 59)
    (hBEG : H ≤ Real.exp (4300 * p ^ 5)) :
    H < Real.exp (4300 * (2 : ℝ) ^ 295) := by
  calc
    H ≤ Real.exp (4300 * p ^ 5) := hBEG
    _ < Real.exp (4300 * ((2 : ℝ) ^ 59) ^ 5) := by
      apply Real.exp_lt_exp.mpr
      gcongr
    _ = _ := by rw [← pow_mul]

theorem pellMatveev_effectiveCoordinateCap
    (b p : ℝ) (hb : 0 < b + 2) (hp : 0 < p)
    (hindex : p < (2 : ℝ) ^ 59)
    (hBEG : Real.log (b + 2) ≤ Real.exp (4300 * p ^ 5)) :
    b + 2 < Real.exp (Real.exp (4300 * (2 : ℝ) ^ 295)) := by
  have hheight := pellMatveev_effectiveHeightCap (Real.log (b + 2)) p hp hindex hBEG
  simpa [Real.exp_log hb] using Real.exp_lt_exp.mpr hheight

#print axioms pellMatveevRoot_sq
#print axioms pellMatveevEta_of_packet
#print axioms pellMatveevEta_fourth
#print axioms pellMatveev_actualApproximation
#print axioms pellMatveev_actualLogLower
#print axioms pellMatveev_actualLogHeight
#print axioms pellMatveev_normalizedExponentBound
#print axioms pellMatveev_indexAbsorption
#print axioms pellMatveev_explicitEstimate_indexBound
#print axioms pellMatveev_effectiveHeightCap
#print axioms pellMatveev_effectiveCoordinateCap

end

end IUTThreeClosures
