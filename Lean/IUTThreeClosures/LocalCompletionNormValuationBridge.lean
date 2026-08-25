/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.NumberTheory.LocalField.Basic
import Mathlib.NumberTheory.NumberField.Completion.FinitePlace
import Mathlib.NumberTheory.NumberField.Ideal.Basic

/-!
# The norm valuation on a finite-place completion

The adic completion of a number field carries two presentations of the same
rank-one valuation ring: its construction valuation with values in `ℤᵐ⁰`, and the
valuation with values in `ℝ≥0` derived from the resulting norm.  This file proves
that their integer subrings agree and transports the local structural facts
needed by the numerical Haar calculation.  No component-volume formula or
target estimate is an input.
-/

noncomputable section

namespace IUTThreeClosures
namespace LocalCompletionNormValuationBridge

open NumberField IsDedekindDomain Valued.integer
open scoped NNReal WithZero

universe u

variable {F : Type u} [Field F] [NumberField F]
variable (v : HeightOneSpectrum (𝓞 F))

/-- The valuation-integer subring defined directly by the norm on the finite
place completion. -/
def normIntegerRing : Subring (v.adicCompletion F) :=
  (NormedField.valuation (K := v.adicCompletion F)).integer

/-- The valuation-integer subring defined by the native `ℤᵐ⁰`-valued
construction valuation. -/
def nativeIntegerRing : Subring (v.adicCompletion F) :=
  ((inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v).integer

/-- The native integer subring is definitionally the integer ring bundled
with the adic completion. -/
theorem nativeIntegerRing_eq_adicCompletionIntegers :
    nativeIntegerRing v = (v.adicCompletionIntegers F).toSubring :=
  rfl

/-- The norm-derived and native valuation-integer subrings coincide. -/
theorem normIntegerRing_eq_nativeIntegerRing :
    normIntegerRing v = nativeIntegerRing v := by
  ext x
  change ‖x‖₊ ≤ 1 ↔
    (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v x ≤ 1
  rw [← NNReal.coe_le_coe]
  simp only [NNReal.coe_one, coe_nnnorm, FinitePlace.norm_def]
  exact WithZeroMulInt.toNNReal_le_one_iff
    (HeightOneSpectrum.one_lt_absNorm_nnreal v)

/-- The norm-derived integer ring is a DVR, transported from the native adic
completion integer ring through the preceding equality. -/
theorem normIntegerRingIsDiscreteValuationRing :
    IsDiscreteValuationRing (normIntegerRing v) := by
  rw [normIntegerRing_eq_nativeIntegerRing,
    nativeIntegerRing_eq_adicCompletionIntegers]
  change IsDiscreteValuationRing (v.adicCompletionIntegers F)
  letI : Finite (𝓞 F ⧸ v.asIdeal) := inferInstance
  infer_instance

/-- Every element of the completed valuation ring is congruent modulo its
maximal ideal to the image of a global integer.  This is the density step
needed to identify the completed residue field with a quotient of `𝓞 F`. -/
theorem exists_globalInteger_sub_lt_one
    (x : v.adicCompletionIntegers F) :
    ∃ r : 𝓞 F,
      (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
        (algebraMap (𝓞 F) (v.adicCompletion F) r -
          (x : v.adicCompletion F)) < 1 := by
  obtain ⟨k, hk⟩ := (v.denseRange_algebraMap F).exists_dist_lt
    (x : v.adicCompletion F) zero_lt_one
  have hknorm :
      ‖algebraMap F (v.adicCompletion F) k - (x : v.adicCompletion F)‖ < 1 := by
    have :
        ‖(x : v.adicCompletion F) - algebraMap F (v.adicCompletion F) k‖ < 1 := by
      simpa only [dist_eq_norm] using hk
    simpa only [norm_sub_rev] using this
  have hkclose :
      (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
        (algebraMap F (v.adicCompletion F) k -
          (x : v.adicCompletion F)) < 1 := by
    rw [FinitePlace.norm_def] at hknorm
    rw [← NNReal.coe_one, NNReal.coe_lt_coe] at hknorm
    exact (WithZeroMulInt.toNNReal_lt_one_iff
      (HeightOneSpectrum.one_lt_absNorm_nnreal v)).mp hknorm
  have hkintCompletion :
      (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
        (algebraMap F (v.adicCompletion F) k) ≤ 1 := by
    calc
      (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
          (algebraMap F (v.adicCompletion F) k) =
          (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
            ((algebraMap F (v.adicCompletion F) k - (x : v.adicCompletion F)) + x) := by
              rw [sub_add_cancel]
      _ ≤ max
          ((inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
            (algebraMap F (v.adicCompletion F) k - (x : v.adicCompletion F)))
          ((inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v x) :=
        map_add_le_max _ _ _
      _ ≤ 1 := max_le hkclose.le x.property
  have hkint : v.valuation F k ≤ 1 := by
    change (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
      (k : v.adicCompletion F) ≤ 1 at hkintCompletion
    simpa only [HeightOneSpectrum.valuedAdicCompletion_eq_valuation'] using hkintCompletion
  obtain ⟨r, hr⟩ :=
    v.exists_valuation_sub_lt_of_integer hkint (1 : (ℤᵐ⁰)ˣ)
  have hrclose :
      (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
        (algebraMap F (v.adicCompletion F)
          (algebraMap (𝓞 F) F r - k)) < 1 := by
    change (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
      ((algebraMap (𝓞 F) F r - k : F) : v.adicCompletion F) < 1
    rw [HeightOneSpectrum.valuedAdicCompletion_eq_valuation']
    simpa using hr
  refine ⟨r, ?_⟩
  have hdecomp :
      algebraMap (𝓞 F) (v.adicCompletion F) r - (x : v.adicCompletion F) =
        algebraMap F (v.adicCompletion F) (algebraMap (𝓞 F) F r - k) +
          (algebraMap F (v.adicCompletion F) k - (x : v.adicCompletion F)) := by
    rw [map_sub,
      IsScalarTower.algebraMap_apply (𝓞 F) F (v.adicCompletion F)]
    ring
  rw [hdecomp]
  exact lt_of_le_of_lt (map_add_le_max _ _ _)
    (max_lt hrclose hkclose)

/-- Reduction of global integers into the native completed residue field. -/
def globalIntegerToNativeResidue :
    𝓞 F →+* IsLocalRing.ResidueField (v.adicCompletionIntegers F) :=
  (IsLocalRing.residue (v.adicCompletionIntegers F)).comp
    (algebraMap (𝓞 F) (v.adicCompletionIntegers F))

/-- Membership in the maximal ideal of the bundled adic integer ring is the
strict native-valuation inequality.  Keeping this as a named bridge avoids
mixing the two definitional order-instance paths on `ℤᵐ⁰`. -/
theorem mem_nativeMaximalIdeal_iff (a : v.adicCompletionIntegers F) :
    a ∈ IsLocalRing.maximalIdeal (v.adicCompletionIntegers F) ↔
      (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
        (a : v.adicCompletion F) < 1 := by
  change a ∈ IsLocalRing.maximalIdeal
      ((inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v.valuationSubring) ↔ _
  exact Valuation.mem_maximalIdeal_iff
    (v.adicCompletion F)
    ((inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v) (a := a)

/-- The global-integer reduction map is onto the completed residue field. -/
theorem globalIntegerToNativeResidue_surjective :
    Function.Surjective (globalIntegerToNativeResidue v) := by
  intro y
  obtain ⟨x, rfl⟩ := IsLocalRing.residue_surjective (R := v.adicCompletionIntegers F) y
  obtain ⟨r, hr⟩ := exists_globalInteger_sub_lt_one v x
  refine ⟨r, ?_⟩
  change IsLocalRing.residue (v.adicCompletionIntegers F)
      (algebraMap (𝓞 F) (v.adicCompletionIntegers F) r) =
    IsLocalRing.residue (v.adicCompletionIntegers F) x
  apply sub_eq_zero.mp
  rw [← map_sub, IsLocalRing.residue_eq_zero_iff,
    mem_nativeMaximalIdeal_iff]
  change (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
    (((algebraMap (𝓞 F) (v.adicCompletionIntegers F) r :
      v.adicCompletionIntegers F) : v.adicCompletion F) -
        (x : v.adicCompletion F)) < 1
  rw [HeightOneSpectrum.algebraMap_adicCompletionIntegers_apply]
  exact hr

/-- A global integer lying in `v` reduces to zero in the completed residue
field. -/
theorem globalIntegerToNativeResidue_eq_zero_of_mem
    (r : 𝓞 F) (hr : r ∈ v.asIdeal) :
    globalIntegerToNativeResidue v r = 0 := by
  rw [globalIntegerToNativeResidue, RingHom.comp_apply,
    IsLocalRing.residue_eq_zero_iff, mem_nativeMaximalIdeal_iff]
  change (inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v
    ((algebraMap (𝓞 F) F r : F) : v.adicCompletion F) < 1
  rw [HeightOneSpectrum.valuedAdicCompletion_eq_valuation']
  exact (v.valuation_lt_one_iff_mem (K := F) r).mpr hr

/-- The induced map from the finite global residue quotient. -/
def globalResidueQuotientToNativeResidue :
    (𝓞 F ⧸ v.asIdeal) →+*
      IsLocalRing.ResidueField (v.adicCompletionIntegers F) :=
  Ideal.Quotient.lift v.asIdeal (globalIntegerToNativeResidue v)
    (globalIntegerToNativeResidue_eq_zero_of_mem v)

/-- The induced map from the global residue quotient remains surjective. -/
theorem globalResidueQuotientToNativeResidue_surjective :
    Function.Surjective (globalResidueQuotientToNativeResidue v) := by
  intro y
  obtain ⟨r, hr⟩ := globalIntegerToNativeResidue_surjective v y
  refine ⟨Ideal.Quotient.mk v.asIdeal r, ?_⟩
  simpa [globalResidueQuotientToNativeResidue] using hr

/-- The native completed residue field is finite because it is a quotient of
the finite global residue ring `𝓞 F / v`. -/
theorem nativeResidueFinite :
    Finite (IsLocalRing.ResidueField (v.adicCompletionIntegers F)) :=
  Finite.of_surjective (globalResidueQuotientToNativeResidue v)
    (globalResidueQuotientToNativeResidue_surjective v)

/-- Local-ring structure for the explicit norm integer ring, obtained from
the transported DVR theorem. -/
local instance normIntegerRingDVR :
    IsDiscreteValuationRing (normIntegerRing v) :=
  normIntegerRingIsDiscreteValuationRing v

/-- The identity on the completed field restricts to an equivalence from the
norm integer ring to the bundled native adic integer ring. -/
def normIntegerRingEquivNative :
    normIntegerRing v ≃+* v.adicCompletionIntegers F where
  toFun x := ⟨x, by
    have hO : normIntegerRing v =
        (v.adicCompletionIntegers F).toSubring :=
      (normIntegerRing_eq_nativeIntegerRing v).trans
        (nativeIntegerRing_eq_adicCompletionIntegers v)
    exact (SetLike.ext_iff.mp hO (x : v.adicCompletion F)).mp x.property⟩
  invFun x := ⟨x, by
    have hO : normIntegerRing v =
        (v.adicCompletionIntegers F).toSubring :=
      (normIntegerRing_eq_nativeIntegerRing v).trans
        (nativeIntegerRing_eq_adicCompletionIntegers v)
    exact (SetLike.ext_iff.mp hO (x : v.adicCompletion F)).mpr x.property⟩
  left_inv x := Subtype.ext rfl
  right_inv x := Subtype.ext rfl
  map_mul' _ _ := rfl
  map_add' _ _ := rfl

/-- The corresponding residue fields are canonically equivalent. -/
def normResidueEquivNative :
    IsLocalRing.ResidueField (normIntegerRing v) ≃+*
      IsLocalRing.ResidueField (v.adicCompletionIntegers F) :=
  IsLocalRing.ResidueField.mapEquiv (normIntegerRingEquivNative v)

/-- Finiteness transported to the residue field of the norm-derived integer
ring. -/
theorem normResidueFinite :
    Finite (IsLocalRing.ResidueField (normIntegerRing v)) := by
  letI : Finite (IsLocalRing.ResidueField (v.adicCompletionIntegers F)) :=
    nativeResidueFinite v
  exact Finite.of_injective (normResidueEquivNative v)
    (normResidueEquivNative v).injective

/-- The norm on a finite-place completion is ultrametric; this is inherited
from its native rank-one valuation. -/
theorem completionIsUltrametricDist :
    IsUltrametricDist (v.adicCompletion F) := by
  infer_instance

/-- The finite-place completion is proper: it is complete, its norm-integer
ring is a DVR, and its residue field is finite.  We apply the criterion through
the native `ℤᵐ⁰` valuation, whose induced normed-field structure is
definitionally the canonical one on the adic completion. -/
theorem completionProperSpace : ProperSpace (v.adicCompletion F) := by
  letI : Finite (𝓞 F ⧸ v.asIdeal) := inferInstance
  letI : IsDiscreteValuationRing
      ((inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v.integer) := by
    change IsDiscreteValuationRing (v.adicCompletionIntegers F)
    infer_instance
  letI : Finite
      (IsLocalRing.ResidueField
        ((inferInstance : Valued (v.adicCompletion F) ℤᵐ⁰).v.integer)) := by
    change Finite
      (IsLocalRing.ResidueField (v.adicCompletionIntegers F))
    exact nativeResidueFinite v
  exact
    (properSpace_iff_completeSpace_and_isDiscreteValuationRing_integer_and_finite_residueField
      (K := v.adicCompletion F) (Γ₀ := ℤᵐ⁰)).mpr
        ⟨inferInstance, inferInstance, inferInstance⟩

end LocalCompletionNormValuationBridge
end IUTThreeClosures
