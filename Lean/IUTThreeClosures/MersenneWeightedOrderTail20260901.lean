/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneOrderBlockAsymptotic20260901

/-!
# The weighted small-order tail and the exact divisor-average endpoint

The mathematical proofs precede this file in
`research/ABC_MERSENNE_WEIGHTED_ORDER_TAIL_2026_09_01.md`.

This module contains only the finite mass algebra and the asymptotic
divisor-sum consequences.  It does not formalize the external analytic
inputs (Brun--Titchmarsh, Erdős--Murty, Siegel--Walfisz, or cyclotomic size
bounds), and it assumes no unproved statement about Wieferich primes.
-/

namespace IUTThreeClosures
namespace MersenneWeightedOrderTail20260901

open Filter Asymptotics
open scoped BigOperators Topology
open MersenneOrderBlockDecomposition20260901
open MersenneOrderBlockAsymptotic20260901

/-! ## Finite logarithmic-shell algebra -/

/-- A positive total mass distributed among finitely many shells overloads
at least one shell relative to any nonnegative profile of total mass at most
one.  This is the finite core of the summable-profile localization. -/
theorem exists_shell_profile_overload
    {κ : Type*} (bins : Finset κ) (shellMass profile : κ → ℝ)
    {target : ℝ}
    (htarget : 0 < target)
    (hmass : target ≤ ∑ k ∈ bins, shellMass k)
    (hprofileSum : ∑ k ∈ bins, profile k ≤ 1) :
    ∃ k ∈ bins, target * profile k ≤ shellMass k := by
  have hbins : bins.Nonempty := by
    by_contra h
    rw [Finset.not_nonempty_iff_eq_empty.mp h] at hmass
    simp only [Finset.sum_empty] at hmass
    linarith
  by_contra h
  push Not at h
  have hpointwise : ∀ k ∈ bins,
      shellMass k ≤ target * profile k := by
    intro k hk
    exact (h k hk).le
  have hstrictWitness : ∃ k ∈ bins,
      shellMass k < target * profile k := by
    rcases hbins with ⟨k, hk⟩
    exact ⟨k, hk, h k hk⟩
  have hsumStrict :
      (∑ k ∈ bins, shellMass k) <
        ∑ k ∈ bins, target * profile k := by
    exact Finset.sum_lt_sum hpointwise hstrictWitness
  have hsumProfile :
      (∑ k ∈ bins, target * profile k) =
        target * ∑ k ∈ bins, profile k := by
    rw [Finset.mul_sum]
  have hprofileBound :
      target * ∑ k ∈ bins, profile k ≤ target := by
    calc
      target * ∑ k ∈ bins, profile k ≤ target * 1 :=
        mul_le_mul_of_nonneg_left hprofileSum htarget.le
      _ = target := mul_one target
  linarith

#print axioms exists_shell_profile_overload

/-- A summable family of shell envelopes bounds the total mass.  In the
number-theoretic application `coefficient` is a quantity tending to zero,
`scale` is `phi(d)`, and `profile` is a fixed summable sequence. -/
theorem totalMass_le_of_profile_shell_bounds
    {κ : Type*} (bins : Finset κ) (shellMass profile : κ → ℝ)
    {total coefficient scale : ℝ}
    (hcoefficient : 0 ≤ coefficient)
    (hscale : 0 ≤ scale)
    (htotal : total ≤ ∑ k ∈ bins, shellMass k)
    (hshell : ∀ k ∈ bins,
      shellMass k ≤ coefficient * scale * profile k)
    (hprofileSum : ∑ k ∈ bins, profile k ≤ 1) :
    total ≤ coefficient * scale := by
  calc
    total ≤ ∑ k ∈ bins, shellMass k := htotal
    _ ≤ ∑ k ∈ bins, coefficient * scale * profile k := by
      exact Finset.sum_le_sum hshell
    _ = (coefficient * scale) * ∑ k ∈ bins, profile k := by
      rw [Finset.mul_sum]
    _ ≤ (coefficient * scale) * 1 := by
      exact mul_le_mul_of_nonneg_left hprofileSum
        (mul_nonneg hcoefficient hscale)
    _ = coefficient * scale := mul_one _

#print axioms totalMass_le_of_profile_shell_bounds

/-- If a total mass is split into light and heavy parts, then either half of
the target remains in the heavy part or the light part contains many points.
The finite cardinal is represented as a nonnegative real `lightCard`. -/
theorem heavyMass_or_manyLight_of_total
    {target lightMass heavyMass lightCard cap : ℝ}
    (hcap : 0 < cap)
    (htotal : target ≤ lightMass + heavyMass)
    (hlight : lightMass ≤ lightCard * cap) :
    target / 2 ≤ heavyMass ∨ target / (2 * cap) ≤ lightCard := by
  by_contra h
  push Not at h
  rcases h with ⟨hheavy, hcard⟩
  have htwoCap : 0 < 2 * cap := mul_pos (by norm_num) hcap
  have hcard' : lightCard * (2 * cap) < target :=
    (lt_div_iff₀ htwoCap).mp hcard
  have hlightStrict : lightCard * cap < target / 2 := by
    nlinarith
  linarith

#print axioms heavyMass_or_manyLight_of_total

/-- A positive lower weight and a total budget bound the number of heavy
points. -/
theorem heavyCard_le_budget_div_threshold
    {heavyCard threshold heavyMass budget : ℝ}
    (hthreshold : 0 < threshold)
    (hfloor : heavyCard * threshold ≤ heavyMass)
    (hbudget : heavyMass ≤ budget) :
    heavyCard ≤ budget / threshold := by
  apply (le_div_iff₀ hthreshold).2
  exact hfloor.trans hbudget

#print axioms heavyCard_le_budget_div_threshold

/-- The square budget alone admits exact saturation by one positive atom.
This finite witness closes only the false abstract strengthening that a
square budget forces a fixed factor-four saving. -/
theorem squareBudget_singleton_saturation
    {budget : ℝ} (hbudget : 0 < budget) :
    ∃ (s : Finset Unit) (weight : Unit → ℝ),
      (∀ x ∈ s, 0 < weight x) ∧
      2 * (∑ x ∈ s, weight x) = budget ∧
      ¬ (∑ x ∈ s, weight x) ≤ budget / 4 := by
  refine ⟨{()}, fun _ => budget / 2, ?_, ?_, ?_⟩
  · intro _ _
    positivity
  · simp only [Finset.sum_singleton]
    field_simp
  · simp only [Finset.sum_singleton]
    intro h
    linarith

#print axioms squareBudget_singleton_saturation

/-! ## Divisor-average endpoint -/

/-- A pointwise `o(phi(d))` estimate for a nonnegative block mass implies
that its divisor sum is `o(m)`.  This isolates the divisor-sum part of the
existing total-mass theorem by taking the lifting mass to be zero. -/
theorem divisorOrderBlockMassSum_isLittleO_of_totient
    (mass : ℕ → ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hmassLittleO :
      mass =o[atTop] (fun d : ℕ => (Nat.totient d : ℝ))) :
    divisorOrderBlockMassSum mass =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  apply totalMass_isLittleO_of_orderBlock_totient
    mass (fun _ => 0) (divisorOrderBlockMassSum mass)
  · exact hmass
  · intro _ _
    norm_num
  · exact hmassLittleO
  · intro _ _
    simp
  · intro m hm
    have hmOne : (1 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hm
    simpa using Real.log_nonneg hmOne

#print axioms divisorOrderBlockMassSum_isLittleO_of_totient

/-- The logarithmic Mersenne lifting factor is itself `o(m)`. -/
theorem log_mersenneLiftingFactor_isLittleO :
    (fun m : ℕ => Real.log (mersenneLiftingFactor m : ℝ)) =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  rw [isLittleO_iff]
  intro c hc
  filter_upwards [Real.isLittleO_log_id_atTop.natCast_atTop.bound hc,
      eventually_ge_atTop 1]
      with m hlog hmOne
  have hm : 0 < m := by omega
  have hLiftNonneg :
      0 ≤ Real.log (mersenneLiftingFactor m : ℝ) :=
    log_mersenneLiftingFactor_nonneg m
  have hLiftLe :
      Real.log (mersenneLiftingFactor m : ℝ) ≤ Real.log (m : ℝ) :=
    log_mersenneLiftingFactor_le_log_index hm
  rw [Real.norm_eq_abs, abs_of_nonneg hLiftNonneg,
    Real.norm_eq_abs, abs_of_nonneg (by positivity : (0 : ℝ) ≤ m)]
  calc
    Real.log (mersenneLiftingFactor m : ℝ) ≤ Real.log (m : ℝ) := hLiftLe
    _ ≤ ‖Real.log (m : ℝ)‖ := by
      rw [Real.norm_eq_abs]
      exact le_abs_self _
    _ ≤ c * ‖(m : ℝ)‖ := hlog
    _ = c * (m : ℝ) := by
      rw [Real.norm_eq_abs, abs_of_nonneg]
      positivity

#print axioms log_mersenneLiftingFactor_isLittleO

/-- The exact endpoint: logarithmic Mersenne power loss is `o(m)` if and
only if the divisor-averaged canonical block mass is `o(m)`.  The difference
between the two functions is exactly the lifting logarithm, already `o(m)`. -/
theorem log_mersennePowerLoss_isLittleO_iff_divisorAverage :
    ((fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      ((fun m : ℕ =>
          divisorOrderBlockMassSum mersenneCanonicalOrderBlockLogMass m)
        =o[atTop] (fun m : ℕ => (m : ℝ))) := by
  let total : ℕ → ℝ :=
    fun m => Real.log (mersennePowerLoss m : ℝ)
  let blocks : ℕ → ℝ :=
    fun m => divisorOrderBlockMassSum mersenneCanonicalOrderBlockLogMass m
  let lifting : ℕ → ℝ :=
    fun m => Real.log (mersenneLiftingFactor m : ℝ)
  have hlifting : lifting =o[atTop] (fun m : ℕ => (m : ℝ)) := by
    exact log_mersenneLiftingFactor_isLittleO
  have hdecomp :
      ∀ᶠ m in atTop, total m = blocks m + lifting m := by
    filter_upwards [eventually_ge_atTop 1] with m hmOne
    have hm : 0 < m := by omega
    exact log_mersennePowerLoss_eq_divisorMassSum_add_lifting hm
  constructor
  · intro htotal
    have hsub :
        (fun m => total m - lifting m) =o[atTop]
          (fun m : ℕ => (m : ℝ)) := htotal.sub hlifting
    apply hsub.congr'
    · filter_upwards [hdecomp] with m hm
      dsimp [total, blocks, lifting] at hm ⊢
      linarith
    · exact Filter.Eventually.of_forall fun _ => rfl
  · intro hblocks
    have hadd :
        (fun m => blocks m + lifting m) =o[atTop]
          (fun m : ℕ => (m : ℝ)) := hblocks.add hlifting
    apply hadd.congr'
    · filter_upwards [hdecomp] with m hm
      exact hm.symm
    · exact Filter.Eventually.of_forall fun _ => rfl

#print axioms log_mersennePowerLoss_isLittleO_iff_divisorAverage

/-- A pointwise split of a block mass into a controlled small arm and a
remainder induces the corresponding exact split of every divisor sum. -/
theorem divisorOrderBlockMassSum_split
    (block small remainder : ℕ → ℝ)
    (hsplit : ∀ d, block d = small d + remainder d) (m : ℕ) :
    divisorOrderBlockMassSum block m =
      divisorOrderBlockMassSum small m +
        divisorOrderBlockMassSum remainder m := by
  classical
  unfold divisorOrderBlockMassSum
  simp_rw [hsplit]
  exact Finset.sum_add_distrib

#print axioms divisorOrderBlockMassSum_split

/-- Strictly weaker endpoint input: the small arm may be controlled
pointwise by `o(phi(d))`, while the remaining tail needs only an `o(m)`
estimate after summing over divisors. -/
theorem divisorAverage_isLittleO_of_smallBlocks_and_remainder
    (block small remainder : ℕ → ℝ)
    (hsmallNonneg : ∀ d, 0 ≤ small d)
    (hsmallLittleO :
      small =o[atTop] (fun d : ℕ => (Nat.totient d : ℝ)))
    (hremainderAverage :
      divisorOrderBlockMassSum remainder =o[atTop]
        (fun m : ℕ => (m : ℝ)))
    (hsplit : ∀ d, block d = small d + remainder d) :
    divisorOrderBlockMassSum block =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  have hsmallAverage :
      divisorOrderBlockMassSum small =o[atTop]
        (fun m : ℕ => (m : ℝ)) :=
    divisorOrderBlockMassSum_isLittleO_of_totient
      small hsmallNonneg hsmallLittleO
  have hadd :
      (fun m => divisorOrderBlockMassSum small m +
        divisorOrderBlockMassSum remainder m) =o[atTop]
          (fun m : ℕ => (m : ℝ)) :=
    hsmallAverage.add hremainderAverage
  apply hadd.congr
  · intro m
    exact (divisorOrderBlockMassSum_split
      block small remainder hsplit m).symm
  · intro _
    rfl

#print axioms divisorAverage_isLittleO_of_smallBlocks_and_remainder

/-- Actual Mersenne closure from a controlled pointwise small arm and an
`o(m)` divisor-average remainder.  This is weaker than demanding the
remainder be `o(phi(d))` at every order. -/
theorem log_mersennePowerLoss_isLittleO_of_smallBlocks_and_remainder
    (small remainder : ℕ → ℝ)
    (hsmallNonneg : ∀ d, 0 ≤ small d)
    (hsmallLittleO :
      small =o[atTop] (fun d : ℕ => (Nat.totient d : ℝ)))
    (hremainderAverage :
      divisorOrderBlockMassSum remainder =o[atTop]
        (fun m : ℕ => (m : ℝ)))
    (hsplit : ∀ d,
      mersenneCanonicalOrderBlockLogMass d = small d + remainder d) :
    (fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  apply log_mersennePowerLoss_isLittleO_iff_divisorAverage.mpr
  exact divisorAverage_isLittleO_of_smallBlocks_and_remainder
    mersenneCanonicalOrderBlockLogMass small remainder
    hsmallNonneg hsmallLittleO hremainderAverage hsplit

#print axioms log_mersennePowerLoss_isLittleO_of_smallBlocks_and_remainder

end MersenneWeightedOrderTail20260901
end IUTThreeClosures
