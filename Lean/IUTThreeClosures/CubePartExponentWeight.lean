/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Canonical cube-root weight of a prime-exponent profile

For a finite exponent profile, the canonical extracted cube root uses
`floor(e/3)` at each coordinate.  The exact residue decomposition at modulus
three and the residue budget prove

`total exponent weight <= 2 * radical weight + 3 * cube-root weight`.

Thus one third of the exponent mass above two radical layers is carried by the
canonical cube root.  This is deterministic and assumes no abc estimate or
Diophantine theorem.
-/

namespace IUTThreeClosures
namespace CubePartExponentWeight

noncomputable section

variable {ι : Type*}

/-- Logarithmic weight of the canonical cube root. -/
def cubeRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  exponentQuotientWeight 3 s weight exponent

/-- The cubic residue coefficient has at most twice the radical weight. -/
theorem cubicResidueWeight_le_two_mul_radicalWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentResidueWeight 3 s weight exponent ≤
      2 * exponentRadicalWeight s weight := by
  have h := exponentResidueWeight_le_radical_budget
    (n := 3) (by norm_num) s weight exponent hweight
  norm_num at h ⊢
  exact h

/-- Total exponent weight is bounded by two radical layers plus three times
the canonical cube-root weight. -/
theorem totalWeight_le_two_mul_radical_add_three_mul_cubeRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent ≤
      2 * exponentRadicalWeight s weight +
        3 * cubeRootWeight s weight exponent := by
  have hdecomp :=
    exponentTotalWeight_eq_residue_add_n_mul_quotient
      3 s weight exponent
  have hres :=
    cubicResidueWeight_le_two_mul_radicalWeight
      s weight exponent hweight
  unfold cubeRootWeight
  rw [hdecomp]
  norm_num
  linarith

/-- Exponent mass above two radical layers is bounded by three times the
canonical cube-root weight. -/
theorem excessAboveTwoRadicalLayers_le_three_mul_cubeRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight ≤
      3 * cubeRootWeight s weight exponent := by
  have h :=
    totalWeight_le_two_mul_radical_add_three_mul_cubeRootWeight
      s weight exponent hweight
  linarith

/-- One third of the excess above two radical layers is carried by the
canonical cube root. -/
theorem one_third_excessAboveTwoRadicalLayers_le_cubeRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    (exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight) / 3 ≤
      cubeRootWeight s weight exponent := by
  have h :=
    excessAboveTwoRadicalLayers_le_three_mul_cubeRootWeight
      s weight exponent hweight
  linarith

/-- A positive lower bound above two radical layers gives one third as much
cube-root weight. -/
theorem cubeRootWeight_large_of_excessAboveTwoRadicalLayers_large
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {A : ℝ}
    (hexcess :
      A < exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight) :
    A / 3 < cubeRootWeight s weight exponent := by
  have hthird :=
    one_third_excessAboveTwoRadicalLayers_le_cubeRootWeight
      s weight exponent hweight
  linarith

#print axioms cubicResidueWeight_le_two_mul_radicalWeight
#print axioms totalWeight_le_two_mul_radical_add_three_mul_cubeRootWeight
#print axioms excessAboveTwoRadicalLayers_le_three_mul_cubeRootWeight
#print axioms one_third_excessAboveTwoRadicalLayers_le_cubeRootWeight
#print axioms cubeRootWeight_large_of_excessAboveTwoRadicalLayers_large

end
end CubePartExponentWeight
end IUTThreeClosures
