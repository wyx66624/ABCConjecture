/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The exponent in the noncanonical Tate theta distribution formula

For an odd integer `ell = 2*k+1`, the root-period cyclic distribution formula
contains the automorphy monomial

` s^(-ell*(ell-1)/2) `.

If `s^ell=q`, its positive exponent is exactly `q^k`.  This module
kernel-checks the natural-number exponent identities before the finite and
infinite theta products are formalized.

No analytic theta identity or abc conclusion is assumed here.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-- The triangular exponent of an odd number `ell=2*k+1` is `ell*k`. -/
theorem oddTriangularExponent_eq
    {ell k : ℕ} (hell : ell = 2 * k + 1) :
    ell * (ell - 1) / 2 = ell * k := by
  omega

/-- Gauss' sum over the root-period indices has the same odd triangular
exponent. -/
theorem sum_range_eq_oddTriangularExponent
    {ell k : ℕ} (hell : ell = 2 * k + 1) :
    (∑ j ∈ Finset.range ell, j) = ell * k := by
  rw [Finset.sum_range_id]
  exact oddTriangularExponent_eq hell

/-- If `s^ell=q`, the positive root-period automorphy exponent is `q^k`. -/
theorem rootPeriod_pow_oddTriangular
    {K : Type*} [Monoid K]
    {ell k : ℕ} (hell : ell = 2 * k + 1)
    (s q : K) (hs : s ^ ell = q) :
    s ^ (ell * (ell - 1) / 2) = q ^ k := by
  rw [oddTriangularExponent_eq hell, pow_mul, hs]

/-- Equivalent form using the sum of the indices `0,...,ell-1`. -/
theorem rootPeriod_pow_sum_range
    {K : Type*} [Monoid K]
    {ell k : ℕ} (hell : ell = 2 * k + 1)
    (s q : K) (hs : s ^ ell = q) :
    s ^ (∑ j ∈ Finset.range ell, j) = q ^ k := by
  rw [sum_range_eq_oddTriangularExponent hell, pow_mul, hs]

/-- Existential form directly from oddness. -/
theorem rootPeriod_pow_of_odd
    {K : Type*} [Monoid K]
    {ell : ℕ} (hell : Odd ell)
    (s q : K) (hs : s ^ ell = q) :
    ∃ k : ℕ,
      ell = 2 * k + 1 ∧
      s ^ (ell * (ell - 1) / 2) = q ^ k := by
  rcases hell with ⟨k, hk⟩
  refine ⟨k, hk, ?_⟩
  exact rootPeriod_pow_oddTriangular hk s q hs

/-- In a group, inversion turns the positive identity into the exact negative
monomial identity used by the theta distribution formula. -/
theorem rootPeriod_inv_pow_oddTriangular
    {K : Type*} [Group K]
    {ell k : ℕ} (hell : ell = 2 * k + 1)
    (s q : K) (hs : s ^ ell = q) :
    (s ^ (ell * (ell - 1) / 2))⁻¹ = (q ^ k)⁻¹ := by
  rw [rootPeriod_pow_oddTriangular hell s q hs]

end IUTThreeClosures
