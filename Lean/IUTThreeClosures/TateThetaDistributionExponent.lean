/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.FieldTheory.KummerExtension

/-!
# Scalar cores of the cyclic Tate theta distribution formulas

For an odd integer `ell = 2*k+1`, the root-period cyclic distribution formula
contains the automorphy monomial

` s^(-ell*(ell-1)/2) `.

If `s^ell=q`, its positive exponent is exactly `q^k`.  This module also proves
the finite root-of-unity factor identities

`prod_i (1-zeta^i*x)=1-x^ell`

and, for odd `ell`,

`prod_i (1+zeta^i*x)=1+x^ell`.

These are the finite algebraic inputs to the canonical theta and Hecke
discriminant distribution formulas.  No infinite-product interchange, metric
comparison or abc conclusion is assumed here.
-/

namespace IUTThreeClosures

open Polynomial
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

/-- Product over all powers of a primitive root: the finite multiplicative
factor used in the Tate products. -/
theorem prod_one_sub_primitiveRoot_pow_mul
    {R : Type*} [CommRing R] [IsDomain R]
    {ell : ℕ} {ζ : R}
    (hζ : IsPrimitiveRoot ζ ell)
    (hell : 0 < ell)
    (x : R) :
    ∏ i ∈ Finset.range ell, (1 - ζ ^ i * x) = 1 - x ^ ell := by
  have hpoly := X_pow_sub_C_eq_prod hζ
    (α := x) (a := x ^ ell) hell rfl
  apply_fun Polynomial.eval 1 at hpoly
  simpa only [map_pow, eval_prod, eval_sub, eval_X, eval_pow, eval_C,
    one_pow] using hpoly.symm

/-- For odd order, replacing `x` by `-x` yields the plus-sign factor identity
used by the canonical theta distribution. -/
theorem prod_one_add_primitiveRoot_pow_mul
    {R : Type*} [CommRing R] [IsDomain R]
    {ell : ℕ} {ζ : R}
    (hζ : IsPrimitiveRoot ζ ell)
    (hell : 0 < ell)
    (hellOdd : Odd ell)
    (x : R) :
    ∏ i ∈ Finset.range ell, (1 + ζ ^ i * x) = 1 + x ^ ell := by
  have h := prod_one_sub_primitiveRoot_pow_mul hζ hell (-x)
  simpa [mul_neg, hellOdd.neg_pow] using h

end IUTThreeClosures
