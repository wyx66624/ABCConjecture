import Mathlib.Analysis.Normed.Group.Ultra
import Mathlib.Analysis.Normed.Unbundled.RingSeminorm
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.RingTheory.Polynomial.GaussNorm
import Mathlib.Topology.ContinuousMap.Basic
import Mathlib.Topology.Instances.AddCircle.Defs

/-!
# Polynomial Gauss points and their radial scaling orbit

This file constructs an honest bundled multiplicative absolute value on
`K[X]` for every positive real radius over a nonarchimedean normed field.
It then computes exactly how variable scaling acts on these points and
identifies the quotient of the positive radius ray by `‖q‖^ℤ` with an
additive circle.

The scope is deliberately narrow.  These are the polynomial Gauss points of
the Berkovich affine line (and their nonzero-radius locus), not a construction
of the full Berkovich spectrum, a Laurent/Tate algebra, a rigid analytic
quotient, or a tempered skeleton comparison.
-/

noncomputable section

open Polynomial Set Topology

namespace IUTThreeClosures
namespace PolynomialGaussPointOrbit

variable {K : Type*} [NormedField K] [IsUltrametricDist K]

/-- The base-field norm as a bundled real-valued absolute value. -/
abbrev baseAbsoluteValue : AbsoluteValue K ℝ :=
  NormedField.toAbsoluteValue K

omit [IsUltrametricDist K] in
@[simp]
theorem baseAbsoluteValue_apply (x : K) :
    baseAbsoluteValue (K := K) x = ‖x‖ := by
  rfl

/-- The positive-radius polynomial Gauss absolute value. -/
def gaussPoint (r : ℝ) (hr : 0 < r) : AbsoluteValue K[X] ℝ :=
  (Polynomial.gaussNorm_isAbsoluteValue
    (v := baseAbsoluteValue (K := K))
    IsUltrametricDist.isNonarchimedean_norm hr).toAbsoluteValue

@[simp]
theorem gaussPoint_apply (r : ℝ) (hr : 0 < r) (p : K[X]) :
    gaussPoint r hr p = p.gaussNorm (baseAbsoluteValue (K := K)) r :=
  rfl

/-- A Gauss point restricts to the original absolute value on constants. -/
@[simp]
theorem gaussPoint_C (r : ℝ) (hr : 0 < r) (a : K) :
    gaussPoint r hr (C a) = ‖a‖ := by
  simp [gaussPoint]

/-- The value of the polynomial variable is exactly the radius. -/
@[simp]
theorem gaussPoint_X (r : ℝ) (hr : 0 < r) :
    gaussPoint r hr (X : K[X]) = r := by
  rw [← Polynomial.monomial_one_one_eq_X]
  simp [gaussPoint]

/-- The radius is recovered by evaluation at `X`, so distinct radii give
distinct bundled multiplicative absolute values. -/
theorem gaussPoint_injective :
    Function.Injective
      (fun r : Set.Ioi (0 : ℝ) => gaussPoint (K := K) r.1 r.2) := by
  intro r s hrs
  have hX := congrArg (fun v : AbsoluteValue K[X] ℝ => v (X : K[X])) hrs
  apply Subtype.ext
  exact (gaussPoint_X r.1 r.2).symm.trans (hX.trans (gaussPoint_X s.1 s.2))

/-- A positive-radius Gauss point is not evaluation at any `K`-rational
point: `X - x` separates the two multiplicative seminorms. -/
theorem gaussPoint_ne_rationalEvaluation (r : ℝ) (hr : 0 < r) (x : K) :
    ∃ p : K[X], gaussPoint r hr p ≠ ‖p.eval x‖ := by
  refine ⟨X - C x, ?_⟩
  have hp : (X - C x : K[X]) ≠ 0 := sub_ne_zero.mpr (Polynomial.X_ne_C x)
  have hpos : 0 < gaussPoint r hr (X - C x) :=
    (gaussPoint r hr).pos_iff.mpr hp
  simpa using hpos.ne'

/-! ## Variable scaling -/

/-- The `K`-algebra automorphism `p(X) ↦ p(qX)` for `q ≠ 0`. -/
def variableScale (q : K) (hq : q ≠ 0) : K[X] ≃ₐ[K] K[X] := by
  letI : Invertible q := invertibleOfNonzero hq
  exact Polynomial.algEquivCMulXAddC q 0

omit [IsUltrametricDist K] in
/-- The variable-scaling automorphism is substitution at `qX`. -/
@[simp]
theorem variableScale_apply (q : K) (hq : q ≠ 0) (p : K[X]) :
    variableScale q hq p = p.comp (C q * X) := by
  letI : Invertible q := invertibleOfNonzero hq
  simp [variableScale, Polynomial.comp_eq_aeval]

omit [IsUltrametricDist K] in
/-- Scaling by `q ≠ 0` does not change the coefficient support. -/
theorem support_variableScale (q : K) (hq : q ≠ 0) (p : K[X]) :
    (variableScale q hq p).support = p.support := by
  ext n
  simp [variableScale_apply, Polynomial.comp_C_mul_X_coeff, hq]

omit [IsUltrametricDist K] in
/-- Exact Gauss-norm covariance under variable scaling. -/
theorem gaussNorm_variableScale (q : K) (hq : q ≠ 0) (r : ℝ) (p : K[X]) :
    (variableScale q hq p).gaussNorm (baseAbsoluteValue (K := K)) r =
      p.gaussNorm (baseAbsoluteValue (K := K)) (‖q‖ * r) := by
  unfold Polynomial.gaussNorm
  rw [support_variableScale q hq p]
  by_cases hp : p.support.Nonempty
  · simp only [hp, dite_true]
    apply Finset.sup'_congr hp rfl
    intro n _hn
    rw [variableScale_apply, Polynomial.comp_C_mul_X_coeff]
    change ‖p.coeff n * q ^ n‖ * r ^ n = ‖p.coeff n‖ * (‖q‖ * r) ^ n
    rw [norm_mul, norm_pow, mul_pow]
    ring
  · simp [hp]

/-- Pull back a Gauss absolute value along the variable-scaling
automorphism. -/
def pullbackGaussPoint (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    AbsoluteValue K[X] ℝ :=
  (gaussPoint r hr).comp (variableScale q hq).injective

/-- Pullback by `X ↦ qX` sends radius `r` exactly to radius `‖q‖r`. -/
theorem gaussPoint_variableScale (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r)
    (p : K[X]) :
    gaussPoint r hr (variableScale q hq p) =
      gaussPoint (‖q‖ * r) (mul_pos (norm_pos_iff.mpr hq) hr) p := by
  exact gaussNorm_variableScale q hq r p

/-- Bundled form of exact covariance: the pullback point itself is the
Gauss point of radius `‖q‖r`. -/
theorem pullbackGaussPoint_eq (q : K) (hq : q ≠ 0) (r : ℝ) (hr : 0 < r) :
    pullbackGaussPoint q hq r hr =
      gaussPoint (‖q‖ * r) (mul_pos (norm_pos_iff.mpr hq) hr) := by
  ext p
  exact gaussPoint_variableScale q hq r hr p

/-! ## The positive radial orbit and its logarithmic circle -/

/-- The type of strictly positive real radii. -/
abbrev PositiveRadius := Set.Ioi (0 : ℝ)

/-- The positive additive period associated to a contraction factor `a`. -/
def radiusPeriod (a : ℝ) : ℝ := -Real.log a

theorem radiusPeriod_pos {a : ℝ} (ha : 0 < a) (ha1 : a < 1) :
    0 < radiusPeriod a := by
  exact neg_pos.mpr (Real.log_neg ha ha1)

/-- Logarithmic radius modulo the period generated by `a`. -/
def radiusCircleMap (a : ℝ) (r : PositiveRadius) : AddCircle (radiusPeriod a) :=
  ((Real.log r.1 : ℝ) : AddCircle (radiusPeriod a))

theorem continuous_radiusCircleMap (a : ℝ) :
    Continuous (radiusCircleMap a) :=
  (AddCircle.continuous_mk' (radiusPeriod a)).comp Real.continuous_log'

/-- Multiplication of the radius by `a` is one full turn of the logarithmic
circle. -/
@[simp]
theorem radiusCircleMap_scale (a : ℝ) (ha : 0 < a) (r : PositiveRadius) :
    radiusCircleMap a ⟨a * r.1, mul_pos ha r.2⟩ = radiusCircleMap a r := by
  change ((Real.log (a * r.1) : ℝ) : AddCircle (radiusPeriod a)) =
    ((Real.log r.1 : ℝ) : AddCircle (radiusPeriod a))
  rw [Real.log_mul ha.ne' r.2.ne', AddCircle.coe_add]
  have hperiod : ((Real.log a : ℝ) : AddCircle (radiusPeriod a)) = 0 := by
    rw [show Real.log a = -radiusPeriod a by simp [radiusPeriod], AddCircle.coe_neg,
      AddCircle.coe_period, neg_zero]
  rw [hperiod, zero_add]

/-- Exact fibres of the logarithmic circle coordinate: equality occurs
precisely along an integral multiplicative `a`-orbit. -/
theorem radiusCircleMap_eq_iff_zpow (a : ℝ) (ha : 0 < a)
    (r s : PositiveRadius) :
    radiusCircleMap a r = radiusCircleMap a s ↔
      ∃ n : ℤ, s.1 = a ^ n * r.1 := by
  constructor
  · intro hrs
    have hzero :
        (((Real.log r.1 - Real.log s.1 : ℝ)) : AddCircle (radiusPeriod a)) = 0 := by
      rw [AddCircle.coe_sub]
      exact sub_eq_zero.mpr hrs
    obtain ⟨n, hn⟩ :=
      (AddCircle.coe_eq_zero_iff (radiusPeriod a)).mp hzero
    have hn' : (n : ℝ) * (-Real.log a) = Real.log r.1 - Real.log s.1 := by
      simpa [radiusPeriod, zsmul_eq_mul] using hn
    refine ⟨n, Real.log_injOn_pos s.2 (mul_pos (zpow_pos ha n) r.2) ?_⟩
    rw [Real.log_mul (zpow_ne_zero n ha.ne') r.2.ne', Real.log_zpow]
    linarith
  · rintro ⟨n, hsr⟩
    apply sub_eq_zero.mp
    change
      (((Real.log r.1 : ℝ) : AddCircle (radiusPeriod a)) -
        ((Real.log s.1 : ℝ) : AddCircle (radiusPeriod a))) = 0
    rw [← AddCircle.coe_sub]
    apply (AddCircle.coe_eq_zero_iff (radiusPeriod a)).mpr
    refine ⟨n, ?_⟩
    rw [hsr, Real.log_mul (zpow_ne_zero n ha.ne') r.2.ne', Real.log_zpow]
    simp only [radiusPeriod, zsmul_eq_mul]
    ring

/-- The logarithmic circle map is onto: a representative `x` is reached by
the positive radius `exp x`. -/
theorem radiusCircleMap_surjective (a : ℝ) :
    Function.Surjective (radiusCircleMap a) := by
  intro z
  obtain ⟨x, rfl⟩ := QuotientAddGroup.mk'_surjective
    (AddSubgroup.zmultiples (radiusPeriod a)) z
  refine ⟨⟨Real.exp x, Real.exp_pos x⟩, ?_⟩
  change ((Real.log (Real.exp x) : ℝ) : AddCircle (radiusPeriod a)) =
    ((x : ℝ) : AddCircle (radiusPeriod a))
  rw [Real.log_exp]

/-- The orbit equivalence relation, presented as the kernel relation of the
logarithmic circle map.  The preceding exact-fibre theorem proves that this
is precisely scaling by integral powers of `a`. -/
def radiusOrbitSetoid (a : ℝ) : Setoid PositiveRadius :=
  Setoid.ker (radiusCircleMap a)

/-- The set quotient of the positive radius ray by integral scaling. -/
abbrev RadiusOrbitQuotient (a : ℝ) := Quotient (radiusOrbitSetoid a)

theorem radiusOrbitSetoid_rel_iff_zpow (a : ℝ) (ha : 0 < a)
    (r s : PositiveRadius) :
    (radiusOrbitSetoid a).r r s ↔ ∃ n : ℤ, s.1 = a ^ n * r.1 :=
  radiusCircleMap_eq_iff_zpow a ha r s

/-- The positive radial orbit quotient is exactly the additive logarithmic
circle, as a set. -/
def radiusOrbitQuotientEquivCircle (a : ℝ) :
    RadiusOrbitQuotient a ≃ AddCircle (radiusPeriod a) :=
  Setoid.quotientKerEquivOfSurjective (radiusCircleMap a)
    (radiusCircleMap_surjective a)

@[simp]
theorem radiusOrbitQuotientEquivCircle_mk (a : ℝ) (r : PositiveRadius) :
    radiusOrbitQuotientEquivCircle a (Quotient.mk (radiusOrbitSetoid a) r) =
      radiusCircleMap a r :=
  rfl

/-- The logarithmic circle map is a quotient map.  This uses the genuine
homeomorphism `log : (0,∞) ≃ ℝ` followed by the standard additive-circle
quotient projection. -/
theorem isQuotientMap_radiusCircleMap (a : ℝ) :
    IsQuotientMap (radiusCircleMap a) := by
  let e : PositiveRadius ≃ₜ ℝ := Real.expOrderIso.toHomeomorph.symm
  have hmk : IsQuotientMap
      (fun x : ℝ => ((x : ℝ) : AddCircle (radiusPeriod a))) :=
    isQuotientMap_quotient_mk'
  have hcomp := hmk.comp e.isQuotientMap
  convert hcomp using 1
  ext r
  simp [radiusCircleMap, e, Real.log_of_pos r.2]

/-- Topological strengthening of `radiusOrbitQuotientEquivCircle`: with the
canonical quotient topology, the positive radial orbit quotient is
homeomorphic to the additive circle. -/
def radiusOrbitQuotientHomeomorphCircle (a : ℝ) :
    RadiusOrbitQuotient a ≃ₜ AddCircle (radiusPeriod a) :=
  let f : C(PositiveRadius, AddCircle (radiusPeriod a)) :=
    ⟨radiusCircleMap a, continuous_radiusCircleMap a⟩
  (show IsQuotientMap f from isQuotientMap_radiusCircleMap a).homeomorph

end PolynomialGaussPointOrbit
end IUTThreeClosures
