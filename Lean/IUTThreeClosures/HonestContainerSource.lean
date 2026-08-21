import IUTThreeClosures.HonestGeneratedSource
import IUTThreeClosures.GeneratedSource

/-!
# Honest generated sources on an IUT large-volume container

This module adapts the current finite-positive `HonestGeneratedSource` to the
actual packet totals of `Iut.LargeVolumeContainerData`.

A container has infinitely many rational places, whereas any concrete
log-volume comparison uses only finitely many active packet coordinates. The
index type below is therefore the finite sigma type of capsule/place pairs
selected by `active`. Each selected packet carries an actual measurable
structure, an actual measure and a finite-positive integral region. The
source's theta region and output regions are then genuine measure-derived
objects on these packet totals.

This is a corrected replacement for an older draft that depended on the
removed `HonestPacketFamily` interface. It does not construct the measures or
multiradial images; those remain the local geometric inhabitant problem.
-/

namespace IUTThreeClosures

open Iut MeasureTheory NumberField

universe u₁ u₂ v uO

variable {ι : Type u₁} {V : Type u₂}
variable {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}

/-- Genuine measured-packet data on every packet of a public large-volume
container, together with the finite set of packet coordinates used by one
comparison. Log-volume is derived from these measures and is not a field. -/
structure ContainerMeasuredRealization
    (D : LargeVolumeContainerData.{u₁, u₂, v} ι V) where
  active : Fin D.proc.length → Finset RationalPlace
  measurableSpace : ∀ (i : Fin D.proc.length) (vQ : RationalPlace),
    MeasurableSpace (D.packet i vQ).Total
  measure : ∀ (i : Fin D.proc.length) (vQ : RationalPlace),
    @Measure (D.packet i vQ).Total (measurableSpace i vQ)
  integral : ∀ (i : Fin D.proc.length) (vQ : RationalPlace),
    @FinitePositiveRegion (D.packet i vQ).Total
      (measurableSpace i vQ) (measure i vQ)
  integral_carrier : ∀ i vQ,
    (integral i vQ).carrier = (D.packet i vQ).integralRegion

namespace ContainerMeasuredRealization

variable (M : ContainerMeasuredRealization D)

/-- Finite packet coordinates used by the honest source. -/
def ActivePacketIndex :=
  Σ i : Fin D.proc.length, {vQ : RationalPlace // vQ ∈ M.active i}

instance : Fintype M.ActivePacketIndex := by
  unfold ActivePacketIndex
  infer_instance

/-- The actual packet total at an active coordinate. -/
def ActivePacketCarrier (x : M.ActivePacketIndex) :
    Type (max (max u₁ u₂) v) :=
  (D.packet x.1 x.2.1).Total

instance activePacketMeasurableSpace (x : M.ActivePacketIndex) :
    MeasurableSpace (M.ActivePacketCarrier x) :=
  M.measurableSpace x.1 x.2.1

/-- The genuine measure at an active coordinate. -/
noncomputable def activePacketMeasure (x : M.ActivePacketIndex) :
    Measure (M.ActivePacketCarrier x) :=
  M.measure x.1 x.2.1

/-- The public integral region, now certified finite-positive for the genuine
measure. -/
noncomputable def activeIntegral (x : M.ActivePacketIndex) :
    FinitePositiveRegion (M.ActivePacketCarrier x)
      (M.activePacketMeasure x) :=
  M.integral x.1 x.2.1

@[simp]
theorem activeIntegral_carrier (x : M.ActivePacketIndex) :
    (M.activeIntegral x).carrier =
      (D.packet x.1 x.2.1).integralRegion :=
  M.integral_carrier x.1 x.2.1

end ContainerMeasuredRealization

/-- A generated finite-positive source on actual active packet totals of a
large-volume container. The output universe is exposed explicitly so that
this adapter does not leave an unconstrained universe metavariable. -/
structure HonestContainerSource
    (M : ContainerMeasuredRealization D) where
  generated :
    HonestGeneratedSource.{max (max u₁ u₂) v, 0, uO}
      M.ActivePacketIndex M.ActivePacketCarrier M.activePacketMeasure
  theta_le_logShell : ∀ x : M.ActivePacketIndex,
    (generated.theta x : Set (M.ActivePacketCarrier x)) ⊆
      D.logShell x.1 x.2.1

namespace HonestContainerSource

variable {M : ContainerMeasuredRealization D}

/-- Every concrete output lies in the corresponding public log-shell because
it lies in the source-generated theta union. -/
theorem realize_le_logShell
    (S : HonestContainerSource.{u₁, u₂, v, uO} M)
    (o : S.generated.Output) (x : M.ActivePacketIndex) :
    (S.generated.realize o x : Set (M.ActivePacketCarrier x)) ⊆
      D.logShell x.1 x.2.1 := by
  intro z hz
  exact S.theta_le_logShell x
    (S.generated.realize_le_theta o x hz)

/-- The canonical numerical inequality on actual packet totals. -/
theorem neg_qLog_le_thetaAverage
    (S : HonestContainerSource.{u₁, u₂, v, uO} M) :
    -S.generated.qLog ≤ S.generated.thetaAverage :=
  S.generated.neg_qLog_le_thetaAverage

end HonestContainerSource

universe u w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- Corrected RHS data over actual initial theta data. The public container
compatibilities are retained, but the inconsistent total real-valued
`LogVolumeData` is replaced by finite-positive measured packets. -/
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

/-- Corrected native source data for one actual public q-pilot. -/
structure HonestGeneratedNativeSource
    (Dθ : InitialThetaData AG TG)
    (Q : QPilotData Dθ) : Type (max (u + 1) (v + 1) (w + 1)) where
  rhs : HonestGeneratedRHSData.{u, v, w} Dθ
  lhs_eq : Q.lhs = -rhs.source.generated.qLog

namespace HonestGeneratedNativeSource

/-- An honest native source proves the numerical IUT III comparison without a
total arbitrary-set log-volume. -/
theorem qPilot_le_thetaAverage
    {Dθ : InitialThetaData AG TG} {Q : QPilotData Dθ}
    (S : HonestGeneratedNativeSource.{u, v, w} Dθ Q) :
    Q.lhs ≤ S.rhs.source.generated.thetaAverage := by
  rw [S.lhs_eq]
  exact S.rhs.source.neg_qLog_le_thetaAverage

end HonestGeneratedNativeSource

end IUTThreeClosures
