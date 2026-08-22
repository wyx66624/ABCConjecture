/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualLocalKummerChoices

/-!
# Maximal-order envelopes for actual Kummer outputs

The integral order inherited from a tensor product may be a proper suborder of
the product of maximal valuation rings.  A norm-one Ind1 unit need not preserve
that proper order.  For the upper-bound direction, however, this causes no
problem: if the actual order lies in the norm unit ball, then every unit-twisted
q-power of the actual order lies in the corresponding q-power of the maximal
order.

This is the local inclusion needed by the full-Ind3 hull-envelope route.  It
requires only an actual-order containment, not equality of integral orders and
not an arbitrary numerical component bound.
-/

namespace IUTThreeClosures

open TateCurvesTheta
open scoped Pointwise

universe u v

namespace TateCurvesTheta

variable {K : Type v} [NormedField K]

/-- A norm-one unit times `q^n` sends any subregion of the maximal integral
ball into the canonical Tate q-power region. -/
theorem scaledRegion_unit_mul_qPower_subset
    (t : TateParameter K) (u : Kˣ) (hu : ‖(u : K)‖ = 1)
    (O : Set K) (hO : O ⊆ normIntegralRegion (K := K)) (n : ℕ) :
    scaledRegion ((u : K) * (t.q : K) ^ n) O ⊆ t.qPowerRegion n := by
  rintro x ⟨y, hy, rfl⟩
  refine ⟨(u : K) * y, ?_, ?_⟩
  · have hy' : ‖y‖ ≤ 1 := hO hy
    change ‖(u : K) * y‖ ≤ 1
    rw [norm_mul, hu, one_mul]
    exact hy'
  · ring

end TateCurvesTheta

namespace FactorKummerChoice

variable {C : Type u} {K : C → Type v}
variable [∀ c, NormedField (K c)]

/-- Product region obtained by applying an actual tensor-product integral
suborder in each primitive field factor. -/
def packetRegionOverOrder
    (A : FactorKummerChoice C K)
    (O : ∀ c, Set (K c)) : Set (∀ c, K c) :=
  {x | ∀ c, x c ∈
    scaledRegion (A.outputValue c) (O c)}

@[simp]
theorem mem_packetRegionOverOrder
    (A : FactorKummerChoice C K)
    (O : ∀ c, Set (K c)) (x : ∀ c, K c) :
    x ∈ A.packetRegionOverOrder O ↔
      ∀ c, x c ∈ scaledRegion (A.outputValue c) (O c) := Iff.rfl

/-- Every factorwise actual-order output is contained in the canonical product
of maximal-order q-power regions. -/
theorem packetRegionOverOrder_subset_qPowerProduct
    (A : FactorKummerChoice C K)
    (O : ∀ c, Set (K c))
    (hO : ∀ c, O c ⊆ normIntegralRegion (K := K c)) :
    A.packetRegionOverOrder O ⊆
      {x | ∀ c, x c ∈ (A.tate c).qPowerRegion (A.power c)} := by
  intro x hx c
  exact TateCurvesTheta.scaledRegion_unit_mul_qPower_subset
    (A.tate c) (A.ind1 c).unit (A.ind1 c).norm_eq_one
    (O c) (hO c) (A.power c) (hx c)

/-- The same containment expressed using the canonical factor packet. -/
theorem packetRegionOverOrder_subset_packetRegion
    (A : FactorKummerChoice C K)
    (O : ∀ c, Set (K c))
    (hO : ∀ c, O c ⊆ normIntegralRegion (K := K c)) :
    A.packetRegionOverOrder O ⊆ A.packetRegion := by
  rw [A.packetRegion_eq_qPowerProduct]
  exact A.packetRegionOverOrder_subset_qPowerProduct O hO

end FactorKummerChoice

end IUTThreeClosures
