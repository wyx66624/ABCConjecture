/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Tactic

/-!
# The exact large-endpoint net excess and its equivalence with abc

For an abc point put

`D = log(max(a,b)*c) - 2*log rad(abc)`.

Since `c/2 <= max(a,b) <= c`,

`2*height - log 2 <= log(max(a,b)*c) <= 2*height`.

Consequently a uniform bound `D <= 2*epsilon*conductor + O_epsilon(1)`
is equivalent, up to the explicit factor-two normalization and `log 2`, to the
usual logarithmic abc conjecture.  This file is an audit: simply renaming the
remaining quality defect as a net excess does not make the hard theorem
weaker.
-/

namespace IUTThreeClosures
namespace LargeEndpointNetExcessEquivalence

noncomputable section

namespace ABCPoint

/-- Logarithmic size of the product of the two large adjacent endpoints. -/
def largeEndpointProductLog (P : ABCPoint) : ℝ :=
  Real.log (((P.largeEndpoint * P.c : ℕ) : ℝ))

/-- The larger summand is at most the sum. -/
theorem largeEndpoint_le_c (P : ABCPoint) : P.largeEndpoint ≤ P.c := by
  unfold largeEndpoint
  exact max_le (Nat.le_of_lt P.a_lt_c) (Nat.le_of_lt P.b_lt_c)

/-- Upper natural-number corridor for the large-endpoint product. -/
theorem largeEndpoint_mul_c_le_c_sq (P : ABCPoint) :
    P.largeEndpoint * P.c ≤ P.c ^ 2 := by
  have hmul := Nat.mul_le_mul_right P.c P.largeEndpoint_le_c
  simpa [pow_two] using hmul

/-- Upper logarithmic corridor. -/
theorem largeEndpointProductLog_le_two_height (P : ABCPoint) :
    P.largeEndpointProductLog ≤ 2 * P.height := by
  have hnpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast (mul_pos P.largeEndpoint_pos P.c_pos)
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hreal :
      ((P.largeEndpoint * P.c : ℕ) : ℝ) ≤ (P.c : ℝ) ^ 2 := by
    exact_mod_cast P.largeEndpoint_mul_c_le_c_sq
  have hlog := Real.log_le_log hnpos hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne'] at hlog
  rw [P.height_eq_log_c]
  exact hlog

/-- Lower logarithmic corridor inherited from `c^2 <= 2*max(a,b)*c`. -/
theorem two_height_sub_log_two_le_largeEndpointProductLog (P : ABCPoint) :
    2 * P.height - Real.log 2 ≤ P.largeEndpointProductLog := by
  have hcpos : 0 < (P.c : ℝ) := by exact_mod_cast P.c_pos
  have hnpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast (mul_pos P.largeEndpoint_pos P.c_pos)
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast P.c_sq_le_two_largeEndpoint_mul_c
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hnpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold largeEndpointProductLog
  linarith

/-- The net large-endpoint defect relative to twice the full abc conductor. -/
def largeEndpointNetExcess (P : ABCPoint) : ℝ :=
  P.largeEndpointProductLog - 2 * P.conductor

/-- Lower defect corridor. -/
theorem two_height_sub_log_two_sub_two_conductor_le_netExcess
    (P : ABCPoint) :
    2 * P.height - Real.log 2 - 2 * P.conductor ≤
      P.largeEndpointNetExcess := by
  have h := P.two_height_sub_log_two_le_largeEndpointProductLog
  unfold largeEndpointNetExcess
  linarith

/-- Upper defect corridor. -/
theorem netExcess_le_two_height_sub_two_conductor (P : ABCPoint) :
    P.largeEndpointNetExcess ≤
      2 * P.height - 2 * P.conductor := by
  have h := P.largeEndpointProductLog_le_two_height
  unfold largeEndpointNetExcess
  linarith

/-- Every pointwise abc violation forces a large net excess. -/
theorem netExcess_large_of_height_violation
    (P : ABCPoint) {epsilon C : ℝ}
    (hviolation :
      (1 + epsilon) * P.conductor + C < P.height) :
    2 * epsilon * P.conductor + 2 * C - Real.log 2 <
      P.largeEndpointNetExcess := by
  have hcorridor :=
    P.two_height_sub_log_two_sub_two_conductor_le_netExcess
  nlinarith

/-- Conversely, a net excess above the threshold without the harmless
`log 2` already forces an abc violation. -/
theorem height_violation_of_netExcess_large
    (P : ABCPoint) {epsilon C : ℝ}
    (hexcess :
      2 * epsilon * P.conductor + 2 * C <
        P.largeEndpointNetExcess) :
    (1 + epsilon) * P.conductor + C < P.height := by
  have hcorridor := P.netExcess_le_two_height_sub_two_conductor
  nlinarith

end ABCPoint

/-- Uniform subcritical control of the net defect. -/
def UniformLargeEndpointNetExcessBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ K : ℝ, ∀ P : ABCPoint,
      P.largeEndpointNetExcess ≤
        2 * epsilon * P.conductor + K

/-- Uniform net-excess control implies abc. -/
theorem abc_of_uniformLargeEndpointNetExcessBound
    (hbound : UniformLargeEndpointNetExcessBound) :
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
  have hlower :=
    P.two_height_sub_log_two_sub_two_conductor_le_netExcess
  have hnet := hK P
  have hpoint :
      P.height ≤
        (1 + epsilon) * P.conductor +
          (K + Real.log 2) / 2 := by
    nlinarith
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

/-- The abc conjecture itself supplies uniform net-excess control. -/
theorem uniformLargeEndpointNetExcessBound_of_abc
    (habc : ABCConjecture) :
    UniformLargeEndpointNetExcessBound := by
  intro epsilon hepsilon
  obtain ⟨C, hC⟩ := habc epsilon hepsilon
  refine ⟨2 * C, ?_⟩
  intro P
  have habcP :=
    hC P.a P.b P.c P.a_pos P.b_pos P.c_pos
      P.sum_eq P.pairwise_coprime
  have hupper := P.largeEndpointProductLog_le_two_height
  unfold ABCPoint.largeEndpointNetExcess
  simpa [ABCPoint.height, ABCPoint.conductor] at habcP
  nlinarith

/-- Exact logical equivalence, with only explicit constant renormalization. -/
theorem uniformLargeEndpointNetExcessBound_iff_abc :
    UniformLargeEndpointNetExcessBound ↔ ABCConjecture := by
  constructor
  · exact abc_of_uniformLargeEndpointNetExcessBound
  · exact uniformLargeEndpointNetExcessBound_of_abc

#print axioms ABCPoint.largeEndpointProductLog_le_two_height
#print axioms ABCPoint.two_height_sub_log_two_le_largeEndpointProductLog
#print axioms ABCPoint.netExcess_large_of_height_violation
#print axioms ABCPoint.height_violation_of_netExcess_large
#print axioms abc_of_uniformLargeEndpointNetExcessBound
#print axioms uniformLargeEndpointNetExcessBound_of_abc
#print axioms uniformLargeEndpointNetExcessBound_iff_abc

end
end LargeEndpointNetExcessEquivalence
end IUTThreeClosures
