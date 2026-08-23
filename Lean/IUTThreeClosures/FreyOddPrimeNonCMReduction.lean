/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyJHeightCorridor

/-!
# Odd bad primes force the Frey j-invariant to be nonintegral

For an abc point `P`, the Frey j-invariant has unreduced denominator
`(abc)^2`.  The only possible cancellation comes from the fixed factor `256`:
the variable numerator core is coprime to `abc`, and the gcd content was
already proved to divide `256`.

Consequently every odd prime dividing `abc` survives in the reduced
denominator of the Frey j-invariant.  In particular the rational j-invariant
is not an integer.  The classical theorem that CM j-invariants are algebraic
integers therefore reduces non-CM of the Frey curve to the existence of one
odd prime in the support of `abc`.

This module proves the complete elementary denominator argument.  It does not
postulate a CM predicate or Serre/Mazur large-image theorem.
-/

namespace IUTThreeClosures

namespace ABCPoint

/-- An odd prime cannot divide the fixed cancellation factor `256 = 2^8`. -/
theorem oddPrime_not_dvd_256
    {p : ℕ} (hp : p.Prime) (hp_ne_two : p ≠ 2) :
    ¬ p ∣ 256 := by
  intro h
  have hpow : p ∣ 2 ^ 8 := by
    norm_num at h ⊢
    exact h
  have htwo : p ∣ 2 := hp.dvd_of_dvd_pow hpow
  have hle : p ≤ 2 := Nat.le_of_dvd (by norm_num) htwo
  have hge : 2 ≤ p := hp.two_le
  exact hp_ne_two (Nat.le_antisymm hle hge)

/-- Every odd prime in the abc support survives in the reduced denominator of
the Frey j-invariant. -/
theorem oddPrime_dvd_freyJReducedDen
    (P : ABCPoint) {p : ℕ}
    (hp : p.Prime) (hp_ne_two : p ≠ 2)
    (hpabc : p ∣ P.a * P.b * P.c) :
    p ∣ P.freyJReducedDen := by
  have hpraw : p ∣ P.freyJRawDen := by
    rcases hpabc with ⟨k, hk⟩
    refine ⟨k ^ 2, ?_⟩
    unfold freyJRawDen
    rw [hk]
    ring
  have hpprod : p ∣ P.freyJReducedDen * P.freyJContent := by
    rw [P.freyJReducedDen_mul_content]
    exact hpraw
  rcases hp.dvd_mul.mp hpprod with hpred | hpcontent
  · exact hpred
  · exfalso
    apply P.oddPrime_not_dvd_256 hp hp_ne_two
    exact hpcontent.trans P.freyJContent_dvd_256

/-- The reduced Frey denominator is nontrivial whenever an odd prime divides
`abc`. -/
theorem freyJReducedDen_ne_one_of_oddPrime
    (P : ABCPoint) {p : ℕ}
    (hp : p.Prime) (hp_ne_two : p ≠ 2)
    (hpabc : p ∣ P.a * P.b * P.c) :
    P.freyJReducedDen ≠ 1 := by
  intro hden
  have hpd := P.oddPrime_dvd_freyJReducedDen hp hp_ne_two hpabc
  rw [hden] at hpd
  exact (Nat.not_prime_one (hp.dvd_of_dvd_one hpd))

/-- An odd prime in the abc support makes the actual Frey j-invariant
nonintegral over `ℚ`. -/
theorem abcFrey_j_not_integer_of_oddPrime
    (P : ABCPoint) {p : ℕ}
    (hp : p.Prime) (hp_ne_two : p ≠ 2)
    (hpabc : p ∣ P.a * P.b * P.c) :
    ¬ ∃ z : ℤ, (abcFreyCurve P).j = (z : ℚ) := by
  rintro ⟨z, hz⟩
  have hden := congrArg Rat.den hz
  have hone : (abcFreyCurve P).j.den = 1 := by
    simpa using hden
  rw [P.abcFrey_j_den] at hone
  exact P.freyJReducedDen_ne_one_of_oddPrime hp hp_ne_two hpabc hone

end ABCPoint

/-- The exact classical CM-integrality principle needed for the Frey route. -/
def FreyCMJIntegralPrinciple
    (HasCM : ABCPoint → Prop) : Prop :=
  ∀ P : ABCPoint, HasCM P →
    ∃ z : ℤ, (abcFreyCurve P).j = (z : ℚ)

/-- Conditional non-CM reduction: once CM integrality is formalized, any abc
point with an odd prime in its support gives a non-CM Frey curve. -/
theorem abcFrey_nonCM_of_oddPrime
    (HasCM : ABCPoint → Prop)
    (hCMIntegral : FreyCMJIntegralPrinciple HasCM)
    (P : ABCPoint) {p : ℕ}
    (hp : p.Prime) (hp_ne_two : p ≠ 2)
    (hpabc : p ∣ P.a * P.b * P.c) :
    ¬ HasCM P := by
  intro hCM
  exact P.abcFrey_j_not_integer_of_oddPrime hp hp_ne_two hpabc
    (hCMIntegral P hCM)

end IUTThreeClosures
