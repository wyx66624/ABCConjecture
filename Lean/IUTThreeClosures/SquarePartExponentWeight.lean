/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Tactic

/-!
# Canonical square-root weight of a prime-exponent profile

For a finite exponent profile, the canonical extracted square root uses
`floor(e/2)` at each coordinate.  The exact residue decomposition at modulus
two and the parity-residue budget prove

`total exponent weight <= radical weight + 2 * square-root weight`.

Equivalently, one half of the multiplicity excess above the radical is always
carried by the canonical square root.  This is an elementary deterministic
statement; no abc estimate or Diophantine theorem is assumed.
-/

namespace IUTThreeClosures
namespace SquarePartExponentWeight

noncomputable section

variable {ι : Type*}

/-- Logarithmic weight of the canonical square root of a finite exponent
profile. -/
def squareRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  exponentQuotientWeight 2 s weight exponent

/-- The parity residue coefficient is bounded by the radical weight. -/
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
  norm_num
  linarith

/-- Multiplicity excess beyond the radical is bounded by twice the canonical
square-root weight. -/
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

/-- One half of the multiplicity excess is carried by the canonical square
root. -/
theorem half_multiplicityExcessWeight_le_squareRootWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    (exponentTotalWeight s weight exponent -
        exponentRadicalWeight s weight) / 2 ≤
      squareRootWeight s weight exponent := by
  have h :=
    multiplicityExcessWeight_le_two_mul_squareRootWeight
      s weight exponent hweight
  linarith

/-- A height-scale lower bound for multiplicity excess gives half as much
height-scale square-root weight. -/
theorem squareRootWeight_large_of_multiplicityExcess_large
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i)
    {A : ℝ}
    (hexcess :
      A < exponentTotalWeight s weight exponent -
        exponentRadicalWeight s weight) :
    A / 2 < squareRootWeight s weight exponent := by
  have hhalf :=
    half_multiplicityExcessWeight_le_squareRootWeight
      s weight exponent hweight
  linarith

#print axioms parityResidueWeight_le_radicalWeight
#print axioms totalWeight_le_radical_add_two_mul_squareRootWeight
#print axioms multiplicityExcessWeight_le_two_mul_squareRootWeight
#print axioms half_multiplicityExcessWeight_le_squareRootWeight
#print axioms squareRootWeight_large_of_multiplicityExcess_large

end
end SquarePartExponentWeight
end IUTThreeClosures
