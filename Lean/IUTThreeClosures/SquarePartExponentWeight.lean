/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Square-part weight captures multiplicity excess

For a finite prime-exponent profile, the canonical square-root profile uses
`floor(e/2)` at each coordinate.  This file proves the exact deterministic
inequality

`total exponent weight <= radical weight + 2 * square-root weight`.

Equivalently, every unit of logarithmic multiplicity beyond the radical is
accounted for by at most twice the logarithmic size of the extracted square
root.  This is the finite-profile core needed to convert endpoint
multiplicity localization into large square divisors.

No statement about abc, prime distribution, or Diophantine gaps is assumed.
-/

namespace IUTThreeClosures
namespace SquarePartExponentWeight

open scoped BigOperators

noncomputable section

variable {ι : Type*}

/-- Logarithmic weight of the canonical square root of a finite exponent
profile. -/
def squareRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  exponentQuotientWeight 2 s weight exponent

/-- The parity residue coefficient has at most radical weight. -/
theorem parityResidueWeight_le_radicalWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentResidueWeight 2 s weight exponent ≤
      exponentRadicalWeight s weight := by
  have h := exponentResidueWeight_le_radical_budget
    (n := 2) (by norm_num) s weight exponent hweight
  norm_num at h ⊢
  exact h

/-- Total exponent weight is bounded by radical weight plus twice the
canonical square-root weight. -/
theorem totalWeight_le_radical_add_two_mul_squareRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent ≤
      exponentRadicalWeight s weight +
        2 * squareRootWeight s weight exponent := by
  have hdecomp :=
    exponentTotalWeight_eq_residue_add_n_mul_quotient
      2 s weight exponent
  have hres :=
    parityResidueWeight_le_radicalWeight s weight exponent hweight
  unfold squareRootWeight
  rw [hdecomp]
  nlinarith

/-- Multiplicity excess is bounded by twice the square-root weight. -/
theorem multiplicityExcessWeight_le_two_mul_squareRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentTotalWeight s weight exponent -
        exponentRadicalWeight s weight ≤
      2 * squareRootWeight s weight exponent := by
  have h :=
    totalWeight_le_radical_add_two_mul_squareRootWeight
      s weight exponent hweight
  linarith

/-- A positive lower bound for multiplicity excess forces half as much
square-root weight. -/
theorem half_excess_le_squareRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    (exponentTotalWeight s weight exponent -
        exponentRadicalWeight s weight) / 2 ≤
      squareRootWeight s weight exponent := by
  have h :=
    multiplicityExcessWeight_le_two_mul_squareRootWeight
      s weight exponent hweight
  linarith

/-- If the multiplicity excess has a positive height slope, so does the
canonical square root. -/
theorem squareRootWeight_large_of_excess_large
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {delta H K : ℝ}
    (hexcess :
      delta * H + K <
        exponentTotalWeight s weight exponent -
          exponentRadicalWeight s weight) :
    (delta * H + K) / 2 <
      squareRootWeight s weight exponent := by
  have hhalf :=
    half_excess_le_squareRootWeight s weight exponent hweight
  nlinarith

#print axioms parityResidueWeight_le_radicalWeight
#print axioms totalWeight_le_radical_add_two_mul_squareRootWeight
#print axioms multiplicityExcessWeight_le_two_mul_squareRootWeight
#print axioms half_excess_le_squareRootWeight
#print axioms squareRootWeight_large_of_excess_large

end
end SquarePartExponentWeight
end IUTThreeClosures
