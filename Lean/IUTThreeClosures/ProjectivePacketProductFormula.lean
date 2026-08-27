/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TorsionLineEnergyNoGo

/-!
# The finite algebra of the projective packet product formula

For a finite family of logarithmic packet coordinates, projective
normalization subtracts the coordinate average.  If every algebraic coordinate
satisfies the weighted product formula, then the weighted global sum of these
averages is zero.  Hence the global projective packet height is the weighted
sum of the local peaks.

The module also verifies that the balanced canonical/noncanonical Tate packet
has zero average, so its centered canonical coordinate is exactly
`((ell - 1) / 12) * L`.

No number-field product formula, local theta theorem, Arakelov estimate, or abc
conclusion is postulated here.  Those are the source-facing layers to which
this finite identity is applied.
-/

namespace IUTThreeClosures

open Finset
open scoped BigOperators

namespace ProjectivePacketProductFormula

variable {ι ν : Type*}
variable [Fintype ι] [Nonempty ι] [Fintype ν]

/-- Average of the logarithmic coordinates of one finite packet. -/
noncomputable def packetAveragePF (x : ι → ℝ) : ℝ :=
  (∑ i, x i) / (Fintype.card ι : ℝ)

/-- A chosen local peak after removing the common scalar component.  In the
application, `peak` is the maximum logarithmic coordinate. -/
noncomputable def centeredPeakPF (x : ι → ℝ) (peak : ℝ) : ℝ :=
  peak - packetAveragePF x

/-- The weighted global average vanishes whenever each coordinate separately
satisfies the weighted product formula. -/
theorem weighted_sum_packetAveragePF_eq_zero
    (weight : ν → ℝ)
    (x : ν → ι → ℝ)
    (hProduct : ∀ i : ι, ∑ v : ν, weight v * x v i = 0) :
    ∑ v : ν, weight v * packetAveragePF (x v) = 0 := by
  have hcard : (Fintype.card ι : ℝ) ≠ 0 := by
    exact_mod_cast Fintype.card_ne_zero
  unfold packetAveragePF
  calc
    (∑ v : ν,
        weight v * ((∑ i : ι, x v i) / (Fintype.card ι : ℝ))) =
        (∑ v : ν, weight v * (∑ i : ι, x v i)) /
          (Fintype.card ι : ℝ) := by
            simp_rw [← mul_div_assoc]
            rw [Finset.sum_div]
    _ = (∑ i : ι, ∑ v : ν, weight v * x v i) /
          (Fintype.card ι : ℝ) := by
            congr 1
            calc
              (∑ v : ν, weight v * (∑ i : ι, x v i)) =
                  ∑ v : ν, ∑ i : ι, weight v * x v i := by
                    apply Finset.sum_congr rfl
                    intro v _hv
                    simpa using
                      (Finset.mul_sum Finset.univ (fun i : ι => x v i) (weight v))
              _ = ∑ i : ι, ∑ v : ν, weight v * x v i := by
                    rw [Finset.sum_comm]
    _ = 0 := by simp [hProduct]

/-- After global product-formula cancellation, the weighted sum of centered
peaks equals the weighted sum of the raw local peaks. -/
theorem weighted_sum_centeredPeakPF_eq_peak
    (weight : ν → ℝ)
    (x : ν → ι → ℝ)
    (peak : ν → ℝ)
    (hProduct : ∀ i : ι, ∑ v : ν, weight v * x v i = 0) :
    ∑ v : ν, weight v * centeredPeakPF (x v) (peak v) =
      ∑ v : ν, weight v * peak v := by
  unfold centeredPeakPF
  simp_rw [mul_sub]
  rw [Finset.sum_sub_distrib,
    weighted_sum_packetAveragePF_eq_zero weight x hProduct,
    sub_zero]

/-- The canonical/noncanonical Tate logarithmic vector has zero coordinate
average. -/
theorem tatePacketAverageNumerator_eq_zero
    {ell : ℕ} (hell : 0 < ell) (L : ℝ) :
    canonicalTateLineCoefficient ell * L +
        (ell : ℝ) * (noncanonicalTateLineCoefficient ell * L) = 0 := by
  calc
    canonicalTateLineCoefficient ell * L +
        (ell : ℝ) * (noncanonicalTateLineCoefficient ell * L) =
      (canonicalTateLineCoefficient ell +
        (ell : ℝ) * noncanonicalTateLineCoefficient ell) * L := by ring
    _ = 0 := by rw [tateLineCoefficient_balance hell, zero_mul]

/-- The actual average of one canonical and `ell` noncanonical Tate
coordinates is zero. -/
theorem tatePacketAverage_eq_zero
    {ell : ℕ} (hell : 0 < ell) (L : ℝ) :
    (canonicalTateLineCoefficient ell * L +
        (ell : ℝ) * (noncanonicalTateLineCoefficient ell * L)) /
        ((ell : ℝ) + 1) = 0 := by
  rw [tatePacketAverageNumerator_eq_zero hell L, zero_div]

/-- Because the Tate packet is already centered, removing its coordinate
average leaves the canonical logarithmic coordinate unchanged. -/
theorem centeredCanonicalTateCoordinatePF
    {ell : ℕ} (hell : 0 < ell) (L : ℝ) :
    canonicalTateLineCoefficient ell * L -
        (canonicalTateLineCoefficient ell * L +
          (ell : ℝ) * (noncanonicalTateLineCoefficient ell * L)) /
          ((ell : ℝ) + 1) =
      canonicalTateLineCoefficient ell * L := by
  rw [tatePacketAverage_eq_zero hell L, sub_zero]

/-- Adding one common local logarithmic factor to the balanced Tate packet
still leaves the centered canonical coordinate equal to the canonical Tate
term. -/
theorem centeredCanonicalTateCoordinatePF_add_common
    {ell : ℕ} (hell : 0 < ell) (L common : ℝ) :
    (common + canonicalTateLineCoefficient ell * L) -
        ((common + canonicalTateLineCoefficient ell * L) +
          (ell : ℝ) *
            (common + noncanonicalTateLineCoefficient ell * L)) /
          ((ell : ℝ) + 1) =
      canonicalTateLineCoefficient ell * L := by
  have hden : (ell : ℝ) + 1 ≠ 0 := by positivity
  have hbal := tatePacketAverageNumerator_eq_zero hell L
  field_simp [hden]
  nlinarith

end ProjectivePacketProductFormula

end IUTThreeClosures
