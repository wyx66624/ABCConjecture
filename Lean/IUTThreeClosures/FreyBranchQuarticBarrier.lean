/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.HigherCongruenceDepthBarrier

/-!
# The Frey branch quartic and the reduced-boundary barrier

For the four branch points `infinity, 0, a, -b`, the binary quartic

`Z * X * (X - a * Z) * (X + b * Z)`

has classical invariants

`I = a^2 + a*b + b^2`,
`J = (a-b)(2a+b)(a+2b)`,

and branch discriminant `a^2*b^2*(a+b)^2`.  This file formalizes those
universal polynomial identities, the three cross-ratio cusp parameters,
the primitivity of `I` along a primitive `abc` boundary, an exact
coefficient-conservation family, and a fixed-prime obstruction to replacing
boundary contact multiplicity by reduced support.

The file does not formalize binary-form GIT, integral orbit minimization,
stable marked curves, cluster pictures, Arakelov intersection theory,
Szpiro, or abc.  In particular, the scalar rescaling theorem below is only
the invariant-weight shadow of a change of binary-quartic coordinates; no
`GL_2` action or minimal-model theorem is hidden in the definitions.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## Classical binary-quartic invariants -/

/-- The classical degree-two invariant of an unscaled binary quartic
`A*X^4 + B*X^3*Z + C*X^2*Z^2 + D*X*Z^3 + E*Z^4`. -/
def binaryQuarticI {R : Type*} [CommRing R]
    (A B C D E : R) : R :=
  12 * A * E - 3 * B * D + C ^ 2

/-- The classical degree-three invariant in the same coefficient
convention. -/
def binaryQuarticJ {R : Type*} [CommRing R]
    (A B C D E : R) : R :=
  72 * A * C * E - 27 * A * D ^ 2 - 27 * B ^ 2 * E +
    9 * B * C * D - 2 * C ^ 3

/-- The `I` invariant of the Frey branch quartic. -/
def freyBranchQuarticI {R : Type*} [CommRing R] (a b : R) : R :=
  a ^ 2 + a * b + b ^ 2

/-- The `J` invariant of the Frey branch quartic. -/
def freyBranchQuarticJ {R : Type*} [CommRing R] (a b : R) : R :=
  (a - b) * (2 * a + b) * (a + 2 * b)

/-- The determinant-product discriminant of the four branch lines.  This is
the usual binary-quartic discriminant, not the discriminant of the genus-one
double cover (which has one additional factor `16`). -/
def freyBranchQuarticDiscriminant {R : Type*} [CommRing R]
    (a b : R) : R :=
  (a * b * (a + b)) ^ 2

/-- Expanding `Z*X*(X-aZ)*(X+bZ)` gives coefficient tuple
`(0, 1, b-a, -ab, 0)`, whose classical `I` is the displayed quadratic. -/
theorem binaryQuarticI_frey_coefficients
    {R : Type*} [CommRing R] (a b : R) :
    binaryQuarticI (0 : R) 1 (b - a) (-a * b) 0 =
      freyBranchQuarticI a b := by
  simp [binaryQuarticI, freyBranchQuarticI]
  ring

/-- The corresponding exact `J` calculation. -/
theorem binaryQuarticJ_frey_coefficients
    {R : Type*} [CommRing R] (a b : R) :
    binaryQuarticJ (0 : R) 1 (b - a) (-a * b) 0 =
      freyBranchQuarticJ a b := by
  simp [binaryQuarticJ, freyBranchQuarticJ]
  ring

/-- The invariant identity for the four Frey branch points. -/
theorem freyBranchQuartic_invariant_discriminant_identity
    {R : Type*} [CommRing R] (a b : R) :
    4 * freyBranchQuarticI a b ^ 3 -
        freyBranchQuarticJ a b ^ 2 =
      27 * freyBranchQuarticDiscriminant a b := by
  simp [freyBranchQuarticI, freyBranchQuarticJ,
    freyBranchQuarticDiscriminant]
  ring

/-- The weighted rescaling law underlying the invariant-theoretic change of
coordinates: weights `2`, `3`, and `6` conserve the discriminant relation. -/
theorem binaryQuartic_weighted_rescaling
    {R : Type*} [CommRing R] (u I J : R) :
    4 * (u ^ 2 * I) ^ 3 - (u ^ 3 * J) ^ 2 =
      u ^ 6 * (4 * I ^ 3 - J ^ 2) := by
  ring

/-! ## The three marked boundary parameters -/

/-- With the ordering `(infinity, 0; a, -b)`, use the cross-ratio
`lambda = -b/a`. -/
def freyBranchCrossRatio {K : Type*} [Field K] (a b : K) : K :=
  -b / a

/-- The cusp at which `b` vanishes is measured by `lambda`. -/
theorem freyBranchCrossRatio_eq_neg_div
    {K : Type*} [Field K] (a b : K) :
    freyBranchCrossRatio a b = -b / a := rfl

/-- The cusp at which `a+b` vanishes is measured by `1-lambda`. -/
theorem one_sub_freyBranchCrossRatio
    {K : Type*} [Field K] {a b : K} (ha : a ≠ 0) :
    1 - freyBranchCrossRatio a b = (a + b) / a := by
  simp [freyBranchCrossRatio, div_eq_mul_inv]
  field_simp

/-- The cusp at which `a` vanishes is measured by `1/lambda`. -/
theorem freyBranchCrossRatio_inv
    {K : Type*} [Field K] (a b : K) :
    (freyBranchCrossRatio a b)⁻¹ = -a / b := by
  simp [freyBranchCrossRatio, div_eq_mul_inv]

/-! ## Primitive arithmetic and invariant height -/

/-- The nonnegative integral version of the Frey quartic `I` invariant. -/
def freyBranchQuarticINat (a b : ℕ) : ℕ :=
  a ^ 2 + a * b + b ^ 2

/-- The nonnegative branch discriminant. -/
def freyBranchQuarticDiscriminantNat (a b : ℕ) : ℕ :=
  (a * b * (a + b)) ^ 2

/-- `I` is coprime to the first endpoint of a primitive pair. -/
theorem freyBranchQuarticINat_coprime_left
    {a b : ℕ} (hab : Nat.Coprime a b) :
    Nat.Coprime (freyBranchQuarticINat a b) a := by
  rw [Nat.coprime_comm]
  simp only [freyBranchQuarticINat]
  rw [show a ^ 2 + a * b + b ^ 2 = b ^ 2 + a * (a + b) by ring]
  simpa using hab.pow_right 2

/-- `I` is coprime to the second endpoint of a primitive pair. -/
theorem freyBranchQuarticINat_coprime_right
    {a b : ℕ} (hab : Nat.Coprime a b) :
    Nat.Coprime (freyBranchQuarticINat a b) b := by
  simp only [freyBranchQuarticINat]
  rw [show a ^ 2 + a * b + b ^ 2 = a ^ 2 + b * (a + b) by ring]
  simpa using hab.pow_left 2

/-- `I` is also coprime to the third branch difference `a+b`. -/
theorem freyBranchQuarticINat_coprime_sum
    {a b : ℕ} (hab : Nat.Coprime a b) :
    Nat.Coprime (freyBranchQuarticINat a b) (a + b) := by
  rw [Nat.coprime_comm]
  simp only [freyBranchQuarticINat]
  rw [show a ^ 2 + a * b + b ^ 2 = b ^ 2 + a * (a + b) by ring]
  rw [Nat.coprime_add_mul_right_right]
  simpa using (Nat.coprime_add_self_left.mpr hab).pow_right 2

/-- Hence a primitive Frey quartic has `I` a unit at every prime in its
branch discriminant.  High bad-prime multiplicity is cancellation in
`4*I^3-J^2`, not removable common content of the invariants. -/
theorem freyBranchQuarticINat_coprime_branchProduct
    {a b : ℕ} (hab : Nat.Coprime a b) :
    Nat.Coprime (freyBranchQuarticINat a b) (a * b * (a + b)) := by
  exact ((freyBranchQuarticINat_coprime_left hab).mul_right
    (freyBranchQuarticINat_coprime_right hab)).mul_right
      (freyBranchQuarticINat_coprime_sum hab)

/-- A first exact comparison with the abc height. -/
theorem freyBranchQuarticINat_add_product
    (a b : ℕ) :
    freyBranchQuarticINat a b + a * b = (a + b) ^ 2 := by
  simp [freyBranchQuarticINat]
  ring

/-- Over the integers, the lower height comparison has an exact square
remainder: `4I = 3(a+b)^2 + (a-b)^2`. -/
theorem four_freyBranchQuarticI_eq_three_sum_sq_add_difference_sq
    (a b : ℤ) :
    4 * freyBranchQuarticI a b =
      3 * (a + b) ^ 2 + (a - b) ^ 2 := by
  simp [freyBranchQuarticI]
  ring

/-- In particular the integral `I` invariant never exceeds the squared
elementary height `(a+b)^2`. -/
theorem freyBranchQuarticINat_le_sum_sq (a b : ℕ) :
    freyBranchQuarticINat a b ≤ (a + b) ^ 2 := by
  rw [← freyBranchQuarticINat_add_product]
  exact Nat.le_add_right _ _

/-! ## A strict coefficient-conservation family -/

/-- On adjacent primitive endpoints, write `A=n(n+1)`.  Then `I=3A+1`. -/
theorem adjacent_freyBranchQuarticINat (n : ℕ) :
    freyBranchQuarticINat n (n + 1) = 3 * (n * (n + 1)) + 1 := by
  simp [freyBranchQuarticINat]
  ring

/-- The same family has branch discriminant `A^2(4A+1)`. -/
theorem adjacent_freyBranchQuarticDiscriminantNat (n : ℕ) :
    freyBranchQuarticDiscriminantNat n (n + 1) =
      (n * (n + 1)) ^ 2 * (4 * (n * (n + 1)) + 1) := by
  simp [freyBranchQuarticDiscriminantNat]
  ring

/-- The invariant scale cannot save a positive logarithmic coefficient:
along the adjacent primitive family, `I^3` and the branch discriminant stay
within the fixed factor `16`. -/
theorem adjacent_invariant_discriminant_within_sixteen
    {n : ℕ} (hn : 0 < n) :
    freyBranchQuarticDiscriminantNat n (n + 1) ≤
        freyBranchQuarticINat n (n + 1) ^ 3 ∧
      freyBranchQuarticINat n (n + 1) ^ 3 ≤
        16 * freyBranchQuarticDiscriminantNat n (n + 1) := by
  let A := n * (n + 1)
  have hA : 1 ≤ A := by
    dsimp [A]
    nlinarith
  rw [adjacent_freyBranchQuarticINat,
    adjacent_freyBranchQuarticDiscriminantNat]
  change A ^ 2 * (4 * A + 1) ≤ (3 * A + 1) ^ 3 ∧
    (3 * A + 1) ^ 3 ≤ 16 * (A ^ 2 * (4 * A + 1))
  constructor
  · nlinarith [Nat.zero_le (23 * A ^ 3 + 26 * A ^ 2 + 9 * A + 1)]
  · have hnonneg :
        0 ≤ (A - 1) * (37 * A ^ 2 + 26 * A + 17) := Nat.zero_le _
    have hsub : A - 1 + 1 = A := by omega
    nlinarith

/-! ## Exact local multiplicity and the reduced-boundary no-go -/

/-- The branch discriminant exponent is twice the exponent of the product of
the three branch differences. -/
theorem freyBranchQuarticDiscriminantNat_factorization
    {a b p : ℕ} (ha : a ≠ 0) (hb : b ≠ 0) :
    (freyBranchQuarticDiscriminantNat a b).factorization p =
      2 * (a * b * (a + b)).factorization p := by
  have hsum : a + b ≠ 0 := by omega
  have hprod : a * b * (a + b) ≠ 0 :=
    mul_ne_zero (mul_ne_zero ha hb) hsum
  simp only [freyBranchQuarticDiscriminantNat]
  rw [Nat.factorization_pow]
  simp

/-- In the actual primitive family `(3^(m+1),2,3^(m+1)+2)`, the branch
discriminant has exponent `2(m+1)` at the same fixed prime `3`. -/
theorem nonsplitThreeFreyPoint_branchDiscriminant_factorization_three
    (m : ℕ) :
    (freyBranchQuarticDiscriminantNat
      (nonsplitThreeFreyPoint m).a
      (nonsplitThreeFreyPoint m).b).factorization 3 = 2 * (m + 1) := by
  rw [freyBranchQuarticDiscriminantNat_factorization
    (nonsplitThreeFreyPoint m).a_pos.ne'
    (nonsplitThreeFreyPoint m).b_pos.ne',
    (nonsplitThreeFreyPoint m).sum_eq,
    nonsplitThreeFreyPoint_abc_factorization_three]

/-- Half the branch-discriminant exponent, after removing its one reduced
boundary copy, is exactly `m` in the fixed-prime family. -/
theorem nonsplitThreeFreyPoint_branchContactExcess_three
    (m : ℕ) :
    (freyBranchQuarticDiscriminantNat
        (nonsplitThreeFreyPoint m).a
        (nonsplitThreeFreyPoint m).b).factorization 3 / 2 - 1 = m := by
  rw [nonsplitThreeFreyPoint_branchDiscriminant_factorization_three]
  omega

/-- The full local contact is unbounded although the reduced boundary at the
fixed prime has multiplicity one. -/
theorem no_local_reducedBoundaryMultiplicity_branchContact_bound
    (F : ℕ → ℕ) :
    ∃ m : ℕ,
      F 1 <
        (freyBranchQuarticDiscriminantNat
          (nonsplitThreeFreyPoint m).a
          (nonsplitThreeFreyPoint m).b).factorization 3 := by
  refine ⟨F 1, ?_⟩
  rw [nonsplitThreeFreyPoint_branchDiscriminant_factorization_three]
  omega

/-- The sharper powerful-excess form of the same obstruction: even after
halving the discriminant contact and removing the reduced copy, the local
excess is unbounded while the reduced multiplicity stays one. -/
theorem no_local_reducedBoundaryMultiplicity_branchExcess_bound
    (F : ℕ → ℕ) :
    ∃ m : ℕ,
      F 1 <
        (freyBranchQuarticDiscriminantNat
            (nonsplitThreeFreyPoint m).a
            (nonsplitThreeFreyPoint m).b).factorization 3 / 2 - 1 := by
  refine ⟨F 1 + 1, ?_⟩
  rw [nonsplitThreeFreyPoint_branchContactExcess_three]
  omega

/-! ## The exact global scalar boundary -/

/-- If total boundary contact is radical contact plus exponent excess, then
a radical upper bound for the excess is exactly the slope-six upper bound
for the branch discriminant degree.  Neither inequality is proved here. -/
theorem branchQuartic_slopeSix_iff_exponentExcess_upper
    {total radical excess eps C : ℝ}
    (hsplit : total = radical + excess) :
    2 * total ≤ (6 + eps) * radical + 2 * C ↔
      excess ≤ (2 + eps / 2) * radical + C := by
  rw [hsplit]
  constructor <;> intro h <;> linarith

end

end IUTThreeClosures
