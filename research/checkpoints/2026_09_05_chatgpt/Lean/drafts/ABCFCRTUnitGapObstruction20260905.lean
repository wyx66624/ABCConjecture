/-
Author: ChatGPT
Date: 2026-09-05
Base repository commit: 6118955d20b4edd32e577e06d1060f3945358dd9

STATUS: UNCOMPILED DRAFT. These scripts have not been executed by Lean here.
Do not import this file into a verified umbrella or mark it verified before replay.
Ordinary proofs are in paper/ChatGPT_ABC_FCRT_UnitGap_2026_09_05.tex.

Scope: a bilinear integer lemma, its proper-divisor consequence, an elementary
real interval identity, and concrete integer certificates. This file does NOT
formalize the infinite-family approximation argument, the complete FCRT owner
construction, dynamic-program invariant, global optimization, or abc.

Suggested replay from Lean/ in a compatible, patched toolchain environment:
  lake env lean -DwarningAsError=true drafts/ABCFCRTUnitGapObstruction20260905.lean
No successful output of that command is claimed in this supplement.
-/
import Mathlib

set_option autoImplicit false

namespace ABCFCRT20260905

/-- Ordinary proof: manuscript Lemma 4.1. The exceptional cell s = t = 1
has C = M and must be excluded explicitly. -/
theorem bilinearFactorGap
    (M C s t : ℤ) (hM : 2 ≤ M) (hs : 1 ≤ s) (ht : 1 ≤ t)
    (hne : C ≠ M) (heq : C + t = s * (M * t + 1)) :
    2 * M - 1 ≤ C := by
  by_cases ht1 : t = 1
  · subst t
    have hs2 : 2 ≤ s := by
      by_contra h
      have hs1 : s = 1 := by omega
      have hc : C = M := by nlinarith [heq]
      exact hne hc
    have hx : 0 ≤ (s - 2) * (M + 1) :=
      mul_nonneg (by omega) (by omega)
    nlinarith [heq]
  · have ht2 : 2 ≤ t := by omega
    have hM0 : 0 ≤ M := by omega
    have ht0 : 0 ≤ t := by omega
    have hmt : 0 ≤ M * t + 1 := by
      nlinarith [mul_nonneg hM0 ht0]
    have hx : 0 ≤ (s - 1) * (M * t + 1) :=
      mul_nonneg (by omega) hmt
    have hy : 0 ≤ (M - 1) * (t - 2) :=
      mul_nonneg (by omega) (by omega)
    nlinarith [heq]

/-- From du = MC - 1 and u = -1 mod M, the complementary factor is 1 mod M.
No invertibility lemma or primality premise is hidden in this calculation. -/
theorem complementaryCongruence
    (M C d u : ℤ) (hprod : d * u + 1 = M * C)
    (hu : M ∣ u + 1) : M ∣ d - 1 := by
  rcases hu with ⟨s, hs⟩
  refine ⟨d * s - C, ?_⟩
  linear_combination d * hs - hprod

/-- Integer parameterization of two nontrivial factors and the sharp gap. -/
theorem factorGapFromDivisibility
    (M C d u : ℤ) (hM : 2 ≤ M) (hd : 2 ≤ d) (hu : 2 ≤ u)
    (hne : C ≠ M) (hprod : d * u + 1 = M * C)
    (hdCong : M ∣ d - 1) (huCong : M ∣ u + 1) :
    2 * M - 1 ≤ C := by
  rcases hdCong with ⟨t, ht⟩
  rcases huCong with ⟨s, hs⟩
  have hdeq : d = M * t + 1 := by linarith
  have hueq : u = M * s - 1 := by linarith
  have htpos : 1 ≤ t := by
    by_contra h
    have ht0 : t ≤ 0 := by omega
    have hm : M * t ≤ 0 :=
      mul_nonpos_of_nonneg_of_nonpos (by omega) ht0
    linarith
  have hspos : 1 ≤ s := by
    by_contra h
    have hs0 : s ≤ 0 := by omega
    have hm : M * s ≤ 0 :=
      mul_nonpos_of_nonneg_of_nonpos (by omega) hs0
    linarith
  have hcancel : M * (C + t - s * (M * t + 1)) = 0 := by
    rw [hdeq, hueq] at hprod
    nlinarith [hprod]
  have hMne : M ≠ 0 := by omega
  have hzero : C + t - s * (M * t + 1) = 0 :=
    (mul_eq_zero.mp hcancel).resolve_left hMne
  have heq : C + t = s * (M * t + 1) := by linarith
  exact bilinearFactorGap M C s t hM hspos htpos hne heq

/-- No proper divisor in the -1 residue class below the factor-gap threshold.
The arithmetic application proves C ≠ M from the exact source prime power.
This theorem deliberately retains that premise rather than silently omitting it. -/
theorem noProperFactor
    (M C : ℤ) (hM : 2 ≤ M) (hne : C ≠ M) (hsmall : C < 2 * M - 1) :
    ¬ ∃ d u : ℤ, 2 ≤ d ∧ 2 ≤ u ∧ d * u + 1 = M * C ∧ M ∣ u + 1 := by
  rintro ⟨d, u, hd, hu, hprod, huCong⟩
  have hdCong := complementaryCongruence M C d u hprod huCong
  have hgap := factorGapFromDivisibility M C d u hM hd hu hne hprod hdCong huCong
  omega

/-- Only the algebraic identity used by the sharpness construction.
The infinite coprime-packet construction is proved in the manuscript, not here. -/
theorem sharpFactorIdentity (M : ℤ) :
    (2 * M + 1) * (M - 1) + 1 = M * (2 * M - 1) := by
  ring

/-- Distance to [l,u] when l ≤ u. -/
def intervalPenalty (l u t : ℝ) : ℝ := max (max (l - t) (t - u)) 0

/-- Algebraic identity underlying the exact two-source divisor-gap reduction.
The variables A,B,Y,t stand for logarithmic masses, not their integer factors. -/
theorem twoSourceBoundaryIdentity
    (A B Y t : ℝ) (h : Y ≤ A + B) :
    max (A - t) 0 + max (B - Y + t) 0 =
      A + B - Y + intervalPenalty (Y - B) A t := by
  unfold intervalPenalty
  simp only [max_def]
  split_ifs <;> linarith

/-- Exact endpoint arithmetic; this does not assert primality of the six factors. -/
theorem concreteEndpointArithmetic :
    (2 : ℕ)^41 * 3^26 = 5589622068988418728132608 ∧
    49 ∣ (2 : ℕ)^41 * 3^26 - 1 ∧
    (3 : ℕ)^26 < 2 * 2^41 - 1 ∧
    (2 : ℕ)^41 < 2 * 3^26 - 1 := by
  norm_num

theorem concreteFactorizationProduct :
    (7 : ℕ)^2 * 439 * 857 * 2729 * 292183 * 380261663 =
      5589622068988418728132607 := by
  norm_num

theorem concreteNoProperFactorTwo :
    ¬ ∃ d u : ℤ, 2 ≤ d ∧ 2 ≤ u ∧
      d * u + 1 = (2 : ℤ)^41 * 3^26 ∧ (2 : ℤ)^41 ∣ u + 1 := by
  apply noProperFactor ((2 : ℤ)^41) ((3 : ℤ)^26) <;> norm_num

theorem concreteNoProperFactorThree :
    ¬ ∃ d u : ℤ, 2 ≤ d ∧ 2 ≤ u ∧
      d * u + 1 = (3 : ℤ)^26 * 2^41 ∧ (3 : ℤ)^26 ∣ u + 1 := by
  apply noProperFactor ((3 : ℤ)^26) ((2 : ℤ)^41) <;> norm_num

theorem concretePartitionArithmetic :
    (2729 : ℕ) * 380261663 = 1037734078327 ∧
    (7 : ℕ) * 439 * 857 * 292183 = 769481753663 ∧
    (1037734078327 : ℕ) ≤ 2^40 ∧
    (769481753663 : ℕ) ≤ 3^25 := by
  norm_num

#print axioms bilinearFactorGap
#print axioms complementaryCongruence
#print axioms factorGapFromDivisibility
#print axioms noProperFactor
#print axioms sharpFactorIdentity
#print axioms twoSourceBoundaryIdentity
#print axioms concreteEndpointArithmetic
#print axioms concreteFactorizationProduct
#print axioms concreteNoProperFactorTwo
#print axioms concreteNoProperFactorThree
#print axioms concretePartitionArithmetic

end ABCFCRT20260905
