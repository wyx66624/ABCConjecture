/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootZAction
import IUTThreeClosures.TateThetaRootAmbientTopology
import Mathlib.Topology.Covering.Quotient

/-!
# The topological covering quotient of the theta-root locus

The corrected theta-root equation locus now has its ambient subspace topology,
a continuous radial coordinate and an honest integer deck action. This module
forms the orbit quotient with its quotient topology and proves directly that
the quotient projection is a covering map.

The local slice at a point `z` is the inverse image of the radial interval
`(rho(z)-1/4,rho(z)+1/4)`. Since the integer action translates `rho` by an
integer, a translate of this slice can meet itself only for the zero integer.
This gives the exact local disjointness field of Mathlib's
`IsQuotientCoveringMap` without assuming local compactness.
-/

namespace IUTThreeClosures

open TateCurvesTheta Set Topology

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootRadialSkeleton

variable (t : TateParameter K) (ell : ℕ)
variable (r : Kˣ) (hr : r ^ ell = t.q)

/-- Positive deck iterates are continuous in the actual ambient topology. -/
theorem continuous_shiftNat (n : ℕ) :
    Continuous (TateThetaRootPullbackPoint.shiftNat t ell r hr n) := by
  induction n with
  | zero => simpa [TateThetaRootPullbackPoint.shiftNat] using
      (continuous_id : Continuous (id :
        TateThetaRootPullbackPoint t ell →
          TateThetaRootPullbackPoint t ell))
  | succ n ih =>
      simpa [TateThetaRootPullbackPoint.shiftNat] using
        (TateThetaRootPullbackPoint.continuous_shift t ell r hr).comp ih

/-- Negative deck iterates are continuous in the actual ambient topology. -/
theorem continuous_shiftNegNat (n : ℕ) :
    Continuous (shiftNegNat t ell r hr n) := by
  induction n with
  | zero => simpa [shiftNegNat] using
      (continuous_id : Continuous (id :
        TateThetaRootPullbackPoint t ell →
          TateThetaRootPullbackPoint t ell))
  | succ n ih =>
      simpa [shiftNegNat] using
        ih.comp (TateThetaRootPullbackPoint.continuous_shiftInv t ell r hr)

/-- Every complete integer deck iterate is continuous. -/
theorem continuous_shiftInt (n : ℤ) :
    Continuous (shiftInt t ell r hr n) := by
  cases n with
  | ofNat k =>
      simpa [shiftInt] using continuous_shiftNat t ell r hr k
  | negSucc k =>
      simpa [shiftInt] using continuous_shiftNegNat t ell r hr (k + 1)

/-- Every genuine permutation-power deck map is continuous. -/
theorem continuous_deckZ (n : ℤ) :
    Continuous (deckZ t ell r hr n) := by
  have hfun : deckZ t ell r hr n = shiftInt t ell r hr n := by
    funext z
    exact deckZ_eq_shiftInt t ell r hr n z
  rw [hfun]
  exact continuous_shiftInt t ell r hr n

/-- The indexed integer deck action is continuous for each fixed group
element. -/
noncomputable instance deckContinuousConstSMul :
    ContinuousConstSMul (DeckGroup t ell r hr)
      (TateThetaRootPullbackPoint t ell) where
  continuous_const_smul g := by
    change Continuous (deckZ t ell r hr (DeckGroup.toInt g))
    exact continuous_deckZ t ell r hr (DeckGroup.toInt g)

/-- The canonical quotient projection. -/
noncomputable def deckQuotientMk :
    TateThetaRootPullbackPoint t ell →
      DeckOrbitQuotient t ell r hr :=
  Quotient.mk'

/-- A radial interval of width `1/2` is disjoint from every nontrivial integer
translate. -/
theorem exists_radial_disjoint_nhds
    (z : TateThetaRootPullbackPoint t ell) :
    ∃ U ∈ 𝓝 z,
      ∀ g : DeckGroup t ell r hr,
        (((g • ·) '' U ∩ U).Nonempty → g = 1) := by
  let ρ : ℝ := coordinate t ell r z
  let U : Set (TateThetaRootPullbackPoint t ell) :=
    coordinate t ell r ⁻¹' Ioo (ρ - 1 / 4) (ρ + 1 / 4)
  refine ⟨U, ?_, ?_⟩
  · apply IsOpen.mem_nhds
    · exact isOpen_Ioo.preimage
        (TateThetaRootPullbackPoint.continuous_radialCoordinate t ell r)
    · change ρ - 1 / 4 < ρ ∧ ρ < ρ + 1 / 4
      constructor <;> norm_num
  · intro g hg
    rcases hg with ⟨w, ⟨u, hu, rfl⟩, hgu⟩
    change ρ - 1 / 4 < coordinate t ell r u ∧
      coordinate t ell r u < ρ + 1 / 4 at hu
    change ρ - 1 / 4 <
        coordinate t ell r
          (deckZ t ell r hr (DeckGroup.toInt g) u) ∧
      coordinate t ell r
          (deckZ t ell r hr (DeckGroup.toInt g) u) <
        ρ + 1 / 4 at hgu
    rw [coordinate_deckZ] at hgu
    have hnlo : (-1 : ℝ) < (DeckGroup.toInt g : ℝ) := by
      linarith [hu.2, hgu.1]
    have hnhi : (DeckGroup.toInt g : ℝ) < 1 := by
      linarith [hu.1, hgu.2]
    have hnloZ : (-1 : ℤ) < DeckGroup.toInt g := by
      exact_mod_cast hnlo
    have hnhiZ : DeckGroup.toInt g < (1 : ℤ) := by
      exact_mod_cast hnhi
    have hn : DeckGroup.toInt g = 0 := by omega
    simpa [DeckGroup.toInt] using congrArg Multiplicative.ofAdd hn

/-- The orbit-quotient projection is a quotient covering map with indexed
integer deck group. -/
theorem deckQuotient_isQuotientCoveringMap :
    IsQuotientCoveringMap
      (deckQuotientMk t ell r hr)
      (DeckGroup t ell r hr) where
  __ := isQuotientMap_quotient_mk'
  continuous_const_smul := fun g =>
    deckContinuousConstSMul.continuous_const_smul g
  apply_eq_iff_mem_orbit := by
    intro x y
    exact Quotient.eq''
  disjoint := exists_radial_disjoint_nhds t ell r hr

/-- In particular, the genuine topological orbit projection is a covering
map. -/
theorem deckQuotient_isCoveringMap :
    IsCoveringMap (deckQuotientMk t ell r hr) :=
  (deckQuotient_isQuotientCoveringMap t ell r hr).isCoveringMap

/-- Every fiber of the topological quotient is canonically a torsor for the
integer deck group after choosing one point in the fiber. -/
noncomputable def deckQuotientFiberEquivInt
    {x : DeckOrbitQuotient t ell r hr}
    (z : (deckQuotientMk t ell r hr) ⁻¹' {x}) :
    (deckQuotientMk t ell r hr) ⁻¹' {x} ≃ Multiplicative ℤ :=
  ((deckQuotient_isQuotientCoveringMap t ell r hr).fiberEquivGroup z).trans
    (DeckGroup.equivMultiplicativeInt t ell r hr)

end TateThetaRootRadialSkeleton

end IUTThreeClosures
