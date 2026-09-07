import CommonExponentArithmetic

/-! The geometric-sum lower bound is proved here and connected to actual
common power representations. These results do not use prime-order or
valuation allocation and do not assert such representations exist. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCActualCommonExponentGap20260907
open ABCEisenstein20260905 ABCLocalPowerArithmetic20260907
open ABCCommonExponentArithmetic20260907

theorem nonnegative_power_monotone (x y : Int) (n : Nat)
    (hy : 0 ≤ y) (hyx : y ≤ x) : y^n ≤ x^n := by
  induction n with
  | zero => simp
  | succ n ih =>
    have hx : 0 ≤ x := by omega
    have h1 := Int.mul_nonneg (show 0 ≤ x-y by omega) (Int.pow_nonneg (m:=n) hx)
    have h2 := Int.mul_nonneg hy (show 0 ≤ x^n-y^n by omega)
    simp only [Int.pow_succ]
    grind

theorem homogeneous_sum_lower (x y : Int) (n : Nat)
    (hy : 0 ≤ y) (hyx : y ≤ x) :
    (n+1:Int)*y^n ≤ homogeneousSum x y (n+1) := by
  induction n with
  | zero => simp [homogeneousSum]
  | succ n ih =>
    have hp := nonnegative_power_monotone x y (n+1) hy hyx
    have hm := Int.mul_nonneg hy
      (show 0 ≤ homogeneousSum x y (n+1)-(n+1:Int)*y^n by omega)
    rw [homogeneousSum]
    simp only [Int.pow_succ] at hp ⊢
    grind

theorem actual_root_gap_positive (a b R Q : Int) (p : Nat)
    (ha : 0 < a) (hb : 0 < b) (hQ : 0 ≤ Q)
    (hM : norm (a,b) = R^p) (hF : second a b = Q^p) : R^2 < Q := by
  have hgt := actual_second_gt_first_square a b ha hb
  rw [hM, hF] at hgt
  have he : (R^2)^p = (R^p)^2 := by
    rw [← Int.pow_mul, ← Int.pow_mul, Nat.mul_comm 2 p]
  by_cases h : R^2 < Q
  · exact h
  · have hm := nonnegative_power_monotone (R^2) Q p hQ (by omega)
    rw [he] at hm
    omega

theorem actual_common_exponent_budget (a b R Q : Int) (n : Nat)
    (ha : 0 < a) (hb : 0 < b) (hR : 0 < R) (hQ : 0 ≤ Q)
    (hM : norm (a,b) = R^(n+1)) (hF : second a b = Q^(n+1)) :
    9*(n+1:Int)*(Q-R^2) ≤ 4*R^2 := by
  have hgap := actual_root_gap_positive a b R Q (n+1) ha hb hQ hM hF
  have hprod := actual_common_power_factorization a b R Q (n+1) hM hF
  have hlower := homogeneous_sum_lower Q (R^2) n (Int.sq_nonneg R) (by omega)
  have hU : 0 < (R^2)^n := Int.pow_pos (Int.pow_pos (m:=2) hR)
  have he : (norm (a,b))^2 = R^2*(R^2)^n := by
    rw [hM]
    have hn : (R^2)^n = (R^n)^2 := by
      rw [← Int.pow_mul, ← Int.pow_mul, Nat.mul_comm 2 n]
    rw [hn, Int.pow_succ]
    grind
  exact root_gap_budget a b (Q-R^2) (n+1) R
    (homogeneousSum Q (R^2) (n+1)) ((R^2)^n)
    (by omega) (by omega) (by omega) hU hprod hlower he

theorem actual_common_root_lower_bound (a b R Q : Int) (n : Nat)
    (ha : 0 < a) (hb : 0 < b) (hR : 0 < R) (hQ : 0 ≤ Q)
    (hM : norm (a,b) = R^(n+1)) (hF : second a b = Q^(n+1)) :
    9*(n+1:Int) ≤ 4*R^2 := by
  have hpos := actual_root_gap_positive a b R Q (n+1) ha hb hQ hM hF
  have hgap := actual_common_exponent_budget a b R Q n ha hb hR hQ hM hF
  exact root_gap_lower_bound (Q-R^2) (n+1) R (by omega) (by omega) hgap

#print axioms nonnegative_power_monotone
#print axioms homogeneous_sum_lower
#print axioms actual_root_gap_positive
#print axioms actual_common_exponent_budget
#print axioms actual_common_root_lower_bound
end ABCActualCommonExponentGap20260907
