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

The Chebyshev function is evaluated at natural-number endpoints. This module
uses the natural ceiling and records every rounding error explicitly:

`y <= ceil y < y + 1`.
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
  have hXnat : 0 < genEllNaturalEndpoint y :=
    Nat.zero_lt_one.trans_le (one_le_genEllNaturalEndpoint hy)
  have hXpos : (0 : ℝ) < genEllNaturalEndpoint y := by
    exact_mod_cast hXnat
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

/-- **Endpoint-correct counting form of GenEll Lemma 4.1 with a real base
height.**  This direct form avoids coercing the printed real height to a
natural number. -/
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
  have hscalar :
      xA <
        -(((M - 1 : ℕ) : ℝ) * Real.log X) -
          Chebyshev.theta H + Chebyshev.theta X := by
    exact genEllLemma41_lt_offending_bound
      hεpos hεlt hxεpos hC hxA hh
        hlog' hupper' hlower'
  rw [hxA_mass] at hscalar
  refine ⟨escapingPrimes A H X, ?_, ?_⟩
  · apply card_escapingPrimes_ge_of_theta_gt A hA H X M hX
    linarith
  · intro p hp
    simpa [H, X] using (mem_escapingPrimes_iff A H X p).mp hp

end IUTThreeClosures
