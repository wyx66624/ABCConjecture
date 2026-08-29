/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.UnitC4SemistableReduction
import IUTThreeClosures.FreyOddMultiplicativeCriterion
import Mathlib.NumberTheory.Padics.PadicIntegers
import Mathlib.Tactic

/-!
# Actual odd-prime semistable reduction of the integral Frey equation

For a primitive positive triple `a + b = c`, this module places the integral
Frey equation

`y^2 = x (x-a) (x+b)`

over the p-adic integers and its fraction field.  At every odd prime `p`, the
curve has:

* good reduction when `p` does not divide `abc`;
* multiplicative reduction when `p` divides `abc`.

The proof is unconditional.  It combines the already formalized invariant
identities and coprimality with the unit-`c4` minimality theorem.  In
particular, no local reduction certificate is supplied as a hypothesis.
-/

namespace IUTThreeClosures
namespace FreyPadicSemistableReduction

open WeierstrassCurve
open IsDedekindDomain.HeightOneSpectrum
open UnitC4SemistableReduction

noncomputable section

variable (p : ℕ) [Fact p.Prime]

/-- Natural casts into the p-adic integers lie in the maximal ideal exactly
when they are divisible by `p`. -/
theorem padicInt_natCast_mem_maximalIdeal_iff (n : ℕ) :
    (n : ℤ_[p]) ∈ maximalIdeal ℤ_[p] ↔ p ∣ n := by
  simp only [IsLocalRing.mem_maximalIdeal, PadicInt.mem_nonunits,
    PadicInt.norm_natCast_lt_one_iff]

/-- The multiplicative DVR valuation of a natural cast is below one exactly at
multiples of `p`. -/
theorem padicValuation_natCast_lt_one_iff (n : ℕ) :
    valuation ℚ_[p] (maximalIdeal ℤ_[p]) (n : ℚ_[p]) < 1 ↔ p ∣ n := by
  simpa only [PadicInt.algebraMap_apply, PadicInt.coe_natCast,
      padicInt_natCast_mem_maximalIdeal_iff (p := p) n] using
    (IsDedekindDomain.HeightOneSpectrum.valuation_lt_one_iff_mem
      (R := ℤ_[p]) (K := ℚ_[p]) (v := maximalIdeal ℤ_[p]) (r := (n : ℤ_[p])))

/-- The multiplicative DVR valuation of a natural cast is one exactly away
from multiples of `p`. -/
theorem padicValuation_natCast_eq_one_iff_not_dvd (n : ℕ) :
    valuation ℚ_[p] (maximalIdeal ℤ_[p]) (n : ℚ_[p]) = 1 ↔ ¬ p ∣ n := by
  simpa only [PadicInt.algebraMap_apply, PadicInt.coe_natCast,
      padicInt_natCast_mem_maximalIdeal_iff (p := p) n] using
    (IsDedekindDomain.HeightOneSpectrum.valuation_eq_one_iff_notMem
      (R := ℤ_[p]) (K := ℚ_[p]) (v := maximalIdeal ℤ_[p])
      (r := (n : ℤ_[p])))

namespace ABCPoint

/-- The integral Frey equation over the p-adic integers. -/
def abcFreyCurvePadicInt (P : ABCPoint) : WeierstrassCurve ℤ_[p] :=
  (abcFreyCurveZ P).map (Int.castRingHom ℤ_[p])

/-- The same equation over the p-adic fraction field. -/
def abcFreyCurvePadic (P : ABCPoint) : WeierstrassCurve ℚ_[p] :=
  (P.abcFreyCurvePadicInt p).baseChange ℚ_[p]

/-- The p-adic Frey equation is integral by construction. -/
noncomputable instance abcFreyCurvePadic_isIntegral (P : ABCPoint) :
    (P.abcFreyCurvePadic p).IsIntegral ℤ_[p] where
  integral := ⟨P.abcFreyCurvePadicInt p, rfl⟩

@[simp]
theorem abcFreyCurvePadicInt_c4 (P : ABCPoint) :
    (P.abcFreyCurvePadicInt p).c₄ = (P.freyC4Nat : ℤ_[p]) := by
  simp [abcFreyCurvePadicInt, freyC4Nat, legendreCore]

@[simp]
theorem abcFreyCurvePadicInt_delta (P : ABCPoint) :
    (P.abcFreyCurvePadicInt p).Δ = (P.freyDeltaNat : ℤ_[p]) := by
  simp [abcFreyCurvePadicInt, freyDeltaNat]

@[simp]
theorem abcFreyCurvePadic_c4 (P : ABCPoint) :
    (P.abcFreyCurvePadic p).c₄ = (P.freyC4Nat : ℚ_[p]) := by
  simp [abcFreyCurvePadic, abcFreyCurvePadicInt_c4]

@[simp]
theorem abcFreyCurvePadic_delta (P : ABCPoint) :
    (P.abcFreyCurvePadic p).Δ = (P.freyDeltaNat : ℚ_[p]) := by
  simp [abcFreyCurvePadic, abcFreyCurvePadicInt_delta]

/-- At an odd prime, the integral Frey discriminant has exactly the prime
support of `abc`. -/
theorem oddPrime_dvd_freyDeltaNat_iff_dvd_abc
    (P : ABCPoint) (hp_ne_two : p ≠ 2) :
    p ∣ P.freyDeltaNat ↔ p ∣ P.a * P.b * P.c := by
  have hp : p.Prime := Fact.out
  constructor
  · intro hDelta
    unfold freyDeltaNat at hDelta
    rcases hp.dvd_mul.mp hDelta with h16 | hsq
    · exfalso
      exact P.oddPrime_not_dvd_256 hp hp_ne_two
        (h16.trans (by norm_num : 16 ∣ 256))
    · exact hp.dvd_of_dvd_pow hsq
  · exact P.prime_dvd_freyDeltaNat

/-- Valuation form of the exact odd-prime support statement for the Frey
`c4`. -/
theorem abcFreyCurvePadic_c4_valuation_eq_one_iff (P : ABCPoint) :
    valuation ℚ_[p] (maximalIdeal ℤ_[p]) (P.abcFreyCurvePadic p).c₄ = 1 ↔
      ¬ p ∣ P.freyC4Nat := by
  rw [P.abcFreyCurvePadic_c4]
  exact padicValuation_natCast_eq_one_iff_not_dvd p P.freyC4Nat

/-- Valuation form of the exact odd-prime support statement for the Frey
discriminant. -/
theorem abcFreyCurvePadic_delta_valuation_lt_one_iff (P : ABCPoint) :
    valuation ℚ_[p] (maximalIdeal ℤ_[p]) (P.abcFreyCurvePadic p).Δ < 1 ↔
      p ∣ P.freyDeltaNat := by
  rw [P.abcFreyCurvePadic_delta]
  exact padicValuation_natCast_lt_one_iff p P.freyDeltaNat

/-- Away from the odd abc support, the actual p-adic Frey equation has good
reduction. -/
theorem abcFreyCurvePadic_hasGoodReduction_of_not_dvd_abc
    (P : ABCPoint) (hp_ne_two : p ≠ 2)
    (hpabc : ¬ p ∣ P.a * P.b * P.c) :
    (P.abcFreyCurvePadic p).HasGoodReduction ℤ_[p] := by
  have hDeltaNat : ¬ p ∣ P.freyDeltaNat := by
    intro hDelta
    exact hpabc ((P.oddPrime_dvd_freyDeltaNat_iff_dvd_abc p hp_ne_two).mp hDelta)
  have hDelta :
      valuation ℚ_[p] (maximalIdeal ℤ_[p]) (P.abcFreyCurvePadic p).Δ = 1 := by
    rw [P.abcFreyCurvePadic_delta]
    exact (padicValuation_natCast_eq_one_iff_not_dvd p P.freyDeltaNat).2 hDeltaNat
  exact hasGoodReduction_of_integral_delta_unit
    (R := ℤ_[p]) (P.abcFreyCurvePadic p) hDelta

/-- At every odd prime in the abc support, the actual p-adic Frey equation has
multiplicative reduction. -/
theorem abcFreyCurvePadic_hasMultiplicativeReduction_of_dvd_abc
    (P : ABCPoint) (hp_ne_two : p ≠ 2)
    (hpabc : p ∣ P.a * P.b * P.c) :
    (P.abcFreyCurvePadic p).HasMultiplicativeReduction ℤ_[p] := by
  have hp : p.Prime := Fact.out
  have hDeltaNat : p ∣ P.freyDeltaNat :=
    P.prime_dvd_freyDeltaNat hpabc
  have hc4Nat : ¬ p ∣ P.freyC4Nat :=
    P.oddPrime_not_dvd_freyC4Nat hp hp_ne_two hpabc
  have hDelta :
      valuation ℚ_[p] (maximalIdeal ℤ_[p]) (P.abcFreyCurvePadic p).Δ < 1 :=
    (P.abcFreyCurvePadic_delta_valuation_lt_one_iff p).2 hDeltaNat
  have hc4 :
      valuation ℚ_[p] (maximalIdeal ℤ_[p]) (P.abcFreyCurvePadic p).c₄ = 1 :=
    (P.abcFreyCurvePadic_c4_valuation_eq_one_iff p).2 hc4Nat
  exact hasMultiplicativeReduction_of_integral_c4_unit
    (R := ℤ_[p]) (P.abcFreyCurvePadic p) hc4 hDelta

/-- The integral Frey equation is semistable at every odd rational prime. -/
theorem abcFreyCurvePadic_hasGood_or_multiplicative_reduction
    (P : ABCPoint) (hp_ne_two : p ≠ 2) :
    (P.abcFreyCurvePadic p).HasGoodReduction ℤ_[p] ∨
      (P.abcFreyCurvePadic p).HasMultiplicativeReduction ℤ_[p] := by
  by_cases hpabc : p ∣ P.a * P.b * P.c
  · exact Or.inr
      (P.abcFreyCurvePadic_hasMultiplicativeReduction_of_dvd_abc
        p hp_ne_two hpabc)
  · exact Or.inl
      (P.abcFreyCurvePadic_hasGoodReduction_of_not_dvd_abc
        p hp_ne_two hpabc)

#print axioms padicInt_natCast_mem_maximalIdeal_iff
#print axioms padicValuation_natCast_lt_one_iff
#print axioms padicValuation_natCast_eq_one_iff_not_dvd
#print axioms ABCPoint.oddPrime_dvd_freyDeltaNat_iff_dvd_abc
#print axioms ABCPoint.abcFreyCurvePadic_hasGoodReduction_of_not_dvd_abc
#print axioms ABCPoint.abcFreyCurvePadic_hasMultiplicativeReduction_of_dvd_abc
#print axioms ABCPoint.abcFreyCurvePadic_hasGood_or_multiplicative_reduction

end
end ABCPoint
end FreyPadicSemistableReduction
end IUTThreeClosures
