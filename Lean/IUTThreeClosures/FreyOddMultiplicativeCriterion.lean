/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyOddPrimeSupport

/-!
# The elementary odd multiplicative-reduction criterion for the Frey model

For the integral Frey equation

`y² = x (x-a) (x+b)`

the relevant integral invariants are

* `c₄ = 16 (a²+ab+b²)`,
* `Δ = 16 (abc)²`.

The quadratic core is coprime to `abc`. Hence at every odd prime dividing
`abc`, the discriminant is divisible by the prime while `c₄` is a unit. Over a
local DVR this is the standard arithmetic criterion for multiplicative
reduction of a minimal Weierstrass equation.

This module proves the entire elementary divisibility input. The final passage
from these divisibility statements to Mathlib's local
`HasMultiplicativeReduction` predicate is a separate local-minimal-model
bridge.
-/

namespace IUTThreeClosures

namespace ABCPoint

/-- Integral numerator of the Frey `c₄` invariant. -/
def freyC4Nat (P : ABCPoint) : ℕ :=
  16 * P.legendreCore

/-- Integral Frey discriminant. -/
def freyDeltaNat (P : ABCPoint) : ℕ :=
  16 * (P.a * P.b * P.c) ^ 2

/-- The natural invariants agree with the rational Weierstrass invariants after
casting. -/
theorem abcFrey_c4_eq_freyC4Nat (P : ABCPoint) :
    (abcFreyCurve P).c₄ = (P.freyC4Nat : ℚ) := by
  rw [abcFrey_c₄]
  unfold freyC4Nat legendreCore
  push_cast
  ring

/-- The rational discriminant is the cast of the integral Frey discriminant. -/
theorem abcFrey_delta_eq_freyDeltaNat (P : ABCPoint) :
    (abcFreyCurve P).Δ = (P.freyDeltaNat : ℚ) := by
  rw [abcFrey_Δ]
  unfold freyDeltaNat
  push_cast
  ring

/-- A support prime divides the integral Frey discriminant. -/
theorem prime_dvd_freyDeltaNat
    (P : ABCPoint) {p : ℕ}
    (hpabc : p ∣ P.a * P.b * P.c) :
    p ∣ P.freyDeltaNat := by
  rcases hpabc with ⟨k, hk⟩
  refine ⟨16 * (P.a * P.b * P.c) * k, ?_⟩
  unfold freyDeltaNat
  rw [hk]
  ring

/-- No prime dividing `abc` divides its coprime Legendre numerator core. -/
theorem prime_not_dvd_legendreCore
    (P : ABCPoint) {p : ℕ}
    (hp : p.Prime)
    (hpabc : p ∣ P.a * P.b * P.c) :
    ¬ p ∣ P.legendreCore := by
  intro hpH
  have hpgcd : p ∣ Nat.gcd (P.a * P.b * P.c) P.legendreCore :=
    Nat.dvd_gcd hpabc hpH
  rw [P.coprime_abc_legendreCore.gcd_eq_one] at hpgcd
  exact hp.ne_one (Nat.dvd_one.mp hpgcd)

/-- An odd support prime cannot divide the integral Frey `c₄`. -/
theorem oddPrime_not_dvd_freyC4Nat
    (P : ABCPoint) {p : ℕ}
    (hp : p.Prime) (hp_ne_two : p ≠ 2)
    (hpabc : p ∣ P.a * P.b * P.c) :
    ¬ p ∣ P.freyC4Nat := by
  intro hpc4
  unfold freyC4Nat at hpc4
  rcases hp.dvd_mul.mp hpc4 with hp16 | hpH
  · apply oddPrime_not_dvd_256 hp hp_ne_two
    exact hp16.trans (by norm_num : 16 ∣ 256)
  · exact P.prime_not_dvd_legendreCore hp hpabc hpH

/-- The exact elementary local signature of multiplicative reduction. -/
def FreyOddMultiplicativeSignature
    (P : ABCPoint) (p : ℕ) : Prop :=
  p.Prime ∧ p ≠ 2 ∧
    p ∣ P.freyDeltaNat ∧ ¬ p ∣ P.freyC4Nat

/-- Every odd prime dividing `abc` gives the multiplicative-reduction
signature for the integral Frey model. -/
theorem freyOddMultiplicativeSignature
    (P : ABCPoint) {p : ℕ}
    (hp : p.Prime) (hp_ne_two : p ≠ 2)
    (hpabc : p ∣ P.a * P.b * P.c) :
    P.FreyOddMultiplicativeSignature p :=
  ⟨hp, hp_ne_two, P.prime_dvd_freyDeltaNat hpabc,
    P.oddPrime_not_dvd_freyC4Nat hp hp_ne_two hpabc⟩

/-- Outside the unique all-2-primary point `(1,1,2)`, the Frey model has an
odd prime with multiplicative-reduction signature. -/
theorem exists_freyOddMultiplicativeSignature_unless_exceptional
    (P : ABCPoint)
    (hP : ¬ (P.a = 1 ∧ P.b = 1 ∧ P.c = 2)) :
    ∃ p : ℕ, P.FreyOddMultiplicativeSignature p := by
  rcases P.exists_oddPrime_dvd_abc_or_exceptional with hodd | hex
  · rcases hodd with ⟨p, hp, hp2, hpabc⟩
    exact ⟨p, P.freyOddMultiplicativeSignature hp hp2 hpabc⟩
  · exact False.elim (hP hex)

end ABCPoint

end IUTThreeClosures
