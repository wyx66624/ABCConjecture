/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCPrimePacketBoundaryTransportSuccessor20260903
import Mathlib.Tactic

/-!
# Once-charged finite kernel for shared CRT incidence

The ordinary definitions and proofs precede this formal kernel in
`research/ABC_SHARED_CRT_INCIDENCE_SUCCESSOR_2026_09_03.md`.

The arithmetic SCRT-0 objects in that report are disjoint families of
saturated CRT hyperedges together with exclusive residual packets.  Their
essential accounting output is a source-credit/sink-charge certificate in
which total source credit is at most total sink charge and every sink charge
is at most its one available logarithmic capacity.  This module formalizes
that finite kernel, its endpoint height bridge, and the conditional
implication to the unchanged `ABCConjecture` for any specified arithmetic
admissibility predicate.

It also formalizes both guard rails from the ordinary proof.  Duplicating one
sink capacity for two sources violates the required total-credit inequality,
while completely unrestricted once-charged pooling has optimum exactly the
positive scalar source-minus-sink defect.  No uniform SCRT-0 estimate is
assumed or proved here.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section

namespace ABCSharedCRTIncidenceSuccessor20260903

open ABCPrimePacketBoundaryTransportSuccessor20260903
open SignedEndpointPrimeTokenTransport

/-! ## The once-charged finite capacity kernel -/

variable {alpha beta : Type*}

/-- A finite shared-incidence certificate after its arithmetic hyperedges
have been checked.  Source credit may be distributed, but the sum of all
credits is bounded by the sum of once-charged sink uses. -/
structure OnceChargedCertificate
    [Fintype alpha] [Fintype beta]
    (sourceWeight : alpha -> Real) (sinkWeight : beta -> Real) where
  sourceCredit : alpha -> Real
  sinkCharge : beta -> Real
  sourceCredit_nonneg : forall i, 0 <= sourceCredit i
  sourceCredit_le : forall i, sourceCredit i <= sourceWeight i
  sinkCharge_nonneg : forall j, 0 <= sinkCharge j
  sinkCharge_le : forall j, sinkCharge j <= sinkWeight j
  totalCredit_le_totalCharge :
    (∑ i, sourceCredit i) <= ∑ j, sinkCharge j

namespace OnceChargedCertificate

variable [Fintype alpha] [Fintype beta]
variable {sourceWeight : alpha -> Real} {sinkWeight : beta -> Real}

/-- Total source mass. -/
def sourceMass
    (_C : OnceChargedCertificate sourceWeight sinkWeight) : Real :=
  ∑ i, sourceWeight i

/-- Total available sink mass. -/
def sinkMass
    (_C : OnceChargedCertificate sourceWeight sinkWeight) : Real :=
  ∑ j, sinkWeight j

/-- Boundary left after subtracting the certified source credits. -/
def boundary
    (C : OnceChargedCertificate sourceWeight sinkWeight) : Real :=
  ∑ i, (sourceWeight i - C.sourceCredit i)

/-- Every certified boundary is nonnegative. -/
theorem boundary_nonneg
    (C : OnceChargedCertificate sourceWeight sinkWeight) :
    0 <= C.boundary := by
  unfold boundary
  exact Finset.sum_nonneg fun i _ => sub_nonneg.mpr (C.sourceCredit_le i)

/-- Once-only sink charging bounds total source credit by total available
sink mass. -/
theorem totalCredit_le_sinkMass
    (C : OnceChargedCertificate sourceWeight sinkWeight) :
    (∑ i, C.sourceCredit i) <= C.sinkMass := by
  have hcharge : (∑ j, C.sinkCharge j) <= ∑ j, sinkWeight j :=
    Finset.sum_le_sum fun j _ => C.sinkCharge_le j
  exact C.totalCredit_le_totalCharge.trans hcharge

/-- The finite mass inequality underlying every SCRT-0 height bridge. -/
theorem sourceMass_sub_sinkMass_le_boundary
    (C : OnceChargedCertificate sourceWeight sinkWeight) :
    C.sourceMass - C.sinkMass <= C.boundary := by
  have hcredit := C.totalCredit_le_sinkMass
  unfold sourceMass sinkMass boundary at *
  rw [Finset.sum_sub_distrib]
  linarith

/-- Zero credit and zero charge give a certificate whenever the source and
sink weights are nonnegative.  This is the formal empty configuration. -/
def zero
    (sourceWeight : alpha -> Real) (sinkWeight : beta -> Real)
    (hsource : forall i, 0 <= sourceWeight i)
    (hsink : forall j, 0 <= sinkWeight j) :
    OnceChargedCertificate sourceWeight sinkWeight where
  sourceCredit := fun _ => 0
  sinkCharge := fun _ => 0
  sourceCredit_nonneg := fun _ => le_rfl
  sourceCredit_le := hsource
  sinkCharge_nonneg := fun _ => le_rfl
  sinkCharge_le := hsink
  totalCredit_le_totalCharge := by simp

@[simp] theorem zero_boundary
    (sourceWeight : alpha -> Real) (sinkWeight : beta -> Real)
    (hsource : forall i, 0 <= sourceWeight i)
    (hsink : forall j, 0 <= sinkWeight j) :
    (zero sourceWeight sinkWeight hsource hsink).boundary =
      ∑ i, sourceWeight i := by
  simp [zero, boundary]

end OnceChargedCertificate

/-! ## Endpoint specialization and conditional abc reduction -/

/-- Once-charged certificates on the actual endpoint source and external
radical-prime sink types. -/
abbrev EndpointOnceChargedCertificate (P : ABCPoint) :=
  OnceChargedCertificate
    (alpha := EndpointPowerPrimeToken P)
    (beta := PrimeSupportToken (P.a * P.b))
    (endpointPowerPrimeWeight P)
    (fun q : PrimeSupportToken (P.a * P.b) => primeSupportTokenWeight q)

/-- Boundary of an endpoint once-charged certificate. -/
def endpointSharedBoundary
    (P : ABCPoint) (C : EndpointOnceChargedCertificate P) : Real :=
  C.boundary

/-- The endpoint source sum is the logarithm of the powerful core. -/
theorem endpointSourceMass_eq_log_core (P : ABCPoint) :
    (∑ s, endpointPowerPrimeWeight P s) =
      Real.log (endpointCore P : Real) := by
  let A := emptyEndpointPrimePacketAssignment P
  simpa only [PrimePacketAssignment.sourceMass] using
    (endpointPacket_sourceMass_eq_log_core P A)

/-- The external sink sum is the logarithm of the external radical. -/
theorem endpointSinkMass_eq_log_externalRadical (P : ABCPoint) :
    (∑ q : PrimeSupportToken (P.a * P.b), primeSupportTokenWeight q) =
      Real.log (externalRadical P : Real) := by
  let A := emptyEndpointPrimePacketAssignment P
  simpa only [PrimePacketAssignment.sinkMass] using
    (endpointPacket_sinkMass_eq_log_externalRadical P A)

/-- Every endpoint once-charged certificate bounds the exact signed endpoint
core defect. -/
theorem signedEndpointCoreDefect_le_sharedBoundary
    (P : ABCPoint) (C : EndpointOnceChargedCertificate P) :
    signedEndpointCoreDefect P <= endpointSharedBoundary P C := by
  have h := C.sourceMass_sub_sinkMass_le_boundary
  unfold OnceChargedCertificate.sourceMass
    OnceChargedCertificate.sinkMass at h
  rw [endpointSourceMass_eq_log_core P,
    endpointSinkMass_eq_log_externalRadical P] at h
  simpa [signedEndpointCoreDefect, endpointSharedBoundary] using h

/-- Pointwise height bridge for every capacity-correct shared CRT
certificate, independently of how its arithmetic admissibility was proved. -/
theorem height_le_conductor_add_sharedBoundary
    (P : ABCPoint) (C : EndpointOnceChargedCertificate P) :
    P.height <= P.conductor + endpointSharedBoundary P C := by
  have h := signedEndpointCoreDefect_le_sharedBoundary P C
  rw [← height_sub_conductor_eq_signedEndpointCoreDefect P] at h
  linarith

/-- An arithmetic admissibility predicate selects the capacity certificates
which actually arise from a proposed shared CRT hypergraph. -/
abbrev EndpointSharedAdmissibility :=
  forall P : ABCPoint, EndpointOnceChargedCertificate P -> Prop

/-- Uniform small-boundary gate for a specified arithmetic admissibility
predicate.  No predicate is asserted to inhabit this gate. -/
def UniformAdmissibleSharedCRTBoundary
    (Admissible : EndpointSharedAdmissibility) : Prop :=
  forall epsilon : Real, 0 < epsilon ->
    exists K : Real, forall P : ABCPoint,
      exists C : EndpointOnceChargedCertificate P,
        Admissible P C /\
        endpointSharedBoundary P C <= epsilon * P.conductor + K

/-- Any uniform admissible once-charged shared-CRT boundary estimate implies
the unchanged standard logarithmic abc conjecture. -/
theorem abc_of_uniformAdmissibleSharedCRTBoundary
    (Admissible : EndpointSharedAdmissibility)
    (hgate : UniformAdmissibleSharedCRTBoundary Admissible) :
    ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨K, hK⟩ := hgate epsilon hepsilon
  refine ⟨K, ?_⟩
  intro a b c ha hb hc hsum hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hsum
      pairwise_coprime := hcoprime }
  obtain ⟨C, _hAdmissible, hC⟩ := hK P
  have hheight := height_le_conductor_add_sharedBoundary P C
  have hpoint : P.height <= (1 + epsilon) * P.conductor + K := by
    calc
      P.height <= P.conductor + endpointSharedBoundary P C := hheight
      _ <= P.conductor + (epsilon * P.conductor + K) := by linarith
      _ = (1 + epsilon) * P.conductor + K := by ring
  simpa [P, ABCPoint.height, ABCPoint.conductor, P.max_eq_c] using hpoint

/-! ## Unrestricted pooling collapses to the scalar positive part -/

/-- Aggregate form of a completely unrestricted once-charged pooled
allocation. -/
structure AggregatePooledAllocation (X Y : Real) where
  credit : Real
  credit_nonneg : 0 <= credit
  credit_le_source : credit <= X
  credit_le_sink : credit <= Y

namespace AggregatePooledAllocation

/-- Boundary left by an aggregate pooled allocation. -/
def boundary {X Y : Real} (A : AggregatePooledAllocation X Y) : Real :=
  X - A.credit

/-- Every pooled allocation leaves at least the scalar positive-part
defect. -/
theorem scalarDefect_le_boundary
    {X Y : Real} (A : AggregatePooledAllocation X Y) :
    max (X - Y) 0 <= A.boundary := by
  unfold boundary
  apply max_le
  · linarith [A.credit_le_sink]
  · linarith [A.credit_le_source]

/-- The maximal unrestricted pooled allocation uses `min X Y` credit. -/
def maximal (X Y : Real) (hX : 0 <= X) (hY : 0 <= Y) :
    AggregatePooledAllocation X Y where
  credit := min X Y
  credit_nonneg := le_min hX hY
  credit_le_source := min_le_left X Y
  credit_le_sink := min_le_right X Y

/-- Completely unrestricted once-charged pooling attains exactly the scalar
positive-part defect. -/
theorem maximal_boundary_eq_scalarDefect
    (X Y : Real) (hX : 0 <= X) (hY : 0 <= Y) :
    (maximal X Y hX hY).boundary = max (X - Y) 0 := by
  change X - min X Y = max (X - Y) 0
  rcases le_total X Y with hXY | hYX
  · rw [min_eq_left hXY, max_eq_right (sub_nonpos.mpr hXY)]
    ring
  · rw [min_eq_right hYX, max_eq_left (sub_nonneg.mpr hYX)]

end AggregatePooledAllocation

/-! ## Duplicated capacity is not once-charged -/

/-- Two unit source credits, used to expose duplicated sink accounting. -/
def duplicatedSourceCredit (_i : Fin 2) : Real := 1

/-- One unit sink charge. -/
def singleSinkCharge (_j : Unit) : Real := 1

theorem duplicatedSourceCredit_sum :
    (∑ i : Fin 2, duplicatedSourceCredit i) = 2 := by
  norm_num [duplicatedSourceCredit]

theorem singleSinkCharge_sum :
    (∑ j : Unit, singleSinkCharge j) = 1 := by
  norm_num [singleSinkCharge]

/-- Crediting the one sink independently to both sources violates the global
once-charge condition. -/
theorem duplicatedCredit_not_le_singleCharge :
    not ((∑ i : Fin 2, duplicatedSourceCredit i) <=
      ∑ j : Unit, singleSinkCharge j) := by
  rw [duplicatedSourceCredit_sum, singleSinkCharge_sum]
  norm_num

/-- The duplicated bookkeeping would report zero boundary. -/
theorem duplicatedReportedBoundary_eq_zero :
    (∑ i : Fin 2, ((1 : Real) - duplicatedSourceCredit i)) = 0 := by
  norm_num [duplicatedSourceCredit]

/-- The same duplicated bookkeeping cannot satisfy the source-minus-sink
height bridge: its left side is one and its reported boundary is zero. -/
theorem duplicatedReportedBoundary_breaks_massBridge :
    not (((∑ _i : Fin 2, (1 : Real)) - ∑ _j : Unit, (1 : Real)) <=
      ∑ i : Fin 2, ((1 : Real) - duplicatedSourceCredit i)) := by
  norm_num [duplicatedSourceCredit]

end ABCSharedCRTIncidenceSuccessor20260903
end
end IUTThreeClosures
