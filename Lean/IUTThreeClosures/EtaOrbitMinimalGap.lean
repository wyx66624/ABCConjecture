/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.FiniteDimensional.Basic

/-!
# The one-dimensional eta-orbit reduction

This file formalizes the elementary reduction isolated by the 2026 eta-orbit
gap audit.  It does **not** postulate that a genuine IUT output exists.

There are two independent ingredients:

* a linear equivalence out of a one-dimensional space is determined by its
  value on any nonzero pilot;
* an abstract volume quotient identifies two represented regions exactly when
  their volumes agree.

Combining them reduces equality of two calibrated eta maps to one scalar
volume equality.  Establishing that a suitable region is actually produced by
the genuine multiradial/Ind1--Ind3 construction remains a separate theorem.
-/

namespace IUTThreeClosures
namespace EtaOrbitMinimalGap

universe u v w z

/-- Two linear equivalences out of a one-dimensional vector space agree if and
only if they agree on one nonzero pilot vector. -/
theorem linearEquiv_eq_iff_apply_pilot
    {K : Type u} {V : Type v} {W : Type w}
    [DivisionRing K]
    [AddCommGroup V] [Module K V]
    [AddCommGroup W] [Module K W]
    (hfin : Module.finrank K V = 1)
    (pilot : V) (hpilot : pilot ≠ 0)
    (f g : V ≃ₗ[K] W) :
    f = g ↔ f pilot = g pilot := by
  constructor
  · intro h
    exact congrArg (fun e : V ≃ₗ[K] W => e pilot) h
  · intro hp
    apply LinearEquiv.ext
    intro x
    obtain ⟨c, rfl⟩ :=
      exists_smul_eq_of_finrank_eq_one hfin hpilot x
    simpa only [map_smul] using congrArg (fun y : W => c • y) hp

/-- An abstract interface for a quotient that forgets everything about a
region except its volume.  This is an interface passed to the theorems below,
not an assertion that the IUT `Rss` quotient or a genuine eta output has been
constructed. -/
structure VolumeQuotientInterface
    (Region : Type u) (Volume : Type v) (Q : Type w) where
  classOf : Region → Q
  volume : Region → Volume
  classOf_eq_iff_volume_eq : ∀ R S,
    classOf R = classOf S ↔ volume R = volume S

namespace VolumeQuotientInterface

variable {Region : Type u} {Volume : Type v} {Q : Type w}

/-- Pilot equality for two calibrated eta maps is equivalent to equality of
the represented volumes. -/
theorem pilot_eq_iff_volume_eq
    (interface : VolumeQuotientInterface Region Volume Q)
    {V : Type z} (pilot : V)
    (etaQ etaAnab : V → Q)
    (nativeQ oneAct : Region)
    (hQ : etaQ pilot = interface.classOf nativeQ)
    (hAnab : etaAnab pilot = interface.classOf oneAct) :
    etaQ pilot = etaAnab pilot ↔
      interface.volume nativeQ = interface.volume oneAct := by
  rw [hQ, hAnab, interface.classOf_eq_iff_volume_eq]

/-- For one-dimensional eta maps, calibration at the nonzero pilot reduces
equality of the entire maps to equality of the two represented volumes.

The theorem is conditional only on the displayed quotient interface and the
two calibration equalities.  In particular, it has no premise asserting the
existence of a suitable or genuine multiradial output. -/
theorem etaMap_eq_iff_volume_eq
    {K : Type u} {V : Type v} {Q : Type w}
    [DivisionRing K]
    [AddCommGroup V] [Module K V]
    [AddCommGroup Q] [Module K Q]
    {Region : Type z} {Volume : Type*}
    (interface : VolumeQuotientInterface Region Volume Q)
    (hfin : Module.finrank K V = 1)
    (pilot : V) (hpilot : pilot ≠ 0)
    (etaQ etaAnab : V ≃ₗ[K] Q)
    (nativeQ oneAct : Region)
    (hQ : etaQ pilot = interface.classOf nativeQ)
    (hAnab : etaAnab pilot = interface.classOf oneAct) :
    etaQ = etaAnab ↔
      interface.volume nativeQ = interface.volume oneAct := by
  rw [linearEquiv_eq_iff_apply_pilot hfin pilot hpilot etaQ etaAnab]
  exact interface.pilot_eq_iff_volume_eq
    pilot etaQ etaAnab nativeQ oneAct hQ hAnab

end VolumeQuotientInterface
end EtaOrbitMinimalGap
end IUTThreeClosures
