/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# Logarithmic source growth is absorbable into an arbitrary conductor slope

The final quantitative ABC bridge does not require source terms to be
uniformly bounded.  It is enough that their dependence on the logarithmic
conductor be sublinear.  The basic analytic input is the tangent-line estimate

`log y <= y - 1`.

Applied to `y = eta * (1 + x)`, it gives, for `x >= 0` and `eta > 0`,

`log (1+x) <= eta*x + (eta - 1 - log eta)`.

Consequently every nonnegative multiple `A * log(1+x)` can be absorbed into
`delta*x` for an arbitrary positive slope `delta`, at the cost of an explicit
additive constant.  The final theorem composes this estimate with two
source-facing inequalities:

* `logEll <= a * log(1+conductor) + b`;
* `source <= k * logEll + d`.

Thus polynomial control of the selected auxiliary prime, together with
logarithmic dependence of a different/error term on that prime, is enough for
the absorbable-source bridge.  A uniform upper bound for the auxiliary prime
is not necessary.

This file is elementary real analysis.  It assumes no effective open-image
theorem, no estimate for an actual IUT source term, and no ABC conclusion.
-/

namespace IUTThreeClosures

/-- A scaled tangent-line bound for `log (1+x)`. -/
theorem log_one_add_le_scaled
    {x eta : ℝ}
    (hx : 0 ≤ x)
    (heta : 0 < eta) :
    Real.log (1 + x) ≤
      eta * x + (eta - 1 - Real.log eta) := by
  have hone : 0 < 1 + x := by linarith
  have hprod : 0 < eta * (1 + x) := mul_pos heta hone
  have hlog := Real.log_le_sub_one_of_pos hprod
  rw [Real.log_mul heta.ne' hone.ne'] at hlog
  nlinarith

/-- Every nonnegative multiple of `log (1+x)` has arbitrarily small linear
slope in `x`, with an explicit additive constant. -/
theorem mul_log_one_add_le_slope
    {A delta x : ℝ}
    (hA : 0 ≤ A)
    (hdelta : 0 < delta)
    (hx : 0 ≤ x) :
    A * Real.log (1 + x) ≤
      delta * x +
        A * (delta / A - 1 - Real.log (delta / A)) := by
  by_cases hAzero : A = 0
  · subst A
    simp
    exact mul_nonneg hdelta.le hx
  · have hApos : 0 < A := lt_of_le_of_ne hA (Ne.symm hAzero)
    have heta : 0 < delta / A := div_pos hdelta hApos
    have h := log_one_add_le_scaled hx heta
    have hmul := mul_le_mul_of_nonneg_left h hA
    have hratio : A * (delta / A) = delta := by
      field_simp [hAzero]
    calc
      A * Real.log (1 + x) ≤
          A * ((delta / A) * x +
            (delta / A - 1 - Real.log (delta / A))) := hmul
      _ = delta * x +
          A * (delta / A - 1 - Real.log (delta / A)) := by
        rw [mul_add, mul_assoc, hratio]

/-- A source term with logarithmic conductor growth is absorbable into an
arbitrary positive conductor slope. -/
theorem logarithmic_source_le_slope
    {source logEll conductor a b k d delta : ℝ}
    (hconductor : 0 ≤ conductor)
    (ha : 0 ≤ a)
    (hk : 0 ≤ k)
    (hdelta : 0 < delta)
    (hlogEll :
      logEll ≤ a * Real.log (1 + conductor) + b)
    (hsource : source ≤ k * logEll + d) :
    source ≤
      delta * conductor +
        (k * b + d +
          (k * a) *
            (delta / (k * a) - 1 -
              Real.log (delta / (k * a)))) := by
  have hka : 0 ≤ k * a := mul_nonneg hk ha
  have hlogmul :
      k * logEll ≤ k * (a * Real.log (1 + conductor) + b) :=
    mul_le_mul_of_nonneg_left hlogEll hk
  have habsorb :=
    mul_log_one_add_le_slope hka hdelta hconductor
  calc
    source ≤ k * logEll + d := hsource
    _ ≤ k * (a * Real.log (1 + conductor) + b) + d := by
      linarith
    _ = (k * a) * Real.log (1 + conductor) + (k * b + d) := by
      ring
    _ ≤ delta * conductor +
        (k * a) *
          (delta / (k * a) - 1 -
            Real.log (delta / (k * a))) +
        (k * b + d) := by
      linarith
    _ = delta * conductor +
        (k * b + d +
          (k * a) *
            (delta / (k * a) - 1 -
              Real.log (delta / (k * a)))) := by
      ring

/-- Existence form: any source term bounded by a logarithm of the conductor
has an arbitrarily small conductor slope with some finite additive constant. -/
theorem exists_constant_logarithmic_source_le_slope
    {source logEll conductor a b k d delta : ℝ}
    (hconductor : 0 ≤ conductor)
    (ha : 0 ≤ a)
    (hk : 0 ≤ k)
    (hdelta : 0 < delta)
    (hlogEll :
      logEll ≤ a * Real.log (1 + conductor) + b)
    (hsource : source ≤ k * logEll + d) :
    ∃ C : ℝ, source ≤ delta * conductor + C := by
  refine ⟨k * b + d +
      (k * a) *
        (delta / (k * a) - 1 -
          Real.log (delta / (k * a)), ?_⟩
  exact logarithmic_source_le_slope
    hconductor ha hk hdelta hlogEll hsource

end IUTThreeClosures
