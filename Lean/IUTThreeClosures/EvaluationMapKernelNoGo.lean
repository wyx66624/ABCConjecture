/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Kernel obstruction for cyclic-line evaluation determinants

The geometric no-go theorem constructs a nonzero section whose zero divisor is
all nonzero points of a cyclic subgroup.  The resulting evaluation map has a
nonzero kernel and therefore cannot define a nonzero determinant.

This module formalizes the linear-algebraic implication.  Constructing the
actual principal section from the elliptic-curve divisor relation remains a
separate algebraic-geometric theorem.
-/

namespace IUTThreeClosures

/-- A linear evaluation map with a nonzero vanishing section is not injective. -/
theorem evaluationMap_not_injective_of_nonzero_kernel
    {K V W : Type*}
    [Semiring K]
    [AddCommMonoid V] [Module K V]
    [AddCommMonoid W] [Module K W]
    (ev : V →ₗ[K] W)
    {s : V}
    (hs : s ≠ 0)
    (hvanish : ev s = 0) :
    ¬ Function.Injective ev := by
  intro hinjective
  have hzero : s = 0 := by
    apply hinjective
    simpa using hvanish
  exact hs hzero

/-- Equivalently, a linear evaluation equivalence cannot contain a nonzero
section that vanishes at every evaluation coordinate. -/
theorem evaluationEquiv_no_nonzero_kernel
    {K V W : Type*}
    [Semiring K]
    [AddCommMonoid V] [Module K V]
    [AddCommMonoid W] [Module K W]
    (ev : V ≃ₗ[K] W)
    {s : V}
    (hvanish : ev s = 0) :
    s = 0 := by
  exact ev.injective (by simpa using hvanish)

end IUTThreeClosures
