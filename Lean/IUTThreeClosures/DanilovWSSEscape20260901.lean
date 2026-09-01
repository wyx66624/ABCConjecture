/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.DanilovSimplePrimitiveNoGo20260901

/-!
# Divisor-pair amplification for a Danilov Wall--Sun--Sun obstruction

The mathematical theorem precedes this file in
research/ABC_DANILOV_WSS_ESCAPE_2026_09_01.md.

The paper combines Carmichael--Yabuta, Sanna's valuation formula, the exact
Danilov--Fibonacci factorization, and a verified 638-prime squarefree
modulus. Those external arithmetic inputs are not reintroduced as Lean
axioms here.

This module kernel-checks the reusable internal pieces:

* a primitive prime cannot be primitive at two different positive indices;
* primitive witnesses at injectively indexed ranks are pairwise distinct;
* equality of prime multiplicities transfers a square divisor;
* the 637-bit half-divisor code has exactly 2^637 elements;
* an injective family indexed by that code yields exactly 2^637 distinct
  repeated-rank witnesses;
* deleting a certified 622 exceptional codes from the full 638-bit divisor
  code leaves exactly `2^638 - 622` codes, and injective primitive witnesses
  on them retain that cardinal;
* a split witness outside the first forty congruence candidates is at least
  `41 * n + 1`;
* the cyclotomic derivative/discriminant shortcut is invalid already in the
  exact numerical Lucas counterexample.

There is no axiom and no sorry.
-/

namespace IUTThreeClosures
namespace DanilovWSSEscape20260901

open DanilovSimplePrimitiveNoGo20260901

-- The exact finite cardinalities below use exponents 637 and 638.  Raising
-- the elaborator threshold locally keeps those intentional terms warning-free.
set_option exponentiation.threshold 700

/-! ## Primitive ranks are unique -/

/-- A prime cannot be primitive for the same sequence at two distinct
positive indices. -/
theorem primitive_index_unique
    {u : ℕ → ℤ} {m n p : ℕ}
    (hmPos : 0 < m) (hnPos : 0 < n)
    (hm : IsPrimitivePrimeDivisor u m p)
    (hn : IsPrimitivePrimeDivisor u n p) :
    m = n := by
  rcases lt_trichotomy m n with hmn | hmn | hnm
  · exact (hn.2.2 m hmPos hmn hm.2.1).elim
  · exact hmn
  · exact (hm.2.2 n hnPos hnm hn.2.1).elim

/-- Choosing a primitive prime at each member of an injective family of
positive ranks automatically gives pairwise distinct primes. -/
theorem primitive_witness_injective
    {ι : Type*} {u : ℕ → ℤ} {rank witness : ι → ℕ}
    (hrank : Function.Injective rank)
    (hrankPos : ∀ i, 0 < rank i)
    (hprimitive :
      ∀ i, IsPrimitivePrimeDivisor u (rank i) (witness i)) :
    Function.Injective witness := by
  intro i j hij
  apply hrank
  apply primitive_index_unique (hrankPos i) (hrankPos j)
      (hprimitive i)
  simpa [hij] using hprimitive j

/-! ## Multiplicity transfer -/

/-- Equality of the multiplicity of a prime in two nonzero integers
transfers divisibility by its square. This is the elementary kernel used
after Sanna identifies the two Fibonacci valuations. -/
theorem square_dvd_of_factorization_eq
    {A B p : ℕ}
    (hp : p.Prime) (hA : A ≠ 0) (hB : B ≠ 0)
    (hfac : A.factorization p = B.factorization p)
    (hsq : p ^ 2 ∣ A) :
    p ^ 2 ∣ B := by
  have hleA : 2 ≤ A.factorization p :=
    (hp.pow_dvd_iff_le_factorization hA).mp hsq
  apply (hp.pow_dvd_iff_le_factorization hB).mpr
  rw [← hfac]
  exact hleA

/-- Abstract rank-level repeatedness. In the Fibonacci application,
Sanna plus the split-rank theorem identifies this with the
Wall--Sun--Sun condition. -/
def IsRepeatedPrimitiveAtRank
    (u : ℕ → ℤ) (m p : ℕ) : Prop :=
  IsPrimitivePrimeDivisor u m p ∧ p ^ 2 ∣ (u m).natAbs

/-- A square divisor at a larger term transfers to the primitive rank once
the two multiplicities have been identified. -/
theorem repeatedPrimitiveAtRank_of_multiplicity_transfer
    {u : ℕ → ℤ} {m N p : ℕ}
    (hprimitive : IsPrimitivePrimeDivisor u m p)
    (hm : (u m).natAbs ≠ 0) (hN : (u N).natAbs ≠ 0)
    (hfac :
      (u N).natAbs.factorization p =
        (u m).natAbs.factorization p)
    (hsqN : p ^ 2 ∣ (u N).natAbs) :
    IsRepeatedPrimitiveAtRank u m p := by
  refine ⟨hprimitive, ?_⟩
  exact square_dvd_of_factorization_eq
    hprimitive.1 hN hm hfac hsqN

/-! ## The exact 2^637 distinct-witness count -/

/-- A canonical code for one representative from each complementary pair
of divisors of a squarefree integer with 638 prime factors. The arithmetic
bijection is supplied in the paper; this type records its exact cardinal. -/
abbrev HalfDivisorCode : Type := Finset (Fin 637)

theorem card_halfDivisorCode :
    Fintype.card HalfDivisorCode = 2 ^ 637 := by
  simp [HalfDivisorCode]

/-- The finite set of values of a witness family on all half-divisor codes. -/
def witnessValues (witness : HalfDivisorCode → ℕ) : Finset ℕ :=
  Finset.univ.image witness

theorem witnessValues_card
    (witness : HalfDivisorCode → ℕ)
    (hwitness : Function.Injective witness) :
    (witnessValues witness).card = 2 ^ 637 := by
  calc
    (witnessValues witness).card =
        (Finset.univ : Finset HalfDivisorCode).card := by
      exact Finset.card_image_iff.mpr hwitness.injOn
    _ = Fintype.card HalfDivisorCode := Finset.card_univ
    _ = 2 ^ 637 := card_halfDivisorCode

/-- Primitive primes attached to injectively varying positive ranks over the
half-divisor code give exactly 2^637 distinct prime values. -/
theorem primitiveWitnessValues_card
    {u : ℕ → ℤ}
    (rank witness : HalfDivisorCode → ℕ)
    (hrank : Function.Injective rank)
    (hrankPos : ∀ i, 0 < rank i)
    (hprimitive :
      ∀ i, IsPrimitivePrimeDivisor u (rank i) (witness i)) :
    (witnessValues witness).card = 2 ^ 637 :=
  witnessValues_card witness
    (primitive_witness_injective hrank hrankPos hprimitive)

/-- If every primitive witness in the half-divisor family is repeated at its
rank, the resulting finite set consists of 2^637 distinct repeated-rank
witnesses. -/
theorem repeatedPrimitiveWitness_amplification
    {u : ℕ → ℤ}
    (rank witness : HalfDivisorCode → ℕ)
    (hrank : Function.Injective rank)
    (hrankPos : ∀ i, 0 < rank i)
    (hrepeated :
      ∀ i, IsRepeatedPrimitiveAtRank u (rank i) (witness i)) :
    (witnessValues witness).card = 2 ^ 637 ∧
      ∀ p ∈ witnessValues witness,
        ∃ i, witness i = p ∧
          IsRepeatedPrimitiveAtRank u (rank i) p := by
  have hprimitive :
      ∀ i, IsPrimitivePrimeDivisor u (rank i) (witness i) :=
    fun i => (hrepeated i).1
  constructor
  · exact primitiveWitnessValues_card rank witness
      hrank hrankPos hprimitive
  · intro p hp
    rw [witnessValues, Finset.mem_image] at hp
    obtain ⟨i, -, hi⟩ := hp
    exact ⟨i, hi, hi ▸ hrepeated i⟩

/-! ## The exact 2^638 - 622 factor-bound count -/

/-- Codes for all divisors of a squarefree integer having 638 labelled prime
factors. The arithmetic subset-product interpretation is certified outside
this file. -/
abbrev AllDivisorCode : Type := Finset (Fin 638)

theorem card_allDivisorCode :
    Fintype.card AllDivisorCode = 2 ^ 638 := by
  simp [AllDivisorCode]

/-- Remove the codes corresponding to the certified small complementary
divisors. -/
def nonexceptionalCodes
    (exceptions : Finset AllDivisorCode) : Finset AllDivisorCode :=
  Finset.univ \ exceptions

theorem card_nonexceptionalCodes
    (exceptions : Finset AllDivisorCode)
    (hcard : exceptions.card = 622) :
    (nonexceptionalCodes exceptions).card = 2 ^ 638 - 622 := by
  simp [nonexceptionalCodes, Finset.card_sdiff, hcard]

/-- Values of a witness family on a specified finite code set. -/
def witnessValuesOn {ι : Type*} [DecidableEq ι]
    (codes : Finset ι) (witness : ι → ℕ) : Finset ℕ :=
  codes.image witness

/-- The abstract kernel of the factor-bound refinement: after exactly 622
exceptional divisor codes are deleted, injectively varying positive primitive
ranks give exactly `2^638 - 622` distinct prime witnesses. -/
theorem nonexceptionalPrimitiveWitnessValues_card
    {u : ℕ → ℤ}
    (exceptions : Finset AllDivisorCode)
    (hcard : exceptions.card = 622)
    (rank witness : AllDivisorCode → ℕ)
    (hrank : Function.Injective rank)
    (hrankPos : ∀ i, 0 < rank i)
    (hprimitive : ∀ i ∈ nonexceptionalCodes exceptions,
      IsPrimitivePrimeDivisor u (rank i) (witness i)) :
    (witnessValuesOn (nonexceptionalCodes exceptions) witness).card =
      2 ^ 638 - 622 := by
  have hwitness : Set.InjOn witness (nonexceptionalCodes exceptions : Set AllDivisorCode) := by
    intro i hi j hj hij
    apply hrank
    apply primitive_index_unique (hrankPos i) (hrankPos j)
        (hprimitive i hi)
    simpa [hij] using hprimitive j hj
  rw [witnessValuesOn, Finset.card_image_iff.mpr hwitness]
  exact card_nonexceptionalCodes exceptions hcard

/-- The retained `2^638 - 622` witnesses are all repeated at their primitive
ranks when the valuation-transfer input supplies repeatedness. In the paper,
Sanna's formula and the split-rank congruence identify these witnesses with
distinct Wall--Sun--Sun primes. -/
theorem nonexceptionalRepeatedPrimitiveWitness_amplification
    {u : ℕ → ℤ}
    (exceptions : Finset AllDivisorCode)
    (hcard : exceptions.card = 622)
    (rank witness : AllDivisorCode → ℕ)
    (hrank : Function.Injective rank)
    (hrankPos : ∀ i, 0 < rank i)
    (hrepeated : ∀ i ∈ nonexceptionalCodes exceptions,
      IsRepeatedPrimitiveAtRank u (rank i) (witness i)) :
    (witnessValuesOn (nonexceptionalCodes exceptions) witness).card =
        2 ^ 638 - 622 ∧
      ∀ p ∈ witnessValuesOn (nonexceptionalCodes exceptions) witness,
        ∃ i ∈ nonexceptionalCodes exceptions,
          witness i = p ∧ IsRepeatedPrimitiveAtRank u (rank i) p := by
  have hprimitive : ∀ i ∈ nonexceptionalCodes exceptions,
      IsPrimitivePrimeDivisor u (rank i) (witness i) :=
    fun i hi => (hrepeated i hi).1
  constructor
  · exact nonexceptionalPrimitiveWitnessValues_card exceptions hcard
      rank witness hrank hrankPos hprimitive
  · intro p hp
    rw [witnessValuesOn, Finset.mem_image] at hp
    obtain ⟨i, hiMem, hi⟩ := hp
    exact ⟨i, hiMem, hi, hi ▸ hrepeated i hiMem⟩

/-! ## The elementary Hong-plus-splitting gap -/

/-- If a split prime has the form `k*n+1` and is different from the first
forty positive candidates `j*n+1`, then its coefficient is at least 41.
Hong's theorem supplies the avoidance hypothesis in the paper. -/
theorem large_split_witness_of_avoids_first_forty
    {n p k : ℕ}
    (hkPos : 0 < k)
    (hp : p = k * n + 1)
    (havoid : ∀ j : ℕ, 1 ≤ j → j ≤ 40 → p ≠ j * n + 1) :
    41 * n + 1 ≤ p := by
  have hk : 41 ≤ k := by
    by_contra hnot
    have hk40 : k ≤ 40 := by omega
    exact (havoid k hkPos hk40) hp
  rw [hp]
  exact Nat.add_le_add_right (Nat.mul_le_mul_right n hk) 1

/-! ## Exact derivative/discriminant no-go core -/

/-- The homogeneous tenth cyclotomic value in the real-Lucas counterexample
has an 11^2 divisor although both the derivative value 142 and the
cyclotomic discriminant 125 are units modulo 11. -/
theorem cyclotomic_square_not_detected_by_derivative_or_discriminant :
    11 ^ 2 ∣ (121 : ℕ) ∧
      ¬ 11 ∣ (142 : ℕ) ∧
      ¬ 11 ∣ (125 : ℕ) := by
  norm_num

#print axioms primitive_index_unique
#print axioms primitive_witness_injective
#print axioms square_dvd_of_factorization_eq
#print axioms repeatedPrimitiveAtRank_of_multiplicity_transfer
#print axioms card_halfDivisorCode
#print axioms witnessValues_card
#print axioms primitiveWitnessValues_card
#print axioms repeatedPrimitiveWitness_amplification
#print axioms card_allDivisorCode
#print axioms card_nonexceptionalCodes
#print axioms nonexceptionalPrimitiveWitnessValues_card
#print axioms nonexceptionalRepeatedPrimitiveWitness_amplification
#print axioms large_split_witness_of_avoids_first_forty
#print axioms cyclotomic_square_not_detected_by_derivative_or_discriminant

end DanilovWSSEscape20260901
end IUTThreeClosures
