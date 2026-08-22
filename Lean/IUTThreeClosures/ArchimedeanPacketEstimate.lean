/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib
import Iut.Cor312.Procession

/-!
# Archimedean packet estimates

This module isolates the ordinary metric calculation used at the infinite
rational place in IUT IV, Proposition 1.5 and Theorem 1.10, Step (vii).

After a tensor packet is written in its direct-sum-of-complex-fields
presentation, a pure tensor has component

`c ↦ ∏ i, x i (c i)`.

If every factor component has norm at most `λ`, every packet component has
norm at most `λ ^ card I`.  For `λ = π`, the radial logarithmic scale is at
most `2 * card I`, since `log π ≤ 2`.  In the standard procession every
capsule has at most `n + 1` labels, so the procession average is at most
`2(n+1)`.  When `ℓ = 2n+1`, this is exactly the `ℓ+1` archimedean allowance
used in the coefficient calculation.

The final section records a counterexample showing that the single public
normalization `componentVol archBall = 0` cannot by itself imply an upper
bound on any other region.  An actual source adapter must therefore connect
the public component to the metric packet calculation above.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

/-- The direct-sum coordinate of a pure tensor of complex vectors. -/
noncomputable def archPureTensorCoordinate
    {I : Type u} {V : Type v} [Fintype I]
    (x : I → V → ℂ) (c : I → V) : ℂ :=
  ∏ i, x i (c i)

/-- The coordinatewise closed packet ball of radius `r`. -/
def archPacketBall
    {I : Type u} {V : Type v} (r : ℝ) :
    Set ((I → V) → ℂ) :=
  {z | ∀ c, ‖z c‖ ≤ r}

/-- Componentwise norm estimate for a pure tensor. -/
theorem norm_archPureTensorCoordinate_le
    {I : Type u} {V : Type v} [Fintype I]
    (x : I → V → ℂ) (c : I → V) {λ : ℝ}
    (hλ : 0 ≤ λ) (hx : ∀ i v, ‖x i v‖ ≤ λ) :
    ‖archPureTensorCoordinate x c‖ ≤ λ ^ Fintype.card I := by
  classical
  simp only [archPureTensorCoordinate, norm_prod]
  calc
    ∏ i, ‖x i (c i)‖ ≤ ∏ _i : I, λ := by
      apply Finset.prod_le_prod
      · intro i hi
        exact norm_nonneg _
      · intro i hi
        exact hx i (c i)
    _ = λ ^ Fintype.card I := by simp

/-- The whole decomposed pure tensor belongs to the packet ball of radius
`λ ^ card I`. -/
theorem archPureTensor_mem_packetBall
    {I : Type u} {V : Type v} [Fintype I]
    (x : I → V → ℂ) {λ : ℝ}
    (hλ : 0 ≤ λ) (hx : ∀ i v, ‖x i v‖ ≤ λ) :
    (fun c => archPureTensorCoordinate x c) ∈
      archPacketBall (I := I) (V := V) (λ ^ Fintype.card I) := by
  intro c
  exact norm_archPureTensorCoordinate_le x c hλ hx

/-- The elementary lower sign needed for radial logarithmic estimates. -/
theorem log_pi_nonneg : 0 ≤ Real.log Real.pi := by
  apply Real.log_nonneg
  have hpi : (3 : ℝ) < Real.pi := Real.pi_gt_three
  linarith

/-- The elementary numerical estimate used in IUT IV: `log π ≤ 2`. -/
theorem log_pi_le_two : Real.log Real.pi ≤ 2 := by
  have hpi0 : 0 < Real.pi := Real.pi_pos
  have hhalf0 : 0 < Real.pi / 2 := div_pos hpi0 (by norm_num)
  have hlog2 : Real.log (2 : ℝ) ≤ 1 := by
    have h := Real.log_le_sub_one_of_pos (show (0 : ℝ) < 2 by norm_num)
    norm_num at h ⊢
    exact h
  have hloghalf : Real.log (Real.pi / 2) ≤ 1 := by
    calc
      Real.log (Real.pi / 2) ≤ Real.pi / 2 - 1 :=
        Real.log_le_sub_one_of_pos hhalf0
      _ ≤ 1 := by
        have hpi4 : Real.pi ≤ 4 := le_of_lt Real.pi_lt_four
        linarith
  calc
    Real.log Real.pi =
        Real.log (2 : ℝ) + Real.log (Real.pi / 2) := by
      rw [← Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hhalf0.ne']
      congr 1
      field_simp
    _ ≤ 1 + 1 := add_le_add hlog2 hloghalf
    _ = 2 := by norm_num

/-- The radial logarithmic scale of a `π^m` packet container is at most
`2m`. -/
theorem card_mul_log_pi_le_two_mul_card (m : ℕ) :
    (m : ℝ) * Real.log Real.pi ≤ 2 * m := by
  have hm : (0 : ℝ) ≤ m := by positivity
  have := mul_le_mul_of_nonneg_left log_pi_le_two hm
  simpa [mul_comm, mul_left_comm, mul_assoc] using this

/-- The archimedean upper contribution assigned to the `i`-th capsule of the
standard procession.  The capsule has `i+2` labels. -/
noncomputable def standardArchCapsuleUpper
    (n : ℕ) (i : Fin n) : ℝ :=
  ((i.1 + 2 : ℕ) : ℝ) * Real.log Real.pi

/-- Procession average of the explicit archimedean capsule bounds. -/
noncomputable def standardArchProcessionAverage (n : ℕ) : ℝ :=
  (∑ i : Fin n, standardArchCapsuleUpper n i) / (n : ℝ)

/-- Every standard capsule has at most `n+1` labels. -/
theorem standard_capsule_card_le (n : ℕ) (i : Fin n) :
    i.1 + 2 ≤ n + 1 := by
  omega

/-- The complete standard-procession archimedean average is at most
`2(n+1)`.  This avoids any independent archimedean error term. -/
theorem standardArchProcessionAverage_le
    (n : ℕ) (hn : 0 < n) :
    standardArchProcessionAverage n ≤ 2 * ((n + 1 : ℕ) : ℝ) := by
  classical
  have hnR : (0 : ℝ) < n := by exact_mod_cast hn
  rw [standardArchProcessionAverage]
  apply (div_le_iff₀ hnR).2
  have hterm : ∀ i : Fin n,
      standardArchCapsuleUpper n i ≤
        ((n + 1 : ℕ) : ℝ) * Real.log Real.pi := by
    intro i
    unfold standardArchCapsuleUpper
    apply mul_le_mul_of_nonneg_right
    · exact_mod_cast standard_capsule_card_le n i
    · exact log_pi_nonneg
  calc
    ∑ i : Fin n, standardArchCapsuleUpper n i ≤
        ∑ _i : Fin n, (((n + 1 : ℕ) : ℝ) * Real.log Real.pi) :=
      Finset.sum_le_sum fun i hi => hterm i
    _ = (n : ℝ) *
        (((n + 1 : ℕ) : ℝ) * Real.log Real.pi) := by simp
    _ ≤ (n : ℝ) * (2 * ((n + 1 : ℕ) : ℝ)) := by
      apply mul_le_mul_of_nonneg_left
      · have hnonneg : (0 : ℝ) ≤ (n + 1 : ℕ) := by positivity
        have h := mul_le_mul_of_nonneg_left log_pi_le_two hnonneg
        nlinarith
      · positivity
    _ = (2 * ((n + 1 : ℕ) : ℝ)) * (n : ℝ) := by ring

/-- In the IUT indexing `ℓ = 2n+1`, the archimedean procession allowance is
exactly bounded by `ℓ+1`. -/
theorem standardArchProcessionAverage_le_ell_add_one
    (n ell : ℕ) (hn : 0 < n) (hell : ell = 2 * n + 1) :
    standardArchProcessionAverage n ≤ ((ell + 1 : ℕ) : ℝ) := by
  calc
    standardArchProcessionAverage n ≤
        2 * ((n + 1 : ℕ) : ℝ) :=
      standardArchProcessionAverage_le n hn
    _ = ((ell + 1 : ℕ) : ℝ) := by
      rw [hell]
      push_cast
      ring

namespace ArchNormalizationCounterexample

/-- A single normalization at one region gives no control on another region.
This is the precise logical obstruction in the current public archimedean
`LogVolumeData` interface. -/
theorem one_normalization_does_not_bound_other_regions (B : ℝ) :
    ∃ vol : Set Bool → ℝ,
      vol ∅ = 0 ∧ ¬ vol Set.univ ≤ B := by
  refine ⟨fun U => if U = ∅ then 0 else B + 1, ?_, ?_⟩
  · simp
  · simp

end ArchNormalizationCounterexample

end IUTThreeClosures
