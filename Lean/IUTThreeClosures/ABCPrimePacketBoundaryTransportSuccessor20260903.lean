/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCSignedEndpointPrimeTokenTransport20260903
import Mathlib.Tactic

/-!
# Prime-packet boundary transport

The ordinary mathematical proof precedes this formalization in
`research/ABC_PRIME_PACKET_BOUNDARY_TRANSPORT_SUCCESSOR_2026_09_03.md`.

Hard prime order and fixed per-edge descent costs are both obstructed by
complete-premise square families.  This module instead aggregates all excess
layers at one endpoint prime into a single source and assigns each external
radical-prime token, indivisibly, to at most one source packet.  The packet
residual satisfies a finite boundary inequality.  Applied to the exact
endpoint core identity, that inequality gives a conditional implication from
a uniform small-packet-residual gate to the unchanged `ABCConjecture`.

The packet gate is not assumed or proved in this module.  A two-source/one-sink
example formally shows that packet optimization does not collapse pointwise
to the fully divisible scalar relaxation.  A prime-square calculation shows
that all external sinks can lie in one packet when `c = p^2`; individual sink
sizes therefore impose no edge-order or per-edge descent charge.  The later
Linnik obstruction module and its ordinary report refute the exact uniform
gate by a different, many-source/one-sink mechanism; the definitions and
conditional implication here remain valid.
-/

namespace IUTThreeClosures

open scoped BigOperators
open UniqueFactorizationMonoid

noncomputable section

namespace ABCPrimePacketBoundaryTransportSuccessor20260903

open SignedEndpointPrimeTokenTransport

/-! ## Finite indivisible sink packets -/

variable {α β : Type*}

/-- An indivisible packet assignment.  Every sink is either unused or owned
by exactly one source. -/
structure PrimePacketAssignment (α β : Type*) where
  owner : β → Option α

namespace PrimePacketAssignment

variable [Fintype α] [Fintype β] [DecidableEq α]

/-- Total source weight. -/
def sourceMass
    (_A : PrimePacketAssignment α β) (sourceWeight : α → ℝ) : ℝ :=
  ∑ i, sourceWeight i

/-- Total available sink weight. -/
def sinkMass
    (_A : PrimePacketAssignment α β) (sinkWeight : β → ℝ) : ℝ :=
  ∑ j, sinkWeight j

/-- Total sink weight in the packet owned by `i`. -/
def packetMass
    (A : PrimePacketAssignment α β) (sinkWeight : β → ℝ) (i : α) : ℝ :=
  ∑ j, if A.owner j = some i then sinkWeight j else 0

/-- Positive source boundary left after inserting its packet. -/
def packetResidual
    (A : PrimePacketAssignment α β)
    (sourceWeight : α → ℝ) (sinkWeight : β → ℝ) (i : α) : ℝ :=
  max (sourceWeight i - A.packetMass sinkWeight i) 0

/-- Sum of all positive source boundaries. -/
def totalResidual
    (A : PrimePacketAssignment α β)
    (sourceWeight : α → ℝ) (sinkWeight : β → ℝ) : ℝ :=
  ∑ i, A.packetResidual sourceWeight sinkWeight i

/-- Total weight of sinks which occur in some packet. -/
def allocatedMass
    (A : PrimePacketAssignment α β) (sinkWeight : β → ℝ) : ℝ :=
  ∑ j, match A.owner j with
    | none => 0
    | some _ => sinkWeight j

/-- The empty assignment is always available. -/
def empty : PrimePacketAssignment α β where
  owner := fun _ => none

/-- Put every sink into one chosen source packet. -/
def allSinksTo (i₀ : α) : PrimePacketAssignment α β where
  owner := fun _ => some i₀

omit [Fintype α] in
theorem packetResidual_nonneg
    (A : PrimePacketAssignment α β)
    (sourceWeight : α → ℝ) (sinkWeight : β → ℝ) (i : α) :
    0 ≤ A.packetResidual sourceWeight sinkWeight i := by
  exact le_max_right _ _

omit [Fintype α] in
theorem source_sub_packetMass_le_packetResidual
    (A : PrimePacketAssignment α β)
    (sourceWeight : α → ℝ) (sinkWeight : β → ℝ) (i : α) :
    sourceWeight i - A.packetMass sinkWeight i ≤
      A.packetResidual sourceWeight sinkWeight i := by
  exact le_max_left _ _

/-- Disjoint ownership makes the sum of packet masses equal the mass of all
assigned sinks. -/
theorem sum_packetMass_eq_allocatedMass
    (A : PrimePacketAssignment α β) (sinkWeight : β → ℝ) :
    (∑ i, A.packetMass sinkWeight i) = A.allocatedMass sinkWeight := by
  classical
  unfold packetMass allocatedMass
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro j _
  cases h : A.owner j with
  | none => simp
  | some i₀ => simp

omit [Fintype α] [DecidableEq α] in
theorem allocatedMass_le_sinkMass
    (A : PrimePacketAssignment α β) (sinkWeight : β → ℝ)
    (hsink : ∀ j, 0 ≤ sinkWeight j) :
    A.allocatedMass sinkWeight ≤ A.sinkMass sinkWeight := by
  classical
  unfold allocatedMass sinkMass
  apply Finset.sum_le_sum
  intro j _
  cases h : A.owner j with
  | none => simpa [h] using hsink j
  | some i => simp

/-- Finite packet boundary inequality.  It is the only generic inequality
needed by the abc reduction. -/
theorem sourceMass_sub_sinkMass_le_totalResidual
    (A : PrimePacketAssignment α β)
    (sourceWeight : α → ℝ) (sinkWeight : β → ℝ)
    (hsink : ∀ j, 0 ≤ sinkWeight j) :
    A.sourceMass sourceWeight - A.sinkMass sinkWeight ≤
      A.totalResidual sourceWeight sinkWeight := by
  have hlocal :
      (∑ i, (sourceWeight i - A.packetMass sinkWeight i)) ≤
        A.totalResidual sourceWeight sinkWeight := by
    unfold totalResidual
    exact Finset.sum_le_sum fun i _ =>
      A.source_sub_packetMass_le_packetResidual sourceWeight sinkWeight i
  have hpackets := A.sum_packetMass_eq_allocatedMass sinkWeight
  have hallocated := A.allocatedMass_le_sinkMass sinkWeight hsink
  unfold sourceMass sinkMass at *
  rw [Finset.sum_sub_distrib, hpackets] at hlocal
  linarith

omit [Fintype α] in
theorem empty_packetMass
    (sinkWeight : β → ℝ) (i : α) :
    (empty : PrimePacketAssignment α β).packetMass sinkWeight i = 0 := by
  simp [packetMass, empty]

omit [Fintype α] in
theorem allSinksTo_packetMass_self
    (sinkWeight : β → ℝ) (i₀ : α) :
    (allSinksTo i₀ : PrimePacketAssignment α β).packetMass sinkWeight i₀ =
      ∑ j, sinkWeight j := by
  simp [packetMass, allSinksTo]

omit [Fintype α] in
theorem allSinksTo_packetMass_of_ne
    (sinkWeight : β → ℝ) {i₀ i : α} (hi : i ≠ i₀) :
    (allSinksTo i₀ : PrimePacketAssignment α β).packetMass sinkWeight i = 0 := by
  simp [packetMass, allSinksTo, Ne.symm hi]

/-- With one source vertex, a single packet aggregates every sink and leaves
exactly the scalar positive-part deficit. -/
theorem allSinksTo_totalResidual_of_unique
    (sourceWeight : α → ℝ) (sinkWeight : β → ℝ) (i₀ : α)
    (hunique : ∀ i : α, i = i₀) :
    (allSinksTo i₀ : PrimePacketAssignment α β).totalResidual
        sourceWeight sinkWeight =
      max (sourceWeight i₀ - ∑ j, sinkWeight j) 0 := by
  classical
  have huniv : (Finset.univ : Finset α) = {i₀} := by
    ext i
    simp [hunique i]
  unfold totalResidual
  rw [huniv]
  simp [packetResidual, allSinksTo_packetMass_self]

end PrimePacketAssignment

/-! ## Endpoint specialization -/

/-- One aggregate source for every prime dividing the endpoint. -/
abbrev EndpointPowerPrimeToken (P : ABCPoint) := PrimeSupportToken P.c

/-- All exponent layers above the radical copy, aggregated at one prime. -/
def endpointPowerPrimeWeight (P : ABCPoint)
    (s : EndpointPowerPrimeToken P) : ℝ :=
  ((P.c.factorization s.1 - 1 : ℕ) : ℝ) * Real.log (s.1 : ℝ)

/-- Packet assignments from endpoint prime-power sources to external radical
prime sinks. -/
abbrev EndpointPrimePacketAssignment (P : ABCPoint) :=
  PrimePacketAssignment
    (EndpointPowerPrimeToken P) (PrimeSupportToken (P.a * P.b))

theorem endpointPowerPrimeWeight_nonneg
    (P : ABCPoint) (s : EndpointPowerPrimeToken P) :
    0 ≤ endpointPowerPrimeWeight P s := by
  unfold endpointPowerPrimeWeight
  exact mul_nonneg (Nat.cast_nonneg _)
    (Real.log_nonneg (by
      exact_mod_cast (Nat.prime_of_mem_primeFactors s.2).one_le))

theorem endpointExternalPrimeWeight_nonneg
    (P : ABCPoint) (q : PrimeSupportToken (P.a * P.b)) :
    0 ≤ primeSupportTokenWeight q := by
  unfold primeSupportTokenWeight
  exact Real.log_nonneg (by
    exact_mod_cast (Nat.prime_of_mem_primeFactors q.2).one_le)

/-- The endpoint packet space is always inhabited. -/
def emptyEndpointPrimePacketAssignment (P : ABCPoint) :
    EndpointPrimePacketAssignment P :=
  PrimePacketAssignment.empty

theorem endpointPrimePacketAssignment_nonempty (P : ABCPoint) :
    Nonempty (EndpointPrimePacketAssignment P) :=
  ⟨emptyEndpointPrimePacketAssignment P⟩

/-- Aggregate source mass is exactly the logarithm of the endpoint powerful
core. -/
theorem endpointPacket_sourceMass_eq_log_core
    (P : ABCPoint) (A : EndpointPrimePacketAssignment P) :
    A.sourceMass (endpointPowerPrimeWeight P) =
      Real.log (endpointCore P : ℝ) := by
  unfold endpointCore
  rw [← primeExponentExcessDegree_eq_log_powerfulPart P.c_pos.ne']
  unfold PrimePacketAssignment.sourceMass endpointPowerPrimeWeight
  unfold primeExponentExcessDegree exponentExcessDegree
  rw [Finset.univ_eq_attach P.c.primeFactors]
  exact Finset.sum_attach P.c.primeFactors
    (fun p => ((P.c.factorization p - 1 : ℕ) : ℝ) * Real.log (p : ℝ))

/-- Sink mass is exactly the external radical logarithm. -/
theorem endpointPacket_sinkMass_eq_log_externalRadical
    (P : ABCPoint) (A : EndpointPrimePacketAssignment P) :
    A.sinkMass (fun q => primeSupportTokenWeight q) =
      Real.log (externalRadical P : ℝ) := by
  unfold PrimePacketAssignment.sinkMass externalRadical
  exact sum_primeSupportTokenWeight_eq_log_radical (P.a * P.b)

/-- Packet residual bounds the exact signed endpoint defect. -/
theorem signedEndpointCoreDefect_le_packetResidual
    (P : ABCPoint) (A : EndpointPrimePacketAssignment P) :
    signedEndpointCoreDefect P ≤
      A.totalResidual (endpointPowerPrimeWeight P)
        (fun q => primeSupportTokenWeight q) := by
  have h := A.sourceMass_sub_sinkMass_le_totalResidual
    (endpointPowerPrimeWeight P) (fun q => primeSupportTokenWeight q)
    (endpointExternalPrimeWeight_nonneg P)
  rw [endpointPacket_sourceMass_eq_log_core P A,
    endpointPacket_sinkMass_eq_log_externalRadical P A] at h
  simpa [signedEndpointCoreDefect] using h

/-- Pointwise height bridge supplied by a packet assignment. -/
theorem height_le_conductor_add_packetResidual
    (P : ABCPoint) (A : EndpointPrimePacketAssignment P) :
    P.height ≤ P.conductor +
      A.totalResidual (endpointPowerPrimeWeight P)
        (fun q => primeSupportTokenWeight q) := by
  have h := signedEndpointCoreDefect_le_packetResidual P A
  rw [← height_sub_conductor_eq_signedEndpointCoreDefect P] at h
  linarith

/-- Packet-boundary gate, retained as a named proposition for its conditional
reduction and subsequent refutation, never as an axiom. -/
def UniformEndpointPrimePacketBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ C : ℝ, ∀ P : ABCPoint,
      ∃ A : EndpointPrimePacketAssignment P,
        A.totalResidual (endpointPowerPrimeWeight P)
            (fun q => primeSupportTokenWeight q) ≤
          epsilon * P.conductor + C

/-- The uniform packet-boundary gate implies the standard logarithmic abc
conjecture. -/
theorem abc_of_uniformEndpointPrimePacketBound
    (hgate : UniformEndpointPrimePacketBound) : ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨C, hC⟩ := hgate epsilon hepsilon
  refine ⟨C, ?_⟩
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
  obtain ⟨A, hA⟩ := hC P
  have hheight := height_le_conductor_add_packetResidual P A
  have hpoint : P.height ≤ (1 + epsilon) * P.conductor + C := by
    calc
      P.height ≤ P.conductor +
          A.totalResidual (endpointPowerPrimeWeight P)
            (fun q => primeSupportTokenWeight q) := hheight
      _ ≤ P.conductor + (epsilon * P.conductor + C) := by
        simpa [add_comm] using add_le_add_left hA P.conductor
      _ = (1 + epsilon) * P.conductor + C := by ring
  simpa [P, ABCPoint.height, ABCPoint.conductor, P.max_eq_c] using hpoint

/-! ## Exact pointwise noncollapse example -/

/-- Two unit sources and one indivisible sink of weight two. -/
def twoSourceOneSinkPacket (ownerIndex : Fin 2) :
    PrimePacketAssignment (Fin 2) Unit where
  owner := fun _ => some ownerIndex

/-- Every assignment in the two-source/one-sink example leaves residual at
least one. -/
theorem one_le_twoSourceOneSink_totalResidual
    (A : PrimePacketAssignment (Fin 2) Unit) :
    (1 : ℝ) ≤ A.totalResidual (fun _ => 1) (fun _ => 2) := by
  classical
  cases h : A.owner () with
  | none => simp [PrimePacketAssignment.totalResidual,
      PrimePacketAssignment.packetResidual,
      PrimePacketAssignment.packetMass, h]
  | some i =>
      fin_cases i <;>
        simp [PrimePacketAssignment.totalResidual,
          PrimePacketAssignment.packetResidual,
          PrimePacketAssignment.packetMass, h]

/-- Giving the sink to the first source attains residual one. -/
theorem twoSourceOneSinkPacket_totalResidual :
    (twoSourceOneSinkPacket 0).totalResidual
        (fun _ => (1 : ℝ)) (fun _ => (2 : ℝ)) = 1 := by
  norm_num [twoSourceOneSinkPacket, PrimePacketAssignment.totalResidual,
    PrimePacketAssignment.packetResidual, PrimePacketAssignment.packetMass]

/-- The same example has zero scalar source-minus-sink positive part. -/
theorem twoSourceOneSink_scalarDefect_eq_zero :
    max (((∑ _i : Fin 2, (1 : ℝ)) - ∑ _j : Unit, (2 : ℝ))) 0 = 0 := by
  norm_num

/-! ## Prime-square source packet -/

/-- The canonical aggregate source token for `p^2`. -/
def primeSquarePacketToken (p : ℕ) (hp : p.Prime) :
    PrimeSupportToken (p ^ 2) :=
  ⟨p, by
    rw [Nat.primeFactors_prime_pow (by norm_num) hp]
    simp⟩

/-- Any aggregate endpoint source token for `p^2` is the canonical one. -/
theorem primeSquarePacketToken_unique
    (p : ℕ) (hp : p.Prime)
    (s : PrimeSupportToken (p ^ 2)) : s.1 = p := by
  have hpf : (p ^ 2).primeFactors = {p} :=
    Nat.primeFactors_prime_pow (by norm_num) hp
  have hs : s.1 ∈ ({p} : Finset ℕ) := by
    rw [← hpf]
    exact s.2
  simpa using hs

/-- The unique aggregate source at `p^2` has weight `log p`. -/
theorem primeSquarePacketWeight
    (p : ℕ) (hp : p.Prime) (s : PrimeSupportToken (p ^ 2)) :
    ((p ^ 2).factorization s.1 - 1 : ℕ) * Real.log (s.1 : ℝ) =
      Real.log (p : ℝ) := by
  have hs := primeSquarePacketToken_unique p hp s
  rw [hs, Nat.factorization_pow_self hp]
  norm_num

/-- For a prime-square endpoint, putting all sinks into its unique aggregate
source packet leaves exactly the scalar aggregate deficit.  In particular,
there is no individual edge-order or edge-drop term. -/
theorem primeSquare_allSinks_totalResidual
    {β : Type*} [Fintype β]
    (p : ℕ) (hp : p.Prime) (sinkWeight : β → ℝ) :
    (PrimePacketAssignment.allSinksTo (primeSquarePacketToken p hp) :
        PrimePacketAssignment (PrimeSupportToken (p ^ 2)) β).totalResidual
        (fun s =>
          ((p ^ 2).factorization s.1 - 1 : ℕ) * Real.log (s.1 : ℝ))
        sinkWeight =
      max (Real.log (p : ℝ) - ∑ j, sinkWeight j) 0 := by
  rw [PrimePacketAssignment.allSinksTo_totalResidual_of_unique
    (i₀ := primeSquarePacketToken p hp)
    (hunique := fun s => Subtype.ext (primeSquarePacketToken_unique p hp s))]
  rw [primeSquarePacketWeight p hp]

end ABCPrimePacketBoundaryTransportSuccessor20260903
end
end IUTThreeClosures
