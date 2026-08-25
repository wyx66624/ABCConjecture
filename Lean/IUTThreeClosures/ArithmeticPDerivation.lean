/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.FieldTheory.Finite.Basic
import Mathlib.Data.Int.NatAbs
import Mathlib.RingTheory.Derivation.Basic
import Mathlib.RingTheory.Int.Basic
import Mathlib.RingTheory.Radical.NatInt

/-!
# Ordinary-derivation no-go and a canonical arithmetic `p`-derivation

This file develops an explicitly non-IUT route suggested by the differential
proof of Mason--Stothers.  It first proves the structural obstruction: ordinary
derivations out of `ℤ`, and `ℤ`-relative derivations on its fraction field `ℚ`,
are zero.  It then defines the integral canonical arithmetic operator

`δ_p(n) = (n - n^p) / p`

for a rational prime `p`, proves its exact twisted additive and multiplicative
laws, specializes the additive law to `a + b = c`, and proves that at a prime
already dividing `n` the operator detects precisely whether the prime occurs
with multiplicity at least two.

Finally an explicit powers-of-two family proves that the raw size of this
operator cannot be bounded by the radical of its input alone.  None of these
statements assumes or packages the abc conjecture.
-/

namespace IUTThreeClosures

/-! ## Ordinary derivations vanish on the arithmetic ground rings -/

/-- Every ordinary derivation of `ℤ` into a `ℤ`-module is zero. -/
theorem intDerivation_eq_zero
    {M : Type*} [AddCommGroup M] [Module ℤ M]
    (D : Derivation ℤ ℤ M) : D = 0 := by
  ext n
  simpa using D.map_intCast n

/-- Every `ℤ`-relative derivation of the fraction field `ℚ` is zero.

This is the localization obstruction behind the failure of a literal
Mason--Stothers Wronskian over the integers. -/
theorem ratOverIntDerivation_eq_zero
    {M : Type*} [AddCommGroup M] [Module ℚ M] [Module ℤ M]
    (D : Derivation ℤ ℚ M) : D = 0 := by
  ext q
  rw [← Rat.num_div_den q]
  simp only [D.leibniz_div]
  simp

/-- In particular, every `ℚ`-relative derivation of `ℚ` is zero. -/
theorem ratRelativeDerivation_eq_zero
    {M : Type*} [AddCommGroup M] [Module ℚ M]
    (D : Derivation ℚ ℚ M) : D = 0 := by
  ext q
  simpa using D.map_algebraMap q

/-! ## The canonical integral `p`-derivation -/

/-- The canonical arithmetic `p`-derivation on integers.

For prime `p` the quotient is exact by Fermat's congruence; the definition is
kept total so that its algebraic specification can carry primality explicitly.
-/
def fermatDelta (p : ℕ) (n : ℤ) : ℤ :=
  (n - n ^ p) / (p : ℤ)

/-- The additive correction polynomial for `fermatDelta`. -/
def fermatAddCorrection (p : ℕ) (x y : ℤ) : ℤ :=
  (x ^ p + y ^ p - (x + y) ^ p) / (p : ℤ)

/-- Fermat's congruence in the exact divisibility orientation needed below. -/
theorem prime_dvd_sub_pow (p : ℕ) (hp : p.Prime) (n : ℤ) :
    (p : ℤ) ∣ n - n ^ p := by
  letI : Fact p.Prime := ⟨hp⟩
  apply (ZMod.intCast_eq_intCast_iff_dvd_sub (n ^ p) n p).mp
  simp

/-- Multiplying `fermatDelta` by its prime recovers its defining numerator. -/
theorem fermatDelta_mul_prime (p : ℕ) (hp : p.Prime) (n : ℤ) :
    fermatDelta p n * (p : ℤ) = n - n ^ p := by
  exact Int.ediv_mul_cancel (prime_dvd_sub_pow p hp n)

/-- The additive correction numerator is divisible by `p`. -/
theorem prime_dvd_addCorrectionNumerator
    (p : ℕ) (hp : p.Prime) (x y : ℤ) :
    (p : ℤ) ∣ x ^ p + y ^ p - (x + y) ^ p := by
  have hx := prime_dvd_sub_pow p hp x
  have hy := prime_dvd_sub_pow p hp y
  have hxy := prime_dvd_sub_pow p hp (x + y)
  rcases hx with ⟨ux, hux⟩
  rcases hy with ⟨uy, huy⟩
  rcases hxy with ⟨uxy, huxy⟩
  refine ⟨uxy - ux - uy, ?_⟩
  linear_combination huxy - hux - huy

/-- Multiplying the additive correction by `p` recovers its numerator. -/
theorem fermatAddCorrection_mul_prime
    (p : ℕ) (hp : p.Prime) (x y : ℤ) :
    fermatAddCorrection p x y * (p : ℤ) =
      x ^ p + y ^ p - (x + y) ^ p := by
  exact Int.ediv_mul_cancel
    (prime_dvd_addCorrectionNumerator p hp x y)

/-- Exact twisted additive law for the canonical arithmetic operator. -/
theorem fermatDelta_add
    (p : ℕ) (hp : p.Prime) (x y : ℤ) :
    fermatDelta p (x + y) =
      fermatDelta p x + fermatDelta p y +
        fermatAddCorrection p x y := by
  have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast hp.ne_zero
  apply mul_right_cancel₀ hp0
  rw [fermatDelta_mul_prime p hp]
  rw [add_mul, add_mul]
  rw [fermatDelta_mul_prime p hp, fermatDelta_mul_prime p hp,
    fermatAddCorrection_mul_prime p hp]
  ring

/-- A short twisted Leibniz law for the canonical arithmetic operator. -/
theorem fermatDelta_mul_short
    (p : ℕ) (hp : p.Prime) (x y : ℤ) :
    fermatDelta p (x * y) =
      x * fermatDelta p y + y ^ p * fermatDelta p x := by
  have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast hp.ne_zero
  apply mul_right_cancel₀ hp0
  rw [fermatDelta_mul_prime p hp]
  calc
    x * y - (x * y) ^ p =
        x * (y - y ^ p) + y ^ p * (x - x ^ p) := by
      rw [mul_pow]
      ring
    _ = (x * fermatDelta p y + y ^ p * fermatDelta p x) * (p : ℤ) := by
      rw [← fermatDelta_mul_prime p hp y,
        ← fermatDelta_mul_prime p hp x]
      ring

/-- Exact standard `p`-derivation product law. -/
theorem fermatDelta_mul
    (p : ℕ) (hp : p.Prime) (x y : ℤ) :
    fermatDelta p (x * y) =
      x ^ p * fermatDelta p y + y ^ p * fermatDelta p x +
        (p : ℤ) * fermatDelta p x * fermatDelta p y := by
  rw [fermatDelta_mul_short p hp]
  have hx : x = x ^ p + (p : ℤ) * fermatDelta p x := by
    have hspec := fermatDelta_mul_prime p hp x
    calc
      x = (x - x ^ p) + x ^ p := by ring
      _ = fermatDelta p x * (p : ℤ) + x ^ p := by rw [hspec]
      _ = x ^ p + (p : ℤ) * fermatDelta p x := by ring
  nth_rewrite 1 [hx]
  ring

/-- For `a+b=c`, the arithmetic derivative relation has an unavoidable,
explicit degree-`p` correction term. -/
theorem fermatDelta_of_add_eq
    (p : ℕ) (hp : p.Prime) {a b c : ℤ} (h : a + b = c) :
    fermatDelta p c =
      fermatDelta p a + fermatDelta p b +
        fermatAddCorrection p a b := by
  subst c
  exact fermatDelta_add p hp a b

/-! ## A first surviving local theorem -/

/-- On a multiple `p*k`, `fermatDelta` removes the displayed factor `p` and
leaves a cofactor congruent to one modulo `p`. -/
theorem fermatDelta_prime_mul
    (p : ℕ) (hp : p.Prime) (k : ℤ) :
    fermatDelta p ((p : ℤ) * k) =
      k * (1 - ((p : ℤ) * k) ^ (p - 1)) := by
  have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast hp.ne_zero
  apply mul_right_cancel₀ hp0
  rw [fermatDelta_mul_prime p hp]
  have hpexp : p = (p - 1) + 1 := by omega
  rw [show ((p : ℤ) * k) ^ p =
      ((p : ℤ) * k) ^ (p - 1) * ((p : ℤ) * k) by
    calc
      ((p : ℤ) * k) ^ p =
          ((p : ℤ) * k) ^ ((p - 1) + 1) :=
        congrArg (fun e : ℕ => ((p : ℤ) * k) ^ e) hpexp
      _ = ((p : ℤ) * k) ^ (p - 1) * ((p : ℤ) * k) :=
        pow_succ _ _]
  ring

/-- The cofactor in `fermatDelta_prime_mul` is a unit modulo `p`. -/
theorem prime_not_dvd_fermatDeltaCofactor
    (p : ℕ) (hp : p.Prime) (k : ℤ) :
    ¬(p : ℤ) ∣ 1 - ((p : ℤ) * k) ^ (p - 1) := by
  letI : Fact p.Prime := ⟨hp⟩
  intro hdiv
  have hzero :
      ((1 - ((p : ℤ) * k) ^ (p - 1) : ℤ) : ZMod p) = 0 := by
    rw [ZMod.intCast_zmod_eq_zero_iff_dvd]
    exact hdiv
  have hp2 := hp.two_le
  have hpos : 0 < p - 1 := by omega
  have hone :
      ((1 - ((p : ℤ) * k) ^ (p - 1) : ℤ) : ZMod p) = 1 := by
    simp [hpos.ne']
  exact one_ne_zero (hone.symm.trans hzero)

/-- At a prime already dividing `n`, the canonical arithmetic derivative
detects exactly whether that prime occurs at least twice. -/
theorem prime_dvd_fermatDelta_iff_sq_dvd
    (p : ℕ) (hp : p.Prime) (n : ℤ) (hpn : (p : ℤ) ∣ n) :
    (p : ℤ) ∣ fermatDelta p n ↔ (p : ℤ) ^ 2 ∣ n := by
  rcases hpn with ⟨k, rfl⟩
  have hpInt : Prime (p : ℤ) := Nat.prime_iff_prime_int.mp hp
  have hcofactor := prime_not_dvd_fermatDeltaCofactor p hp k
  rw [fermatDelta_prime_mul p hp]
  constructor
  · intro h
    have hk : (p : ℤ) ∣ k := (hpInt.dvd_mul.mp h).resolve_right hcofactor
    simpa [pow_two, mul_assoc] using mul_dvd_mul_left (p : ℤ) hk
  · intro h
    have hp0 : (p : ℤ) ≠ 0 := by exact_mod_cast hp.ne_zero
    rw [pow_two] at h
    have hk : (p : ℤ) ∣ k := by
      exact (mul_dvd_mul_iff_left hp0).mp h
    exact dvd_mul_of_dvd_left hk _

/-! ## Explicit obstruction to radical-only size estimates -/

/-- Exact powers-of-two formula for the simplest canonical arithmetic
derivative. -/
theorem fermatDelta_two_pow (m : ℕ) :
    fermatDelta 2 ((2 : ℤ) ^ (m + 1)) =
      -((2 : ℤ) ^ m) * ((2 : ℤ) ^ (m + 1) - 1) := by
  have hp : Nat.Prime 2 := Nat.prime_two
  rw [pow_succ']
  calc
    fermatDelta 2 ((2 : ℤ) * (2 : ℤ) ^ m) =
        (2 : ℤ) ^ m * (1 - ((2 : ℤ) * (2 : ℤ) ^ m) ^ (2 - 1)) :=
      fermatDelta_prime_mul 2 hp ((2 : ℤ) ^ m)
    _ = -((2 : ℤ) ^ m) * ((2 : ℤ) * (2 : ℤ) ^ m - 1) := by
      norm_num
      ring

/-- Every positive power of two has radical exactly two. -/
theorem radical_two_pow_succ (m : ℕ) :
    UniqueFactorizationMonoid.radical (2 ^ (m + 1)) = 2 := by
  simpa using
    (UniqueFactorizationMonoid.radical_pow_of_prime
      (Nat.prime_iff.mp Nat.prime_two)
      (show m + 1 ≠ 0 by omega))

/-- The raw arithmetic derivative is unbounded on inputs of fixed radical.

This strictly refutes every proposed bound depending only on the radical of a
single input; it does not refute a global three-variable abc estimate. -/
theorem fermatDelta_unbounded_at_fixed_radical (B : ℕ) :
    ∃ n : ℕ,
      UniqueFactorizationMonoid.radical n = 2 ∧
        B < (fermatDelta 2 n).natAbs := by
  refine ⟨2 ^ (B + 2), ?_, ?_⟩
  · rw [show B + 2 = (B + 1) + 1 by omega]
    exact radical_two_pow_succ (B + 1)
  · change B < (fermatDelta 2 ((2 : ℤ) ^ (B + 2))).natAbs
    rw [show B + 2 = (B + 1) + 1 by omega]
    rw [fermatDelta_two_pow (B + 1)]
    rw [Int.natAbs_mul, Int.natAbs_neg, Int.natAbs_pow]
    have htwoAbs : (2 : ℤ).natAbs = 2 := by norm_num
    rw [htwoAbs]
    have hone : 1 ≤ (2 : ℕ) ^ (B + 1 + 1) :=
      Nat.one_le_pow _ _ (by omega)
    have hcast :
        (2 : ℤ) ^ (B + 1 + 1) - 1 =
          ((2 ^ (B + 1 + 1) : ℕ) : ℤ) - (1 : ℕ) := by norm_cast
    rw [hcast, Int.natAbs_natCast_sub_natCast_of_ge hone]
    have hfactor : 1 ≤ 2 ^ (B + 2) - 1 := by
      have : 2 ≤ 2 ^ (B + 2) := by
        simpa using
          (Nat.pow_le_pow_right (n := 2) (by omega) (show 1 ≤ B + 2 by omega))
      omega
    have hle : 2 ^ (B + 1) ≤ 2 ^ (B + 1) * (2 ^ (B + 2) - 1) := by
      simpa using Nat.mul_le_mul_left (2 ^ (B + 1)) hfactor
    have hB : B < 2 ^ B := B.lt_two_pow_self
    have hpow : 2 ^ B ≤ 2 ^ (B + 1) := by
      rw [pow_succ]
      exact Nat.le_mul_of_pos_right _ (by decide)
    exact (hB.trans_le hpow).trans_le hle

end IUTThreeClosures
