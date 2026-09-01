/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.KFullRadicalCompression
import IUTThreeClosures.ArithmeticLeibnizWronskian
import IUTThreeClosures.ABCPointLegendreCurve
import IUTThreeClosures.SquareRootSmoothNeighbourThreshold

/-!
# Mixed-full Campana points and the exact abc gate

For a primitive positive abc point whose three coordinates are respectively
`p`-, `q`-, and `r`-full, this file proves

`rad(abc) ^ (p*q*r) ≤ c ^ (q*r + p*r + p*q)`

and the corresponding exact logarithmic slope

`conductor ≤ (1/p + 1/q + 1/r) * height`.

It then proves, against the unchanged standard `ABCConjecture`, that an
unbounded family with reciprocal sum below one would disprove abc.  No
existence or counting theorem for Campana points is assumed.
-/

namespace IUTThreeClosures
namespace ABCMixedFullCampana20260831

open KFullRadicalCompression

noncomputable section

/-- The three reciprocal orbifold weights of a mixed-full abc point. -/
def mixedFullSlope (p q r : ℕ) : ℝ :=
  1 / (p : ℝ) + 1 / (q : ℝ) + 1 / (r : ℝ)

/-- The three coordinates have their prescribed, possibly different,
fullness exponents. -/
def MixedFull (P : ABCPoint) (p q r : ℕ) : Prop :=
  IsKFull p P.a ∧ IsKFull q P.b ∧ IsKFull r P.c

theorem mixedFullSlope_nonneg (p q r : ℕ) :
    0 ≤ mixedFullSlope p q r := by
  simp only [mixedFullSlope]
  positivity

/-- Clearing the three positive denominators gives the symmetric pair-sum
numerator used by the natural-number radical inequality. -/
theorem mixedFullSlope_eq_pairSum_div_product
    {p q r : ℕ} (hp : 0 < p) (hq : 0 < q) (hr : 0 < r) :
    mixedFullSlope p q r =
      ((q * r + p * r + p * q : ℕ) : ℝ) /
        ((p * q * r : ℕ) : ℝ) := by
  have hp0 : (p : ℝ) ≠ 0 := by exact_mod_cast hp.ne'
  have hq0 : (q : ℝ) ≠ 0 := by exact_mod_cast hq.ne'
  have hr0 : (r : ℝ) ≠ 0 := by exact_mod_cast hr.ne'
  simp only [mixedFullSlope, Nat.cast_add, Nat.cast_mul]
  field_simp

/-- The log-general-type reciprocal condition is exactly the
denominator-cleared integer inequality. -/
theorem mixedFullSlope_lt_one_iff_pairSum_lt_product
    {p q r : ℕ} (hp : 0 < p) (hq : 0 < q) (hr : 0 < r) :
    mixedFullSlope p q r < 1 ↔
      q * r + p * r + p * q < p * q * r := by
  rw [mixedFullSlope_eq_pairSum_div_product hp hq hr]
  have hprod : 0 < (((p * q * r : ℕ) : ℝ)) := by
    positivity
  rw [div_lt_one hprod]
  exact_mod_cast (Iff.rfl :
    q * r + p * r + p * q < p * q * r ↔
      q * r + p * r + p * q < p * q * r)

/-- Denominator-free radical compression for the three different fullness
exponents. -/
theorem radical_pow_pqr_le_c_pow_pairSum
    (P : ABCPoint) {p q r : ℕ} (hfull : MixedFull P p q r) :
    abcRadical (P.a * P.b * P.c) ^ (p * q * r) ≤
      P.c ^ (q * r + p * r + p * q) := by
  rcases hfull with ⟨ha, hb, hc⟩
  have haPow :
      abcRadical P.a ^ (p * q * r) ≤ P.a ^ (q * r) := by
    simpa [pow_mul, Nat.mul_assoc] using
      Nat.pow_le_pow_left ha.radical_pow_le (q * r)
  have hbPow :
      abcRadical P.b ^ (p * q * r) ≤ P.b ^ (p * r) := by
    calc
      abcRadical P.b ^ (p * q * r) =
          (abcRadical P.b ^ q) ^ (p * r) := by
        rw [show p * q * r = q * (p * r) by ring, pow_mul]
      _ ≤ P.b ^ (p * r) :=
        Nat.pow_le_pow_left hb.radical_pow_le (p * r)
  have hcPow :
      abcRadical P.c ^ (p * q * r) ≤ P.c ^ (p * q) := by
    calc
      abcRadical P.c ^ (p * q * r) =
          (abcRadical P.c ^ r) ^ (p * q) := by
        rw [show p * q * r = r * (p * q) by ring, pow_mul]
      _ ≤ P.c ^ (p * q) :=
        Nat.pow_le_pow_left hc.radical_pow_le (p * q)
  have haToC : P.a ^ (q * r) ≤ P.c ^ (q * r) :=
    Nat.pow_le_pow_left (Nat.le_of_lt P.a_lt_c) (q * r)
  have hbToC : P.b ^ (p * r) ≤ P.c ^ (p * r) :=
    Nat.pow_le_pow_left (Nat.le_of_lt P.b_lt_c) (p * r)
  rw [P.abcRadical_abcProduct, mul_pow, mul_pow]
  calc
    abcRadical P.a ^ (p * q * r) *
          abcRadical P.b ^ (p * q * r) *
          abcRadical P.c ^ (p * q * r) ≤
        P.a ^ (q * r) * P.b ^ (p * r) * P.c ^ (p * q) :=
      Nat.mul_le_mul (Nat.mul_le_mul haPow hbPow) hcPow
    _ ≤ P.c ^ (q * r) * P.c ^ (p * r) * P.c ^ (p * q) :=
      Nat.mul_le_mul (Nat.mul_le_mul haToC hbToC) (le_refl _)
    _ = P.c ^ (q * r + p * r + p * q) := by
      rw [← pow_add, ← pow_add]

/-- Exact logarithmic conductor slope for a mixed-full primitive abc point. -/
theorem conductor_le_mixedFullSlope_mul_height
    (P : ABCPoint) {p q r : ℕ}
    (hp : 0 < p) (hq : 0 < q) (hr : 0 < r)
    (hfull : MixedFull P p q r) :
    P.conductor ≤ mixedFullSlope p q r * P.height := by
  rcases hfull with ⟨ha, hb, hc⟩
  have hra : (abcRadical P.a : ℝ) ≠ 0 := by
    exact_mod_cast (abcRadical_pos P.a).ne'
  have hrb : (abcRadical P.b : ℝ) ≠ 0 := by
    exact_mod_cast (abcRadical_pos P.b).ne'
  have hrc : (abcRadical P.c : ℝ) ≠ 0 := by
    exact_mod_cast (abcRadical_pos P.c).ne'
  have hlogProduct :
      Real.log (abcRadical (P.a * P.b * P.c) : ℝ) =
        Real.log (abcRadical P.a : ℝ) +
          Real.log (abcRadical P.b : ℝ) +
            Real.log (abcRadical P.c : ℝ) := by
    rw [P.abcRadical_abcProduct]
    push_cast
    rw [Real.log_mul (mul_ne_zero hra hrb) hrc, Real.log_mul hra hrb]
  have hlogAC : Real.log (P.a : ℝ) ≤ Real.log (P.c : ℝ) := by
    apply Real.log_le_log
    · exact_mod_cast P.a_pos
    · exact_mod_cast Nat.le_of_lt P.a_lt_c
  have hlogBC : Real.log (P.b : ℝ) ≤ Real.log (P.c : ℝ) := by
    apply Real.log_le_log
    · exact_mod_cast P.b_pos
    · exact_mod_cast Nat.le_of_lt P.b_lt_c
  have hpR : 0 < (p : ℝ) := by exact_mod_cast hp
  have hqR : 0 < (q : ℝ) := by exact_mod_cast hq
  have hrR : 0 < (r : ℝ) := by exact_mod_cast hr
  have haBound :
      Real.log (abcRadical P.a : ℝ) ≤
        Real.log (P.c : ℝ) / (p : ℝ) :=
    (ha.log_radical_le_div_log hp).trans
      ((div_le_div_iff_of_pos_right hpR).2 hlogAC)
  have hbBound :
      Real.log (abcRadical P.b : ℝ) ≤
        Real.log (P.c : ℝ) / (q : ℝ) :=
    (hb.log_radical_le_div_log hq).trans
      ((div_le_div_iff_of_pos_right hqR).2 hlogBC)
  have hcBound :
      Real.log (abcRadical P.c : ℝ) ≤
        Real.log (P.c : ℝ) / (r : ℝ) :=
    hc.log_radical_le_div_log hr
  rw [ABCPoint.conductor, hlogProduct, P.height_eq_log_c]
  calc
    Real.log (abcRadical P.a : ℝ) +
          Real.log (abcRadical P.b : ℝ) +
          Real.log (abcRadical P.c : ℝ) ≤
        Real.log (P.c : ℝ) / (p : ℝ) +
          Real.log (P.c : ℝ) / (q : ℝ) +
          Real.log (P.c : ℝ) / (r : ℝ) :=
      add_le_add (add_le_add haBound hbBound) hcBound
    _ = mixedFullSlope p q r * Real.log (P.c : ℝ) := by
      simp only [mixedFullSlope]
      ring

/-- A reciprocal sum below one has a fixed positive abc epsilon margin. -/
theorem exists_positive_epsilon_of_mixedFullSlope_lt_one
    {p q r : ℕ} (hsubunit : mixedFullSlope p q r < 1) :
    ∃ ε : ℝ, 0 < ε ∧ (1 + ε) * mixedFullSlope p q r < 1 :=
  SquareRootSmoothNeighbourThreshold.exists_positive_epsilon_of_subunit_slope
    (mixedFullSlope_nonneg p q r) hsubunit

/-- Under abc, all mixed-full points with fixed log-general-type weights
have a uniform logarithmic height bound. -/
theorem abcConjecture_implies_mixedFull_height_bound
    (habc : ABCConjecture) {p q r : ℕ}
    (hp : 0 < p) (hq : 0 < q) (hr : 0 < r)
    (hsubunit : mixedFullSlope p q r < 1) :
    ∃ H : ℝ, ∀ P : ABCPoint,
      MixedFull P p q r → P.height ≤ H := by
  obtain ⟨ε, hε, hcritical⟩ :=
    exists_positive_epsilon_of_mixedFullSlope_lt_one hsubunit
  obtain ⟨C, hC⟩ := habc ε hε
  let gap : ℝ := 1 - (1 + ε) * mixedFullSlope p q r
  have hgap : 0 < gap := by
    dsimp [gap]
    linarith
  refine ⟨C / gap, ?_⟩
  intro P hfull
  have habcP :
      P.height ≤ (1 + ε) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using
      hC P.a P.b P.c P.a_pos P.b_pos P.c_pos P.sum_eq
        P.pairwise_coprime
  have hcond :=
    conductor_le_mixedFullSlope_mul_height P hp hq hr hfull
  have hone : 0 ≤ 1 + ε := by linarith
  have hscaled :
      (1 + ε) * P.conductor ≤
        (1 + ε) * (mixedFullSlope p q r * P.height) :=
    mul_le_mul_of_nonneg_left hcond hone
  apply (le_div_iff₀ hgap).2
  dsimp [gap]
  nlinarith

/-- An actually unbounded family of mixed-full Campana points in the
log-general-type range is a strict disproof of the standard abc conjecture. -/
theorem not_abcConjecture_of_unbounded_mixedFull_family
    (P : ℕ → ABCPoint) {p q r : ℕ}
    (hp : 0 < p) (hq : 0 < q) (hr : 0 < r)
    (hsubunit : mixedFullSlope p q r < 1)
    (hfull : ∀ n, MixedFull (P n) p q r)
    (hunbounded : ∀ B : ℝ, ∃ n : ℕ, B < (P n).height) :
    ¬ ABCConjecture := by
  obtain ⟨ε, hε, hcritical⟩ :=
    exists_positive_epsilon_of_mixedFullSlope_lt_one hsubunit
  apply not_abcConjecture_of_subcritical_radical_slope
    (fun n => (P n).a) (fun n => (P n).b) (fun n => (P n).c)
    (mixedFullSlope p q r) 0 ε hε hcritical
  · exact fun n => (P n).a_pos
  · exact fun n => (P n).b_pos
  · exact fun n => (P n).c_pos
  · exact fun n => (P n).sum_eq
  · exact fun n => (P n).pairwise_coprime
  · intro B
    obtain ⟨n, hn⟩ := hunbounded B
    exact ⟨n, by
      simpa [familyABCHeightLog, ABCPoint.height] using hn⟩
  · intro n
    have hcond :=
      conductor_le_mixedFullSlope_mul_height (P n) hp hq hr (hfull n)
    simpa [familyABCRadicalLog, familyABCHeightLog,
      ABCPoint.conductor, ABCPoint.height] using hcond

#print axioms radical_pow_pqr_le_c_pow_pairSum
#print axioms mixedFullSlope_eq_pairSum_div_product
#print axioms mixedFullSlope_lt_one_iff_pairSum_lt_product
#print axioms conductor_le_mixedFullSlope_mul_height
#print axioms exists_positive_epsilon_of_mixedFullSlope_lt_one
#print axioms abcConjecture_implies_mixedFull_height_bound
#print axioms not_abcConjecture_of_unbounded_mixedFull_family

end

end ABCMixedFullCampana20260831
end IUTThreeClosures
