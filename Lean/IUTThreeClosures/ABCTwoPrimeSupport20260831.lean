/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCStatement
import Mathlib.Data.Nat.Factorization.PrimePow
import Mathlib.NumberTheory.Multiplicity
import Mathlib.Tactic.ByContra
import Mathlib.Tactic.IntervalCases
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Positivity

/-!
# A sharp radical bound for primitive abc triples supported on at most two primes

The mathematical proof precedes this file in
research/ANALYTIC_UNIFORM_GATE_2026_08_31.md, Sections 2 and 7.
The intended result is the actual arithmetic inequality
2 * c ≤ 3 * abcRadical (a * b * c), together with c ≤ rad(abc)
outside the two ordered triples (1,8,9) and (8,1,9).

The classification starts from the actual finite prime-factor support.
No prime-power classification, Catalan theorem, or abc statement is assumed.
-/

namespace IUTThreeClosures.ABCTwoPrimeSupport20260831

open scoped BigOperators

/-- Pairwise coprimality makes prime-support cardinalities additive. -/
theorem primeFactors_card_mul_three {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hcop : PairwiseCoprimeABC a b c) :
    (a * b * c).primeFactors.card =
      a.primeFactors.card + b.primeFactors.card + c.primeFactors.card := by
  rcases hcop with ⟨hab, hbc, hca⟩
  rw [Nat.primeFactors_mul (mul_ne_zero ha.ne' hb.ne') hc.ne',
    Nat.primeFactors_mul ha.ne' hb.ne',
    Finset.card_union_of_disjoint
      (Finset.disjoint_union_left.mpr
        ⟨hca.symm.disjoint_primeFactors, hbc.disjoint_primeFactors⟩),
    Finset.card_union_of_disjoint hab.disjoint_primeFactors]

/-- Three positive entries greater than one would require three distinct primes. -/
theorem one_addend_eq_one {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hadd : a + b = c)
    (hcop : PairwiseCoprimeABC a b c)
    (hcard : (a * b * c).primeFactors.card ≤ 2) :
    a = 1 ∨ b = 1 := by
  by_contra! h
  have ha' : 1 < a := by omega
  have hb' : 1 < b := by omega
  have hc' : 1 < c := by omega
  have hca := Finset.card_pos.mpr (Nat.nonempty_primeFactors.mpr ha')
  have hcb := Finset.card_pos.mpr (Nat.nonempty_primeFactors.mpr hb')
  have hcc := Finset.card_pos.mpr (Nat.nonempty_primeFactors.mpr hc')
  rw [primeFactors_card_mul_three ha hb (by omega) hcop] at hcard
  omega

/-- Two nontrivial coprime factors with at most two primes are actual prime powers. -/
theorem two_prime_powers_of_small_support {b c : ℕ}
    (hb : 1 < b) (hc : 1 < c) (hcop : Nat.Coprime b c)
    (hcard : (b * c).primeFactors.card ≤ 2) :
    ∃ p q u v : ℕ, p.Prime ∧ q.Prime ∧ 0 < u ∧ 0 < v ∧
      p ^ u = b ∧ q ^ v = c ∧ p ≠ q := by
  have hbcard := Finset.card_pos.mpr (Nat.nonempty_primeFactors.mpr hb)
  have hccard := Finset.card_pos.mpr (Nat.nonempty_primeFactors.mpr hc)
  rw [hcop.primeFactors_mul,
    Finset.card_union_of_disjoint hcop.disjoint_primeFactors] at hcard
  have hbp : IsPrimePow b :=
    isPrimePow_iff_card_primeFactors_eq_one.mpr (by omega)
  have hcp : IsPrimePow c :=
    isPrimePow_iff_card_primeFactors_eq_one.mpr (by omega)
  obtain ⟨p, u, hp, hu, hpb⟩ := (isPrimePow_nat_iff b).mp hbp
  obtain ⟨q, v, hq, hv, hqc⟩ := (isPrimePow_nat_iff c).mp hcp
  refine ⟨p, q, u, v, hp, hq, hu, hv, hpb, hqc, ?_⟩
  intro hpq
  have hpdvb : p ∣ b := hpb ▸ dvd_pow_self p hu.ne'
  have hpdvc : p ∣ c := hpq ▸ (hqc ▸ dvd_pow_self q hv.ne')
  exact Finset.disjoint_left.mp hcop.disjoint_primeFactors
    (hp.mem_primeFactors hpdvb (by omega))
    (hp.mem_primeFactors hpdvc (by omega))

/-- An odd integer factor of a power of two is a unit of the integer ring. -/
theorem int_eq_one_or_neg_one_of_dvd_two_pow {z : ℤ} {u : ℕ}
    (hz : ¬(2 : ℤ) ∣ z) (hdiv : z ∣ (2 : ℤ) ^ u) :
    z = 1 ∨ z = -1 := by
  have habsdiv : z.natAbs ∣ 2 ^ u := by
    simpa using Int.natAbs_dvd_natAbs.mpr hdiv
  obtain ⟨k, _, hk⟩ := (Nat.dvd_prime_pow Nat.prime_two).mp habsdiv
  have hkzero : k = 0 := by
    by_contra hkn
    have habseven : 2 ∣ z.natAbs := by
      rw [hk]
      exact dvd_pow_self 2 hkn
    exact hz (Int.natCast_dvd.mpr habseven)
  have habsone : z.natAbs = 1 := by simpa [hkzero] using hk
  simpa using Int.natAbs_eq_iff.mp habsone

/-- For an odd exponent the odd geometric cofactor cannot occur in a power of two. -/
theorem odd_geometric_gap_eq_base_gap {x y : ℤ} {n u : ℕ}
    (hxypos : 0 < x - y) (hxy : (2 : ℤ) ∣ x - y)
    (hx : ¬(2 : ℤ) ∣ x) (hn : Odd n)
    (hgap : x ^ n - y ^ n = (2 : ℤ) ^ u) :
    x ^ n - y ^ n = x - y := by
  let g : ℤ := ∑ i ∈ Finset.range n, x ^ i * y ^ (n - 1 - i)
  have hnnot : ¬(2 : ℤ) ∣ (n : ℤ) := by
    exact_mod_cast hn.not_two_dvd_nat
  have hgnot : ¬(2 : ℤ) ∣ g :=
    not_dvd_geom_sum₂ Int.prime_two hxy hx hnnot
  have hmul : g * (x - y) = x ^ n - y ^ n := geom_sum₂_mul x y n
  have hgdiv : g ∣ (2 : ℤ) ^ u := ⟨x - y, (hmul.trans hgap).symm⟩
  rcases int_eq_one_or_neg_one_of_dvd_two_pow hgnot hgdiv with hg | hg
  · simpa [hg] using hmul.symm
  · have hpos : (0 : ℤ) < 2 ^ u := by positivity
    rw [hg] at hmul
    omega

/-- Odd exponents in q^n + 1 = 2^u must be one. -/
theorem odd_exponent_eq_one_of_pow_add_one {q n u : ℕ}
    (hq : 1 < q) (hqodd : Odd q) (hn : Odd n)
    (heq : q ^ n + 1 = 2 ^ u) : n = 1 := by
  have hx : ¬(2 : ℤ) ∣ (q : ℤ) := by
    exact_mod_cast hqodd.not_two_dvd_nat
  have hxy : (2 : ℤ) ∣ (q : ℤ) - -1 := by
    obtain ⟨k, hk⟩ := hqodd
    have hk' : (q : ℤ) = 2 * (k : ℤ) + 1 := by exact_mod_cast hk
    refine ⟨(k : ℤ) + 1, ?_⟩
    omega
  have hgap : (q : ℤ) ^ n - (-1 : ℤ) ^ n = (2 : ℤ) ^ u := by
    rw [hn.neg_one_pow, sub_neg_eq_add]
    exact_mod_cast heq
  have h := odd_geometric_gap_eq_base_gap
    (x := (q : ℤ)) (y := -1) (by omega) hxy hx hn hgap
  rw [hn.neg_one_pow] at h
  have heqpow : q ^ n = q ^ 1 := by
    have h' : (q : ℤ) ^ n = (q : ℤ) := by linarith
    simpa using (show q ^ n = q from by exact_mod_cast h')
  exact Nat.pow_right_injective (by omega) heqpow

/-- Odd exponents in q^n = 2^u + 1 must be one. -/
theorem odd_exponent_eq_one_of_pow_eq_two_pow_add_one {q n u : ℕ}
    (hq : 1 < q) (hqodd : Odd q) (hn : Odd n)
    (heq : q ^ n = 2 ^ u + 1) : n = 1 := by
  have hx : ¬(2 : ℤ) ∣ (q : ℤ) := by
    exact_mod_cast hqodd.not_two_dvd_nat
  have hxy : (2 : ℤ) ∣ (q : ℤ) - 1 := by
    obtain ⟨k, hk⟩ := hqodd
    have hk' : (q : ℤ) = 2 * (k : ℤ) + 1 := by exact_mod_cast hk
    exact ⟨(k : ℤ), by omega⟩
  have heq' : (q : ℤ) ^ n = (2 : ℤ) ^ u + 1 := by exact_mod_cast heq
  have hgap : (q : ℤ) ^ n - (1 : ℤ) ^ n = (2 : ℤ) ^ u := by
    simpa using (sub_eq_of_eq_add heq')
  have h := odd_geometric_gap_eq_base_gap
    (x := (q : ℤ)) (y := 1) (by omega)
    hxy hx hn hgap
  simp only [one_pow] at h
  have heqpow : q ^ n = q ^ 1 := by
    have h' : (q : ℤ) ^ n = (q : ℤ) := by linarith
    simpa using (show q ^ n = q from by exact_mod_cast h')
  exact Nat.pow_right_injective (by omega) heqpow

/-- An odd square greater than one is never one less than a power of two. -/
theorem odd_square_add_one_ne_two_pow {Q u : ℕ}
    (hQ : 1 < Q) (hQodd : Odd Q) : Q ^ 2 + 1 ≠ 2 ^ u := by
  intro heq
  have hu : 2 ≤ u := by
    by_contra! hu
    interval_cases u <;> norm_num at heq <;> nlinarith
  have hfour : 4 ∣ 2 ^ u := by
    simpa using (pow_dvd_pow (2 : ℕ) hu)
  obtain ⟨m, hm⟩ := hfour
  obtain ⟨k, hk⟩ := hQodd
  rw [hk] at heq
  have hbad : 4 * m = 4 * (k ^ 2 + k) + 2 := by nlinarith
  omega

/-- The only two positive powers of two at distance two are two and four. -/
theorem two_pow_add_two_eq_two_pow {r s : ℕ}
    (hr : 0 < r) (heq : 2 ^ r + 2 = 2 ^ s) :
    r = 1 ∧ s = 2 := by
  have hpow : 2 ≤ 2 ^ r := Nat.le_self_pow hr.ne' 2
  have hs : 2 ≤ s := by
    by_contra! hs
    interval_cases s <;> omega
  have hrone : r = 1 := by
    by_contra hrone
    have hr' : 2 ≤ r := by omega
    have hfourr : 4 ∣ 2 ^ r := by simpa using (pow_dvd_pow (2 : ℕ) hr')
    have hfours : 4 ∣ 2 ^ s := by simpa using (pow_dvd_pow (2 : ℕ) hs)
    obtain ⟨k, hk⟩ := hfourr
    obtain ⟨m, hm⟩ := hfours
    omega
  refine ⟨hrone, Nat.pow_right_injective (a := 2) (by decide) ?_⟩
  norm_num [hrone] at heq
  simpa using heq.symm

/-- The even-exponent equation has exactly the elementary eight-nine exception. -/
theorem even_exponent_exception {q v u : ℕ}
    (hq : q.Prime) (hqne : q ≠ 2) (hv : 0 < v) (heven : Even v)
    (heq : q ^ v = 2 ^ u + 1) :
    q = 3 ∧ v = 2 ∧ u = 3 := by
  obtain ⟨j, hj⟩ := even_iff_two_dvd.mp heven
  have hjpos : 0 < j := by omega
  have hQodd : Odd (q ^ j) := (hq.odd_of_ne_two hqne).pow
  have hQgt : 1 < q ^ j := Nat.one_lt_pow hjpos.ne' hq.one_lt
  have hQge : 3 ≤ q ^ j := by
    have hmod := Nat.odd_iff.mp hQodd
    omega
  have hsquare : q ^ j * q ^ j = 2 ^ u + 1 := by
    have hexp : v = j + j := by omega
    simpa [hexp, pow_add] using heq
  have hfac : (q ^ j - 1) * (q ^ j + 1) = 2 ^ u := by
    have hsub := Nat.sub_add_cancel (show 1 ≤ q ^ j by omega)
    nlinarith
  have hminusdiv : q ^ j - 1 ∣ 2 ^ u := ⟨q ^ j + 1, hfac.symm⟩
  have hplusdiv : q ^ j + 1 ∣ 2 ^ u :=
    ⟨q ^ j - 1, by simpa [mul_comm] using hfac.symm⟩
  obtain ⟨r, _, hminus⟩ := (Nat.dvd_prime_pow Nat.prime_two).mp hminusdiv
  obtain ⟨s, _, hplus⟩ := (Nat.dvd_prime_pow Nat.prime_two).mp hplusdiv
  have hrpos : 0 < r := by
    by_contra! hr
    have hrzero : r = 0 := by omega
    simp only [hrzero, pow_zero] at hminus
    omega
  have hgap : 2 ^ r + 2 = 2 ^ s := by omega
  obtain ⟨hrone, _⟩ := two_pow_add_two_eq_two_pow hrpos hgap
  have hqj : q ^ j = 3 := by
    norm_num [hrone] at hminus
    omega
  have hqdiv : q ∣ 3 := hqj ▸ dvd_pow_self q hjpos.ne'
  have hqthree : q = 3 := (Nat.prime_dvd_prime_iff_eq hq Nat.prime_three).mp hqdiv
  have hjone : j = 1 := by
    apply Nat.pow_right_injective (a := 3) (by decide)
    simpa [hqthree] using hqj
  have hvtwo : v = 2 := by omega
  refine ⟨hqthree, hvtwo, Nat.pow_right_injective (a := 2) (by decide) ?_⟩
  norm_num [hqthree, hvtwo] at heq
  norm_num
  omega

/-- If an odd prime power is immediately below a power of two, its exponent is one. -/
theorem exponent_eq_one_of_prime_pow_add_one {q v u : ℕ}
    (hq : q.Prime) (hqne : q ≠ 2) (hv : 0 < v)
    (heq : q ^ v + 1 = 2 ^ u) : v = 1 := by
  rcases Nat.even_or_odd v with heven | hodd
  · obtain ⟨j, hj⟩ := even_iff_two_dvd.mp heven
    have hjpos : 0 < j := by omega
    have hpow : (q ^ j) ^ 2 = q ^ v := by
      rw [← pow_mul]
      congr 1
      omega
    exact False.elim
      (odd_square_add_one_ne_two_pow
        (Nat.one_lt_pow hjpos.ne' hq.one_lt)
        (hq.odd_of_ne_two hqne).pow (by simpa [hpow] using heq))
  · exact odd_exponent_eq_one_of_pow_add_one hq.one_lt
      (hq.odd_of_ne_two hqne) hodd heq

/-- The other ordering has exponent one, or the unique eight-nine exception. -/
theorem exponent_eq_one_or_eight_nine {q v u : ℕ}
    (hq : q.Prime) (hqne : q ≠ 2) (hv : 0 < v)
    (heq : q ^ v = 2 ^ u + 1) :
    v = 1 ∨ (q = 3 ∧ v = 2 ∧ u = 3) := by
  rcases Nat.even_or_odd v with heven | hodd
  · exact Or.inr (even_exponent_exception hq hqne hv heven heq)
  · exact Or.inl (odd_exponent_eq_one_of_pow_eq_two_pow_add_one
      hq.one_lt (hq.odd_of_ne_two hqne) hodd heq)

/-- Consecutiveness identifies one prime base as two, without assuming a classification. -/
theorem power_two_and_odd_prime_power {b c : ℕ}
    (hb : 1 < b) (hadd : b + 1 = c) (hcop : Nat.Coprime b c)
    (hcard : (b * c).primeFactors.card ≤ 2) :
    ∃ q u v : ℕ, q.Prime ∧ q ≠ 2 ∧ 0 < u ∧ 0 < v ∧
      ((b = 2 ^ u ∧ c = q ^ v) ∨ (b = q ^ v ∧ c = 2 ^ u)) := by
  obtain ⟨p, q, u, v, hp, hq, hu, hv, hpb, hqc, hpq⟩ :=
    two_prime_powers_of_small_support hb (by omega) hcop hcard
  have htwo : 2 ∣ b ∨ 2 ∣ c := by
    simp only [Nat.dvd_iff_mod_eq_zero]
    omega
  rcases htwo with hbdiv | hcdiv
  · have htwop : 2 ∣ p := Nat.prime_two.dvd_of_dvd_pow (hpb.symm ▸ hbdiv)
    have hp2 : p = 2 :=
      ((Nat.prime_dvd_prime_iff_eq Nat.prime_two hp).mp htwop).symm
    refine ⟨q, u, v, hq, (by omega), hu, hv, Or.inl ⟨?_, hqc.symm⟩⟩
    simpa [hp2] using hpb.symm
  · have htwoq : 2 ∣ q := Nat.prime_two.dvd_of_dvd_pow (hqc.symm ▸ hcdiv)
    have hq2 : q = 2 :=
      ((Nat.prime_dvd_prime_iff_eq Nat.prime_two hq).mp htwoq).symm
    refine ⟨p, v, u, hp, (by omega), hv, hu, Or.inr ⟨hpb.symm, ?_⟩⟩
    simpa [hq2] using hqc.symm

/-- The repository radical is exactly twice the odd prime for this support. -/
theorem radical_two_prime_powers {q u v : ℕ}
    (hq : q.Prime) (hqne : q ≠ 2) (hu : 0 < u) (hv : 0 < v) :
    abcRadical (2 ^ u * q ^ v) = 2 * q := by
  unfold abcRadical
  rw [Nat.primeFactors_mul (pow_ne_zero _ (by decide : (2 : ℕ) ≠ 0))
      (pow_ne_zero _ hq.ne_zero),
    Nat.primeFactors_prime_pow hu.ne' Nat.prime_two,
    Nat.primeFactors_prime_pow hv.ne' hq]
  simp [Ne.symm hqne]

/-- The exact radical of the exceptional product, using the proved support formula. -/
theorem radical_seventy_two : abcRadical 72 = 6 := by
  simpa using radical_two_prime_powers (q := 3) (u := 3) (v := 2)
    Nat.prime_three (by decide) (by decide) (by decide)

/-- Full one-addend classification, starting from support rather than prime-power data. -/
theorem one_addend_bound_or_exception {b c : ℕ}
    (hb : 0 < b) (hadd : 1 + b = c) (hcop : Nat.Coprime b c)
    (hcard : (b * c).primeFactors.card ≤ 2) :
    c ≤ abcRadical (b * c) ∨ (b = 8 ∧ c = 9) := by
  by_cases hb1 : b = 1
  · subst b
    have hc2 : c = 2 := by omega
    subst c
    left
    change 2 ≤ abcRadical 2
    simp [abcRadical, Nat.prime_two.primeFactors]
  · obtain ⟨q, u, v, hq, hqne, hu, hv, hcase⟩ :=
      power_two_and_odd_prime_power (by omega) (by omega) hcop hcard
    rcases hcase with ⟨hbpow, hcpow⟩ | ⟨hbpow, hcpow⟩
    · have heq : q ^ v = 2 ^ u + 1 := by omega
      rcases exponent_eq_one_or_eight_nine hq hqne hv heq with hvone | hex
      · left
        have hrad : abcRadical (b * c) = 2 * q := by
          rw [hbpow, hcpow]
          exact radical_two_prime_powers hq hqne hu hv
        rw [hrad, hcpow, hvone, pow_one]
        omega
      · obtain ⟨hqthree, hvtwo, huthree⟩ := hex
        right
        norm_num [hbpow, hcpow, hqthree, hvtwo, huthree]
    · have heq : q ^ v + 1 = 2 ^ u := by omega
      have hvone := exponent_eq_one_of_prime_pow_add_one hq hqne hv heq
      have hrad : abcRadical (b * c) = 2 * q := by
        rw [hbpow, hcpow, mul_comm]
        exact radical_two_prime_powers hq hqne hu hv
      have hcq : c = q + 1 := by
        simpa [hbpow, hvone, Nat.add_comm] using hadd.symm
      left
      rw [hrad, hcq]
      have hqpos := hq.pos
      omega

/-- Every actual primitive triple on at most two primes is regular or one of two exceptions. -/
theorem radical_bound_or_exception {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hadd : a + b = c)
    (hcop : PairwiseCoprimeABC a b c)
    (hcard : (a * b * c).primeFactors.card ≤ 2) :
    c ≤ abcRadical (a * b * c) ∨
      (a = 1 ∧ b = 8 ∧ c = 9) ∨ (a = 8 ∧ b = 1 ∧ c = 9) := by
  rcases one_addend_eq_one ha hb hadd hcop hcard with ha1 | hb1
  · subst a
    have hcard' : (b * c).primeFactors.card ≤ 2 := by simpa using hcard
    rcases one_addend_bound_or_exception hb hadd hcop.2.1 hcard' with hle | hex
    · exact Or.inl (by simpa using hle)
    · exact Or.inr (Or.inl ⟨rfl, hex⟩)
  · subst b
    have hcard' : (a * c).primeFactors.card ≤ 2 := by simpa using hcard
    rcases one_addend_bound_or_exception ha (by omega) hcop.2.2.symm hcard'
      with hle | hex
    · exact Or.inl (by simpa using hle)
    · exact Or.inr (Or.inr ⟨hex.1, rfl, hex.2⟩)

/-- Outside the two exceptional ordered triples, the larger endpoint is at most the radical. -/
theorem c_le_radical_of_not_exception {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hadd : a + b = c)
    (hcop : PairwiseCoprimeABC a b c)
    (hcard : (a * b * c).primeFactors.card ≤ 2)
    (hnot₁ : ¬(a = 1 ∧ b = 8 ∧ c = 9))
    (hnot₂ : ¬(a = 8 ∧ b = 1 ∧ c = 9)) :
    c ≤ abcRadical (a * b * c) := by
  rcases radical_bound_or_exception ha hb hadd hcop hcard with hle | hex₁ | hex₂
  · exact hle
  · exact False.elim (hnot₁ hex₁)
  · exact False.elim (hnot₂ hex₂)

/-- The unconditional sharp bound c ≤ (3/2) rad(abc) on the complete two-prime subclass. -/
theorem two_mul_c_le_three_mul_radical {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hadd : a + b = c)
    (hcop : PairwiseCoprimeABC a b c)
    (hcard : (a * b * c).primeFactors.card ≤ 2) :
    2 * c ≤ 3 * abcRadical (a * b * c) := by
  rcases radical_bound_or_exception ha hb hadd hcop hcard with hle | hex₁ | hex₂
  · omega
  · rcases hex₁ with ⟨rfl, rfl, rfl⟩
    norm_num [radical_seventy_two]
  · rcases hex₂ with ⟨rfl, rfl, rfl⟩
    norm_num [radical_seventy_two]

/-- Equality in the sharp bound identifies exactly the eight-nine triples. -/
theorem two_mul_c_eq_three_mul_radical_iff {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hadd : a + b = c)
    (hcop : PairwiseCoprimeABC a b c)
    (hcard : (a * b * c).primeFactors.card ≤ 2) :
    2 * c = 3 * abcRadical (a * b * c) ↔
      (a = 1 ∧ b = 8 ∧ c = 9) ∨ (a = 8 ∧ b = 1 ∧ c = 9) := by
  constructor
  · intro heq
    rcases radical_bound_or_exception ha hb hadd hcop hcard with hle | hex₁ | hex₂
    · omega
    · exact Or.inl hex₁
    · exact Or.inr hex₂
  · rintro (⟨rfl, rfl, rfl⟩ | ⟨rfl, rfl, rfl⟩) <;>
      norm_num [radical_seventy_two]

/-- The usual single gcd assumption and the sum equation imply pairwise coprimality. -/
theorem pairwise_coprime_of_add {a b c : ℕ}
    (hadd : a + b = c) (hcop : Nat.Coprime a b) :
    PairwiseCoprimeABC a b c := by
  subst c
  exact ⟨hcop, Nat.coprime_add_self_right.mpr hcop.symm,
    Nat.coprime_self_add_left.mpr hcop.symm⟩

/-- The sharp result also accepts the standard primitive hypothesis gcd(a,b)=1 directly. -/
theorem two_mul_c_le_three_mul_radical_of_coprime {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hadd : a + b = c)
    (hcop : Nat.Coprime a b)
    (hcard : (a * b * c).primeFactors.card ≤ 2) :
    2 * c ≤ 3 * abcRadical (a * b * c) :=
  two_mul_c_le_three_mul_radical ha hb hadd (pairwise_coprime_of_add hadd hcop) hcard

end IUTThreeClosures.ABCTwoPrimeSupport20260831
