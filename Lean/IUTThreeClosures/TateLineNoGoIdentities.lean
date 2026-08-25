/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Exact no-go identities for symmetric Tate-line selectors

For a split Tate curve, the canonical cyclic `ell`-line has logarithmic
coefficient

`A_ell = (ell - 1) / 12`,

while every noncanonical line has coefficient

`B_ell = -(ell - 1) / (12 * ell)`.

Two exact identities underlie the no-go theorems in the v8 abc research
programme:

* one canonical line plus all `ell` noncanonical lines has total coefficient
  zero;
* a generic selector that recovers only a `1 / (ell + 1)` fraction of the gap
  between canonical and noncanonical lines also has coefficient zero.

The module proves only these scalar identities.  The geometric statements that
produce the coefficients and the Galois/geometry-of-numbers averaging are kept
as separate mathematical theorems.
-/

namespace IUTThreeClosures

/-- Canonical Tate-line coefficient. -/
noncomputable def tateCanonicalLineCoefficient (ell : ℝ) : ℝ :=
  (ell - 1) / 12

/-- Noncanonical Tate-line coefficient. -/
noncomputable def tateNoncanonicalLineCoefficient (ell : ℝ) : ℝ :=
  -(ell - 1) / (12 * ell)

/-- One canonical line and all `ell` noncanonical lines cancel exactly. -/
theorem canonical_add_noncanonical_orbit_eq_zero
    {ell : ℝ} (hell : ell ≠ 0) :
    tateCanonicalLineCoefficient ell +
      ell * tateNoncanonicalLineCoefficient ell = 0 := by
  unfold tateCanonicalLineCoefficient tateNoncanonicalLineCoefficient
  field_simp [hell]
  ring

/-- The full torsion-packet coefficient vanishes after multiplication by any
common local Tate weight. -/
theorem full_torsion_packet_energy_eq_zero
    {ell W : ℝ} (hell : ell ≠ 0) :
    tateCanonicalLineCoefficient ell * W +
      ell * tateNoncanonicalLineCoefficient ell * W = 0 := by
  have h := canonical_add_noncanonical_orbit_eq_zero (ell := ell) hell
  calc
    tateCanonicalLineCoefficient ell * W +
        ell * tateNoncanonicalLineCoefficient ell * W =
      (tateCanonicalLineCoefficient ell +
        ell * tateNoncanonicalLineCoefficient ell) * W := by ring
    _ = 0 := by rw [h, zero_mul]

/-- A generic full-projective-orbit selector recovers only a
`1 / (ell + 1)` fraction of the canonical/noncanonical gap, which again
cancels exactly against the noncanonical baseline. -/
theorem full_orbit_selector_dimension_barrier
    {ell : ℝ}
    (hell : ell ≠ 0)
    (hellOne : ell + 1 ≠ 0) :
    tateNoncanonicalLineCoefficient ell +
      (tateCanonicalLineCoefficient ell -
        tateNoncanonicalLineCoefficient ell) / (ell + 1) = 0 := by
  unfold tateCanonicalLineCoefficient tateNoncanonicalLineCoefficient
  field_simp [hell, hellOne]
  ring

/-- Weighted form of the generic selector barrier. -/
theorem full_orbit_selector_energy_eq_zero
    {ell W : ℝ}
    (hell : ell ≠ 0)
    (hellOne : ell + 1 ≠ 0) :
    (tateNoncanonicalLineCoefficient ell +
      (tateCanonicalLineCoefficient ell -
        tateNoncanonicalLineCoefficient ell) / (ell + 1)) * W = 0 := by
  rw [full_orbit_selector_dimension_barrier hell hellOne, zero_mul]

end IUTThreeClosures
