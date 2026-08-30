/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EndpointBalanceCoefficientTransfer
import IUTThreeClosures.IteratedRadicalExcessSplit
import Mathlib.RingTheory.Radical.NatInt
import Mathlib.Tactic

/-!
# Splitting the conductor budget at an endpoint-degenerate abc point

Let `m=min(a,b)` and `M=max(a,b)`.  Primitivity gives

`rad(abc) = rad(m) * rad(M*c)`.

The high-multiplicity excess relevant to the large adjacent pair is controlled
against `rad(M*c)`, not against the full radical.  This yields the sharper
ledger

`2h <= log 2 + 2 log rad(M*c) + log Q₂(M*c)`.

Consequently the exact remaining sufficient estimate charges the small
endpoint radical with coefficient `2(1+epsilon)` and the large-pair radical
with coefficient `2epsilon`.  Every violation must simultaneously have a
small-endpoint radical deficit and a large-pair repeated-prime surplus.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid
open IteratedRadicalExcessSplit

noncomputable section

namespace ABCPoint

/-- Radical log of the smaller additive endpoint. -/
def smallEndpointRadicalLog (P : ABCPoint) : ℝ :=
  Real.log (abcRadical P.endpointMin : ℝ)

/-- Radical log of the two large adjacent endpoints. -/
def largePairRadicalLog (P : ABCPoint) : ℝ :=
  Real.log (abcRadical (P.largeEndpoint * P.c) : ℝ)

/-- The min/max product is the product of the two summands. -/
theorem endpointMin_mul_largeEndpoint_eq_ab (P : ABCPoint) :
    P.endpointMin * P.largeEndpoint = P.a * P.b := by
  by_cases hab : P.a ≤ P.b
  · simp [endpointMin, largeEndpoint, hab]
  · have hba : P.b ≤ P.a := by omega
    simp [endpointMin, largeEndpoint, hba, Nat.mul_comm]

/-- The two additive endpoints remain coprime after ordering them. -/
theorem endpointMin_coprime_largeEndpoint (P : ABCPoint) :
    Nat.Coprime P.endpointMin P.largeEndpoint := by
  by_cases hab : P.a ≤ P.b
  · simpa [endpointMin, largeEndpoint, hab] using P.pairwise_coprime.1
  · have hba : P.b ≤ P.a := by omega
    simpa [endpointMin, largeEndpoint, hba] using P.pairwise_coprime.1.symm

/-- The smaller summand is coprime to the sum. -/
theorem endpointMin_coprime_c (P : ABCPoint) :
    Nat.Coprime P.endpointMin P.c := by
  by_cases hab : P.a ≤ P.b
  · simpa [endpointMin, hab] using P.pairwise_coprime.2.2.symm
  · have hba : P.b ≤ P.a := by omega
    simpa [endpointMin, hba] using P.pairwise_coprime.2.1

/-- The smaller endpoint is coprime to the complete large adjacent pair. -/
theorem endpointMin_coprime_largePair (P : ABCPoint) :
    Nat.Coprime P.endpointMin (P.largeEndpoint * P.c) :=
  P.endpointMin_coprime_largeEndpoint.mul_right P.endpointMin_coprime_c

/-- Exact radical factorization into the small endpoint and the large pair. -/
theorem abcRadical_eq_small_mul_largePair (P : ABCPoint) :
    abcRadical (P.a * P.b * P.c) =
      abcRadical P.endpointMin *
        abcRadical (P.largeEndpoint * P.c) := by
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical,
    abcRadical_eq_natRadical]
  have hproduct :
      P.a * P.b * P.c =
        P.endpointMin * (P.largeEndpoint * P.c) := by
    rw [← P.endpointMin_mul_largeEndpoint_eq_ab]
    ring
  rw [hproduct]
  exact UniqueFactorizationMonoid.radical_mul
    (Nat.coprime_iff_isRelPrime.mp P.endpointMin_coprime_largePair)

/-- The elementary conductor splits exactly into the two radical budgets. -/
theorem conductor_eq_smallEndpointRadicalLog_add_largePairRadicalLog
    (P : ABCPoint) :
    P.conductor = P.smallEndpointRadicalLog + P.largePairRadicalLog := by
  have hsmall : 0 < (abcRadical P.endpointMin : ℝ) := by
    exact_mod_cast abcRadical_pos P.endpointMin
  have hlarge :
      0 < (abcRadical (P.largeEndpoint * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.largeEndpoint * P.c)
  unfold ABCPoint.conductor smallEndpointRadicalLog largePairRadicalLog
  rw [P.abcRadical_eq_small_mul_largePair]
  push_cast
  exact Real.log_mul hsmall.ne' hlarge.ne'

/-- Both split conductor budgets are nonnegative. -/
theorem smallEndpointRadicalLog_nonneg (P : ABCPoint) :
    0 ≤ P.smallEndpointRadicalLog := by
  unfold smallEndpointRadicalLog
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr (abcRadical_pos P.endpointMin).ne')

theorem largePairRadicalLog_nonneg (P : ABCPoint) :
    0 ≤ P.largePairRadicalLog := by
  unfold largePairRadicalLog
  apply Real.log_nonneg
  exact_mod_cast
    (Nat.one_le_iff_ne_zero.mpr
      (abcRadical_pos (P.largeEndpoint * P.c)).ne')

/-- Radical-square control using only the radical of the two large endpoints. -/
theorem largeEndpoint_mul_c_le_largePairRadical_sq_mul_secondQuotient
    (P : ABCPoint) :
    P.largeEndpoint * P.c ≤
      abcRadical (P.largeEndpoint * P.c) ^ 2 *
        P.largeEndpointSecondRadicalQuotient := by
  simpa [largeEndpointSecondRadicalQuotient] using
    le_radical_sq_mul_secondRadicalQuotient
      (P.largeEndpoint * P.c)

/-- Sharpened height ledger: the small endpoint radical is absent from the
base coefficient-two term. -/
theorem two_mul_height_le_log_two_add_two_mul_largePairRadicalLog_add_log_secondQuotient
    (P : ABCPoint) :
    2 * P.height ≤
      Real.log 2 + 2 * P.largePairRadicalLog +
        Real.log (P.largeEndpointSecondRadicalQuotient : ℝ) := by
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hradpos :
      0 < (abcRadical (P.largeEndpoint * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.largeEndpoint * P.c)
  have hqpos :
      0 < (P.largeEndpointSecondRadicalQuotient : ℝ) := by
    exact_mod_cast P.largeEndpointSecondRadicalQuotient_pos
  have hnat :
      P.c ^ 2 ≤
        2 * (abcRadical (P.largeEndpoint * P.c) ^ 2 *
          P.largeEndpointSecondRadicalQuotient) := by
    calc
      P.c ^ 2 ≤ 2 * (P.largeEndpoint * P.c) :=
        P.c_sq_le_two_largeEndpoint_mul_c
      _ ≤ 2 * (abcRadical (P.largeEndpoint * P.c) ^ 2 *
          P.largeEndpointSecondRadicalQuotient) :=
        Nat.mul_le_mul_left 2
          P.largeEndpoint_mul_c_le_largePairRadical_sq_mul_secondQuotient
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((abcRadical (P.largeEndpoint * P.c) : ℝ) ^ 2 *
          (P.largeEndpointSecondRadicalQuotient : ℝ)) := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0)
        (mul_pos (pow_pos hradpos 2) hqpos).ne',
      Real.log_mul (pow_pos hradpos 2).ne' hqpos.ne',
      Real.log_pow] at hlog
  rw [P.height_eq_log_c]
  unfold largePairRadicalLog
  ring_nf at hlog ⊢
  exact hlog

/-- Exact joint small-endpoint/large-pair sufficient estimate. -/
theorem height_le_of_split_excess_bound
    (P : ABCPoint) {epsilon K : ℝ}
    (hexcess :
      Real.log (P.largeEndpointSecondRadicalQuotient : ℝ) ≤
        2 * epsilon * P.largePairRadicalLog +
          2 * (1 + epsilon) * P.smallEndpointRadicalLog + K) :
    P.height ≤
      (1 + epsilon) * P.conductor + (K + Real.log 2) / 2 := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_largePairRadicalLog_add_log_secondQuotient
  rw [P.conductor_eq_smallEndpointRadicalLog_add_largePairRadicalLog]
  nlinarith

/-- Every violation must defeat the exact split radical budget. -/
theorem split_excess_large_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.largePairRadicalLog +
        2 * (1 + epsilon) * P.smallEndpointRadicalLog +
          2 * C - Real.log 2 <
      Real.log (P.largeEndpointSecondRadicalQuotient : ℝ) := by
  have hledger :=
    P.two_mul_height_le_log_two_add_two_mul_largePairRadicalLog_add_log_secondQuotient
  rw [P.conductor_eq_smallEndpointRadicalLog_add_largePairRadicalLog] at hviolation
  nlinarith

end ABCPoint

namespace EndpointRadicalExcessBudget

/-- The exact remaining uniform target after splitting the radical budget. -/
def UniformSplitEndpointExcessBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ K : ℝ, ∀ P : ABCPoint,
      Real.log (P.largeEndpointSecondRadicalQuotient : ℝ) ≤
        2 * epsilon * P.largePairRadicalLog +
          2 * (1 + epsilon) * P.smallEndpointRadicalLog + K

/-- Uniform control of the split endpoint excess proves abc. -/
theorem abc_of_uniformSplitEndpointExcessBound
    (hbound : UniformSplitEndpointExcessBound) :
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
  have hpoint := ABCPoint.height_le_of_split_excess_bound P (hK P)
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

#print axioms ABCPoint.endpointMin_mul_largeEndpoint_eq_ab
#print axioms ABCPoint.endpointMin_coprime_largePair
#print axioms ABCPoint.abcRadical_eq_small_mul_largePair
#print axioms ABCPoint.conductor_eq_smallEndpointRadicalLog_add_largePairRadicalLog
#print axioms ABCPoint.two_mul_height_le_log_two_add_two_mul_largePairRadicalLog_add_log_secondQuotient
#print axioms ABCPoint.height_le_of_split_excess_bound
#print axioms ABCPoint.split_excess_large_of_height_violation
#print axioms abc_of_uniformSplitEndpointExcessBound

end EndpointRadicalExcessBudget
end
end IUTThreeClosures
