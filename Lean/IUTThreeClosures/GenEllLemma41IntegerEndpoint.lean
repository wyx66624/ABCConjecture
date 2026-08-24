/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GenEllLemma41CountingBridge

/-!
# Integer endpoints in GenEll Lemma 4.1

The printed radius in GenEll Lemma 4.1 is a real number

`y_A = (1 + 6*epsilon) * x_A + 8*h`.

The Chebyshev function in the present Lean development is indexed by natural
numbers.  We therefore choose the least natural number `X` with `y_A <= X`.
Minimality gives the sharp rounding bounds

`y_A <= X < y_A + 1`.

The upper endpoint error is consequently at most one.  Moreover
`log X <= log (y_A + 1)`, so the logarithmic mass of at most `M-1` offending
primes is controlled by the slightly stronger but endpoint-stable condition

`(M-1) * log (y_A + 1) <= epsilon * y_A`.

Combining this with the counting bridge yields at least `M` primes outside the
forbidden set, all bounded by `y_A + 1`.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- The least natural endpoint lying above a real radius. -/
noncomputable def leastNatAbove (y : ℝ) : ℕ :=
  Nat.find (exists_nat_ge y)

/-- The selected endpoint lies above the real radius. -/
theorem le_leastNatAbove (y : ℝ) :
    y ≤ (leastNatAbove y : ℝ) :=
  Nat.find_spec (exists_nat_ge y)

/-- For a nonnegative radius, the selected endpoint overshoots by less than
one. -/
theorem leastNatAbove_lt_add_one
    {y : ℝ} (hy : 0 ≤ y) :
    (leastNatAbove y : ℝ) < y + 1 := by
  by_cases hzero : leastNatAbove y = 0
  · rw [hzero]
    norm_num
    linarith
  · have hpos : 0 < leastNatAbove y := Nat.pos_of_ne_zero hzero
    have hpred_lt : leastNatAbove y - 1 < leastNatAbove y :=
      Nat.sub_lt hpos (by omega)
    have hnot :
        ¬ y ≤ ((leastNatAbove y - 1 : ℕ) : ℝ) :=
      Nat.find_min' (exists_nat_ge y) hpred_lt
    have hpred :
        ((leastNatAbove y - 1 : ℕ) : ℝ) < y :=
      lt_of_not_ge hnot
    have hdecomp :
        leastNatAbove y = (leastNatAbove y - 1) + 1 := by
      omega
    rw [hdecomp]
    norm_num
    linarith

/-- If the real radius is at least one, so is the integer endpoint. -/
theorem one_le_leastNatAbove
    {y : ℝ} (hy : 1 ≤ y) :
    1 ≤ leastNatAbove y := by
  by_contra h
  have hzero : leastNatAbove y = 0 := by omega
  have := le_leastNatAbove y
  rw [hzero] at this
  norm_num at this
  linarith

/-- The endpoint logarithm is bounded by the logarithm of the radius plus the
single rounding unit. -/
theorem log_leastNatAbove_le_log_add_one
    {y : ℝ} (hy : 0 ≤ y) :
    Real.log (leastNatAbove y) ≤ Real.log (y + 1) := by
  have hXpos : (0 : ℝ) < leastNatAbove y := by
    by_cases hzero : leastNatAbove y = 0
    · rw [hzero]
      simp
    · exact_mod_cast Nat.pos_of_ne_zero hzero
  have hupper :
      (leastNatAbove y : ℝ) ≤ y + 1 :=
    (leastNatAbove_lt_add_one hy).le
  exact Real.log_le_log hXpos hupper

/-- **Endpoint-correct form of GenEll Lemma 4.1.**  The integer endpoint is
chosen canonically and all resulting primes lie below the printed real radius
plus one. -/
theorem genEllLemma41_many_primes_at_leastNatAbove
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (H M : ℕ)
    {ε xε Cε xA hBase : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hCε : Cε < ε * xε)
    (hxA : xε < xA)
    (hxA_mass : xA = primeLogMass A)
    (hhBase : 0 ≤ hBase)
    (hyOne :
      1 ≤ genEllLemma41Radius ε xA hBase)
    (hMlog :
      (((M - 1 : ℕ) : ℝ) *
          Real.log (genEllLemma41Radius ε xA hBase + 1)) ≤
        ε * genEllLemma41Radius ε xA hBase)
    (hthetaH :
      Chebyshev.theta H <
        (5 / 4 : ℝ) * ((1 + 6 * ε) * hBase) + Cε)
    (hthetaX :
      (1 - ε) * genEllLemma41Radius ε xA hBase <
        Chebyshev.theta
          (leastNatAbove (genEllLemma41Radius ε xA hBase))) :
    ∃ S : Finset ℕ,
      M ≤ S.card ∧
      ∀ p ∈ S,
        p.Prime ∧ H < p ∧
        (p : ℝ) < genEllLemma41Radius ε xA hBase + 1 ∧
        p ∉ A := by
  let y : ℝ := genEllLemma41Radius ε xA hBase
  let X : ℕ := leastNatAbove y
  have hy0 : 0 ≤ y := by
    dsimp [y, genEllLemma41Radius]
    have hxApos : 0 < xA := hxεpos.trans hxA
    have hfactor : 0 < 1 + 6 * ε := by linarith
    positivity
  have hXone : 1 ≤ X := by
    exact one_le_leastNatAbove (y := y) (by simpa [y] using hyOne)
  have hlogX :
      Real.log X ≤ Real.log (y + 1) :=
    log_leastNatAbove_le_log_add_one hy0
  have hmult_nonneg :
      0 ≤ (((M - 1 : ℕ) : ℝ)) := by positivity
  have hMlogX :
      (((M - 1 : ℕ) : ℝ) * Real.log X) ≤ ε * y := by
    calc
      (((M - 1 : ℕ) : ℝ) * Real.log X) ≤
          (((M - 1 : ℕ) : ℝ) * Real.log (y + 1)) :=
        mul_le_mul_of_nonneg_left hlogX hmult_nonneg
      _ ≤ ε * y := by simpa [y] using hMlog
  obtain ⟨S, hcard, hS⟩ :=
    genEllLemma41_many_primes
      A hA H X M hXone
      hεpos hεlt hxεpos hCε hxA hxA_mass
      (by simpa [y, X] using hMlogX)
      hthetaH
      (by simpa [y, X] using hthetaX)
  refine ⟨S, hcard, ?_⟩
  intro p hp
  have hspec := hS p hp
  refine ⟨hspec.1, hspec.2.1, ?_, hspec.2.2.2⟩
  have hXupper : (X : ℝ) < y + 1 :=
    leastNatAbove_lt_add_one hy0
  have hpX : (p : ℝ) ≤ X := by
    exact_mod_cast hspec.2.2.1
  exact hpX.trans_lt hXupper

end IUTThreeClosures
