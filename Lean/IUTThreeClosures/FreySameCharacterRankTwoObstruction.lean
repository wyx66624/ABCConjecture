/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.WeightedPoitouTateSelectorAudit

/-!
# Two points in one quadratic-character space

This module checks the algebraic core of the companion note
`FREY_SAME_CHARACTER_RANK_TWO_OBSTRUCTION.md`.

For the Frey cubic `f(x) = x * (x - a) * (x + b)`, the
Rubin--Silverberg rational-two-torsion construction specializes to two
abscissas whose cubic values have the same square class.  Lean verifies the
two point identities, the exact carrier factorization, and the collision at
the displayed specializations which remove the two large linear carrier
factors.

Lean also verifies the elementary Pell-family identities and the abstract
subgroup and quadratic-form statements used in the local and global ledgers.
It does **not** model elliptic surfaces, Shioda pairings, Neron local heights,
conductors, or specialization of canonical heights.  Those inputs are marked
paper-only in the companion note.
-/

namespace IUTThreeClosures

/-! ## A direct Rubin--Silverberg specialization -/

/-- The first abscissa in the same-character pair. -/
noncomputable def freyRankTwoXOne (a b v : ℝ) : ℝ :=
  a * b * (1 + v ^ 2) / (b - a)

/-- The second abscissa.  The hypotheses used below always exclude `v = 0`. -/
noncomputable def freyRankTwoXTwo (a b v : ℝ) : ℝ :=
  freyRankTwoXOne a b v / v ^ 2

/-- A rational carrier for the common square class of the two cubic values. -/
def freyRankTwoCarrier (a b v : ℝ) : ℝ :=
  (b - a) * (1 + v ^ 2) * (a + b * v ^ 2) * (b + a * v ^ 2)


/-- The first cubic value is the carrier times an explicit square. -/
theorem freyRankTwo_firstRadicand
    {a b v : ℝ} (hba : b - a ≠ 0) :
    let x := freyRankTwoXOne a b v
    x * (x - a) * (x + b) =
      freyRankTwoCarrier a b v * (a * b / (b - a) ^ 2) ^ 2 := by
  dsimp [freyRankTwoXOne, freyRankTwoCarrier]
  field_simp [hba]
  ring

/-- The second cubic value is the same carrier times another explicit square. -/
theorem freyRankTwo_secondRadicand
    {a b v : ℝ} (hba : b - a ≠ 0) (hv : v ≠ 0) :
    let x := freyRankTwoXTwo a b v
    x * (x - a) * (x + b) =
      freyRankTwoCarrier a b v *
        (a * b / ((b - a) ^ 2 * v ^ 3)) ^ 2 := by
  dsimp [freyRankTwoXTwo, freyRankTwoXOne, freyRankTwoCarrier]
  field_simp [hba, hv]
  ring

/-- Equivalently, the ratio of the two cubic values is the square `v⁻⁶`. -/
theorem freyRankTwo_squareRatio
    {a b v : ℝ} (hba : b - a ≠ 0) (hv : v ≠ 0) :
    let x₁ := freyRankTwoXOne a b v
    let x₂ := freyRankTwoXTwo a b v
    x₂ * (x₂ - a) * (x₂ + b) =
      (x₁ * (x₁ - a) * (x₁ + b)) / v ^ 6 := by
  dsimp [freyRankTwoXTwo, freyRankTwoXOne]
  field_simp [hba, hv]
  ring


/-- The coefficient identity which turns the Rubin--Silverberg degree-six
twist polynomial into the direct same-character carrier after `u = Bv`. -/
theorem rubinSilverberg_scaled_factorization (A B v : ℝ) :
    -A * B * ((B * v) ^ 2 + B ^ 2) *
        ((B * v) ^ 4 + 2 * B ^ 2 * (B * v) ^ 2 -
          A ^ 2 * B * (B * v) ^ 2 + B ^ 4) =
      -A * B ^ 6 * (1 + v ^ 2) *
        (B * (1 + v ^ 2) ^ 2 - A ^ 2 * v ^ 2) := by
  ring

/-- The special Frey relation behind the carrier factorization. -/
theorem freyRankTwo_middleFactor (a b v : ℝ) :
    (b - a) ^ 2 * v ^ 2 - (-a * b) * (1 + v ^ 2) ^ 2 =
      (a + b * v ^ 2) * (b + a * v ^ 2) := by
  ring

/-- Exact specialization of the Rubin--Silverberg polynomial.  Its value is
the sixth power `(-ab)⁶` times the direct carrier, so both define the same
quadratic twist. -/
theorem rubinSilverberg_freyCarrier (a b v : ℝ) :
    -(b - a) * (-a * b) * (((-a * b) * v) ^ 2 + (-a * b) ^ 2) *
        (((-a * b) * v) ^ 4 +
          2 * (-a * b) ^ 2 * ((-a * b) * v) ^ 2 -
          (b - a) ^ 2 * (-a * b) * ((-a * b) * v) ^ 2 +
          (-a * b) ^ 4) =
      (-a * b) ^ 6 * freyRankTwoCarrier a b v := by
  calc
    -(b - a) * (-a * b) * (((-a * b) * v) ^ 2 + (-a * b) ^ 2) *
          (((-a * b) * v) ^ 4 +
            2 * (-a * b) ^ 2 * ((-a * b) * v) ^ 2 -
            (b - a) ^ 2 * (-a * b) * ((-a * b) * v) ^ 2 +
            (-a * b) ^ 4) =
        -(b - a) * (-a * b) ^ 6 * (1 + v ^ 2) *
          ((-a * b) * (1 + v ^ 2) ^ 2 - (b - a) ^ 2 * v ^ 2) :=
      rubinSilverberg_scaled_factorization (b - a) (-a * b) v
    _ = (-a * b) ^ 6 * freyRankTwoCarrier a b v := by
      have hmid :
          (-a * b) * (1 + v ^ 2) ^ 2 - (b - a) ^ 2 * v ^ 2 =
            -((a + b * v ^ 2) * (b + a * v ^ 2)) := by
        calc
          (-a * b) * (1 + v ^ 2) ^ 2 - (b - a) ^ 2 * v ^ 2 =
              -((b - a) ^ 2 * v ^ 2 -
                (-a * b) * (1 + v ^ 2) ^ 2) := by ring
          _ = -((a + b * v ^ 2) * (b + a * v ^ 2)) := by
            rw [freyRankTwo_middleFactor]
      rw [hmid]
      dsimp [freyRankTwoCarrier]
      ring


/-- At `v = 1` the nominal two points collide. -/
theorem freyRankTwo_collision_one (a b : ℝ) :
    freyRankTwoXTwo a b 1 = freyRankTwoXOne a b 1 := by
  simp [freyRankTwoXTwo]

/-- At `v = -1` their abscissas also collide (their ordinates have opposite
sign in the explicit pair). -/
theorem freyRankTwo_collision_negOne (a b : ℝ) :
    freyRankTwoXTwo a b (-1) = freyRankTwoXOne a b (-1) := by
  simp [freyRankTwoXTwo]

/-- The cheap carrier at the collision is `2 (b-a) (a+b)²`. -/
theorem freyRankTwoCarrier_at_one (a b : ℝ) :
    freyRankTwoCarrier a b 1 = 2 * (b - a) * (a + b) ^ 2 := by
  simp [freyRankTwoCarrier]
  ring

/-- Clearing the denominator of `v = p/q` produces the integral cubic
carrier used for the conductor audit. -/
theorem freyRankTwoCarrier_clearDenominator
    {a b p q : ℝ} (hq : q ≠ 0) :
    q ^ 6 * freyRankTwoCarrier a b (p / q) =
      (b - a) * (p ^ 2 + q ^ 2) *
        (q ^ 2 * a + p ^ 2 * b) * (q ^ 2 * b + p ^ 2 * a) := by
  dsimp [freyRankTwoCarrier]
  field_simp [hq]
  ring

/-- On the diagonal `p=q`, the two large linear factors become the square
`p⁴(a+b)²`; this is exactly the collision specialization. -/
theorem freyRankTwo_integralCarrier_diagonal (a b p : ℤ) :
    (b - a) * (p ^ 2 + p ^ 2) *
        (p ^ 2 * a + p ^ 2 * b) * (p ^ 2 * b + p ^ 2 * a) =
      2 * p ^ 6 * (b - a) * (a + b) ^ 2 := by
  ring


/-! ## A strict Pell subfamily with a fixed common twist -/

/-- The first fixed abscissa has square class `6` on `b=3r²-2`. -/
theorem pellFrey_firstRadicand (r : ℤ) :
    let b := 3 * r ^ 2 - 2
    (2 : ℤ) * (2 - 1) * (2 + b) = 6 * r ^ 2 := by
  dsimp
  ring

/-- The second fixed abscissa has the same square class under the Pell
relation `s²-3r²=1`. -/
theorem pellFrey_secondRadicand
    {r s : ℤ} (hpell : s ^ 2 - 3 * r ^ 2 = 1) :
    let b := 3 * r ^ 2 - 2
    (3 : ℤ) * (3 - 1) * (3 + b) = 6 * s ^ 2 := by
  dsimp
  nlinarith

/-- The corresponding first rational point lies on the integral `6`-twist. -/
theorem pellFrey_firstTwistPoint (r : ℤ) :
    let b := 3 * r ^ 2 - 2
    (36 * r) ^ 2 = (12 : ℤ) * (12 - 6) * (12 + 6 * b) := by
  dsimp
  ring

/-- The corresponding second rational point lies on the same integral
`6`-twist. -/
theorem pellFrey_secondTwistPoint
    {r s : ℤ} (hpell : s ^ 2 - 3 * r ^ 2 = 1) :
    let b := 3 * r ^ 2 - 2
    (36 * s) ^ 2 = (18 : ℤ) * (18 - 6) * (18 + 6 * b) := by
  dsimp
  nlinarith

/-- The two addition-law abscissa numerators used as a degree check. -/
theorem pellFrey_sumSlopeIdentity
    {r s : ℤ} (hpell : s ^ 2 - 3 * r ^ 2 = 1) :
    let b := 3 * r ^ 2 - 2
    6 * (s - r) ^ 2 - b - 4 = 21 * r ^ 2 + 4 - 12 * r * s := by
  dsimp
  nlinarith

theorem pellFrey_differenceSlopeIdentity
    {r s : ℤ} (hpell : s ^ 2 - 3 * r ^ 2 = 1) :
    let b := 3 * r ^ 2 - 2
    6 * (s + r) ^ 2 - b - 4 = 21 * r ^ 2 + 4 + 12 * r * s := by
  dsimp
  nlinarith

/-- The standard rational parametrization sends a second Pell solution to
one on `s²-3r²=1`. -/
theorem pellFrey_doubleParametrization
    {p q : ℤ} (hpell : q ^ 2 - 3 * p ^ 2 = 1) :
    (q ^ 2 + 3 * p ^ 2) ^ 2 - 3 * (2 * p * q) ^ 2 = 1 := by
  calc
    (q ^ 2 + 3 * p ^ 2) ^ 2 - 3 * (2 * p * q) ^ 2 =
        (q ^ 2 - 3 * p ^ 2) ^ 2 := by ring
    _ = 1 := by rw [hpell]; norm_num


/-! ## Formal scalar and subgroup consequences of the paper-only ledgers -/

/-- Membership in an identity-component subgroup is retained by every
integer linear combination. -/
theorem integerCombination_mem_addSubgroup
    {G : Type*} [AddCommGroup G] (S : AddSubgroup G)
    {P Q : G} (hP : P ∈ S) (hQ : Q ∈ S) (m n : ℤ) :
    m • P + n • Q ∈ S := by
  exact S.add_mem (S.zsmul_mem hP m) (S.zsmul_mem hQ n)

/-- A nonzero integral coefficient vector has squared Euclidean norm at
least one. -/
theorem int_one_le_sq_add_sq
    {m n : ℤ} (hne : m ≠ 0 ∨ n ≠ 0) :
    (1 : ℤ) ≤ m ^ 2 + n ^ 2 := by
  have hpos : (0 : ℤ) < m ^ 2 + n ^ 2 := by
    rcases hne with hm | hn
    · exact add_pos_of_pos_of_nonneg (sq_pos_of_ne_zero hm) (sq_nonneg n)
    · exact add_pos_of_nonneg_of_pos (sq_nonneg m) (sq_pos_of_ne_zero hn)
  omega


/-- An exact orthogonal height Gram matrix admits no integral cancellation. -/
theorem orthogonalGram_noCancellation
    {H : ℝ} (hH : 0 ≤ H) {m n : ℤ} (hne : m ≠ 0 ∨ n ≠ 0) :
    H ≤ H * (m : ℝ) ^ 2 + H * (n : ℝ) ^ 2 := by
  have hsInt : (1 : ℤ) ≤ m ^ 2 + n ^ 2 := int_one_le_sq_add_sq hne
  have hs : (1 : ℝ) ≤ (m : ℝ) ^ 2 + (n : ℝ) ^ 2 := by
    exact_mod_cast hsInt
  have hmul := mul_le_mul_of_nonneg_left hs hH
  nlinarith

/-- The fixed-abscissa component baseline and archimedean correction again
sum to the canonical coefficient `1/4`. -/
theorem sameCharacter_criticalLedger (logScale : ℝ) :
    logScale / 3 - logScale / 12 = logScale / 4 := by
  ring

end IUTThreeClosures
