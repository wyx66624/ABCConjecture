/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootEquivariantDescent

/-!
# Freeness of the corrected Tate theta-root deck action

The pulled-back theta-root locus carries the corrected generator

`(v,y) ↦ (r*v, (r*v)⁻¹*y)`, where `r^ell=q`.

This module proves that every positive iterate is fixed-point free.  The key
observation is entirely source-derived: the base coordinate of the `n`-th
iterate is `r^n*v`.  A fixed point would therefore imply `r^n=1`, hence

`q^n = (r^ell)^n = (r^n)^ell = 1`,

contradicting the strict Tate inequality `‖q‖<1`.

Thus the corrected equivariant pullback has the algebraic freeness required of
a deck-action candidate.  Proper discontinuity, the analytic quotient,
orbicurve compactification, tempered fundamental group, and graph-cusp
identification remain separate topological/analytic constructions.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootPullbackPoint

/-- Natural iterates of the corrected positive Tate translation. -/
noncomputable def shiftNat
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q) :
    ℕ → TateThetaRootPullbackPoint t ell →
      TateThetaRootPullbackPoint t ell
  | 0, z => z
  | n + 1, z => shift t ell r hr (shiftNat t ell r hr n z)

@[simp]
theorem shiftNat_zero
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftNat t ell r hr 0 z = z :=
  rfl

@[simp]
theorem shiftNat_succ
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftNat t ell r hr (n + 1) z =
      shift t ell r hr (shiftNat t ell r hr n z) :=
  rfl

/-- Exact base coordinate of every positive iterate. -/
theorem shiftNat_base
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    (shiftNat t ell r hr n z).base = r ^ n * z.base := by
  induction n with
  | zero => simp
  | succ n ih =>
      simp [shiftNat, shift, ih, pow_succ, mul_assoc,
        mul_left_comm, mul_comm]

/-- Iteration is additive. -/
theorem shiftNat_add
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (m n : ℕ)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftNat t ell r hr (m + n) z =
      shiftNat t ell r hr m (shiftNat t ell r hr n z) := by
  induction m with
  | zero => simp
  | succ m ih =>
      simp [Nat.succ_add, shiftNat, ih]

/-- Every fixed natural iterate is an injective self-map. -/
theorem shiftNat_injective
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ) :
    Function.Injective (shiftNat t ell r hr n) := by
  induction n with
  | zero =>
      intro x y h
      simpa using h
  | succ n ih =>
      intro x y h
      apply ih
      exact (shiftEquiv t ell r hr).injective h

/-- A fixed point of the `n`-th iterate would force `r^n=1`. -/
theorem root_pow_eq_one_of_shiftNat_eq
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (z : TateThetaRootPullbackPoint t ell)
    (hfix : shiftNat t ell r hr n z = z) :
    r ^ n = 1 := by
  have hbase :=
    congrArg (fun x : TateThetaRootPullbackPoint t ell => x.base) hfix
  rw [shiftNat_base] at hbase
  have hbase' : r ^ n * z.base = 1 * z.base := by
    simpa using hbase
  exact mul_right_cancel hbase'

/-- If `r^ell=q` and `r^n=1`, then `q^n=1`. -/
theorem q_pow_eq_one_of_root_pow_eq_one
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    (n : ℕ)
    (hrn : r ^ n = 1) :
    (t.q : K) ^ n = 1 := by
  have hqUnits : t.q ^ n = 1 := by
    calc
      t.q ^ n = (r ^ ell) ^ n := by
        simpa using congrArg (fun a : Kˣ => a ^ n) hr.symm
      _ = r ^ (ell * n) := by
        rw [pow_mul]
      _ = r ^ (n * ell) := by
        rw [Nat.mul_comm]
      _ = (r ^ n) ^ ell := by
        rw [pow_mul]
      _ = 1 := by
        rw [hrn]
        simp
  have hcoerced := congrArg (fun a : Kˣ => (a : K)) hqUnits
  simpa only [Units.val_pow, Units.val_one] using hcoerced

/-- **Freeness theorem.** No positive iterate of the corrected theta-root
translation fixes a point. -/
theorem shiftNat_ne_of_pos
    (t : TateParameter K) (ell : ℕ)
    (r : Kˣ) (hr : r ^ ell = t.q)
    {n : ℕ} (hn : 0 < n)
    (z : TateThetaRootPullbackPoint t ell) :
    shiftNat t ell r hr n z ≠ z := by
  intro hfix
  have hrn := root_pow_eq_one_of_shiftNat_eq
    t ell r hr n z hfix
  have hqn := q_pow_eq_one_of_root_pow_eq_one
    t ell r hr n hrn
  exact t.pow_ne_one hn hqn

end TateThetaRootPullbackPoint

end IUTThreeClosures
