import IUTThreeClosures.FreyPellChebyshevIndexThreeAudit

/-!
# Prime-five Chebyshev certificate boundary

This file checks the exact integer algebra used in
`FREY_PELL_CHEBYSHEV_INDEX_FIVE_ELLIPTIC_CHABAUTY_CERTIFICATE.md`.

The complete rational-point computation on the genus-two curve is external:
it was performed with Magma V2.29-9 by two-cover descent and elliptic
Chabauty.  It enters Lean only through the explicit proposition
`MagmaIntegralXCertificateIndexFive`.  Every theorem that uses the
computation takes that proposition as a hypothesis, so this file does not
pretend that the Magma computation was proved by the Lean kernel.
-/

namespace IUTThreeClosures

/-! ## External certificate interface -/

/-- A deliberately weakened interface to the external Magma computation.

Magma proves the stronger rational statement that the only affine rational
points on `Y^2 = -2*X^5 + 10*X^3 - 10*X + 5` have `X = -2` or `X = 2`.
Only the integral consequence needed below is exposed to Lean. -/
def MagmaIntegralXCertificateIndexFive : Prop :=
  ∀ X Y : ℤ,
    Y ^ 2 = -2 * X ^ 5 + 10 * X ^ 3 - 10 * X + 5 →
      X = -2 ∨ X = 2

/-! ## Kernel-checked scalar transformation and consequences -/

/-- Under `X = -2*T`, the prime-five affine equation becomes the
genus-two model used by the external computation. -/
theorem indexFive_to_magma_model (T y : ℤ)
    (h : y ^ 2 = 64 * T ^ 5 - 80 * T ^ 3 + 20 * T + 5) :
    y ^ 2 = -2 * (-2 * T) ^ 5 + 10 * (-2 * T) ^ 3 -
      10 * (-2 * T) + 5 := by
  calc
    y ^ 2 = 64 * T ^ 5 - 80 * T ^ 3 + 20 * T + 5 := h
    _ = -2 * (-2 * T) ^ 5 + 10 * (-2 * T) ^ 3 -
        10 * (-2 * T) + 5 := by ring

/-- Conditional only on the transparent external certificate, every integral
solution of the prime-five affine equation has `T = 1` or `T = -1`. -/
theorem indexFive_base_eq_one_or_neg_one_of_external_certificate
    (hcert : MagmaIntegralXCertificateIndexFive)
    (T y : ℤ)
    (h : y ^ 2 = 64 * T ^ 5 - 80 * T ^ 3 + 20 * T + 5) :
    T = 1 ∨ T = -1 := by
  have hcurve := indexFive_to_magma_model T y h
  rcases hcert (-2 * T) y hcurve with hX | hX
  · left
    omega
  · right
    omega

/-- Hence the prime-five affine equation has no integral solution at
`T > 1`, conditional on the same external certificate. -/
theorem no_indexFive_polynomial_of_external_certificate
    (hcert : MagmaIntegralXCertificateIndexFive)
    (T : ℤ)
    (hT : 1 < T) :
    ¬ ∃ y : ℤ,
      y ^ 2 = 64 * T ^ 5 - 80 * T ^ 3 + 20 * T + 5 := by
  rintro ⟨y, hy⟩
  rcases indexFive_base_eq_one_or_neg_one_of_external_certificate
      hcert T y hy with h | h <;> omega

/-- The same exclusion in its Chebyshev form. -/
theorem no_indexFive_chebyshev_shiftSquare_of_external_certificate
    (hcert : MagmaIntegralXCertificateIndexFive)
    (T : ℤ)
    (hT : 1 < T) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 5 T + 5 := by
  rintro ⟨y, hy⟩
  have hpoly := indexFive_genusTwo_model T y hy
  exact no_indexFive_polynomial_of_external_certificate hcert T hT
    ⟨y, hpoly⟩

end IUTThreeClosures

#print axioms IUTThreeClosures.indexFive_to_magma_model
#print axioms IUTThreeClosures.indexFive_base_eq_one_or_neg_one_of_external_certificate
#print axioms IUTThreeClosures.no_indexFive_polynomial_of_external_certificate
#print axioms IUTThreeClosures.no_indexFive_chebyshev_shiftSquare_of_external_certificate
