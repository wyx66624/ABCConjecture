/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootProperDiscontinuity

/-!
# A canonical fundamental strip for the theta-root deck action

The exact formula `rho(T^n z)=rho(z)+n` gives a canonical representative of
every complete deck orbit.  Shift by

`n(z) = -floor(rho(z))`.

The resulting radial coordinate lies in `[0,1)`, and this integer is the unique
one with that property.  Thus the half-open radial strip is a genuine
set-theoretic fundamental domain for every parametrized orbit.

If the corresponding closed strip is compact in the eventual nonarchimedean
analytic topology, this fundamental-domain theorem combines with the uniform
finite-translate estimate to produce a compact properly discontinuous
quotient.  Compactness of the full analytic strip remains a geometric theorem,
not an assumption hidden here.
-/

namespace IUTThreeClosures

open TateCurvesTheta
open scoped Int

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootFundamentalStrip

/-- The half-open normalized radial fundamental strip. -/
def fundamentalStrip
    (t : TateParameter K) (ell : ℕ) (r : Kˣ) :
    Set (TateThetaRootPullbackPoint t ell) :=
  {z |
    0 ≤ TateThetaRootRadialSkeleton.coordinate t ell r z ∧
    TateThetaRootRadialSkeleton.coordinate t ell r z < 1}

/-- The canonical integer bringing a point into the fundamental strip. -/
noncomputable def normalizeIndex
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (z : TateThetaRootPullbackPoint t ell) : ℤ :=
  -⌊TateThetaRootRadialSkeleton.coordinate t ell r z⌋

/-- Shifting by the canonical index places the point in the half-open
fundamental strip. -/
theorem shift_normalizeIndex_mem
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    TateThetaRootIntegerAction.shiftInt t ell r hr
        (normalizeIndex t ell r z) z ∈
      fundamentalStrip t ell r := by
  let ρ := TateThetaRootRadialSkeleton.coordinate t ell r z
  have hfloor : ((⌊ρ⌋ : ℤ) : ℝ) ≤ ρ := Int.floor_le ρ
  have hlt : ρ < ((⌊ρ⌋ : ℤ) : ℝ) + 1 := Int.lt_floor_add_one ρ
  change
    0 ≤ TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr
            (normalizeIndex t ell r z) z) ∧
      TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr
            (normalizeIndex t ell r z) z) < 1
  rw [TateThetaRootIntegerAction.coordinate_shiftInt]
  dsimp [normalizeIndex, ρ]
  push_cast
  constructor <;> linarith

/-- The canonical normalization index is the unique integer sending the point
into the half-open radial strip. -/
theorem normalizeIndex_unique
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (n : ℤ)
    (hn : TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
      fundamentalStrip t ell r) :
    n = normalizeIndex t ell r z := by
  have hcanonical := shift_normalizeIndex_mem t ell r hr z
  change
    0 ≤ TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr n z) ∧
      TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr n z) < 1
    at hn
  change
    0 ≤ TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr
            (normalizeIndex t ell r z) z) ∧
      TateThetaRootRadialSkeleton.coordinate t ell r
          (TateThetaRootIntegerAction.shiftInt t ell r hr
            (normalizeIndex t ell r z) z) < 1
    at hcanonical
  rw [TateThetaRootIntegerAction.coordinate_shiftInt] at hn hcanonical
  have hdiffUpper :
      ((n - normalizeIndex t ell r z : ℤ) : ℝ) < 1 := by
    push_cast
    linarith
  have hdiffLower :
      (-1 : ℝ) < ((n - normalizeIndex t ell r z : ℤ) : ℝ) := by
    push_cast
    linarith
  have hdiffUpperInt : n - normalizeIndex t ell r z < 1 := by
    exact_mod_cast hdiffUpper
  have hdiffLowerInt : -1 < n - normalizeIndex t ell r z := by
    exact_mod_cast hdiffLower
  omega

/-- Every parametrized deck orbit has exactly one representative in the
fundamental strip. -/
theorem exists_unique_strip_representative
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    ∃! n : ℤ,
      TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
        fundamentalStrip t ell r := by
  refine ⟨normalizeIndex t ell r z,
    shift_normalizeIndex_mem t ell r hr z, ?_⟩
  intro n hn
  exact normalizeIndex_unique t ell r hr z n hn

end TateThetaRootFundamentalStrip

end IUTThreeClosures
