/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyEntireIsogenyArithmetic20260831
import Heights.WeilHeight

/-!
# Exact actual rational Weil heights of four Frey isogeny models

The mathematical proof and its auxiliary Bezout details precede this module in
research/FREY_ENTIRE_ISOGENY_WEIL_HEIGHT_2026_08_31.md and
research/FREY_ISOGENY_WEIL_HEIGHT_FORMAL_PROOFS_2026_08_31.md.

We use the existing actual Weierstrass curves and mathlib's actual rational
height. The `ModelLabel` enumeration is not asserted here to be an entire
rational isogeny class. That identification remains the separate paper proof.
-/

namespace IUTThreeClosures.FreyIsogenyWeilHeight20260831

open FreyEntireIsogenyArithmetic20260831

/-- The odd integer half of the existing endpoint. -/
def halfEndpoint (n : ℕ) : ℤ := 896 * (n : ℤ) + 1

/-- The four quadratic factors in the actual c4 invariants. -/
def corePolynomial {R : Type*} [CommRing R] (c : R) : ModelLabel → R
  | .original => c ^ 2 - c + 1
  | .zeroKernel => c ^ 2 - 16 * c + 16
  | .aKernel => c ^ 2 + 14 * c + 1
  | .negBKernel => 16 * c ^ 2 - 16 * c + 1

/-- Signed coefficient in the reduced numerator, including the negative zero-kernel j. -/
def numeratorFactor : ModelLabel → ℤ
  | .original => 64
  | .zeroKernel => -1
  | .aKernel => 8
  | .negBKernel => 8

/-- Candidate integer numerator, proved below to be the actual rational numerator. -/
def reducedNumerator (n : ℕ) (i : ModelLabel) : ℤ :=
  numeratorFactor i * corePolynomial (endpointC n : ℤ) i ^ 3

/-- Candidate positive denominator, proved below to be the actual rational denominator. -/
def reducedDenominator (n : ℕ) : ModelLabel → ℤ
  | .original => halfEndpoint n ^ 2 * ((endpointC n : ℤ) - 1) ^ 2
  | .zeroKernel => ((endpointC n : ℤ) - 1) * halfEndpoint n ^ 4
  | .aKernel => halfEndpoint n * ((endpointC n : ℤ) - 1) ^ 4
  | .negBKernel => halfEndpoint n * ((endpointC n : ℤ) - 1)

theorem endpoint_eq_two_half (n : ℕ) :
    (endpointC n : ℤ) = 2 * halfEndpoint n := by
  simp [endpointC, halfEndpoint]
  ring

theorem halfEndpoint_pos (n : ℕ) : 0 < halfEndpoint n := by
  unfold halfEndpoint
  omega

theorem reducedDenominator_pos (n : ℕ) (i : ModelLabel) :
    0 < reducedDenominator n i := by
  have hu := halfEndpoint_pos n
  have hb : 0 < (endpointC n : ℤ) - 1 := by
    have := endpoint_eq_two_half n
    omega
  cases i <;> simp only [reducedDenominator] <;> positivity

private theorem isCoprime_of_residue {x y r k : ℤ}
    (hxy : x = r + y * k) (hry : IsCoprime r y) : IsCoprime x y := by
  obtain ⟨a, b, hab⟩ := hry
  refine ⟨a, b - a * k, ?_⟩
  rw [hxy]
  linear_combination hab

theorem two_coprime_halfEndpoint (n : ℕ) : IsCoprime 2 (halfEndpoint n) := by
  refine ⟨-448 * (n : ℤ), 1, ?_⟩
  simp [halfEndpoint]
  ring

theorem two_coprime_endpoint_sub_one (n : ℕ) :
    IsCoprime 2 ((endpointC n : ℤ) - 1) := by
  refine ⟨-896 * (n : ℤ), 1, ?_⟩
  simp [endpointC]
  ring

theorem corePolynomial_coprime_halfEndpoint (n : ℕ) (i : ModelLabel) :
    IsCoprime (corePolynomial (endpointC n : ℤ) i) (halfEndpoint n) := by
  have h16 : IsCoprime 16 (halfEndpoint n) := by
    simpa using (two_coprime_halfEndpoint n).pow_left (m := 4)
  cases i
  · apply isCoprime_of_residue (r := 1) (k := 4 * halfEndpoint n - 2)
    · rw [endpoint_eq_two_half]; simp only [corePolynomial]; ring
    · exact isCoprime_one_left
  · apply isCoprime_of_residue (r := 16) (k := 4 * halfEndpoint n - 32)
    · rw [endpoint_eq_two_half]; simp only [corePolynomial]; ring
    · exact h16
  · apply isCoprime_of_residue (r := 1) (k := 4 * halfEndpoint n + 28)
    · rw [endpoint_eq_two_half]; simp only [corePolynomial]; ring
    · exact isCoprime_one_left
  · apply isCoprime_of_residue (r := 1) (k := 64 * halfEndpoint n - 32)
    · rw [endpoint_eq_two_half]; simp only [corePolynomial]; ring
    · exact isCoprime_one_left

theorem corePolynomial_coprime_endpoint_sub_one (n : ℕ) (i : ModelLabel) :
    IsCoprime (corePolynomial (endpointC n : ℤ) i) ((endpointC n : ℤ) - 1) := by
  have h16 : IsCoprime 16 ((endpointC n : ℤ) - 1) := by
    simpa using (two_coprime_endpoint_sub_one n).pow_left (m := 4)
  cases i
  · apply isCoprime_of_residue (r := 1) (k := (endpointC n : ℤ))
    · simp only [corePolynomial]; ring
    · exact isCoprime_one_left
  · apply isCoprime_of_residue (r := 1) (k := (endpointC n : ℤ) - 15)
    · simp only [corePolynomial]; ring
    · exact isCoprime_one_left
  · apply isCoprime_of_residue (r := 16) (k := (endpointC n : ℤ) + 15)
    · simp only [corePolynomial]; ring
    · exact h16
  · apply isCoprime_of_residue (r := 1) (k := 16 * (endpointC n : ℤ))
    · simp only [corePolynomial]; ring
    · exact isCoprime_one_left

theorem reduced_coprime (n : ℕ) (i : ModelLabel) :
    IsCoprime (reducedNumerator n i) (reducedDenominator n i) := by
  have h2u := two_coprime_halfEndpoint n
  have h2b := two_coprime_endpoint_sub_one n
  have hpu := corePolynomial_coprime_halfEndpoint n i
  have hpb := corePolynomial_coprime_endpoint_sub_one n i
  have hcore : IsCoprime (corePolynomial (endpointC n : ℤ) i)
      (reducedDenominator n i) := by
    cases i
    · exact hpu.pow_right.mul_right hpb.pow_right
    · exact hpb.mul_right hpu.pow_right
    · exact hpu.mul_right hpb.pow_right
    · exact hpu.mul_right hpb
  have htwo : IsCoprime 2 (reducedDenominator n i) := by
    cases i
    · exact h2u.pow_right.mul_right h2b.pow_right
    · exact h2b.mul_right h2u.pow_right
    · exact h2u.mul_right h2b.pow_right
    · exact h2u.mul_right h2b
  unfold reducedNumerator
  apply IsCoprime.mul_left _ hcore.pow_left
  cases i
  · simpa [numeratorFactor] using htwo.pow_left (m := 6)
  · exact ⟨-1, 0, by norm_num [numeratorFactor]⟩
  · simpa [numeratorFactor] using htwo.pow_left (m := 3)
  · simpa [numeratorFactor] using htwo.pow_left (m := 3)

/-- An equality for the actual signed rational invariant, not merely its absolute value. -/
theorem familyCurve_j_eq_reduced (n : ℕ) (i : ModelLabel) :
    (familyCurve n i).j = (reducedNumerator n i : ℚ) / reducedDenominator n i := by
  have hu : (halfEndpoint n : ℚ) ≠ 0 := by
    exact_mod_cast (halfEndpoint_pos n).ne'
  have hb : 2 * (halfEndpoint n : ℚ) - 1 ≠ 0 := by
    have h1 : (1 : ℚ) ≤ halfEndpoint n := by
      exact_mod_cast (show (1 : ℤ) ≤ halfEndpoint n by
        have := halfEndpoint_pos n
        omega)
    linarith
  have hcu : (endpointC n : ℚ) = 2 * (halfEndpoint n : ℚ) := by
    exact_mod_cast endpoint_eq_two_half n
  rw [WeierstrassCurve.j, Units.val_inv_eq_inv_val, WeierstrassCurve.coe_Δ']
  simp only [familyCurve, model_discriminant, model_c4]
  cases i <;>
    simp only [reducedNumerator, reducedDenominator, numeratorFactor, corePolynomial]
  all_goals
    push_cast
    rw [hcu]
    field_simp [hu, hb]
    ring

/-- The proved reduced numerator is exactly the numerator stored by `Rat`. -/
theorem familyCurve_j_num (n : ℕ) (i : ModelLabel) :
    (familyCurve n i).j.num = reducedNumerator n i := by
  rw [familyCurve_j_eq_reduced]
  exact Rat.num_div_eq_of_coprime (reducedDenominator_pos n i)
    (Int.isCoprime_iff_gcd_eq_one.mp (reduced_coprime n i))

/-- The proved denominator is exactly the positive denominator stored by `Rat`. -/
theorem familyCurve_j_den (n : ℕ) (i : ModelLabel) :
    ((familyCurve n i).j.den : ℤ) = reducedDenominator n i := by
  rw [familyCurve_j_eq_reduced]
  exact Rat.den_div_eq_of_coprime (reducedDenominator_pos n i)
    (Int.isCoprime_iff_gcd_eq_one.mp (reduced_coprime n i))

private theorem rat_den_le_num_natAbs (q : ℚ) (hq : 1 ≤ |q|) :
    q.den ≤ q.num.natAbs := by
  have hd : (0 : ℚ) < q.den := by exact_mod_cast q.den_pos
  have habs : |q| = (q.num.natAbs : ℚ) / q.den := by
    calc
      |q| = |(q.num : ℚ) / q.den| := congrArg abs q.num_div_den.symm
      _ = (q.num.natAbs : ℚ) / q.den := by
        simp [abs_div, abs_of_pos hd, Nat.cast_natAbs, Int.cast_abs]
  rw [habs] at hq
  have h := (le_div_iff₀ hd).mp hq
  exact_mod_cast (show (q.den : ℚ) ≤ q.num.natAbs by simpa using h)

/-- The actual numerator dominates the actual denominator for every one of the four curves. -/
theorem familyCurve_den_le_num_natAbs (n : ℕ) (hn : 1 ≤ n) (i : ModelLabel) :
    (familyCurve n i).j.den ≤ (familyCurve n i).j.num.natAbs := by
  apply rat_den_le_num_natAbs
  have hj := familyCurve_j_lower n hn i
  have hc : (2 : ℚ) ≤ endpointC n := by exact_mod_cast endpointC_ge_two n
  linarith

/-- The genuine multiplicative Weil height is the absolute reduced integer numerator. -/
theorem familyCurve_mulHeight_eq_abs_reducedNumerator
    (n : ℕ) (hn : 1 ≤ n) (i : ModelLabel) :
    Height.mulHeight₁ (familyCurve n i).j = (|reducedNumerator n i| : ℤ) := by
  rw [Rat.mulHeight₁_eq_max,
    max_eq_left (familyCurve_den_le_num_natAbs n hn i), familyCurve_j_num]
  simp only [Nat.cast_natAbs]

private theorem corePolynomial_int_cast {R : Type*} [CommRing R] (c : ℤ) (i : ModelLabel) :
    ((corePolynomial c i : ℤ) : R) = corePolynomial (c : R) i := by
  cases i <;> simp [corePolynomial]

theorem corePolynomial_pos (c : ℝ) (hc : 32 ≤ c) (i : ModelLabel) :
    0 < corePolynomial c i := by
  have hc0 : 0 ≤ c := by linarith
  have hprod := mul_nonneg hc0 (show 0 ≤ c - 32 by linarith)
  cases i <;> simp only [corePolynomial] <;> nlinarith

theorem zeroKernel_corePolynomial_lt (c : ℝ) (hc : 32 ≤ c)
    (i : ModelLabel) (hi : i ≠ .zeroKernel) :
    corePolynomial c .zeroKernel < corePolynomial c i := by
  cases i <;> simp only [corePolynomial] at * <;> first | contradiction | nlinarith

/-- The exact table of multiplicative heights of the actual rational j invariants. -/
theorem familyCurve_mulHeight (n : ℕ) (hn : 1 ≤ n) (i : ModelLabel) :
    Height.mulHeight₁ (familyCurve n i).j =
      (match i with
      | .original => 64 * ((endpointC n : ℝ) ^ 2 - endpointC n + 1) ^ 3
      | .zeroKernel => ((endpointC n : ℝ) ^ 2 - 16 * endpointC n + 16) ^ 3
      | .aKernel => 8 * ((endpointC n : ℝ) ^ 2 + 14 * endpointC n + 1) ^ 3
      | .negBKernel => 8 * (16 * (endpointC n : ℝ) ^ 2 - 16 * endpointC n + 1) ^ 3) := by
  have hc : (32 : ℝ) ≤ endpointC n := by
    exact_mod_cast (le_trans (by decide : 32 ≤ 1794) (endpointC_ge_1794 n hn))
  have hp := corePolynomial_pos (endpointC n : ℝ) hc i
  rw [familyCurve_mulHeight_eq_abs_reducedNumerator n hn i,
    Int.cast_abs, reducedNumerator, Int.cast_mul, Int.cast_pow,
    corePolynomial_int_cast, Int.cast_natCast, abs_mul, abs_pow, abs_of_pos hp]
  cases i <;> norm_num [numeratorFactor, corePolynomial]

/-- The exact table for mathlib's logarithmic height, relative and absolute over Q alike. -/
theorem familyCurve_logHeight (n : ℕ) (hn : 1 ≤ n) (i : ModelLabel) :
    Height.logHeight₁ (familyCurve n i).j =
      (match i with
      | .original => Real.log 64 + 3 * Real.log ((endpointC n : ℝ) ^ 2 - endpointC n + 1)
      | .zeroKernel => 3 * Real.log ((endpointC n : ℝ) ^ 2 - 16 * endpointC n + 16)
      | .aKernel => Real.log 8 + 3 * Real.log ((endpointC n : ℝ) ^ 2 + 14 * endpointC n + 1)
      | .negBKernel => Real.log 8 +
          3 * Real.log (16 * (endpointC n : ℝ) ^ 2 - 16 * endpointC n + 1)) := by
  have hc : (32 : ℝ) ≤ endpointC n := by
    exact_mod_cast (le_trans (by decide : 32 ≤ 1794) (endpointC_ge_1794 n hn))
  have hp := corePolynomial_pos (endpointC n : ℝ) hc i
  rw [Height.logHeight₁_eq_log_mulHeight₁, familyCurve_mulHeight n hn i]
  cases i <;> simp only [corePolynomial] at hp
  all_goals
    try rw [Real.log_mul (by norm_num) (pow_ne_zero 3 hp.ne')]
    norm_num [Real.log_pow]

/-- Strict multiplicative-height comparison with every other actual model. -/
theorem zeroKernel_mulHeight_lt (n : ℕ) (hn : 1 ≤ n)
    (i : ModelLabel) (hi : i ≠ .zeroKernel) :
    Height.mulHeight₁ (familyCurve n .zeroKernel).j <
      Height.mulHeight₁ (familyCurve n i).j := by
  have hc : (32 : ℝ) ≤ endpointC n := by
    exact_mod_cast (le_trans (by decide : 32 ≤ 1794) (endpointC_ge_1794 n hn))
  have hq := corePolynomial_pos (endpointC n : ℝ) hc .zeroKernel
  have hp := corePolynomial_pos (endpointC n : ℝ) hc i
  have hcube := pow_lt_pow_left₀ (zeroKernel_corePolynomial_lt _ hc i hi)
    hq.le (show (3 : ℕ) ≠ 0 by decide)
  rw [familyCurve_mulHeight n hn .zeroKernel, familyCurve_mulHeight n hn i]
  have hp3 := pow_pos hp 3
  cases i <;> simp only [corePolynomial] at hcube hp3 ⊢
  · nlinarith
  · exact (hi rfl).elim
  · nlinarith
  · nlinarith

/-- Strict comparison for the actual logarithmic Weil heights. -/
theorem zeroKernel_logHeight_lt (n : ℕ) (hn : 1 ≤ n)
    (i : ModelLabel) (hi : i ≠ .zeroKernel) :
    Height.logHeight₁ (familyCurve n .zeroKernel).j <
      Height.logHeight₁ (familyCurve n i).j := by
  exact Real.log_lt_log (Height.mulHeight₁_pos _)
    (zeroKernel_mulHeight_lt n hn i hi)

/-- Exact attained minimum over the four actual models.
No entire-class identification is assumed. -/
theorem familyCurve_logHeight_isLeast (n : ℕ) (hn : 1 ≤ n) :
    IsLeast (Set.range fun i : ModelLabel => Height.logHeight₁ (familyCurve n i).j)
      (3 * Real.log ((endpointC n : ℝ) ^ 2 - 16 * endpointC n + 16)) := by
  have hzero : Height.logHeight₁ (familyCurve n .zeroKernel).j =
      3 * Real.log ((endpointC n : ℝ) ^ 2 - 16 * endpointC n + 16) :=
    familyCurve_logHeight n hn .zeroKernel
  refine ⟨⟨.zeroKernel, hzero⟩, ?_⟩
  rintro x ⟨i, rfl⟩
  rw [← hzero]
  by_cases hi : i = .zeroKernel
  · subst i
    rfl
  · exact (zeroKernel_logHeight_lt n hn i hi).le

/-- The multiplicative Weil height also attains its exact minimum on the zero-kernel model. -/
theorem familyCurve_mulHeight_isLeast (n : ℕ) (hn : 1 ≤ n) :
    IsLeast (Set.range fun i : ModelLabel => Height.mulHeight₁ (familyCurve n i).j)
      (((endpointC n : ℝ) ^ 2 - 16 * endpointC n + 16) ^ 3) := by
  have hzero : Height.mulHeight₁ (familyCurve n .zeroKernel).j =
      ((endpointC n : ℝ) ^ 2 - 16 * endpointC n + 16) ^ 3 :=
    familyCurve_mulHeight n hn .zeroKernel
  refine ⟨⟨.zeroKernel, hzero⟩, ?_⟩
  rintro x ⟨i, rfl⟩
  rw [← hzero]
  by_cases hi : i = .zeroKernel
  · subst i
    rfl
  · exact (zeroKernel_mulHeight_lt n hn i hi).le

/-- The actual-model minimizer is unique. -/
theorem familyCurve_logHeight_eq_min_iff (n : ℕ) (hn : 1 ≤ n) (i : ModelLabel) :
    Height.logHeight₁ (familyCurve n i).j =
        3 * Real.log ((endpointC n : ℝ) ^ 2 - 16 * endpointC n + 16) ↔
      i = .zeroKernel := by
  constructor
  · intro heq
    by_contra hi
    have hlt := zeroKernel_logHeight_lt n hn i hi
    rw [familyCurve_logHeight n hn .zeroKernel, heq] at hlt
    exact (lt_irrefl _ hlt)
  · rintro rfl
    exact familyCurve_logHeight n hn .zeroKernel

/-- The library's degree-normalized height agrees with mathlib's height
on these rational j values. -/
theorem familyCurve_normalizedLogHeight (n : ℕ) (i : ModelLabel) :
    Heights.normalizedLogHeight ℚ (familyCurve n i).j =
      Height.logHeight₁ (familyCurve n i).j := by
  simp [Heights.normalizedLogHeight]

/-- The same exact minimum is a theorem about the existing absolute normalized-height API. -/
theorem familyCurve_normalizedLogHeight_isLeast (n : ℕ) (hn : 1 ≤ n) :
    IsLeast (Set.range fun i : ModelLabel =>
        Heights.normalizedLogHeight ℚ (familyCurve n i).j)
      (3 * Real.log ((endpointC n : ℝ) ^ 2 - 16 * endpointC n + 16)) := by
  simpa only [familyCurve_normalizedLogHeight] using familyCurve_logHeight_isLeast n hn

theorem familyCurve_normalizedLogHeight_eq_min_iff
    (n : ℕ) (hn : 1 ≤ n) (i : ModelLabel) :
    Heights.normalizedLogHeight ℚ (familyCurve n i).j =
        3 * Real.log ((endpointC n : ℝ) ^ 2 - 16 * endpointC n + 16) ↔
      i = .zeroKernel := by
  rw [familyCurve_normalizedLogHeight]
  exact familyCurve_logHeight_eq_min_iff n hn i

theorem zeroKernel_corePolynomial_bounds (c : ℝ) (hc : 32 ≤ c) :
    c ^ 2 / 2 < corePolynomial c .zeroKernel ∧
      corePolynomial c .zeroKernel < c ^ 2 := by
  have hprod := mul_nonneg (show 0 ≤ c by linarith) (show 0 ≤ c - 32 by linarith)
  simp only [corePolynomial]
  constructor <;> nlinarith

/-- The exact actual minimum has the leading term 6 log c, with an explicit bounded error. -/
theorem zeroKernel_logHeight_bounds (n : ℕ) (hn : 1 ≤ n) :
    6 * Real.log (endpointC n : ℝ) - 3 * Real.log 2 <
        Height.logHeight₁ (familyCurve n .zeroKernel).j ∧
      Height.logHeight₁ (familyCurve n .zeroKernel).j <
        6 * Real.log (endpointC n : ℝ) := by
  have hc : (32 : ℝ) ≤ endpointC n := by
    exact_mod_cast (le_trans (by decide : 32 ≤ 1794) (endpointC_ge_1794 n hn))
  have hc0 : (0 : ℝ) < endpointC n := by linarith
  have hbounds := zeroKernel_corePolynomial_bounds (endpointC n : ℝ) hc
  have hq := corePolynomial_pos (endpointC n : ℝ) hc .zeroKernel
  have hlo := Real.log_lt_log (div_pos (pow_pos hc0 2) (by norm_num)) hbounds.1
  have hhi := Real.log_lt_log hq hbounds.2
  rw [Real.log_div (pow_ne_zero 2 hc0.ne') (by norm_num), Real.log_pow] at hlo
  rw [Real.log_pow] at hhi
  rw [familyCurve_logHeight n hn .zeroKernel]
  simp only [corePolynomial] at hlo hhi
  norm_num at hlo hhi
  constructor <;> linarith

#print axioms familyCurve_j_num
#print axioms familyCurve_j_den
#print axioms familyCurve_mulHeight
#print axioms familyCurve_logHeight_eq_min_iff
#print axioms familyCurve_normalizedLogHeight_isLeast
#print axioms zeroKernel_logHeight_bounds

end IUTThreeClosures.FreyIsogenyWeilHeight20260831
