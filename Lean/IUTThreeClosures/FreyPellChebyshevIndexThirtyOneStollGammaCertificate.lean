import IUTThreeClosures.FreyPellChebyshevIndexThirtyOneAlgebraicCore

/-!
# Prime-thirty-one Stoll--Gamma closure: transparent scalar companion

The external certificates establish the global descent input, the dyadic
Stoll recursion, and the local Coleman calculation.  This file checks only
copied polynomial identities and finite scalar consequences.  The resulting
rational-point statement remains an explicit hypothesis: no class-group,
Selmer, Jacobian, Stoll, or Coleman theorem is introduced as a Lean axiom.
-/

namespace IUTThreeClosures

/-- The complete formal-12k shells have depths five, six, and seven. -/
theorem pellChebyshevThirtyOne_stollGammaShellMaxLedger :
    3 + 2 = 5 ∧ 4 + 2 = 6 ∧ 5 + 2 = 7 := by
  norm_num

/-- All frozen identity margins, including the initial divisor, exceed the
strict threshold 2000. -/
theorem pellChebyshevThirtyOne_stollGammaValuationMarginLedger :
    2000 < 12021 ∧ 2000 < 12018 ∧ 2000 < 12015 ∧
      2000 < 9795 ∧ 2000 < 7419 ∧ 2000 < 4017 := by
  norm_num

/-- Modulo 32 on odd units gives exactly the required local-constancy radii. -/
theorem pellChebyshevThirtyOne_stollGammaLocalConstancyLedger :
    3 + 5 = (3 + 2) + 3 ∧
      4 + 5 = (4 + 2) + 3 ∧
      5 + 5 = (5 + 2) + 3 := by
  norm_num

/-- Sixteen representatives in each of three shells give 48 tests. -/
theorem pellChebyshevThirtyOne_stollGammaRepresentativeCountLedger :
    32 / 2 = 16 ∧ 3 * 16 = 48 := by
  norm_num

/-- Stoll's tail inequality closes with equality in the fifth shell. -/
theorem pellChebyshevThirtyOne_stollGammaTailLedger :
    2 * 5 - 3 = 7 ∧ 7 ≤ 2 * 5 - 3 := by
  norm_num

/-- Two rational directions have dimension below the genus-fifteen local
Lie group. -/
theorem pellChebyshevThirtyOne_stollGammaClosureDimensionLedger :
    (2 : ℕ) < 15 := by
  norm_num

/-- With `D0=-2H1`, the negative branch changes the embedded class by the
correction `4H1`. -/
theorem pellChebyshevThirtyOne_negativeBranchCorrectionLedger
    (i h1 : ℤ) :
    -i - 2 * (-2 * h1) = -i + 4 * h1 := by
  ring

/-- The negative-branch correction vanishes in the mod-two Kummer quotient. -/
theorem pellChebyshevThirtyOne_negativeBranchModTwoLedger (h1 : ℤ) :
    (4 * h1) % 2 = 0 := by
  omega

/-- Characteristic zero is the elementary final step in passing from an
annihilated subgroup to its rational saturation. -/
theorem pellChebyshevThirtyOne_saturatedIntegralZeroLedger
    (n : ℕ) (hn : 0 < n) (integral : ℚ)
    (hzero : (n : ℚ) * integral = 0) :
    integral = 0 := by
  have hnq : (n : ℚ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hn)
  exact (mul_eq_zero.mp hzero).resolve_left hnq

/-- Five rational anchors and one non-rational Weierstrass anchor occupy the
six good-reduction residue disks. -/
theorem pellChebyshevThirtyOne_stollGammaColemanDiskLedger :
    5 + 1 = 6 := by
  norm_num

/-- Normalized logarithm columns zero and one have determinant three modulo
five. -/
theorem pellChebyshevThirtyOne_stollGammaColemanUnitMinorLedger :
    ((3 : ℤ) * 3 - 1 * 1) % 5 = 3 := by
  norm_num

/-- The reduced numerator `1+x^13+x^14` is a unit at the finite residue
types, and its leading value at infinity is one. -/
theorem pellChebyshevThirtyOne_stollGammaColemanUnitValuesLedger :
    1 % 5 = 1 ∧
      (1 + 1 + 1) % 5 = 3 ∧
      (1 - 1 + 1) % 5 = 1 ∧
      1 % 5 = 1 := by
  norm_num

/-- The shifted-square polynomial in the coefficient form consumed by the
external rational-point computation. -/
def pellChebyshevThirtyOne_shiftSquarePolynomial (T : ℤ) : ℤ :=
  4 * (1073741824 * T ^ 31 - 8321499136 * T ^ 29 +
    29125246976 * T ^ 27 - 60850962432 * T ^ 25 +
      84515225600 * T ^ 23 - 82239815680 * T ^ 21 +
        57567870976 * T ^ 19 - 29297934336 * T ^ 17 +
          10827497472 * T ^ 15 - 2870927360 * T ^ 13 +
            533172224 * T ^ 11 - 66646528 * T ^ 9 +
              5261568 * T ^ 7 - 236096 * T ^ 5 +
                4960 * T ^ 3 - 31 * T) + 5

/-- Transparent interface to the external p31 target-disk rational-point
certificate.  It is a proposition to be supplied, not a kernel theorem. -/
def PARISageRationalTargetDiskCertificateIndexThirtyOne : Prop :=
  ∀ T y : ℤ,
    (T + 1) % 8 = 0 →
    y ^ 2 = pellChebyshevThirtyOne_shiftSquarePolynomial T →
      T = -1

/-- The p31 equation is exactly the displayed genus-fifteen coefficient
model used by the external certificates. -/
theorem indexThirtyOne_genusFifteen_model (T y : ℤ)
    (h : y ^ 2 = 4 * pellChebyshev 31 T + 5) :
    y ^ 2 = pellChebyshevThirtyOne_shiftSquarePolynomial T := by
  rw [pellChebyshev_thirtyOne] at h
  simpa [pellChebyshevThirtyOne_shiftSquarePolynomial] using h

/-- Conditional on the explicit external certificate, there is no p31
solution with `T>1` in the certified dyadic target disk. -/
theorem no_indexThirtyOne_chebyshev_shiftSquare_in_targetDisk_of_external_certificate
    (hcert : PARISageRationalTargetDiskCertificateIndexThirtyOne)
    (T : ℤ) (hT : 1 < T) (htarget : (T + 1) % 8 = 0) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 31 T + 5 := by
  rintro ⟨y, hy⟩
  have hmodel := indexThirtyOne_genusFifteen_model T y hy
  have hminus := hcert T y htarget hmodel
  omega

/-- The Pell residue `T=23 mod 24` lies in the certified target disk. -/
theorem no_indexThirtyOne_chebyshev_shiftSquare_in_pellResidue_of_external_certificate
    (hcert : PARISageRationalTargetDiskCertificateIndexThirtyOne)
    (T : ℤ) (hT : 1 < T) (hresidue : T % 24 = 23) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 31 T + 5 := by
  apply no_indexThirtyOne_chebyshev_shiftSquare_in_targetDisk_of_external_certificate
      hcert T hT
  omega

#print axioms pellChebyshevThirtyOne_stollGammaShellMaxLedger
#print axioms pellChebyshevThirtyOne_stollGammaValuationMarginLedger
#print axioms pellChebyshevThirtyOne_stollGammaLocalConstancyLedger
#print axioms pellChebyshevThirtyOne_stollGammaRepresentativeCountLedger
#print axioms pellChebyshevThirtyOne_stollGammaTailLedger
#print axioms pellChebyshevThirtyOne_stollGammaClosureDimensionLedger
#print axioms pellChebyshevThirtyOne_negativeBranchCorrectionLedger
#print axioms pellChebyshevThirtyOne_negativeBranchModTwoLedger
#print axioms pellChebyshevThirtyOne_saturatedIntegralZeroLedger
#print axioms pellChebyshevThirtyOne_stollGammaColemanDiskLedger
#print axioms pellChebyshevThirtyOne_stollGammaColemanUnitMinorLedger
#print axioms pellChebyshevThirtyOne_stollGammaColemanUnitValuesLedger
#print axioms indexThirtyOne_genusFifteen_model
#print axioms
  no_indexThirtyOne_chebyshev_shiftSquare_in_targetDisk_of_external_certificate
#print axioms
  no_indexThirtyOne_chebyshev_shiftSquare_in_pellResidue_of_external_certificate

end IUTThreeClosures
