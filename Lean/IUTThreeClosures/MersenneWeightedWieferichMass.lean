/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneRadicalWieferichBarrier

/-!
# Quantitative barriers for the weighted Mersenne--Wieferich mass

This file isolates three facts needed when one tries to improve the exact
Mersenne LTE reduction by order grouping, a p-adic size estimate, or an
average argument.

* When the index multiplier is prime to `p`, *every* prime-power divisibility
  statement, not merely square divisibility, is already present at the first
  exponent.
* A divisibility estimate gives only the literal size budget
  `p^e ≤ 2^d - 1` (and hence `(d+1)^e ≤ 2^d - 1` when order information gives
  `d+1 ≤ p`).  It contains no sublinear saving by itself.
* The prime `1093` is a simple root of `X^364-1` modulo `1093`, although the
  fixed lift `X=2` makes the value divisible by `1093^2`.  Thus a derivative
  or discriminant test cannot delete the order-level Wieferich term.

The final definitions give a completely explicit divisibility-monotone spike
model.  Its paper-level normalized averages tend to zero, while its values at
powers of two have full size.  The Lean results here prove the algebraic spine
of that countermodel; no analytic average estimate and no abc-type bound is
assumed.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-! ## Full prime-power persistence at the first exponent -/

/-- With no index lifting, arbitrary prime-power divisibility at exponent
`d*k` is equivalent to the same divisibility at exponent `d`.  This extends
the square-only statement in the preceding module. -/
theorem prime_pow_dvd_two_pow_mul_sub_one_iff
    (p d k e : ℕ) (hp : p.Prime) (hpodd : Odd p)
    (hd : 0 < d) (hk : k ≠ 0)
    (hpd : p ∣ 2 ^ d - 1) (hpk : ¬ p ∣ k) :
    p ^ e ∣ 2 ^ (d * k) - 1 ↔ p ^ e ∣ 2 ^ d - 1 := by
  have hsmall : 2 ^ d - 1 ≠ 0 := by
    exact Nat.sub_ne_zero_of_lt (one_lt_pow₀ (by norm_num) hd.ne')
  have hdk : 0 < d * k := mul_pos hd (Nat.pos_of_ne_zero hk)
  have hlarge : 2 ^ (d * k) - 1 ≠ 0 := by
    exact Nat.sub_ne_zero_of_lt (one_lt_pow₀ (by norm_num) hdk.ne')
  rw [hp.pow_dvd_iff_le_factorization hlarge,
    hp.pow_dvd_iff_le_factorization hsmall,
    factorization_two_pow_mul_sub_one_of_not_dvd
      p d k hp hpodd hd hk hpd hpk]

/-! ## What the elementary p-adic size budget actually proves -/

/-- A prime-power divisor of a nonzero Mersenne block is at most the block.
This is the exact archimedean content of the most elementary p-adic-logarithm
bound. -/
theorem primePower_le_twoPow_sub_one_of_dvd
    (p d e : ℕ) (hd : 0 < d)
    (hpow : p ^ e ∣ 2 ^ d - 1) :
    p ^ e ≤ 2 ^ d - 1 := by
  exact Nat.le_of_dvd
    (Nat.sub_pos_of_lt (one_lt_pow₀ (by norm_num) hd.ne')) hpow

/-- Combining the order congruence lower bound `d+1 ≤ p` with divisibility
still gives only the literal exponential budget. -/
theorem orderLowerBound_pow_le_twoPow_sub_one
    (p d e : ℕ) (hd : 0 < d) (hdp : d + 1 ≤ p)
    (hpow : p ^ e ∣ 2 ^ d - 1) :
    (d + 1) ^ e ≤ 2 ^ d - 1 := by
  exact (Nat.pow_le_pow_left hdp e).trans
    (primePower_le_twoPow_sub_one_of_dvd p d e hd hpow)

/-! ## A simple modular root can have a square-valued fixed lift -/

/-- The derivative of `X^364-1` at `X=2` is nonzero modulo `1093`, even
though the value is zero modulo `1093^2`.  This is a strict, numerical
counterexample to using a simple-root/discriminant test as a squarefreeness
test for a fixed integer evaluation. -/
theorem wieferich_1093_simpleRoot_squareLift :
    1093 ^ 2 ∣ 2 ^ 364 - 1 ∧
      ¬ 1093 ∣ 364 * 2 ^ 363 := by
  refine ⟨wieferich_1093_sq_dvd_two_pow_364_sub_one, ?_⟩
  intro hdiv
  rcases prime_1093.dvd_mul.mp hdiv with h364 | hpow
  · exact wieferich_1093_not_dvd_exponent h364
  · exact (by norm_num : ¬ 1093 ∣ 2) (prime_1093.dvd_of_dvd_pow hpow)

/-! ## A divisibility-monotone spike model for the average/pointwise gap -/

/-- The largest power of two certified by the elementary `2`-adic valuation.
For positive inputs this is the usual exact power-of-two divisor. -/
def twoAdicDivisor (n : ℕ) : ℕ :=
  2 ^ padicValNat 2 n

/-- The model really is a divisor of its input. -/
theorem twoAdicDivisor_dvd (n : ℕ) :
    twoAdicDivisor n ∣ n := by
  exact pow_padicValNat_dvd

/-- The model is monotone along divisibility, just like an order-level mass
that persists at all multiples of its first exponent. -/
theorem twoAdicDivisor_mono_of_dvd
    {a b : ℕ} (hb : b ≠ 0) (hab : a ∣ b) :
    twoAdicDivisor a ≤ twoAdicDivisor b := by
  have hval : padicValNat 2 a ≤ padicValNat 2 b := by
    rw [← padicValNat_dvd_iff_le_of_ne_one (by norm_num) hb]
    exact (twoAdicDivisor_dvd a).trans hab
  exact Nat.pow_le_pow_right (by norm_num) hval

/-- Along the infinite power-of-two subsequence the monotone model has full
size. -/
@[simp]
theorem twoAdicDivisor_twoPow (k : ℕ) :
    twoAdicDivisor (2 ^ k) = 2 ^ k := by
  simp [twoAdicDivisor, padicValNat_base_pow (by norm_num : 1 < (2 : ℕ))]

/-- On `2^k*q` with `q` odd, the exact two-adic divisor is `2^k`.  This is
the decomposition used in the paper proof that the normalized Cesaro average
of the model tends to zero. -/
theorem twoAdicDivisor_twoPow_mul_odd
    (k q : ℕ) (hq : q ≠ 0) (hqodd : Odd q) :
    twoAdicDivisor (2 ^ k * q) = 2 ^ k := by
  have hqnot : ¬ 2 ∣ q := by
    rw [← even_iff_two_dvd, Nat.not_even_iff_odd]
    exact hqodd
  have hqval : padicValNat 2 q = 0 :=
    padicValNat.eq_zero_of_not_dvd hqnot
  simp [twoAdicDivisor,
    padicValNat_base_pow_mul (by norm_num : 1 < (2 : ℕ)) hq k,
    hqval]

/-- A finite delayed spike family: on positive inputs it vanishes before an
arbitrary threshold `N`, is full-sized at `N`, and is monotone under
divisibility. -/
def divisibilitySpike (N n : ℕ) : ℕ :=
  if N ∣ n then N else 0

@[simp]
theorem divisibilitySpike_self (N : ℕ) :
    divisibilitySpike N N = N := by
  simp [divisibilitySpike]

theorem divisibilitySpike_eq_zero_of_lt
    {N n : ℕ} (hnpos : 0 < n) (hn : n < N) :
    divisibilitySpike N n = 0 := by
  rw [divisibilitySpike, if_neg]
  intro hdiv
  exact (Nat.not_lt_of_ge (Nat.le_of_dvd hnpos hdiv)) hn

theorem divisibilitySpike_mono_of_dvd
    (N : ℕ) {a b : ℕ} (hab : a ∣ b) :
    divisibilitySpike N a ≤ divisibilitySpike N b := by
  unfold divisibilitySpike
  by_cases hNa : N ∣ a
  · have hNb : N ∣ b := hNa.trans hab
    simp [hNa, hNb]
  · simp [hNa]

/-! ## A finite certificate for the surviving first-order-block route -/

/-- The total mass carried by first-order blocks whose indices divide `m`.
For the paper application, `mass d` is `log E_d`. -/
def orderBlockMassSum (mass : ℕ → ℝ) (m : ℕ) : ℝ :=
  ∑ d ∈ m.divisors, mass d

/-- A uniform local bound costs exactly the number of divisors.  This is the
finite inequality behind the sufficient power-saving criterion; no
asymptotic divisor estimate is included as a hypothesis-free conclusion. -/
theorem orderBlockMassSum_le_card_mul
    (mass : ℕ → ℝ) (m : ℕ) (B : ℝ)
    (hlocal : ∀ d ∈ m.divisors, mass d ≤ B) :
    orderBlockMassSum mass m ≤ (m.divisors.card : ℝ) * B := by
  calc
    orderBlockMassSum mass m = ∑ d ∈ m.divisors, mass d := rfl
    _ ≤ ∑ _d ∈ m.divisors, B :=
      Finset.sum_le_sum fun d hd ↦ hlocal d hd
    _ = (m.divisors.card : ℝ) * B := by simp

/-- An explicit finite `epsilon` certificate.  To apply it one must prove
both the local block bound and the displayed divisor-count budget; neither is
stored in a structure or inferred from the desired endpoint estimate. -/
theorem orderBlockMassSum_le_epsilon_mul
    (mass : ℕ → ℝ) (m : ℕ) (B epsilon : ℝ)
    (hlocal : ∀ d ∈ m.divisors, mass d ≤ B)
    (hbudget : (m.divisors.card : ℝ) * B ≤ epsilon * m) :
    orderBlockMassSum mass m ≤ epsilon * m := by
  exact (orderBlockMassSum_le_card_mul mass m B hlocal).trans hbudget

end IUTThreeClosures
