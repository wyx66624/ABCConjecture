/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ConcreteAffineFermatJacobian
import IUTThreeClosures.ConcreteFermatOpenRing

/-!
# Equivalence of two affine Fermat presentations

There are two concrete affine Fermat coordinate rings in this development:

* the bivariate quotient
  `K[X₀,X₁] / (X₀^n + X₁^n - 1)` used by the Jacobian calculation;
* the iterated univariate presentation
  `AdjoinRoot (Y^n - (1-X^n))` over `K[X]` used by the irreducibility and
  localization calculations.

This file proves directly that they are isomorphic as `K`-algebras.

## Mathematical proof

Write `Q` for the bivariate quotient and `A` for the `AdjoinRoot`
presentation.  In `A`, let `x` be the image of the coefficient variable and
let `y` be the adjoined root.  Since `x^n + y^n = 1`, evaluation

`X₀ |-> x`, `X₁ |-> y`

kills the bivariate Fermat relation and therefore factors through a
`K`-algebra map `F : Q -> A`.

Conversely, in `Q` let `xbar` and `ybar` be the images of `X₀` and `X₁`.
Evaluation `X |-> xbar` gives a `K`-algebra map `K[X] -> Q`.  The quotient
relation says

`ybar^n = 1 - xbar^n`,

so `ybar` is a root of `Y^n - (1-X^n)` after applying this coefficient map.
The universal property of `AdjoinRoot` therefore gives a `K`-algebra map
`G : A -> Q`.

The composite `G o F` fixes the two bivariate polynomial generators, hence
is the identity on `Q`.  The composite `F o G` fixes the coefficient
variable `X` and the adjoined root `Y`; polynomial and `AdjoinRoot`
extensionality therefore make it the identity on `A`.  Thus `F` and `G` are
inverse maps, without a separate injectivity or surjectivity argument.

The already-proved Jacobian smoothness of `Q` transports across this
equivalence to `A`.  Smoothness then composes with localization at the honest
boundary element, proving smoothness of the affine open Fermat ring.

These are affine algebra statements only.  No projective compactification,
projective smoothness, ramification index, or Belyi-cover theorem is asserted.
-/

namespace IUTThreeClosures
namespace ConcreteFermatPresentationEquiv

noncomputable section

open Polynomial

universe u

variable (K : Type u) [Field K]

namespace J

abbrev Relation := ConcreteAffineFermatJacobian.fermatRelation
abbrev RelationIdeal := ConcreteAffineFermatJacobian.fermatRelationIdeal
abbrev Ring := ConcreteAffineFermatJacobian.FermatJacobianRing

/-- The bivariate quotient map as a `K`-algebra homomorphism. -/
abbrev quotientAlgHom (n : ℕ) :
    MvPolynomial (Fin 2) K →ₐ[K] Ring K n :=
  Ideal.Quotient.mkₐ K (RelationIdeal K n)

/-- The image of the first bivariate variable in the quotient. -/
def x (n : ℕ) : Ring K n :=
  quotientAlgHom K n (MvPolynomial.X 0)

/-- The image of the second bivariate variable in the quotient. -/
def y (n : ℕ) : Ring K n :=
  quotientAlgHom K n (MvPolynomial.X 1)

end J

namespace A

abbrev Polynomial := ConcreteFermatIrreducibility.fermatPolynomial
abbrev Ring := ConcreteFermatIrreducibility.FermatAffineRing
abbrev x := ConcreteFermatOpenRing.affineX
abbrev y := ConcreteFermatOpenRing.affineY

end A

/-! ## The map from the bivariate quotient to `AdjoinRoot` -/

/-- The two target coordinates used to evaluate the bivariate polynomial
ring. -/
def adjoinCoordinates (n : ℕ) : Fin 2 → A.Ring K n :=
  ![A.x K n, A.y K n]

/-- Evaluate the two bivariate generators at the two coordinates of the
`AdjoinRoot` presentation. -/
def mvPolynomialToAdjoin (n : ℕ) :
    MvPolynomial (Fin 2) K →ₐ[K] A.Ring K n :=
  MvPolynomial.aeval (adjoinCoordinates K n)

@[simp]
theorem mvPolynomialToAdjoin_X_zero (n : ℕ) :
    mvPolynomialToAdjoin K n (MvPolynomial.X 0) = A.x K n := by
  simp [mvPolynomialToAdjoin, adjoinCoordinates]

@[simp]
theorem mvPolynomialToAdjoin_X_one (n : ℕ) :
    mvPolynomialToAdjoin K n (MvPolynomial.X 1) = A.y K n := by
  simp [mvPolynomialToAdjoin, adjoinCoordinates]

/-- The defining bivariate relation evaluates to zero in the
`AdjoinRoot` presentation. -/
theorem mvPolynomialToAdjoin_relation_eq_zero (n : ℕ) :
    mvPolynomialToAdjoin K n (J.Relation K n) = 0 := by
  rw [J.Relation, ConcreteAffineFermatJacobian.fermatRelation,
    ConcreteAffineFermatJacobian.fermatX,
    ConcreteAffineFermatJacobian.fermatY,
    map_sub, map_add, map_pow, map_pow,
    mvPolynomialToAdjoin_X_zero, mvPolynomialToAdjoin_X_one, map_one]
  exact sub_eq_zero.mpr (ConcreteFermatOpenRing.affine_fermat_equation K n)

/-- The whole principal relation ideal lies in the kernel of bivariate
evaluation. -/
theorem relationIdeal_le_ker_mvPolynomialToAdjoin (n : ℕ) :
    J.RelationIdeal K n ≤ RingHom.ker (mvPolynomialToAdjoin K n).toRingHom := by
  rw [J.RelationIdeal, ConcreteAffineFermatJacobian.fermatRelationIdeal]
  apply Ideal.span_le.mpr
  rintro _ ⟨_i, rfl⟩
  change mvPolynomialToAdjoin K n
    (ConcreteAffineFermatJacobian.fermatRelationFamily K n _i) = 0
  simpa [ConcreteAffineFermatJacobian.fermatRelationFamily] using
    mvPolynomialToAdjoin_relation_eq_zero K n

/-- Factor bivariate evaluation through the Fermat quotient. -/
def jacobianToAdjoin (n : ℕ) : J.Ring K n →ₐ[K] A.Ring K n :=
  Ideal.Quotient.liftₐ (J.RelationIdeal K n) (mvPolynomialToAdjoin K n)
    (fun _p hp => relationIdeal_le_ker_mvPolynomialToAdjoin K n hp)

@[simp]
theorem jacobianToAdjoin_x (n : ℕ) :
    jacobianToAdjoin K n (J.x K n) = A.x K n := by
  simp [jacobianToAdjoin, J.x, J.quotientAlgHom]

@[simp]
theorem jacobianToAdjoin_y (n : ℕ) :
    jacobianToAdjoin K n (J.y K n) = A.y K n := by
  simp [jacobianToAdjoin, J.y, J.quotientAlgHom]

/-! ## The map from `AdjoinRoot` to the bivariate quotient -/

/-- Evaluate the coefficient polynomial variable at the first bivariate
quotient coordinate. -/
def coefficientToJacobian (n : ℕ) : K[X] →ₐ[K] J.Ring K n :=
  Polynomial.aeval (J.x K n)

@[simp]
theorem coefficientToJacobian_X (n : ℕ) :
    coefficientToJacobian K n X = J.x K n := by
  simp [coefficientToJacobian]

@[simp]
theorem coefficientToJacobian_boundary (n : ℕ) :
    coefficientToJacobian K n
        (ConcreteFermatIrreducibility.boundaryPolynomial K n) =
      1 - J.x K n ^ n := by
  simp [coefficientToJacobian,
    ConcreteFermatIrreducibility.boundaryPolynomial]

/-- The quotient coordinates satisfy the affine Fermat equation. -/
theorem jacobian_fermat_equation (n : ℕ) :
    J.x K n ^ n + J.y K n ^ n = 1 := by
  have h := ConcreteAffineFermatJacobian.fermatRelation_quotient_eq_zero K n
  change J.quotientAlgHom K n
    (ConcreteAffineFermatJacobian.fermatRelation K n) = 0 at h
  simpa [ConcreteAffineFermatJacobian.fermatRelation,
    ConcreteAffineFermatJacobian.fermatX,
    ConcreteAffineFermatJacobian.fermatY, J.x, J.y,
    map_add, map_sub, map_pow] using sub_eq_zero.mp h

/-- The second quotient coordinate is a root of the univariate Fermat
polynomial after evaluating its coefficient variable at the first
coordinate. -/
theorem fermatPolynomial_eval₂_jacobian_eq_zero (n : ℕ) :
    (A.Polynomial K n).eval₂ (coefficientToJacobian K n) (J.y K n) = 0 := by
  rw [A.Polynomial, ConcreteFermatIrreducibility.fermatPolynomial,
    eval₂_sub, eval₂_X_pow, eval₂_C]
  change J.y K n ^ n -
    coefficientToJacobian K n
      (ConcreteFermatIrreducibility.boundaryPolynomial K n) = 0
  rw [coefficientToJacobian_boundary]
  apply sub_eq_zero.mpr
  linear_combination jacobian_fermat_equation K n

/-- The universal property of `AdjoinRoot` gives the reverse map. -/
def adjoinToJacobian (n : ℕ) : A.Ring K n →ₐ[K] J.Ring K n :=
  AdjoinRoot.liftAlgHom (A.Polynomial K n) (coefficientToJacobian K n)
    (J.y K n) (fermatPolynomial_eval₂_jacobian_eq_zero K n)

@[simp]
theorem adjoinToJacobian_x (n : ℕ) :
    adjoinToJacobian K n (A.x K n) = J.x K n := by
  simp [adjoinToJacobian, A.x, ConcreteFermatOpenRing.affineX,
    coefficientToJacobian]

@[simp]
theorem adjoinToJacobian_y (n : ℕ) :
    adjoinToJacobian K n (A.y K n) = J.y K n := by
  simp [adjoinToJacobian, A.y, ConcreteFermatOpenRing.affineY]

/-! ## The two universal maps are inverse -/

/-- Evaluating into `AdjoinRoot` after applying the reverse universal map is
the identity.  The proof checks the coefficient variable and the adjoined
root separately. -/
theorem jacobianToAdjoin_comp_adjoinToJacobian (n : ℕ) :
    (jacobianToAdjoin K n).comp (adjoinToJacobian K n) =
      AlgHom.id K (A.Ring K n) := by
  apply AdjoinRoot.algHom_ext'
  · apply Polynomial.algHom_ext
    change jacobianToAdjoin K n (adjoinToJacobian K n (A.x K n)) = A.x K n
    rw [adjoinToJacobian_x, jacobianToAdjoin_x]
  · change jacobianToAdjoin K n (adjoinToJacobian K n (A.y K n)) = A.y K n
    rw [adjoinToJacobian_y, jacobianToAdjoin_y]

/-- Applying the reverse universal map after bivariate evaluation is the
identity.  It is enough to check the two bivariate generators before passing
to the quotient. -/
theorem adjoinToJacobian_comp_jacobianToAdjoin (n : ℕ) :
    (adjoinToJacobian K n).comp (jacobianToAdjoin K n) =
      AlgHom.id K (J.Ring K n) := by
  apply Ideal.Quotient.algHom_ext K
  apply MvPolynomial.algHom_ext
  intro i
  fin_cases i
  · change adjoinToJacobian K n (jacobianToAdjoin K n (J.x K n)) = J.x K n
    rw [jacobianToAdjoin_x, adjoinToJacobian_x]
  · change adjoinToJacobian K n (jacobianToAdjoin K n (J.y K n)) = J.y K n
    rw [jacobianToAdjoin_y, adjoinToJacobian_y]

/-- The explicit `K`-algebra equivalence between the two affine Fermat
presentations. -/
def fermatAffinePresentationEquiv (n : ℕ) :
    J.Ring K n ≃ₐ[K] A.Ring K n :=
  AlgEquiv.ofAlgHom (jacobianToAdjoin K n) (adjoinToJacobian K n)
    (jacobianToAdjoin_comp_adjoinToJacobian K n)
    (adjoinToJacobian_comp_jacobianToAdjoin K n)

@[simp]
theorem fermatAffinePresentationEquiv_apply_x (n : ℕ) :
    fermatAffinePresentationEquiv K n (J.x K n) = A.x K n :=
  jacobianToAdjoin_x K n

@[simp]
theorem fermatAffinePresentationEquiv_apply_y (n : ℕ) :
    fermatAffinePresentationEquiv K n (J.y K n) = A.y K n :=
  jacobianToAdjoin_y K n

/-! ## Transport of affine smoothness -/

/-- The `AdjoinRoot` affine Fermat presentation is smooth over a
characteristic-zero field. -/
theorem fermatAffineRing_smooth
    [CharZero K] {n : ℕ} (hn : 0 < n) :
    Algebra.Smooth K (A.Ring K n) := by
  letI : Algebra.Smooth K (J.Ring K n) :=
    ConcreteAffineFermatJacobian.fermatJacobianRing_smooth K hn
  exact Algebra.Smooth.of_equiv (fermatAffinePresentationEquiv K n)

/-- Localizing the smooth affine Fermat ring at the honest boundary element
preserves smoothness over `K`. -/
theorem fermatOpenRing_smooth
    [CharZero K] {n : ℕ} (hn : 0 < n) :
    Algebra.Smooth K (ConcreteFermatOpenRing.FermatOpenRing K n) := by
  letI : Algebra.Smooth K (A.Ring K n) := fermatAffineRing_smooth K hn
  letI : Algebra.Smooth (A.Ring K n)
      (ConcreteFermatOpenRing.FermatOpenRing K n) :=
    Algebra.Smooth.of_isLocalization_Away
      (ConcreteFermatOpenRing.affineBoundary K n)
  exact Algebra.Smooth.comp K (A.Ring K n)
    (ConcreteFermatOpenRing.FermatOpenRing K n)

end

end ConcreteFermatPresentationEquiv
end IUTThreeClosures
