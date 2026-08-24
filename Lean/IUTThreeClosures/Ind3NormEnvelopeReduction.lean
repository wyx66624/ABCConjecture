/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.UpperSemicompatiblePossibleImageSystem

/-!
# Reduction of Ind3 envelope preservation to a pointwise norm estimate

At a nonarchimedean component, the source-level Ind3 statement is naturally a
relation: the new possible-image region is contained in the image of the old
region under a log-link/Kummer map. To preserve a radial envelope it is enough
that this map does not increase norms.

This module proves that elementary reduction. Thus the remaining analytic
source theorem can be stated pointwise as

`‖logLink x‖ ≤ ‖x‖`

(or with an explicit multiplicative constant), rather than as a global volume
or height inequality.
-/

namespace IUTThreeClosures

universe u v w

section OneMap

variable {α : Type u} {β : Type v}
variable [SeminormedAddCommGroup α] [SeminormedAddCommGroup β]

/-- Closed radial envelope centered at zero. -/
def radialEnvelope (r : ℝ) : Set α :=
  {x | ‖x‖ ≤ r}

@[simp]
theorem mem_radialEnvelope {r : ℝ} {x : α} :
    x ∈ radialEnvelope (α := α) r ↔ ‖x‖ ≤ r :=
  Iff.rfl

/-- A pointwise norm-nonincreasing map sends a radial envelope into the radial
envelope of the same radius. -/
theorem image_radialEnvelope_le
    (f : α → β)
    (hf : ∀ x, ‖f x‖ ≤ ‖x‖)
    (r : ℝ) :
    f '' radialEnvelope (α := α) r ⊆
      radialEnvelope (α := β) r := by
  rintro y ⟨x, hx, rfl⟩
  exact (hf x).trans hx

/-- Relational upper semi-compatibility: if a target region is contained in
the image of a source region, norm nonincrease preserves every radial
envelope. -/
theorem relational_step_preserves_radialEnvelope
    (f : α → β)
    (hf : ∀ x, ‖f x‖ ≤ ‖x‖)
    {U : Set α} {V : Set β} {r : ℝ}
    (hU : U ⊆ radialEnvelope (α := α) r)
    (hV : V ⊆ f '' U) :
    V ⊆ radialEnvelope (α := β) r := by
  intro y hy
  rcases hV hy with ⟨x, hxU, rfl⟩
  exact (hf x).trans (hU hxU)

/-- Version with an explicit dilation factor `C`. -/
theorem relational_step_preserves_scaled_radialEnvelope
    (f : α → β) (C : ℝ)
    (hC : 0 ≤ C)
    (hf : ∀ x, ‖f x‖ ≤ C * ‖x‖)
    {U : Set α} {V : Set β} {r : ℝ}
    (hU : U ⊆ radialEnvelope (α := α) r)
    (hV : V ⊆ f '' U) :
    V ⊆ radialEnvelope (α := β) (C * r) := by
  intro y hy
  rcases hV hy with ⟨x, hxU, rfl⟩
  exact (hf x).trans (mul_le_mul_of_nonneg_left (hU hxU) hC)

end OneMap

section Packet

variable {Label : Type w}
variable {α : Label → Type u}
variable [∀ j, SeminormedAddCommGroup (α j)]

/-- Product radial packet with one radius per component. -/
def radialPacketEnvelope (r : Label → ℝ) :
    Set (∀ j, α j) :=
  {x | ∀ j, ‖x j‖ ≤ r j}

/-- Coordinatewise norm-nonincreasing maps preserve product radial packets. -/
theorem piMap_preserves_radialPacketEnvelope
    (f : ∀ j, α j → α j)
    (hf : ∀ j x, ‖f j x‖ ≤ ‖x‖)
    (r : Label → ℝ) :
    (fun x j => f j (x j)) '' radialPacketEnvelope r ⊆
      radialPacketEnvelope r := by
  rintro y ⟨x, hx, rfl⟩ j
  exact (hf j (x j)).trans (hx j)

/-- A relational Ind3 target contained in a coordinatewise log-link image
remains in the same product radial packet. -/
theorem relational_piStep_preserves_radialPacketEnvelope
    (f : ∀ j, α j → α j)
    (hf : ∀ j x, ‖f j x‖ ≤ ‖x‖)
    (r : Label → ℝ)
    {U V : Set (∀ j, α j)}
    (hU : U ⊆ radialPacketEnvelope r)
    (hV : V ⊆ (fun x j => f j (x j)) '' U) :
    V ⊆ radialPacketEnvelope r := by
  intro y hy
  rcases hV hy with ⟨x, hxU, rfl⟩
  intro j
  exact (hf j (x j)).trans (hU hxU j)

end Packet

end IUTThreeClosures
