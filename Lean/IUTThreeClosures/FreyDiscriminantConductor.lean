import IUTThreeClosures.ABCFreyCurve
import IUTThreeClosures.NonCircularDownstream
import Mathlib.RingTheory.Radical.NatInt

/-!
# Radical support of the Frey discriminant

For the integral Frey equation attached to an abc point,

`Δ = 16 (abc)²`.

The radical of this discriminant has exactly the same point-dependent prime
support as `abc`; the only additional possible prime comes from the fixed
factor `16`. This file proves the corresponding uniform comparison without
introducing a freely populated conductor function:

`rad(abc) ≤ rad(16 (abc)²) ≤ 16 rad(abc)`.

Consequently the logarithmic conductor of the Frey discriminant differs from
the elementary abc conductor by a quantity in `[0, log 16]`. The constant can
later be sharpened to `log 2`, but the present bound is already uniform and is
sufficient to remove the conductor comparison as a conceptual gap in the
source-derived bridge.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid

/-- The repository's elementary radical is Mathlib's UFM radical on naturals. -/
theorem abcRadical_eq_natRadical (n : ℕ) :
    abcRadical n = radical n := by
  rw [Nat.radical_eq_prod_primeFactors]
  rfl

/-- The elementary radical is always positive, including at zero. -/
theorem abcRadical_pos (n : ℕ) : 0 < abcRadical n := by
  rw [abcRadical_eq_natRadical]
  exact Nat.radical_pos n

namespace ABCPoint

/-- The positive natural discriminant underlying the rational Frey
Weierstrass discriminant. -/
def freyDiscriminantNat (P : ABCPoint) : ℕ :=
  16 * (P.a * P.b * P.c) ^ 2

@[simp]
theorem freyDiscriminantNat_pos (P : ABCPoint) :
    0 < P.freyDiscriminantNat := by
  unfold freyDiscriminantNat
  exact mul_pos (by norm_num)
    (pow_pos (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos) 2)

/-- The natural discriminant is the exact value of the rational Frey
Weierstrass discriminant. -/
theorem abcFrey_Δ_eq_freyDiscriminantNat (P : ABCPoint) :
    (abcFreyCurve P).Δ = (P.freyDiscriminantNat : ℚ) := by
  rw [abcFrey_Δ]
  unfold freyDiscriminantNat
  push_cast
  ring

/-- The abc product divides its Frey discriminant. -/
theorem abcProduct_dvd_freyDiscriminantNat (P : ABCPoint) :
    P.a * P.b * P.c ∣ P.freyDiscriminantNat := by
  unfold freyDiscriminantNat
  refine ⟨16 * (P.a * P.b * P.c), ?_⟩
  ring

/-- Every prime of `abc` remains in the Frey discriminant radical. -/
theorem abcRadical_le_freyDiscriminantRadical (P : ABCPoint) :
    abcRadical (P.a * P.b * P.c) ≤
      abcRadical P.freyDiscriminantNat := by
  have hdiv :
      radical (P.a * P.b * P.c) ∣ radical P.freyDiscriminantNat :=
    radical_dvd_radical P.abcProduct_dvd_freyDiscriminantNat
      P.freyDiscriminantNat_pos.ne'
  have hle := Nat.le_of_dvd (Nat.radical_pos P.freyDiscriminantNat) hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- Squaring does not change radical support. -/
theorem radical_abcProduct_sq (P : ABCPoint) :
    radical ((P.a * P.b * P.c) ^ 2) =
      radical (P.a * P.b * P.c) := by
  exact radical_pow _ (by norm_num)

/-- The fixed factor `16` gives a uniform upper bound for the Frey
 discriminant radical. -/
theorem freyDiscriminantRadical_le (P : ABCPoint) :
    abcRadical P.freyDiscriminantNat ≤
      16 * abcRadical (P.a * P.b * P.c) := by
  have hdiv :
      radical P.freyDiscriminantNat ∣
        radical 16 * radical ((P.a * P.b * P.c) ^ 2) := by
    simpa [freyDiscriminantNat] using
      (radical_mul_dvd
        (a := (16 : ℕ)) (b := (P.a * P.b * P.c) ^ 2))
  rw [P.radical_abcProduct_sq] at hdiv
  have hpos : 0 < radical 16 * radical (P.a * P.b * P.c) :=
    mul_pos (Nat.radical_pos 16)
      (Nat.radical_pos (P.a * P.b * P.c))
  have hle₁ :
      radical P.freyDiscriminantNat ≤
        radical 16 * radical (P.a * P.b * P.c) :=
    Nat.le_of_dvd hpos hdiv
  have h16 : radical (16 : ℕ) ≤ 16 :=
    (Nat.radical_le_self_iff).2 (by norm_num)
  have hle₂ :
      radical 16 * radical (P.a * P.b * P.c) ≤
        16 * radical (P.a * P.b * P.c) :=
    Nat.mul_le_mul_right _ h16
  have hle := hle₁.trans hle₂
  simpa [abcRadical_eq_natRadical] using hle

/-- A source-independent logarithmic conductor obtained from the actual Frey
 discriminant. -/
noncomputable def freyDiscriminantConductor (P : ABCPoint) : ℝ :=
  Real.log ((abcRadical P.freyDiscriminantNat : ℕ) : ℝ)

/-- The elementary abc conductor is bounded by the actual Frey discriminant
 conductor. -/
theorem conductor_le_freyDiscriminantConductor (P : ABCPoint) :
    P.conductor ≤ P.freyDiscriminantConductor := by
  have hpos :
      0 < ((abcRadical (P.a * P.b * P.c) : ℕ) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hle :
      ((abcRadical (P.a * P.b * P.c) : ℕ) : ℝ) ≤
        (abcRadical P.freyDiscriminantNat : ℝ) := by
    exact_mod_cast P.abcRadical_le_freyDiscriminantRadical
  exact Real.log_le_log hpos hle

/-- The Frey discriminant conductor exceeds the elementary conductor by at
 most the explicit absolute constant `log 16`. -/
theorem freyDiscriminantConductor_le (P : ABCPoint) :
    P.freyDiscriminantConductor ≤ P.conductor + Real.log 16 := by
  have hdiscPos :
      0 < (abcRadical P.freyDiscriminantNat : ℝ) := by
    exact_mod_cast abcRadical_pos P.freyDiscriminantNat
  have habcPos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hle :
      (abcRadical P.freyDiscriminantNat : ℝ) ≤
        16 * (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast P.freyDiscriminantRadical_le
  have hlog := Real.log_le_log hdiscPos hle
  rw [Real.log_mul (by norm_num : (16 : ℝ) ≠ 0) habcPos.ne'] at hlog
  simpa [freyDiscriminantConductor, conductor, add_comm] using hlog

/-- Exact uniform interval for the difference between the two logarithmic
 conductors. -/
theorem freyDiscriminantConductor_error_bounds (P : ABCPoint) :
    0 ≤ P.freyDiscriminantConductor - P.conductor ∧
      P.freyDiscriminantConductor - P.conductor ≤ Real.log 16 := by
  constructor
  · exact sub_nonneg.mpr P.conductor_le_freyDiscriminantConductor
  · linarith [P.freyDiscriminantConductor_le]

end ABCPoint

end IUTThreeClosures
