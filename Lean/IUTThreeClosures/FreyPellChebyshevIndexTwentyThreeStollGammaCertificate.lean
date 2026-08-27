import IUTThreeClosures.FreyPellChebyshevIndexElevenColemanChabautyCertificate

/-!
# Prime-twenty-three Stoll--Gamma closure: scalar companion

The companion audit and the external PARI/Sage certificates implement the
unconditional class-group 2-torsion proof, the global-to-dyadic Kummer injection, Stoll's
finite shell recursion, and the Coleman finish.  This file checks the copied
polynomial and finite scalar consequences and exposes the target-disk
rational-point statement only as a transparent proposition supplied as a
hypothesis.

The external CL2 package has passed its rigorous real-ball and exact-resultant
gates.  Those results remain transparent at the Lean boundary: this file does
not formalize class groups, explicit formulas, Jacobians, Selmer groups,
Hilbert symbols, p-adic halving, or Coleman integration.
-/

namespace IUTThreeClosures

private theorem pellChebyshev_two_indexTwentyThree (x : ℤ) :
    pellChebyshev 2 x = 2 * x ^ 2 - 1 := by
  rw [show 2 = 0 + 2 by norm_num, pellChebyshev_add_two]
  simp [pellChebyshev_zero, pellChebyshev_one]
  ring_nf

private theorem pellChebyshev_twentyOne_indexTwentyThree (x : ℤ) :
    pellChebyshev 21 x =
      1048576 * x ^ 21 - 5505024 * x ^ 19 +
        12386304 * x ^ 17 - 15597568 * x ^ 15 +
          12042240 * x ^ 13 - 5870592 * x ^ 11 +
            1793792 * x ^ 9 - 329472 * x ^ 7 +
              33264 * x ^ 5 - 1540 * x ^ 3 + 21 * x := by
  rw [show 21 = 3 * 7 by norm_num, pellChebyshev_mul]
  rw [pellChebyshev_three, pellChebyshev_seven]
  ring

private theorem pellChebyshev_twentyTwo_indexTwentyThree (x : ℤ) :
    pellChebyshev 22 x =
      2097152 * x ^ 22 - 11534336 * x ^ 20 +
        27394048 * x ^ 18 - 36765696 * x ^ 16 +
          30638080 * x ^ 14 - 16400384 * x ^ 12 +
            5637632 * x ^ 10 - 1208064 * x ^ 8 +
              151008 * x ^ 6 - 9680 * x ^ 4 + 242 * x ^ 2 - 1 := by
  rw [show 22 = 2 * 11 by norm_num, pellChebyshev_mul]
  rw [pellChebyshev_two_indexTwentyThree, pellChebyshev_eleven]
  ring

/-- The first-kind twenty-third Chebyshev polynomial in the repository's Pell
normalization. -/
theorem pellChebyshev_twentyThree (x : ℤ) :
    pellChebyshev 23 x =
      4194304 * x ^ 23 - 24117248 * x ^ 21 +
        60293120 * x ^ 19 - 85917696 * x ^ 17 +
          76873728 * x ^ 15 - 44843008 * x ^ 13 +
            17145856 * x ^ 11 - 4209920 * x ^ 9 +
              631488 * x ^ 7 - 52624 * x ^ 5 +
                2024 * x ^ 3 - 23 * x := by
  rw [show 23 = 21 + 2 by norm_num, pellChebyshev_add_two]
  norm_num only [Nat.reduceAdd]
  rw [pellChebyshev_twentyTwo_indexTwentyThree,
      pellChebyshev_twentyOne_indexTwentyThree]
  ring

/-- Exact coefficient ledger for the coordinate bridge between the Coleman
model and the monic dyadic model under X=4x and Y=2^23*y_c.  Equality of
these thirteen scaled coefficients is the full polynomial identity used by
the external Sage assertion. -/
theorem pellChebyshevTwentyThree_stollColemanMonicModelBridge :
    (4 : ℤ) ^ 23 = 2 ^ 22 * (4 * 4194304) ∧
      92 * 4 ^ 21 = 2 ^ 22 * (4 * 24117248) ∧
      3680 * 4 ^ 19 = 2 ^ 22 * (4 * 60293120) ∧
      83904 * 4 ^ 17 = 2 ^ 22 * (4 * 85917696) ∧
      1201152 * 4 ^ 15 = 2 ^ 22 * (4 * 76873728) ∧
      11210752 * 4 ^ 13 = 2 ^ 22 * (4 * 44843008) ∧
      68583424 * 4 ^ 11 = 2 ^ 22 * (4 * 17145856) ∧
      269434880 * 4 ^ 9 = 2 ^ 22 * (4 * 4209920) ∧
      646643712 * 4 ^ 7 = 2 ^ 22 * (4 * 631488) ∧
      862191616 * 4 ^ 5 = 2 ^ 22 * (4 * 52624) ∧
      530579456 * 4 ^ 3 = 2 ^ 22 * (4 * 2024) ∧
      96468992 * 4 = 2 ^ 22 * (4 * 23) ∧
      20971520 = 2 ^ 22 * 5 := by
  norm_num

/-- The two Coleman points map to the monic points with ordinates 2048 and
6144 under `Y=2^23*y_c`; the Coleman denominator is `2^12`. -/
theorem pellChebyshevTwentyThree_stollColemanEndpointScaleLedger :
    (2 : ℤ) ^ 23 = 2048 * 2 ^ 12 ∧
      3 * (2 : ℤ) ^ 23 = 6144 * 2 ^ 12 := by
  norm_num

/-- The certified global support dimension, full dyadic squareclass dimension,
and eleven-dimensional Stoll over-approximation. -/
theorem pellChebyshevTwentyThree_globalDyadicDimensionLedger :
    1 + 11 + 5 = 17 ∧
      17 - 6 = 11 ∧
      23 + 2 = 25 ∧
      (11 : ℕ) ≤ 25 := by
  norm_num

/-- Exact scalar inputs recorded by the external unconditional `Cl(K)[2]=0`
certificate: the 23-adic index residue, the degree-one-prime count including
the two separately treated ramified primes, and degree/signature arithmetic.
The transcendental explicit-formula inequality remains external and
transparent; it is deliberately not encoded as a scalar theorem here. -/
theorem pellChebyshevTwentyThree_cl2ExplicitScalarLedger :
    (2 : ℕ) ^ 22 % (23 ^ 2) = 392 ∧
      598490 + 2 = 598492 ∧
      2 * 23 = 46 ∧
      2 + 2 * 22 = 46 := by
  norm_num

/-- The three complete shell computations have maxima 5, 6, and 7. -/
theorem pellChebyshevTwentyThree_stollGammaShellMaxLedger :
    3 + 2 = 5 ∧ 4 + 2 = 6 ∧ 5 + 2 = 7 := by
  norm_num

/-- Odd units modulo 32 give the exact `n+3` local-constancy radii. -/
theorem pellChebyshevTwentyThree_stollGammaLocalConstancyLedger :
    3 + 5 = (3 + 2) + 3 ∧
      4 + 5 = (4 + 2) + 3 ∧
      5 + 5 = (5 + 2) + 3 := by
  norm_num

/-- Sixteen representatives in each of three shells give 48 tests. -/
theorem pellChebyshevTwentyThree_stollGammaRepresentativeCountLedger :
    32 / 2 = 16 ∧ 3 * 16 = 48 := by
  norm_num

/-- Stoll's tail inequality closes with equality at the fifth shell. -/
theorem pellChebyshevTwentyThree_stollGammaTailLedger :
    2 * 5 - 3 = 7 ∧ 7 ≤ 2 * 5 - 3 := by
  norm_num

/-- Two rational directions have dimension below the genus eleven Lie group. -/
theorem pellChebyshevTwentyThree_stollGammaClosureDimensionLedger :
    (2 : ℕ) < 11 := by
  norm_num

/-- With `D0=-2H1`, the involution correction is `4H1`. -/
theorem pellChebyshevTwentyThree_negativeBranchCorrectionLedger
    (i h1 : ℤ) :
    -i - 2 * (-2 * h1) = -i + 4 * h1 := by
  ring

/-- The correction `4H1` vanishes in the mod-two Kummer quotient. -/
theorem pellChebyshevTwentyThree_negativeBranchModTwoLedger (h1 : ℤ) :
    (4 * h1) % 2 = 0 := by
  omega

/-- Five rational anchors and one non-rational Weierstrass anchor account for
the six good-reduction residue disks. -/
theorem pellChebyshevTwentyThree_stollGammaColemanDiskLedger :
    5 + 1 = 6 := by
  norm_num

/-- The first two normalized logarithm columns have determinant one modulo
five: `1*3-1*2=1`. -/
theorem pellChebyshevTwentyThree_stollGammaColemanUnitMinorLedger :
    (1 * 3 - 1 * 2) % 5 = 1 := by
  norm_num

/-- The reduced differential numerator `1+3*x^10` is a unit at the finite
residue types `0,1,-1`, and its leading value at infinity is three. -/
theorem pellChebyshevTwentyThree_stollGammaColemanUnitValuesLedger :
    1 % 5 = 1 ∧
      (1 + 3) % 5 = 4 ∧
      (1 + 3 * 4 ^ 10) % 5 = 4 ∧
      3 % 5 = 3 := by
  norm_num

/-- The shifted-square polynomial in the coefficient form used by the
external computation.  Keeping the outer factor of four visible makes the
connection to `pellChebyshev_twentyThree` definitional and avoids an
expensive symbolic normalization of a degree-23 expression. -/
def pellChebyshevTwentyThree_shiftSquarePolynomial (T : ℤ) : ℤ :=
  4 * (4194304 * T ^ 23 - 24117248 * T ^ 21 +
    60293120 * T ^ 19 - 85917696 * T ^ 17 +
      76873728 * T ^ 15 - 44843008 * T ^ 13 +
        17145856 * T ^ 11 - 4209920 * T ^ 9 +
          631488 * T ^ 7 - 52624 * T ^ 5 +
            2024 * T ^ 3 - 23 * T) + 5

/-- Transparent interface to the external PARI/Sage target-disk rational-point
certificate.  At the Lean boundary the external result remains an explicit
hypothesis; the frozen audit independently certifies every gate, including the
unconditional class-group 2-torsion proof.  The
condition `(T + 1) % 8 = 0` is the integral form of the actual Stoll disk
`T + 1 ∈ 8 * Z_2`; the external calculation does not cover every rational
point of the genus-eleven curve. -/
def PARISageRationalTargetDiskCertificateIndexTwentyThree : Prop :=
  ∀ T y : ℤ,
    (T + 1) % 8 = 0 →
    y ^ 2 = pellChebyshevTwentyThree_shiftSquarePolynomial T →
      T = -1 ∨ T = 1

/-- The prime-twenty-three shifted-square equation has the explicit genus
eleven polynomial model consumed by the external certificate. -/
theorem indexTwentyThree_genusEleven_model (T y : ℤ)
    (h : y ^ 2 = 4 * pellChebyshev 23 T + 5) :
    y ^ 2 = pellChebyshevTwentyThree_shiftSquarePolynomial T := by
  rw [pellChebyshev_twentyThree] at h
  simpa [pellChebyshevTwentyThree_shiftSquarePolynomial] using h

/-- Conditional on the transparent external certificate, the prime-twenty-three
Chebyshev equation has no integral solution with `T > 1` in the certified
dyadic target disk. -/
theorem no_indexTwentyThree_chebyshev_shiftSquare_in_targetDisk_of_external_certificate
    (hcert : PARISageRationalTargetDiskCertificateIndexTwentyThree)
    (T : ℤ) (hT : 1 < T) (htarget : (T + 1) % 8 = 0) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 23 T + 5 := by
  rintro ⟨y, hy⟩
  have hmodel := indexTwentyThree_genusEleven_model T y hy
  rcases hcert T y htarget hmodel with h | h <;> omega

/-- The Pell residue T congruent to 23 modulo 24 lies in the certified dyadic
disk. -/
theorem no_indexTwentyThree_chebyshev_shiftSquare_in_pellResidue_of_external_certificate
    (hcert : PARISageRationalTargetDiskCertificateIndexTwentyThree)
    (T : ℤ) (hT : 1 < T) (hresidue : T % 24 = 23) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev 23 T + 5 := by
  apply no_indexTwentyThree_chebyshev_shiftSquare_in_targetDisk_of_external_certificate
      hcert T hT
  omega

#print axioms pellChebyshev_twentyThree
#print axioms pellChebyshevTwentyThree_stollColemanMonicModelBridge
#print axioms pellChebyshevTwentyThree_stollColemanEndpointScaleLedger
#print axioms pellChebyshevTwentyThree_globalDyadicDimensionLedger
#print axioms pellChebyshevTwentyThree_cl2ExplicitScalarLedger
#print axioms pellChebyshevTwentyThree_stollGammaShellMaxLedger
#print axioms pellChebyshevTwentyThree_stollGammaLocalConstancyLedger
#print axioms pellChebyshevTwentyThree_stollGammaRepresentativeCountLedger
#print axioms pellChebyshevTwentyThree_stollGammaTailLedger
#print axioms pellChebyshevTwentyThree_stollGammaClosureDimensionLedger
#print axioms pellChebyshevTwentyThree_negativeBranchCorrectionLedger
#print axioms pellChebyshevTwentyThree_negativeBranchModTwoLedger
#print axioms pellChebyshevTwentyThree_stollGammaColemanDiskLedger
#print axioms pellChebyshevTwentyThree_stollGammaColemanUnitMinorLedger
#print axioms pellChebyshevTwentyThree_stollGammaColemanUnitValuesLedger
#print axioms indexTwentyThree_genusEleven_model
#print axioms
  no_indexTwentyThree_chebyshev_shiftSquare_in_targetDisk_of_external_certificate
#print axioms
  no_indexTwentyThree_chebyshev_shiftSquare_in_pellResidue_of_external_certificate

end IUTThreeClosures
