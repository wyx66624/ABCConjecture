/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.HonestFinitePositiveLogVolume
import IUTThreeClosures.MultiradialLabelAbsoluteValue
import IUTThreeClosures.TensorPacketDistribution
import Mathlib.MeasureTheory.Group.Pointwise
import Mathlib.MeasureTheory.Measure.Lebesgue.EqHaar
import Mathlib.RingTheory.PiTensorProduct

/-!
# Cross-label integer action on a genuine tensor degree line

Step (x) in the proof of IUT III, Corollary 3.12 invokes the fact that the
tensor products in a local mono-analytic packet identify multiplication by an
integer at different labels, including its log-volume effect.  This module
formalizes exactly that algebraic/measure-theoretic source statement.

For a family of modules `M i`, `tensorScalarAt M j r` applies `r` only in the
factor labelled `j`.  The balancing relation in `PiTensorProduct` proves

`tensorScalarAt M j r = r • LinearMap.id`.

Thus the action is literally independent of `j`.  This applies in particular
to factors that are direct sums over local places.  For the real tensor degree
line `⨂ i, ℝ`, the canonical multiplication equivalence with `ℝ` conjugates
the action to `x ↦ n*x`.  Lebesgue/Haar scaling then constructs an honest
finite-positive scaling law whose logarithmic Jacobian is `log |n|`.

No Corollary 3.12 inequality, possible-image estimate, q-bound, or abc target
is a field of any structure here.  The remaining IUT-specific obligation is
to construct the AHS/untilt, Kummer, and log-link maps that place the alien
labelled local objects inside one such common tensor packet.
-/

namespace IUTThreeClosures

open MeasureTheory PiTensorProduct TensorProduct DirectSum
open scoped Pointwise

universe u v w

/-! ## Tensor balancing identifies scalar action at every label -/

/-- The endomorphism of an n-ary tensor packet obtained by multiplying only
the factor labelled `j` by `r`. -/
def tensorScalarAt
    {R : Type u} [CommRing R]
    {ι : Type v} [DecidableEq ι]
    (M : ι → Type w)
    [∀ i, AddCommGroup (M i)] [∀ i, Module R (M i)]
    (j : ι) (r : R) :
    (⨂[R] i : ι, M i) →ₗ[R] (⨂[R] i : ι, M i) :=
  PiTensorProduct.map
    (Function.update
      (fun i => (LinearMap.id : M i →ₗ[R] M i))
      j (r • (LinearMap.id : M j →ₗ[R] M j)))

/-- The balancing relation moves the scalar out of any chosen tensor factor.
This is the source theorem, not an assumed compatibility field. -/
theorem tensorScalarAt_eq_smul_id
    {R : Type u} [CommRing R]
    {ι : Type v} [DecidableEq ι]
    (M : ι → Type w)
    [∀ i, AddCommGroup (M i)] [∀ i, Module R (M i)]
    (j : ι) (r : R) :
    tensorScalarAt M j r =
      r • (LinearMap.id :
        (⨂[R] i : ι, M i) →ₗ[R] (⨂[R] i : ι, M i)) := by
  unfold tensorScalarAt
  rw [PiTensorProduct.map_update_smul]
  simp

@[simp]
theorem tensorScalarAt_apply
    {R : Type u} [CommRing R]
    {ι : Type v} [DecidableEq ι]
    (M : ι → Type w)
    [∀ i, AddCommGroup (M i)] [∀ i, Module R (M i)]
    (j : ι) (r : R) (x : ⨂[R] i : ι, M i) :
    tensorScalarAt M j r x = r • x := by
  rw [tensorScalarAt_eq_smul_id]
  rfl

/-- Scalar multiplication in two different factors induces the same
endomorphism of the tensor packet. -/
theorem tensorScalarAt_eq_tensorScalarAt
    {R : Type u} [CommRing R]
    {ι : Type v} [DecidableEq ι]
    (M : ι → Type w)
    [∀ i, AddCommGroup (M i)] [∀ i, Module R (M i)]
    (j k : ι) (r : R) :
    tensorScalarAt M j r = tensorScalarAt M k r := by
  rw [tensorScalarAt_eq_smul_id, tensorScalarAt_eq_smul_id]

/-- Integer multiplication in one chosen factor of a tensor packet. -/
def tensorIntegerAt
    {R : Type u} [CommRing R]
    {ι : Type v} [DecidableEq ι]
    (M : ι → Type w)
    [∀ i, AddCommGroup (M i)] [∀ i, Module R (M i)]
    (j : ι) (n : ℤ) :
    (⨂[R] i : ι, M i) →ₗ[R] (⨂[R] i : ι, M i) :=
  tensorScalarAt M j (n : R)

/-- Integer action at any tensor label is the ordinary scalar action on the
whole packet. -/
theorem tensorIntegerAt_eq_smul_id
    {R : Type u} [CommRing R]
    {ι : Type v} [DecidableEq ι]
    (M : ι → Type w)
    [∀ i, AddCommGroup (M i)] [∀ i, Module R (M i)]
    (j : ι) (n : ℤ) :
    tensorIntegerAt M j n =
      (n : R) •
        (LinearMap.id :
          (⨂[R] i : ι, M i) →ₗ[R] (⨂[R] i : ι, M i)) :=
  tensorScalarAt_eq_smul_id M j (n : R)

/-- Integer multiplication is identified across every pair of labels in the
actual tensor product. -/
theorem tensorIntegerAt_label_independent
    {R : Type u} [CommRing R]
    {ι : Type v} [DecidableEq ι]
    (M : ι → Type w)
    [∀ i, AddCommGroup (M i)] [∀ i, Module R (M i)]
    (j k : ι) (n : ℤ) :
    tensorIntegerAt (R := R) M j n =
      tensorIntegerAt (R := R) M k n :=
  tensorScalarAt_eq_tensorScalarAt (R := R) M j k (n : R)

/-! ## The direct-sum local packet specialization -/

/-- A local mono-analytic-style packet: tensor over labels of the direct sum
over places in each label. -/
abbrev LocalDirectSumTensorPacket
    (R : Type u) [CommRing R]
    (Label : Type v)
    (Place : Label → Type w)
    (K : ∀ j, Place j → Type w)
    [∀ j p, AddCommGroup (K j p)]
    [∀ j p, Module R (K j p)] :=
  (⨂[R] j : Label, (⨁ p : Place j, K j p))

/-- Integer action at one label of the direct-sum local tensor packet. -/
def localPacketIntegerAt
    (R : Type u) [CommRing R]
    {Label : Type v} [DecidableEq Label]
    (Place : Label → Type w)
    (K : ∀ j, Place j → Type w)
    [∀ j p, AddCommGroup (K j p)]
    [∀ j p, Module R (K j p)]
    (j : Label) (n : ℤ) :
    LocalDirectSumTensorPacket R Label Place K →ₗ[R]
      LocalDirectSumTensorPacket R Label Place K :=
  tensorIntegerAt (R := R)
    (fun i => (⨁ p : Place i, K i p)) j n

/-- The direct-sum tensor packet identifies integer action at any two labels
before any tuple expansion or volume calculation. -/
theorem localPacketIntegerAt_label_independent
    (R : Type u) [CommRing R]
    {Label : Type v} [DecidableEq Label]
    (Place : Label → Type w)
    (K : ∀ j, Place j → Type w)
    [∀ j p, AddCommGroup (K j p)]
    [∀ j p, Module R (K j p)]
    (j k : Label) (n : ℤ) :
    localPacketIntegerAt R Place K j n =
      localPacketIntegerAt R Place K k n :=
  tensorIntegerAt_label_independent (R := R)
    (fun i => (⨁ p : Place i, K i p)) j k n

/-- Tuple expansion of the direct-sum packet retains the same global scalar
action. Thus passing to place-tuple coordinates does not reintroduce a label
dependence. -/
theorem tensorPacketTupleExpansion_localPacketIntegerAt
    (R : Type u) [Field R]
    (Label : Type v) [Finite Label] [DecidableEq Label]
    (Place : Label → Type w)
    (K : ∀ j, Place j → Type w)
    [∀ j p, AddCommGroup (K j p)]
    [∀ j p, Module R (K j p)]
    (j : Label) (n : ℤ)
    (x : LocalDirectSumTensorPacket R Label Place K) :
    tensorPacketTupleExpansion R Label Place K
        (localPacketIntegerAt R Place K j n x) =
      (n : R) • tensorPacketTupleExpansion R Label Place K x := by
  rw [localPacketIntegerAt, tensorIntegerAt_eq_smul_id]
  simp

/-! ## The canonical real tensor degree line -/

/-- The tensor of one real degree line at every label. -/
abbrev RealTensorDegreeLine (Label : Type v) :=
  (⨂[ℝ] _i : Label, ℝ)

/-- Multiplication of tensor coordinates identifies the real tensor degree
line canonically with `ℝ`. -/
noncomputable def realTensorDegreeCoordinate
    (Label : Type v) [Fintype Label] :
    RealTensorDegreeLine Label ≃ₗ[ℝ] ℝ :=
  (PiTensorProduct.constantBaseRingEquiv Label ℝ).toLinearEquiv

@[simp]
theorem realTensorDegreeCoordinate_tprod
    (Label : Type v) [Fintype Label]
    (x : Label → ℝ) :
    realTensorDegreeCoordinate Label (⨂ₜ[ℝ] i, x i) = ∏ i, x i := by
  exact PiTensorProduct.constantBaseRingEquiv_tprod x

/-- Conjugate integer action from a labelled tensor factor to the canonical
real degree line. -/
noncomputable def realDegreeLineIntegerAt
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) : ℝ →ₗ[ℝ] ℝ :=
  (realTensorDegreeCoordinate Label).toLinearMap.comp
    ((tensorIntegerAt (fun _ : Label => ℝ) j n).comp
      (realTensorDegreeCoordinate Label).symm.toLinearMap)

/-- On the canonical degree line, integer action at any tensor label is
ordinary multiplication by that integer. -/
theorem realDegreeLineIntegerAt_eq_smul_id
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) :
    realDegreeLineIntegerAt j n =
      (n : ℝ) • (LinearMap.id : ℝ →ₗ[ℝ] ℝ) := by
  apply LinearMap.ext
  intro x
  simp [realDegreeLineIntegerAt, tensorIntegerAt,
    tensorScalarAt_apply]

@[simp]
theorem realDegreeLineIntegerAt_apply
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) (x : ℝ) :
    realDegreeLineIntegerAt j n x = (n : ℝ) * x := by
  rw [realDegreeLineIntegerAt_eq_smul_id]
  rfl

/-- The conjugated degree-line action is independent of the tensor label. -/
theorem realDegreeLineIntegerAt_label_independent
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j k : Label) (n : ℤ) :
    realDegreeLineIntegerAt j n = realDegreeLineIntegerAt k n := by
  rw [realDegreeLineIntegerAt_eq_smul_id,
    realDegreeLineIntegerAt_eq_smul_id]

/-! ## Honest Haar log-volume effect -/

/-- Image of a degree-line region under integer action in one tensor factor. -/
def realDegreeLineIntegerImage
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) (U : Set ℝ) : Set ℝ :=
  realDegreeLineIntegerAt j n '' U

/-- The actual tensor action image is ordinary scalar dilation. -/
theorem realDegreeLineIntegerImage_eq_smul
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) (U : Set ℝ) :
    realDegreeLineIntegerImage j n U = (n : ℝ) • U := by
  ext x
  simp [realDegreeLineIntegerImage, Set.mem_smul_set,
    realDegreeLineIntegerAt_apply]

/-- A nonzero integer action carries every finite-positive degree-line region
to another finite-positive region. -/
noncomputable def FinitePositiveRegion.tensorIntegerImage
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) (hn : n ≠ 0)
    (U : FinitePositiveRegion ℝ volume) :
    FinitePositiveRegion ℝ volume where
  carrier := realDegreeLineIntegerImage j n U.carrier
  measurable := by
    rw [realDegreeLineIntegerImage_eq_smul]
    exact U.measurable.const_smul_of_ne_zero (Int.cast_ne_zero.mpr hn)
  measure_ne_zero := by
    rw [realDegreeLineIntegerImage_eq_smul,
      Measure.addHaar_smul]
    simp only [Module.finrank_self, pow_one]
    exact mul_ne_zero
      (ENNReal.ofReal_ne_zero_iff.mpr
        (abs_pos.mpr (Int.cast_ne_zero.mpr hn)))
      U.measure_ne_zero
  measure_ne_top := by
    rw [realDegreeLineIntegerImage_eq_smul,
      Measure.addHaar_smul]
    simp only [Module.finrank_self, pow_one]
    exact ENNReal.mul_ne_top ENNReal.ofReal_ne_top U.measure_ne_top

@[simp]
theorem FinitePositiveRegion.coe_tensorIntegerImage
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) (hn : n ≠ 0)
    (U : FinitePositiveRegion ℝ volume) :
    ((U.tensorIntegerImage j n hn :
        FinitePositiveRegion ℝ volume) : Set ℝ) =
      realDegreeLineIntegerImage j n (U : Set ℝ) :=
  rfl

/-- Exact Haar measure scaling, derived from the tensor action. -/
theorem FinitePositiveRegion.measure_tensorIntegerImage
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) (hn : n ≠ 0)
    (U : FinitePositiveRegion ℝ volume) :
    volume (U.tensorIntegerImage j n hn : Set ℝ) =
      ENNReal.ofReal |(n : ℝ)| * volume (U : Set ℝ) := by
  rw [coe_tensorIntegerImage,
    realDegreeLineIntegerImage_eq_smul, Measure.addHaar_smul]
  simp only [Module.finrank_self, pow_one]

/-- Exact finite-positive logarithmic Haar-volume effect of integer
multiplication on the tensor degree line. -/
theorem FinitePositiveRegion.logVolume_tensorIntegerImage
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) (hn : n ≠ 0)
    (U : FinitePositiveRegion ℝ volume) :
    (U.tensorIntegerImage j n hn).logVolume =
      Real.log |(n : ℝ)| + U.logVolume := by
  apply FinitePositiveRegion.logVolume_eq_add_of_measure_toReal_eq_mul
    _ _ |(n : ℝ)| (abs_pos.mpr (Int.cast_ne_zero.mpr hn))
  change
    (volume (U.tensorIntegerImage j n hn : Set ℝ)).toReal =
      |(n : ℝ)| * (volume (U : Set ℝ)).toReal
  rw [measure_tensorIntegerImage,
    ENNReal.toReal_mul, ENNReal.toReal_ofReal (abs_nonneg (n : ℝ))]

/-- The tensor action supplies an honest scaling law on the finite-positive
domain. Its log-Jacobian is proved, not stored as a desired global estimate. -/
noncomputable def realDegreeLineIntegerScalingLaw
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j : Label) (n : ℤ) (hn : n ≠ 0) :
    FinitePositiveRegion.ScalingLaw (μ := volume)
      (realDegreeLineIntegerImage j n)
      (Real.log |(n : ℝ)|) where
  pullback U := U.tensorIntegerImage j n hn
  carrier_pullback U := rfl
  logVolume_pullback U := by
    rw [FinitePositiveRegion.logVolume_tensorIntegerImage]
    ac_rfl

/-- Both the transformed region and the logarithmic Haar-volume contribution
are independent of which tensor label carries the integer action. -/
theorem realDegreeLineIntegerImage_label_independent
    {Label : Type v} [Fintype Label] [DecidableEq Label]
    (j k : Label) (n : ℤ) (U : Set ℝ) :
    realDegreeLineIntegerImage j n U =
      realDegreeLineIntegerImage k n U := by
  rw [realDegreeLineIntegerImage_eq_smul,
    realDegreeLineIntegerImage_eq_smul]

/-! ## Boundary: the naive common-isometric-copy model is impossible -/

/-- The two fixed-field label rescalings cannot be embedded isometrically in
one metric packet while identifying both zero and an integer of nonzero
logarithmic norm. This is a concrete counterexample to the naive proposal
that the missing AHS comparison is a common isometric realization of those
rescaled copies. It does not obstruct non-isometric AHS/untilt maps. -/
theorem no_common_isometric_label_integer_identification
    {K : Type u} [NormedField K] [IsUltrametricDist K]
    (a : ℤ) (hlog : Real.log ‖(a : K)‖ ≠ 0)
    {E : Type v} [PseudoMetricSpace E]
    (f₁ : LabelOneNormCopy K → E)
    (f₂ : LabelTwoNormCopy K → E)
    (hf₁ : Isometry f₁) (hf₂ : Isometry f₂)
    (hzero : f₁ 0 = f₂ 0)
    (hint : f₁ (a : LabelOneNormCopy K) =
      f₂ (a : LabelTwoNormCopy K)) : False := by
  have hdist :
      dist (a : LabelTwoNormCopy K) 0 =
        dist (a : LabelOneNormCopy K) 0 := by
    calc
      dist (a : LabelTwoNormCopy K) 0 =
          dist (f₂ (a : LabelTwoNormCopy K)) (f₂ 0) :=
        (hf₂.dist_eq _ _).symm
      _ = dist (f₁ (a : LabelOneNormCopy K)) (f₁ 0) := by
        rw [hint, hzero]
      _ = dist (a : LabelOneNormCopy K) 0 :=
        hf₁.dist_eq _ _
  have hnorm :
      ‖(a : LabelTwoNormCopy K)‖ =
        ‖(a : LabelOneNormCopy K)‖ := by
    simpa only [dist_zero_right] using hdist
  apply labelOneTwoRingEquiv_not_logNorm_preserving_at_int a hlog
  rw [map_intCast]
  exact congrArg Real.log hnorm

/-- At a genuine `p`-adic place the integer `p` supplies the explicit
counterexample required by the preceding theorem. -/
theorem padic_no_common_isometric_label_integer_identification
    (p : ℕ) [Fact p.Prime]
    {E : Type v} [PseudoMetricSpace E]
    (f₁ : LabelOneNormCopy ℚ_[p] → E)
    (f₂ : LabelTwoNormCopy ℚ_[p] → E)
    (hf₁ : Isometry f₁) (hf₂ : Isometry f₂)
    (hzero : f₁ 0 = f₂ 0)
    (hint : f₁ (p : LabelOneNormCopy ℚ_[p]) =
      f₂ (p : LabelTwoNormCopy ℚ_[p])) : False := by
  apply no_common_isometric_label_integer_identification
    (K := ℚ_[p]) (p : ℤ) _ f₁ f₂ hf₁ hf₂ hzero hint
  have hp0 : (p : ℚ_[p]) ≠ 0 := by
    exact_mod_cast (Fact.out : p.Prime).ne_zero
  exact Real.log_ne_zero_of_pos_of_ne_one
    (norm_pos_iff.mpr hp0) (ne_of_lt Padic.norm_p_lt_one)

end IUTThreeClosures
