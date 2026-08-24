/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootRadialQuotient

/-!
# Proper-discontinuity criterion on theta-root radial bands

Pointwise orbit local finiteness is strengthened here to the uniform
finite-translate condition used for proper discontinuity.  If a bounded radial
band `B=[a,b]` meets its `n`-th translate, then

`a-b <= n <= b-a`.

Thus only finitely many integer translates of `B` can meet `B`.  Positive base
annuli map into bounded radial bands, so the same conclusion holds for annuli.

This proves the group-action estimate independently of a topology.  Once the
actual nonarchimedean analytic topology has compact annuli forming a local
exhaustion, the theorem is exactly the compact-set finiteness input for a
properly discontinuous quotient.
-/

namespace IUTThreeClosures

open TateCurvesTheta
open scoped Int

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootProperDiscontinuity

/-- Integer indices whose translate of a radial band meets the band. -/
def bandIntersectionIndices
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (a b : ℝ) : Set ℤ :=
  {n | ∃ z,
    z ∈ TateThetaRootOrbitLocalFiniteness.coordinateBand t ell r a b ∧
    TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
      TateThetaRootOrbitLocalFiniteness.coordinateBand t ell r a b}

/-- Every translate meeting a radial band has uniformly bounded index. -/
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

/-- The finite integer window containing all translates that can meet a radial
band. -/
noncomputable def bandTranslateWindow (a b : ℝ) : Finset ℤ :=
  Finset.Icc ⌊a - b⌋ ⌈b - a⌉

/-- Every translate meeting the band belongs to the explicit finite window. -/
theorem mem_bandTranslateWindow_of_intersects
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (a b : ℝ) {n : ℤ}
    (hn : n ∈ bandIntersectionIndices t ell r hr a b) :
    n ∈ bandTranslateWindow a b := by
  have hb := index_bounds_of_mem_bandIntersectionIndices
    t ell r hr a b hn
  have hlower_real : ((⌊a - b⌋ : ℤ) : ℝ) ≤ (n : ℝ) :=
    (Int.floor_le _).trans hb.1
  have hupper_real : (n : ℝ) ≤ ((⌈b - a⌉ : ℤ) : ℝ) :=
    hb.2.trans (Int.le_ceil _)
  have hlower : (⌊a - b⌋ : ℤ) ≤ n := by
    exact_mod_cast hlower_real
  have hupper : n ≤ (⌈b - a⌉ : ℤ) := by
    exact_mod_cast hupper_real
  exact Finset.mem_Icc.mpr ⟨hlower, hupper⟩

/-- **Uniform radial proper-discontinuity estimate.**  Only finitely many
integer translates of a bounded radial band can meet the band. -/
theorem finite_bandIntersectionIndices
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (a b : ℝ) :
    (bandIntersectionIndices t ell r hr a b).Finite := by
  refine (bandTranslateWindow a b).finite_toSet.subset ?_
  intro n hn
  exact mem_bandTranslateWindow_of_intersects
    t ell r hr a b hn

/-- Integer translates whose image of one positive base annulus meets another
copy of the same annulus. -/
def annulusIntersectionIndices
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (δ R : ℝ) : Set ℤ :=
  {n | ∃ z,
    z ∈ TateThetaRootOrbitLocalFiniteness.baseAnnulus t ell δ R ∧
    TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
      TateThetaRootOrbitLocalFiniteness.baseAnnulus t ell δ R}

/-- **Uniform annulus local finiteness.**  Only finitely many complete deck
translates of a positive closed base annulus can meet that annulus. -/
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
