/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Version 9 scalar cancellation and incidence cores

This module formalizes two theorem-first pieces of the version 9 research
programme.

* The canonical and noncanonical Tate-line coefficients cancel on one complete
  projective orbit.  The same coefficients meet the generic
  `1 / (ell + 1)` projective-selection gain at exactly zero.
* A finite incidence relation with at least `m` outputs per input and at most
  `r` inputs per output satisfies the standard double-count inequality
  `|input| * m <= |output| * r`.

These are unconditional elementary theorems.  They do not construct an
elliptic curve, an exceptional-point amplifier, an IUT source, or an
`ABCConjecture` proof.
-/

namespace IUTThreeClosures

/-! ## Tate-line scalar identities -/

/-- The local coefficient of the canonical cyclic `ell`-line. -/
noncomputable def tateCanonicalLineCoefficient (ell : ℝ) : ℝ :=
  (ell - 1) / 12

/-- The local coefficient of each noncanonical cyclic `ell`-line. -/
noncomputable def tateNoncanonicalLineCoefficient (ell : ℝ) : ℝ :=
  -((ell - 1) / (12 * ell))

/-- One canonical line and `ell` noncanonical lines have total coefficient
zero. -/
theorem tateLineCoefficient_completeOrbit_cancel
    {ell : ℝ} (hell : ell ≠ 0) :
    tateCanonicalLineCoefficient ell +
        ell * tateNoncanonicalLineCoefficient ell = 0 := by
  unfold tateCanonicalLineCoefficient tateNoncanonicalLineCoefficient
  field_simp [hell]
  ring

/-- The generic `1 / (ell + 1)` projective selector meets the noncanonical
baseline at exactly zero. -/
theorem tateLineCoefficient_dimensionBarrier
    {ell : ℝ} (hell : ell ≠ 0) (hellOne : ell + 1 ≠ 0) :
    tateNoncanonicalLineCoefficient ell +
        (tateCanonicalLineCoefficient ell -
          tateNoncanonicalLineCoefficient ell) / (ell + 1) = 0 := by
  unfold tateCanonicalLineCoefficient tateNoncanonicalLineCoefficient
  field_simp [hell, hellOne]
  ring

/-- The complete-orbit cancellation after multiplying by an arbitrary total
weight. -/
theorem tateLineWeighted_completeOrbit_cancel
    {ell totalWeight : ℝ} (hell : ell ≠ 0) :
    tateCanonicalLineCoefficient ell * totalWeight +
        tateNoncanonicalLineCoefficient ell * (ell * totalWeight) = 0 := by
  calc
    tateCanonicalLineCoefficient ell * totalWeight +
        tateNoncanonicalLineCoefficient ell * (ell * totalWeight) =
      (tateCanonicalLineCoefficient ell +
        ell * tateNoncanonicalLineCoefficient ell) * totalWeight := by
          ring
    _ = 0 := by
      rw [tateLineCoefficient_completeOrbit_cancel hell]
      simp

/-! ## Finite incidence double counting -/

universe u v

/-- The finite type of incidences of a relation. -/
def Incidence
    {α : Type u} {β : Type v} (R : α → β → Prop) :=
  {p : α × β // R p.1 p.2}

namespace Incidence

variable {α : Type u} {β : Type v} (R : α → β → Prop)

/-- View an incidence as an input together with one output in its fiber. -/
def equivLeft :
    Incidence R ≃ Σ a : α, {b : β // R a b} where
  toFun p := ⟨p.1.1, ⟨p.1.2, p.2⟩⟩
  invFun p := ⟨(p.1, p.2.1), p.2.2⟩
  left_inv p := by
    cases p with
    | mk p hp =>
        cases p
        rfl
  right_inv p := by
    cases p with
    | mk a p =>
        cases p
        rfl

/-- View an incidence as an output together with one input in its fiber. -/
def equivRight :
    Incidence R ≃ Σ b : β, {a : α // R a b} where
  toFun p := ⟨p.1.2, ⟨p.1.1, p.2⟩⟩
  invFun p := ⟨(p.2.1, p.1), p.2.2⟩
  left_inv p := by
    cases p with
    | mk p hp =>
        cases p
        rfl
  right_inv p := by
    cases p with
    | mk b p =>
        cases p
        rfl

variable [Fintype α] [Fintype β]

/-- Count the incidence relation by its input fibers. -/
theorem card_eq_sum_left :
    Fintype.card (Incidence R) =
      ∑ a : α, Fintype.card {b : β // R a b} := by
  classical
  calc
    Fintype.card (Incidence R) =
        Fintype.card (Σ a : α, {b : β // R a b}) :=
      Fintype.card_congr (equivLeft R)
    _ = ∑ a : α, Fintype.card {b : β // R a b} := by
      simp

/-- Count the incidence relation by its output fibers. -/
theorem card_eq_sum_right :
    Fintype.card (Incidence R) =
      ∑ b : β, Fintype.card {a : α // R a b} := by
  classical
  calc
    Fintype.card (Incidence R) =
        Fintype.card (Σ b : β, {a : α // R a b}) :=
      Fintype.card_congr (equivRight R)
    _ = ∑ b : β, Fintype.card {a : α // R a b} := by
      simp

/-- Finite incidence double counting.  If every input has at least `m`
related outputs and every output has at most `r` related inputs, then
`|α| * m ≤ |β| * r`. -/
theorem card_mul_lower_le_card_mul_overlap
    (m r : ℕ)
    (hlower : ∀ a : α, m ≤ Fintype.card {b : β // R a b})
    (hoverlap : ∀ b : β, Fintype.card {a : α // R a b} ≤ r) :
    Fintype.card α * m ≤ Fintype.card β * r := by
  classical
  calc
    Fintype.card α * m = ∑ _a : α, m := by simp
    _ ≤ ∑ a : α, Fintype.card {b : β // R a b} := by
      exact Finset.sum_le_sum fun a _ha => hlower a
    _ = Fintype.card (Incidence R) := (card_eq_sum_left R).symm
    _ = ∑ b : β, Fintype.card {a : α // R a b} := card_eq_sum_right R
    _ ≤ ∑ _b : β, r := by
      exact Finset.sum_le_sum fun b _hb => hoverlap b
    _ = Fintype.card β * r := by simp

end Incidence

end IUTThreeClosures
