/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EuclidAuxiliaryPrimeAvoidOne

/-!
# Quantitative consequence of a uniform avoidance large-image criterion

For a semistable elliptic curve, the classical group-theoretic route to large
mod-`ell` image has the following shape:

* `ell` is above the finite rational-isogeny threshold;
* `ell` does not divide a multiplicative Tate/discriminant order, so inertia
  supplies a nontrivial transvection;
* `ell` is distinct from the residue characteristic at the place used for the
  local inertia calculation;
* irreducibility plus the transvection forces the image to contain `SL₂`.

This module does not prove those arithmetic and subgroup-classification
inputs.  It packages their exact uniform consequence and combines it with the
two-stage Euclidean selector.  The result is an explicit upper bound for a
large-image prime, rather than mere eventual existence.
-/

namespace IUTThreeClosures

/-- A uniform large-image criterion controlled by one positive local order and
one residue characteristic. -/
structure UniformAvoidanceLargeImageCriterion
    (LargeImage : ℕ → Prop) where
  cutoff : ℕ
  localOrder : ℕ
  localOrder_pos : 0 < localOrder
  residuePrime : ℕ
  residuePrime_prime : Nat.Prime residuePrime
  largeImage_of_conditions :
    ∀ ell : ℕ,
      Nat.Prime ell →
      cutoff < ell →
      ¬ ell ∣ localOrder →
      ell ≠ residuePrime →
      LargeImage ell

namespace UniformAvoidanceLargeImageCriterion

/-- The two-stage Euclidean prime selected from a uniform criterion. -/
def selectedPrime
    {LargeImage : ℕ → Prop}
    (C : UniformAvoidanceLargeImageCriterion LargeImage) : ℕ :=
  euclidAuxiliaryPrimeAvoidOne
    C.cutoff C.localOrder C.residuePrime

/-- The selected prime satisfies the large-image criterion. -/
theorem selectedPrime_largeImage
    {LargeImage : ℕ → Prop}
    (C : UniformAvoidanceLargeImageCriterion LargeImage) :
    LargeImage C.selectedPrime := by
  exact C.largeImage_of_conditions C.selectedPrime
    (euclidAuxiliaryPrimeAvoidOne_prime C.localOrder_pos)
    (threshold_lt_euclidAuxiliaryPrimeAvoidOne C.localOrder_pos)
    (euclidAuxiliaryPrimeAvoidOne_not_dvd C.localOrder_pos)
    (euclidAuxiliaryPrimeAvoidOne_ne
      C.localOrder_pos C.residuePrime_prime)

/-- The selected large-image prime has an explicit polynomial upper bound in
the local order. -/
theorem selectedPrime_le
    {LargeImage : ℕ → Prop}
    (C : UniformAvoidanceLargeImageCriterion LargeImage) :
    C.selectedPrime ≤
      C.cutoff.factorial * C.localOrder *
          (C.cutoff.factorial * C.localOrder + 1) + 1 := by
  exact euclidAuxiliaryPrimeAvoidOne_le C.localOrder_pos

/-- Complete bounded large-image-prime theorem. -/
theorem exists_bounded_largeImage_prime
    {LargeImage : ℕ → Prop}
    (C : UniformAvoidanceLargeImageCriterion LargeImage) :
    ∃ ell : ℕ,
      Nat.Prime ell ∧
      C.cutoff < ell ∧
      LargeImage ell ∧
      ell ≤ C.cutoff.factorial * C.localOrder *
          (C.cutoff.factorial * C.localOrder + 1) + 1 := by
  exact ⟨C.selectedPrime,
    euclidAuxiliaryPrimeAvoidOne_prime C.localOrder_pos,
    threshold_lt_euclidAuxiliaryPrimeAvoidOne C.localOrder_pos,
    C.selectedPrime_largeImage,
    C.selectedPrime_le⟩

end UniformAvoidanceLargeImageCriterion

end IUTThreeClosures
