import IUTThreeClosures.TripodWeilHeight
import Mathlib.AlgebraicGeometry.EllipticCurve.ModelsWithJ

/-!
# A nonintegral-j elliptic curve attached to every abc point

The Legendre/Frey curve has the correct height, but exceptional abc points may
have a CM `j`-invariant such as `1728`.  For the admissible-prime route it is
useful to have a point-dependent curve whose rational `j`-invariant is visibly
nonintegral while retaining the same height scale.

For `λ = a/c` define

`j_shift = 2 + λ = (2c + a)/c`.

Since `gcd(a,c)=1`, this fraction is reduced; its denominator is exactly `c`.
As `a,b>0` and `a+b=c`, one has `c≥2` and hence `j_shift` is not an integer.
Mathlib's `WeierstrassCurve.ofJ` then gives an actual elliptic curve with this
`j`-invariant.  Its absolute Weil height lies between

`height(P) + log 2` and `height(P) + log 3`.

The classical theorem that a CM elliptic curve has algebraic-integral
`j`-invariant would therefore certify this family as non-CM.  That theorem and
the subsequent open-image theorem are not presently available in the imported
Lean libraries; this file formalizes the complete elementary input to that
route without postulating either result.
-/

namespace IUTThreeClosures

namespace ABCPoint

/-- The shifted rational `j`-parameter `2 + a/c`. -/
noncomputable def shiftedJ (P : ABCPoint) : ℚ :=
  2 + P.lambda

/-- The explicit numerator/denominator presentation of the shifted parameter. -/
theorem shiftedJ_eq_num_div (P : ABCPoint) :
    P.shiftedJ =
      ((2 * P.c + P.a : ℕ) : ℚ) / (P.c : ℚ) := by
  have hc : (P.c : ℚ) ≠ 0 := by
    exact_mod_cast P.c_pos.ne'
  rw [shiftedJ, ABCPoint.lambda]
  field_simp [hc]
  ring

/-- The shifted parameter lies strictly between `2` and `3`. -/
theorem two_lt_shiftedJ (P : ABCPoint) : (2 : ℚ) < P.shiftedJ := by
  unfold shiftedJ
  linarith [P.lambda_pos]

/-- The shifted parameter lies strictly below `3`. -/
theorem shiftedJ_lt_three (P : ABCPoint) : P.shiftedJ < (3 : ℚ) := by
  unfold shiftedJ
  linarith [P.lambda_lt_one]

/-- In particular the shifted parameter is neither `0` nor `1728`. -/
theorem shiftedJ_ne_zero (P : ABCPoint) : P.shiftedJ ≠ 0 :=
  ne_of_gt (lt_trans (by norm_num) P.two_lt_shiftedJ)

/-- In particular the shifted parameter is not `1728`. -/
theorem shiftedJ_ne_1728 (P : ABCPoint) : P.shiftedJ ≠ 1728 := by
  intro h
  have : P.shiftedJ < (1728 : ℚ) :=
    P.shiftedJ_lt_three.trans (by norm_num)
  linarith

/-- The numerator `2c+a` is coprime to `c`. -/
theorem coprime_shiftedJ_num_den (P : ABCPoint) :
    Nat.Coprime (2 * P.c + P.a) P.c := by
  rw [show 2 * P.c + P.a = P.a + P.c * 2 by omega]
  exact (Nat.coprime_add_mul_left_left P.a P.c 2).2 P.coprime_a_c

/-- The reduced numerator of `j_shift` is exactly `2c+a`. -/
theorem shiftedJ_num (P : ABCPoint) :
    P.shiftedJ.num = (2 * P.c + P.a : ℕ) := by
  rw [P.shiftedJ_eq_num_div]
  have hc : 0 < (P.c : ℤ) := by
    exact_mod_cast P.c_pos
  have hcop : Nat.Coprime
      (2 * P.c + P.a : ℤ).natAbs (P.c : ℤ).natAbs := by
    simpa using P.coprime_shiftedJ_num_den
  simpa using Rat.num_div_eq_of_coprime
    (a := (2 * P.c + P.a : ℤ)) (b := (P.c : ℤ)) hc hcop

/-- The reduced denominator of `j_shift` is exactly `c`. -/
theorem shiftedJ_den (P : ABCPoint) :
    P.shiftedJ.den = P.c := by
  rw [P.shiftedJ_eq_num_div]
  have hc : 0 < (P.c : ℤ) := by
    exact_mod_cast P.c_pos
  have hcop : Nat.Coprime
      (2 * P.c + P.a : ℤ).natAbs (P.c : ℤ).natAbs := by
    simpa using P.coprime_shiftedJ_num_den
  have h := Rat.den_div_eq_of_coprime
    (a := (2 * P.c + P.a : ℤ)) (b := (P.c : ℤ)) hc hcop
  have h' :
      ((((((2 * P.c + P.a : ℕ) : ℚ) / (P.c : ℚ)).den : ℕ) : ℤ)) =
        (P.c : ℤ) := by
    simpa using h
  exact Int.ofNat_inj.mp h'

/-- Every positive abc triple has `c ≥ 2`. -/
theorem two_le_c (P : ABCPoint) : 2 ≤ P.c := by
  omega

/-- The shifted parameter has nontrivial denominator. -/
theorem shiftedJ_den_ne_one (P : ABCPoint) : P.shiftedJ.den ≠ 1 := by
  rw [P.shiftedJ_den]
  omega

/-- The shifted rational parameter is not the image of an integer. -/
theorem shiftedJ_not_integer (P : ABCPoint) :
    ¬ ∃ z : ℤ, P.shiftedJ = (z : ℚ) := by
  rintro ⟨z, hz⟩
  have hden := congrArg Rat.den hz
  have : P.shiftedJ.den = 1 := by simpa using hden
  exact P.shiftedJ_den_ne_one this

/-- The numerator is strictly larger than `2c`. -/
theorem two_c_lt_shiftedJ_numNat (P : ABCPoint) :
    2 * P.c < 2 * P.c + P.a := by
  omega

/-- The numerator is strictly smaller than `3c`. -/
theorem shiftedJ_numNat_lt_three_c (P : ABCPoint) :
    2 * P.c + P.a < 3 * P.c := by
  have ha := P.a_lt_c
  omega

/-- The actual absolute Weil height of the shifted parameter. -/
theorem normalizedLogHeight_shiftedJ (P : ABCPoint) :
    Heights.normalizedLogHeight ℚ P.shiftedJ =
      Real.log ((2 * P.c + P.a : ℕ) : ℝ) := by
  rw [Heights.normalizedLogHeight_rat, P.shiftedJ_num, P.shiftedJ_den]
  simp only [Int.natAbs_natCast]
  rw [max_eq_left]
  exact Nat.le_of_lt (P.c_lt_shiftedJ_numNat)

/-- The shifted `j`-height is at least `height(P)+log 2`. -/
theorem height_add_log_two_le_shiftedJHeight (P : ABCPoint) :
    P.height + Real.log 2 ≤ Heights.normalizedLogHeight ℚ P.shiftedJ := by
  rw [P.height_eq_log_c, P.normalizedLogHeight_shiftedJ]
  have hc : (0 : ℝ) < P.c := by exact_mod_cast P.c_pos
  have hnum : (0 : ℝ) < 2 * P.c + P.a := by
    exact_mod_cast Nat.add_pos_left (2 * P.c) P.a
  have hle : (2 : ℝ) * P.c ≤ (2 * P.c + P.a : ℕ) := by
    exact_mod_cast (Nat.le_add_right (2 * P.c) P.a)
  have hlog := Real.log_le_log (mul_pos (by norm_num) hc) hle
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hc.ne'] at hlog
  exact hlog

/-- The shifted `j`-height is at most `height(P)+log 3`. -/
theorem shiftedJHeight_le_height_add_log_three (P : ABCPoint) :
    Heights.normalizedLogHeight ℚ P.shiftedJ ≤
      P.height + Real.log 3 := by
  rw [P.height_eq_log_c, P.normalizedLogHeight_shiftedJ]
  have hc : (0 : ℝ) < P.c := by exact_mod_cast P.c_pos
  have hnum : (0 : ℝ) < (2 * P.c + P.a : ℕ) := by
    exact_mod_cast Nat.add_pos_left (2 * P.c) P.a
  have hle : ((2 * P.c + P.a : ℕ) : ℝ) ≤ (3 : ℝ) * P.c := by
    exact_mod_cast Nat.le_of_lt P.shiftedJ_numNat_lt_three_c
  have hlog := Real.log_le_log hnum hle
  rw [Real.log_mul (by norm_num : (3 : ℝ) ≠ 0) hc.ne'] at hlog
  nlinarith

/-- Uniform bounded discrepancy between the shifted `j`-height and the abc
height. -/
theorem shiftedJHeight_sub_height_bounds (P : ABCPoint) :
    Real.log 2 ≤ Heights.normalizedLogHeight ℚ P.shiftedJ - P.height ∧
      Heights.normalizedLogHeight ℚ P.shiftedJ - P.height ≤ Real.log 3 := by
  constructor
  · linarith [P.height_add_log_two_le_shiftedJHeight]
  · linarith [P.shiftedJHeight_le_height_add_log_three]

end ABCPoint

/-- The Mathlib elliptic curve with prescribed nonintegral shifted
`j`-invariant. -/
noncomputable def abcShiftedJCurve (P : ABCPoint) : WeierstrassCurve ℚ :=
  WeierstrassCurve.ofJ P.shiftedJ

noncomputable instance abcShiftedJCurve_isElliptic (P : ABCPoint) :
    (abcShiftedJCurve P).IsElliptic := by
  unfold abcShiftedJCurve
  infer_instance

/-- The constructed curve has exactly the shifted `j`-invariant. -/
theorem abcShiftedJCurve_j (P : ABCPoint) :
    (abcShiftedJCurve P).j = P.shiftedJ := by
  unfold abcShiftedJCurve
  exact WeierstrassCurve.ofJ_j P.shiftedJ

/-- The `j`-invariant of the constructed curve is not rational-integral. -/
theorem abcShiftedJCurve_j_not_integer (P : ABCPoint) :
    ¬ ∃ z : ℤ, (abcShiftedJCurve P).j = (z : ℚ) := by
  rw [abcShiftedJCurve_j]
  exact P.shiftedJ_not_integer

end IUTThreeClosures
