import LocalPowerArithmetic

/-! Integer algebra of the reviewed common-exponent compatibility argument.
The actual first and second norms are imported from the existing repository.
Prime orders, full valuation allocation, and the existence of a common power
representation are not assumed implicitly or formalized by these identities.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCCommonExponentArithmetic20260907
open ABCEisenstein20260905 ABCLocalPowerArithmetic20260907

theorem actual_norm_difference (a b : Int) :
    second a b - (norm (a,b))^2 = a*b*(a+b)^2 := by
  dsimp [second, norm]
  grind

theorem actual_four_ninths_certificate (a b : Int) :
    4*(norm (a,b))^2 - 9*a*b*(a+b)^2 =
      (a-b)^2*(4*a^2+7*a*b+4*b^2) := by
  dsimp [norm]
  grind

theorem actual_four_ninths_bound (a b : Int) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    9*a*b*(a+b)^2 ≤ 4*(norm (a,b))^2 := by
  have ha2 := Int.sq_nonneg a
  have hb2 := Int.sq_nonneg b
  have hab := Int.mul_nonneg ha hb
  have hpoly : 0 ≤ 4*a^2+7*a*b+4*b^2 := by grind
  have hprod := Int.mul_nonneg (Int.sq_nonneg (a-b)) hpoly
  have hid := actual_four_ninths_certificate a b
  omega

theorem actual_first_norm_lt_sum_square (a b : Int) (ha : 0 < a) (hb : 0 < b) :
    norm (a,b) < (a+b)^2 := by
  have hab := Int.mul_pos ha hb
  dsimp [norm]
  grind

theorem actual_second_gt_first_square (a b : Int) (ha : 0 < a) (hb : 0 < b) :
    (norm (a,b))^2 < second a b := by
  have hab := Int.mul_pos ha hb
  have hc : 0 < (a+b)*(a+b) := Int.mul_pos (by omega) (by omega)
  have hp := Int.mul_pos hab hc
  have hid := actual_norm_difference a b
  grind

def homogeneousSum (x y : Int) : Nat → Int
  | 0 => 0
  | n+1 => x^n + y*homogeneousSum x y n

theorem homogeneous_factorization (x y : Int) (n : Nat) :
    (x-y)*homogeneousSum x y n = x^n-y^n := by
  induction n with
  | zero => simp [homogeneousSum]
  | succ n ih =>
    simp only [homogeneousSum, Int.pow_succ]
    grind

theorem actual_common_power_factorization (a b R Q : Int) (p : Nat)
    (hM : norm (a,b) = R^p) (hF : second a b = Q^p) :
    (Q-R^2)*homogeneousSum Q (R^2) p = a*b*(a+b)^2 := by
  have hid := actual_norm_difference a b
  rw [hM, hF] at hid
  have he : (R^2)^p = (R^p)^2 := by
    rw [← Int.pow_mul, ← Int.pow_mul, Nat.mul_comm 2 p]
  rw [homogeneous_factorization, he]
  exact hid

/-- Explicit arithmetic interface after a lower bound for the geometric sum.
The hypotheses `hS` and `hM` are visible formal obligations, not hidden
prime-order or valuation conclusions. -/
theorem root_gap_budget (a b D p R S U : Int)
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hD : 0 ≤ D) (hU : 0 < U)
    (hprod : D*S = a*b*(a+b)^2)
    (hS : p*U ≤ S) (hM : (norm (a,b))^2 = R^2*U) :
    9*p*D ≤ 4*R^2 := by
  have hbound := actual_four_ninths_bound a b ha hb
  have hmul := Int.mul_nonneg hD (show 0 ≤ S-p*U by omega)
  by_cases h : 9*p*D ≤ 4*R^2
  · exact h
  · have hpos := Int.mul_pos (show 0 < 9*p*D-4*R^2 by omega) hU
    grind

theorem root_gap_lower_bound (D p R : Int) (hp : 0 ≤ p)
    (hD : 1 ≤ D) (hgap : 9*p*D ≤ 4*R^2) : 9*p ≤ 4*R^2 := by
  have hmul := Int.mul_nonneg hp (show 0 ≤ D-1 by omega)
  grind

/-- The bad-part divisibility theorem remains an explicit antecedent.
This statement transfers it to the squared size estimate without logarithms. -/
theorem bad_part_square_budget (C p D R : Int)
    (hbad : C^2 ≤ p*D) (hgap : 9*p*D ≤ 4*R^2) : 9*C^2 ≤ 4*R^2 := by
  grind

#print axioms actual_norm_difference
#print axioms actual_four_ninths_certificate
#print axioms actual_four_ninths_bound
#print axioms actual_first_norm_lt_sum_square
#print axioms actual_second_gt_first_square
#print axioms homogeneous_factorization
#print axioms actual_common_power_factorization
#print axioms root_gap_budget
#print axioms root_gap_lower_bound
#print axioms bad_part_square_budget
end ABCCommonExponentArithmetic20260907
