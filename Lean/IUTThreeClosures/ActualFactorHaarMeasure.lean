/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.RefinedFactorLocalFieldData
import IUTThreeClosures.HonestFinitePositiveLogVolume
import Mathlib.MeasureTheory.Measure.Haar.Basic

/-!
# The actual normalized additive Haar measure on every primitive packet factor

A primitive factor of a finite-etale tensor packet is a finite extension of
`ℚ_[p]`.  `RefinedFactorLocalFieldData` constructs its canonical spectral norm,
complete locally compact topology, and maximal integral order.  This module
uses those derived structures to construct, rather than postulate, an additive
Haar measure normalized by the closed spectral unit ball.

The measurable space and measure are bundled explicitly.  This avoids
installing a second global normed-field instance on the quotient field and
allows downstream finite-positive regions to use exactly the same canonical
spectral realization.
-/

namespace IUTThreeClosures

open MeasureTheory

universe u v

/-- A measure together with the concrete measurable unit ball used to
normalize it.  The measurable space is bundled because the canonical spectral
norm on a refined factor is installed locally. -/
structure ActualNormalizedAddHaarMeasure (L : Type u) where
  measurableSpace : MeasurableSpace L
  measure : @Measure L measurableSpace
  unitBall : Set L
  unitBallMeasurable : @MeasurableSet L measurableSpace unitBall
  measure_unitBall : measure unitBall = 1

namespace RefinedFactorHaar

variable {p : ℕ} [Fact p.Prime]
variable {Tuple : Type u}
variable (P : TupleFiniteEtalePacket ℚ_[p] Tuple)
variable (d : P.RefinedComponent)

/-- The closed spectral unit ball, regarded as a positive compact set. -/
noncomputable def unitBallPositiveCompact :
    letI : Algebra.IsAlgebraic ℚ_[p] (P.Summand d) :=
      Algebra.IsAlgebraic.of_finite
    letI : NontriviallyNormedField (P.Summand d) :=
      spectralNorm.nontriviallyNormedField ℚ_[p] (P.Summand d)
    letI : NormedAlgebra ℚ_[p] (P.Summand d) :=
      spectralNorm.normedAlgebra ℚ_[p] (P.Summand d)
    letI : IsUltrametricDist (P.Summand d) :=
      IsUltrametricDist.of_normedAlgebra ℚ_[p] (P.Summand d)
    letI : CompleteSpace (P.Summand d) :=
      spectralNorm.completeSpace ℚ_[p] (P.Summand d)
    letI : ProperSpace (P.Summand d) :=
      FiniteDimensional.proper ℚ_[p] (P.Summand d)
    PositiveCompacts (P.Summand d) := by
  letI : Algebra.IsAlgebraic ℚ_[p] (P.Summand d) :=
    Algebra.IsAlgebraic.of_finite
  letI : NontriviallyNormedField (P.Summand d) :=
    spectralNorm.nontriviallyNormedField ℚ_[p] (P.Summand d)
  letI : NormedAlgebra ℚ_[p] (P.Summand d) :=
    spectralNorm.normedAlgebra ℚ_[p] (P.Summand d)
  letI : IsUltrametricDist (P.Summand d) :=
    IsUltrametricDist.of_normedAlgebra ℚ_[p] (P.Summand d)
  letI : CompleteSpace (P.Summand d) :=
    spectralNorm.completeSpace ℚ_[p] (P.Summand d)
  letI : ProperSpace (P.Summand d) :=
    FiniteDimensional.proper ℚ_[p] (P.Summand d)
  refine ⟨⟨Metric.closedBall 0 1, isCompact_closedBall 0 1⟩, ?_⟩
  refine ⟨0, mem_interior_iff_mem_nhds.mpr ?_⟩
  exact Filter.mem_of_superset
    (Metric.ball_mem_nhds (0 : P.Summand d) zero_lt_one)
    Metric.ball_subset_closedBall

/-- The actual additive Haar measure on a primitive factor, normalized so that
the closed spectral unit ball has measure one. -/
noncomputable def actualMeasure :
    ActualNormalizedAddHaarMeasure (P.Summand d) := by
  letI : Algebra.IsAlgebraic ℚ_[p] (P.Summand d) :=
    Algebra.IsAlgebraic.of_finite
  letI : NontriviallyNormedField (P.Summand d) :=
    spectralNorm.nontriviallyNormedField ℚ_[p] (P.Summand d)
  letI : NormedAlgebra ℚ_[p] (P.Summand d) :=
    spectralNorm.normedAlgebra ℚ_[p] (P.Summand d)
  letI : IsUltrametricDist (P.Summand d) :=
    IsUltrametricDist.of_normedAlgebra ℚ_[p] (P.Summand d)
  letI : CompleteSpace (P.Summand d) :=
    spectralNorm.completeSpace ℚ_[p] (P.Summand d)
  letI : ProperSpace (P.Summand d) :=
    FiniteDimensional.proper ℚ_[p] (P.Summand d)
  let K := unitBallPositiveCompact P d
  refine
    { measurableSpace := inferInstance
      measure := Measure.addHaarMeasure K
      unitBall := Metric.closedBall 0 1
      unitBallMeasurable := measurableSet_closedBall
      measure_unitBall := ?_ }
  simpa [K, unitBallPositiveCompact] using
    (Measure.addHaarMeasure_self K)

/-- The actual normalized unit ball is a finite-positive region.  Thus the
consistent `FinitePositiveRegion`/`HonestGeneratedSource` pipeline can use the
real Haar measure without invoking the inconsistent total `LogVolumeData`
interface. -/
noncomputable def unitBallFinitePositive :
    let H := actualMeasure P d
    letI : MeasurableSpace (P.Summand d) := H.measurableSpace
    FinitePositiveRegion (P.Summand d) H.measure := by
  let H := actualMeasure P d
  letI : MeasurableSpace (P.Summand d) := H.measurableSpace
  refine
    { carrier := H.unitBall
      measurable := H.unitBallMeasurable
      measure_ne_zero := ?_
      measure_ne_top := ?_ }
  · rw [H.measure_unitBall]
    exact one_ne_zero
  · rw [H.measure_unitBall]
    exact one_ne_top

end RefinedFactorHaar

end IUTThreeClosures
