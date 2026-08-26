/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Scalar core of the archimedean unit-spread barrier

A pair of norm-one conjugate units has logarithmic coordinate vectors

`(n L, -n L)` and `(-n L, n L)`

at the two real embeddings.  This module proves that the normalized projective
height of this pair is exactly `n L`, and is therefore unbounded when `L > 0`.

The number-field instantiation is `L = log (3 + 2 * sqrt 2)` in
`Q(sqrt 2)`.  The present module isolates the source-independent real
inequality; no height--conductor estimate or abc conclusion is assumed.
-/

namespace IUTThreeClosures

/-- The normalized two-real-place projective height of logarithmic coordinates
`(nL,-nL)` and their conjugate swap. -/
noncomputable def symmetricTwoPlaceLogHeight (L : ℝ) (n : ℕ) : ℝ :=
  (max ((n : ℝ) * L) (-((n : ℝ) * L)) +
      max (-((n : ℝ) * L)) ((n : ℝ) * L)) / 2

/-- For a nonnegative logarithmic unit size, both real embeddings contribute
`nL` to the projective maximum. -/
theorem symmetricTwoPlaceLogHeight_eq
    {L : ℝ} (hL : 0 ≤ L) (n : ℕ) :
    symmetricTwoPlaceLogHeight L n = (n : ℝ) * L := by
  have hnL : 0 ≤ (n : ℝ) * L :=
    mul_nonneg (Nat.cast_nonneg n) hL
  have hneg : -((n : ℝ) * L) ≤ (n : ℝ) * L := by
    linarith
  unfold symmetricTwoPlaceLogHeight
  rw [max_eq_left hneg, max_eq_right hneg]
  ring

/-- If the logarithmic size is positive, the two-place heights exceed every
real bound. -/
theorem exists_symmetricTwoPlaceLogHeight_gt
    {L : ℝ} (hL : 0 < L) (B : ℝ) :
    ∃ n : ℕ, B < symmetricTwoPlaceLogHeight L n := by
  obtain ⟨n, hn⟩ := exists_nat_gt (B / L)
  refine ⟨n, ?_⟩
  rw [symmetricTwoPlaceLogHeight_eq hL.le]
  exact (div_lt_iff₀ hL).mp hn

end IUTThreeClosures
