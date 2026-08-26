import IUTThreeClosures.FreyPellChebyshevIndexFiveEllipticChabautyCertificate

/-!
# Prime-seven Chebyshev certificate boundary

This file checks the scalar algebra used in
`FREY_PELL_CHEBYSHEV_INDEX_SEVEN_COLEMAN_CHABAUTY_CERTIFICATE.md`.

The complete rational-point computation on the genus-three curve is external:
Magma V2.29-9 supplies the Jacobian rank upper bound, and SageMath 10.9
supplies the Coleman logarithms used in a residue-disc proof.  The result
enters Lean only through the explicit proposition
`MagmaSageRationalXCertificateIndexSeven`.  Every theorem using that
computation takes this proposition as a hypothesis.
-/

namespace IUTThreeClosures

/-! ## Seventh Chebyshev polynomial -/

/-- The first-kind seventh Chebyshev polynomial in the convention used by the
Pell-unit argument. -/
theorem pellChebyshev_seven (x : ℤ) :
    pellChebyshev 7 x =
      64 * x ^ 7 - 112 * x ^ 5 + 56 * x ^ 3 - 7 * x := by
  rw [show 7 = 5 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [show 6 = 4 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [show 5 = 3 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [show 4 = 2 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [show 3 = 1 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [show 2 = 0 + 2 by norm_num, pellChebyshev_add_two]
  simp
  ring

/-! ## External rational-point certificate -/

/-- Transparent interface to the external Magma/Sage computation.

The accompanying note proves the stronger complete affine rational-point
list.  For downstream scalar algebra it is enough to expose the statement
that the only rational `X`-coordinates are `-1` and `1`. -/
def MagmaSageRationalXCertificateIndexSeven : Prop :=
  ∀ X Y : ℚ,
    Y ^ 2 = 256 * X ^ 7 - 448 * X ^ 5 + 224 * X ^ 3 - 28 * X + 5 →
      X = -1 ∨ X = 1

/-- The full affine rational-point list follows by elementary algebra once
the external `X`-coordinate certificate is supplied. -/
theorem indexSeven_rational_points_of_external_certificate
    (hcert : MagmaSageRationalXCertificateIndexSeven)
    (T y : ℚ)
    (h : y ^ 2 = 256 * T ^ 7 - 448 * T ^ 5 + 224 * T ^ 3 - 28 * T + 5) :
    (T = -1 ∧ (y = 1 ∨ y = -1)) ∨
      (T = 1 ∧ (y = 3 ∨ y = -3)) := by
  rcases hcert T y h with hT | hT
  · left
    refine ⟨hT, ?_⟩
    subst T
    norm_num at h
    have hy : y ^ 2 = (1 : ℚ) ^ 2 := by
      norm_num
      exact h
    exact sq_eq_sq_iff_eq_or_eq_neg.mp hy
  · right
    refine ⟨hT, ?_⟩
    subst T
    norm_num at h
    have hy : y ^ 2 = (3 : ℚ) ^ 2 := by
      norm_num
      exact h
    exact sq_eq_sq_iff_eq_or_eq_neg.mp hy

/-! ## Kernel-checked scalar model and integral consequence -/

/-- The prime-seven shifted-square equation has the genus-three polynomial
model used by Magma and Sage. -/
theorem indexSeven_genusThree_model (T y : ℤ)
    (h : y ^ 2 = 4 * pellChebyshev 7 T + 5) :
    y ^ 2 =
      256 * T ^ 7 - 448 * T ^ 5 + 224 * T ^ 3 - 28 * T + 5 := by
  rw [pellChebyshev_seven] at h
  calc
    y ^ 2 =
        4 * (64 * T ^ 7 - 112 * T ^ 5 + 56 * T ^ 3 - 7 * T) + 5 := h
    _ = 256 * T ^ 7 - 448 * T ^ 5 + 224 * T ^ 3 - 28 * T + 5 := by
      ring

/-- Conditional only on the transparent external certificate, every integral
solution has base `T = -1` or `T = 1`. -/
theorem indexSeven_base_eq_neg_one_or_one_of_external_certificate
    (hcert : MagmaSageRationalXCertificateIndexSeven)
    (T y : ℤ)
    (h : y ^ 2 =
      256 * T ^ 7 - 448 * T ^ 5 + 224 * T ^ 3 - 28 * T + 5) :
    T = -1 ∨ T = 1 := by
  have hq : (y : ℚ) ^ 2 =
      256 * (T : ℚ) ^ 7 - 448 * (T : ℚ) ^ 5 +
        224 * (T : ℚ) ^ 3 - 28 * (T : ℚ) + 5 := by
    exact_mod_cast h
  rcases hcert (T : ℚ) (y : ℚ) hq with hT | hT
  · left
    exact_mod_cast hT
  · right
    exact_mod_cast hT

/-- Hence the prime-seven polynomial equation has no integral solution at
`T > 1`, conditional on the same external certificate. -/
theorem no_indexSeven_polynomial_of_external_certificate
    (hcert : MagmaSageRationalXCertificateIndexSeven)
    (T : ℤ)
    (hT : 1 < T) :
    ¬ ∃ y : ℤ,
      y ^ 2 =
        256 * T ^ 7 - 448 * T ^ 5 + 224 * T ^ 3 - 28 * T + 5 := by
  rintro ⟨y, hy⟩
  rcases indexSeven_base_eq_neg_one_or_one_of_external_certificate
      hcert T y hy with h | h <;> omega

/-- The same exclusion in its Chebyshev form. -/
theorem no_indexSeven_chebyshev_shiftSquare_of_external_certificate
    (hcert : MagmaSageRationalXCertificateIndexSeven)
    (T : ℤ)
    (hT : 1 < T) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 7 T + 5 := by
  rintro ⟨y, hy⟩
  have hpoly := indexSeven_genusThree_model T y hy
  exact no_indexSeven_polynomial_of_external_certificate hcert T hT
    ⟨y, hpoly⟩

end IUTThreeClosures

#print axioms IUTThreeClosures.pellChebyshev_seven
#print axioms IUTThreeClosures.indexSeven_rational_points_of_external_certificate
#print axioms IUTThreeClosures.indexSeven_genusThree_model
#print axioms IUTThreeClosures.indexSeven_base_eq_neg_one_or_one_of_external_certificate
#print axioms IUTThreeClosures.no_indexSeven_polynomial_of_external_certificate
#print axioms IUTThreeClosures.no_indexSeven_chebyshev_shiftSquare_of_external_certificate
