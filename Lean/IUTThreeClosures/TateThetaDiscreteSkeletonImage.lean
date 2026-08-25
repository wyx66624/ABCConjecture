/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaValuationCircleComparison
import TateCurvesTheta.QParameter.NormalizedOrder
import Mathlib.Data.ZMod.QuotientGroup

/-!
# The angular kernel and the discrete rational skeleton image

The logarithmic valuation-circle map on the present Tate `K`-point quotient
has kernel exactly the image of the norm-one units. In a discretely normed
field with a chosen uniformizer, its image is a finite cyclic group of order
the normalized order of `q`.

This is a theorem about `K`-rational points and ordinary quotient groups. It
does not construct a rigid, adic, Berkovich, or tempered object. In
particular, the finite rational image is not the full Berkovich skeleton;
analytic points with non-classical real radii are absent from this API.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K]

namespace TateThetaRootPoint

/-! ## The exact angular kernel over an arbitrary normed field -/

/-- The subgroup of field units having norm one. -/
def normOneUnitSubgroup : Subgroup Kˣ where
  carrier := {u | ‖(u : K)‖ = 1}
  one_mem' := by simp
  mul_mem' := by
    intro u v hu hv
    change ‖(u : K)‖ = 1 at hu
    change ‖(v : K)‖ = 1 at hv
    change ‖(u : K) * (v : K)‖ = 1
    rw [norm_mul, hu, hv, one_mul]
  inv_mem' := by
    intro u hu
    change ‖(u : K)‖ = 1 at hu
    change ‖((u⁻¹ : Kˣ) : K)‖ = 1
    rw [Units.val_inv_eq_inv_val, norm_inv, hu, inv_one]

@[simp]
theorem mem_normOneUnitSubgroup_iff (u : Kˣ) :
    u ∈ (normOneUnitSubgroup (K := K) : Subgroup Kˣ) ↔ ‖(u : K)‖ = 1 :=
  Iff.rfl

/-- Restriction of the Tate quotient map to norm-one units. -/
def normOneClassHom (t : TateParameter K) :
    (normOneUnitSubgroup (K := K)) →* t.AnalyticQuotient :=
  t.toAnalyticQuotient.comp (normOneUnitSubgroup (K := K)).subtype

/-- Norm-one units inject into `Kˣ/q^ℤ`: their intersection with `q^ℤ` is
trivial. -/
theorem normOneClassHom_injective (t : TateParameter K) :
    Function.Injective (normOneClassHom t) := by
  intro u v huv
  apply Subtype.ext
  change t.toAnalyticQuotient (u : Kˣ) =
    t.toAnalyticQuotient (v : Kˣ) at huv
  let w : Kˣ := (u : Kˣ) * (v : Kˣ)⁻¹
  have huNorm : ‖((u : Kˣ) : K)‖ = 1 :=
    (mem_normOneUnitSubgroup_iff (u : Kˣ)).mp u.property
  have hvNorm : ‖((v : Kˣ) : K)‖ = 1 :=
    (mem_normOneUnitSubgroup_iff (v : Kˣ)).mp v.property
  have hvInvNorm : ‖(((v : Kˣ)⁻¹ : Kˣ) : K)‖ = 1 :=
    (mem_normOneUnitSubgroup_iff ((v : Kˣ)⁻¹)).mp
      ((normOneUnitSubgroup (K := K)).inv_mem v.property)
  have hwNorm : ‖(w : K)‖ = 1 := by
    dsimp [w]
    rw [norm_mul, huNorm, hvInvNorm, one_mul]
  have hwQuot : t.toAnalyticQuotient w = 1 := by
    simp [w, map_mul, huv]
  have hw : w = 1 := by
    by_contra hwne
    exact (toAnalyticQuotient_norm_one_unit_ne_one t hwNorm hwne) hwQuot
  exact mul_inv_eq_one.mp hw

/-- The angular subgroup inside the Tate `K`-point quotient. -/
def angularKernel (t : TateParameter K) : Subgroup t.AnalyticQuotient :=
  (normOneClassHom t).range

/-- The kernel of the real valuation-circle map is exactly the angular
norm-one subgroup. -/
theorem valuationCircleMap_ker_eq_angularKernel (t : TateParameter K) :
    (valuationCircleMap t).ker = angularKernel t := by
  ext x
  constructor
  · intro hx
    obtain ⟨u, rfl⟩ := QuotientGroup.mk'_surjective t.qpowers x
    change valuationCircleMap t (t.toAnalyticQuotient u) = 1 at hx
    rw [valuationCircleMap_mk] at hx
    change ((-unitLogNorm u : ℝ) : TateValuationCircle t) = 0 at hx
    obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff t.ord).mp hx
    have hn' : (n : ℝ) * (-unitLogNorm t.q) = -unitLogNorm u := by
      simpa [TateParameter.ord, unitLogNorm, zsmul_eq_mul] using hn
    let w : Kˣ := u * t.q ^ (-n)
    have hwLog : unitLogNorm w = 0 := by
      dsimp [w]
      rw [unitLogNorm_mul, unitLogNorm_zpow]
      push_cast
      linarith
    have hwNorm : ‖(w : K)‖ = 1 := by
      apply Real.eq_one_of_pos_of_log_eq_zero
      · exact norm_pos_iff.mpr w.ne_zero
      · simpa [unitLogNorm] using hwLog
    change t.toAnalyticQuotient u ∈ (normOneClassHom t).range
    refine ⟨⟨w, hwNorm⟩, ?_⟩
    change t.toAnalyticQuotient w = t.toAnalyticQuotient u
    change t.toAnalyticQuotient (u * t.q ^ (-n)) =
      t.toAnalyticQuotient u
    apply (QuotientGroup.mk'_eq_mk' t.qpowers).2
    refine ⟨t.q ^ n, ⟨n, rfl⟩, ?_⟩
    group
  · intro hx
    change x ∈ (normOneClassHom t).range at hx
    obtain ⟨w, rfl⟩ := hx
    change valuationCircleMap t
      (t.toAnalyticQuotient (w : Kˣ)) = 1
    exact valuationCircleMap_norm_one_unit t w.property

instance angularKernel_normal (t : TateParameter K) :
    (angularKernel t).Normal := by
  rw [← valuationCircleMap_ker_eq_angularKernel t]
  infer_instance

/-- First-isomorphism form of the angular/radial decomposition. -/
noncomputable def angularQuotientEquivValuationCircleRange
    (t : TateParameter K) :
    (t.AnalyticQuotient ⧸ angularKernel t) ≃*
      (valuationCircleMap t).range :=
  (QuotientGroup.quotientMulEquivOfEq
      (valuationCircleMap_ker_eq_angularKernel t).symm).trans
    (QuotientGroup.quotientKerEquivRange (valuationCircleMap t))

/-! ## The discrete norm exponent -/

/-- The unique exponent of the norm of a unit with respect to a norm
uniformizer. -/
noncomputable def uniformizerExponent {p : K}
    (hp : IsUniformizer p) (u : Kˣ) : ℤ :=
  Classical.choose (hp.generates u)

@[simp]
theorem norm_eq_uniformizer_zpow {p : K}
    (hp : IsUniformizer p) (u : Kˣ) :
    ‖(u : K)‖ = ‖p‖ ^ uniformizerExponent hp u :=
  Classical.choose_spec (hp.generates u)

theorem uniformizerExponent_eq_of_norm {p : K}
    (hp : IsUniformizer p) (u : Kˣ) {n : ℤ}
    (hn : ‖(u : K)‖ = ‖p‖ ^ n) :
    uniformizerExponent hp u = n :=
  hp.zpow_right_injective ((norm_eq_uniformizer_zpow hp u).symm.trans hn)

/-- The discrete norm exponent is a multiplicative homomorphism into the
multiplicativization of the additive group `ℤ`. -/
noncomputable def uniformizerExponentHom {p : K}
    (hp : IsUniformizer p) : Kˣ →* Multiplicative ℤ where
  toFun u := Multiplicative.ofAdd (uniformizerExponent hp u)
  map_one' := by
    change uniformizerExponent hp (1 : Kˣ) = 0
    apply uniformizerExponent_eq_of_norm
    simp
  map_mul' u v := by
    change uniformizerExponent hp (u * v) =
      uniformizerExponent hp u + uniformizerExponent hp v
    apply uniformizerExponent_eq_of_norm
    calc
      ‖((u * v : Kˣ) : K)‖ = ‖(u : K)‖ * ‖(v : K)‖ := by
        rw [Units.val_mul, norm_mul]
      _ = ‖p‖ ^ uniformizerExponent hp u *
          ‖p‖ ^ uniformizerExponent hp v := by
        rw [norm_eq_uniformizer_zpow hp u,
          norm_eq_uniformizer_zpow hp v]
      _ = ‖p‖ ^ (uniformizerExponent hp u +
          uniformizerExponent hp v) :=
        (zpow_add₀ (norm_ne_zero_iff.mpr hp.ne_zero)
          (uniformizerExponent hp u)
          (uniformizerExponent hp v)).symm

@[simp]
theorem uniformizerExponent_mul {p : K}
    (hp : IsUniformizer p) (u v : Kˣ) :
    uniformizerExponent hp (u * v) =
      uniformizerExponent hp u + uniformizerExponent hp v := by
  exact congrArg Multiplicative.toAdd
    ((uniformizerExponentHom hp).map_mul u v)

@[simp]
theorem uniformizerExponent_zpow {p : K}
    (hp : IsUniformizer p) (u : Kˣ) (n : ℤ) :
    uniformizerExponent hp (u ^ n) =
      n * uniformizerExponent hp u := by
  simpa [uniformizerExponentHom] using
    congrArg Multiplicative.toAdd
      ((uniformizerExponentHom hp).map_zpow u n)

/-- The field element underlying a uniformizer, promoted to a unit. -/
def uniformizerUnit (p : K) (hp : IsUniformizer p) : Kˣ :=
  Units.mk0 p hp.ne_zero

@[simp]
theorem uniformizerUnit_coe (p : K) (hp : IsUniformizer p) :
    (uniformizerUnit p hp : K) = p :=
  rfl

@[simp]
theorem uniformizerExponent_uniformizerUnit (p : K)
    (hp : IsUniformizer p) :
    uniformizerExponent hp (uniformizerUnit p hp) = 1 := by
  apply uniformizerExponent_eq_of_norm
  simp

@[simp]
theorem uniformizerExponent_q (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) :
    uniformizerExponent hp t.q = t.orderZ hp := by
  apply uniformizerExponent_eq_of_norm
  exact t.norm_q_eq_zpow hp

/-- The positive natural discrete order used as the modulus. -/
noncomputable abbrev discreteTateOrder (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) : ℕ :=
  (t.toOrdered hp).orderNat

theorem orderZ_eq_discreteTateOrder (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) :
    t.orderZ hp = (discreteTateOrder t hp : ℤ) := by
  rw [discreteTateOrder, TateParameter.toOrdered_orderNat,
    Int.toNat_of_nonneg (t.orderZ_pos hp).le]

theorem discreteTateOrder_pos (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) :
    0 < discreteTateOrder t hp :=
  (t.toOrdered hp).orderNat_pos

/-! ## The finite discrete skeleton quotient -/

/-- Before quotienting by `q^ℤ`, reduce the discrete norm exponent modulo the
normalized order of `q`. -/
noncomputable def discreteNormClassHom (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) :
    Kˣ →* Multiplicative (ZMod (discreteTateOrder t hp)) :=
  (Int.castAddHom (ZMod (discreteTateOrder t hp))).toMultiplicative.comp
    (uniformizerExponentHom hp)

@[simp]
theorem discreteNormClassHom_apply (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) (u : Kˣ) :
    discreteNormClassHom t hp u =
      Multiplicative.ofAdd
        (uniformizerExponent hp u : ZMod (discreteTateOrder t hp)) :=
  rfl

@[simp]
theorem discreteNormClassHom_q (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) :
    discreteNormClassHom t hp t.q = 1 := by
  change (uniformizerExponent hp t.q :
    ZMod (discreteTateOrder t hp)) = 0
  rw [uniformizerExponent_q, orderZ_eq_discreteTateOrder]
  simp only [Int.cast_natCast, ZMod.natCast_self]

theorem qpowers_le_discreteNormClassHom_ker
    (t : TateParameter K) {p : K} (hp : IsUniformizer p) :
    t.qpowers ≤ (discreteNormClassHom t hp).ker := by
  rw [show t.qpowers = Subgroup.zpowers t.q from rfl,
    Subgroup.zpowers_le]
  exact discreteNormClassHom_q t hp

/-- The discrete radial class descends to the Tate `K`-point quotient. -/
noncomputable def discreteSkeletonMap (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) :
    t.AnalyticQuotient →*
      Multiplicative (ZMod (discreteTateOrder t hp)) :=
  QuotientGroup.lift t.qpowers (discreteNormClassHom t hp)
    (qpowers_le_discreteNormClassHom_ker t hp)

@[simp]
theorem discreteSkeletonMap_mk (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) (u : Kˣ) :
    discreteSkeletonMap t hp (t.toAnalyticQuotient u) =
      Multiplicative.ofAdd
        (uniformizerExponent hp u : ZMod (discreteTateOrder t hp)) := by
  exact QuotientGroup.lift_mk' _ _ u

/-- Every residue class of the discrete order is realized by a power of the
uniformizer. -/
theorem discreteNormClassHom_surjective (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) :
    Function.Surjective (discreteNormClassHom t hp) := by
  intro z
  obtain ⟨n, hn⟩ := ZMod.intCast_surjective z.toAdd
  refine ⟨(uniformizerUnit p hp) ^ n, ?_⟩
  change (uniformizerExponent hp ((uniformizerUnit p hp) ^ n) :
    ZMod (discreteTateOrder t hp)) = z.toAdd
  rw [uniformizerExponent_zpow,
    uniformizerExponent_uniformizerUnit, mul_one, hn]

theorem discreteSkeletonMap_surjective (t : TateParameter K) {p : K}
    (hp : IsUniformizer p) :
    Function.Surjective (discreteSkeletonMap t hp) := by
  intro z
  obtain ⟨u, hu⟩ := discreteNormClassHom_surjective t hp z
  refine ⟨t.toAnalyticQuotient u, ?_⟩
  rw [discreteSkeletonMap_mk]
  exact hu

/-- The discrete skeleton map has the same exact angular kernel as the real
valuation-circle map. -/
theorem discreteSkeletonMap_ker_eq_angularKernel
    (t : TateParameter K) {p : K} (hp : IsUniformizer p) :
    (discreteSkeletonMap t hp).ker = angularKernel t := by
  ext x
  constructor
  · intro hx
    obtain ⟨u, rfl⟩ := QuotientGroup.mk'_surjective t.qpowers x
    change discreteSkeletonMap t hp (t.toAnalyticQuotient u) = 1 at hx
    rw [discreteSkeletonMap_mk] at hx
    change (uniformizerExponent hp u :
      ZMod (discreteTateOrder t hp)) = 0 at hx
    have hdvd : (discreteTateOrder t hp : ℤ) ∣
        uniformizerExponent hp u :=
      (ZMod.intCast_zmod_eq_zero_iff_dvd _ _).mp hx
    obtain ⟨k, hk⟩ := hdvd
    let w : Kˣ := u * t.q ^ (-k)
    have hwExp : uniformizerExponent hp w = 0 := by
      dsimp [w]
      rw [uniformizerExponent_mul, uniformizerExponent_zpow,
        uniformizerExponent_q, orderZ_eq_discreteTateOrder, hk]
      ring
    have hwNorm : ‖(w : K)‖ = 1 := by
      calc
        ‖(w : K)‖ = ‖p‖ ^ uniformizerExponent hp w :=
          norm_eq_uniformizer_zpow hp w
        _ = 1 := by rw [hwExp, zpow_zero]
    change t.toAnalyticQuotient u ∈ (normOneClassHom t).range
    refine ⟨⟨w, hwNorm⟩, ?_⟩
    change t.toAnalyticQuotient w = t.toAnalyticQuotient u
    change t.toAnalyticQuotient (u * t.q ^ (-k)) =
      t.toAnalyticQuotient u
    apply (QuotientGroup.mk'_eq_mk' t.qpowers).2
    refine ⟨t.q ^ k, ⟨k, rfl⟩, ?_⟩
    group
  · intro hx
    change x ∈ (normOneClassHom t).range at hx
    obtain ⟨w, rfl⟩ := hx
    change discreteSkeletonMap t hp
      (t.toAnalyticQuotient (w : Kˣ)) = 1
    rw [discreteSkeletonMap_mk]
    change (uniformizerExponent hp (w : Kˣ) :
      ZMod (discreteTateOrder t hp)) = 0
    have hwExp : uniformizerExponent hp (w : Kˣ) = 0 := by
      have hwNorm : ‖((w : Kˣ) : K)‖ = 1 :=
        (mem_normOneUnitSubgroup_iff (w : Kˣ)).mp w.property
      apply uniformizerExponent_eq_of_norm
      rw [zpow_zero]
      exact hwNorm
    rw [hwExp]
    norm_num

/-- First-isomorphism identification of the angular quotient with the finite
discrete skeleton group. -/
noncomputable def angularQuotientEquivDiscreteSkeleton
    (t : TateParameter K) {p : K} (hp : IsUniformizer p) :
    (t.AnalyticQuotient ⧸ angularKernel t) ≃*
      Multiplicative (ZMod (discreteTateOrder t hp)) :=
  (QuotientGroup.quotientMulEquivOfEq
      (discreteSkeletonMap_ker_eq_angularKernel t hp).symm).trans
    (QuotientGroup.quotientKerEquivOfSurjective
      (discreteSkeletonMap t hp)
      (discreteSkeletonMap_surjective t hp))

/-- The image of the real valuation-circle map on `K`-rational points is
abstractly the finite cyclic group of order `ord_p(q)`. -/
noncomputable def valuationCircleRangeEquivZMod
    (t : TateParameter K) {p : K} (hp : IsUniformizer p) :
    (valuationCircleMap t).range ≃*
      Multiplicative (ZMod (discreteTateOrder t hp)) :=
  (angularQuotientEquivValuationCircleRange t).symm.trans
    (angularQuotientEquivDiscreteSkeleton t hp)

/-- The rational valuation-circle image is finite. -/
theorem valuationCircleMap_range_finite
    (t : TateParameter K) {p : K} (hp : IsUniformizer p) :
    Finite (valuationCircleMap t).range := by
  letI : NeZero (discreteTateOrder t hp) :=
    ⟨(discreteTateOrder_pos t hp).ne'⟩
  exact Finite.of_equiv
    (Multiplicative (ZMod (discreteTateOrder t hp)))
    (valuationCircleRangeEquivZMod t hp).symm.toEquiv

/-- Its exact cardinality is the positive discrete normalized order of `q`. -/
theorem natCard_valuationCircleMap_range
    (t : TateParameter K) {p : K} (hp : IsUniformizer p) :
    Nat.card (valuationCircleMap t).range = discreteTateOrder t hp := by
  rw [Nat.card_congr (valuationCircleRangeEquivZMod t hp).toEquiv]
  exact Nat.card_zmod _

end TateThetaRootPoint

end IUTThreeClosures
