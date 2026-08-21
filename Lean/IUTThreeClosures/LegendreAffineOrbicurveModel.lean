import Mathlib

/-!
# The affine Legendre curve and its sign involution

For a field `k` and `λ : k`, the affine equation

`y² = x (x - 1) (x - λ)`

is the once-punctured Legendre elliptic curve: the omitted point is the point
at infinity. This module constructs its coordinate relation in the genuine
polynomial ring `k[x,y]` and the algebraic involution `(x,y) ↦ (x,-y)` that
underlies the `±1` quotient.

This is the first concrete algebraic layer of the orbicurve route. It does
not yet construct the quotient stack, its hyperbolic core, or its étale and
tempered fundamental groups.
-/

namespace IUTThreeClosures
namespace LegendreAffine

universe u

/-- The two affine coordinates. -/
inductive Coord
  | x
  | y
  deriving DecidableEq, Fintype

variable {k : Type u} [Field k]

open MvPolynomial

/-- The Legendre equation as a polynomial relation in `k[x,y]`. -/
noncomputable def relation (λ : k) : MvPolynomial Coord k :=
  X Coord.y ^ 2 - X Coord.x * (X Coord.x - 1) * (X Coord.x - C λ)

/-- The principal ideal cutting out the affine Legendre curve. -/
noncomputable def ideal (λ : k) : Ideal (MvPolynomial Coord k) :=
  Ideal.span {relation λ}

/-- The affine coordinate ring of the once-punctured Legendre curve. -/
abbrev CoordinateRing (λ : k) :=
  MvPolynomial Coord k ⧸ ideal λ

/-- The polynomial-ring involution induced by `(x,y) ↦ (x,-y)`. -/
noncomputable def negYHom :
    MvPolynomial Coord k →+* MvPolynomial Coord k :=
  MvPolynomial.eval₂Hom (RingHom.id k)
    (fun
      | Coord.x => X Coord.x
      | Coord.y => -X Coord.y)

@[simp]
theorem negYHom_X_x :
    negYHom (k := k) (X Coord.x) = X Coord.x := by
  simp [negYHom]

@[simp]
theorem negYHom_X_y :
    negYHom (k := k) (X Coord.y) = -X Coord.y := by
  simp [negYHom]

@[simp]
theorem negYHom_C (a : k) :
    negYHom (k := k) (C a) = C a := by
  simp [negYHom]

/-- The defining equation is invariant under the sign involution. -/
@[simp]
theorem negYHom_relation (λ : k) :
    negYHom (k := k) (relation λ) = relation λ := by
  simp [negYHom, relation]
  ring

/-- Applying the sign substitution twice is the identity. -/
theorem negYHom_involutive :
    Function.Involutive (negYHom (k := k)) := by
  intro f
  induction f using MvPolynomial.induction_on with
  | C a => simp
  | add p q hp hq => simp [map_add, hp, hq]
  | monomial p a hp =>
      simp only [map_monomial, map_id, hp]
      congr 1
      ext i
      cases i <;> simp [negYHom]

/-- The sign substitution is a ring automorphism of the polynomial ring. -/
noncomputable def negYEquiv :
    MvPolynomial Coord k ≃+* MvPolynomial Coord k where
  toFun := negYHom
  invFun := negYHom
  left_inv := negYHom_involutive
  right_inv := negYHom_involutive
  map_mul' := map_mul _
  map_add' := map_add _

/-- The defining principal ideal is stable under the sign automorphism. -/
theorem negYEquiv_ideal (λ : k) :
    Ideal.map (negYEquiv (k := k)).toRingHom (ideal λ) = ideal λ := by
  apply le_antisymm
  · rw [Ideal.map_le_iff_le_comap]
    intro f hf
    rw [Ideal.mem_comap]
    rcases (Ideal.mem_span_singleton.mp hf) with ⟨g, rfl⟩
    rw [map_mul, negYEquiv]
    exact Ideal.mul_mem_left _ _
      (Ideal.subset_span (by simp))
  · rw [← (negYEquiv (k := k)).symm_symm]
    have h := Ideal.map_mono (f := (negYEquiv (k := k)).symm.toRingHom)
      (show ideal λ ≤ ideal λ from le_rfl)
    simpa [negYEquiv] using h

/-- The sign involution descends to the affine coordinate ring. -/
noncomputable def coordinateNegYHom (λ : k) :
    CoordinateRing λ →+* CoordinateRing λ :=
  Ideal.Quotient.map (ideal λ) (ideal λ) (negYHom (k := k)) (by
    rw [← Ideal.map_le_iff_le_comap]
    simpa [negYEquiv] using negYEquiv_ideal (k := k) λ)

@[simp]
theorem coordinateNegYHom_mk (λ : k) (f : MvPolynomial Coord k) :
    coordinateNegYHom λ (Ideal.Quotient.mk (ideal λ) f) =
      Ideal.Quotient.mk (ideal λ) (negYHom (k := k) f) := by
  rfl

/-- The descended coordinate-ring endomorphism is involutive. -/
theorem coordinateNegYHom_involutive (λ : k) :
    Function.Involutive (coordinateNegYHom λ) := by
  intro z
  refine Quotient.inductionOn' z ?_
  intro f
  simp [coordinateNegYHom, negYHom_involutive (k := k) f]

/-- The genuine algebraic sign involution on the affine Legendre coordinate
ring. -/
noncomputable def coordinateNegYEquiv (λ : k) :
    CoordinateRing λ ≃+* CoordinateRing λ where
  toFun := coordinateNegYHom λ
  invFun := coordinateNegYHom λ
  left_inv := coordinateNegYHom_involutive λ
  right_inv := coordinateNegYHom_involutive λ
  map_mul' := map_mul _
  map_add' := map_add _

end LegendreAffine
end IUTThreeClosures
