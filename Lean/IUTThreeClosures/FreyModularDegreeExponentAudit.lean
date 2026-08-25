/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# Scalar audit for the Frey modular-degree route

This file contains only real-number bookkeeping.  Its variables are intended
to stand for logarithms of a conductor, a modular degree, a Petersson
covolume, and heights.  Every arithmetic or geometric input is an explicit
hypothesis.  In particular, this file does **not** formalize modularity, a
modular parametrization, a Manin constant, an adjoint-L-value estimate,
Faltings heights, a conductor calculation, Szpiro, or abc.

The main coefficient calculation is the following.  A modular-degree
coefficient `α`, a Petersson lower coefficient `β`, the factor `1 / 2` in the
area identity, and the factor `12` in the Faltings--`j` comparison produce
the `j`-height coefficient

`12 * (α - β) / 2 = 6 * (α - β)`.

Thus the expected Petersson coefficient `β = 1` turns a degree exponent
`α = 2 + η` into the sharp `j`-height coefficient `6 + 6η`.
-/

namespace IUTThreeClosures

/-- Exact solution of the logarithmic modular-area identity.  Here
`degreeLog - 2 * maninLog` is the logarithm of the normalized modular degree,
and `formCovolumeLog` includes the `(2π)²` normalization. -/
theorem relativeHeight_eq_of_modular_area
    (degreeLog maninLog formCovolumeLog relativeHeight : ℝ)
    (harea :
      2 * relativeHeight =
        degreeLog - 2 * maninLog - formCovolumeLog) :
    relativeHeight =
      ((degreeLog - 2 * maninLog) - formCovolumeLog) / 2 := by
  linarith

/-- Coefficient audit before inserting any particular degree or Petersson
exponent.  A nonnegative logarithmic Manin constant has the favorable sign
for this upper-bound direction. -/
theorem modular_degree_petersson_coefficient_audit
    (conductorLog degreeLog formCovolumeLog maninLog : ℝ)
    (relativeHeight stableHeight jHeight : ℝ)
    (degreeCoeff peterssonCoeff degreeError peterssonError jError : ℝ)
    (harea :
      relativeHeight =
        (degreeLog - 2 * maninLog - formCovolumeLog) / 2)
    (hmanin : 0 ≤ maninLog)
    (hstable : stableHeight ≤ relativeHeight)
    (hdegree :
      degreeLog ≤ degreeCoeff * conductorLog + degreeError)
    (hpetersson :
      peterssonCoeff * conductorLog - peterssonError ≤
        formCovolumeLog)
    (hj : jHeight ≤ 12 * stableHeight + jError) :
    jHeight ≤
      6 * (degreeCoeff - peterssonCoeff) * conductorLog +
        6 * (degreeError + peterssonError) + jError := by
  linarith

/-- The Frey target: degree exponent `2 + η` and Petersson exponent `1`
give `j`-height slope `6 + 6η`. -/
theorem modular_degree_two_plus_eta_to_j_six_plus_six_eta
    (conductorLog degreeLog formCovolumeLog maninLog : ℝ)
    (relativeHeight stableHeight jHeight : ℝ)
    (η degreeError peterssonError jError : ℝ)
    (harea :
      relativeHeight =
        (degreeLog - 2 * maninLog - formCovolumeLog) / 2)
    (hmanin : 0 ≤ maninLog)
    (hstable : stableHeight ≤ relativeHeight)
    (hdegree :
      degreeLog ≤ (2 + η) * conductorLog + degreeError)
    (hpetersson :
      conductorLog - peterssonError ≤ formCovolumeLog)
    (hj : jHeight ≤ 12 * stableHeight + jError) :
    jHeight ≤
      (6 + 6 * η) * conductorLog +
        6 * (degreeError + peterssonError) + jError := by
  have h := modular_degree_petersson_coefficient_audit
    conductorLog degreeLog formCovolumeLog maninLog
    relativeHeight stableHeight jHeight
    (2 + η) 1 degreeError peterssonError jError
    harea hmanin hstable hdegree (by simpa using hpetersson) hj
  calc
    jHeight ≤
        6 * ((2 + η) - 1) * conductorLog +
          6 * (degreeError + peterssonError) + jError := h
    _ = (6 + 6 * η) * conductorLog +
          6 * (degreeError + peterssonError) + jError := by ring

/-- The same audit with the Manin term already absorbed into the normalized
degree log `normalizedDegreeLog = degreeLog - 2 * maninLog`. -/
theorem normalized_modular_degree_to_j_budget
    (conductorLog normalizedDegreeLog formCovolumeLog : ℝ)
    (relativeHeight stableHeight jHeight : ℝ)
    (η degreeError peterssonError jError : ℝ)
    (harea :
      relativeHeight =
        (normalizedDegreeLog - formCovolumeLog) / 2)
    (hstable : stableHeight ≤ relativeHeight)
    (hdegree :
      normalizedDegreeLog ≤
        (2 + η) * conductorLog + degreeError)
    (hpetersson :
      conductorLog - peterssonError ≤ formCovolumeLog)
    (hj : jHeight ≤ 12 * stableHeight + jError) :
    jHeight ≤
      (6 + 6 * η) * conductorLog +
        6 * (degreeError + peterssonError) + jError := by
  linarith

/-- Adding the Frey corridor `log c ≤ h(j) / 6 + corridorError` transfers
the same excess `η` to the final abc exponent. -/
theorem modular_j_budget_to_abc_budget
    (conductorLog jHeight logC : ℝ)
    (η degreeError peterssonError jError corridorError : ℝ)
    (hj :
      jHeight ≤
        (6 + 6 * η) * conductorLog +
          6 * (degreeError + peterssonError) + jError)
    (hcorridor : logC ≤ jHeight / 6 + corridorError) :
    logC ≤
      (1 + η) * conductorLog + degreeError + peterssonError +
        jError / 6 + corridorError := by
  linarith

/-- An explicit elementary form of the sublinear absorption used for the
Pazuki error `6 * log (1 + jHeight)`.  No asymptotic notation is hidden:
the displayed final summand is a constant once `ρ > 0` is fixed. -/
theorem pazukiLogError_sublinear
    (jHeight ρ : ℝ) (hjHeight : 0 ≤ jHeight) (hρ : 0 < ρ) :
    6 * Real.log (1 + jHeight) ≤
      ρ * jHeight +
        (ρ - 6 - 6 * Real.log (ρ / 6)) := by
  have hone : 0 < 1 + jHeight := by linarith
  have hsix : (0 : ℝ) < 6 := by norm_num
  have hscale : 0 < ρ / 6 := div_pos hρ hsix
  have hlog := Real.log_le_sub_one_of_pos (mul_pos hscale hone)
  rw [Real.log_mul hscale.ne' hone.ne'] at hlog
  nlinarith

/-- Pure scalar absorption.  It is meant to be applied only after replacing a
sublinear `j`-comparison error by `ρ * jHeight + constant`, for some fixed
`0 ≤ ρ < 1`. -/
theorem absorb_linear_j_error
    (jHeight baseBudget ρ constant : ℝ)
    (_hρnonneg : 0 ≤ ρ) (hρlt : ρ < 1)
    (hbudget : jHeight ≤ baseBudget + ρ * jHeight + constant) :
    jHeight ≤ (baseBudget + constant) / (1 - ρ) := by
  apply (le_div_iff₀ (by linarith : 0 < 1 - ρ)).2
  nlinarith

/-- There is no hidden cancellation in the coefficient audit: if all upper
and lower inputs are attained exactly, degree excess `η` becomes exactly
`6η` in the `j`-height slope. -/
theorem degree_excess_survives_exactly (conductorLog η : ℝ) :
    12 * ((((2 + η) * conductorLog) - conductorLog) / 2) =
      (6 + 6 * η) * conductorLog := by
  ring

/-- For positive conductor log and positive degree excess, the exact witness
has strictly larger slope than six. -/
theorem positive_degree_excess_breaks_slope_six
    {conductorLog η : ℝ}
    (hconductor : 0 < conductorLog) (hη : 0 < η) :
    6 * conductorLog <
      12 * ((((2 + η) * conductorLog) - conductorLog) / 2) := by
  nlinarith

/-- A coarse upper envelope lying above the target coefficient cannot, by
itself, force the target bound.  This supplies an elementary countermodel to
any purely formal inference from such an envelope. -/
theorem coarse_degree_upper_does_not_force_exponent_two
    {conductorLog η upperEnvelope : ℝ}
    (hconductor : 0 < conductorLog) (hη : 0 < η)
    (henvelope : (2 + η) * conductorLog ≤ upperEnvelope) :
    ∃ degreeLog,
      degreeLog ≤ upperEnvelope ∧
        2 * conductorLog < degreeLog := by
  refine ⟨(2 + η) * conductorLog, henvelope, ?_⟩
  nlinarith

end IUTThreeClosures
