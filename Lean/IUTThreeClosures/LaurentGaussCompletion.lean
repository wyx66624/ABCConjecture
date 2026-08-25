/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LaurentGaussPointOrbit
import Mathlib.Analysis.Normed.Module.Completion
import Mathlib.Analysis.Normed.Ring.WithAbs

/-!
# Completion of the Laurent Gauss norm

For a positive radius `r`, this file equips the Laurent polynomial ring with
the actual Laurent Gauss norm constructed in `LaurentGaussPointOrbit` and
takes its separated uniform completion.  The radius is retained in the type
through `WithAbs`, so completions at different radii are not conflated by a
local choice of normed-ring instance.

The substitution `T ↦ qT` is an isometry from the `‖q‖ r` norm to the `r`
norm.  It therefore extends to an isometric `K`-algebra equivalence of the
corresponding completions.

This is a genuine complete normed algebra obtained from the one-radius
Laurent Gauss norm.  We do not identify it with a coefficient-series model or
a named Tate/annulus algebra, and do not construct a Berkovich/adic spectrum,
an analytic quotient, or a tempered fundamental group.
-/

noncomputable section

open scoped LaurentPolynomial

namespace IUTThreeClosures
namespace LaurentGaussCompletion

open LaurentGaussPointOrbit LaurentPolynomial
open UniformSpace

variable {K : Type*} [NormedField K] [IsUltrametricDist K]

/-! ## The radius-tagged normed algebra and its completion -/

/-- The Laurent polynomial ring tagged by its radius-`r` Laurent Gauss
absolute value. -/
abbrev LaurentGaussNormedRing (r : ℝ) (hr : 0 < r) :=
  WithAbs (laurentGaussPoint (K := K) r hr)

/-- The separated uniform completion of the radius-`r` Laurent Gauss norm. -/
abbrev LaurentGaussCompletedRing (r : ℝ) (hr : 0 < r) :=
  UniformSpace.Completion (LaurentGaussNormedRing (K := K) r hr)

/-- The Laurent Gauss norm is exactly compatible with scalar multiplication
by `K`. -/
theorem norm_smul_eq (r : ℝ) (hr : 0 < r) (a : K)
    (f : LaurentGaussNormedRing (K := K) r hr) :
    ‖a • f‖ = ‖a‖ * ‖f‖ := by
  change laurentGaussPoint r hr (a • f.ofAbs) =
    ‖a‖ * laurentGaussPoint r hr f.ofAbs
  rw [Algebra.smul_def, map_mul, LaurentPolynomial.algebraMap_apply,
    Algebra.algebraMap_self, RingHom.id_apply, laurentGaussPoint_C]

/-- The tagged ring retains commutativity together with the Laurent Gauss
norm. -/
instance normedCommRing (r : ℝ) (hr : 0 < r) :
    NormedCommRing (LaurentGaussNormedRing (K := K) r hr) where
  __ : CommRing (LaurentGaussNormedRing (K := K) r hr) := inferInstance
  __ : NormedRing (LaurentGaussNormedRing (K := K) r hr) := inferInstance

/-- The radius-tagged norm is exactly multiplicative, not merely
submultiplicative. -/
instance normMulClass (r : ℝ) (hr : 0 < r) :
    NormMulClass (LaurentGaussNormedRing (K := K) r hr) where
  norm_mul f g := by
    change laurentGaussPoint r hr (f.ofAbs * g.ofAbs) =
      laurentGaussPoint r hr f.ofAbs * laurentGaussPoint r hr g.ofAbs
    exact map_mul (laurentGaussPoint r hr) f.ofAbs g.ofAbs

/-- The unit has Laurent Gauss norm one. -/
instance normOneClass (r : ℝ) (hr : 0 < r) :
    NormOneClass (LaurentGaussNormedRing (K := K) r hr) where
  norm_one := by
    change laurentGaussPoint r hr 1 = 1
    exact map_one (laurentGaussPoint r hr)

/-- The radius-tagged Laurent Gauss ring is a normed `K`-algebra. -/
instance normedAlgebra (r : ℝ) (hr : 0 < r) :
    NormedAlgebra K (LaurentGaussNormedRing (K := K) r hr) where
  norm_smul_le a f := (norm_smul_eq r hr a f).le

/-- Exact multiplicativity survives passage to the Laurent Gauss
completion. -/
theorem norm_mul_completed (r : ℝ) (hr : 0 < r)
    (x y : LaurentGaussCompletedRing (K := K) r hr) :
    ‖x * y‖ = ‖x‖ * ‖y‖ := by
  induction x, y using UniformSpace.Completion.induction_on₂ with
  | hp => exact isClosed_eq (by fun_prop) (by fun_prop)
  | ih f g =>
      simpa only [← UniformSpace.Completion.coe_mul,
        UniformSpace.Completion.norm_coe] using norm_mul f g

/-- The completed Laurent Gauss norm remains exactly multiplicative. -/
instance completedNormMulClass (r : ℝ) (hr : 0 < r) :
    NormMulClass (LaurentGaussCompletedRing (K := K) r hr) where
  norm_mul := norm_mul_completed r hr

/-- The unit of the completion has norm one. -/
instance completedNormOneClass (r : ℝ) (hr : 0 < r) :
    NormOneClass (LaurentGaussCompletedRing (K := K) r hr) where
  norm_one := by
    rw [← UniformSpace.Completion.coe_one,
      UniformSpace.Completion.norm_coe, norm_one]

/-- The canonical map from finite Laurent polynomials into their Laurent
Gauss completion. -/
def toCompletion (r : ℝ) (hr : 0 < r) :
    K[T;T⁻¹] →+* LaurentGaussCompletedRing (K := K) r hr :=
  UniformSpace.Completion.coeRingHom.comp
    (WithAbs.equiv (laurentGaussPoint (K := K) r hr)).symm.toRingHom

/-- The canonical completion map as a `K`-algebra homomorphism. -/
def toCompletionAlgHom (r : ℝ) (hr : 0 < r) :
    K[T;T⁻¹] →ₐ[K] LaurentGaussCompletedRing (K := K) r hr where
  toRingHom := toCompletion r hr
  commutes' a := by
    change
      ((WithAbs.toAbs (laurentGaussPoint (K := K) r hr)
          (algebraMap K K[T;T⁻¹] a) :
        LaurentGaussNormedRing (K := K) r hr) :
        LaurentGaussCompletedRing (K := K) r hr) =
      ((algebraMap K (LaurentGaussNormedRing (K := K) r hr) a :
        LaurentGaussNormedRing (K := K) r hr) :
        LaurentGaussCompletedRing (K := K) r hr)
    congr 1

@[simp]
theorem toCompletionAlgHom_apply (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) :
    toCompletionAlgHom r hr f = toCompletion r hr f :=
  rfl

@[simp]
theorem toCompletion_apply (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) :
    toCompletion r hr f =
      ((WithAbs.toAbs (laurentGaussPoint (K := K) r hr) f :
          LaurentGaussNormedRing (K := K) r hr) :
        LaurentGaussCompletedRing (K := K) r hr) :=
  rfl

/-- The completion map preserves the Laurent Gauss norm exactly. -/
@[simp]
theorem norm_toCompletion (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) :
    ‖toCompletion r hr f‖ = laurentGaussPoint r hr f := by
  rw [toCompletion_apply, UniformSpace.Completion.norm_coe,
    WithAbs.norm_toAbs_eq]

/-- Finite Laurent polynomials embed injectively into the completion. -/
theorem toCompletion_injective (r : ℝ) (hr : 0 < r) :
    Function.Injective (toCompletion (K := K) r hr) := by
  intro f g hfg
  apply WithAbs.toAbs_injective (laurentGaussPoint (K := K) r hr)
  apply UniformSpace.Completion.coe_injective
  exact hfg

/-- Finite Laurent polynomials have dense image in the completion. -/
theorem toCompletion_denseRange (r : ℝ) (hr : 0 < r) :
    DenseRange (toCompletion (K := K) r hr) := by
  change DenseRange
    (((↑) : LaurentGaussNormedRing (K := K) r hr →
        LaurentGaussCompletedRing (K := K) r hr) ∘
      WithAbs.toAbs (laurentGaussPoint (K := K) r hr))
  exact UniformSpace.Completion.denseRange_coe.comp
    (WithAbs.toAbs_surjective
      (laurentGaussPoint (K := K) r hr)).denseRange
    (UniformSpace.Completion.continuous_coe _)

/-- The completed Laurent variable has norm exactly `r^n`. -/
@[simp]
theorem norm_toCompletion_T (r : ℝ) (hr : 0 < r) (n : ℤ) :
    ‖toCompletion r hr (LaurentPolynomial.T n : K[T;T⁻¹])‖ = r ^ n := by
  rw [norm_toCompletion, laurentGaussPoint_T]

/-- Constants retain their original field norm in the completion. -/
@[simp]
theorem norm_toCompletion_C (r : ℝ) (hr : 0 < r) (a : K) :
    ‖toCompletion r hr (LaurentPolynomial.C a)‖ = ‖a‖ := by
  rw [norm_toCompletion, laurentGaussPoint_C]

/-! ## Radius-changing scaling before completion -/

/-- Substitution `T ↦ qT`, regarded as a ring equivalence from the
`‖q‖ r`-normed Laurent ring to the `r`-normed Laurent ring. -/
def scaleWithAbs (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    LaurentGaussNormedRing (K := K) (‖q‖ * r)
        (mul_pos (norm_pos_iff.mpr hq) hr) ≃+*
      LaurentGaussNormedRing (K := K) r hr :=
  WithAbs.congr
    (laurentGaussPoint (K := K) (‖q‖ * r)
      (mul_pos (norm_pos_iff.mpr hq) hr))
    (laurentGaussPoint (K := K) r hr)
    (laurentVariableScale q hq).toRingEquiv

@[simp]
theorem scaleWithAbs_apply (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r)
    (f : LaurentGaussNormedRing (K := K) (‖q‖ * r)
      (mul_pos (norm_pos_iff.mpr hq) hr)) :
    scaleWithAbs q hq r hr f =
      WithAbs.toAbs (laurentGaussPoint (K := K) r hr)
        (laurentVariableScale q hq f.ofAbs) :=
  rfl

/-- Laurent covariance says exactly that radius-changing substitution
preserves the norm. -/
@[simp]
theorem norm_scaleWithAbs (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r)
    (f : LaurentGaussNormedRing (K := K) (‖q‖ * r)
      (mul_pos (norm_pos_iff.mpr hq) hr)) :
    ‖scaleWithAbs q hq r hr f‖ = ‖f‖ := by
  change laurentGaussPoint r hr (laurentVariableScale q hq f.ofAbs) =
    laurentGaussPoint (‖q‖ * r)
      (mul_pos (norm_pos_iff.mpr hq) hr) f.ofAbs
  exact laurentGaussPoint_variableScale q hq r hr f.ofAbs

/-- Radius-changing substitution is an isometry on finite Laurent
polynomials. -/
theorem scaleWithAbs_isometry (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    Isometry (scaleWithAbs q hq r hr) :=
  AddMonoidHomClass.isometry_of_norm (scaleWithAbs q hq r hr)
    (norm_scaleWithAbs q hq r hr)

/-- The inverse radius-changing substitution is also an isometry. -/
theorem scaleWithAbs_symm_isometry
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    Isometry (scaleWithAbs q hq r hr).symm :=
  (scaleWithAbs_isometry q hq r hr).right_inv
    (scaleWithAbs q hq r hr).right_inv

@[simp]
theorem scaleWithAbs_algebraMap
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) (a : K) :
    scaleWithAbs q hq r hr
        (algebraMap K
          (LaurentGaussNormedRing (K := K) (‖q‖ * r)
            (mul_pos (norm_pos_iff.mpr hq) hr)) a) =
      algebraMap K (LaurentGaussNormedRing (K := K) r hr) a := by
  apply WithAbs.ofAbs_injective (laurentGaussPoint (K := K) r hr)
  simp [scaleWithAbs, WithAbs.algebraMap_right_apply]

/-! ## The extended isometric equivalence of completions -/

/-- The ring equivalence induced on the two Laurent Gauss completions. -/
def scaleCompletionRingEquiv
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    LaurentGaussCompletedRing (K := K) (‖q‖ * r)
        (mul_pos (norm_pos_iff.mpr hq) hr) ≃+*
      LaurentGaussCompletedRing (K := K) r hr :=
  UniformSpace.Completion.mapRingEquiv
    (scaleWithAbs q hq r hr)
    (scaleWithAbs_isometry q hq r hr).continuous
    (scaleWithAbs_symm_isometry q hq r hr).continuous

@[simp]
theorem scaleCompletionRingEquiv_coe
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r)
    (f : LaurentGaussNormedRing (K := K) (‖q‖ * r)
      (mul_pos (norm_pos_iff.mpr hq) hr)) :
    scaleCompletionRingEquiv q hq r hr
        (f : LaurentGaussCompletedRing (K := K) (‖q‖ * r)
          (mul_pos (norm_pos_iff.mpr hq) hr)) =
      ((scaleWithAbs q hq r hr f : LaurentGaussNormedRing (K := K) r hr) :
        LaurentGaussCompletedRing (K := K) r hr) := by
  exact UniformSpace.Completion.mapRingHom_coe
    (scaleWithAbs_isometry q hq r hr).continuous f

/-- The completed ring equivalence still preserves all distances. -/
theorem scaleCompletionRingEquiv_isometry
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    Isometry (scaleCompletionRingEquiv q hq r hr) :=
  (scaleWithAbs_isometry q hq r hr).isometry_mapRingHom

/-- The completed radius-changing map as a `K`-algebra equivalence. -/
def scaleCompletion
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    LaurentGaussCompletedRing (K := K) (‖q‖ * r)
        (mul_pos (norm_pos_iff.mpr hq) hr) ≃ₐ[K]
      LaurentGaussCompletedRing (K := K) r hr :=
  AlgEquiv.ofRingEquiv (f := scaleCompletionRingEquiv q hq r hr) fun a => by
    change scaleCompletionRingEquiv q hq r hr
        ((algebraMap K
          (LaurentGaussNormedRing (K := K) (‖q‖ * r)
            (mul_pos (norm_pos_iff.mpr hq) hr)) a :
          LaurentGaussNormedRing (K := K) (‖q‖ * r)
            (mul_pos (norm_pos_iff.mpr hq) hr)) :
          LaurentGaussCompletedRing (K := K) (‖q‖ * r)
            (mul_pos (norm_pos_iff.mpr hq) hr)) =
      ((algebraMap K (LaurentGaussNormedRing (K := K) r hr) a :
          LaurentGaussNormedRing (K := K) r hr) :
        LaurentGaussCompletedRing (K := K) r hr)
    rw [scaleCompletionRingEquiv_coe, scaleWithAbs_algebraMap]

/-- On the dense Laurent subalgebra, the completed map is exactly
substitution `T ↦ qT`. -/
@[simp]
theorem scaleCompletion_toCompletion
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) (f : K[T;T⁻¹]) :
    scaleCompletion q hq r hr
        (toCompletion (‖q‖ * r) (mul_pos (norm_pos_iff.mpr hq) hr) f) =
      toCompletion r hr (laurentVariableScale q hq f) := by
  change scaleCompletionRingEquiv q hq r hr
      ((WithAbs.toAbs
        (laurentGaussPoint (K := K) (‖q‖ * r)
          (mul_pos (norm_pos_iff.mpr hq) hr)) f :
        LaurentGaussNormedRing (K := K) (‖q‖ * r)
          (mul_pos (norm_pos_iff.mpr hq) hr)) :
        LaurentGaussCompletedRing (K := K) (‖q‖ * r)
          (mul_pos (norm_pos_iff.mpr hq) hr)) =
    ((WithAbs.toAbs (laurentGaussPoint (K := K) r hr)
      (laurentVariableScale q hq f) :
      LaurentGaussNormedRing (K := K) r hr) :
      LaurentGaussCompletedRing (K := K) r hr)
  rw [scaleCompletionRingEquiv_coe]
  rfl

/-- The completed `K`-algebra equivalence is an isometry. -/
theorem scaleCompletion_isometry
    (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    Isometry (scaleCompletion q hq r hr) :=
  scaleCompletionRingEquiv_isometry q hq r hr

end LaurentGaussCompletion
end IUTThreeClosures
