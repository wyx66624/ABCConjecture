/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootRadialSkeleton

/-!
# The all-integer theta-root deck action

The corrected theta-root deck generator translates the normalized logarithmic
radial coordinate by one.  This file constructs the negative and all-integer
iterates and proves the exact formula

`rho(T^n z) = rho(z) + n`, `n : ℤ`.

Consequently positive iterates escape to `+∞` and negative iterates escape to
`-∞` in radial coordinates, and different integer iterates of a point are
distinct.  These are the algebraic/radial ingredients for local finiteness and
proper discontinuity.  No topology or Berkovich quotient is imposed here.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootIntegerAction

/-- Negative natural iterates of the corrected theta-root deck generator. -/
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

/-- The inverse deck generator translates the radial coordinate by `-1`. -/
theorem coordinate_shiftEquiv_symm
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
  simp only [Equiv.apply_symm_apply] at h
  linarith

/-- The `n`-th negative iterate translates the radial coordinate by `-n`. -/
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
      rw [shiftNegNat_succ,
        coordinate_shiftEquiv_symm, ih]
      push_cast
      ring

/-- The all-integer deck iterate. -/
noncomputable def shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℤ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | Int.ofNat n, z =>
      TateThetaRootPullbackPoint.shiftNat t ell r hr n z
  | Int.negSucc n, z =>
      shiftNegNat t ell r hr (n + 1) z

/-- Exact all-integer radial translation formula. -/
theorem coordinate_shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ) (z : TateThetaRootPullbackPoint t ell) :
    TateThetaRootRadialSkeleton.coordinate t ell r
        (shiftInt t ell r hr n z) =
      TateThetaRootRadialSkeleton.coordinate t ell r z + (n : ℝ) := by
  cases n with
  | ofNat n =>
      simpa [shiftInt] using
        TateThetaRootRadialSkeleton.coordinate_shiftNat
          t ell r hr n z
  | negSucc n =>
      rw [shiftInt, coordinate_shiftNegNat]
      push_cast
      ring

/-- The radial coordinate separates all integer points of one deck orbit. -/
theorem shiftInt_injective_index
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    Function.Injective (fun n : ℤ => shiftInt t ell r hr n z) := by
  intro m n h
  have hcoord := congrArg
    (TateThetaRootRadialSkeleton.coordinate t ell r) h
  rw [coordinate_shiftInt, coordinate_shiftInt] at hcoord
  have hreal : (m : ℝ) = n := by linarith
  exact_mod_cast hreal

/-- Positive integer indices tend to `+∞` in radial coordinates. -/
theorem coordinate_shiftNat_tendsto_atTop
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    Filter.Tendsto
      (fun n : ℕ =>
        TateThetaRootRadialSkeleton.coordinate t ell r
          (shiftInt t ell r hr n z))
      Filter.atTop Filter.atTop := by
  simpa [coordinate_shiftInt] using
    (Filter.tendsto_natCast_atTop_atTop.const_add
      (TateThetaRootRadialSkeleton.coordinate t ell r z))

/-- Negative integer indices tend to `-∞` in radial coordinates. -/
theorem coordinate_shift_negNat_tendsto_atBot
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    Filter.Tendsto
      (fun n : ℕ =>
        TateThetaRootRadialSkeleton.coordinate t ell r
          (shiftInt t ell r hr (-(n : ℤ)) z))
      Filter.atTop Filter.atBot := by
  have h :
      Filter.Tendsto (fun n : ℕ => -((n : ℝ)))
        Filter.atTop Filter.atBot :=
    Filter.tendsto_natCast_atTop_atTop.neg_atTop
  have hadd := h.const_add
    (TateThetaRootRadialSkeleton.coordinate t ell r z)
  simpa [coordinate_shiftInt, add_comm] using hadd

end TateThetaRootIntegerAction

end IUTThreeClosures
