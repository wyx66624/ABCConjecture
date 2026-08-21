import IUTThreeClosures.TripodWeilHeight

/-!
# A canonical Legendre height corridor

For an abc point let `H = a² + ab + b²`.  The elementary inequalities

`3 c² ≤ 4 H ≤ 4 c²`

show that `log H` differs from `2 log c` by a universal bounded amount.  This
file turns that observation into a source-independent Lean theorem.  In
particular the canonical quantity `3 log H` differs from six times the actual
tripod Weil height by at most `3 log 2`.

This does not identify the public q-pilot with `3 log H`; that is a separate
source theorem.  It does remove the arithmetic-height part of such an
identification from the remaining IUT IV bridge.
-/

namespace IUTThreeClosures

namespace ABCPoint

/-- A convenient integral consequence of `3c² ≤ 4H`. -/
theorem c_sq_le_two_legendreCore (P : ABCPoint) :
    P.c ^ 2 ≤ 2 * P.legendreCore := by
  have h := P.three_c_sq_le_four_legendreCore
  omega

/-- The logarithm of the Legendre numerator core is at most twice the abc
height. -/
theorem log_legendreCore_le_two_height (P : ABCPoint) :
    Real.log (P.legendreCore : ℝ) ≤ 2 * P.height := by
  rw [P.height_eq_log_c]
  have hHpos : 0 < (P.legendreCore : ℝ) := by
    exact_mod_cast P.legendreCore_pos
  have hle : (P.legendreCore : ℝ) ≤ (P.c : ℝ) ^ 2 := by
    exact_mod_cast P.legendreCore_le_c_sq
  calc
    Real.log (P.legendreCore : ℝ) ≤
        Real.log ((P.c : ℝ) ^ 2) :=
      Real.log_le_log hHpos hle
    _ = 2 * Real.log (P.c : ℝ) := by
      rw [Real.log_pow]
      norm_num

/-- Twice the abc height is at most `log 2 + log H`. -/
theorem two_height_le_log_two_add_log_legendreCore (P : ABCPoint) :
    2 * P.height ≤
      Real.log 2 + Real.log (P.legendreCore : ℝ) := by
  rw [P.height_eq_log_c]
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hHpos : 0 < (P.legendreCore : ℝ) := by
    exact_mod_cast P.legendreCore_pos
  have hle : (P.c : ℝ) ^ 2 ≤ 2 * (P.legendreCore : ℝ) := by
    exact_mod_cast P.c_sq_le_two_legendreCore
  calc
    2 * Real.log (P.c : ℝ) = Real.log ((P.c : ℝ) ^ 2) := by
      rw [Real.log_pow]
      norm_num
    _ ≤ Real.log (2 * (P.legendreCore : ℝ)) :=
      Real.log_le_log (sq_pos_of_pos hcpos) hle
    _ = Real.log 2 + Real.log (P.legendreCore : ℝ) := by
      rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hHpos.ne']

/-- Exact uniform interval for the difference `2h - log H`. -/
theorem legendreCore_height_error_bounds (P : ABCPoint) :
    0 ≤ 2 * P.height - Real.log (P.legendreCore : ℝ) ∧
      2 * P.height - Real.log (P.legendreCore : ℝ) ≤ Real.log 2 := by
  constructor
  · exact sub_nonneg.mpr P.log_legendreCore_le_two_height
  · have h := P.two_height_le_log_two_add_log_legendreCore
    linarith

end ABCPoint

/-- Canonical arithmetic q-log candidate supplied by the Legendre numerator. -/
noncomputable def legendreCoreQLog (P : ABCPoint) : ℝ :=
  3 * Real.log (P.legendreCore : ℝ)

/-- Six times the actual tripod height differs from the canonical Legendre
core q-log by a nonnegative error bounded by `3 log 2`. -/
theorem six_height_sub_legendreCoreQLog_bounds (P : ABCPoint) :
    0 ≤ 6 * P.height - legendreCoreQLog P ∧
      6 * P.height - legendreCoreQLog P ≤ 3 * Real.log 2 := by
  have h := P.legendreCore_height_error_bounds
  unfold legendreCoreQLog
  constructor <;> nlinarith

/-- Symmetric bounded-discrepancy form of the canonical height corridor. -/
theorem abs_six_height_sub_legendreCoreQLog_le (P : ABCPoint) :
    |6 * P.height - legendreCoreQLog P| ≤ 3 * Real.log 2 := by
  rw [abs_of_nonneg (six_height_sub_legendreCoreQLog_bounds P).1]
  exact (six_height_sub_legendreCoreQLog_bounds P).2

end IUTThreeClosures
