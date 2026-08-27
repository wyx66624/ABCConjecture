/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Scalar core of the Riemann--Hurwitz barrier to Belyi amplification

For a degree-`d` map of projective lines, if `r` is the number of distinct
points above three marked values, the ramification contribution above those
values is `3d-r`.  Riemann--Hurwitz bounds this by `2d-2`.  This module proves
the source-independent arithmetic consequences:

`3d-r <= 2d-2  ->  d+2 <= r`,

and hence a nonconstant map with at most three boundary preimages has degree
one.

The geometric Riemann--Hurwitz theorem itself is not postulated here.
-/

namespace IUTThreeClosures

/-- Arithmetic rearrangement of the three-boundary Riemann--Hurwitz budget. -/
theorem belyiBoundaryCount_of_ramificationBudget
    {d r : ℤ}
    (h : 3 * d - r ≤ 2 * d - 2) :
    d + 2 ≤ r := by
  linarith

/-- A nonconstant support-preserving three-boundary self-map must have degree
one. -/
theorem supportPreservingThreeBoundary_degree_one
    {d r : ℤ}
    (hd : 1 ≤ d)
    (hr : r ≤ 3)
    (h : 3 * d - r ≤ 2 * d - 2) :
    d = 1 := by
  have hcount : d + 2 ≤ r :=
    belyiBoundaryCount_of_ramificationBudget h
  linarith

/-- In particular, a degree strictly greater than one is incompatible with at
most three distinct boundary preimages. -/
theorem no_nontrivial_supportPreservingThreeBoundary
    {d r : ℤ}
    (hd : 2 ≤ d)
    (hr : r ≤ 3)
    (h : 3 * d - r ≤ 2 * d - 2) : False := by
  have hone := supportPreservingThreeBoundary_degree_one
    (d := d) (r := r) (by linarith) hr h
  linarith

end IUTThreeClosures
