/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SymmetricTransverseKernel

/-!
# Regrouping the product Weil pairing

An element of `E[ell]^2` is naturally written as two symplectic coordinate
pairs `((a₁,b₁),(a₂,b₂))`.  The transverse-graph construction regroups these
coordinates as `((a₁,a₂),(b₁,b₂))`.  Under this regrouping, the direct sum of
the two elliptic alternating forms is exactly the cross form used by
`SymmetricTransverseKernel`.

This resolves the coordinate audit: a symmetric graph is isotropic for the
actual product polarization, and a diagonal two-copy Tate line becomes a
scalar graph in the regrouped coordinates.
-/

namespace IUTThreeClosures

universe u

variable {F : Type u} [CommRing F]

/-- The standard alternating pairing on one elliptic two-coordinate module. -/
def ellipticAlternatingPairing (x y : F × F) : F :=
  x.1 * y.2 - x.2 * y.1

/-- The direct-sum pairing on two elliptic copies. -/
def ellipticProductPairing
    (x y : (F × F) × (F × F)) : F :=
  ellipticAlternatingPairing x.1 y.1 +
    ellipticAlternatingPairing x.2 y.2

/-- Regroup from elliptic-copy coordinates to first/second symplectic
coordinates across both copies. -/
def regroupEllipticCoordinates
    (x : (F × F) × (F × F)) :
    (F × F) × (F × F) :=
  ((x.1.1, x.2.1), (x.1.2, x.2.2))

/-- The product Weil pairing is the cross pairing after regrouping. -/
theorem ellipticProductPairing_eq_regrouped_cross
    (x y : (F × F) × (F × F)) :
    ellipticProductPairing x y =
      productSymplecticPairing
        (regroupEllipticCoordinates x)
        (regroupEllipticCoordinates y) := by
  rcases x with ⟨⟨a₁, b₁⟩, ⟨a₂, b₂⟩⟩
  rcases y with ⟨⟨a₁', b₁'⟩, ⟨a₂', b₂'⟩⟩
  simp [ellipticProductPairing, ellipticAlternatingPairing,
    regroupEllipticCoordinates, productSymplecticPairing]
  ring

/-- A diagonal two-copy line of finite slope in elliptic-copy coordinates. -/
def ellipticDiagonalSlopePoint
    (lambda : F) (a : F × F) :
    (F × F) × (F × F) :=
  ((a.1, lambda * a.1),
    (a.2, lambda * a.2))

/-- After regrouping, a diagonal two-copy Tate line is exactly a scalar graph. -/
theorem regroup_ellipticDiagonalSlopePoint
    (lambda : F) (a : F × F) :
    regroupEllipticCoordinates
        (ellipticDiagonalSlopePoint lambda a) =
      scalarDiagonalPoint lambda a := by
  rcases a with ⟨a₁, a₂⟩
  rfl

/-- A symmetric transverse graph is isotropic for the direct product pairing
when converted back to elliptic-copy coordinates. -/
theorem symmetricGraph_isotropic_for_ellipticProduct
    (a b : F) (x y : F × F) :
    let gx := symmetricTransverseGraphPoint a b x
    let gy := symmetricTransverseGraphPoint a b y
    ellipticProductPairing
      ((gx.1.1, gx.2.1), (gx.1.2, gx.2.2))
      ((gy.1.1, gy.2.1), (gy.1.2, gy.2.2)) = 0 := by
  dsimp
  rw [ellipticProductPairing_eq_regrouped_cross]
  change productSymplecticPairing
      (symmetricTransverseGraphPoint a b x)
      (symmetricTransverseGraphPoint a b y) = 0
  exact symmetricGraph_isotropic a b x y

end IUTThreeClosures
