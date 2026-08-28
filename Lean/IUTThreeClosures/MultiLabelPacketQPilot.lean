/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MultiLabelProductWeightMarginalization
import IUTThreeClosures.PrimePowerQPilotRegion

/-!
# Prime-power packet volumes with several active labels

The public packet components are tuples of places indexed by all labels in one
capsule. If the prime-power order of a component is the sum of independent
label-local orders, then normalized product weights marginalize the packet
volume to the sum of the weighted local label contributions.

This is the exact algebra needed to distinguish two source models:

* one distinguished active label per capsule;
* every inherited label active in every capsule.

The first gives the verified square-average coefficient. The second gives the
repeated-label coefficient audited in
`RepeatedLabelProcessionOvercount`.
-/

namespace Iut
namespace PrimePowerQPilotRegion

open scoped BigOperators

universe u₁ u₂ v

variable {ι : Type u₁} {V : Type u₂}
variable {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}

/-- Packet log-volume when the component order is the sum of label-local
orders. -/
theorem packetVol_additiveLabelOrders
    (vol : LogVolumeData D)
    (i : Fin D.proc.length) (p : Nat.Primes)
    (order :
      (D.proc.capsule i).LabelType → D.Fiber (.finite p) → ℕ)
    (hp : ∀ c : D.Components i (.finite p),
      (((p : ℕ) : (D.packet i (.finite p)).Summand c)) ≠ 0) :
    vol.packetVol i (.finite p)
        (packetPrimePowerRegion i p
          (fun c => ∑ j, order j (c j))) =
      ∑ j : (D.proc.capsule i).LabelType,
        ∑ x : D.Fiber (.finite p),
          vol.weight (.finite p) x *
            (- (order j x : ℝ) * Real.log p) := by
  classical
  rw [packetVol_packetPrimePowerRegion vol i p _ hp]
  have horder (c : D.Components i (.finite p)) :
      - (((∑ j, order j (c j) : ℕ) : ℝ)) * Real.log p =
        ∑ j : (D.proc.capsule i).LabelType,
          (- (order j (c j) : ℝ) * Real.log p) := by
    push_cast
    rw [← Finset.sum_mul, Finset.sum_neg_distrib]
  calc
    (∑ c : D.Components i (.finite p),
        vol.packetWeight i (.finite p) c *
          (- (((∑ j, order j (c j) : ℕ) : ℝ)) *
            Real.log p)) =
      ∑ c : D.Components i (.finite p),
        vol.packetWeight i (.finite p) c *
          (∑ j : (D.proc.capsule i).LabelType,
            (- (order j (c j) : ℝ) * Real.log p)) := by
              apply Finset.sum_congr rfl
              intro c hc
              rw [horder c]
    _ = ∑ j : (D.proc.capsule i).LabelType,
        ∑ x : D.Fiber (.finite p),
          vol.weight (.finite p) x *
            (- (order j x : ℝ) * Real.log p) := by
              exact IUTThreeClosures.product_weight_additive_marginal
                (vol.weight (.finite p))
                (fun j x =>
                  - (order j x : ℝ) * Real.log p)
                (vol.weight_sum_one (.finite p))

/-- If label `j` contributes a natural scalar `a j` times one common local
order, then the packet coefficient is `sum_j a j`. -/
theorem packetVol_scaledLabelOrders
    (vol : LogVolumeData D)
    (i : Fin D.proc.length) (p : Nat.Primes)
    (a : (D.proc.capsule i).LabelType → ℕ)
    (order : D.Fiber (.finite p) → ℕ)
    (hp : ∀ c : D.Components i (.finite p),
      (((p : ℕ) : (D.packet i (.finite p)).Summand c)) ≠ 0) :
    vol.packetVol i (.finite p)
        (packetPrimePowerRegion i p
          (fun c => ∑ j, a j * order (c j))) =
      (∑ j, (a j : ℝ)) *
        (∑ x : D.Fiber (.finite p),
          vol.weight (.finite p) x *
            (- (order x : ℝ) * Real.log p)) := by
  classical
  rw [packetVol_additiveLabelOrders vol i p
    (fun j x => a j * order x) hp]
  calc
    (∑ j : (D.proc.capsule i).LabelType,
        ∑ x : D.Fiber (.finite p),
          vol.weight (.finite p) x *
            (- ((a j * order x : ℕ) : ℝ) * Real.log p)) =
      ∑ j : (D.proc.capsule i).LabelType,
        (a j : ℝ) *
          (∑ x : D.Fiber (.finite p),
            vol.weight (.finite p) x *
              (- (order x : ℝ) * Real.log p)) := by
                apply Finset.sum_congr rfl
                intro j hj
                rw [Finset.mul_sum]
                apply Finset.sum_congr rfl
                intro x hx
                push_cast
                ring
    _ = (∑ j, (a j : ℝ)) *
        (∑ x : D.Fiber (.finite p),
          vol.weight (.finite p) x *
            (- (order x : ℝ) * Real.log p)) := by
              rw [Finset.sum_mul]

end PrimePowerQPilotRegion
end Iut
