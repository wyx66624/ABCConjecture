/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootRadialSkeleton

/-!
# The all-integer theta-root deck action

The corrected theta-root deck generator translates the normalized logarithmic
radial coordinate by one. We construct its negative and all-integer iterates
and prove the exact formula

`rho(T^n z) = rho(z) + n`, `n : ℤ`.

Thus positive iterates escape above every real threshold, negative iterates
escape below every real threshold, and all integer iterates are distinct.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootIntegerAction

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

noncomputable def shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℤ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | Int.ofNat n, z =>
      TateThetaRootPullbackPoint.shiftNat t ell r hr n z
  | Int.negSucc n, z =>
      shiftNegNat t ell r hr (n + 1) z

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

theorem exists_positive_escape_above
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (A : ℝ) :
    ∃ N : ℕ, ∀ n ≥ N,
      A < TateThetaRootRadialSkeleton.coordinate t ell r
        (shiftInt t ell r hr n z) := by
  obtain ⟨N, hN⟩ :=
    exists_nat_gt
      (A - TateThetaRootRadialSkeleton.coordinate t ell r z)
  refine ⟨N, ?_⟩
  intro n hn
  rw [coordinate_shiftInt]
  have hcast : (N : ℝ) ≤ n := by exact_mod_cast hn
  have hN' :
      A - TateThetaRootRadialSkeleton.coordinate t ell r z < (N : ℝ) :=
    hN
  linarith

theorem exists_negative_escape_below
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (A : ℝ) :
    ∃ N : ℕ, ∀ n ≥ N,
      TateThetaRootRadialSkeleton.coordinate t ell r
          (shiftInt t ell r hr (-(n : ℤ)) z) < A := by
  obtain ⟨N, hN⟩ :=
    exists_nat_gt
      (TateThetaRootRadialSkeleton.coordinate t ell r z - A)
  refine ⟨N, ?_⟩
  intro n hn
  rw [coordinate_shiftInt]
  push_cast
  have hcast : (N : ℝ) ≤ n := by exact_mod_cast hn
  have hN' :
      TateThetaRootRadialSkeleton.coordinate t ell r z - A < (N : ℝ) :=
    hN
  linarith

end TateThetaRootIntegerAction

end IUTThreeClosures
