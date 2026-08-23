/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyJHeightCorridor

/-!
# Odd support primes and the Frey j-invariant

For an abc point `P`, the Frey j-invariant has unreduced denominator
`(abc)^2`. The variable numerator core is coprime to `abc`, and the complete
cancellation content was already proved to divide the fixed integer `256`.
Hence every odd prime dividing `abc` survives in the reduced denominator.

A primitive positive abc triple has an odd support prime unless it is the
single exceptional triple `(1,1,2)`. Consequently the Frey j-invariant is a
nonintegral rational number for every nonexceptional abc point. The classical
CM-j integrality theorem then supplies the non-CM conclusion needed by the
large-image route.
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
    refine ⟨p * k ^ 2, ?_⟩
    unfold freyJRawDen
    rw [hk]
    ring
  have hpprod : p ∣ P.freyJReducedDen * P.freyJContent := by
    rw [P.freyJReducedDen_mul_content]
    exact hpraw
  rcases hp.dvd_mul.mp hpprod with hpred | hpcontent
  · exact hpred
  · exfalso
    apply oddPrime_not_dvd_256 hp hp_ne_two
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
  have hpone : p = 1 := Nat.dvd_one.mp hpd
  exact hp.ne_one hpone

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

private theorem exists_oddPrime_dvd_of_mod_two_eq_one
    {n : ℕ} (hnmod : n % 2 = 1) (hone : 1 < n) :
    ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ p ∣ n := by
  let p := n.minFac
  have hp : p.Prime := Nat.minFac_prime (by omega)
  have hpd : p ∣ n := Nat.minFac_dvd n
  have hp_ne_two : p ≠ 2 := by
    intro hp2
    rcases hpd with ⟨k, hk⟩
    have hk2 : n = 2 * k := by
      simpa [hp2] using hk
    rw [hk2] at hnmod
    omega
  exact ⟨p, hp, hp_ne_two, hpd⟩

private theorem eq_one_of_no_oddPrime_dvd
    {n : ℕ} (hnpos : 0 < n) (hnmod : n % 2 = 1)
    (hno : ¬ ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ p ∣ n) :
    n = 1 := by
  by_contra hne
  have hone : 1 < n := by omega
  exact hno (exists_oddPrime_dvd_of_mod_two_eq_one hnmod hone)

/-- Every abc point either has an odd prime in the support of `abc`, or is the
unique all-2-primary primitive point `(1,1,2)`. -/
theorem exists_oddPrime_dvd_abc_or_exceptional (P : ABCPoint) :
    (∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ p ∣ P.a * P.b * P.c) ∨
      (P.a = 1 ∧ P.b = 1 ∧ P.c = 2) := by
  by_cases hex :
      ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ p ∣ P.a * P.b * P.c
  · exact Or.inl hex
  · right
    have hno_a :
        ¬ ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ p ∣ P.a := by
      rintro ⟨p, hp, hp2, hpa⟩
      apply hex
      refine ⟨p, hp, hp2, ?_⟩
      exact dvd_mul_of_dvd_left (dvd_mul_of_dvd_left hpa P.b) P.c
    have hno_b :
        ¬ ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ p ∣ P.b := by
      rintro ⟨p, hp, hp2, hpb⟩
      apply hex
      refine ⟨p, hp, hp2, ?_⟩
      exact dvd_mul_of_dvd_left (dvd_mul_of_dvd_right hpb P.a) P.c
    have hno_c :
        ¬ ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ p ∣ P.c := by
      rintro ⟨p, hp, hp2, hpc⟩
      apply hex
      refine ⟨p, hp, hp2, ?_⟩
      exact dvd_mul_of_dvd_right hpc (P.a * P.b)
    have haParity : P.a % 2 = 0 ∨ P.a % 2 = 1 := by omega
    have hbParity : P.b % 2 = 0 ∨ P.b % 2 = 1 := by omega
    rcases haParity with ha | ha <;> rcases hbParity with hb | hb
    · have h2a : 2 ∣ P.a := Nat.dvd_iff_mod_eq_zero.mpr ha
      have h2b : 2 ∣ P.b := Nat.dvd_iff_mod_eq_zero.mpr hb
      have h2g : 2 ∣ Nat.gcd P.a P.b := Nat.dvd_gcd h2a h2b
      rw [P.pairwise_coprime.1.gcd_eq_one] at h2g
      norm_num at h2g
    · have hb1 : P.b = 1 :=
        eq_one_of_no_oddPrime_dvd P.b_pos hb hno_b
      have hcmod : P.c % 2 = 1 := by
        rw [← P.sum_eq, hb1]
        omega
      have hc1 : P.c = 1 :=
        eq_one_of_no_oddPrime_dvd P.c_pos hcmod hno_c
      have hsum := P.sum_eq
      omega
    · have ha1 : P.a = 1 :=
        eq_one_of_no_oddPrime_dvd P.a_pos ha hno_a
      have hcmod : P.c % 2 = 1 := by
        rw [← P.sum_eq, ha1]
        omega
      have hc1 : P.c = 1 :=
        eq_one_of_no_oddPrime_dvd P.c_pos hcmod hno_c
      have hsum := P.sum_eq
      omega
    · have ha1 : P.a = 1 :=
        eq_one_of_no_oddPrime_dvd P.a_pos ha hno_a
      have hb1 : P.b = 1 :=
        eq_one_of_no_oddPrime_dvd P.b_pos hb hno_b
      refine ⟨ha1, hb1, ?_⟩
      rw [← P.sum_eq, ha1, hb1]

/-- Outside the one explicit exceptional abc point, the actual Frey
j-invariant is rational-nonintegral. -/
theorem abcFrey_j_not_integer_unless_exceptional
    (P : ABCPoint)
    (hP : ¬ (P.a = 1 ∧ P.b = 1 ∧ P.c = 2)) :
    ¬ ∃ z : ℤ, (abcFreyCurve P).j = (z : ℚ) := by
  rcases P.exists_oddPrime_dvd_abc_or_exceptional with hodd | hex
  · rcases hodd with ⟨p, hp, hp2, hpd⟩
    exact P.abcFrey_j_not_integer_of_oddPrime hp hp2 hpd
  · exact False.elim (hP hex)

end ABCPoint

/-- The exact CM-integrality principle needed by the Frey route. -/
def FreyCMJIntegralPrinciple
    (HasCM : ABCPoint → Prop) : Prop :=
  ∀ P : ABCPoint, HasCM P →
    ∃ z : ℤ, (abcFreyCurve P).j = (z : ℚ)

/-- Conditional non-CM theorem for every nonexceptional abc point. -/
theorem abcFrey_nonCM_unless_exceptional
    (HasCM : ABCPoint → Prop)
    (hCMIntegral : FreyCMJIntegralPrinciple HasCM)
    (P : ABCPoint)
    (hP : ¬ (P.a = 1 ∧ P.b = 1 ∧ P.c = 2)) :
    ¬ HasCM P := by
  intro hCM
  exact P.abcFrey_j_not_integer_unless_exceptional hP
    (hCMIntegral P hCM)

end IUTThreeClosures
