/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.RingTheory.Etale.StandardEtale

/-!
# A concrete finite étale Kummer algebra

Let `R` be a commutative ring, let `u` be a unit of `R`, and suppose that the
positive integer `n` is also represented by a unit of `R`.  This file builds
the standard étale presentation of

`R[X] / (X^n - u)`.

The key input is proved, rather than stored in a structure field: if
`f = X^n - u`, then

`f' * ((n⁻¹ u⁻¹) X) + f * (-u⁻¹) = 1`.

Thus `f'` is invertible modulo `f`.  This is the affine algebraic core of the
Kummer covers used in the GenEll/Fermat-cover route.  No connectedness,
compactification, ramification-at-the-boundary, height comparison, or Belyi
descent is asserted here.
-/

namespace IUTThreeClosures.ConcreteGenEllKummerCover

open Polynomial

noncomputable section

universe u

variable {R : Type u} [CommRing R]

/-- The Kummer polynomial `X^n - u`. -/
def kummerPolynomial (n : ℕ) (u : Rˣ) : R[X] :=
  X ^ n - C (u : R)

/-- The Kummer polynomial is monic as soon as its exponent is positive. -/
theorem kummerPolynomial_monic
    (n : ℕ) (hn : n ≠ 0) (u : Rˣ) :
    (kummerPolynomial n u).Monic := by
  exact monic_X_pow_sub_C (u : R) hn

/-- The explicit Bézout identity between the Kummer polynomial and its
derivative.  The unit `nu` records that the image of `n` in `R` is a unit. -/
theorem kummer_derivative_bezout
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    derivative (kummerPolynomial n u) *
          (C ((nu⁻¹ : Rˣ) : R) * C ((u⁻¹ : Rˣ) : R) * X) +
        kummerPolynomial n u * (-C ((u⁻¹ : Rˣ) : R)) = 1 := by
  simp only [kummerPolynomial, derivative_sub, derivative_X_pow,
    derivative_C, sub_zero]
  rw [← hnu]
  have hpow : (X : R[X]) ^ (n - 1) * X = X ^ n := by
    rw [← pow_succ]
    congr 1
    omega
  have hfirst :
      C (nu : R) * X ^ (n - 1) *
          (C ((nu⁻¹ : Rˣ) : R) * C ((u⁻¹ : Rˣ) : R) * X) =
        C ((u⁻¹ : Rˣ) : R) * X ^ n := by
    calc
      _ = (C (nu : R) * C ((nu⁻¹ : Rˣ) : R)) *
          C ((u⁻¹ : Rˣ) : R) * (X ^ (n - 1) * X) := by
            ac_rfl
      _ = C ((nu : R) * ((nu⁻¹ : Rˣ) : R)) *
          C ((u⁻¹ : Rˣ) : R) * X ^ n := by
            rw [C_mul, hpow]
      _ = C ((u⁻¹ : Rˣ) : R) * X ^ n := by simp
  rw [hfirst]
  calc
    C ((u⁻¹ : Rˣ) : R) * X ^ n +
        (X ^ n - C (u : R)) * -C ((u⁻¹ : Rˣ) : R) =
      C (u : R) * C ((u⁻¹ : Rˣ) : R) := by ring
    _ = 1 := by rw [← C_mul]; simp

/-- The standard étale presentation of the Kummer algebra. -/
def kummerStandardEtalePair
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    StandardEtalePair R where
  f := kummerPolynomial n u
  monic_f := kummerPolynomial_monic n hn u
  g := 1
  cond := by
    refine ⟨C ((nu⁻¹ : Rˣ) : R) * C ((u⁻¹ : Rˣ) : R) * X,
      -C ((u⁻¹ : Rˣ) : R), 1, ?_⟩
    simpa using kummer_derivative_bezout n hn u nu hnu

/-- The distinguished generator satisfies the defining Kummer equation in
the concrete standard étale ring. -/
theorem kummer_X_pow_eq
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    (kummerStandardEtalePair n hn u nu hnu).X ^ n =
      algebraMap R (kummerStandardEtalePair n hn u nu hnu).Ring (u : R) := by
  let P := kummerStandardEtalePair n hn u nu hnu
  change P.X ^ n = algebraMap R P.Ring (u : R)
  have hroot := P.hasMap_X.1
  change aeval P.X (kummerPolynomial n u) = 0 at hroot
  rw [kummerPolynomial, map_sub, aeval_X_pow, aeval_C] at hroot
  exact sub_eq_zero.mp hroot

/-- The concrete Kummer presentation is étale over its base ring. -/
theorem kummer_algebra_etale
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    Algebra.Etale R (kummerStandardEtalePair n hn u nu hnu).Ring := by
  infer_instance

/-- Because the localization polynomial is `g = 1`, the standard étale ring
is canonically equivalent to the ordinary monogenic quotient
`AdjoinRoot (X^n-u)`. -/
noncomputable def kummerRingEquivAdjoinRoot
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    (kummerStandardEtalePair n hn u nu hnu).Ring ≃ₐ[R]
      AdjoinRoot (kummerPolynomial n u) := by
  let P := kummerStandardEtalePair n hn u nu hnu
  have hg : IsUnit (AdjoinRoot.mk P.f P.g) := by
    change IsUnit ((AdjoinRoot.mk P.f) 1)
    exact isUnit_one.map (AdjoinRoot.mk P.f)
  exact P.equivAwayAdjoinRoot.trans
    ((IsLocalization.atUnit (AdjoinRoot P.f)
      (Localization.Away (AdjoinRoot.mk P.f P.g))
      (AdjoinRoot.mk P.f P.g) hg).symm.restrictScalars R)

/-- The transported power basis of the concrete Kummer algebra. -/
noncomputable def kummerPowerBasis
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    PowerBasis R (kummerStandardEtalePair n hn u nu hnu).Ring :=
  (AdjoinRoot.powerBasis' (kummerPolynomial_monic n hn u)).map
    (kummerRingEquivAdjoinRoot n hn u nu hnu).symm

/-- The concrete power basis has exactly `n` elements. -/
@[simp]
theorem kummerPowerBasis_dim
    [Nontrivial R]
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    (kummerPowerBasis n hn u nu hnu).dim = n := by
  simp [kummerPowerBasis, kummerPolynomial, AdjoinRoot.powerBasis']

/-- A positive-degree Kummer algebra over a nontrivial base is itself
nontrivial.  This is extracted from the explicit power basis, rather than
postulated as an extra hypothesis on the quotient ring. -/
theorem kummer_ring_nontrivial
    [Nontrivial R]
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    Nontrivial (kummerStandardEtalePair n hn u nu hnu).Ring := by
  let pb := kummerPowerBasis n hn u nu hnu
  have hdim : pb.dim = n := kummerPowerBasis_dim n hn u nu hnu
  let i : Fin pb.dim :=
    ⟨0, by simpa [hdim] using Nat.pos_of_ne_zero hn⟩
  exact nontrivial_of_ne (pb.basis i) 0 (pb.basis.linearIndependent.ne_zero i)

/-- The Kummer algebra is free over `R`; its explicit power basis has rank
`n` by `kummerPowerBasis_dim`. -/
theorem kummer_module_free
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    Module.Free R (kummerStandardEtalePair n hn u nu hnu).Ring := by
  letI : Module.Free R (AdjoinRoot (kummerPolynomial n u)) :=
    (kummerPolynomial_monic n hn u).free_adjoinRoot
  exact Module.Free.of_equiv
    (kummerRingEquivAdjoinRoot n hn u nu hnu).symm.toLinearEquiv

/-- The Kummer algebra is finite as a module over `R`.  Together with
`kummer_algebra_etale`, this gives a concrete finite étale cover. -/
theorem kummer_module_finite
    (n : ℕ) (hn : n ≠ 0) (u nu : Rˣ) (hnu : (nu : R) = (n : R)) :
    Module.Finite R (kummerStandardEtalePair n hn u nu hnu).Ring := by
  let P := kummerStandardEtalePair n hn u nu hnu
  letI : Module.Finite R (AdjoinRoot (kummerPolynomial n u)) :=
    (kummerPolynomial_monic n hn u).finite_adjoinRoot
  exact Module.Finite.equiv
    (kummerRingEquivAdjoinRoot n hn u nu hnu).symm.toLinearEquiv

end

end IUTThreeClosures.ConcreteGenEllKummerCover
