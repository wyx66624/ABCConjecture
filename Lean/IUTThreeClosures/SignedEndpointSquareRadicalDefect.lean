/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointPowerFreeClosure
import Mathlib.Tactic

/-!
# The signed square-radical defect of the two large abc endpoints

The unsigned cubeful quotient overcounts the obstruction: a prime occurring
once contributes negatively relative to `rad^2` and can cancel a high exponent
on the other endpoint.  The correct signed quantity is

`log(max(a,b)*c) - 2*log(rad(abc))`.

This file proves that a uniform subcritical bound for this signed defect is
*equivalent* to the logarithmic abc conjecture.  Thus the reformulation loses
neither the exponent-one cancellation nor any quantifier.
-/

namespace IUTThreeClosures
namespace SignedEndpointSquareRadicalDefect

noncomputable section

namespace ABCPoint

/-- Logarithmic size of the product of the two large adjacent endpoints. -/
def largeEndpointProductLog (P : ABCPoint) : ℝ :=
  Real.log (((P.largeEndpoint * P.c : ℕ) : ℝ))

/-- Signed defect from the square of the full abc radical. -/
def signedEndpointSquareRadicalDefect (P : ABCPoint) : ℝ :=
  P.largeEndpointProductLog - 2 * P.conductor

/-- The larger summand is at most the sum. -/
theorem largeEndpoint_le_c (P : ABCPoint) :
    P.largeEndpoint ≤ P.c := by
  unfold largeEndpoint
  exact max_le (Nat.le_of_lt P.a_lt_c) (Nat.le_of_lt P.b_lt_c)

/-- Upper product corridor `max(a,b)*c <= c^2`. -/
theorem largeEndpoint_mul_c_le_c_sq (P : ABCPoint) :
    P.largeEndpoint * P.c ≤ P.c ^ 2 := by
  have hmul := Nat.mul_le_mul_right P.c P.largeEndpoint_le_c
  simpa [pow_two] using hmul

/-- Lower logarithmic product corridor. -/
theorem two_height_sub_log_two_le_largeEndpointProductLog
    (P : ABCPoint) :
    2 * P.height - Real.log 2 ≤ P.largeEndpointProductLog := by
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hprodpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast mul_pos P.largeEndpoint_pos P.c_pos
  have hreal :
      (P.c : ℝ) ^ 2 ≤
        2 * ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast P.c_sq_le_two_largeEndpoint_mul_c
  have hlog := Real.log_le_log (pow_pos hcpos 2) hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne',
      Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hprodpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold largeEndpointProductLog
  linarith

/-- Upper logarithmic product corridor. -/
theorem largeEndpointProductLog_le_two_height (P : ABCPoint) :
    P.largeEndpointProductLog ≤ 2 * P.height := by
  have hprodpos : 0 < ((P.largeEndpoint * P.c : ℕ) : ℝ) := by
    exact_mod_cast mul_pos P.largeEndpoint_pos P.c_pos
  have hcpos : 0 < (P.c : ℝ) := by
    exact_mod_cast P.c_pos
  have hreal :
      ((P.largeEndpoint * P.c : ℕ) : ℝ) ≤ (P.c : ℝ) ^ 2 := by
    exact_mod_cast P.largeEndpoint_mul_c_le_c_sq
  have hlog := Real.log_le_log hprodpos hreal
  rw [show (P.c : ℝ) ^ 2 = (P.c : ℝ) * P.c by ring,
      Real.log_mul hcpos.ne' hcpos.ne'] at hlog
  rw [P.height_eq_log_c]
  unfold largeEndpointProductLog
  linarith

/-- Exact two-sided corridor for the signed defect. -/
theorem signedEndpointSquareRadicalDefect_corridor (P : ABCPoint) :
    2 * P.height - 2 * P.conductor - Real.log 2 ≤
        P.signedEndpointSquareRadicalDefect ∧
      P.signedEndpointSquareRadicalDefect ≤
        2 * P.height - 2 * P.conductor := by
  constructor
  · have h := P.two_height_sub_log_two_le_largeEndpointProductLog
    unfold signedEndpointSquareRadicalDefect
    linarith
  · have h := P.largeEndpointProductLog_le_two_height
    unfold signedEndpointSquareRadicalDefect
    linarith

end ABCPoint

/-- Uniform subcritical control of the signed endpoint defect. -/
def UniformSignedEndpointSquareRadicalDefectBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ K : ℝ, ∀ P : ABCPoint,
      P.signedEndpointSquareRadicalDefect ≤
        2 * epsilon * P.conductor + K

/-- Signed-defect control implies abc. -/
theorem abc_of_uniformSignedEndpointSquareRadicalDefectBound
    (hdefect : UniformSignedEndpointSquareRadicalDefectBound) :
    ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨K, hK⟩ := hdefect epsilon hepsilon
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
    (ABCPoint.signedEndpointSquareRadicalDefect_corridor P).1
  have hupper := hK P
  have hpoint :
      P.height ≤
        (1 + epsilon) * P.conductor + (K + Real.log 2) / 2 := by
    nlinarith
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

/-- The abc conjecture gives the signed-defect bound with exactly twice its
height constant. -/
theorem uniformSignedEndpointSquareRadicalDefectBound_of_abc
    (habc : ABCConjecture) :
    UniformSignedEndpointSquareRadicalDefectBound := by
  intro epsilon hepsilon
  obtain ⟨C, hC⟩ := habc epsilon hepsilon
  refine ⟨2 * C, ?_⟩
  intro P
  have habcP :
      P.height ≤ (1 + epsilon) * P.conductor + C := by
    have h := hC P.a P.b P.c P.a_pos P.b_pos P.c_pos
      P.sum_eq P.pairwise_coprime
    have hmax : max P.a (max P.b P.c) = P.c := by
      omega
    simpa [ABCPoint.height, ABCPoint.conductor, hmax] using h
  have hdefectUpper :=
    (ABCPoint.signedEndpointSquareRadicalDefect_corridor P).2
  nlinarith

/-- Exact logical equivalence of the signed-defect formulation and abc. -/
theorem uniformSignedEndpointSquareRadicalDefectBound_iff_abc :
    UniformSignedEndpointSquareRadicalDefectBound ↔ ABCConjecture := by
  constructor
  · exact abc_of_uniformSignedEndpointSquareRadicalDefectBound
  · exact uniformSignedEndpointSquareRadicalDefectBound_of_abc

/-- Scalar audit: an unsigned excess with slope one cannot be bounded by a
fixed coefficient strictly below one.  This records the cancellation that is
lost when exponent-one primes are omitted. -/
theorem no_uniform_subunit_bound_for_unsigned_linear_excess
    {rho : ℝ} (hrho : rho < 1) :
    ¬ ∃ K : ℝ, ∀ x : ℝ, 0 ≤ x → x ≤ rho * x + K := by
  rintro ⟨K, hK⟩
  let x : ℝ := (|K| + 1) / (1 - rho)
  have hden : 0 < 1 - rho := by linarith
  have hx : 0 ≤ x := by
    dsimp [x]
    positivity
  have hbound := hK x hx
  have hidentity : (1 - rho) * x = |K| + 1 := by
    dsimp [x]
    field_simp [hden.ne']
  have hKabs : K ≤ |K| := le_abs_self K
  nlinarith

#print axioms ABCPoint.signedEndpointSquareRadicalDefect_corridor
#print axioms abc_of_uniformSignedEndpointSquareRadicalDefectBound
#print axioms uniformSignedEndpointSquareRadicalDefectBound_of_abc
#print axioms uniformSignedEndpointSquareRadicalDefectBound_iff_abc
#print axioms no_uniform_subunit_bound_for_unsigned_linear_excess

end
end SignedEndpointSquareRadicalDefect
end IUTThreeClosures
