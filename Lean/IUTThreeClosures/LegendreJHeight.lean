import IUTThreeClosures.ABCFreyCurve
import IUTThreeClosures.LegendreHeightCorridor
import Heights.WeilHeight

/-!
# The rational Legendre/Frey `j`-height corridor

For an abc point, put

* `H = a² + ab + b²`,
* `D = (abc)²`,
* `r = H³ / D`.

The Frey and Legendre curves have `j = 256 r`. This file first isolates the
pure arithmetic needed for an exact Weil-height comparison. In particular,
`D ≤ H³ ≤ c⁶ ≤ 8 H³`. Hence the reduced rational height of `r` is controlled
within a universal constant of six times the tripod height.

No q-pilot or IUT estimate is assumed here; all quantities are canonical
functions of the abc point.
-/

namespace IUTThreeClosures

namespace ABCPoint

/-- The denominator occurring in the primitive Legendre/Frey `j`-ratio. -/
def legendreDenominator (P : ABCPoint) : ℕ :=
  (P.a * P.b * P.c) ^ 2

/-- The primitive rational part of the Frey `j`-invariant. -/
noncomputable def legendreCoreRatio (P : ABCPoint) : ℚ :=
  (P.legendreCore : ℚ) ^ 3 / (P.legendreDenominator : ℚ)

@[simp] theorem legendreDenominator_pos (P : ABCPoint) :
    0 < P.legendreDenominator := by
  unfold legendreDenominator
  positivity

/-- The cubed core and the squared abc product are coprime. -/
theorem coprime_coreCube_legendreDenominator (P : ABCPoint) :
    Nat.Coprime (P.legendreCore ^ 3) P.legendreDenominator := by
  unfold legendreDenominator
  exact (P.coprime_abc_legendreCore.symm.pow_left 3).pow_right 2

/-- `ab ≤ H`. -/
theorem ab_le_legendreCore (P : ABCPoint) :
    P.a * P.b ≤ P.legendreCore := by
  unfold legendreCore
  omega

/-- `ac ≤ H`. -/
theorem ac_le_legendreCore (P : ABCPoint) :
    P.a * P.c ≤ P.legendreCore := by
  rw [← P.sum_eq]
  unfold legendreCore
  nlinarith [Nat.zero_le (P.b ^ 2)]

/-- `bc ≤ H`. -/
theorem bc_le_legendreCore (P : ABCPoint) :
    P.b * P.c ≤ P.legendreCore := by
  rw [← P.sum_eq]
  unfold legendreCore
  nlinarith [Nat.zero_le (P.a ^ 2)]

/-- The rational denominator does not exceed the numerator core cube. -/
theorem legendreDenominator_le_coreCube (P : ABCPoint) :
    P.legendreDenominator ≤ P.legendreCore ^ 3 := by
  calc
    P.legendreDenominator =
        (P.a * P.b) * (P.a * P.c) * (P.b * P.c) := by
      unfold legendreDenominator
      ring
    _ ≤ P.legendreCore * P.legendreCore * P.legendreCore :=
      Nat.mul_le_mul
        (Nat.mul_le_mul P.ab_le_legendreCore P.ac_le_legendreCore)
        P.bc_le_legendreCore
    _ = P.legendreCore ^ 3 := by ring

/-- The core cube is at most `c⁶`. -/
theorem coreCube_le_c_pow_six (P : ABCPoint) :
    P.legendreCore ^ 3 ≤ P.c ^ 6 := by
  calc
    P.legendreCore ^ 3 =
        P.legendreCore * P.legendreCore * P.legendreCore := by ring
    _ ≤ (P.c ^ 2) * (P.c ^ 2) * (P.c ^ 2) :=
      Nat.mul_le_mul
        (Nat.mul_le_mul P.legendreCore_le_c_sq P.legendreCore_le_c_sq)
        P.legendreCore_le_c_sq
    _ = P.c ^ 6 := by ring

/-- Conversely `c⁶` is at most eight times the core cube. -/
theorem c_pow_six_le_eight_coreCube (P : ABCPoint) :
    P.c ^ 6 ≤ 8 * P.legendreCore ^ 3 := by
  calc
    P.c ^ 6 = (P.c ^ 2) * (P.c ^ 2) * (P.c ^ 2) := by ring
    _ ≤ (2 * P.legendreCore) * (2 * P.legendreCore) *
        (2 * P.legendreCore) :=
      Nat.mul_le_mul
        (Nat.mul_le_mul P.c_sq_le_two_legendreCore
          P.c_sq_le_two_legendreCore)
        P.c_sq_le_two_legendreCore
    _ = 8 * P.legendreCore ^ 3 := by ring

end ABCPoint

/-- The Frey `j`-invariant is the fixed scalar `256` times the primitive core
ratio. -/
theorem abcFrey_j_eq_256_mul_legendreCoreRatio (P : ABCPoint) :
    (abcFreyCurve P).j = 256 * P.legendreCoreRatio := by
  rw [abcFrey_j]
  unfold ABCPoint.legendreCoreRatio ABCPoint.legendreDenominator
  push_cast
  ring

end IUTThreeClosures
