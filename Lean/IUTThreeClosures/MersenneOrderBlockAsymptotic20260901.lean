/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneOrderBlockDecomposition20260901
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Nat.Totient

/-!
# The Mersenne order-block asymptotic passage

This module formalizes the asymptotic summation step behind the paper's
implication

`log E_d = o(phi(d))  ==>  log W_m = o(m)`.

The input is kept honest: the little-oh estimate for the block mass is an
explicit hypothesis.  The proof uses the exact divisor identity
`sum_{d | m} phi(d) = m`, bounds the finitely many small divisors by one
fixed prefix, and absorbs both that prefix and the lifting term `log m` into
`o(m)`.
-/

namespace IUTThreeClosures
namespace MersenneOrderBlockAsymptotic20260901

open Filter Asymptotics
open scoped BigOperators Topology
open MersenneOrderBlockDecomposition20260901

/-- Sum of an abstract nonnegative order-block mass over the divisors of an
index. -/
def divisorOrderBlockMassSum (mass : ℕ → ℝ) (m : ℕ) : ℝ :=
  ∑ d ∈ m.divisors, mass d

/-- A uniform totient tail bounds every divisor sum by a fixed finite prefix
plus `epsilon * m`. -/
theorem divisorOrderBlockMassSum_le_prefix_add_totientTail
    (mass : ℕ → ℝ) (m D : ℕ) (epsilon : ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hepsilon : 0 ≤ epsilon)
    (htail : ∀ d ∈ m.divisors, D ≤ d →
      mass d ≤ epsilon * (Nat.totient d : ℝ)) :
    divisorOrderBlockMassSum mass m ≤
      (∑ d ∈ Finset.range D, mass d) + epsilon * (m : ℝ) := by
  unfold divisorOrderBlockMassSum
  rw [← Finset.sum_filter_add_sum_filter_not
    m.divisors (fun d : ℕ => d < D) mass]
  have htailBound :
      (∑ d ∈ m.divisors with ¬ d < D, mass d) ≤
        epsilon * (m : ℝ) := by
    calc
      (∑ d ∈ m.divisors with ¬ d < D, mass d)
          ≤ ∑ d ∈ m.divisors with ¬ d < D,
              epsilon * (Nat.totient d : ℝ) := by
            apply Finset.sum_le_sum
            intro d hd
            exact htail d (Finset.mem_filter.mp hd).1
              (Nat.le_of_not_gt (Finset.mem_filter.mp hd).2)
      _ = epsilon * ∑ d ∈ m.divisors with ¬ d < D,
            (Nat.totient d : ℝ) := by
          rw [Finset.mul_sum]
      _ ≤ epsilon * ∑ d ∈ m.divisors,
            (Nat.totient d : ℝ) := by
          apply mul_le_mul_of_nonneg_left _ hepsilon
          apply Finset.sum_le_sum_of_subset_of_nonneg
            (Finset.filter_subset (fun d : ℕ => ¬ d < D) m.divisors)
          intro d _ _
          positivity
      _ = epsilon * (m : ℝ) := by
          congr 1
          exact_mod_cast Nat.sum_totient m
  have hsubset :
      m.divisors.filter (fun d : ℕ => d < D) ⊆ Finset.range D := by
    intro d hd
    exact Finset.mem_range.mpr (Finset.mem_filter.mp hd).2
  have hsmall :
      (∑ d ∈ m.divisors with d < D, mass d) ≤
        ∑ d ∈ Finset.range D, mass d := by
    apply Finset.sum_le_sum_of_subset_of_nonneg hsubset
    intro d _ _
    exact hmass d
  linarith

/-- Abstract asymptotic passage.  If a nonnegative block mass is
`o(phi(d))`, and a total mass is the corresponding divisor sum plus a
nonnegative lifting mass bounded by `log m`, then the total mass is `o(m)`.

The decomposition and lifting bound are required only for positive indices,
which is exactly what an `atTop` conclusion needs. -/
theorem totalMass_isLittleO_of_orderBlock_totient
    (mass liftingMass totalMass : ℕ → ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hliftingNonneg : ∀ m, 0 < m → 0 ≤ liftingMass m)
    (hmassLittleO :
      mass =o[atTop] (fun d : ℕ => (Nat.totient d : ℝ)))
    (hdecomp : ∀ m, 0 < m →
      totalMass m = divisorOrderBlockMassSum mass m + liftingMass m)
    (hlifting : ∀ m, 0 < m → liftingMass m ≤ Real.log (m : ℝ)) :
    totalMass =o[atTop] (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  let epsilon : ℝ := c / 3
  have hepsilon : 0 < epsilon := by
    dsimp [epsilon]
    positivity
  have htailEventually :
      ∀ᶠ d in atTop,
        mass d ≤ epsilon * (Nat.totient d : ℝ) := by
    filter_upwards [hmassLittleO.bound hepsilon] with d hd
    simpa [Real.norm_eq_abs, abs_of_nonneg (hmass d)] using hd
  rcases (eventually_atTop.1 htailEventually) with ⟨D, hD⟩
  let prefixMass : ℝ := ∑ d ∈ Finset.range D, mass d
  have hprefixNonneg : 0 ≤ prefixMass := by
    dsimp [prefixMass]
    exact Finset.sum_nonneg fun d _ => hmass d
  have hprefixLittleO :
      (fun _ : ℕ => prefixMass) =o[atTop] (fun m : ℕ => (m : ℝ)) := by
    apply isLittleO_const_left.mpr
    exact Or.inr
      (tendsto_norm_atTop_atTop.comp
        (tendsto_natCast_atTop_atTop (R := ℝ)))
  have hlogLittleO :
      (fun m : ℕ => Real.log (m : ℝ)) =o[atTop]
        (fun m : ℕ => (m : ℝ)) :=
    Real.isLittleO_log_id_atTop.natCast_atTop
  filter_upwards [hprefixLittleO.bound hepsilon,
      hlogLittleO.bound hepsilon, eventually_ge_atTop 1]
      with m hprefixBound hlogBound hmOne
  have hm : 0 < m := by omega
  have htail : ∀ d ∈ m.divisors, D ≤ d →
      mass d ≤ epsilon * (Nat.totient d : ℝ) := by
    intro d hd hdD
    exact hD d hdD
  have hsum := divisorOrderBlockMassSum_le_prefix_add_totientTail
    mass m D epsilon hmass hepsilon.le htail
  have htotalNonneg : 0 ≤ totalMass m := by
    rw [hdecomp m hm]
    exact add_nonneg
      (Finset.sum_nonneg fun d _ => hmass d)
      (hliftingNonneg m hm)
  have hprefixBound' : prefixMass ≤ epsilon * (m : ℝ) := by
    simpa [Real.norm_eq_abs, abs_of_nonneg hprefixNonneg] using hprefixBound
  have hlogBound' : Real.log (m : ℝ) ≤ epsilon * (m : ℝ) := by
    calc
      Real.log (m : ℝ) ≤ ‖Real.log (m : ℝ)‖ := by
        rw [Real.norm_eq_abs]
        exact le_abs_self _
      _ ≤ epsilon * ‖(m : ℝ)‖ := hlogBound
      _ = epsilon * (m : ℝ) := by
        rw [Real.norm_eq_abs, abs_of_nonneg]
        positivity
  have htotalBound :
      totalMass m ≤ prefixMass + epsilon * (m : ℝ) + Real.log (m : ℝ) := by
    rw [hdecomp m hm]
    exact add_le_add hsum (hlifting m hm)
  rw [Real.norm_eq_abs, abs_of_nonneg htotalNonneg,
    Real.norm_eq_abs, abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)]
  dsimp [epsilon] at hprefixBound' hlogBound' htotalBound ⊢
  linarith

/-! ## Connection to the actual Mersenne blocks -/

/-- Canonical exact-order block at `d`, defined on the prime support of
`2^d - 1`. -/
noncomputable def mersenneCanonicalOrderBlock (d : ℕ) : ℕ :=
  ∏ p ∈ (2 ^ d - 1).primeFactors with mersenneExactOrder p = d,
    p ^ ((2 ^ d - 1).factorization p - 1)

/-- Every canonical exact-order block is positive. -/
theorem mersenneCanonicalOrderBlock_pos (d : ℕ) :
    0 < mersenneCanonicalOrderBlock d := by
  classical
  unfold mersenneCanonicalOrderBlock
  apply Finset.prod_pos
  intro p hpFiber
  have hp : p.Prime := Nat.prime_of_mem_primeFactors
    (Finset.mem_filter.mp hpFiber).1
  exact pow_pos hp.pos _

/-- Every relative block used in the arithmetic decomposition is positive. -/
theorem mersenneOrderBlock_pos (m d : ℕ) :
    0 < mersenneOrderBlock m d := by
  classical
  unfold mersenneOrderBlock
  apply Finset.prod_pos
  intro p hpFiber
  have hp : p.Prime := Nat.prime_of_mem_primeFactors
    (Finset.mem_filter.mp hpFiber).1
  exact pow_pos hp.pos _

/-- On a divisor `d | m`, restricting the order-`d` block to the support of
`2^m - 1` loses no prime: it is the canonical block at `d`. -/
theorem mersenneOrderBlock_eq_canonical
    {m d : ℕ} (hm : 0 < m) (hd : d ∈ m.divisors) :
    mersenneOrderBlock m d = mersenneCanonicalOrderBlock d := by
  classical
  unfold mersenneOrderBlock mersenneCanonicalOrderBlock
  apply Finset.prod_congr
  · ext p
    simp only [Finset.mem_filter]
    constructor
    · rintro ⟨hpM, hpOrder⟩
      have hp : p.Prime := Nat.prime_of_mem_primeFactors hpM
      have hpDvdM : p ∣ 2 ^ m - 1 := Nat.dvd_of_mem_primeFactors hpM
      have hdDvdM : d ∣ m := Nat.dvd_of_mem_divisors hd
      have hdPos : 0 < d := Nat.pos_of_dvd_of_pos hdDvdM hm
      have hpDvdBase : p ∣ 2 ^ d - 1 := by
        have h := prime_dvd_exactOrder_mersenne hm hp hpDvdM
        simpa [hpOrder] using h
      exact ⟨Nat.mem_primeFactors.mpr
        ⟨hp, hpDvdBase, (mersenne_sub_one_pos hdPos).ne'⟩, hpOrder⟩
    · rintro ⟨hpD, hpOrder⟩
      have hp : p.Prime := Nat.prime_of_mem_primeFactors hpD
      have hdDvdM : d ∣ m := Nat.dvd_of_mem_divisors hd
      have hbaseDvd : 2 ^ d - 1 ∣ 2 ^ m - 1 :=
        Nat.pow_sub_one_dvd_pow_sub_one 2 hdDvdM
      have hpDvdM : p ∣ 2 ^ m - 1 :=
        (Nat.dvd_of_mem_primeFactors hpD).trans hbaseDvd
      exact ⟨Nat.mem_primeFactors.mpr
        ⟨hp, hpDvdM, (mersenne_sub_one_pos hm).ne'⟩, hpOrder⟩
  · intro p hp
    rfl

/-- The canonical logarithmic block mass. -/
noncomputable def mersenneCanonicalOrderBlockLogMass (d : ℕ) : ℝ :=
  Real.log (mersenneCanonicalOrderBlock d : ℝ)

/-- The logarithm of the finite order-block product is the divisor sum of
the canonical block logarithms. -/
theorem log_mersenneOrderBlockProduct_eq_divisorMassSum
    {m : ℕ} (hm : 0 < m) :
    Real.log (mersenneOrderBlockProduct m : ℝ) =
      divisorOrderBlockMassSum mersenneCanonicalOrderBlockLogMass m := by
  classical
  unfold divisorOrderBlockMassSum
  have hcast :
      (mersenneOrderBlockProduct m : ℝ) =
        ∏ d ∈ m.divisors, (mersenneOrderBlock m d : ℝ) := by
    simp [mersenneOrderBlockProduct]
  rw [hcast, Real.log_prod]
  · apply Finset.sum_congr rfl
    intro d hd
    rw [mersenneOrderBlock_eq_canonical hm hd]
    rfl
  · intro d hd
    exact_mod_cast (mersenneOrderBlock_pos m d).ne'

/-- Exact logarithmic form of the arithmetic decomposition. -/
theorem log_mersennePowerLoss_eq_divisorMassSum_add_lifting
    {m : ℕ} (hm : 0 < m) :
    Real.log (mersennePowerLoss m : ℝ) =
      divisorOrderBlockMassSum mersenneCanonicalOrderBlockLogMass m +
        Real.log (mersenneLiftingFactor m : ℝ) := by
  have hLpos : 0 < mersenneLiftingFactor m := by
    unfold mersenneLiftingFactor
    exact Nat.gcd_pos_of_pos_left _ hm
  have hPpos : 0 < mersenneOrderBlockProduct m := by
    rw [← mersenneBaseQuotient_eq_orderBlockProduct hm]
    exact mersenneBaseQuotient_pos hm
  have hcast :
      (mersennePowerLoss m : ℝ) =
        (mersenneLiftingFactor m : ℝ) *
          (mersenneOrderBlockProduct m : ℝ) := by
    exact_mod_cast
      mersennePowerLoss_eq_lifting_mul_orderBlockProduct hm
  calc
    Real.log (mersennePowerLoss m : ℝ) =
        Real.log ((mersenneLiftingFactor m : ℝ) *
          (mersenneOrderBlockProduct m : ℝ)) := congrArg Real.log hcast
    _ = Real.log (mersenneLiftingFactor m : ℝ) +
          Real.log (mersenneOrderBlockProduct m : ℝ) := by
      rw [Real.log_mul]
      · exact_mod_cast hLpos.ne'
      · exact_mod_cast hPpos.ne'
    _ = divisorOrderBlockMassSum mersenneCanonicalOrderBlockLogMass m +
          Real.log (mersenneLiftingFactor m : ℝ) := by
      rw [log_mersenneOrderBlockProduct_eq_divisorMassSum hm]
      ring

/-- The logarithmic lifting mass is nonnegative. -/
theorem log_mersenneLiftingFactor_nonneg (m : ℕ) :
    0 ≤ Real.log (mersenneLiftingFactor m : ℝ) :=
  Real.log_natCast_nonneg _

/-- Since the lifting factor divides the index, its logarithm is bounded by
`log m` at every positive index. -/
theorem log_mersenneLiftingFactor_le_log_index
    {m : ℕ} (hm : 0 < m) :
    Real.log (mersenneLiftingFactor m : ℝ) ≤ Real.log (m : ℝ) := by
  have hLpos : 0 < mersenneLiftingFactor m := by
    unfold mersenneLiftingFactor
    exact Nat.gcd_pos_of_pos_left _ hm
  apply Real.log_le_log
  · exact_mod_cast hLpos
  · exact_mod_cast Nat.le_of_dvd hm (mersenneLiftingFactor_dvd_index m)

/-- The canonical block logarithm is nonnegative. -/
theorem mersenneCanonicalOrderBlockLogMass_nonneg (d : ℕ) :
    0 ≤ mersenneCanonicalOrderBlockLogMass d := by
  unfold mersenneCanonicalOrderBlockLogMass
  exact Real.log_natCast_nonneg _

/-- Actual Mersenne asymptotic passage.  The hypothesis is precisely the
paper's still-open sufficient condition on the canonical exact-order blocks;
the conclusion follows unconditionally from that hypothesis and the exact
arithmetic decomposition proved in the companion module. -/
theorem log_mersennePowerLoss_isLittleO_of_orderBlocks
    (hblocks :
      mersenneCanonicalOrderBlockLogMass =o[atTop]
        (fun d : ℕ => (Nat.totient d : ℝ))) :
    (fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  exact totalMass_isLittleO_of_orderBlock_totient
    mersenneCanonicalOrderBlockLogMass
    (fun m => Real.log (mersenneLiftingFactor m : ℝ))
    (fun m => Real.log (mersennePowerLoss m : ℝ))
    mersenneCanonicalOrderBlockLogMass_nonneg
    (fun m _ => log_mersenneLiftingFactor_nonneg m)
    hblocks
    (fun m hm => log_mersennePowerLoss_eq_divisorMassSum_add_lifting hm)
    (fun m hm => log_mersenneLiftingFactor_le_log_index hm)

#print axioms divisorOrderBlockMassSum_le_prefix_add_totientTail
#print axioms totalMass_isLittleO_of_orderBlock_totient
#print axioms mersenneCanonicalOrderBlock_pos
#print axioms mersenneOrderBlock_pos
#print axioms mersenneOrderBlock_eq_canonical
#print axioms log_mersenneOrderBlockProduct_eq_divisorMassSum
#print axioms log_mersennePowerLoss_eq_divisorMassSum_add_lifting
#print axioms log_mersenneLiftingFactor_nonneg
#print axioms log_mersenneLiftingFactor_le_log_index
#print axioms mersenneCanonicalOrderBlockLogMass_nonneg
#print axioms log_mersennePowerLoss_isLittleO_of_orderBlocks

end MersenneOrderBlockAsymptotic20260901
end IUTThreeClosures
