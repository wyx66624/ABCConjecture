/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PellLucasAllOrderStaircase20260901
import IUTThreeClosures.PellOddKernelThirdOrderPacket20260901

/-!
# Correlated all-order Pell--Lucas companion staircases

The mathematical arguments precede this module in
`research/ABC_PELL_LUCAS_CORRELATED_ALL_ORDER_EXCLUSION_2026_09_01.md`.

This file kernel-checks only the reusable algebraic core:

* the original product-to-binomial coefficient identity and correlation;
* the exact weighted identity for two correlated coefficient lists;
* the normalized-tail congruence at an arbitrary order;
* the every-order paired correction and recovery of one common half-companion;
* the cross-order determinant-zero relation;
* propagation of channel signs from cubes to sixth powers;
* a finite negative-row extraction with the opposite rank congruence; and
* the elementary half-unit power identity behind the quartic-two column sign.

No Lucas multiplication theorem, Pell rank theorem, perfect-power theorem,
squarefull packet, or abc statement is introduced as an axiom.  Arithmetic
specializations enter the generic interface only as explicit hypotheses.
-/

namespace IUTThreeClosures
namespace PellLucasCorrelatedAllOrderExclusion20260901

open scoped BigOperators

/-! ## Closed-form coefficient correlation -/

/-- Companion coefficient `choose (theta+j) (2*j)`, regarded in `ℚ`. -/
def companionCoeffQ (theta j : ℕ) : ℚ :=
  Nat.choose (theta + j) (2 * j)

/-- The closed form `ell/(2*j+1) * companionCoeffQ`. -/
def firstCoeffQ (ell theta j : ℕ) : ℚ :=
  (ell : ℚ) * companionCoeffQ theta j / (2 * j + 1 : ℕ)

/-- The coefficient identity after the first coefficient has been put into
its closed binomial form.  The substantive passage from the original product
formula to this form is proved in `product_firstCoeff_eq_closedForm` below. -/
theorem rational_coefficient_correlation (ell theta j : ℕ) :
    (2 * j + 1 : ℕ) * firstCoeffQ ell theta j =
      (ell : ℚ) * companionCoeffQ theta j := by
  have hne : ((2 * j + 1 : ℕ) : ℚ) ≠ 0 := by positivity
  simp only [firstCoeffQ]
  field_simp

/-- The product of the odd quadratic factors in the original Lucas
coefficient formula (2.2), evaluated in `ℚ`.  The range index `i` represents
the odd integer `2*i+1`. -/
def lucasOddFactorProductQ (ell j : ℕ) : ℚ :=
  ∏ i ∈ Finset.range j,
    ((ell : ℚ) ^ 2 - ((2 * i + 1 : ℕ) : ℚ) ^ 2)

/-- The first-sequence coefficient in the original product form (2.2). -/
def productFirstCoeffQ (ell j : ℕ) : ℚ :=
  (ell : ℚ) * lucasOddFactorProductQ ell j /
    ((4 : ℚ) ^ j * ((2 * j + 1).factorial : ℚ))

/-- Pairing the descending factors below `theta` with the ascending factors
above it produces one centered descending factorial. -/
theorem centeredFactorProduct_eq_descFactorial (theta j : ℕ) :
    (∏ i ∈ Finset.range j, (theta - i) * (theta + i + 1)) =
      (theta + j).descFactorial (2 * j) := by
  rw [Finset.prod_mul_distrib]
  rw [← Nat.descFactorial_eq_prod_range]
  have hasc : (∏ i ∈ Finset.range j, (theta + i + 1)) =
      (theta + 1).ascFactorial j := by
    rw [Nat.ascFactorial_eq_prod_range]
    apply Finset.prod_congr rfl
    intro i hi
    omega
  rw [hasc, ← Nat.add_descFactorial_eq_ascFactorial]
  have h := Nat.descFactorial_mul_descFactorial (n := theta + j)
    (k := j) (m := 2 * j) (by omega)
  have hsub : 2 * j - j = j := by omega
  rw [hsub] at h
  simpa [Nat.add_sub_cancel_left] using h

/-- For `j ≤ theta`, the raw odd-factor product with `ell = 2*theta+1`
is exactly `4^j` times the centered descending factorial. -/
theorem lucasOddFactorProductQ_eq (theta j : ℕ) (hj : j ≤ theta) :
    lucasOddFactorProductQ (2 * theta + 1) j =
      (4 : ℚ) ^ j * ((theta + j).descFactorial (2 * j) : ℚ) := by
  unfold lucasOddFactorProductQ
  calc
    (∏ i ∈ Finset.range j,
        (((2 * theta + 1 : ℕ) : ℚ) ^ 2 -
          ((2 * i + 1 : ℕ) : ℚ) ^ 2)) =
        ∏ i ∈ Finset.range j,
          (4 : ℚ) * (((theta - i) * (theta + i + 1) : ℕ) : ℚ) := by
      apply Finset.prod_congr rfl
      intro i hi
      have hit : i ≤ theta :=
        le_trans (Nat.le_of_lt (Finset.mem_range.mp hi)) hj
      rw [Nat.cast_mul, Nat.cast_sub hit]
      push_cast
      ring
    _ = (4 : ℚ) ^ j *
        ((∏ i ∈ Finset.range j, (theta - i) * (theta + i + 1) : ℕ) : ℚ) := by
      rw [Finset.prod_mul_distrib, Finset.prod_const, Finset.card_range]
      push_cast
      rfl
    _ = (4 : ℚ) ^ j * ((theta + j).descFactorial (2 * j) : ℚ) := by
      rw [centeredFactorProduct_eq_descFactorial]

/-- The original product formula (2.2) equals the closed binomial formula
used for `firstCoeffQ`.  This is the formal counterpart of the nontrivial
factorial calculation in Theorem 2.1. -/
theorem product_firstCoeff_eq_closedForm (theta j : ℕ) (hj : j ≤ theta) :
    productFirstCoeffQ (2 * theta + 1) j =
      firstCoeffQ (2 * theta + 1) theta j := by
  rw [productFirstCoeffQ, firstCoeffQ, companionCoeffQ,
    lucasOddFactorProductQ_eq theta j hj,
    Nat.descFactorial_eq_factorial_mul_choose]
  push_cast
  rw [show 2 * j + 1 = (2 * j).succ by omega, Nat.factorial_succ]
  push_cast
  have h4 : (4 : ℚ) ^ j ≠ 0 := by positivity
  have hfac : (((2 * j).factorial : ℕ) : ℚ) ≠ 0 := by positivity
  have hodd : (((2 * j).succ : ℕ) : ℚ) ≠ 0 := by positivity
  field_simp

/-- The paper's coefficient correlation, with `c_j` represented by its
original odd-factor product rather than defined from the claimed result. -/
theorem product_coefficient_correlation (theta j : ℕ) (hj : j ≤ theta) :
    (2 * j + 1 : ℕ) * productFirstCoeffQ (2 * theta + 1) j =
      ((2 * theta + 1 : ℕ) : ℚ) * companionCoeffQ theta j := by
  rw [product_firstCoeff_eq_closedForm theta j hj]
  exact rational_coefficient_correlation (2 * theta + 1) theta j

/-- The same identity after multiplying both coefficients by an arbitrary
common scale, such as `32^j` in the balancing-Pell specialization. -/
theorem scaled_rational_coefficient_correlation
    (ell theta j : ℕ) (scale : ℚ) :
    (2 * j + 1 : ℕ) * (scale * firstCoeffQ ell theta j) =
      (ell : ℚ) * (scale * companionCoeffQ theta j) := by
  rw [show ((2 * j + 1 : ℕ) : ℚ) * (scale * firstCoeffQ ell theta j) =
      scale * (((2 * j + 1 : ℕ) : ℚ) * firstCoeffQ ell theta j) by ring,
    rational_coefficient_correlation]
  ring

/-- The scaled correlation with the first coefficient still represented by
the original product formula.  Taking `scale = 32^j` is the coefficient
identity used by the balancing-Pell tails. -/
theorem scaled_product_coefficient_correlation
    (theta j : ℕ) (hj : j ≤ theta) (scale : ℚ) :
    (2 * j + 1 : ℕ) *
        (scale * productFirstCoeffQ (2 * theta + 1) j) =
      ((2 * theta + 1 : ℕ) : ℚ) *
        (scale * companionCoeffQ theta j) := by
  rw [product_firstCoeff_eq_closedForm theta j hj]
  exact scaled_rational_coefficient_correlation
    (2 * theta + 1) theta j scale

/-! ## Exact weighted identity for correlated coefficient lists -/

/-- Two integer coefficient lists are correlated from order `start` when
their heads obey `(2*start+1)*a = ell*b` at every successive order. -/
def CorrelatedFrom (ell start : ℤ) : List ℤ → List ℤ → Prop
  | [], [] => True
  | a :: as, b :: bs =>
      (2 * start + 1) * a = ell * b ∧
        CorrelatedFrom ell (start + 1) as bs
  | _, _ => False

/-- Weighted Horner evaluation of `sum_i (2*(start+i)+1)*a_i*U^(2*i)`. -/
def weightedEvenPowerSum (start U : ℤ) : List ℤ → ℤ
  | [] => 0
  | a :: as =>
      (2 * start + 1) * a + U ^ 2 * weightedEvenPowerSum (start + 1) U as

/-- Exact list form of the differential companion identity. -/
theorem weightedEvenPowerSum_eq_mul
    (ell start U : ℤ) (as bs : List ℤ)
    (hcorr : CorrelatedFrom ell start as bs) :
    weightedEvenPowerSum start U as =
      ell * PellLucasAllOrderStaircase20260901.evenPowerSum U bs := by
  induction as generalizing start bs with
  | nil =>
      cases bs <;> simp [CorrelatedFrom, weightedEvenPowerSum,
        PellLucasAllOrderStaircase20260901.evenPowerSum] at hcorr ⊢
  | cons a as ih =>
      cases bs with
      | nil => simp [CorrelatedFrom] at hcorr
      | cons b bs =>
          rcases hcorr with ⟨hhead, htail⟩
          simp only [weightedEvenPowerSum,
            PellLucasAllOrderStaircase20260901.evenPowerSum]
          rw [ih (start := start + 1) (bs := bs) htail, hhead]
          ring

/-- An even-power Horner tail is congruent to its leading coefficient modulo
`U^2`. -/
theorem evenPowerSum_cons_modEq (U a : ℤ) (as : List ℤ) :
    PellLucasAllOrderStaircase20260901.evenPowerSum U (a :: as) ≡
      a [ZMOD U ^ 2] := by
  apply Int.modEq_of_dvd
  refine ⟨-PellLucasAllOrderStaircase20260901.evenPowerSum U as, ?_⟩
  simp only [PellLucasAllOrderStaircase20260901.evenPowerSum]
  ring

/-- At any tail order, the head coefficient correlation induces the paired
normalized-tail congruence modulo `U^2`. -/
theorem normalized_tail_correlation
    (U ell weight a b : ℤ) (as bs : List ℤ)
    (hcoeff : weight * a = ell * b) :
    weight * PellLucasAllOrderStaircase20260901.evenPowerSum U (a :: as) ≡
      ell * PellLucasAllOrderStaircase20260901.evenPowerSum U
        (b :: bs) [ZMOD U ^ 2] := by
  calc
    weight * PellLucasAllOrderStaircase20260901.evenPowerSum U (a :: as) ≡
        weight * a [ZMOD U ^ 2] :=
      (evenPowerSum_cons_modEq U a as).mul_left weight
    _ = ell * b := hcoeff
    _ ≡ ell * PellLucasAllOrderStaircase20260901.evenPowerSum U
        (b :: bs) [ZMOD U ^ 2] :=
      ((evenPowerSum_cons_modEq U b bs).mul_left ell).symm

/-! ## Every-order paired correction and reconstruction -/

/-- Multiplying a normalized-tail correlation by the companion value gives
the every-order paired correction. -/
theorem everyOrderPairedCorrection
    (U ell weight v E F T : ℤ)
    (hEF : weight * E ≡ ell * F [ZMOD U ^ 2])
    (hT : T = v * F) :
    ell * T ≡ weight * v * E [ZMOD U ^ 2] := by
  rw [hT]
  calc
    ell * (v * F) = v * (ell * F) := by ring
    _ ≡ v * (weight * E) [ZMOD U ^ 2] := hEF.symm.mul_left v
    _ = weight * v * E := by ring

/-- The coefficient used to reconstruct the half-companion is a unit modulo
`U^2` when each of its three factors is a support unit. -/
theorem everyOrderDenominatorUnit
    (U weight E : ℤ)
    (h2 : IsCoprime 2 U)
    (hweight : IsCoprime weight U)
    (hE : IsCoprime E U) :
    IsCoprime (2 * weight * E) (U ^ 2) :=
  ((h2.mul_left hweight).mul_left hE).pow_right

/-- Every normalized tail reconstructs the same half-companion residue. -/
theorem everyOrderSplitter_recovers_halfCompanion
    (U ell weight v E T Z Z0 : ℤ)
    (hv : v = 2 * Z0)
    (hunit : IsCoprime (2 * weight * E) (U ^ 2))
    (hpair : ell * T ≡ weight * v * E [ZMOD U ^ 2])
    (hZ : (2 * weight * E) * Z ≡ ell * T [ZMOD U ^ 2]) :
    Z ≡ Z0 [ZMOD U ^ 2] := by
  have hright : ell * T ≡ (2 * weight * E) * Z0 [ZMOD U ^ 2] := by
    calc
      ell * T ≡ weight * v * E [ZMOD U ^ 2] := hpair
      _ = (2 * weight * E) * Z0 := by rw [hv]; ring
  have hmul : (2 * weight * E) * Z ≡
      (2 * weight * E) * Z0 [ZMOD U ^ 2] := hZ.trans hright
  exact PellLucasAllOrderStaircase20260901.cancel_coprime_factor_modEq
    (U ^ 2) (2 * weight * E) Z Z0 hunit hmul

/-- All tail levels have zero two-by-two determinant modulo `U^2`: they lie
on one projective line after weighting by their odd order. -/
theorem crossOrderDeterminant_zero
    (U ell v wr ws Er Es Tr Ts : ℤ)
    (hell : IsCoprime ell (U ^ 2))
    (hr : ell * Tr ≡ wr * v * Er [ZMOD U ^ 2])
    (hs : ell * Ts ≡ ws * v * Es [ZMOD U ^ 2]) :
    Tr * (ws * Es) ≡ Ts * (wr * Er) [ZMOD U ^ 2] := by
  have hmul : ell * (Tr * (ws * Es)) ≡
      ell * (Ts * (wr * Er)) [ZMOD U ^ 2] := by
    calc
      ell * (Tr * (ws * Es)) = (ell * Tr) * (ws * Es) := by ring
      _ ≡ (wr * v * Er) * (ws * Es) [ZMOD U ^ 2] :=
        hr.mul_right (ws * Es)
      _ = (ws * v * Es) * (wr * Er) := by ring
      _ ≡ (ell * Ts) * (wr * Er) [ZMOD U ^ 2] :=
        hs.symm.mul_right (wr * Er)
      _ = ell * (Ts * (wr * Er)) := by ring
  exact PellLucasAllOrderStaircase20260901.cancel_coprime_factor_modEq
    (U ^ 2) ell (Tr * (ws * Es)) (Ts * (wr * Er)) hell hmul

/-! ## Channel signs and the depth-six specialization -/

/-- A cubic divisor of a channel gives a sixth-power divisor of its square. -/
theorem cube_dvd_channel_gives_sixth_dvd_square
    (q A : ℤ) (h : q ^ 3 ∣ A) : q ^ 6 ∣ A ^ 2 := by
  rcases h with ⟨k, rfl⟩
  refine ⟨k ^ 2, ?_⟩
  ring

/-- Reduction of a positive channel sign from `A^2` to a selected cube
prime's sixth power. -/
theorem positiveChannel_depthSix
    (q A Z : ℤ) (hq : q ^ 3 ∣ A)
    (hZ : Z ≡ 1 [ZMOD A ^ 2]) :
    Z ≡ 1 [ZMOD q ^ 6] :=
  Int.ModEq.of_dvd (cube_dvd_channel_gives_sixth_dvd_square q A hq) hZ

/-- Reduction of a negative channel sign from `B^2` to a selected cube
prime's sixth power. -/
theorem negativeChannel_depthSix
    (r B Z : ℤ) (hr : r ^ 3 ∣ B)
    (hZ : Z ≡ -1 [ZMOD B ^ 2]) :
    Z ≡ -1 [ZMOD r ^ 6] :=
  Int.ModEq.of_dvd (cube_dvd_channel_gives_sixth_dvd_square r B hr) hZ

/-- A recovered half-companion has the two channel signs once the exact
Pell companion identities are supplied. -/
theorem recoveredHalfCompanion_channelSigns
    (A B U Z Z0 : ℤ)
    (hU : U = A * B)
    (hZU : Z ≡ Z0 [ZMOD U ^ 2])
    (hA : Z0 = 2 * A ^ 2 + 1)
    (hB : Z0 = 4 * B ^ 2 - 1) :
    Z ≡ 1 [ZMOD A ^ 2] ∧ Z ≡ -1 [ZMOD B ^ 2] := by
  rcases PellLucasAllOrderStaircase20260901.channel_square_divisors
    U A B hU with ⟨hAdiv, hBdiv⟩
  have hZ0A : Z0 ≡ 1 [ZMOD A ^ 2] := by
    apply Int.modEq_of_dvd
    refine ⟨-2, ?_⟩
    rw [hA]
    ring
  have hZ0B : Z0 ≡ -1 [ZMOD B ^ 2] := by
    apply Int.modEq_of_dvd
    refine ⟨-4, ?_⟩
    rw [hB]
    ring
  exact ⟨(Int.ModEq.of_dvd hAdiv hZU).trans hZ0A,
    (Int.ModEq.of_dvd hBdiv hZU).trans hZ0B⟩

/-- A single recovered half-companion simultaneously carries the positive
and negative sixth-power signs at an opposite depth-three pair. -/
theorem recoveredHalfCompanion_oppositeDepthSix
    (q r A B U Z Z0 : ℤ)
    (hU : U = A * B)
    (hZU : Z ≡ Z0 [ZMOD U ^ 2])
    (hA : Z0 = 2 * A ^ 2 + 1)
    (hB : Z0 = 4 * B ^ 2 - 1)
    (hq : q ^ 3 ∣ A)
    (hr : r ^ 3 ∣ B) :
    Z ≡ 1 [ZMOD q ^ 6] ∧ Z ≡ -1 [ZMOD r ^ 6] := by
  rcases recoveredHalfCompanion_channelSigns A B U Z Z0 hU hZU hA hB with
    ⟨hZA, hZB⟩
  exact ⟨positiveChannel_depthSix q A Z hq hZA,
    negativeChannel_depthSix r B Z hr hZB⟩

/-! ## Vertexwise sign rows and the forced opposite congruence -/

/-- A list of signs with negative product contains a negative entry. -/
theorem exists_negative_of_sign_product
    (xs : List ℤ)
    (hsign : ∀ x ∈ xs, x = 1 ∨ x = -1)
    (hprod : xs.prod = -1) :
    ∃ x ∈ xs, x = -1 := by
  by_contra hnone
  have hall : ∀ x ∈ xs, x = 1 := by
    intro x hx
    rcases hsign x hx with hone | hneg
    · exact hone
    · exact False.elim (hnone ⟨x, hx, hneg⟩)
  have : xs.prod = 1 := List.prod_eq_one hall
  omega

/-- A negative vertex row plus the two opposite rank congruences produces an
actual negative edge whose prime labels sum to a multiple of `2*ell`. -/
theorem negativeRow_forces_oppositeCongruence
    (ell r : ℤ) (qs : List ℤ) (chi : ℤ → ℤ)
    (hsign : ∀ q ∈ qs, chi q = 1 ∨ chi q = -1)
    (hprod : (qs.map chi).prod = -1)
    (hq : ∀ q ∈ qs, q ≡ 1 [ZMOD 2 * ell])
    (hr : r ≡ -1 [ZMOD 2 * ell]) :
    ∃ q ∈ qs, chi q = -1 ∧ (2 * ell) ∣ q + r := by
  have mappedSign : ∀ x ∈ qs.map chi, x = 1 ∨ x = -1 := by
    intro x hx
    rcases List.mem_map.mp hx with ⟨q, hqmem, rfl⟩
    exact hsign q hqmem
  rcases exists_negative_of_sign_product (qs.map chi) mappedSign hprod with
    ⟨x, hx, hneg⟩
  rcases List.mem_map.mp hx with ⟨q, hqmem, rfl⟩
  refine ⟨q, hqmem, hneg, ?_⟩
  have hadd : q + r ≡ 0 [ZMOD 2 * ell] := by
    simpa using (hq q hqmem).add hr
  have hneg : (2 * ell) ∣ -(q + r) := by simpa using hadd.dvd
  exact (dvd_neg.mp hneg)

/-! ## The algebra behind the quartic-two column sign -/

/-- If `two * B^2 = 1`, the Euler half-power of `B` times the corresponding
quarter-power of `two` is one.  In `ZMod q` with `q = 1 mod 8`, both factors
are signs, so they are equal. -/
theorem halfUnit_power_product
    {R : Type*} [CommMonoid R] (two B : R) (n : ℕ)
    (hhalf : two * B ^ 2 = 1) :
    B ^ (2 * n) * two ^ n = 1 := by
  calc
    B ^ (2 * n) * two ^ n = (B ^ 2) ^ n * two ^ n := by rw [pow_mul]
    _ = (B ^ 2 * two) ^ n := (mul_pow (B ^ 2) two n).symm
    _ = 1 := by rw [mul_comm, hhalf]; simp

#check rational_coefficient_correlation
#check product_firstCoeff_eq_closedForm
#check product_coefficient_correlation
#check scaled_rational_coefficient_correlation
#check scaled_product_coefficient_correlation
#check weightedEvenPowerSum_eq_mul
#check normalized_tail_correlation
#check everyOrderPairedCorrection
#check everyOrderDenominatorUnit
#check everyOrderSplitter_recovers_halfCompanion
#check crossOrderDeterminant_zero
#check cube_dvd_channel_gives_sixth_dvd_square
#check positiveChannel_depthSix
#check negativeChannel_depthSix
#check recoveredHalfCompanion_channelSigns
#check recoveredHalfCompanion_oppositeDepthSix
#check exists_negative_of_sign_product
#check negativeRow_forces_oppositeCongruence
#check halfUnit_power_product

#print axioms rational_coefficient_correlation
#print axioms product_firstCoeff_eq_closedForm
#print axioms product_coefficient_correlation
#print axioms scaled_rational_coefficient_correlation
#print axioms scaled_product_coefficient_correlation
#print axioms weightedEvenPowerSum_eq_mul
#print axioms normalized_tail_correlation
#print axioms everyOrderPairedCorrection
#print axioms everyOrderDenominatorUnit
#print axioms everyOrderSplitter_recovers_halfCompanion
#print axioms crossOrderDeterminant_zero
#print axioms cube_dvd_channel_gives_sixth_dvd_square
#print axioms positiveChannel_depthSix
#print axioms negativeChannel_depthSix
#print axioms recoveredHalfCompanion_channelSigns
#print axioms recoveredHalfCompanion_oppositeDepthSix
#print axioms exists_negative_of_sign_product
#print axioms negativeRow_forces_oppositeCongruence
#print axioms halfUnit_power_product

end PellLucasCorrelatedAllOrderExclusion20260901
end IUTThreeClosures
