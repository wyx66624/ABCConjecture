/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArakelovCongruenceDegreeBarrier
import IUTThreeClosures.NatExponentProfileBridge
import Mathlib.Tactic

/-!
# Signed endpoint core defect and monotone prime-token transport

For a positive primitive `abc` point, the powerful core of the sum endpoint
and the radical of the two other arms satisfy an exact multiplicative and
logarithmic balance.  This file realizes the two terms as actual finite prime
token types and defines a fractional monotone flow from excess prime layers of
`c` to distinct prime-support sinks of `a*b`.

The exact flow accounting bounds the signed endpoint defect by unmatched
source mass.  A threshold theorem supplies the weighted Hall obstruction for
every natural prime threshold.  Consequently, a uniform `epsilon`-small
unmatched-mass hypothesis implies the repository's standard logarithmic
`ABCConjecture`.

The file does not assume that such uniformly small flows exist.  It also
certifies complete-premise counterexamples to full integral dominance
matching and proves an infinite primitive unit-arm family that rules out any
fixed-constant, zero-epsilon endpoint-core domination.
-/

namespace IUTThreeClosures

open scoped BigOperators
open UniqueFactorizationMonoid

noncomputable section

namespace SignedEndpointPrimeTokenTransport

/-! ## Generic finite fractional monotone flows -/

variable {α β : Type*} [Fintype α] [Fintype β]

/-- A nonnegative capacitated flow.  Positive mass may move only from a
source whose natural key is at most the sink key. -/
structure MonotoneWeightedFlow
    (sourceWeight : α → ℝ) (sinkWeight : β → ℝ)
    (sourceKey : α → ℕ) (sinkKey : β → ℕ) where
  flow : α → β → ℝ
  flow_nonneg : ∀ i j, 0 ≤ flow i j
  source_capacity : ∀ i, (∑ j, flow i j) ≤ sourceWeight i
  sink_capacity : ∀ j, (∑ i, flow i j) ≤ sinkWeight j
  monotone : ∀ i j, 0 < flow i j → sourceKey i ≤ sinkKey j

namespace MonotoneWeightedFlow

variable {sourceWeight : α → ℝ} {sinkWeight : β → ℝ}
variable {sourceKey : α → ℕ} {sinkKey : β → ℕ}

/-- Total source capacity. -/
def sourceMass
    (_F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) : ℝ :=
  ∑ i, sourceWeight i

/-- Total sink capacity. -/
def sinkMass
    (_F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) : ℝ :=
  ∑ j, sinkWeight j

/-- Total mass carried by the flow. -/
def carriedMass
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) : ℝ :=
  ∑ i, ∑ j, F.flow i j

/-- Source capacity left unmatched. -/
def unmatchedMass
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) : ℝ :=
  ∑ i, (sourceWeight i - ∑ j, F.flow i j)

/-- Sink capacity left unused. -/
def unusedCapacity
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) : ℝ :=
  ∑ j, (sinkWeight j - ∑ i, F.flow i j)

/-- Source capacity above a natural threshold. -/
def sourceTailMass
    (_F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey)
    (t : ℕ) : ℝ :=
  ∑ i ∈ Finset.univ.filter (fun i => t < sourceKey i), sourceWeight i

/-- Sink capacity above a natural threshold. -/
def sinkTailMass
    (_F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey)
    (t : ℕ) : ℝ :=
  ∑ j ∈ Finset.univ.filter (fun j => t < sinkKey j), sinkWeight j

/-- Carried mass emitted by sources above a threshold. -/
def sourceTailCarried
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey)
    (t : ℕ) : ℝ :=
  ∑ i ∈ Finset.univ.filter (fun i => t < sourceKey i), ∑ j, F.flow i j

/-- Unmatched mass restricted to sources above a threshold. -/
def sourceTailUnmatched
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey)
    (t : ℕ) : ℝ :=
  ∑ i ∈ Finset.univ.filter (fun i => t < sourceKey i),
    (sourceWeight i - ∑ j, F.flow i j)

theorem unmatchedMass_nonneg
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) :
    0 ≤ F.unmatchedMass := by
  classical
  unfold unmatchedMass
  exact Finset.sum_nonneg fun i _ => sub_nonneg.mpr (F.source_capacity i)

theorem unusedCapacity_nonneg
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) :
    0 ≤ F.unusedCapacity := by
  classical
  unfold unusedCapacity
  exact Finset.sum_nonneg fun j _ => sub_nonneg.mpr (F.sink_capacity j)

theorem unmatchedMass_eq_sourceMass_sub_carriedMass
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) :
    F.unmatchedMass = F.sourceMass - F.carriedMass := by
  classical
  unfold unmatchedMass sourceMass carriedMass
  rw [Finset.sum_sub_distrib]

theorem unusedCapacity_eq_sinkMass_sub_carriedMass
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) :
    F.unusedCapacity = F.sinkMass - F.carriedMass := by
  classical
  unfold unusedCapacity sinkMass carriedMass
  rw [Finset.sum_sub_distrib, Finset.sum_comm]

/-- Exact source-defect accounting: unmatched source mass equals the scalar
source-minus-sink defect plus unused sink capacity. -/
theorem unmatchedMass_eq_defect_add_unusedCapacity
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) :
    F.unmatchedMass =
      (F.sourceMass - F.sinkMass) + F.unusedCapacity := by
  rw [F.unmatchedMass_eq_sourceMass_sub_carriedMass,
    F.unusedCapacity_eq_sinkMass_sub_carriedMass]
  ring

theorem sourceMass_sub_sinkMass_le_unmatchedMass
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey) :
    F.sourceMass - F.sinkMass ≤ F.unmatchedMass := by
  rw [F.unmatchedMass_eq_defect_add_unusedCapacity]
  exact le_add_of_nonneg_right F.unusedCapacity_nonneg

theorem sourceTailUnmatched_le_unmatchedMass
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey)
    (t : ℕ) :
    F.sourceTailUnmatched t ≤ F.unmatchedMass := by
  classical
  unfold sourceTailUnmatched unmatchedMass
  apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.filter_subset _ _)
  intro i _ _
  exact sub_nonneg.mpr (F.source_capacity i)

theorem sourceTailUnmatched_eq_tailMass_sub_tailCarried
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey)
    (t : ℕ) :
    F.sourceTailUnmatched t = F.sourceTailMass t - F.sourceTailCarried t := by
  classical
  unfold sourceTailUnmatched sourceTailMass sourceTailCarried
  rw [Finset.sum_sub_distrib]

theorem sourceTailCarried_le_sinkTailMass
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey)
    (t : ℕ) :
    F.sourceTailCarried t ≤ F.sinkTailMass t := by
  classical
  let sTail : Finset α := Finset.univ.filter (fun i => t < sourceKey i)
  let tTail : Finset β := Finset.univ.filter (fun j => t < sinkKey j)
  calc
    F.sourceTailCarried t = ∑ i ∈ sTail, ∑ j, F.flow i j := by
      rfl
    _ = ∑ i ∈ sTail, ∑ j ∈ tTail, F.flow i j := by
      apply Finset.sum_congr rfl
      intro i hi
      symm
      apply Finset.sum_filter_of_ne
      intro j _ hne
      have hiTail : t < sourceKey i := (Finset.mem_filter.mp hi).2
      have hpos : 0 < F.flow i j :=
        lt_of_le_of_ne (F.flow_nonneg i j) (Ne.symm hne)
      exact lt_of_lt_of_le hiTail (F.monotone i j hpos)
    _ = ∑ j ∈ tTail, ∑ i ∈ sTail, F.flow i j := by
      rw [Finset.sum_comm]
    _ ≤ ∑ j ∈ tTail, ∑ i, F.flow i j := by
      apply Finset.sum_le_sum
      intro j _
      apply Finset.sum_le_sum_of_subset_of_nonneg (Finset.subset_univ sTail)
      intro i _ _
      exact F.flow_nonneg i j
    _ ≤ ∑ j ∈ tTail, sinkWeight j := by
      exact Finset.sum_le_sum fun j _ => F.sink_capacity j
    _ = F.sinkTailMass t := by
      rfl

/-- Weighted Hall threshold obstruction for every natural threshold. -/
theorem sourceTailMass_sub_sinkTailMass_le_unmatchedMass
    (F : MonotoneWeightedFlow sourceWeight sinkWeight sourceKey sinkKey)
    (t : ℕ) :
    F.sourceTailMass t - F.sinkTailMass t ≤ F.unmatchedMass := by
  have htail := F.sourceTailUnmatched_le_unmatchedMass t
  have hcarried := F.sourceTailCarried_le_sinkTailMass t
  rw [F.sourceTailUnmatched_eq_tailMass_sub_tailCarried] at htail
  linarith

end MonotoneWeightedFlow

/-! ## Actual endpoint prime tokens and exact core balance -/

/-- One distinct prime-support token of `n`. -/
abbrev PrimeSupportToken (n : ℕ) := ↥n.primeFactors

/-- One token for every exponent layer above the first copy of a prime. -/
abbrev PrimeExcessToken (n : ℕ) :=
  Σ p : PrimeSupportToken n, Fin (n.factorization p.1 - 1)

def primeSupportTokenPrime {n : ℕ} (q : PrimeSupportToken n) : ℕ := q.1

def primeExcessTokenPrime {n : ℕ} (s : PrimeExcessToken n) : ℕ := s.1.1

def primeSupportTokenWeight {n : ℕ} (q : PrimeSupportToken n) : ℝ :=
  Real.log (q.1 : ℝ)

def primeExcessTokenWeight {n : ℕ} (s : PrimeExcessToken n) : ℝ :=
  Real.log (s.1.1 : ℝ)

/-- Powerful core of the sum endpoint. -/
def endpointCore (P : ABCPoint) : ℕ := abcPowerfulPart P.c

/-- Radical support supplied by the two summand arms. -/
def externalRadical (P : ABCPoint) : ℕ := abcRadical (P.a * P.b)

/-- Full radical of the three arms. -/
def totalRadical (P : ABCPoint) : ℕ := abcRadical (P.a * P.b * P.c)

/-- Signed `c`-core mass after charging the radical of the two other arms. -/
def signedEndpointCoreDefect (P : ABCPoint) : ℝ :=
  Real.log (endpointCore P : ℝ) - Real.log (externalRadical P : ℝ)

theorem externalRadical_eq_radical_a_mul_radical_b (P : ABCPoint) :
    externalRadical P = abcRadical P.a * abcRadical P.b := by
  unfold externalRadical
  simp only [abcRadical_eq_natRadical]
  rw [radical_mul
    (Nat.coprime_iff_isRelPrime.mp P.pairwise_coprime.1)]

/-- Exact multiplicative endpoint-core balance. -/
theorem externalRadical_mul_c_eq_totalRadical_mul_endpointCore
    (P : ABCPoint) :
    externalRadical P * P.c = totalRadical P * endpointCore P := by
  rw [externalRadical_eq_radical_a_mul_radical_b P]
  unfold totalRadical endpointCore
  rw [P.abcRadical_abcProduct]
  have hc := abcRadical_mul_abcPowerfulPart P.c
  calc
    (abcRadical P.a * abcRadical P.b) * P.c =
        (abcRadical P.a * abcRadical P.b) *
          (abcRadical P.c * abcPowerfulPart P.c) := by rw [hc]
    _ = (abcRadical P.a * abcRadical P.b * abcRadical P.c) *
          abcPowerfulPart P.c := by ring

theorem endpointCore_pos (P : ABCPoint) : 0 < endpointCore P := by
  exact abcPowerfulPart_pos P.c_pos

theorem externalRadical_pos (P : ABCPoint) : 0 < externalRadical P := by
  exact abcRadical_pos (P.a * P.b)

theorem totalRadical_pos (P : ABCPoint) : 0 < totalRadical P := by
  exact abcRadical_pos (P.a * P.b * P.c)

/-- Exact logarithmic endpoint-core identity. -/
theorem log_c_sub_log_totalRadical_eq_signedEndpointCoreDefect
    (P : ABCPoint) :
    Real.log (P.c : ℝ) - Real.log (totalRadical P : ℝ) =
      signedEndpointCoreDefect P := by
  have hbalance :
      (externalRadical P : ℝ) * (P.c : ℝ) =
        (totalRadical P : ℝ) * (endpointCore P : ℝ) := by
    exact_mod_cast externalRadical_mul_c_eq_totalRadical_mul_endpointCore P
  have hext : (externalRadical P : ℝ) ≠ 0 := by
    exact_mod_cast (externalRadical_pos P).ne'
  have hc : (P.c : ℝ) ≠ 0 := by exact_mod_cast P.c_pos.ne'
  have htotal : (totalRadical P : ℝ) ≠ 0 := by
    exact_mod_cast (totalRadical_pos P).ne'
  have hcore : (endpointCore P : ℝ) ≠ 0 := by
    exact_mod_cast (endpointCore_pos P).ne'
  have hlog := congrArg Real.log hbalance
  rw [Real.log_mul hext hc, Real.log_mul htotal hcore] at hlog
  unfold signedEndpointCoreDefect
  linarith

theorem height_sub_conductor_eq_signedEndpointCoreDefect (P : ABCPoint) :
    P.height - P.conductor = signedEndpointCoreDefect P := by
  rw [P.height_eq_log_c]
  simpa [ABCPoint.conductor, totalRadical] using
    log_c_sub_log_totalRadical_eq_signedEndpointCoreDefect P

/-- Total weight of the actual excess-layer token type. -/
theorem sum_primeExcessTokenWeight_eq_log_powerfulPart
    (n : ℕ) (hn : n ≠ 0) :
    (∑ s : PrimeExcessToken n, primeExcessTokenWeight s) =
      Real.log (abcPowerfulPart n : ℝ) := by
  rw [Fintype.sum_sigma]
  simp only [primeExcessTokenWeight, Fin.sum_const, nsmul_eq_mul]
  rw [← primeExponentExcessDegree_eq_log_powerfulPart hn]
  unfold primeExponentExcessDegree exponentExcessDegree
  rw [Finset.univ_eq_attach n.primeFactors]
  exact Finset.sum_attach n.primeFactors
    (fun p => ((n.factorization p - 1 : ℕ) : ℝ) * Real.log (p : ℝ))

/-- Total weight of the actual distinct-prime support token type. -/
theorem sum_primeSupportTokenWeight_eq_log_radical (n : ℕ) :
    (∑ q : PrimeSupportToken n, primeSupportTokenWeight q) =
      Real.log (abcRadical n : ℝ) := by
  rw [abcRadical_eq_natRadical]
  rw [←
    NatExponentProfileBridge.exponentRadicalWeight_primeFactorization_eq_log_radical n]
  unfold exponentRadicalWeight
  rw [Finset.univ_eq_attach n.primeFactors]
  exact Finset.sum_attach n.primeFactors (fun p => Real.log (p : ℝ))

/-- Actual fractional monotone flow from the excess layers of `c` to the
distinct external primes of `a*b`. -/
abbrev EndpointPrimeFlow (P : ABCPoint) :=
  MonotoneWeightedFlow
    (fun s : PrimeExcessToken P.c => primeExcessTokenWeight s)
    (fun q : PrimeSupportToken (P.a * P.b) => primeSupportTokenWeight q)
    (fun s : PrimeExcessToken P.c => primeExcessTokenPrime s)
    (fun q : PrimeSupportToken (P.a * P.b) => primeSupportTokenPrime q)

theorem endpointPrimeFlow_sourceMass_eq_log_core
    (P : ABCPoint) (F : EndpointPrimeFlow P) :
    F.sourceMass = Real.log (endpointCore P : ℝ) := by
  unfold MonotoneWeightedFlow.sourceMass endpointCore
  exact sum_primeExcessTokenWeight_eq_log_powerfulPart P.c P.c_pos.ne'

theorem endpointPrimeFlow_sinkMass_eq_log_externalRadical
    (P : ABCPoint) (F : EndpointPrimeFlow P) :
    F.sinkMass = Real.log (externalRadical P : ℝ) := by
  unfold MonotoneWeightedFlow.sinkMass externalRadical
  exact sum_primeSupportTokenWeight_eq_log_radical (P.a * P.b)

/-- Any actual endpoint flow bounds the exact signed endpoint-core defect. -/
theorem signedEndpointCoreDefect_le_unmatchedMass
    (P : ABCPoint) (F : EndpointPrimeFlow P) :
    signedEndpointCoreDefect P ≤ F.unmatchedMass := by
  have h := F.sourceMass_sub_sinkMass_le_unmatchedMass
  rw [endpointPrimeFlow_sourceMass_eq_log_core P F,
    endpointPrimeFlow_sinkMass_eq_log_externalRadical P F] at h
  exact h

theorem height_le_conductor_add_unmatchedMass
    (P : ABCPoint) (F : EndpointPrimeFlow P) :
    P.height ≤ P.conductor + F.unmatchedMass := by
  have hdefect := signedEndpointCoreDefect_le_unmatchedMass P F
  rw [← height_sub_conductor_eq_signedEndpointCoreDefect P] at hdefect
  linarith

/-- Actual-prime weighted Hall obstruction inherited from the generic flow. -/
theorem endpointPrimeFlow_threshold_obstruction
    (P : ABCPoint) (F : EndpointPrimeFlow P) (t : ℕ) :
    F.sourceTailMass t - F.sinkTailMass t ≤ F.unmatchedMass :=
  F.sourceTailMass_sub_sinkTailMass_le_unmatchedMass t

/-! ## Exact implication to the standard abc statement -/

/-- The ordered uniform small-unmatched-mass flow gate.  A companion module
proves that this exact proposition is false. -/
def UniformEndpointPrimeFlowBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ C : ℝ, ∀ P : ABCPoint,
      ∃ F : EndpointPrimeFlow P,
        F.unmatchedMass ≤ epsilon * P.conductor + C

/-- A uniform endpoint-flow bound implies the standard logarithmic `abc`
conjecture with the same epsilon and additive constant. -/
theorem abc_of_uniformEndpointPrimeFlowBound
    (hflow : UniformEndpointPrimeFlowBound) : ABCConjecture := by
  intro epsilon hepsilon
  obtain ⟨C, hC⟩ := hflow epsilon hepsilon
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
  obtain ⟨F, hF⟩ := hC P
  have hheight := height_le_conductor_add_unmatchedMass P F
  have hpoint : P.height ≤ (1 + epsilon) * P.conductor + C := by
    calc
      P.height ≤ P.conductor + F.unmatchedMass := hheight
      _ ≤ P.conductor + (epsilon * P.conductor + C) :=
        by simpa [add_comm] using add_le_add_left hF P.conductor
      _ = (1 + epsilon) * P.conductor + C := by ring
  have ha_le : P.a ≤ P.c := Nat.le_of_lt P.a_lt_c
  have hb_le : P.b ≤ P.c := Nat.le_of_lt P.b_lt_c
  have hmax : max P.a (max P.b P.c) = P.c := by
    simp [max_eq_right hb_le, max_eq_right ha_le]
  simpa [P, ABCPoint.height, ABCPoint.conductor, hmax] using hpoint

/-! ## Complete-premise finite counterexamples to integral matching -/

/-- Stronger integral condition retired below: every excess layer is sent
injectively to a distinct external prime at least as large. -/
def FullIntegralDominanceMatching (P : ABCPoint) : Prop :=
  ∃ f : PrimeExcessToken P.c → PrimeSupportToken (P.a * P.b),
    Function.Injective f ∧
      ∀ s, primeExcessTokenPrime s ≤ primeSupportTokenPrime (f s)

def threeThirteenSixteenDatum : ABCPoint where
  a := 3
  b := 13
  c := 16
  a_pos := by norm_num
  b_pos := by norm_num
  c_pos := by norm_num
  sum_eq := by norm_num
  pairwise_coprime := by norm_num [PairwiseCoprimeABC]

theorem factorization_sixteen_two : (16 : ℕ).factorization 2 = 4 := by
  have hp : Nat.Prime 2 := by norm_num
  rw [show (16 : ℕ) = 2 ^ 4 by norm_num, Nat.factorization_pow]
  simp [hp.factorization]

def sixteenSourceTokenZero : PrimeExcessToken threeThirteenSixteenDatum.c := by
  change PrimeExcessToken 16
  have hp : Nat.Prime 2 := by norm_num
  have hmem : 2 ∈ (16 : ℕ).primeFactors :=
    hp.mem_primeFactors (by norm_num) (by norm_num)
  exact
    ⟨⟨2, hmem⟩,
      ⟨0, by rw [factorization_sixteen_two]; norm_num⟩⟩

def sixteenSourceTokenOne : PrimeExcessToken threeThirteenSixteenDatum.c := by
  change PrimeExcessToken 16
  have hp : Nat.Prime 2 := by norm_num
  have hmem : 2 ∈ (16 : ℕ).primeFactors :=
    hp.mem_primeFactors (by norm_num) (by norm_num)
  exact
    ⟨⟨2, hmem⟩,
      ⟨1, by rw [factorization_sixteen_two]; norm_num⟩⟩

def sixteenSourceTokenTwo : PrimeExcessToken threeThirteenSixteenDatum.c := by
  change PrimeExcessToken 16
  have hp : Nat.Prime 2 := by norm_num
  have hmem : 2 ∈ (16 : ℕ).primeFactors :=
    hp.mem_primeFactors (by norm_num) (by norm_num)
  exact
    ⟨⟨2, hmem⟩,
      ⟨2, by rw [factorization_sixteen_two]; norm_num⟩⟩

theorem sixteenSourceTokenZero_ne_one :
    sixteenSourceTokenZero ≠ sixteenSourceTokenOne := by
  intro h
  have hval := congrArg
    (fun s : PrimeExcessToken threeThirteenSixteenDatum.c => s.2.val) h
  simp [sixteenSourceTokenZero, sixteenSourceTokenOne] at hval

theorem sixteenSourceTokenZero_ne_two :
    sixteenSourceTokenZero ≠ sixteenSourceTokenTwo := by
  intro h
  have hval := congrArg
    (fun s : PrimeExcessToken threeThirteenSixteenDatum.c => s.2.val) h
  simp [sixteenSourceTokenZero, sixteenSourceTokenTwo] at hval

theorem sixteenSourceTokenOne_ne_two :
    sixteenSourceTokenOne ≠ sixteenSourceTokenTwo := by
  intro h
  have hval := congrArg
    (fun s : PrimeExcessToken threeThirteenSixteenDatum.c => s.2.val) h
  simp [sixteenSourceTokenOne, sixteenSourceTokenTwo] at hval

theorem threeThirteenSixteen_sink_prime
    (q : PrimeSupportToken
      (threeThirteenSixteenDatum.a * threeThirteenSixteenDatum.b)) :
    q.1 = 3 ∨ q.1 = 13 := by
  have hp : q.1.Prime := Nat.prime_of_mem_primeFactors q.property
  have hd : q.1 ∣ 39 := by
    simpa [threeThirteenSixteenDatum] using Nat.dvd_of_mem_primeFactors q.property
  have hle : q.1 ≤ 39 := Nat.le_of_dvd (by norm_num) hd
  interval_cases q.1 <;> norm_num at hp
  all_goals norm_num at hd
  all_goals norm_num

/-- Full integral matching fails by cardinality on a primitive nonunit
triple. -/
theorem threeThirteenSixteen_not_fullIntegralDominanceMatching :
    ¬ FullIntegralDominanceMatching threeThirteenSixteenDatum := by
  rintro ⟨f, hf, _⟩
  have h01 : f sixteenSourceTokenZero ≠ f sixteenSourceTokenOne :=
    fun h => sixteenSourceTokenZero_ne_one (hf h)
  have h02 : f sixteenSourceTokenZero ≠ f sixteenSourceTokenTwo :=
    fun h => sixteenSourceTokenZero_ne_two (hf h)
  have h12 : f sixteenSourceTokenOne ≠ f sixteenSourceTokenTwo :=
    fun h => sixteenSourceTokenOne_ne_two (hf h)
  rcases threeThirteenSixteen_sink_prime (f sixteenSourceTokenZero) with h0 | h0
  <;> rcases threeThirteenSixteen_sink_prime (f sixteenSourceTokenOne) with h1 | h1
  <;> rcases threeThirteenSixteen_sink_prime (f sixteenSourceTokenTwo) with h2 | h2
  all_goals
    exfalso
    first
    | exact h01 (Subtype.ext (by omega))
    | exact h02 (Subtype.ext (by omega))
    | exact h12 (Subtype.ext (by omega))

def nineSixteenTwentyFiveDatum : ABCPoint where
  a := 9
  b := 16
  c := 25
  a_pos := by norm_num
  b_pos := by norm_num
  c_pos := by norm_num
  sum_eq := by norm_num
  pairwise_coprime := by norm_num [PairwiseCoprimeABC]

def twentyFiveSourceToken :
    PrimeExcessToken nineSixteenTwentyFiveDatum.c := by
  change PrimeExcessToken 25
  have hfact : (25 : ℕ).factorization 5 = 2 := by
    have hp : Nat.Prime 5 := by norm_num
    rw [show (25 : ℕ) = 5 ^ 2 by norm_num, Nat.factorization_pow]
    simp [hp.factorization]
  have hp : Nat.Prime 5 := by norm_num
  have hmem : 5 ∈ (25 : ℕ).primeFactors :=
    hp.mem_primeFactors (by norm_num) (by norm_num)
  exact
    ⟨⟨5, hmem⟩,
      ⟨0, by rw [hfact]; norm_num⟩⟩

@[simp] theorem twentyFiveSourceToken_prime :
    primeExcessTokenPrime twentyFiveSourceToken = 5 := by
  simp [primeExcessTokenPrime, twentyFiveSourceToken]

theorem nineSixteenTwentyFive_sink_lt_five
    (q : PrimeSupportToken
      (nineSixteenTwentyFiveDatum.a * nineSixteenTwentyFiveDatum.b)) :
    q.1 < 5 := by
  have hp : q.1.Prime := Nat.prime_of_mem_primeFactors q.property
  have hd : q.1 ∣ 144 := by
    simpa [nineSixteenTwentyFiveDatum] using Nat.dvd_of_mem_primeFactors q.property
  have hle : q.1 ≤ 144 := Nat.le_of_dvd (by norm_num) hd
  interval_cases q.1 <;> norm_num at hp
  all_goals norm_num at hd
  all_goals norm_num

/-- Even favorable aggregate core mass does not force an integral monotone
edge: the unique source prime is `5`, while the external support is `{2,3}`. -/
theorem nineSixteenTwentyFive_not_fullIntegralDominanceMatching :
    ¬ FullIntegralDominanceMatching nineSixteenTwentyFiveDatum := by
  rintro ⟨f, _, hdom⟩
  have hle := hdom twentyFiveSourceToken
  rw [twentyFiveSourceToken_prime] at hle
  have hlt := nineSixteenTwentyFive_sink_lt_five (f twentyFiveSourceToken)
  exact (not_le_of_gt hlt) hle

theorem nineSixteenTwentyFive_core_eq_five :
    endpointCore nineSixteenTwentyFiveDatum = 5 := by
  have hp : Nat.Prime 5 := by norm_num
  unfold endpointCore abcPowerfulPart
  rw [abcRadical_eq_natRadical,
    show (nineSixteenTwentyFiveDatum.c : ℕ) = 5 ^ 2 by
      norm_num [nineSixteenTwentyFiveDatum],
    radical_pow_of_prime hp.prime (by norm_num : (2 : ℕ) ≠ 0)]
  norm_num

theorem nineSixteenTwentyFive_externalRadical_eq_six :
    externalRadical nineSixteenTwentyFiveDatum = 6 := by
  rw [externalRadical_eq_radical_a_mul_radical_b]
  have hthree : Nat.Prime 3 := by norm_num
  have htwo : Nat.Prime 2 := by norm_num
  simp only [nineSixteenTwentyFiveDatum]
  rw [abcRadical_eq_natRadical, abcRadical_eq_natRadical,
    show (9 : ℕ) = 3 ^ 2 by norm_num,
    show (16 : ℕ) = 2 ^ 4 by norm_num,
    radical_pow_of_prime hthree.prime (by norm_num : (2 : ℕ) ≠ 0),
    radical_pow_of_prime htwo.prime (by norm_num : (4 : ℕ) ≠ 0)]
  norm_num

theorem nineSixteenTwentyFive_core_le_externalRadical :
    endpointCore nineSixteenTwentyFiveDatum ≤
      externalRadical nineSixteenTwentyFiveDatum := by
  rw [nineSixteenTwentyFive_core_eq_five,
    nineSixteenTwentyFive_externalRadical_eq_six]
  norm_num

/-! ## A reusable prime-power radical budget -/

/-- If `p^(k+1)` divides a positive integer, removing repeated copies of `p`
forces the displayed radical budget. -/
theorem primePower_succ_dvd_forces_radical_budget
    {p k n : ℕ} (hp : p.Prime) (hn : 0 < n)
    (hpow : p ^ (k + 1) ∣ n) :
    p ^ k * abcRadical n ≤ n := by
  obtain ⟨u, rfl⟩ := hpow
  have hppow : 0 < p ^ (k + 1) := pow_pos hp.pos _
  have hu : 0 < u := by
    by_contra h
    have : u = 0 := Nat.eq_zero_of_not_pos h
    subst u
    simp at hn
  have hraddiv :
      radical (p ^ (k + 1) * u) ∣
        radical (p ^ (k + 1)) * radical u := radical_mul_dvd
  have hradpow : radical (p ^ (k + 1)) = p := by
    simpa using radical_pow_of_prime hp.prime (by omega : k + 1 ≠ 0)
  rw [hradpow] at hraddiv
  have hradrightPos : 0 < p * radical u :=
    mul_pos hp.pos (Nat.radical_pos u)
  have hradle : radical (p ^ (k + 1) * u) ≤ p * radical u :=
    Nat.le_of_dvd hradrightPos hraddiv
  have hradu_le : radical u ≤ u := Nat.radical_le_self_iff.mpr hu.ne'
  rw [abcRadical_eq_natRadical]
  calc
    p ^ k * radical (p ^ (k + 1) * u) ≤
        p ^ k * (p * radical u) := Nat.mul_le_mul_left _ hradle
    _ = p ^ (k + 1) * radical u := by
      rw [pow_succ]
      ring
    _ ≤ p ^ (k + 1) * u := Nat.mul_le_mul_left _ hradu_le

/-! ## An infinite complete-premise obstruction to fixed constants -/

/-- The elementary `3`-adic divisibility behind the Mersenne family.  The
proof works in `ℤ` so the factorization `X^3 - 1` has no truncated
subtraction. -/
theorem three_pow_succ_dvd_four_pow_three_pow_sub_one_int (k : ℕ) :
    (3 : ℤ) ^ (k + 1) ∣ (4 : ℤ) ^ (3 ^ k) - 1 := by
  induction k with
  | zero => norm_num
  | succ k ih =>
      let X : ℤ := (4 : ℤ) ^ (3 ^ k)
      have hthreePow : (3 : ℤ) ^ (k + 1) ∣ X - 1 := by
        simpa [X] using ih
      have hthree : (3 : ℤ) ∣ X - 1 := by
        exact (dvd_pow_self 3 (by omega : k + 1 ≠ 0)).trans hthreePow
      obtain ⟨u, hu⟩ := hthree
      have hX : X = 3 * u + 1 := by omega
      have hfactor : (3 : ℤ) ∣ X ^ 2 + X + 1 := by
        refine ⟨3 * u ^ 2 + 3 * u + 1, ?_⟩
        rw [hX]
        ring
      have hproduct := mul_dvd_mul hthreePow hfactor
      have hpow : (4 : ℤ) ^ (3 ^ (k + 1)) = X ^ 3 := by
        rw [pow_succ]
        exact pow_mul (4 : ℤ) (3 ^ k) 3
      rw [show (3 : ℤ) ^ (k + 1 + 1) =
          (3 : ℤ) ^ (k + 1) * 3 by rw [pow_succ]]
      rw [hpow]
      rw [show X ^ 3 - 1 = (X - 1) * (X ^ 2 + X + 1) by ring]
      exact hproduct

/-- Natural-number form of the `3`-adic Mersenne divisibility. -/
theorem three_pow_succ_dvd_four_pow_three_pow_sub_one (k : ℕ) :
    3 ^ (k + 1) ∣ 4 ^ (3 ^ k) - 1 := by
  have hInt := three_pow_succ_dvd_four_pow_three_pow_sub_one_int k
  have hle : (1 : ℕ) ≤ 4 ^ (3 ^ k) := one_le_pow₀ (by norm_num)
  rw [← Int.natCast_dvd_natCast]
  simpa [Nat.cast_sub hle] using hInt

/-- The genuine primitive unit-arm family `(1, 4^(3^k)-1, 4^(3^k))`. -/
def dyadicMersenneCoreDatum (k : ℕ) : ABCPoint where
  a := 1
  b := 4 ^ (3 ^ k) - 1
  c := 4 ^ (3 ^ k)
  a_pos := by norm_num
  b_pos := by
    have : (1 : ℕ) < 4 ^ (3 ^ k) := by
      exact one_lt_pow₀ (by norm_num) (pow_ne_zero _ (by norm_num))
    omega
  c_pos := pow_pos (by norm_num) _
  sum_eq := by
    have : (1 : ℕ) ≤ 4 ^ (3 ^ k) := one_le_pow₀ (by norm_num)
    omega
  pairwise_coprime := by
    rw [PairwiseCoprimeABC]
    refine ⟨Nat.coprime_one_left _, ?_, Nat.coprime_one_right _⟩
    apply (Nat.coprime_self_sub_left (one_le_pow₀ (by norm_num))).mpr
    exact Nat.coprime_one_left _

theorem dyadicMersenneCoreDatum_radical_c (k : ℕ) :
    abcRadical (dyadicMersenneCoreDatum k).c = 2 := by
  rw [abcRadical_eq_natRadical]
  change radical (4 ^ (3 ^ k)) = 2
  rw [show (4 : ℕ) ^ (3 ^ k) = 2 ^ (2 * 3 ^ k) by
    rw [pow_mul]
    norm_num]
  exact radical_pow_of_prime (by norm_num : Nat.Prime 2).prime
    (mul_ne_zero (by norm_num) (pow_ne_zero _ (by norm_num)))

theorem dyadicMersenneCoreDatum_two_mul_core (k : ℕ) :
    2 * endpointCore (dyadicMersenneCoreDatum k) =
      (dyadicMersenneCoreDatum k).c := by
  rw [← dyadicMersenneCoreDatum_radical_c k]
  exact abcRadical_mul_abcPowerfulPart (dyadicMersenneCoreDatum k).c

theorem dyadicMersenneCoreDatum_three_pow_succ_dvd_b (k : ℕ) :
    3 ^ (k + 1) ∣ (dyadicMersenneCoreDatum k).b := by
  exact three_pow_succ_dvd_four_pow_three_pow_sub_one k

theorem dyadicMersenneCoreDatum_radical_budget (k : ℕ) :
    3 ^ k * abcRadical (dyadicMersenneCoreDatum k).b ≤
      (dyadicMersenneCoreDatum k).b := by
  apply primePower_succ_dvd_forces_radical_budget (by norm_num : Nat.Prime 3)
  · exact (dyadicMersenneCoreDatum k).b_pos
  · exact dyadicMersenneCoreDatum_three_pow_succ_dvd_b k

/-- Cross-multiplied, division-free form of the strict ratio lower bound
`core(c) / rad(b) > 3^k / 2`. -/
theorem dyadicMersenneCoreDatum_three_pow_mul_radical_lt_two_mul_core
    (k : ℕ) :
    3 ^ k * abcRadical (dyadicMersenneCoreDatum k).b <
      2 * endpointCore (dyadicMersenneCoreDatum k) := by
  calc
    3 ^ k * abcRadical (dyadicMersenneCoreDatum k).b ≤
        (dyadicMersenneCoreDatum k).b :=
      dyadicMersenneCoreDatum_radical_budget k
    _ < (dyadicMersenneCoreDatum k).c := by
      change 4 ^ (3 ^ k) - 1 < 4 ^ (3 ^ k)
      have : 0 < 4 ^ (3 ^ k) := pow_pos (by norm_num) _
      omega
    _ = 2 * endpointCore (dyadicMersenneCoreDatum k) :=
      (dyadicMersenneCoreDatum_two_mul_core k).symm

theorem dyadicMersenneCoreDatum_externalRadical (k : ℕ) :
    externalRadical (dyadicMersenneCoreDatum k) =
      abcRadical (dyadicMersenneCoreDatum k).b := by
  unfold externalRadical
  change abcRadical (1 * (4 ^ (3 ^ k) - 1)) =
    abcRadical (4 ^ (3 ^ k) - 1)
  rw [one_mul]

/-- No natural multiplier uniformly bounds the endpoint core by the external
radical on all primitive positive `abc` points.  This exact quantified result
retires only the fixed-constant, zero-epsilon proposal. -/
theorem no_uniform_natural_endpointCore_domination :
    ¬ ∃ K : ℕ, ∀ P : ABCPoint,
      endpointCore P ≤ K * externalRadical P := by
  rintro ⟨K, hK⟩
  let k : ℕ := 2 * K + 1
  let P : ABCPoint := dyadicMersenneCoreDatum k
  have hk : 2 * K < 3 ^ k := by
    have hbase : 2 * K < k := by simp [k]
    have hpow : k ≤ 3 ^ k := by
      induction k with
      | zero => simp
      | succ k ih =>
          rw [pow_succ]
          have hpos : 0 < 3 ^ k := pow_pos (by norm_num) _
          omega
    exact hbase.trans_le hpow
  have hrad : 3 ^ k * abcRadical P.b ≤ P.b := by
    simpa [P] using dyadicMersenneCoreDatum_radical_budget k
  have hradPos : 0 < abcRadical P.b := abcRadical_pos P.b
  have hb_lt : P.b < P.c := by
    change 4 ^ (3 ^ k) - 1 < 4 ^ (3 ^ k)
    have : 0 < 4 ^ (3 ^ k) := pow_pos (by norm_num) _
    omega
  have hdouble : 2 * (K * abcRadical P.b) < P.c := by
    calc
      2 * (K * abcRadical P.b) =
          (2 * K) * abcRadical P.b := by ring
      _ < 3 ^ k * abcRadical P.b :=
        Nat.mul_lt_mul_of_pos_right hk hradPos
      _ ≤ P.b := hrad
      _ < P.c := hb_lt
  have hcore : 2 * endpointCore P = P.c := by
    simpa [P] using dyadicMersenneCoreDatum_two_mul_core k
  have hlt : K * externalRadical P < endpointCore P := by
    rw [dyadicMersenneCoreDatum_externalRadical k]
    apply (Nat.mul_lt_mul_left (by norm_num : 0 < 2)).mp
    rw [hcore]
    exact hdouble
  exact (not_lt_of_ge (hK P)) hlt

end SignedEndpointPrimeTokenTransport
end
end IUTThreeClosures
