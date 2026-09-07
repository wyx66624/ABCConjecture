import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Data.Nat.GCD.BigOperators
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-! A reflected local depth law gives an actual radical divisibility bill.
The local depth law is explicit. Its oriented-factorization origin is not
postulated as an axiom or silently treated as a formal theorem. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
namespace ABCResidualReflection20260907
open scoped BigOperators

def primeSupportProduct (C : Nat) : Nat := ∏ p ∈ C.primeFactors, p

theorem positive_integer_multiple_lower (n k : Int) (hn : 0 < n) (h : 0 < n * k) :
    n ≤ n * k := by
  have hk : 1 ≤ k := by nlinarith
  nlinarith

theorem reflected_depth_budget (n a f b r : Int) (hn : 0 < n) (ha : 0 < a)
    (hf : 0 < f) (hb : 0 ≤ b) (_hr : 0 ≤ r) (h : |a - n * f| = b + n * r) :
    n ≤ a + b := by
  by_cases han : n ≤ a
  · omega
  · have hf1 : 1 ≤ f := by omega
    have hsign : a - n * f ≤ 0 := by nlinarith
    rw [abs_of_nonpos hsign] at h
    have heq : n * (f - r) = a + b := by nlinarith
    have hpos : 0 < n * (f - r) := by rw [heq]; omega
    have hbound := positive_integer_multiple_lower n (f - r) hn hpos
    omega

theorem reflected_natural_depth_budget (n a f b r : Nat) (hn : 0 < n) (ha : 0 < a)
    (hf : 0 < f) (h : |(a : Int) - (n : Int) * f| = (b : Int) + (n : Int) * r) :
    n ≤ a + b := by
  have result := reflected_depth_budget n a f b r
    (by exact_mod_cast hn) (by exact_mod_cast ha) (by exact_mod_cast hf)
    (by positivity) (by positivity) h
  exact_mod_cast result

theorem sharp_local_reflection (n : Nat) (hn : 2 ≤ n) :
    |(1 : Int) - (n : Int) * 1| = ((n - 1 : Nat) : Int) + (n : Int) * 0 ∧
    1 + (n - 1) = n := by
  have hs : (1 : Int) - n * 1 ≤ 0 := by omega
  rw [abs_of_nonpos hs]
  constructor <;> omega

theorem distinct_prime_product_power_dvd (S : Finset Nat) (n N : Nat)
    (hp : ∀ p ∈ S, Nat.Prime p) (hd : ∀ p ∈ S, p ^ n ∣ N) :
    (∏ p ∈ S, p) ^ n ∣ N := by
  induction S using Finset.induction_on with
  | empty => simp
  | @insert p S hnot ih =>
    have hprime : Nat.Prime p := hp p (Finset.mem_insert_self p S)
    have hcop : Nat.Coprime (p ^ n) ((∏ q ∈ S, q) ^ n) := by
      apply Nat.Coprime.pow
      apply Nat.coprime_prod_right_iff.mpr
      intro q hq
      apply (Nat.coprime_primes hprime (hp q (Finset.mem_insert_of_mem hq))).mpr
      intro heq
      exact hnot (heq ▸ hq)
    rw [Finset.prod_insert hnot, mul_pow]
    apply hcop.mul_dvd_of_dvd_of_dvd
    · exact hd p (Finset.mem_insert_self p S)
    · apply ih
      · intro q hq
        exact hp q (Finset.mem_insert_of_mem hq)
      · intro q hq
        exact hd q (Finset.mem_insert_of_mem hq)

theorem actual_reflected_support_bill (n C V V' R R' : Nat) (hn : 0 < n)
    (hV : V ≠ 0) (hV' : V' ≠ 0)
    (hdepth : ∀ p ∈ C.primeFactors, 0 < V.factorization p ∧ 0 < R.factorization p ∧
      |(V.factorization p : Int) - (n : Int) * R.factorization p| =
        (V'.factorization p : Int) + (n : Int) * R'.factorization p) :
    primeSupportProduct C ^ n ∣ V * V' := by
  apply distinct_prime_product_power_dvd
  · exact fun p hp ↦ Nat.prime_of_mem_primeFactors hp
  · intro p hp
    have hprime := Nat.prime_of_mem_primeFactors hp
    have hd := hdepth p hp
    apply (hprime.pow_dvd_iff_le_factorization (Nat.mul_ne_zero hV hV')).mpr
    rw [Nat.factorization_mul hV hV']
    exact reflected_natural_depth_budget n _ _ _ _ hn hd.1 hd.2.1 hd.2.2

theorem content_one_of_small_joint_product (n C V V' : Nat) (hC : C ≠ 0)
    (hV : V ≠ 0) (hV' : V' ≠ 0)
    (hmin : ∀ p ∈ C.primeFactors, 7 ≤ p)
    (hbill : primeSupportProduct C ^ n ∣ V * V') (hsmall : V * V' < 7 ^ n) : C = 1 := by
  by_contra hne
  obtain ⟨p, hp, hpd⟩ := Nat.exists_prime_and_dvd hne
  have hmem : p ∈ C.primeFactors := Nat.mem_primeFactors.mpr ⟨hp, hpd, hC⟩
  have hprad : p ∣ primeSupportProduct C := Finset.dvd_prod_of_mem (fun q ↦ q) hmem
  have hpN : p ^ n ∣ V * V' := (pow_dvd_pow_of_dvd hprad n).trans hbill
  have hupper := Nat.le_of_dvd (Nat.mul_pos (Nat.pos_of_ne_zero hV)
    (Nat.pos_of_ne_zero hV')) hpN
  have hlower : 7 ^ n ≤ p ^ n := Nat.pow_le_pow_left (hmin p hmem) n
  omega

#print axioms positive_integer_multiple_lower
#print axioms reflected_depth_budget
#print axioms reflected_natural_depth_budget
#print axioms sharp_local_reflection
#print axioms distinct_prime_product_power_dvd
#print axioms actual_reflected_support_bill
#print axioms content_one_of_small_joint_product
end ABCResidualReflection20260907
