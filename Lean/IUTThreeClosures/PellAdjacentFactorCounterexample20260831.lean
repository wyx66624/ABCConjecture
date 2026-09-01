/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellCampanaCounterexample20260831

/-!
# The adjacent-factor descent for the Pell squarefull route

The mathematical proofs precede this file in
`research/ABC_PELL_ADJACENT_FACTOR_GATE_2026_08_31.md`.

For a positive solution `1 + 8*y^2 = x^2`, oddness of `x` gives

`x = 2*r + 1`, `s = r + 1`, and `r*s = 2*y^2`.

If `y` is squarefull, the primitive adjacent point `(r,1,s)` has

`conductor <= height / 2 + log 2`.

Thus an unbounded family of such data would disprove the unchanged standard
`ABCConjecture`.  The file proves this deterministic implication only.  It
does not assert the existence of an unbounded squarefull Pell family.
-/

namespace IUTThreeClosures
namespace PellAdjacentFactorCounterexample20260831

open KFullRadicalCompression
open PellCampanaCounterexample20260831

noncomputable section

/-! ## Exact half-factorization -/

/-- The two half-factors of a positive Pell solution exist with their exact
product, positivity, coprimality, and comparison with the Pell root. -/
theorem exists_pell_half_factors {x y : ℕ}
    (hy : 0 < y)
    (heq : 1 + 8 * y ^ 2 = x ^ 2) :
    ∃ r s : ℕ,
      x = 2 * r + 1 ∧ s = r + 1 ∧ r * s = 2 * y ^ 2 ∧
        0 < r ∧ 0 < s ∧ Nat.Coprime r s ∧ y < s := by
  have hxNotEven : ¬ Even x := by
    rintro ⟨k, hk⟩
    rw [hk] at heq
    ring_nf at heq
    omega
  obtain ⟨r, hr⟩ := (Nat.not_even_iff_odd.mp hxNotEven)
  have hproduct : r * (r + 1) = 2 * y ^ 2 := by
    rw [hr] at heq
    nlinarith
  have hrpos : 0 < r := by
    rw [hr] at heq
    nlinarith
  have hyx : 2 * y < x := by
    nlinarith
  have hys : y < r + 1 := by
    rw [hr] at hyx
    omega
  refine ⟨r, r + 1, hr, rfl, hproduct, hrpos, by omega, ?_, hys⟩
  exact (Nat.coprime_self_add_right (m := r) (n := 1)).2
    (Nat.coprime_one_right r)

/-- The lower half-factor in the odd representation is unique. -/
theorem pell_half_factor_unique {x r r' : ℕ}
    (hr : x = 2 * r + 1) (hr' : x = 2 * r' + 1) : r = r' := by
  omega

/-! ## Squarefull adjacent data and its actual abc point -/

/-- A squarefull Pell solution together with its two proved half-factors. -/
structure Datum where
  x : ℕ
  y : ℕ
  r : ℕ
  s : ℕ
  x_pos : 0 < x
  y_pos : 0 < y
  r_pos : 0 < r
  s_pos : 0 < s
  pell : 1 + 8 * y ^ 2 = x ^ 2
  x_split : x = 2 * r + 1
  adjacent : s = r + 1
  product : r * s = 2 * y ^ 2
  coprime : Nat.Coprime r s
  y_lt_s : y < s
  y_twoFull : IsKFull 2 y

/-- Every old squarefull Pell datum has adjacent half-factor data; no new
arithmetic existence premise is inserted. -/
theorem exists_datum_of_pellDatum
    (D : PellCampanaCounterexample20260831.Datum) :
    ∃ A : Datum, A.x = D.x ∧ A.y = D.y := by
  obtain ⟨r, s, hxsplit, hs, hprod, hrpos, hspos, hcop, hys⟩ :=
    exists_pell_half_factors D.y_pos D.equation
  refine ⟨{
    x := D.x
    y := D.y
    r := r
    s := s
    x_pos := D.x_pos
    y_pos := D.y_pos
    r_pos := hrpos
    s_pos := hspos
    pell := D.equation
    x_split := hxsplit
    adjacent := hs
    product := hprod
    coprime := hcop
    y_lt_s := hys
    y_twoFull := D.y_twoFull
  }, rfl, rfl⟩

namespace Datum

/-- The adjacent primitive point `(r,1,s)`. -/
def point (D : Datum) : ABCPoint where
  a := D.r
  b := 1
  c := D.s
  a_pos := D.r_pos
  b_pos := by norm_num
  c_pos := D.s_pos
  sum_eq := D.adjacent.symm
  pairwise_coprime := by
    simp only [PairwiseCoprimeABC]
    exact ⟨by simp, by simp, D.coprime.symm⟩

@[simp] theorem point_a (D : Datum) : D.point.a = D.r := rfl
@[simp] theorem point_b (D : Datum) : D.point.b = 1 := rfl
@[simp] theorem point_c (D : Datum) : D.point.c = D.s := rfl

/-- The adjacent point has exactly the upper half-factor as its height
endpoint. -/
theorem point_height (D : Datum) :
    D.point.height = Real.log (D.s : ℝ) := by
  have hrs : D.r ≤ D.s := by
    rw [D.adjacent]
    omega
  have hones : 1 ≤ D.s := D.s_pos
  simp [point, ABCPoint.height, max_eq_right hones, max_eq_right hrs]

/-- Radical submultiplicativity and squarefullness give the exact natural
number budget needed for the one-half logarithmic slope. -/
theorem point_radical_sq_le_four_mul_c (D : Datum) :
    abcRadical (D.point.a * D.point.b * D.point.c) ^ 2 ≤
      4 * D.point.c := by
  have hradTwo : abcRadical 2 = 2 := by
    simpa using
      (abcRadical_prime_pow (p := 2) (k := 1) Nat.prime_two (by norm_num))
  have hrad :
      abcRadical (D.point.a * D.point.b * D.point.c) ≤
        2 * abcRadical D.y := by
    calc
      abcRadical (D.point.a * D.point.b * D.point.c) =
          abcRadical (2 * D.y ^ 2) := by
            congr 1
            simp only [point_a, point_b, point_c, mul_one]
            exact D.product
      _ ≤ abcRadical 2 * abcRadical (D.y ^ 2) :=
        abcRadical_mul_le_mul 2 (D.y ^ 2)
      _ = 2 * abcRadical D.y := by
        rw [abcRadical_pow (by norm_num : (2 : ℕ) ≠ 0), hradTwo]
  have hpow := Nat.pow_le_pow_left hrad 2
  have hyRad := D.y_twoFull.radical_pow_le
  simp only [point_c]
  calc
    abcRadical (D.point.a * D.point.b * D.point.c) ^ 2 ≤
        (2 * abcRadical D.y) ^ 2 := hpow
    _ = 4 * abcRadical D.y ^ 2 := by ring
    _ ≤ 4 * D.y := Nat.mul_le_mul_left 4 hyRad
    _ ≤ 4 * D.s := Nat.mul_le_mul_left 4 (Nat.le_of_lt D.y_lt_s)

/-- The actual adjacent conductor has slope one half, with only the uniform
additive constant `log 2`. -/
theorem point_conductor_le_half_height_add_log_two (D : Datum) :
    D.point.conductor ≤ (1 / 2 : ℝ) * D.point.height + Real.log 2 := by
  let R : ℕ := abcRadical (D.point.a * D.point.b * D.point.c)
  have hRposNat : 0 < R := abcRadical_pos _
  have hnat : R ^ 2 ≤ 4 * D.s := by
    simpa [R] using D.point_radical_sq_le_four_mul_c
  have hreal : (R : ℝ) ^ 2 ≤ 4 * (D.s : ℝ) := by
    exact_mod_cast hnat
  have hRpos : 0 < (R : ℝ) := by exact_mod_cast hRposNat
  have hspos : 0 < (D.s : ℝ) := by exact_mod_cast D.s_pos
  have hlog := Real.log_le_log (pow_pos hRpos 2) hreal
  rw [Real.log_pow, Real.log_mul (by norm_num : (4 : ℝ) ≠ 0) hspos.ne'] at hlog
  have hlogFour : Real.log (4 : ℝ) = 2 * Real.log 2 := by
    rw [show (4 : ℝ) = 2 ^ 2 by norm_num, Real.log_pow]
    norm_num
  rw [hlogFour] at hlog
  rw [ABCPoint.conductor, point_height]
  change Real.log (R : ℝ) ≤ _
  norm_num at hlog ⊢
  nlinarith

end Datum

/-! ## Conditional disproof and the even fourth-full refinement -/

/-- If a squarefull integer `y` is even and two coprime factors multiply to
`2*y^2`, then the left factor is fourth-full.  This isolates the valuation
transfer used by both adjacent Pell factors. -/
theorem left_factor_isFourFull_of_even_twoFull
    {y r s : ℕ} (hy : IsKFull 2 y) (hyeven : Even y)
    (hrpos : 0 < r) (hproduct : r * s = 2 * y ^ 2)
    (hcoprime : Nat.Coprime r s) :
    IsKFull 4 r := by
  apply (IsKFull.iff_prime_pow_dvd hrpos.ne').2
  intro p hp hpr
  have hpProduct : p ∣ 2 * y ^ 2 := by
    rw [← hproduct]
    exact dvd_mul_of_dvd_left hpr s
  have hpy : p ∣ y := by
    rcases hp.dvd_mul.mp hpProduct with hp2 | hpy2
    · have hpeq : p = 2 :=
        (Nat.dvd_prime Nat.prime_two).mp hp2 |>.resolve_left hp.ne_one
      subst p
      exact hyeven.two_dvd
    · exact hp.dvd_of_dvd_pow hpy2
  have hp2y : p ^ 2 ∣ y :=
    (IsKFull.iff_prime_pow_dvd hy.ne_zero).1 hy p hp hpy
  have hp4y2 : p ^ 4 ∣ y ^ 2 := by
    calc
      p ^ 4 = (p ^ 2) ^ 2 := by ring
      _ ∣ y ^ 2 := pow_dvd_pow_of_dvd hp2y 2
  have hp4Product : p ^ 4 ∣ r * s := by
    rw [hproduct]
    exact dvd_mul_of_dvd_right hp4y2 2
  have hpcoprime : (p ^ 4).Coprime s :=
    (Nat.Coprime.of_dvd_left hpr hcoprime).pow_left 4
  exact hpcoprime.dvd_of_dvd_mul_right hp4Product

namespace Datum

/-- In the even squarefull Pell case, the lower adjacent factor is
fourth-full. -/
theorem r_fourFull_of_even (D : Datum) (hyeven : Even D.y) :
    IsKFull 4 D.r :=
  left_factor_isFourFull_of_even_twoFull D.y_twoFull hyeven D.r_pos
    D.product D.coprime

/-- In the even squarefull Pell case, the upper adjacent factor is also
fourth-full. -/
theorem s_fourFull_of_even (D : Datum) (hyeven : Even D.y) :
    IsKFull 4 D.s := by
  apply left_factor_isFourFull_of_even_twoFull D.y_twoFull hyeven D.s_pos
  · simpa [Nat.mul_comm] using D.product
  · exact D.coprime.symm

end Datum

/-- An unbounded adjacent family obtained from squarefull Pell roots
contradicts the unchanged standard abc conjecture at slope `1/2`. -/
theorem not_abcConjecture_of_unbounded_adjacentPell_family
    (D : ℕ → Datum)
    (hunbounded : ∀ B : ℝ, ∃ n : ℕ, B < (D n).point.height) :
    ¬ ABCConjecture := by
  apply not_abcConjecture_of_subcritical_radical_slope
    (fun n => (D n).point.a) (fun n => (D n).point.b)
    (fun n => (D n).point.c) (1 / 2) (Real.log 2) (1 / 2)
  · norm_num
  · norm_num
  · exact fun n => (D n).point.a_pos
  · exact fun n => (D n).point.b_pos
  · exact fun n => (D n).point.c_pos
  · exact fun n => (D n).point.sum_eq
  · exact fun n => (D n).point.pairwise_coprime
  · exact hunbounded
  · intro n
    simpa [familyABCRadicalLog, familyABCHeightLog,
      ABCPoint.conductor, ABCPoint.height] using
      (D n).point_conductor_le_half_height_add_log_two

#print axioms exists_pell_half_factors
#print axioms exists_datum_of_pellDatum
#print axioms Datum.point_radical_sq_le_four_mul_c
#print axioms Datum.point_conductor_le_half_height_add_log_two
#print axioms left_factor_isFourFull_of_even_twoFull
#print axioms Datum.r_fourFull_of_even
#print axioms Datum.s_fourFull_of_even
#print axioms not_abcConjecture_of_unbounded_adjacentPell_family

end

end PellAdjacentFactorCounterexample20260831
end IUTThreeClosures
