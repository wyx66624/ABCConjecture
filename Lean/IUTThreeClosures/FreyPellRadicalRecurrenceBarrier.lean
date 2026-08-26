import IUTThreeClosures.FreyAdelicPacketCompensationAudit

/-!
# Pell recurrence behind the adelic radical barrier

The fixed-field Pell family from the adelic audit is indexed by the powers of
`2 + sqrt 3`.  This file isolates its exact integral recurrence.  The two
consecutive integers entering the abc radical are simple order-three linear
recurrences with characteristic polynomial

`(X - 1) * (X^2 - 194 X + 1)`.

Only these algebraic identities are formalized here.  In particular, this file
does not assert a lower bound for their radicals, an archimedean local-height
estimate, or the abc conjecture.
-/

namespace IUTThreeClosures

mutual
  /-- Rational part of `(2 + sqrt 3)^n`. -/
  def pellOrbitQ : ℕ → ℤ
    | 0 => 1
    | n + 1 => 2 * pellOrbitQ n + 3 * pellOrbitP n

  /-- `sqrt 3` coefficient of `(2 + sqrt 3)^n`. -/
  def pellOrbitP : ℕ → ℤ
    | 0 => 0
    | n + 1 => pellOrbitQ n + 2 * pellOrbitP n
end

/-- Every term of the orbit lies on the Pell conic. -/
theorem pellOrbit_norm (n : ℕ) :
    pellOrbitQ n ^ 2 - 3 * pellOrbitP n ^ 2 = 1 := by
  induction n with
  | zero => norm_num [pellOrbitQ, pellOrbitP]
  | succ n ih =>
      change
        (2 * pellOrbitQ n + 3 * pellOrbitP n) ^ 2 -
            3 * (pellOrbitQ n + 2 * pellOrbitP n) ^ 2 = 1
      calc
        _ = pellOrbitQ n ^ 2 - 3 * pellOrbitP n ^ 2 := by ring
        _ = 1 := ih

/-- The doubled Pell coordinate `r = 2pq`. -/
def pellDoubleR (n : ℕ) : ℤ :=
  2 * pellOrbitP n * pellOrbitQ n

/-- The doubled Pell coordinate `s = q^2 + 3p^2`. -/
def pellDoubleS (n : ℕ) : ℤ :=
  pellOrbitQ n ^ 2 + 3 * pellOrbitP n ^ 2

/-- Doubling a Pell solution gives another Pell solution. -/
theorem pellDouble_norm (n : ℕ) :
    pellDoubleS n ^ 2 - 3 * pellDoubleR n ^ 2 = 1 := by
  calc
    pellDoubleS n ^ 2 - 3 * pellDoubleR n ^ 2 =
        (pellOrbitQ n ^ 2 - 3 * pellOrbitP n ^ 2) ^ 2 := by
          simp only [pellDoubleS, pellDoubleR]
          ring
    _ = 1 := by rw [pellOrbit_norm]; norm_num

/-- The doubled coordinates evolve by the trace-`14` Pell matrix. -/
theorem pellDoubleS_succ (n : ℕ) :
    pellDoubleS (n + 1) = 7 * pellDoubleS n + 12 * pellDoubleR n := by
  simp only [pellDoubleS, pellDoubleR, pellOrbitQ, pellOrbitP]
  ring

/-- The companion coordinate evolves by the same Pell matrix. -/
theorem pellDoubleR_succ (n : ℕ) :
    pellDoubleR (n + 1) = 4 * pellDoubleS n + 7 * pellDoubleR n := by
  simp only [pellDoubleS, pellDoubleR, pellOrbitQ, pellOrbitP]
  ring

/-- Hence the trace coordinate itself is a binary recurrence. -/
theorem pellDoubleS_recurrence (n : ℕ) :
    pellDoubleS (n + 2) = 14 * pellDoubleS (n + 1) - pellDoubleS n := by
  simp [pellDoubleS_succ, pellDoubleR_succ]
  ring

/-- First member of the consecutive Pell--Frey pair. -/
def pellRadicalB (n : ℕ) : ℤ :=
  pellDoubleS n ^ 2 - 3

/-- Second member of the consecutive Pell--Frey pair. -/
def pellRadicalC (n : ℕ) : ℤ :=
  pellDoubleS n ^ 2 - 2

/-- The two displayed recurrence values are consecutive. -/
theorem pellRadicalC_eq_B_add_one (n : ℕ) :
    pellRadicalC n = pellRadicalB n + 1 := by
  simp only [pellRadicalB, pellRadicalC]
  ring

/-- The first recurrence is exactly the `3r^2 - 2` Pell--Frey input. -/
theorem pellRadicalB_eq_three_r_sq_sub_two (n : ℕ) :
    pellRadicalB n = 3 * pellDoubleR n ^ 2 - 2 := by
  have h := pellDouble_norm n
  simp only [pellRadicalB]
  linarith

/-- The second recurrence is exactly the consecutive `3r^2 - 1` input. -/
theorem pellRadicalC_eq_three_r_sq_sub_one (n : ℕ) :
    pellRadicalC n = 3 * pellDoubleR n ^ 2 - 1 := by
  have h := pellDouble_norm n
  simp only [pellRadicalC]
  linarith

/-- Squaring the trace-`14` recurrence produces the order-three recurrence
with coefficients `195, -195, 1`. -/
theorem pellRadicalB_recurrence (n : ℕ) :
    pellRadicalB (n + 3) =
      195 * pellRadicalB (n + 2) -
        195 * pellRadicalB (n + 1) + pellRadicalB n := by
  simp [pellRadicalB, pellDoubleS_succ, pellDoubleR_succ]
  ring

/-- The consecutive companion has the identical characteristic recurrence. -/
theorem pellRadicalC_recurrence (n : ℕ) :
    pellRadicalC (n + 3) =
      195 * pellRadicalC (n + 2) -
        195 * pellRadicalC (n + 1) + pellRadicalC n := by
  simp [pellRadicalC, pellDoubleS_succ, pellDoubleR_succ]
  ring

/-- Factorization of the common characteristic polynomial. -/
theorem pellRadical_characteristicPolynomial (X : ℤ) :
    (X - 1) * (X ^ 2 - 194 * X + 1) =
      X ^ 3 - 195 * X ^ 2 + 195 * X - 1 := by
  ring

/-- The first nontrivial pair is `(46,47)`. -/
theorem pellRadical_first_pair :
    pellRadicalB 1 = 46 ∧ pellRadicalC 1 = 47 := by
  norm_num [pellRadicalB, pellRadicalC, pellDoubleS, pellOrbitQ, pellOrbitP]

/-- The next pair is `(9406,9407)`. -/
theorem pellRadical_second_pair :
    pellRadicalB 2 = 9406 ∧ pellRadicalC 2 = 9407 := by
  norm_num [pellRadicalB, pellRadicalC, pellDoubleS, pellOrbitQ, pellOrbitP]

end IUTThreeClosures
