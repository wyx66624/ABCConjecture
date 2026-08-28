/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Properness from a real translation coordinate

Suppose a family of transformations indexed by `ℤ` admits a real coordinate
`rho` satisfying

`rho (act k x) = rho x + k`.

If a subset `C` is bounded in the `rho` coordinate, then only finitely many
integer transformations can carry a point of `C` back into `C`.  This is the
numerical core of proper discontinuity for the theta-root deck action.

The theorem does not require a topology.  In a topological or Berkovich
realization, compactness is used only to prove that the continuous radial
coordinate is bounded on the compact set; the finite-transporter conclusion
then follows from the theorem below without further analytic geometry.
-/

namespace IUTThreeClosures

universe u

/-- A real coordinate which turns the indexed transformations into integer
translations.  No action law is needed for the transporter-finiteness
argument. -/
def IsTranslationCoordinate
    {X : Type u}
    (act : ℤ → X → X)
    (rho : X → ℝ) : Prop :=
  ∀ k x, rho (act k x) = rho x + k

/-- A set is bounded between two real levels of a coordinate. -/
def CoordinateBounded
    {X : Type u}
    (rho : X → ℝ)
    (C : Set X) : Prop :=
  ∃ a b : ℝ, ∀ x ∈ C, a ≤ rho x ∧ rho x ≤ b

/-- Integer transformations which carry at least one point of `C` back into
`C`. -/
def transporterIndices
    {X : Type u}
    (act : ℤ → X → X)
    (C : Set X) : Set ℤ :=
  {k | ∃ x ∈ C, act k x ∈ C}

/-- **Finite-transporter theorem.**  A translation coordinate makes every
coordinate-bounded subset proper for the integer transformation family. -/
theorem finite_transporterIndices_of_coordinateBounded
    {X : Type u}
    {act : ℤ → X → X}
    {rho : X → ℝ}
    (htranslate : IsTranslationCoordinate act rho)
    {C : Set X}
    (hbounded : CoordinateBounded rho C) :
    (transporterIndices act C).Finite := by
  rcases hbounded with ⟨a, b, hab⟩
  obtain ⟨N : ℕ, hN⟩ :=
    exists_nat_gt (|a| + |b| + 1)
  have hNpos : 0 < N := by
    have hnonneg : 0 ≤ |a| + |b| + 1 := by positivity
    exact Nat.zero_lt_of_lt <|
      lt_of_le_of_lt hnonneg hN
  refine (Set.finite_Icc (-(N : ℤ)) (N : ℤ)).subset ?_
  intro k hk
  rcases hk with ⟨x, hxC, hkxC⟩
  have hx := hab x hxC
  have hkx := hab (act k x) hkxC
  have hcoord := htranslate k x
  have haLower : -|a| ≤ a := neg_abs_le a
  have haUpper : a ≤ |a| := le_abs_self a
  have hbLower : -|b| ≤ b := neg_abs_le b
  have hbUpper : b ≤ |b| := le_abs_self b
  have hkUpperReal : (k : ℝ) < N := by
    rw [hcoord] at hkx
    have hk_le : (k : ℝ) ≤ b - a := by linarith
    have hba : b - a ≤ |b| + |a| := by linarith
    exact hk_le.trans_lt <| hba.trans_lt <| by linarith
  have hkLowerReal : (-(N : ℤ) : ℝ) < k := by
    rw [hcoord] at hkx
    have hk_ge : a - b ≤ (k : ℝ) := by linarith
    have habs : -(|a| + |b|) ≤ a - b := by linarith
    have hNneg : (-(N : ℝ)) < -(|a| + |b|) := by
      nlinarith
    exact hNneg.trans_le (habs.trans hk_ge)
  constructor
  · exact_mod_cast (le_of_lt hkLowerReal)
  · exact_mod_cast (le_of_lt hkUpperReal)

/-- A slightly more explicit version with supplied coordinate bounds. -/
theorem finite_transporterIndices_of_bounds
    {X : Type u}
    {act : ℤ → X → X}
    {rho : X → ℝ}
    (htranslate : IsTranslationCoordinate act rho)
    {C : Set X}
    {a b : ℝ}
    (hab : ∀ x ∈ C, a ≤ rho x ∧ rho x ≤ b) :
    (transporterIndices act C).Finite :=
  finite_transporterIndices_of_coordinateBounded
    htranslate ⟨a, b, hab⟩

/-- A translation coordinate also proves that each point orbit has no repeated
integer indices. -/
theorem injective_index_of_translationCoordinate
    {X : Type u}
    {act : ℤ → X → X}
    {rho : X → ℝ}
    (htranslate : IsTranslationCoordinate act rho)
    (x : X) :
    Function.Injective (fun k : ℤ => act k x) := by
  intro k l hkl
  have hcoord := congrArg rho hkl
  rw [htranslate k x, htranslate l x] at hcoord
  have hreal : (k : ℝ) = l := by linarith
  exact_mod_cast hreal

end IUTThreeClosures
