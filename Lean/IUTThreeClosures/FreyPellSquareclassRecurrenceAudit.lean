import IUTThreeClosures.FreyPellRadicalRecurrenceBarrier

/-!
# Scalar kernel for the Pell square-class recurrence audit

For the actual Pell companion one writes `c n = A n * y n ^ 2`, where
`A n` is the squarefree representative of the rational square class.  This
notion is different from the radical (the product of all support primes).

The companion note audits recurrence theorems which concern radicals,
primitive support, or perfect powers.  The elementary model below has exactly
the same order-three recurrence as the Pell companion, but is visibly twice a
square at every index.  It therefore separates recurrence-spectrum data from
growth of the square-class representative.

No squarefree-factorization theorem, primitive-divisor theorem, asymptotic,
or abc statement is formalized or assumed here.
-/

namespace IUTThreeClosures

/-- A same-spectrum Pell model whose rational square class is visibly `2`:
`Z_n = 2 * s_n^2`. -/
def pellSquareclassSpectralModel (n : ℕ) : ℤ :=
  2 * pellDoubleS n ^ 2

/-- The displayed factorization is definitional.  In the paper, the separate
elementary fact that `pellDoubleS n` is odd identifies `2` as the unique
positive squarefree representative. -/
theorem pellSquareclassSpectralModel_eq_two_mul_square (n : ℕ) :
    pellSquareclassSpectralModel n = 2 * pellDoubleS n ^ 2 := by
  rfl

/-- The model is only an affine translate of the actual Pell companion. -/
theorem pellSquareclassSpectralModel_eq_two_mul_C_add_four (n : ℕ) :
    pellSquareclassSpectralModel n = 2 * pellRadicalC n + 4 := by
  simp only [pellSquareclassSpectralModel, pellRadicalC]
  ring

/-- Consequently it has exactly the same order-three recurrence as `c_n`. -/
theorem pellSquareclassSpectralModel_recurrence (n : ℕ) :
    pellSquareclassSpectralModel (n + 3) =
      195 * pellSquareclassSpectralModel (n + 2) -
        195 * pellSquareclassSpectralModel (n + 1) +
          pellSquareclassSpectralModel n := by
  simp [pellSquareclassSpectralModel, pellDoubleS_succ, pellDoubleR_succ]
  ring

/-- The characteristic polynomial is literally the Pell companion's
reciprocal cubic. -/
theorem pellSquareclassSpectralModel_characteristicPolynomial (X : ℤ) :
    (X - 1) * (X ^ 2 - 194 * X + 1) =
      X ^ 3 - 195 * X ^ 2 + 195 * X - 1 := by
  exact pellRadical_characteristicPolynomial X

/-- The first two nontrivial values are `98 = 2*7^2` and
`18818 = 2*97^2`. -/
theorem pellSquareclassSpectralModel_first_values :
    pellSquareclassSpectralModel 1 = 98 ∧
      pellSquareclassSpectralModel 2 = 18818 := by
  norm_num [pellSquareclassSpectralModel, pellDoubleS,
    pellOrbitQ, pellOrbitP]

/-! ## A norm-two Pell boundary model -/

/-- Multiplication by the norm-one unit `48 + 7 * sqrt 47` on the
coordinates of `s + y * sqrt 47`. -/
def normTwo47StepS (s y : ℤ) : ℤ :=
  48 * s + 329 * y

def normTwo47StepY (s y : ℤ) : ℤ :=
  7 * s + 48 * y

/-- The fixed squarefree parameter `47`, which is `23 mod 24`, supports an
infinite norm-two Pell orbit.  Thus the equation `s^2 - A*y^2 = 2` and the
congruence `A = 23 mod 24`, without the separate simultaneous
`s^2 - 3*r^2 = 1` condition and the fundamental-solution condition, do not
force the parameter `A` to grow. -/
theorem normTwo47Step_preserves
    (s y : ℤ) (h : s ^ 2 - 47 * y ^ 2 = 2) :
    normTwo47StepS s y ^ 2 - 47 * normTwo47StepY s y ^ 2 = 2 := by
  rw [show normTwo47StepS s y ^ 2 - 47 * normTwo47StepY s y ^ 2 =
      (48 ^ 2 - 47 * 7 ^ 2) * (s ^ 2 - 47 * y ^ 2) by
    simp only [normTwo47StepS, normTwo47StepY]
    ring]
  norm_num [h]

theorem normTwo47_initial : (7 : ℤ) ^ 2 - 47 * (1 : ℤ) ^ 2 = 2 := by
  norm_num

theorem normTwo47_congruence : (47 : ℤ) % 24 = 23 := by
  norm_num

/-! ## Scalar parity ledger -/

/-- A radical lower bound does not by itself lower-bound the parity
square-class weight.  Here `total = squareclass + 2*squareBase`, while a
separate radical certificate may be arbitrarily large without occurring in
that identity. -/
theorem radicalWeight_does_not_enter_squareclassLedger
    (total squareclass squareBase : ℝ)
    (hledger : total = squareclass + 2 * squareBase) :
    squareclass = total - 2 * squareBase := by
  linarith

/-- Coefficient-one growth of the square-class representative is exactly
equivalent, at the scalar level, to sublinear square-base weight. -/
theorem squareclassCoefficientOne_iff_squareBaseSmall
    (source epsilon squareclass squareBase : ℝ)
    (hledger : source = squareclass + 2 * squareBase) :
    (1 - epsilon) * source ≤ squareclass ↔
      2 * squareBase ≤ epsilon * source := by
  constructor <;> intro h <;> linarith

end IUTThreeClosures
