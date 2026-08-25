/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneWeightedWieferichMass

/-!
# First-order power lifts and the fixed-base sieve boundary

This file proves the finite algebraic core behind the exact `1/p` lift
density used in heuristic discussions of Wieferich primes.

If `a^n - 1 = p*q`, Taylor expansion modulo `p^2` gives

`p^2 | (a+p*k)^n - 1` if and only if
`p | q + n*a^(n-1)*k`.

When the displayed linear coefficient is coprime to `p`, there is one and
only one correction class `k mod p`.  The final section verifies the
coprimality condition for the base-two Fermat exponent `n=p-1` at an odd
prime and then removes the explicit Fermat-quotient witness.

These are finite root-counting statements.  They average the lift of the
base and do not assert any distribution estimate for the fixed lift `a=2`
as `p` varies.  No Mersenne radical estimate, large-sieve hypothesis, or abc
bound is assumed.
-/

namespace IUTThreeClosures

/-! ## Taylor expansion modulo the square of the step prime -/

/-- The first-order Taylor formula for an integral power, modulo `p^2`,
after shifting the base by `p*k`. -/
theorem primeSquare_dvd_powerLift_taylorRemainder
    (p n : ℕ) (a k : ℤ) :
    (p : ℤ) ^ 2 ∣
      (a + (p : ℤ) * k) ^ n - a ^ n -
        (n : ℤ) * a ^ (n - 1) * (p : ℤ) * k := by
  have hstep := sq_dvd_add_pow_sub_sub ((p : ℤ) * k) a n
  have hscale : (p : ℤ) ^ 2 ∣ ((p : ℤ) * k) ^ 2 := by
    refine ⟨k ^ 2, ?_⟩
    ring
  have h := hscale.trans hstep
  have heq :
      (a + (p : ℤ) * k) ^ n -
          a ^ (n - 1) * ((p : ℤ) * k) * (n : ℤ) - a ^ n =
        (a + (p : ℤ) * k) ^ n - a ^ n -
          (n : ℤ) * a ^ (n - 1) * (p : ℤ) * k := by
    ring
  rw [← heq]
  exact h

/-- If `a^n-1=p*q`, the lifted value has an exact affine first-order term
plus a multiple of `p^2`. -/
theorem exists_powerLift_affineExpansion
    (p n : ℕ) (a k q : ℤ)
    (hq : a ^ n - 1 = (p : ℤ) * q) :
    ∃ t : ℤ,
      (a + (p : ℤ) * k) ^ n - 1 =
        (p : ℤ) *
            (q + (n : ℤ) * a ^ (n - 1) * k) +
          (p : ℤ) ^ 2 * t := by
  rcases primeSquare_dvd_powerLift_taylorRemainder p n a k with ⟨t, ht⟩
  refine ⟨t, ?_⟩
  calc
    (a + (p : ℤ) * k) ^ n - 1 =
        ((a + (p : ℤ) * k) ^ n - a ^ n -
            (n : ℤ) * a ^ (n - 1) * (p : ℤ) * k) +
          (a ^ n - 1) +
            (n : ℤ) * a ^ (n - 1) * (p : ℤ) * k := by ring
    _ = (p : ℤ) ^ 2 * t + (p : ℤ) * q +
          (n : ℤ) * a ^ (n - 1) * (p : ℤ) * k := by
      rw [ht, hq]
    _ = (p : ℤ) *
            (q + (n : ℤ) * a ^ (n - 1) * k) +
          (p : ℤ) ^ 2 * t := by ring

/-- Exact square-lift criterion.  The nonzero assumption is only what is
needed to cancel one visible factor of `p`; primality is not needed here. -/
theorem primeSquare_dvd_powerLift_iff_affine
    (p n : ℕ) (a k q : ℤ)
    (hp0 : (p : ℤ) ≠ 0)
    (hq : a ^ n - 1 = (p : ℤ) * q) :
    (p : ℤ) ^ 2 ∣ (a + (p : ℤ) * k) ^ n - 1 ↔
      (p : ℤ) ∣ q + (n : ℤ) * a ^ (n - 1) * k := by
  rcases exists_powerLift_affineExpansion p n a k q hq with ⟨t, ht⟩
  let B : ℤ := q + (n : ℤ) * a ^ (n - 1) * k
  change (p : ℤ) ^ 2 ∣ (a + (p : ℤ) * k) ^ n - 1 ↔
    (p : ℤ) ∣ B
  rw [ht]
  constructor
  · intro htotal
    have htail : (p : ℤ) ^ 2 ∣ (p : ℤ) ^ 2 * t :=
      dvd_mul_right _ _
    have hhead : (p : ℤ) ^ 2 ∣ (p : ℤ) * B := by
      have hsub := dvd_sub htotal htail
      simpa using hsub
    have hcancel : (p : ℤ) * p ∣ (p : ℤ) * B := by
      simpa [pow_two] using hhead
    exact (mul_dvd_mul_iff_left hp0).mp hcancel
  · intro hB
    have hhead : (p : ℤ) ^ 2 ∣ (p : ℤ) * B := by
      have hcancel : (p : ℤ) * p ∣ (p : ℤ) * B :=
        (mul_dvd_mul_iff_left hp0).mpr hB
      simpa [pow_two] using hcancel
    exact dvd_add hhead (dvd_mul_right _ _)

/-! ## The unique affine correction class -/

/-- A linear congruence with invertible coefficient has a solution, unique
modulo the modulus.  This is stated over the integers so it can be combined
directly with the Taylor criterion. -/
theorem exists_affineDivisor_unique_mod
    (p c q : ℤ) (hcop : IsCoprime c p) :
    ∃ k : ℤ,
      p ∣ q + c * k ∧
      ∀ l : ℤ, p ∣ q + c * l → p ∣ l - k := by
  have hcopSymm : IsCoprime p c := hcop.symm
  rcases hcop with ⟨r, s, hrs⟩
  let k : ℤ := -r * q
  have hk : p ∣ q + c * k := by
    refine ⟨s * q, ?_⟩
    dsimp [k]
    linear_combination -q * hrs
  refine ⟨k, hk, ?_⟩
  intro l hl
  have hdiff : p ∣ c * (l - k) := by
    have hsub := dvd_sub hl hk
    have heq : (q + c * l) - (q + c * k) = c * (l - k) := by
      ring
    rw [← heq]
    exact hsub
  exact IsCoprime.dvd_of_dvd_mul_left hcopSymm hdiff

/-- Combining the affine congruence with Taylor expansion gives one good
power-lift correction class modulo `p`. -/
theorem exists_powerLiftCorrection_unique_mod
    (p n : ℕ) (a q : ℤ)
    (hp0 : (p : ℤ) ≠ 0)
    (hq : a ^ n - 1 = (p : ℤ) * q)
    (hcop : IsCoprime ((n : ℤ) * a ^ (n - 1)) (p : ℤ)) :
    ∃ k : ℤ,
      (p : ℤ) ^ 2 ∣ (a + (p : ℤ) * k) ^ n - 1 ∧
      ∀ l : ℤ,
        (p : ℤ) ^ 2 ∣ (a + (p : ℤ) * l) ^ n - 1 →
          (p : ℤ) ∣ l - k := by
  rcases exists_affineDivisor_unique_mod
      (p : ℤ) ((n : ℤ) * a ^ (n - 1)) q hcop with
    ⟨k, hk, huniq⟩
  refine ⟨k, ?_, ?_⟩
  · exact (primeSquare_dvd_powerLift_iff_affine
      p n a k q hp0 hq).2 hk
  · intro l hl
    exact huniq l ((primeSquare_dvd_powerLift_iff_affine
      p n a l q hp0 hq).1 hl)

/-! ## The base-two Fermat coefficient is invertible -/

/-- For an odd prime `p`, the affine correction coefficient
`(p-1)*2^(p-2)` is coprime to `p`. -/
theorem baseTwoFermatLiftCoefficient_isCoprime
    (p : ℕ) (hp : p.Prime) (hpodd : Odd p) :
    IsCoprime
      ((((p - 1) * 2 ^ (p - 2) : ℕ) : ℤ))
      (p : ℤ) := by
  have hpone : 1 ≤ p := hp.one_le
  have hpred : Nat.Coprime (p - 1) p := by
    have heq : p - 1 + 1 = p := Nat.sub_add_cancel hpone
    have h : Nat.Coprime (p - 1) ((p - 1) + 1) :=
      Nat.coprime_self_add_right.mpr (by simp)
    simpa only [heq] using h
  have htwo : Nat.Coprime 2 p := by
    apply Nat.prime_two.coprime_iff_not_dvd.mpr
    rw [← even_iff_two_dvd, Nat.not_even_iff_odd]
    exact hpodd
  have hpow : Nat.Coprime (2 ^ (p - 2)) p :=
    htwo.pow_left (p - 2)
  exact (hpred.mul_left hpow).isCoprime

/-- The base-two specialization: once the Fermat quotient `q` is exposed,
there is exactly one correction class modulo an odd prime whose lift remains
a `(p-1)`-st root modulo `p^2`. -/
theorem exists_baseTwoFermatLiftCorrection_unique_mod
    (p : ℕ) (hp : p.Prime) (hpodd : Odd p) (q : ℤ)
    (hq : (2 : ℤ) ^ (p - 1) - 1 = (p : ℤ) * q) :
    ∃ k : ℤ,
      (p : ℤ) ^ 2 ∣
          ((2 : ℤ) + (p : ℤ) * k) ^ (p - 1) - 1 ∧
      ∀ l : ℤ,
        (p : ℤ) ^ 2 ∣
            ((2 : ℤ) + (p : ℤ) * l) ^ (p - 1) - 1 →
          (p : ℤ) ∣ l - k := by
  have hp2 : 2 ≤ p := hp.two_le
  have hexp : p - 1 - 1 = p - 2 := by omega
  have hcop :
      IsCoprime (((p - 1 : ℕ) : ℤ) * (2 : ℤ) ^ (p - 2))
        (p : ℤ) := by
    simpa only [Nat.cast_mul, Nat.cast_pow, Nat.cast_ofNat] using
      baseTwoFermatLiftCoefficient_isCoprime p hp hpodd
  simpa only [hexp] using
    exists_powerLiftCorrection_unique_mod p (p - 1) (2 : ℤ) q
      (by exact_mod_cast hp.ne_zero) hq hcop

/-- Fermat's theorem supplies the quotient in the preceding result.  Thus
for every odd prime there is unconditionally one good correction class
modulo `p`; no quotient witness is left as a hypothesis. -/
theorem exists_baseTwoFermatLiftCorrection_unique_mod_of_prime
    (p : ℕ) (hp : p.Prime) (hpodd : Odd p) :
    ∃ k : ℤ,
      (p : ℤ) ^ 2 ∣
          ((2 : ℤ) + (p : ℤ) * k) ^ (p - 1) - 1 ∧
      ∀ l : ℤ,
        (p : ℤ) ^ 2 ∣
            ((2 : ℤ) + (p : ℤ) * l) ^ (p - 1) - 1 →
          (p : ℤ) ∣ l - k := by
  have htwo : Nat.Coprime 2 p := by
    apply Nat.prime_two.coprime_iff_not_dvd.mpr
    rw [← even_iff_two_dvd, Nat.not_even_iff_odd]
    exact hpodd
  have hdiv :
      (p : ℤ) ∣ (2 : ℤ) ^ (p - 1) - 1 :=
    Int.prime_dvd_pow_sub_one hp htwo.isCoprime
  rcases hdiv with ⟨q, hq⟩
  exact exists_baseTwoFermatLiftCorrection_unique_mod p hp hpodd q hq

end IUTThreeClosures
