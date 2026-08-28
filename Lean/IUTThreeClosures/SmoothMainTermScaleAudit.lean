/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Absolute versus relative error at a vanishing main-term scale

Suppose a short interval has length `h`, its smooth-number main term has size
`h * rho`, and a proposed exceptional subset is bounded only by `o(h)`.
When `rho -> 0`, this absolute estimate does not imply that the exceptional
subset is smaller than the smooth subset.  The required comparison is relative
to the main term, for example `o(h * rho)`.

This file kernel-packages the purely logical and scalar parts of that audit.
It deliberately does not assert any unproved distribution theorem for smooth
integers in short intervals.
-/

namespace IUTThreeClosures
namespace SmoothMainTermScaleAudit

/-- A discrete, multiplication-only version of `bad = o(scale)`: every fixed
multiple of `bad` is eventually bounded by `scale`. -/
def NegligibleAtNaturalScale (bad scale : ℕ → ℕ) : Prop :=
  ∀ K : ℕ, ∃ N : ℕ, ∀ n : ℕ, N ≤ n → K * bad n ≤ scale n

/-- Eventual strict domination, the cardinality comparison needed to extract
an element of a main set outside an exceptional subset. -/
def EventuallyStrictlyBelow (bad main : ℕ → ℕ) : Prop :=
  ∃ N : ℕ, ∀ n : ℕ, N ≤ n → bad n < main n

/-- An ambient interval scale tending to infinity. -/
def intervalScale (n : ℕ) : ℕ := n + 1

/-- A vanishing-density main count in the simplest exact countermodel. -/
def smoothMain (_n : ℕ) : ℕ := 1

/-- The exceptional count can exhaust the whole main set while remaining
negligible relative to the ambient interval. -/
def badMass (_n : ℕ) : ℕ := 1

/-- The countermodel's exceptional mass is negligible at the ambient scale. -/
theorem badMass_negligible_against_intervalScale :
    NegligibleAtNaturalScale badMass intervalScale := by
  intro K
  refine ⟨K, ?_⟩
  intro n hn
  simp [badMass, intervalScale]
  omega

/-- The same exceptional mass is not negligible relative to the vanishing
main count. -/
theorem badMass_not_negligible_against_smoothMain :
    ¬ NegligibleAtNaturalScale badMass smoothMain := by
  intro h
  obtain ⟨N, hN⟩ := h 2
  have hle : (2 : ℕ) ≤ 1 := by
    simpa [badMass, smoothMain] using hN N (le_refl N)
  omega

/-- In fact the exceptional count is never strictly smaller than the main
count in this model. -/
theorem badMass_not_eventually_below_smoothMain :
    ¬ EventuallyStrictlyBelow badMass smoothMain := by
  intro h
  obtain ⟨N, hN⟩ := h
  have hlt : (1 : ℕ) < 1 := by
    simpa [badMass, smoothMain] using hN N (le_refl N)
  exact (Nat.lt_irrefl 1) hlt

/-- Exact logical counterexample to the inference
`bad = o(ambient) -> bad < main` when the main density vanishes. -/
theorem ambient_negligibility_does_not_give_relative_extraction :
    NegligibleAtNaturalScale badMass intervalScale ∧
      ¬ EventuallyStrictlyBelow badMass smoothMain :=
  ⟨badMass_negligible_against_intervalScale,
    badMass_not_eventually_below_smoothMain⟩

/-- A cardinality gap is sufficient to extract a desired element.  Applied to
smooth numbers, `smooth` is the local smooth set and `bad` is its high-omega
subset. -/
theorem exists_good_of_bad_card_lt_smooth_card
    {α : Type*} [DecidableEq α]
    (smooth bad : Finset α)
    (hcard : bad.card < smooth.card) :
    ∃ x ∈ smooth, x ∉ bad := by
  classical
  by_contra hgood
  have hsub : smooth ⊆ bad := by
    intro x hx
    by_contra hxbad
    exact hgood ⟨x, hx, hxbad⟩
  have hle : smooth.card ≤ bad.card := Finset.card_le_card hsub
  exact (Nat.not_lt_of_ge hle) hcard

/-- A finite exact model in which every main-set element is exceptional. -/
def singletonSmooth : Finset ℕ := {0}

def singletonBad : Finset ℕ := {0}

theorem singleton_smooth_set_has_no_good_element :
    ¬ ∃ x ∈ singletonSmooth, x ∉ singletonBad := by
  simp [singletonSmooth, singletonBad]

/-- `denom` grows faster than every fixed polynomial.  For a density
`rho = 1 / denom`, this is the multiplication-only form of
`rho = o(u^(-m))` for every fixed `m`. -/
def FasterThanEveryPower (denom : ℕ → ℕ) : Prop :=
  ∀ m C N : ℕ, ∃ n : ℕ,
    N ≤ n ∧ C * (n + 1) ^ m < denom n

/-- A fixed polynomial can eventually absorb the reciprocal-density
denominator.  This is exactly the cross-multiplied condition needed to turn a
polynomial ambient error into an error relative to the main term. -/
def PolynomiallyAbsorbable (denom : ℕ → ℕ) (m : ℕ) : Prop :=
  ∃ C N : ℕ, ∀ n : ℕ, N ≤ n →
    denom n ≤ C * (n + 1) ^ m

/-- Super-polynomial reciprocal density rules out every fixed-polynomial
absorption estimate. -/
theorem fasterThanEveryPower_not_polynomiallyAbsorbable
    {denom : ℕ → ℕ}
    (hdenom : FasterThanEveryPower denom)
    (m : ℕ) :
    ¬ PolynomiallyAbsorbable denom m := by
  rintro ⟨C, N, hCN⟩
  obtain ⟨n, hn, hlt⟩ := hdenom m C N
  have hle := hCN n hn
  exact (Nat.not_lt_of_ge hle) hlt

/-- Pointwise scalar form of the same obstruction.  If
`C * u^m * rho < 1`, then the ambient polynomial error `h / u^m` is strictly
larger than `C` times the main term `h * rho`; hence it cannot be absorbed as
a relative error with constant `C`. -/
theorem polynomial_ambient_error_exceeds_relative_main
    {h u rho C : ℝ} {m : ℕ}
    (hh : 0 < h) (hu : 0 < u)
    (hsmall : C * u ^ m * rho < 1) :
    C * (h * rho) < h / u ^ m := by
  have hupow : 0 < u ^ m := pow_pos hu m
  apply (lt_div_iff₀ hupow).2
  calc
    C * (h * rho) * u ^ m = h * (C * u ^ m * rho) := by ring
    _ < h * 1 := mul_lt_mul_of_pos_left hsmall hh
    _ = h := by ring

#print axioms badMass_negligible_against_intervalScale
#print axioms badMass_not_negligible_against_smoothMain
#print axioms badMass_not_eventually_below_smoothMain
#print axioms ambient_negligibility_does_not_give_relative_extraction
#print axioms exists_good_of_bad_card_lt_smooth_card
#print axioms singleton_smooth_set_has_no_good_element
#print axioms fasterThanEveryPower_not_polynomiallyAbsorbable
#print axioms polynomial_ambient_error_exceeds_relative_main

end SmoothMainTermScaleAudit
end IUTThreeClosures
