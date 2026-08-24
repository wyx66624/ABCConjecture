/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootIntegerAction

/-!
# Local finiteness of all-integer theta-root deck orbits

The normalized radial coordinate satisfies

`rho(T^n z) = rho(z) + n` for every `n : ℤ`.

Hence the set of indices for which an orbit lies in a bounded radial band is
contained in an explicit finite interval of integers.  Since every closed base
annulus with positive inner radius gives a bounded radial band, every complete
`ℤ`-orbit meets such an annulus only finitely often.

This is the exact local-finiteness estimate used in a properly discontinuous
quotient construction.  It does not by itself provide a topology on the full
theta-root locus or identify the resulting quotient with a Berkovich curve.
-/

namespace IUTThreeClosures

open TateCurvesTheta
open scoped Int

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootOrbitLocalFiniteness

/-- A bounded band in the normalized logarithmic radial coordinate. -/
def coordinateBand
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (a b : ℝ) : Set (TateThetaRootPullbackPoint t ell) :=
  {z |
    a ≤ TateThetaRootRadialSkeleton.coordinate t ell r z ∧
    TateThetaRootRadialSkeleton.coordinate t ell r z ≤ b}

/-- Explicit finite set of integer deck indices that can meet a fixed radial
band. -/
noncomputable def indexWindow
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) : Finset ℤ :=
  Finset.Icc
    ⌊a - TateThetaRootRadialSkeleton.coordinate t ell r z⌋
    ⌈b - TateThetaRootRadialSkeleton.coordinate t ell r z⌉

/-- Any integer iterate lying in a bounded radial band belongs to the explicit
finite index window. -/
theorem mem_indexWindow_of_shiftInt_mem_coordinateBand
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) (n : ℤ)
    (hn : TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
      coordinateBand t ell r a b) :
    n ∈ indexWindow t ell r z a b := by
  have hband := hn
  change
    a ≤ TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr n z) ∧
      TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr n z) ≤ b
    at hband
  rw [TateThetaRootIntegerAction.coordinate_shiftInt] at hband
  have hlower_real :
      ((⌊a - TateThetaRootRadialSkeleton.coordinate t ell r z⌋ : ℤ) : ℝ) ≤
        (n : ℝ) := by
    have hfloor :
        ((⌊a - TateThetaRootRadialSkeleton.coordinate t ell r z⌋ : ℤ) : ℝ) ≤
          a - TateThetaRootRadialSkeleton.coordinate t ell r z :=
      Int.floor_le _
    linarith
  have hupper_real :
      (n : ℝ) ≤
        ((⌈b - TateThetaRootRadialSkeleton.coordinate t ell r z⌉ : ℤ) : ℝ) := by
    have hceil :
        b - TateThetaRootRadialSkeleton.coordinate t ell r z ≤
          ((⌈b - TateThetaRootRadialSkeleton.coordinate t ell r z⌉ : ℤ) : ℝ) :=
      Int.le_ceil _
    linarith
  have hlower :
      (⌊a - TateThetaRootRadialSkeleton.coordinate t ell r z⌋ : ℤ) ≤ n := by
    exact_mod_cast hlower_real
  have hupper :
      n ≤ (⌈b - TateThetaRootRadialSkeleton.coordinate t ell r z⌉ : ℤ) := by
    exact_mod_cast hupper_real
  exact Finset.mem_Icc.mpr ⟨hlower, hupper⟩

/-- Every all-integer orbit meets a bounded radial band at only finitely many
indices. -/
theorem finite_indices_in_coordinateBand
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) :
    {n : ℤ |
      TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
        coordinateBand t ell r a b}.Finite := by
  refine (indexWindow t ell r z a b).finite_toSet.subset ?_
  intro n hn
  exact mem_indexWindow_of_shiftInt_mem_coordinateBand
    t ell r hr z a b n hn

/-- A closed annulus in the base coordinate. -/
def baseAnnulus
    (t : TateParameter K) (ell : ℕ)
    (δ R : ℝ) : Set (TateThetaRootPullbackPoint t ell) :=
  {z | δ ≤ ‖(z.base : K)‖ ∧ ‖(z.base : K)‖ ≤ R}

/-- A positive closed base annulus maps into a bounded radial coordinate band.
The order of the two radial endpoints is reversed because `log ‖r‖ < 0`. -/
theorem baseAnnulus_subset_coordinateBand
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    {δ R : ℝ} (hδ : 0 < δ)
    (hδR : δ ≤ R) :
    baseAnnulus t ell δ R ⊆
      coordinateBand t ell r
        (Real.log R / Real.log ‖(r : K)‖)
        (Real.log δ / Real.log ‖(r : K)‖) := by
  intro z hz
  change δ ≤ ‖(z.base : K)‖ ∧ ‖(z.base : K)‖ ≤ R at hz
  change
    Real.log R / Real.log ‖(r : K)‖ ≤
        TateThetaRootRadialSkeleton.coordinate t ell r z ∧
      TateThetaRootRadialSkeleton.coordinate t ell r z ≤
        Real.log δ / Real.log ‖(r : K)‖
  have hnorm : 0 < ‖(z.base : K)‖ :=
    TateThetaRootRadialSkeleton.base_norm_pos z
  have hR : 0 < R := hδ.trans_le hδR
  have hd : Real.log ‖(r : K)‖ < 0 :=
    TateThetaRootRadialSkeleton.log_root_norm_neg t ell r hr
  have hlogUpper : Real.log ‖(z.base : K)‖ ≤ Real.log R :=
    Real.log_le_log hnorm hz.2
  have hlogLower : Real.log δ ≤ Real.log ‖(z.base : K)‖ :=
    Real.log_le_log hδ hz.1
  constructor
  · unfold TateThetaRootRadialSkeleton.coordinate
    exact (div_le_div_iff_of_neg_right hd).2 hlogUpper
  · unfold TateThetaRootRadialSkeleton.coordinate
    exact (div_le_div_iff_of_neg_right hd).2 hlogLower

/-- **All-integer annulus local finiteness.**  Every complete deck orbit meets
each closed base annulus with positive inner radius only finitely often. -/
theorem finite_indices_in_baseAnnulus
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    {δ R : ℝ} (hδ : 0 < δ)
    (hδR : δ ≤ R) :
    {n : ℤ |
      TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
        baseAnnulus t ell δ R}.Finite := by
  have hsubset := baseAnnulus_subset_coordinateBand
    t ell r hr hδ hδR
  exact
    (finite_indices_in_coordinateBand
      t ell r hr z
      (Real.log R / Real.log ‖(r : K)‖)
      (Real.log δ / Real.log ‖(r : K)‖)).subset
      (by
        intro n hn
        exact hsubset hn)

end TateThetaRootOrbitLocalFiniteness

end IUTThreeClosures
