import IUTThreeClosures.PrimePowerQPilotRegion
import IUTThreeClosures.ProductWeightMarginalization

/-!
# Distinguished-label packet q-pilot calibration

If the q-pilot action is carried by one distinguished procession label, product
packet weights marginalize to the ordinary normalized place weights.  This
proves capsule independence once the source construction identifies the actual
Kummer image with this region.
-/

namespace Iut

open scoped BigOperators

universe u₁ u₂ v

variable {ι : Type u₁} {V : Type u₂}
variable {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}

namespace PrimePowerQPilotRegion

theorem packetVol_distinguishedLabel
    (vol : LogVolumeData D)
    (i : Fin D.proc.length) (p : Nat.Primes)
    (j₀ : (D.proc.capsule i).LabelType)
    (order : D.Fiber (.finite p) → ℕ) :
    vol.packetVol i (.finite p)
        (packetPrimePowerRegion i p (fun c => order (c j₀))) =
      ∑ v : D.Fiber (.finite p),
        vol.weight (.finite p) v *
          (- (order v : ℝ) * Real.log p) := by
  rw [vol.packetVol_packetPrimePowerRegion]
  exact IUTThreeClosures.product_weight_marginal
    j₀ (vol.weight (.finite p))
    (fun v => - (order v : ℝ) * Real.log p)
    (vol.weight_sum_one (.finite p))

end PrimePowerQPilotRegion
end Iut
