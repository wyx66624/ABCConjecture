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

/-! ## Exact power thresholds -/

/-- The exponent-independent natural-number form of the global size
argument.  Keeping the target exponent explicit lets later residual
reductions instantiate the strongest lower bound currently available. -/
theorem pellPrimeLocal_powerThreshold
    (D T Z p k : ℕ)
    (hcoordinate : D + 1 ≤ T ^ 2)
    (hchebyshev : T ^ p ≤ Z)
    (hk : k ≤ p) :
    (D + 1) ^ k ≤ Z ^ 2 := by
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
  exact (Nat.pow_le_pow_right hbase hk).trans hpPower

/-- The natural-number form of the global size argument.  The hypotheses
are precisely D+1 <= T^2 and T^p <= Z.  For p >= 11 they imply the
integer certificate (D+1)^11 <= Z^2, without real roots or asymptotics. -/
theorem pellPrimeLocal_elevenThreshold
    (D T Z p : ℕ)
    (hcoordinate : D + 1 ≤ T ^ 2)
    (hchebyshev : T ^ p ≤ Z)
    (hp : 11 ≤ p) :
    (D + 1) ^ 11 ≤ Z ^ 2 :=
  pellPrimeLocal_powerThreshold D T Z p 11 hcoordinate hchebyshev hp

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

/-! ## The active prime-index range: the exact 4/31 threshold -/

/-- After the certified closures through prime index 29, every active
prime-index residual has p >= 31.  The same integer argument therefore
retains exponent 31 rather than weakening it to 11. -/
theorem pellPrimeLocal_thirtyOneThreshold
    (D T Z p : ℕ)
    (hcoordinate : D + 1 ≤ T ^ 2)
    (hchebyshev : T ^ p ≤ Z)
    (hp : 31 ≤ p) :
    (D + 1) ^ 31 ≤ Z ^ 2 :=
  pellPrimeLocal_powerThreshold D T Z p 31 hcoordinate hchebyshev hp

/-- Substitution D=3*A*B in the active p >= 31 range. -/
theorem pellPrimeLocal_fourThirtyOneParityThreshold
    (A B T Z p : ℕ)
    (hcoordinate : 3 * A * B + 1 ≤ T ^ 2)
    (hchebyshev : T ^ p ≤ Z)
    (hp : 31 ≤ p) :
    (3 * A * B + 1) ^ 31 ≤ Z ^ 2 :=
  pellPrimeLocal_thirtyOneThreshold (3 * A * B) T Z p
    hcoordinate hchebyshev hp

/-- The exact remaining sufficient inequality in the active p >= 31
range.  It deliberately assumes only the opposite strict parity-core bound;
no unproved squarefree-part estimate is hidden here. -/
theorem pellPrimeLocal_strictParityBoundThirtyOne_excludes
    (A B Z : ℕ)
    (hnecessary : (3 * A * B + 1) ^ 31 ≤ Z ^ 2)
    (hlower : Z ^ 2 < (3 * A * B + 1) ^ 31) :
    False :=
  (not_lt_of_ge hnecessary) hlower

/-! ## An absolute height floor for every active residual -/

/-- The four-consecutive branch has A = 22 and B = 23 modulo 24.  These
residues alone force the exact lower bound A*B >= 506. -/
theorem pellPrimeLocal_activeKernelProductFloor
    (A B : ℕ)
    (hA : A % 24 = 22)
    (hB : B % 24 = 23) :
    506 ≤ A * B := by
  have hAle : 22 ≤ A := by omega
  have hBle : 23 ≤ B := by omega
  have hprod : 22 * 23 ≤ A * B := Nat.mul_le_mul hAle hBle
  norm_num at hprod
  exact hprod

/-- Combining the active exponent-31 obstruction with the exact parity-core
residues excludes every height b+2 at most 4*10^24.  The final comparison is
an exact natural-number calculation, not a floating-point estimate. -/
theorem pellPrimeLocal_activeHeightFloor
    (A B b Z : ℕ)
    (hA : A % 24 = 22)
    (hB : B % 24 = 23)
    (hnecessary : (3 * A * B + 1) ^ 31 ≤ Z ^ 2)
    (hupper : Z ^ 2 < (b + 2) ^ 4) :
    4_000_000_000_000_000_000_000_000 < b + 2 := by
  have hAB : 506 ≤ A * B :=
    pellPrimeLocal_activeKernelProductFloor A B hA hB
  have hbase : 1519 ≤ 3 * A * B + 1 := by
    calc
      1519 = 3 * 506 + 1 := by norm_num
      _ ≤ 3 * (A * B) + 1 :=
        Nat.add_le_add_right (Nat.mul_le_mul_left 3 hAB) 1
      _ = 3 * A * B + 1 := by ring
  have hpow : 1519 ^ 31 ≤ (3 * A * B + 1) ^ 31 :=
    Nat.pow_le_pow_left hbase 31
  have hstrict : 1519 ^ 31 < (b + 2) ^ 4 :=
    (hpow.trans hnecessary).trans_lt hupper
  by_contra hheight
  have hb : b + 2 ≤ 4_000_000_000_000_000_000_000_000 := by omega
  have hbpow : (b + 2) ^ 4 ≤
      4_000_000_000_000_000_000_000_000 ^ 4 :=
    Nat.pow_le_pow_left hb 4
  have himpossible : 1519 ^ 31 <
      4_000_000_000_000_000_000_000_000 ^ 4 :=
    hstrict.trans_le hbpow
  norm_num at himpossible

/-! ## The post-p31 active range: the exact 4/37 threshold -/

/-- Once the fixed prime 31 is removed by its accepted Stoll--Coleman
certificate, every remaining prime-index residual has `p ≥ 37`.  The generic
power threshold can therefore retain exponent 37. -/
theorem pellPrimeLocal_thirtySevenThreshold
    (D T Z p : ℕ)
    (hcoordinate : D + 1 ≤ T ^ 2)
    (hchebyshev : T ^ p ≤ Z)
    (hp : 37 ≤ p) :
    (D + 1) ^ 37 ≤ Z ^ 2 :=
  pellPrimeLocal_powerThreshold D T Z p 37 hcoordinate hchebyshev hp

/-- Substitution `D=3*A*B` in the post-p31 active range. -/
theorem pellPrimeLocal_fourThirtySevenParityThreshold
    (A B T Z p : ℕ)
    (hcoordinate : 3 * A * B + 1 ≤ T ^ 2)
    (hchebyshev : T ^ p ≤ Z)
    (hp : 37 ≤ p) :
    (3 * A * B + 1) ^ 37 ≤ Z ^ 2 :=
  pellPrimeLocal_thirtySevenThreshold (3 * A * B) T Z p
    hcoordinate hchebyshev hp

/-- Any strict parity-core estimate in the opposite direction closes the
post-p31 residual immediately. -/
theorem pellPrimeLocal_strictParityBoundThirtySeven_excludes
    (A B Z : ℕ)
    (hnecessary : (3 * A * B + 1) ^ 37 ≤ Z ^ 2)
    (hlower : Z ^ 2 < (3 * A * B + 1) ^ 37) :
    False :=
  (not_lt_of_ge hnecessary) hlower

/-- The exponent-37 threshold and the fixed residues of `A,B` exclude every
height `b+2` at most `2.6*10^29`.  The final comparison is exact integer
arithmetic. -/
theorem pellPrimeLocal_activeHeightFloorAfterThirtyOne
    (A B b Z : ℕ)
    (hA : A % 24 = 22)
    (hB : B % 24 = 23)
    (hnecessary : (3 * A * B + 1) ^ 37 ≤ Z ^ 2)
    (hupper : Z ^ 2 < (b + 2) ^ 4) :
    260_000_000_000_000_000_000_000_000_000 < b + 2 := by
  have hAB : 506 ≤ A * B :=
    pellPrimeLocal_activeKernelProductFloor A B hA hB
  have hbase : 1519 ≤ 3 * A * B + 1 := by
    calc
      1519 = 3 * 506 + 1 := by norm_num
      _ ≤ 3 * (A * B) + 1 :=
        Nat.add_le_add_right (Nat.mul_le_mul_left 3 hAB) 1
      _ = 3 * A * B + 1 := by ring
  have hpow : 1519 ^ 37 ≤ (3 * A * B + 1) ^ 37 :=
    Nat.pow_le_pow_left hbase 37
  have hstrict : 1519 ^ 37 < (b + 2) ^ 4 :=
    (hpow.trans hnecessary).trans_lt hupper
  by_contra hheight
  have hb : b + 2 ≤
      260_000_000_000_000_000_000_000_000_000 := by omega
  have hbpow : (b + 2) ^ 4 ≤
      260_000_000_000_000_000_000_000_000_000 ^ 4 :=
    Nat.pow_le_pow_left hb 4
  have himpossible : 1519 ^ 37 <
      260_000_000_000_000_000_000_000_000_000 ^ 4 :=
    hstrict.trans_le hbpow
  norm_num at himpossible

#print axioms pellPrimeLocal_halfAngleReconstruction
#print axioms pellPrimeLocal_blockOne
#print axioms pellPrimeLocal_derivativeFactor_ne_zero
#print axioms pellPrimeLocal_smallPrimeBranch
#print axioms pellPrimeLocal_minusOne_oddPow
#print axioms pellPrimeLocal_powerThreshold
#print axioms pellPrimeLocal_elevenThreshold
#print axioms pellPrimeLocal_fourElevenParityThreshold
#print axioms pellPrimeLocal_strictParityBound_excludes
#print axioms pellPrimeLocal_thirtyOneThreshold
#print axioms pellPrimeLocal_fourThirtyOneParityThreshold
#print axioms pellPrimeLocal_strictParityBoundThirtyOne_excludes
#print axioms pellPrimeLocal_activeKernelProductFloor
#print axioms pellPrimeLocal_activeHeightFloor
#print axioms pellPrimeLocal_thirtySevenThreshold
#print axioms pellPrimeLocal_fourThirtySevenParityThreshold
#print axioms pellPrimeLocal_strictParityBoundThirtySeven_excludes
#print axioms pellPrimeLocal_activeHeightFloorAfterThirtyOne

end IUTThreeClosures
