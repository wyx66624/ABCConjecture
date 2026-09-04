/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointExternalRadical
import Mathlib.Tactic

/-!
# One-sided concentration forced by every remaining abc violation

The exact compensated-excess obstruction can be split between the two large
coprime endpoints. For a positive integer `n`, let

`σ₂(n) = log n - 2 log(rad n)`.

For coprime integers this statistic is additive. Hence, for an abc point with
`m=min(a,b)` and `M=max(a,b)`, every violation of

`height <= (1+ε) conductor + C`

forces at least one of `M` and `c` to satisfy

`σ₂(x) > log(rad m) + ε conductor + C - log 2 / 2`.

At `ε=C=0`, one of the two large endpoints obeys the explicit integer-scale
concentration inequality `x > rad(x)^2 * rad(m)` after exponentiating. This
file proves the dichotomy without assuming any distribution statement for
powerful numbers.
-/

namespace IUTThreeClosures
namespace LargeEndpointOneSidedConcentration

noncomputable section

/-- Signed exponent-two excess of a positive integer. -/
def exponentTwoSignedExcess (n : ℕ) : ℝ :=
  Real.log (n : ℝ) - 2 * Real.log (abcRadical n : ℝ)

/-- Signed excess is additive on coprime positive products. -/
theorem exponentTwoSignedExcess_mul_of_coprime
    {x y : ℕ} (hx : 0 < x) (hy : 0 < y)
    (hcop : Nat.Coprime x y) :
    exponentTwoSignedExcess (x * y) =
      exponentTwoSignedExcess x + exponentTwoSignedExcess y := by
  have hxR : 0 < (x : ℝ) := by exact_mod_cast hx
  have hyR : 0 < (y : ℝ) := by exact_mod_cast hy
  have hradxR : 0 < (abcRadical x : ℝ) := by
    exact_mod_cast abcRadical_pos x
  have hradyR : 0 < (abcRadical y : ℝ) := by
    exact_mod_cast abcRadical_pos y
  unfold exponentTwoSignedExcess
  rw [Nat.cast_mul, Real.log_mul hxR.ne' hyR.ne',
      abcRadical_mul_of_coprime hcop, Nat.cast_mul,
      Real.log_mul hradxR.ne' hradyR.ne']
  ring

/-- A logarithmic one-sided excess inequality gives the corresponding
strict natural-number concentration inequality. -/
theorem nat_concentration_of_exponentTwoSignedExcess
    {x m : ℕ} (hx : 0 < x)
    (h : Real.log (abcRadical m : ℝ) <
      exponentTwoSignedExcess x) :
    abcRadical x ^ 2 * abcRadical m < x := by
  have hxR : 0 < (x : ℝ) := by exact_mod_cast hx
  have hradxR : 0 < (abcRadical x : ℝ) := by
    exact_mod_cast abcRadical_pos x
  have hradmR : 0 < (abcRadical m : ℝ) := by
    exact_mod_cast abcRadical_pos m
  have hleftR :
      0 < ((abcRadical x ^ 2 * abcRadical m : ℕ) : ℝ) := by
    exact_mod_cast mul_pos (pow_pos (abcRadical_pos x) 2)
      (abcRadical_pos m)
  have hlog :
      Real.log (((abcRadical x ^ 2 * abcRadical m : ℕ) : ℝ)) <
        Real.log (x : ℝ) := by
    unfold exponentTwoSignedExcess at h
    rw [Nat.cast_mul, Nat.cast_pow,
        Real.log_mul (pow_pos hradxR 2).ne' hradmR.ne',
        Real.log_pow]
    linarith
  have hexp := Real.exp_lt_exp.mpr hlog
  rw [Real.exp_log hleftR, Real.exp_log hxR] at hexp
  exact_mod_cast hexp

end
end LargeEndpointOneSidedConcentration

open LargeEndpointOneSidedConcentration

noncomputable section

namespace ABCPoint

/-- The two large adjacent endpoints are coprime. -/
theorem largeEndpoint_coprime_c (P : ABCPoint) :
    Nat.Coprime P.largeEndpoint P.c := by
  have hp :
      Nat.Coprime P.a P.b ∧
        Nat.Coprime P.a P.c ∧
        Nat.Coprime P.b P.c := by
    simpa [PairwiseCoprimeABC] using P.pairwise_coprime
  rcases hp with ⟨hab, hac, hbc⟩
  by_cases hle : P.a ≤ P.b
  · have hmax : P.largeEndpoint = P.b := by
      simp [largeEndpoint, hle]
    rw [hmax]
    exact hbc
  · have hba : P.b ≤ P.a := by omega
    have hmax : P.largeEndpoint = P.a := by
      simp [largeEndpoint, hba]
    rw [hmax]
    exact hac

/-- Exact decomposition of the large-product signed excess into the two
individual endpoint excesses and the small-endpoint radical. -/
theorem largeEndpointSignedExcess_eq_endpointExcessSum_sub_smallRadical
    (P : ABCPoint) :
    P.largeEndpointSignedExcess =
      exponentTwoSignedExcess P.largeEndpoint +
        exponentTwoSignedExcess P.c -
          2 * Real.log (abcRadical P.endpointMin : ℝ) := by
  have hMpos : 0 < (P.largeEndpoint : ℝ) := by
    exact_mod_cast P.largeEndpoint_pos
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hradSmallPos : 0 < (abcRadical P.endpointMin : ℝ) := by
    exact_mod_cast abcRadical_pos P.endpointMin
  have hradLargeProdPos :
      0 < (abcRadical (P.largeEndpoint * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.largeEndpoint * P.c)
  have hradMPos : 0 < (abcRadical P.largeEndpoint : ℝ) := by
    exact_mod_cast abcRadical_pos P.largeEndpoint
  have hradcPos : 0 < (abcRadical P.c : ℝ) := by
    exact_mod_cast abcRadical_pos P.c
  have hfullrad :
      abcRadical (P.a * P.b * P.c) =
        abcRadical P.endpointMin *
          abcRadical (P.largeEndpoint * P.c) := by
    rw [← P.endpointMin_mul_largeEndpoint_mul_c_eq_abcProduct]
    exact abcRadical_mul_of_coprime
      P.endpointMin_coprime_largeEndpoint_mul_c
  have hlargeRad :
      abcRadical (P.largeEndpoint * P.c) =
        abcRadical P.largeEndpoint * abcRadical P.c :=
    abcRadical_mul_of_coprime P.largeEndpoint_coprime_c
  unfold largeEndpointSignedExcess
  unfold ABCPoint.conductor
  unfold exponentTwoSignedExcess
  rw [Nat.cast_mul, Real.log_mul hMpos.ne' hcpos.ne',
      hfullrad, Nat.cast_mul,
      Real.log_mul hradSmallPos.ne' hradLargeProdPos.ne',
      hlargeRad, Nat.cast_mul,
      Real.log_mul hradMPos.ne' hradcPos.ne']
  ring

/-- Every quantitative abc violation forces a one-sided endpoint concentration.
The conclusion is a disjunction because the total signed excess is additive. -/
theorem one_largeEndpoint_excess_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    Real.log (abcRadical P.endpointMin : ℝ) +
          epsilon * P.conductor + C - Real.log 2 / 2 <
        exponentTwoSignedExcess P.largeEndpoint ∨
      Real.log (abcRadical P.endpointMin : ℝ) +
          epsilon * P.conductor + C - Real.log 2 / 2 <
        exponentTwoSignedExcess P.c := by
  have hcorridor :=
    P.two_height_sub_two_conductor_le_largeEndpointSignedExcess_add_log_two
  have hdecomp :=
    P.largeEndpointSignedExcess_eq_endpointExcessSum_sub_smallRadical
  by_contra hnot
  push_neg at hnot
  rcases hnot with ⟨hM, hc⟩
  nlinarith

/-- Strong coefficient-one violation forces one endpoint above the exact
square-root radical threshold after compensation by the small endpoint. -/
theorem one_largeEndpoint_excess_of_strong_violation
    (P : ABCPoint)
    (hviolation : P.conductor + Real.log 2 / 2 < P.height) :
    Real.log (abcRadical P.endpointMin : ℝ) <
        exponentTwoSignedExcess P.largeEndpoint ∨
      Real.log (abcRadical P.endpointMin : ℝ) <
        exponentTwoSignedExcess P.c := by
  simpa using
    (P.one_largeEndpoint_excess_of_height_violation
      (epsilon := 0) (C := Real.log 2 / 2) hviolation)

/-- Every strong violation forces one of the two large endpoints to exceed
its radical square times the radical of the small endpoint. -/
theorem one_largeEndpoint_nat_concentration_of_strong_violation
    (P : ABCPoint)
    (hviolation : P.conductor + Real.log 2 / 2 < P.height) :
    abcRadical P.largeEndpoint ^ 2 * abcRadical P.endpointMin <
        P.largeEndpoint ∨
      abcRadical P.c ^ 2 * abcRadical P.endpointMin < P.c := by
  rcases P.one_largeEndpoint_excess_of_strong_violation hviolation with hM | hc
  · exact Or.inl
      (nat_concentration_of_exponentTwoSignedExcess
        P.largeEndpoint_pos hM)
  · exact Or.inr
      (nat_concentration_of_exponentTwoSignedExcess P.c_pos hc)

end ABCPoint

namespace LargeEndpointOneSidedConcentration

#print axioms exponentTwoSignedExcess_mul_of_coprime
#print axioms nat_concentration_of_exponentTwoSignedExcess
#print axioms ABCPoint.largeEndpoint_coprime_c
#print axioms ABCPoint.largeEndpointSignedExcess_eq_endpointExcessSum_sub_smallRadical
#print axioms ABCPoint.one_largeEndpoint_excess_of_height_violation
#print axioms ABCPoint.one_largeEndpoint_excess_of_strong_violation
#print axioms ABCPoint.one_largeEndpoint_nat_concentration_of_strong_violation

end LargeEndpointOneSidedConcentration
end
end IUTThreeClosures
