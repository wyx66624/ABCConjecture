/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Combining residual supports for coprime exponent moduli

The recent endpoint reductions show that merely extracting large coprime power
moduli on adjacent endpoints cannot close abc: the residual coefficients must
also be controlled.  This file gives an exact deterministic mechanism for
combining such control.

For an exponent modulus `n`, let `E_n` be the radical weight of coordinates
whose exponent is not divisible by `n`.  These are precisely the coordinates
that survive in the canonical `n`-th-power residue coefficient.  We prove:

* the logarithmic residue coefficient is at most `(n-1) E_n`;
* for coprime `m,n`, `E_{mn} <= E_m + E_n`;
* consequently the canonical `(mn)`-th-power residue coefficient is bounded
  by `(mn-1)(E_m+E_n)`;
* the complementary exponent mass forces a quantitative canonical
  `(mn)`-th-power root.

At `(m,n)=(2,3)`, simultaneous control of the parity and cubic residual
supports therefore produces a sixth-power decomposition whose coefficient
weight is at most five times the sum of the two residual radical weights.
Conversely, unless the sixth-power root is large, at least one of those two
residual radical weights must itself be quantitatively large.

No abc estimate, generalized-Fermat theorem, or height bound is assumed.
-/

namespace IUTThreeClosures
namespace CoprimeModuliResidualProductCore

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- Radical weight of the support surviving exponent divisibility by `n`. -/
def residualRadicalWeight
    (n : ℕ) (s : Finset ι) (weight : ι → ℝ)
    (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ exponentResidualSupport n s exponent, weight i

/-- The canonical residue coefficient uses only the residual support, so its
weight is bounded by `(n-1)` times that residual radical weight. -/
theorem residueWeight_le_modulusMinusOne_mul_residualRadicalWeight
    {n : ℕ} (hn : 0 < n)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentResidueWeight n s weight exponent ≤
      ((n - 1 : ℕ) : ℝ) *
        residualRadicalWeight n s weight exponent := by
  classical
  unfold exponentResidueWeight residualRadicalWeight
    exponentResidualSupport
  simp only [Finset.sum_filter]
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  by_cases hdiv : n ∣ exponent i
  · have hmod : exponent i % n = 0 := Nat.mod_eq_zero_of_dvd hdiv
    simp [hdiv, hmod]
  · have hmodNat : exponent i % n ≤ n - 1 := by
      have hlt := Nat.mod_lt (exponent i) hn
      omega
    have hmodReal :
        ((exponent i % n : ℕ) : ℝ) ≤ ((n - 1 : ℕ) : ℝ) := by
      exact_mod_cast hmodNat
    simp [hdiv]
    exact mul_le_mul_of_nonneg_right hmodReal (hweight i hi)

/-- For coprime moduli, every coordinate surviving the product modulus
survives at least one factor modulus. -/
theorem productResidualRadicalWeight_le_add
    {m n : ℕ} (hcoprime : Nat.Coprime m n)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    residualRadicalWeight (m * n) s weight exponent ≤
      residualRadicalWeight m s weight exponent +
        residualRadicalWeight n s weight exponent := by
  classical
  unfold residualRadicalWeight exponentResidualSupport
  simp only [Finset.sum_filter]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_le_sum
  intro i hi
  by_cases hm : m ∣ exponent i
  · by_cases hn : n ∣ exponent i
    · have hmn : m * n ∣ exponent i := hcoprime.mul_dvd hm hn
      simp [hm, hn, hmn]
    · have hmn : ¬ m * n ∣ exponent i := by
        intro hprod
        apply hn
        exact (show n ∣ m * n by exact dvd_mul_left n m).trans hprod
      simp [hm, hn, hmn]
  · have hmn : ¬ m * n ∣ exponent i := by
      intro hprod
      apply hm
      exact (show m ∣ m * n by exact dvd_mul_right m n).trans hprod
    by_cases hn : n ∣ exponent i
    · simp [hm, hn, hmn]
    · simp [hm, hn, hmn]
      nlinarith [hweight i hi]

/-- Two coprime residual-support bounds combine into a coefficient bound at
the product modulus. -/
theorem productModulusResidueWeight_le
    {m n : ℕ} (hm : 0 < m) (hn : 0 < n)
    (hcoprime : Nat.Coprime m n)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentResidueWeight (m * n) s weight exponent ≤
      (((m * n) - 1 : ℕ) : ℝ) *
        (residualRadicalWeight m s weight exponent +
          residualRadicalWeight n s weight exponent) := by
  have hresidue :=
    residueWeight_le_modulusMinusOne_mul_residualRadicalWeight
      (n := m * n) (Nat.mul_pos hm hn) s weight exponent hweight
  have hsupport :=
    productResidualRadicalWeight_le_add hcoprime
      s weight exponent hweight
  have hcoeff : 0 ≤ (((m * n) - 1 : ℕ) : ℝ) := by positivity
  exact hresidue.trans
    (mul_le_mul_of_nonneg_left hsupport hcoeff)

/-- The exact exponent decomposition converts the coefficient bound into a
quantitative lower bound for the canonical `(m*n)`-th-power root. -/
theorem productPowerRootWeight_lower_bound
    {m n : ℕ} (hm : 0 < m) (hn : 0 < n)
    (hcoprime : Nat.Coprime m n)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    (exponentTotalWeight s weight exponent -
        (((m * n) - 1 : ℕ) : ℝ) *
          (residualRadicalWeight m s weight exponent +
            residualRadicalWeight n s weight exponent)) /
        ((m * n : ℕ) : ℝ) ≤
      exponentQuotientWeight (m * n) s weight exponent := by
  have hcoefficient :=
    productModulusResidueWeight_le hm hn hcoprime
      s weight exponent hweight
  have hdecomp :=
    exponentTotalWeight_eq_residue_add_n_mul_quotient
      (m * n) s weight exponent
  have hden : 0 < ((m * n : ℕ) : ℝ) := by
    exact_mod_cast Nat.mul_pos hm hn
  apply (div_le_iff₀ hden).2
  rw [hdecomp]
  nlinarith

/-- Square--cube specialization: the sixth-power residue coefficient is
controlled by the parity and cubic residual radical weights. -/
theorem sixthPowerResidueWeight_le_five_mul_squareCubeResidualSum
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentResidueWeight 6 s weight exponent ≤
      5 * (residualRadicalWeight 2 s weight exponent +
        residualRadicalWeight 3 s weight exponent) := by
  have h :=
    productModulusResidueWeight_le
      (m := 2) (n := 3) (by norm_num) (by norm_num)
      (by norm_num) s weight exponent hweight
  norm_num at h ⊢
  exact h

/-- Square--cube specialization of the common-power-root lower bound. -/
theorem sixthPowerRootWeight_lower_bound
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    (exponentTotalWeight s weight exponent -
        5 * (residualRadicalWeight 2 s weight exponent +
          residualRadicalWeight 3 s weight exponent)) / 6 ≤
      exponentQuotientWeight 6 s weight exponent := by
  have h :=
    productPowerRootWeight_lower_bound
      (m := 2) (n := 3) (by norm_num) (by norm_num)
      (by norm_num) s weight exponent hweight
  norm_num at h ⊢
  exact h

/-- Quantitative square--cube trichotomy: either one residual coefficient has
large radical support, or the canonical sixth-power root is large. -/
theorem squareResidualLarge_or_cubeResidualLarge_or_sixthRootLarge
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    (A B : ℝ) :
    A < residualRadicalWeight 2 s weight exponent ∨
      B < residualRadicalWeight 3 s weight exponent ∨
        (exponentTotalWeight s weight exponent - 5 * (A + B)) / 6 ≤
          exponentQuotientWeight 6 s weight exponent := by
  by_cases htwo : A < residualRadicalWeight 2 s weight exponent
  · exact Or.inl htwo
  · right
    by_cases hthree : B < residualRadicalWeight 3 s weight exponent
    · exact Or.inl hthree
    · right
      have htwoLe := le_of_not_gt htwo
      have hthreeLe := le_of_not_gt hthree
      have hroot := sixthPowerRootWeight_lower_bound
        s weight exponent hweight
      nlinarith

/-- Contrapositive form: if the sixth-power root is below a proposed scale,
then one of the square or cube residual radical weights must carry at least
half of the resulting deficit. -/
theorem squareResidualLarge_or_cubeResidualLarge_of_sixthRootSmall
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {Q : ℝ}
    (hrootSmall : exponentQuotientWeight 6 s weight exponent < Q) :
    (exponentTotalWeight s weight exponent - 6 * Q) / 10 <
        residualRadicalWeight 2 s weight exponent ∨
      (exponentTotalWeight s weight exponent - 6 * Q) / 10 <
        residualRadicalWeight 3 s weight exponent := by
  have hroot := sixthPowerRootWeight_lower_bound
    s weight exponent hweight
  have hsum :
      (exponentTotalWeight s weight exponent - 6 * Q) / 5 <
        residualRadicalWeight 2 s weight exponent +
          residualRadicalWeight 3 s weight exponent := by
    nlinarith
  by_cases htwo :
      (exponentTotalWeight s weight exponent - 6 * Q) / 10 <
        residualRadicalWeight 2 s weight exponent
  · exact Or.inl htwo
  · right
    have htwoLe := le_of_not_gt htwo
    nlinarith

#print axioms residueWeight_le_modulusMinusOne_mul_residualRadicalWeight
#print axioms productResidualRadicalWeight_le_add
#print axioms productModulusResidueWeight_le
#print axioms productPowerRootWeight_lower_bound
#print axioms sixthPowerResidueWeight_le_five_mul_squareCubeResidualSum
#print axioms sixthPowerRootWeight_lower_bound
#print axioms squareResidualLarge_or_cubeResidualLarge_or_sixthRootLarge
#print axioms squareResidualLarge_or_cubeResidualLarge_of_sixthRootSmall

end
end CoprimeModuliResidualProductCore
end IUTThreeClosures
