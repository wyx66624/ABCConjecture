import IUTThreeClosures.FreyPellChebyshevIndexSeventeenObstructionAudit
import IUTThreeClosures.FreyPellChebyshevIndexElevenColemanChabautyCertificate
import IUTThreeClosures.FreyPellChebyshevIndexThirteenColemanChabautyCertificate

/-!
# Prime-seventeen dyadic and Coleman certificate boundary

The companion note closes the remaining index-seventeen calculation using
exact external Magma V2.29-9 and SageMath 10.9 transcripts.  This file checks
only the scalar algebra copied from those transcripts:

* the seventeenth Chebyshev polynomial and the original genus-eight model;
* the exact horizontal identity that supplies the eighth dyadic class;
* the dimension and Hensel-precision ledgers;
* the reductions of the selected Coleman differential;
* the rational-point and `T > 1` consequences, conditional on a transparent
  proposition containing the external rational-point certificate.

It does not reimplement number fields, local Kummer maps, Selmer groups,
Magma, p-adic integration, or Coleman--Chabauty.
-/

namespace IUTThreeClosures

/-! ## The seventeenth Chebyshev polynomial -/

private theorem pellChebyshev_ten_indexSeventeen (x : ℤ) :
    pellChebyshev 10 x =
      512 * x ^ 10 - 1280 * x ^ 8 + 1120 * x ^ 6 -
        400 * x ^ 4 + 50 * x ^ 2 - 1 := by
  rw [show 10 = 2 * 5 by norm_num, pellChebyshev_mul]
  rw [show 2 = 0 + 2 by norm_num, pellChebyshev_add_two]
  simp [pellChebyshev_five]
  ring

private theorem pellChebyshev_twelve_indexSeventeen (x : ℤ) :
    pellChebyshev 12 x =
      2048 * x ^ 12 - 6144 * x ^ 10 + 6912 * x ^ 8 -
        3584 * x ^ 6 + 840 * x ^ 4 - 72 * x ^ 2 + 1 := by
  rw [show 12 = 10 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_eleven, pellChebyshev_ten_indexSeventeen]
  ring

private theorem pellChebyshev_fourteen_indexSeventeen (x : ℤ) :
    pellChebyshev 14 x =
      8192 * x ^ 14 - 28672 * x ^ 12 + 39424 * x ^ 10 -
        26880 * x ^ 8 + 9408 * x ^ 6 - 1568 * x ^ 4 +
          98 * x ^ 2 - 1 := by
  rw [show 14 = 12 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_thirteen, pellChebyshev_twelve_indexSeventeen]
  ring

private theorem pellChebyshev_fifteen_indexSeventeen (x : ℤ) :
    pellChebyshev 15 x =
      16384 * x ^ 15 - 61440 * x ^ 13 + 92160 * x ^ 11 -
        70400 * x ^ 9 + 28800 * x ^ 7 - 6048 * x ^ 5 +
          560 * x ^ 3 - 15 * x := by
  rw [show 15 = 13 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_fourteen_indexSeventeen, pellChebyshev_thirteen]
  ring

private theorem pellChebyshev_sixteen_indexSeventeen (x : ℤ) :
    pellChebyshev 16 x =
      32768 * x ^ 16 - 131072 * x ^ 14 + 212992 * x ^ 12 -
        180224 * x ^ 10 + 84480 * x ^ 8 - 21504 * x ^ 6 +
          2688 * x ^ 4 - 128 * x ^ 2 + 1 := by
  rw [show 16 = 14 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_fifteen_indexSeventeen,
      pellChebyshev_fourteen_indexSeventeen]
  ring

/-- The first-kind seventeenth Chebyshev polynomial in the Pell convention. -/
theorem pellChebyshev_seventeen (x : ℤ) :
    pellChebyshev 17 x =
      65536 * x ^ 17 - 278528 * x ^ 15 + 487424 * x ^ 13 -
        452608 * x ^ 11 + 239360 * x ^ 9 - 71808 * x ^ 7 +
          11424 * x ^ 5 - 816 * x ^ 3 + 17 * x := by
  rw [show 17 = 15 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_sixteen_indexSeventeen,
      pellChebyshev_fifteen_indexSeventeen]
  ring

/-! ## Dyadic scalar ledgers -/

/-- The exact horizontal identity whose local quartic factor supplies the
eighth independent Kummer class in the Magma certificate. -/
theorem pellChebyshevSeventeen_horizontal256Identity (x : ℤ) :
    let fm :=
      x ^ 17 - 68 * x ^ 15 + 1904 * x ^ 13 - 28288 * x ^ 11 +
        239360 * x ^ 9 - 1148928 * x ^ 7 + 2924544 * x ^ 5 -
          3342336 * x ^ 3 + 1114112 * x + 327680
    let U1 :=
      x ^ 8 - 2 * x ^ 7 - 28 * x ^ 6 + 48 * x ^ 5 + 240 * x ^ 4 -
        320 * x ^ 3 - 640 * x ^ 2 + 512 * x + 256
    fm - 256 ^ 2 = (x + 4) * U1 ^ 2 := by
  dsimp
  ring

/-- The exact finite-dimensional and Hensel-stability arithmetic copied from
the dyadic transcript.  The non-scalar rank assertions remain external. -/
theorem pellChebyshevSeventeen_dyadicScalarLedger :
    (19 - 3 : ℤ) = 16 ∧
      (8 + 8 - 14 : ℤ) = 2 ∧
      (40 * 17 : ℤ) = 680 ∧
      (680 - 64 : ℤ) = 616 ∧
      (616 : ℤ) > 2 * 17 := by
  norm_num

/-- The selected reduced Coleman numerator is `1 + 2x^6 + x^7`; these are
its values at the three finite reduced x-coordinates and at infinity. -/
theorem pellChebyshevSeventeen_colemanReductionLedger :
    ((1 + 2 * (0 : ℤ) ^ 6 + (0 : ℤ) ^ 7) % 5 = 1) ∧
      ((1 + 2 * (1 : ℤ) ^ 6 + (1 : ℤ) ^ 7) % 5 = 4) ∧
      ((1 + 2 * (4 : ℤ) ^ 6 + (4 : ℤ) ^ 7) % 5 = 2) ∧
      ((1 : ℤ) % 5 = 1) := by
  norm_num

/-! ## Transparent external certificate and scalar consequences -/

/-- Interface to the external Magma/Sage rational-point computation. -/
def MagmaSageRationalTCertificateIndexSeventeen : Prop :=
  ∀ T y : ℚ,
    y ^ 2 =
        262144 * T ^ 17 - 1114112 * T ^ 15 + 1949696 * T ^ 13 -
          1810432 * T ^ 11 + 957440 * T ^ 9 - 287232 * T ^ 7 +
            45696 * T ^ 5 - 3264 * T ^ 3 + 68 * T + 5 →
      T = -1 ∨ T = 1

/-- The complete affine rational-point list follows by elementary algebra
once the external x-coordinate certificate is supplied. -/
theorem indexSeventeen_rational_points_of_external_certificate
    (hcert : MagmaSageRationalTCertificateIndexSeventeen)
    (T y : ℚ)
    (h : y ^ 2 =
      262144 * T ^ 17 - 1114112 * T ^ 15 + 1949696 * T ^ 13 -
        1810432 * T ^ 11 + 957440 * T ^ 9 - 287232 * T ^ 7 +
          45696 * T ^ 5 - 3264 * T ^ 3 + 68 * T + 5) :
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

/-- The prime-seventeen shifted-square equation has the genus-eight
polynomial model used by Sage. -/
theorem indexSeventeen_genusEight_model (T y : ℤ)
    (h : y ^ 2 = 4 * pellChebyshev 17 T + 5) :
    y ^ 2 =
      262144 * T ^ 17 - 1114112 * T ^ 15 + 1949696 * T ^ 13 -
        1810432 * T ^ 11 + 957440 * T ^ 9 - 287232 * T ^ 7 +
          45696 * T ^ 5 - 3264 * T ^ 3 + 68 * T + 5 := by
  rw [pellChebyshev_seventeen] at h
  calc
    y ^ 2 =
        4 * (65536 * T ^ 17 - 278528 * T ^ 15 + 487424 * T ^ 13 -
          452608 * T ^ 11 + 239360 * T ^ 9 - 71808 * T ^ 7 +
            11424 * T ^ 5 - 816 * T ^ 3 + 17 * T) + 5 := h
    _ = 262144 * T ^ 17 - 1114112 * T ^ 15 + 1949696 * T ^ 13 -
        1810432 * T ^ 11 + 957440 * T ^ 9 - 287232 * T ^ 7 +
          45696 * T ^ 5 - 3264 * T ^ 3 + 68 * T + 5 := by
      ring

/-- Conditional only on the transparent external certificate, every
integral solution has base `T = -1` or `T = 1`. -/
theorem indexSeventeen_base_eq_neg_one_or_one_of_external_certificate
    (hcert : MagmaSageRationalTCertificateIndexSeventeen)
    (T y : ℤ)
    (h : y ^ 2 =
      262144 * T ^ 17 - 1114112 * T ^ 15 + 1949696 * T ^ 13 -
        1810432 * T ^ 11 + 957440 * T ^ 9 - 287232 * T ^ 7 +
          45696 * T ^ 5 - 3264 * T ^ 3 + 68 * T + 5) :
    T = -1 ∨ T = 1 := by
  have hq : (y : ℚ) ^ 2 =
      262144 * (T : ℚ) ^ 17 - 1114112 * (T : ℚ) ^ 15 +
        1949696 * (T : ℚ) ^ 13 - 1810432 * (T : ℚ) ^ 11 +
          957440 * (T : ℚ) ^ 9 - 287232 * (T : ℚ) ^ 7 +
            45696 * (T : ℚ) ^ 5 - 3264 * (T : ℚ) ^ 3 +
              68 * (T : ℚ) + 5 := by
    exact_mod_cast h
  rcases hcert (T : ℚ) (y : ℚ) hq with hT | hT
  · left
    exact_mod_cast hT
  · right
    exact_mod_cast hT

/-- Hence the prime-seventeen polynomial equation has no integral solution
at `T > 1`, conditional on the external certificate. -/
theorem no_indexSeventeen_polynomial_of_external_certificate
    (hcert : MagmaSageRationalTCertificateIndexSeventeen)
    (T : ℤ)
    (hT : 1 < T) :
    ¬ ∃ y : ℤ,
      y ^ 2 =
        262144 * T ^ 17 - 1114112 * T ^ 15 + 1949696 * T ^ 13 -
          1810432 * T ^ 11 + 957440 * T ^ 9 - 287232 * T ^ 7 +
            45696 * T ^ 5 - 3264 * T ^ 3 + 68 * T + 5 := by
  rintro ⟨y,hy⟩
  rcases indexSeventeen_base_eq_neg_one_or_one_of_external_certificate
      hcert T y hy with h | h <;> omega

/-- The same exclusion in its original Chebyshev form. -/
theorem no_indexSeventeen_chebyshev_shiftSquare_of_external_certificate
    (hcert : MagmaSageRationalTCertificateIndexSeventeen)
    (T : ℤ)
    (hT : 1 < T) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 17 T + 5 := by
  rintro ⟨y,hy⟩
  have hpoly := indexSeventeen_genusEight_model T y hy
  exact no_indexSeventeen_polynomial_of_external_certificate hcert T hT
    ⟨y,hpoly⟩

end IUTThreeClosures

#print axioms IUTThreeClosures.pellChebyshev_seventeen
#print axioms IUTThreeClosures.pellChebyshevSeventeen_horizontal256Identity
#print axioms IUTThreeClosures.pellChebyshevSeventeen_dyadicScalarLedger
#print axioms IUTThreeClosures.pellChebyshevSeventeen_colemanReductionLedger
#print axioms IUTThreeClosures.indexSeventeen_rational_points_of_external_certificate
#print axioms IUTThreeClosures.indexSeventeen_genusEight_model
#print axioms IUTThreeClosures.no_indexSeventeen_chebyshev_shiftSquare_of_external_certificate
