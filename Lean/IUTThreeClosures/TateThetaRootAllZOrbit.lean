/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootRadialSkeleton
import Mathlib.Data.Int.Interval

/-!
# The full integer theta-root orbit is radially proper

The positive corrected Tate translation multiplies the base coordinate by a
root `r` with `0 < ‖r‖ < 1`; its inverse multiplies by `r⁻¹`.  The normalized
radial coordinate therefore changes by `+1` in the positive direction and by
`-1` in the negative direction.

This module constructs the negative natural iterates and the complete integer
orbit.  It proves:

* the `n`-th negative iterate has radial coordinate `rho(z) - n`;
* negative iterates eventually have base norm larger than every positive
  outer radius;
* the full `ℤ`-orbit meets every closed radial annulus with positive inner and
  outer radii in only finitely many integer indices.

The final theorem is the radial proper-discontinuity statement required before
constructing a quotient.  It does not assert that radial annuli exhaust the
compact subsets of the full analytic theta-root space, nor does it construct a
Berkovich quotient or a tempered fundamental group.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootAllZOrbit

/-- Negative natural iterates of the corrected deck transformation. -/
noncomputable def shiftNegNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℕ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | 0, z => z
  | n + 1, z =>
      (TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm
        (shiftNegNat t ell r hr n z)

@[simp]
theorem shiftNegNat_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftNegNat t ell r hr 0 z = z :=
  rfl

@[simp]
theorem shiftNegNat_succ
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ) (z : TateThetaRootPullbackPoint t ell) :
    shiftNegNat t ell r hr (n + 1) z =
      (TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm
        (shiftNegNat t ell r hr n z) :=
  rfl

/-- One inverse deck step subtracts one from the normalized radial
coordinate. -/
theorem coordinate_shiftSymm
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    TateThetaRootRadialSkeleton.coordinate t ell r
        ((TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z) =
      TateThetaRootRadialSkeleton.coordinate t ell r z - 1 := by
  have h :=
    TateThetaRootRadialSkeleton.coordinate_shiftEquiv
      t ell r hr
      ((TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z)
  rw [Equiv.apply_symm_apply] at h
  linarith

/-- Exact radial coordinate after `n` inverse deck steps. -/
theorem coordinate_shiftNegNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ) (z : TateThetaRootPullbackPoint t ell) :
    TateThetaRootRadialSkeleton.coordinate t ell r
        (shiftNegNat t ell r hr n z) =
      TateThetaRootRadialSkeleton.coordinate t ell r z - n := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [shiftNegNat_succ, coordinate_shiftSymm, ih]
      push_cast
      ring

/-- Negative iterates eventually escape beyond every positive outer radius. -/
theorem eventually_shiftNegNat_base_norm_gt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {R : ℝ} (hR : 0 < R) :
    ∃ N : ℕ, ∀ n ≥ N,
      R < ‖((shiftNegNat t ell r hr n z).base : K)‖ := by
  let d : ℝ := Real.log ‖(r : K)‖
  let c : ℝ :=
    TateThetaRootRadialSkeleton.coordinate t ell r z
  have hd : d < 0 := by
    simpa [d] using
      TateThetaRootRadialSkeleton.log_root_norm_neg t ell r hr
  obtain ⟨N, hN⟩ :=
    exists_nat_gt (c - Real.log R / d)
  refine ⟨N, ?_⟩
  intro n hn
  have hnreal : (N : ℝ) ≤ n := by
    exact_mod_cast hn
  have hcoord :
      TateThetaRootRadialSkeleton.coordinate t ell r
          (shiftNegNat t ell r hr n z) <
        Real.log R / d := by
    rw [coordinate_shiftNegNat]
    dsimp [c] at hN ⊢
    nlinarith
  have hnormPos :
      0 < ‖((shiftNegNat t ell r hr n z).base : K)‖ :=
    TateThetaRootRadialSkeleton.base_norm_pos _
  have hdiv :
      Real.log
          ‖((shiftNegNat t ell r hr n z).base : K)‖ / d <
        Real.log R / d := by
    simpa [TateThetaRootRadialSkeleton.coordinate, d] using hcoord
  have hlog :
      Real.log R <
        Real.log ‖((shiftNegNat t ell r hr n z).base : K)‖ :=
    (div_lt_div_iff_of_neg_right hd).mp hdiv
  exact (Real.log_lt_log_iff hR hnormPos).mp hlog

/-- Negative iterates eventually leave every closed radial annulus through its
outer boundary. -/
theorem eventually_shiftNegNat_not_mem_baseAnnulus
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {δ R : ℝ} (hR : 0 < R) :
    ∃ N : ℕ, ∀ n ≥ N,
      shiftNegNat t ell r hr n z ∉
        TateThetaRootPullbackPoint.baseAnnulus t ell δ R := by
  obtain ⟨N, hN⟩ :=
    eventually_shiftNegNat_base_norm_gt t ell r hr z hR
  refine ⟨N, ?_⟩
  intro n hn hmem
  have hupper :=
    (TateThetaRootPullbackPoint.mem_baseAnnulus
      t ell δ R _).mp hmem |>.2
  exact (not_lt_of_ge hupper) (hN n hn)

/-- Complete integer orbit, using positive iterates for nonnegative integers
and inverse iterates for negative integers. -/
noncomputable def shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℤ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | Int.ofNat n, z =>
      TateThetaRootPullbackPoint.shiftNat t ell r hr n z
  | Int.negSucc n, z =>
      shiftNegNat t ell r hr (n + 1) z

/-- Exact radial coordinate of every integer deck iterate. -/
theorem coordinate_shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (k : ℤ) (z : TateThetaRootPullbackPoint t ell) :
    TateThetaRootRadialSkeleton.coordinate t ell r
        (shiftInt t ell r hr k z) =
      TateThetaRootRadialSkeleton.coordinate t ell r z + k := by
  cases k with
  | ofNat n =>
      simpa [shiftInt] using
        TateThetaRootRadialSkeleton.coordinate_shiftNat
          t ell r hr n z
  | negSucc n =>
      rw [shiftInt, coordinate_shiftNegNat]
      push_cast
      ring

/-- A finite window of integer indices containing every possible annulus
intersection once positive and negative escape thresholds are fixed. -/
noncomputable def indexWindow (Npos Nneg : ℕ) : Finset ℤ :=
  (Finset.range Npos).image (fun n => (n : ℤ)) ∪
    (Finset.range Nneg).image (fun n => -(n : ℤ))

/-- **All-integer radial local finiteness.**  The complete deck orbit of one
point meets a closed annulus with positive inner and outer radii at only
finitely many integer indices. -/
theorem finite_indices_mem_baseAnnulus
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {δ R : ℝ} (hδ : 0 < δ) (hR : 0 < R) :
    Set.Finite
      {k : ℤ |
        shiftInt t ell r hr k z ∈
          TateThetaRootPullbackPoint.baseAnnulus t ell δ R} := by
  obtain ⟨Npos, hpos⟩ :=
    TateThetaRootPullbackPoint.eventually_shiftNat_not_mem_baseAnnulus
      t ell r hr z hδ
  obtain ⟨Nneg, hneg⟩ :=
    eventually_shiftNegNat_not_mem_baseAnnulus
      t ell r hr z hR
  refine (indexWindow Npos Nneg).finite_toSet.subset ?_
  intro k hk
  change shiftInt t ell r hr k z ∈
      TateThetaRootPullbackPoint.baseAnnulus t ell δ R at hk
  cases k with
  | ofNat n =>
      have hnlt : n < Npos := by
        by_contra hn
        have hn' : Npos ≤ n := Nat.le_of_not_gt hn
        exact hpos n hn' (by simpa [shiftInt] using hk)
      apply Finset.mem_union_left
      exact Finset.mem_image.mpr
        ⟨n, Finset.mem_range.mpr hnlt, rfl⟩
  | negSucc n =>
      have hnlt : n + 1 < Nneg := by
        by_contra hn
        have hn' : Nneg ≤ n + 1 := Nat.le_of_not_gt hn
        exact hneg (n + 1) hn' (by simpa [shiftInt] using hk)
      apply Finset.mem_union_right
      exact Finset.mem_image.mpr
        ⟨n + 1, Finset.mem_range.mpr hnlt, by simp⟩

end TateThetaRootAllZOrbit

end IUTThreeClosures
