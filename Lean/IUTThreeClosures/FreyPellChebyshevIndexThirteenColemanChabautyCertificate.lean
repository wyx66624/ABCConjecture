import IUTThreeClosures.FreyPellChebyshevIndexSevenColemanChabautyCertificate

/-!
# Prime-thirteen Chebyshev certificate boundary

This file checks the scalar algebra used in
`FREY_PELL_CHEBYSHEV_INDEX_THIRTEEN_COLEMAN_CHABAUTY_CERTIFICATE.md`.

The complete rational-point computation on the genus-six curve is external:
Magma V2.29-9 supplies an exact 2-descent, and SageMath 10.9 supplies the
Coleman logarithms used in the residue-disc proof.  The result enters Lean
only through the explicit proposition
`MagmaSageRationalXCertificateIndexThirteen`.  Every theorem using that
computation takes this proposition as a hypothesis.
-/

namespace IUTThreeClosures

/-! ## Thirteenth Chebyshev polynomial -/

private theorem pellChebyshev_four_indexThirteen (x : ℤ) :
    pellChebyshev 4 x = 8 * x ^ 4 - 8 * x ^ 2 + 1 := by
  rw [show 4 = 2 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_three]
  rw [show 2 = 0 + 2 by norm_num, pellChebyshev_add_two]
  simp
  ring

private theorem pellChebyshev_six_indexThirteen (x : ℤ) :
    pellChebyshev 6 x =
      32 * x ^ 6 - 48 * x ^ 4 + 18 * x ^ 2 - 1 := by
  rw [show 6 = 4 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_five, pellChebyshev_four_indexThirteen]
  ring

private theorem pellChebyshev_eight_indexThirteen (x : ℤ) :
    pellChebyshev 8 x =
      128 * x ^ 8 - 256 * x ^ 6 + 160 * x ^ 4 - 32 * x ^ 2 + 1 := by
  rw [show 8 = 6 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_seven, pellChebyshev_six_indexThirteen]
  ring

private theorem pellChebyshev_nine_indexThirteen (x : ℤ) :
    pellChebyshev 9 x =
      256 * x ^ 9 - 576 * x ^ 7 + 432 * x ^ 5 - 120 * x ^ 3 + 9 * x := by
  rw [show 9 = 7 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_eight_indexThirteen, pellChebyshev_seven]
  ring

private theorem pellChebyshev_ten_indexThirteen (x : ℤ) :
    pellChebyshev 10 x =
      512 * x ^ 10 - 1280 * x ^ 8 + 1120 * x ^ 6 - 400 * x ^ 4 +
        50 * x ^ 2 - 1 := by
  rw [show 10 = 8 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_nine_indexThirteen, pellChebyshev_eight_indexThirteen]
  ring

private theorem pellChebyshev_eleven_indexThirteen (x : ℤ) :
    pellChebyshev 11 x =
      1024 * x ^ 11 - 2816 * x ^ 9 + 2816 * x ^ 7 - 1232 * x ^ 5 +
        220 * x ^ 3 - 11 * x := by
  rw [show 11 = 9 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_ten_indexThirteen, pellChebyshev_nine_indexThirteen]
  ring

private theorem pellChebyshev_twelve_indexThirteen (x : ℤ) :
    pellChebyshev 12 x =
      2048 * x ^ 12 - 6144 * x ^ 10 + 6912 * x ^ 8 - 3584 * x ^ 6 +
        840 * x ^ 4 - 72 * x ^ 2 + 1 := by
  rw [show 12 = 10 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_eleven_indexThirteen, pellChebyshev_ten_indexThirteen]
  ring

/-- The first-kind thirteenth Chebyshev polynomial in the convention used by
the Pell-unit argument. -/
theorem pellChebyshev_thirteen (x : ℤ) :
    pellChebyshev 13 x =
      4096 * x ^ 13 - 13312 * x ^ 11 + 16640 * x ^ 9 -
        9984 * x ^ 7 + 2912 * x ^ 5 - 364 * x ^ 3 + 13 * x := by
  rw [show 13 = 11 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_twelve_indexThirteen, pellChebyshev_eleven_indexThirteen]
  ring

/-! ## External rational-point certificate -/

/-- Transparent interface to the external Magma/Sage computation.

The accompanying note proves the stronger complete affine rational-point
list.  For downstream scalar algebra it is enough to expose the statement
that the only rational `X`-coordinates are `-1` and `1`. -/
def MagmaSageRationalXCertificateIndexThirteen : Prop :=
  ∀ X Y : ℚ,
    Y ^ 2 =
        16384 * X ^ 13 - 53248 * X ^ 11 + 66560 * X ^ 9 -
          39936 * X ^ 7 + 11648 * X ^ 5 - 1456 * X ^ 3 +
            52 * X + 5 →
      X = -1 ∨ X = 1

/-- The full affine rational-point list follows by elementary algebra once
the external `X`-coordinate certificate is supplied. -/
theorem indexThirteen_rational_points_of_external_certificate
    (hcert : MagmaSageRationalXCertificateIndexThirteen)
    (T y : ℚ)
    (h : y ^ 2 =
      16384 * T ^ 13 - 53248 * T ^ 11 + 66560 * T ^ 9 -
        39936 * T ^ 7 + 11648 * T ^ 5 - 1456 * T ^ 3 +
          52 * T + 5) :
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

/-- The prime-thirteen shifted-square equation has the genus-six polynomial
model used by Magma and Sage. -/
theorem indexThirteen_genusSix_model (T y : ℤ)
    (h : y ^ 2 = 4 * pellChebyshev 13 T + 5) :
    y ^ 2 =
      16384 * T ^ 13 - 53248 * T ^ 11 + 66560 * T ^ 9 -
        39936 * T ^ 7 + 11648 * T ^ 5 - 1456 * T ^ 3 +
          52 * T + 5 := by
  rw [pellChebyshev_thirteen] at h
  calc
    y ^ 2 =
        4 * (4096 * T ^ 13 - 13312 * T ^ 11 + 16640 * T ^ 9 -
          9984 * T ^ 7 + 2912 * T ^ 5 - 364 * T ^ 3 + 13 * T) + 5 := h
    _ = 16384 * T ^ 13 - 53248 * T ^ 11 + 66560 * T ^ 9 -
        39936 * T ^ 7 + 11648 * T ^ 5 - 1456 * T ^ 3 +
          52 * T + 5 := by
      ring

/-- Conditional only on the transparent external certificate, every integral
solution has base `T = -1` or `T = 1`. -/
theorem indexThirteen_base_eq_neg_one_or_one_of_external_certificate
    (hcert : MagmaSageRationalXCertificateIndexThirteen)
    (T y : ℤ)
    (h : y ^ 2 =
      16384 * T ^ 13 - 53248 * T ^ 11 + 66560 * T ^ 9 -
        39936 * T ^ 7 + 11648 * T ^ 5 - 1456 * T ^ 3 +
          52 * T + 5) :
    T = -1 ∨ T = 1 := by
  have hq : (y : ℚ) ^ 2 =
      16384 * (T : ℚ) ^ 13 - 53248 * (T : ℚ) ^ 11 +
        66560 * (T : ℚ) ^ 9 - 39936 * (T : ℚ) ^ 7 +
          11648 * (T : ℚ) ^ 5 - 1456 * (T : ℚ) ^ 3 +
            52 * (T : ℚ) + 5 := by
    exact_mod_cast h
  rcases hcert (T : ℚ) (y : ℚ) hq with hT | hT
  · left
    exact_mod_cast hT
  · right
    exact_mod_cast hT

/-- Hence the prime-thirteen polynomial equation has no integral solution at
`T > 1`, conditional on the same external certificate. -/
theorem no_indexThirteen_polynomial_of_external_certificate
    (hcert : MagmaSageRationalXCertificateIndexThirteen)
    (T : ℤ)
    (hT : 1 < T) :
    ¬ ∃ y : ℤ,
      y ^ 2 =
        16384 * T ^ 13 - 53248 * T ^ 11 + 66560 * T ^ 9 -
          39936 * T ^ 7 + 11648 * T ^ 5 - 1456 * T ^ 3 +
            52 * T + 5 := by
  rintro ⟨y, hy⟩
  rcases indexThirteen_base_eq_neg_one_or_one_of_external_certificate
      hcert T y hy with h | h <;> omega

/-- The same exclusion in its Chebyshev form. -/
theorem no_indexThirteen_chebyshev_shiftSquare_of_external_certificate
    (hcert : MagmaSageRationalXCertificateIndexThirteen)
    (T : ℤ)
    (hT : 1 < T) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 13 T + 5 := by
  rintro ⟨y, hy⟩
  have hpoly := indexThirteen_genusSix_model T y hy
  exact no_indexThirteen_polynomial_of_external_certificate hcert T hT
    ⟨y, hpoly⟩

end IUTThreeClosures

#print axioms IUTThreeClosures.pellChebyshev_thirteen
#print axioms IUTThreeClosures.indexThirteen_rational_points_of_external_certificate
#print axioms IUTThreeClosures.indexThirteen_genusSix_model
#print axioms IUTThreeClosures.indexThirteen_base_eq_neg_one_or_one_of_external_certificate
#print axioms IUTThreeClosures.no_indexThirteen_polynomial_of_external_certificate
#print axioms IUTThreeClosures.no_indexThirteen_chebyshev_shiftSquare_of_external_certificate
