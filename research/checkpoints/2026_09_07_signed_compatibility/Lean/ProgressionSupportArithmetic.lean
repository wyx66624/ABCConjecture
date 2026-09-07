import ActualCommonExponentGap

/-! Elementary assembly for the independently reviewed PP/EP support
arguments. Rank divisibility and progression-part budgets remain explicit
premises. No prime allocation, real mass theorem or ABC claim is asserted. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCProgressionSupportArithmetic20260907
open ABCEisenstein20260905

theorem odd_rank_one (n q d : Int) (hn : n%2=1) (hd : 0 < d)
    (hnq : n ∣ q-1) (hdn : d ∣ n) (hdq : d ∣ q+1) : d=1 := by
  have hdm : d ∣ q-1 := Int.dvd_trans hdn hnq
  have ht : d ∣ 2 := by
    have hs := Int.dvd_sub hdq hdm
    have he : q+1-(q-1)=2 := by omega
    rw [he] at hs
    exact hs
  have hle := Int.le_of_dvd (show (0:Int)<2 by omega) ht
  by_cases h : d=2
  · rw [h] at hdn
    have hz := Int.emod_eq_zero_of_dvd hdn
    omega
  · omega

theorem first_arm_height_identity (x y : Int) :
    4*norm (x,y)-3*x^2=(x+2*y)^2 := by
  dsimp [norm]
  grind

theorem first_arm_height_bound (x y : Int) : 3*x^2 ≤ 4*norm (x,y) := by
  have hi := first_arm_height_identity x y
  have hs := Int.sq_nonneg (x+2*y)
  omega

theorem sum_arm_height_bound (x y : Int) : 3*(x+y)^2 ≤ 4*norm (x,y) := by
  have hi := norm_height_identity x y
  have hs := Int.sq_nonneg (x-y)
  omega

theorem support_product_budget (B J U R : Int)
    (hB : 9*B^2 ≤ 4*U) (hJ : 3*J^2 ≤ 4*R) :
    27*(B*J)^2 ≤ 16*U*R := by
  have hb := Int.sq_nonneg B
  have hj := Int.sq_nonneg J
  have hu : 0 ≤ U := by omega
  have h1 := Int.mul_nonneg (show 0 ≤ 4*U-9*B^2 by omega)
    (show 0 ≤ 3*J^2 by omega)
  have h2 := Int.mul_nonneg (show 0 ≤ 4*U by omega)
    (show 0 ≤ 4*R-3*J^2 by omega)
  grind

theorem support_power_product_budget (B J K R : Int) (e : Nat)
    (hB : 9*B^2 ≤ 4*K*R^e) (hJ : 3*J^2 ≤ 4*R) :
    27*(B*J)^2 ≤ 16*K*R^(e+1) := by
  have h := support_product_budget B J (K*R^e) R (by grind) hJ
  simpa only [Int.pow_succ R e, Int.mul_assoc] using h

theorem progression_part_nontrivial (G K N R : Int) (k : Nat)
    (hR : 1 ≤ R) (hK : 0 < K) (hKN : K ≤ N)
    (hroot : 9*N ≤ 4*R^2)
    (hgood : 27*R^(k+2) < 16*K*G^2) : 1 < G^2 := by
  have hpAll : ∀ j : Nat, 1 ≤ R^j := by
    intro j
    induction j with
    | zero => simp
    | succ j ih =>
      have hm := Int.mul_nonneg (show 0 ≤ R-1 by omega)
        (show 0 ≤ R^j by omega)
      rw [Int.pow_succ R j]
      generalize R^j=v at *
      grind
  have hp := hpAll k
  have hs := Int.sq_nonneg R
  have hm := Int.mul_nonneg (show 0 ≤ R^k-1 by omega) hs
  have he : R^(k+2)=R^k*R^2 := by
    exact Int.pow_add _ _ _
  rw [he] at hgood
  by_cases h : 1 < G^2
  · exact h
  · have ht := Int.mul_nonneg (show 0 ≤ K by omega)
      (show 0 ≤ 1-G^2 by omega)
    generalize R^k=v at *
    grind

#print axioms odd_rank_one
#print axioms first_arm_height_identity
#print axioms first_arm_height_bound
#print axioms sum_arm_height_bound
#print axioms support_product_budget
#print axioms support_power_product_budget
#print axioms progression_part_nontrivial
end ABCProgressionSupportArithmetic20260907
