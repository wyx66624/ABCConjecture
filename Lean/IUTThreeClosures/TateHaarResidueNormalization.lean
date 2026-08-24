import IUTThreeClosures.HaarResidueNormalization

/-!
# From the Tate norm-uniformizer to residue-normalized Haar volume

The public Tate-parameter library defines a uniformizer by generation of the
norm value group.  Mathlib's DVR Haar calculation uses an irreducible element
of the valuation-integer ring.  This file proves the bridge between those two
concrete notions and then applies the local Haar normalization to a Tate
parameter.  No desired volume identity is stored in an input structure.
-/

namespace IUTThreeClosures
namespace TateHaarResidueNormalization

open MeasureTheory Set
open scoped ENNReal NNReal NormedField Pointwise Valued

universe u

open HaarResidueNormalization MaximalValuationRingHull TateCurvesTheta

variable {K : Type u}
variable [NontriviallyNormedField K] [IsUltrametricDist K]
variable [IsDiscreteValuationRing 𝒪[K]]

/-- A norm-uniformizer belongs to the valuation-integer ring. -/
def normUniformizerInteger (π : K) (hπ : TateCurvesTheta.IsUniformizer π) : 𝒪[K] :=
  ⟨π, Valued.integer.mem_iff.mpr hπ.norm_lt_one.le⟩

omit [IsDiscreteValuationRing 𝒪[K]] in
@[simp]
theorem normUniformizerInteger_coe
    (π : K) (hπ : TateCurvesTheta.IsUniformizer π) :
    (normUniformizerInteger π hπ : K) = π :=
  rfl

omit [IsDiscreteValuationRing 𝒪[K]] in
theorem normUniformizerInteger_ne_zero
    (π : K) (hπ : TateCurvesTheta.IsUniformizer π) :
    normUniformizerInteger π hπ ≠ 0 := by
  intro h
  apply hπ.ne_zero
  exact congrArg Subtype.val h

/-- The norm-generator definition used by the Tate library implies the DVR
uniformizer definition used by Mathlib: the corresponding valuation integer
is irreducible. -/
theorem normUniformizerInteger_irreducible
    (π : K) (hπ : TateCurvesTheta.IsUniformizer π) :
    Irreducible (normUniformizerInteger π hπ) := by
  let πO : 𝒪[K] := normUniformizerInteger π hπ
  have hπO0 : πO ≠ 0 := normUniformizerInteger_ne_zero π hπ
  obtain ⟨ϖ, hϖ⟩ := IsDiscreteValuationRing.exists_irreducible 𝒪[K]
  obtain ⟨n, u, hu⟩ :=
    IsDiscreteValuationRing.eq_unit_mul_pow_irreducible hπO0 hϖ
  have hfac : ‖π‖ = ‖(ϖ : K)‖ ^ n := by
    have h := congrArg (fun x : 𝒪[K] => ‖(x : K)‖) hu
    simpa [πO, norm_mul, norm_pow] using h
  have hϖK0 : (ϖ : K) ≠ 0 := by
    intro h
    apply hϖ.ne_zero
    exact Subtype.ext h
  obtain ⟨m, hm⟩ := hπ.generates (Units.mk0 (ϖ : K) hϖK0)
  have hm' : ‖(ϖ : K)‖ = ‖π‖ ^ m := by
    simpa using hm
  have hpowers :
      ‖π‖ ^ (1 : ℤ) = ‖π‖ ^ (m * (n : ℤ)) := by
    calc
      ‖π‖ ^ (1 : ℤ) = ‖π‖ := zpow_one _
      _ = ‖(ϖ : K)‖ ^ n := hfac
      _ = (‖π‖ ^ m) ^ n := by rw [hm']
      _ = ‖π‖ ^ (m * (n : ℤ)) := by
        rw [← zpow_natCast, ← zpow_mul]
  have hexponents : (1 : ℤ) = m * (n : ℤ) :=
    hπ.zpow_right_injective hpowers
  have hn_dvd_int : (n : ℤ) ∣ 1 := by
    refine ⟨m, ?_⟩
    simpa [mul_comm] using hexponents
  have hn_dvd : n ∣ 1 := by
    exact_mod_cast hn_dvd_int
  have hn : n = 1 := Nat.dvd_one.mp hn_dvd
  have hassociated : Associated πO ϖ := by
    simp [hu, hn]
  exact hassociated.symm.irreducible hϖ

omit [IsUltrametricDist K] [IsDiscreteValuationRing 𝒪[K]] in
/-- Pointwise multiplication by a field unit is the concrete scaled region
used in the valuation-ring calculation. -/
theorem unit_smul_normIntegralRegion (a : Kˣ) :
    a • normIntegralRegion (K := K) =
      scaledRegion (a : K) (normIntegralRegion (K := K)) := by
  ext x
  constructor
  · rintro ⟨y, hy, rfl⟩
    exact ⟨y, hy, by simp [smul_eq_mul]⟩
  · rintro ⟨y, hy, rfl⟩
    exact ⟨y, hy, by simp [smul_eq_mul]⟩

section Haar

variable [ProperSpace K] [MeasurableSpace K] [BorelSpace K]

omit [IsDiscreteValuationRing 𝒪[K]] in
/-- On a one-dimensional nonarchimedean field, the distributive Haar
character depends only on the norm of the scalar.  This is proved from equal
scaled valuation-integer balls, not postulated as a normalization axiom. -/
theorem distribHaarChar_eq_of_norm (a b : Kˣ)
    (h : ‖(a : K)‖ = ‖(b : K)‖) :
    distribHaarChar K a = distribHaarChar K b := by
  let μ : Measure K := normalizedIntegerHaar (K := K)
  letI : μ.IsAddHaarMeasure := by
    dsimp [μ, normalizedIntegerHaar]
    infer_instance
  have ha := distribHaarChar_mul (μ := μ) a
    (normIntegralRegion (K := K))
  have hb := distribHaarChar_mul (μ := μ) b
    (normIntegralRegion (K := K))
  have hunit : μ (normIntegralRegion (K := K)) = 1 :=
    normalizedIntegerHaar_apply_normIntegralRegion (K := K)
  have hset :
      a • normIntegralRegion (K := K) =
        b • normIntegralRegion (K := K) := by
    rw [unit_smul_normIntegralRegion, unit_smul_normIntegralRegion,
      scaled_normIntegralRegion_eq_normBall,
      scaled_normIntegralRegion_eq_normBall, h]
  rw [hunit, mul_one, hset] at ha
  rw [hunit, mul_one] at hb
  exact ENNReal.coe_injective (ha.trans hb.symm)

variable [Finite 𝓀[K]]

/-- The genuine Tate parameter has Haar character equal to the residue-card
uniformizer factor raised to its canonical normalized integer order. -/
theorem distribHaarChar_tateParameter
    (t : TateParameter K) (π : K)
    (hπ : TateCurvesTheta.IsUniformizer π) :
    distribHaarChar K t.q =
      ((Nat.card 𝓀[K] : ℝ≥0)⁻¹) ^ (t.toOrdered hπ).orderNat := by
  let πO : 𝒪[K] := normUniformizerInteger π hπ
  have hπirr : Irreducible πO := normUniformizerInteger_irreducible π hπ
  let πu : Kˣ := integerUnit πO hπirr.ne_zero
  have hnorm :
      ‖(t.q : K)‖ = ‖((πu ^ (t.toOrdered hπ).orderNat : Kˣ) : K)‖ := by
    rw [t.norm_q_eq_pow_orderNat hπ]
    simp [πu, πO, norm_pow]
  have hchar := distribHaarChar_eq_of_norm t.q
    (πu ^ (t.toOrdered hπ).orderNat) hnorm
  rw [map_pow, distribHaarChar_integerUnit_eq_residueCard_inv πO hπirr] at hchar
  exact hchar

/-- **Residue-normalized Tate formula.**  This is the requested local
numerical normalization, with the negative sign fixed by the fact that
`q 𝒪_K` is smaller than `𝒪_K`. -/
theorem log_distribHaarChar_tateParameter
    (t : TateParameter K) (π : K)
    (hπ : TateCurvesTheta.IsUniformizer π) :
    Real.log ((distribHaarChar K t.q : ℝ≥0) : ℝ) =
      -(t.toOrdered hπ).orderNat * Real.log (Nat.card 𝓀[K] : ℝ) := by
  rw [distribHaarChar_tateParameter t π hπ]
  simp only [NNReal.coe_pow, NNReal.coe_inv, NNReal.coe_natCast,
    Real.log_pow, Real.log_inv]
  ring

end Haar

end TateHaarResidueNormalization
end IUTThreeClosures
