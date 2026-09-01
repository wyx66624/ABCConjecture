/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AnalyticAmplificationContinuation20260830
import IUTThreeClosures.DVRReachableHaar20260830
import IUTThreeClosures.GeometryUniformityContinuation20260830
import IUTThreeClosures.IUTReachabilityContinuation20260830
import IUTThreeClosures.MatveevPellFinitePacket20260830
import IUTThreeClosures.IUTTargetReset20260830

/-!
# Declaration and kernel dependency audit for the August 30 continuation

This audit displays the original standard target without supplying a proof
of it. The Matveev and BEG theorems are not newly declared axioms: scalar
estimates which use their conclusions keep those estimates as explicit
arguments. Full-rank Haar is checked on the compact integral lattice;
source-specific local fields and ambient measure restriction are separate.
The target-reset theorem keeps the source family and its classes fixed.
-/

open IUTThreeClosures
open IUTThreeClosures.AnalyticAmplificationContinuation20260830
open IUTThreeClosures.DVRReachableHaar20260830
open IUTThreeClosures.IUTReachabilityContinuation20260830
open IUTThreeClosures.IUTTargetReset20260830

#print ABCConjecture

#check @inherited_radical_bound
#print axioms inherited_radical_bound
#check @inherited_cofactor_certificate_budget
#print axioms inherited_cofactor_certificate_budget
#check @crt_certificate_unique_in_strip
#print axioms crt_certificate_unique_in_strip
#check @crtCertifiedUpTo_card_le
#print axioms crtCertifiedUpTo_card_le
#check @inherited_template_union_card_le
#print axioms inherited_template_union_card_le
#check @square_completion_radical_bound
#print axioms square_completion_radical_bound
#check @square_completion_parameter_identity
#print axioms square_completion_parameter_identity
#check @square_completion_certificate_height
#print axioms square_completion_certificate_height
#check @seed_radical_product_ge_sq
#print axioms seed_radical_product_ge_sq
#check @half_lt_bblt_exponent
#print axioms half_lt_bblt_exponent

#check @mem_range_of_det_dvd_cramer
#print axioms mem_range_of_det_dvd_cramer
#check @exists_reachable_min_det_span
#print axioms exists_reachable_min_det_span
#check @cardQuot_matrix_range
#print axioms cardQuot_matrix_range
#check @matrix_range_isClosed
#print axioms matrix_range_isClosed
#check @measure_matrix_range
#print axioms measure_matrix_range
#check @log_measure_matrix_range
#print axioms log_measure_matrix_range
#check @exists_reachable_closed_span_volume
#print axioms exists_reachable_closed_span_volume

#check @geometry_logAbsorption
#print axioms geometry_logAbsorption
#check @geometry_jointSixthLogCorridor
#print axioms geometry_jointSixthLogCorridor
#check @geometry_normThreeRatioBounds
#print axioms geometry_normThreeRatioBounds
#check @geometry_indexTwoRatioBound
#print axioms geometry_indexTwoRatioBound
#check @ABCPoint.geometryFrey_invariantNormalization
#print axioms ABCPoint.geometryFrey_invariantNormalization
#check @ABCPoint.geometryFrey_normalizedMordellPoint
#print axioms ABCPoint.geometryFrey_normalizedMordellPoint
#check @ABCPoint.geometryFrey_weightedPrimitive
#print axioms ABCPoint.geometryFrey_weightedPrimitive
#check @ABCPoint.geometryFrey_normalizedCubicSplit
#print axioms ABCPoint.geometryFrey_normalizedCubicSplit

#check @principalHull_le
#print axioms principalHull_le
#check @isUnit_tmul
#print axioms isUnit_tmul
#check @linearIndependent_tmul_mul
#print axioms linearIndependent_tmul_mul
#check @scaledIntegralTensorSpan_le_hull
#print axioms scaledIntegralTensorSpan_le_hull

#check @pellMatveevRoot_sq
#print axioms pellMatveevRoot_sq
#check @pellMatveevEta_of_packet
#print axioms pellMatveevEta_of_packet
#check @pellMatveevEta_fourth
#print axioms pellMatveevEta_fourth
#check @pellMatveev_actualApproximation
#print axioms pellMatveev_actualApproximation
#check @pellMatveev_actualLogLower
#print axioms pellMatveev_actualLogLower
#check @pellMatveev_actualLogHeight
#print axioms pellMatveev_actualLogHeight
#check @pellMatveev_normalizedExponentBound
#print axioms pellMatveev_normalizedExponentBound
#check @pellMatveev_indexAbsorption
#print axioms pellMatveev_indexAbsorption
#check @pellMatveev_explicitEstimate_indexBound
#print axioms pellMatveev_explicitEstimate_indexBound
#check @pellMatveev_effectiveHeightCap
#print axioms pellMatveev_effectiveHeightCap
#check @pellMatveev_effectiveCoordinateCap
#print axioms pellMatveev_effectiveCoordinateCap

#check @image_coherentCollation
#print axioms image_coherentCollation
#check @map_span_coherentCollation
#print axioms map_span_coherentCollation
#check @coherentCollation_reindex
#print axioms coherentCollation_reindex
