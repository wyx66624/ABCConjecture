import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity

/-! Actual finite prime factorization and real logarithmic weights.
The ordinary finite argument precedes this implementation. No analytic
uniformity or arbitrary-root membership theorem is asserted. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCActualPrimeLogCompensation20260907
open scoped BigOperators

def weight (Y p : Nat) : Real := if Y < p then Real.log p else 0

def mass (Y N : Nat) : Real :=
  N.factorization.sum fun p e => (e : Real) * weight Y p

def radical (Y N : Nat) : Real := ∑ p ∈ N.primeFactors, weight Y p

def excess (h Y N : Nat) : Real :=
  N.factorization.sum fun p e => ((e-h : Nat) : Real) * weight Y p

def smallMass (Y N : Nat) : Real :=
  N.factorization.sum fun p e => (e : Real) * (if p ≤ Y then Real.log p else 0)

def signedCost (Y N : Nat) : Real := mass Y N - 3 * radical Y N

theorem prime_weight_nonnegative (Y p : Nat) (hp : p.Prime) : 0 ≤ weight Y p := by
  unfold weight
  split
  · exact Real.log_nonneg (by exact_mod_cast hp.one_le)
  · rfl

theorem mass_nonnegative (Y N : Nat) : 0 ≤ mass Y N := by
  unfold mass Finsupp.sum
  apply Finset.sum_nonneg
  intro p hp
  exact mul_nonneg (Nat.cast_nonneg _)
    (prime_weight_nonnegative Y p (Nat.prime_of_mem_primeFactors hp))

theorem small_mass_nonnegative (Y N : Nat) : 0 ≤ smallMass Y N := by
  unfold smallMass Finsupp.sum
  apply Finset.sum_nonneg
  intro p hp
  apply mul_nonneg (Nat.cast_nonneg _)
  split
  · exact Real.log_nonneg (by exact_mod_cast (Nat.prime_of_mem_primeFactors hp).one_le)
  · rfl

theorem mass_partition (Y N : Nat) : mass Y N + smallMass Y N = Real.log N := by
  rw [Real.log_nat_eq_sum_factorization]
  unfold mass smallMass Finsupp.sum
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro p hp
  unfold weight
  by_cases h : Y < p
  · simp [h, Nat.not_le.mpr h]
  · simp [h, Nat.le_of_not_gt h]

theorem mass_le_log (Y N : Nat) : mass Y N ≤ Real.log N := by
  have h := mass_partition Y N
  have hs := small_mass_nonnegative Y N
  linarith

theorem actual_depth_cap_budget (h Y N : Nat) :
    mass Y N ≤ (h : Real) * radical Y N + excess h Y N := by
  unfold mass radical excess Finsupp.sum
  simp only [Nat.support_factorization]
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_le_sum
  intro p hp
  have hn : N.factorization p ≤ h + (N.factorization p-h) := by omega
  have hr : (N.factorization p : Real) ≤ (h : Real) + ((N.factorization p-h : Nat) : Real) := by
    exact_mod_cast hn
  have hw := prime_weight_nonnegative Y p (Nat.prime_of_mem_primeFactors hp)
  nlinarith

theorem mass_mul (Y U V : Nat) (hU : U ≠ 0) (hV : V ≠ 0) :
    mass Y (U*V) = mass Y U + mass Y V := by
  unfold mass
  rw [Nat.factorization_mul hU hV]
  exact Finsupp.sum_add_index' (by intro p; simp)
    (by intro p a b; simp [Nat.cast_add, add_mul])

theorem radical_mul_coprime (Y U V : Nat) (hUV : U.Coprime V) :
    radical Y (U*V) = radical Y U + radical Y V := by
  unfold radical
  rw [hUV.primeFactors_mul, Finset.sum_union hUV.disjoint_primeFactors]

theorem signed_mul_coprime (Y U V : Nat) (hU : U ≠ 0) (hV : V ≠ 0)
    (hUV : U.Coprime V) :
    signedCost Y (U*V) = signedCost Y U + signedCost Y V := by
  unfold signedCost
  rw [mass_mul Y U V hU hV, radical_mul_coprime Y U V hUV]
  ring

theorem radical_mul_ge_right (Y U V : Nat) (hU : U ≠ 0) (hV : V ≠ 0) :
    radical Y V ≤ radical Y (U*V) := by
  unfold radical
  rw [Nat.primeFactors_mul hU hV]
  apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_union_right)
  intro p hp hn
  rcases Finset.mem_union.mp hp with h | h
  · exact prime_weight_nonnegative Y p (Nat.prime_of_mem_primeFactors h)
  · exact prime_weight_nonnegative Y p (Nat.prime_of_mem_primeFactors h)

theorem actual_overlap_budget (Y U V : Nat) (hU : U ≠ 0) (hV : V ≠ 0) :
    signedCost Y (U*V) ≤ signedCost Y V + Real.log U := by
  have hm := mass_mul Y U V hU hV
  have hr := radical_mul_ge_right Y U V hU hV
  have hl := mass_le_log Y U
  unfold signedCost
  linarith

theorem actual_three_factor_additivity (Y A B C : Nat)
    (hA : A ≠ 0) (hB : B ≠ 0) (hC : C ≠ 0)
    (hAB : A.Coprime B) (hAC : A.Coprime C) (hBC : B.Coprime C) :
    signedCost Y (A*B*C) = signedCost Y A + signedCost Y B + signedCost Y C := by
  rw [signed_mul_coprime Y (A*B) C (Nat.mul_ne_zero hA hB) hC
    (hAC.mul_left hBC), signed_mul_coprime Y A B hA hB hAB]

theorem actual_two_arm_prime_log_budget (Y A B C : Nat)
    (hA : A ≠ 0) (hB : B ≠ 0) (hC : C ≠ 0)
    (hAB : A.Coprime B) (hAC : A.Coprime C) (hBC : B.Coprime C) :
    signedCost Y (A*B*C) ≤ mass Y C - (mass Y A + mass Y B)/2 +
      3*(excess 2 Y A + excess 2 Y B)/2 - 3*radical Y C := by
  rw [actual_three_factor_additivity Y A B C hA hB hC hAB hAC hBC]
  have ha := actual_depth_cap_budget 2 Y A
  have hb := actual_depth_cap_budget 2 Y B
  norm_num at ha hb
  unfold signedCost
  linarith

theorem actual_two_arm_with_height_budget (Y A B C : Nat)
    (hA : A ≠ 0) (hB : B ≠ 0) (hC : C ≠ 0)
    (hAB : A.Coprime B) (hAC : A.Coprime C) (hBC : B.Coprime C)
    (t delta l₁ l₂ : Real) (h₃ : mass Y C ≤ t)
    (h₁ : t-delta-l₁ ≤ mass Y A) (h₂ : t-delta-l₂ ≤ mass Y B) :
    signedCost Y (A*B*C) ≤ delta+(l₁+l₂)/2 +
      3*(excess 2 Y A + excess 2 Y B)/2 - 3*radical Y C := by
  have h := actual_two_arm_prime_log_budget Y A B C hA hB hC hAB hAC hBC
  linarith

theorem actual_two_arm_with_old_factor (Y U A B C : Nat)
    (hU : U ≠ 0) (hA : A ≠ 0) (hB : B ≠ 0) (hC : C ≠ 0)
    (hAB : A.Coprime B) (hAC : A.Coprime C) (hBC : B.Coprime C)
    (t delta l₁ l₂ : Real) (h₃ : mass Y C ≤ t)
    (h₁ : t-delta-l₁ ≤ mass Y A) (h₂ : t-delta-l₂ ≤ mass Y B) :
    signedCost Y (U*(A*B*C)) ≤ delta+(l₁+l₂)/2+Real.log U +
      3*(excess 2 Y A + excess 2 Y B)/2 - 3*radical Y C := by
  have hp : A*B*C ≠ 0 := Nat.mul_ne_zero (Nat.mul_ne_zero hA hB) hC
  have ho := actual_overlap_budget Y U (A*B*C) hU hp
  have hc := actual_two_arm_with_height_budget Y A B C hA hB hC hAB hAC hBC
    t delta l₁ l₂ h₃ h₁ h₂
  linarith

theorem excess_zero_of_actual_cap (h Y N : Nat)
    (hc : ∀ p ∈ N.primeFactors, Y < p → N.factorization p ≤ h) :
    excess h Y N = 0 := by
  unfold excess Finsupp.sum
  apply Finset.sum_eq_zero
  intro p hp
  by_cases hy : Y < p
  · have he : N.factorization p-h=0 := Nat.sub_eq_zero_of_le (hc p hp hy)
    simp [he]
  · simp [weight,hy]

theorem actual_one_squarefree_prime_log_budget (Y A B C : Nat)
    (hA : A ≠ 0) (hB : B ≠ 0) (hC : C ≠ 0)
    (hAB : A.Coprime B) (hAC : A.Coprime C) (hBC : B.Coprime C)
    (hcap : ∀ p ∈ A.primeFactors, Y < p → A.factorization p ≤ 1)
    (t delta l₁ : Real) (h₁ : t-delta-l₁ ≤ mass Y A)
    (h₂ : mass Y B ≤ t) (h₃ : mass Y C ≤ t) :
    signedCost Y (A*B*C) ≤ 2*delta+2*l₁-3*(radical Y B+radical Y C) := by
  have he := excess_zero_of_actual_cap 1 Y A hcap
  have hb := actual_depth_cap_budget 1 Y A
  norm_num [he] at hb
  rw [actual_three_factor_additivity Y A B C hA hB hC hAB hAC hBC]
  unfold signedCost
  linarith

#print axioms prime_weight_nonnegative
#print axioms mass_nonnegative
#print axioms small_mass_nonnegative
#print axioms mass_partition
#print axioms mass_le_log
#print axioms actual_depth_cap_budget
#print axioms mass_mul
#print axioms radical_mul_coprime
#print axioms signed_mul_coprime
#print axioms radical_mul_ge_right
#print axioms actual_overlap_budget
#print axioms actual_three_factor_additivity
#print axioms actual_two_arm_prime_log_budget
#print axioms actual_two_arm_with_height_budget
#print axioms actual_two_arm_with_old_factor
#print axioms excess_zero_of_actual_cap
#print axioms actual_one_squarefree_prime_log_budget

end ABCActualPrimeLogCompensation20260907
