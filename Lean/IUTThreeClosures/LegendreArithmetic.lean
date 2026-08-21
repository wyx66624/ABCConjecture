import IUTThreeClosures.ABCPointLegendreCurve

/-!
# Arithmetic of the Legendre `j`-invariant

For `a + b = c`, put

`H = a² + ab + b²`.

Then

`j(E_λ) = 256 H³ / (a² b² c²)`.

Moreover `H` is coprime to `abc`, and

`3 c² ≤ 4 H ≤ 4 c²`.

These facts isolate the elementary part of the bounded-discrepancy comparison
between the Legendre `j`-height and six times the abc height. In particular,
all cancellation in the displayed rational expression for `j` is confined to
the fixed factor `256`; no point-dependent prime can cancel between `H³` and
`a²b²c²`.
-/

namespace IUTThreeClosures

open scoped BigOperators

namespace ABCPoint

/-- The positive quadratic form appearing in the Legendre numerator. -/
def legendreCore (P : ABCPoint) : ℕ :=
  P.a ^ 2 + P.a * P.b + P.b ^ 2

@[simp] theorem legendreCore_pos (P : ABCPoint) : 0 < P.legendreCore := by
  unfold legendreCore
  nlinarith [P.a_pos, P.b_pos]

/-- `1 - λ = b/c`. -/
theorem one_sub_lambda_eq_b_div_c (P : ABCPoint) :
    (1 - P.lambda : ℚ) = (P.b : ℚ) / (P.c : ℚ) := by
  have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
  have hsum : (P.a : ℚ) + (P.b : ℚ) = (P.c : ℚ) := by
    exact_mod_cast P.sum_eq
  rw [ABCPoint.lambda]
  field_simp [hc]
  linarith

/-- `1 - λ + λ² = H/c²`. -/
theorem legendre_quadratic_eq_core_div (P : ABCPoint) :
    (1 - P.lambda + P.lambda ^ 2 : ℚ) =
      (P.legendreCore : ℚ) / (P.c : ℚ) ^ 2 := by
  have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
  have hsum : (P.a : ℚ) + (P.b : ℚ) = (P.c : ℚ) := by
    exact_mod_cast P.sum_eq
  rw [ABCPoint.lambda]
  unfold legendreCore
  field_simp [hc]
  rw [← hsum]
  push_cast
  ring

/-- The core is coprime to `a`. -/
theorem coprime_a_legendreCore (P : ABCPoint) :
    Nat.Coprime P.a P.legendreCore := by
  have hab : Nat.Coprime P.a P.b := P.pairwise_coprime.1
  have hab2 : Nat.Coprime P.a (P.b ^ 2) := hab.pow_right 2
  rw [legendreCore]
  rw [show P.a ^ 2 + P.a * P.b + P.b ^ 2 =
      P.b ^ 2 + P.a * (P.a + P.b) by ring]
  simpa using
    (Nat.coprime_add_mul_left_right P.a (P.b ^ 2) (P.a + P.b)).2 hab2

/-- The core is coprime to `b`. -/
theorem coprime_b_legendreCore (P : ABCPoint) :
    Nat.Coprime P.b P.legendreCore := by
  have hba : Nat.Coprime P.b P.a := P.pairwise_coprime.1.symm
  have hba2 : Nat.Coprime P.b (P.a ^ 2) := hba.pow_right 2
  rw [legendreCore]
  rw [show P.a ^ 2 + P.a * P.b + P.b ^ 2 =
      P.a ^ 2 + P.b * (P.a + P.b) by ring]
  simpa using
    (Nat.coprime_add_mul_left_right P.b (P.a ^ 2) (P.a + P.b)).2 hba2

/-- The core is coprime to `c`. -/
theorem coprime_c_legendreCore (P : ABCPoint) :
    Nat.Coprime P.c P.legendreCore := by
  have hca : Nat.Coprime P.c P.a := P.coprime_a_c.symm
  have hca2 : Nat.Coprime P.c (P.a ^ 2) := hca.pow_right 2
  rw [legendreCore]
  rw [show P.a ^ 2 + P.a * P.b + P.b ^ 2 =
      P.a ^ 2 + (P.a + P.b) * P.b by ring]
  rw [P.sum_eq]
  simpa using
    (Nat.coprime_add_mul_left_right P.c (P.a ^ 2) P.b).2 hca2

/-- No prime dividing `abc` divides the Legendre numerator core. -/
theorem coprime_abc_legendreCore (P : ABCPoint) :
    Nat.Coprime (P.a * P.b * P.c) P.legendreCore := by
  rw [Nat.coprime_mul_iff_left, Nat.coprime_mul_iff_left]
  exact ⟨⟨P.coprime_a_legendreCore, P.coprime_b_legendreCore⟩,
    P.coprime_c_legendreCore⟩

/-- The quadratic core is at most `c²`. -/
theorem legendreCore_le_c_sq (P : ABCPoint) :
    P.legendreCore ≤ P.c ^ 2 := by
  rw [← P.sum_eq]
  unfold legendreCore
  nlinarith [Nat.zero_le (P.a * P.b)]

/-- A uniform lower bound: `H ≥ 3c²/4`. -/
theorem three_c_sq_le_four_legendreCore (P : ABCPoint) :
    3 * P.c ^ 2 ≤ 4 * P.legendreCore := by
  have hsum : (P.a : ℤ) + (P.b : ℤ) = (P.c : ℤ) := by
    exact_mod_cast P.sum_eq
  have hsquare : 0 ≤ ((P.a : ℤ) - (P.b : ℤ)) ^ 2 := sq_nonneg _
  unfold legendreCore
  exact_mod_cast (show 3 * (P.c : ℤ) ^ 2 ≤
      4 * ((P.a : ℤ) ^ 2 + (P.a : ℤ) * (P.b : ℤ) + (P.b : ℤ) ^ 2) by
    rw [← hsum]
    nlinarith)

end ABCPoint

/-- Exact rational expression for the Legendre `j`-invariant in terms of the
primitive abc triple. -/
theorem abcLegendre_j_eq_core
    (P : ABCPoint) :
    (abcLegendreCurve P).j =
      256 * (P.legendreCore : ℚ) ^ 3 /
        ((P.a : ℚ) ^ 2 * (P.b : ℚ) ^ 2 * (P.c : ℚ) ^ 2) := by
  calc
    (abcLegendreCurve P).j =
        256 * (1 - P.lambda + P.lambda ^ 2) ^ 3 /
          (P.lambda ^ 2 * (1 - P.lambda) ^ 2) := abcLegendre_j P
    _ = 256 * (P.legendreCore : ℚ) ^ 3 /
          ((P.a : ℚ) ^ 2 * (P.b : ℚ) ^ 2 * (P.c : ℚ) ^ 2) := by
      rw [P.legendre_quadratic_eq_core_div,
        P.one_sub_lambda_eq_b_div_c, ABCPoint.lambda]
      have ha : (P.a : ℚ) ≠ 0 := by exact_mod_cast P.a_pos.ne'
      have hb : (P.b : ℚ) ≠ 0 := by exact_mod_cast P.b_pos.ne'
      have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
      field_simp [ha, hb, hc]

end IUTThreeClosures
