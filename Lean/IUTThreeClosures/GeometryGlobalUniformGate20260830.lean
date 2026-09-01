/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyJReducedData
import IUTThreeClosures.FreyDiscriminantConductor
import Mathlib.Data.Nat.Factorization.Root
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

/-!
# Actual auxiliary Mordell points for every abc triple

The proofs were written first in
`research/GEOMETRY_GLOBAL_UNIFORM_GATE_2026_08_30.md`.

The cube extraction is the actual prime-factorization flooring root, not
a supplied model. The theorems below construct the three Mordell points,
retain the elementary abc height, and check the cubic and order matrices.
Pasten, Landau, Siegel, number-field integral-basis theory, and the global
abc conjecture are not introduced as axioms. Rational coordinate identities
alone are not a construction of an elliptic-curve isogeny or group law.
-/

namespace IUTThreeClosures.GeometryGlobalUniformGate

open scoped BigOperators
open UniqueFactorizationMonoid

/-- Maximal cube divisor, with the cube root taken in the divisibility order. -/
def cubeBase (n : ℕ) : ℕ := Nat.floorRoot 3 n

/-- The actual cube-free coefficient left after maximal cube extraction. -/
def cubeCoefficient (n : ℕ) : ℕ := n / cubeBase n ^ 3

theorem cubeBase_pos {n : ℕ} (hn : 0 < n) : 0 < cubeBase n := by
  exact Nat.pos_of_ne_zero (Nat.floorRoot_ne_zero.mpr ⟨by decide, hn.ne'⟩)

theorem cubeBase_cube_dvd (n : ℕ) : cubeBase n ^ 3 ∣ n :=
  Nat.floorRoot_pow_dvd

theorem cube_decomposition (n : ℕ) :
    cubeCoefficient n * cubeBase n ^ 3 = n :=
  Nat.div_mul_cancel (cubeBase_cube_dvd n)

theorem cubeCoefficient_pos {n : ℕ} (hn : 0 < n) :
    0 < cubeCoefficient n := by
  have h := cube_decomposition n
  by_contra hnot
  have hz : cubeCoefficient n = 0 := by omega
  rw [hz, zero_mul] at h
  omega

theorem cubeBase_dvd (n : ℕ) : cubeBase n ∣ n :=
  (dvd_pow_self (cubeBase n) (by decide : 3 ≠ 0)).trans (cubeBase_cube_dvd n)

theorem cubeCoefficient_dvd (n : ℕ) : cubeCoefficient n ∣ n :=
  ⟨cubeBase n ^ 3, (cube_decomposition n).symm⟩

/-- Every prime exponent of the actual coefficient is the original remainder. -/
theorem cubeCoefficient_factorization (n p : ℕ) :
    (cubeCoefficient n).factorization p = n.factorization p % 3 := by
  unfold cubeCoefficient
  rw [Nat.factorization_div (cubeBase_cube_dvd n), Nat.factorization_pow]
  simp only [cubeBase, Nat.factorization_floorRoot, Finsupp.tsub_apply,
    Finsupp.smul_apply, smul_eq_mul, Finsupp.floorDiv_apply, Nat.floorDiv_eq_div]
  omega

def pairBase (m n : ℕ) : ℕ := cubeBase m * cubeBase n

def pairCoefficient (m n : ℕ) : ℕ := cubeCoefficient m * cubeCoefficient n

theorem pair_decomposition (m n : ℕ) :
    m * n = pairBase m n ^ 3 * pairCoefficient m n := by
  conv_lhs => rw [← cube_decomposition m, ← cube_decomposition n]
  unfold pairBase pairCoefficient
  ring

theorem pairCoefficient_pos {m n : ℕ} (hm : 0 < m) (hn : 0 < n) :
    0 < pairCoefficient m n :=
  mul_pos (cubeCoefficient_pos hm) (cubeCoefficient_pos hn)

/-- The positive abscissa for a selected pair of endpoints. -/
def pairX (m n : ℕ) : ℤ := 4 * (pairBase m n : ℤ) * pairCoefficient m n

def pairYPlus (m n : ℕ) : ℤ :=
  4 * (pairCoefficient m n : ℤ) * ((m : ℤ) + n)

def pairYMinus (m n : ℕ) : ℤ :=
  4 * (pairCoefficient m n : ℤ) * ((m : ℤ) - n)

theorem pairX_cube (m n : ℕ) :
    pairX m n ^ 3 = 64 * (m : ℤ) * n * (pairCoefficient m n : ℤ) ^ 2 := by
  have h : (m : ℤ) * n = (pairBase m n : ℤ) ^ 3 * pairCoefficient m n := by
    exact_mod_cast pair_decomposition m n
  calc
    pairX m n ^ 3 = 64 * ((pairBase m n : ℤ) ^ 3 * pairCoefficient m n) *
        (pairCoefficient m n : ℤ) ^ 2 := by unfold pairX; ring
    _ = _ := by rw [← h]; ring

theorem pairX_pos {m n : ℕ} (hm : 0 < m) (hn : 0 < n) :
    0 < pairX m n := by
  have hb : 0 < pairBase m n := mul_pos (cubeBase_pos hm) (cubeBase_pos hn)
  have hr := pairCoefficient_pos hm hn
  unfold pairX
  positivity

theorem pair_mordell_difference (m n : ℕ) :
    pairYPlus m n ^ 2 = pairX m n ^ 3 +
      16 * (((n : ℤ) - m) * pairCoefficient m n) ^ 2 := by
  rw [pairX_cube]
  unfold pairYPlus
  ring

theorem pair_mordell_sum (m n : ℕ) :
    pairYMinus m n ^ 2 = (-pairX m n) ^ 3 +
      16 * (((m : ℤ) + n) * pairCoefficient m n) ^ 2 := by
  rw [neg_pow, pairX_cube]
  unfold pairYMinus
  ring

/-- The omit-a point is an actual integral Mordell point for every abc triple. -/
theorem mordell_omit_a (P : ABCPoint) :
    pairYPlus P.b P.c ^ 2 = pairX P.b P.c ^ 3 +
      16 * ((P.a : ℤ) * pairCoefficient P.b P.c) ^ 2 := by
  have hs : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  have hd : (P.c : ℤ) - P.b = P.a := by omega
  simpa only [hd] using pair_mordell_difference P.b P.c

/-- The omit-b point has the opposite two endpoints in its cube extraction. -/
theorem mordell_omit_b (P : ABCPoint) :
    pairYPlus P.a P.c ^ 2 = pairX P.a P.c ^ 3 +
      16 * ((P.b : ℤ) * pairCoefficient P.a P.c) ^ 2 := by
  have hs : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  have hd : (P.c : ℤ) - P.a = P.b := by omega
  simpa only [hd] using pair_mordell_difference P.a P.c

/-- The omit-c point genuinely has a negative abscissa. -/
theorem mordell_omit_c (P : ABCPoint) :
    pairYMinus P.a P.b ^ 2 = (-pairX P.a P.b) ^ 3 +
      16 * ((P.c : ℤ) * pairCoefficient P.a P.b) ^ 2 := by
  have hs : (P.a : ℤ) + P.b = P.c := by exact_mod_cast P.sum_eq
  simpa only [hs] using pair_mordell_sum P.a P.b

theorem selected_pair_height
    {m n c : ℕ} (hm : 0 < m) (hn : 0 < n) (hc : c ≤ 2 * (m * n)) :
    (32 * c : ℤ) ≤ |pairX m n| ^ 3 := by
  have hr := pairCoefficient_pos hm hn
  have hrZ : (1 : ℤ) ≤ pairCoefficient m n := by exact_mod_cast hr
  have hprod : (0 : ℤ) ≤ (m : ℤ) * n := by positivity
  have hr2 : (1 : ℤ) ≤ (pairCoefficient m n : ℤ) ^ 2 := by nlinarith
  have hcZ : (c : ℤ) ≤ 2 * ((m : ℤ) * n) := by exact_mod_cast hc
  rw [abs_of_pos (pairX_pos hm hn), pairX_cube]
  nlinarith [mul_le_mul_of_nonneg_left hr2 (by positivity :
    (0 : ℤ) ≤ 64 * ((m : ℤ) * n))]

theorem all_three_points_retain_height (P : ABCPoint) :
    (32 * P.c : ℤ) ≤ |pairX P.b P.c| ^ 3 ∧
    (32 * P.c : ℤ) ≤ |pairX P.a P.c| ^ 3 ∧
    (32 * P.c : ℤ) ≤ |-pairX P.a P.b| ^ 3 := by
  have ha : 1 ≤ P.a := P.a_pos
  have hb : 1 ≤ P.b := P.b_pos
  have hca : P.c ≤ P.a * P.c := by simpa using Nat.mul_le_mul_right P.c ha
  have hcb : P.c ≤ P.b * P.c := by simpa using Nat.mul_le_mul_right P.c hb
  have hab : P.a ≤ P.a * P.b := by simpa using Nat.mul_le_mul_left P.a hb
  have hba : P.b ≤ P.a * P.b := by simpa using Nat.mul_le_mul_right P.b ha
  have hs := P.sum_eq
  have hc : P.c ≤ 2 * (P.a * P.b) := by omega
  exact ⟨selected_pair_height P.b_pos P.c_pos (by omega),
    selected_pair_height P.a_pos P.c_pos (by omega),
    by simpa only [abs_neg] using selected_pair_height P.a_pos P.b_pos hc⟩

/-! These identities use genuine finite matrices. Interpreting their
determinants as number-field order indices remains a separate theorem. -/

theorem trace_matrix_determinant (r : ℤ) :
    Matrix.det (!![3, 0, 0; 0, 0, 3 * r; 0, 3 * r, 0] :
      Matrix (Fin 3) (Fin 3) ℤ) = -27 * r ^ 2 := by
  rw [Matrix.det_fin_three]
  norm_num [Matrix.cons_val_two]
  ring

theorem plus_order_matrix_determinant (E F h j : ℤ) :
    Matrix.det (!![1, 0, 8 * h * j * (E * F);
      0, -2 * h, 4 * F * j ^ 2;
      0, -2 * j, 4 * E * h ^ 2] : Matrix (Fin 3) (Fin 3) ℤ) =
      8 * (F * j ^ 3 - E * h ^ 3) := by
  rw [Matrix.det_fin_three]
  norm_num [Matrix.cons_val_two]
  ring

theorem minus_order_matrix_determinant (E F h j : ℤ) :
    Matrix.det (!![1, 0, -8 * h * j * (E * F);
      0, -2 * h, 4 * F * j ^ 2;
      0, 2 * j, 4 * E * h ^ 2] : Matrix (Fin 3) (Fin 3) ℤ) =
      -8 * (E * h ^ 3 + F * j ^ 3) := by
  rw [Matrix.det_fin_three]
  norm_num [Matrix.cons_val_two]
  ring

/-! The prime-cost product is proved for the actual UFM radical. -/

theorem radical_factorization {n p : ℕ} (hn : n ≠ 0) (hp : p.Prime) :
    (radical n).factorization p = if p ∣ n then 1 else 0 := by
  by_cases h : p ∣ n
  · rw [if_pos h]
    exact Nat.factorization_eq_one_of_squarefree
      (squarefree_radical (a := n)) hp
      ((dvd_radical_iff_of_irreducible hp hn).mpr h)
  · rw [if_neg h]
    exact Nat.factorization_eq_zero_of_not_dvd
      (by simpa only [dvd_radical_iff_of_irreducible hp hn] using h)

theorem radical_mul_cube {k n : ℕ} (hk : k ≠ 0) (hn : n ≠ 0) :
    radical (k * n ^ 3) = radical (k * n) := by
  simp only [Nat.radical_eq_prod_primeFactors]
  rw [Nat.primeFactors_mul hk (pow_ne_zero 3 hn),
    Nat.primeFactors_mul hk hn, Nat.primeFactors_pow n (by decide : 3 ≠ 0)]

/-- Pairwise coprimality makes a common radical factor occur exactly three times. -/
theorem three_cost_radical_product
    {k a b c : ℕ} (hk : k ≠ 0) (ha : a ≠ 0) (hb : b ≠ 0) (hc : c ≠ 0)
    (hab : a.Coprime b) (hbc : b.Coprime c) (hca : c.Coprime a) :
    radical (k * a) * radical (k * b) * radical (k * c) =
      radical k ^ 2 * radical (k * (a * b * c)) := by
  have hRa : radical (k * a) ≠ 0 := (Nat.radical_pos _).ne'
  have hRb : radical (k * b) ≠ 0 := (Nat.radical_pos _).ne'
  have hRc : radical (k * c) ≠ 0 := (Nat.radical_pos _).ne'
  have hRk : radical k ≠ 0 := (Nat.radical_pos _).ne'
  have hRall : radical (k * (a * b * c)) ≠ 0 := (Nat.radical_pos _).ne'
  apply Nat.eq_of_factorization_eq (by positivity) (by positivity)
  intro p
  by_cases hp : p.Prime
  · have habp : ¬(p ∣ a ∧ p ∣ b) := by
      intro h
      have hd := Nat.dvd_gcd h.1 h.2
      rw [hab.gcd_eq_one] at hd
      exact hp.ne_one (Nat.dvd_one.mp hd)
    have hbcp : ¬(p ∣ b ∧ p ∣ c) := by
      intro h
      have hd := Nat.dvd_gcd h.1 h.2
      rw [hbc.gcd_eq_one] at hd
      exact hp.ne_one (Nat.dvd_one.mp hd)
    have hcap : ¬(p ∣ c ∧ p ∣ a) := by
      intro h
      have hd := Nat.dvd_gcd h.1 h.2
      rw [hca.gcd_eq_one] at hd
      exact hp.ne_one (Nat.dvd_one.mp hd)
    simp only [Nat.factorization_mul (mul_ne_zero hRa hRb) hRc,
      Nat.factorization_mul hRa hRb,
      Nat.factorization_mul (pow_ne_zero 2 hRk) hRall,
      Nat.factorization_pow, Finsupp.add_apply, Finsupp.smul_apply, smul_eq_mul]
    rw [radical_factorization (mul_ne_zero hk ha) hp,
      radical_factorization (mul_ne_zero hk hb) hp,
      radical_factorization (mul_ne_zero hk hc) hp,
      radical_factorization hk hp,
      radical_factorization (mul_ne_zero hk (mul_ne_zero (mul_ne_zero ha hb) hc)) hp]
    simp only [hp.dvd_mul]
    by_cases hkp : p ∣ k <;> by_cases hap : p ∣ a <;>
      by_cases hbp : p ∣ b <;> by_cases hcp : p ∣ c <;> simp_all
  · simp only [Nat.factorization_eq_zero_of_not_prime _ hp]

def coefficientProduct (P : ABCPoint) : ℕ :=
  cubeCoefficient P.a * cubeCoefficient P.b * cubeCoefficient P.c

def baseProduct (P : ABCPoint) : ℕ := cubeBase P.a * cubeBase P.b * cubeBase P.c

theorem coefficientProduct_pos (P : ABCPoint) : 0 < coefficientProduct P :=
  mul_pos (mul_pos (cubeCoefficient_pos P.a_pos) (cubeCoefficient_pos P.b_pos))
    (cubeCoefficient_pos P.c_pos)

theorem baseProduct_pos (P : ABCPoint) : 0 < baseProduct P :=
  mul_pos (mul_pos (cubeBase_pos P.a_pos) (cubeBase_pos P.b_pos))
    (cubeBase_pos P.c_pos)

theorem abc_cube_decomposition (P : ABCPoint) :
    P.a * P.b * P.c = coefficientProduct P * baseProduct P ^ 3 := by
  calc
    P.a * P.b * P.c =
        (cubeCoefficient P.a * cubeBase P.a ^ 3) *
        (cubeCoefficient P.b * cubeBase P.b ^ 3) *
        (cubeCoefficient P.c * cubeBase P.c ^ 3) := by
      rw [cube_decomposition, cube_decomposition, cube_decomposition]
    _ = _ := by unfold coefficientProduct baseProduct; ring

noncomputable def costA (P : ABCPoint) : ℕ := radical (2 * P.a * pairCoefficient P.b P.c)
noncomputable def costB (P : ABCPoint) : ℕ := radical (2 * P.b * pairCoefficient P.a P.c)
noncomputable def costC (P : ABCPoint) : ℕ := radical (2 * P.c * pairCoefficient P.a P.b)

theorem costA_eq (P : ABCPoint) :
    costA P = radical ((2 * coefficientProduct P) * cubeBase P.a) := by
  have h : 2 * P.a * pairCoefficient P.b P.c =
      (2 * coefficientProduct P) * cubeBase P.a ^ 3 := by
    calc
      2 * P.a * pairCoefficient P.b P.c =
          2 * (cubeCoefficient P.a * cubeBase P.a ^ 3) * pairCoefficient P.b P.c := by
        rw [cube_decomposition]
      _ = _ := by unfold coefficientProduct pairCoefficient; ring
  unfold costA
  rw [h]
  exact radical_mul_cube (mul_ne_zero (by decide : (2 : ℕ) ≠ 0)
    (coefficientProduct_pos P).ne')
    (cubeBase_pos P.a_pos).ne'

theorem costB_eq (P : ABCPoint) :
    costB P = radical ((2 * coefficientProduct P) * cubeBase P.b) := by
  have h : 2 * P.b * pairCoefficient P.a P.c =
      (2 * coefficientProduct P) * cubeBase P.b ^ 3 := by
    calc
      2 * P.b * pairCoefficient P.a P.c =
          2 * (cubeCoefficient P.b * cubeBase P.b ^ 3) * pairCoefficient P.a P.c := by
        rw [cube_decomposition]
      _ = _ := by unfold coefficientProduct pairCoefficient; ring
  unfold costB
  rw [h]
  exact radical_mul_cube (mul_ne_zero (by decide : (2 : ℕ) ≠ 0)
    (coefficientProduct_pos P).ne')
    (cubeBase_pos P.b_pos).ne'

theorem costC_eq (P : ABCPoint) :
    costC P = radical ((2 * coefficientProduct P) * cubeBase P.c) := by
  have h : 2 * P.c * pairCoefficient P.a P.b =
      (2 * coefficientProduct P) * cubeBase P.c ^ 3 := by
    calc
      2 * P.c * pairCoefficient P.a P.b =
          2 * (cubeCoefficient P.c * cubeBase P.c ^ 3) * pairCoefficient P.a P.b := by
        rw [cube_decomposition]
      _ = _ := by unfold coefficientProduct pairCoefficient; ring
  unfold costC
  rw [h]
  exact radical_mul_cube (mul_ne_zero (by decide : (2 : ℕ) ≠ 0)
    (coefficientProduct_pos P).ne')
    (cubeBase_pos P.c_pos).ne'

/-- Exact prime-cost ledger, keeping the forced factor two inside the radical. -/
theorem actual_three_cost_product (P : ABCPoint) :
    costA P * costB P * costC P =
      radical (2 * coefficientProduct P) ^ 2 * radical (2 * (P.a * P.b * P.c)) := by
  rw [costA_eq, costB_eq, costC_eq]
  have hab := Nat.Coprime.of_dvd (cubeBase_dvd P.a) (cubeBase_dvd P.b)
    P.pairwise_coprime.1
  have hbc := Nat.Coprime.of_dvd (cubeBase_dvd P.b) (cubeBase_dvd P.c)
    P.pairwise_coprime.2.1
  have hca := Nat.Coprime.of_dvd (cubeBase_dvd P.c) (cubeBase_dvd P.a)
    P.pairwise_coprime.2.2
  rw [three_cost_radical_product (mul_ne_zero (by decide : (2 : ℕ) ≠ 0)
    (coefficientProduct_pos P).ne')
    (cubeBase_pos P.a_pos).ne' (cubeBase_pos P.b_pos).ne'
    (cubeBase_pos P.c_pos).ne' hab hbc hca]
  congr 1
  rw [abc_cube_decomposition]
  change radical ((2 * coefficientProduct P) * baseProduct P) =
    radical (2 * (coefficientProduct P * baseProduct P ^ 3))
  rw [← mul_assoc]
  exact (radical_mul_cube (mul_ne_zero (by decide : (2 : ℕ) ≠ 0)
    (coefficientProduct_pos P).ne')
    (baseProduct_pos P).ne').symm

/-! Truncation at exponent two is checked, rather than replaced by the radical. -/

noncomputable def truncatedTwo (n : ℕ) : ℕ := n.gcd (radical n ^ 2)

theorem truncatedTwo_factorization {n p : ℕ} (hn : n ≠ 0) (hp : p.Prime) :
    (truncatedTwo n).factorization p = min 2 (n.factorization p) := by
  unfold truncatedTwo
  rw [Nat.factorization_gcd hn (pow_ne_zero 2 (Nat.radical_pos n).ne'),
    Nat.factorization_pow]
  simp only [Finsupp.inf_apply, Finsupp.smul_apply, smul_eq_mul]
  rw [radical_factorization hn hp]
  by_cases hd : p ∣ n
  · simp [hd, min_comm]
  · simp [hd, Nat.factorization_eq_zero_of_not_dvd hd]

theorem radical_mul_square {k n : ℕ} (hk : k ≠ 0) (hn : n ≠ 0) :
    radical (k * n ^ 2) = radical (k * n) := by
  simp only [Nat.radical_eq_prod_primeFactors]
  rw [Nat.primeFactors_mul hk (pow_ne_zero 2 hn),
    Nat.primeFactors_mul hk hn, Nat.primeFactors_pow n (by decide : 2 ≠ 0)]

/-- For these actual Mordell parameters, truncation is exactly a radical square. -/
theorem truncated_mordell_parameter {s : ℕ} (hs : s ≠ 0) :
    truncatedTwo (16 * s ^ 2) = radical (2 * s) ^ 2 := by
  have hk : 16 * s ^ 2 = (4 * s) ^ 2 := by ring
  have hrad : radical (4 * s) = radical (2 * s) := by
    calc
      radical (4 * s) = radical (s * 2 ^ 2) := by congr 1; ring
      _ = radical (s * 2) := radical_mul_square hs (by decide)
      _ = radical (2 * s) := by rw [mul_comm]
  unfold truncatedTwo
  rw [hk, radical_pow _ (by decide : 2 ≠ 0)]
  have hd : radical (4 * s) ^ 2 ∣ (4 * s) ^ 2 :=
    pow_dvd_pow_of_dvd radical_dvd_self 2
  rw [Nat.gcd_eq_right hd, hrad]

/-! Cubic roots and coordinate matrices over any commutative ring. -/

section CubicAlgebra

variable {R : Type*} [CommRing R]

theorem cubic_root_cubes (E F α β : R)
    (hα : α ^ 2 = E * β) (hβ : β ^ 2 = F * α) (hprod : α * β = E * F) :
    α ^ 3 = E ^ 2 * F ∧ β ^ 3 = E * F ^ 2 := by
  constructor
  · calc
      α ^ 3 = E * (α * β) := by linear_combination α * hα
      _ = E ^ 2 * F := by rw [hprod]; ring
  · calc
      β ^ 3 = F * (α * β) := by linear_combination β * hβ
      _ = E * F ^ 2 := by rw [hprod]; ring

theorem cubic_plus_root (E F h j α β : R)
    (hα : α ^ 2 = E * β) (hβ : β ^ 2 = F * α) (hprod : α * β = E * F) :
    (-2 * (h * α + j * β)) ^ 3 -
      12 * h * j * (E * F) * (-2 * (h * α + j * β)) +
      8 * (E * F) * (E * h ^ 3 + F * j ^ 3) = 0 := by
  obtain ⟨hα3, hβ3⟩ := cubic_root_cubes E F α β hα hβ hprod
  linear_combination -8 * h ^ 3 * hα3 - 8 * j ^ 3 * hβ3 -
    24 * h ^ 2 * j * α * hprod - 24 * h * j ^ 2 * β * hprod

theorem cubic_minus_root (E F h j α β : R)
    (hα : α ^ 2 = E * β) (hβ : β ^ 2 = F * α) (hprod : α * β = E * F) :
    (-2 * (h * α - j * β)) ^ 3 +
      12 * h * j * (E * F) * (-2 * (h * α - j * β)) +
      8 * (E * F) * (E * h ^ 3 - F * j ^ 3) = 0 := by
  obtain ⟨hα3, hβ3⟩ := cubic_root_cubes E F α β hα hβ hprod
  linear_combination -8 * h ^ 3 * hα3 + 8 * j ^ 3 * hβ3 +
    24 * h ^ 2 * j * α * hprod - 24 * h * j ^ 2 * β * hprod

theorem cubic_plus_square_coordinates (E F h j α β : R)
    (hα : α ^ 2 = E * β) (hβ : β ^ 2 = F * α) (hprod : α * β = E * F) :
    (-2 * (h * α + j * β)) ^ 2 =
      8 * h * j * (E * F) + 4 * F * j ^ 2 * α + 4 * E * h ^ 2 * β := by
  linear_combination 4 * h ^ 2 * hα + 4 * j ^ 2 * hβ + 8 * h * j * hprod

theorem cubic_minus_square_coordinates (E F h j α β : R)
    (hα : α ^ 2 = E * β) (hβ : β ^ 2 = F * α) (hprod : α * β = E * F) :
    (-2 * (h * α - j * β)) ^ 2 =
      -8 * h * j * (E * F) + 4 * F * j ^ 2 * α + 4 * E * h ^ 2 * β := by
  linear_combination 4 * h ^ 2 * hα + 4 * j ^ 2 * hβ - 8 * h * j * hprod

end CubicAlgebra

theorem scale_mordell (x y N t : ℚ) (ht : t ≠ 0)
    (h : y ^ 2 = x ^ 3 + 16 * (N * t ^ 3) ^ 2) :
    (y / t ^ 3) ^ 2 = (x / t ^ 2) ^ 3 + 16 * N ^ 2 := by
  field_simp
  linear_combination h

theorem parameterA_identity (P : ABCPoint) :
    P.a * pairCoefficient P.b P.c = coefficientProduct P * cubeBase P.a ^ 3 := by
  calc
    P.a * pairCoefficient P.b P.c =
        (cubeCoefficient P.a * cubeBase P.a ^ 3) * pairCoefficient P.b P.c := by
      rw [cube_decomposition]
    _ = _ := by unfold coefficientProduct pairCoefficient; ring

theorem parameterB_identity (P : ABCPoint) :
    P.b * pairCoefficient P.a P.c = coefficientProduct P * cubeBase P.b ^ 3 := by
  calc
    P.b * pairCoefficient P.a P.c =
        (cubeCoefficient P.b * cubeBase P.b ^ 3) * pairCoefficient P.a P.c := by
      rw [cube_decomposition]
    _ = _ := by unfold coefficientProduct pairCoefficient; ring

theorem parameterC_identity (P : ABCPoint) :
    P.c * pairCoefficient P.a P.b = coefficientProduct P * cubeBase P.c ^ 3 := by
  calc
    P.c * pairCoefficient P.a P.b =
        (cubeCoefficient P.c * cubeBase P.c ^ 3) * pairCoefficient P.a P.b := by
      rw [cube_decomposition]
    _ = _ := by unfold coefficientProduct pairCoefficient; ring

/-- The actual omit-a point after rational normalization lies on the common curve. -/
theorem common_curve_omit_a (P : ABCPoint) :
    ((pairYPlus P.b P.c : ℚ) / (cubeBase P.a : ℚ) ^ 3) ^ 2 =
      ((pairX P.b P.c : ℚ) / (cubeBase P.a : ℚ) ^ 2) ^ 3 +
      16 * (coefficientProduct P : ℚ) ^ 2 := by
  have ht : (cubeBase P.a : ℚ) ≠ 0 := by exact_mod_cast (cubeBase_pos P.a_pos).ne'
  apply scale_mordell _ _ _ _ ht
  have h := mordell_omit_a P
  have hn := parameterA_identity P
  have hq : (P.a : ℚ) * pairCoefficient P.b P.c =
      (coefficientProduct P : ℚ) * (cubeBase P.a : ℚ) ^ 3 := by exact_mod_cast hn
  have he : (pairYPlus P.b P.c : ℚ) ^ 2 = (pairX P.b P.c : ℚ) ^ 3 +
      16 * ((P.a : ℚ) * pairCoefficient P.b P.c) ^ 2 := by exact_mod_cast h
  rwa [hq] at he

theorem common_curve_omit_b (P : ABCPoint) :
    ((pairYPlus P.a P.c : ℚ) / (cubeBase P.b : ℚ) ^ 3) ^ 2 =
      ((pairX P.a P.c : ℚ) / (cubeBase P.b : ℚ) ^ 2) ^ 3 +
      16 * (coefficientProduct P : ℚ) ^ 2 := by
  have ht : (cubeBase P.b : ℚ) ≠ 0 := by exact_mod_cast (cubeBase_pos P.b_pos).ne'
  apply scale_mordell _ _ _ _ ht
  have hq : (P.b : ℚ) * pairCoefficient P.a P.c =
      (coefficientProduct P : ℚ) * (cubeBase P.b : ℚ) ^ 3 := by
    exact_mod_cast parameterB_identity P
  have he : (pairYPlus P.a P.c : ℚ) ^ 2 = (pairX P.a P.c : ℚ) ^ 3 +
      16 * ((P.b : ℚ) * pairCoefficient P.a P.c) ^ 2 := by
    exact_mod_cast mordell_omit_b P
  rwa [hq] at he

theorem common_curve_omit_c (P : ABCPoint) :
    ((pairYMinus P.a P.b : ℚ) / (cubeBase P.c : ℚ) ^ 3) ^ 2 =
      (-(pairX P.a P.b : ℚ) / (cubeBase P.c : ℚ) ^ 2) ^ 3 +
      16 * (coefficientProduct P : ℚ) ^ 2 := by
  have ht : (cubeBase P.c : ℚ) ≠ 0 := by exact_mod_cast (cubeBase_pos P.c_pos).ne'
  apply scale_mordell _ _ _ _ ht
  have hq : (P.c : ℚ) * pairCoefficient P.a P.b =
      (coefficientProduct P : ℚ) * (cubeBase P.c : ℚ) ^ 3 := by
    exact_mod_cast parameterC_identity P
  have he : (pairYMinus P.a P.b : ℚ) ^ 2 = (-(pairX P.a P.b : ℚ)) ^ 3 +
      16 * ((P.c : ℚ) * pairCoefficient P.a P.b) ^ 2 := by
    exact_mod_cast mordell_omit_c P
  rwa [hq] at he

/-- Coprime endpoints have multiplicative cube-free coefficients. -/
theorem cubeCoefficient_mul {a b : ℕ} (ha : 0 < a) (hb : 0 < b)
    (hab : a.Coprime b) :
    cubeCoefficient (a * b) = cubeCoefficient a * cubeCoefficient b := by
  have hca := cubeCoefficient_pos ha
  have hcb := cubeCoefficient_pos hb
  have hcab := cubeCoefficient_pos (mul_pos ha hb)
  apply Nat.eq_of_factorization_eq hcab.ne' (mul_ne_zero hca.ne' hcb.ne')
  intro p
  simp only [cubeCoefficient_factorization,
    Nat.factorization_mul ha.ne' hb.ne', Nat.factorization_mul hca.ne' hcb.ne',
    Finsupp.add_apply]
  by_cases hp : p.Prime
  · by_cases hpa : p ∣ a
    · have hpb : ¬p ∣ b := by
        intro h
        have hd := Nat.dvd_gcd hpa h
        rw [hab.gcd_eq_one] at hd
        exact hp.ne_one (Nat.dvd_one.mp hd)
      simp only [Nat.factorization_eq_zero_of_not_dvd hpb, add_zero, Nat.zero_mod]
    · simp only [Nat.factorization_eq_zero_of_not_dvd hpa, zero_add, Nat.zero_mod]
  · simp only [Nat.factorization_eq_zero_of_not_prime _ hp, zero_add, Nat.zero_mod]

theorem coefficientProduct_eq_cubeCoefficient (P : ABCPoint) :
    coefficientProduct P = cubeCoefficient (P.a * P.b * P.c) := by
  have habc : (P.a * P.b).Coprime P.c :=
    Nat.coprime_mul_iff_left.mpr ⟨P.pairwise_coprime.2.2.symm, P.pairwise_coprime.2.1⟩
  rw [cubeCoefficient_mul (mul_pos P.a_pos P.b_pos) P.c_pos habc,
    cubeCoefficient_mul P.a_pos P.b_pos P.pairwise_coprime.1]
  rfl

noncomputable def residualSupport (n : ℕ) : ℕ := radical (cubeCoefficient n)

/-- Exact support of valuations not divisible by three. -/
theorem prime_dvd_residualSupport_iff {n p : ℕ} (hn : 0 < n) (hp : p.Prime) :
    p ∣ residualSupport n ↔ ¬3 ∣ n.factorization p := by
  unfold residualSupport
  rw [dvd_radical_iff_of_irreducible hp (cubeCoefficient_pos hn).ne',
    hp.dvd_iff_one_le_factorization (cubeCoefficient_pos hn).ne',
    cubeCoefficient_factorization, Nat.dvd_iff_mod_eq_zero]
  omega

theorem cubeCoefficient_dvd_residualSupport_sq {n : ℕ} (hn : 0 < n) :
    cubeCoefficient n ∣ residualSupport n ^ 2 := by
  have hcn := cubeCoefficient_pos hn
  have hr : residualSupport n ≠ 0 := (Nat.radical_pos _).ne'
  apply (Nat.factorization_le_iff_dvd hcn.ne' (pow_ne_zero 2 hr)).mp
  intro p
  simp only [Nat.factorization_pow, Finsupp.smul_apply, smul_eq_mul]
  by_cases hp : p.Prime
  · unfold residualSupport
    rw [radical_factorization hcn.ne' hp]
    by_cases hd : p ∣ cubeCoefficient n
    · rw [if_pos hd, cubeCoefficient_factorization]
      have hmod := Nat.mod_lt (n.factorization p) (by decide : 0 < 3)
      omega
    · rw [if_neg hd, Nat.factorization_eq_zero_of_not_dvd hd]
  · simp only [Nat.factorization_eq_zero_of_not_prime _ hp, mul_zero, le_refl]

/-- The common Mordell parameter really ranges over finitely many models
when the residual support is bounded. No Diophantine finiteness is used here. -/
theorem coefficientProduct_le_residualSupport_sq (P : ABCPoint) :
    coefficientProduct P ≤ residualSupport (P.a * P.b * P.c) ^ 2 := by
  rw [coefficientProduct_eq_cubeCoefficient]
  exact Nat.le_of_dvd (pow_pos (Nat.radical_pos _) 2)
    (cubeCoefficient_dvd_residualSupport_sq (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos))

/-- Polynomial identity underlying the auxiliary 3-isogeny. -/
theorem auxiliary_isogeny_polynomial (z k : ℚ) :
    (z + k) * (z - 8 * k) ^ 2 - (z + 4 * k) ^ 3 = -27 * k * z ^ 2 := by
  ring

/-- The rational formula maps Mordell equations to Mordell equations.
This statement does not assert an isogeny of the original Frey curve. -/
theorem auxiliary_isogeny_equation (x y k : ℚ) (hx : x ≠ 0)
    (h : y ^ 2 = x ^ 3 + k) :
    (y * (x ^ 3 - 8 * k) / x ^ 3) ^ 2 =
      ((x ^ 3 + 4 * k) / x ^ 2) ^ 3 - 27 * k := by
  field_simp
  linear_combination (x ^ 3 - 8 * k) ^ 2 * h

#print axioms cubeCoefficient_factorization
#print axioms all_three_points_retain_height
#print axioms actual_three_cost_product
#print axioms truncated_mordell_parameter
#print axioms cubic_plus_root
#print axioms cubic_minus_root
#print axioms plus_order_matrix_determinant
#print axioms common_curve_omit_a
#print axioms common_curve_omit_b
#print axioms common_curve_omit_c
#print axioms coefficientProduct_le_residualSupport_sq
#print axioms auxiliary_isogeny_equation

end IUTThreeClosures.GeometryGlobalUniformGate
