/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TripodWeilHeight
import Mathlib.NumberTheory.FLT.MasonStothers
import Mathlib.RingTheory.Polynomial.Resultant.Basic

/-!
# Mason--Stothers and the specialization barrier

This file formalizes an exact non-IUT audit of the tempting passage from the
function-field polynomial abc theorem to the integer abc conjecture.

* One fixed polynomial tripod `X, 1-X, -1` is a sharp Mason--Stothers
  identity and specializes at `a/c` to every primitive abc triple after
  clearing the denominator.
* A translated integral family has fixed degrees and unit pairwise resultant,
  while its values at a fixed section are unbounded.  Thus neither horizontal
  degree nor bad-fibre resultants control specialization height or
  intersection multiplicity.
* A direct evaluation estimate exposes the coefficient/point-height term
  which every honest specialization argument must pay.
* The uniform tripod moving-section inequality, stated using the actual Weil
  height, is proved equivalent to `ABCConjecture`.

No direction assumes a specialization inequality, Vojta's conjecture, or the
abc conjecture as structure data.
-/

namespace IUTThreeClosures

open Polynomial UniqueFactorizationMonoid
open scoped BigOperators

noncomputable section

/-! ## The fixed horizontal Mason tripod -/

/-- The first polynomial in the fixed tripod. -/
def fixedMasonA : ℚ[X] := X

/-- The second polynomial in the fixed tripod. -/
def fixedMasonB : ℚ[X] := 1 - X

/-- The third polynomial in the fixed tripod, in sum-zero convention. -/
def fixedMasonC : ℚ[X] := -1

/-- The fixed tripod is an exact polynomial identity. -/
theorem fixedMason_sum_eq_zero :
    fixedMasonA + fixedMasonB + fixedMasonC = 0 := by
  simp [fixedMasonA, fixedMasonB, fixedMasonC]

/-- The first two members of the fixed tripod are coprime. -/
theorem fixedMason_isCoprime : IsCoprime fixedMasonA fixedMasonB := by
  have h : IsCoprime
      (X - C (0 : ℚ)) (X - C (1 : ℚ)) :=
    isCoprime_X_sub_C_of_isUnit_sub (by norm_num)
  have hneg := h.neg_right
  simpa [fixedMasonA, fixedMasonB] using hneg

/-- Mason--Stothers is sharp on the fixed tripod: its polynomial radical has
degree exactly two. -/
theorem fixedMason_radical_natDegree :
    (radical (fixedMasonA * fixedMasonB * fixedMasonC)).natDegree = 2 := by
  have ha : fixedMasonA ≠ 0 := by
    simp [fixedMasonA]
  have hb : fixedMasonB ≠ 0 := by
    intro h
    have hd := congrArg Polynomial.derivative h
    simpa [fixedMasonB] using hd
  have hc : fixedMasonC ≠ 0 := by
    norm_num [fixedMasonC]
  have hm := Polynomial.abc ha hb hc fixedMason_isCoprime
    fixedMason_sum_eq_zero
  have hlower : 2 ≤
      (radical (fixedMasonA * fixedMasonB * fixedMasonC)).natDegree := by
    rcases hm with hm | hderiv
    · simpa [fixedMasonA] using hm.1
    · have := hderiv.1
      simpa [fixedMasonA] using this
  have hupper := natDegree_radical_le
    (a := fixedMasonA * fixedMasonB * fixedMasonC)
  have hdegA : fixedMasonA.natDegree = 1 := by
    simp [fixedMasonA]
  have hdegB : fixedMasonB.natDegree = 1 := by
    change (1 - X : ℚ[X]).natDegree = 1
    rw [show (1 - X : ℚ[X]) = C (-1) * X + C 1 by
      simp [sub_eq_add_neg, add_comm]]
    exact natDegree_linear (by norm_num)
  have hdegC : fixedMasonC.natDegree = 0 := by
    norm_num [fixedMasonC]
  have hproduct :
      (fixedMasonA * fixedMasonB * fixedMasonC).natDegree = 2 := by
    rw [Polynomial.natDegree_mul (mul_ne_zero ha hb) hc,
      Polynomial.natDegree_mul ha hb, hdegA, hdegB, hdegC]
  rw [hproduct] at hupper
  omega

/-- Evaluation of the fixed tripod at the abc coordinate, before clearing the
common denominator. -/
theorem fixedMason_eval_lambda (P : ABCPoint) :
    eval P.lambda fixedMasonA = P.lambda ∧
      eval P.lambda fixedMasonB = 1 - P.lambda ∧
      eval P.lambda fixedMasonC = -1 := by
  simp [fixedMasonA, fixedMasonB, fixedMasonC]

/-- Clearing the denominator of the fixed tripod specialization recovers the
integer triple `(a,b,-c)` exactly. -/
theorem fixedMason_clear_denominator (P : ABCPoint) :
    (P.c : ℚ) * eval P.lambda fixedMasonA = P.a ∧
      (P.c : ℚ) * eval P.lambda fixedMasonB = P.b ∧
      (P.c : ℚ) * eval P.lambda fixedMasonC = -(P.c : ℚ) := by
  have hc : (P.c : ℚ) ≠ 0 := by
    exact_mod_cast P.c_pos.ne'
  constructor
  · rw [(fixedMason_eval_lambda P).1, ABCPoint.lambda]
    field_simp
  constructor
  · rw [fixedMason_eval_lambda P |>.2.1,
      P.one_sub_lambda_eq_b_div_c]
    field_simp
  · simp [fixedMasonC]

/-! ## A unit-resultant translated family -/

/-- The constant member of the translated integral tripod. -/
def translatedMasonA : ℤ[X] := 1

/-- The first moving section of the translated integral tripod. -/
def translatedMasonB (n : ℤ) : ℤ[X] := X + C n

/-- The adjacent moving section of the translated integral tripod. -/
def translatedMasonC (n : ℤ) : ℤ[X] := X + C (n + 1)

/-- The translated family retains the additive identity. -/
theorem translatedMason_add (n : ℤ) :
    translatedMasonA + translatedMasonB n = translatedMasonC n := by
  simp [translatedMasonA, translatedMasonB, translatedMasonC]
  ring

/-- The specialization at the fixed section `T=0` is `(1,n,n+1)`. -/
theorem translatedMason_eval_zero (n : ℤ) :
    eval 0 translatedMasonA = 1 ∧
      eval 0 (translatedMasonB n) = n ∧
      eval 0 (translatedMasonC n) = n + 1 := by
  simp [translatedMasonA, translatedMasonB, translatedMasonC]

/-- The degree triple of the translated family is always `(0,1,1)`. -/
theorem translatedMason_natDegrees (n : ℤ) :
    translatedMasonA.natDegree = 0 ∧
      (translatedMasonB n).natDegree = 1 ∧
      (translatedMasonC n).natDegree = 1 := by
  constructor
  · simp [translatedMasonA]
  constructor
  · exact natDegree_X_add_C n
  · exact natDegree_X_add_C (n + 1)

/-- The two finite sections have unit resultant, independently of `n`. -/
theorem translatedMason_resultant (n : ℤ) :
    (translatedMasonB n).resultant (translatedMasonC n) = 1 := by
  simp only [translatedMasonB, translatedMasonC, natDegree_X_add_C]
  calc
    (X + C n).resultant (X + C (n + 1)) 1 1 =
        eval (-n) (X + C (n + 1)) :=
      resultant_X_add_C_left (g := X + C (n + 1)) (n := 1)
        n (by simpa using (natDegree_X_add_C (R := ℤ) (n + 1)).le)
    _ = 1 := by simp

/-- Translation identifies every member with the fixed adjacent-section
configuration `X, X+1`. -/
theorem translatedMason_comp_sub (n : ℤ) :
    (translatedMasonB n).comp (X - C n) = X ∧
      (translatedMasonC n).comp (X - C n) = X + 1 := by
  constructor <;> simp [translatedMasonB, translatedMasonC] <;> ring

/-- Fixed horizontal degrees and a unit resultant do not bound the value at a
fixed specialization section.  This is the formal strict counterexample to a
degree-and-bad-fibre-only specialization bridge. -/
theorem no_uniform_bound_from_degree_and_resultant (B : ℕ) :
    ∃ n : ℕ,
      B < (eval 0 (translatedMasonC (n : ℤ))).natAbs ∧
      translatedMasonA + translatedMasonB (n : ℤ) =
        translatedMasonC (n : ℤ) ∧
      translatedMasonA.natDegree = 0 ∧
      (translatedMasonB (n : ℤ)).natDegree = 1 ∧
      (translatedMasonC (n : ℤ)).natDegree = 1 ∧
      (translatedMasonB (n : ℤ)).resultant
        (translatedMasonC (n : ℤ)) = 1 := by
  let n : ℕ := B + 1
  refine ⟨n, ?_, translatedMason_add (n : ℤ),
    (translatedMason_natDegrees (n : ℤ)).1,
    (translatedMason_natDegrees (n : ℤ)).2.1,
    (translatedMason_natDegrees (n : ℤ)).2.2,
    translatedMason_resultant (n : ℤ)⟩
  rw [(translatedMason_eval_zero (n : ℤ)).2.2]
  dsimp [n]
  rw [show (B : ℤ) + 1 + 1 = ((B + 2 : ℕ) : ℤ) by omega,
    Int.natAbs_natCast]
  omega

/-- Even with unit family resultant, the fixed section can have an arbitrarily
large displayed power of the prime two. -/
theorem unit_resultant_with_power_two_specialization (m : ℕ) :
    eval 0 (translatedMasonB ((2 : ℤ) ^ m)) = (2 : ℤ) ^ m ∧
      (translatedMasonB ((2 : ℤ) ^ m)).resultant
        (translatedMasonC ((2 : ℤ) ^ m)) = 1 := by
  exact ⟨(translatedMason_eval_zero ((2 : ℤ) ^ m)).2.1,
    translatedMason_resultant _⟩

/-! ## The unavoidable coefficient/point-height term -/

/-- Elementary specialization loss for a degree-`d` natural polynomial
written as a truncated coefficient sum. -/
theorem truncatedNatPolynomialEval_le
    (u : ℕ → ℕ) (d t H : ℕ)
    (hu : ∀ i ≤ d, u i ≤ H) :
    (∑ i ∈ Finset.range (d + 1), u i * t ^ i) ≤
      (d + 1) * H * (max 1 t) ^ d := by
  calc
    (∑ i ∈ Finset.range (d + 1), u i * t ^ i) ≤
        ∑ _i ∈ Finset.range (d + 1), H * (max 1 t) ^ d := by
      apply Finset.sum_le_sum
      intro i hi
      have hid : i ≤ d := by
        simpa [Finset.mem_range] using hi
      have ht : t ≤ max 1 t := le_max_right _ _
      have hbase : t ^ i ≤ (max 1 t) ^ i :=
        Nat.pow_le_pow_left ht i
      have hone : 1 ≤ max 1 t := le_max_left _ _
      have hexp : (max 1 t) ^ i ≤ (max 1 t) ^ d :=
        pow_le_pow_right' hone hid
      exact Nat.mul_le_mul (hu i hid) (hbase.trans hexp)
    _ = (d + 1) * H * (max 1 t) ^ d := by
      simp [mul_assoc]

/-! ## The exact logical boundary -/

/-- The uniform arithmetic moving-section inequality on the fixed tripod.

The point height and conductor are the repository's concrete invariants; no
arbitrary height or target inequality is stored in data. -/
def TripodSpecializationBound : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ C : ℝ, ∀ P : ABCPoint,
      tripodWeilHeight P ≤ (1 + ε) * P.conductor + C

/-- The hoped-for uniform specialization bridge on the fixed Mason tripod is
logically exactly the logarithmic abc conjecture. -/
theorem tripodSpecializationBound_iff_abc :
    TripodSpecializationBound ↔ ABCConjecture := by
  constructor
  · intro h ε hε
    rcases h ε hε with ⟨C, hC⟩
    refine ⟨C, ?_⟩
    intro a b c ha hb hc hab hcop
    let P : ABCPoint :=
      { a := a
        b := b
        c := c
        a_pos := ha
        b_pos := hb
        c_pos := hc
        sum_eq := hab
        pairwise_coprime := hcop }
    have hs := hC P
    simpa [tripodWeilHeight_eq_height,
      ABCPoint.height, ABCPoint.conductor, P] using hs
  · intro h ε hε
    rcases h ε hε with ⟨C, hC⟩
    refine ⟨C, ?_⟩
    intro P
    have hs := hC P.a P.b P.c P.a_pos P.b_pos P.c_pos
      P.sum_eq P.pairwise_coprime
    simpa [tripodWeilHeight_eq_height,
      ABCPoint.height, ABCPoint.conductor] using hs

end

end IUTThreeClosures
