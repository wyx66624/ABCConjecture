/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LaurentGaussCompletion
import Mathlib.Analysis.Normed.Unbundled.RingSeminorm
import Mathlib.Algebra.Group.Action.End
import Mathlib.Data.Int.Cast.Lemmas
import Mathlib.Topology.Homeomorph.Lemmas

/-!
# A bounded multiplicative-seminorm space for Laurent Gauss completions

This file constructs the pointwise topological space of multiplicative ring
seminorms on a normed `K`-algebra which extend the norm of `K` and are bounded
by the algebra norm.  Contractive algebra maps act contravariantly, and
isometric algebra equivalences induce homeomorphisms.

For the Laurent Gauss completion, the completed norm is a distinguished point,
and `T ↦ qT` induces a homeomorphism between the seminorm spaces at radii `r`
and `‖q‖ r`, carrying the norm point to the norm point.

The local Mathlib snapshot has no packaged `BerkovichSpectrum` API.  We
therefore use the honest underlying axioms and pointwise topology directly.
No compactness theorem, affinoid universal property, analytic orbit quotient,
adic identification, or tempered comparison is claimed.
-/

noncomputable section

open scoped LaurentPolynomial

namespace IUTThreeClosures
namespace LaurentGaussSeminormSpectrum

open LaurentGaussPointOrbit LaurentGaussCompletion LaurentPolynomial
open Topology

universe uK uA uB

variable (K : Type uK) (A : Type uA)
variable [NormedField K] [NormedRing A] [Algebra K A]

/-! ## The contractive multiplicative-seminorm space -/

/-- Multiplicative ring seminorms on `A` which extend the norm of `K` and are
pointwise bounded by the given norm on `A`.

Unlike an absolute value, a `MulRingSeminorm` is allowed to have a nonzero
kernel. -/
def BoundedKSeminorm :=
  { v : MulRingSeminorm A //
      (∀ a : K, v (algebraMap K A a) = ‖a‖) ∧
      ∀ x : A, v x ≤ ‖x‖ }

namespace BoundedKSeminorm

variable {K A}

instance instFunLike : FunLike (BoundedKSeminorm K A) A ℝ where
  coe v := v.1
  coe_injective v w h := by
    apply Subtype.ext
    exact MulRingSeminorm.ext fun x => congr_fun h x

@[ext]
theorem ext {v w : BoundedKSeminorm K A} (h : ∀ x, v x = w x) : v = w :=
  DFunLike.ext v w h

theorem restricts (v : BoundedKSeminorm K A) (a : K) :
    v (algebraMap K A a) = ‖a‖ :=
  v.2.1 a

theorem apply_le_norm (v : BoundedKSeminorm K A) (x : A) :
    v x ≤ ‖x‖ :=
  v.2.2 x

/-- The pointwise-convergence topology on bounded multiplicative seminorms. -/
instance instTopologicalSpace : TopologicalSpace (BoundedKSeminorm K A) :=
  TopologicalSpace.induced
    (fun v : BoundedKSeminorm K A => (v : A → ℝ)) Pi.topologicalSpace

/-- Evaluation at any algebra element is continuous for the pointwise
topology. -/
@[fun_prop]
theorem continuous_eval (x : A) :
    Continuous (fun v : BoundedKSeminorm K A => v x) :=
  (continuous_apply x).comp continuous_induced_dom

/-- The defining map to the product of real lines is a topological
embedding. -/
theorem isEmbedding_coe :
    IsEmbedding (fun v : BoundedKSeminorm K A => (v : A → ℝ)) :=
  ⟨.induced _, fun v w h => DFunLike.ext v w (congr_fun h)⟩

/-- The pointwise seminorm space is Hausdorff. -/
instance instT2Space : T2Space (BoundedKSeminorm K A) :=
  isEmbedding_coe.t2Space

variable {B : Type uB} [NormedRing B] [Algebra K B]

/-- Pull a bounded multiplicative seminorm back along a contractive
`K`-algebra homomorphism. -/
def pullback (φ : A →ₐ[K] B) (hφ : ∀ x : A, ‖φ x‖ ≤ ‖x‖)
    (v : BoundedKSeminorm K B) : BoundedKSeminorm K A where
  val :=
    { toFun := fun x => v (φ x)
      map_zero' := by
        change v.1 (φ 0) = 0
        rw [map_zero]
        exact v.1.map_zero'
      map_one' := by
        change v.1 (φ 1) = 1
        rw [map_one]
        exact v.1.map_one'
      add_le' := fun x y => by
        change v.1 (φ (x + y)) ≤ v.1 (φ x) + v.1 (φ y)
        rw [map_add]
        exact v.1.add_le' (φ x) (φ y)
      neg' := fun x => by
        change v.1 (φ (-x)) = v.1 (φ x)
        rw [map_neg]
        exact v.1.neg' (φ x)
      map_mul' := fun x y => by
        change v.1 (φ (x * y)) = v.1 (φ x) * v.1 (φ y)
        rw [map_mul]
        exact v.1.map_mul' (φ x) (φ y) }
  property := by
    constructor
    · intro a
      change v.1 (φ (algebraMap K A a)) = ‖a‖
      rw [φ.commutes]
      exact v.2.1 a
    · intro x
      change v.1 (φ x) ≤ ‖x‖
      exact (v.2.2 (φ x)).trans (hφ x)

@[simp]
theorem pullback_apply (φ : A →ₐ[K] B) (hφ : ∀ x : A, ‖φ x‖ ≤ ‖x‖)
    (v : BoundedKSeminorm K B) (x : A) :
    pullback φ hφ v x = v (φ x) :=
  rfl

/-- Pullback is continuous for the pointwise topologies. -/
theorem continuous_pullback (φ : A →ₐ[K] B)
    (hφ : ∀ x : A, ‖φ x‖ ≤ ‖x‖) :
    Continuous (pullback φ hφ :
      BoundedKSeminorm K B → BoundedKSeminorm K A) := by
  rw [continuous_induced_rng]
  exact continuous_pi fun x => continuous_eval (φ x)

/-- An isometric algebra equivalence gives a contravariant homeomorphism of
bounded multiplicative-seminorm spaces. -/
def pullbackHomeomorph (e : A ≃ₐ[K] B) (he : ∀ x : A, ‖e x‖ = ‖x‖) :
    BoundedKSeminorm K B ≃ₜ BoundedKSeminorm K A where
  toFun := pullback e.toAlgHom (fun x => (he x).le)
  invFun := pullback e.symm.toAlgHom fun y => by
    simpa using (he (e.symm y)).symm.le
  left_inv v := by
    ext y
    simp
  right_inv v := by
    ext x
    simp
  continuous_toFun := continuous_pullback e.toAlgHom (fun x => (he x).le)
  continuous_invFun := continuous_pullback e.symm.toAlgHom fun y => by
    simpa using (he (e.symm y)).symm.le

@[simp]
theorem pullbackHomeomorph_apply (e : A ≃ₐ[K] B)
    (he : ∀ x : A, ‖e x‖ = ‖x‖) (v : BoundedKSeminorm K B) (x : A) :
    pullbackHomeomorph e he v x = v (e x) :=
  rfl

/-! ## The norm point -/

variable [NormMulClass A] [NormOneClass A]

/-- Exact multiplicativity promotes the algebra norm to a multiplicative ring
seminorm. -/
def normMulRingSeminorm : MulRingSeminorm A where
  toFun := norm
  map_zero' := norm_zero
  map_one' := norm_one
  add_le' := norm_add_le
  neg' := norm_neg
  map_mul' := norm_mul

@[simp]
theorem normMulRingSeminorm_apply (x : A) :
    normMulRingSeminorm (A := A) x = ‖x‖ :=
  rfl

/-- The algebra norm as a point of the bounded seminorm space, assuming the
scalar embedding is isometric. -/
def normPoint (hK : ∀ a : K, ‖algebraMap K A a‖ = ‖a‖) :
    BoundedKSeminorm K A where
  val := normMulRingSeminorm
  property := ⟨hK, fun _ => le_rfl⟩

@[simp]
theorem normPoint_apply (hK : ∀ a : K, ‖algebraMap K A a‖ = ‖a‖)
    (x : A) :
    normPoint hK x = ‖x‖ :=
  rfl

end BoundedKSeminorm

/-! ## Application to Laurent Gauss completions -/

variable {K : Type uK} [NormedField K] [IsUltrametricDist K]

/-- Constants embed isometrically in every Laurent Gauss completion. -/
theorem norm_algebraMap_completed (r : ℝ) (hr : 0 < r) (a : K) :
    ‖algebraMap K (LaurentGaussCompletedRing (K := K) r hr) a‖ = ‖a‖ := by
  rw [← (toCompletionAlgHom (K := K) r hr).commutes a]
  change ‖toCompletion r hr (algebraMap K K[T;T⁻¹] a)‖ = ‖a‖
  rw [LaurentPolynomial.algebraMap_apply, Algebra.algebraMap_self,
    RingHom.id_apply, norm_toCompletion_C]

/-- The completed Laurent Gauss norm as a distinguished bounded
multiplicative-seminorm point. -/
def completedGaussPoint (r : ℝ) (hr : 0 < r) :
    BoundedKSeminorm K (LaurentGaussCompletedRing (K := K) r hr) :=
  BoundedKSeminorm.normPoint (norm_algebraMap_completed r hr)

@[simp]
theorem completedGaussPoint_apply (r : ℝ) (hr : 0 < r)
    (x : LaurentGaussCompletedRing (K := K) r hr) :
    completedGaussPoint r hr x = ‖x‖ :=
  rfl

@[simp]
theorem completedGaussPoint_T (r : ℝ) (hr : 0 < r) (n : ℤ) :
    completedGaussPoint r hr
        (toCompletion r hr (LaurentPolynomial.T n : K[T;T⁻¹])) = r ^ n := by
  rw [completedGaussPoint_apply, norm_toCompletion_T]

/-- Pullback along completed radial scaling, as a homeomorphism of honest
bounded multiplicative-seminorm spaces. -/
def scaleSpectrumHomeomorph
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    BoundedKSeminorm K (LaurentGaussCompletedRing (K := K) r hr) ≃ₜ
      BoundedKSeminorm K
        (LaurentGaussCompletedRing (K := K) (‖q‖ * r)
          (mul_pos (norm_pos_iff.mpr hq) hr)) :=
  BoundedKSeminorm.pullbackHomeomorph
    (scaleCompletion q hq r hr)
    (fun x => (scaleCompletion_isometry q hq r hr).norm_map_of_map_zero
      (map_zero (scaleCompletion q hq r hr)) x)

@[simp]
theorem scaleSpectrumHomeomorph_apply
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r)
    (v : BoundedKSeminorm K (LaurentGaussCompletedRing (K := K) r hr))
    (x : LaurentGaussCompletedRing (K := K) (‖q‖ * r)
      (mul_pos (norm_pos_iff.mpr hq) hr)) :
    scaleSpectrumHomeomorph q hq r hr v x =
      v (scaleCompletion q hq r hr x) :=
  rfl

/-- Radial pullback carries the completed Gauss norm point to the completed
Gauss norm point at the scaled radius. -/
theorem scaleSpectrumHomeomorph_gaussPoint
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    scaleSpectrumHomeomorph q hq r hr (completedGaussPoint r hr) =
      completedGaussPoint (‖q‖ * r)
        (mul_pos (norm_pos_iff.mpr hq) hr) := by
  ext x
  rw [scaleSpectrumHomeomorph_apply, completedGaussPoint_apply,
    completedGaussPoint_apply]
  exact (scaleCompletion_isometry q hq r hr).norm_map_of_map_zero
    (map_zero (scaleCompletion q hq r hr)) x

/-! ## The fixed-radius unit-norm `q^ℤ` action -/

/-- If `‖q‖ = 1`, radial pullback is a self-homeomorphism of the seminorm
space at radius `r`. -/
def unitNormScaleSpectrumHomeomorph
    (q : K) (hq : q ≠ 0) (hqnorm : ‖q‖ = 1) (r : ℝ) (hr : 0 < r) :
    BoundedKSeminorm K (LaurentGaussCompletedRing (K := K) r hr) ≃ₜ
      BoundedKSeminorm K (LaurentGaussCompletedRing (K := K) r hr) := by
  let s : Set.Ioi (0 : ℝ) :=
    ⟨‖q‖ * r, mul_pos (norm_pos_iff.mpr hq) hr⟩
  let t : Set.Ioi (0 : ℝ) := ⟨r, hr⟩
  let X (u : Set.Ioi (0 : ℝ)) :=
    BoundedKSeminorm K
      (LaurentGaussCompletedRing (K := K) u.1 u.2)
  have hst : s = t := by
    apply Subtype.ext
    simp only [s, t, hqnorm, one_mul]
  have e : X t ≃ₜ X s := scaleSpectrumHomeomorph q hq r hr
  rw [hst] at e
  exact e

/-- The integral powers of unit-norm radial pullback form an actual additive
`ℤ`-action on the fixed-radius bounded seminorm space.  This is an algebraic
action whose generator is the homeomorphism
`unitNormScaleSpectrumHomeomorph`; no orbit quotient is identified with an
analytic or tempered quotient. -/
@[reducible] def unitNormSpectrumZAction
    (q : K) (hq : q ≠ 0) (hqnorm : ‖q‖ = 1) (r : ℝ) (hr : 0 < r) :
    AddAction ℤ
      (BoundedKSeminorm K
        (LaurentGaussCompletedRing (K := K) r hr)) := by
  let X := BoundedKSeminorm K
    (LaurentGaussCompletedRing (K := K) r hr)
  let g : Equiv.Perm X :=
    (unitNormScaleSpectrumHomeomorph q hq hqnorm r hr).toEquiv
  letI : AddAction (Additive (Equiv.Perm X)) X := inferInstance
  exact AddAction.compHom X
    (zmultiplesHom (Additive (Equiv.Perm X)) (Additive.ofMul g))

/-- The element `1 : ℤ` acts by the unit-norm radial pullback
homeomorphism. -/
theorem unitNormSpectrumZAction_one_vadd
    (q : K) (hq : q ≠ 0) (hqnorm : ‖q‖ = 1) (r : ℝ) (hr : 0 < r)
    (v : BoundedKSeminorm K
      (LaurentGaussCompletedRing (K := K) r hr)) :
    letI := unitNormSpectrumZAction q hq hqnorm r hr
    (1 : ℤ) +ᵥ v = unitNormScaleSpectrumHomeomorph q hq hqnorm r hr v := by
  rfl

end LaurentGaussSeminormSpectrum
end IUTThreeClosures
