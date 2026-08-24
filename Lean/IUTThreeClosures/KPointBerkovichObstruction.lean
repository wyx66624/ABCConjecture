/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaRootAmbientTopology
import Mathlib.Topology.Connected.PathConnected
import Mathlib.Topology.Connected.TotallyDisconnected

/-!
# Why the ordinary `K`-point topology cannot replace Berkovich analytification

For a nonarchimedean field, the ordinary field topology is totally
disconnected.  The corrected theta-root `K`-point locus inherits a faithful
continuous map into `Kˣ × K`.  Consequently every continuous path in the
point locus is constant.

This gives a strict obstruction to one tempting shortcut: the ordinary
`K`-point quotient may be a perfectly valid topological covering quotient, but
it cannot itself be the connected Berkovich circle/skeleton whenever that
skeleton has more than one point.  The genuine tempered route must enlarge the
point set to analytic/Berkovich points or provide an equivalent connected
analytic realization.

This result does not exclude the Berkovich route.  It excludes only the
replacement of Berkovich analytification by the ordinary topology on rational
or geometric points.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootPullbackPoint

variable (t : TateParameter K) (ell : ℕ)

/-- The actual ambient-coordinate realization is a topological embedding. -/
theorem toAmbient_isEmbedding :
    Topology.IsEmbedding (toAmbient t ell) where
  eq_induced := rfl
  injective := toAmbient_injective t ell

/-- If both ambient factors are totally disconnected, every path in the
ordinary theta-root point topology has equal endpoints. -/
theorem path_endpoints_eq
    [TotallyDisconnectedSpace Kˣ]
    [TotallyDisconnectedSpace K]
    {x y : TateThetaRootPullbackPoint t ell}
    (γ : Path x y) :
    x = y := by
  have hambient :
      toAmbient t ell x = toAmbient t ell y := by
    have h := TotallyDisconnectedSpace.eq_of_continuous
      (fun s => toAmbient t ell (γ s))
      ((continuous_toAmbient t ell).comp γ.continuous)
      (0 : Set.Icc (0 : ℝ) 1) (1 : Set.Icc (0 : ℝ) 1)
    simpa using h
  exact (toAmbient_injective t ell) hambient

/-- Distinct ordinary theta-root points cannot be joined by a continuous
path. -/
theorem not_nonempty_path_of_ne
    [TotallyDisconnectedSpace Kˣ]
    [TotallyDisconnectedSpace K]
    {x y : TateThetaRootPullbackPoint t ell}
    (hxy : x ≠ y) :
    ¬ Nonempty (Path x y) := by
  rintro ⟨γ⟩
  exact hxy (path_endpoints_eq t ell γ)

/-- The entire ordinary theta-root point space is totally disconnected. -/
noncomputable instance instTotallyDisconnectedSpace
    [TotallyDisconnectedSpace Kˣ]
    [TotallyDisconnectedSpace K] :
    TotallyDisconnectedSpace (TateThetaRootPullbackPoint t ell) := by
  have hEmb := toAmbient_isEmbedding t ell
  apply (hEmb.isTotallyDisconnected_range).mp
  exact isTotallyDisconnected_of_totallyDisconnectedSpace _

/-- If the ordinary theta-root point locus is nontrivial, it cannot be a
preconnected space.  In particular it cannot itself be the connected radial
Berkovich circle. -/
theorem not_preconnectedSpace_of_nontrivial
    [TotallyDisconnectedSpace Kˣ]
    [TotallyDisconnectedSpace K]
    [Nontrivial (TateThetaRootPullbackPoint t ell)] :
    ¬ PreconnectedSpace (TateThetaRootPullbackPoint t ell) := by
  intro hpre
  haveI : PreconnectedSpace (TateThetaRootPullbackPoint t ell) := hpre
  have hsub : Subsingleton (TateThetaRootPullbackPoint t ell) :=
    subsingleton_of_preconnected_totallyDisconnected
  exact not_subsingleton _ hsub

end TateThetaRootPullbackPoint

end IUTThreeClosures
