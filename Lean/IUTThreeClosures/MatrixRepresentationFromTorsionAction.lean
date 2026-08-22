/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Module.ZMod
import Mathlib.LinearAlgebra.Matrix.GeneralLinearGroup.Defs
import Mathlib.LinearAlgebra.StdBasis

/-!
# Matrix representations derived from torsion actions

The mod-`ell` matrix representation should not be independent data once the
actual Galois action on the torsion module and a torsion basis have been fixed.
This module performs that construction abstractly.

An additive equivalence of `ZMod ell`-modules is automatically linear.  Given
an actual action on a torsion module `T` and an additive basis

`T ≃+ (Fin 2 → ZMod ell)`,

we conjugate the action into the coordinate module and then use the canonical
multiplicative equivalence between invertible linear maps on the coordinate
module and `GL₂(ZMod ell)`.  The resulting matrix action is a monoid
homomorphism, its matrix-vector formula is a theorem, and its kernel is exactly
the kernel of the original torsion action.

Thus the `rep` and `rep_spec` fields of admissible-prime data can ultimately be
derived.  The genuinely arithmetic obligations that remain are construction of
the torsion basis, largeness of the image, and openness of the actual action
kernel.
-/

namespace IUTThreeClosures

universe u v

variable {ell : ℕ}

/-- Reinterpret an additive equivalence between `ZMod ell`-modules as a linear
equivalence. -/
def addEquivToZModLinearEquiv
    {M : Type u} {N : Type v}
    [AddCommGroup M] [AddCommGroup N]
    [Module (ZMod ell) M] [Module (ZMod ell) N]
    (e : M ≃+ N) : M ≃ₗ[ZMod ell] N where
  toFun := e
  invFun := e.symm
  map_add' := e.map_add
  map_smul' := ZMod.map_smul e
  left_inv := e.left_inv
  right_inv := e.right_inv

section Representation

variable {G : Type u} [Group G]
variable {T : Type v} [AddCommGroup T] [Module (ZMod ell) T]

/-- The coordinate module used for the two-dimensional torsion
representation. -/
abbrev TorsionCoordinates (ell : ℕ) := Fin 2 → ZMod ell

/-- Conjugate an actual linear action on `T` through a chosen additive torsion
basis. -/
noncomputable def coordinateLinearAction
    (basis : T ≃+ TorsionCoordinates ell)
    (action : G →* LinearMap.GeneralLinearGroup (ZMod ell) T) :
    G →* LinearMap.GeneralLinearGroup (ZMod ell) (TorsionCoordinates ell) :=
  (LinearMap.GeneralLinearGroup.congrLinearEquiv
      (addEquivToZModLinearEquiv basis)).toMonoidHom.comp action

/-- The canonical matrix representation associated to the actual torsion
action and the chosen basis. -/
noncomputable def matrixRepresentationFromAction
    (basis : T ≃+ TorsionCoordinates ell)
    (action : G →* LinearMap.GeneralLinearGroup (ZMod ell) T) :
    G →* Matrix.GeneralLinearGroup (Fin 2) (ZMod ell) :=
  (Matrix.GeneralLinearGroup.toLin
      (n := Fin 2) (R := ZMod ell)).symm.toMonoidHom.comp
    (coordinateLinearAction basis action)

/-- The derived representation acts on coordinate vectors by the genuine
action conjugated through the torsion basis. -/
theorem matrixRepresentationFromAction_mulVec
    (basis : T ≃+ TorsionCoordinates ell)
    (action : G →* LinearMap.GeneralLinearGroup (ZMod ell) T)
    (g : G) (x : TorsionCoordinates ell) :
    ((matrixRepresentationFromAction basis action g :
        Matrix (Fin 2) (Fin 2) (ZMod ell)).mulVec x) =
      basis ((action g).toLinearEquiv (basis.symm x)) := by
  let b : T ≃ₗ[ZMod ell] TorsionCoordinates ell :=
    addEquivToZModLinearEquiv basis
  have hcoord :
      (coordinateLinearAction basis action g).toLinearEquiv x =
        b ((action g).toLinearEquiv (b.symm x)) := by
    simp [coordinateLinearAction, b,
      LinearMap.GeneralLinearGroup.congrLinearEquiv_apply]
  have hmatrix :
      Matrix.GeneralLinearGroup.toLin
          (matrixRepresentationFromAction basis action g) =
        coordinateLinearAction basis action g := by
    simp [matrixRepresentationFromAction]
  calc
    ((matrixRepresentationFromAction basis action g :
        Matrix (Fin 2) (Fin 2) (ZMod ell)).mulVec x) =
        (Matrix.GeneralLinearGroup.toLin
          (matrixRepresentationFromAction basis action g)).toLinearEquiv x := by
      rfl
    _ = (coordinateLinearAction basis action g).toLinearEquiv x := by
      rw [hmatrix]
    _ = b ((action g).toLinearEquiv (b.symm x)) := hcoord
    _ = basis ((action g).toLinearEquiv (basis.symm x)) := rfl

/-- Conjugating the target and changing from linear maps to matrices does not
change the kernel. -/
theorem matrixRepresentationFromAction_ker
    (basis : T ≃+ TorsionCoordinates ell)
    (action : G →* LinearMap.GeneralLinearGroup (ZMod ell) T) :
    (matrixRepresentationFromAction basis action).ker = action.ker := by
  ext g
  simp [matrixRepresentationFromAction, coordinateLinearAction]

end Representation

end IUTThreeClosures
