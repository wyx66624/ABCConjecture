import Mathlib.NumberTheory.LucasPrimality
import Mathlib.Data.Nat.Sqrt
import Mathlib.RingTheory.Fintype

namespace IUTThreeClosures

/-!
# A partial Lucas--Pocklington primality criterion

The theorem below is deliberately certificate-oriented.  `F` need only be a
known factor of `n - 1`, rather than all of `n - 1`.  The unit hypotheses are
the `ZMod n` form of the usual coprimality checks

`gcd (a ^ ((n - 1) / q) - 1) n = 1`.

No primality assumption on `n` is used to interpret those checks.
-/

/-- If `x ^ N = 1`, `F ∣ N`, and the Lucas quotient power is nontrivial for
every prime divisor of `F`, then `F` divides the order of `x`.

This is the group-theoretic core of the partial Pocklington criterion. -/
theorem factor_dvd_orderOf_of_pow_eq_one
    {M : Type*} [Monoid M] (x : M) {N F : ℕ}
    (hFN : F ∣ N) (hx : x ^ N = 1)
    (hquot : ∀ q : ℕ, q.Prime → q ∣ F → x ^ (N / q) ≠ 1) :
    F ∣ orderOf x := by
  have hordN : orderOf x ∣ N := orderOf_dvd_of_pow_eq_one hx
  have hfactor : orderOf x * (N / orderOf x) = N := Nat.mul_div_cancel' hordN
  have hcop : Nat.Coprime F (N / orderOf x) := by
    apply Nat.coprime_of_dvd
    intro q hq hqF hqcofactor
    have hqN : q ∣ N := hqF.trans hFN
    have hordqN : orderOf x * q ∣ N := by
      rw [← hfactor]
      exact Nat.mul_dvd_mul_left (orderOf x) hqcofactor
    have hord_div : orderOf x ∣ N / q := by
      apply (Nat.dvd_div_iff_mul_dvd hqN).2
      simpa [Nat.mul_comm] using hordqN
    exact hquot q hq hqF ((orderOf_dvd_iff_pow_eq_one).1 hord_div)
  apply hcop.dvd_of_dvd_mul_right
  rw [hfactor]
  exact hFN

/-- Partial Lucas--Pocklington criterion, phrased entirely inside `ZMod n`.

The `IsUnit` assumptions are exactly what survives after mapping the
certificate to every divisor `m ∣ n`: a unit cannot map to zero. -/
theorem pocklington_primality
    (n F : ℕ) (a : ZMod n)
    (hn : 1 < n) (hFN : F ∣ n - 1) (hlarge : n < F ^ 2)
    (hpow : a ^ (n - 1) = 1)
    (hunit : ∀ q : ℕ, q.Prime → q ∣ F → IsUnit (a ^ ((n - 1) / q) - 1)) :
    n.Prime := by
  rw [Nat.prime_def_le_sqrt]
  refine ⟨Nat.succ_le_iff.2 hn, ?_⟩
  intro m hm hm_sqrt hmn
  have hm1 : 1 < m := Nat.succ_le_iff.1 hm
  letI : Nontrivial (ZMod m) := ZMod.nontrivial_iff.mpr hm1.ne'
  let f : ZMod n →+* ZMod m := ZMod.castHom hmn (ZMod m)
  let b : ZMod m := f a
  have hpow_m : b ^ (n - 1) = 1 := by
    change (f a) ^ (n - 1) = 1
    rw [← map_pow, hpow, map_one]
  have hquot_m : ∀ q : ℕ, q.Prime → q ∣ F → b ^ ((n - 1) / q) ≠ 1 := by
    intro q hq hqF heq
    have hu : IsUnit (f (a ^ ((n - 1) / q) - 1)) :=
      (hunit q hq hqF).map f
    have hz : f (a ^ ((n - 1) / q) - 1) = 0 := by
      rw [map_sub, map_pow, heq, map_one, sub_self]
    rw [hz] at hu
    exact not_isUnit_zero hu
  have hForder : F ∣ orderOf b :=
    factor_dvd_orderOf_of_pow_eq_one b hFN hpow_m hquot_m
  have horder_pos : 0 < orderOf b :=
    Nat.pos_of_dvd_of_pos (orderOf_dvd_of_pow_eq_one hpow_m) (tsub_pos_of_lt hn)
  have hFm : F < m :=
    (Nat.le_of_dvd horder_pos hForder).trans_lt (ZMod.orderOf_lt hm1 b)
  have hsqrtF : Nat.sqrt n < F := Nat.sqrt_lt'.2 hlarge
  omega

/-- A small smoke test which genuinely uses only a partial factor:
`F = 4` divides `13 - 1`, while the remaining cofactor is `3`. -/
example : Nat.Prime 13 := by
  apply pocklington_primality 13 4 (2 : ZMod 13)
  · norm_num
  · norm_num
  · norm_num
  · decide
  · intro q hq hq4
    have hqle : q ≤ 4 := Nat.le_of_dvd (by norm_num) hq4
    have hqge : 2 ≤ q := hq.two_le
    have hqeq : q = 2 := by
      interval_cases q
      · rfl
      · norm_num at hq4
      · exact ((by decide : ¬ Nat.Prime 4) hq).elim
    subst q
    decide

#print axioms factor_dvd_orderOf_of_pow_eq_one
#print axioms pocklington_primality

end IUTThreeClosures
