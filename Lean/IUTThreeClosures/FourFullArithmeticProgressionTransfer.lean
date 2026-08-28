/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LowRadicalExponentBudget

/-!
# Four-full arithmetic progressions transfer to the negation of abc

For a positive primitive three-term arithmetic progression

`x + z = 2*y`, `Nat.Coprime x (2*y)`,

the associated abc point is `(z,x,2*y)`.  If each of `x,y,z` has fourth-power
radical compression, then

`log rad(z*x*(2*y)) <= (3/4) * log(2*y) + log 2`.

The additive `log 2` is retained exactly.  A general affine logarithmic-gap
certificate shows that any unbounded family of such progressions contradicts
the abc conjecture.  No existence theorem for the family is assumed.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## Affine logarithmic radical-gap certificates -/

/-- A logarithmic radical certificate allowing a fixed additive error. -/
structure AffineLogRadicalGapCertificate
    (P : ABCPoint) (X delta K : ℝ) : Prop where
  X_pos : 0 < X
  height_lower : Real.log X ≤ P.height
  conductor_upper : P.conductor ≤ delta * Real.log X + K

namespace AffineLogRadicalGapCertificate

/-- A sufficiently large affine logarithmic gap violates the abc inequality
at the specified epsilon and additive abc constant. -/
theorem violates_at
    {P : ABCPoint} {X delta K epsilon C : ℝ}
    (G : AffineLogRadicalGapCertificate P X delta K)
    (hepsilon : 0 ≤ epsilon)
    (hgap :
      C + (1 + epsilon) * K <
        (1 - (1 + epsilon) * delta) * Real.log X) :
    ¬ P.height ≤ (1 + epsilon) * P.conductor + C := by
  intro habc
  have hcoeff : 0 ≤ 1 + epsilon := by linarith
  have hscaled :=
    mul_le_mul_of_nonneg_left G.conductor_upper hcoeff
  linarith [G.height_lower]

end AffineLogRadicalGapCertificate

/-- An unbounded family of affine certificates with a fixed positive strict
slope gap disproves abc. -/
theorem not_abc_of_unbounded_affineLogRadicalGaps
    {epsilon delta K : ℝ}
    (hepsilon : 0 < epsilon)
    (P : ℕ → ABCPoint)
    (X : ℕ → ℝ)
    (G : ∀ n, AffineLogRadicalGapCertificate (P n) (X n) delta K)
    (hunboundedGap :
      ∀ T : ℝ, ∃ n : ℕ,
        T < (1 - (1 + epsilon) * delta) * Real.log (X n)) :
    ¬ ABCConjecture := by
  intro habc
  obtain ⟨C, hC⟩ := habc epsilon hepsilon
  obtain ⟨n, hn⟩ :=
    hunboundedGap (C + (1 + epsilon) * K)
  exact (G n).violates_at hepsilon.le hn (hC (P n))

/-- If `delta<1`, ordinary logarithmic unboundedness supplies an abc epsilon
leaving a positive strict slope gap, even in the presence of a fixed additive
error `K`. -/
theorem not_abc_of_unbounded_affineCertificates_of_delta_lt_one
    {delta K : ℝ}
    (hdelta0 : 0 ≤ delta)
    (hdelta1 : delta < 1)
    (P : ℕ → ABCPoint)
    (X : ℕ → ℝ)
    (G : ∀ n, AffineLogRadicalGapCertificate (P n) (X n) delta K)
    (hunbounded : ∀ T : ℝ, ∃ n : ℕ, T < Real.log (X n)) :
    ¬ ABCConjecture := by
  obtain ⟨epsilon, hepsilon, hstrict⟩ :=
    exists_positive_abcEpsilon_of_budget_lt_one hdelta0 hdelta1
  refine not_abc_of_unbounded_affineLogRadicalGaps
    hepsilon P X G ?_
  intro T
  let kappa : ℝ := 1 - (1 + epsilon) * delta
  have hkappa : 0 < kappa := by
    dsimp [kappa]
    linarith
  obtain ⟨n, hn⟩ := hunbounded (T / kappa)
  refine ⟨n, ?_⟩
  have hscaled : T < Real.log (X n) * kappa :=
    (div_lt_iff₀ hkappa).mp hn
  simpa [kappa, mul_comm] using hscaled

/-! ## Three independent radical factors -/

/-- Separate affine logarithmic bounds add at the product level. -/
theorem log_mul_three_le_affine_sum
    {A B C X alpha beta gamma KA KB KC : ℝ}
    (hA : 0 < A) (hB : 0 < B) (hC : 0 < C)
    (hAlog : Real.log A ≤ alpha * Real.log X + KA)
    (hBlog : Real.log B ≤ beta * Real.log X + KB)
    (hClog : Real.log C ≤ gamma * Real.log X + KC) :
    Real.log (A * B * C) ≤
      (alpha + beta + gamma) * Real.log X + (KA + KB + KC) := by
  calc
    Real.log (A * B * C) =
        (Real.log A + Real.log B) + Real.log C := by
      rw [Real.log_mul (mul_pos hA hB).ne' hC.ne',
        Real.log_mul hA.ne' hB.ne']
    _ ≤ ((alpha * Real.log X + KA) +
          (beta * Real.log X + KB)) +
          (gamma * Real.log X + KC) :=
      add_le_add (add_le_add hAlog hBlog) hClog
    _ = (alpha + beta + gamma) * Real.log X +
        (KA + KB + KC) := by ring

/-- Three radical bounds, each with an exponent and a fixed additive
logarithmic error, relative to a common height scale. -/
structure ThreeTermRadicalAffineBudget
    (P : ABCPoint) (X alpha beta gamma KA KB KC : ℝ) where
  A : ℕ
  B : ℕ
  C : ℕ
  X_pos : 0 < X
  height_lower : Real.log X ≤ P.height
  radical_a_le : abcRadical P.a ≤ A
  radical_b_le : abcRadical P.b ≤ B
  radical_c_le : abcRadical P.c ≤ C
  radical_a_log_le :
    Real.log (A : ℝ) ≤ alpha * Real.log X + KA
  radical_b_log_le :
    Real.log (B : ℝ) ≤ beta * Real.log X + KB
  radical_c_log_le :
    Real.log (C : ℝ) ≤ gamma * Real.log X + KC

namespace ThreeTermRadicalAffineBudget

variable {P : ABCPoint} {X alpha beta gamma KA KB KC : ℝ}

@[simp]
theorem A_pos
    (E : ThreeTermRadicalAffineBudget P X alpha beta gamma KA KB KC) :
    0 < E.A :=
  (abcRadical_pos P.a).trans_le E.radical_a_le

@[simp]
theorem B_pos
    (E : ThreeTermRadicalAffineBudget P X alpha beta gamma KA KB KC) :
    0 < E.B :=
  (abcRadical_pos P.b).trans_le E.radical_b_le

@[simp]
theorem C_pos
    (E : ThreeTermRadicalAffineBudget P X alpha beta gamma KA KB KC) :
    0 < E.C :=
  (abcRadical_pos P.c).trans_le E.radical_c_le

/-- Radical submultiplicativity transfers the three coordinate bounds to the
abc conductor radical. -/
theorem point_radical_le
    (E : ThreeTermRadicalAffineBudget P X alpha beta gamma KA KB KC) :
    abcRadical (P.a * P.b * P.c) ≤ E.A * E.B * E.C := by
  calc
    abcRadical (P.a * P.b * P.c) ≤
        abcRadical (P.a * P.b) * abcRadical P.c :=
      abcRadical_mul_le_mul (P.a * P.b) P.c
    _ ≤ (abcRadical P.a * abcRadical P.b) * abcRadical P.c :=
      Nat.mul_le_mul_right _ (abcRadical_mul_le_mul P.a P.b)
    _ ≤ (E.A * E.B) * E.C :=
      Nat.mul_le_mul
        (Nat.mul_le_mul E.radical_a_le E.radical_b_le)
        E.radical_c_le
    _ = E.A * E.B * E.C := rfl

/-- The canonical conductor is bounded by the logarithm of the three supplied
radical bounds. -/
theorem conductor_le_log_product
    (E : ThreeTermRadicalAffineBudget P X alpha beta gamma KA KB KC) :
    P.conductor ≤ Real.log (((E.A * E.B * E.C : ℕ) : ℝ)) := by
  change
    Real.log ((abcRadical (P.a * P.b * P.c) : ℕ) : ℝ) ≤
      Real.log (((E.A * E.B * E.C : ℕ) : ℝ))
  have hrad : 0 < ((abcRadical (P.a * P.b * P.c) : ℕ) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  apply Real.log_le_log hrad
  exact_mod_cast E.point_radical_le

/-- The three-factor budget gives one affine logarithmic-gap certificate. -/
def toAffineLogRadicalGapCertificate
    (E : ThreeTermRadicalAffineBudget P X alpha beta gamma KA KB KC) :
    AffineLogRadicalGapCertificate P X
      (alpha + beta + gamma) (KA + KB + KC) where
  X_pos := E.X_pos
  height_lower := E.height_lower
  conductor_upper :=
    E.conductor_le_log_product.trans <| by
      simpa only [Nat.cast_mul] using
        (log_mul_three_le_affine_sum
          (A := (E.A : ℝ)) (B := (E.B : ℝ)) (C := (E.C : ℝ))
          (X := X)
          (alpha := alpha) (beta := beta) (gamma := gamma)
          (KA := KA) (KB := KB) (KC := KC)
          (by exact_mod_cast E.A_pos)
          (by exact_mod_cast E.B_pos)
          (by exact_mod_cast E.C_pos)
          E.radical_a_log_le E.radical_b_log_le E.radical_c_log_le)

end ThreeTermRadicalAffineBudget

/-! ## Primitive three-term arithmetic progressions -/

/-- A positive three-term arithmetic progression whose associated equation
`z+x=2*y` is primitive. -/
structure PrimitiveThreeTermAPData where
  x : ℕ
  y : ℕ
  z : ℕ
  x_pos : 0 < x
  y_pos : 0 < y
  z_pos : 0 < z
  ap_eq : x + z = 2 * y
  coprime_x_two_y : Nat.Coprime x (2 * y)

namespace PrimitiveThreeTermAPData

/-- Regard `z+x=2*y` as the coprime-neighbour abc point with `b=x` and
`c=2*y`. -/
def toNeighbour (D : PrimitiveThreeTermAPData) :
    CoprimeNeighbourData where
  b := D.x
  c := 2 * D.y
  b_pos := D.x_pos
  b_lt_c := by omega
  coprime_bc := D.coprime_x_two_y

@[simp]
theorem toNeighbour_a (D : PrimitiveThreeTermAPData) :
    D.toNeighbour.a = D.z := by
  change 2 * D.y - D.x = D.z
  omega

/-- The associated primitive abc point `(z,x,2*y)`. -/
def point (D : PrimitiveThreeTermAPData) : ABCPoint :=
  D.toNeighbour.point

@[simp]
theorem point_a (D : PrimitiveThreeTermAPData) : D.point.a = D.z := by
  change D.toNeighbour.a = D.z
  exact D.toNeighbour_a

@[simp]
theorem point_b (D : PrimitiveThreeTermAPData) : D.point.b = D.x := rfl

@[simp]
theorem point_c (D : PrimitiveThreeTermAPData) :
    D.point.c = 2 * D.y := rfl

@[simp]
theorem point_height (D : PrimitiveThreeTermAPData) :
    D.point.height = Real.log ((2 * D.y : ℕ) : ℝ) := by
  simpa [point, toNeighbour] using D.toNeighbour.point_height

@[simp]
theorem x_lt_two_y (D : PrimitiveThreeTermAPData) :
    D.x < 2 * D.y := by omega

@[simp]
theorem z_lt_two_y (D : PrimitiveThreeTermAPData) :
    D.z < 2 * D.y := by omega

@[simp]
theorem y_le_two_y (D : PrimitiveThreeTermAPData) :
    D.y ≤ 2 * D.y := by omega

end PrimitiveThreeTermAPData

/-! ## Fourth-power radical compression -/

/-- A primitive arithmetic progression whose three original entries satisfy
the exact radical compression enjoyed by every positive four-full integer. -/
structure FourthRadicalCompressedAPData where
  ap : PrimitiveThreeTermAPData
  radical_x_four_le : abcRadical ap.x ^ 4 ≤ ap.x
  radical_y_four_le : abcRadical ap.y ^ 4 ≤ ap.y
  radical_z_four_le : abcRadical ap.z ^ 4 ≤ ap.z

/-- Taking logarithms of a radical-power bound. -/
theorem natCast_mul_log_radical_le_log_of_pow_le
    {n c r : ℕ}
    (hr : 0 < r) (hc : 0 < c)
    (hpow : abcRadical n ^ r ≤ c) :
    (r : ℝ) * Real.log ((abcRadical n : ℕ) : ℝ) ≤
      Real.log (c : ℝ) := by
  have hrad : 0 < ((abcRadical n : ℕ) : ℝ) := by
    exact_mod_cast abcRadical_pos n
  have hpowPos :
      0 < (((abcRadical n ^ r : ℕ) : ℝ)) := by
    exact_mod_cast pow_pos (abcRadical_pos n) r
  have hcast :
      (((abcRadical n ^ r : ℕ) : ℝ)) ≤ (c : ℝ) := by
    exact_mod_cast hpow
  have hlog := Real.log_le_log hpowPos hcast
  rw [Nat.cast_pow, Real.log_pow] at hlog
  simpa using hlog

/-- The fixed coefficient `2` contributes at most a factor two to the
radical. -/
theorem abcRadical_two_mul_le (y : ℕ) :
    abcRadical (2 * y) ≤ 2 * abcRadical y := by
  calc
    abcRadical (2 * y) ≤ abcRadical 2 * abcRadical y :=
      abcRadical_mul_le_mul 2 y
    _ ≤ 2 * abcRadical y :=
      Nat.mul_le_mul_right _ (abcRadical_le_self (by norm_num : 2 ≠ 0))

namespace FourthRadicalCompressedAPData

/-- The exact three-factor affine budget with visible `log 2` error. -/
def affineBudget (D : FourthRadicalCompressedAPData) :
    ThreeTermRadicalAffineBudget D.ap.point
      ((2 * D.ap.y : ℕ) : ℝ)
      (1 / 4 : ℝ) (1 / 4 : ℝ) (1 / 4 : ℝ)
      0 0 (Real.log 2) := by
  have hc : 0 < 2 * D.ap.y := by omega
  have hxpow : abcRadical D.ap.x ^ 4 ≤ 2 * D.ap.y :=
    D.radical_x_four_le.trans D.ap.x_lt_two_y.le
  have hypow : abcRadical D.ap.y ^ 4 ≤ 2 * D.ap.y :=
    D.radical_y_four_le.trans D.ap.y_le_two_y
  have hzpow : abcRadical D.ap.z ^ 4 ≤ 2 * D.ap.y :=
    D.radical_z_four_le.trans D.ap.z_lt_two_y.le
  have hx4 :=
    natCast_mul_log_radical_le_log_of_pow_le
      (n := D.ap.x) (c := 2 * D.ap.y) (r := 4)
      (by norm_num) hc hxpow
  have hy4 :=
    natCast_mul_log_radical_le_log_of_pow_le
      (n := D.ap.y) (c := 2 * D.ap.y) (r := 4)
      (by norm_num) hc hypow
  have hz4 :=
    natCast_mul_log_radical_le_log_of_pow_le
      (n := D.ap.z) (c := 2 * D.ap.y) (r := 4)
      (by norm_num) hc hzpow
  have hxlog :
      Real.log ((abcRadical D.ap.x : ℕ) : ℝ) ≤
        (1 / 4 : ℝ) * Real.log ((2 * D.ap.y : ℕ) : ℝ) := by
    norm_num at hx4 ⊢
    linarith
  have hylog :
      Real.log ((abcRadical D.ap.y : ℕ) : ℝ) ≤
        (1 / 4 : ℝ) * Real.log ((2 * D.ap.y : ℕ) : ℝ) := by
    norm_num at hy4 ⊢
    linarith
  have hzlog :
      Real.log ((abcRadical D.ap.z : ℕ) : ℝ) ≤
        (1 / 4 : ℝ) * Real.log ((2 * D.ap.y : ℕ) : ℝ) := by
    norm_num at hz4 ⊢
    linarith
  refine
    { A := abcRadical D.ap.z
      B := abcRadical D.ap.x
      C := 2 * abcRadical D.ap.y
      X_pos := by exact_mod_cast hc
      height_lower := by rw [D.ap.point_height]
      radical_a_le := by simp
      radical_b_le := by simp
      radical_c_le := by
        simpa using abcRadical_two_mul_le D.ap.y
      radical_a_log_le := by simpa using hzlog
      radical_b_log_le := by simpa using hxlog
      radical_c_log_le := ?_ }
  have hradY : 0 < ((abcRadical D.ap.y : ℕ) : ℝ) := by
    exact_mod_cast abcRadical_pos D.ap.y
  rw [Nat.cast_mul, Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hradY.ne']
  linarith

/-- The primitive abc point attached to a four-compressed progression has
conductor slope `3/4` and only the fixed additive error `log 2`. -/
def affineCertificate (D : FourthRadicalCompressedAPData) :
    AffineLogRadicalGapCertificate D.ap.point
      ((2 * D.ap.y : ℕ) : ℝ) (3 / 4 : ℝ) (Real.log 2) := by
  simpa [show (1 / 4 : ℝ) + 1 / 4 + 1 / 4 = 3 / 4 by norm_num]
    using D.affineBudget.toAffineLogRadicalGapCertificate

/-- Explicit logarithmic conductor bound for the associated primitive abc
point. -/
theorem conductor_le_three_quarters_log_add_log_two
    (D : FourthRadicalCompressedAPData) :
    D.ap.point.conductor ≤
      (3 / 4 : ℝ) * Real.log ((2 * D.ap.y : ℕ) : ℝ) +
        Real.log 2 :=
  D.affineCertificate.conductor_upper

end FourthRadicalCompressedAPData

/-- An unbounded family of primitive fourth-power-radical-compressed
three-term arithmetic progressions disproves abc. -/
theorem not_abc_of_unbounded_fourthRadicalCompressedAPs
    (D : ℕ → FourthRadicalCompressedAPData)
    (hunbounded :
      ∀ T : ℝ, ∃ n : ℕ,
        T < Real.log ((2 * (D n).ap.y : ℕ) : ℝ)) :
    ¬ ABCConjecture := by
  refine not_abc_of_unbounded_affineCertificates_of_delta_lt_one
    (delta := (3 / 4 : ℝ)) (K := Real.log 2)
    (by norm_num) (by norm_num)
    (fun n => (D n).ap.point)
    (fun n => ((2 * (D n).ap.y : ℕ) : ℝ))
    (fun n => (D n).affineCertificate)
    hunbounded

/-! ## Exact elementary threshold audit -/

/-- Three generic powerful (`2`-full) radical costs are above the strict abc
threshold. -/
theorem powerful_three_term_reciprocal_sum_not_lt_one :
    ¬ ((2 : ℝ)⁻¹ + (2 : ℝ)⁻¹ + (2 : ℝ)⁻¹ < 1) := by
  norm_num

/-- Three generic `3`-full radical costs give equality, not a strict gap. -/
theorem threeFull_three_term_reciprocal_sum_not_lt_one :
    ¬ ((3 : ℝ)⁻¹ + (3 : ℝ)⁻¹ + (3 : ℝ)⁻¹ < 1) := by
  norm_num

/-- Four-fullness is the first uniform full-power level crossing the
three-term threshold. -/
theorem fourFull_three_term_reciprocal_sum_lt_one :
    (4 : ℝ)⁻¹ + (4 : ℝ)⁻¹ + (4 : ℝ)⁻¹ < 1 := by
  norm_num

end
end IUTThreeClosures
