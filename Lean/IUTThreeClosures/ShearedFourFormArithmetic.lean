/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArithmeticLeibnizWronskian
import IUTThreeClosures.ArithmeticPDerivation

/-!
# Arithmetic rigidity and counterexamples for sheared four-form counting

For an `abc` point and an integer shear parameter `u`, the extra linear form
is `c - u*a`.  This file records two pieces of exact arithmetic which are
useful when auditing a proposed level-one four-point estimate.

* Common divisors of two shears are controlled by their resultant
  `(v-u)*a`.  Analogous determinant identities control overlap with each of
  `a`, `b`, and `c`.
* Resultant separation does **not** force a new radical contribution.  There
  are primitive unbounded `abc` families for which one prescribed shear, or
  two adjacent prescribed shears simultaneously, have constant radical.
* A second primitive family makes three consecutive shears perfect squares.
  It strictly blocks any attempt to recover a coefficient better than the
  square-root threshold merely from the fact that several resultants are
  coprime.

No truncated SMT, Subspace theorem, S-unit estimate, or `abc` bound occurs as
an assumption or a field of a structure.
-/

namespace IUTThreeClosures

open UniqueFactorizationMonoid

/-! ## Determinant/resultant identities -/

/-- The signed extra form introduced by the shear `lambda ↦ u*lambda`. -/
def shearedLinearForm (u a c : ℤ) : ℤ :=
  c - u * a

/-- Primitivity of `(a,c)` is inherited by every signed shear. -/
theorem isCoprime_a_shearedLinearForm
    {u a c : ℤ} (hac : IsCoprime a c) :
    IsCoprime a (shearedLinearForm u a c) := by
  simpa [shearedLinearForm, sub_eq_add_neg, mul_comm] using
    hac.add_mul_right_right (-u)

@[simp]
theorem shearedLinearForm_sub
    (u v a c : ℤ) :
    shearedLinearForm u a c - shearedLinearForm v a c =
      (v - u) * a := by
  simp only [shearedLinearForm]
  ring

/-- Any common divisor of two sheared forms divides their exact resultant
`(v-u)*a`. -/
theorem commonDivisor_two_shears_dvd_resultant
    {k u v a c : ℤ}
    (hu : k ∣ shearedLinearForm u a c)
    (hv : k ∣ shearedLinearForm v a c) :
    k ∣ (v - u) * a := by
  rw [← shearedLinearForm_sub u v a c]
  exact dvd_sub hu hv

/-- After cancelling a factor coprime to `a`, the same resultant statement
shows that overlap between two shears is supported on `v-u`. -/
theorem coprime_commonDivisor_two_shears_dvd_parameterDifference
    {k u v a c : ℤ}
    (hka : IsCoprime k a)
    (hu : k ∣ shearedLinearForm u a c)
    (hv : k ∣ shearedLinearForm v a c) :
    k ∣ v - u := by
  exact hka.dvd_of_dvd_mul_right
    (commonDivisor_two_shears_dvd_resultant hu hv)

/-- Consecutive shears are actually coprime when `(a,c)` is primitive. -/
theorem isCoprime_adjacent_shears
    {u a c : ℤ} (hac : IsCoprime a c) :
    IsCoprime (shearedLinearForm u a c)
      (shearedLinearForm (u + 1) a c) := by
  have hda : IsCoprime (shearedLinearForm u a c) a :=
    (isCoprime_a_shearedLinearForm hac).symm
  have haux : IsCoprime (shearedLinearForm u a c)
      (a + shearedLinearForm u a c * (-1)) :=
    hda.add_mul_left_right (-1)
  have hneg := haux.neg_right
  have heq : -(a + shearedLinearForm u a c * (-1)) =
      shearedLinearForm (u + 1) a c := by
    simp only [shearedLinearForm]
    ring
  rw [heq] at hneg
  exact hneg

/-- A common divisor of `a` and `c-u*a` also divides `c`. -/
theorem commonDivisor_a_shear_dvd_c
    {k u a c : ℤ}
    (ha : k ∣ a) (hd : k ∣ shearedLinearForm u a c) :
    k ∣ c := by
  have hua : k ∣ u * a := dvd_mul_of_dvd_right ha u
  have hsum : k ∣ shearedLinearForm u a c + u * a := dvd_add hd hua
  simpa [shearedLinearForm] using hsum

/-- A common divisor of `c` and `c-u*a` divides `u*a`. -/
theorem commonDivisor_c_shear_dvd_u_mul_a
    {k u a c : ℤ}
    (hc : k ∣ c) (hd : k ∣ shearedLinearForm u a c) :
    k ∣ u * a := by
  have hsub : k ∣ c - shearedLinearForm u a c := dvd_sub hc hd
  simpa [shearedLinearForm] using hsub

/-- Writing `b=c-a`, a common divisor of `b` and `c-u*a` divides
`(u-1)*a`. -/
theorem commonDivisor_b_shear_dvd_u_sub_one_mul_a
    {k u a b c : ℤ}
    (habc : a + b = c)
    (hb : k ∣ b) (hd : k ∣ shearedLinearForm u a c) :
    k ∣ (u - 1) * a := by
  have hsub : k ∣ b - shearedLinearForm u a c := dvd_sub hb hd
  have hid : b - shearedLinearForm u a c = (u - 1) * a := by
    simp only [shearedLinearForm]
    linear_combination habc
  simpa [hid] using hsub

/-- The exact quadratic identity behind the four-form problem.  Applying an
`abc` estimate to this identity would be circular: for `u=2` it becomes
`a^2 + c(c-2a) = b^2`, whose radical is supported on the four forms
`a,b,c,c-2a`. -/
theorem adjacent_shear_quadratic_identity
    (u a b c : ℤ) (habc : a + b = c) :
    (u - 1) * a ^ 2 + c * shearedLinearForm u a c =
      b * shearedLinearForm (u - 1) a c := by
  rw [← habc]
  simp only [shearedLinearForm]
  ring

/-- The most economical specialization of the quadratic identity. -/
theorem shear_two_difference_of_squares
    (a b c : ℤ) (habc : a + b = c) :
    a ^ 2 + c * shearedLinearForm 2 a c = b ^ 2 := by
  have h := adjacent_shear_quadratic_identity 2 a b c habc
  have hshear : shearedLinearForm 1 a c = b := by
    rw [← habc]
    simp [shearedLinearForm]
  norm_num at h
  rw [hshear] at h
  simpa [pow_two] using h

/-! ## One prescribed shear can have constant radical -/

/-- For shear parameter `u=v+1`, take

`(a,b,c) = (1, 2^(n+1)+v, 2^(n+1)+v+1)`.

This is a primitive positive abc point and `c-u*a=2^(n+1)`. -/
def fixedShearPowerPoint (v n : ℕ) : ABCPoint where
  a := 1
  b := 2 ^ (n + 1) + v
  c := 2 ^ (n + 1) + v + 1
  a_pos := by norm_num
  b_pos := by positivity
  c_pos := by positivity
  sum_eq := by omega
  pairwise_coprime := by
    simp only [PairwiseCoprimeABC]
    constructor
    · simp
    constructor
    · simpa [Nat.coprime_comm] using
        (Nat.coprime_add_self_left (m := 2 ^ (n + 1) + v) (n := 1))
    · simp

@[simp]
theorem fixedShearPowerPoint_shear
    (v n : ℕ) :
    shearedLinearForm (v + 1)
        (fixedShearPowerPoint v n).a
        (fixedShearPowerPoint v n).c = (2 ^ (n + 1) : ℕ) := by
  simp [fixedShearPowerPoint, shearedLinearForm]

/-- The new form in the preceding unbounded family has radical exactly two. -/
theorem fixedShearPowerPoint_shear_radical
    (v n : ℕ) :
    abcRadical
        (shearedLinearForm (v + 1)
          (fixedShearPowerPoint v n).a
          (fixedShearPowerPoint v n).c).natAbs = 2 := by
  rw [fixedShearPowerPoint_shear]
  simp only [Int.natAbs_natCast]
  rw [abcRadical_eq_natRadical]
  exact radical_two_pow_succ n

/-- The family is genuinely unbounded, so the constant-radical phenomenon is
not a finite collection of small exceptions. -/
theorem fixedShearPowerPoint_unbounded
    (v N : ℕ) :
    N < (fixedShearPowerPoint v N).c := by
  dsimp [fixedShearPowerPoint]
  have hpow : N < 2 ^ N := N.lt_two_pow_self
  omega

/-! ## Two adjacent prescribed shears can both have constant radical -/

/-- Put `Q=2^(n+1)`, `a=Q-1`, and

`c=(u+1)*a+1`.

Then `c-u*a=Q` and `c-(u+1)*a=1`. -/
def adjacentShearPowerPoint (u n : ℕ) : ABCPoint where
  a := 2 ^ (n + 1) - 1
  b := u * (2 ^ (n + 1) - 1) + 1
  c := (u + 1) * (2 ^ (n + 1) - 1) + 1
  a_pos := by
    have h : 1 < 2 ^ (n + 1) := one_lt_pow₀ (by norm_num) (by omega)
    omega
  b_pos := by positivity
  c_pos := by positivity
  sum_eq := by ring
  pairwise_coprime := by
    let A := 2 ^ (n + 1) - 1
    have hab : Nat.Coprime A (u * A + 1) := by
      simpa [Nat.coprime_comm] using
        (Nat.coprime_mul_right_add_right A 1 u)
    have hbc : Nat.Coprime (u * A + 1) ((u + 1) * A + 1) := by
      have hsum : A + (u * A + 1) = (u + 1) * A + 1 := by ring
      rw [← hsum]
      simpa [Nat.coprime_comm] using hab
    have hca : Nat.Coprime ((u + 1) * A + 1) A := by
      simpa [Nat.coprime_comm, add_comm, add_left_comm, add_assoc] using hab
    exact ⟨hab, hbc, hca⟩

@[simp]
theorem adjacentShearPowerPoint_first_shear
    (u n : ℕ) :
    shearedLinearForm u
        (adjacentShearPowerPoint u n).a
        (adjacentShearPowerPoint u n).c = (2 ^ (n + 1) : ℕ) := by
  simp [adjacentShearPowerPoint, shearedLinearForm]
  push_cast
  ring

@[simp]
theorem adjacentShearPowerPoint_second_shear
    (u n : ℕ) :
    shearedLinearForm (u + 1)
        (adjacentShearPowerPoint u n).a
        (adjacentShearPowerPoint u n).c = 1 := by
  simp [adjacentShearPowerPoint, shearedLinearForm]

/-- Both consecutive extra forms have constant radicals (`2` and `1`). -/
theorem adjacentShearPowerPoint_two_constant_radicals
    (u n : ℕ) :
    abcRadical
        (shearedLinearForm u
          (adjacentShearPowerPoint u n).a
          (adjacentShearPowerPoint u n).c).natAbs = 2 ∧
      abcRadical
        (shearedLinearForm (u + 1)
          (adjacentShearPowerPoint u n).a
          (adjacentShearPowerPoint u n).c).natAbs = 1 := by
  constructor
  · rw [adjacentShearPowerPoint_first_shear]
    simp only [Int.natAbs_natCast]
    rw [abcRadical_eq_natRadical]
    exact radical_two_pow_succ n
  · rw [adjacentShearPowerPoint_second_shear]
    norm_num [abcRadical]

/-- The two-shear counterexample family is unbounded. -/
theorem adjacentShearPowerPoint_unbounded
    (u N : ℕ) :
    N < (adjacentShearPowerPoint u N).c := by
  have hpow : N < 2 ^ N := N.lt_two_pow_self
  have hpow' : N < 2 ^ (N + 1) - 1 := by
    have hdouble : 2 ^ (N + 1) = 2 ^ N * 2 := by ring
    rw [hdouble]
    omega
  dsimp [adjacentShearPowerPoint]
  nlinarith

/-! ## Three consecutive square shears in a primitive family -/

/-- Three positive bases in a classical three-square arithmetic progression. -/
def squareShearX (k : ℕ) : ℕ := 4 * k ^ 2 + 20 * k + 23
def squareShearY (k : ℕ) : ℕ := 4 * k ^ 2 + 16 * k + 17
def squareShearZ (k : ℕ) : ℕ := 4 * k ^ 2 + 12 * k + 7

/-- The outer squares have mean equal to the middle square. -/
theorem squareShear_progression_identity (k : ℕ) :
    squareShearX k ^ 2 + squareShearZ k ^ 2 =
      2 * squareShearY k ^ 2 := by
  simp only [squareShearX, squareShearY, squareShearZ]
  ring

/-- Consecutive bases in the construction are coprime. -/
theorem squareShearX_coprime_squareShearY (k : ℕ) :
    Nat.Coprime (squareShearX k) (squareShearY k) := by
  let m : ℕ := 2 * k + 3
  have hm2 : Nat.Coprime m 2 := by
    rw [Nat.coprime_two_right]
    exact ⟨k + 1, by simp [m]; ring⟩
  have hmy : Nat.Coprime m (squareShearY k) := by
    have hy : squareShearY k = m * (2 * k + 5) + 2 := by
      dsimp [squareShearY, m]
      ring
    rw [hy]
    simpa [Nat.coprime_comm] using
      (Nat.coprime_mul_right_add_left 2 m (2 * k + 5)).2 hm2.symm
  have hy2 : Nat.Coprime (squareShearY k) 2 := by
    rw [Nat.coprime_two_right]
    exact ⟨2 * k ^ 2 + 8 * k + 8, by
      simp [squareShearY]
      ring⟩
  have hy2m : Nat.Coprime (squareShearY k) (2 * m) :=
    hy2.mul_right hmy.symm
  have hdiff : squareShearY k + 2 * m = squareShearX k := by
    dsimp [squareShearX, squareShearY, m]
    ring
  rw [← hdiff]
  simpa [Nat.coprime_comm, add_comm] using hy2m

/-- The step between the three squares. -/
def squareShearStep (k : ℕ) : ℕ :=
  squareShearX k ^ 2 - squareShearY k ^ 2

theorem squareShearY_sq_add_step (k : ℕ) :
    squareShearY k ^ 2 + squareShearStep k = squareShearX k ^ 2 := by
  unfold squareShearStep
  have hbase : squareShearY k < squareShearX k := by
    dsimp [squareShearX, squareShearY]
    omega
  have hle : squareShearY k ^ 2 ≤ squareShearX k ^ 2 := by
    exact (Nat.pow_lt_pow_left hbase (by norm_num)).le
  exact Nat.add_sub_of_le hle

theorem squareShearZ_sq_add_step (k : ℕ) :
    squareShearZ k ^ 2 + squareShearStep k = squareShearY k ^ 2 := by
  have hxy := squareShearY_sq_add_step k
  have hprog := squareShear_progression_identity k
  omega

/-- The square progression gives a primitive abc point whose shears at
`u=2,3,4` are the three displayed squares. -/
def threeSquareShearPoint (k : ℕ) : ABCPoint where
  a := squareShearStep k
  b := squareShearX k ^ 2 + squareShearStep k
  c := squareShearX k ^ 2 + 2 * squareShearStep k
  a_pos := by
    unfold squareShearStep
    have hbase : squareShearY k < squareShearX k := by
      dsimp [squareShearX, squareShearY]
      omega
    have hlt : squareShearY k ^ 2 < squareShearX k ^ 2 := by
      exact Nat.pow_lt_pow_left hbase (by norm_num)
    omega
  b_pos := by
    dsimp [squareShearX, squareShearStep]
    positivity
  c_pos := by
    dsimp [squareShearX, squareShearStep]
    positivity
  sum_eq := by ring
  pairwise_coprime := by
    have hxy := squareShearX_coprime_squareShearY k
    have hstepx : Nat.Coprime (squareShearStep k) (squareShearX k) := by
      have hstepx2 : Nat.Coprime (squareShearStep k) (squareShearX k ^ 2) := by
        unfold squareShearStep
        have hbase : squareShearY k < squareShearX k := by
          dsimp [squareShearX, squareShearY]
          omega
        have hle : squareShearY k ^ 2 ≤ squareShearX k ^ 2 := by
          exact (Nat.pow_lt_pow_left hbase (by norm_num)).le
        have hpowers : Nat.Coprime
            (squareShearX k ^ 2) (squareShearY k ^ 2) :=
          hxy.pow_right 2 |>.pow_left 2
        have hleft : Nat.Coprime
            (squareShearX k ^ 2)
            (squareShearX k ^ 2 - squareShearY k ^ 2) :=
          (Nat.coprime_self_sub_right hle).2 hpowers
        exact hleft.symm
      exact hstepx2.of_dvd_right (dvd_pow_self _ (by norm_num))
    have hstepx2 : Nat.Coprime (squareShearStep k) (squareShearX k ^ 2) :=
      hstepx.pow_right 2
    let A := squareShearStep k
    let X2 := squareShearX k ^ 2
    have hab : Nat.Coprime A (X2 + A) := by
      dsimp [A, X2]
      simpa using
        (Nat.coprime_add_self_right (m := squareShearStep k)
          (n := squareShearX k ^ 2)).2 hstepx2
    have hbc : Nat.Coprime (X2 + A) (X2 + 2 * A) := by
      have hsum : A + (X2 + A) = X2 + 2 * A := by ring
      rw [← hsum]
      simpa [Nat.coprime_comm] using hab
    have hca : Nat.Coprime (X2 + 2 * A) A := by
      have : Nat.Coprime A (X2 + 2 * A) := by
        dsimp [A, X2]
        simpa [add_comm, add_left_comm, add_assoc] using hstepx2
      exact this.symm
    exact ⟨hab, hbc, hca⟩

theorem threeSquareShearPoint_shear_two (k : ℕ) :
    (threeSquareShearPoint k).c - 2 * (threeSquareShearPoint k).a =
      squareShearX k ^ 2 := by
  simp [threeSquareShearPoint]

theorem threeSquareShearPoint_shear_three (k : ℕ) :
    (threeSquareShearPoint k).c - 3 * (threeSquareShearPoint k).a =
      squareShearY k ^ 2 := by
  dsimp [threeSquareShearPoint]
  have h := squareShearY_sq_add_step k
  omega

theorem threeSquareShearPoint_shear_four (k : ℕ) :
    (threeSquareShearPoint k).c - 4 * (threeSquareShearPoint k).a =
      squareShearZ k ^ 2 := by
  dsimp [threeSquareShearPoint]
  have hxy := squareShearY_sq_add_step k
  have hyz := squareShearZ_sq_add_step k
  omega

/-- The radical of a nonzero natural square is the radical of its base and
is therefore at most the base. -/
theorem abcRadical_sq_le (x : ℕ) (hx : 0 < x) :
    abcRadical (x ^ 2) ≤ x := by
  rw [abcRadical_eq_natRadical, radical_pow x (by norm_num)]
  exact Nat.le_of_dvd hx radical_dvd_self

/-- Each of the three consecutive new forms has at most square-root radical.
This is an exact, primitive obstruction to extracting a better exponent from
resultant separation alone. -/
theorem threeSquareShearPoint_radical_bounds (k : ℕ) :
    abcRadical
        ((threeSquareShearPoint k).c -
          2 * (threeSquareShearPoint k).a) ≤ squareShearX k ∧
      abcRadical
        ((threeSquareShearPoint k).c -
          3 * (threeSquareShearPoint k).a) ≤ squareShearY k ∧
      abcRadical
        ((threeSquareShearPoint k).c -
          4 * (threeSquareShearPoint k).a) ≤ squareShearZ k := by
  rw [threeSquareShearPoint_shear_two,
    threeSquareShearPoint_shear_three,
    threeSquareShearPoint_shear_four]
  exact ⟨abcRadical_sq_le _ (by simp [squareShearX]),
    abcRadical_sq_le _ (by simp [squareShearY]),
    abcRadical_sq_le _ (by simp [squareShearZ])⟩

/-- A square of unbounded base strictly refutes every uniform
`d^2 ≤ C * rad(d)^3` estimate.  This is the integral version of ruling out
a uniform radical exponent `2/3`, hence any argument claiming that such an
exponent follows from resultant separation alone. -/
theorem square_radical_two_thirds_strict_counterexample
    (C x : ℕ) (hx : 0 < x) (hCx : C < x) :
    C * abcRadical (x ^ 2) ^ 3 < (x ^ 2) ^ 2 := by
  have hrad : abcRadical (x ^ 2) ≤ x := abcRadical_sq_le x hx
  have hrad3 : abcRadical (x ^ 2) ^ 3 ≤ x ^ 3 :=
    Nat.pow_le_pow_left hrad 3
  calc
    C * abcRadical (x ^ 2) ^ 3 ≤ C * x ^ 3 :=
      Nat.mul_le_mul_left C hrad3
    _ < x * x ^ 3 := (Nat.mul_lt_mul_right (pow_pos hx 3)).2 hCx
    _ = (x ^ 2) ^ 2 := by ring

/-- More strongly, for every proposed constant the same primitive abc point
makes **all three** consecutive shears `2,3,4` violate the uniform
two-thirds radical lower bound. -/
theorem threeSquareShearPoint_simultaneous_two_thirds_counterexample
    (C : ℕ) :
    ∃ P : ABCPoint,
      C * abcRadical (P.c - 2 * P.a) ^ 3 < (P.c - 2 * P.a) ^ 2 ∧
      C * abcRadical (P.c - 3 * P.a) ^ 3 < (P.c - 3 * P.a) ^ 2 ∧
      C * abcRadical (P.c - 4 * P.a) ^ 3 < (P.c - 4 * P.a) ^ 2 := by
  let k := C + 1
  refine ⟨threeSquareShearPoint k, ?_⟩
  rw [threeSquareShearPoint_shear_two,
    threeSquareShearPoint_shear_three,
    threeSquareShearPoint_shear_four]
  have hCx : C < squareShearX k := by
    dsimp [squareShearX, k]
    omega
  have hCy : C < squareShearY k := by
    dsimp [squareShearY, k]
    omega
  have hCz : C < squareShearZ k := by
    dsimp [squareShearZ, k]
    omega
  exact ⟨square_radical_two_thirds_strict_counterexample C _
      (by simp [squareShearX]) hCx,
    square_radical_two_thirds_strict_counterexample C _
      (by simp [squareShearY]) hCy,
    square_radical_two_thirds_strict_counterexample C _
      (by simp [squareShearZ]) hCz⟩

/-! ## Exact scalar threshold for a four-form transfer -/

/-- A coefficient `2-eta` against the four-form reduced count is exactly
what is needed after paying the elementary one-height upper bound for the
new form. -/
theorem four_form_threshold_rearrangement
    {eta height oldCount newCount fixedLoss smtConstant : ℝ}
    (heta : 0 ≤ eta) (heta1 : eta < 1)
    (hnew : newCount ≤ height + fixedLoss)
    (hfour : (2 - eta) * height ≤ oldCount + newCount + smtConstant) :
    height ≤ oldCount / (1 - eta) +
      (fixedLoss + smtConstant) / (1 - eta) := by
  have hden : 0 < 1 - eta := by linarith
  have hcore : (1 - eta) * height ≤ oldCount + fixedLoss + smtConstant := by
    linarith
  have hquot : height ≤
      (oldCount + fixedLoss + smtConstant) / (1 - eta) := by
    exact (le_div_iff₀ hden).2 (by simpa [mul_comm] using hcore)
  calc
    height ≤ (oldCount + fixedLoss + smtConstant) / (1 - eta) := hquot
    _ = oldCount / (1 - eta) +
        (fixedLoss + smtConstant) / (1 - eta) := by ring

end IUTThreeClosures
