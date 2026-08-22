/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FiniteIndexHaarCorrection

/-!
# Finite integral index is favorable for upper bounds

The tensor-product integral order may be a proper finite-index suborder of the
product of maximal valuation rings.  Its logarithmic correction is
`-log N`, hence nonpositive.  Therefore it can be discarded in the direction
needed for the IUT IV component-volume upper bound.

This does not remove other different/ramification terms arising from changing
fields or mono-analytic structures.  It proves only that the semisimple-factor
integral-index seam itself cannot enlarge the local log-volume.
-/

namespace IUTThreeClosures

open MeasureTheory

universe u v

namespace FinitePositiveRegion.FiniteIndexComparison

variable {α : Type u} [MeasurableSpace α] {μ : Measure α}
variable {U V : FinitePositiveRegion α μ}

/-- The finite-index logarithmic correction is nonpositive. -/
theorem neg_log_card_nonpos
    (C : FinitePositiveRegion.FiniteIndexComparison.{u, v} U V) :
    -Real.log (Fintype.card C.Quotient : ℝ) ≤ 0 := by
  have hcardNat : 1 ≤ Fintype.card C.Quotient :=
    Nat.one_le_iff_ne_zero.mpr (Fintype.card_ne_zero)
  have hcard : (1 : ℝ) ≤ (Fintype.card C.Quotient : ℝ) := by
    exact_mod_cast hcardNat
  exact neg_nonpos.mpr (Real.log_nonneg hcard)

/-- Passing to a finite-index integral order can only decrease the scaled
component log-volume. -/
theorem iterate_scaling_logVolume_le
    (C : FinitePositiveRegion.FiniteIndexComparison.{u, v} U V)
    {f : Set α → Set α} {a : ℝ}
    (S : FinitePositiveRegion.ScalingLaw (μ := μ) f a) (n : ℕ) :
    ((S.iterate n).pullback U).logVolume ≤
      V.logVolume + (n : ℝ) * a := by
  rw [C.iterate_scaling_logVolume S n]
  have h := C.neg_log_card_nonpos
  linarith

/-- With maximal compact volume normalized to zero, the actual order satisfies
the same q-power upper bound as the maximal order. -/
theorem iterate_scaling_logVolume_le_of_large_eq_zero
    (C : FinitePositiveRegion.FiniteIndexComparison.{u, v} U V)
    {f : Set α → Set α} {a : ℝ}
    (S : FinitePositiveRegion.ScalingLaw (μ := μ) f a) (n : ℕ)
    (hV : V.logVolume = 0) :
    ((S.iterate n).pullback U).logVolume ≤ (n : ℝ) * a := by
  simpa [hV] using C.iterate_scaling_logVolume_le S n

end FinitePositiveRegion.FiniteIndexComparison

end IUTThreeClosures
