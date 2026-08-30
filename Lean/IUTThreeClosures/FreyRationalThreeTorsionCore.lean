/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyDiscriminantConductor
import Mathlib.Tactic

/-!
# A source-derived rational three-torsion Frey core

For a primitive positive triple `a + b = c`, this module attaches the two
Tate-normal-form curves

`E_a : y^2 + 3a*x*y + a^2*c*y = x^3`,

`E_b : y^2 + 3b*x*y + b^2*c*y = x^3`.

It proves their exact Weierstrass invariants, discriminants and rational
`j`-maps.  Their modular parameter has degree four:

`j = t*(t-24)^3/(t-27)`, with `t = 27a/c` or `27b/c`.

The absolute discriminants introduce no variable bad prime beyond the original
abc support: their radicals lie between `rad(abc)` and `3*rad(abc)`.  Finally,
the two raw `j` denominators are `b*c^3` and `a*c^3`, and one of them controls
`c^4` up to the absolute factor two.

No Szpiro, IUT, Vojta, height--conductor or abc estimate is assumed.
-/

namespace IUTThreeClosures

open WeierstrassCurve UniqueFactorizationMonoid

namespace ABCPoint

/-- Tate normal form oriented toward the summand `a`. -/
def abcThreeTorsionCurveA (P : ABCPoint) : WeierstrassCurve ℚ where
  a₁ := 3 * (P.a : ℚ)
  a₂ := 0
  a₃ := (P.a : ℚ) ^ 2 * P.c
  a₄ := 0
  a₆ := 0

/-- The same construction with `a` and `b` interchanged. -/
def abcThreeTorsionCurveB (P : ABCPoint) : WeierstrassCurve ℚ where
  a₁ := 3 * (P.b : ℚ)
  a₂ := 0
  a₃ := (P.b : ℚ) ^ 2 * P.c
  a₄ := 0
  a₆ := 0

@[simp] theorem abcThreeTorsionA_b₂ (P : ABCPoint) :
    P.abcThreeTorsionCurveA.b₂ = 9 * (P.a : ℚ) ^ 2 := by
  simp [abcThreeTorsionCurveA, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcThreeTorsionA_b₄ (P : ABCPoint) :
    P.abcThreeTorsionCurveA.b₄ =
      3 * (P.a : ℚ) ^ 3 * P.c := by
  simp [abcThreeTorsionCurveA, WeierstrassCurve.b₄]
  ring

@[simp] theorem abcThreeTorsionA_b₆ (P : ABCPoint) :
    P.abcThreeTorsionCurveA.b₆ =
      (P.a : ℚ) ^ 4 * P.c ^ 2 := by
  simp [abcThreeTorsionCurveA, WeierstrassCurve.b₆]
  ring

@[simp] theorem abcThreeTorsionA_b₈ (P : ABCPoint) :
    P.abcThreeTorsionCurveA.b₈ = 0 := by
  simp [abcThreeTorsionCurveA, WeierstrassCurve.b₈]

@[simp] theorem abcThreeTorsionA_c₄ (P : ABCPoint) :
    P.abcThreeTorsionCurveA.c₄ =
      9 * (P.a : ℚ) ^ 3 * ((P.a : ℚ) - 8 * P.b) := by
  rw [WeierstrassCurve.c₄, P.abcThreeTorsionA_b₂,
    P.abcThreeTorsionA_b₄]
  have hsum : (P.a : ℚ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcThreeTorsionA_Δ (P : ABCPoint) :
    P.abcThreeTorsionCurveA.Δ =
      -27 * (P.a : ℚ) ^ 8 * P.b * P.c ^ 3 := by
  rw [WeierstrassCurve.Δ, P.abcThreeTorsionA_b₂,
    P.abcThreeTorsionA_b₄, P.abcThreeTorsionA_b₆,
    P.abcThreeTorsionA_b₈]
  have hsum : (P.a : ℚ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcThreeTorsionB_b₂ (P : ABCPoint) :
    P.abcThreeTorsionCurveB.b₂ = 9 * (P.b : ℚ) ^ 2 := by
  simp [abcThreeTorsionCurveB, WeierstrassCurve.b₂]
  ring

@[simp] theorem abcThreeTorsionB_b₄ (P : ABCPoint) :
    P.abcThreeTorsionCurveB.b₄ =
      3 * (P.b : ℚ) ^ 3 * P.c := by
  simp [abcThreeTorsionCurveB, WeierstrassCurve.b₄]
  ring

@[simp] theorem abcThreeTorsionB_b₆ (P : ABCPoint) :
    P.abcThreeTorsionCurveB.b₆ =
      (P.b : ℚ) ^ 4 * P.c ^ 2 := by
  simp [abcThreeTorsionCurveB, WeierstrassCurve.b₆]
  ring

@[simp] theorem abcThreeTorsionB_b₈ (P : ABCPoint) :
    P.abcThreeTorsionCurveB.b₈ = 0 := by
  simp [abcThreeTorsionCurveB, WeierstrassCurve.b₈]

@[simp] theorem abcThreeTorsionB_c₄ (P : ABCPoint) :
    P.abcThreeTorsionCurveB.c₄ =
      9 * (P.b : ℚ) ^ 3 * ((P.b : ℚ) - 8 * P.a) := by
  rw [WeierstrassCurve.c₄, P.abcThreeTorsionB_b₂,
    P.abcThreeTorsionB_b₄]
  have hsum : (P.a : ℚ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

@[simp] theorem abcThreeTorsionB_Δ (P : ABCPoint) :
    P.abcThreeTorsionCurveB.Δ =
      -27 * (P.b : ℚ) ^ 8 * P.a * P.c ^ 3 := by
  rw [WeierstrassCurve.Δ, P.abcThreeTorsionB_b₂,
    P.abcThreeTorsionB_b₄, P.abcThreeTorsionB_b₆,
    P.abcThreeTorsionB_b₈]
  have hsum : (P.a : ℚ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  rw [← hsum]
  ring

noncomputable instance abcThreeTorsionA_isElliptic (P : ABCPoint) :
    P.abcThreeTorsionCurveA.IsElliptic where
  isUnit := by
    rw [P.abcThreeTorsionA_Δ]
    apply isUnit_iff_ne_zero.mpr
    have ha : (P.a : ℚ) ≠ 0 := by exact_mod_cast P.a_pos.ne'
    have hb : (P.b : ℚ) ≠ 0 := by exact_mod_cast P.b_pos.ne'
    have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
    norm_num [ha, hb, hc]

noncomputable instance abcThreeTorsionB_isElliptic (P : ABCPoint) :
    P.abcThreeTorsionCurveB.IsElliptic where
  isUnit := by
    rw [P.abcThreeTorsionB_Δ]
    apply isUnit_iff_ne_zero.mpr
    have ha : (P.a : ℚ) ≠ 0 := by exact_mod_cast P.a_pos.ne'
    have hb : (P.b : ℚ) ≠ 0 := by exact_mod_cast P.b_pos.ne'
    have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
    norm_num [ha, hb, hc]

/-- Exact rational `j`-invariant in the `a` orientation. -/
theorem abcThreeTorsionA_j (P : ABCPoint) :
    P.abcThreeTorsionCurveA.j =
      -27 * (P.a : ℚ) * ((P.a : ℚ) - 8 * P.b) ^ 3 /
        ((P.b : ℚ) * P.c ^ 3) := by
  rw [WeierstrassCurve.j]
  simp only [Units.val_inv_eq_inv_val, WeierstrassCurve.coe_Δ',
    P.abcThreeTorsionA_Δ, P.abcThreeTorsionA_c₄]
  have ha : (P.a : ℚ) ≠ 0 := by exact_mod_cast P.a_pos.ne'
  have hb : (P.b : ℚ) ≠ 0 := by exact_mod_cast P.b_pos.ne'
  have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
  field_simp [ha, hb, hc]
  ring

/-- Exact rational `j`-invariant in the `b` orientation. -/
theorem abcThreeTorsionB_j (P : ABCPoint) :
    P.abcThreeTorsionCurveB.j =
      -27 * (P.b : ℚ) * ((P.b : ℚ) - 8 * P.a) ^ 3 /
        ((P.a : ℚ) * P.c ^ 3) := by
  rw [WeierstrassCurve.j]
  simp only [Units.val_inv_eq_inv_val, WeierstrassCurve.coe_Δ',
    P.abcThreeTorsionB_Δ, P.abcThreeTorsionB_c₄]
  have ha : (P.a : ℚ) ≠ 0 := by exact_mod_cast P.a_pos.ne'
  have hb : (P.b : ℚ) ≠ 0 := by exact_mod_cast P.b_pos.ne'
  have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
  field_simp [ha, hb, hc]
  ring

/-- Degree-four Tate parameter in the `a` orientation. -/
noncomputable def threeTorsionParameterA (P : ABCPoint) : ℚ :=
  27 * (P.a : ℚ) / P.c

/-- Degree-four Tate parameter in the `b` orientation. -/
noncomputable def threeTorsionParameterB (P : ABCPoint) : ℚ :=
  27 * (P.b : ℚ) / P.c

/-- The `a`-oriented `j`-map is `t*(t-24)^3/(t-27)`. -/
theorem abcThreeTorsionA_j_eq_parameter (P : ABCPoint) :
    P.abcThreeTorsionCurveA.j =
      P.threeTorsionParameterA *
          (P.threeTorsionParameterA - 24) ^ 3 /
        (P.threeTorsionParameterA - 27) := by
  rw [P.abcThreeTorsionA_j]
  unfold threeTorsionParameterA
  have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
  have hsum : (P.a : ℚ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  field_simp [hc]
  rw [← hsum]
  ring

/-- The swapped `j`-map has the same degree-four formula. -/
theorem abcThreeTorsionB_j_eq_parameter (P : ABCPoint) :
    P.abcThreeTorsionCurveB.j =
      P.threeTorsionParameterB *
          (P.threeTorsionParameterB - 24) ^ 3 /
        (P.threeTorsionParameterB - 27) := by
  rw [P.abcThreeTorsionB_j]
  unfold threeTorsionParameterB
  have hc : (P.c : ℚ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
  have hsum : (P.a : ℚ) + P.b = P.c := by
    exact_mod_cast P.sum_eq
  field_simp [hc]
  rw [← hsum]
  ring

/-- Positive natural absolute discriminant of the `a`-oriented model. -/
def threeTorsionDiscriminantNatA (P : ABCPoint) : ℕ :=
  27 * P.a ^ 8 * P.b * P.c ^ 3

/-- Positive natural absolute discriminant of the `b`-oriented model. -/
def threeTorsionDiscriminantNatB (P : ABCPoint) : ℕ :=
  27 * P.b ^ 8 * P.a * P.c ^ 3

@[simp] theorem threeTorsionDiscriminantNatA_pos (P : ABCPoint) :
    0 < P.threeTorsionDiscriminantNatA := by
  unfold threeTorsionDiscriminantNatA
  exact mul_pos
    (mul_pos (mul_pos (by norm_num) (pow_pos P.a_pos 8)) P.b_pos)
    (pow_pos P.c_pos 3)

@[simp] theorem threeTorsionDiscriminantNatB_pos (P : ABCPoint) :
    0 < P.threeTorsionDiscriminantNatB := by
  unfold threeTorsionDiscriminantNatB
  exact mul_pos
    (mul_pos (mul_pos (by norm_num) (pow_pos P.b_pos 8)) P.a_pos)
    (pow_pos P.c_pos 3)

/-- The rational discriminant is the negative of the natural absolute value. -/
theorem abcThreeTorsionA_Δ_eq_neg_nat (P : ABCPoint) :
    P.abcThreeTorsionCurveA.Δ =
      -(P.threeTorsionDiscriminantNatA : ℚ) := by
  rw [P.abcThreeTorsionA_Δ]
  unfold threeTorsionDiscriminantNatA
  push_cast
  ring

/-- Swapped version of the natural discriminant identity. -/
theorem abcThreeTorsionB_Δ_eq_neg_nat (P : ABCPoint) :
    P.abcThreeTorsionCurveB.Δ =
      -(P.threeTorsionDiscriminantNatB : ℚ) := by
  rw [P.abcThreeTorsionB_Δ]
  unfold threeTorsionDiscriminantNatB
  push_cast
  ring

/-- The original abc product divides the `a`-oriented discriminant. -/
theorem abcProduct_dvd_threeTorsionDiscriminantNatA (P : ABCPoint) :
    P.a * P.b * P.c ∣ P.threeTorsionDiscriminantNatA := by
  refine ⟨27 * P.a ^ 7 * P.c ^ 2, ?_⟩
  unfold threeTorsionDiscriminantNatA
  ring

/-- The original abc product divides the swapped discriminant. -/
theorem abcProduct_dvd_threeTorsionDiscriminantNatB (P : ABCPoint) :
    P.a * P.b * P.c ∣ P.threeTorsionDiscriminantNatB := by
  refine ⟨27 * P.b ^ 7 * P.c ^ 2, ?_⟩
  unfold threeTorsionDiscriminantNatB
  ring

/-- The `a`-oriented discriminant divides a fixed factor times `(abc)^8`. -/
theorem threeTorsionDiscriminantNatA_dvd_fixed_mul_abc_pow (P : ABCPoint) :
    P.threeTorsionDiscriminantNatA ∣
      27 * (P.a * P.b * P.c) ^ 8 := by
  refine ⟨P.b ^ 7 * P.c ^ 5, ?_⟩
  unfold threeTorsionDiscriminantNatA
  ring

/-- Swapped version of the fixed-support divisibility. -/
theorem threeTorsionDiscriminantNatB_dvd_fixed_mul_abc_pow (P : ABCPoint) :
    P.threeTorsionDiscriminantNatB ∣
      27 * (P.a * P.b * P.c) ^ 8 := by
  refine ⟨P.a ^ 7 * P.c ^ 5, ?_⟩
  unfold threeTorsionDiscriminantNatB
  ring

/-- Every original abc prime remains in the first three-torsion discriminant. -/
theorem abcRadical_le_threeTorsionDiscriminantRadicalA (P : ABCPoint) :
    abcRadical (P.a * P.b * P.c) ≤
      abcRadical P.threeTorsionDiscriminantNatA := by
  have hdiv :
      radical (P.a * P.b * P.c) ∣
        radical P.threeTorsionDiscriminantNatA :=
    radical_dvd_radical P.abcProduct_dvd_threeTorsionDiscriminantNatA
      P.threeTorsionDiscriminantNatA_pos.ne'
  have hle := Nat.le_of_dvd
    (Nat.radical_pos P.threeTorsionDiscriminantNatA) hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- Every original abc prime remains in the swapped discriminant. -/
theorem abcRadical_le_threeTorsionDiscriminantRadicalB (P : ABCPoint) :
    abcRadical (P.a * P.b * P.c) ≤
      abcRadical P.threeTorsionDiscriminantNatB := by
  have hdiv :
      radical (P.a * P.b * P.c) ∣
        radical P.threeTorsionDiscriminantNatB :=
    radical_dvd_radical P.abcProduct_dvd_threeTorsionDiscriminantNatB
      P.threeTorsionDiscriminantNatB_pos.ne'
  have hle := Nat.le_of_dvd
    (Nat.radical_pos P.threeTorsionDiscriminantNatB) hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- The first discriminant introduces at most the fixed prime `3`. -/
theorem threeTorsionDiscriminantRadicalA_le_three (P : ABCPoint) :
    abcRadical P.threeTorsionDiscriminantNatA ≤
      3 * abcRadical (P.a * P.b * P.c) := by
  have htarget : 0 < 27 * (P.a * P.b * P.c) ^ 8 := by
    exact mul_pos (by norm_num)
      (pow_pos (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos) 8)
  have hdiv₁ :
      radical P.threeTorsionDiscriminantNatA ∣
        radical (27 * (P.a * P.b * P.c) ^ 8) :=
    radical_dvd_radical P.threeTorsionDiscriminantNatA_dvd_fixed_mul_abc_pow
      htarget.ne'
  have hdiv₂ :
      radical (27 * (P.a * P.b * P.c) ^ 8) ∣
        radical 27 * radical ((P.a * P.b * P.c) ^ 8) := by
    exact radical_mul_dvd
  have hrad27 : radical (27 : ℕ) = 3 := by
    exact radical_pow_of_prime (a := (3 : ℕ)) Nat.prime_three.prime
      (n := 3) (by norm_num)
  have hpow :
      radical ((P.a * P.b * P.c) ^ 8) =
        radical (P.a * P.b * P.c) :=
    radical_pow _ (by norm_num)
  rw [hrad27, hpow] at hdiv₂
  have hdiv :
      radical P.threeTorsionDiscriminantNatA ∣
        3 * radical (P.a * P.b * P.c) :=
    hdiv₁.trans hdiv₂
  have hpos : 0 < 3 * radical (P.a * P.b * P.c) :=
    mul_pos (by norm_num) (Nat.radical_pos _)
  have hle := Nat.le_of_dvd hpos hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- The swapped discriminant also introduces at most the fixed prime `3`. -/
theorem threeTorsionDiscriminantRadicalB_le_three (P : ABCPoint) :
    abcRadical P.threeTorsionDiscriminantNatB ≤
      3 * abcRadical (P.a * P.b * P.c) := by
  have htarget : 0 < 27 * (P.a * P.b * P.c) ^ 8 := by
    exact mul_pos (by norm_num)
      (pow_pos (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos) 8)
  have hdiv₁ :
      radical P.threeTorsionDiscriminantNatB ∣
        radical (27 * (P.a * P.b * P.c) ^ 8) :=
    radical_dvd_radical P.threeTorsionDiscriminantNatB_dvd_fixed_mul_abc_pow
      htarget.ne'
  have hdiv₂ :
      radical (27 * (P.a * P.b * P.c) ^ 8) ∣
        radical 27 * radical ((P.a * P.b * P.c) ^ 8) := by
    exact radical_mul_dvd
  have hrad27 : radical (27 : ℕ) = 3 := by
    exact radical_pow_of_prime (a := (3 : ℕ)) Nat.prime_three.prime
      (n := 3) (by norm_num)
  have hpow :
      radical ((P.a * P.b * P.c) ^ 8) =
        radical (P.a * P.b * P.c) :=
    radical_pow _ (by norm_num)
  rw [hrad27, hpow] at hdiv₂
  have hdiv :
      radical P.threeTorsionDiscriminantNatB ∣
        3 * radical (P.a * P.b * P.c) :=
    hdiv₁.trans hdiv₂
  have hpos : 0 < 3 * radical (P.a * P.b * P.c) :=
    mul_pos (by norm_num) (Nat.radical_pos _)
  have hle := Nat.le_of_dvd hpos hdiv
  simpa [abcRadical_eq_natRadical] using hle

/-- Raw denominator of the first rational `j` expression. -/
def threeTorsionJRawDenA (P : ABCPoint) : ℕ :=
  P.b * P.c ^ 3

/-- Raw denominator after interchanging `a` and `b`. -/
def threeTorsionJRawDenB (P : ABCPoint) : ℕ :=
  P.a * P.c ^ 3

/-- One of the two raw denominators has quartic source height. -/
theorem c_pow_four_le_two_mul_max_threeTorsionJRawDen (P : ABCPoint) :
    P.c ^ 4 ≤
      2 * max P.threeTorsionJRawDenA P.threeTorsionJRawDenB := by
  by_cases hab : P.a ≤ P.b
  · have hc : P.c ≤ 2 * P.b := by
      rw [← P.sum_eq]
      omega
    calc
      P.c ^ 4 = P.c * P.c ^ 3 := by ring
      _ ≤ (2 * P.b) * P.c ^ 3 :=
        Nat.mul_le_mul_right (P.c ^ 3) hc
      _ = 2 * P.threeTorsionJRawDenA := by
        unfold threeTorsionJRawDenA
        ring
      _ ≤ 2 * max P.threeTorsionJRawDenA
          P.threeTorsionJRawDenB :=
        Nat.mul_le_mul_left 2 (le_max_left _ _)
  · have hba : P.b ≤ P.a := Nat.le_of_lt (Nat.lt_of_not_ge hab)
    have hc : P.c ≤ 2 * P.a := by
      rw [← P.sum_eq]
      omega
    calc
      P.c ^ 4 = P.c * P.c ^ 3 := by ring
      _ ≤ (2 * P.a) * P.c ^ 3 :=
        Nat.mul_le_mul_right (P.c ^ 3) hc
      _ = 2 * P.threeTorsionJRawDenB := by
        unfold threeTorsionJRawDenB
        ring
      _ ≤ 2 * max P.threeTorsionJRawDenA
          P.threeTorsionJRawDenB :=
        Nat.mul_le_mul_left 2 (le_max_right _ _)

#print axioms ABCPoint.abcThreeTorsionA_c₄
#print axioms ABCPoint.abcThreeTorsionA_Δ
#print axioms ABCPoint.abcThreeTorsionB_c₄
#print axioms ABCPoint.abcThreeTorsionB_Δ
#print axioms ABCPoint.abcThreeTorsionA_j
#print axioms ABCPoint.abcThreeTorsionB_j
#print axioms ABCPoint.abcThreeTorsionA_j_eq_parameter
#print axioms ABCPoint.abcThreeTorsionB_j_eq_parameter
#print axioms ABCPoint.abcRadical_le_threeTorsionDiscriminantRadicalA
#print axioms ABCPoint.abcRadical_le_threeTorsionDiscriminantRadicalB
#print axioms ABCPoint.threeTorsionDiscriminantRadicalA_le_three
#print axioms ABCPoint.threeTorsionDiscriminantRadicalB_le_three
#print axioms ABCPoint.c_pow_four_le_two_mul_max_threeTorsionJRawDen

end ABCPoint
end IUTThreeClosures
