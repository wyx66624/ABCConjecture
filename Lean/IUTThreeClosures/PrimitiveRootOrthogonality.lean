/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.RingTheory.RootsOfUnity.PrimitiveRoots

/-!
# Scalar orthogonality for a primitive root of unity

For a primitive root `ζ` of prime order `ell`, every nontrivial power
`ζ^d` is again primitive.  Consequently its complete geometric sum vanishes:

`∑ j < ell, ζ^(d*j) = 0`

whenever `ell ∤ d`.  This is the scalar input for the row-orthogonality of the
finite Fourier matrix in the Heisenberg--theta route.
-/

namespace IUTThreeClosures

open Finset
open scoped BigOperators

/-- A nontrivial power of a primitive root of prime order has vanishing complete
geometric sum. -/
theorem primitiveRoot_pow_sum_eq_zero
    {K : Type*} [CommRing K] [IsDomain K]
    {ell d : ℕ} {ζ : K}
    (hell : ell.Prime)
    (hζ : IsPrimitiveRoot ζ ell)
    (hd : ¬ ell ∣ d) :
    ∑ j ∈ Finset.range ell, ζ ^ (d * j) = 0 := by
  have hcop : d.Coprime ell :=
    hell.coprime_iff_not_dvd.mpr hd
  have hpow : IsPrimitiveRoot (ζ ^ d) ell :=
    hζ.pow_of_coprime d hcop
  have hell_one : 1 < ell := hell.one_lt
  simpa [pow_mul] using hpow.geom_sum_eq_zero hell_one

/-- Diagonal companion: the complete sum of the trivial character is the
cardinality of the index set. -/
theorem primitiveRoot_trivial_sum
    {K : Type*} [CommRing K]
    (ell : ℕ) :
    ∑ _j ∈ Finset.range ell, (1 : K) = ell := by
  simp

/-- Two-exponent form used in Fourier row products. -/
theorem primitiveRoot_difference_sum_eq_zero
    {K : Type*} [CommRing K] [IsDomain K]
    {ell a b : ℕ} {ζ : K}
    (hell : ell.Prime)
    (hζ : IsPrimitiveRoot ζ ell)
    (hab : ¬ ell ∣ a - b) :
    ∑ j ∈ Finset.range ell, ζ ^ ((a - b) * j) = 0 :=
  primitiveRoot_pow_sum_eq_zero hell hζ hab

end IUTThreeClosures
