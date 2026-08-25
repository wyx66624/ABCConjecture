/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyJHeightCorridor
import IUTThreeClosures.FreyDiscriminantConductor

/-!
# A concrete Frey / modified-Szpiro route

This file isolates a non-IUT conditional route to abc.  Its source height is
the actual integral-model quantity

`log max (|c₄|³) |Δ|`.

For the Frey model this height differs from `6 log c` by an explicit bounded
amount.  A pointwise modified-Szpiro estimate of slope `6 + 6ε` therefore
implies the pointwise abc estimate by a scalar calculation.  The estimate is
an explicit theorem hypothesis, never a field of a data structure.

The file also computes the quotient model for the rational two-torsion point
`(0,0)`.  Its discriminant grows like `c⁵`, rather than `c⁴`, on the endpoint
family `(1,N,N+1)`.  Hence a direct exponent-six discriminant argument improves
the limiting coefficient from `3/2` to `6/5`, but still does not reach `1`.
Strict endpoint counterexamples show that the exponents four and five cannot
be increased uniformly for these two displayed models.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid WeierstrassCurve

namespace ABCPoint

/-- The concrete natural modified height of the integral Frey model:
`max (|c₄|³) |Δ|`. -/
def freyModifiedHeightNat (P : ABCPoint) : ℕ :=
  max ((16 * P.legendreCore) ^ 3) P.freyDiscriminantNat

/-- The natural definition is literally the maximum of the absolute integral
Weierstrass invariants of the displayed model. -/
theorem freyModifiedHeightNat_eq_invariants (P : ABCPoint) :
    P.freyModifiedHeightNat =
      max ((abcFreyCurveZ P).c₄.natAbs ^ 3)
        (abcFreyCurveZ P).Δ.natAbs := by
  unfold freyModifiedHeightNat freyDiscriminantNat
  rw [abcFreyZ_c₄, abcFreyZ_Δ]
  simp only [Int.natAbs_mul, Int.natAbs_pow, Int.natAbs_natCast]
  norm_num
  ring

@[simp]
theorem freyModifiedHeightNat_pos (P : ABCPoint) :
    0 < P.freyModifiedHeightNat := by
  exact P.freyDiscriminantNat_pos.trans_le (le_max_right _ _)

/-- The actual logarithmic modified height of the displayed integral model. -/
noncomputable def freyModifiedHeight (P : ABCPoint) : ℝ :=
  Real.log (P.freyModifiedHeightNat : ℝ)

/-- The elementary height scale `c⁶` is bounded by the concrete modified
height integer. -/
theorem c_pow_six_le_freyModifiedHeightNat (P : ABCPoint) :
    P.c ^ 6 ≤ P.freyModifiedHeightNat := by
  calc
    P.c ^ 6 = (P.c ^ 2) ^ 3 := by ring
    _ ≤ (2 * P.legendreCore) ^ 3 := by
      exact Nat.pow_le_pow_left P.c_sq_le_two_legendreCore 3
    _ = 8 * P.legendreCore ^ 3 := by ring
    _ ≤ 4096 * P.legendreCore ^ 3 :=
      Nat.mul_le_mul_right _ (by norm_num)
    _ = (16 * P.legendreCore) ^ 3 := by ring
    _ ≤ P.freyModifiedHeightNat := le_max_left _ _

/-- Both invariant coordinates of the modified height are at most
`4096 c⁶`. -/
theorem freyModifiedHeightNat_le (P : ABCPoint) :
    P.freyModifiedHeightNat ≤ 4096 * P.c ^ 6 := by
  apply max_le
  · calc
      (16 * P.legendreCore) ^ 3 =
          4096 * P.legendreCore ^ 3 := by ring
      _ ≤ 4096 * (P.c ^ 2) ^ 3 := by
        exact Nat.mul_le_mul_left 4096
          (Nat.pow_le_pow_left P.legendreCore_le_c_sq 3)
      _ = 4096 * P.c ^ 6 := by ring
  · have ha : P.a ≤ P.c := Nat.le_of_lt P.a_lt_c
    have hb : P.b ≤ P.c := Nat.le_of_lt P.b_lt_c
    calc
      P.freyDiscriminantNat = 16 * (P.a * P.b * P.c) ^ 2 := rfl
      _ ≤ 16 * (P.c * P.c * P.c) ^ 2 := by gcongr
      _ = 16 * P.c ^ 6 := by ring
      _ ≤ 4096 * P.c ^ 6 :=
        Nat.mul_le_mul_right _ (by norm_num)

/-- Lower half of the exact `6 log c + O(1)` modified-height corridor. -/
theorem six_mul_height_le_freyModifiedHeight (P : ABCPoint) :
    6 * P.height ≤ P.freyModifiedHeight := by
  rw [P.height_eq_log_c, freyModifiedHeight]
  have hc : (0 : ℝ) < P.c := by exact_mod_cast P.c_pos
  have hreal : (P.c : ℝ) ^ 6 ≤ (P.freyModifiedHeightNat : ℝ) := by
    exact_mod_cast P.c_pow_six_le_freyModifiedHeightNat
  have hlog := Real.log_le_log (pow_pos hc 6) hreal
  rw [Real.log_pow] at hlog
  exact hlog

/-- Upper half of the exact `6 log c + O(1)` modified-height corridor. -/
theorem freyModifiedHeight_le (P : ABCPoint) :
    P.freyModifiedHeight ≤ 6 * P.height + Real.log 4096 := by
  rw [P.height_eq_log_c, freyModifiedHeight]
  have hc : (0 : ℝ) < P.c := by exact_mod_cast P.c_pos
  have hM : (0 : ℝ) < P.freyModifiedHeightNat := by
    exact_mod_cast P.freyModifiedHeightNat_pos
  have hreal :
      (P.freyModifiedHeightNat : ℝ) ≤ 4096 * (P.c : ℝ) ^ 6 := by
    exact_mod_cast P.freyModifiedHeightNat_le
  have hlog := Real.log_le_log hM hreal
  rw [Real.log_mul (by norm_num : (4096 : ℝ) ≠ 0)
      (pow_pos hc 6).ne', Real.log_pow] at hlog
  calc
    Real.log (P.freyModifiedHeightNat : ℝ) ≤
        Real.log 4096 + 6 * Real.log (P.c : ℝ) := by
      simpa using hlog
    _ = 6 * Real.log (P.c : ℝ) + Real.log 4096 := by ring

/-- Sharpen the fixed-prime radical loss from the earlier coarse factor `16`
to the exact possible extra factor `2`. -/
theorem freyDiscriminantRadical_le_two (P : ABCPoint) :
    abcRadical P.freyDiscriminantNat ≤
      2 * abcRadical (P.a * P.b * P.c) := by
  have hdiv :
      radical P.freyDiscriminantNat ∣
        radical 16 * radical ((P.a * P.b * P.c) ^ 2) := by
    simpa [freyDiscriminantNat] using
      (radical_mul_dvd
        (a := (16 : ℕ)) (b := (P.a * P.b * P.c) ^ 2))
  rw [P.radical_abcProduct_sq] at hdiv
  have hrad16 : radical (16 : ℕ) = 2 := by
    exact radical_pow_of_prime (a := (2 : ℕ)) Nat.prime_two.prime
      (n := 4) (by norm_num)
  rw [hrad16] at hdiv
  have hpos : 0 < 2 * radical (P.a * P.b * P.c) :=
    mul_pos (by norm_num) (Nat.radical_pos _)
  have hle := Nat.le_of_dvd hpos hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- The actual discriminant-radical conductor differs from the elementary
abc conductor by at most `log 2`. -/
theorem freyDiscriminantConductor_le_log_two (P : ABCPoint) :
    P.freyDiscriminantConductor ≤ P.conductor + Real.log 2 := by
  have hdiscPos :
      0 < (abcRadical P.freyDiscriminantNat : ℝ) := by
    exact_mod_cast abcRadical_pos P.freyDiscriminantNat
  have habcPos :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hle :
      (abcRadical P.freyDiscriminantNat : ℝ) ≤
        2 * (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast P.freyDiscriminantRadical_le_two
  have hlog := Real.log_le_log hdiscPos hle
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) habcPos.ne'] at hlog
  simpa [freyDiscriminantConductor, conductor, add_comm] using hlog

/-- Strict scalar reduction from a concrete pointwise modified-Szpiro
estimate to the pointwise abc estimate.  The difficult estimate is an
explicit hypothesis, not stored data. -/
theorem height_le_of_freyModifiedSzpiro
    (P : ABCPoint) (ε C : ℝ) (hε : 0 ≤ ε)
    (hMS : P.freyModifiedHeight ≤
      (6 + 6 * ε) * P.freyDiscriminantConductor + C) :
    P.height ≤
      (1 + ε) * P.conductor +
        (1 + ε) * Real.log 2 + C / 6 := by
  have hcoef : 0 ≤ 6 + 6 * ε := by nlinarith
  have hcond := mul_le_mul_of_nonneg_left
    P.freyDiscriminantConductor_le_log_two hcoef
  calc
    P.height ≤ P.freyModifiedHeight / 6 := by
      apply (le_div_iff₀ (by norm_num : (0 : ℝ) < 6)).2
      simpa [mul_comm] using P.six_mul_height_le_freyModifiedHeight
    _ ≤ ((6 + 6 * ε) * P.freyDiscriminantConductor + C) / 6 := by
      exact div_le_div_of_nonneg_right hMS (by norm_num)
    _ ≤ ((6 + 6 * ε) * (P.conductor + Real.log 2) + C) / 6 := by
      apply div_le_div_of_nonneg_right _ (by norm_num)
      simpa [add_comm] using add_le_add_right hcond C
    _ = (1 + ε) * P.conductor +
          (1 + ε) * Real.log 2 + C / 6 := by ring

end ABCPoint

/-- A uniform concrete modified-Szpiro estimate for all source-derived Frey
models implies the logarithmic abc conjecture.  The assumption is displayed
verbatim in the theorem binder. -/
theorem abc_of_uniform_freyModifiedSzpiro
    (hMS : ∀ ε : ℝ, 0 < ε → ∃ C : ℝ, ∀ P : ABCPoint,
      P.freyModifiedHeight ≤
        (6 + 6 * ε) * P.freyDiscriminantConductor + C) :
    ABCConjecture := by
  intro ε hε
  rcases hMS ε hε with ⟨C, hC⟩
  refine ⟨(1 + ε) * Real.log 2 + C / 6, ?_⟩
  intro a b c ha hb hc hab hcop
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hab
      pairwise_coprime := hcop }
  have hpoint := P.height_le_of_freyModifiedSzpiro ε C hε.le (hC P)
  simpa [P, ABCPoint.height, ABCPoint.conductor, add_assoc] using hpoint

namespace ABCPoint

/-- The elementary endpoint inequality used to measure discriminant growth. -/
theorem c_le_two_mul_ab (P : ABCPoint) :
    P.c ≤ 2 * (P.a * P.b) := by
  have ha : P.a ≤ P.a * P.b := by
    have h := Nat.mul_le_mul_left P.a (Nat.succ_le_iff.mpr P.b_pos)
    simpa using h
  have hb : P.b ≤ P.a * P.b := by
    have h := Nat.mul_le_mul_right P.b (Nat.succ_le_iff.mpr P.a_pos)
    simpa [Nat.mul_comm] using h
  rw [← P.sum_eq]
  nlinarith

/-- The original displayed Frey discriminant has a universal fourth-power
lower bound. -/
theorem four_mul_c_pow_four_le_freyDiscriminantNat (P : ABCPoint) :
    4 * P.c ^ 4 ≤ P.freyDiscriminantNat := by
  have hsq : P.c ^ 2 ≤ (2 * (P.a * P.b)) ^ 2 :=
    Nat.pow_le_pow_left P.c_le_two_mul_ab 2
  have hmul := Nat.mul_le_mul_right (4 * P.c ^ 2) hsq
  calc
    4 * P.c ^ 4 = P.c ^ 2 * (4 * P.c ^ 2) := by ring
    _ ≤ (2 * (P.a * P.b)) ^ 2 * (4 * P.c ^ 2) := by
      simpa [mul_comm] using hmul
    _ = P.freyDiscriminantNat := by
      simp [freyDiscriminantNat]
      ring

/-- The logarithmic size of the original displayed Frey discriminant. -/
noncomputable def freyDiscriminantLogSize (P : ABCPoint) : ℝ :=
  Real.log (P.freyDiscriminantNat : ℝ)

/-- Direct use of the original discriminant controls the abc height only
after division by four. -/
theorem height_le_freyDiscriminantLogSize_div_four (P : ABCPoint) :
    P.height ≤ P.freyDiscriminantLogSize / 4 := by
  rw [P.height_eq_log_c, freyDiscriminantLogSize]
  have hc : (0 : ℝ) < P.c := by exact_mod_cast P.c_pos
  have hnat : P.c ^ 4 ≤ P.freyDiscriminantNat := by
    calc
      P.c ^ 4 ≤ 4 * P.c ^ 4 := by
        have h := Nat.mul_le_mul_right (P.c ^ 4) (by norm_num : 1 ≤ 4)
        simpa using h
      _ ≤ P.freyDiscriminantNat :=
        P.four_mul_c_pow_four_le_freyDiscriminantNat
  have hreal : (P.c : ℝ) ^ 4 ≤ (P.freyDiscriminantNat : ℝ) := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log (pow_pos hc 4) hreal
  rw [Real.log_pow] at hlog
  apply (le_div_iff₀ (by norm_num : (0 : ℝ) < 4)).2
  simpa [mul_comm] using hlog

/-- A direct exponent-`6+δ` estimate on the original displayed discriminant
has coefficient `(6+δ)/4`, hence tends to `3/2`, not `1`. -/
theorem height_le_of_plainFreyDiscriminantSzpiro
    (P : ABCPoint) (δ C : ℝ) (hδ : 0 ≤ δ)
    (hS : P.freyDiscriminantLogSize ≤
      (6 + δ) * P.freyDiscriminantConductor + C) :
    P.height ≤
      ((6 + δ) / 4) * P.conductor +
        ((6 + δ) * Real.log 2 + C) / 4 := by
  have hcoef : 0 ≤ 6 + δ := by linarith
  have hcond := mul_le_mul_of_nonneg_left
    P.freyDiscriminantConductor_le_log_two hcoef
  calc
    P.height ≤ P.freyDiscriminantLogSize / 4 :=
      P.height_le_freyDiscriminantLogSize_div_four
    _ ≤ ((6 + δ) * P.freyDiscriminantConductor + C) / 4 := by
      exact div_le_div_of_nonneg_right hS (by norm_num)
    _ ≤ ((6 + δ) * (P.conductor + Real.log 2) + C) / 4 := by
      apply div_le_div_of_nonneg_right _ (by norm_num)
      simpa [add_comm] using add_le_add_right hcond C
    _ = ((6 + δ) / 4) * P.conductor +
          ((6 + δ) * Real.log 2 + C) / 4 := by ring

end ABCPoint

/-! ## The rational two-isogeny quotient model -/

/-- For `y²=x³+A x²+B x`, the standard quotient by `(0,0)` has equation
`Y²=X³-2A X²+(A²-4B)X`.  This identity checks its rational map away from the
kernel, after substituting the source equation. -/
theorem twoIsogenyAffineEquation
    {K : Type*} [Field K] (A B x y : K) (hx : x ≠ 0)
    (hE : y ^ 2 = x ^ 3 + A * x ^ 2 + B * x) :
    let X := y ^ 2 / x ^ 2
    let Y := y * (B - x ^ 2) / x ^ 2
    Y ^ 2 = X ^ 3 - 2 * A * X ^ 2 + (A ^ 2 - 4 * B) * X := by
  dsimp
  field_simp [hx]
  rw [hE]
  ring

/-- The integral quotient model by the rational two-torsion point `(0,0)`. -/
def abcFreyTwoIsogenousCurveZ (P : ABCPoint) : WeierstrassCurve ℤ where
  a₁ := 0
  a₂ := 2 * ((P.a : ℤ) - P.b)
  a₃ := 0
  a₄ := (P.c : ℤ) ^ 2
  a₆ := 0

/-- The same quotient model over `ℚ`. -/
def abcFreyTwoIsogenousCurve (P : ABCPoint) : WeierstrassCurve ℚ where
  a₁ := 0
  a₂ := 2 * ((P.a : ℚ) - P.b)
  a₃ := 0
  a₄ := (P.c : ℚ) ^ 2
  a₆ := 0

@[simp] theorem abcFreyTwoIsogenousZ_b₂ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurveZ P).b₂ =
      8 * ((P.a : ℤ) - P.b) := by
  simp [abcFreyTwoIsogenousCurveZ, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcFreyTwoIsogenousZ_b₄ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurveZ P).b₄ = 2 * (P.c : ℤ) ^ 2 := by
  simp [abcFreyTwoIsogenousCurveZ, WeierstrassCurve.b₄]

@[simp] theorem abcFreyTwoIsogenousZ_b₆ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurveZ P).b₆ = 0 := by
  simp [abcFreyTwoIsogenousCurveZ, WeierstrassCurve.b₆]

@[simp] theorem abcFreyTwoIsogenousZ_b₈ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurveZ P).b₈ = -(P.c : ℤ) ^ 4 := by
  simp [abcFreyTwoIsogenousCurveZ, WeierstrassCurve.b₈]
  ring

@[simp] theorem abcFreyTwoIsogenousZ_c₄ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurveZ P).c₄ =
      16 * ((P.a : ℤ) ^ 2 - 14 * P.a * P.b + (P.b : ℤ) ^ 2) := by
  rw [WeierstrassCurve.c₄, abcFreyTwoIsogenousZ_b₂,
    abcFreyTwoIsogenousZ_b₄]
  have hsum : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFreyTwoIsogenousZ_Δ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurveZ P).Δ =
      -256 * (P.a : ℤ) * P.b * (P.c : ℤ) ^ 4 := by
  rw [WeierstrassCurve.Δ, abcFreyTwoIsogenousZ_b₂,
    abcFreyTwoIsogenousZ_b₄, abcFreyTwoIsogenousZ_b₆,
    abcFreyTwoIsogenousZ_b₈]
  have hsum : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFreyTwoIsogenous_b₂ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurve P).b₂ =
      8 * ((P.a : ℚ) - P.b) := by
  simp [abcFreyTwoIsogenousCurve, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcFreyTwoIsogenous_b₄ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurve P).b₄ = 2 * (P.c : ℚ) ^ 2 := by
  simp [abcFreyTwoIsogenousCurve, WeierstrassCurve.b₄]

@[simp] theorem abcFreyTwoIsogenous_b₆ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurve P).b₆ = 0 := by
  simp [abcFreyTwoIsogenousCurve, WeierstrassCurve.b₆]

@[simp] theorem abcFreyTwoIsogenous_b₈ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurve P).b₈ = -(P.c : ℚ) ^ 4 := by
  simp [abcFreyTwoIsogenousCurve, WeierstrassCurve.b₈]
  ring

@[simp] theorem abcFreyTwoIsogenous_c₄ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurve P).c₄ =
      16 * ((P.a : ℚ) ^ 2 - 14 * P.a * P.b + (P.b : ℚ) ^ 2) := by
  rw [WeierstrassCurve.c₄, abcFreyTwoIsogenous_b₂,
    abcFreyTwoIsogenous_b₄]
  have hsum : (P.a : ℚ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcFreyTwoIsogenous_Δ (P : ABCPoint) :
    (abcFreyTwoIsogenousCurve P).Δ =
      -256 * (P.a : ℚ) * P.b * (P.c : ℚ) ^ 4 := by
  rw [WeierstrassCurve.Δ, abcFreyTwoIsogenous_b₂,
    abcFreyTwoIsogenous_b₄, abcFreyTwoIsogenous_b₆,
    abcFreyTwoIsogenous_b₈]
  have hsum : (P.a : ℚ) + P.b = P.c := by exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

/-- The quotient model is nonsingular. -/
noncomputable instance abcFreyTwoIsogenous_isElliptic (P : ABCPoint) :
    (abcFreyTwoIsogenousCurve P).IsElliptic where
  isUnit := by
    rw [abcFreyTwoIsogenous_Δ]
    apply isUnit_iff_ne_zero.mpr
    exact mul_ne_zero
      (mul_ne_zero
        (mul_ne_zero (by norm_num) (by exact_mod_cast P.a_pos.ne'))
        (by exact_mod_cast P.b_pos.ne'))
      (pow_ne_zero _ (by exact_mod_cast P.c_pos.ne'))

namespace ABCPoint

/-- Absolute discriminant of the displayed rational two-isogeny quotient. -/
def freyTwoIsogenousDiscriminantNat (P : ABCPoint) : ℕ :=
  256 * P.a * P.b * P.c ^ 4

@[simp]
theorem freyTwoIsogenousDiscriminantNat_pos (P : ABCPoint) :
    0 < P.freyTwoIsogenousDiscriminantNat := by
  unfold freyTwoIsogenousDiscriminantNat
  exact mul_pos
    (mul_pos (mul_pos (by norm_num) P.a_pos) P.b_pos)
    (pow_pos P.c_pos 4)

/-- The natural number is exactly the absolute integral discriminant. -/
theorem freyTwoIsogenousDiscriminantNat_eq_natAbs (P : ABCPoint) :
    P.freyTwoIsogenousDiscriminantNat =
      (abcFreyTwoIsogenousCurveZ P).Δ.natAbs := by
  rw [abcFreyTwoIsogenousZ_Δ]
  simp only [Int.natAbs_neg, Int.natAbs_mul, Int.natAbs_pow,
    Int.natAbs_natCast]
  norm_num [freyTwoIsogenousDiscriminantNat]

/-- The quotient discriminant has a universal fifth-power lower bound. -/
theorem one_twenty_eight_mul_c_pow_five_le_twoIsogenousDiscriminantNat
    (P : ABCPoint) :
    128 * P.c ^ 5 ≤ P.freyTwoIsogenousDiscriminantNat := by
  have hmul := Nat.mul_le_mul_right (128 * P.c ^ 4) P.c_le_two_mul_ab
  calc
    128 * P.c ^ 5 = P.c * (128 * P.c ^ 4) := by ring
    _ ≤ (2 * (P.a * P.b)) * (128 * P.c ^ 4) := by
      simpa [mul_comm] using hmul
    _ = P.freyTwoIsogenousDiscriminantNat := by
      simp [freyTwoIsogenousDiscriminantNat]
      ring

/-- Logarithmic absolute discriminant of the quotient model. -/
noncomputable def freyTwoIsogenousDiscriminantLogSize (P : ABCPoint) : ℝ :=
  Real.log (P.freyTwoIsogenousDiscriminantNat : ℝ)

/-- Direct use of the quotient discriminant controls the abc height only
after division by five. -/
theorem height_le_twoIsogenousDiscriminantLogSize_div_five
    (P : ABCPoint) :
    P.height ≤ P.freyTwoIsogenousDiscriminantLogSize / 5 := by
  rw [P.height_eq_log_c, freyTwoIsogenousDiscriminantLogSize]
  have hc : (0 : ℝ) < P.c := by exact_mod_cast P.c_pos
  have hnat : P.c ^ 5 ≤ P.freyTwoIsogenousDiscriminantNat := by
    calc
      P.c ^ 5 ≤ 128 * P.c ^ 5 := by
        have h := Nat.mul_le_mul_right (P.c ^ 5) (by norm_num : 1 ≤ 128)
        simpa using h
      _ ≤ P.freyTwoIsogenousDiscriminantNat :=
        P.one_twenty_eight_mul_c_pow_five_le_twoIsogenousDiscriminantNat
  have hreal :
      (P.c : ℝ) ^ 5 ≤ (P.freyTwoIsogenousDiscriminantNat : ℝ) := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log (pow_pos hc 5) hreal
  rw [Real.log_pow] at hlog
  apply (le_div_iff₀ (by norm_num : (0 : ℝ) < 5)).2
  simpa [mul_comm] using hlog

/-- A direct exponent-`6+δ` estimate on the displayed quotient discriminant
has coefficient `(6+δ)/5`, hence tends to `6/5`, not `1`. -/
theorem height_le_of_twoIsogenousDiscriminantSzpiro
    (P : ABCPoint) (δ C : ℝ) (hδ : 0 ≤ δ)
    (hS : P.freyTwoIsogenousDiscriminantLogSize ≤
      (6 + δ) * P.freyDiscriminantConductor + C) :
    P.height ≤
      ((6 + δ) / 5) * P.conductor +
        ((6 + δ) * Real.log 2 + C) / 5 := by
  have hcoef : 0 ≤ 6 + δ := by linarith
  have hcond := mul_le_mul_of_nonneg_left
    P.freyDiscriminantConductor_le_log_two hcoef
  calc
    P.height ≤ P.freyTwoIsogenousDiscriminantLogSize / 5 :=
      P.height_le_twoIsogenousDiscriminantLogSize_div_five
    _ ≤ ((6 + δ) * P.freyDiscriminantConductor + C) / 5 := by
      exact div_le_div_of_nonneg_right hS (by norm_num)
    _ ≤ ((6 + δ) * (P.conductor + Real.log 2) + C) / 5 := by
      apply div_le_div_of_nonneg_right _ (by norm_num)
      simpa [add_comm] using add_le_add_right hcond C
    _ = ((6 + δ) / 5) * P.conductor +
          ((6 + δ) * Real.log 2 + C) / 5 := by ring

end ABCPoint

/-! ## Strict endpoint-family barriers -/

/-- Original Frey discriminant on the endpoint triple `(1,c-1,c)`. -/
def endpointFreyDiscriminantNat (c : ℕ) : ℕ :=
  16 * (c - 1) ^ 2 * c ^ 2

/-- Quotient-model discriminant on the endpoint triple `(1,c-1,c)`. -/
def endpointTwoIsogenousDiscriminantNat (c : ℕ) : ℕ :=
  256 * (c - 1) * c ^ 4

/-- Endpoint original discriminants have at most fourth-power growth. -/
theorem endpointFreyDiscriminantNat_le (c : ℕ) :
    endpointFreyDiscriminantNat c ≤ 16 * c ^ 4 := by
  unfold endpointFreyDiscriminantNat
  have hsub : c - 1 ≤ c := Nat.sub_le _ _
  have hsquare : (c - 1) ^ 2 ≤ c ^ 2 :=
    Nat.pow_le_pow_left hsub 2
  calc
    16 * (c - 1) ^ 2 * c ^ 2 ≤ 16 * c ^ 2 * c ^ 2 := by gcongr
    _ = 16 * c ^ 4 := by ring

/-- Strict counterexample to every proposed uniform fifth-power lower bound
for the original displayed discriminant. -/
theorem no_uniform_c_pow_five_lower_for_endpointFrey (K : ℕ) :
    let c := 16 * K + 2
    K * endpointFreyDiscriminantNat c < c ^ 5 := by
  dsimp
  let c := 16 * K + 2
  have hc : 0 < c := by simp [c]
  have hKc : 16 * K < c := by simp [c]
  calc
    K * endpointFreyDiscriminantNat c ≤ K * (16 * c ^ 4) :=
      Nat.mul_le_mul_left K (endpointFreyDiscriminantNat_le c)
    _ = (16 * K) * c ^ 4 := by ring
    _ < c * c ^ 4 := Nat.mul_lt_mul_of_pos_right hKc (pow_pos hc 4)
    _ = c ^ 5 := by ring

/-- Endpoint quotient discriminants have at most fifth-power growth. -/
theorem endpointTwoIsogenousDiscriminantNat_le (c : ℕ) :
    endpointTwoIsogenousDiscriminantNat c ≤ 256 * c ^ 5 := by
  unfold endpointTwoIsogenousDiscriminantNat
  have hsub : c - 1 ≤ c := Nat.sub_le _ _
  calc
    256 * (c - 1) * c ^ 4 ≤ 256 * c * c ^ 4 := by gcongr
    _ = 256 * c ^ 5 := by ring

/-- Strict counterexample to every proposed uniform sixth-power lower bound
for the displayed rational two-isogeny quotient discriminant. -/
theorem no_uniform_c_pow_six_lower_for_endpointTwoIsogenous (K : ℕ) :
    let c := 256 * K + 2
    K * endpointTwoIsogenousDiscriminantNat c < c ^ 6 := by
  dsimp
  let c := 256 * K + 2
  have hc : 0 < c := by simp [c]
  have hKc : 256 * K < c := by simp [c]
  calc
    K * endpointTwoIsogenousDiscriminantNat c ≤ K * (256 * c ^ 5) :=
      Nat.mul_le_mul_left K (endpointTwoIsogenousDiscriminantNat_le c)
    _ = (256 * K) * c ^ 5 := by ring
    _ < c * c ^ 5 := Nat.mul_lt_mul_of_pos_right hKc (pow_pos hc 5)
    _ = c ^ 6 := by ring

end IUTThreeClosures
