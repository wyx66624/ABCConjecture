/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArithmeticWronskianQuantization
import Mathlib.Algebra.Order.Floor.Ring
import Mathlib.Tactic

/-!
# Saturation of the normalized arithmetic Wronskian lattice

The exact quotient determinant has a simple normalized geometry.  On the real
line

`y - x = d`,

an integer diagonal translate changes neither the difference nor the
Wronskian index.  If `d >= 1`, one translate places `x` in `[-d,0]`, so that

`|x| + |y| = d`.

Applied to the powerful-part quotient lattice of an abc point, this says that
whenever `c >= rad(abc)`, the abstract compatible derivative-value lattice has
a representative whose normalized mass is exactly `c / rad(abc)`.  Therefore
the elementary Wronskian height inequality is saturated at the abstract
endpoint-value level.  Any genuine abc gain must use the special image of a
prime-weight derivative or another arithmetic/geometric restriction; it cannot
come from the divisibility lattice alone.
-/

namespace IUTThreeClosures
namespace ArithmeticWronskianSaturation

noncomputable section

/-- Every interval of length at least one contains a translate of a prescribed
real number by an integer.  The chosen translate lies in `[-d,0]`. -/
theorem exists_integer_translate_in_neg_interval
    (x d : ℝ) (hd : 1 ≤ d) :
    ∃ k : ℤ, -d ≤ x + (k : ℝ) ∧ x + (k : ℝ) ≤ 0 := by
  refine ⟨⌊-x⌋, ?_, ?_⟩
  · have hfloor : -x - 1 < (⌊-x⌋ : ℝ) := by
      simpa using (Int.sub_one_lt_floor (-x))
    linarith
  · have hfloor : (⌊-x⌋ : ℝ) ≤ -x := Int.floor_le (-x)
    linarith

/-- On a line of positive difference at least one, an integer diagonal
translate attains the triangle lower bound exactly. -/
theorem exists_integer_translate_exact_l1
    (x y d : ℝ) (hline : y - x = d) (hd : 1 ≤ d) :
    ∃ k : ℤ,
      |x + (k : ℝ)| + |y + (k : ℝ)| = d := by
  obtain ⟨k, hxlow, hxhigh⟩ :=
    exists_integer_translate_in_neg_interval x d hd
  refine ⟨k, ?_⟩
  have hy : 0 ≤ y + (k : ℝ) := by
    linarith
  rw [abs_of_nonpos hxhigh, abs_of_nonneg hy]
  linarith

/-- The determinant index gives the exact universal lower bound for normalized
quotient mass. -/
theorem normalizedDeterminant_lower_bound
    {ra rb qc u v t : ℝ}
    (hra : 0 < ra) (hrb : 0 < rb)
    (hdet : ra * v - rb * u = qc * t) :
    |qc * t| / (ra * rb) ≤ |u| / ra + |v| / rb := by
  have htri :
      |qc * t| ≤ ra * |v| + rb * |u| := by
    rw [← hdet]
    calc
      |ra * v - rb * u| ≤ |ra * v| + |rb * u| := abs_sub _ _
      _ = ra * |v| + rb * |u| := by
        rw [abs_mul, abs_mul, abs_of_pos hra, abs_of_pos hrb]
  have hprod : 0 < ra * rb := mul_pos hra hrb
  apply (div_le_iff₀ hprod).2
  calc
    |qc * t| ≤ ra * |v| + rb * |u| := htri
    _ = (|u| / ra + |v| / rb) * (ra * rb) := by
      field_simp [hra.ne', hrb.ne']
      ring

/-- A determinant-one quotient pair can be shifted to attain its normalized
lower bound whenever that lower bound is at least one. -/
theorem exists_integer_shift_exact_normalizedMass
    {ra rb qc u v : ℝ}
    (hra : 0 < ra) (hrb : 0 < rb)
    (hdet : ra * v - rb * u = qc)
    (hlarge : 1 ≤ qc / (ra * rb)) :
    ∃ k : ℤ,
      ra * (v + rb * (k : ℝ)) -
          rb * (u + ra * (k : ℝ)) = qc ∧
        |u + ra * (k : ℝ)| / ra +
          |v + rb * (k : ℝ)| / rb = qc / (ra * rb) := by
  have hline : v / rb - u / ra = qc / (ra * rb) := by
    field_simp [hra.ne', hrb.ne']
    nlinarith [hdet]
  obtain ⟨k, hmass⟩ :=
    exists_integer_translate_exact_l1
      (u / ra) (v / rb) (qc / (ra * rb)) hline hlarge
  refine ⟨k, ?_, ?_⟩
  · nlinarith [hdet]
  · have hu :
        (u + ra * (k : ℝ)) / ra = u / ra + (k : ℝ) := by
      field_simp [hra.ne']
      ring
    have hv :
        (v + rb * (k : ℝ)) / rb = v / rb + (k : ℝ) := by
      field_simp [hrb.ne']
      ring
    have huabs :
        |u + ra * (k : ℝ)| / ra =
          |(u + ra * (k : ℝ)) / ra| := by
      rw [abs_div, abs_of_pos hra]
    have hvabs :
        |v + rb * (k : ℝ)| / rb =
          |(v + rb * (k : ℝ)) / rb| := by
      rw [abs_div, abs_of_pos hrb]
    calc
      |u + ra * (k : ℝ)| / ra +
          |v + rb * (k : ℝ)| / rb =
        |(u + ra * (k : ℝ)) / ra| +
          |(v + rb * (k : ℝ)) / rb| := by
            rw [huabs, hvabs]
      _ = |u / ra + (k : ℝ)| + |v / rb + (k : ℝ)| := by
            rw [hu, hv]
      _ = qc / (ra * rb) := hmass

namespace ABCPoint

/-- The normalized determinant spacing is exactly `c / rad(abc)`. -/
theorem powerful_c_ratio_eq_heightRadical_ratio (P : ABCPoint) :
    (abcPowerfulPart P.c : ℝ) /
        ((abcRadical P.a : ℝ) * (abcRadical P.b : ℝ)) =
      (P.c : ℝ) /
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
  have hra : 0 < (abcRadical P.a : ℝ) := by
    exact_mod_cast abcRadical_pos P.a
  have hrb : 0 < (abcRadical P.b : ℝ) := by
    exact_mod_cast abcRadical_pos P.b
  have hrc : 0 < (abcRadical P.c : ℝ) := by
    exact_mod_cast abcRadical_pos P.c
  have hrad :
      (abcRadical (P.a * P.b * P.c) : ℝ) =
        (abcRadical P.a : ℝ) *
          (abcRadical P.b : ℝ) *
            (abcRadical P.c : ℝ) := by
    exact_mod_cast P.abcRadical_abcProduct
  have hc :
      (abcRadical P.c : ℝ) * (abcPowerfulPart P.c : ℝ) =
        (P.c : ℝ) := by
    exact_mod_cast abcRadical_mul_abcPowerfulPart P.c
  rw [hrad, ← hc]
  field_simp [hra.ne', hrb.ne', hrc.ne']
  ring

/-- If `c >= rad(abc)`, every determinant-one quotient solution has an integer
diagonal shift whose normalized mass is exactly `c / rad(abc)`. -/
theorem exists_shift_saturating_abstract_normalizedMass
    (P : ABCPoint) (u v : ℤ)
    (hdet :
      (abcRadical P.a : ℤ) * v -
          (abcRadical P.b : ℤ) * u =
        (abcPowerfulPart P.c : ℤ))
    (hlarge : abcRadical (P.a * P.b * P.c) ≤ P.c) :
    ∃ k : ℤ,
      (abcRadical P.a : ℝ) *
          ((v : ℝ) + (abcRadical P.b : ℝ) * (k : ℝ)) -
        (abcRadical P.b : ℝ) *
          ((u : ℝ) + (abcRadical P.a : ℝ) * (k : ℝ)) =
          (abcPowerfulPart P.c : ℝ) ∧
      |(u : ℝ) + (abcRadical P.a : ℝ) * (k : ℝ)| /
          (abcRadical P.a : ℝ) +
        |(v : ℝ) + (abcRadical P.b : ℝ) * (k : ℝ)| /
          (abcRadical P.b : ℝ) =
        (P.c : ℝ) /
          (abcRadical (P.a * P.b * P.c) : ℝ) := by
  have hra : 0 < (abcRadical P.a : ℝ) := by
    exact_mod_cast abcRadical_pos P.a
  have hrb : 0 < (abcRadical P.b : ℝ) := by
    exact_mod_cast abcRadical_pos P.b
  have hrabc :
      0 < (abcRadical (P.a * P.b * P.c) : ℝ) := by
    exact_mod_cast abcRadical_pos (P.a * P.b * P.c)
  have hdetR :
      (abcRadical P.a : ℝ) * (v : ℝ) -
          (abcRadical P.b : ℝ) * (u : ℝ) =
        (abcPowerfulPart P.c : ℝ) := by
    exact_mod_cast hdet
  have hlargeR :
      (abcRadical (P.a * P.b * P.c) : ℝ) ≤ (P.c : ℝ) := by
    exact_mod_cast hlarge
  have hone :
      1 ≤ (P.c : ℝ) /
        (abcRadical (P.a * P.b * P.c) : ℝ) := by
    apply (le_div_iff₀ hrabc).2
    simpa using hlargeR
  have hspacing :
      1 ≤ (abcPowerfulPart P.c : ℝ) /
        ((abcRadical P.a : ℝ) * (abcRadical P.b : ℝ)) := by
    rw [P.powerful_c_ratio_eq_heightRadical_ratio]
    exact hone
  obtain ⟨k, hshift, hmass⟩ :=
    exists_integer_shift_exact_normalizedMass
      hra hrb hdetR hspacing
  refine ⟨k, hshift, ?_⟩
  rw [P.powerful_c_ratio_eq_heightRadical_ratio] at hmass
  exact hmass

/-- Every integer Wronskian index is realized by compatible derivative values.
In particular the exact lattice spectrum is the full powerful-product ideal. -/
theorem exists_compatibleDerivative_wronskianIndex
    (P : ABCPoint) (t : ℤ) :
    ∃ Da Db Dc : ℤ,
      Da + Db = Dc ∧
      (abcPowerfulPart P.a : ℤ) ∣ Da ∧
      (abcPowerfulPart P.b : ℤ) ∣ Db ∧
      (abcPowerfulPart P.c : ℤ) ∣ Dc ∧
      arithmeticWronskian P Da Db =
        (abcPowerfulPart P.a : ℤ) *
          (abcPowerfulPart P.b : ℤ) *
            (abcPowerfulPart P.c : ℤ) * t := by
  obtain ⟨Da, Db, Dc, hadd, hDa, hDb, hDc, hW⟩ :=
    P.exists_compatibleDerivative_minimalWronskian
  refine ⟨t * Da, t * Db, t * Dc, ?_, ?_, ?_, ?_, ?_⟩
  · calc
      t * Da + t * Db = t * (Da + Db) := by ring
      _ = t * Dc := by rw [hadd]
  · exact dvd_mul_of_dvd_right hDa t
  · exact dvd_mul_of_dvd_right hDb t
  · exact dvd_mul_of_dvd_right hDc t
  · unfold arithmeticWronskian at hW ⊢
    rw [hW]
    ring

end ABCPoint

#print axioms exists_integer_translate_exact_l1
#print axioms normalizedDeterminant_lower_bound
#print axioms exists_integer_shift_exact_normalizedMass
#print axioms ABCPoint.powerful_c_ratio_eq_heightRadical_ratio
#print axioms ABCPoint.exists_shift_saturating_abstract_normalizedMass
#print axioms ABCPoint.exists_compatibleDerivative_wronskianIndex

end
end ArithmeticWronskianSaturation
end IUTThreeClosures
