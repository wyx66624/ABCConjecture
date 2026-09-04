/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCValuationIncidenceComplex20260903

/-!
# Coefficient-one scale-budget obstruction for valuation incidence

The ordinary proof appears first in
`research/ABC_VALUATION_INCIDENCE_SCALE_BUDGET_OBSTRUCTION_2026_09_03.md`.

For `k : ℕ`, consider the primitive nonunit datum

`(2 ^ (2 * (k + 1)), 3 ^ (k + 1), 2 ^ (2 * (k + 1)) + 3 ^ (k + 1))`.

An `AB`-reconstructing face must contain the unique support vertex on each
summand arm.  Its two additive defect degrees therefore sum to `3 * k + 1`.
The least binary exponent dominating the sum arm is at most `2 * k + 3`.
Consequently every coefficient-one binary-scale budget with a fixed additive
slack fails on an infinite tail of this family.

The final theorem also includes the quantitative radical-defect inequality
from VIC-1R and refutes its all-but-finitely-many formulation.  Only this
specific selector is retired.  No claim about the valuation-incidence
complex as a whole, or about the `abc` conjecture, is made.
-/

namespace IUTThreeClosures
namespace ABCValuationIncidenceScaleBudgetObstruction20260903

open ABCValuationIncidenceComplex20260903

abbrev PrimitiveABC :=
  ABCValuationIncidenceComplex20260903.PrimitiveABC
abbrev Face (P : PrimitiveABC) :=
  ABCValuationIncidenceComplex20260903.Face P

/-! ## The least binary scale -/

/-- Every natural number is dominated by a power of two. -/
theorem exists_le_two_pow (n : ℕ) : ∃ s : ℕ, n ≤ 2 ^ s := by
  refine ⟨(Nat.log 2 n).succ, ?_⟩
  exact (Nat.lt_pow_succ_log_self (by norm_num : 1 < (2 : ℕ)) n).le

/-- The least exponent `s` for which `n ≤ 2 ^ s`. -/
def binaryScale (n : ℕ) : ℕ :=
  Nat.find (exists_le_two_pow n)

/-- The defining domination property of the least binary scale. -/
theorem le_two_pow_binaryScale (n : ℕ) : n ≤ 2 ^ binaryScale n := by
  exact Nat.find_spec (exists_le_two_pow n)

/-- Minimality of the binary scale. -/
theorem binaryScale_le_of_le_two_pow {n s : ℕ} (h : n ≤ 2 ^ s) :
    binaryScale n ≤ s := by
  exact Nat.find_min' (exists_le_two_pow n) h

/-- Exact least-exponent characterization of the binary scale. -/
theorem binaryScale_le_iff {n s : ℕ} :
    binaryScale n ≤ s ↔ n ≤ 2 ^ s := by
  constructor
  · intro h
    exact (le_two_pow_binaryScale n).trans
      (Nat.pow_le_pow_right (by norm_num : 0 < (2 : ℕ)) h)
  · exact binaryScale_le_of_le_two_pow

/-! ## The balanced two-prime family -/

/-- The family `Q_(k+1) = (2^(2(k+1)), 3^(k+1), sum)`. -/
def balancedTwoPrimeDatum (k : ℕ) : PrimitiveABC where
  a := 2 ^ (2 * (k + 1))
  b := 3 ^ (k + 1)
  c := 2 ^ (2 * (k + 1)) + 3 ^ (k + 1)
  a_gt_one := Nat.one_lt_pow (by omega) (by norm_num)
  b_gt_one := Nat.one_lt_pow (by omega) (by norm_num)
  sum_eq := rfl
  coprime_ab := ((by norm_num : Nat.Coprime 2 3).pow_left _).pow_right _

/-- The balanced family is injectively parametrized. -/
theorem balancedTwoPrimeDatum_injective :
    Function.Injective balancedTwoPrimeDatum := by
  intro k l hdatum
  have ha := congrArg (fun P : PrimitiveABC => P.a) hdatum
  simp only [balancedTwoPrimeDatum] at ha
  have hexponents :=
    Nat.pow_right_injective (by norm_num : 2 ≤ (2 : ℕ)) ha
  omega

/-- The `A` arm has the unique prime support vertex `2`. -/
theorem balanced_A_primeFactors (k : ℕ) :
    (ABCValuationIncidenceComplex20260903.coordinate
      (balancedTwoPrimeDatum k) .A).primeFactors = {2} := by
  simp only [ABCValuationIncidenceComplex20260903.coordinate,
    balancedTwoPrimeDatum]
  rw [Nat.primeFactors_prime_pow (by omega : 2 * (k + 1) ≠ 0)
    Nat.prime_two]

/-- The `B` arm has the unique prime support vertex `3`. -/
theorem balanced_B_primeFactors (k : ℕ) :
    (ABCValuationIncidenceComplex20260903.coordinate
      (balancedTwoPrimeDatum k) .B).primeFactors = {3} := by
  simp only [ABCValuationIncidenceComplex20260903.coordinate,
    balancedTwoPrimeDatum]
  rw [Nat.primeFactors_prime_pow (by omega : k + 1 ≠ 0)
    Nat.prime_three]

/-- Exact valuation carried by the unique `A` vertex. -/
theorem balanced_A_valuation_two (k : ℕ) :
    ABCValuationIncidenceComplex20260903.Face.valuation
      (balancedTwoPrimeDatum k) .A 2 = 2 * (k + 1) := by
  simp only [ABCValuationIncidenceComplex20260903.Face.valuation,
    ABCValuationIncidenceComplex20260903.coordinate,
    balancedTwoPrimeDatum]
  rw [(by norm_num : Nat.Prime 2).factorization_pow]
  simp

/-- Exact valuation carried by the unique `B` vertex. -/
theorem balanced_B_valuation_three (k : ℕ) :
    ABCValuationIncidenceComplex20260903.Face.valuation
      (balancedTwoPrimeDatum k) .B 3 = k + 1 := by
  simp only [ABCValuationIncidenceComplex20260903.Face.valuation,
    ABCValuationIncidenceComplex20260903.coordinate,
    balancedTwoPrimeDatum]
  rw [(by norm_num : Nat.Prime 3).factorization_pow]
  simp

/-- Omitting `2` makes the selected `A` support empty. -/
theorem A_support_eq_empty_of_two_not_mem
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (htwo : 2 ∉ F.support .A) : F.support .A = ∅ := by
  apply Finset.eq_empty_iff_forall_notMem.mpr
  intro p hp
  have hsubset : F.support .A ⊆ {2} := by
    simpa [balanced_A_primeFactors k] using F.support_subset .A
  have hp2 : p = 2 := by simpa using hsubset hp
  subst p
  exact htwo hp

/-- Omitting `3` makes the selected `B` support empty. -/
theorem B_support_eq_empty_of_three_not_mem
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (hthree : 3 ∉ F.support .B) : F.support .B = ∅ := by
  apply Finset.eq_empty_iff_forall_notMem.mpr
  intro p hp
  have hsubset : F.support .B ⊆ {3} := by
    simpa [balanced_B_primeFactors k] using F.support_subset .B
  have hp3 : p = 3 := by simpa using hsubset hp
  subst p
  exact hthree hp

/-- An `AB`-reconstructing face must contain the unique `A` support vertex. -/
theorem two_mem_A_of_ABReconstructing
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (hrec : F.ABReconstructing) : 2 ∈ F.support .A := by
  by_contra htwo
  have hsupport := A_support_eq_empty_of_two_not_mem F htwo
  have hMA : F.armModulus .A = 1 := by
    rw [ABCValuationIncidenceComplex20260903.Face.armModulus, hsupport]
    simp
  have hMBdvd : F.armModulus .B ∣ 3 ^ (k + 1) := by
    simpa [ABCValuationIncidenceComplex20260903.coordinate,
      balancedTwoPrimeDatum] using
      F.armModulus_dvd_coordinate ABCValuationIncidenceComplex20260903.Arm.B
  have hMB : F.armModulus .B ≤ 3 ^ (k + 1) :=
    Nat.le_of_dvd (pow_pos (by norm_num) _) hMBdvd
  have hcgt : 3 ^ (k + 1) < (balancedTwoPrimeDatum k).c := by
    simp only [balancedTwoPrimeDatum]
    have hApos : 0 < 2 ^ (2 * (k + 1)) := pow_pos (by norm_num) _
    omega
  unfold ABCValuationIncidenceComplex20260903.Face.ABReconstructing at hrec
  rw [hMA, one_mul] at hrec
  omega

/-- An `AB`-reconstructing face must contain the unique `B` support vertex. -/
theorem three_mem_B_of_ABReconstructing
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (hrec : F.ABReconstructing) : 3 ∈ F.support .B := by
  by_contra hthree
  have hsupport := B_support_eq_empty_of_three_not_mem F hthree
  have hMB : F.armModulus .B = 1 := by
    rw [ABCValuationIncidenceComplex20260903.Face.armModulus, hsupport]
    simp
  have hMAdvd : F.armModulus .A ∣ 2 ^ (2 * (k + 1)) := by
    simpa [ABCValuationIncidenceComplex20260903.coordinate,
      balancedTwoPrimeDatum] using
      F.armModulus_dvd_coordinate ABCValuationIncidenceComplex20260903.Arm.A
  have hMA : F.armModulus .A ≤ 2 ^ (2 * (k + 1)) :=
    Nat.le_of_dvd (pow_pos (by norm_num) _) hMAdvd
  have hcgt : 2 ^ (2 * (k + 1)) < (balancedTwoPrimeDatum k).c := by
    simp only [balancedTwoPrimeDatum]
    have hBpos : 0 < 3 ^ (k + 1) := pow_pos (by norm_num) _
    omega
  unfold ABCValuationIncidenceComplex20260903.Face.ABReconstructing at hrec
  rw [hMB, mul_one] at hrec
  omega

/-- Reconstruction forces the full singleton support on the `A` arm. -/
theorem A_support_eq_singleton_of_ABReconstructing
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (hrec : F.ABReconstructing) : F.support .A = {2} := by
  apply Finset.Subset.antisymm
  · simpa [balanced_A_primeFactors k] using F.support_subset .A
  · simpa using two_mem_A_of_ABReconstructing F hrec

/-- Reconstruction forces the full singleton support on the `B` arm. -/
theorem B_support_eq_singleton_of_ABReconstructing
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (hrec : F.ABReconstructing) : F.support .B = {3} := by
  apply Finset.Subset.antisymm
  · simpa [balanced_B_primeFactors k] using F.support_subset .B
  · simpa using three_mem_B_of_ABReconstructing F hrec

/-- Exact `A`-arm defect degree of every reconstructing face. -/
theorem defectDegree_A_eq_of_ABReconstructing
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (hrec : F.ABReconstructing) : F.defectDegree .A = 2 * k + 1 := by
  rw [ABCValuationIncidenceComplex20260903.Face.defectDegree,
    A_support_eq_singleton_of_ABReconstructing F hrec]
  simp [balanced_A_valuation_two]
  omega

/-- Exact `B`-arm defect degree of every reconstructing face. -/
theorem defectDegree_B_eq_of_ABReconstructing
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (hrec : F.ABReconstructing) : F.defectDegree .B = k := by
  rw [ABCValuationIncidenceComplex20260903.Face.defectDegree,
    B_support_eq_singleton_of_ABReconstructing F hrec]
  simp [balanced_B_valuation_three]

/-- The total summand-arm defect forced by reconstruction is `3*k+1`. -/
theorem defectDegree_AB_eq_of_ABReconstructing
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (hrec : F.ABReconstructing) :
    F.defectDegree .A + F.defectDegree .B = 3 * k + 1 := by
  rw [defectDegree_A_eq_of_ABReconstructing F hrec,
    defectDegree_B_eq_of_ABReconstructing F hrec]
  omega

/-- The lower-bound form used by the obstruction. -/
theorem three_mul_k_add_one_le_defectDegree_AB_of_ABReconstructing
    {k : ℕ} (F : Face (balancedTwoPrimeDatum k))
    (hrec : F.ABReconstructing) :
    3 * k + 1 ≤ F.defectDegree .A + F.defectDegree .B := by
  rw [defectDegree_AB_eq_of_ABReconstructing F hrec]

/-! ## Binary-scale upper bound -/

/-- The `3`-power is strictly smaller than the balanced `4`-power. -/
theorem three_pow_succ_lt_two_pow_twice_succ (k : ℕ) :
    3 ^ (k + 1) < 2 ^ (2 * (k + 1)) := by
  calc
    3 ^ (k + 1) < 4 ^ (k + 1) :=
      Nat.pow_lt_pow_left (by norm_num) (by omega)
    _ = 2 ^ (2 * (k + 1)) := by
      rw [show (4 : ℕ) = 2 ^ 2 by norm_num, pow_mul]

/-- The sum arm is dominated by `2^(2*k+3)`. -/
theorem balanced_c_le_two_pow_two_mul_add_three (k : ℕ) :
    (balancedTwoPrimeDatum k).c ≤ 2 ^ (2 * k + 3) := by
  have hsmall := three_pow_succ_lt_two_pow_twice_succ k
  simp only [balancedTwoPrimeDatum]
  calc
    2 ^ (2 * (k + 1)) + 3 ^ (k + 1) ≤
        2 ^ (2 * (k + 1)) + 2 ^ (2 * (k + 1)) :=
      Nat.add_le_add_left hsmall.le _
    _ = 2 ^ (2 * (k + 1) + 1) := by
      rw [pow_succ]
      ring
    _ = 2 ^ (2 * k + 3) := by
      congr 1

/-- The least binary scale of the sum arm is at most `2*k+3`. -/
theorem binaryScale_balanced_c_le (k : ℕ) :
    binaryScale (balancedTwoPrimeDatum k).c ≤ 2 * k + 3 :=
  binaryScale_le_of_le_two_pow (balanced_c_le_two_pow_two_mul_add_three k)

/-! ## Infinite failure and the complete VIC-1R proposition -/

/-- The two necessary scale-budget and reconstruction requirements. -/
def HasCoefficientOneScaleReconstructingFace
    (P : PrimitiveABC) (t : ℕ) : Prop :=
  ∃ F : Face P,
    F.ABReconstructing ∧
      F.defectDegree .A + F.defectDegree .B ≤ binaryScale P.c + t

/-- The full pointwise VIC-1R requirement, including its quantitative
radical-defect inequality. -/
def HasVIC1RFace (P : PrimitiveABC) (m n t : ℕ) : Prop :=
  ∃ F : Face P,
    F.ABReconstructing ∧
    F.defectDegree .A + F.defectDegree .B ≤ binaryScale P.c + t ∧
    (ABCValuationIncidenceComplex20260903.Face.full P).armDefect .C ^ m ≤
      (F.armRadical .A * F.armRadical .B) ^ (m + n) *
        (ABCValuationIncidenceComplex20260903.Face.full P).armRadical .C ^ n

/-- All-but-finitely-many, coefficient-one binary-scale form of VIC-1R. -/
def CoefficientOneScaleVIC1R (m n : ℕ) : Prop :=
  ∃ t : ℕ, {P : PrimitiveABC | ¬ HasVIC1RFace P m n t}.Finite

/-- Once `k > t+2`, no reconstructing face can meet the scale budget. -/
theorem balanced_no_coefficientOneScaleReconstructingFace
    {k t : ℕ} (hkt : t + 2 < k) :
    ¬ HasCoefficientOneScaleReconstructingFace
      (balancedTwoPrimeDatum k) t := by
  rintro ⟨F, hrec, hbudget⟩
  have hdefect :=
    three_mul_k_add_one_le_defectDegree_AB_of_ABReconstructing F hrec
  have hscale := binaryScale_balanced_c_le k
  omega

/-- The full pointwise VIC-1R selector fails on the same tail, independently
of its rational-power parameters. -/
theorem balanced_no_VIC1RFace (m n : ℕ) {k t : ℕ} (hkt : t + 2 < k) :
    ¬ HasVIC1RFace (balancedTwoPrimeDatum k) m n t := by
  intro h
  apply balanced_no_coefficientOneScaleReconstructingFace hkt
  rcases h with ⟨F, hrec, hbudget, _hquantitative⟩
  exact ⟨F, hrec, hbudget⟩

/-- For every fixed additive slack, scale-budget reconstruction fails on an
infinite complete-premise family. -/
theorem coefficientOneScale_reconstruction_failureSet_infinite (t : ℕ) :
    {P : PrimitiveABC |
      ¬ HasCoefficientOneScaleReconstructingFace P t}.Infinite := by
  let f : ℕ → PrimitiveABC := fun j =>
    balancedTwoPrimeDatum (j + t + 3)
  have hfinj : Function.Injective f := by
    intro j l h
    have hindex := balancedTwoPrimeDatum_injective h
    omega
  have hrange : (Set.range f).Infinite :=
    Set.infinite_range_of_injective hfinj
  apply hrange.mono
  intro P hP
  rcases hP with ⟨j, rfl⟩
  change ¬ HasCoefficientOneScaleReconstructingFace
    (balancedTwoPrimeDatum (j + t + 3)) t
  apply balanced_no_coefficientOneScaleReconstructingFace
  omega

/-- For every parameter pair and additive slack, the complete VIC-1R failure
set is infinite. -/
theorem coefficientOneScale_VIC1R_failureSet_infinite (m n t : ℕ) :
    {P : PrimitiveABC | ¬ HasVIC1RFace P m n t}.Infinite := by
  let f : ℕ → PrimitiveABC := fun j =>
    balancedTwoPrimeDatum (j + t + 3)
  have hfinj : Function.Injective f := by
    intro j l h
    have hindex := balancedTwoPrimeDatum_injective h
    omega
  have hrange : (Set.range f).Infinite :=
    Set.infinite_range_of_injective hfinj
  apply hrange.mono
  intro P hP
  rcases hP with ⟨j, rfl⟩
  change ¬ HasVIC1RFace (balancedTwoPrimeDatum (j + t + 3)) m n t
  apply balanced_no_VIC1RFace
  omega

/-- The all-but-finitely-many coefficient-one VIC-1R selector is false for
every rational-power parameter pair. -/
theorem not_coefficientOneScaleVIC1R (m n : ℕ) :
    ¬ CoefficientOneScaleVIC1R m n := by
  rintro ⟨t, hfinite⟩
  exact (coefficientOneScale_VIC1R_failureSet_infinite m n t).not_finite
    hfinite

end ABCValuationIncidenceScaleBudgetObstruction20260903
end IUTThreeClosures
