/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCSignedEndpointPrimeTokenTransport20260903
import IUTThreeClosures.ABCValuationIncidenceComplex20260903
import IUTThreeClosures.SteinbergValuationContactSurface20260902
import Mathlib.Tactic

/-!
# Three-arm incidence covers and complement transport

This module continues the labeled valuation-incidence route on the full
positive `ABCPoint` domain.  A face may use prime-power vertices on all three
arms.  Its selected moduli weakly cover the endpoint when their product is at
least `c`.

The first candidate asks for a cover whose selected multiplicity defect is
uniformly small.  Its elementary implication to `ABCConjecture` is proved,
but a primitive Pythagorean-square family supplies an infinite obstruction.

The ordered successor gives the unused prime vertices a genuine role.  An
ordered fractional flow sends selected excess-prime mass only to an unselected
prime at least as large.  Exact flow accounting and the selected/complement
radical partition show that a uniform small-unmatched-mass theorem would imply
`ABCConjecture`.  No such uniform flow theorem is assumed or proved here; a
companion module gives its later prime-square refutation.
-/

namespace IUTThreeClosures
namespace ABCThreeArmIncidenceSuccessor20260903

open scoped BigOperators
open UniqueFactorizationMonoid
open SignedEndpointPrimeTokenTransport

noncomputable section

abbrev Arm := ABCValuationIncidenceComplex20260903.Arm

/-- Coordinate of an arm for a positive primitive point. -/
def coordinate (P : ABCPoint) : Arm → ℕ
  | .A => P.a
  | .B => P.b
  | .C => P.c

theorem coordinate_pos (P : ABCPoint) (r : Arm) : 0 < coordinate P r := by
  cases r with
  | A => exact P.a_pos
  | B => exact P.b_pos
  | C => exact P.c_pos

/-- A three-arm face on the full positive `ABCPoint` domain. -/
structure Face (P : ABCPoint) where
  support : Arm → Finset ℕ
  support_subset : ∀ r, support r ⊆ (coordinate P r).primeFactors

namespace Face

variable {P : ABCPoint}

/-- The actual valuation carried by a selected labeled vertex. -/
def valuation (P : ABCPoint) (r : Arm) (p : ℕ) : ℕ :=
  (coordinate P r).factorization p

/-- Product of selected distinct primes on one arm. -/
def armRadical (F : Face P) (r : Arm) : ℕ :=
  ∏ p ∈ F.support r, p

/-- Product of unselected distinct primes on one arm. -/
def armComplementRadical (F : Face P) (r : Arm) : ℕ :=
  ∏ p ∈ (coordinate P r).primeFactors \ F.support r, p

/-- Selected multiplicity defect on one arm. -/
def armDefect (F : Face P) (r : Arm) : ℕ :=
  ∏ p ∈ F.support r, p ^ (valuation P r p - 1)

/-- Selected full prime-power modulus on one arm. -/
def armModulus (F : Face P) (r : Arm) : ℕ :=
  ∏ p ∈ F.support r, p ^ valuation P r p

/-- Product of selected radicals on all three arms. -/
def selectedRadical (F : Face P) : ℕ :=
  ∏ r : Arm, F.armRadical r

/-- Product of complementary radicals on all three arms. -/
def complementRadical (F : Face P) : ℕ :=
  ∏ r : Arm, F.armComplementRadical r

/-- Product of selected multiplicity defects on all three arms. -/
def selectedDefect (F : Face P) : ℕ :=
  ∏ r : Arm, F.armDefect r

/-- Product of selected full prime-power moduli on all three arms. -/
def selectedModulus (F : Face P) : ℕ :=
  ∏ r : Arm, F.armModulus r

/-- Weak three-arm coverage.  The equality case includes `(1,1,2)` and is
enough for the height argument; strict CRT uniqueness is stated separately. -/
def CoversEndpoint (F : Face P) : Prop :=
  P.c ≤ F.selectedModulus

/-- Strict three-arm CRT window. -/
def StrictlyReconstructsEndpoint (F : Face P) : Prop :=
  P.c < F.selectedModulus

theorem prime_of_mem_support (F : Face P) {r : Arm} {p : ℕ}
    (hp : p ∈ F.support r) : p.Prime := by
  exact Nat.prime_of_mem_primeFactors (F.support_subset r hp)

theorem valuation_pos_of_mem_support (F : Face P) {r : Arm} {p : ℕ}
    (hp : p ∈ F.support r) : 0 < valuation P r p := by
  have hprime := F.prime_of_mem_support hp
  have hdvd : p ∣ coordinate P r :=
    (Nat.mem_primeFactors.mp (F.support_subset r hp)).2.1
  exact hprime.factorization_pos_of_dvd (coordinate_pos P r).ne' hdvd

theorem armRadical_pos (F : Face P) (r : Arm) : 0 < F.armRadical r := by
  simp only [armRadical]
  exact Finset.prod_pos fun p hp => (F.prime_of_mem_support hp).pos

theorem armComplementRadical_pos (F : Face P) (r : Arm) :
    0 < F.armComplementRadical r := by
  simp only [armComplementRadical]
  exact Finset.prod_pos fun p hp =>
    (Nat.prime_of_mem_primeFactors (Finset.mem_sdiff.mp hp).1).pos

theorem armDefect_pos (F : Face P) (r : Arm) : 0 < F.armDefect r := by
  simp only [armDefect]
  exact Finset.prod_pos fun p hp => pow_pos (F.prime_of_mem_support hp).pos _

theorem selectedRadical_pos (F : Face P) : 0 < F.selectedRadical := by
  unfold selectedRadical
  exact Finset.prod_pos fun r _ => F.armRadical_pos r

theorem complementRadical_pos (F : Face P) : 0 < F.complementRadical := by
  unfold complementRadical
  exact Finset.prod_pos fun r _ => F.armComplementRadical_pos r

theorem selectedDefect_pos (F : Face P) : 0 < F.selectedDefect := by
  unfold selectedDefect
  exact Finset.prod_pos fun r _ => F.armDefect_pos r

theorem armRadical_mul_armDefect (F : Face P) (r : Arm) :
    F.armRadical r * F.armDefect r = F.armModulus r := by
  rw [armRadical, armDefect, armModulus, ← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro p hp
  rw [← pow_succ']
  congr 1
  have hpos := F.valuation_pos_of_mem_support hp
  omega

/-- Every selected arm modulus divides its actual coordinate. -/
theorem armModulus_dvd_coordinate (F : Face P) (r : Arm) :
    F.armModulus r ∣ coordinate P r := by
  calc
    F.armModulus r ∣
        ∏ p ∈ (coordinate P r).primeFactors,
          p ^ Face.valuation P r p := by
      exact Finset.prod_dvd_prod_of_subset _ _ _ (F.support_subset r)
    _ = coordinate P r := by
      simpa only [valuation, Nat.prod_factorization_eq_prod_primeFactors] using
        (Nat.prod_factorization_pow_eq_self (coordinate_pos P r).ne')

/-- The three actual local incidence congruences. -/
theorem localIncidenceSignature (F : Face P) :
    P.c ≡ P.b [MOD F.armModulus .A] ∧
      P.c ≡ P.a [MOD F.armModulus .B] ∧
        P.c ≡ 0 [MOD F.armModulus .C] := by
  have hA : F.armModulus .A ∣ P.a := by
    simpa [coordinate] using F.armModulus_dvd_coordinate (.A : Arm)
  have hB : F.armModulus .B ∣ P.b := by
    simpa [coordinate] using F.armModulus_dvd_coordinate (.B : Arm)
  have hC : F.armModulus .C ∣ P.c := by
    simpa [coordinate] using F.armModulus_dvd_coordinate (.C : Arm)
  constructor
  · rw [← P.sum_eq]
    simpa using hA.modEq_zero_nat.add_right P.b
  constructor
  · rw [← P.sum_eq]
    simpa using hB.modEq_zero_nat.add_left P.a
  · exact hC.modEq_zero_nat

theorem coprime_modulus_AB (F : Face P) :
    (F.armModulus .A).Coprime (F.armModulus .B) := by
  apply Nat.Coprime.of_dvd
    (by simpa [coordinate] using F.armModulus_dvd_coordinate (.A : Arm))
    (by simpa [coordinate] using F.armModulus_dvd_coordinate (.B : Arm))
    P.pairwise_coprime.1

theorem coprime_modulus_AC (F : Face P) :
    (F.armModulus .A).Coprime (F.armModulus .C) := by
  apply Nat.Coprime.of_dvd
    (by simpa [coordinate] using F.armModulus_dvd_coordinate (.A : Arm))
    (by simpa [coordinate] using F.armModulus_dvd_coordinate (.C : Arm))
    P.pairwise_coprime.2.2.symm

theorem coprime_modulus_BC (F : Face P) :
    (F.armModulus .B).Coprime (F.armModulus .C) := by
  apply Nat.Coprime.of_dvd
    (by simpa [coordinate] using F.armModulus_dvd_coordinate (.B : Arm))
    (by simpa [coordinate] using F.armModulus_dvd_coordinate (.C : Arm))
    P.pairwise_coprime.2.1

/-- In a strict three-arm window, the three local signatures determine the
endpoint uniquely below the product modulus. -/
theorem eq_c_of_strictThreeArmReconstruction
    (F : Face P) (hrec : F.StrictlyReconstructsEndpoint)
    {x : ℕ} (hx : x < F.selectedModulus)
    (hA : x ≡ P.b [MOD F.armModulus .A])
    (hB : x ≡ P.a [MOD F.armModulus .B])
    (hC : x ≡ 0 [MOD F.armModulus .C]) : x = P.c := by
  have hsig := F.localIncidenceSignature
  have hxcA : x ≡ P.c [MOD F.armModulus .A] := hA.trans hsig.1.symm
  have hxcB : x ≡ P.c [MOD F.armModulus .B] := hB.trans hsig.2.1.symm
  have hxcC : x ≡ P.c [MOD F.armModulus .C] := hC.trans hsig.2.2.symm
  have hxcAB : x ≡ P.c [MOD F.armModulus .A * F.armModulus .B] :=
    (Nat.modEq_and_modEq_iff_modEq_mul F.coprime_modulus_AB).1 ⟨hxcA, hxcB⟩
  have hcoprimeABC :
      (F.armModulus .A * F.armModulus .B).Coprime (F.armModulus .C) :=
    F.coprime_modulus_AC.mul_left F.coprime_modulus_BC
  have hxc : x ≡ P.c [MOD
      (F.armModulus .A * F.armModulus .B) * F.armModulus .C] :=
    (Nat.modEq_and_modEq_iff_modEq_mul hcoprimeABC).1 ⟨hxcAB, hxcC⟩
  unfold selectedModulus at hx
  unfold StrictlyReconstructsEndpoint selectedModulus at hrec
  have hprod : (∏ r : Arm, F.armModulus r) =
      (F.armModulus .A * F.armModulus .B) * F.armModulus .C := by
    classical
    rw [show (Finset.univ : Finset Arm) = {.A, .B, .C} by
      ext r
      fin_cases r <;> simp]
    simp [mul_assoc]
  rw [hprod] at hx hrec
  rw [Nat.ModEq, Nat.mod_eq_of_lt hx, Nat.mod_eq_of_lt hrec] at hxc
  exact hxc

theorem selectedRadical_mul_selectedDefect (F : Face P) :
    F.selectedRadical * F.selectedDefect = F.selectedModulus := by
  unfold selectedRadical selectedDefect selectedModulus
  rw [← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro r _
  exact F.armRadical_mul_armDefect r

theorem armRadical_mul_armComplementRadical (F : Face P) (r : Arm) :
    F.armRadical r * F.armComplementRadical r =
      abcRadical (coordinate P r) := by
  rw [abcRadical_eq_natRadical, Nat.radical_eq_prod_primeFactors]
  unfold armRadical armComplementRadical
  rw [← Finset.prod_union]
  · congr 1
    exact Finset.union_sdiff_of_subset (F.support_subset r)
  · exact Finset.disjoint_sdiff

theorem selectedRadical_mul_complementRadical (F : Face P) :
    F.selectedRadical * F.complementRadical =
      abcRadical (P.a * P.b * P.c) := by
  unfold selectedRadical complementRadical
  rw [P.abcRadical_abcProduct]
  rw [← Finset.prod_mul_distrib]
  have hprod : (∏ r : Arm, abcRadical (coordinate P r)) =
      abcRadical P.a * abcRadical P.b * abcRadical P.c := by
    classical
    rw [show (Finset.univ : Finset Arm) = {.A, .B, .C} by
      ext r
      fin_cases r <;> simp]
    simp [coordinate, mul_assoc]
  rw [← hprod]
  apply Finset.prod_congr rfl
  intro r _
  exact F.armRadical_mul_armComplementRadical r

/-- Every cover bounds height by conductor plus its raw selected defect. -/
theorem height_le_conductor_add_log_selectedDefect
    (F : Face P) (hcover : F.CoversEndpoint) :
    P.height ≤ P.conductor + Real.log (F.selectedDefect : ℝ) := by
  have hrad : F.selectedRadical ≤ abcRadical (P.a * P.b * P.c) := by
    exact Nat.le_of_dvd (abcRadical_pos _) ⟨F.complementRadical,
      F.selectedRadical_mul_complementRadical.symm⟩
  have hmod : F.selectedModulus ≤
      abcRadical (P.a * P.b * P.c) * F.selectedDefect := by
    rw [← F.selectedRadical_mul_selectedDefect]
    exact Nat.mul_le_mul_right _ hrad
  have hnat : P.c ≤
      abcRadical (P.a * P.b * P.c) * F.selectedDefect :=
    hcover.trans hmod
  have hreal : (P.c : ℝ) ≤
      (abcRadical (P.a * P.b * P.c) : ℝ) * (F.selectedDefect : ℝ) := by
    exact_mod_cast hnat
  have hlog := Real.log_le_log (by exact_mod_cast P.c_pos) hreal
  rw [P.height_eq_log_c, ABCPoint.conductor]
  rw [Real.log_mul (by exact_mod_cast (abcRadical_pos (P.a * P.b * P.c)).ne')
    (by exact_mod_cast F.selectedDefect_pos.ne')] at hlog
  exact hlog

end Face

/-! ## The first, overstrong raw-defect gate -/

/-- First three-arm candidate: uniformly cover the endpoint using only an
`epsilon`-small selected multiplicity defect. -/
def UniformRawThreeArmDefectBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ C : ℝ, ∀ P : ABCPoint,
      ∃ F : Face P,
        F.CoversEndpoint ∧
          Real.log (F.selectedDefect : ℝ) ≤ epsilon * P.conductor + C

/-- The raw three-arm candidate would imply the standard `abc` conjecture. -/
theorem abc_of_uniformRawThreeArmDefectBound
    (hgate : UniformRawThreeArmDefectBound) : ABCConjecture := by
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
  obtain ⟨F, hcover, hdefect⟩ := hC P
  have hheight := F.height_le_conductor_add_log_selectedDefect hcover
  have htarget : P.height ≤ (1 + epsilon) * P.conductor + C := by
    calc
      P.height ≤ P.conductor + Real.log (F.selectedDefect : ℝ) := hheight
      _ ≤ P.conductor + (epsilon * P.conductor + C) :=
        by simpa [add_comm] using add_le_add_left hdefect P.conductor
      _ = (1 + epsilon) * P.conductor + C := by ring
  simpa [P, ABCPoint.height, ABCPoint.conductor] using htarget

/-! ## Selected-excess to complementary-support transport -/

/-- A selected arm-labeled prime vertex. -/
abbrev SelectedPrimeToken {P : ABCPoint} (F : Face P) :=
  Σ r : Arm, ↥(F.support r)

/-- One token for every valuation layer above the first at a selected vertex. -/
abbrev SelectedExcessToken {P : ABCPoint} (F : Face P) :=
  Σ q : SelectedPrimeToken F,
    Fin (Face.valuation P q.1 q.2.1 - 1)

/-- An unselected arm-labeled prime vertex, available as radical capacity. -/
abbrev ComplementPrimeToken {P : ABCPoint} (F : Face P) :=
  Σ r : Arm, ↥((coordinate P r).primeFactors \ F.support r)

def selectedExcessPrime {P : ABCPoint} {F : Face P}
    (s : SelectedExcessToken F) : ℕ := s.1.2.1

def complementPrime {P : ABCPoint} {F : Face P}
    (q : ComplementPrimeToken F) : ℕ := q.2.1

def selectedExcessWeight {P : ABCPoint} {F : Face P}
    (s : SelectedExcessToken F) : ℝ := Real.log (selectedExcessPrime s : ℝ)

def complementPrimeWeight {P : ABCPoint} {F : Face P}
    (q : ComplementPrimeToken F) : ℝ := Real.log (complementPrime q : ℝ)

/-- Fractional incidence transport.  A selected excess layer at prime `p`
may use complementary radical capacity only at a prime `q >= p`. -/
abbrev ComplementTransport {P : ABCPoint} (F : Face P) :=
  MonotoneWeightedFlow
    (fun s : SelectedExcessToken F => selectedExcessWeight s)
    (fun q : ComplementPrimeToken F => complementPrimeWeight q)
    (fun s : SelectedExcessToken F => selectedExcessPrime s)
    (fun q : ComplementPrimeToken F => complementPrime q)

theorem selectedExcessPrime_prime {P : ABCPoint} {F : Face P}
    (s : SelectedExcessToken F) : (selectedExcessPrime s).Prime := by
  exact F.prime_of_mem_support s.1.2.2

theorem complementPrime_prime {P : ABCPoint} {F : Face P}
    (q : ComplementPrimeToken F) : (complementPrime q).Prime := by
  exact Nat.prime_of_mem_primeFactors (Finset.mem_sdiff.mp q.2.2).1

/-- The zero flow shows that the actual transport type is never empty.  Mere
flow existence gives no small-unmatched-mass conclusion. -/
def zeroComplementTransport {P : ABCPoint} (F : Face P) :
    ComplementTransport F where
  flow := fun _ _ => 0
  flow_nonneg := by simp
  source_capacity := by
    intro s
    rw [Finset.sum_const_zero]
    unfold selectedExcessWeight
    apply Real.log_nonneg
    exact_mod_cast (show 1 ≤ selectedExcessPrime s by
      have := (selectedExcessPrime_prime s).two_le
      omega)
  sink_capacity := by
    intro q
    rw [Finset.sum_const_zero]
    unfold complementPrimeWeight
    apply Real.log_nonneg
    exact_mod_cast (show 1 ≤ complementPrime q by
      have := (complementPrime_prime q).two_le
      omega)
  monotone := by simp

namespace Face

variable {P : ABCPoint}

private theorem sum_subtype_finset (s : Finset ℕ) (f : ℕ → ℝ) :
    (∑ p : ↥s, f p.1) = ∑ p ∈ s, f p := by
  rw [Finset.univ_eq_attach s]
  exact Finset.sum_attach s f

theorem log_armDefect_eq_weightSum (F : Face P) (r : Arm) :
    Real.log (F.armDefect r : ℝ) =
      ∑ p ∈ F.support r,
        ((Face.valuation P r p - 1 : ℕ) : ℝ) * Real.log (p : ℝ) := by
  unfold armDefect
  push_cast
  rw [Real.log_prod]
  · apply Finset.sum_congr rfl
    intro p hp
    rw [Real.log_pow]
  · intro p hp
    exact pow_ne_zero _ (by exact_mod_cast (F.prime_of_mem_support hp).ne_zero)

theorem log_armComplementRadical_eq_weightSum (F : Face P) (r : Arm) :
    Real.log (F.armComplementRadical r : ℝ) =
      ∑ p ∈ (coordinate P r).primeFactors \ F.support r,
        Real.log (p : ℝ) := by
  unfold armComplementRadical
  push_cast
  rw [Real.log_prod]
  intro p hp
  exact_mod_cast
    (Nat.prime_of_mem_primeFactors (Finset.mem_sdiff.mp hp).1).ne_zero

theorem complementTransport_sourceMass_eq_log_selectedDefect
    (F : Face P) (T : ComplementTransport F) :
    T.sourceMass = Real.log (F.selectedDefect : ℝ) := by
  classical
  unfold MonotoneWeightedFlow.sourceMass selectedExcessWeight
    selectedExcessPrime
  rw [Fintype.sum_sigma]
  simp only [Fin.sum_const, nsmul_eq_mul]
  rw [Fintype.sum_sigma]
  rw [selectedDefect]
  push_cast
  rw [Real.log_prod]
  · apply Finset.sum_congr rfl
    intro r _
    rw [F.log_armDefect_eq_weightSum r]
    simpa using
      (sum_subtype_finset (F.support r)
        (fun p => ((Face.valuation P r p - 1 : ℕ) : ℝ) * Real.log (p : ℝ)))
  · intro r _
    exact_mod_cast (F.armDefect_pos r).ne'

theorem complementTransport_sinkMass_eq_log_complementRadical
    (F : Face P) (T : ComplementTransport F) :
    T.sinkMass = Real.log (F.complementRadical : ℝ) := by
  classical
  unfold MonotoneWeightedFlow.sinkMass complementPrimeWeight complementPrime
  rw [Fintype.sum_sigma]
  rw [complementRadical]
  push_cast
  rw [Real.log_prod]
  · apply Finset.sum_congr rfl
    intro r _
    rw [F.log_armComplementRadical_eq_weightSum r]
    simpa using
      (sum_subtype_finset ((coordinate P r).primeFactors \ F.support r)
        (fun p => Real.log (p : ℝ)))
  · intro r _
    exact_mod_cast (F.armComplementRadical_pos r).ne'

/-- The actual complement transport bounds the selected logarithmic defect by
the complementary radical capacity plus unmatched mass. -/
theorem log_selectedDefect_le_log_complementRadical_add_unmatchedMass
    (F : Face P) (T : ComplementTransport F) :
    Real.log (F.selectedDefect : ℝ) ≤
      Real.log (F.complementRadical : ℝ) + T.unmatchedMass := by
  have h := T.sourceMass_sub_sinkMass_le_unmatchedMass
  rw [F.complementTransport_sourceMass_eq_log_selectedDefect T,
    F.complementTransport_sinkMass_eq_log_complementRadical T] at h
  linarith

/-- Every actual complement transport inherits the weighted Hall upper-tail
obstruction from the generic monotone-flow theorem. -/
theorem complementTransport_threshold_obstruction
    (F : Face P) (T : ComplementTransport F) (t : ℕ) :
    T.sourceTailMass t - T.sinkTailMass t ≤ T.unmatchedMass :=
  T.sourceTailMass_sub_sinkTailMass_le_unmatchedMass t

/-- A covering face equipped with complement transport gives the exact
height bound `height <= conductor + unmatchedMass`. -/
theorem height_le_conductor_add_complementTransport_unmatchedMass
    (F : Face P) (hcover : F.CoversEndpoint) (T : ComplementTransport F) :
    P.height ≤ P.conductor + T.unmatchedMass := by
  have hflow :=
    F.log_selectedDefect_le_log_complementRadical_add_unmatchedMass T
  have hpartition :
      Real.log (F.selectedRadical : ℝ) +
          Real.log (F.complementRadical : ℝ) = P.conductor := by
    have hprod := congrArg (fun n : ℕ => (n : ℝ))
      F.selectedRadical_mul_complementRadical
    have hlog := congrArg Real.log hprod
    rw [Nat.cast_mul,
      Real.log_mul (by exact_mod_cast F.selectedRadical_pos.ne')
        (by exact_mod_cast F.complementRadical_pos.ne')] at hlog
    simpa [ABCPoint.conductor] using hlog
  have hcoverLog : P.height ≤
      Real.log (F.selectedRadical : ℝ) +
        Real.log (F.selectedDefect : ℝ) := by
    have hfactor := F.selectedRadical_mul_selectedDefect
    have hcmod : P.c ≤ F.selectedModulus := hcover
    rw [← hfactor] at hcmod
    have hreal : (P.c : ℝ) ≤
        (F.selectedRadical : ℝ) * (F.selectedDefect : ℝ) := by
      exact_mod_cast hcmod
    have hlog := Real.log_le_log (by exact_mod_cast P.c_pos) hreal
    rw [P.height_eq_log_c]
    calc
      Real.log (P.c : ℝ) ≤
          Real.log ((F.selectedRadical : ℝ) * (F.selectedDefect : ℝ)) := hlog
      _ = Real.log (F.selectedRadical : ℝ) +
          Real.log (F.selectedDefect : ℝ) := by
        rw [Real.log_mul (by exact_mod_cast F.selectedRadical_pos.ne')
          (by exact_mod_cast F.selectedDefect_pos.ne')]
  linarith

end Face

/-- Ordered candidate: every positive primitive point has a covering
three-arm face and an actual monotone complement transport with uniformly
small unmatched mass.  Its negation is proved in the companion obstruction
module. -/
def UniformThreeArmComplementTransportBound : Prop :=
  ∀ epsilon : ℝ, 0 < epsilon →
    ∃ C : ℝ, ∀ P : ABCPoint,
      ∃ F : Face P, ∃ T : ComplementTransport F,
        F.CoversEndpoint ∧
          T.unmatchedMass ≤ epsilon * P.conductor + C

/-- The three-arm complement-transport gate implies the unchanged standard
logarithmic `ABCConjecture`. -/
theorem abc_of_uniformThreeArmComplementTransportBound
    (hgate : UniformThreeArmComplementTransportBound) : ABCConjecture := by
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
  obtain ⟨F, T, hcover, hT⟩ := hC P
  have hheight :=
    F.height_le_conductor_add_complementTransport_unmatchedMass hcover T
  have htarget : P.height ≤ (1 + epsilon) * P.conductor + C := by
    calc
      P.height ≤ P.conductor + T.unmatchedMass := hheight
      _ ≤ P.conductor + (epsilon * P.conductor + C) := by
        simpa [add_comm] using add_le_add_left hT P.conductor
      _ = (1 + epsilon) * P.conductor + C := by ring
  simpa [P, ABCPoint.height, ABCPoint.conductor] using htarget

/-! ## Infinite complete-premise obstruction to the raw-defect candidate -/

open SteinbergValuationContactSurface20260902

/-- Every prime occurring in a nonzero square has valuation at least two. -/
theorem two_le_factorization_square_of_mem_primeFactors
    {x p : ℕ} (hx : 0 < x) (hp : p ∈ (x ^ 2).primeFactors) :
    2 ≤ (x ^ 2).factorization p := by
  have hprime : p.Prime := Nat.prime_of_mem_primeFactors hp
  have hpDvdSquare : p ∣ x ^ 2 := (Nat.mem_primeFactors.mp hp).2.1
  have hpDvd : p ∣ x := hprime.dvd_of_dvd_pow hpDvdSquare
  have hfac : 0 < x.factorization p :=
    hprime.factorization_pos_of_dvd hx.ne' hpDvd
  rw [Nat.factorization_pow]
  simp only [Finsupp.smul_apply, smul_eq_mul]
  omega

/-- The three coordinates of the Pythagorean-square point are literal squares
of the three Euclidean parameters. -/
theorem pythagoreanSquare_coordinate
    (t : ℕ) (ht : 0 < t) (r : Arm) :
    coordinate (pythagoreanSquarePoint t ht) r =
      (match r with
        | .A => pythagoreanX t
        | .B => pythagoreanY t
        | .C => pythagoreanZ t) ^ 2 := by
  cases r <;> rfl

/-- Every selected vertex on a Pythagorean-square point has valuation at
least two. -/
theorem pythagoreanSquare_valuation_ge_two
    (t : ℕ) (ht : 0 < t) (F : Face (pythagoreanSquarePoint t ht))
    (r : Arm) {p : ℕ} (hp : p ∈ F.support r) :
    2 ≤ Face.valuation (pythagoreanSquarePoint t ht) r p := by
  have hpSupport := F.support_subset r hp
  rw [pythagoreanSquare_coordinate t ht r] at hpSupport
  cases r with
  | A =>
      exact two_le_factorization_square_of_mem_primeFactors
        (by simp [pythagoreanX]) hpSupport
  | B =>
      exact two_le_factorization_square_of_mem_primeFactors
        (by unfold pythagoreanY; positivity) hpSupport
  | C =>
      exact two_le_factorization_square_of_mem_primeFactors
        (by simp [pythagoreanZ]) hpSupport

namespace Face

variable {P : ABCPoint}

/-- If every selected valuation is at least two, then every selected radical
prime is already paid for inside the selected multiplicity defect. -/
theorem selectedRadical_le_selectedDefect_of_valuation_ge_two
    (F : Face P)
    (hval : ∀ r p, p ∈ F.support r → 2 ≤ Face.valuation P r p) :
    F.selectedRadical ≤ F.selectedDefect := by
  unfold selectedRadical selectedDefect
  exact Finset.prod_le_prod
    (fun _r _hr => Nat.zero_le _)
    (fun r _hr => by
      unfold armRadical armDefect
      exact Finset.prod_le_prod
        (fun _p _hp => Nat.zero_le _)
        (fun p hp => Nat.le_pow (by have := hval r p hp; omega)))

/-- Under the same squarefull condition, the selected modulus is at most the
square of the selected defect. -/
theorem selectedModulus_le_selectedDefect_sq_of_valuation_ge_two
    (F : Face P)
    (hval : ∀ r p, p ∈ F.support r → 2 ≤ Face.valuation P r p) :
    F.selectedModulus ≤ F.selectedDefect ^ 2 := by
  rw [← F.selectedRadical_mul_selectedDefect]
  have hRD := F.selectedRadical_le_selectedDefect_of_valuation_ge_two hval
  calc
    F.selectedRadical * F.selectedDefect ≤
        F.selectedDefect * F.selectedDefect := Nat.mul_le_mul_right _ hRD
    _ = F.selectedDefect ^ 2 := by ring

end Face

/-- Every covering face of the Pythagorean-square point has selected defect
at least the unsquared hypotenuse. -/
theorem pythagoreanZ_le_selectedDefect_of_cover
    (t : ℕ) (ht : 0 < t) (F : Face (pythagoreanSquarePoint t ht))
    (hcover : F.CoversEndpoint) :
    pythagoreanZ t ≤ F.selectedDefect := by
  have hmod := F.selectedModulus_le_selectedDefect_sq_of_valuation_ge_two
    (pythagoreanSquare_valuation_ge_two t ht F)
  have hc : pythagoreanZ t ^ 2 ≤ F.selectedDefect ^ 2 := by
    exact hcover.trans hmod
  exact (Nat.pow_le_pow_iff_left (by norm_num : (2 : ℕ) ≠ 0)).mp hc

/-- The radical of a nonzero square is at most its base. -/
theorem abcRadical_square_le_base (x : ℕ) (hx : 0 < x) :
    abcRadical (x ^ 2) ≤ x := by
  rw [abcRadical_eq_natRadical, radical_pow x (by norm_num : (2 : ℕ) ≠ 0)]
  exact Nat.le_of_dvd hx radical_dvd_self

/-- On the primitive Pythagorean-square family, the total radical is at most
the cube of the unsquared hypotenuse. -/
theorem pythagoreanSquare_totalRadical_le_z_cube
    (t : ℕ) (ht : 0 < t) :
    abcRadical ((pythagoreanSquarePoint t ht).a *
      (pythagoreanSquarePoint t ht).b *
        (pythagoreanSquarePoint t ht).c) ≤ pythagoreanZ t ^ 3 := by
  let P := pythagoreanSquarePoint t ht
  have hx : 0 < pythagoreanX t := by simp [pythagoreanX]
  have hy : 0 < pythagoreanY t := by unfold pythagoreanY; positivity
  have hz : 0 < pythagoreanZ t := by simp [pythagoreanZ]
  have hxz : pythagoreanX t ≤ pythagoreanZ t := by
    unfold pythagoreanX pythagoreanZ
    nlinarith
  have hyz : pythagoreanY t ≤ pythagoreanZ t := by
    unfold pythagoreanY pythagoreanZ
    nlinarith
  rw [P.abcRadical_abcProduct]
  change abcRadical (pythagoreanX t ^ 2) *
      abcRadical (pythagoreanY t ^ 2) *
        abcRadical (pythagoreanZ t ^ 2) ≤ pythagoreanZ t ^ 3
  calc
    abcRadical (pythagoreanX t ^ 2) *
          abcRadical (pythagoreanY t ^ 2) *
            abcRadical (pythagoreanZ t ^ 2) ≤
        pythagoreanX t * pythagoreanY t * pythagoreanZ t := by
      exact Nat.mul_le_mul
        (Nat.mul_le_mul (abcRadical_square_le_base _ hx)
          (abcRadical_square_le_base _ hy))
        (abcRadical_square_le_base _ hz)
    _ ≤ pythagoreanZ t * pythagoreanZ t * pythagoreanZ t := by
      exact Nat.mul_le_mul (Nat.mul_le_mul hxz hyz) le_rfl
    _ = pythagoreanZ t ^ 3 := by ring

/-- The first raw selected-defect gate is false.  The proof uses epsilon
`1/4` and an infinite unbounded primitive Pythagorean-square family; this
particular family does not refute `ABCConjecture`.  A distinct prime-square
family in the companion obstruction module refutes the ordered successor. -/
theorem not_uniformRawThreeArmDefectBound :
    ¬ UniformRawThreeArmDefectBound := by
  intro hgate
  obtain ⟨C, hC⟩ := hgate (1 / 4 : ℝ) (by norm_num)
  obtain ⟨t, htLarge⟩ := exists_nat_gt (Real.exp (4 * C))
  have htPosR : 0 < (t : ℝ) := lt_trans (Real.exp_pos _) htLarge
  have ht : 0 < t := by exact_mod_cast htPosR
  let P := pythagoreanSquarePoint t ht
  obtain ⟨F, hcover, hdefect⟩ := hC P
  have hzPos : 0 < pythagoreanZ t := by simp [pythagoreanZ]
  have htLeZ : t ≤ pythagoreanZ t := by
    unfold pythagoreanZ
    nlinarith
  have hExpZ : Real.exp (4 * C) < (pythagoreanZ t : ℝ) := by
    have htLeZR : (t : ℝ) ≤ (pythagoreanZ t : ℝ) := by exact_mod_cast htLeZ
    exact htLarge.trans_le htLeZR
  have hlogZLarge : 4 * C < Real.log (pythagoreanZ t : ℝ) :=
    (Real.lt_log_iff_exp_lt (by exact_mod_cast hzPos)).2 hExpZ
  have hzD := pythagoreanZ_le_selectedDefect_of_cover t ht F hcover
  have hlogZD : Real.log (pythagoreanZ t : ℝ) ≤
      Real.log (F.selectedDefect : ℝ) := by
    apply Real.log_le_log (by exact_mod_cast hzPos)
    exact_mod_cast hzD
  have hrad := pythagoreanSquare_totalRadical_le_z_cube t ht
  have hlogRad : P.conductor ≤ 3 * Real.log (pythagoreanZ t : ℝ) := by
    have hreal :
        (abcRadical (P.a * P.b * P.c) : ℝ) ≤
          ((pythagoreanZ t : ℝ) ^ 3) := by
      exact_mod_cast hrad
    have hlog := Real.log_le_log
      (by exact_mod_cast (abcRadical_pos (P.a * P.b * P.c))) hreal
    rw [ABCPoint.conductor]
    rw [Real.log_pow] at hlog
    norm_num at hlog
    exact hlog
  norm_num at hdefect
  nlinarith

end
end ABCThreeArmIncidenceSuccessor20260903
end IUTThreeClosures
