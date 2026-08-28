/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootIntegerAction

/-!
# Local finiteness of all-integer theta-root deck orbits

The exact formula `rho(T^n z)=rho(z)+n` implies that the indices for which an
orbit lies in a bounded radial band belong to an explicit finite integer
interval. Positive closed base annuli map to bounded radial bands; therefore a
complete `ℤ`-orbit meets every such annulus only finitely often.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootOrbitLocalFiniteness

def coordinateBand
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (a b : ℝ) : Set (TateThetaRootPullbackPoint t ell) :=
  {z |
    a ≤ TateThetaRootRadialSkeleton.coordinate t ell r z ∧
    TateThetaRootRadialSkeleton.coordinate t ell r z ≤ b}

noncomputable def indexWindow
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) : Finset ℤ :=
  Finset.Icc
    ⌊a - TateThetaRootRadialSkeleton.coordinate t ell r z⌋
    ⌈b - TateThetaRootRadialSkeleton.coordinate t ell r z⌉

theorem mem_indexWindow_of_shiftInt_mem_coordinateBand
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) (n : ℤ)
    (hn : TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
      coordinateBand t ell r a b) :
    n ∈ indexWindow t ell r z a b := by
  change
    a ≤ TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr n z) ∧
      TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr n z) ≤ b
    at hn
  rw [TateThetaRootIntegerAction.coordinate_shiftInt] at hn
  have hlowerReal :
      ((⌊a - TateThetaRootRadialSkeleton.coordinate t ell r z⌋ : ℤ) : ℝ) ≤
        (n : ℝ) := by
    have hfloor :
        ((⌊a - TateThetaRootRadialSkeleton.coordinate t ell r z⌋ : ℤ) : ℝ) ≤
          a - TateThetaRootRadialSkeleton.coordinate t ell r z :=
      Int.floor_le _
    linarith
  have hupperReal :
      (n : ℝ) ≤
        ((⌈b - TateThetaRootRadialSkeleton.coordinate t ell r z⌉ : ℤ) : ℝ) := by
    have hceil :
        b - TateThetaRootRadialSkeleton.coordinate t ell r z ≤
          ((⌈b - TateThetaRootRadialSkeleton.coordinate t ell r z⌉ : ℤ) : ℝ) :=
      Int.le_ceil _
    linarith
  have hlower :
      (⌊a - TateThetaRootRadialSkeleton.coordinate t ell r z⌋ : ℤ) ≤ n := by
    exact_mod_cast hlowerReal
  have hupper :
      n ≤ (⌈b - TateThetaRootRadialSkeleton.coordinate t ell r z⌉ : ℤ) := by
    exact_mod_cast hupperReal
  exact Finset.mem_Icc.mpr ⟨hlower, hupper⟩

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

def baseAnnulus
    (t : TateParameter K) (ell : ℕ)
    (δ R : ℝ) : Set (TateThetaRootPullbackPoint t ell) :=
  {z | δ ≤ ‖(z.base : K)‖ ∧ ‖(z.base : K)‖ ≤ R}

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
