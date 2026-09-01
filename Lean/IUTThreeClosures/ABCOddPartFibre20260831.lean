/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NonCircularDownstream
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.SetTheory.Cardinal.Finite
import Mathlib.Tactic.NormNum

/-!
# The exact size of a fibre of labelled odd parts

The elementary mathematical proof precedes this file in
research/ABC_ODD_PART_FIBRE_FORMAL_PROOFS_2026_08_31.md.

The odd parts are computed from the actual natural-number factorization,
and the points use the unchanged canonical ABCPoint structure. No transport,
orbit-membership, or abc conjecture is assumed. The bound two is attained
by the actual primitive triples (4,3,7) and (1,6,7).
-/

namespace IUTThreeClosures.ABCOddPartFibre20260831

/-- The actual odd part; the factorization convention also gives oddPart 0 = 0. -/
def oddPart (n : ℕ) : ℕ := ordCompl[2] n

theorem oddPart_le (n : ℕ) : oddPart n ≤ n := Nat.ordCompl_le n 2

theorem oddPart_eq_self_of_odd {n : ℕ} (hn : n % 2 = 1) : oddPart n = n := by
  apply (Nat.ordCompl_eq_self_iff_zero_or_not_dvd n Nat.prime_two).mpr
  right
  simp [Nat.dvd_iff_mod_eq_zero, hn]

theorem oddPart_lt_self_of_even {n : ℕ} (hn : 0 < n) (heven : n % 2 = 0) :
    oddPart n < n := by
  have hne : oddPart n ≠ n := by
    intro heq
    rcases (Nat.ordCompl_eq_self_iff_zero_or_not_dvd n Nat.prime_two).mp heq with
      hzero | hnot
    · omega
    · exact hnot (Nat.dvd_of_mod_eq_zero heven)
  exact lt_of_le_of_ne (oddPart_le n) hne

/-- The three natural-number coordinates determine a point, including its proof fields. -/
theorem point_eq_of_coordinates {P Q : ABCPoint}
    (ha : P.a = Q.a) (hb : P.b = Q.b) (hc : P.c = Q.c) : P = Q := by
  cases P
  cases Q
  cases ha
  cases hb
  cases hc
  rfl

/-- Exactly one endpoint of a primitive abc triple is even. -/
theorem parity_cases (P : ABCPoint) :
    (P.a % 2 = 0 ∧ P.b % 2 = 1 ∧ P.c % 2 = 1) ∨
    (P.a % 2 = 1 ∧ P.b % 2 = 0 ∧ P.c % 2 = 1) ∨
    (P.a % 2 = 1 ∧ P.b % 2 = 1 ∧ P.c % 2 = 0) := by
  have hnot : ¬(P.a % 2 = 0 ∧ P.b % 2 = 0) := by
    rintro ⟨ha, hb⟩
    have hd := Nat.dvd_gcd (Nat.dvd_of_mod_eq_zero ha) (Nat.dvd_of_mod_eq_zero hb)
    have hcop : Nat.gcd P.a P.b = 1 := P.pairwise_coprime.1
    rw [hcop] at hd
    norm_num at hd
  have hsum := P.sum_eq
  omega

/-- Equality of all three labelled, actual odd parts. -/
def SameOddParts (P Q : ABCPoint) : Prop :=
  oddPart P.a = oddPart Q.a ∧ oddPart P.b = oddPart Q.b ∧ oddPart P.c = oddPart Q.c

theorem sameOddParts_symm {P Q : ABCPoint} (h : SameOddParts P Q) :
    SameOddParts Q P := ⟨h.1.symm, h.2.1.symm, h.2.2.symm⟩

theorem eq_of_sameOddParts_even_a {P Q : ABCPoint}
    (h : SameOddParts P Q) (hp : P.a % 2 = 0) (hq : Q.a % 2 = 0) : P = Q := by
  have hP := parity_cases P
  have hQ := parity_cases Q
  have hbP := oddPart_eq_self_of_odd (n := P.b) (by omega)
  have hcP := oddPart_eq_self_of_odd (n := P.c) (by omega)
  have hbQ := oddPart_eq_self_of_odd (n := Q.b) (by omega)
  have hcQ := oddPart_eq_self_of_odd (n := Q.c) (by omega)
  have hb : P.b = Q.b := by simpa only [hbP, hbQ] using h.2.1
  have hc : P.c = Q.c := by simpa only [hcP, hcQ] using h.2.2
  have hsumP := P.sum_eq
  have hsumQ := Q.sum_eq
  exact point_eq_of_coordinates (by omega) hb hc

theorem eq_of_sameOddParts_even_b {P Q : ABCPoint}
    (h : SameOddParts P Q) (hp : P.b % 2 = 0) (hq : Q.b % 2 = 0) : P = Q := by
  have hP := parity_cases P
  have hQ := parity_cases Q
  have haP := oddPart_eq_self_of_odd (n := P.a) (by omega)
  have hcP := oddPart_eq_self_of_odd (n := P.c) (by omega)
  have haQ := oddPart_eq_self_of_odd (n := Q.a) (by omega)
  have hcQ := oddPart_eq_self_of_odd (n := Q.c) (by omega)
  have ha : P.a = Q.a := by simpa only [haP, haQ] using h.1
  have hc : P.c = Q.c := by simpa only [hcP, hcQ] using h.2.2
  have hsumP := P.sum_eq
  have hsumQ := Q.sum_eq
  exact point_eq_of_coordinates ha (by omega) hc

theorem eq_of_sameOddParts_even_c {P Q : ABCPoint}
    (h : SameOddParts P Q) (hp : P.c % 2 = 0) (hq : Q.c % 2 = 0) : P = Q := by
  have hP := parity_cases P
  have hQ := parity_cases Q
  have haP := oddPart_eq_self_of_odd (n := P.a) (by omega)
  have hbP := oddPart_eq_self_of_odd (n := P.b) (by omega)
  have haQ := oddPart_eq_self_of_odd (n := Q.a) (by omega)
  have hbQ := oddPart_eq_self_of_odd (n := Q.b) (by omega)
  have ha : P.a = Q.a := by simpa only [haP, haQ] using h.1
  have hb : P.b = Q.b := by simpa only [hbP, hbQ] using h.2.1
  have hsumP := P.sum_eq
  have hsumQ := Q.sum_eq
  exact point_eq_of_coordinates ha hb (by omega)

/-- In one fibre a point with even b cannot coexist with a point with even c. -/
theorem not_sameOddParts_even_b_even_c {P Q : ABCPoint}
    (hp : P.b % 2 = 0) (hq : Q.c % 2 = 0) : ¬SameOddParts P Q := by
  intro h
  have hP := parity_cases P
  have hQ := parity_cases Q
  have haP := oddPart_eq_self_of_odd (n := P.a) (by omega)
  have hcP := oddPart_eq_self_of_odd (n := P.c) (by omega)
  have haQ := oddPart_eq_self_of_odd (n := Q.a) (by omega)
  have hbQ := oddPart_eq_self_of_odd (n := Q.b) (by omega)
  have hbP := oddPart_lt_self_of_even P.b_pos hp
  have hcQ := oddPart_lt_self_of_even Q.c_pos hq
  have hsumP := P.sum_eq
  have hsumQ := Q.sum_eq
  rcases h with ⟨ha, hb, hc⟩
  omega

/-- Equality of a modulo two, in addition to the odd parts, determines the entire point. -/
theorem eq_of_sameOddParts_mod_a {P Q : ABCPoint}
    (h : SameOddParts P Q) (hmod : P.a % 2 = Q.a % 2) : P = Q := by
  rcases parity_cases P with hP | hP | hP
  · exact eq_of_sameOddParts_even_a h hP.1 (by omega)
  · rcases parity_cases Q with hQ | hQ | hQ
    · omega
    · exact eq_of_sameOddParts_even_b h hP.2.1 hQ.2.1
    · exact False.elim (not_sameOddParts_even_b_even_c hP.2.1 hQ.2.2 h)
  · rcases parity_cases Q with hQ | hQ | hQ
    · omega
    · exact False.elim
        (not_sameOddParts_even_b_even_c hQ.2.1 hP.2.2 (sameOddParts_symm h))
    · exact eq_of_sameOddParts_even_c h hP.2.2 hQ.2.2

/-- The actual fibre over three labelled odd parts, including possibly empty fibres. -/
def Fibre (A B C : ℕ) :=
  {P : ABCPoint // oddPart P.a = A ∧ oddPart P.b = B ∧ oddPart P.c = C}

/-- A parity coordinate taking values in an actual two-element type. -/
def parityMap {A B C : ℕ} (P : Fibre A B C) : Fin 2 :=
  ⟨P.val.a % 2, Nat.mod_lt _ (by decide)⟩

theorem parityMap_injective (A B C : ℕ) :
    Function.Injective (@parityMap A B C) := by
  intro P Q heq
  apply Subtype.ext
  apply eq_of_sameOddParts_mod_a
  · exact ⟨P.property.1.trans Q.property.1.symm,
      P.property.2.1.trans Q.property.2.1.symm,
      P.property.2.2.trans Q.property.2.2.symm⟩
  · exact congrArg Fin.val heq

instance fibreFinite (A B C : ℕ) : Finite (Fibre A B C) :=
  Finite.of_injective parityMap (parityMap_injective A B C)

/-- A uniform cardinality bound for the complete, unrestricted arithmetic fibre. -/
theorem fibre_card_le_two (A B C : ℕ) : Nat.card (Fibre A B C) ≤ 2 := by
  simpa using Nat.card_le_card_of_injective parityMap (parityMap_injective A B C)

/-- The first actual primitive point attaining the bound. -/
def exampleP : ABCPoint where
  a := 4
  b := 3
  c := 7
  a_pos := by decide
  b_pos := by decide
  c_pos := by decide
  sum_eq := by decide
  pairwise_coprime := by
    change Nat.Coprime 4 3 ∧ Nat.Coprime 3 7 ∧ Nat.Coprime 7 4
    decide

/-- The second actual primitive point attaining the bound. -/
def exampleQ : ABCPoint where
  a := 1
  b := 6
  c := 7
  a_pos := by decide
  b_pos := by decide
  c_pos := by decide
  sum_eq := by decide
  pairwise_coprime := by
    change Nat.Coprime 1 6 ∧ Nat.Coprime 6 7 ∧ Nat.Coprime 7 1
    decide

theorem exampleP_oddParts :
    oddPart exampleP.a = 1 ∧ oddPart exampleP.b = 3 ∧ oddPart exampleP.c = 7 := by
  change oddPart 4 = 1 ∧ oddPart 3 = 3 ∧ oddPart 7 = 7
  refine ⟨?_, oddPart_eq_self_of_odd (by decide), oddPart_eq_self_of_odd (by decide)⟩
  simpa [oddPart] using Nat.ordCompl_self_pow (p := 2) (k := 2) Nat.prime_two

theorem exampleQ_oddParts :
    oddPart exampleQ.a = 1 ∧ oddPart exampleQ.b = 3 ∧ oddPart exampleQ.c = 7 := by
  change oddPart 1 = 1 ∧ oddPart 6 = 3 ∧ oddPart 7 = 7
  refine ⟨oddPart_eq_self_of_odd (by decide), ?_, oddPart_eq_self_of_odd (by decide)⟩
  simpa [oddPart] using
    Nat.ordCompl_pow_mul_of_not_dvd (m := 3) 1 Nat.prime_two (by decide)

theorem exampleP_ne_exampleQ : exampleP ≠ exampleQ := by
  intro h
  have := congrArg ABCPoint.a h
  norm_num [exampleP, exampleQ] at this

/-- The sharp fibre contains exactly these two actual points. -/
theorem fibre_one_three_seven_classification (P : Fibre 1 3 7) :
    P.val = exampleP ∨ P.val = exampleQ := by
  by_cases heven : P.val.a % 2 = 0
  · left
    apply eq_of_sameOddParts_mod_a
    · exact ⟨P.property.1.trans exampleP_oddParts.1.symm,
        P.property.2.1.trans exampleP_oddParts.2.1.symm,
        P.property.2.2.trans exampleP_oddParts.2.2.symm⟩
    · simpa [exampleP] using heven
  · right
    apply eq_of_sameOddParts_mod_a
    · exact ⟨P.property.1.trans exampleQ_oddParts.1.symm,
        P.property.2.1.trans exampleQ_oddParts.2.1.symm,
        P.property.2.2.trans exampleQ_oddParts.2.2.symm⟩
    · change P.val.a % 2 = 1
      omega

/-- The number two is attained; the bound is not merely a consequence of empty fibres. -/
theorem fibre_one_three_seven_card : Nat.card (Fibre 1 3 7) = 2 := by
  apply Nat.card_eq_two_iff.mpr
  refine ⟨⟨exampleP, exampleP_oddParts⟩, ⟨exampleQ, exampleQ_oddParts⟩, ?_, ?_⟩
  · intro h
    exact exampleP_ne_exampleQ (congrArg Subtype.val h)
  · ext P
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff, Set.mem_univ, iff_true]
    rcases fibre_one_three_seven_classification P with hp | hq
    · exact Or.inl (Subtype.ext hp)
    · exact Or.inr (Subtype.ext hq)

end IUTThreeClosures.ABCOddPartFibre20260831
