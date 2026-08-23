/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyJHeightCorridor
import IUTThreeClosures.ShiftedJNonCMLargeImageReduction

/-!
# The Frey curve is non-CM outside an explicit finite set

The shifted-j curve gives a visibly nonintegral rational j-invariant, but it
is not the curve used by the already formalized Frey height and conductor
comparisons.  This module keeps the genuine integral Frey curve.

For an abc point `P`, its reduced j-denominator satisfies

`freyJReducedDen(P) * freyJContent(P) = (a*b*c)^2`,

while `freyJContent(P) ∣ 256`.  Therefore, if the rational Frey j-invariant is
an integer, its reduced denominator is one and hence `(a*b*c)^2 ≤ 256`.  In
particular `c ≤ 256`.

Consequently all possible integral-j, hence all possible CM, Frey curves lie
in the explicit finite set of abc points with `c ≤ 256`.  Outside this set,
CM j-integrality and Serre open image give eventual large mod-ell image for
the actual Frey curve.  The elementary prime-selection layer then yields a
large-image prime above any prescribed lower bound and simultaneously prime
to any finite family of nonzero local orders.

The only external arithmetic inputs remain exactly the two fields of
`RationalCMOpenImagePackage`: CM j-integrality and Serre open image.  No abc
inequality, IUT geometric source theorem, or final q-estimate is assumed.
-/

namespace IUTThreeClosures

open Iut

/-- The subtype containing the explicit finite exceptional locus. -/
def FreySmallExceptionalPoint := {P : ABCPoint // P.c ≤ 256}

/-- There are only finitely many abc points with `c ≤ 256`.

The injection records `(a,b)` in `Fin 257 × Fin 257`; the equation `a+b=c`
recovers the third coordinate. -/
noncomputable instance freySmallExceptionalPointFinite :
    Finite FreySmallExceptionalPoint := by
  let encode : FreySmallExceptionalPoint → Fin 257 × Fin 257 :=
    fun P =>
      (⟨P.1.a, by
          have ha := P.1.a_lt_c
          omega⟩,
       ⟨P.1.b, by
          have hb := P.1.b_lt_c
          omega⟩)
  apply Finite.of_injective encode
  intro P Q h
  apply Subtype.ext
  have ha : P.1.a = Q.1.a :=
    congrArg (fun x : Fin 257 × Fin 257 => x.1.val) h
  have hb : P.1.b = Q.1.b :=
    congrArg (fun x : Fin 257 × Fin 257 => x.2.val) h
  have hc : P.1.c = Q.1.c := by
    omega
  exact ABCPoint.ext ha hb hc

/-- The explicit finite exceptional set of Frey abc points. -/
noncomputable def freyCMExceptional : Finset ABCPoint := by
  classical
  exact Finset.univ.image
    (fun P : FreySmallExceptionalPoint => P.1)

@[simp]
theorem mem_freyCMExceptional_iff (P : ABCPoint) :
    P ∈ freyCMExceptional ↔ P.c ≤ 256 := by
  classical
  constructor
  · intro hP
    rcases Finset.mem_image.mp hP with ⟨Q, _hQ, hQP⟩
    rw [← hQP]
    exact Q.2
  · intro hP
    apply Finset.mem_image.mpr
    exact ⟨⟨P, hP⟩, Finset.mem_univ _, rfl⟩

namespace ABCPoint

/-- If the actual rational Frey j-invariant is an integer, then `c ≤ 256`.

The proof uses the reduced denominator already identified with `Rat.den` and
the theorem that every cancellation factor divides `256`. -/
theorem abcFrey_j_integer_implies_c_le_256
    (P : ABCPoint)
    (hInt : ∃ z : ℤ, (abcFreyCurve P).j = (z : ℚ)) :
    P.c ≤ 256 := by
  rcases hInt with ⟨z, hz⟩
  have hden : (abcFreyCurve P).j.den = 1 := by
    have h := congrArg Rat.den hz
    simpa using h
  rw [P.abcFrey_j_den] at hden
  have hraw : P.freyJRawDen = P.freyJContent := by
    rw [← P.freyJReducedDen_mul_content, hden, one_mul]
  have hraw_le : P.freyJRawDen ≤ 256 := by
    rw [hraw]
    exact P.freyJContent_le_256
  let n : ℕ := P.a * P.b * P.c
  have hnpos : 0 < n := by
    exact Nat.mul_pos (Nat.mul_pos P.a_pos P.b_pos) P.c_pos
  have hab_one : 1 ≤ P.a * P.b := by
    exact Nat.one_le_iff_ne_zero.mpr
      (Nat.mul_ne_zero P.a_pos.ne' P.b_pos.ne')
  have hc_le_n : P.c ≤ n := by
    have h := Nat.mul_le_mul_right P.c hab_one
    simpa [n, Nat.mul_assoc] using h
  have hn_le_sq : n ≤ n ^ 2 := by
    have h := Nat.mul_le_mul_right n hnpos
    simpa [pow_two] using h
  have hsq : n ^ 2 ≤ 256 := by
    simpa [freyJRawDen, n] using hraw_le
  exact hc_le_n.trans (hn_le_sq.trans hsq)

/-- Outside the explicit finite exceptional set, the actual Frey j-invariant
is not an integer. -/
theorem abcFrey_j_not_integer_outside_exceptional
    (P : ABCPoint)
    (hP : P ∉ freyCMExceptional) :
    ¬ ∃ z : ℤ, (abcFreyCurve P).j = (z : ℚ) := by
  intro hInt
  apply hP
  exact (mem_freyCMExceptional_iff P).2
    (P.abcFrey_j_integer_implies_c_le_256 hInt)

end ABCPoint

namespace RationalCMOpenImagePackage

/-- **Frey non-CM theorem outside a finite set.**  CM integrality would make
the rational Frey j-invariant an integer, contradicting the denominator
calculation above. -/
theorem freyCurve_nonCM_outside_exceptional
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint)
    (hP : P ∉ freyCMExceptional) :
    ¬ S.HasCM (abcFreyCurve P) := by
  intro hCM
  exact P.abcFrey_j_not_integer_outside_exceptional hP
    (S.cm_j_integer (abcFreyCurve P) hCM)

/-- Eventual large mod-ell image for the actual Frey curve outside the explicit
finite exceptional set. -/
theorem freyCurve_eventual_largeImage_outside_exceptional
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint)
    (hP : P ∉ freyCMExceptional) :
    ∃ N : ℕ, ∀ ell : ℕ, ell.Prime → N < ell →
      S.LargeImageAt (abcFreyCurve P) ell :=
  S.serre_eventual_large_image
    (abcFreyCurve P)
    (S.freyCurve_nonCM_outside_exceptional P hP)

/-- **Arbitrarily large simultaneous admissible-prime selection for the Frey
curve.**  For every prescribed lower bound `M`, select a prime strictly above
`M`, at least five, with large image and coprime to every specified nonzero
local order. -/
theorem exists_frey_largeImage_prime_coprime_above
    (S : RationalCMOpenImagePackage)
    (P : ABCPoint)
    (hP : P ∉ freyCMExceptional)
    (M : ℕ)
    (orders : Finset ℕ)
    (horders : ∀ n ∈ orders, n ≠ 0) :
    ∃ ell : ℕ,
      ell.Prime ∧
      M < ell ∧
      5 ≤ ell ∧
      S.LargeImageAt (abcFreyCurve P) ell ∧
      ∀ n ∈ orders, Nat.Coprime ell n := by
  classical
  rcases S.freyCurve_eventual_largeImage_outside_exceptional P hP with
    ⟨N, hN⟩
  let B : ℕ := max N (max M 5)
  let Good : ℕ → Prop := fun ell =>
    M < ell ∧ 5 ≤ ell ∧ S.LargeImageAt (abcFreyCurve P) ell
  rcases exists_prime_of_eventual_finite_exception_and_coprimality
      B ∅ orders horders Good
      (by
        intro ell hell hBell _hellNot
        have hNB : N ≤ B := by simp [B]
        have hMB : M ≤ B := by simp [B]
        have h5B : 5 ≤ B := by simp [B]
        exact ⟨lt_of_le_of_lt hMB hBell,
          h5B.trans (Nat.le_of_lt hBell),
          hN ell hell (lt_of_le_of_lt hNB hBell)⟩) with
    ⟨ell, hell, hGood, _hellNot, hcop⟩
  exact ⟨ell, hell, hGood.1, hGood.2.1, hGood.2.2, hcop⟩

end RationalCMOpenImagePackage

end IUTThreeClosures
