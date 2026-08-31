/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArithmeticLeibnizWronskian
import Mathlib.Tactic

/-!
# Exact quantization of the arithmetic Wronskian lattice

The arithmetic Leibniz--Wronskian bridge uses integer values divisible by the
three powerful parts.  This file identifies the quotient lattice exactly.

Write

`r_a = rad(a)`, `q_a = a / rad(a)`

and similarly for `b,c`.  For quotient variables `u,v`, compatibility

`q_a u + q_b v = 0 (mod q_c)`

is equivalent to the determinant congruence

`r_a v - r_b u = 0 (mod q_c)`.

Moreover

`W(q_a u,q_b v) = q_a q_b (r_a v-r_b u)`.

Thus every nonzero Wronskian is quantized by the full powerful product.  The
lower divisibility bound is sharp: for every primitive positive abc point
there are compatible derivative values whose Wronskian is exactly
`q_a q_b q_c`.

This is a structural audit, not an abc estimate.  It shows that the algebraic
Wronskian divisibility step contains no hidden factor from which an abc gain
could be extracted; any gain must come from a genuinely quantitative upper
bound for a normalized representative of this lattice.
-/

namespace IUTThreeClosures
namespace ArithmeticWronskianQuantization

open UniqueFactorizationMonoid

noncomputable section

namespace ABCPoint

/-- Radicals of the two coprime summands remain coprime. -/
theorem wronskianQuantization_coprime_radical_a_b (P : ABCPoint) :
    Nat.Coprime (abcRadical P.a) (abcRadical P.b) := by
  apply Nat.Coprime.of_dvd
    (show abcRadical P.a ∣ P.a by
      rw [abcRadical_eq_natRadical]
      exact radical_dvd_self)
    (show abcRadical P.b ∣ P.b by
      rw [abcRadical_eq_natRadical]
      exact radical_dvd_self)
    P.pairwise_coprime.1

/-- The radical of `b` is coprime to the powerful part of `c`. -/
theorem wronskianQuantization_coprime_radical_b_powerful_c
    (P : ABCPoint) :
    Nat.Coprime (abcRadical P.b) (abcPowerfulPart P.c) := by
  apply Nat.Coprime.of_dvd
    (show abcRadical P.b ∣ P.b by
      rw [abcRadical_eq_natRadical]
      exact radical_dvd_self)
    (abcPowerfulPart_dvd P.c)
    P.pairwise_coprime.2.1

/-- Exact congruence criterion for compatible quotient derivative values. -/
theorem powerful_c_dvd_quotientSum_iff_dvd_radicalDeterminant
    (P : ABCPoint) (u v : ℤ) :
    (abcPowerfulPart P.c : ℤ) ∣
        (abcPowerfulPart P.a : ℤ) * u +
          (abcPowerfulPart P.b : ℤ) * v ↔
      (abcPowerfulPart P.c : ℤ) ∣
        (abcRadical P.a : ℤ) * v -
          (abcRadical P.b : ℤ) * u := by
  constructor
  · intro hsum
    have hcdiv : (abcPowerfulPart P.c : ℤ) ∣ (P.c : ℤ) := by
      exact_mod_cast abcPowerfulPart_dvd P.c
    have hid :
        (abcPowerfulPart P.a : ℤ) *
            ((abcRadical P.a : ℤ) * v -
              (abcRadical P.b : ℤ) * u) =
          (P.c : ℤ) * v -
            (abcRadical P.b : ℤ) *
              ((abcPowerfulPart P.a : ℤ) * u +
                (abcPowerfulPart P.b : ℤ) * v) := by
      have ha :
          (abcRadical P.a : ℤ) * (abcPowerfulPart P.a : ℤ) =
            (P.a : ℤ) := by
        exact_mod_cast abcRadical_mul_abcPowerfulPart P.a
      have hb :
          (abcRadical P.b : ℤ) * (abcPowerfulPart P.b : ℤ) =
            (P.b : ℤ) := by
        exact_mod_cast abcRadical_mul_abcPowerfulPart P.b
      have habc : (P.a : ℤ) + P.b = P.c := by
        exact_mod_cast P.sum_eq
      rw [← habc]
      rw [← ha, ← hb]
      ring
    have hmul :
        (abcPowerfulPart P.c : ℤ) ∣
          (abcPowerfulPart P.a : ℤ) *
            ((abcRadical P.a : ℤ) * v -
              (abcRadical P.b : ℤ) * u) := by
      rw [hid]
      exact dvd_sub
        (dvd_mul_of_dvd_left hcdiv v)
        (dvd_mul_of_dvd_right hsum (abcRadical P.b : ℤ))
    have hcop : IsCoprime
        (abcPowerfulPart P.c : ℤ)
        (abcPowerfulPart P.a : ℤ) :=
      P.coprime_powerfulPart_a_c.symm.isCoprime
    exact hcop.dvd_of_dvd_mul_left hmul
  · intro hdet
    have hcdiv : (abcPowerfulPart P.c : ℤ) ∣ (P.c : ℤ) := by
      exact_mod_cast abcPowerfulPart_dvd P.c
    have hid :
        (abcRadical P.b : ℤ) *
            ((abcPowerfulPart P.a : ℤ) * u +
              (abcPowerfulPart P.b : ℤ) * v) =
          (P.c : ℤ) * v -
            (abcPowerfulPart P.a : ℤ) *
              ((abcRadical P.a : ℤ) * v -
                (abcRadical P.b : ℤ) * u) := by
      have ha :
          (abcRadical P.a : ℤ) * (abcPowerfulPart P.a : ℤ) =
            (P.a : ℤ) := by
        exact_mod_cast abcRadical_mul_abcPowerfulPart P.a
      have hb :
          (abcRadical P.b : ℤ) * (abcPowerfulPart P.b : ℤ) =
            (P.b : ℤ) := by
        exact_mod_cast abcRadical_mul_abcPowerfulPart P.b
      have habc : (P.a : ℤ) + P.b = P.c := by
        exact_mod_cast P.sum_eq
      rw [← habc]
      rw [← ha, ← hb]
      ring
    have hmul :
        (abcPowerfulPart P.c : ℤ) ∣
          (abcRadical P.b : ℤ) *
            ((abcPowerfulPart P.a : ℤ) * u +
              (abcPowerfulPart P.b : ℤ) * v) := by
      rw [hid]
      exact dvd_sub
        (dvd_mul_of_dvd_left hcdiv v)
        (dvd_mul_of_dvd_right hdet (abcPowerfulPart P.a : ℤ))
    have hcop : IsCoprime
        (abcPowerfulPart P.c : ℤ)
        (abcRadical P.b : ℤ) :=
      P.wronskianQuantization_coprime_radical_b_powerful_c.symm.isCoprime
    exact hcop.dvd_of_dvd_mul_left hmul

/-- Exact factorization of the Wronskian through the quotient determinant. -/
theorem arithmeticWronskian_powerfulQuotients
    (P : ABCPoint) (u v : ℤ) :
    arithmeticWronskian P
        ((abcPowerfulPart P.a : ℤ) * u)
        ((abcPowerfulPart P.b : ℤ) * v) =
      (abcPowerfulPart P.a : ℤ) *
        (abcPowerfulPart P.b : ℤ) *
          ((abcRadical P.a : ℤ) * v -
            (abcRadical P.b : ℤ) * u) := by
  have ha :
      (abcRadical P.a : ℤ) * (abcPowerfulPart P.a : ℤ) =
        (P.a : ℤ) := by
    exact_mod_cast abcRadical_mul_abcPowerfulPart P.a
  have hb :
      (abcRadical P.b : ℤ) * (abcPowerfulPart P.b : ℤ) =
        (P.b : ℤ) := by
    exact_mod_cast abcRadical_mul_abcPowerfulPart P.b
  unfold arithmeticWronskian
  rw [← ha, ← hb]
  ring

/-- Every compatible quotient pair has a Wronskian equal to the full powerful
product times an integer index. -/
theorem exists_wronskianIndex_of_compatibleQuotients
    (P : ABCPoint) (u v : ℤ)
    (hcompat :
      (abcPowerfulPart P.c : ℤ) ∣
        (abcPowerfulPart P.a : ℤ) * u +
          (abcPowerfulPart P.b : ℤ) * v) :
    ∃ t : ℤ,
      arithmeticWronskian P
          ((abcPowerfulPart P.a : ℤ) * u)
          ((abcPowerfulPart P.b : ℤ) * v) =
        (abcPowerfulPart P.a : ℤ) *
          (abcPowerfulPart P.b : ℤ) *
            (abcPowerfulPart P.c : ℤ) * t := by
  have hdet :=
    (P.powerful_c_dvd_quotientSum_iff_dvd_radicalDeterminant u v).1 hcompat
  obtain ⟨t, ht⟩ := hdet
  refine ⟨t, ?_⟩
  rw [P.arithmeticWronskian_powerfulQuotients u v, ht]
  ring

/-- Sharpness: every primitive positive abc point admits compatible derivative
values with Wronskian exactly the full powerful product. -/
theorem exists_compatibleDerivative_minimalWronskian (P : ABCPoint) :
    ∃ Da Db Dc : ℤ,
      Da + Db = Dc ∧
      (abcPowerfulPart P.a : ℤ) ∣ Da ∧
      (abcPowerfulPart P.b : ℤ) ∣ Db ∧
      (abcPowerfulPart P.c : ℤ) ∣ Dc ∧
      arithmeticWronskian P Da Db =
        (abcPowerfulPart P.a : ℤ) *
          (abcPowerfulPart P.b : ℤ) *
            (abcPowerfulPart P.c : ℤ) := by
  let ra := abcRadical P.a
  let rb := abcRadical P.b
  let qc := abcPowerfulPart P.c
  let u : ℤ := -(qc : ℤ) * Nat.gcdB ra rb
  let v : ℤ := (qc : ℤ) * Nat.gcdA ra rb
  have hcop : Nat.Coprime ra rb := by
    simpa [ra, rb] using P.wronskianQuantization_coprime_radical_a_b
  have hbez :
      (1 : ℤ) = (ra : ℤ) * Nat.gcdA ra rb +
        (rb : ℤ) * Nat.gcdB ra rb := by
    have h := Nat.gcd_eq_gcd_ab ra rb
    rw [hcop] at h
    exact h
  have hdet :
      (abcRadical P.a : ℤ) * v -
          (abcRadical P.b : ℤ) * u =
        (abcPowerfulPart P.c : ℤ) := by
    dsimp [u, v, ra, rb, qc]
    linear_combination (abcPowerfulPart P.c : ℤ) * hbez
  have hdetDiv :
      (abcPowerfulPart P.c : ℤ) ∣
        (abcRadical P.a : ℤ) * v -
          (abcRadical P.b : ℤ) * u := by
    rw [hdet]
  have hsumDiv :
      (abcPowerfulPart P.c : ℤ) ∣
        (abcPowerfulPart P.a : ℤ) * u +
          (abcPowerfulPart P.b : ℤ) * v :=
    (P.powerful_c_dvd_quotientSum_iff_dvd_radicalDeterminant u v).2 hdetDiv
  obtain ⟨w, hw⟩ := hsumDiv
  refine ⟨
    (abcPowerfulPart P.a : ℤ) * u,
    (abcPowerfulPart P.b : ℤ) * v,
    (abcPowerfulPart P.c : ℤ) * w,
    ?_, ?_, ?_, ?_, ?_⟩
  · exact hw
  · exact ⟨u, rfl⟩
  · exact ⟨v, rfl⟩
  · exact ⟨w, rfl⟩
  · rw [P.arithmeticWronskian_powerfulQuotients u v, hdet]

end ABCPoint

#print axioms ABCPoint.powerful_c_dvd_quotientSum_iff_dvd_radicalDeterminant
#print axioms ABCPoint.arithmeticWronskian_powerfulQuotients
#print axioms ABCPoint.exists_wronskianIndex_of_compatibleQuotients
#print axioms ABCPoint.exists_compatibleDerivative_minimalWronskian

end
end ArithmeticWronskianQuantization
end IUTThreeClosures
