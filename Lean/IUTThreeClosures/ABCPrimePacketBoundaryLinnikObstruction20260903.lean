/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCPrimePacketBoundaryTransportSuccessor20260903
import Mathlib.Tactic

/-!
# Linnik obstruction to exclusive endpoint prime packets

The ordinary proof is in
`research/ABC_PRIME_PACKET_BOUNDARY_THEORETICAL_AUDIT_2026_09_03.md`.

This file formalizes the finite packet combinatorics, the actual abc point
`(1, ell, ell + 1)`, the endpoint tokens forced by a square divisor, and the
elementary radical bounds used in that proof.  Mathlib does not currently
contain Linnik's least-prime theorem.  Accordingly the analytic input is not
introduced as an axiom: `LinnikPrimeNeighborEscape` is a visible arithmetic
proposition, and the final refutation is conditional on a proof of precisely
that proposition.  The cited ordinary proof derives it from the published
Linnik theorem.
-/

namespace IUTThreeClosures

open scoped BigOperators
open UniqueFactorizationMonoid

noncomputable section

namespace ABCPrimePacketBoundaryLinnikObstruction20260903

open ABCPrimePacketBoundaryTransportSuccessor20260903
open ABCPrimePacketBoundaryTransportSuccessor20260903.PrimePacketAssignment
open SignedEndpointPrimeTokenTransport

/-! ## Exact finite packet identities -/

variable {alpha beta iota : Type*}

namespace PrimePacketAssignment

variable [Fintype beta] [DecidableEq alpha]

/-- Clipped source mass actually rewarded by an assignment. -/
def clippedReward
    [Fintype alpha]
    (A : PrimePacketAssignment alpha beta)
    (sourceWeight : alpha -> Real) (sinkWeight : beta -> Real) : Real :=
  ∑ i, min (sourceWeight i) (A.packetMass sinkWeight i)

/-- The positive residual at one source is source mass minus clipped reward. -/
theorem packetResidual_eq_source_sub_min
    (A : PrimePacketAssignment alpha beta)
    (sourceWeight : alpha -> Real) (sinkWeight : beta -> Real) (i : alpha) :
    A.packetResidual sourceWeight sinkWeight i =
      sourceWeight i - min (sourceWeight i) (A.packetMass sinkWeight i) := by
  unfold packetResidual
  by_cases h : sourceWeight i <= A.packetMass sinkWeight i
  · rw [max_eq_right (sub_nonpos.mpr h), min_eq_left h]
    ring
  · have h' : A.packetMass sinkWeight i <= sourceWeight i := le_of_not_ge h
    rw [max_eq_left (sub_nonneg.mpr h'), min_eq_right h']

/-- Exact clipped-reward identity for the total packet residual. -/
theorem totalResidual_eq_sourceMass_sub_clippedReward
    [Fintype alpha]
    (A : PrimePacketAssignment alpha beta)
    (sourceWeight : alpha -> Real) (sinkWeight : beta -> Real) :
    A.totalResidual sourceWeight sinkWeight =
      A.sourceMass sourceWeight - clippedReward A sourceWeight sinkWeight := by
  unfold totalResidual sourceMass clippedReward
  simp_rw [packetResidual_eq_source_sub_min A sourceWeight sinkWeight]
  rw [Finset.sum_sub_distrib]

/-- With a unique sink, its packet mass is either its full weight or zero. -/
theorem packetMass_eq_of_unique_sink
    (A : PrimePacketAssignment alpha beta) (sinkWeight : beta -> Real)
    (j0 : beta) (hunique : forall j : beta, j = j0) (i : alpha) :
    A.packetMass sinkWeight i =
      if A.owner j0 = some i then sinkWeight j0 else 0 := by
  classical
  have huniv : (Finset.univ : Finset beta) = {j0} := by
    ext j
    simp [hunique j]
  unfold packetMass
  rw [huniv]
  simp

/-- A unique indivisible sink can erase at most one member of any injectively
indexed collection of source lower bounds. -/
theorem sum_sub_cap_le_totalResidual_of_unique_sink
    [Fintype alpha] [Fintype iota]
    (A : PrimePacketAssignment alpha beta)
    (sourceWeight : alpha -> Real) (sinkWeight : beta -> Real)
    (j0 : beta) (hunique : forall j : beta, j = j0)
    (f : iota ↪ alpha) (lower : iota -> Real) (cap : Real)
    (hlower : forall i, lower i <= sourceWeight (f i))
    (hcap : forall i, lower i <= cap) (hcap_nonneg : 0 <= cap) :
    (∑ i, lower i) - cap <= A.totalResidual sourceWeight sinkWeight := by
  classical
  have hrestricted (s : Finset iota) :
      (∑ i ∈ s, A.packetResidual sourceWeight sinkWeight (f i)) <=
        A.totalResidual sourceWeight sinkWeight := by
    calc
      (∑ i ∈ s, A.packetResidual sourceWeight sinkWeight (f i)) =
          ∑ a ∈ s.map f, A.packetResidual sourceWeight sinkWeight a := by
            rw [Finset.sum_map]
      _ <= ∑ a : alpha, A.packetResidual sourceWeight sinkWeight a := by
        apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ _)
        intro a _ _
        exact A.packetResidual_nonneg sourceWeight sinkWeight a
      _ = A.totalResidual sourceWeight sinkWeight := rfl
  cases howner : A.owner j0 with
  | none =>
      have hpoint (i : iota) :
          lower i <= A.packetResidual sourceWeight sinkWeight (f i) := by
        rw [packetResidual, packetMass_eq_of_unique_sink A sinkWeight j0 hunique,
          howner]
        simp only [reduceCtorEq, ↓reduceIte, sub_zero]
        exact (hlower i).trans (le_max_left _ _)
      have hsum : (∑ i, lower i) <=
          ∑ i, A.packetResidual sourceWeight sinkWeight (f i) :=
        Finset.sum_le_sum fun i _ => hpoint i
      exact (sub_le_self _ hcap_nonneg).trans
        (hsum.trans (hrestricted Finset.univ))
  | some a0 =>
      by_cases hhit : exists i : iota, f i = a0
      · obtain ⟨i0, hi0⟩ := hhit
        have hpoint {i : iota} (hi : i ≠ i0) :
            lower i <= A.packetResidual sourceWeight sinkWeight (f i) := by
          have hfi : f i ≠ a0 := by
            intro h
            exact hi (f.injective (h.trans hi0.symm))
          rw [packetResidual, packetMass_eq_of_unique_sink A sinkWeight j0 hunique,
            howner]
          simp only [Option.some.injEq]
          rw [if_neg (Ne.symm hfi)]
          simp only [sub_zero]
          exact (hlower i).trans (le_max_left _ _)
        have hsumErase : (∑ i ∈ (Finset.univ.erase i0), lower i) <=
            ∑ i ∈ (Finset.univ.erase i0),
              A.packetResidual sourceWeight sinkWeight (f i) := by
          apply Finset.sum_le_sum
          intro i hi
          exact hpoint (Finset.ne_of_mem_erase hi)
        have hremove : (∑ i, lower i) - cap <=
            ∑ i ∈ (Finset.univ.erase i0), lower i := by
          have herase := Finset.add_sum_erase
            (Finset.univ : Finset iota) lower (Finset.mem_univ i0)
          linarith [hcap i0]
        exact hremove.trans
          (hsumErase.trans (hrestricted (Finset.univ.erase i0)))
      · have hpoint (i : iota) :
            lower i <= A.packetResidual sourceWeight sinkWeight (f i) := by
          have hfi : f i ≠ a0 := fun h => hhit ⟨i, h⟩
          rw [packetResidual, packetMass_eq_of_unique_sink A sinkWeight j0 hunique,
            howner]
          simp only [Option.some.injEq]
          rw [if_neg (Ne.symm hfi)]
          simp only [sub_zero]
          exact (hlower i).trans (le_max_left _ _)
        have hsum : (∑ i, lower i) <=
            ∑ i, A.packetResidual sourceWeight sinkWeight (f i) :=
          Finset.sum_le_sum fun i _ => hpoint i
        exact (sub_le_self _ hcap_nonneg).trans
          (hsum.trans (hrestricted Finset.univ))

end PrimePacketAssignment

/-! ## The actual prime-neighbour abc point -/

/-- The prime-neighbour abc point `(1, ell, ell + 1)`. -/
def primeNeighborPoint (ell : Nat) (hell : ell.Prime) : ABCPoint where
  a := 1
  b := ell
  c := ell + 1
  a_pos := by norm_num
  b_pos := hell.pos
  c_pos := by omega
  sum_eq := by omega
  pairwise_coprime := by
    refine ⟨by simp, ?_, by simp⟩
    exact (Nat.coprime_self_add_right (m := ell) (n := 1)).2 (by simp)

@[simp] theorem primeNeighborPoint_a (ell : Nat) (hell : ell.Prime) :
    (primeNeighborPoint ell hell).a = 1 := rfl

@[simp] theorem primeNeighborPoint_b (ell : Nat) (hell : ell.Prime) :
    (primeNeighborPoint ell hell).b = ell := rfl

@[simp] theorem primeNeighborPoint_c (ell : Nat) (hell : ell.Prime) :
    (primeNeighborPoint ell hell).c = ell + 1 := rfl

/-- Positivity of all three coordinates is explicit at the constructed
prime-neighbour point. -/
theorem primeNeighborPoint_positive (ell : Nat) (hell : ell.Prime) :
    0 < (primeNeighborPoint ell hell).a ∧
      0 < (primeNeighborPoint ell hell).b ∧
      0 < (primeNeighborPoint ell hell).c :=
  ⟨(primeNeighborPoint ell hell).a_pos,
    (primeNeighborPoint ell hell).b_pos,
    (primeNeighborPoint ell hell).c_pos⟩

/-- The constructed point has the required pairwise coprimality. -/
theorem primeNeighborPoint_pairwise_coprime (ell : Nat) (hell : ell.Prime) :
    PairwiseCoprimeABC (primeNeighborPoint ell hell).a
      (primeNeighborPoint ell hell).b (primeNeighborPoint ell hell).c :=
  (primeNeighborPoint ell hell).pairwise_coprime

/-- For every odd prime in the construction, the endpoint `ell + 1` is
even. -/
theorem primeNeighborPoint_endpoint_even
    (ell : Nat) (hell : ell.Prime) (hell2 : ell ≠ 2) :
    Even (primeNeighborPoint ell hell).c := by
  exact (hell.odd_of_ne_two hell2).add_one

/-- The unique external prime token is `ell`. -/
def primeNeighborSinkToken (ell : Nat) (hell : ell.Prime) :
    PrimeSupportToken
      ((primeNeighborPoint ell hell).a * (primeNeighborPoint ell hell).b) :=
  ⟨ell, by
    apply Nat.mem_primeFactors.mpr
    simpa using And.intro hell (And.intro (dvd_refl ell) hell.ne_zero)⟩

/-- Every external token of the prime-neighbour point is the canonical token. -/
theorem primeNeighborSinkToken_unique
    (ell : Nat) (hell : ell.Prime)
    (q : PrimeSupportToken
      ((primeNeighborPoint ell hell).a * (primeNeighborPoint ell hell).b)) :
    q = primeNeighborSinkToken ell hell := by
  apply Subtype.ext
  have hqPrime : q.1.Prime := Nat.prime_of_mem_primeFactors q.2
  have hqDvd : q.1 ∣ ell := by
    simpa using Nat.dvd_of_mem_primeFactors q.2
  exact (Nat.prime_dvd_prime_iff_eq hqPrime hell).mp hqDvd

/-! ## Square-product forcing of actual endpoint sources -/

/-- Product of a finite set of primes. -/
def finitePrimeProduct (S : Finset Nat) : Nat := ∏ p ∈ S, p

/-- A prime in `S` contributes its square to the square of the product. -/
theorem primeSquare_dvd_finitePrimeProduct_sq
    {S : Finset Nat} {p : Nat} (hpS : p ∈ S) :
    p ^ 2 ∣ finitePrimeProduct S ^ 2 := by
  unfold finitePrimeProduct
  exact pow_dvd_pow_of_dvd (Finset.dvd_prod_of_mem id hpS) 2

/-- A square-product divisor forces every selected prime square at the
endpoint. -/
theorem primeSquare_dvd_endpoint_of_product_sq_dvd
    {ell : Nat} {S : Finset Nat} {p : Nat} (hpS : p ∈ S)
    (hdiv : finitePrimeProduct S ^ 2 ∣ ell + 1) :
    p ^ 2 ∣ ell + 1 :=
  (primeSquare_dvd_finitePrimeProduct_sq hpS).trans hdiv

/-- The actual endpoint prime token forced by a selected prime square. -/
def forcedEndpointToken
    (ell : Nat) (hell : ell.Prime) (S : Finset Nat)
    (hSprime : ∀ p ∈ S, p.Prime)
    (hdiv : finitePrimeProduct S ^ 2 ∣ ell + 1)
    (p : ↑S) : EndpointPowerPrimeToken (primeNeighborPoint ell hell) :=
  ⟨p.1, by
    have hp2 : p.1 ^ 2 ∣ ell + 1 :=
      primeSquare_dvd_endpoint_of_product_sq_dvd p.2 hdiv
    have hp : p.1.Prime := hSprime p.1 p.2
    exact Nat.mem_primeFactors.mpr
      ⟨hp, (dvd_pow_self p.1 (by norm_num : 2 ≠ 0)).trans hp2,
        Nat.add_one_ne_zero ell⟩⟩

/-- Distinct selected primes give distinct actual endpoint source tokens. -/
def forcedEndpointTokenEmbedding
    (ell : Nat) (hell : ell.Prime) (S : Finset Nat)
    (hSprime : ∀ p ∈ S, p.Prime)
    (hdiv : finitePrimeProduct S ^ 2 ∣ ell + 1) :
    ↑S ↪ EndpointPowerPrimeToken (primeNeighborPoint ell hell) where
  toFun := forcedEndpointToken ell hell S hSprime hdiv
  inj' := by
    intro p q hpq
    apply Subtype.ext
    exact congrArg
      (fun t : EndpointPowerPrimeToken (primeNeighborPoint ell hell) => t.1) hpq

/-- Each selected square divisor supplies at least one logarithmic excess
layer at its actual endpoint source token. -/
theorem log_prime_le_forcedEndpointToken_weight
    (ell : Nat) (hell : ell.Prime) (S : Finset Nat)
    (hSprime : ∀ p ∈ S, p.Prime)
    (hdiv : finitePrimeProduct S ^ 2 ∣ ell + 1)
    (p : ↑S) :
    Real.log (p.1 : Real) <=
      endpointPowerPrimeWeight (primeNeighborPoint ell hell)
        (forcedEndpointToken ell hell S hSprime hdiv p) := by
  have hp : p.1.Prime := hSprime p.1 p.2
  have hp2 : p.1 ^ 2 ∣ ell + 1 :=
    primeSquare_dvd_endpoint_of_product_sq_dvd p.2 hdiv
  have hfac : 2 <= (ell + 1).factorization p.1 :=
    (hp.pow_dvd_iff_le_factorization (by omega : ell + 1 ≠ 0)).mp hp2
  have hcoeff : (1 : Nat) <= (ell + 1).factorization p.1 - 1 := by omega
  have hlog : 0 <= Real.log (p.1 : Real) :=
    Real.log_nonneg (by exact_mod_cast hp.one_le)
  unfold endpointPowerPrimeWeight
  change Real.log (p.1 : Real) <=
    (((ell + 1).factorization p.1 - 1 : Nat) : Real) *
      Real.log (p.1 : Real)
  have hcoeffReal : (1 : Real) <=
      (((ell + 1).factorization p.1 - 1 : Nat) : Real) := by
    exact_mod_cast hcoeff
  nlinarith

/-- The actual endpoint packet residual is bounded below by the sum of the
forced logarithmic sources minus any common upper bound for one owner. -/
theorem forcedPrimeLogSum_sub_cap_le_packetResidual
    (ell : Nat) (hell : ell.Prime) (S : Finset Nat)
    (hSprime : ∀ p ∈ S, p.Prime)
    (hdiv : finitePrimeProduct S ^ 2 ∣ ell + 1)
    (cap : Real) (hcap_nonneg : 0 <= cap)
    (hcap : ∀ p ∈ S, Real.log (p : Real) <= cap)
    (A : EndpointPrimePacketAssignment (primeNeighborPoint ell hell)) :
    (∑ p ∈ S, Real.log (p : Real)) - cap <=
      A.totalResidual (endpointPowerPrimeWeight (primeNeighborPoint ell hell))
        (fun q => primeSupportTokenWeight q) := by
  let f := forcedEndpointTokenEmbedding ell hell S hSprime hdiv
  let j0 := primeNeighborSinkToken ell hell
  have h := PrimePacketAssignment.sum_sub_cap_le_totalResidual_of_unique_sink A
    (endpointPowerPrimeWeight (primeNeighborPoint ell hell))
    (fun q => primeSupportTokenWeight q) j0
    (primeNeighborSinkToken_unique ell hell) f
    (fun p : ↑S => Real.log (p.1 : Real)) cap
    (log_prime_le_forcedEndpointToken_weight ell hell S hSprime hdiv)
    (fun p => hcap p.1 p.2) hcap_nonneg
  have hsum : (∑ p : ↑S, Real.log (p.1 : Real)) =
      ∑ p ∈ S, Real.log (p : Real) := by
    rw [Finset.univ_eq_attach S]
    exact Finset.sum_attach S (fun p => Real.log (p : Real))
  rw [← hsum]
  exact h

/-! ## Elementary conductor and scalar-defect estimates -/

/-- The radical of the prime-neighbour point is at most the ambient product
`ell * (ell + 1)`. -/
theorem primeNeighbor_totalRadical_le_product
    (ell : Nat) (hell : ell.Prime) :
    totalRadical (primeNeighborPoint ell hell) <= ell * (ell + 1) := by
  unfold totalRadical
  simpa [primeNeighborPoint] using
    (show abcRadical (1 * ell * (ell + 1)) <= 1 * ell * (ell + 1) by
      rw [abcRadical_eq_natRadical]
      exact Nat.radical_le_self_iff.mpr
        (mul_ne_zero (mul_ne_zero one_ne_zero hell.ne_zero)
          (Nat.add_one_ne_zero ell)))

/-- The logarithmic conductor is at most `2 log(ell + 1)`. -/
theorem primeNeighbor_conductor_le_two_log_succ
    (ell : Nat) (hell : ell.Prime) :
    (primeNeighborPoint ell hell).conductor <=
      2 * Real.log ((ell + 1 : Nat) : Real) := by
  let P := primeNeighborPoint ell hell
  have hrad := primeNeighbor_totalRadical_le_product ell hell
  have hprod : ell * (ell + 1) <= (ell + 1) ^ 2 := by nlinarith
  have hreal : (totalRadical P : Real) <= ((ell + 1 : Nat) : Real) ^ 2 := by
    exact_mod_cast hrad.trans hprod
  have hlog := Real.log_le_log (by exact_mod_cast totalRadical_pos P) hreal
  change Real.log (totalRadical P : Real) <=
    2 * Real.log ((ell + 1 : Nat) : Real)
  simpa [Real.log_pow] using hlog

/-- If `ell` is odd, the endpoint radical supplies a factor two and the
prime-neighbour point already satisfies the slope-one logarithmic bound. -/
theorem primeNeighbor_height_le_conductor_of_ne_two
    (ell : Nat) (hell : ell.Prime) (hell2 : ell ≠ 2) :
    (primeNeighborPoint ell hell).height <=
      (primeNeighborPoint ell hell).conductor := by
  let P := primeNeighborPoint ell hell
  have heven : 2 ∣ ell + 1 := (hell.odd_of_ne_two hell2).add_one.two_dvd
  have htwoMem : 2 ∈ (ell + 1).primeFactors :=
    Nat.mem_primeFactors.mpr
      ⟨Nat.prime_two, heven, by omega⟩
  have htwoRad : 2 ∣ abcRadical (ell + 1) := by
    unfold abcRadical
    exact Finset.dvd_prod_of_mem id htwoMem
  have hradTwo : 2 <= abcRadical (ell + 1) :=
    Nat.le_of_dvd (abcRadical_pos (ell + 1)) htwoRad
  have hradEll : abcRadical ell = ell := by
    rw [abcRadical_eq_natRadical,
      UniqueFactorizationMonoid.radical_of_prime hell.prime]
    simp
  have hradLower : ell + 1 <= totalRadical P := by
    unfold totalRadical
    rw [P.abcRadical_abcProduct]
    change ell + 1 <= abcRadical 1 * abcRadical ell * abcRadical (ell + 1)
    rw [hradEll]
    have hellOne : 1 <= ell := hell.one_le
    simp only [abcRadical, Nat.primeFactors_one, Finset.prod_empty, one_mul]
    calc
      ell + 1 <= ell * 2 := by omega
      _ <= ell * (ell + 1).primeFactors.prod id :=
        Nat.mul_le_mul_left ell hradTwo
  rw [P.height_eq_log_c]
  change Real.log ((ell + 1 : Nat) : Real) <=
    Real.log (totalRadical P : Real)
  exact Real.log_le_log (by positivity) (by exact_mod_cast hradLower)

/-- Equivalently, the divisible scalar positive-part defect vanishes. -/
theorem primeNeighbor_positive_height_defect_eq_zero
    (ell : Nat) (hell : ell.Prime) (hell2 : ell ≠ 2) :
    max ((primeNeighborPoint ell hell).height -
      (primeNeighborPoint ell hell).conductor) 0 = 0 := by
  rw [max_eq_right]
  linarith [primeNeighbor_height_le_conductor_of_ne_two ell hell hell2]

/-! ## The transparent arithmetic escape and conditional formal refutation -/

/-- Arithmetic escape supplied in the ordinary proof by Linnik's theorem.

This proposition mentions only primes, a square divisibility condition, and
explicit logarithmic growth.  It is neither an axiom nor a reformulation of
the packet gate's negation. -/
def LinnikPrimeNeighborEscape : Prop :=
  ∃ epsilon : Real, 0 < epsilon ∧ ∀ C : Real,
    ∃ ell : Nat, ∃ S : Finset Nat, ∃ cap : Real,
      ell.Prime ∧ ell ≠ 2 ∧
      (∀ p ∈ S, p.Prime) ∧
      finitePrimeProduct S ^ 2 ∣ ell + 1 ∧
      0 <= cap ∧
      (∀ p ∈ S, Real.log (p : Real) <= cap) ∧
      epsilon * (2 * Real.log ((ell + 1 : Nat) : Real)) + C <
        (∑ p ∈ S, Real.log (p : Real)) - cap

/-- The explicit arithmetic escape refutes the exclusive-ownership endpoint
packet gate.  The only unformalized ingredient in the unconditional paper
proof is the derivation of `LinnikPrimeNeighborEscape` from Linnik's theorem. -/
theorem not_uniformEndpointPrimePacketBound_of_linnikEscape
    (hescape : LinnikPrimeNeighborEscape) :
    ¬ UniformEndpointPrimePacketBound := by
  rintro hgate
  obtain ⟨epsilon, hepsilon, hescapeC⟩ := hescape
  obtain ⟨C, hC⟩ := hgate epsilon hepsilon
  obtain ⟨ell, S, cap, hell, hell2, hSprime, hdiv, hcapNonneg, hcap, hlarge⟩ :=
    hescapeC C
  let P := primeNeighborPoint ell hell
  obtain ⟨A, hA⟩ := hC P
  have hlower := forcedPrimeLogSum_sub_cap_le_packetResidual
    ell hell S hSprime hdiv cap hcapNonneg hcap A
  have hcond := primeNeighbor_conductor_le_two_log_succ ell hell
  have hscaled : epsilon * P.conductor <=
      epsilon * (2 * Real.log ((ell + 1 : Nat) : Real)) :=
    mul_le_mul_of_nonneg_left hcond hepsilon.le
  have hupper :
      A.totalResidual (endpointPowerPrimeWeight P)
          (fun q => primeSupportTokenWeight q) <=
        epsilon * (2 * Real.log ((ell + 1 : Nat) : Real)) + C :=
    hA.trans (by linarith)
  exact (not_lt_of_ge (hlower.trans hupper)) hlarge

end ABCPrimePacketBoundaryLinnikObstruction20260903
end
end IUTThreeClosures
