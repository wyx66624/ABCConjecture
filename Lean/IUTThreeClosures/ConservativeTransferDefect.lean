/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Conservative transfer and the global defect budget

This module formalizes the finite-dimensional theorem proved first in
`../research/CONSERVATIVE_TRANSFER_DEFECT_THEOREM.md`.

A transfer matrix `T` preserves a global weight `w` when `w^T T = w^T`.
Such a transfer leaves the weighted global mass unchanged.  After adding a
defect vector, the entire global change is exactly the weighted mass of that
defect.  The two-stage theorem shows that conservative layers cannot create a
strict global gain: gains add only through the explicit defect terms.

The result is an audit theorem for packet, orbit, base-change, and
product-formula arguments.  It does not assert the abc conjecture and it does
not postulate any arithmetic source theorem.
-/

namespace IUTThreeClosures
namespace ConservativeTransferDefect

open scoped BigOperators

variable {ι : Type*} [Fintype ι]

/-- The weighted global mass of a finite packet. -/
noncomputable def weightedMass (w x : ι → ℝ) : ℝ :=
  ∑ i, w i * x i

/-- The action of a finite transfer matrix on a packet. -/
noncomputable def transfer (T : ι → ι → ℝ) (x : ι → ℝ) : ι → ℝ :=
  fun i => ∑ j, T i j * x j

/-- A transfer preserves `w` when the row vector `wᵀ` is stationary. -/
def PreservesWeight (w : ι → ℝ) (T : ι → ι → ℝ) : Prop :=
  ∀ j, ∑ i, w i * T i j = w j

/-- **Conservative-transfer identity.** A weight-preserving transfer cannot
change the weighted global mass. -/
theorem weightedMass_transfer
    (w x : ι → ℝ) (T : ι → ι → ℝ)
    (hT : PreservesWeight w T) :
    weightedMass w (transfer T x) = weightedMass w x := by
  classical
  unfold weightedMass transfer
  calc
    (∑ i : ι, w i * ∑ j : ι, T i j * x j) =
        ∑ i : ι, ∑ j : ι, w i * (T i j * x j) := by
      apply Finset.sum_congr rfl
      intro i _hi
      simpa using
        (Finset.mul_sum Finset.univ
          (fun j : ι => T i j * x j) (w i))
    _ = ∑ j : ι, ∑ i : ι, w i * (T i j * x j) := by
      rw [Finset.sum_comm]
    _ = ∑ j : ι, (∑ i : ι, w i * T i j) * x j := by
      apply Finset.sum_congr rfl
      intro j _hj
      calc
        (∑ i : ι, w i * (T i j * x j)) =
            ∑ i : ι, (w i * T i j) * x j := by
          apply Finset.sum_congr rfl
          intro i _hi
          ring
        _ = (∑ i : ι, w i * T i j) * x j := by
          rw [Finset.sum_mul]
    _ = ∑ j : ι, w j * x j := by
      apply Finset.sum_congr rfl
      intro j _hj
      rw [hT j]

/-- After an affine defect is added, the entire global change is the weighted
mass of that defect. -/
theorem weightedMass_transfer_add_defect
    (w x d : ι → ℝ) (T : ι → ι → ℝ)
    (hT : PreservesWeight w T) :
    weightedMass w (fun i => transfer T x i + d i) =
      weightedMass w x + weightedMass w d := by
  calc
    weightedMass w (fun i => transfer T x i + d i) =
        weightedMass w (transfer T x) + weightedMass w d := by
      unfold weightedMass
      simp_rw [mul_add]
      rw [Finset.sum_add_distrib]
    _ = weightedMass w x + weightedMass w d := by
      rw [weightedMass_transfer w x T hT]

/-- The global change produced by one conservative affine stage is exactly the
defect mass. -/
theorem globalChange_eq_defectMass
    (w x d : ι → ℝ) (T : ι → ι → ℝ)
    (hT : PreservesWeight w T) :
    weightedMass w (fun i => transfer T x i + d i) - weightedMass w x =
      weightedMass w d := by
  rw [weightedMass_transfer_add_defect w x d T hT]
  ring

/-- A conservative affine stage has a strict global gain exactly when its
defect has positive weighted mass. -/
theorem strictGlobalGain_iff_positiveDefectMass
    (w x d : ι → ℝ) (T : ι → ι → ℝ)
    (hT : PreservesWeight w T) :
    weightedMass w x <
        weightedMass w (fun i => transfer T x i + d i) ↔
      0 < weightedMass w d := by
  rw [weightedMass_transfer_add_defect w x d T hT]
  linarith

/-- Nonpositive defect mass rules out a strict global gain. -/
theorem noStrictGlobalGain_of_defectMass_nonpos
    (w x d : ι → ℝ) (T : ι → ι → ℝ)
    (hT : PreservesWeight w T)
    (hd : weightedMass w d ≤ 0) :
    ¬ weightedMass w x <
      weightedMass w (fun i => transfer T x i + d i) := by
  rw [strictGlobalGain_iff_positiveDefectMass w x d T hT]
  exact not_lt.mpr hd

/-- In a two-stage conservative cascade, the global change is the sum of the
two explicit defect masses. -/
theorem twoStage_defectBudget
    (w x d₁ d₂ : ι → ℝ) (T S : ι → ι → ℝ)
    (hT : PreservesWeight w T) (hS : PreservesWeight w S) :
    weightedMass w
        (fun i => transfer S (fun j => transfer T x j + d₁ j) i + d₂ i) =
      weightedMass w x + weightedMass w d₁ + weightedMass w d₂ := by
  calc
    weightedMass w
        (fun i => transfer S (fun j => transfer T x j + d₁ j) i + d₂ i) =
      weightedMass w (fun j => transfer T x j + d₁ j) +
        weightedMass w d₂ := by
      exact weightedMass_transfer_add_defect
        w (fun j => transfer T x j + d₁ j) d₂ S hS
    _ = weightedMass w x + weightedMass w d₁ + weightedMass w d₂ := by
      rw [weightedMass_transfer_add_defect w x d₁ T hT]

/-- Exact strict-gain criterion for a two-stage conservative cascade. -/
theorem twoStage_strictGlobalGain_iff
    (w x d₁ d₂ : ι → ℝ) (T S : ι → ι → ℝ)
    (hT : PreservesWeight w T) (hS : PreservesWeight w S) :
    weightedMass w x <
        weightedMass w
          (fun i => transfer S (fun j => transfer T x j + d₁ j) i + d₂ i) ↔
      0 < weightedMass w d₁ + weightedMass w d₂ := by
  rw [twoStage_defectBudget w x d₁ d₂ T S hT hS]
  linarith

end ConservativeTransferDefect
end IUTThreeClosures
