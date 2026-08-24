import IUTThreeClosures.IUTIVAbsorption

/-!
# Explicit absorption of square-root logarithmic q-pilot errors

The prescribed-size auxiliary-prime estimates used in IUT IV produce errors
of the shape `K * sqrt x * log (A * x)`.  This file proves, purely at the
scalar level, an explicit linear majorant for such an error.  In particular,
no comparison between a q-pilot and a global height is assumed here.
-/

namespace IUTThreeClosures

/-- A polynomial form of Young's inequality, with the constant optimized for
the cubic/quartic exponents used below. -/
theorem four_mul_cube_le_mul_fourth_add
    {s t : ℝ} (hs : 0 < s) :
    4 * t ^ 3 ≤ s * t ^ 4 + 27 / s ^ 3 := by
  let y : ℝ := s * t
  have hquad : 0 ≤ y ^ 2 + 2 * y + 3 := by
    nlinarith [sq_nonneg (y + 1)]
  have hfactor : 0 ≤ (y - 3) ^ 2 * (y ^ 2 + 2 * y + 3) :=
    mul_nonneg (sq_nonneg (y - 3)) hquad
  have hpoly : 4 * y ^ 3 ≤ y ^ 4 + 27 := by
    nlinarith [hfactor]
  have hs3 : 0 < s ^ 3 := pow_pos hs 3
  have hsne : s ≠ 0 := ne_of_gt hs
  calc
    4 * t ^ 3 = (4 * (s * t) ^ 3) / s ^ 3 := by
      field_simp [hsne]
    _ ≤ ((s * t) ^ 4 + 27) / s ^ 3 := by
      exact div_le_div_of_nonneg_right (by simpa [y] using hpoly) hs3.le
    _ = s * t ^ 4 + 27 / s ^ 3 := by
      field_simp [hsne]

/-- Square completion in the precise scaled form needed for the logarithm of
the fixed factor. -/
theorem sq_mul_le_mul_fourth_add
    {s t u : ℝ} (hs : 0 < s) :
    t ^ 2 * u ≤ s * t ^ 4 + u ^ 2 / (4 * s) := by
  have hsq : 0 ≤ (2 * s * t ^ 2 - u) ^ 2 := sq_nonneg _
  have hscaled :
      4 * s * (t ^ 2 * u) ≤ 4 * s * (s * t ^ 4) + u ^ 2 := by
    nlinarith [hsq]
  have h4s : 0 < 4 * s := mul_pos (by norm_num) hs
  have hsne : s ≠ 0 := ne_of_gt hs
  calc
    t ^ 2 * u = (4 * s * (t ^ 2 * u)) / (4 * s) := by
      field_simp [hsne]
    _ ≤ (4 * s * (s * t ^ 4) + u ^ 2) / (4 * s) := by
      exact div_le_div_of_nonneg_right hscaled h4s.le
    _ = s * t ^ 4 + u ^ 2 / (4 * s) := by
      field_simp [hsne]

/-- Explicit sublinear-to-linear absorption:

`sqrt x * log (A*x) ≤ ρ*x + 216/ρ^3 + (log A)^2/(2ρ)`.

The hypotheses `1 ≤ x` and `1 ≤ A` are the natural range in the q-pilot
application. -/
theorem sqrt_mul_log_le_linear_explicit
    {x A ρ : ℝ} (hx : 1 ≤ x) (hA : 1 ≤ A) (hρ : 0 < ρ) :
    Real.sqrt x * Real.log (A * x) ≤
      ρ * x + 216 / ρ ^ 3 + (Real.log A) ^ 2 / (2 * ρ) := by
  let t : ℝ := Real.sqrt (Real.sqrt x)
  let s : ℝ := ρ / 2
  have hx0 : 0 ≤ x := le_trans (by norm_num) hx
  have hxpos : 0 < x := lt_of_lt_of_le (by norm_num) hx
  have hApos : 0 < A := lt_of_lt_of_le (by norm_num) hA
  have hsqrtx0 : 0 ≤ Real.sqrt x := Real.sqrt_nonneg x
  have hsqrtxpos : 0 < Real.sqrt x := Real.sqrt_pos.2 hxpos
  have htpos : 0 < t := by
    exact Real.sqrt_pos.2 hsqrtxpos
  have ht2 : t ^ 2 = Real.sqrt x := by
    simp [t, hsqrtx0]
  have ht4 : t ^ 4 = x := by
    calc
      t ^ 4 = (t ^ 2) ^ 2 := by ring
      _ = (Real.sqrt x) ^ 2 := by rw [ht2]
      _ = x := Real.sq_sqrt hx0
  have hs : 0 < s := by
    dsimp [s]
    positivity
  have hlogt : Real.log t ≤ t := by
    have h := Real.log_le_sub_one_of_pos htpos
    linarith
  have hlogx : Real.log x ≤ 4 * t := by
    have hlogpow : Real.log x = 4 * Real.log t := by
      calc
        Real.log x = Real.log (t ^ 4) := by rw [ht4]
        _ = 4 * Real.log t := by rw [Real.log_pow]; norm_num
    rw [hlogpow]
    nlinarith
  have hxpart :
      Real.sqrt x * Real.log x ≤ 4 * t ^ 3 := by
    rw [← ht2]
    calc
      t ^ 2 * Real.log x ≤ t ^ 2 * (4 * t) :=
        mul_le_mul_of_nonneg_left hlogx (sq_nonneg t)
      _ = 4 * t ^ 3 := by ring
  have hyoung : 4 * t ^ 3 ≤ s * x + 27 / s ^ 3 := by
    simpa [ht4] using
      (four_mul_cube_le_mul_fourth_add (s := s) (t := t) hs)
  have hApart :
      Real.sqrt x * Real.log A ≤
        s * x + (Real.log A) ^ 2 / (4 * s) := by
    rw [← ht2]
    simpa [ht4] using
      (sq_mul_le_mul_fourth_add
        (s := s) (t := t) (u := Real.log A) hs)
  have hlogmul : Real.log (A * x) = Real.log A + Real.log x :=
    Real.log_mul hApos.ne' hxpos.ne'
  calc
    Real.sqrt x * Real.log (A * x) =
        Real.sqrt x * Real.log x + Real.sqrt x * Real.log A := by
      rw [hlogmul]
      ring
    _ ≤ (s * x + 27 / s ^ 3) +
        (s * x + (Real.log A) ^ 2 / (4 * s)) := by
      linarith
    _ = ρ * x + 216 / ρ ^ 3 + (Real.log A) ^ 2 / (2 * ρ) := by
      dsimp [s]
      field_simp [ne_of_gt hρ]
      all_goals ring

/-- Multiplicatively weighted version of
`sqrt_mul_log_le_linear_explicit`. -/
theorem mul_sqrt_mul_log_le_linear_explicit
    {x A K τ : ℝ}
    (hx : 1 ≤ x) (hA : 1 ≤ A) (hK : 0 < K) (hτ : 0 < τ) :
    K * (Real.sqrt x * Real.log (A * x)) ≤
      τ * x + 216 * K ^ 4 / τ ^ 3 +
        K ^ 2 * (Real.log A) ^ 2 / (2 * τ) := by
  have hρ : 0 < τ / K := div_pos hτ hK
  have hbase := sqrt_mul_log_le_linear_explicit hx hA hρ
  have hscaled := mul_le_mul_of_nonneg_left hbase hK.le
  calc
    K * (Real.sqrt x * Real.log (A * x)) ≤
        K * ((τ / K) * x + 216 / (τ / K) ^ 3 +
          (Real.log A) ^ 2 / (2 * (τ / K))) := hscaled
    _ = τ * x + 216 * K ^ 4 / τ ^ 3 +
        K ^ 2 * (Real.log A) ^ 2 / (2 * τ) := by
      field_simp [ne_of_gt hK, ne_of_gt hτ]

/-- `proposition21_absorption` with a prescribed-size-prime error of the form
`K * sqrt q6 * log (A*q6)` already converted into an explicit constant. -/
theorem proposition21_absorption_with_sqrtLog
    {ε q6 diff cond C K A : ℝ}
    (hε : 0 < ε) (hε1 : ε ≤ 1)
    (hq6 : 1 ≤ q6) (hA : 1 ≤ A) (hK : 0 < K)
    (hdiff : 0 ≤ diff) (hcond : 0 ≤ cond) (hC : 0 ≤ C)
    (hmain : q6 ≤
      (1 + 2 * ε / 5) * (diff + cond) +
        K * (Real.sqrt q6 * Real.log (A * q6)) + C) :
    q6 ≤ (1 + ε) * (diff + cond) +
      2 * (C +
        (216 * K ^ 4 / (ε / 5) ^ 3 +
          K ^ 2 * (Real.log A) ^ 2 / (2 * (ε / 5)))) := by
  let E : ℝ :=
    216 * K ^ 4 / (ε / 5) ^ 3 +
      K ^ 2 * (Real.log A) ^ 2 / (2 * (ε / 5))
  have hτ : 0 < ε / 5 := by positivity
  have herr :
      K * (Real.sqrt q6 * Real.log (A * q6)) ≤
        (ε / 5) * q6 + E := by
    simpa [E, add_assoc] using
      (mul_sqrt_mul_log_le_linear_explicit hq6 hA hK hτ)
  have hE : 0 ≤ E := by
    dsimp [E]
    positivity
  have hinput : q6 ≤
      (1 + 2 * ε / 5) * (diff + cond) +
        (ε / 5) * (q6 + diff) + (C + E) := by
    nlinarith
  simpa [E] using
    (proposition21_absorption hε hε1 hdiff hcond
      (add_nonneg hC hE) hinput)

end IUTThreeClosures
