import IUTThreeClosures.ABCSharedCRTIncidenceSuccessor20260903

/-!
# Axiom audit: shared CRT-incidence successor

Compile this file directly with `-DwarningAsError=true`.  The inventory is
one-for-one with every public `abbrev`, `structure`, `def`, and `theorem` in
the implementation module.  The conditional admissible-boundary gate is
printed but is not assumed.
-/

open IUTThreeClosures
open ABCSharedCRTIncidenceSuccessor20260903

#print axioms OnceChargedCertificate
#print axioms OnceChargedCertificate.sourceMass
#print axioms OnceChargedCertificate.sinkMass
#print axioms OnceChargedCertificate.boundary
#print axioms OnceChargedCertificate.boundary_nonneg
#print axioms OnceChargedCertificate.totalCredit_le_sinkMass
#print axioms OnceChargedCertificate.sourceMass_sub_sinkMass_le_boundary
#print axioms OnceChargedCertificate.zero
#print axioms OnceChargedCertificate.zero_boundary

#print axioms EndpointOnceChargedCertificate
#print axioms endpointSharedBoundary
#print axioms endpointSourceMass_eq_log_core
#print axioms endpointSinkMass_eq_log_externalRadical
#print axioms signedEndpointCoreDefect_le_sharedBoundary
#print axioms height_le_conductor_add_sharedBoundary
#print axioms EndpointSharedAdmissibility
#print axioms UniformAdmissibleSharedCRTBoundary
#print axioms abc_of_uniformAdmissibleSharedCRTBoundary

#print axioms AggregatePooledAllocation
#print axioms AggregatePooledAllocation.boundary
#print axioms AggregatePooledAllocation.scalarDefect_le_boundary
#print axioms AggregatePooledAllocation.maximal
#print axioms AggregatePooledAllocation.maximal_boundary_eq_scalarDefect

#print axioms duplicatedSourceCredit
#print axioms singleSinkCharge
#print axioms duplicatedSourceCredit_sum
#print axioms singleSinkCharge_sum
#print axioms duplicatedCredit_not_le_singleCharge
#print axioms duplicatedReportedBoundary_eq_zero
#print axioms duplicatedReportedBoundary_breaks_massBridge
