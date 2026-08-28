/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.RefinedFactorLocalFieldData
import Mathlib.MeasureTheory.Measure.Haar.NormedSpace
import Mathlib.MeasureTheory.Measure.Haar.MulEquivHaarChar

/-! Temporary declaration probe for the pinned Mathlib Haar APIs. -/

open MeasureTheory

#check PositiveCompacts
#check Measure.addHaarMeasure
#check Measure.addHaarMeasure_self
#check Measure.isAddLeftInvariant_addHaarMeasure
#check Measure.isHaarMeasure_addHaarMeasure
#check Measure.addHaarScalarFactor
#check Measure.addHaarScalarFactor_smulRight
#check Measure.addHaarScalarFactor_inner
#check Measure.map_smul
#check Measure.map_addHaarMeasure_eq_smul_addHaarMeasure
#check MeasurePreserving
#check MeasurableEquiv
#check MeasurableEquiv.smulRight
#check Metric.closedBall
#check isCompact_closedBall
#check Metric.ball_mem_nhds
#check interior_nonempty_iff
