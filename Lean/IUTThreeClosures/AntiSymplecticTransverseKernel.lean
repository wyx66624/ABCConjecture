/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SymmetricTransverseKernel

/-!
# Anti-symplectic universally transverse graph kernels

The product polarization on `E^2[ell]` is represented by the direct-sum
symplectic form, not by the cross form used for an abstract cotangent graph.
A graph kernel is isotropic for the product form exactly when its defining
operator is anti-symplectic.

This module gives the corrected companion operator

`T_t(x,y) = (y, x+t*y)`.

It preserves the negative of the standard symplectic form. If `t^2+4` is a
nonsquare, it has no ground-field eigenline, so its graph is transverse to
every diagonal copy of a scalar line and is isotropic for the actual product
pairing.

The module also records an explicit `ZMod 5` counterexample to interpreting
the previously constructed symmetric graph as isotropic for the product
polarization. The older cross-pairing theorem remains mathematically valid;
only that polarization interpretation is excluded.
-/

namespace IUTThreeClosures

universe u

variable {F : Type u} [Field F]

/-- The standard alternating form on `F^2`. -/
def standardAlternatingPairing (x y : F × F) : F :=
  x.1 * y.2 - x.2 * y.1

/-- The direct-sum pairing induced by the product polarization. -/
def productPolarizationPairing
    (x y : (F × F) × (F × F)) : F :=
  standardAlternatingPairing x.1 y.1 +
    standardAlternatingPairing x.2 y.2

/-- The determinant-minus-one companion operator. -/
def antiSymplecticCompanion (t : F) (z : F × F) : F × F :=
  (z.2, z.1 + t * z.2)

/-- The corrected companion reverses the standard alternating form. -/
theorem antiSymplecticCompanion_pairing
    (t : F) (x y : F × F) :
    standardAlternatingPairing
        (antiSymplecticCompanion t x)
        (antiSymplecticCompanion t y) =
      -standardAlternatingPairing x y := by
  rcases x with ⟨x₁, x₂⟩
  rcases y with ⟨y₁, y₂⟩
  simp [standardAlternatingPairing, antiSymplecticCompanion]
  ring

/-- A point in the graph of the corrected companion. -/
def antiSymplecticGraphPoint (t : F) (z : F × F) :
    (F × F) × (F × F) :=
  (z, antiSymplecticCompanion t z)

/-- The corrected graph is isotropic for the actual product polarization. -/
theorem antiSymplecticGraph_isotropic
    (t : F) (x y : F × F) :
    productPolarizationPairing
        (antiSymplecticGraphPoint t x)
        (antiSymplecticGraphPoint t y) = 0 := by
  rw [productPolarizationPairing]
  change standardAlternatingPairing x y +
      standardAlternatingPairing
        (antiSymplecticCompanion t x)
        (antiSymplecticCompanion t y) = 0
  rw [antiSymplecticCompanion_pairing]
  ring

/-- If `t^2+4` is a nonsquare, the corrected companion has no nonzero
vector with a ground-field eigenvalue. -/
theorem antiSymplecticCompanion_no_eigenvector
    {t lambda x y : F}
    (hchar : (2 : F) ≠ 0)
    (hdisc : ¬ ∃ z : F, z ^ 2 = t ^ 2 + 4)
    (h : antiSymplecticCompanion t (x, y) =
      (lambda * x, lambda * y)) :
    x = 0 ∧ y = 0 := by
  have h₁ : y = lambda * x := congrArg Prod.fst h
  have h₂ : x + t * y = lambda * y := congrArg Prod.snd h
  by_cases hx : x = 0
  · subst x
    simp at h₁
    exact ⟨rfl, h₁⟩
  · have hpoly_mul :
        (lambda ^ 2 - t * lambda - 1) * x = 0 := by
      rw [h₁] at h₂
      calc
        (lambda ^ 2 - t * lambda - 1) * x =
            lambda * (lambda * x) -
              (x + t * (lambda * x)) := by ring
        _ = 0 := sub_eq_zero.mpr h₂.symm
    have hpoly : lambda ^ 2 - t * lambda - 1 = 0 :=
      (mul_eq_zero.mp hpoly_mul).resolve_right hx
    have hsquare : (2 * lambda - t) ^ 2 = t ^ 2 + 4 := by
      calc
        (2 * lambda - t) ^ 2 - (t ^ 2 + 4) =
            4 * (lambda ^ 2 - t * lambda - 1) := by ring
        _ = 0 := by rw [hpoly, mul_zero]
      exact sub_eq_zero.mp this
    exact (hdisc ⟨2 * lambda - t, hsquare⟩).elim

/-- A point in the finite-slope diagonal two-copy subspace. -/
def productScalarDiagonalPoint (lambda : F) (z : F × F) :
    (F × F) × (F × F) :=
  (z, (lambda * z.1, lambda * z.2))

/-- The corrected graph meets every finite-slope diagonal only at zero. -/
theorem antiSymplecticGraph_inter_scalarDiagonal
    {t lambda : F} {z w : F × F}
    (hchar : (2 : F) ≠ 0)
    (hdisc : ¬ ∃ c : F, c ^ 2 = t ^ 2 + 4)
    (h : antiSymplecticGraphPoint t z =
      productScalarDiagonalPoint lambda w) :
    z = (0, 0) ∧ w = (0, 0) := by
  have hzw : z = w := congrArg Prod.fst h
  subst w
  have heig : antiSymplecticCompanion t z =
      (lambda * z.1, lambda * z.2) :=
    congrArg Prod.snd h
  rcases z with ⟨x, y⟩
  rcases antiSymplecticCompanion_no_eigenvector
      hchar hdisc heig with ⟨hx, hy⟩
  subst x
  subst y
  simp

/-- The corrected graph also meets the vertical diagonal only at zero. -/
theorem antiSymplecticGraph_inter_vertical
    {t : F} {z w : F × F}
    (h : antiSymplecticGraphPoint t z =
      ((0, 0), w)) :
    z = (0, 0) ∧ w = (0, 0) := by
  have hz : z = (0, 0) := congrArg Prod.fst h
  subst z
  have hw : antiSymplecticCompanion t (0, 0) = w :=
    congrArg Prod.snd h
  simp [antiSymplecticCompanion] at hw
  exact ⟨rfl, hw.symm⟩

/-! ## Explicit audit counterexample -/

/-- Over `ZMod 5`, the old symmetric universally transverse operator with
coefficients `(4,1)` is not isotropic for the product polarization. -/
theorem symmetricGraph_not_product_isotropic_ZMod5 :
    productPolarizationPairing
      (symmetricTransverseGraphPoint
        (4 : ZMod 5) 1 ((1, 0) : ZMod 5 × ZMod 5))
      (symmetricTransverseGraphPoint
        (4 : ZMod 5) 1 ((0, 1) : ZMod 5 × ZMod 5)) ≠ 0 := by
  norm_num [productPolarizationPairing, standardAlternatingPairing,
    symmetricTransverseGraphPoint, symmetricTransverseOperator]

end IUTThreeClosures
