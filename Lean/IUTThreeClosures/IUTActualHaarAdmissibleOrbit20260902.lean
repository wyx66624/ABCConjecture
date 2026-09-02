/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateHaarResidueNormalization
import Mathlib.NumberTheory.Padics.RingHoms

/-!
# Actual Haar admissibility and the uniformizer preimage orbit

This module derives the corrected local preimage law from the normalized
additive Haar measure already constructed in `MaximalValuationRingHull`.
It does not populate an abstract volume field with the desired identity.

For every nonzero scalar, inverse image preserves the type of measurable
finite-positive regions and adds the logarithm of the inverse Haar character.
For a DVR uniformizer this character is the residue-field cardinality.  The
resulting expanding scaled balls are actual nonempty compact-open regions;
their log-volumes grow linearly, their orbit is injective, and no one
finite-positive region contains the whole orbit.

These are local results.  The tensor/place normalization, realization of all
IUT possible images, horizontal same-pilot comparison, Corollary 3.12, and abc
remain separate theorems.
-/

namespace IUTThreeClosures
namespace IUTActualHaarAdmissibleOrbit20260902

open MeasureTheory Set
open scoped ENNReal NNReal NormedField Pointwise Valued

universe u v

open MaximalValuationRingHull TateCurvesTheta

/-! ## Exact preimages and the finite-positive Haar domain -/

variable {K : Type u} [NontriviallyNormedField K]

/-- Multiplication by a field unit has inverse image equal to pointwise
multiplication by the inverse unit. -/
theorem preimage_mul_eq_inv_smul (a : Kˣ) (U : Set K) :
    (fun x : K => (a : K) * x) ⁻¹' U = a⁻¹ • U := by
  ext x
  constructor
  · intro hx
    refine ⟨(a : K) * x, hx, ?_⟩
    simp [smul_eq_mul]
  · rintro ⟨y, hy, rfl⟩
    simpa [smul_eq_mul] using hy

section Haar

variable [ProperSpace K] [MeasurableSpace K] [BorelSpace K]

/-- The honest preimage of a finite-positive region under multiplication by
a nonzero field element.  Its finiteness and positivity are consequences of
Haar change of variables. -/
noncomputable def mulPreimageRegion (a : Kˣ)
    (U : FinitePositiveRegion K (normalizedIntegerHaar (K := K))) :
    FinitePositiveRegion K (normalizedIntegerHaar (K := K)) where
  carrier := (fun x : K => (a : K) * x) ⁻¹' U.carrier
  measurable := U.measurable.preimage (by fun_prop)
  measure_ne_zero := by
    let μ : Measure K := normalizedIntegerHaar (K := K)
    letI : μ.IsAddHaarMeasure := by
      dsimp [μ, normalizedIntegerHaar]
      infer_instance
    have hs := distribHaarChar_mul (μ := μ) a⁻¹ U.carrier
    rw [← preimage_mul_eq_inv_smul] at hs
    rw [← hs]
    exact mul_ne_zero (by simp [distribHaarChar_pos.ne']) U.measure_ne_zero
  measure_ne_top := by
    let μ : Measure K := normalizedIntegerHaar (K := K)
    letI : μ.IsAddHaarMeasure := by
      dsimp [μ, normalizedIntegerHaar]
      infer_instance
    have hs := distribHaarChar_mul (μ := μ) a⁻¹ U.carrier
    rw [← preimage_mul_eq_inv_smul] at hs
    rw [← hs]
    exact ENNReal.mul_ne_top (by simp) U.measure_ne_top

@[simp]
theorem coe_mulPreimageRegion (a : Kˣ)
    (U : FinitePositiveRegion K (normalizedIntegerHaar (K := K))) :
    (mulPreimageRegion a U : Set K) =
      (fun x : K => (a : K) * x) ⁻¹' (U : Set K) :=
  rfl

/-- Genuine Haar change of variables for the preimage region. -/
theorem mulPreimageRegion_measure (a : Kˣ)
    (U : FinitePositiveRegion K (normalizedIntegerHaar (K := K))) :
    normalizedIntegerHaar (K := K) (mulPreimageRegion a U).carrier =
      (distribHaarChar K a⁻¹ : ℝ≥0∞) *
        normalizedIntegerHaar (K := K) U.carrier := by
  let μ : Measure K := normalizedIntegerHaar (K := K)
  letI : μ.IsAddHaarMeasure := by
    dsimp [μ, normalizedIntegerHaar]
    infer_instance
  have hs := distribHaarChar_mul (μ := μ) a⁻¹ U.carrier
  rw [← preimage_mul_eq_inv_smul] at hs
  exact hs.symm

/-- The measure identity becomes an additive identity for canonical real
log-volume. -/
theorem mulPreimageRegion_logVolume (a : Kˣ)
    (U : FinitePositiveRegion K (normalizedIntegerHaar (K := K))) :
    (mulPreimageRegion a U).logVolume = U.logVolume +
      Real.log ((distribHaarChar K a⁻¹ : ℝ≥0) : ℝ) := by
  rw [FinitePositiveRegion.logVolume, FinitePositiveRegion.logVolume,
    mulPreimageRegion_measure, ENNReal.toReal_mul]
  rw [ENNReal.coe_toReal]
  rw [Real.log_mul]
  · ring
  · exact_mod_cast (distribHaarChar_pos (A := K) (g := a⁻¹)).ne'
  · exact U.measure_toReal_pos.ne'

/-- Every nonzero scalar supplies a proof-carrying scaling law on the entire
finite-positive domain. -/
noncomputable def unitMulPreimageScalingLaw (a : Kˣ) :
    FinitePositiveRegion.ScalingLaw
      (μ := normalizedIntegerHaar (K := K))
      (fun U : Set K => (fun x : K => (a : K) * x) ⁻¹' U)
      (Real.log ((distribHaarChar K a⁻¹ : ℝ≥0) : ℝ)) where
  pullback := mulPreimageRegion a
  carrier_pullback := coe_mulPreimageRegion a
  logVolume_pullback := mulPreimageRegion_logVolume a

/-! ## The exact compact-open source domain -/

/-- A nonempty compact-open region with its finite positive Haar-volume
proofs.  This is the nonarchimedean domain denoted `M(-)` in IUT III,
Proposition 3.9(i). -/
structure HaarCompactOpenRegion where
  toFinitePositiveRegion :
    FinitePositiveRegion K (normalizedIntegerHaar (K := K))
  isCompact : IsCompact (toFinitePositiveRegion : Set K)
  isOpen : IsOpen (toFinitePositiveRegion : Set K)

namespace HaarCompactOpenRegion

@[ext]
theorem ext {U V : HaarCompactOpenRegion (K := K)}
    (h : U.toFinitePositiveRegion = V.toFinitePositiveRegion) : U = V := by
  cases U
  cases V
  simp_all

/-- Canonical logarithmic Haar volume on a compact-open region. -/
noncomputable def logVolume (U : HaarCompactOpenRegion (K := K)) : ℝ :=
  U.toFinitePositiveRegion.logVolume

/-- Scalar preimage on the exact compact-open source domain. -/
noncomputable def mulPreimage (a : Kˣ)
    (U : HaarCompactOpenRegion (K := K)) :
    HaarCompactOpenRegion (K := K) where
  toFinitePositiveRegion := mulPreimageRegion a U.toFinitePositiveRegion
  isCompact := by
    change IsCompact
      ((fun x : K => (a : K) * x) ⁻¹'
        (U.toFinitePositiveRegion : Set K))
    rw [preimage_mul_eq_inv_smul]
    exact U.isCompact.image (by fun_prop)
  isOpen := U.isOpen.preimage (by fun_prop)

@[simp]
theorem coe_mulPreimage (a : Kˣ)
    (U : HaarCompactOpenRegion (K := K)) :
    ((mulPreimage a U).toFinitePositiveRegion : Set K) =
      (fun x : K => (a : K) * x) ⁻¹'
        (U.toFinitePositiveRegion : Set K) :=
  rfl

/-- The genuine logarithmic change-of-variables law restricts to the exact
compact-open source domain. -/
theorem mulPreimage_logVolume (a : Kˣ)
    (U : HaarCompactOpenRegion (K := K)) :
    (mulPreimage a U).logVolume = U.logVolume +
      Real.log ((distribHaarChar K a⁻¹ : ℝ≥0) : ℝ) :=
  mulPreimageRegion_logVolume a U.toFinitePositiveRegion

end HaarCompactOpenRegion

/-! ## Actual scaled integral balls -/

/-- The scaled integral ball associated to an ambient field unit. -/
noncomputable def unitScaledFinitePositiveRegion (a : Kˣ) :
    FinitePositiveRegion K (normalizedIntegerHaar (K := K)) :=
  scaledFinitePositiveRegion (a : K) a.ne_zero

@[simp]
theorem coe_unitScaledFinitePositiveRegion (a : Kˣ) :
    (unitScaledFinitePositiveRegion a : Set K) =
      a • normIntegralRegion (K := K) := by
  rw [unitScaledFinitePositiveRegion, coe_scaledFinitePositiveRegion,
    TateHaarResidueNormalization.unit_smul_normIntegralRegion]

/-- Preimage sends a scaled integral ball to the ball with inverse-adjusted
scale. -/
theorem mulPreimageRegion_unitScaled (a b : Kˣ) :
    mulPreimageRegion a (unitScaledFinitePositiveRegion b) =
      unitScaledFinitePositiveRegion (a⁻¹ * b) := by
  apply FinitePositiveRegion.ext
  rw [coe_mulPreimageRegion, coe_unitScaledFinitePositiveRegion,
    coe_unitScaledFinitePositiveRegion, preimage_mul_eq_inv_smul,
    mul_smul]

/-- Canonical log-volume of an actual scaled integral ball. -/
theorem unitScaledFinitePositiveRegion_logVolume (a : Kˣ) :
    (unitScaledFinitePositiveRegion a).logVolume =
      Real.log ((distribHaarChar K a : ℝ≥0) : ℝ) := by
  rw [FinitePositiveRegion.logVolume]
  have hcarrier := coe_unitScaledFinitePositiveRegion (K := K) a
  change Real.log
      (normalizedIntegerHaar (K := K)
        (unitScaledFinitePositiveRegion a : Set K)).toReal = _
  rw [hcarrier]
  let μ : Measure K := normalizedIntegerHaar (K := K)
  letI : μ.IsAddHaarMeasure := by
    dsimp [μ, normalizedIntegerHaar]
    infer_instance
  have hs := distribHaarChar_mul (μ := μ) a
    (normIntegralRegion (K := K))
  have hunit : μ (normIntegralRegion (K := K)) = 1 :=
    normalizedIntegerHaar_apply_normIntegralRegion (K := K)
  rw [hunit, mul_one] at hs
  rw [← hs, ENNReal.coe_toReal]

/-- Every scaled integral ball has compact closure. -/
theorem unitScaledFinitePositiveRegion_closure_compact (a : Kˣ) :
    IsCompact (closure
      (unitScaledFinitePositiveRegion a : Set K)) := by
  have hc : IsCompact (unitScaledFinitePositiveRegion a : Set K) := by
    change IsCompact
      (scaledPositiveCompacts (a : K) a.ne_zero : Set K)
    exact (scaledPositiveCompacts (a : K) a.ne_zero).isCompact
  rw [hc.isClosed.closure_eq]
  exact hc

/-- In the ultrametric case, every scaled integral ball is open as well as
compact. -/
theorem unitScaledFinitePositiveRegion_isOpen
    [IsUltrametricDist K] (a : Kˣ) :
    IsOpen (unitScaledFinitePositiveRegion a : Set K) := by
  rw [coe_unitScaledFinitePositiveRegion,
    TateHaarResidueNormalization.unit_smul_normIntegralRegion,
    scaled_normIntegralRegion_eq_normBall]
  have hnorm : ‖(a : K)‖ ≠ 0 := (norm_pos_iff.mpr a.ne_zero).ne'
  have hopen := IsUltrametricDist.isOpen_closedBall (0 : K) hnorm
  convert hopen using 1
  ext x
  simp [Metric.mem_closedBall, dist_eq_norm]

/-- Every scaled integral ball contains zero. -/
theorem unitScaledFinitePositiveRegion_nonempty (a : Kˣ) :
    (unitScaledFinitePositiveRegion a : Set K).Nonempty := by
  refine ⟨0, ?_⟩
  rw [coe_unitScaledFinitePositiveRegion]
  exact ⟨0, by simp [normIntegralRegion], by simp⟩

/-- An actual scaled integral ball as an inhabitant of the exact compact-open
source domain. -/
noncomputable def unitScaledHaarCompactOpenRegion
    [IsUltrametricDist K] (a : Kˣ) :
    HaarCompactOpenRegion (K := K) where
  toFinitePositiveRegion := unitScaledFinitePositiveRegion a
  isCompact := by
    change IsCompact (scaledPositiveCompacts (a : K) a.ne_zero : Set K)
    exact (scaledPositiveCompacts (a : K) a.ne_zero).isCompact
  isOpen := unitScaledFinitePositiveRegion_isOpen a

@[simp]
theorem unitScaledHaarCompactOpenRegion_toFinite
    [IsUltrametricDist K] (a : Kˣ) :
    (unitScaledHaarCompactOpenRegion a).toFinitePositiveRegion =
      unitScaledFinitePositiveRegion a :=
  rfl

/-- Scalar preimage stays in the compact-open scaled-ball family. -/
theorem HaarCompactOpenRegion.mulPreimage_unitScaled
    [IsUltrametricDist K] (a b : Kˣ) :
    HaarCompactOpenRegion.mulPreimage a
        (unitScaledHaarCompactOpenRegion b) =
      unitScaledHaarCompactOpenRegion (a⁻¹ * b) := by
  apply HaarCompactOpenRegion.ext
  exact mulPreimageRegion_unitScaled a b

/-! ## Residue-normalized uniformizer orbit -/

section Discrete

variable [IsUltrametricDist K] [IsDiscreteValuationRing 𝒪[K]] [Finite 𝓀[K]]

/-- Inverse uniformizer scaling adds the logarithm of the residue cardinality. -/
theorem log_distribHaarChar_integerUnit_inv
    (π : 𝒪[K]) (hπ : Irreducible π) :
    Real.log ((distribHaarChar K
      (HaarResidueNormalization.integerUnit π hπ.ne_zero)⁻¹ : ℝ≥0) : ℝ) =
      Real.log (Nat.card 𝓀[K] : ℝ) := by
  rw [map_inv,
    HaarResidueNormalization.distribHaarChar_integerUnit_eq_residueCard_inv
      π hπ]
  simp

omit [IsDiscreteValuationRing 𝒪[K]] [Finite 𝓀[K]] in
/-- A norm-one multiplicative unit has distributive Haar character one. -/
theorem distribHaarChar_eq_one_of_norm_eq_one
    (u : Kˣ) (hu : ‖(u : K)‖ = 1) :
    distribHaarChar K u = 1 := by
  have h := TateHaarResidueNormalization.distribHaarChar_eq_of_norm
    u (1 : Kˣ) (by simpa using hu)
  simpa using h

/-- If a scalar factors as a norm-one unit times the `e`-th power of a
uniformizer, its Haar character is the corresponding residue factor. -/
theorem distribHaarChar_primeScalar
    (π : 𝒪[K]) (hπ : Irreducible π)
    (a u : Kˣ) (e : ℕ)
    (ha : a = u * (HaarResidueNormalization.integerUnit π hπ.ne_zero) ^ e)
    (hu : ‖(u : K)‖ = 1) :
    distribHaarChar K a =
      ((Nat.card 𝓀[K] : ℝ≥0)⁻¹) ^ e := by
  rw [ha, map_mul, map_pow,
    distribHaarChar_eq_one_of_norm_eq_one u hu,
    HaarResidueNormalization.distribHaarChar_integerUnit_eq_residueCard_inv
      π hπ, one_mul]

/-- Logarithmic inverse character of a rational-prime-like scalar with
ramification exponent `e`. -/
theorem log_distribHaarChar_primeScalar_inv
    (π : 𝒪[K]) (hπ : Irreducible π)
    (a u : Kˣ) (e : ℕ)
    (ha : a = u * (HaarResidueNormalization.integerUnit π hπ.ne_zero) ^ e)
    (hu : ‖(u : K)‖ = 1) :
    Real.log ((distribHaarChar K a⁻¹ : ℝ≥0) : ℝ) =
      (e : ℝ) * Real.log (Nat.card 𝓀[K] : ℝ) := by
  rw [map_inv, distribHaarChar_primeScalar π hπ a u e ha hu]
  simp only [inv_pow, inv_inv, NNReal.coe_pow, NNReal.coe_natCast,
    Real.log_pow]

/-- Raw Haar log-volume under a rational-prime-like scalar preimage changes
by `e * log q`. -/
theorem primeScalarPreimage_logVolume
    (π : 𝒪[K]) (hπ : Irreducible π)
    (a u : Kˣ) (e : ℕ)
    (ha : a = u * (HaarResidueNormalization.integerUnit π hπ.ne_zero) ^ e)
    (hu : ‖(u : K)‖ = 1)
    (U : FinitePositiveRegion K (normalizedIntegerHaar (K := K))) :
    (mulPreimageRegion a U).logVolume = U.logVolume +
      (e : ℝ) * Real.log (Nat.card 𝓀[K] : ℝ) := by
  rw [mulPreimageRegion_logVolume,
    log_distribHaarChar_primeScalar_inv π hπ a u e ha hu]

/-- After division by the local degree `e*f`, raw rational-prime preimage
adds exactly `log p`. -/
theorem primeScalarPreimage_normalizedLogVolume
    (π : 𝒪[K]) (hπ : Irreducible π)
    (a u : Kˣ) (p e f : ℕ)
    (ha : a = u * (HaarResidueNormalization.integerUnit π hπ.ne_zero) ^ e)
    (hu : ‖(u : K)‖ = 1)
    (hcard : Nat.card 𝓀[K] = p ^ f)
    (he : 0 < e) (hf : 0 < f)
    (U : FinitePositiveRegion K (normalizedIntegerHaar (K := K))) :
    (mulPreimageRegion a U).logVolume / ((e : ℝ) * (f : ℝ)) =
      U.logVolume / ((e : ℝ) * (f : ℝ)) + Real.log (p : ℝ) := by
  rw [primeScalarPreimage_logVolume π hπ a u e ha hu U,
    hcard, Nat.cast_pow, Real.log_pow]
  have he0 : (e : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt he)
  have hf0 : (f : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hf)
  field_simp

/-- The desired uniformizer-preimage scaling law, constructed from actual
normalized Haar measure and finite residue-field counting. -/
noncomputable def uniformizerPreimageScalingLaw
    (π : 𝒪[K]) (hπ : Irreducible π) :
    FinitePositiveRegion.ScalingLaw
      (μ := normalizedIntegerHaar (K := K))
      (fun U : Set K => (fun x : K => (π : K) * x) ⁻¹' U)
      (Real.log (Nat.card 𝓀[K] : ℝ)) where
  pullback := mulPreimageRegion (HaarResidueNormalization.integerUnit π hπ.ne_zero)
  carrier_pullback U := by
    rw [coe_mulPreimageRegion]
    rfl
  logVolume_pullback U := by
    rw [mulPreimageRegion_logVolume,
      log_distribHaarChar_integerUnit_inv π hπ]

/-- The actual expanding uniformizer orbit `π⁻ⁿ O_K`. -/
noncomputable def uniformizerExpandedBall
    (π : 𝒪[K]) (hπ : Irreducible π) (n : ℕ) :
    FinitePositiveRegion K (normalizedIntegerHaar (K := K)) :=
  unitScaledFinitePositiveRegion
    ((HaarResidueNormalization.integerUnit π hπ.ne_zero)⁻¹ ^ n)

omit [IsDiscreteValuationRing 𝒪[K]] [Finite 𝓀[K]] in
/-- One uniformizer preimage advances the actual orbit by one step. -/
theorem uniformizerExpandedBall_succ
    (π : 𝒪[K]) (hπ : Irreducible π) (n : ℕ) :
    mulPreimageRegion (HaarResidueNormalization.integerUnit π hπ.ne_zero)
        (uniformizerExpandedBall π hπ n) =
      uniformizerExpandedBall π hπ (n + 1) := by
  rw [uniformizerExpandedBall, uniformizerExpandedBall,
    mulPreimageRegion_unitScaled]
  congr 1
  simp [pow_succ']

/-- Exact logarithmic volume of every orbit ball. -/
@[simp]
theorem uniformizerExpandedBall_logVolume
    (π : 𝒪[K]) (hπ : Irreducible π) (n : ℕ) :
    (uniformizerExpandedBall π hπ n).logVolume =
      (n : ℝ) * Real.log (Nat.card 𝓀[K] : ℝ) := by
  induction n with
  | zero =>
      simp [uniformizerExpandedBall,
        unitScaledFinitePositiveRegion_logVolume]
  | succ n ih =>
      rw [← uniformizerExpandedBall_succ,
        mulPreimageRegion_logVolume,
        log_distribHaarChar_integerUnit_inv π hπ, ih]
      push_cast
      ring

omit [ProperSpace K] [MeasurableSpace K] [BorelSpace K]
    [IsDiscreteValuationRing 𝒪[K]] in
/-- A finite residue field is nontrivial, hence has cardinality greater than
one. -/
theorem residueCard_one_lt : 1 < Nat.card 𝓀[K] := by
  letI := Fintype.ofFinite 𝓀[K]
  rw [Nat.card_eq_fintype_card]
  exact Fintype.one_lt_card_iff_nontrivial.mpr inferInstance

/-- The expanding compact-open orbit is injective and therefore aperiodic. -/
theorem uniformizerExpandedBall_injective
    (π : 𝒪[K]) (hπ : Irreducible π) :
    Function.Injective (uniformizerExpandedBall π hπ) := by
  intro m n hmn
  have hv := congrArg
    (fun W : FinitePositiveRegion K (normalizedIntegerHaar (K := K)) =>
      W.logVolume) hmn
  rw [uniformizerExpandedBall_logVolume,
    uniformizerExpandedBall_logVolume] at hv
  have hq : 0 < Real.log (Nat.card 𝓀[K] : ℝ) :=
    Real.log_pos (by exact_mod_cast (residueCard_one_lt (K := K)))
  have hcast : (m : ℝ) = (n : ℝ) := by nlinarith
  exact_mod_cast hcast

/-- No one finite-positive region can contain every member of the expanding
uniformizer-preimage orbit. -/
theorem uniformizerExpandedBall_no_finitePositive_envelope
    (π : 𝒪[K]) (hπ : Irreducible π)
    (V : FinitePositiveRegion K (normalizedIntegerHaar (K := K))) :
    ¬ ∀ n, (uniformizerExpandedBall π hπ n : Set K) ⊆ (V : Set K) := by
  intro hcontain
  have hq : 0 < Real.log (Nat.card 𝓀[K] : ℝ) :=
    Real.log_pos (by exact_mod_cast (residueCard_one_lt (K := K)))
  obtain ⟨n, hn⟩ := exists_nat_gt
    (V.logVolume / Real.log (Nat.card 𝓀[K] : ℝ))
  have hstrict :
      V.logVolume < (n : ℝ) * Real.log (Nat.card 𝓀[K] : ℝ) :=
    (div_lt_iff₀ hq).mp hn
  have hmono := FinitePositiveRegion.logVolume_mono (hcontain n)
  rw [uniformizerExpandedBall_logVolume] at hmono
  exact (not_lt_of_ge hmono) hstrict

end Discrete

end Haar

/-! ## Finite products and the rational-prime coefficient -/

section Product

variable {ι : Type v} [Fintype ι]
variable {L : ι → Type u}
variable [∀ i, NontriviallyNormedField (L i)]
variable [∀ i, ProperSpace (L i)]
variable [∀ i, MeasurableSpace (L i)] [∀ i, BorelSpace (L i)]
variable [∀ i, IsUltrametricDist (L i)]
variable [∀ i, IsDiscreteValuationRing 𝒪[L i]] [∀ i, Finite 𝓀[L i]]
variable [∀ i, SigmaFinite (normalizedIntegerHaar (K := L i))]

/-- Simultaneous uniformizer preimage of a genuine product rectangle adds the
sum of the local residue-cardinality logarithms. -/
theorem product_uniformizerPreimage_logVolume
    (π : ∀ i, 𝒪[L i]) (hπ : ∀ i, Irreducible (π i))
    (U : ∀ i, FinitePositiveRegion (L i)
      (normalizedIntegerHaar (K := L i))) :
    (FinitePositiveRegion.pi
        (fun i => normalizedIntegerHaar (K := L i))
        (fun i => mulPreimageRegion
          (HaarResidueNormalization.integerUnit (π i) (hπ i).ne_zero)
          (U i))).logVolume =
      (FinitePositiveRegion.pi
        (fun i => normalizedIntegerHaar (K := L i)) U).logVolume +
        ∑ i, Real.log (Nat.card 𝓀[L i] : ℝ) := by
  rw [FinitePositiveRegion.logVolume_pi,
    FinitePositiveRegion.logVolume_pi,
    ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  rw [mulPreimageRegion_logVolume]
  have hlog := log_distribHaarChar_integerUnit_inv
    (K := L i) (π i) (hπ i)
  rw [hlog]

omit [∀ i, SigmaFinite (normalizedIntegerHaar (K := L i))] in
/-- The weighted component log-volume has shift equal to the weighted sum of
the local residue-cardinality logarithms. -/
theorem weighted_uniformizerPreimage_logVolume
    (w : ι → ℝ)
    (π : ∀ i, 𝒪[L i]) (hπ : ∀ i, Irreducible (π i))
    (U : ∀ i, FinitePositiveRegion (L i)
      (normalizedIntegerHaar (K := L i))) :
    (∑ i, w i *
      (mulPreimageRegion
        (HaarResidueNormalization.integerUnit (π i) (hπ i).ne_zero)
        (U i)).logVolume) =
      (∑ i, w i * (U i).logVolume) +
        ∑ i, w i * Real.log (Nat.card 𝓀[L i] : ℝ) := by
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  rw [mulPreimageRegion_logVolume]
  have hlog := log_distribHaarChar_integerUnit_inv
    (K := L i) (π i) (hπ i)
  rw [hlog, mul_add]

omit [∀ i, ProperSpace (L i)] [∀ i, MeasurableSpace (L i)]
    [∀ i, BorelSpace (L i)]
    [∀ i, IsDiscreteValuationRing 𝒪[L i]] [∀ i, Finite 𝓀[L i]]
    [∀ i, SigmaFinite (normalizedIntegerHaar (K := L i))] in
/-- If every residue cardinality is `p ^ fᵢ`, the weighted shift is exactly
`log p` precisely under the displayed degree normalization. -/
theorem weighted_residueDegree_shift_eq_log_prime
    (p : ℕ) (f : ι → ℕ) (w : ι → ℝ)
    (hcard : ∀ i, Nat.card 𝓀[L i] = p ^ f i)
    (hdegree : ∑ i, w i * (f i : ℝ) = 1) :
    (∑ i, w i * Real.log (Nat.card 𝓀[L i] : ℝ)) =
      Real.log (p : ℝ) := by
  calc
    (∑ i, w i * Real.log (Nat.card 𝓀[L i] : ℝ)) =
        ∑ i, (w i * (f i : ℝ)) * Real.log (p : ℝ) := by
      apply Finset.sum_congr rfl
      intro i hi
      rw [hcard i, Nat.cast_pow, Real.log_pow]
      ring
    _ = (∑ i, w i * (f i : ℝ)) * Real.log (p : ℝ) := by
      rw [Finset.sum_mul]
    _ = Real.log (p : ℝ) := by rw [hdegree, one_mul]

omit [∀ i, SigmaFinite (normalizedIntegerHaar (K := L i))] in
/-- Combination of the actual local change-of-variables theorem with the
degree normalization gives the public rational-prime coefficient. -/
theorem weighted_uniformizerPreimage_logVolume_eq_add_log_prime
    (p : ℕ) (f : ι → ℕ) (w : ι → ℝ)
    (π : ∀ i, 𝒪[L i]) (hπ : ∀ i, Irreducible (π i))
    (U : ∀ i, FinitePositiveRegion (L i)
      (normalizedIntegerHaar (K := L i)))
    (hcard : ∀ i, Nat.card 𝓀[L i] = p ^ f i)
    (hdegree : ∑ i, w i * (f i : ℝ) = 1) :
    (∑ i, w i *
      (mulPreimageRegion
        (HaarResidueNormalization.integerUnit (π i) (hπ i).ne_zero)
        (U i)).logVolume) =
      (∑ i, w i * (U i).logVolume) + Real.log (p : ℝ) := by
  calc
    _ = (∑ i, w i * (U i).logVolume) +
        ∑ i, w i * Real.log (Nat.card 𝓀[L i] : ℝ) :=
      weighted_uniformizerPreimage_logVolume w π hπ U
    _ = (∑ i, w i * (U i).logVolume) + Real.log (p : ℝ) := by
      rw [weighted_residueDegree_shift_eq_log_prime p f w hcard hdegree]

omit [∀ i, SigmaFinite (normalizedIntegerHaar (K := L i))] in
/-- Source-compatible two-stage normalization: divide each raw Haar
log-volume by its local degree `eᵢ*fᵢ`, then use place weights summing to one.
Simultaneous rational-prime preimage adds exactly `log p`. -/
theorem weighted_normalized_primeScalarPreimage
    (p : ℕ) (w : ι → ℝ)
    (π : ∀ i, 𝒪[L i]) (hπ : ∀ i, Irreducible (π i))
    (a u : ∀ i, (L i)ˣ) (e f : ι → ℕ)
    (ha : ∀ i, a i = u i *
      (HaarResidueNormalization.integerUnit (π i) (hπ i).ne_zero) ^ e i)
    (hu : ∀ i, ‖(u i : L i)‖ = 1)
    (hcard : ∀ i, Nat.card 𝓀[L i] = p ^ f i)
    (he : ∀ i, 0 < e i) (hf : ∀ i, 0 < f i)
    (U : ∀ i, FinitePositiveRegion (L i)
      (normalizedIntegerHaar (K := L i)))
    (hweight : ∑ i, w i = 1) :
    (∑ i, w i *
      ((mulPreimageRegion (a i) (U i)).logVolume /
        ((e i : ℝ) * (f i : ℝ)))) =
      (∑ i, w i *
        ((U i).logVolume / ((e i : ℝ) * (f i : ℝ)))) +
        Real.log (p : ℝ) := by
  calc
    _ = ∑ i, w i *
        ((U i).logVolume / ((e i : ℝ) * (f i : ℝ)) +
          Real.log (p : ℝ)) := by
      apply Finset.sum_congr rfl
      intro i hi
      rw [primeScalarPreimage_normalizedLogVolume
        (π i) (hπ i) (a i) (u i) p (e i) (f i)
        (ha i) (hu i) (hcard i) (he i) (hf i) (U i)]
    _ = (∑ i, w i *
        ((U i).logVolume / ((e i : ℝ) * (f i : ℝ)))) +
          ∑ i, w i * Real.log (p : ℝ) := by
      simp_rw [mul_add]
      rw [Finset.sum_add_distrib]
    _ = (∑ i, w i *
        ((U i).logVolume / ((e i : ℝ) * (f i : ℝ)))) +
          (∑ i, w i) * Real.log (p : ℝ) := by
      rw [Finset.sum_mul]
    _ = (∑ i, w i *
        ((U i).logVolume / ((e i : ℝ) * (f i : ℝ)))) +
          Real.log (p : ℝ) := by rw [hweight, one_mul]

end Product

/-- Full-premise numerical counterexample: weights summing to one do not by
themselves normalize a residue-degree-two component to a `log p` shift. -/
theorem weight_sum_one_not_sufficient (p : ℕ) (hp : 1 < p) :
    (1 : ℝ) * Real.log ((p ^ 2 : ℕ) : ℝ) ≠ Real.log (p : ℝ) := by
  rw [one_mul, Nat.cast_pow, Real.log_pow]
  have hlog : 0 < Real.log (p : ℝ) :=
    Real.log_pos (by exact_mod_cast hp)
  intro h
  norm_num at h
  linarith

/-! ## The exact residue cardinality for `ℚ_p` -/

/-- Mathlib's explicit residue-field equivalence identifies the residue
cardinality of `ℚ_p` with `p`. -/
theorem padic_residueCard (p : ℕ) [Fact p.Prime] :
    Nat.card 𝓀[ℚ_[p]] = p := by
  calc
    Nat.card 𝓀[ℚ_[p]] = Nat.card (ZMod p) :=
      Nat.card_congr (PadicInt.residueField (p := p)).toEquiv
    _ = p := by simp

end IUTActualHaarAdmissibleOrbit20260902
end IUTThreeClosures
