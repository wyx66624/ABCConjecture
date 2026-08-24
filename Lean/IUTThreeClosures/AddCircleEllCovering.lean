/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Topology.Covering.AddCircle
import Mathlib.Topology.Instances.AddCircle.Real

/-!
# The degree-`ell` covering of the radial additive circle

On the unit additive circle `R/Z`, multiplication by a positive integer
models the map from the `ell`-sheeted theta-root skeleton to the original Tate
skeleton.  Its kernel consists of the standard rational points `j/ell`, i.e.
the image of `ZMod ell`.

Mathlib contains the covering-space theory of additive circles.  The first
theorem below asks the library search procedure for the canonical covering-map
statement in its native API.  Once that standard theorem is identified, the
remaining results package the residual deck labels and their kernel formula.

No Berkovich comparison or orbicurve statement is hidden here.
-/

namespace IUTThreeClosures

open AddCircle

/-- Multiplication by a nonzero natural number on the unit additive circle is
a covering map. -/
theorem unitAddCircle_nsmul_isCoveringMap
    (ell : ℕ) [NeZero ell] :
    IsCoveringMap (fun x : UnitAddCircle => ell • x) := by
  exact?

/-- Every standard residual deck label lies in the kernel of multiplication
by `ell`. -/
theorem zmod_toAddCircle_mem_nsmul_kernel
    (ell : ℕ) [NeZero ell]
    (j : ZMod ell) :
    ell • ZMod.toAddCircle j = 0 := by
  induction j using ZMod.inductionOn with
  | _ k =>
      rw [ZMod.toAddCircle_intCast]
      change
        ell • (((k : ℝ) / (ell : ℝ) : ℝ) : UnitAddCircle) = 0
      rw [← AddCircle.coe_nsmul]
      have hell : (ell : ℝ) ≠ 0 := by
        exact_mod_cast (NeZero.ne ell)
      have hreal : (ell : ℝ) * ((k : ℝ) / (ell : ℝ)) = k := by
        field_simp [hell]
      rw [hreal]
      simp

/-- The standard `ZMod ell` labels give distinct points in the kernel. -/
theorem zmod_toAddCircle_kernel_injective
    (ell : ℕ) [NeZero ell] :
    Function.Injective
      (fun j : ZMod ell =>
        (ZMod.toAddCircle j,
          zmod_toAddCircle_mem_nsmul_kernel ell j)) := by
  intro i j h
  have hbase : ZMod.toAddCircle i = ZMod.toAddCircle j :=
    congrArg Subtype.val h
  exact ZMod.toAddCircle_injective ell hbase

/-- The one-step deck point is a nonzero kernel element for prime `ell`. -/
theorem unitAddCircle_kernel_generator_ne_zero
    {ell : ℕ} (hell : ell.Prime) :
    ZMod.toAddCircle (1 : ZMod ell) ≠ 0 := by
  letI : NeZero ell := ⟨hell.ne_zero⟩
  rw [ZMod.toAddCircle_eq_zero]
  exact one_ne_zero

/-- Source-facing kernel completeness theorem.  It is isolated in the exact
shape needed by the radial theta-root comparison: every kernel point is one of
the standard `j/ell` labels.  Mathlib proof search is used to locate the native
AddCircle classification theorem. -/
theorem unitAddCircle_nsmul_kernel_eq_zmod_range
    (ell : ℕ) [NeZero ell] :
    {x : UnitAddCircle | ell • x = 0} =
      Set.range (ZMod.toAddCircle : ZMod ell → UnitAddCircle) := by
  exact?

end IUTThreeClosures
