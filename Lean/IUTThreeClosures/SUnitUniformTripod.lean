/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TripodWeilHeight
import Mathlib.Algebra.Order.Ring.Unbundled.Rat

/-!
# The uniform rational S-unit/tripod reformulation of abc

For a rational number in lowest terms, `rationalPrimeSupport` is the union of
the prime support of its numerator and denominator.  The tripod support of
`x` is the union of the supports of `x` and `1-x`.  This file proves:

* at `x = a/c` for an `ABCPoint`, the tripod support is exactly the prime
  support of `abc`;
* the rational Weil height is exactly `log c`;
* every rational `0 < x < 1` canonically gives an `ABCPoint` with coordinate
  `x`;
* consequently, the logarithmic abc conjecture is equivalent to a uniform
  truncated-support height bound for rational solutions of
  `x + (1-x) = 1`;
* fixed-support finiteness alone does not imply such a uniform bound, via a
  fully explicit abstract countermodel.

No S-unit finiteness theorem, Baker estimate, Subspace Theorem, abc estimate,
or target inequality is stored as data in this module.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-! ## Rational prime supports and the tripod equation -/

/-- Prime divisors of the reduced numerator or denominator of a rational. -/
def rationalPrimeSupport (x : ℚ) : Finset ℕ :=
  x.num.natAbs.primeFactors ∪ x.den.primeFactors

/-- Truncated finite-prime support of the divisors `0,1,∞` at `x`. -/
def rationalTripodPrimeSupport (x : ℚ) : Finset ℕ :=
  rationalPrimeSupport x ∪ rationalPrimeSupport (1 - x)

/-- Elementary meaning of being a rational S-unit outside `S`. -/
def IsRationalSUnitOutside (S : Finset ℕ) (x : ℚ) : Prop :=
  rationalPrimeSupport x ⊆ S

/-- Both summands of the rational S-unit equation are supported in `S`
exactly when the tripod support is contained in `S`. -/
theorem tripod_support_subset_iff (S : Finset ℕ) (x : ℚ) :
    rationalTripodPrimeSupport x ⊆ S ↔
      IsRationalSUnitOutside S x ∧ IsRationalSUnitOutside S (1 - x) := by
  constructor
  · intro h
    exact ⟨Finset.subset_union_left.trans h,
      Finset.subset_union_right.trans h⟩
  · rintro ⟨hx, h1x⟩
    exact Finset.union_subset hx h1x

/-- The complementary rational coordinates tautologically solve the S-unit
equation. -/
theorem rational_tripod_equation (x : ℚ) : x + (1 - x) = 1 := by
  ring

/-- Product of a finite prime-support set. -/
def finiteSupportRadical (S : Finset ℕ) : ℕ :=
  ∏ p ∈ S, p

/-- Logarithmic truncated counting mass of the rational tripod. -/
noncomputable def rationalTripodCounting (x : ℚ) : ℝ :=
  Real.log (finiteSupportRadical (rationalTripodPrimeSupport x) : ℝ)

/-- The actual normalized rational Weil height used in the uniform
reformulation. -/
noncomputable def rationalTripodHeight (x : ℚ) : ℝ :=
  Heights.normalizedLogHeight ℚ x

namespace ABCPoint

/-- At the tripod coordinate of a primitive positive abc point, the rational
prime support is exactly the support of `abc`. -/
theorem rationalTripodPrimeSupport_lambda (P : ABCPoint) :
    rationalTripodPrimeSupport P.lambda =
      (P.a * P.b * P.c).primeFactors := by
  rw [Nat.primeFactors_mul (mul_ne_zero P.a_pos.ne' P.b_pos.ne') P.c_pos.ne',
    Nat.primeFactors_mul P.a_pos.ne' P.b_pos.ne']
  simp [rationalTripodPrimeSupport, rationalPrimeSupport,
    P.lambda_num, P.lambda_den, P.one_sub_lambda_num,
    P.one_sub_lambda_den, Finset.union_left_comm,
    Finset.union_comm]

/-- The finite-support product at `lambda` is the standard abc radical. -/
theorem finiteSupportRadical_lambda (P : ABCPoint) :
    finiteSupportRadical (rationalTripodPrimeSupport P.lambda) =
      abcRadical (P.a * P.b * P.c) := by
  rw [P.rationalTripodPrimeSupport_lambda]
  rfl

/-- The rational tripod count is exactly the elementary abc conductor. -/
theorem rationalTripodCounting_lambda (P : ABCPoint) :
    rationalTripodCounting P.lambda = P.conductor := by
  rw [rationalTripodCounting, P.finiteSupportRadical_lambda]
  rfl

/-- The rational tripod height is exactly the abc height. -/
theorem rationalTripodHeight_lambda (P : ABCPoint) :
    rationalTripodHeight P.lambda = P.height := by
  exact P.normalizedLogHeight_lambda

/-- In particular the tripod height is exactly `log c`. -/
theorem rationalTripodHeight_lambda_eq_log_c (P : ABCPoint) :
    rationalTripodHeight P.lambda = Real.log (P.c : ℝ) := by
  rw [P.rationalTripodHeight_lambda, P.height_eq_log_c]

/-! ## Every rational point between zero and one gives an abc point -/

/-- The positive reduced numerator, used as `a` in the inverse construction. -/
def ratNumerator (x : ℚ) : ℕ := x.num.natAbs

/-- The reduced denominator, used as `c` in the inverse construction. -/
def ratDenominator (x : ℚ) : ℕ := x.den

theorem ratNumerator_pos {x : ℚ} (hx : 0 < x) :
    0 < ratNumerator x := by
  have hnum : 0 < x.num := Rat.num_pos.mpr hx
  exact Int.natAbs_pos.mpr hnum.ne'

theorem ratNumerator_lt_denominator {x : ℚ} (hx0 : 0 < x) (hx1 : x < 1) :
    ratNumerator x < ratDenominator x := by
  have hnum : 0 < x.num := Rat.num_pos.mpr hx0
  have hlt : x.num < (x.den : ℤ) := Rat.num_lt_denom_iff.mpr hx1
  have habs : (x.num.natAbs : ℤ) = x.num := Int.natAbs_of_nonneg hnum.le
  exact_mod_cast (habs.trans_lt hlt)

/-- The canonical positive primitive triple associated to `0<x<1`:
`(|num x|, den x - |num x|, den x)`. -/
def ofRat (x : ℚ) (hx0 : 0 < x) (hx1 : x < 1) : ABCPoint where
  a := ratNumerator x
  b := ratDenominator x - ratNumerator x
  c := ratDenominator x
  a_pos := ratNumerator_pos hx0
  b_pos := Nat.sub_pos_iff_lt.mpr (ratNumerator_lt_denominator hx0 hx1)
  c_pos := x.den_pos
  sum_eq := Nat.add_sub_of_le (Nat.le_of_lt (ratNumerator_lt_denominator hx0 hx1))
  pairwise_coprime := by
    have hle : ratNumerator x ≤ ratDenominator x :=
      Nat.le_of_lt (ratNumerator_lt_denominator hx0 hx1)
    have hcop : Nat.Coprime (ratNumerator x) (ratDenominator x) := by
      exact x.reduced
    exact ⟨
      (Nat.coprime_sub_self_right hle).mpr hcop,
      (Nat.coprime_self_sub_left hle).mpr hcop,
      hcop.symm⟩

@[simp] theorem ofRat_a (x : ℚ) (hx0 : 0 < x) (hx1 : x < 1) :
    (ofRat x hx0 hx1).a = x.num.natAbs := rfl

@[simp] theorem ofRat_b (x : ℚ) (hx0 : 0 < x) (hx1 : x < 1) :
    (ofRat x hx0 hx1).b = x.den - x.num.natAbs := rfl

@[simp] theorem ofRat_c (x : ℚ) (hx0 : 0 < x) (hx1 : x < 1) :
    (ofRat x hx0 hx1).c = x.den := rfl

/-- The inverse construction recovers the original rational coordinate. -/
theorem ofRat_lambda (x : ℚ) (hx0 : 0 < x) (hx1 : x < 1) :
    (ofRat x hx0 hx1).lambda = x := by
  have hnum : 0 < x.num := Rat.num_pos.mpr hx0
  have habs : (x.num.natAbs : ℤ) = x.num := Int.natAbs_of_nonneg hnum.le
  have hcast : (x.num.natAbs : ℚ) = (x.num : ℚ) := by
    calc
      (x.num.natAbs : ℚ) = ((x.num.natAbs : ℤ) : ℚ) := by simp
      _ = (x.num : ℚ) := by rw [habs]
  rw [ABCPoint.lambda, ofRat_a, ofRat_c]
  rw [hcast]
  exact x.num_div_den

end ABCPoint

/-! ## Exact equivalence with the uniform rational S-unit bound -/

/-- The quantifier-correct uniform rational tripod statement.  The constant
depends on `epsilon` but not on `x` or its varying prime support. -/
def UniformRationalSUnitTripodBound : Prop :=
  ∀ ε : ℝ, 0 < ε →
    ∃ C : ℝ, ∀ x : ℚ, 0 < x → x < 1 →
      rationalTripodHeight x ≤
        (1 + ε) * rationalTripodCounting x + C

/-- The abc conjecture gives the uniform rational S-unit/tripod bound. -/
theorem uniformRationalSUnitTripodBound_of_abc
    (habc : ABCConjecture) : UniformRationalSUnitTripodBound := by
  intro ε hε
  obtain ⟨C, hC⟩ := habc ε hε
  refine ⟨C, ?_⟩
  intro x hx0 hx1
  let P : ABCPoint := ABCPoint.ofRat x hx0 hx1
  have hP := hC P.a P.b P.c P.a_pos P.b_pos P.c_pos
    P.sum_eq P.pairwise_coprime
  have hP' : P.height ≤ (1 + ε) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using hP
  rw [← ABCPoint.ofRat_lambda x hx0 hx1]
  change rationalTripodHeight P.lambda ≤
    (1 + ε) * rationalTripodCounting P.lambda + C
  rw [P.rationalTripodHeight_lambda, P.rationalTripodCounting_lambda]
  exact hP'

/-- The uniform rational S-unit/tripod bound gives the abc conjecture. -/
theorem abc_of_uniformRationalSUnitTripodBound
    (htripod : UniformRationalSUnitTripodBound) : ABCConjecture := by
  intro ε hε
  obtain ⟨C, hC⟩ := htripod ε hε
  refine ⟨C, ?_⟩
  intro a b c ha hb hc hsum hcop
  let P : ABCPoint :=
    { a := a, b := b, c := c, a_pos := ha, b_pos := hb, c_pos := hc,
      sum_eq := hsum, pairwise_coprime := hcop }
  have hP := hC P.lambda P.lambda_pos P.lambda_lt_one
  have hP' : P.height ≤ (1 + ε) * P.conductor + C := by
    simpa [P.rationalTripodHeight_lambda, P.rationalTripodCounting_lambda] using hP
  simpa [ABCPoint.height, ABCPoint.conductor, P] using hP'

/-- Exact elementary reformulation: uniform rational S-unit/tripod height is
neither weaker nor stronger than logarithmic abc. -/
theorem abcConjecture_iff_uniformRationalSUnitTripodBound :
    ABCConjecture ↔ UniformRationalSUnitTripodBound :=
  ⟨uniformRationalSUnitTripodBound_of_abc,
    abc_of_uniformRationalSUnitTripodBound⟩

/-! ## A pure quantifier countermodel -/

/-- Abstract support with one label per point. -/
def toySupport (n : ℕ) : Finset ℕ := {n}

/-- Every fixed finite support admits only finitely many toy points. -/
theorem toy_fixed_support_finite (S : Finset ℕ) :
    Set.Finite {n : ℕ | toySupport n ⊆ S} := by
  simp [toySupport]

/-- Nevertheless fixed-support finiteness does not supply a uniform height
bound linear in support cardinality.  This is only a logical countermodel and
does not refute any assertion about actual S-unit equations. -/
theorem toy_no_uniform_card_linear_bound :
    ¬ ∃ A B : ℝ, ∀ n : ℕ,
      (n : ℝ) ≤ A * (toySupport n).card + B := by
  rintro ⟨A, B, h⟩
  obtain ⟨n : ℕ, hn⟩ := exists_nat_gt (A + B)
  have hn' := h n
  simp [toySupport] at hn'
  linarith

end IUTThreeClosures
