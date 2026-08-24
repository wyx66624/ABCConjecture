/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The scalar contradiction in GenEll Lemma 4.1

Lemma 4.1 of *Arithmetic Elliptic Curves in General Position* chooses

`delta = 6 * epsilon`,
`y_A = (1 + delta) * x_A + 8 * h`.

After the prime-counting step, failure to find the required distinct primes
would imply

`x_A >= -Mlog - theta((1+delta)h) + theta(y_A)`.

The hypotheses of the lemma give

* `Mlog <= epsilon * y_A`;
* `theta((1+delta)h) < 5/4 * (1+delta)h + C_epsilon`;
* `(1-epsilon)y_A < theta(y_A)`;
* `C_epsilon < epsilon*x_epsilon < epsilon*x_A`.

For `0 < epsilon < 1/4`, these inequalities are inconsistent.  This module
formalizes that exact real-algebraic contradiction, independently of the
analytic theorem used to provide the Chebyshev bounds and independently of
the finite-set counting argument.

Together with `ChebyshevMultiplePrimeEscape`, the remaining content of the
printed Lemma 4.1 is now reduced to matching strict/non-strict endpoint
conventions and instantiating the two Chebyshev estimates.
-/

namespace IUTThreeClosures

/-- The upper radius used in GenEll Lemma 4.1. -/
def genEllLemma41Radius (ε xA h : ℝ) : ℝ :=
  (1 + 6 * ε) * xA + 8 * h

/-- The coefficient of `x_A` in the contradiction exceeds `epsilon` by the
strictly positive quantity `3*epsilon*(1-4*epsilon)`. -/
theorem genEllLemma41_x_coefficient_identity (ε : ℝ) :
    (1 - 2 * ε) * (1 + 6 * ε) - 1 =
      ε + 3 * ε * (1 - 4 * ε) := by
  ring

/-- The coefficient of `h` in the exact calculation. -/
theorem genEllLemma41_h_coefficient_identity (ε : ℝ) :
    8 * (1 - 2 * ε) - (5 / 4 : ℝ) * (1 + 6 * ε) =
      27 / 4 - (47 / 2) * ε := by
  ring

/-- For `epsilon < 1/4`, the `h`-coefficient is strictly positive. -/
theorem genEllLemma41_h_coefficient_pos
    {ε : ℝ} (hε : ε < 1 / 4) :
    0 < 27 / 4 - (47 / 2) * ε := by
  nlinarith

/-- **Exact scalar core of GenEll Lemma 4.1.**  The lower bound obtained from
an offending set of primes contradicts the printed Chebyshev and logarithmic
estimates. -/
theorem genEllLemma41_scalar_contradiction
    {ε xε Cε xA h Mlog thetaH thetaY : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hCε : Cε < ε * xε)
    (hxA : xε < xA)
    (hh : 0 ≤ h)
    (hMlog : Mlog ≤ ε * genEllLemma41Radius ε xA h)
    (hthetaH :
      thetaH <
        (5 / 4 : ℝ) * ((1 + 6 * ε) * h) + Cε)
    (hthetaY :
      (1 - ε) * genEllLemma41Radius ε xA h < thetaY) :
    ¬ xA ≥ -Mlog - thetaH + thetaY := by
  intro hoffending
  have hxApos : 0 < xA := hxεpos.trans hxA
  have hεx : ε * xε < ε * xA :=
    mul_lt_mul_of_pos_left hxA hεpos
  have hCεA : Cε < ε * xA := hCε.trans hεx
  have hquarter : 0 < 1 - 4 * ε := by
    nlinarith
  have hxextra :
      0 < 3 * ε * (1 - 4 * ε) * xA := by
    positivity
  have hhcoef :
      0 < 27 / 4 - (47 / 2) * ε :=
    genEllLemma41_h_coefficient_pos hεlt
  have hhterm :
      0 ≤ (27 / 4 - (47 / 2) * ε) * h :=
    mul_nonneg hhcoef.le hh
  unfold genEllLemma41Radius at hMlog hthetaY
  nlinarith [
    genEllLemma41_x_coefficient_identity ε,
    genEllLemma41_h_coefficient_identity ε,
    hxextra,
    hhterm]

/-- A convenient reformulation: under the scalar hypotheses, every lower
bound of the offending-set form is strictly smaller than `x_A`. -/
theorem genEllLemma41_offending_bound_lt
    {ε xε Cε xA h Mlog thetaH thetaY : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hCε : Cε < ε * xε)
    (hxA : xε < xA)
    (hh : 0 ≤ h)
    (hMlog : Mlog ≤ ε * genEllLemma41Radius ε xA h)
    (hthetaH :
      thetaH <
        (5 / 4 : ℝ) * ((1 + 6 * ε) * h) + Cε)
    (hthetaY :
      (1 - ε) * genEllLemma41Radius ε xA h < thetaY) :
    -Mlog - thetaH + thetaY < xA := by
  exact lt_of_not_ge <|
    genEllLemma41_scalar_contradiction
      hεpos hεlt hxεpos hCε hxA hh
      hMlog hthetaH hthetaY

end IUTThreeClosures
