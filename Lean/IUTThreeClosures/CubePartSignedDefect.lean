/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# The signed exponent-two defect is captured by a canonical cube root

For a finite nonnegatively weighted exponent profile, let

`Q₃ = sum floor(e_i/3) w_i`.

The exact decomposition modulo three and the residue bound `e_i % 3 <= 2`
give the sharp elementary inequality

`total exponent weight - 2 * radical weight <= 3 * Q₃`.

Consequently any positive signed exponent-two defect forces a canonical cube
root whose logarithmic weight is at least one third of that defect.  This
reduces the positive-defect endpoint branch to a single fixed exponent rather
than a growing family of generalized-Fermat signatures.

No abc estimate, modularity theorem, or gap theorem is assumed.
-/

namespace IUTThreeClosures
namespace CubePartSignedDefect

noncomputable section

variable {ι : Type*}

/-- Logarithmic weight of the canonical cube root of an exponent profile. -/
def cubeRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  exponentQuotientWeight 3 s weight exponent

/-- The signed exponent-two defect is at most three times the canonical cube
root weight. -/
theorem signedTwoSurplus_le_three_mul_cubeRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight ≤
      3 * cubeRootWeight s weight exponent := by
  have hdecomp :=
    exponentTotalWeight_eq_residue_add_n_mul_quotient
      3 s weight exponent
  have hresidue :=
    exponentResidueWeight_le_radical_budget
      (n := 3) (by norm_num) s weight exponent hweight
  unfold cubeRootWeight
  norm_num at hdecomp hresidue
  rw [hdecomp]
  linarith

/-- Any lower bound for the signed defect transfers with the exact factor
one third to the canonical cube root. -/
theorem one_third_signedTwoSurplus_le_cubeRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    (exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight) / 3 ≤
      cubeRootWeight s weight exponent := by
  have h :=
    signedTwoSurplus_le_three_mul_cubeRootWeight
      s weight exponent hweight
  nlinarith

/-- Strict quantitative extraction form. -/
theorem cubeRootWeight_large_of_signedTwoSurplus_large
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {L : ℝ}
    (hlarge :
      L < exponentTotalWeight s weight exponent -
        2 * exponentRadicalWeight s weight) :
    L / 3 < cubeRootWeight s weight exponent := by
  have hthird :=
    one_third_signedTwoSurplus_le_cubeRootWeight
      s weight exponent hweight
  nlinarith

#print axioms signedTwoSurplus_le_three_mul_cubeRootWeight
#print axioms one_third_signedTwoSurplus_le_cubeRootWeight
#print axioms cubeRootWeight_large_of_signedTwoSurplus_large

end
end CubePartSignedDefect
end IUTThreeClosures
