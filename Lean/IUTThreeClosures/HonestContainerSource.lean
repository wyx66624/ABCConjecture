import IUTThreeClosures.HonestGeneratedSource
import IUTThreeClosures.GeneratedSource

/-!
# Honest generated sources on an IUT large-volume container

This module identifies the generic measure-derived source layer with the
actual packet types of `Iut.LargeVolumeContainerData`.  A realization supplies
one measurable structure and one genuine measure on every packet total,
together with a finite-positive integral region whose carrier is exactly the
public holomorphic integral region.

The resulting source has canonical finite-sum logarithmic volume and proves
its theta inequality by measure monotonicity.  Constructing the measures and
regions from local fields, tempered theta data, and the multiradial algorithm
remains a separate geometric task.
-/

namespace IUTThreeClosures

open Iut MeasureTheory NumberField

universe u₁ u₂ v uO

variable {ι : Type u₁} {V : Type u₂}
variable {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}

/-- Actual measured-packet data on every packet of a public large-volume
container.  Unlike `LogVolumeData`, the logarithmic volume is not a field: it
is derived from `measure`. -/
structure ContainerMeasuredRealization
    (D : LargeVolumeContainerData.{u₁, u₂, v} ι V) where
  measurableSpace : ∀ (i : Fin D.proc.length) (vQ : RationalPlace),
    MeasurableSpace (D.packet i vQ).Total
  measure : ∀ (i : Fin D.proc.length) (vQ : RationalPlace),
    @Measure (D.packet i vQ).Total (measurableSpace i vQ)
  integral : ∀ (i : Fin D.proc.length) (vQ : RationalPlace),
    @FinitePositiveRegion (D.packet i vQ).Total
      (measurableSpace i vQ) (measure i vQ)
  integral_carrier : ∀ i vQ,
    (integral i vQ).carrier = (D.packet i vQ).integralRegion
  active : Fin D.proc.length → Finset RationalPlace

namespace ContainerMeasuredRealization

variable (M : ContainerMeasuredRealization D)

/-- Forgetting the container presentation gives the generic honest packet
family, while retaining the actual packet totals definitionally. -/
def toPacketFamily :
    HonestPacketFamily (Fin D.proc.length) RationalPlace where
  packet i vQ :=
    { Carrier := (D.packet i vQ).Total
      measurableSpace := M.measurableSpace i vQ
      measure := M.measure i vQ
      integral := M.integral i vQ }
  active := M.active

@[simp]
theorem toPacketFamily_integral_carrier
    (i : Fin D.proc.length) (vQ : RationalPlace) :
    ((M.toPacketFamily.packet i vQ).integral).carrier =
      (D.packet i vQ).integralRegion := by
  simpa [toPacketFamily] using M.integral_carrier i vQ

end ContainerMeasuredRealization

/-- A generated honest source on an actual large-volume container. -/
structure HonestContainerSource
    (M : ContainerMeasuredRealization D) where
  generated : HonestGeneratedSource
    (Fin D.proc.length) RationalPlace M.toPacketFamily
  theta_le_logShell : ∀ i vQ,
    ((generated.theta i).region vQ).carrier ⊆ D.logShell i vQ

namespace HonestContainerSource

variable {M : ContainerMeasuredRealization D}

/-- Every concrete output lies in the public log-shell because it lies in the
theta envelope. -/
theorem realize_le_logShell
    (S : HonestContainerSource.{u₁, u₂, v, uO} M)
    (o : S.generated.Output) (i : Fin D.proc.length)
    (vQ : RationalPlace) :
    ((S.generated.realize o i).region vQ).carrier ⊆ D.logShell i vQ := by
  intro x hx
  exact S.theta_le_logShell i vQ
    (S.generated.realize_le_theta o i vQ hx)

/-- The source-derived numerical inequality on the actual packet types. -/
theorem qLHS_le_thetaVolume
    (S : HonestContainerSource.{u₁, u₂, v, uO} M) :
    S.generated.qLHS ≤
      M.toPacketFamily.totalVolume S.generated.theta :=
  S.generated.qLHS_le_thetaVolume

end HonestContainerSource

universe u w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- Corrected RHS data over actual initial theta data.  The public container
compatibilities are retained, but the inconsistent `LogVolumeData` is replaced
by genuine measured packets. -/
structure HonestGeneratedRHSData
    (Dθ : InitialThetaData AG TG) : Type (max (u + 1) (v + 1) (w + 1)) where
  container : LargeVolumeContainerData.{0, u, v} ℕ
    (Place ↥Dθ.prime.torsionField)
  proc_standard :
    container.proc = Procession.standard ((Dθ.ℓ - 1) / 2)
  toRational_finite : ∀ x : FinitePlace ↥Dθ.prime.torsionField,
    (container.toRational (Place.finite x)).residueChar = residueChar x
  toRational_infinite : ∀ x : InfinitePlace ↥Dθ.prime.torsionField,
    container.toRational (Place.infinite x) = RationalPlace.infinite
  measured : ContainerMeasuredRealization container
  source : HonestContainerSource.{0, u, v, w} measured

/-- Corrected native source data for one q-pilot. -/
structure HonestGeneratedNativeSource
    (Dθ : InitialThetaData AG TG)
    (Q : QPilotData Dθ) : Type (max (u + 1) (v + 1) (w + 1)) where
  rhs : HonestGeneratedRHSData.{u, v, w} Dθ
  lhs_eq : rhs.source.generated.qLHS = Q.lhs

namespace HonestGeneratedNativeSource

/-- An honest native source proves the numerical IUT III comparison without a
total arbitrary-set log-volume. -/
theorem qPilot_le_thetaVolume
    {Dθ : InitialThetaData AG TG} {Q : QPilotData Dθ}
    (S : HonestGeneratedNativeSource.{u, v, w} Dθ Q) :
    Q.lhs ≤ S.rhs.measured.toPacketFamily.totalVolume
      S.rhs.source.generated.theta := by
  rw [← S.lhs_eq]
  exact S.rhs.source.qLHS_le_thetaVolume

end HonestGeneratedNativeSource

end IUTThreeClosures