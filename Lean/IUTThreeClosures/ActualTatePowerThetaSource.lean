/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ScalarPowerGeneratedThetaHull
import IUTThreeClosures.TateParameterPowerRegions

/-!
# Actual Tate-power generated theta sources

This module instantiates the generic local-scalar hull theorem by genuine Tate
parameters on the public finite packet summands.

The source must supply the actual normed-field structure on each summand, the
Tate parameter belonging to that local field, and the identification of the
public integral subring with the norm unit ball.  Once the concrete
Kummer/tempered output is proved to be the product of `q_v`-power regions, all
remaining hull data are derived:

* the local scalar is the actual Tate parameter `q_v`;
* its nonvanishing and integrality follow from the Tate-parameter axioms;
* the output exponent is the actual output power;
* the holomorphic theta hull is the componentwise minimum of these powers;
* the literal component and packet log-volume formula follows from the local
  Haar scaling theorem.

No final height inequality or theta coefficient is included in this source
record.  The still-geometric input is the realization theorem saying that the
actual theta/Kummer/tempered outputs are the displayed `q_v`-power products.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut TateCurvesTheta
open scoped Pointwise

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}
variable {G : GeneratedRHSData.{u, v, w} D}

section NormedSummands

variable [∀ (i : Fin G.container.proc.length) (p : Nat.Primes)
  (c : G.container.Components i (.finite p)),
    NormedField ((G.container.packet i (.finite p)).Summand c)]

/-- A generated finite-place output family whose local scalars are actual Tate
parameters. -/
structure GeneratedTatePowerThetaHullData
    (G : GeneratedRHSData.{u, v, w} D) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  /-- The actual Tate parameter on each finite packet summand. -/
  tate :
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
    (c : G.container.Components i (.finite p)) →
      TateParameter ((G.container.packet i (.finite p)).Summand c)
  /-- The public holomorphic integral subring is the norm unit ball of the
  actual local normed field. -/
  integral_eq_normIntegral : ∀ i p c,
    ((G.container.packet i (.finite p)).integral c :
      Set ((G.container.packet i (.finite p)).Summand c)) =
        normIntegralRegion
          (K := (G.container.packet i (.finite p)).Summand c)
  /-- Power of the actual Tate parameter used by each concrete output and
  component. -/
  power :
    (o : G.outputs.Output) →
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
      G.container.Components i (.finite p) → ℕ
  /-- The actual theta/Kummer/tempered realization theorem. -/
  realize_finite : ∀ o i p,
    (G.outputs.realize o i).region (.finite p) =
      ScalarPowerRegion.packetScalarPowerRegion i p
        (fun c => ((tate i p c).q :
          (G.container.packet i (.finite p)).Summand c))
        (power o i p)

namespace GeneratedTatePowerThetaHullData

/-- The actual Tate parameter lies in the public integral subring. -/
theorem q_mem_integral
    (A : GeneratedTatePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    ((A.tate i p c).q :
      (G.container.packet i (.finite p)).Summand c) ∈
        (G.container.packet i (.finite p)).integral c := by
  rw [A.integral_eq_normIntegral i p c]
  exact (A.tate i p c).norm_lt_one.le

/-- Forgetting the Tate origin gives the generic scalar-power generated source.
All scalar hypotheses are theorems of the Tate parameter. -/
noncomputable def toScalarPower
    (A : GeneratedTatePowerThetaHullData G) :
    GeneratedScalarPowerThetaHullData G where
  scalar i p c := (A.tate i p c).q
  scalar_ne_zero i p c := (A.tate i p c).q.ne_zero
  scalar_mem_integral i p c := A.q_mem_integral i p c
  power := A.power
  realize_finite := A.realize_finite

/-- The actual `q_v^n` component region is the local Tate-power region. -/
theorem scalarPowerRegion_eq_qPowerRegion
    (A : GeneratedTatePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p))
    (n : ℕ) :
    ScalarPowerRegion.powerRegion
        ((A.tate i p c).q :
          (G.container.packet i (.finite p)).Summand c)
        ((G.container.packet i (.finite p)).integral c) n =
      (A.tate i p c).qPowerRegion n := by
  rw [A.integral_eq_normIntegral i p c]
  unfold ScalarPowerRegion.powerRegion
  exact (A.tate i p c).qPowerRegion_eq_pow_smul n

/-- The actual public finite theta hull is the product of the
componentwise-minimum powers of the actual Tate parameters. -/
theorem thetaHull_finite_eq_minimumTatePowers
    (A : GeneratedTatePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    ((G.toRHSData).thetaHull i).region (.finite p) =
      ScalarPowerRegion.packetScalarPowerRegion i p
        (fun c => ((A.tate i p c).q :
          (G.container.packet i (.finite p)).Summand c))
        (A.toScalarPower.minimumPower i p) :=
  A.toScalarPower.thetaHull_finite_eq_minimum i p

/-- The actual theta-hull component is exactly the corresponding Tate-power
region. -/
theorem thetaHullComponentRegion_finite_eq_qPowerRegion
    (A : GeneratedTatePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    thetaHullComponentRegion (G.toRHSData) i (.finite p) c =
      (A.tate i p c).qPowerRegion
        (A.toScalarPower.minimumPower i p c) := by
  rw [A.toScalarPower.thetaHullComponentRegion_finite_eq i p c]
  exact A.scalarPowerRegion_eq_qPowerRegion i p c _

end GeneratedTatePowerThetaHullData

/-- The genuine local Haar calculation for the Tate-power regions.  The scale
is fixed to `log ‖q_v‖`; it is not an arbitrary component-value function. -/
structure GeneratedTatePowerLogVolumeData
    (A : GeneratedTatePowerThetaHullData G) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  componentVol_qPower : ∀ i p c n,
    G.vol.componentVol i (.finite p) c
        ((A.tate i p c).qPowerRegion n) =
      (n : ℝ) * Real.log ‖((A.tate i p c).q :
        (G.container.packet i (.finite p)).Summand c)‖

namespace GeneratedTatePowerLogVolumeData

variable {A : GeneratedTatePowerThetaHullData G}

/-- The local Tate Haar theorem supplies the generic scalar-power volume law. -/
noncomputable def toScalarPowerLogVolume
    (V : GeneratedTatePowerLogVolumeData A) :
    GeneratedScalarPowerLogVolumeData A.toScalarPower where
  logScale i p c :=
    Real.log ‖((A.tate i p c).q :
      (G.container.packet i (.finite p)).Summand c)‖
  componentVol_power := by
    intro i p c n
    rw [A.scalarPowerRegion_eq_qPowerRegion i p c n]
    exact V.componentVol_qPower i p c n

/-- Literal componentwise product-log-volume formula for the actual
Tate/Kummer/tempered theta hull. -/
theorem componentVol_thetaHull_finite_eq
    (V : GeneratedTatePowerLogVolumeData A)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    G.vol.componentVol i (.finite p) c
        (thetaHullComponentRegion (G.toRHSData) i (.finite p) c) =
      (A.toScalarPower.minimumPower i p c : ℝ) *
        Real.log ‖((A.tate i p c).q :
          (G.container.packet i (.finite p)).Summand c)‖ :=
  V.toScalarPowerLogVolume.componentVol_thetaHull_finite_eq i p c

/-- Exact product-weighted packet log-volume formula for the actual generated
Tate-power theta hull. -/
theorem packetVol_thetaHull_finite_eq
    (V : GeneratedTatePowerLogVolumeData A)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    G.vol.packetVol i (.finite p)
        (((G.toRHSData).thetaHull i).region (.finite p)) =
      ∑ c : G.container.Components i (.finite p),
        G.vol.packetWeight i (.finite p) c *
          ((A.toScalarPower.minimumPower i p c : ℝ) *
            Real.log ‖((A.tate i p c).q :
              (G.container.packet i (.finite p)).Summand c)‖) :=
  V.toScalarPowerLogVolume.packetVol_thetaHull_finite_eq i p

end GeneratedTatePowerLogVolumeData

end NormedSummands

end IUTThreeClosures
