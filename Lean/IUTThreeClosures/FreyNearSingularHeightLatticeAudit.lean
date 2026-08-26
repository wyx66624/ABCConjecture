/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreySameCharacterRankTwoObstruction

/-!
# Near-singular displayed Gram matrices are not short-point certificates

This module formalizes the scalar and additive-group core of
`FREY_NEAR_SINGULAR_HEIGHT_LATTICE_AUDIT.md`.

An integral shear replaces a displayed pair `(P, R)` by `(P, N P + R)`.
The displayed real Gram matrix can then have an arbitrarily small Rayleigh
quotient even though the integral coefficient lattice, determinant, and first
integral minimum are unchanged.  Lean also checks the rank-one doubled-orbit,
finite-scale cancellation, and Shioda-ledger scalar identities used in the
paper audit.

No elliptic curve, canonical height, isogeny, elliptic surface, conductor,
field discriminant, Neron model, or abc assertion is modeled here.
-/

namespace IUTThreeClosures

/-! ## Exact integral shear of a binary height form -/

/-- A binary quadratic form in Gram coordinates.  In the companion note the
coefficients are interpreted as two self-pairings and one cross-pairing. -/
def binaryHeightForm (A B C x y : ℝ) : ℝ :=
  A * x ^ 2 + 2 * B * x * y + C * y ^ 2

/-- The first diagonal entry after replacing the second vector by
`N * first + second`. -/
def shearedGramFirst (A : ℝ) : ℝ := A

/-- The cross entry after the same shear. -/
def shearedGramCross (A B N : ℝ) : ℝ := N * A + B

/-- The second diagonal entry after the same shear. -/
def shearedGramSecond (A B C N : ℝ) : ℝ :=
  N ^ 2 * A + 2 * N * B + C

/-- Evaluating the sheared Gram form is exactly the same as applying the
original form after the unimodular coefficient map `(m,n) -> (m+Nn,n)`. -/
theorem shearedGram_quadraticIdentity
    (A B C N m n : ℝ) :
    binaryHeightForm (shearedGramFirst A) (shearedGramCross A B N)
        (shearedGramSecond A B C N) m n =
      binaryHeightForm A B C (m + N * n) n := by
  simp only [binaryHeightForm, shearedGramFirst, shearedGramCross,
    shearedGramSecond]
  ring

/-- A unimodular shear leaves the Gram determinant unchanged. -/
theorem shearedGram_determinantInvariant (A B C N : ℝ) :
    shearedGramFirst A * shearedGramSecond A B C N -
        shearedGramCross A B N ^ 2 =
      A * C - B ^ 2 := by
  simp only [shearedGramFirst, shearedGramCross, shearedGramSecond]
  ring

/-- The inverse coefficient identity for the integral shear. -/
theorem integralShear_leftInverse (N m n : ℤ) :
    (m + N * n) - N * n = m := by
  ring

/-- The forward coefficient identity for the inverse integral shear. -/
theorem integralShear_rightInverse (N u v : ℤ) :
    (u - N * v) + N * v = u := by
  ring

/-- Every coefficient pair in the original basis comes from a coefficient
pair in the sheared basis. -/
theorem integralShear_surjective (N u v : ℤ) :
    ∃ m n : ℤ, m + N * n = u ∧ n = v := by
  exact ⟨u - N * v, v, integralShear_rightInverse N u v, rfl⟩

/-- The integral shear is injective on coefficient pairs. -/
theorem integralShear_injective
    {N m₁ n₁ m₂ n₂ : ℤ}
    (hfirst : m₁ + N * n₁ = m₂ + N * n₂)
    (hsecond : n₁ = n₂) :
    m₁ = m₂ ∧ n₁ = n₂ := by
  subst n₂
  constructor
  · linarith
  · rfl

/-- Values of a binary height form on nonzero integral coefficient vectors.
Equality of these sets is an exact formal surrogate for invariance of the
first integral successive minimum. -/
def nonzeroIntegralBinaryValues (A B C : ℝ) : Set ℝ :=
  {height | ∃ m n : ℤ,
    (m ≠ 0 ∨ n ≠ 0) ∧
      height = binaryHeightForm A B C (m : ℝ) (n : ℝ)}

/-! ## A small real Rayleigh quotient with no short integral vector -/

/-- The orthogonal height form after an integral shear. -/
def orthogonalShearHeight (H : ℝ) (N m n : ℤ) : ℝ :=
  H * (((m + N * n : ℤ) : ℝ) ^ 2 + (n : ℝ) ^ 2)

/-- The long coefficient vector `(-N,1)` merely recovers the old second
vector, so its height numerator is exactly `H`. -/
theorem orthogonalShear_relationVector (H : ℝ) (N : ℤ) :
    orthogonalShearHeight H N (-N) 1 = H := by
  simp [orthogonalShearHeight]

/-- Its exact Rayleigh quotient is `H / (N^2+1)`.  Hence a sequence of large
shears has displayed least eigenvalue at most a quantity tending to zero. -/
theorem orthogonalShear_relationRayleigh (H : ℝ) (N : ℤ) :
    orthogonalShearHeight H N (-N) 1 /
        ((N : ℝ) ^ 2 + 1) =
      H / ((N : ℝ) ^ 2 + 1) := by
  rw [orthogonalShear_relationVector]

/-- A nonzero integral coefficient pair stays nonzero after the shear. -/
theorem integralShear_nonzero
    {N m n : ℤ} (hne : m ≠ 0 ∨ n ≠ 0) :
    m + N * n ≠ 0 ∨ n ≠ 0 := by
  by_cases hn : n = 0
  · left
    subst n
    simpa using hne
  · exact Or.inr hn

/-- The inverse shear also preserves nonzero coefficient vectors. -/
theorem integralUnshear_nonzero
    {N u v : ℤ} (hne : u ≠ 0 ∨ v ≠ 0) :
    u - N * v ≠ 0 ∨ v ≠ 0 := by
  by_cases hv : v = 0
  · left
    subst v
    simpa using hne
  · exact Or.inr hv

/-- The complete set of heights of nonzero integral vectors is invariant
under the shear.  In particular, whenever a first minimum exists, it is
unchanged even though the displayed real least eigenvalue may shrink. -/
theorem shearedGram_nonzeroIntegralValues_eq
    (A B C : ℝ) (N : ℤ) :
    nonzeroIntegralBinaryValues (shearedGramFirst A)
        (shearedGramCross A B (N : ℝ))
        (shearedGramSecond A B C (N : ℝ)) =
      nonzeroIntegralBinaryValues A B C := by
  ext height
  constructor
  · rintro ⟨m, n, hne, rfl⟩
    refine ⟨m + N * n, n, integralShear_nonzero hne, ?_⟩
    rw [shearedGram_quadraticIdentity]
    push_cast
    rfl
  · rintro ⟨u, v, hne, rfl⟩
    refine ⟨u - N * v, v, integralUnshear_nonzero hne, ?_⟩
    rw [shearedGram_quadraticIdentity]
    push_cast
    congr 2
    ring

/-- A nonzero integral pair has squared Euclidean norm at least one after
the shear. -/
theorem one_le_integralShear_sqNorm
    {N m n : ℤ} (hne : m ≠ 0 ∨ n ≠ 0) :
    (1 : ℤ) ≤ (m + N * n) ^ 2 + n ^ 2 := by
  exact int_one_le_sq_add_sq (integralShear_nonzero hne)

/-- Despite the small real Rayleigh quotient, every nonzero integral
combination has height at least `H`. -/
theorem orthogonalShear_noIntegralCancellation
    {H : ℝ} (hH : 0 ≤ H) (N m n : ℤ)
    (hne : m ≠ 0 ∨ n ≠ 0) :
    H ≤ orthogonalShearHeight H N m n := by
  have hsqInt :
      (1 : ℤ) ≤ (m + N * n) ^ 2 + n ^ 2 :=
    one_le_integralShear_sqNorm hne
  have hsq :
      (1 : ℝ) ≤ (((m + N * n : ℤ) : ℝ) ^ 2 + (n : ℝ) ^ 2) := by
    exact_mod_cast hsqInt
  simpa [orthogonalShearHeight] using
    (mul_le_mul_of_nonneg_left hsq hH)

/-- In the orthogonal model the sheared determinant remains exactly `H^2`. -/
theorem orthogonalShear_regulatorInvariant (H N : ℝ) :
    H * (H * (N ^ 2 + 1)) - (H * N) ^ 2 = H ^ 2 := by
  ring

/-! ## The shear does not change an additive subgroup -/

/-- If two points satisfy a chosen additive local condition, so does the
sheared second point.  The paper interprets the subgroup as a Neron identity
component. -/
theorem shearedPoint_mem_addSubgroup
    {G : Type*} [AddCommGroup G] (S : AddSubgroup G)
    {P R : G} (hP : P ∈ S) (hR : R ∈ S) (N : ℤ) :
    N • P + R ∈ S := by
  exact S.add_mem (S.zsmul_mem hP N) hR

/-- Conversely, the old second point is recovered from the sheared pair
inside every additive subgroup. -/
theorem unshearedPoint_mem_addSubgroup
    {G : Type*} [AddCommGroup G] (S : AddSubgroup G)
    {P Q : G} (hP : P ∈ S) (hQ : Q ∈ S) (N : ℤ) :
    Q - N • P ∈ S := by
  exact S.sub_mem hQ (S.zsmul_mem hP N)

/-! ## Rank-one isogeny-orbit scalar audit -/

/-- The scalar height form of the displayed pair `(P, [2]P)`. -/
def doubledOrbitHeight (H : ℝ) (m n : ℤ) : ℝ :=
  H * ((m : ℝ) + 2 * (n : ℝ)) ^ 2

/-- The Gram determinant of `(P,[2]P)` is zero. -/
theorem doubledOrbit_gramDeterminant (H : ℝ) :
    H * (4 * H) - (2 * H) ^ 2 = 0 := by
  ring

/-- The coefficient relation `-2 P + [2]P` has zero scalar height. -/
theorem doubledOrbit_integralRelation (H : ℝ) :
    doubledOrbitHeight H (-2) 1 = 0 := by
  norm_num [doubledOrbitHeight]

/-- Transporting a whole Gram form through a degree-two isogeny only applies
a common scalar factor. -/
theorem degreeTwoTransport_binaryHeight
    (A B C x y : ℝ) :
    binaryHeightForm (2 * A) (2 * B) (2 * C) x y =
      2 * binaryHeightForm A B C x y := by
  simp only [binaryHeightForm]
  ring

/-! ## Fixed finite base-change and Shioda-ledger scalar cores -/

/-- A common nonzero finite-base-change scale cancels from a normalized
height/source ratio. -/
theorem commonBaseChangeScale_cancels
    {d H L : ℝ} (hd : d ≠ 0) (hL : L ≠ 0) :
    (d * H) / (d * L) = H / L := by
  field_simp

/-- If a Shioda self-height is small, then the auxiliary component
correction must nearly pay the full `2 chi` baseline. -/
theorem shioda_smallHeight_requiresAuxCorrection
    {height chi intersection correction ε : ℝ}
    (hformula : height = 2 * chi + 2 * intersection - correction)
    (hintersection : 0 ≤ intersection)
    (hsmall : height ≤ ε) :
    2 * chi - ε ≤ correction := by
  linarith

/-- For semistable multiplicative fibers, the bound
`correction <= auxiliaryDiscriminantDegree / 4` gives the displayed lower
height ledger. -/
theorem shioda_semistableTargetIdentity_lower
    {height chi intersection correction auxiliaryDegree : ℝ}
    (hformula : height = 2 * chi + 2 * intersection - correction)
    (hintersection : 0 ≤ intersection)
    (hcorrection : correction ≤ auxiliaryDegree / 4) :
    2 * chi - auxiliaryDegree / 4 ≤ height := by
  linarith

/-- Rewriting the preceding ledger with total discriminant degree
`totalDegree = 12 chi` and `auxiliary = total - target`. -/
theorem shioda_targetDegree_lower
    {height chi intersection correction totalDegree targetDegree : ℝ}
    (hformula : height = 2 * chi + 2 * intersection - correction)
    (hintersection : 0 ≤ intersection)
    (htotal : totalDegree = 12 * chi)
    (hcorrection : correction ≤ (totalDegree - targetDegree) / 4) :
    targetDegree / 4 - totalDegree / 12 ≤ height := by
  rw [htotal] at hcorrection ⊢
  linarith

/-- A narrow section has no component correction, leaving the entire
`2 chi` baseline (and any nonnegative zero-section intersection). -/
theorem shioda_narrowSection_lower
    {height chi intersection : ℝ}
    (hformula : height = 2 * chi + 2 * intersection)
    (hintersection : 0 ≤ intersection) :
    2 * chi ≤ height := by
  linarith

end IUTThreeClosures
