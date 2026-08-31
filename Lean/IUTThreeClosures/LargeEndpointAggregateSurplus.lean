/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Tactic

/-!
# Aggregate exponent surplus on the two large abc endpoints

The primewise cubeful excess is too strong as a global target: exponent-one
primes on one large endpoint can compensate high prime powers on the other.
The correct first aggregate object is

`log(M*c) - 2*log(rad(M*c))`,

where `M=max(a,b)`.  Primewise this is the signed sum

`sum_p (v_p(M*c)-2) log p`.

Exponent-one primes contribute negatively, so the object preserves the
cross-endpoint compensation lost by a positive-part truncation.

This file proves the exact height ledger and its strict contrapositive.  It
contains no estimate for the aggregate surplus itself.
-/

namespace IUTThreeClosures
namespace LargeEndpointAggregateSurplus

noncomputable section

namespace ABCPoint

/-- Logarithmic product of the two large adjacent endpoints. -/
def largePairLog (P : ABCPoint) : ℝ :=
  Real.log ((P.largeEndpoint * P.c : ℕ) : ℝ)

/-- Logarithmic radical of the two large adjacent endpoints. -/
def largePairRadicalLog (P : ABCPoint) : ℝ :=
  Real.log (abcRadical (P.largeEndpoint * P.c) : ℝ)

/-- Signed aggregate exponent surplus above average multiplicity two. -/
def largePairAggregateSurplus (P : ABCPoint) : ℝ :=
  P.largePairLog - 2 * P.largePairRadicalLog

/-- The larger summand is no larger than the sum. -/
theorem largeEndpoint_le_c (P : ABCPoint) :
    P.largeEndpoint ≤ P.c := by
  unfold largeEndpoint
  exact max_le (Nat.le_of_lt P.a_lt_c) (Nat.le_of_lt P.b_lt_c)

/-- The large-pair logarithm lies below twice the abc height. -/
theorem largePairLog_le_two_height (P : ABCPoint) :
    P.largePairLog ≤ 2 * P.height := by
  have hprodpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast mul_pos P.largeEndpoint_pos P.c_pos
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hnat : P.largeEndpoint * P.c ≤ P.c ^ 2 := by
    calc
      P.largeEndpoint * P.c ≤ P.c * P.c :=
        Nat.mul_le_mul_right P.c P.largeEndpoint_le_c
      _ = P.c ^ 2 := by ring
  have hreal :
      ((P.largeEndpoint * P.c : ℕ) : ℝ) ≤ (P.c : ℝ) ^ 2 := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log hprodpos hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne'] at hlog
  rw [P.height_eq_log_c]
  exact hlog

/-- The reverse corridor, up to the sharp factor two. -/
theorem two_height_sub_log_two_le_largePairLog (P : ABCPoint) :
    2 * P.height - Real.log 2 ≤ P.largePairLog := by
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hpairpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast mul_pos P.largeEndpoint_pos P.c_pos
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast P.c_sq_le_two_largeEndpoint_mul_c
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hpairpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold largePairLog
  linarith

/-- The pair radical is bounded by the full abc conductor. -/
theorem largePairRadicalLog_le_conductor (P : ABCPoint) :
    P.largePairRadicalLog ≤ P.conductor := by
  have hpairradpos :
      0 < (abcRadical (P.largeEndpoint * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.largeEndpoint * P.c)
  have hnat := P.radical_largeEndpoint_mul_c_le_abcRadical
  have hreal :
      (abcRadical (P.largeEndpoint * P.c) : ℝ) ≤
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log hpairradpos hreal
  simpa [largePairRadicalLog, ABCPoint.conductor] using hlog

/-- Exact aggregate-surplus height ledger. -/
theorem two_mul_height_le_log_two_add_two_mul_conductor_add_aggregateSurplus
    (P : ABCPoint) :
    2 * P.height ≤
      Real.log 2 + 2 * P.conductor + P.largePairAggregateSurplus := by
  have hlower := P.two_height_sub_log_two_le_largePairLog
  have hrad := P.largePairRadicalLog_le_conductor
  unfold largePairAggregateSurplus at *
  linarith

/-- A subcritical aggregate-surplus estimate yields the standard abc slope. -/
theorem height_le_of_aggregateSurplus_bound
    (P : ABCPoint) {epsilon K : ℝ}
    (hsurplus :
      P.largePairAggregateSurplus ≤
        2 * epsilon * P.conductor + K) :
    P.height ≤
      (1 + epsilon) * P.conductor + (K + Real.log 2) / 2 := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_aggregateSurplus
  nlinarith

/-- Every violation forces a quantitatively large signed aggregate surplus. -/
theorem aggregateSurplus_large_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.conductor + 2 * C - Real.log 2 <
      P.largePairAggregateSurplus := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_conductor_add_aggregateSurplus
  nlinarith

/-- The aggregate surplus has the exact corridor obtained by replacing the
large-pair logarithm by its two height bounds. -/
theorem aggregateSurplus_corridor (P : ABCPoint) :
    2 * P.height - Real.log 2 - 2 * P.largePairRadicalLog ≤
        P.largePairAggregateSurplus ∧
      P.largePairAggregateSurplus ≤
        2 * P.height - 2 * P.largePairRadicalLog := by
  constructor
  · have h := P.two_height_sub_log_two_le_largePairLog
    unfold largePairAggregateSurplus
    linarith
  · have h := P.largePairLog_le_two_height
    unfold largePairAggregateSurplus
    linarith

end ABCPoint

/-- Uniform control of the signed aggregate surplus. This is a concrete
arithmetic target and contains no abc conclusion as data. -/
def UniformLargePairAggregateSurplusBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ K : ℝ, ∀ P : ABCPoint,
      P.largePairAggregateSurplus ≤
        2 * epsilon * P.conductor + K

/-- Uniform subcritical aggregate-surplus control proves abc. -/
theorem abc_of_uniformLargePairAggregateSurplusBound
    (hbound : UniformLargePairAggregateSurplusBound) :
    ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨K, hK⟩ := hbound epsilon hepsilon
  refine ⟨(K + Real.log 2) / 2, ?_⟩
  intro a b c ha hb hc hsum hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcoprime }
  have hpoint := ABCPoint.height_le_of_aggregateSurplus_bound P (hK P)
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

#print axioms ABCPoint.largeEndpoint_le_c
#print axioms ABCPoint.largePairLog_le_two_height
#print axioms ABCPoint.two_height_sub_log_two_le_largePairLog
#print axioms ABCPoint.largePairRadicalLog_le_conductor
#print axioms ABCPoint.two_mul_height_le_log_two_add_two_mul_conductor_add_aggregateSurplus
#print axioms ABCPoint.height_le_of_aggregateSurplus_bound
#print axioms ABCPoint.aggregateSurplus_large_of_height_violation
#print axioms ABCPoint.aggregateSurplus_corridor
#print axioms abc_of_uniformLargePairAggregateSurplusBound

end
end LargeEndpointAggregateSurplus
end IUTThreeClosures
