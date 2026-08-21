/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PrimePowerGeneratedThetaHull

/-!
# Component regions of a prime-power generated theta hull

Equality of two nonempty direct-product regions determines every component
factor.  Applying this elementary fact to the two presentations of the actual
finite theta hull — the public scaled-integral presentation and the canonical
minimum prime-power presentation — identifies each actual component region
itself, not merely the total packet.

Consequently the component volume selected by the actual public holomorphic
hull is exactly

`-(minimumExponent : ℝ) * log p`.

This is the literal componentwise product-log-volume formula requested by the
IUT IV calculation.
-/

set_option linter.checkUnivs false

namespace Iut

open scoped Pointwise

universe u v

namespace DirectSumPresentation

variable {C : Type u} (P : DirectSumPresentation.{u, v} C)

/-- Two product regions whose factors all contain zero have equal component
factors whenever the total product regions are equal. -/
theorem component_eq_of_productRegion_eq
    (U V : ∀ c, Set (P.Summand c))
    (hU0 : ∀ c, (0 : P.Summand c) ∈ U c)
    (hV0 : ∀ c, (0 : P.Summand c) ∈ V c)
    (hEq : P.productRegion U = P.productRegion V)
    (c : C) :
    U c = V c := by
  classical
  ext x
  constructor
  · intro hx
    let z : P.Total := Function.update (fun _ => 0) c x
    have hzU : z ∈ P.productRegion U := by
      intro d
      by_cases hdc : d = c
      · subst d
        simpa [z] using hx
      · simpa [z, hdc] using hU0 d
    have hzV : z ∈ P.productRegion V := by
      rw [← hEq]
      exact hzU
    simpa [z] using hzV c
  · intro hx
    let z : P.Total := Function.update (fun _ => 0) c x
    have hzV : z ∈ P.productRegion V := by
      intro d
      by_cases hdc : d = c
      · subst d
        simpa [z] using hx
      · simpa [z, hdc] using hV0 d
    have hzU : z ∈ P.productRegion U := by
      rw [hEq]
      exact hzV
    simpa [z] using hzU c

end DirectSumPresentation

end Iut

namespace IUTThreeClosures

open Iut
open scoped Pointwise

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}
variable {G : GeneratedRHSData.{u, v, w} D}

namespace GeneratedPrimePowerThetaHullData

/-- The actual component region selected by the public theta hull at a finite
rational place is precisely the corresponding minimum prime-power region. -/
theorem thetaHullComponentRegion_finite_eq
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    thetaHullComponentRegion (G.toRHSData) i (.finite p) c =
      PrimePowerQPilotRegion.primePowerImage p
        (A.minimumExponent i p c)
        ((G.container.packet i (.finite p)).integral c) := by
  let P := G.container.packet i (.finite p)
  apply P.component_eq_of_productRegion_eq
  · intro d
    unfold thetaHullComponentRegion
    apply Set.mem_smul_set.mpr
    refine ⟨0, (G.container.packet i (.finite p)).integral d |>.zero_mem, ?_⟩
    simp [smul_eq_mul]
  · intro d
    exact PrimePowerQPilotRegion.zero_mem_primePowerImage_integral
      p (G.container.packet i (.finite p)).integral d
      (A.minimumExponent i p d)
  · change
      (G.container.packet i (.finite p)).scaledIntegral
          (thetaHullScale (G.toRHSData) i (.finite p)) =
        PrimePowerQPilotRegion.packetPrimePowerRegion i p
          (A.minimumExponent i p)
    rw [← thetaHull_region_eq_scaledIntegral,
      A.thetaHull_finite_eq_minimum]

/-- **Literal actual component formula.** The public component log-volume of
the finite theta hull is exactly `-m log p`, with `m` the canonical minimum
Kummer exponent among the actual outputs. -/
theorem componentVol_thetaHull_finite_eq
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    G.vol.componentVol i (.finite p) c
        (thetaHullComponentRegion (G.toRHSData) i (.finite p) c) =
      - (A.minimumExponent i p c : ℝ) * Real.log p := by
  rw [A.thetaHullComponentRegion_finite_eq i p c]
  exact PrimePowerQPilotRegion.componentVol_primePowerIntegral
    G.vol i p c (A.prime_ne_zero i p c)

end GeneratedPrimePowerThetaHullData

end IUTThreeClosures
