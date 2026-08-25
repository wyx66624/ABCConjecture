/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SecondJetQuadraticSystem
import Mathlib.NumberTheory.ArithmeticFunction.Misc

/-!
# Quantitative barriers for integral zeros of the straight second jet

This file records three unconditional facts about the quadratic core isolated
in `SecondJetQuadraticSystem`.

* A three-prime internal block has an explicit Gram determinant.  In
  particular its discriminant contains only the block size and the prime
  multiplicities; changing from normalized prime coordinates to integral
  prime weights changes the determinant only by a square.
* The five-variable isotropic form
  `u₁²+u₂²-T²(v₁²+v₂²+v₃²)` has fixed determinant radical
  along `T=2^(k+1)`, but every nondegenerate integral zero has positive energy at
  least `T²`.  Thus dimension, signature, determinant square-class, and the
  set of bad primes cannot by themselves give a uniform least-zero bound.
* For the infinite endpoint family `(1, 2^m-1, 2^m)`, `m ≥ 3`, the
  straight prime-dependent second-jet equations have no nonzero real
  solution.  This strengthens the block-scaling obstruction: arbitrary
  weights at the prime divisors of `2^m-1` are covered through the exact
  moment Cauchy inequality.

No least-zero theorem, local-density estimate, or abc bound is assumed.
-/

namespace IUTThreeClosures

open scoped ArithmeticFunction.Omega

/-! ## An explicit internal-block discriminant -/

/-- The integral two-parameter chart on the kernel of
`e*y₁ + f*y₂ + g*y₃`: take `(y₁,y₂,y₃)=(g*s,g*t,-e*s-f*t)`.
The first component of the conjunction is the kernel equation and the second
is the exact energy in this chart. -/
theorem threeCoordinateInternalChart
    (e f g s t : ℚ) :
    e * (g * s) + f * (g * t) + g * (-e * s - f * t) = 0 ∧
      e * (g * s) ^ 2 + f * (g * t) ^ 2 +
          g * (-e * s - f * t) ^ 2 =
        (e * g * (e + g)) * s ^ 2 +
          2 * (e * f * g) * s * t +
          (f * g * (f + g)) * t ^ 2 := by
  constructor <;> ring

/-- Gram determinant of the chart in `threeCoordinateInternalChart`.
Modulo rational squares this is `e*f*g*(e+f+g)`, the three-coordinate
instance of the general internal-block discriminant formula. -/
theorem threeCoordinateInternalGramDeterminant
    (e f g : ℚ) :
    (e * g * (e + g)) * (f * g * (f + g)) -
        (e * f * g) ^ 2 =
      e * f * g ^ 3 * (e + f + g) := by
  ring

/-- Positivity of the internal Gram determinant for positive
multiplicities.  This is the two-dimensional positive-definite block which
contributes with sign `-a`, `-b`, or `+c` in the global internal Hessian. -/
theorem threeCoordinateInternalGramDeterminant_pos
    (e f g : ℝ) (he : 0 < e) (hf : 0 < f) (hg : 0 < g) :
    0 < (e * g * (e + g)) * (f * g * (f + g)) -
        (e * f * g) ^ 2 := by
  have hid :
      (e * g * (e + g)) * (f * g * (f + g)) -
          (e * f * g) ^ 2 =
        e * f * g ^ 3 * (e + f + g) := by ring
  rw [hid]
  positivity

/-! ## A square-class-blind least-zero counterexample -/

/-- The square-scaled five-variable form is rationally the constant form of
signature `(2,3)`: the change of variables multiplies each negative
coordinate by `T`.  This rational change is not unimodular on the integral
lattice, which is exactly the quantitative issue. -/
theorem squareScaledFiveForm_changeOfVariables
    (T u₁ u₂ v₁ v₂ v₃ : ℤ) :
    u₁ ^ 2 + u₂ ^ 2 - T ^ 2 * (v₁ ^ 2 + v₂ ^ 2 + v₃ ^ 2) =
      u₁ ^ 2 + u₂ ^ 2 -
        ((T * v₁) ^ 2 + (T * v₂) ^ 2 + (T * v₃) ^ 2) := by
  ring

/-- Every integral zero whose negative block is nonzero has positive energy
at least `T²`. -/
theorem squareScaledFiveForm_zero_energy_lowerBound
    (T u₁ u₂ v₁ v₂ v₃ : ℕ)
    (hzero :
      u₁ ^ 2 + u₂ ^ 2 =
        T ^ 2 * (v₁ ^ 2 + v₂ ^ 2 + v₃ ^ 2))
    (hv : 0 < v₁ ^ 2 + v₂ ^ 2 + v₃ ^ 2) :
    T ^ 2 ≤ u₁ ^ 2 + u₂ ^ 2 := by
  calc
    T ^ 2 = T ^ 2 * 1 := by simp
    _ ≤ T ^ 2 * (v₁ ^ 2 + v₂ ^ 2 + v₃ ^ 2) :=
      Nat.mul_le_mul_left _ hv
    _ = u₁ ^ 2 + u₂ ^ 2 := hzero.symm

/-- The lower bound in `squareScaledFiveForm_zero_energy_lowerBound` is
attained by the primitive zero `(T,0,1,0,0)`. -/
theorem squareScaledFiveForm_lowerBound_sharp (T : ℕ) :
    T ^ 2 + 0 ^ 2 = T ^ 2 * (1 ^ 2 + 0 ^ 2 + 0 ^ 2) ∧
      T ^ 2 = T ^ 2 + 0 ^ 2 := by
  norm_num

/-- The determinant of `diag(1,1,-T²,-T²,-T²)` is `-T⁶`. -/
theorem squareScaledFiveForm_determinant (T : ℤ) :
    (1 : ℤ) * 1 * (-T ^ 2) * (-T ^ 2) * (-T ^ 2) = -T ^ 6 := by
  ring

/-- Along square scales `T=2^(k+1)`, the absolute determinant `T⁶` has
constant radical two although the least positive energy tends to infinity. -/
theorem squareScaledFiveForm_determinantRadical (k : ℕ) :
    UniqueFactorizationMonoid.radical ((2 ^ (k + 1)) ^ 6) = 2 := by
  rw [← pow_mul]
  rw [show (k + 1) * 6 = (6 * k + 5) + 1 by omega]
  simpa using
    (UniqueFactorizationMonoid.radical_pow_of_prime
      (Nat.prime_iff.mp Nat.prime_two)
      (show 6 * k + 5 + 1 ≠ 0 by omega))

/-! ## The full Mersenne endpoint obstruction -/

/-- The total number of prime factors, with multiplicity, gives the elementary
lower bound `2^Ω(n) ≤ n`. -/
theorem twoPow_cardFactors_le (n : ℕ) (hn : n ≠ 0) :
    2 ^ ArithmeticFunction.cardFactors n ≤ n := by
  rw [ArithmeticFunction.cardFactors_apply]
  calc
    2 ^ n.primeFactorsList.length ≤ n.primeFactorsList.prod :=
      List.pow_card_le_prod n.primeFactorsList 2 fun p hp =>
        (Nat.prime_of_mem_primeFactorsList hp).two_le
    _ = n := Nat.prod_primeFactorsList hn

/-- Since `2^m-1 < 2^m`, its total prime multiplicity is at most `m-1`. -/
theorem cardFactors_twoPow_sub_one_le (m : ℕ) (hm : 0 < m) :
    ArithmeticFunction.cardFactors (2 ^ m - 1) ≤ m - 1 := by
  have hb0 : 2 ^ m - 1 ≠ 0 := by
    have : 1 < 2 ^ m := one_lt_pow₀ (by norm_num) hm.ne'
    omega
  have hpow := twoPow_cardFactors_le (2 ^ m - 1) hb0
  have hlt :
      2 ^ ArithmeticFunction.cardFactors (2 ^ m - 1) < 2 ^ m :=
    lt_of_le_of_lt hpow (Nat.sub_lt (Nat.two_pow_pos m) (by norm_num))
  have hOmega : ArithmeticFunction.cardFactors (2 ^ m - 1) < m :=
    (Nat.pow_lt_pow_iff_right (by norm_num : 1 < (2 : ℕ))).mp hlt
  omega

/-- A convenient elementary exponential estimate. -/
theorem addFour_sq_le_twoPow_addFour (k : ℕ) :
    (k + 4) ^ 2 ≤ 2 ^ (k + 4) := by
  induction k with
  | zero => norm_num
  | succ k ih =>
      calc
        (k + 1 + 4) ^ 2 = (k + 5) ^ 2 := by rfl
        _ ≤ 2 * (k + 4) ^ 2 := by
          calc
            (k + 5) ^ 2 ≤ (k + 5) ^ 2 + (k ^ 2 + 6 * k + 7) :=
              Nat.le_add_right _ _
            _ = 2 * (k + 4) ^ 2 := by ring
        _ ≤ 2 * 2 ^ (k + 4) := Nat.mul_le_mul_left 2 ih
        _ = 2 ^ (k + 1 + 4) := by
          rw [show k + 1 + 4 = (k + 4) + 1 by omega, pow_succ]
          ring

/-- The strict numerical inequality which drives the Mersenne obstruction. -/
theorem mersenne_growth (m : ℕ) (hm : 3 ≤ m) :
    m * (m - 2) < 2 ^ m - 1 := by
  rcases Nat.exists_eq_add_of_le hm with ⟨k, rfl⟩
  rcases k with _ | k
  · norm_num
  · have hsquare := addFour_sq_le_twoPow_addFour k
    have hpoly : (k + 4) * ((k + 4) - 2) + 2 ≤ (k + 4) ^ 2 := by
      rw [show k + 4 - 2 = k + 2 by omega]
      calc
        (k + 4) * (k + 2) + 2 ≤
            (k + 4) * (k + 2) + 2 + (2 * k + 6) :=
          Nat.le_add_right _ _
        _ = (k + 4) ^ 2 := by ring
    have hbound : (k + 4) * ((k + 4) - 2) + 2 ≤ 2 ^ (k + 4) :=
      hpoly.trans hsquare
    rw [show 3 + (k + 1) = k + 4 by omega]
    omega

/-- Polynomial form of the endpoint block calculation.  The assumptions say
that the `b` block has moments `(L,E)`, the `c` block is supported at one
prime of multiplicity `m`, and first- and second-order compatibility hold.
The conclusion is the exact scalar equation used below. -/
theorem endpointSinglePrime_energyEquation
    (b c m L E Lc Ec : ℝ)
    (hb : b ≠ 0)
    (hfirst : b * L = c * Lc)
    (hsingle : m * Ec = Lc ^ 2)
    (henergy : c * (b * E - c * Ec) = b * L ^ 2) :
    m * c * E = (m + b) * L ^ 2 := by
  have hsquare := congrArg (fun z : ℝ => z ^ 2) hfirst
  have hmul :
      b * (m * c * E - (m + b) * L ^ 2) = 0 := by
    linear_combination m * henergy + c ^ 2 * hsingle - hsquare
  exact sub_eq_zero.mp ((mul_eq_zero.mp hmul).resolve_left hb)

/-- A strict coefficient ratio and moment Cauchy force the first moment to
vanish.  This is a general lattice statement, independent of Mersenne
numbers. -/
theorem strictMomentRatio_forces_zero
    (A B O L E : ℝ)
    (hA : 0 < A)
    (hratio : O * B < A)
    (hcauchy : L ^ 2 ≤ O * E)
    (hbalance : A * E = B * L ^ 2) :
    L = 0 := by
  by_contra hL
  have hLsq : 0 < L ^ 2 := sq_pos_of_ne_zero hL
  have hle : A * L ^ 2 ≤ (O * B) * L ^ 2 := by
    calc
      A * L ^ 2 ≤ A * (O * E) :=
        mul_le_mul_of_nonneg_left hcauchy hA.le
      _ = O * (A * E) := by ring
      _ = (O * B) * L ^ 2 := by rw [hbalance]; ring
  have hlt : (O * B) * L ^ 2 < A * L ^ 2 :=
    mul_lt_mul_of_pos_right hratio hLsq
  exact (not_lt_of_ge hle) hlt

/-- Moment-level no-go theorem for an endpoint with a single-prime `c`
block.  `O` is the total prime multiplicity of the `b` block. -/
theorem endpointSinglePrime_onlyZeroMoments
    (b c m O L E Lc Ec : ℝ)
    (hb : 0 < b) (hc : 0 < c) (hm : 0 < m)
    (hfirst : b * L = c * Lc)
    (hsingle : m * Ec = Lc ^ 2)
    (henergy : c * (b * E - c * Ec) = b * L ^ 2)
    (hcauchy : L ^ 2 ≤ O * E)
    (hratio : O * (m + b) < m * c) :
    L = 0 ∧ E = 0 ∧ Lc = 0 ∧ Ec = 0 := by
  have hbalance := endpointSinglePrime_energyEquation
    b c m L E Lc Ec hb.ne' hfirst hsingle henergy
  have hmc : 0 < m * c := mul_pos hm hc
  have hL : L = 0 := strictMomentRatio_forces_zero
    (m * c) (m + b) O L E hmc hratio hcauchy (by simpa [mul_assoc] using hbalance)
  have hE : E = 0 := by
    have hzero : (m * c) * E = 0 := by simpa [hL] using hbalance
    exact (mul_eq_zero.mp hzero).resolve_left hmc.ne'
  have hLc : Lc = 0 := by
    rw [hL, mul_zero] at hfirst
    exact (mul_eq_zero.mp hfirst.symm).resolve_left hc.ne'
  have hEc : Ec = 0 := by
    have hzero : m * Ec = 0 := by simpa [hLc] using hsingle
    exact (mul_eq_zero.mp hzero).resolve_left hm.ne'
  exact ⟨hL, hE, hLc, hEc⟩

/-- If both nonempty endpoint blocks have just one prime coordinate, then a
nonzero solution forces one exact numerical ratio.  This completely
classifies the one-coordinate/one-coordinate case. -/
theorem endpointTwoSinglePrime_nonzero_forces_ratio
    (b c m N L E Lc Ec : ℝ)
    (hb : b ≠ 0)
    (hfirst : b * L = c * Lc)
    (hsingleB : N * E = L ^ 2)
    (hsingleC : m * Ec = Lc ^ 2)
    (henergy : c * (b * E - c * Ec) = b * L ^ 2)
    (hL : L ≠ 0) :
    N * (m + b) = m * c := by
  have hbalance := endpointSinglePrime_energyEquation
    b c m L E Lc Ec hb hfirst hsingleC henergy
  have hfactor :
      (m * c - N * (m + b)) * L ^ 2 = 0 := by
    linear_combination N * hbalance - (m * c) * hsingleB
  have hcoefficient : m * c - N * (m + b) = 0 :=
    (mul_eq_zero.mp hfactor).resolve_right (pow_ne_zero 2 hL)
  linarith

/-- The small-support endpoint `(1,3,4)` has only zero first moment. -/
theorem endpoint_three_four_firstMoment_zero
    (L E Lc Ec : ℝ)
    (hfirst : 3 * L = 4 * Lc)
    (hsingleB : E = L ^ 2)
    (hsingleC : 2 * Ec = Lc ^ 2)
    (henergy : 4 * (3 * E - 4 * Ec) = 3 * L ^ 2) :
    L = 0 := by
  by_contra hL
  have hratio := endpointTwoSinglePrime_nonzero_forces_ratio
    3 4 2 1 L E Lc Ec (by norm_num) hfirst (by simpa using hsingleB)
    hsingleC henergy hL
  norm_num at hratio

/-- The small-support endpoint `(1,8,9)` has only zero first moment. -/
theorem endpoint_eight_nine_firstMoment_zero
    (L E Lc Ec : ℝ)
    (hfirst : 8 * L = 9 * Lc)
    (hsingleB : 3 * E = L ^ 2)
    (hsingleC : 2 * Ec = Lc ^ 2)
    (henergy : 9 * (8 * E - 9 * Ec) = 8 * L ^ 2) :
    L = 0 := by
  by_contra hL
  have hratio := endpointTwoSinglePrime_nonzero_forces_ratio
    8 9 2 3 L E Lc Ec (by norm_num) hfirst hsingleB hsingleC henergy hL
  norm_num at hratio

/-- The coefficient ratio required by the endpoint no-go theorem holds for
the Mersenne family. -/
theorem mersenne_strictMomentRatio
    (m : ℕ) (hm : 3 ≤ m) :
    (ArithmeticFunction.cardFactors (2 ^ m - 1) : ℝ) *
        ((m : ℝ) + (2 ^ m - 1 : ℕ)) <
      (m : ℝ) * (2 ^ m : ℕ) := by
  have hm0 : 0 < m := lt_of_lt_of_le (by norm_num) hm
  have hOmegaNat := cardFactors_twoPow_sub_one_le m hm0
  have hgrowthNat := mersenne_growth m hm
  have hOmega :
      (ArithmeticFunction.cardFactors (2 ^ m - 1) : ℝ) ≤ (m - 1 : ℕ) :=
    by exact_mod_cast hOmegaNat
  have hmb : (0 : ℝ) ≤ (m : ℝ) + (2 ^ m - 1 : ℕ) := by positivity
  have hmul := mul_le_mul_of_nonneg_right hOmega hmb
  have hgrowth :
      ((m - 1 : ℕ) : ℝ) * ((m : ℝ) + (2 ^ m - 1 : ℕ)) <
        (m : ℝ) * (2 ^ m : ℕ) := by
    have hmcast : ((m - 1 : ℕ) : ℝ) = (m : ℝ) - 1 := by
      rw [Nat.cast_sub (by omega : 1 ≤ m)]
      norm_num
    have hpowcast : ((2 ^ m - 1 : ℕ) : ℝ) = (2 : ℝ) ^ m - 1 := by
      rw [Nat.cast_sub (by exact Nat.one_le_two_pow), Nat.cast_pow]
      norm_num
    rw [hmcast, hpowcast]
    have hgrowthCastRaw :
        ((m * (m - 2) : ℕ) : ℝ) < ((2 ^ m - 1 : ℕ) : ℝ) := by
      exact_mod_cast hgrowthNat
    have hgrowthCast :
        (m : ℝ) * ((m : ℝ) - 2) < (2 : ℝ) ^ m - 1 := by
      rw [Nat.cast_mul, Nat.cast_sub (by omega : 2 ≤ m), Nat.cast_ofNat,
        hpowcast] at hgrowthCastRaw
      exact hgrowthCastRaw
    rw [Nat.cast_pow, Nat.cast_ofNat]
    nlinarith
  exact hmul.trans_lt hgrowth

/-- Full moment-level Mersenne obstruction.  The data are the moments of
arbitrary prime-dependent weights on `b=2^m-1`; no block-scaling hypothesis
appears. -/
theorem mersenneStraightSecondJet_onlyZeroMoments
    (m : ℕ) (hm : 3 ≤ m)
    (L E Lc Ec : ℝ)
    (hfirst : ((2 ^ m - 1 : ℕ) : ℝ) * L = (2 ^ m : ℕ) * Lc)
    (hsingle : (m : ℝ) * Ec = Lc ^ 2)
    (henergy :
      ((2 ^ m : ℕ) : ℝ) *
          (((2 ^ m - 1 : ℕ) : ℝ) * E - (2 ^ m : ℕ) * Ec) =
        ((2 ^ m - 1 : ℕ) : ℝ) * L ^ 2)
    (hcauchy :
      L ^ 2 ≤ (ArithmeticFunction.cardFactors (2 ^ m - 1) : ℝ) * E) :
    L = 0 ∧ E = 0 ∧ Lc = 0 ∧ Ec = 0 := by
  have hm0 : 0 < m := lt_of_lt_of_le (by norm_num) hm
  have hb : (0 : ℝ) < (2 ^ m - 1 : ℕ) := by
    exact_mod_cast Nat.sub_pos_of_lt
      (one_lt_pow₀ (by norm_num : 1 < (2 : ℕ)) hm0.ne')
  have hc : (0 : ℝ) < (2 ^ m : ℕ) := by positivity
  exact endpointSinglePrime_onlyZeroMoments
    ((2 ^ m - 1 : ℕ) : ℝ) ((2 ^ m : ℕ) : ℝ) (m : ℝ)
    (ArithmeticFunction.cardFactors (2 ^ m - 1) : ℝ)
    L E Lc Ec hb hc (by exact_mod_cast hm0) hfirst hsingle henergy hcauchy
    (mersenne_strictMomentRatio m hm)

/-- Zero weighted square energy with strictly positive multiplicities forces
every prime coordinate to vanish.  This converts the moment-level Mersenne
result into a statement about all individual weights. -/
theorem weightedSquareEnergy_eq_zero_iff
    {ι : Type*} (s : Finset ι) (e x : ι → ℝ)
    (he : ∀ i ∈ s, 0 < e i) :
    (∑ i ∈ s, e i * x i ^ 2) = 0 ↔ ∀ i ∈ s, x i = 0 := by
  constructor
  · intro h i hi
    have hterm : e i * x i ^ 2 = 0 :=
      (Finset.sum_eq_zero_iff_of_nonneg
        (fun j hj => mul_nonneg (he j hj).le (sq_nonneg (x j)))).mp h i hi
    exact (sq_eq_zero_iff.mp ((mul_eq_zero.mp hterm).resolve_left (he i hi).ne'))
  · intro h
    apply Finset.sum_eq_zero
    intro i hi
    simp [h i hi]

/-- Finite-coordinate form of the Mersenne obstruction.  Here `y` contains
all normalized weights at primes dividing `2^m-1`, `e` contains their
positive multiplicities, and `z` is the normalized weight at `2`.  The
theorem derives moment Cauchy internally and concludes that every coordinate
vanishes. -/
theorem mersenneStraightSecondJet_allWeightsZero
    {ι : Type*} (s : Finset ι) (e y : ι → ℝ)
    (m : ℕ) (hm : 3 ≤ m) (z : ℝ)
    (he : ∀ i ∈ s, 0 < e i)
    (hOmega :
      (∑ i ∈ s, e i) =
        (ArithmeticFunction.cardFactors (2 ^ m - 1) : ℝ))
    (hfirst :
      ((2 ^ m - 1 : ℕ) : ℝ) * (∑ i ∈ s, e i * y i) =
        ((2 ^ m : ℕ) : ℝ) * ((m : ℝ) * z))
    (henergy :
      ((2 ^ m : ℕ) : ℝ) *
          (((2 ^ m - 1 : ℕ) : ℝ) *
              (∑ i ∈ s, e i * y i ^ 2) -
            ((2 ^ m : ℕ) : ℝ) * ((m : ℝ) * z ^ 2)) =
        ((2 ^ m - 1 : ℕ) : ℝ) *
          (∑ i ∈ s, e i * y i) ^ 2) :
    (∀ i ∈ s, y i = 0) ∧ z = 0 := by
  let L : ℝ := ∑ i ∈ s, e i * y i
  let E : ℝ := ∑ i ∈ s, e i * y i ^ 2
  let Lc : ℝ := (m : ℝ) * z
  let Ec : ℝ := (m : ℝ) * z ^ 2
  have hcauchy0 := finiteWeightedMomentCauchy s e y
    (fun i hi => (he i hi).le)
  have hcauchy :
      L ^ 2 ≤ (ArithmeticFunction.cardFactors (2 ^ m - 1) : ℝ) * E := by
    dsimp [L, E]
    rw [← hOmega]
    exact hcauchy0
  have hsingle : (m : ℝ) * Ec = Lc ^ 2 := by
    dsimp [Lc, Ec]
    ring
  have hzero := mersenneStraightSecondJet_onlyZeroMoments
    m hm L E Lc Ec (by simpa [L, Lc] using hfirst) hsingle
    (by simpa [L, E, Lc, Ec] using henergy) hcauchy
  have hy : ∀ i ∈ s, y i = 0 := by
    apply (weightedSquareEnergy_eq_zero_iff s e y he).mp
    simpa [E] using hzero.2.1
  have hm0 : (m : ℝ) ≠ 0 := by
    exact_mod_cast (show m ≠ 0 by omega)
  have hz : z = 0 := by
    have : (m : ℝ) * z = 0 := by simpa [Lc] using hzero.2.2.1
    exact (mul_eq_zero.mp this).resolve_left hm0
  exact ⟨hy, hz⟩

end IUTThreeClosures
