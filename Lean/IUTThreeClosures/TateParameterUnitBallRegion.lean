import TateCurvesTheta.QParameter.NormalizedOrder

/-!
# A Tate parameter and its uniformizer power define the same norm-unit-ball region
-/

namespace TateCurvesTheta

variable {K : Type*} [NormedField K]

def normIntegralRegion : Set K := {x | ‖x‖ ≤ 1}

def scaledRegion (a : K) (U : Set K) : Set K :=
  (fun x => a * x) '' U

theorem scaledRegion_mul (a b : K) (U : Set K) :
    scaledRegion (a * b) U = scaledRegion a (scaledRegion b U) := by
  ext x
  constructor
  · rintro ⟨y, hy, rfl⟩
    exact ⟨b * y, ⟨y, hy, rfl⟩, by ring⟩
  · rintro ⟨z, ⟨y, hy, rfl⟩, rfl⟩
    exact ⟨y, hy, by ring⟩

theorem scaledRegion_normIntegral_of_norm_eq_one
    (u : K) (hu : ‖u‖ = 1) :
    scaledRegion u (normIntegralRegion (K := K)) =
      normIntegralRegion (K := K) := by
  have hu0 : u ≠ 0 := by
    intro h
    rw [h, norm_zero] at hu
    norm_num at hu
  ext x
  constructor
  · rintro ⟨y, hy, rfl⟩
    change ‖u * y‖ ≤ 1
    rw [norm_mul, hu]
    simpa [normIntegralRegion] using hy
  · intro hx
    refine ⟨u⁻¹ * x, ?_, ?_⟩
    · change ‖u⁻¹ * x‖ ≤ 1
      rw [norm_mul, norm_inv, hu]
      simpa [normIntegralRegion] using hx
    · simp [hu0, mul_assoc]

theorem scaledRegion_eq_of_norm_eq
    {a b : K} (hb : b ≠ 0) (hab : ‖a‖ = ‖b‖) :
    scaledRegion a (normIntegralRegion (K := K)) =
      scaledRegion b (normIntegralRegion (K := K)) := by
  let u : K := a / b
  have hu : ‖u‖ = 1 := by
    rw [u, norm_div, hab, div_self]
    exact norm_ne_zero_iff.mpr hb
  have ha : a = b * u := by
    dsimp [u]
    field_simp
  rw [ha, scaledRegion_mul,
    scaledRegion_normIntegral_of_norm_eq_one u hu]

namespace TateParameter

theorem scaledRegion_q_eq_uniformizerPower
    (t : TateParameter K) {π : K} (hπ : IsUniformizer π) :
    scaledRegion (t.q : K) (normIntegralRegion (K := K)) =
      scaledRegion (π ^ (t.toOrdered hπ).orderNat)
        (normIntegralRegion (K := K)) := by
  apply scaledRegion_eq_of_norm_eq
  · exact pow_ne_zero _ hπ.ne_zero
  · exact t.norm_q_eq_pow_orderNat hπ

end TateParameter
end TateCurvesTheta
