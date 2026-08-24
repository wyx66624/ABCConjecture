/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GenEllLemma41CountingBridge

/-!
# Integer endpoints in GenEll Lemma 4.1

The printed radius in GenEll Lemma 4.1 is a real number

`y_A = (1 + 6 * epsilon) * x_A + 8 * h`.

The Chebyshev function is evaluated at natural-number endpoints.  This module
uses the natural ceiling and records every rounding error explicitly:

`y <= ceil y < y + 1`.

The lower Chebyshev estimate transfers from `ceil y` to `y` without a loss.
The upper estimate at the rounded lower endpoint incurs the explicit additive
constant `5/4`.  The logarithmic counting term is controlled by
`log (y + 1)`.  Consequently there is no hidden endpoint convention in the
connection between the printed scalar proof and the finite-prime theorem.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped BigOperators Nat.Prime

/-- Natural endpoint attached to a nonnegative real radius. -/
noncomputable def genEllNaturalEndpoint (y : ℝ) : ℕ :=
  ⌈y⌉₊

/-- The real radius lies below its natural ceiling. -/
theorem le_genEllNaturalEndpoint (y : ℝ) :
    y ≤ (genEllNaturalEndpoint y : ℝ) := by
  exact Nat.le_ceil y

/-- For a nonnegative radius, the natural ceiling is strictly less than one
more than the radius. -/
theorem genEllNaturalEndpoint_lt_add_one
    {y : ℝ} (hy : 0 ≤ y) :
    (genEllNaturalEndpoint y : ℝ) < y + 1 := by
  exact Nat.ceil_lt_add_one hy

/-- A radius at least one has a positive natural endpoint. -/
theorem one_le_genEllNaturalEndpoint
    {y : ℝ} (hy : 1 ≤ y) :
    1 ≤ genEllNaturalEndpoint y := by
  have hcast : (1 : ℝ) ≤ (genEllNaturalEndpoint y : ℝ) :=
    hy.trans (le_genEllNaturalEndpoint y)
  exact_mod_cast hcast

/-- The logarithm of the rounded endpoint is controlled by the logarithm of
`y + 1`. -/
theorem log_genEllNaturalEndpoint_lt_log_add_one
    {y : ℝ} (hy : 1 ≤ y) :
    Real.log (genEllNaturalEndpoint y) < Real.log (y + 1) := by
  have hXpos : (0 : ℝ) < genEllNaturalEndpoint y := by
    exact_mod_cast (one_le_genEllNaturalEndpoint hy).trans_lt
      (Nat.lt_succ_self _)
  have hy0 : 0 ≤ y := zero_le_one.trans hy
  exact Real.log_lt_log hXpos
    (genEllNaturalEndpoint_lt_add_one hy0)

/-- A lower Chebyshev estimate at the ceiling implies the printed lower
estimate at the real radius. -/
theorem lower_chebyshev_transfer_from_ceiling
    {ε y thetaX : ℝ}
    (hε : ε < 1)
    (hlower :
      (1 - ε) * (genEllNaturalEndpoint y : ℝ) < thetaX) :
    (1 - ε) * y < thetaX := by
  have hcoef : 0 ≤ 1 - ε := by linarith
  have hyX : y ≤ (genEllNaturalEndpoint y : ℝ) :=
    le_genEllNaturalEndpoint y
  exact (mul_le_mul_of_nonneg_left hyX hcoef).trans_lt hlower

/-- Rounding the lower endpoint contributes at most the explicit additive
constant `5/4` to the standard upper Chebyshev estimate. -/
theorem upper_chebyshev_transfer_from_ceiling
    {base C thetaH : ℝ}
    (hbase : 0 ≤ base)
    (hupper :
      thetaH < (5 / 4 : ℝ) *
        (genEllNaturalEndpoint base : ℝ) + C) :
    thetaH < (5 / 4 : ℝ) * base + (C + 5 / 4) := by
  have hround := genEllNaturalEndpoint_lt_add_one hbase
  nlinarith

/-- The ceiling logarithm may replace the printed real logarithm after the
single explicit strengthening `log(y+1)`. -/
theorem counting_log_transfer_to_ceiling
    {ε y : ℝ} {M : ℕ}
    (hy : 1 ≤ y)
    (hlog :
      (((M - 1 : ℕ) : ℝ) * Real.log (y + 1)) ≤ ε * y) :
    (((M - 1 : ℕ) : ℝ) *
        Real.log (genEllNaturalEndpoint y)) ≤ ε * y := by
  have hcoeff : 0 ≤ ((M - 1 : ℕ) : ℝ) := by positivity
  have hlt := log_genEllNaturalEndpoint_lt_log_add_one hy
  have hle :
      (((M - 1 : ℕ) : ℝ) *
          Real.log (genEllNaturalEndpoint y)) ≤
        ((M - 1 : ℕ) : ℝ) * Real.log (y + 1) :=
    mul_le_mul_of_nonneg_left hlt.le hcoeff
  exact hle.trans hlog

/-- **Endpoint-correct counting form of GenEll Lemma 4.1.**

Both the lower and upper Chebyshev endpoints are chosen by natural ceilings.
All rounding losses are visible in the hypotheses: `C + 5/4` in the upper
estimate and `log(y+1)` in the logarithmic candidate-prime term. -/
theorem genEllLemma41_many_primes_with_ceiling_endpoints
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (M : ℕ)
    {ε xε C xA hBase : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hC : C + 5 / 4 < ε * xε)
    (hxA : xε < xA)
    (hxA_mass : xA = primeLogMass A)
    (hh : 0 ≤ hBase)
    (hy :
      1 ≤ genEllLemma41Radius ε xA hBase)
    (hlog :
      (((M - 1 : ℕ) : ℝ) *
          Real.log (genEllLemma41Radius ε xA hBase + 1)) ≤
        ε * genEllLemma41Radius ε xA hBase)
    (hupper :
      Chebyshev.theta
          (genEllNaturalEndpoint ((1 + 6 * ε) * hBase)) <
        (5 / 4 : ℝ) *
          (genEllNaturalEndpoint ((1 + 6 * ε) * hBase) : ℝ) + C)
    (hlower :
      (1 - ε) *
          (genEllNaturalEndpoint
            (genEllLemma41Radius ε xA hBase) : ℝ) <
        Chebyshev.theta
          (genEllNaturalEndpoint
            (genEllLemma41Radius ε xA hBase))) :
    ∃ S : Finset ℕ,
      M ≤ S.card ∧
      ∀ p ∈ S,
        p.Prime ∧
        genEllNaturalEndpoint ((1 + 6 * ε) * hBase) < p ∧
        p ≤ genEllNaturalEndpoint
          (genEllLemma41Radius ε xA hBase) ∧
        p ∉ A := by
  let H : ℕ := genEllNaturalEndpoint ((1 + 6 * ε) * hBase)
  let X : ℕ :=
    genEllNaturalEndpoint (genEllLemma41Radius ε xA hBase)
  have hbaseNonneg : 0 ≤ (1 + 6 * ε) * hBase := by
    have : 0 < 1 + 6 * ε := by linarith
    positivity
  have hupper' :
      Chebyshev.theta H <
        (5 / 4 : ℝ) * ((1 + 6 * ε) * hBase) +
          (C + 5 / 4) := by
    exact upper_chebyshev_transfer_from_ceiling
      hbaseNonneg (by simpa [H] using hupper)
  have hlower' :
      (1 - ε) * genEllLemma41Radius ε xA hBase <
        Chebyshev.theta X := by
    exact lower_chebyshev_transfer_from_ceiling
      (by linarith) (by simpa [X] using hlower)
  have hlog' :
      (((M - 1 : ℕ) : ℝ) * Real.log X) ≤
        ε * genEllLemma41Radius ε xA hBase := by
    simpa [X] using counting_log_transfer_to_ceiling hy hlog
  have hX : 1 ≤ X := by
    exact one_le_genEllNaturalEndpoint hy
  simpa [H, X] using
    genEllLemma41_many_primes
      A hA H X M hX
      hεpos hεlt hxεpos hC hxA hxA_mass
      hlog' hupper' hlower'

end IUTThreeClosures
