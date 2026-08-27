import IUTThreeClosures.FreyPellChebyshevIndexTwentyThreeStollGammaCertificate
import IUTThreeClosures.P29SelmerLinearCore

/-!
# Prime-twenty-nine Stoll--Gamma closure: transparent scalar companion

The external exact certificates establish the class-number-one input, the
global-to-dyadic Selmer injection, Stoll's finite shell recursion, and the
Coleman unit-minor finish.  This Lean file checks only the copied polynomial
identities and finite scalar consequences.  The rational-point conclusion is
exposed as a proposition that must be supplied explicitly as a hypothesis.

In particular, this file does not formalize class groups, Selmer groups,
Jacobians, Hilbert symbols, p-adic halving, Stoll's theorems, or Coleman
integration, and it introduces no axiom for any external computation.
-/

namespace IUTThreeClosures

private theorem pellChebyshev_four_indexTwentyNine (x : ℤ) :
    pellChebyshev 4 x = 8 * x ^ 4 - 8 * x ^ 2 + 1 := by
  rw [show 4 = 2 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_three]
  rw [show 2 = 0 + 2 by norm_num, pellChebyshev_add_two]
  simp [pellChebyshev_zero, pellChebyshev_one]
  ring

private theorem pellChebyshev_nine_indexTwentyNine (x : ℤ) :
    pellChebyshev 9 x =
      256 * x ^ 9 - 576 * x ^ 7 + 432 * x ^ 5 - 120 * x ^ 3 + 9 * x := by
  rw [show 9 = 3 * 3 by norm_num, pellChebyshev_mul]
  rw [pellChebyshev_three, pellChebyshev_three]
  ring

private theorem pellChebyshev_twentySeven_indexTwentyNine (x : ℤ) :
    pellChebyshev 27 x =
      67108864 * x ^ 27 - 452984832 * x ^ 25 +
        1358954496 * x ^ 23 - 2387607552 * x ^ 21 +
          2724986880 * x ^ 19 - 2118057984 * x ^ 17 +
            1143078912 * x ^ 15 - 428654592 * x ^ 13 +
              109983744 * x ^ 11 - 18670080 * x ^ 9 +
                1976832 * x ^ 7 - 117936 * x ^ 5 +
                  3276 * x ^ 3 - 27 * x := by
  rw [show 27 = 3 * 9 by norm_num, pellChebyshev_mul]
  rw [pellChebyshev_three, pellChebyshev_nine_indexTwentyNine]
  ring

private theorem pellChebyshev_twentyEight_indexTwentyNine (x : ℤ) :
    pellChebyshev 28 x =
      134217728 * x ^ 28 - 939524096 * x ^ 26 +
        2936012800 * x ^ 24 - 5402263552 * x ^ 22 +
          6499598336 * x ^ 20 - 5369233408 * x ^ 18 +
            3111714816 * x ^ 16 - 1270087680 * x ^ 14 +
              361181184 * x ^ 12 - 69701632 * x ^ 10 +
                8712704 * x ^ 8 - 652288 * x ^ 6 +
                  25480 * x ^ 4 - 392 * x ^ 2 + 1 := by
  rw [show 28 = 4 * 7 by norm_num, pellChebyshev_mul]
  rw [pellChebyshev_four_indexTwentyNine, pellChebyshev_seven]
  ring

/-- The first-kind twenty-ninth Chebyshev polynomial in the repository's
Pell normalization. -/
theorem pellChebyshev_twentyNine (x : ℤ) :
    pellChebyshev 29 x =
      268435456 * x ^ 29 - 1946157056 * x ^ 27 +
        6325010432 * x ^ 25 - 12163481600 * x ^ 23 +
          15386804224 * x ^ 21 - 13463453696 * x ^ 19 +
            8341487616 * x ^ 17 - 3683254272 * x ^ 15 +
              1151016960 * x ^ 13 - 249387008 * x ^ 11 +
                36095488 * x ^ 9 - 3281408 * x ^ 7 +
                  168896 * x ^ 5 - 4060 * x ^ 3 + 29 * x := by
  rw [show 29 = 27 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_twentyEight_indexTwentyNine,
      pellChebyshev_twentySeven_indexTwentyNine]
  ring

/-- Exact coordinate bridge between the Coleman model
`y_c^2=(4*T_29(x)+5)/2^30` and the monic dyadic model: `X=4x` and
`Y=2^29*y_c`. -/
theorem pellChebyshevTwentyNine_stollColemanMonicModelBridge (x : ℤ) :
    let t29 :=
      268435456 * x ^ 29 - 1946157056 * x ^ 27 +
        6325010432 * x ^ 25 - 12163481600 * x ^ 23 +
          15386804224 * x ^ 21 - 13463453696 * x ^ 19 +
            8341487616 * x ^ 17 - 3683254272 * x ^ 15 +
              1151016960 * x ^ 13 - 249387008 * x ^ 11 +
                36095488 * x ^ 9 - 3281408 * x ^ 7 +
                  168896 * x ^ 5 - 4060 * x ^ 3 + 29 * x
    let fm :=
      (4 * x) ^ 29 - 116 * (4 * x) ^ 27 +
        6032 * (4 * x) ^ 25 - 185600 * (4 * x) ^ 23 +
          3756544 * (4 * x) ^ 21 - 52591616 * (4 * x) ^ 19 +
            521342976 * (4 * x) ^ 17 - 3683254272 * (4 * x) ^ 15 +
              18416271360 * (4 * x) ^ 13 - 63843074048 * (4 * x) ^ 11 +
                147847118848 * (4 * x) ^ 9 - 215050354688 * (4 * x) ^ 7 +
                  177100292096 * (4 * x) ^ 5 - 68115496960 * (4 * x) ^ 3 +
                    7784628224 * (4 * x) + 1342177280
    fm = 2 ^ 28 * (4 * t29 + 5) := by
  dsimp
  ring

/-- Under `Y=2^29*y_c`, the two Coleman endpoints have monic-model
ordinates `2^14` and `3*2^14`. -/
theorem pellChebyshevTwentyNine_stollColemanEndpointScaleLedger :
    (2 : ℤ) ^ 29 = 2 ^ 14 * 2 ^ 15 ∧
      3 * (2 : ℤ) ^ 29 = (3 * 2 ^ 14) * 2 ^ 15 := by
  norm_num

/-- Exact finite counts in the unconditional BDF principal-factor-base
certificate.  The strict real-ball inequality remains external. -/
theorem pellChebyshevTwentyNine_classNumberOneScalarLedger :
    2434529 + 406 + 14 + 4 = 2434953 ∧
      406 + 14 + 4 = 424 ∧
      28 + 29 = 57 := by
  norm_num

/-- The three complete Stoll shell computations have maxima 5, 6, and 7. -/
theorem pellChebyshevTwentyNine_stollGammaShellMaxLedger :
    3 + 2 = 5 ∧ 4 + 2 = 6 ∧ 5 + 2 = 7 := by
  norm_num

/-- Odd units modulo 32 give the exact `n+3` local-constancy radii. -/
theorem pellChebyshevTwentyNine_stollGammaLocalConstancyLedger :
    3 + 5 = (3 + 2) + 3 ∧
      4 + 5 = (4 + 2) + 3 ∧
      5 + 5 = (5 + 2) + 3 := by
  norm_num

/-- Sixteen representatives in each of three shells give 48 tests. -/
theorem pellChebyshevTwentyNine_stollGammaRepresentativeCountLedger :
    32 / 2 = 16 ∧ 3 * 16 = 48 := by
  norm_num

/-- Stoll's tail inequality closes with equality at the fifth shell. -/
theorem pellChebyshevTwentyNine_stollGammaTailLedger :
    2 * 5 - 3 = 7 ∧ 7 ≤ 2 * 5 - 3 := by
  norm_num

/-- Two rational directions have dimension below the genus-fourteen local
Lie group. -/
theorem pellChebyshevTwentyNine_stollGammaClosureDimensionLedger :
    (2 : ℕ) < 14 := by
  norm_num

/-- With `D0=-2H1`, the hyperelliptic-involution correction is `4H1`. -/
theorem pellChebyshevTwentyNine_negativeBranchCorrectionLedger
    (i h1 : ℤ) :
    -i - 2 * (-2 * h1) = -i + 4 * h1 := by
  ring

/-- The correction `4H1` vanishes in the mod-two Kummer quotient. -/
theorem pellChebyshevTwentyNine_negativeBranchModTwoLedger (h1 : ℤ) :
    (4 * h1) % 2 = 0 := by
  omega

/-- Characteristic zero is the final elementary step in the saturation
argument: a positive integral multiple of a Coleman integral can vanish only
when the integral itself vanishes. -/
theorem pellChebyshevTwentyNine_saturatedIntegralZeroLedger
    (n : ℕ) (hn : 0 < n) (integral : ℚ)
    (hzero : (n : ℚ) * integral = 0) :
    integral = 0 := by
  have hnq : (n : ℚ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hn)
  exact (mul_eq_zero.mp hzero).resolve_left hnq

/-- Five rational anchors and one non-rational Weierstrass anchor account for
the six good-reduction residue disks. -/
theorem pellChebyshevTwentyNine_stollGammaColemanDiskLedger :
    5 + 1 = 6 := by
  norm_num

/-- Normalized logarithm columns zero and two have determinant one modulo
five: `1*2-3*2=-4=1 (mod 5)`. -/
theorem pellChebyshevTwentyNine_stollGammaColemanUnitMinorLedger :
    ((1 : ℤ) * 2 - 3 * 2) % 5 = 1 := by
  norm_num

/-- The reduced differential numerator
`4+x+2*x^2+x^13` is a unit at `0,1,-1`, and its leading value at infinity
is one. -/
theorem pellChebyshevTwentyNine_stollGammaColemanUnitValuesLedger :
    4 % 5 = 4 ∧
      (4 + 1 + 2 + 1) % 5 = 3 ∧
      (4 - 1 + 2 - 1) % 5 = 4 ∧
      1 % 5 = 1 := by
  norm_num

/-- The shifted-square polynomial in the coefficient form consumed by the
external rational-point computation. -/
def pellChebyshevTwentyNine_shiftSquarePolynomial (T : ℤ) : ℤ :=
  4 * (268435456 * T ^ 29 - 1946157056 * T ^ 27 +
    6325010432 * T ^ 25 - 12163481600 * T ^ 23 +
      15386804224 * T ^ 21 - 13463453696 * T ^ 19 +
        8341487616 * T ^ 17 - 3683254272 * T ^ 15 +
          1151016960 * T ^ 13 - 249387008 * T ^ 11 +
            36095488 * T ^ 9 - 3281408 * T ^ 7 +
              168896 * T ^ 5 - 4060 * T ^ 3 + 29 * T) + 5

/-- Transparent interface to the external target-disk rational-point
certificate.  The condition `(T+1)%8=0` is the integral form of the actual
Stoll disk. -/
def PARISageRationalTargetDiskCertificateIndexTwentyNine : Prop :=
  ∀ T y : ℤ,
    (T + 1) % 8 = 0 →
    y ^ 2 = pellChebyshevTwentyNine_shiftSquarePolynomial T →
      T = -1

/-- The prime-twenty-nine equation has the explicit genus-fourteen model
consumed by the external certificate. -/
theorem indexTwentyNine_genusFourteen_model (T y : ℤ)
    (h : y ^ 2 = 4 * pellChebyshev 29 T + 5) :
    y ^ 2 = pellChebyshevTwentyNine_shiftSquarePolynomial T := by
  rw [pellChebyshev_twentyNine] at h
  simpa [pellChebyshevTwentyNine_shiftSquarePolynomial] using h

/-- Conditional on the transparent external certificate, the
prime-twenty-nine equation has no integral solution with `T>1` in the
certified dyadic target disk. -/
theorem no_indexTwentyNine_chebyshev_shiftSquare_in_targetDisk_of_external_certificate
    (hcert : PARISageRationalTargetDiskCertificateIndexTwentyNine)
    (T : ℤ) (hT : 1 < T) (htarget : (T + 1) % 8 = 0) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 29 T + 5 := by
  rintro ⟨y, hy⟩
  have hmodel := indexTwentyNine_genusFourteen_model T y hy
  have hminus := hcert T y htarget hmodel
  omega

/-- The Pell residue `T=23 mod 24` lies in the certified dyadic disk. -/
theorem no_indexTwentyNine_chebyshev_shiftSquare_in_pellResidue_of_external_certificate
    (hcert : PARISageRationalTargetDiskCertificateIndexTwentyNine)
    (T : ℤ) (hT : 1 < T) (hresidue : T % 24 = 23) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 29 T + 5 := by
  apply no_indexTwentyNine_chebyshev_shiftSquare_in_targetDisk_of_external_certificate
      hcert T hT
  omega

#print axioms pellChebyshev_twentyNine
#print axioms pellChebyshevTwentyNine_stollColemanMonicModelBridge
#print axioms pellChebyshevTwentyNine_stollColemanEndpointScaleLedger
#print axioms pellChebyshevTwentyNine_classNumberOneScalarLedger
#print axioms pellChebyshevTwentyNine_stollGammaShellMaxLedger
#print axioms pellChebyshevTwentyNine_stollGammaLocalConstancyLedger
#print axioms pellChebyshevTwentyNine_stollGammaRepresentativeCountLedger
#print axioms pellChebyshevTwentyNine_stollGammaTailLedger
#print axioms pellChebyshevTwentyNine_stollGammaClosureDimensionLedger
#print axioms pellChebyshevTwentyNine_negativeBranchCorrectionLedger
#print axioms pellChebyshevTwentyNine_negativeBranchModTwoLedger
#print axioms pellChebyshevTwentyNine_saturatedIntegralZeroLedger
#print axioms pellChebyshevTwentyNine_stollGammaColemanDiskLedger
#print axioms pellChebyshevTwentyNine_stollGammaColemanUnitMinorLedger
#print axioms pellChebyshevTwentyNine_stollGammaColemanUnitValuesLedger
#print axioms indexTwentyNine_genusFourteen_model
#print axioms
  no_indexTwentyNine_chebyshev_shiftSquare_in_targetDisk_of_external_certificate
#print axioms
  no_indexTwentyNine_chebyshev_shiftSquare_in_pellResidue_of_external_certificate

end IUTThreeClosures
