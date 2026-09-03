/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.IUTActualHaarAdmissibleOrbit20260902
import IUTThreeClosures.RefinedFactorLocalFieldData
import IUTThreeClosures.UpperSemicompatiblePossibleImageSystem

/-!
# Refined tensor Haar volume and the pointed same-pilot gate

This module formalizes the results proved first in
`research/ABC_IUT_REFINED_TENSOR_HAAR_THETA_SAME_PILOT_2026_09_02.md`.

* a DVR element factors as a norm-one unit times a uniformizer power;
* on genuine finite products of local fields, total-local-degree
  normalization converts the raw rational-prime Haar shift to `log p`;
* relative local-degree weights recover the same normalized product volume;
* primitive refinement preserves a tuple weight exactly;
* an open possible-image union contained in one relatively compact envelope
  is an actual finite-positive measure region;
* source-generated native inclusion then gives the same-pilot logarithmic
  inequality by measure monotonicity.

The module also records exact counterexamples to copying one tuple weight to
every primitive factor, to deriving per-output admissibility from envelope
preservation alone, and to deriving a pointed bound from unpointed finite
positive data.

No source-level IPL/SHE/APT map, Ind3 openness theorem, Corollary 3.12, IUT, or
abc statement is assumed or proved here.
-/

namespace IUTThreeClosures
namespace IUTRefinedTensorHaarThetaSamePilot20260902

set_option linter.unusedSectionVars false

open MeasureTheory Set
open scoped BigOperators ENNReal NNReal NormedField Pointwise Valued

universe u v w x y

open MaximalValuationRingHull HaarResidueNormalization
open IUTActualHaarAdmissibleOrbit20260902

/-- A measure-generic compact-open region carrying proofs that its measure is
finite and positive.  This lets product fields and theta unions use the same
actual admissible class as the one-field Haar construction. -/
structure FinitePositiveCompactOpenRegion
    (X : Type u) [TopologicalSpace X] [MeasurableSpace X]
    (μ : Measure X) where
  toFinitePositiveRegion : FinitePositiveRegion X μ
  isCompact : IsCompact (toFinitePositiveRegion : Set X)
  isOpen : IsOpen (toFinitePositiveRegion : Set X)

/-! ## Actual DVR factorization -/

section DVRFactorization

variable {K : Type u} [NontriviallyNormedField K]
variable [IsUltrametricDist K] [IsDiscreteValuationRing 𝒪[K]]

/-- Every nonzero valuation integer factors in the ambient field as a
norm-one integral unit times a power of any chosen uniformizer.  Applied to
the image of the rational prime, the exponent is its ramification index. -/
theorem exists_normOne_unit_mul_uniformizer_pow
    (a π : 𝒪[K]) (ha : a ≠ 0) (hπ : Irreducible π) :
    ∃ (e : ℕ) (u : Kˣ),
      integerUnit a ha = u * (integerUnit π hπ.ne_zero) ^ e ∧
      ‖(u : K)‖ = 1 := by
  obtain ⟨e, uO, huO⟩ :=
    IsDiscreteValuationRing.eq_unit_mul_pow_irreducible ha hπ
  let u : Kˣ := Units.map (algebraMap 𝒪[K] K) uO
  refine ⟨e, u, ?_, ?_⟩
  · apply Units.ext
    change (a : K) = (uO : 𝒪[K]) * (π : K) ^ e
    exact congrArg ((↑) : 𝒪[K] → K) huO
  · exact Valued.integer.norm_coe_unit uO

end DVRFactorization

/-! ## Exact mixed-characteristic identities on every primitive factor -/

section MixedCharacteristicLocalIdentities

open Iut4Sec1
open scoped Padic WithZero

variable (p : ℕ) [Fact p.Prime]
variable (L : Type u) [Field L] [Algebra ℚ_[p] L]
  [FiniteDimensional ℚ_[p] L]

/-- The rational prime as an element of the canonical spectral integer ring. -/
noncomputable def mixedCharPrimeInteger (D : MixedCharLocalFieldData p L) :
    D.ringOfIntegers :=
  ⟨MixedCharLocalFieldData.pElement (p := p) (L := L),
    D.p_valuation_lt_one.le⟩

/-- Exact DVR factorization of the rational prime: for every uniformizer,
the exponent is the constructed ramification index, rather than an arbitrary
natural number. -/
theorem mixedChar_prime_eq_unit_mul_uniformizer_pow_ramificationIndex
    (D : MixedCharLocalFieldData p L)
    (π : D.ringOfIntegers) (hπ : Irreducible π) :
    ∃ unit : D.ringOfIntegersˣ,
      mixedCharPrimeInteger p L D =
          (unit : D.ringOfIntegers) * π ^ D.ramificationIndex ∧
        D.valuation (unit : L) = 1 := by
  letI := D.integerRingIsDVR
  let pO : D.ringOfIntegers := mixedCharPrimeInteger p L D
  have hpO : pO ≠ 0 := by
    intro h
    have h' := congrArg ((↑) : D.ringOfIntegers → L) h
    change algebraMap ℚ_[p] L (p : ℚ_[p]) = 0 at h'
    exact (map_ne_zero (algebraMap ℚ_[p] L)).2
      (Nat.cast_ne_zero.mpr (Fact.out : p.Prime).ne_zero) h'
  obtain ⟨m, unit, hm⟩ :=
    IsDiscreteValuationRing.eq_unit_mul_pow_irreducible hpO hπ
  have hunitVal :
      D.discreteValuation (unit : D.ringOfIntegers) = 1 := by
    let w := IsDiscreteValuationRing.maximalIdeal D.ringOfIntegers
    rw [MixedCharLocalFieldData.discreteValuation]
    change w.valuation L (algebraMap D.ringOfIntegers L
      (unit : D.ringOfIntegers)) = 1
    rw [w.valuation_of_algebraMap]
    exact IsDedekindDomain.HeightOneSpectrum.intValuation_eq_one_iff.mpr
      (w.asIdeal.notMem_of_isUnit unit.isUnit)
  have hπVal : D.discreteValuation (π : D.ringOfIntegers) =
      WithZero.exp (-1 : ℤ) := by
    let w := IsDiscreteValuationRing.maximalIdeal D.ringOfIntegers
    rw [MixedCharLocalFieldData.discreteValuation]
    change w.valuation L (algebraMap D.ringOfIntegers L π) =
      WithZero.exp (-1 : ℤ)
    rw [w.valuation_of_algebraMap]
    exact w.intValuation_singleton hπ.ne_zero hπ.maximalIdeal_eq
  have hv := congrArg (fun x : D.ringOfIntegers =>
    D.discreteValuation (x : L)) hm
  change D.discreteValuation
      (MixedCharLocalFieldData.pElement (p := p) (L := L)) =
    D.discreteValuation ((unit : L) * (π : L) ^ m) at hv
  rw [map_mul, map_pow, hunitVal, hπVal, one_mul] at hv
  have hmram : m = D.ramificationIndex := by
    rw [MixedCharLocalFieldData.ramificationIndex, hv,
      WithZero.log_pow, WithZero.log_exp]
    simp
  have hunitSpectral : D.valuation (unit : L) = 1 := by
    exact (Valuation.integer.integers D.valuation).one_of_isUnit unit.isUnit
  exact ⟨unit, hmram ▸ hm, hunitSpectral⟩

/-- Public version of the canonical identification of the spectral integer
ring of `ℚ_[p]` with `ℤ_[p]`. -/
noncomputable def baseRingEquivPadicInt :
    (baseValuation p).integer ≃+* ℤ_[p] where
  toFun x := ⟨x, by
    have hx := x.2
    change ‖(x : ℚ_[p])‖₊ ≤ 1 at hx
    exact_mod_cast hx⟩
  invFun x := ⟨x, by
    change baseValuation p (x : ℚ_[p]) ≤ 1
    rw [baseValuation, NormedField.valuation_apply]
    exact_mod_cast x.2⟩
  left_inv _ := rfl
  right_inv _ := rfl
  map_mul' _ _ := rfl
  map_add' _ _ := rfl

/-- The base residue field has exactly `p` elements. -/
theorem baseResidue_natCard :
    Nat.card (IsLocalRing.ResidueField (baseValuation p).integer) = p := by
  let e := (IsLocalRing.ResidueField.mapEquiv
    (baseRingEquivPadicInt p)).trans PadicInt.residueField
  simpa only [Nat.card_zmod] using Nat.card_congr e.toEquiv

/-- The fundamental local-degree identity for the public
`MixedCharLocalFieldData`: `e f = [L : ℚ_p]`.  Module finiteness of the
integer ring is derived from its characterization as the integral closure. -/
theorem mixedChar_ramification_mul_residueDegree
    (D : MixedCharLocalFieldData p L) :
    D.ramificationIndex * D.residueDegree = Module.finrank ℚ_[p] L := by
  letI := D.valuationExtension
  letI := D.integerRingIsDVR
  letI : IsIntegralClosure D.ringOfIntegers
      (MixedCharLocalFieldData.baseRingOfIntegers (p := p)) L := {
    algebraMap_injective := Subtype.coe_injective
    isIntegral_iff := by
      intro x
      rw [← D.mem_ringOfIntegers_iff_isIntegral x]
      constructor
      · intro hx
        exact ⟨⟨x, hx⟩, rfl⟩
      · rintro ⟨y, rfl⟩
        exact y.2
  }
  letI : Module.Finite
      (MixedCharLocalFieldData.baseRingOfIntegers (p := p))
      D.ringOfIntegers :=
    IsIntegralClosure.finite
      (MixedCharLocalFieldData.baseRingOfIntegers (p := p)) ℚ_[p] L
      D.ringOfIntegers
  have h := Ideal.ramificationIdx_mul_inertiaDeg_of_isLocalRing
    D.ringOfIntegers ℚ_[p] L
    (IsDiscreteValuationRing.not_a_field
      (MixedCharLocalFieldData.baseRingOfIntegers (p := p)))
  rw [Ideal.ramificationIdx'_eq_ramificationIdx
      (IsLocalRing.maximalIdeal
        (MixedCharLocalFieldData.baseRingOfIntegers (p := p)))
      (IsLocalRing.maximalIdeal D.ringOfIntegers)
      (IsDiscreteValuationRing.not_a_field
        (MixedCharLocalFieldData.baseRingOfIntegers (p := p))),
    Ideal.inertiaDeg'_eq_inertiaDeg] at h
  rw [D.ramificationIndex_eq_idealRamificationIndex]
  simpa only [MixedCharLocalFieldData.idealRamificationIndex,
    MixedCharLocalFieldData.residueDegree] using h

/-- The residue field of a finite extension has cardinality `p^f`, with
`f` the constructed residue degree. -/
theorem mixedChar_residueField_natCard
    (D : MixedCharLocalFieldData p L) :
    Nat.card (IsLocalRing.ResidueField D.ringOfIntegers) =
      p ^ D.residueDegree := by
  letI := D.valuationExtension
  letI := D.integerRingIsDVR
  letI : IsIntegralClosure D.ringOfIntegers
      (MixedCharLocalFieldData.baseRingOfIntegers (p := p)) L := {
    algebraMap_injective := Subtype.coe_injective
    isIntegral_iff := by
      intro x
      rw [← D.mem_ringOfIntegers_iff_isIntegral x]
      constructor
      · intro hx
        exact ⟨⟨x, hx⟩, rfl⟩
      · rintro ⟨y, rfl⟩
        exact y.2
  }
  letI : Module.Finite
      (MixedCharLocalFieldData.baseRingOfIntegers (p := p))
      D.ringOfIntegers :=
    IsIntegralClosure.finite
      (MixedCharLocalFieldData.baseRingOfIntegers (p := p)) ℚ_[p] L
      D.ringOfIntegers
  have h := Ideal.cardQuot_pow_inertiaDeg
    (IsLocalRing.maximalIdeal
      (MixedCharLocalFieldData.baseRingOfIntegers (p := p)))
    (IsLocalRing.maximalIdeal D.ringOfIntegers)
  rw [Submodule.cardQuot_apply, Submodule.cardQuot_apply] at h
  change Nat.card
      (D.ringOfIntegers ⧸ IsLocalRing.maximalIdeal D.ringOfIntegers) =
    p ^ D.residueDegree
  rw [← h]
  change Nat.card
      ((MixedCharLocalFieldData.baseRingOfIntegers (p := p)) ⧸
        IsLocalRing.maximalIdeal
          (MixedCharLocalFieldData.baseRingOfIntegers (p := p))) ^
      D.residueDegree = p ^ D.residueDegree
  rw [show Nat.card
      ((MixedCharLocalFieldData.baseRingOfIntegers (p := p)) ⧸
        IsLocalRing.maximalIdeal
          (MixedCharLocalFieldData.baseRingOfIntegers (p := p))) = p by
    simpa only [IsLocalRing.ResidueField] using baseResidue_natCard p]

end MixedCharacteristicLocalIdentities

/-! ## Total-degree normalization on refined primitive factors -/

section RefinedProduct

variable {ι : Type v} [Fintype ι] [Nonempty ι]
variable {L : ι → Type u}
variable [∀ i, NontriviallyNormedField (L i)]
variable [∀ i, ProperSpace (L i)]
variable [∀ i, MeasurableSpace (L i)] [∀ i, BorelSpace (L i)]
variable [∀ i, IsUltrametricDist (L i)]
variable [∀ i, IsDiscreteValuationRing 𝒪[L i]] [∀ i, Finite 𝓀[L i]]
variable [∀ i, SigmaFinite (normalizedIntegerHaar (K := L i))]

/-- A rectangle of actual one-field compact-open Haar regions is an actual
finite-positive compact-open region for the genuine product Haar measure. -/
noncomputable def refinedProductCompactOpenRegion
    (U : ∀ i, HaarCompactOpenRegion (K := L i)) :
    FinitePositiveCompactOpenRegion (∀ i, L i)
      (Measure.pi (fun i => normalizedIntegerHaar (K := L i))) where
  toFinitePositiveRegion :=
    FinitePositiveRegion.pi
      (fun i => normalizedIntegerHaar (K := L i))
      (fun i => (U i).toFinitePositiveRegion)
  isCompact := by
    rw [FinitePositiveRegion.coe_pi]
    exact isCompact_univ_pi fun i => (U i).isCompact
  isOpen := by
    rw [FinitePositiveRegion.coe_pi]
    exact isOpen_set_pi Set.finite_univ fun i hi => (U i).isOpen

/-- Sum of the real local degrees `eᵢ fᵢ` of the primitive factors. -/
noncomputable def realTotalLocalDegree (e f : ι → ℕ) : ℝ :=
  ∑ i, (e i : ℝ) * (f i : ℝ)

/-- Positivity of the total degree follows from positivity of every local
ramification and residue degree and nonemptiness of the factor family. -/
theorem realTotalLocalDegree_pos
    (e f : ι → ℕ) (he : ∀ i, 0 < e i) (hf : ∀ i, 0 < f i) :
    0 < realTotalLocalDegree e f := by
  classical
  apply Finset.sum_pos'
  · intro i hi
    exact (mul_pos (by exact_mod_cast he i) (by exact_mod_cast hf i)).le
  · obtain ⟨i⟩ := ‹Nonempty ι›
    exact ⟨i, Finset.mem_univ i,
      mul_pos (by exact_mod_cast he i) (by exact_mod_cast hf i)⟩

/-- Raw product Haar logarithm under simultaneous rational-prime preimage.
The coefficient is the sum of the primitive local degrees. -/
theorem refinedProduct_primePreimage_rawLogVolume
    (p : ℕ)
    (π : ∀ i, 𝒪[L i]) (hπ : ∀ i, Irreducible (π i))
    (a u : ∀ i, (L i)ˣ) (e f : ι → ℕ)
    (ha : ∀ i, a i = u i *
      (integerUnit (π i) (hπ i).ne_zero) ^ e i)
    (hu : ∀ i, ‖(u i : L i)‖ = 1)
    (hcard : ∀ i, Nat.card 𝓀[L i] = p ^ f i)
    (U : ∀ i, FinitePositiveRegion (L i)
      (normalizedIntegerHaar (K := L i))) :
    (FinitePositiveRegion.pi
        (fun i => normalizedIntegerHaar (K := L i))
        (fun i => mulPreimageRegion (a i) (U i))).logVolume =
      (FinitePositiveRegion.pi
        (fun i => normalizedIntegerHaar (K := L i)) U).logVolume +
        realTotalLocalDegree e f * Real.log (p : ℝ) := by
  rw [FinitePositiveRegion.logVolume_pi,
    FinitePositiveRegion.logVolume_pi]
  calc
    (∑ i, (mulPreimageRegion (a i) (U i)).logVolume) =
        ∑ i, ((U i).logVolume +
          ((e i : ℝ) * (f i : ℝ)) * Real.log (p : ℝ)) := by
      apply Finset.sum_congr rfl
      intro i hi
      rw [primeScalarPreimage_logVolume
        (π i) (hπ i) (a i) (u i) (e i) (ha i) (hu i) (U i),
        hcard i, Nat.cast_pow, Real.log_pow]
      ring
    _ = (∑ i, (U i).logVolume) +
        ∑ i, ((e i : ℝ) * (f i : ℝ)) * Real.log (p : ℝ) := by
      rw [Finset.sum_add_distrib]
    _ = (∑ i, (U i).logVolume) +
        realTotalLocalDegree e f * Real.log (p : ℝ) := by
      rw [realTotalLocalDegree, Finset.sum_mul]

/-- Genuine product Haar logarithm divided by total local degree. -/
noncomputable def refinedProductNormalizedLogVolume
    (e f : ι → ℕ)
    (U : ∀ i, FinitePositiveRegion (L i)
      (normalizedIntegerHaar (K := L i))) : ℝ :=
  (FinitePositiveRegion.pi
    (fun i => normalizedIntegerHaar (K := L i)) U).logVolume /
      realTotalLocalDegree e f

/-- Total-degree normalization converts the raw diagonal-prime Jacobian to
the exact `log p` coefficient. -/
theorem refinedProduct_primePreimage_normalizedLogVolume
    (p : ℕ)
    (π : ∀ i, 𝒪[L i]) (hπ : ∀ i, Irreducible (π i))
    (a u : ∀ i, (L i)ˣ) (e f : ι → ℕ)
    (ha : ∀ i, a i = u i *
      (integerUnit (π i) (hπ i).ne_zero) ^ e i)
    (hu : ∀ i, ‖(u i : L i)‖ = 1)
    (hcard : ∀ i, Nat.card 𝓀[L i] = p ^ f i)
    (he : ∀ i, 0 < e i) (hf : ∀ i, 0 < f i)
    (U : ∀ i, FinitePositiveRegion (L i)
      (normalizedIntegerHaar (K := L i))) :
    refinedProductNormalizedLogVolume e f
        (fun i => mulPreimageRegion (a i) (U i)) =
      refinedProductNormalizedLogVolume e f U + Real.log (p : ℝ) := by
  rw [refinedProductNormalizedLogVolume,
    refinedProductNormalizedLogVolume,
    refinedProduct_primePreimage_rawLogVolume
      p π hπ a u e f ha hu hcard U]
  have hD : realTotalLocalDegree e f ≠ 0 :=
    (realTotalLocalDegree_pos e f he hf).ne'
  field_simp

/-- Relative local-degree weights sum to one. -/
theorem relativeLocalDegreeWeight_sum_one
    (e f : ι → ℕ) (he : ∀ i, 0 < e i) (hf : ∀ i, 0 < f i) :
    (∑ i, ((e i : ℝ) * (f i : ℝ)) /
      realTotalLocalDegree e f) = 1 := by
  rw [← Finset.sum_div, realTotalLocalDegree]
  have hD : (∑ i, (e i : ℝ) * (f i : ℝ)) ≠ 0 := by
    simpa [realTotalLocalDegree] using
      (realTotalLocalDegree_pos e f he hf).ne'
  exact div_self hD

/-- Averaging individually degree-normalized primitive factor logarithms with
relative local-degree weights is exactly the normalized raw product Haar
logarithm. -/
theorem dimensionWeighted_factorFormula
    (e f : ι → ℕ) (he : ∀ i, 0 < e i) (hf : ∀ i, 0 < f i)
    (U : ∀ i, FinitePositiveRegion (L i)
      (normalizedIntegerHaar (K := L i))) :
    (∑ i,
      (((e i : ℝ) * (f i : ℝ)) / realTotalLocalDegree e f) *
        ((U i).logVolume / ((e i : ℝ) * (f i : ℝ)))) =
      refinedProductNormalizedLogVolume e f U := by
  have hD : realTotalLocalDegree e f ≠ 0 :=
    (realTotalLocalDegree_pos e f he hf).ne'
  calc
    (∑ i,
      (((e i : ℝ) * (f i : ℝ)) / realTotalLocalDegree e f) *
        ((U i).logVolume / ((e i : ℝ) * (f i : ℝ)))) =
        ∑ i, (U i).logVolume / realTotalLocalDegree e f := by
      apply Finset.sum_congr rfl
      intro i hi
      have hei : (e i : ℝ) ≠ 0 := by exact_mod_cast (he i).ne'
      have hfi : (f i : ℝ) ≠ 0 := by exact_mod_cast (hf i).ne'
      field_simp
    _ = (∑ i, (U i).logVolume) / realTotalLocalDegree e f := by
      rw [Finset.sum_div]
    _ = refinedProductNormalizedLogVolume e f U := by
      rw [refinedProductNormalizedLogVolume,
        FinitePositiveRegion.logVolume_pi]

end RefinedProduct

/-! ## Conservation of tuple weights under primitive refinement -/

section RefinedWeights

variable {C : Type v} [Fintype C]
variable {D : C → Type w} [∀ c, Fintype (D c)] [∀ c, Nonempty (D c)]

/-- Total primitive local degree inside one place tuple. -/
noncomputable def tupleTotalDegree (degree : ∀ c, D c → ℕ) (c : C) : ℝ :=
  ∑ d, (degree c d : ℝ)

/-- The canonical refined weight: tuple weight times relative primitive
degree. -/
noncomputable def refinedFactorWeight
    (tupleWeight : C → ℝ) (degree : ∀ c, D c → ℕ)
    (c : C) (d : D c) : ℝ :=
  tupleWeight c * (degree c d : ℝ) / tupleTotalDegree degree c

omit [Fintype C] in
/-- A refined primitive family conserves its parent tuple weight. -/
theorem sum_refinedFactorWeight_eq_tupleWeight
    (tupleWeight : C → ℝ) (degree : ∀ c, D c → ℕ)
    (hdegree : ∀ c d, 0 < degree c d) (c : C) :
    (∑ d, refinedFactorWeight tupleWeight degree c d) = tupleWeight c := by
  have hDpos : 0 < tupleTotalDegree degree c := by
    classical
    apply Finset.sum_pos'
    · intro d hd
      exact_mod_cast (hdegree c d).le
    · obtain ⟨d⟩ := ‹∀ c, Nonempty (D c)› c
      exact ⟨d, Finset.mem_univ d, by exact_mod_cast hdegree c d⟩
  have hD : tupleTotalDegree degree c ≠ 0 := hDpos.ne'
  simp_rw [refinedFactorWeight]
  rw [← Finset.sum_div, ← Finset.mul_sum]
  change tupleWeight c * tupleTotalDegree degree c /
    tupleTotalDegree degree c = tupleWeight c
  field_simp

/-- Refined weights preserve global normalization of the tuple weights. -/
theorem sum_refinedFactorWeight_eq_one
    (tupleWeight : C → ℝ) (degree : ∀ c, D c → ℕ)
    (hdegree : ∀ c d, 0 < degree c d)
    (htuple : ∑ c, tupleWeight c = 1) :
    (∑ c, ∑ d, refinedFactorWeight tupleWeight degree c d) = 1 := by
  calc
    (∑ c, ∑ d, refinedFactorWeight tupleWeight degree c d) =
        ∑ c, tupleWeight c := by
      apply Finset.sum_congr rfl
      intro c hc
      exact sum_refinedFactorWeight_eq_tupleWeight
        tupleWeight degree hdegree c
    _ = 1 := htuple

/-- Copying a normalized tuple weight to both primitive factors doubles the
prime-preimage coefficient. -/
theorem copied_twoFactor_weight_counterexample (p : ℕ) (hp : 1 < p) :
    (1 : ℝ) * Real.log (p : ℝ) +
        1 * Real.log (p : ℝ) ≠ Real.log (p : ℝ) := by
  have hlog : 0 < Real.log (p : ℝ) :=
    Real.log_pos (by exact_mod_cast hp)
  intro h
  have hz : Real.log (p : ℝ) = 0 := by
    linarith [h]
  exact hlog.ne' hz

/-- A single quadratic primitive factor has total degree two but factor count
one, so factor-count normalization leaves coefficient two. -/
theorem factorCount_normalization_counterexample (p : ℕ) (hp : 1 < p) :
    ((2 : ℝ) * Real.log (p : ℝ)) / 1 ≠ Real.log (p : ℝ) := by
  have hlog : 0 < Real.log (p : ℝ) :=
    Real.log_pos (by exact_mod_cast hp)
  intro h
  have hz : Real.log (p : ℝ) = 0 := by
    linarith [h]
  exact hlog.ne' hz

/-- The corrected equal-degree split on two factors has weights one half and
restores one prime coefficient. -/
theorem corrected_twoFactor_weight_shift (p : ℕ) :
    ((1 : ℝ) / 2) * Real.log (p : ℝ) +
        ((1 : ℝ) / 2) * Real.log (p : ℝ) = Real.log (p : ℝ) := by
  ring

end RefinedWeights

/-! ## Bounded open orbits are actual finite-positive regions -/

section OpenOrbit

variable {X : Type u} [TopologicalSpace X] [MeasurableSpace X]
variable [BorelSpace X]
variable (μ : Measure X) [μ.IsOpenPosMeasure]
variable [IsFiniteMeasureOnCompacts μ]
variable {A : Type v}

/-- Union of the images of a region under a family of homeomorphisms. -/
def homeomorphOrbitUnion (φ : A → X ≃ₜ X) (U : Set X) : Set X :=
  ⋃ a, φ a '' U

/-- A homeomorphism orbit of an open region is open even for an arbitrary
index type. -/
theorem homeomorphOrbitUnion_isOpen
    (φ : A → X ≃ₜ X) {U : Set X} (hU : IsOpen U) :
    IsOpen (homeomorphOrbitUnion φ U) := by
  apply isOpen_iUnion
  intro a
  exact (φ a).isOpenMap U hU

/-- An identity member puts the original region inside its orbit union. -/
theorem subset_homeomorphOrbitUnion_of_identity
    (φ : A → X ≃ₜ X) {U : Set X} (a₀ : A)
    (hidentity : φ a₀ = Homeomorph.refl X) :
    U ⊆ homeomorphOrbitUnion φ U := by
  intro x hx
  apply Set.mem_iUnion.mpr
  refine ⟨a₀, ?_⟩
  rw [hidentity]
  exact ⟨x, hx, rfl⟩

/-- Coordinatewise bounds on every image bound the complete orbit union. -/
theorem homeomorphOrbitUnion_subset_envelope
    (φ : A → X ≃ₜ X) {U E : Set X}
    (hbound : ∀ a, φ a '' U ⊆ E) :
    homeomorphOrbitUnion φ U ⊆ E := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨a, hxa⟩
  exact hbound a hxa

/-- A common relatively compact envelope makes the orbit union relatively
compact. -/
theorem homeomorphOrbitUnion_closure_compact
    (φ : A → X ≃ₜ X) {U E : Set X}
    (hbound : ∀ a, φ a '' U ⊆ E)
    (hE : IsCompact (closure E)) :
    IsCompact (closure (homeomorphOrbitUnion φ U)) := by
  apply IsCompact.of_isClosed_subset hE isClosed_closure
  exact closure_mono
    (homeomorphOrbitUnion_subset_envelope φ hbound)

/-- For a finite family, compactness of the seed itself propagates to the
orbit union. -/
theorem homeomorphOrbitUnion_isCompact [Finite A]
    (φ : A → X ≃ₜ X) {U : Set X} (hU : IsCompact U) :
    IsCompact (homeomorphOrbitUnion φ U) := by
  apply isCompact_iUnion
  intro a
  exact hU.image (φ a).continuous

/-- A finite homeomorphism orbit of a nonempty compact-open seed is itself
an actual finite-positive compact-open region. -/
noncomputable def finiteHomeomorphOrbitCompactOpenRegion [Finite A]
    (φ : A → X ≃ₜ X) (U : FinitePositiveCompactOpenRegion X μ)
    (a₀ : A) (hidentity : φ a₀ = Homeomorph.refl X) :
    FinitePositiveCompactOpenRegion X μ where
  toFinitePositiveRegion := {
    carrier := homeomorphOrbitUnion φ U.toFinitePositiveRegion
    measurable :=
      (homeomorphOrbitUnion_isOpen φ U.isOpen).measurableSet
    measure_ne_zero := by
      have hnonempty :
          (U.toFinitePositiveRegion : Set X).Nonempty := by
        rw [Set.nonempty_iff_ne_empty]
        intro h
        apply U.toFinitePositiveRegion.measure_ne_zero
        change μ (U.toFinitePositiveRegion : Set X) = 0
        rw [h, measure_empty]
      have hnonemptyInterior :
          (interior (homeomorphOrbitUnion φ
            U.toFinitePositiveRegion)).Nonempty := by
        rw [(homeomorphOrbitUnion_isOpen φ U.isOpen).interior_eq]
        exact hnonempty.mono
          (subset_homeomorphOrbitUnion_of_identity φ a₀ hidentity)
      exact
        (Measure.measure_pos_of_nonempty_interior μ hnonemptyInterior).ne'
    measure_ne_top :=
      (homeomorphOrbitUnion_isCompact φ U.isCompact).measure_ne_top
  }
  isCompact := homeomorphOrbitUnion_isCompact φ U.isCompact
  isOpen := homeomorphOrbitUnion_isOpen φ U.isOpen

/-- **Actual theta-orbit admissibility.**  A nonempty open homeomorphism
orbit inside one relatively compact envelope has finite positive measure. -/
noncomputable def boundedOpenOrbitRegion
    (φ : A → X ≃ₜ X) (U E : Set X)
    (hUopen : IsOpen U) (hUnonempty : U.Nonempty)
    (a₀ : A) (hidentity : φ a₀ = Homeomorph.refl X)
    (hbound : ∀ a, φ a '' U ⊆ E)
    (hE : IsCompact (closure E)) :
    FinitePositiveRegion X μ where
  carrier := homeomorphOrbitUnion φ U
  measurable := (homeomorphOrbitUnion_isOpen φ hUopen).measurableSet
  measure_ne_zero := by
    have hnonemptyInterior :
        (interior (homeomorphOrbitUnion φ U)).Nonempty := by
      rw [(homeomorphOrbitUnion_isOpen φ hUopen).interior_eq]
      exact hUnonempty.mono
        (subset_homeomorphOrbitUnion_of_identity φ a₀ hidentity)
    exact
      (Measure.measure_pos_of_nonempty_interior μ hnonemptyInterior).ne'
  measure_ne_top := by
    have hcompact :
        IsCompact (closure (homeomorphOrbitUnion φ U)) :=
      homeomorphOrbitUnion_closure_compact φ hbound hE
    exact ne_top_of_le_ne_top hcompact.measure_ne_top
      (measure_mono subset_closure)

@[simp]
theorem coe_boundedOpenOrbitRegion
    (φ : A → X ≃ₜ X) (U E : Set X)
    (hUopen : IsOpen U) (hUnonempty : U.Nonempty)
    (a₀ : A) (hidentity : φ a₀ = Homeomorph.refl X)
    (hbound : ∀ a, φ a '' U ⊆ E)
    (hE : IsCompact (closure E)) :
    ((boundedOpenOrbitRegion μ φ U E hUopen hUnonempty a₀ hidentity
      hbound hE : FinitePositiveRegion X μ) : Set X) =
        homeomorphOrbitUnion φ U := by
  change (boundedOpenOrbitRegion μ φ U E hUopen hUnonempty a₀ hidentity
    hbound hE).carrier = homeomorphOrbitUnion φ U
  rfl

end OpenOrbit

/-! ## Open upper-semicompatible Ind1--Ind3 systems -/

section UpperSemicompatibleOpen

variable {X : Type y} [TopologicalSpace X] [MeasurableSpace X]
variable [BorelSpace X]
variable (μ : Measure X) [μ.IsOpenPosMeasure]
variable [IsFiniteMeasureOnCompacts μ]

variable
  (S : UpperSemicompatiblePossibleImageSystem.{u, v, w, x, y} X)

/-- Openness propagates through the exact inductive Ind1--Ind3 syntax once
each source operation has the displayed topological property. -/
theorem reachable_isOpen
    (hordinary : ∀ o, IsOpen (S.ordinaryRegion o))
    (hind1 : ∀ a U, IsOpen U → IsOpen (S.act1 a U))
    (hind2 : ∀ a U, IsOpen U → IsOpen (S.act2 a U))
    (hind3 : ∀ a U V, IsOpen U → S.step3 a U V → IsOpen V)
    {U : Set X} (hU : S.Reachable U) :
    IsOpen U := by
  induction hU with
  | ordinary o => exact hordinary o
  | ind1 a hU ih => exact hind1 a _ ih
  | ind2 a hU ih => exact hind2 a _ ih
  | ind3 a hU hUV ih => exact hind3 a _ _ ih hUV

/-- The complete possible-image union is open. -/
theorem possibleUnion_isOpen
    (hordinary : ∀ o, IsOpen (S.ordinaryRegion o))
    (hind1 : ∀ a U, IsOpen U → IsOpen (S.act1 a U))
    (hind2 : ∀ a U, IsOpen U → IsOpen (S.act2 a U))
    (hind3 : ∀ a U V, IsOpen U → S.step3 a U V → IsOpen V) :
    IsOpen S.possibleUnion := by
  apply isOpen_iUnion
  intro o
  exact reachable_isOpen S hordinary hind1 hind2 hind3 o.2

/-- A nonempty native branch makes the complete possible-image union
nonempty. -/
theorem possibleUnion_nonempty
    (hnative : S.nativeRegion.Nonempty) :
    S.possibleUnion.Nonempty :=
  hnative.mono S.actualNativeImage

/-- The envelope field already carried by the generated syntax makes the
closure of the possible-image union compact whenever the envelope closure is
compact. -/
theorem possibleUnion_closure_compact
    (hE : IsCompact (closure S.envelope)) :
    IsCompact (closure S.possibleUnion) := by
  apply IsCompact.of_isClosed_subset hE isClosed_closure
  exact closure_mono S.actualPossibleImageEnvelope

/-- The complete open possible-image union is an actual finite-positive
measure region, rather than a region whose desired volume properties are
stored in an input field. -/
noncomputable def possibleUnionFinitePositiveRegion
    (hordinary : ∀ o, IsOpen (S.ordinaryRegion o))
    (hind1 : ∀ a U, IsOpen U → IsOpen (S.act1 a U))
    (hind2 : ∀ a U, IsOpen U → IsOpen (S.act2 a U))
    (hind3 : ∀ a U V, IsOpen U → S.step3 a U V → IsOpen V)
    (hnative : S.nativeRegion.Nonempty)
    (hE : IsCompact (closure S.envelope)) :
    FinitePositiveRegion X μ where
  carrier := S.possibleUnion
  measurable :=
    (possibleUnion_isOpen S hordinary hind1 hind2 hind3).measurableSet
  measure_ne_zero := by
    have hnonemptyInterior : (interior S.possibleUnion).Nonempty := by
      rw [(possibleUnion_isOpen S hordinary hind1 hind2 hind3).interior_eq]
      exact possibleUnion_nonempty S hnative
    exact
      (Measure.measure_pos_of_nonempty_interior μ hnonemptyInterior).ne'
  measure_ne_top := by
    exact ne_top_of_le_ne_top
      (possibleUnion_closure_compact S hE).measure_ne_top
      (measure_mono subset_closure)

@[simp]
theorem coe_possibleUnionFinitePositiveRegion
    (hordinary : ∀ o, IsOpen (S.ordinaryRegion o))
    (hind1 : ∀ a U, IsOpen U → IsOpen (S.act1 a U))
    (hind2 : ∀ a U, IsOpen U → IsOpen (S.act2 a U))
    (hind3 : ∀ a U V, IsOpen U → S.step3 a U V → IsOpen V)
    (hnative : S.nativeRegion.Nonempty)
    (hE : IsCompact (closure S.envelope)) :
    ((possibleUnionFinitePositiveRegion μ S hordinary hind1 hind2 hind3
      hnative hE : FinitePositiveRegion X μ) : Set X) =
        S.possibleUnion :=
  rfl

/-- Once an actual finite-positive region is identified with the native
q-pilot, source-generated native inclusion supplies the first same-pilot
volume inequality. -/
theorem native_logVolume_le_possibleUnion
    (hordinary : ∀ o, IsOpen (S.ordinaryRegion o))
    (hind1 : ∀ a U, IsOpen U → IsOpen (S.act1 a U))
    (hind2 : ∀ a U, IsOpen U → IsOpen (S.act2 a U))
    (hind3 : ∀ a U V, IsOpen U → S.step3 a U V → IsOpen V)
    (hnative : S.nativeRegion.Nonempty)
    (hE : IsCompact (closure S.envelope))
    (P : FinitePositiveRegion X μ)
    (hP : (P : Set X) = S.nativeRegion) :
    P.logVolume ≤
      (possibleUnionFinitePositiveRegion μ S hordinary hind1 hind2 hind3
        hnative hE).logVolume := by
  apply FinitePositiveRegion.logVolume_mono
  rw [coe_possibleUnionFinitePositiveRegion, hP]
  exact S.actualNativeImage

/-- Actual-Haar same-pilot sandwich: pointed native inclusion and an output
hull inclusion are sufficient for the numerical comparison. -/
theorem samePilot_logVolume_sandwich
    (P Θ H : FinitePositiveRegion X μ)
    (hPΘ : (P : Set X) ⊆ (Θ : Set X))
    (hΘH : (Θ : Set X) ⊆ (H : Set X)) :
    P.logVolume ≤ Θ.logVolume ∧ Θ.logVolume ≤ H.logVolume :=
  ⟨FinitePositiveRegion.logVolume_mono hPΘ,
    FinitePositiveRegion.logVolume_mono hΘH⟩

/-- An independent output hull bound transfers to the pointed native pilot. -/
theorem samePilot_bound
    (P Θ H : FinitePositiveRegion X μ) {T : ℝ}
    (hPΘ : (P : Set X) ⊆ (Θ : Set X))
    (hΘH : (Θ : Set X) ⊆ (H : Set X))
    (hHT : H.logVolume ≤ T) :
    P.logVolume ≤ T :=
  ((samePilot_logVolume_sandwich μ P Θ H hPΘ hΘH).1.trans
    (samePilot_logVolume_sandwich μ P Θ H hPΘ hΘH).2).trans hHT

end UpperSemicompatibleOpen

/-! ## Exact counterexamples at the remaining logical seams -/

section Counterexamples

/-- A minimal upper-semicompatible system whose Ind3 relation collapses an
open native region to a zero-measure singleton while preserving one compact
envelope. -/
noncomputable def ind3SingletonCollapseSystem :
    UpperSemicompatiblePossibleImageSystem.{0, 0, 0, 0, 0} ℝ where
  Ordinary := Unit
  Ind1 := Unit
  Ind2 := Unit
  Ind3 := Unit
  ordinaryRegion _ := Set.Ioo (-1 : ℝ) 1
  act1 _ U := U
  act2 _ U := U
  step3 _ _ V := V = {0}
  native := ()
  envelope := Set.Icc (-1 : ℝ) 1
  ordinary_le_envelope := by
    intro o x hx
    exact ⟨hx.1.le, hx.2.le⟩
  ind1_preserves_envelope := by
    intro a U hU
    exact hU
  ind2_preserves_envelope := by
    intro a U hU
    exact hU
  ind3_preserves_envelope := by
    intro a U V hU hUV
    subst V
    intro z hz
    subst z
    norm_num

/-- The zero-measure singleton is genuinely Ind3-reachable. -/
theorem ind3Singleton_reachable :
    ind3SingletonCollapseSystem.Reachable ({0} : Set ℝ) := by
  apply UpperSemicompatibleReachable.ind3 ()
    (UpperSemicompatibleReachable.ordinary ())
  rfl

/-- Full-premise pressure test: native and Ind3 target both stay in the same
compact envelope, but the target has zero Haar measure. -/
theorem envelope_preservation_not_enough_for_ind3_admissibility :
    (Set.Ioo (-1 : ℝ) 1).Nonempty ∧
      Set.Ioo (-1 : ℝ) 1 ⊆ Set.Icc (-1 : ℝ) 1 ∧
      ({0} : Set ℝ) ⊆ Set.Icc (-1 : ℝ) 1 ∧
      IsCompact (Set.Icc (-1 : ℝ) 1) ∧
      ind3SingletonCollapseSystem.Reachable ({0} : Set ℝ) ∧
      volume ({0} : Set ℝ) = 0 := by
  refine ⟨⟨0, by norm_num⟩, ?_, ?_, isCompact_Icc,
    ind3Singleton_reachable, by simp⟩
  · intro z hz
    exact ⟨hz.1.le, hz.2.le⟩
  · intro z hz
    subst z
    norm_num

/-- Finite counting-measure counterexample to an unpointed comparison: an
output and its envelope can both have mass one while an unrelated native
pilot has mass two. -/
theorem unpointed_finitePositive_bound_counterexample :
    let P : Finset (Fin 3) := {0, 1}
    let Θ : Finset (Fin 3) := {0}
    let H : Finset (Fin 3) := {0}
    Θ ⊆ H ∧ P.card = 2 ∧ Θ.card = 1 ∧ H.card = 1 ∧
      ¬ P ⊆ Θ ∧
      ¬ Real.log (P.card : ℝ) ≤ Real.log (H.card : ℝ) := by
  dsimp
  constructor
  · simp
  constructor
  · decide
  constructor
  · decide
  constructor
  · decide
  constructor
  · decide
  · have hPcard : ({0, 1} : Finset (Fin 3)).card = 2 := by decide
    have hHcard : ({0} : Finset (Fin 3)).card = 1 := by decide
    rw [hPcard, hHcard]
    simpa only [Nat.cast_ofNat, Nat.cast_one, Real.log_one, not_le] using
      (Real.log_pos (by norm_num : (1 : ℝ) < 2))

end Counterexamples

/-! ## Direct connection to the refined finite-etale factors -/

section RefinedFactorConnection

variable (p : ℕ) [Fact p.Prime]
variable {Tuple : Type v}
variable (P : TupleFiniteEtalePacket.{0, v, w} ℚ_[p] Tuple)

/-- On an actual primitive tensor factor, the rational prime is a unit times
the ramification-index power of every chosen uniformizer. -/
theorem refinedFactor_prime_factorization
    (d : P.RefinedComponent)
    (π : (refinedFactorLocalFieldData p P d).ringOfIntegers)
    (hπ : Irreducible π) :
    ∃ unit : (refinedFactorLocalFieldData p P d).ringOfIntegersˣ,
      mixedCharPrimeInteger p (P.Summand d)
          (refinedFactorLocalFieldData p P d) =
        (unit : (refinedFactorLocalFieldData p P d).ringOfIntegers) *
          π ^ (refinedFactorLocalFieldData p P d).ramificationIndex ∧
      (refinedFactorLocalFieldData p P d).valuation
          (unit : P.Summand d) = 1 :=
  mixedChar_prime_eq_unit_mul_uniformizer_pow_ramificationIndex
    p (P.Summand d) (refinedFactorLocalFieldData p P d) π hπ

/-- The actual primitive tensor factor has local degree `e f`. -/
theorem refinedFactor_localDegree_eq
    (d : P.RefinedComponent) :
    (refinedFactorLocalFieldData p P d).ramificationIndex *
        (refinedFactorLocalFieldData p P d).residueDegree =
      Module.finrank ℚ_[p] (P.Summand d) :=
  mixedChar_ramification_mul_residueDegree
    p (P.Summand d) (refinedFactorLocalFieldData p P d)

/-- The actual primitive tensor factor has residue cardinality `p^f`. -/
theorem refinedFactor_residueField_natCard
    (d : P.RefinedComponent) :
    Nat.card
        (IsLocalRing.ResidueField
          (refinedFactorLocalFieldData p P d).ringOfIntegers) =
      p ^ (refinedFactorLocalFieldData p P d).residueDegree :=
  mixedChar_residueField_natCard
    p (P.Summand d) (refinedFactorLocalFieldData p P d)

/-- Finiteness of the primitive-factor index inside one tuple, obtained from
the Artinian structure of its finite-dimensional algebra. -/
noncomputable instance tupleMaximalSpectrumFintype (c : Tuple) :
    Fintype (MaximalSpectrum (P.AlgebraAt c)) := by
  letI : IsArtinianRing (P.AlgebraAt c) :=
    IsArtinianRing.of_finite ℚ_[p] (P.AlgebraAt c)
  exact Fintype.ofFinite _

/-- The residue algebra at a maximal ideal of one tuple algebra is a field.
This quotient-shaped instance lets the finite-product dimension theorem be
elaborated before the maximal ideal has been packaged as a sigma component. -/
noncomputable instance tuplePrimitiveQuotientField
    (c : Tuple) (m : MaximalSpectrum (P.AlgebraAt c)) :
    Field (P.AlgebraAt c ⧸ m.asIdeal) :=
  Ideal.Quotient.field m.asIdeal

/-- Dimension conservation on one actual place tuple: the tensor-algebra
dimension is the sum of `e_d f_d` over its primitive field factors. -/
theorem tuple_finrank_eq_sum_refined_localDegrees (c : Tuple) :
    Module.finrank ℚ_[p] (P.AlgebraAt c) =
      ∑ m : MaximalSpectrum (P.AlgebraAt c),
        (refinedFactorLocalFieldData p P ⟨c, m⟩).ramificationIndex *
          (refinedFactorLocalFieldData p P ⟨c, m⟩).residueDegree := by
  letI : IsArtinianRing (P.AlgebraAt c) :=
    IsArtinianRing.of_finite ℚ_[p] (P.AlgebraAt c)
  calc
    Module.finrank ℚ_[p] (P.AlgebraAt c) =
        Module.finrank ℚ_[p]
          (∀ m : MaximalSpectrum (P.AlgebraAt c),
            P.AlgebraAt c ⧸ m.asIdeal) :=
      (P.tupleCoordinates c).toLinearEquiv.finrank_eq
    _ = ∑ m : MaximalSpectrum (P.AlgebraAt c),
          Module.finrank ℚ_[p] (P.AlgebraAt c ⧸ m.asIdeal) :=
      Module.finrank_pi_fintype ℚ_[p]
    _ = ∑ m : MaximalSpectrum (P.AlgebraAt c),
          (refinedFactorLocalFieldData p P ⟨c, m⟩).ramificationIndex *
            (refinedFactorLocalFieldData p P ⟨c, m⟩).residueDegree := by
      apply Finset.sum_congr rfl
      intro m hm
      exact (refinedFactor_localDegree_eq p P ⟨c, m⟩).symm

/-- Every primitive factor constructed from the actual finite-etale tensor
packet has a positive ramification index. -/
theorem refinedFactor_ramificationIndex_pos
    (d : P.RefinedComponent) :
    0 < (refinedFactorLocalFieldData p P d).ramificationIndex :=
  Iut4Sec1.MixedCharLocalFieldData.ramificationIndex_pos
    (refinedFactorLocalFieldData p P d)

/-- Every primitive factor's canonical spectral integer ring has finite
residue field. -/
theorem refinedFactor_residueField_finite
    (d : P.RefinedComponent) :
    Finite
      (IsLocalRing.ResidueField
        (refinedFactorLocalFieldData p P d).ringOfIntegers) :=
  Iut4Sec1.MixedCharLocalFieldData.residueFieldFinite
    (refinedFactorLocalFieldData p P d)

end RefinedFactorConnection

#print axioms exists_normOne_unit_mul_uniformizer_pow
#print axioms mixedChar_prime_eq_unit_mul_uniformizer_pow_ramificationIndex
#print axioms baseResidue_natCard
#print axioms mixedChar_ramification_mul_residueDegree
#print axioms mixedChar_residueField_natCard
#print axioms realTotalLocalDegree_pos
#print axioms refinedProduct_primePreimage_rawLogVolume
#print axioms refinedProduct_primePreimage_normalizedLogVolume
#print axioms relativeLocalDegreeWeight_sum_one
#print axioms dimensionWeighted_factorFormula
#print axioms sum_refinedFactorWeight_eq_tupleWeight
#print axioms sum_refinedFactorWeight_eq_one
#print axioms copied_twoFactor_weight_counterexample
#print axioms factorCount_normalization_counterexample
#print axioms corrected_twoFactor_weight_shift
#print axioms homeomorphOrbitUnion_isOpen
#print axioms subset_homeomorphOrbitUnion_of_identity
#print axioms homeomorphOrbitUnion_closure_compact
#print axioms boundedOpenOrbitRegion
#print axioms reachable_isOpen
#print axioms possibleUnion_isOpen
#print axioms possibleUnion_closure_compact
#print axioms possibleUnionFinitePositiveRegion
#print axioms native_logVolume_le_possibleUnion
#print axioms samePilot_logVolume_sandwich
#print axioms samePilot_bound
#print axioms ind3Singleton_reachable
#print axioms envelope_preservation_not_enough_for_ind3_admissibility
#print axioms unpointed_finitePositive_bound_counterexample
#print axioms refinedFactor_prime_factorization
#print axioms refinedFactor_localDegree_eq
#print axioms refinedFactor_residueField_natCard
#print axioms tuple_finrank_eq_sum_refined_localDegrees
#print axioms refinedFactor_ramificationIndex_pos
#print axioms refinedFactor_residueField_finite

end IUTRefinedTensorHaarThetaSamePilot20260902
end IUTThreeClosures
