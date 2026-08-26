import Mathlib

/-!
# Algebraic skeleton for the Pell first-hit and lifting audit

This module verifies the polynomial and trace identities used in the paper
audit of the Pell radical pair.  It does not formalize quadratic reciprocity,
splitting of primes, local fields, Hensel lifting, gcd divisibility, or a
radical lower bound.
-/

namespace IUTThreeClosures

/-! ## The two toric polynomials -/

/-- The toric polynomial whose roots are `5` plus or minus `2 * sqrt 6`. -/
def pellToricB (X : ℤ) : ℤ :=
  X ^ 2 - 10 * X + 1

/-- The toric polynomial whose roots are `3` plus or minus `2 * sqrt 2`. -/
def pellToricC (X : ℤ) : ℤ :=
  X ^ 2 - 6 * X + 1

/-- The two shifted toric polynomials differ by exactly `4X`. -/
theorem pellToric_difference (X : ℤ) :
    pellToricC X - pellToricB X = 4 * X := by
  simp only [pellToricB, pellToricC]
  ring

/-- A Bezout certificate excluding a common root in odd characteristic. -/
theorem pellToric_bezout (X : ℤ) :
    4 * pellToricB X +
        (10 - X) * (pellToricC X - pellToricB X) = 4 := by
  simp only [pellToricB, pellToricC]
  ring

/-- The discriminant certificate for the first toric polynomial. -/
theorem pellToricB_discriminant_certificate (X : ℤ) :
    (2 * X - 10) ^ 2 - 4 * pellToricB X = 96 := by
  simp only [pellToricB]
  ring

/-- The discriminant certificate for the second toric polynomial. -/
theorem pellToricC_discriminant_certificate (X : ℤ) :
    (2 * X - 6) ^ 2 - 4 * pellToricC X = 32 := by
  simp only [pellToricC]
  ring

/-- Ring-valued form of the Bezout obstruction: any common root forces
`4 = 0`. -/
theorem pellToric_common_root_forces_four
    {R : Type*} [CommRing R] (X : R)
    (hB : X ^ 2 - 10 * X + 1 = 0)
    (hC : X ^ 2 - 6 * X + 1 = 0) :
    (4 : R) = 0 := by
  calc
    (4 : R) =
        4 * (X ^ 2 - 10 * X + 1) +
          (10 - X) *
            ((X ^ 2 - 6 * X + 1) - (X ^ 2 - 10 * X + 1)) := by ring
    _ = 0 := by rw [hB, hC]; ring

/-! ## Trace carriers -/

/-- The trace recurrence attached to a norm-one unit with trace `T`. -/
def pellUnitTrace (T : ℤ) : ℕ → ℤ
  | 0 => 2
  | 1 => T
  | n + 2 => T * pellUnitTrace T (n + 1) - pellUnitTrace T n

/-- The target trace attached to `5 + 2 * sqrt 6`. -/
def pellTargetTraceB : ℕ → ℤ :=
  pellUnitTrace 10

/-- The target trace attached to `3 + 2 * sqrt 2`. -/
def pellTargetTraceC : ℕ → ℤ :=
  pellUnitTrace 6

/-- The first target trace has recurrence coefficient `10`. -/
theorem pellTargetTraceB_recurrence (n : ℕ) :
    pellTargetTraceB (n + 2) =
      10 * pellTargetTraceB (n + 1) - pellTargetTraceB n := by
  rfl

/-- The second target trace has recurrence coefficient `6`. -/
theorem pellTargetTraceC_recurrence (n : ℕ) :
    pellTargetTraceC (n + 2) =
      6 * pellTargetTraceC (n + 1) - pellTargetTraceC n := by
  rfl

/-- The cross carrier for the observed prime `23` is `92 = 4 * 23`. -/
theorem pellTargetTrace_cross_23 :
    pellTargetTraceB 2 - pellTargetTraceC 1 = 92 := by
  norm_num [pellTargetTraceB, pellTargetTraceC, pellUnitTrace]

/-- The cross carrier for the observed prime `47` is `-188 = -4 * 47`. -/
theorem pellTargetTrace_cross_47 :
    pellTargetTraceB 1 - pellTargetTraceC 3 = -188 := by
  norm_num [pellTargetTraceB, pellTargetTraceC, pellUnitTrace]

/-- Product over the four inverse conjugates equals the square of the trace
difference. -/
theorem inverseRoot_traceNorm_identity
    (x y : ℚ) (hx : x ≠ 0) (hy : y ≠ 0) :
    (x - y) * (x - y⁻¹) * (x⁻¹ - y) * (x⁻¹ - y⁻¹) =
      ((x + x⁻¹) - (y + y⁻¹)) ^ 2 := by
  field_simp
  ring

/-! ## Scalar powerful-prime ledger -/

/-- Logarithmic size carried by one prime with exponent `e`. -/
def onePrimeLogSize (e primeLog : ℝ) : ℝ :=
  e * primeLog

/-- Radical weight carried by the same prime, independent of its exponent. -/
def onePrimeRadLog (primeLog : ℝ) : ℝ :=
  primeLog

/-- For one prime, radical weight is the reciprocal-exponent fraction of
logarithmic size.  This is the scalar obstruction behind the finite local
model; it is not a statement about the actual Pell recurrence. -/
theorem onePrime_radical_fraction
    (e primeLog : ℝ) (he : e ≠ 0) :
    onePrimeRadLog primeLog = onePrimeLogSize e primeLog / e := by
  simp only [onePrimeRadLog, onePrimeLogSize]
  field_simp

end IUTThreeClosures
