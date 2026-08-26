import IUTThreeClosures.FreyPellChebyshevPrimeIndexUniformGenusAudit

/-!
# Prime-index local permutation barrier: scalar kernel

This file checks the elementary algebra and the exact integer-power threshold
in the companion note
FREY_PELL_CHEBYSHEV_PRIME_INDEX_LOCAL_PERMUTATION_BARRIER.md.

It does not formalize Dickson's finite-field permutation theorem, Hensel's
lemma, Dirichlet's theorem, the Chinese remainder theorem, Chebyshev
convexity, squarefree kernels, quadratic fields, fundamental units, modularity,
or the external PARI calculation.  In particular, it does not assert an
unconditional exclusion of prime indices at least eleven.
-/

namespace IUTThreeClosures

/-! ## The nondegenerate fixed-prime local block -/

/-- The scalar reconstruction used after choosing a finite-field preimage
of 5 under the odd Chebyshev polynomial.  The two half-angle identities and
U = F*G recover both neighboring kernels, the norm-one equation, and the
radical coefficient 2 of the complete local unit power. -/
theorem pellPrimeLocal_halfAngleReconstruction
    {K : Type*} [Field K]
    (t F G U : K)
    (hF : (t - 1) * F ^ 2 = 4)
    (hG : (t + 1) * G ^ 2 = 6)
    (hU : U = F * G)
    (hFne : F ≠ 0)
    (hGne : G ≠ 0) :
    let x := 2 / F
    let y := 1 / G
    t - 1 = x ^ 2 ∧
      t + 1 = 6 * y ^ 2 ∧
      t ^ 2 - 6 * (x * y) ^ 2 = 1 ∧
      x * y * U = 2 := by
  dsimp
  have hx : t - 1 = (2 / F) ^ 2 := by
    field_simp [hFne]
    convert hF using 1
    norm_num
  have hy : t + 1 = 6 * (1 / G) ^ 2 := by
    field_simp [hGne]
    exact hG
  refine ⟨hx, hy, ?_, ?_⟩
  · calc
      t ^ 2 - 6 * ((2 / F) * (1 / G)) ^ 2
          = (t - 1) * (t + 1) -
              6 * ((2 / F) * (1 / G)) ^ 2 + 1 := by ring
      _ = (2 / F) ^ 2 * (6 * (1 / G) ^ 2) -
              6 * ((2 / F) * (1 / G)) ^ 2 + 1 := by rw [hx, hy]
      _ = 1 := by ring
  · rw [hU]
    field_simp [hFne, hGne]

/-- The fixed local four-consecutive block used in the permutation
construction is exact over the integers. -/
theorem pellPrimeLocal_blockOne :
    let b : ℤ := 1
    let A : ℤ := 1
    let B : ℤ := 2
    let u : ℤ := 1
    let v : ℤ := 1
    let r : ℤ := 1
    let s : ℤ := 2
    let D : ℤ := 6
    let Z : ℤ := 5
    b = A * u ^ 2 ∧
      b + 1 = B * v ^ 2 ∧
      b + 2 = 3 * r ^ 2 ∧
      b + 3 = s ^ 2 ∧
      D = 3 * A * B ∧
      Z = b ^ 2 + 3 * b + 1 ∧
      u * v * r * s = 2 := by
  norm_num

/-- Once the characteristic, and both half-angle factors, are nonzero, the
Chebyshev derivative factor p*F*G is nonzero.  Hensel's lemma itself remains
an external accepted theorem. -/
theorem pellPrimeLocal_derivativeFactor_ne_zero
    {K : Type*} [Field K]
    (pScalar F G : K)
    (hp : pScalar ≠ 0)
    (hF : F ≠ 0)
    (hG : G ≠ 0) :
    pScalar * F * G ≠ 0 :=
  mul_ne_zero (mul_ne_zero hp hF) hG

/-! ## The exact branches at two and three -/

/-- The common 2-adic/3-adic branch satisfies all scalar block, kernel,
norm, and radical-coefficient equations.  Its signed residues are local
data; this theorem makes no positivity assertion. -/
theorem pellPrimeLocal_smallPrimeBranch :
    let t : ℤ := -1
    let b : ℤ := -2
    let A : ℤ := -2
    let B : ℤ := -1
    let u : ℤ := 1
    let v : ℤ := 1
    let r : ℤ := 0
    let s : ℤ := 1
    let x : ℤ := 1
    let y : ℤ := 0
    let D : ℤ := 6
    let Z : ℤ := -1
    b = A * u ^ 2 ∧
      b + 1 = B * v ^ 2 ∧
      b + 2 = 3 * r ^ 2 ∧
      b + 3 = s ^ 2 ∧
      D = 3 * A * B ∧
      t - 1 = A * x ^ 2 ∧
      t + 1 = 3 * B * y ^ 2 ∧
      t ^ 2 - D * (x * y) ^ 2 = 1 ∧
      Z = b ^ 2 + 3 * b + 1 ∧
      x * y = u * v * r * s := by
  norm_num

/-- The scalar unit coordinate of the small-prime branch is stable under
every positive odd power. -/
theorem pellPrimeLocal_minusOne_oddPow (m : ℕ) :
    (-1 : ℤ) ^ (2 * m + 1) = -1 := by
  simp [pow_add]

/-! ## The exact 4/11 threshold -/

/-- The natural-number form of the global size argument.  The hypotheses
are precisely D+1 <= T^2 and T^p <= Z.  For p >= 11 they imply the
integer certificate (D+1)^11 <= Z^2, without real roots or asymptotics. -/
theorem pellPrimeLocal_elevenThreshold
    (D T Z p : ℕ)
    (hcoordinate : D + 1 ≤ T ^ 2)
    (hchebyshev : T ^ p ≤ Z)
    (hp : 11 ≤ p) :
    (D + 1) ^ 11 ≤ Z ^ 2 := by
  have hraise : (D + 1) ^ p ≤ (T ^ 2) ^ p :=
    Nat.pow_le_pow_left hcoordinate p
  have hmiddle : (T ^ 2) ^ p = (T ^ p) ^ 2 := by
    simp only [← pow_mul, Nat.mul_comm]
  have hsquare : (T ^ p) ^ 2 ≤ Z ^ 2 :=
    Nat.pow_le_pow_left hchebyshev 2
  have hpPower : (D + 1) ^ p ≤ Z ^ 2 := by
    rw [hmiddle] at hraise
    exact hraise.trans hsquare
  have hbase : 0 < D + 1 := by omega
  exact (Nat.pow_le_pow_right hbase hp).trans hpPower

/-- Substitution D=3*A*B gives the exact parity-core obstruction appearing
in the companion note. -/
theorem pellPrimeLocal_fourElevenParityThreshold
    (A B T Z p : ℕ)
    (hcoordinate : 3 * A * B + 1 ≤ T ^ 2)
    (hchebyshev : T ^ p ≤ Z)
    (hp : 11 ≤ p) :
    (3 * A * B + 1) ^ 11 ≤ Z ^ 2 :=
  pellPrimeLocal_elevenThreshold (3 * A * B) T Z p
    hcoordinate hchebyshev hp

/-- Any strict pointwise lower bound in the opposite direction excludes a
prime-index residual immediately. -/
theorem pellPrimeLocal_strictParityBound_excludes
    (A B Z : ℕ)
    (hnecessary : (3 * A * B + 1) ^ 11 ≤ Z ^ 2)
    (hlower : Z ^ 2 < (3 * A * B + 1) ^ 11) :
    False :=
  (not_lt_of_ge hnecessary) hlower

#print axioms pellPrimeLocal_halfAngleReconstruction
#print axioms pellPrimeLocal_blockOne
#print axioms pellPrimeLocal_derivativeFactor_ne_zero
#print axioms pellPrimeLocal_smallPrimeBranch
#print axioms pellPrimeLocal_minusOne_oddPow
#print axioms pellPrimeLocal_elevenThreshold
#print axioms pellPrimeLocal_fourElevenParityThreshold
#print axioms pellPrimeLocal_strictParityBound_excludes

end IUTThreeClosures
