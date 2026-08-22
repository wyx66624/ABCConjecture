/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArchimedeanPacketEstimate
import IUTThreeClosures.HonestFinitePositiveLogVolume
import IUTThreeClosures.PublicThetaHullComponentFormula

/-!
# Actual public archimedean component estimate

The public Corollary 3.12 interface records only one archimedean normalization
and therefore cannot prove a component bound by itself. This module states
the missing source adapter without storing a numerical upper value.

For every actual infinite packet component it supplies:

* an explicit measurable structure and radial measure;
* an honest finite-positive model of the public theta-hull component;
* a normalized unit region of logarithmic volume zero;
* the genuine radial `pi`-scaling law;
* the metric inclusion of the theta component into the `card(S)`-fold scaled
  unit region.

Monotonicity and the iterated scaling theorem then derive the public estimate

`componentVol(thetaHullComponent) <= card(S) * log pi`.

The measurable structures are explicit fields because the public packet
presentation currently carries only a topology and a field structure; it does
not install a Borel measurable space on each summand.
-/

namespace IUTThreeClosures

open Iut MeasureTheory

universe u v

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- Honest metric source data for every actual public archimedean component. -/
structure ActualArchimedeanComponentMetricData
    (R : RHSData.{u, v} D) : Type (max (u + 1) (v + 1)) where
  /-- The measurable structure underlying the actual radial measure. -/
  measurableSpace :
    ∀ (i : Fin R.container.proc.length)
      (c : R.container.Components i .infinite),
      MeasurableSpace ((R.container.packet i .infinite).Summand c)
  /-- The actual radial measure on each complex direct summand. -/
  measure :
    ∀ (i : Fin R.container.proc.length)
      (c : R.container.Components i .infinite),
      @Measure ((R.container.packet i .infinite).Summand c)
        (measurableSpace i c)
  /-- The public theta-hull component as a finite-positive measured region. -/
  thetaRegion :
    ∀ (i : Fin R.container.proc.length)
      (c : R.container.Components i .infinite),
      @FinitePositiveRegion
        ((R.container.packet i .infinite).Summand c)
        (measurableSpace i c) (measure i c)
  thetaRegion_carrier : ∀ i c,
    (thetaRegion i c).carrier =
      thetaHullComponentRegion R i .infinite c
  /-- The normalized archimedean unit region. -/
  unitRegion :
    ∀ (i : Fin R.container.proc.length)
      (c : R.container.Components i .infinite),
      @FinitePositiveRegion
        ((R.container.packet i .infinite).Summand c)
        (measurableSpace i c) (measure i c)
  unit_logVolume : ∀ i c,
    @FinitePositiveRegion.logVolume
      ((R.container.packet i .infinite).Summand c)
      (measurableSpace i c) (measure i c) (unitRegion i c) = 0
  /-- The set-level radial scaling by `pi`. -/
  piTransform :
    ∀ (i : Fin R.container.proc.length)
      (c : R.container.Components i .infinite),
      Set ((R.container.packet i .infinite).Summand c) →
        Set ((R.container.packet i .infinite).Summand c)
  /-- Genuine radial scaling: one application adds `log pi`. -/
  piScaling : ∀ i c,
    @FinitePositiveRegion.ScalingLaw
      ((R.container.packet i .infinite).Summand c)
      (measurableSpace i c) (measure i c)
      (piTransform i c) (Real.log Real.pi)
  /-- IUT IV Proposition 1.5: the actual component is contained in the
  `card(S)`-fold radial `pi`-container. -/
  theta_le_piPacket : ∀ i c,
    (thetaRegion i c).carrier ⊆
      (((piScaling i c).iterate (R.container.proc.capsule i).card).pullback
        (unitRegion i c)).carrier
  /-- Identification of the public component log-volume with the honest
  measured log-volume. -/
  public_componentVol_eq : ∀ i c,
    R.vol.componentVol i .infinite c
        (thetaHullComponentRegion R i .infinite c) =
      @FinitePositiveRegion.logVolume
        ((R.container.packet i .infinite).Summand c)
        (measurableSpace i c) (measure i c) (thetaRegion i c)

namespace ActualArchimedeanComponentMetricData

variable {R : RHSData.{u, v} D}

/-- The source metric data derive the actual public component estimate. -/
theorem componentVol_thetaHull_le_card_mul_log_pi
    (A : ActualArchimedeanComponentMetricData R)
    (i : Fin R.container.proc.length)
    (c : R.container.Components i .infinite) :
    R.vol.componentVol i .infinite c
        (thetaHullComponentRegion R i .infinite c) ≤
      ((R.container.proc.capsule i).card : ℝ) * Real.log Real.pi := by
  letI : MeasurableSpace ((R.container.packet i .infinite).Summand c) :=
    A.measurableSpace i c
  rw [A.public_componentVol_eq i c]
  calc
    (A.thetaRegion i c).logVolume ≤
        (((A.piScaling i c).iterate
          (R.container.proc.capsule i).card).pullback
            (A.unitRegion i c)).logVolume :=
      FinitePositiveRegion.logVolume_mono (A.theta_le_piPacket i c)
    _ = (A.unitRegion i c).logVolume +
        ((R.container.proc.capsule i).card : ℝ) * Real.log Real.pi :=
      (((A.piScaling i c).iterate
        (R.container.proc.capsule i).card).logVolume_pullback
          (A.unitRegion i c))
    _ = ((R.container.proc.capsule i).card : ℝ) *
        Real.log Real.pi := by
      rw [A.unit_logVolume i c, zero_add]

/-- Canonical archimedean upper function; unlike the earlier interface field,
this is derived from the actual capsule cardinality. -/
noncomputable def componentUpper
    (A : ActualArchimedeanComponentMetricData R)
    (i : Fin R.container.proc.length)
    (_c : R.container.Components i .infinite) : ℝ :=
  ((R.container.proc.capsule i).card : ℝ) * Real.log Real.pi

/-- The canonical upper function satisfies the public component inequality. -/
theorem componentVol_thetaHull_le_componentUpper
    (A : ActualArchimedeanComponentMetricData R)
    (i : Fin R.container.proc.length)
    (c : R.container.Components i .infinite) :
    R.vol.componentVol i .infinite c
        (thetaHullComponentRegion R i .infinite c) ≤
      A.componentUpper i c :=
  A.componentVol_thetaHull_le_card_mul_log_pi i c

end ActualArchimedeanComponentMetricData

end IUTThreeClosures
