import ResidualReflectionArithmetic
import ActualGlobalSignedBridge

/-! Actual integer prime products, real logarithms, and the strict joint bill.
The ordinary proof precedes the implementation. Local depth allocation and
the global signed-bound premises remain explicit at their prior interfaces. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCActualResidualLogThreshold20260907
open ABCResidualReflection20260907
open ABCActualPrimeLogCompensation20260907
open ABCActualGlobalSignedBridge20260907
open scoped BigOperators

theorem prime_support_product_positive (C : Nat) : 0 < primeSupportProduct C := by
  apply Finset.prod_pos
  intro p hp
  exact (Nat.prime_of_mem_primeFactors hp).pos

theorem radical_zero_eq_log_support_product (C : Nat) :
    radical 0 C = Real.log (primeSupportProduct C) := by
  unfold primeSupportProduct radical
  rw [Nat.cast_prod, Real.log_prod]
  · apply Finset.sum_congr rfl
    intro p hp
    simp [weight, (Nat.prime_of_mem_primeFactors hp).pos]
  · intro p hp
    exact_mod_cast (Nat.prime_of_mem_primeFactors hp).ne_zero

theorem joint_log_small_iff_product_lt_power (n V V' : Nat) (hV : 0 < V)
    (hV' : 0 < V') :
    Real.log V + Real.log V' < (n : Real) * Real.log 7 ↔ V * V' < 7 ^ n := by
  have hv : (0 : Real) < V := by exact_mod_cast hV
  have hv' : (0 : Real) < V' := by exact_mod_cast hV'
  rw [← Real.log_mul (ne_of_gt hv) (ne_of_gt hv'), ← Real.log_pow]
  rw [Real.log_lt_log_iff (mul_pos hv hv') (by positivity)]
  exact_mod_cast Iff.rfl

theorem content_one_of_small_joint_log (n C V V' : Nat) (hC : C ≠ 0)
    (hV : 0 < V) (hV' : 0 < V') (hmin : ∀ p ∈ C.primeFactors, 7 ≤ p)
    (hbill : primeSupportProduct C ^ n ∣ V * V')
    (hsmall : Real.log V + Real.log V' < (n : Real) * Real.log 7) : C = 1 := by
  apply content_one_of_small_joint_product n C V V' hC
    (Nat.ne_of_gt hV) (Nat.ne_of_gt hV') hmin hbill
  exact (joint_log_small_iff_product_lt_power n V V' hV hV').mp hsmall

theorem actual_global_signed_eq_integer_log (N : Nat) :
    signedCost 0 N = Real.log N - 3 * Real.log (primeSupportProduct N) := by
  rw [signed_zero_cutoff, radical_zero_eq_log_support_product]

theorem global_log_radical_height_transfer (Y N : Nat) (t delta cost low : Real)
    (hlog : 3 * t - delta ≤ Real.log N) (htail : signedCost Y N ≤ cost)
    (hsmall : smallMass Y N ≤ low) :
    t - (delta + cost + low) / 3 ≤ Real.log (primeSupportProduct N) := by
  rw [← radical_zero_eq_log_support_product]
  exact global_radical_height_transfer Y N t delta cost low hlog htail hsmall

#print axioms prime_support_product_positive
#print axioms radical_zero_eq_log_support_product
#print axioms joint_log_small_iff_product_lt_power
#print axioms content_one_of_small_joint_log
#print axioms actual_global_signed_eq_integer_log
#print axioms global_log_radical_height_transfer
end ABCActualResidualLogThreshold20260907
