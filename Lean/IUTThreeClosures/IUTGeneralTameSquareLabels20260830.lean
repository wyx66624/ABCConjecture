/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Field.ZMod
import Mathlib.Data.Nat.Prime.Basic
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Ring

/-!
# Finite arithmetic for the general tame square-label construction

The mathematical proof precedes this module in
`research/IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md`.

This module proves uniqueness of the possible exceptional half-range
quadratic label, the finite bad-index budget and its avoidance consequence,
and the signs and scale identities of the integer hull exponents.

It does not formalize a local field, logarithm, Galois-group automorphism,
trace-dual lattice, pilot source, or Haar measure. No such assertion is
introduced as an axiom or concealed in an unconditional conclusion.
-/

namespace IUTThreeClosures.IUTGeneralTameSquareLabels20260830

/-- The number of nonzero square labels in the chosen half range. -/
def halfLabels (ell : ℕ) : ℕ := (ell - 1) / 2

/-- The point-orbit budget plus the worst whole-orbit budget. -/
def badIndexBudget (ell : ℕ) : ℕ :=
  15 * halfLabels ell + (halfLabels ell - 1 + ell)

/-- For an odd prime in scope, the half range has exactly `(ell-1)/2` labels. -/
theorem two_halfLabels_add_one {ell : ℕ} (hp : Nat.Prime ell) (hell : 7 ≤ ell) :
    2 * halfLabels ell + 1 = ell := by
  have hodd := hp.eq_two_or_odd
  unfold halfLabels
  omega

/-- The precise worst-case budget, including the possible short whole orbit. -/
theorem badIndexBudget_eq {ell : ℕ} (hp : Nat.Prime ell) (hell : 7 ≤ ell) :
    badIndexBudget ell = 9 * ell - 9 := by
  have hhalf := two_halfLabels_add_one hp hell
  unfold badIndexBudget
  omega

/-- The budget is strictly smaller than the complete tame inertia orbit. -/
theorem badIndexBudget_lt {ell : ℕ} (hp : Nat.Prime ell) (hell : 7 ≤ ell) :
    badIndexBudget ell < 15 * ell := by
  rw [badIndexBudget_eq hp hell]
  omega

/-- The congruence supplies enough residue-field elements for all the forbidden kernels. -/
theorem residue_card_gt_label_count {ell p : ℕ} (hell : 7 ≤ ell)
    (hcong : p % (30 * ell) = 30 * ell - 1) : ell < p := by
  have hmod := Nat.mod_le p (30 * ell)
  rw [hcong] at hmod
  omega

/-- A finite bad set satisfying the proved budget leaves an actual inertia index.
The hypothesis is a finite-cardinality statement, not an assertion that a local
Galois action has already been formalized. -/
theorem exists_index_outside_bad {ell : ℕ} (hp : Nat.Prime ell) (hell : 7 ≤ ell)
    (bad : Finset (Fin (15 * ell))) (hbad : bad.card ≤ badIndexBudget ell) :
    ∃ t : Fin (15 * ell), t ∉ bad := by
  classical
  have hlt : bad.card < 15 * ell := lt_of_le_of_lt hbad (badIndexBudget_lt hp hell)
  by_contra hnone
  push Not at hnone
  have heq : bad = Finset.univ := by
    ext t
    simp [hnone t]
  simp [heq] at hlt

/-- There is at most one label in the half range with the exceptional whole
character. This is the actual congruence `30*j^2+1 = 0`, not an assumed
one-exception interface. -/
theorem exceptional_half_label_unique {ell j k : ℕ} (hp : Nat.Prime ell)
    (hj : 0 < j) (hk : 0 < k) (hjr : 2 * j < ell) (hkr : 2 * k < ell)
    (hjroot : (30 : ZMod ell) * (j : ZMod ell) ^ 2 + 1 = 0)
    (hkroot : (30 : ZMod ell) * (k : ZMod ell) ^ 2 + 1 = 0) : j = k := by
  letI : Fact (Nat.Prime ell) := ⟨hp⟩
  have h30 : (30 : ZMod ell) ≠ 0 := by
    intro hzero
    simp [hzero] at hjroot
  have hmul : (30 : ZMod ell) * (j : ZMod ell) ^ 2 =
      (30 : ZMod ell) * (k : ZMod ell) ^ 2 := by
    linear_combination hjroot - hkroot
  have hsq : (j : ZMod ell) ^ 2 = (k : ZMod ell) ^ 2 :=
    mul_left_cancel₀ h30 hmul
  have hprod : ((j : ZMod ell) - (k : ZMod ell)) *
      ((j : ZMod ell) + (k : ZMod ell)) = 0 := by
    calc
      _ = (j : ZMod ell) ^ 2 - (k : ZMod ell) ^ 2 := by ring
      _ = 0 := sub_eq_zero.mpr hsq
  rcases mul_eq_zero.mp hprod with hminus | hplus
  · have heq := congrArg ZMod.val (sub_eq_zero.mp hminus)
    simpa only [ZMod.val_natCast_of_lt (by omega : j < ell),
      ZMod.val_natCast_of_lt (by omega : k < ell)] using heq
  · have hcast : ((j + k : ℕ) : ZMod ell) = 0 := by
      simpa only [Nat.cast_add] using hplus
    have hdvd := (ZMod.natCast_eq_zero_iff (j + k) ell).mp hcast
    exact False.elim ((Nat.not_dvd_of_pos_of_lt (by omega : 0 < j + k)
      (by omega : j + k < ell)) hdvd)

/-- The integer part of the native valuation `2*j^2/ell`. -/
def wholeContent (ell j : ℕ) : ℕ := 2 * j ^ 2 / ell

/-- The half-range prime hypotheses force a genuinely nonintegral native ratio. -/
theorem prime_not_dvd_two_square {ell j : ℕ} (hp : Nat.Prime ell) (hell : 7 ≤ ell)
    (hj : 0 < j) (hjr : 2 * j < ell) : ¬ell ∣ 2 * j ^ 2 := by
  intro hdvd
  rcases hp.dvd_mul.mp hdvd with htwo | hsq
  · have hle := Nat.le_of_dvd (by decide : 0 < 2) htwo
    omega
  · exact (Nat.not_dvd_of_pos_of_lt hj (by omega : j < ell))
      (hp.dvd_of_dvd_pow hsq)

/-- The actual strict floor/ceiling bracket, so the floor-plus-one is the
ceiling of the native ratio in every prime label of the paper. -/
theorem content_strict_sandwich {ell j : ℕ} (hp : Nat.Prime ell) (hell : 7 ≤ ell)
    (hj : 0 < j) (hjr : 2 * j < ell) :
    ell * wholeContent ell j < 2 * j ^ 2 ∧
      2 * j ^ 2 < ell * (wholeContent ell j + 1) := by
  have hn := prime_not_dvd_two_square hp hell hj hjr
  have hmodne : (2 * j ^ 2) % ell ≠ 0 := by
    simpa only [Nat.dvd_iff_mod_eq_zero] using hn
  have hmodlt := Nat.mod_lt (2 * j ^ 2) hp.pos
  have hmodpos : 0 < (2 * j ^ 2) % ell := Nat.pos_of_ne_zero hmodne
  have hidentity := Nat.mod_add_div (2 * j ^ 2) ell
  unfold wholeContent
  constructor <;> nlinarith

/-- The floor-plus-one content is bounded by the label in the strict half range.
For the prime labels in the paper this is the actual ceiling, since the ratio
is nonintegral. This elementary bound itself needs no primality assumption. -/
theorem wholeContent_add_one_le {ell j : ℕ} (hj : 0 < j) (hjr : 2 * j < ell) :
    wholeContent ell j + 1 ≤ j := by
  have hell : 0 < ell := by omega
  have hmul : 2 * j ^ 2 < ell * j := by
    have h := Nat.mul_lt_mul_of_pos_right hjr hj
    nlinarith
  have hdiv : 2 * j ^ 2 / ell < j :=
    (Nat.div_lt_iff_lt_mul hell).mpr (by simpa [Nat.mul_comm] using hmul)
  exact Nat.succ_le_of_lt hdiv

/-- Normalized point-hull valuation exponent in the genuine uniformizer. -/
def pointExponent (ell j : ℕ) : ℤ :=
  15 * (ell : ℤ) * ((wholeContent ell j + 1 : ℕ) : ℤ) -
    (15 * (ell : ℤ) - 1) * ((j : ℤ) + 1)

/-- Normalized whole-product valuation exponent. -/
def wholeExponent (ell j : ℕ) : ℤ :=
  15 * (ell : ℤ) * (wholeContent ell j : ℤ) -
    (15 * (ell : ℤ) - 1) * ((j : ℤ) + 1)

/-- The exact one-factor-of-`p` gap on uniformizer exponents. -/
theorem wholeExponent_eq_point_sub (ell j : ℕ) :
    wholeExponent ell j = pointExponent ell j - 15 * (ell : ℤ) := by
  simp only [wholeExponent, pointExponent, Nat.cast_add, Nat.cast_one]
  ring

/-- The useful uniform upper bound on every normalized point exponent. -/
theorem pointExponent_le {ell j : ℕ} (hj : 0 < j) (hjr : 2 * j < ell) :
    pointExponent ell j ≤ (j : ℤ) + 1 - 15 * (ell : ℤ) := by
  have hcontent : ((wholeContent ell j + 1 : ℕ) : ℤ) ≤ (j : ℤ) := by
    exact_mod_cast wholeContent_add_one_le hj hjr
  have hmul := mul_le_mul_of_nonneg_left hcontent (by positivity : (0 : ℤ) ≤ 15 * ell)
  unfold pointExponent
  nlinarith

/-- Negative normalized point exponents throughout the strict half range. -/
theorem pointExponent_neg {ell j : ℕ} (hj : 0 < j) (hjr : 2 * j < ell) :
    pointExponent ell j < 0 := by
  have hle := pointExponent_le hj hjr
  have hji : (0 : ℤ) < j := by exact_mod_cast hj
  have hr : 2 * (j : ℤ) < ell := by exact_mod_cast hjr
  omega

/-- Negative normalized whole-product exponents, with the same label range. -/
theorem wholeExponent_neg {ell j : ℕ} (hj : 0 < j) (hjr : 2 * j < ell) :
    wholeExponent ell j < 0 := by
  rw [wholeExponent_eq_point_sub]
  have hp := pointExponent_neg hj hjr
  have hell : (0 : ℤ) < ell := by exact_mod_cast (by omega : 0 < ell)
  omega

/-- Scaling all `j+1` coordinates by `p` gives the precise standard exponent. -/
theorem pointExponent_standard_scale (ell j : ℕ) :
    pointExponent ell j + 15 * (ell : ℤ) * ((j : ℤ) + 1) =
      15 * (ell : ℤ) * ((wholeContent ell j + 1 : ℕ) : ℤ) + ((j : ℤ) + 1) := by
  unfold pointExponent
  ring

/-- The corresponding identity for the whole-product source. -/
theorem wholeExponent_standard_scale (ell j : ℕ) :
    wholeExponent ell j + 15 * (ell : ℤ) * ((j : ℤ) + 1) =
      15 * (ell : ℤ) * (wholeContent ell j : ℤ) + ((j : ℤ) + 1) := by
  unfold wholeExponent
  ring

/-- Standard-scale valuation exponents are positive, not positive log volumes. -/
theorem pointExponent_standard_pos (ell j : ℕ) :
    0 < pointExponent ell j + 15 * (ell : ℤ) * ((j : ℤ) + 1) := by
  rw [pointExponent_standard_scale]
  positivity

/-- The consistently rescaled whole-product exponent is also positive. -/
theorem wholeExponent_standard_pos (ell j : ℕ) :
    0 < wholeExponent ell j + 15 * (ell : ℤ) * ((j : ℤ) + 1) := by
  rw [wholeExponent_standard_scale]
  positivity

#print axioms exceptional_half_label_unique
#print axioms exists_index_outside_bad
#print axioms content_strict_sandwich
#print axioms pointExponent_neg
#print axioms wholeExponent_standard_pos

end IUTThreeClosures.IUTGeneralTameSquareLabels20260830
