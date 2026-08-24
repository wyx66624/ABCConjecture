/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootDeckFreeness
import Mathlib.Analysis.SpecificLimits.Basic

/-!
# Contraction and annulus escape for the theta-root deck action

Let `r^ell=q` for the corrected pulled-back theta-root translation.  Since the
Tate parameter satisfies `‖q‖<1`, the root itself satisfies `‖r‖<1`.  The base
coordinate of the `n`-th positive iterate is

`r^n * v`,

so its norm converges geometrically to zero.  Consequently every positive
orbit eventually leaves every annulus whose inner radius is strictly positive.

This is the positive-direction proper-discontinuity estimate for the deck
action candidate.  To construct the analytic quotient one still needs the
corresponding negative-direction escape, local compactness/annulus exhaustion,
and a topological quotient theorem; the orbicurve compactification, tempered
fundamental group and graph-cusp comparison remain later stages.
-/

namespace IUTThreeClosures

open Filter Set TateCurvesTheta
open scoped Topology

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootPullbackPoint

/-- Taking norms in `r^ell=q`. -/
theorem root_norm_pow_eq_q_norm
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ‖(r : K)‖ ^ ell = ‖(t.q : K)‖ := by
  have h := congrArg (fun a : Kˣ => ‖(a : K)‖) hr
  simpa only [Units.val_pow, norm_pow] using h

/-- Every chosen `ell`-th root of a strict Tate parameter is itself strictly
contracting. -/
theorem root_norm_lt_one
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ‖(r : K)‖ < 1 := by
  by_contra hnot
  have hge : 1 ≤ ‖(r : K)‖ := le_of_not_gt hnot
  have hpow : 1 ≤ ‖(r : K)‖ ^ ell :=
    one_le_pow_of_one_le hge ell
  rw [root_norm_pow_eq_q_norm t ell r hr] at hpow
  exact (not_le_of_gt t.norm_lt_one) hpow

/-- Exact norm of the base coordinate after `n` positive deck steps. -/
theorem shiftNat_base_norm
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    ‖((shiftNat t ell r hr n z).base : K)‖ =
      ‖(r : K)‖ ^ n * ‖(z.base : K)‖ := by
  rw [shiftNat_base]
  simp only [Units.val_mul, Units.val_pow, norm_mul, norm_pow]

/-- Positive deck iterates contract every base coordinate to zero. -/
theorem shiftNat_base_norm_tendsto_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    Tendsto
      (fun n : ℕ => ‖((shiftNat t ell r hr n z).base : K)‖)
      atTop (𝓝 0) := by
  have hpow :
      Tendsto (fun n : ℕ => ‖(r : K)‖ ^ n) atTop (𝓝 0) :=
    tendsto_pow_atTop_nhds_zero_of_lt_one
      (norm_nonneg (r : K)) (root_norm_lt_one t ell r hr)
  have hmul := hpow.mul tendsto_const_nhds
  simpa only [shiftNat_base_norm, zero_mul] using hmul

/-- Quantitative eventual form of base contraction. -/
theorem eventually_shiftNat_base_norm_lt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {δ : ℝ} (hδ : 0 < δ) :
    ∀ᶠ n : ℕ in atTop,
      ‖((shiftNat t ell r hr n z).base : K)‖ < δ := by
  have h :=
    (shiftNat_base_norm_tendsto_zero t ell r hr z).eventually
      (Iio_mem_nhds hδ)
  simpa only [Set.mem_Iio] using h

/-- Explicit threshold form of the contraction estimate. -/
theorem exists_shiftNat_base_norm_lt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {δ : ℝ} (hδ : 0 < δ) :
    ∃ N : ℕ, ∀ n ≥ N,
      ‖((shiftNat t ell r hr n z).base : K)‖ < δ := by
  exact eventually_atTop.1
    (eventually_shiftNat_base_norm_lt t ell r hr z hδ)

/-- A closed radial annulus in the base coordinate of the pulled-back
root locus. -/
def baseAnnulus
    (t : TateParameter K) (ell : ℕ)
    (δ R : ℝ) : Set (TateThetaRootPullbackPoint t ell) :=
  {z | δ ≤ ‖(z.base : K)‖ ∧ ‖(z.base : K)‖ ≤ R}

@[simp]
theorem mem_baseAnnulus
    (t : TateParameter K) (ell : ℕ)
    (δ R : ℝ)
    (z : TateThetaRootPullbackPoint t ell) :
    z ∈ baseAnnulus t ell δ R ↔
      δ ≤ ‖(z.base : K)‖ ∧ ‖(z.base : K)‖ ≤ R :=
  Iff.rfl

/-- Every positive orbit eventually leaves any annulus with positive inner
radius.  This is the key pointwise finiteness estimate behind proper
discontinuity. -/
theorem eventually_shiftNat_not_mem_baseAnnulus
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {δ R : ℝ} (hδ : 0 < δ) :
    ∃ N : ℕ, ∀ n ≥ N,
      shiftNat t ell r hr n z ∉ baseAnnulus t ell δ R := by
  obtain ⟨N, hN⟩ :=
    exists_shiftNat_base_norm_lt t ell r hr z hδ
  refine ⟨N, ?_⟩
  intro n hn hmem
  have hlower := (mem_baseAnnulus t ell δ R _).mp hmem |>.1
  exact (not_lt_of_ge hlower) (hN n hn)

end TateThetaRootPullbackPoint

end IUTThreeClosures
