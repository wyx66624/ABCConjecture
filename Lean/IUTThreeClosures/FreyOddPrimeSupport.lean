/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyOddPrimeNonCMReduction

/-!
# An abc triple has odd support except for `(1,1,2)`

For a primitive positive triple `a+b=c`, if no odd prime divides `abc`, every
odd member of the triple must be `1`.  The parity equation then leaves only
the exceptional triple `(1,1,2)`.

Combined with `FreyOddPrimeNonCMReduction`, this shows that the Frey
j-invariant is rational-nonintegral for every abc point except one explicit
point.  This is the elementary exceptional-set input for the non-CM and
large-image route.
-/

namespace IUTThreeClosures

namespace ABCPoint

private theorem exists_oddPrime_dvd_of_mod_two_eq_one
    {n : ℕ} (hnmod : n % 2 = 1) (hone : 1 < n) :
    ∃ p : ℕ, p.Prime ∧ p ≠ 2 ∧ p ∣ n := by
  let p := n.minFac
  have hp : p.Prime := Nat.minFac_prime (by omega)
  have hpd : p ∣ n := Nat.minFac_dvd n
  have hp_ne_two : p ≠ 2 := by
    intro hp2
    rcases hpd with ⟨k, hk⟩
    rw [hp2, hk] at hnmod
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
      omega
    · have ha1 : P.a = 1 :=
        eq_one_of_no_oddPrime_dvd P.a_pos ha hno_a
      have hcmod : P.c % 2 = 1 := by
        rw [← P.sum_eq, ha1]
        omega
      have hc1 : P.c = 1 :=
        eq_one_of_no_oddPrime_dvd P.c_pos hcmod hno_c
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

end IUTThreeClosures
