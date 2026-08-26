import IUTThreeClosures.FreyPellRadicalRecurrenceBarrier

/-!
# Recurrence skeleton for the Pell squarefull and primitive-divisor audit

The companion note combines the consecutive Pell values into one order-five
recurrence and audits what square-free-factor, primitive-divisor, perfect-power,
and fixed-S theorems actually imply.  This file proves only elementary
recurrence identities and a real-valued coefficient ledger.

It does not formalize Stewart's theorem, primitive-divisor theorems, radicals,
asymptotics, or the missing pointwise abc estimate.  None of those statements
is inserted as an axiom.
-/

namespace IUTThreeClosures

/-! ## The joint Pell value is an order-five recurrence -/

/-- Product of the two consecutive Pell--Frey values. -/
def pellRadicalJoint (n : ℕ) : ℤ :=
  pellRadicalB n * pellRadicalC n

/-- Multiplying the two order-three characteristic factors at the two power
scales gives the reciprocal order-five characteristic polynomial. -/
theorem pellRadicalJoint_characteristicPolynomial (X : ℤ) :
    (X - 1) * (X ^ 2 - 194 * X + 1) *
        (X ^ 2 - 37634 * X + 1) =
      X ^ 5 - 37829 * X ^ 4 + 7338826 * X ^ 3 -
        7338826 * X ^ 2 + 37829 * X - 1 := by
  ring

/-- The product sequence has the order-five recurrence predicted by the five
distinct power-sum roots `lambda^2, lambda, 1, lambda^-1, lambda^-2`. -/
theorem pellRadicalJoint_recurrence (n : ℕ) :
    pellRadicalJoint (n + 5) =
      37829 * pellRadicalJoint (n + 4) -
        7338826 * pellRadicalJoint (n + 3) +
          7338826 * pellRadicalJoint (n + 2) -
            37829 * pellRadicalJoint (n + 1) +
              pellRadicalJoint n := by
  simp [pellRadicalJoint, pellRadicalB, pellRadicalC,
    pellDoubleS_succ, pellDoubleR_succ]
  ring

/-- The shifted first sequence is not a divisibility sequence: already its
first nontrivial term does not divide its second. -/
theorem pellRadicalB_not_divisibilityWitness :
    ¬pellRadicalB 1 ∣ pellRadicalB 2 := by
  norm_num [pellRadicalB, pellDoubleS, pellOrbitQ, pellOrbitP]

/-- The same elementary obstruction holds for the consecutive companion. -/
theorem pellRadicalC_not_divisibilityWitness :
    ¬pellRadicalC 1 ∣ pellRadicalC 2 := by
  norm_num [pellRadicalC, pellDoubleS, pellOrbitQ, pellOrbitP]

/-! ## A homogeneous carrier for repeated support -/

/-- Addition on the Pell torus, expressed in the doubled coordinates. -/
theorem pellDouble_addition (m k : ℕ) :
    pellDoubleS (m + k) =
        pellDoubleS m * pellDoubleS k +
          3 * pellDoubleR m * pellDoubleR k ∧
      pellDoubleR (m + k) =
        pellDoubleS m * pellDoubleR k +
          pellDoubleR m * pellDoubleS k := by
  induction k with
  | zero =>
      norm_num [pellDoubleS, pellDoubleR, pellOrbitQ, pellOrbitP]
  | succ k ih =>
      constructor
      · rw [Nat.add_succ, pellDoubleS_succ, ih.1, ih.2,
          pellDoubleS_succ, pellDoubleR_succ]
        ring
      · rw [Nat.add_succ, pellDoubleR_succ, ih.1, ih.2,
          pellDoubleS_succ, pellDoubleR_succ]
        ring

/-- The difference of two `b`-values factors through homogeneous Pell/Lucas
terms at the difference and sum indices.  With `n = m + k`, this is
`b_n - b_m = 3 r_{n-m} r_{n+m}`. -/
theorem pellRadicalB_difference_homogeneousCarrier (m k : ℕ) :
    pellRadicalB (m + k) - pellRadicalB m =
      3 * pellDoubleR k * pellDoubleR (m + m + k) := by
  have hadd := (pellDouble_addition m k).1
  have hdoubleS := (pellDouble_addition m m).1
  have hdoubleR := (pellDouble_addition m m).2
  have hcarrier := (pellDouble_addition (m + m) k).2
  have hnormM := pellDouble_norm m
  have hnormK := pellDouble_norm k
  simp only [pellRadicalB]
  rw [hadd, hcarrier, hdoubleS, hdoubleR]
  nlinarith

/-- The consecutive companion has exactly the same homogeneous difference
carrier. -/
theorem pellRadicalC_difference_homogeneousCarrier (m k : ℕ) :
    pellRadicalC (m + k) - pellRadicalC m =
      3 * pellDoubleR k * pellDoubleR (m + m + k) := by
  have h := pellRadicalB_difference_homogeneousCarrier m k
  simp only [pellRadicalB, pellRadicalC] at h ⊢
  linarith

/-! ## An actual recurrence showing the coefficient gap -/

/-- A nondegenerate dominant-root recurrence with primitive support eventually
(by Zsigmondy) and no perfect-power terms, but with a built-in cubic carrier.
The external arithmetic facts about its support are proved only in the note. -/
def primitiveDivisorOutputModel (n : ℕ) : ℤ :=
  2 * ((2 : ℤ) ^ n - 1) ^ 3

/-- The model has the four distinct roots `8, 4, 2, 1`. -/
theorem primitiveDivisorOutputModel_recurrence (n : ℕ) :
    primitiveDivisorOutputModel (n + 4) =
      15 * primitiveDivisorOutputModel (n + 3) -
        70 * primitiveDivisorOutputModel (n + 2) +
          120 * primitiveDivisorOutputModel (n + 1) -
            64 * primitiveDivisorOutputModel n := by
  simp only [primitiveDivisorOutputModel, pow_succ]
  ring

/-- Characteristic polynomial of the output model. -/
theorem primitiveDivisorOutputModel_characteristicPolynomial (X : ℤ) :
    (X - 8) * (X - 4) * (X - 2) * (X - 1) =
      X ^ 4 - 15 * X ^ 3 + 70 * X ^ 2 - 120 * X + 64 := by
  ring

/-! ## Exact coefficient obstruction -/

/-- Any theorem that leaves only a subcritical radical budget `known` is
compatible with an excess larger than the abc allowance.  This is the exact
scalar reason that primitive divisors, a sublinear square-free-factor lower
bound, and perfect-power finiteness do not by themselves close the route. -/
theorem pellSquarefull_subcriticalKnownMass_leavesTooMuchExcess
    (source known excess eta : ℝ)
    (hledger : known + excess = 2 * source)
    (hknown : known ≤ (1 - eta) * source) :
    (1 + eta) * source ≤ excess := by
  nlinarith

/-- A strict version: if the presently certified radical mass is strictly
below the critical coefficient, then the compatible excess strictly exceeds
the permitted coefficient. -/
theorem pellSquarefull_strictSubcriticalKnownMass_exceedsAllowance
    (source known excess eta : ℝ)
    (hledger : known + excess = 2 * source)
    (hknown : known < (1 - eta) * source) :
    (1 + eta) * source < excess := by
  nlinarith

end IUTThreeClosures
