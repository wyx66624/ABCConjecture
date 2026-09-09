/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Compatibility of canonical square and fourth-power decompositions

For every exponent `e`,

`floor(e/2) = 2*floor(e/4) + floor((e mod 4)/2)`.

The final term is a bit. Consequently the canonical square root of an integer
is the product of the square of its canonical fourth root and a squarefree
residual factor.
-/

namespace IUTThreeClosures
namespace SquareFourthRootCompatibility

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- The middle binary digit of an exponent in base two. -/
def middleBit (e : ℕ) : ℕ := (e % 4) / 2

/-- The middle bit is at most one. -/
theorem middleBit_le_one (e : ℕ) : middleBit e ≤ 1 := by
  unfold middleBit
  omega

/-- Exact compatibility of the square-root and fourth-root exponents. -/
theorem div_two_eq_two_mul_div_four_add_middleBit (e : ℕ) :
    e / 2 = 2 * (e / 4) + middleBit e := by
  unfold middleBit
  omega

/-- Exact compatibility of the mod-four and parity residues. -/
theorem mod_four_eq_mod_two_add_two_mul_middleBit (e : ℕ) :
    e % 4 = e % 2 + 2 * middleBit e := by
  unfold middleBit
  omega

/-- Weighted logarithmic size of the squarefree residual inside the canonical
square root after removing the square of the fourth root. -/
def middleBitWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, (middleBit (exponent i) : ℝ) * weight i

/-- Exact weighted square/fourth-root compatibility. -/
theorem quotientWeight_two_eq_two_mul_quotientWeight_four_add_middleBitWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) :
    exponentQuotientWeight 2 s weight exponent =
      2 * exponentQuotientWeight 4 s weight exponent +
        middleBitWeight s weight exponent := by
  classical
  unfold exponentQuotientWeight middleBitWeight
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  have hidNat := div_two_eq_two_mul_div_four_add_middleBit (exponent i)
  have hidReal :
      ((exponent i / 2 : ℕ) : ℝ) =
        2 * ((exponent i / 4 : ℕ) : ℝ) +
          (middleBit (exponent i) : ℝ) := by
    exact_mod_cast hidNat
  rw [hidReal]
  ring

/-- Exact weighted compatibility of the fourth-power-free coefficient with
its squarefree kernel. -/
theorem residueWeight_four_eq_residueWeight_two_add_two_mul_middleBitWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) :
    exponentResidueWeight 4 s weight exponent =
      exponentResidueWeight 2 s weight exponent +
        2 * middleBitWeight s weight exponent := by
  classical
  unfold exponentResidueWeight middleBitWeight
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  have hidNat := mod_four_eq_mod_two_add_two_mul_middleBit (exponent i)
  have hidReal :
      ((exponent i % 4 : ℕ) : ℝ) =
        ((exponent i % 2 : ℕ) : ℝ) +
          2 * (middleBit (exponent i) : ℝ) := by
    exact_mod_cast hidNat
  rw [hidReal]
  ring

/-- The residual bit weight is nonnegative for nonnegative prime weights. -/
theorem middleBitWeight_nonneg
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    0 ≤ middleBitWeight s weight exponent := by
  classical
  unfold middleBitWeight
  apply Finset.sum_nonneg
  intro i hi
  exact mul_nonneg (Nat.cast_nonneg _) (hweight i hi)

/-- The residual bit weight is bounded by the radical weight. -/
theorem middleBitWeight_le_radicalWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    middleBitWeight s weight exponent ≤
      exponentRadicalWeight s weight := by
  classical
  unfold middleBitWeight exponentRadicalWeight
  apply Finset.sum_le_sum
  intro i hi
  have hbit : (middleBit (exponent i) : ℝ) ≤ 1 := by
    exact_mod_cast middleBit_le_one (exponent i)
  exact mul_le_mul_of_nonneg_right hbit (hweight i hi)

/-- The canonical square root contains the square of the fourth root. -/
theorem two_mul_fourthRootWeight_le_squareRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    2 * exponentQuotientWeight 4 s weight exponent ≤
      exponentQuotientWeight 2 s weight exponent := by
  rw [quotientWeight_two_eq_two_mul_quotientWeight_four_add_middleBitWeight]
  have hmiddle := middleBitWeight_nonneg s weight exponent hweight
  linarith

/-- The canonical square-root weight differs from twice the fourth-root weight
by at most one radical layer. -/
theorem squareRootWeight_le_two_mul_fourthRootWeight_add_radicalWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentQuotientWeight 2 s weight exponent ≤
      2 * exponentQuotientWeight 4 s weight exponent +
        exponentRadicalWeight s weight := by
  rw [quotientWeight_two_eq_two_mul_quotientWeight_four_add_middleBitWeight]
  have hmiddle := middleBitWeight_le_radicalWeight
    s weight exponent hweight
  linarith

/-- A height-scale fourth root produces twice that logarithmic scale as a
square divisor inside the moving-Pell root. -/
theorem squareRoot_gain_of_fourthRoot_gain
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {A lambda : ℝ}
    (hlambda : 0 ≤ lambda)
    (hgain : A < lambda * exponentQuotientWeight 4 s weight exponent) :
    2 * A < lambda * exponentQuotientWeight 2 s weight exponent := by
  have hcontain := two_mul_fourthRootWeight_le_squareRootWeight
    s weight exponent hweight
  have hscaled := mul_le_mul_of_nonneg_left hcontain hlambda
  nlinarith

#print axioms div_two_eq_two_mul_div_four_add_middleBit
#print axioms mod_four_eq_mod_two_add_two_mul_middleBit
#print axioms quotientWeight_two_eq_two_mul_quotientWeight_four_add_middleBitWeight
#print axioms residueWeight_four_eq_residueWeight_two_add_two_mul_middleBitWeight
#print axioms middleBitWeight_nonneg
#print axioms middleBitWeight_le_radicalWeight
#print axioms two_mul_fourthRootWeight_le_squareRootWeight
#print axioms squareRootWeight_le_two_mul_fourthRootWeight_add_radicalWeight
#print axioms squareRoot_gain_of_fourthRoot_gain

end
end SquareFourthRootCompatibility
end IUTThreeClosures
