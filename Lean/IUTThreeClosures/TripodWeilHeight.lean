import Heights.WeilHeight
import IUTThreeClosures.LegendreArithmetic

/-!
# The actual Weil height of the tripod coordinate

For an abc point `P`, the rational coordinate `λ = a/c` is already in lowest
terms and satisfies `0 < a < c`.  Hence its absolute logarithmic Weil height is
exactly `log c`, which is the elementary height used in `ABCConjecture`.

This removes another freely chosen function from the downstream bridge: the
tripod height is the existing `Heights.normalizedLogHeight ℚ P.lambda`, not an
arbitrary real-valued field.  The same exact identity holds for `1 - λ = b/c`.
-/

namespace IUTThreeClosures

namespace ABCPoint

/-- The reduced numerator of `λ = a/c` is `a`. -/
theorem lambda_num (P : ABCPoint) :
    P.lambda.num = (P.a : ℤ) := by
  have hb : 0 < (P.c : ℤ) := by exact_mod_cast P.c_pos
  have hcop : Nat.Coprime (P.a : ℤ).natAbs (P.c : ℤ).natAbs := by
    simpa using P.coprime_a_c
  have h := Rat.num_div_eq_of_coprime
    (a := (P.a : ℤ)) (b := (P.c : ℤ)) hb hcop
  simpa [ABCPoint.lambda] using h

/-- The reduced denominator of `λ = a/c` is `c`. -/
theorem lambda_den (P : ABCPoint) :
    P.lambda.den = P.c := by
  have hb : 0 < (P.c : ℤ) := by exact_mod_cast P.c_pos
  have hcop : Nat.Coprime (P.a : ℤ).natAbs (P.c : ℤ).natAbs := by
    simpa using P.coprime_a_c
  have h := Rat.den_div_eq_of_coprime
    (a := (P.a : ℤ)) (b := (P.c : ℤ)) hb hcop
  have h' : (P.lambda.den : ℤ) = (P.c : ℤ) := by
    simpa [ABCPoint.lambda] using h
  exact_mod_cast h'

/-- The actual absolute logarithmic Weil height of `λ` is the abc height. -/
theorem normalizedLogHeight_lambda (P : ABCPoint) :
    Heights.normalizedLogHeight ℚ P.lambda = P.height := by
  rw [Heights.normalizedLogHeight_rat, P.lambda_num, P.lambda_den]
  simp only [Int.natAbs_natCast]
  rw [max_eq_right (Nat.le_of_lt P.a_lt_c)]
  exact P.height_eq_log_c.symm

/-- The reduced numerator of `1 - λ = b/c` is `b`. -/
theorem one_sub_lambda_num (P : ABCPoint) :
    (1 - P.lambda).num = (P.b : ℤ) := by
  have hc : 0 < (P.c : ℤ) := by exact_mod_cast P.c_pos
  have hcop : Nat.Coprime (P.b : ℤ).natAbs (P.c : ℤ).natAbs := by
    simpa using P.pairwise_coprime.2.1
  have h := Rat.num_div_eq_of_coprime
    (a := (P.b : ℤ)) (b := (P.c : ℤ)) hc hcop
  rw [P.one_sub_lambda_eq_b_div_c]
  simpa using h

/-- The reduced denominator of `1 - λ = b/c` is `c`. -/
theorem one_sub_lambda_den (P : ABCPoint) :
    (1 - P.lambda).den = P.c := by
  have hc : 0 < (P.c : ℤ) := by exact_mod_cast P.c_pos
  have hcop : Nat.Coprime (P.b : ℤ).natAbs (P.c : ℤ).natAbs := by
    simpa using P.pairwise_coprime.2.1
  have h := Rat.den_div_eq_of_coprime
    (a := (P.b : ℤ)) (b := (P.c : ℤ)) hc hcop
  have h' : ((1 - P.lambda).den : ℤ) = (P.c : ℤ) := by
    rw [P.one_sub_lambda_eq_b_div_c]
    simpa using h
  exact_mod_cast h'

/-- The actual Weil height of `1 - λ` is also the abc height. -/
theorem normalizedLogHeight_one_sub_lambda (P : ABCPoint) :
    Heights.normalizedLogHeight ℚ (1 - P.lambda) = P.height := by
  rw [Heights.normalizedLogHeight_rat,
    P.one_sub_lambda_num, P.one_sub_lambda_den]
  simp only [Int.natAbs_natCast]
  rw [max_eq_right (Nat.le_of_lt P.b_lt_c)]
  exact P.height_eq_log_c.symm

end ABCPoint

/-- The canonical tripod height used by the source-derived bridge. -/
noncomputable def tripodWeilHeight (P : ABCPoint) : ℝ :=
  Heights.normalizedLogHeight ℚ P.lambda

/-- The canonical tripod height is exactly the target abc height. -/
theorem tripodWeilHeight_eq_height (P : ABCPoint) :
    tripodWeilHeight P = P.height :=
  P.normalizedLogHeight_lambda

end IUTThreeClosures