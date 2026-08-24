/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootOrbitLocalFiniteness

/-!
# Proper-discontinuity estimates on theta-root radial bands

If a bounded radial band `[a,b]` meets its `n`-th deck translate, then

`a-b <= n <= b-a`.

Thus only finitely many integer translates of a bounded band can meet it.
Positive closed base annuli map into bounded radial bands, giving the same
uniform finiteness result for annuli. This is the compact-set estimate used in
a properly discontinuous quotient construction.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootProperDiscontinuity

def bandIntersectionIndices
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (a b : ℝ) : Set ℤ :=
  {n | ∃ z,
    z ∈ TateThetaRootOrbitLocalFiniteness.coordinateBand t ell r a b ∧
    TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
      TateThetaRootOrbitLocalFiniteness.coordinateBand t ell r a b}

theorem index_bounds_of_mem_bandIntersectionIndices
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (a b : ℝ) {n : ℤ}
    (hn : n ∈ bandIntersectionIndices t ell r hr a b) :
    a - b ≤ (n : ℝ) ∧ (n : ℝ) ≤ b - a := by
  rcases hn with ⟨z, hz, hshift⟩
  change
    a ≤ TateThetaRootRadialSkeleton.coordinate t ell r z ∧
      TateThetaRootRadialSkeleton.coordinate t ell r z ≤ b at hz
  change
    a ≤ TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr n z) ∧
      TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr n z) ≤ b
    at hshift
  rw [TateThetaRootIntegerAction.coordinate_shiftInt] at hshift
  constructor <;> linarith

noncomputable def bandTranslateWindow (a b : ℝ) : Finset ℤ :=
  Finset.Icc ⌊a - b⌋ ⌈b - a⌉

theorem mem_bandTranslateWindow_of_intersects
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (a b : ℝ) {n : ℤ}
    (hn : n ∈ bandIntersectionIndices t ell r hr a b) :
    n ∈ bandTranslateWindow a b := by
  have hb := index_bounds_of_mem_bandIntersectionIndices
    t ell r hr a b hn
  have hlowerReal : ((⌊a - b⌋ : ℤ) : ℝ) ≤ (n : ℝ) :=
    (Int.floor_le _).trans hb.1
  have hupperReal : (n : ℝ) ≤ ((⌈b - a⌉ : ℤ) : ℝ) :=
    hb.2.trans (Int.le_ceil _)
  have hlower : (⌊a - b⌋ : ℤ) ≤ n := by
    exact_mod_cast hlowerReal
  have hupper : n ≤ (⌈b - a⌉ : ℤ) := by
    exact_mod_cast hupperReal
  exact Finset.mem_Icc.mpr ⟨hlower, hupper⟩

theorem finite_bandIntersectionIndices
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (a b : ℝ) :
    (bandIntersectionIndices t ell r hr a b).Finite := by
  refine (bandTranslateWindow a b).finite_toSet.subset ?_
  intro n hn
  exact mem_bandTranslateWindow_of_intersects
    t ell r hr a b hn

def annulusIntersectionIndices
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (δ R : ℝ) : Set ℤ :=
  {n | ∃ z,
    z ∈ TateThetaRootOrbitLocalFiniteness.baseAnnulus t ell δ R ∧
    TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
      TateThetaRootOrbitLocalFiniteness.baseAnnulus t ell δ R}

theorem finite_annulusIntersectionIndices
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    {δ R : ℝ} (hδ : 0 < δ) (hδR : δ ≤ R) :
    (annulusIntersectionIndices t ell r hr δ R).Finite := by
  let a := Real.log R / Real.log ‖(r : K)‖
  let b := Real.log δ / Real.log ‖(r : K)‖
  have hAnn :=
    TateThetaRootOrbitLocalFiniteness.baseAnnulus_subset_coordinateBand
      t ell r hr hδ hδR
  refine (finite_bandIntersectionIndices t ell r hr a b).subset ?_
  intro n hn
  rcases hn with ⟨z, hz, hshift⟩
  exact ⟨z, hAnn hz, hAnn hshift⟩

end TateThetaRootProperDiscontinuity

end IUTThreeClosures
