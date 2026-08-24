/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootRadialSkeleton
import Mathlib.Topology.Instances.Int
import Mathlib.Algebra.Order.Floor.Ring

/-!
# Negative escape and local finiteness of the full integer theta-root orbit

The positive corrected theta-root translation increases the normalized radial
coordinate by one. Its inverse therefore decreases the same coordinate by
one. Iterating the two directions defines the complete integer-indexed orbit
and gives the exact formula

`rho(T^n z) = rho(z) + n`.

Consequently:

* positive iterates eventually leave every radially bounded set through its
  upper boundary;
* negative iterates eventually leave through its lower boundary;
* the set of all integer iterates meeting a fixed closed radial strip is
  contained in an explicit finite integer interval.

This is the full algebraic/radial local-finiteness statement needed for proper
discontinuity. Passing from radial strips to arbitrary compact subsets of the
analytic theta-root space still requires a topology for which compact subsets
have bounded radial coordinate; the next topological bridge can use precisely
that source-facing hypothesis.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootRadialSkeleton

/-- Natural iterates of the inverse corrected Tate translation. -/
noncomputable def shiftInvNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℕ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | 0, z => z
  | n + 1, z =>
      TateThetaRootPullbackPoint.shiftInv t ell r hr
        (shiftInvNat t ell r hr n z)

@[simp]
theorem shiftInvNat_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftInvNat t ell r hr 0 z = z :=
  rfl

@[simp]
theorem shiftInvNat_succ
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftInvNat t ell r hr (n + 1) z =
      TateThetaRootPullbackPoint.shiftInv t ell r hr
        (shiftInvNat t ell r hr n z) :=
  rfl

/-- One inverse deck step decreases the normalized radial coordinate by one. -/
theorem coordinate_shiftInv
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r
        (TateThetaRootPullbackPoint.shiftInv t ell r hr z) =
      coordinate t ell r z - 1 := by
  have h := coordinate_shiftEquiv t ell r hr
    ((TateThetaRootPullbackPoint.shiftEquiv t ell r hr).symm z)
  rw [Equiv.apply_symm_apply] at h
  change
    coordinate t ell r
        (TateThetaRootPullbackPoint.shiftInv t ell r hr z) =
      coordinate t ell r z - 1
  linarith

/-- The `n`-fold inverse iterate decreases the radial coordinate by `n`. -/
theorem coordinate_shiftInvNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (shiftInvNat t ell r hr n z) =
      coordinate t ell r z - n := by
  induction n with
  | zero => simp [shiftInvNat]
  | succ n ih =>
      rw [shiftInvNat_succ, coordinate_shiftInv, ih]
      push_cast
      ring

/-- The complete integer-indexed corrected theta-root orbit. Nonnegative
indices use positive iterates; `-[n+1]` uses `n+1` inverse iterates. -/
noncomputable def shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℤ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | Int.ofNat n, z =>
      TateThetaRootPullbackPoint.shiftNat t ell r hr n z
  | Int.negSucc n, z =>
      shiftInvNat t ell r hr (n + 1) z

@[simp]
theorem shiftInt_ofNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftInt t ell r hr (n : ℤ) z =
      TateThetaRootPullbackPoint.shiftNat t ell r hr n z :=
  rfl

@[simp]
theorem shiftInt_negSucc
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftInt t ell r hr (Int.negSucc n) z =
      shiftInvNat t ell r hr (n + 1) z :=
  rfl

/-- Exact radial-coordinate formula for every integer orbit index. -/
theorem coordinate_shiftInt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℤ)
    (z : TateThetaRootPullbackPoint t ell) :
    coordinate t ell r (shiftInt t ell r hr n z) =
      coordinate t ell r z + (n : ℝ) := by
  cases n with
  | ofNat n =>
      simpa [shiftInt] using
        coordinate_shiftNat t ell r hr n z
  | negSucc n =>
      have h := coordinate_shiftInvNat t ell r hr (n + 1) z
      simpa [shiftInt, sub_eq_add_neg] using h

/-- A closed strip in the normalized logarithmic radial coordinate. -/
def radialStrip
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (a b : ℝ) : Set (TateThetaRootPullbackPoint t ell) :=
  {z | a ≤ coordinate t ell r z ∧ coordinate t ell r z ≤ b}

@[simp]
theorem mem_radialStrip
    (t : TateParameter K) (ell : ℕ) (r : Kˣ)
    (a b : ℝ)
    (z : TateThetaRootPullbackPoint t ell) :
    z ∈ radialStrip t ell r a b ↔
      a ≤ coordinate t ell r z ∧ coordinate t ell r z ≤ b :=
  Iff.rfl

/-- If the `n`-th integer iterate meets a radial strip, then `n` lies in an
explicit integer interval obtained by ceiling and floor. -/
theorem index_bounds_of_shiftInt_mem_radialStrip
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) (n : ℤ)
    (hn : shiftInt t ell r hr n z ∈ radialStrip t ell r a b) :
    ⌈a - coordinate t ell r z⌉ ≤ n ∧
      n ≤ ⌊b - coordinate t ell r z⌋ := by
  have hmem := (mem_radialStrip t ell r a b _).mp hn
  rw [coordinate_shiftInt] at hmem
  constructor
  · apply (Int.ceil_le).2
    linarith
  · apply (Int.le_floor).2
    linarith

/-- **All-integer radial local finiteness.** Only finitely many deck indices
can carry a fixed point into a fixed closed radial strip. -/
theorem finite_shiftInt_mem_radialStrip
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) :
    {n : ℤ | shiftInt t ell r hr n z ∈
      radialStrip t ell r a b}.Finite := by
  apply (Set.finite_Icc
    ⌈a - coordinate t ell r z⌉
    ⌊b - coordinate t ell r z⌋).subset
  intro n hn
  exact index_bounds_of_shiftInt_mem_radialStrip
    t ell r hr z a b n hn

/-- Positive integer iterates eventually leave every upper-bounded radial
region. -/
theorem eventually_positive_coordinate_gt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (b : ℝ) :
    ∃ N : ℕ, ∀ n ≥ N,
      b < coordinate t ell r
        (shiftInt t ell r hr (n : ℤ) z) := by
  obtain ⟨N, hN⟩ := exists_nat_gt
    (b - coordinate t ell r z)
  refine ⟨N, ?_⟩
  intro n hn
  have hnR : (N : ℝ) ≤ n := by exact_mod_cast hn
  rw [coordinate_shiftInt]
  push_cast
  linarith

/-- Negative integer iterates eventually leave every lower-bounded radial
region. This is the missing negative-direction escape theorem. -/
theorem eventually_negative_coordinate_lt
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a : ℝ) :
    ∃ N : ℕ, ∀ n ≥ N,
      coordinate t ell r
          (shiftInt t ell r hr (-(n : ℤ)) z) < a := by
  obtain ⟨N, hN⟩ := exists_nat_gt
    (coordinate t ell r z - a)
  refine ⟨N, ?_⟩
  intro n hn
  have hnR : (N : ℝ) ≤ n := by exact_mod_cast hn
  rw [coordinate_shiftInt]
  push_cast
  linarith

/-- Both tails of the integer orbit eventually avoid every closed radial
strip. -/
theorem eventually_both_tails_not_mem_radialStrip
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell)
    (a b : ℝ) :
    ∃ N : ℕ, ∀ n ≥ N,
      shiftInt t ell r hr (n : ℤ) z ∉ radialStrip t ell r a b ∧
      shiftInt t ell r hr (-(n : ℤ)) z ∉ radialStrip t ell r a b := by
  obtain ⟨N₊, hN₊⟩ :=
    eventually_positive_coordinate_gt t ell r hr z b
  obtain ⟨N₋, hN₋⟩ :=
    eventually_negative_coordinate_lt t ell r hr z a
  refine ⟨max N₊ N₋, ?_⟩
  intro n hn
  have hn₊ : N₊ ≤ n := le_trans (Nat.le_max_left _ _) hn
  have hn₋ : N₋ ≤ n := le_trans (Nat.le_max_right _ _) hn
  constructor
  · intro hmem
    exact (not_lt_of_ge ((mem_radialStrip t ell r a b _).mp hmem).2)
      (hN₊ n hn₊)
  · intro hmem
    exact (not_lt_of_ge ((mem_radialStrip t ell r a b _).mp hmem).1)
      (hN₋ n hn₋)

end TateThetaRootRadialSkeleton

end IUTThreeClosures
