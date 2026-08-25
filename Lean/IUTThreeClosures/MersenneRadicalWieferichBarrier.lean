/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArithmeticLeibnizWronskian
import Mathlib.NumberTheory.Multiplicity

/-!
# The Mersenne radical and the Wieferich barrier

This file records the exact elementary arithmetic behind attempts to handle
the endpoint triples `(1, 2^m - 1, 2^m)` by a separate radical estimate.

The useful positive result is an LTE identity: after a prime first appears in
`2^d - 1`, its multiplicity in `2^(d*k) - 1` is the original multiplicity
plus the multiplicity of the index `k`.  Thus, when `p ∤ k`, a square at
the larger exponent is already a square at the first exponent.  This is the
precise place where base-two Wieferich primes enter.

The numerical prime `1093` gives a strict obstruction to deleting this term:
`1093^2` divides `2^364 - 1`, although `1093` does not divide the exponent;
the displayed modular checks isolate order `364` on paper.  No radical lower
bound, abc estimate, or finiteness assertion about Wieferich primes is assumed.
-/

namespace IUTThreeClosures

/-! ## Exact radical loss -/

/-- The part of a Mersenne number left after one copy of every prime divisor
has been removed. -/
def mersennePowerLoss (m : ℕ) : ℕ :=
  abcPowerfulPart (2 ^ m - 1)

/-- The Mersenne radical and its exact power loss recover the number. -/
theorem mersenneRadical_mul_powerLoss (m : ℕ) :
    abcRadical (2 ^ m - 1) * mersennePowerLoss m = 2 ^ m - 1 := by
  exact abcRadical_mul_abcPowerfulPart (2 ^ m - 1)

/-- Bounding the powerful loss is exactly the corresponding multiplicative
lower bound for the radical; this is an equivalence, not an assumed estimate. -/
theorem mersennePowerLoss_le_iff
    (m K : ℕ) :
    mersennePowerLoss m ≤ K ↔
      2 ^ m - 1 ≤ abcRadical (2 ^ m - 1) * K := by
  constructor
  · intro h
    calc
      2 ^ m - 1 = abcRadical (2 ^ m - 1) * mersennePowerLoss m :=
        (mersenneRadical_mul_powerLoss m).symm
      _ ≤ abcRadical (2 ^ m - 1) * K := Nat.mul_le_mul_left _ h
  · intro h
    have hmul :
        abcRadical (2 ^ m - 1) * mersennePowerLoss m ≤
          abcRadical (2 ^ m - 1) * K := by
      calc
        abcRadical (2 ^ m - 1) * mersennePowerLoss m = 2 ^ m - 1 :=
          mersenneRadical_mul_powerLoss m
        _ ≤ abcRadical (2 ^ m - 1) * K := h
    exact le_of_mul_le_mul_left hmul (abcRadical_pos _)

/-! ## Exact LTE splitting -/

/-- LTE for a prime divisor of a Mersenne block.  The first term is the
order-level multiplicity; the second is the entire loss caused by enlarging
the exponent from `d` to `d*k`. -/
theorem padicValNat_two_pow_mul_sub_one
    (p d k : ℕ) (hp : p.Prime) (hpodd : Odd p)
    (hd : 0 < d) (hk : k ≠ 0)
    (hpd : p ∣ 2 ^ d - 1) :
    padicValNat p (2 ^ (d * k) - 1) =
      padicValNat p (2 ^ d - 1) + padicValNat p k := by
  letI : Fact p.Prime := ⟨hp⟩
  have hpneTwo : p ≠ 2 := by
    intro h
    subst p
    norm_num at hpodd
  have hpNotDvdTwo : ¬ p ∣ 2 := by
    intro h
    have hple : p ≤ 2 := Nat.le_of_dvd (by norm_num) h
    have hpge : 2 ≤ p := hp.two_le
    exact hpneTwo (Nat.le_antisymm hple hpge)
  have hpNotDvdPow : ¬ p ∣ 2 ^ d := by
    intro h
    exact hpNotDvdTwo (hp.dvd_of_dvd_pow h)
  have hpow : 1 < 2 ^ d := one_lt_pow₀ (by norm_num) hd.ne'
  have h := padicValNat.pow_sub_pow (p := p) hpodd hpow hpd
    hpNotDvdPow hk
  simpa [pow_mul] using h

/-- The same LTE statement expressed directly in prime-factorization
coordinates. -/
theorem factorization_two_pow_mul_sub_one
    (p d k : ℕ) (hp : p.Prime) (hpodd : Odd p)
    (hd : 0 < d) (hk : k ≠ 0)
    (hpd : p ∣ 2 ^ d - 1) :
    (2 ^ (d * k) - 1).factorization p =
      (2 ^ d - 1).factorization p + k.factorization p := by
  simp only [Nat.factorization_def _ hp]
  exact padicValNat_two_pow_mul_sub_one p d k hp hpodd hd hk hpd

/-- If the prime does not divide the exponent multiplier, enlarging the
exponent creates no additional copy of that prime. -/
theorem factorization_two_pow_mul_sub_one_of_not_dvd
    (p d k : ℕ) (hp : p.Prime) (hpodd : Odd p)
    (hd : 0 < d) (hk : k ≠ 0)
    (hpd : p ∣ 2 ^ d - 1) (hpk : ¬ p ∣ k) :
    (2 ^ (d * k) - 1).factorization p =
      (2 ^ d - 1).factorization p := by
  have hkfac : k.factorization p = 0 := by
    rw [Nat.factorization_def _ hp, padicValNat.eq_zero_of_not_dvd hpk]
  rw [factorization_two_pow_mul_sub_one p d k hp hpodd hd hk hpd,
    hkfac, add_zero]

/-- With no index lifting, square divisibility at exponent `d*k` is exactly
the order-level square divisibility at exponent `d`. -/
theorem prime_sq_dvd_two_pow_mul_sub_one_iff
    (p d k : ℕ) (hp : p.Prime) (hpodd : Odd p)
    (hd : 0 < d) (hk : k ≠ 0)
    (hpd : p ∣ 2 ^ d - 1) (hpk : ¬ p ∣ k) :
    p ^ 2 ∣ 2 ^ (d * k) - 1 ↔ p ^ 2 ∣ 2 ^ d - 1 := by
  have hsmall : 2 ^ d - 1 ≠ 0 := by
    exact Nat.sub_ne_zero_of_lt (one_lt_pow₀ (by norm_num) hd.ne')
  have hdk : 0 < d * k := mul_pos hd (Nat.pos_of_ne_zero hk)
  have hlarge : 2 ^ (d * k) - 1 ≠ 0 := by
    exact Nat.sub_ne_zero_of_lt (one_lt_pow₀ (by norm_num) hdk.ne')
  rw [hp.pow_dvd_iff_le_factorization hlarge,
    hp.pow_dvd_iff_le_factorization hsmall,
    factorization_two_pow_mul_sub_one_of_not_dvd
      p d k hp hpodd hd hk hpd hpk]

/-! ## A strict order-level Wieferich obstruction -/

/-- `1093` is prime. -/
theorem prime_1093 : Nat.Prime 1093 := by
  norm_num

/-- The first classical base-two Wieferich prime already occurs squared in
the order-level Mersenne block with exponent `364`. -/
theorem wieferich_1093_sq_dvd_two_pow_364_sub_one :
    1093 ^ 2 ∣ 2 ^ 364 - 1 := by
  refine ⟨31454160447446347543279816539108468209499962568531106568805277152130328156499302385402895724314254018135, ?_⟩
  rw [show (364 : ℕ) = 28 * 13 by norm_num, pow_mul]
  norm_num

/-- Its exponent in this block is exactly two, not three. -/
theorem wieferich_1093_cube_not_dvd_two_pow_364_sub_one :
    ¬ 1093 ^ 3 ∣ 2 ^ 364 - 1 := by
  intro h
  have hdecomp :
      2 ^ 364 - 1 =
        1093 ^ 3 *
          28777822916236365547374031600282221600640404911739347272465944329487948908050596875940435246399134508 +
            1064432259 := by
    rw [show (364 : ℕ) = 28 * 13 by norm_num, pow_mul]
    norm_num
  have hmod : (2 ^ 364 - 1) % (1093 ^ 3) = 1064432259 := by
    rw [hdecomp]
    norm_num
  rw [Nat.dvd_iff_mod_eq_zero] at h
  omega

/-- The repeated factor is not an LTE contribution from divisibility of the
exponent by `1093`. -/
theorem wieferich_1093_not_dvd_exponent :
    ¬ 1093 ∣ 364 := by
  norm_num

/-- Modular checks for the three prime-index maximal proper divisors of
`364 = 2^2 * 7 * 13`.  Together with the square-divisibility theorem, these
checks give `ord_1093(2)=364` by the elementary order argument. -/
theorem wieferich_1093_order_checks :
    2 ^ 182 % 1093 = 1092 ∧
      2 ^ 52 % 1093 = 27 ∧
      2 ^ 28 % 1093 = 121 := by
  norm_num

end IUTThreeClosures
