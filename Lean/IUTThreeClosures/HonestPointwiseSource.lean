import IUTThreeClosures.HonestContainerSource

/-!
# Pointwise honest IUT III source families

The original pointwise source family depended on the inconsistent public
`LogVolumeData`. This module packages the corrected measure-derived source at
every arithmetic input. Its conclusion is genuinely pointwise: each input
has its own initial theta data, q-pilot, packet measures, output family, and
native volume identity.

An inhabitant still requires the actual anabelian, tempered, local theta, and
multiradial constructions. The purpose of this type is to state that missing
construction without reintroducing an arbitrary volume function.
-/

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-- A corrected IUT III source family at every input. -/
structure HonestPointwiseIUTIIIFamily
    (Input : Type z) : Type (max (u + 1) (v + 1) (w + 1) (z + 1)) where
  data : Input → InitialThetaData AG TG
  qPilot : ∀ x, QPilotData (data x)
  source : ∀ x,
    HonestGeneratedNativeSource.{u, v, w} (data x) (qPilot x)

namespace HonestPointwiseIUTIIIFamily

/-- Every input of an honest pointwise family satisfies the measure-derived
IUT III numerical comparison. -/
theorem qPilot_le_thetaVolume
    {Input : Type z}
    (F : HonestPointwiseIUTIIIFamily.{u, v, w, z}
      (AG := AG) (TG := TG) Input)
    (x : Input) :
    (F.qPilot x).lhs ≤
      (F.source x).rhs.measured.toPacketFamily.totalVolume
        (F.source x).rhs.envelope.generated.theta :=
  (F.source x).qPilot_le_thetaVolume

end HonestPointwiseIUTIIIFamily

end IUTThreeClosures