import IUTThreeClosures.FreyJReducedData
import Heights.WeilHeight

/-!
# Canonical Frey `j`-height corridor

This file converts the reduced numerator/denominator estimates for the Frey
`j`-invariant into an actual Weil-height comparison. No arbitrary real-valued
height function is introduced: the middle quantity is
`Heights.normalizedLogHeight ℚ (abcFreyCurve P).j`.

The resulting two-sided estimate is

`height(P) - log(8)/6 ≤ h(j(E_P))/6 ≤ height(P) + log(256)/6`.

It supplies the canonical bounded-discrepancy input needed by a strict
source-derived IUT IV bridge once the source q-pilot is identified with the
Frey/Legendre `j`-height.
-/

namespace IUTThreeClosures

namespace ABCPoint

/-- The Frey `j`-invariant written with its unreduced natural numerator and
denominator. -/
theorem abcFrey_j_eq_raw (P : ABCPoint) :
    (abcFreyCurve P).j =
      (P.freyJRawNum : ℚ) / (P.freyJRawDen : ℚ) := by
  rw [abcFrey_j]
  unfold freyJRawNum freyJRawDen
  push_cast
  ring

/-- The actual Frey `j`-invariant is the quotient of the reduced natural
coordinates. -/
theorem abcFrey_j_eq_reduced (P : ABCPoint) :
    (abcFreyCurve P).j =
      (P.freyJReducedNum : ℚ) / (P.freyJReducedDen : ℚ) := by
  rw [P.abcFrey_j_eq_raw]
  rw [← P.freyJReducedNum_mul_content,
    ← P.freyJReducedDen_mul_content]
  push_cast
  have hg : (P.freyJContent : ℚ) ≠ 0 := by
    exact_mod_cast P.freyJContent_pos.ne'
  have hd : (P.freyJReducedDen : ℚ) ≠ 0 := by
    exact_mod_cast P.freyJReducedDen_pos.ne'
  field_simp [hg, hd]

/-- The reduced natural numerator is the numerator stored by `ℚ`. -/
theorem abcFrey_j_num (P : ABCPoint) :
    (abcFreyCurve P).j.num = (P.freyJReducedNum : ℤ) := by
  rw [P.abcFrey_j_eq_reduced]
  have hd : 0 < (P.freyJReducedDen : ℤ) := by
    exact_mod_cast P.freyJReducedDen_pos
  have hcop : Nat.Coprime
      (P.freyJReducedNum : ℤ).natAbs
      (P.freyJReducedDen : ℤ).natAbs := by
    simpa using P.freyJReduced_coprime
  simpa using Rat.num_div_eq_of_coprime
    (a := (P.freyJReducedNum : ℤ))
    (b := (P.freyJReducedDen : ℤ)) hd hcop

/-- The reduced natural denominator is the denominator stored by `ℚ`. -/
theorem abcFrey_j_den (P : ABCPoint) :
    (abcFreyCurve P).j.den = P.freyJReducedDen := by
  rw [P.abcFrey_j_eq_reduced]
  have hd : 0 < (P.freyJReducedDen : ℤ) := by
    exact_mod_cast P.freyJReducedDen_pos
  have hcop : Nat.Coprime
      (P.freyJReducedNum : ℤ).natAbs
      (P.freyJReducedDen : ℤ).natAbs := by
    simpa using P.freyJReduced_coprime
  have h := Rat.den_div_eq_of_coprime
    (a := (P.freyJReducedNum : ℤ))
    (b := (P.freyJReducedDen : ℤ)) hd hcop
  have h' :
      ((((P.freyJReducedNum : ℚ) /
        (P.freyJReducedDen : ℚ)).den : ℕ) : ℤ) =
        (P.freyJReducedDen : ℤ) := by
    simpa using h
  exact Int.ofNat_inj.mp h'

/-- Exact expression for the actual absolute rational Weil height of the Frey
`j`-invariant. -/
theorem normalizedLogHeight_abcFrey_j (P : ABCPoint) :
    Heights.normalizedLogHeight ℚ (abcFreyCurve P).j =
      Real.log
        ((max P.freyJReducedNum P.freyJReducedDen : ℕ) : ℝ) := by
  rw [Heights.normalizedLogHeight_rat,
    P.abcFrey_j_num, P.abcFrey_j_den]
  simp only [Int.natAbs_natCast]

/-- The elementary abc height is bounded by one sixth of the canonical Frey
`j`-height, up to the explicit constant `log 8 / 6`. -/
theorem height_le_normalizedLogHeight_abcFrey_j (P : ABCPoint) :
    P.height ≤
      Heights.normalizedLogHeight ℚ (abcFreyCurve P).j / 6 +
        Real.log 8 / 6 := by
  rw [P.height_eq_log_c, P.normalizedLogHeight_abcFrey_j]
  let M : ℕ := max P.freyJReducedNum P.freyJReducedDen
  have hM : 0 < M :=
    P.freyJReducedNum_pos.trans_le (le_max_left _ _)
  have hnat : P.c ^ 6 ≤ 8 * M := by
    simpa [M] using P.c_pow_six_le_eight_freyJReducedMax
  have hcR : (0 : ℝ) < P.c := by
    exact_mod_cast P.c_pos
  have hMR : (0 : ℝ) < M := by
    exact_mod_cast hM
  have hreal : (P.c : ℝ) ^ 6 ≤ 8 * (M : ℝ) := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log (pow_pos hcR 6) hreal
  rw [Real.log_pow,
    Real.log_mul (by norm_num : (8 : ℝ) ≠ 0) hMR.ne'] at hlog
  have hgoal :
      Real.log (P.c : ℝ) ≤
        Real.log (M : ℝ) / 6 + Real.log 8 / 6 := by
    nlinarith [hlog]
  simpa [M] using hgoal

/-- Conversely, one sixth of the canonical Frey `j`-height is bounded by the
abc height up to the explicit constant `log 256 / 6`. -/
theorem normalizedLogHeight_abcFrey_j_div_six_le (P : ABCPoint) :
    Heights.normalizedLogHeight ℚ (abcFreyCurve P).j / 6 ≤
      P.height + Real.log 256 / 6 := by
  rw [P.height_eq_log_c, P.normalizedLogHeight_abcFrey_j]
  let M : ℕ := max P.freyJReducedNum P.freyJReducedDen
  have hM : 0 < M :=
    P.freyJReducedNum_pos.trans_le (le_max_left _ _)
  have hnat : M ≤ 256 * P.c ^ 6 := by
    simpa [M] using P.freyJReducedMax_le
  have hMR : (0 : ℝ) < M := by
    exact_mod_cast hM
  have hcR : (0 : ℝ) < P.c := by
    exact_mod_cast P.c_pos
  have hreal : (M : ℝ) ≤ 256 * (P.c : ℝ) ^ 6 := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log hMR hreal
  rw [Real.log_mul (by norm_num : (256 : ℝ) ≠ 0)
      (pow_pos hcR 6).ne',
    Real.log_pow] at hlog
  have hgoal :
      Real.log (M : ℝ) / 6 ≤
        Real.log (P.c : ℝ) + Real.log 256 / 6 := by
    nlinarith [hlog]
  simpa [M] using hgoal

/-- Two-sided bounded discrepancy between the target height and one sixth of
the canonical Frey `j`-height. -/
theorem abs_height_sub_freyJHeight_div_six_le (P : ABCPoint) :
    |P.height -
      Heights.normalizedLogHeight ℚ (abcFreyCurve P).j / 6| ≤
        max (Real.log 8 / 6) (Real.log 256 / 6) := by
  rw [abs_le]
  constructor
  · have h := P.normalizedLogHeight_abcFrey_j_div_six_le
    have hm : Real.log 256 / 6 ≤
        max (Real.log 8 / 6) (Real.log 256 / 6) :=
      le_max_right _ _
    nlinarith
  · have h := P.height_le_normalizedLogHeight_abcFrey_j
    have hm : Real.log 8 / 6 ≤
        max (Real.log 8 / 6) (Real.log 256 / 6) :=
      le_max_left _ _
    nlinarith

end ABCPoint

end IUTThreeClosures
