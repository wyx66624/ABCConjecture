/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyBranchQuarticBarrier
import IUTThreeClosures.TripodWeilHeight

/-!
# The Frey real-period / AGM height barrier

For the Frey curve `y² = x (x-a) (x+b)`, with `a+b=c`, the primitive
positive real period for the invariant differential `dx/(2y)` is

`2 / sqrt(c) * K (sqrt (b/c))`.

Equivalently it is `pi / AGM(sqrt(c),sqrt(a))`.  The analytic period and AGM
identities are proved in the accompanying paper note, not in this file.
This file formalizes the algebraic arithmetic that an AGM/Landen descent has
to pay:

* the descending Landen ratio satisfies a reciprocal quadratic equation;
* its chosen real contraction is inverted by the new sign conjugation;
* the quadratic discriminant is exactly `16*a*c`;
* in the adjacent family `(n,1,n+1)`, the apparent contraction has the exact
  reciprocal-square cost;
* a fixed-prime square-power family has unbounded order-discriminant depth;
* the rational hypergeometric argument still has the full abc height;
* a period lower bound of critical conductor exponent `1/2`, together with
  only a sublinear elliptic-integral kernel, gives the expected scalar abc
  budget.

No elliptic integral, period comparison, AGM convergence, number-field
height, order-index formula, G-function estimate, conductor calculation,
Szpiro estimate, or abc estimate is assumed as structure data.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The universal reciprocal Landen quadratic -/

/-- The descending Landen ratio attached to two square roots. -/
def landenRatio {K : Type*} [Field K] (u v : K) : K :=
  (u - v) / (u + v)

/-- Changing the sign of one newly adjoined square root sends the contracted
Landen ratio to its reciprocal. -/
theorem landenRatio_mul_signConjugate
    {K : Type*} [Field K] {u v : K}
    (hsum : u + v ≠ 0) (hdiff : u - v ≠ 0) :
    landenRatio u v * landenRatio u (-v) = 1 := by
  rw [show landenRatio u (-v) = (u + v) / (u - v) by
    simp [landenRatio, sub_eq_add_neg]]
  unfold landenRatio
  field_simp

/-- If `u²=A` and `v²=B`, the Landen ratio satisfies the reciprocal
quadratic `(A-B)T² - 2(A+B)T + (A-B)`. -/
theorem landenRatio_quadratic
    {K : Type*} [Field K] (u v : K) (hsum : u + v ≠ 0) :
    (u ^ 2 - v ^ 2) * landenRatio u v ^ 2 -
        2 * (u ^ 2 + v ^ 2) * landenRatio u v +
        (u ^ 2 - v ^ 2) = 0 := by
  unfold landenRatio
  field_simp
  ring

/-- The discriminant of the reciprocal Landen quadratic is `16 A B`. -/
theorem landenQuadratic_discriminant
    {R : Type*} [CommRing R] (A B : R) :
    (2 * (A + B)) ^ 2 - 4 * (A - B) ^ 2 = 16 * A * B := by
  ring

/-- The normalized AGM gap after one step is the square of the descending
Landen ratio.  Thus the real convergence is quadratic, but it uses the same
new square roots whose sign conjugation inverts the ratio. -/
theorem agmGapRatio_eq_landenRatio_sq
    {K : Type*} [Field K] [CharZero K] {u v : K}
    (hsum : u + v ≠ 0) :
    (((u ^ 2 + v ^ 2) / 2) - u * v) /
        (((u ^ 2 + v ^ 2) / 2) + u * v) =
      landenRatio u v ^ 2 := by
  have htwo : (2 : K) ≠ 0 := by norm_num
  have hnum : (u ^ 2 + v ^ 2) / 2 - u * v =
      (u - v) ^ 2 / 2 := by ring
  have hdeneq : (u ^ 2 + v ^ 2) / 2 + u * v =
      (u + v) ^ 2 / 2 := by ring
  have hden : (u ^ 2 + v ^ 2) / 2 + u * v ≠ 0 := by
    rw [hdeneq]
    exact div_ne_zero (pow_ne_zero 2 hsum) htwo
  rw [hnum, hdeneq]
  unfold landenRatio
  rw [div_pow]
  field_simp

/-! ## Specialization to a Frey triple -/

/-- The scalar quadratic polynomial of the first Frey Landen transform. -/
def freyLandenQuadratic
    {R : Type*} [CommRing R] (a b c T : R) : R :=
  b * T ^ 2 - 2 * (a + c) * T + b

/-- For square roots `u²=c`, `v²=a`, the first descending Landen ratio
satisfies `b*T² - 2(a+c)T + b = 0`. -/
theorem freyLandenRatio_quadratic
    {K : Type*} [Field K] {a b c u v : K}
    (hc : a + b = c) (hu : u ^ 2 = c) (hv : v ^ 2 = a)
    (hsum : u + v ≠ 0) :
    freyLandenQuadratic a b c (landenRatio u v) = 0 := by
  have h := landenRatio_quadratic u v hsum
  rw [hu, hv] at h
  have hdiff : c - a = b := by
    rw [← hc]
    ring
  rw [hdiff, add_comm c a] at h
  exact h

/-- The first Frey Landen quadratic has discriminant exactly `16ac`. -/
theorem freyLandenQuadratic_discriminant
    {R : Type*} [CommRing R] {a b c : R} (hc : a + b = c) :
    (2 * (a + c)) ^ 2 - 4 * b ^ 2 = 16 * a * c := by
  rw [← hc]
  ring

/-- Rationalizing the first Landen numerator gives an exact norm square.
This is the algebraic place at which the third branch difference `b` returns. -/
theorem freyLanden_numerator_norm
    {R : Type*} [CommRing R] {a b c s : R}
    (hc : a + b = c) (hs : s ^ 2 = a * c) :
    (a + c - 2 * s) * (a + c + 2 * s) = b ^ 2 := by
  rw [show (a + c - 2 * s) * (a + c + 2 * s) =
      (a + c) ^ 2 - 4 * s ^ 2 by ring, hs, ← hc]
  ring

/-! ## Exact archimedean contraction cost -/

/-- When the two input squares differ by one, the small real Landen ratio is
exactly the inverse square of their sum.  For `u=sqrt(n+1)`, `v=sqrt(n)`,
this is the family `(a,b,c)=(n,1,n+1)`. -/
theorem landenRatio_eq_inv_sum_sq_of_sq_sub_sq_eq_one
    {K : Type*} [Field K] {u v : K}
    (hunit : u ^ 2 - v ^ 2 = 1) (hsum : u + v ≠ 0) :
    landenRatio u v = 1 / (u + v) ^ 2 := by
  have hprod : (u - v) * (u + v) = 1 := by
    calc
      (u - v) * (u + v) = u ^ 2 - v ^ 2 := by ring
      _ = 1 := hunit
  unfold landenRatio
  calc
    (u - v) / (u + v) =
        ((u - v) * (u + v)) / (u + v) ^ 2 := by
      field_simp
    _ = 1 / (u + v) ^ 2 := by rw [hprod]

/-- The apparent real contraction has an exact multiplicative precision
cost; no limiting or asymptotic assertion is involved. -/
theorem adjacentLanden_contraction_cost
    {K : Type*} [Field K] {u v : K}
    (hunit : u ^ 2 - v ^ 2 = 1) (hsum : u + v ≠ 0) :
    landenRatio u v * (u + v) ^ 2 = 1 := by
  rw [landenRatio_eq_inv_sum_sq_of_sq_sub_sq_eq_one hunit hsum]
  exact div_mul_cancel₀ 1 (pow_ne_zero 2 hsum)

/-- Logarithmic form of the exact adjacent-family precision cost. -/
theorem adjacentLanden_log_contraction_cost
    {u v : ℝ} (hunit : u ^ 2 - v ^ 2 = 1) (hsum : u + v ≠ 0) :
    -Real.log (landenRatio u v) = 2 * Real.log (u + v) := by
  rw [landenRatio_eq_inv_sum_sq_of_sq_sub_sq_eq_one hunit hsum]
  simp only [one_div, Real.log_inv, Real.log_pow]
  ring

/-! ## A fixed-prime order-discriminant family -/

/-- The first-Landen quadratic discriminant for
`(a,b,c)=(3^(2(m+1)),1,3^(2(m+1))+1)`. -/
def squarePowerAdjacentLandenDiscriminant (m : ℕ) : ℕ :=
  16 * 3 ^ (2 * (m + 1)) * (3 ^ (2 * (m + 1)) + 1)

/-- The adjacent endpoint remains a unit modulo three. -/
theorem three_not_dvd_squarePowerAdjacent_c (m : ℕ) :
    ¬ 3 ∣ 3 ^ (2 * (m + 1)) + 1 := by
  intro hdiv
  have hpow : 3 ∣ 3 ^ (2 * (m + 1)) :=
    dvd_pow_self 3 (by omega)
  have hone : 3 ∣ 1 := (Nat.dvd_add_iff_right hpow).2 hdiv
  norm_num at hone

/-- Although the associated quadratic field is unramified at `3`, the
displayed quadratic-order discriminant retains exponent `2(m+1)` at `3`.
The number-field interpretation of this scalar identity is kept in the note. -/
theorem squarePowerAdjacentLandenDiscriminant_factorization_three
    (m : ℕ) :
    (squarePowerAdjacentLandenDiscriminant m).factorization 3 =
      2 * (m + 1) := by
  have hpow0 : 3 ^ (2 * (m + 1)) ≠ 0 := pow_ne_zero _ (by norm_num)
  have hleft0 : 16 * 3 ^ (2 * (m + 1)) ≠ 0 :=
    mul_ne_zero (by norm_num) hpow0
  have hc0 : 3 ^ (2 * (m + 1)) + 1 ≠ 0 := by positivity
  unfold squarePowerAdjacentLandenDiscriminant
  rw [Nat.factorization_mul hleft0 hc0,
    Nat.factorization_mul (by norm_num) hpow0]
  simp only [Finsupp.add_apply]
  rw [Nat.factorization_eq_zero_of_not_dvd (by norm_num : ¬ 3 ∣ 16),
    Nat.factorization_pow_self Nat.prime_three,
    Nat.factorization_eq_zero_of_not_dvd
      (three_not_dvd_squarePowerAdjacent_c m)]
  omega

/-- Fixed reduced prime support does not bound the order-discriminant depth. -/
theorem squarePowerAdjacentLandenDiscriminant_depth_unbounded (B : ℕ) :
    B < (squarePowerAdjacentLandenDiscriminant B).factorization 3 := by
  rw [squarePowerAdjacentLandenDiscriminant_factorization_three]
  omega

/-! ## Hypergeometric specialization still has full height -/

/-- The Gauss hypergeometric argument `b/c = 1-lambda` has exactly the abc
height, not the logarithm of the radical. -/
theorem freyHypergeometricArgument_height_eq_abcHeight (P : ABCPoint) :
    Heights.normalizedLogHeight ℚ (1 - P.lambda) = P.height :=
  P.normalizedLogHeight_one_sub_lambda

/-- The first nonconstant coefficient of
`2F1(1/2,1/2;1;z)` is `z/4`; on the adjacent family its reduced denominator
is already the full `4c`. -/
def adjacentHypergeometricLinearTerm (n : ℕ) : ℚ :=
  (1 : ℚ) / (4 * (n + 1) : ℕ)

theorem adjacentHypergeometricLinearTerm_den (n : ℕ) :
    (adjacentHypergeometricLinearTerm n).den = 4 * (n + 1) := by
  have hb : 0 < (4 * (n + 1) : ℤ) := by positivity
  have hcop : Nat.Coprime (1 : ℤ).natAbs
      (4 * (n + 1) : ℤ).natAbs := by simp
  have h := Rat.den_div_eq_of_coprime
    (a := (1 : ℤ)) (b := (4 * (n + 1) : ℤ)) hb hcop
  have h' : ((adjacentHypergeometricLinearTerm n).den : ℤ) =
      (4 * (n + 1) : ℤ) := by
    simpa [adjacentHypergeometricLinearTerm] using h
  exact_mod_cast h'

/-- Consequently even the linear Taylor datum has unbounded denominator on
the adjacent primitive family. -/
theorem adjacentHypergeometricLinearTerm_den_unbounded (B : ℕ) :
    B < (adjacentHypergeometricLinearTerm B).den := by
  rw [adjacentHypergeometricLinearTerm_den]
  omega

/-! ## Exact scalar boundary of a period-conductor bridge -/

/-- If `H=log c` and `Kern=log(2K(k))`, then the negative logarithm of the
primitive positive real period is `H/2-Kern`. -/
def periodLogFromHeightKernel (height kernel : ℝ) : ℝ :=
  height / 2 - kernel

/-- A period lower bound at conductor exponent `1/2+eta` and a kernel bound
`kernel <= delta*height+B` leave exactly the displayed coefficient.  This is
only scalar bookkeeping; neither difficult estimate is asserted here. -/
theorem periodRadical_budget_conservation
    {height kernel radical eta delta C B : ℝ}
    (hperiod : periodLogFromHeightKernel height kernel ≤
      (1 / 2 + eta) * radical + C)
    (hkernel : kernel ≤ delta * height + B) :
    (1 - 2 * delta) * height ≤
      (1 + 2 * eta) * radical + 2 * (C + B) := by
  unfold periodLogFromHeightKernel at hperiod
  nlinarith

/-- When the elliptic-integral kernel is genuinely sublinear (`delta<1/2`),
the preceding conserved budget can be solved for the abc height. -/
theorem height_le_of_periodRadical_and_sublinearKernel
    {height kernel radical eta delta C B : ℝ}
    (hdelta : delta < 1 / 2)
    (hperiod : periodLogFromHeightKernel height kernel ≤
      (1 / 2 + eta) * radical + C)
    (hkernel : kernel ≤ delta * height + B) :
    height ≤
      ((1 + 2 * eta) * radical + 2 * (C + B)) /
        (1 - 2 * delta) := by
  have hden : 0 < 1 - 2 * delta := by nlinarith
  apply (le_div_iff₀ hden).2
  simpa [mul_comm] using
    (periodRadical_budget_conservation hperiod hkernel)

end

end IUTThreeClosures
