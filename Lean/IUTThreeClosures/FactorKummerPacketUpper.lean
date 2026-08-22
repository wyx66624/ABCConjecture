/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FactorKummerHaarComponent

/-!
# Weighted packet upper bound from factorwise Kummer/Haar formulas

After the corrected semisimple decomposition, one packet is a finite product of
primitive local-field factors.  If every factor carries its honest Tate/Haar
data and the packet weights are nonnegative, the exact local formula implies
the complete weighted packet upper bound.  The finite integral-index terms
are all nonpositive and therefore disappear in the IUT-IV upper-bound
direction.

This file performs only the finite weighted algebra.  It does not assume a
public theta coefficient or a final height estimate.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

variable {C : Type u} [Fintype C]
variable {K : C → Type v} [∀ c, NormedField (K c)]

/-- Exact weighted measured log-volume of a factorwise Kummer packet. -/
noncomputable def factorKummerPacketLogVolume
    (D : ∀ c, FactorKummerHaarData (K c))
    (weight : C → ℝ) (power : C → ℕ) : ℝ :=
  ∑ c, weight c * ((D c).outputRegion (power c)).logVolume

/-- Canonical q-power upper expression for the packet. -/
noncomputable def factorKummerPacketQUpper
    (D : ∀ c, FactorKummerHaarData (K c))
    (weight : C → ℝ) (power : C → ℕ) : ℝ :=
  ∑ c, weight c *
    ((power c : ℝ) * Real.log ‖(((D c).tate.q : K c))‖)

/-- Exact packet formula including every finite-index correction. -/
theorem factorKummerPacketLogVolume_eq
    (D : ∀ c, FactorKummerHaarData (K c))
    (weight : C → ℝ) (power : C → ℕ) :
    factorKummerPacketLogVolume D weight power =
      ∑ c, weight c *
        (((power c : ℝ) * Real.log ‖(((D c).tate.q : K c))‖) -
          Real.log
            (Fintype.card (D c).finiteIndex.Quotient : ℝ)) := by
  unfold factorKummerPacketLogVolume
  apply Finset.sum_congr rfl
  intro c hc
  rw [(D c).outputRegion_logVolume]

/-- Nonnegative packet weights preserve the local upper bounds. -/
theorem factorKummerPacketLogVolume_le
    (D : ∀ c, FactorKummerHaarData (K c))
    (weight : C → ℝ) (power : C → ℕ)
    (hweight : ∀ c, 0 ≤ weight c) :
    factorKummerPacketLogVolume D weight power ≤
      factorKummerPacketQUpper D weight power := by
  unfold factorKummerPacketLogVolume factorKummerPacketQUpper
  apply Finset.sum_le_sum
  intro c hc
  exact mul_le_mul_of_nonneg_left
    ((D c).outputRegion_logVolume_le (power c)) (hweight c)

/-- If the packet weights sum to one, the theorem remains an upper estimate
with the same canonical q-expression; normalization is recorded separately so
that no hidden rescaling is introduced. -/
theorem factorKummerPacketLogVolume_le_of_probabilityWeights
    (D : ∀ c, FactorKummerHaarData (K c))
    (weight : C → ℝ) (power : C → ℕ)
    (hweight : ∀ c, 0 ≤ weight c)
    (_hsum : ∑ c, weight c = 1) :
    factorKummerPacketLogVolume D weight power ≤
      factorKummerPacketQUpper D weight power :=
  factorKummerPacketLogVolume_le D weight power hweight

end IUTThreeClosures
