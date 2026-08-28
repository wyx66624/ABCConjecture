/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootProperDiscontinuity

/-!
# A canonical fundamental strip for the theta-root deck action

The exact formula `rho(T^n z)=rho(z)+n` gives a canonical representative of
every complete deck orbit. Shift by

`n(z) = -floor(rho(z))`.

The resulting radial coordinate lies in `[0,1)`, and this integer is unique.
Thus the half-open radial strip is a genuine set-theoretic fundamental domain
for every parametrized orbit.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootFundamentalStrip

def fundamentalStrip
    (t : TateParameter K) (ell : ℕ) (r : Kˣ) :
    Set (TateThetaRootPullbackPoint t ell) :=
  {z |
    0 ≤ TateThetaRootRadialSkeleton.coordinate t ell r z ∧
    TateThetaRootRadialSkeleton.coordinate t ell r z < 1}

noncomputable def normalizeIndex
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (z : TateThetaRootPullbackPoint t ell) : ℤ :=
  -⌊TateThetaRootRadialSkeleton.coordinate t ell r z⌋

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

theorem normalizeIndex_unique
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (n : ℤ)
    (hn : TateThetaRootIntegerAction.shiftInt t ell r hr n z ∈
      fundamentalStrip t ell r) :
    n = normalizeIndex t ell r z := by
  have hc := shift_normalizeIndex_mem t ell r hr z
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
    at hc
  rw [TateThetaRootIntegerAction.coordinate_shiftInt] at hn hc
  have hupper :
      ((n - normalizeIndex t ell r z : ℤ) : ℝ) < 1 := by
    push_cast
    linarith
  have hlower :
      (-1 : ℝ) < ((n - normalizeIndex t ell r z : ℤ) : ℝ) := by
    push_cast
    linarith
  have hupperInt : n - normalizeIndex t ell r z < 1 := by
    exact_mod_cast hupper
  have hlowerInt : -1 < n - normalizeIndex t ell r z := by
    exact_mod_cast hlower
  omega

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
