/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersennePolylogCodivisorGate20260901
import IUTThreeClosures.MersenneNearDiagonalGlobalTriage20260901

/-!
# Fixed-polylogarithmic actual block mass and sharp Mersenne triage

The mathematical proofs precede this file in
`research/ABC_MERSENNE_FIXED_POLYLOG_BLOCK_MASS_TRIAGE_2026_09_01.md`.

This module removes the auxiliary normalized-exception threshold from the
fixed-polylogarithmic gate.  It partitions the actual divisor block sum into
the strict window

`log (m / d) < k * log (log (3m))`

and its closed complement.  The cyclotomic pointwise cap and the already
proved uniform `C / k` totient-tail estimate show that the full block sum is
little-oh exactly when every fixed positive-integer local block mass is
little-oh.

The final section records the finite ordered-ring core of the improved
three-arm obstruction.  Once only one controlled small arm remains, every
share whose triple fits in the residual budget is forced into the deep,
transition, or extreme arm.  Exact full-premise numerical examples prove
the quarter coefficient and the one-third algebraic ceiling are sharp in
their stated abstract scopes.  No unproved prime-distribution assertion is
introduced.
-/

namespace IUTThreeClosures
namespace MersenneFixedPolylogBlockMassTriage20260901

open Filter Asymptotics
open scoped BigOperators Topology
open MersenneOrderBlockAsymptotic20260901
open MersenneWeightedOrderTail20260901
open MersenneTotientDivisorConcentration20260901
open MersenneTotientDivisorConcentration20260901.ExactMoment
open MersennePolylogCodivisorGate20260901
open MersenneWieferichTailReduction20260901

/-! ## Actual mass in a fixed-polylogarithmic window -/

/-- Actual divisor-block mass in the strict fixed-polylogarithmic
co-divisor window.  Negating the closed far predicate makes the two regions
an exact partition, including the boundary. -/
noncomputable def polylogLocalizedBlockMass
    (mass : ℕ → ℝ) (k m : ℕ) : ℝ :=
  restrictedDivisorMass mass
    (fun n d =>
      Real.log (n / d : ℕ) < fixedPolylogScale k n) m

/-- Actual divisor-block mass in the closed complementary co-divisor tail. -/
noncomputable def polylogFarBlockMass
    (mass : ℕ → ℝ) (k m : ℕ) : ℝ :=
  restrictedDivisorMass mass
    (fun n d =>
      fixedPolylogScale k n ≤ Real.log (n / d : ℕ)) m

lemma polylogLocalizedBlockMass_nonneg
    (mass : ℕ → ℝ) (hmass : ∀ d, 0 ≤ mass d) (k m : ℕ) :
    0 ≤ polylogLocalizedBlockMass mass k m := by
  classical
  unfold polylogLocalizedBlockMass restrictedDivisorMass
  exact Finset.sum_nonneg fun d _ => hmass d

lemma polylogFarBlockMass_nonneg
    (mass : ℕ → ℝ) (hmass : ∀ d, 0 ≤ mass d) (k m : ℕ) :
    0 ≤ polylogFarBlockMass mass k m := by
  classical
  unfold polylogFarBlockMass restrictedDivisorMass
  exact Finset.sum_nonneg fun d _ => hmass d

/-- The full divisor block mass is exactly the closed far mass plus the
strict fixed-polylogarithmic local mass. -/
theorem divisorOrderBlockMassSum_eq_far_add_polylogLocalized
    (mass : ℕ → ℝ) (k m : ℕ) :
    divisorOrderBlockMassSum mass m =
      polylogFarBlockMass mass k m +
        polylogLocalizedBlockMass mass k m := by
  classical
  simpa only [divisorOrderBlockMassSum, polylogFarBlockMass,
      polylogLocalizedBlockMass, restrictedDivisorMass, not_le]
    using
      (Finset.sum_filter_add_sum_filter_not
        m.divisors
          (fun d => fixedPolylogScale k m ≤ Real.log (m / d : ℕ)) mass).symm

/-- A nonnegative localized actual mass is bounded by the full divisor
block mass. -/
theorem polylogLocalizedBlockMass_le_total
    (mass : ℕ → ℝ) (hmass : ∀ d, 0 ≤ mass d) (k m : ℕ) :
    polylogLocalizedBlockMass mass k m ≤
      divisorOrderBlockMassSum mass m := by
  classical
  simp only [polylogLocalizedBlockMass, restrictedDivisorMass,
    divisorOrderBlockMassSum]
  apply Finset.sum_le_sum_of_subset_of_nonneg
    (Finset.filter_subset _ _)
  intro d _ _
  exact hmass d

/-- The actual far block mass inherits any pointwise totient cap and is
therefore bounded by `cap` times the fixed-polylogarithmic far totient
mass. -/
theorem polylogFarBlockMass_le_cap_mul_polylogFarTotientMass
    (mass : ℕ → ℝ) (cap : ℝ) (k m : ℕ)
    (hcap : ∀ d, mass d ≤ cap * (Nat.totient d : ℝ)) :
    polylogFarBlockMass mass k m ≤
      cap * polylogFarTotientMass k m := by
  simpa only [polylogFarBlockMass, polylogFarTotientMass,
      totientMovingLogDeficitTailWeight_eq_restrictedTotientDivisorMass]
    using
      (restrictedDivisorMass_le_cap_totient mass
        (fun n d =>
          fixedPolylogScale k n ≤ Real.log (n / d : ℕ)) cap m hcap)

#print axioms divisorOrderBlockMassSum_eq_far_add_polylogLocalized
#print axioms polylogLocalizedBlockMass_le_total
#print axioms polylogFarBlockMass_le_cap_mul_polylogFarTotientMass

/-! ## The threshold-free equivalence -/

/-- For every nonnegative mass with a fixed totient cap, the full divisor
sum is `o(m)` exactly when its actual mass in every fixed positive-integer
polylogarithmic co-divisor window is `o(m)`.

The reverse implication chooses `k` from the requested error before using
the fixed-`k` little-oh hypothesis. -/
theorem divisorOrderBlockMassSum_isLittleO_iff_all_fixedPolylogBlockMass
    (mass : ℕ → ℝ) (cap : ℝ)
    (hmass : ∀ d, 0 ≤ mass d)
    (hcapNonneg : 0 ≤ cap)
    (hcap : ∀ d, mass d ≤ cap * (Nat.totient d : ℝ)) :
    (divisorOrderBlockMassSum mass =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      (∀ k : ℕ, 0 < k →
        polylogLocalizedBlockMass mass k =o[atTop]
          (fun m : ℕ => (m : ℝ))) := by
  constructor
  · intro htotal k _hk
    apply isLittleO_natCast_of_nonneg_le
      (polylogLocalizedBlockMass mass k)
      (divisorOrderBlockMassSum mass)
    · exact polylogLocalizedBlockMass_nonneg mass hmass k
    · exact divisorOrderBlockMassSum_nonneg mass hmass
    · exact polylogLocalizedBlockMass_le_total mass hmass k
    · exact htotal
  · intro hfixed
    obtain ⟨B, hBpos, hfar⟩ :=
      exists_uniform_polylogFarTotientMass_bound
    apply isLittleO_natCast_of_all_fixed_approximants
      (divisorOrderBlockMassSum mass)
      (fun k m => polylogLocalizedBlockMass mass k m) (cap * B)
    · exact divisorOrderBlockMassSum_nonneg mass hmass
    · exact fun k => polylogLocalizedBlockMass_nonneg mass hmass k
    · exact mul_nonneg hcapNonneg hBpos.le
    · exact hfixed
    · intro k hk
      filter_upwards [hfar] with m hfarM
      have hactualFar :
          polylogFarBlockMass mass k m ≤
            cap * polylogFarTotientMass k m :=
        polylogFarBlockMass_le_cap_mul_polylogFarTotientMass
          mass cap k m hcap
      have htotientFar :
          cap * polylogFarTotientMass k m ≤
            cap * ((B / (k : ℝ)) * (m : ℝ)) :=
        mul_le_mul_of_nonneg_left (hfarM k hk) hcapNonneg
      calc
        divisorOrderBlockMassSum mass m =
            polylogFarBlockMass mass k m +
              polylogLocalizedBlockMass mass k m :=
          divisorOrderBlockMassSum_eq_far_add_polylogLocalized mass k m
        _ ≤ cap * ((B / (k : ℝ)) * (m : ℝ)) +
              polylogLocalizedBlockMass mass k m :=
          add_le_add (hactualFar.trans htotientFar) (le_refl _)
        _ = polylogLocalizedBlockMass mass k m +
              ((cap * B) / (k : ℝ)) * (m : ℝ) := by ring

#print axioms divisorOrderBlockMassSum_isLittleO_iff_all_fixedPolylogBlockMass

/-- The actual Mersenne theorem: the logarithmic power loss is `o(m)` iff
the actual canonical block mass is `o(m)` in every fixed positive-integer
polylogarithmic co-divisor window.  No exceptional threshold remains. -/
theorem log_mersennePowerLoss_isLittleO_iff_all_fixedPolylogBlockMass :
    ((fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
        (fun m : ℕ => (m : ℝ))) ↔
      (∀ k : ℕ, 0 < k →
        polylogLocalizedBlockMass
          mersenneCanonicalOrderBlockLogMass k =o[atTop]
            (fun m : ℕ => (m : ℝ))) := by
  rw [log_mersennePowerLoss_isLittleO_iff_divisorAverage]
  exact
    divisorOrderBlockMassSum_isLittleO_iff_all_fixedPolylogBlockMass
      mersenneCanonicalOrderBlockLogMass (Real.log 3)
      mersenneCanonicalOrderBlockLogMass_nonneg
      (Real.log_nonneg (by norm_num))
      mersenneCanonicalOrderBlockLogMass_le_cyclotomicCap

#print axioms log_mersennePowerLoss_isLittleO_iff_all_fixedPolylogBlockMass

/-! ## Finite three-arm subtraction and transition cardinality -/

/-- If the controlled small arm fits below the target after reserving three
copies of `share`, then one of the three unresolved arms carries `share`.
This is the exact finite core used for every asymptotic coefficient below
one third. -/
theorem deep_or_transition_or_extreme_of_small_budget
    {target small deep transition extreme share : ℝ}
    (htotal : target ≤ small + deep + transition + extreme)
    (hsmall : small ≤ target - 3 * share) :
    share ≤ deep ∨ share ≤ transition ∨ share ≤ extreme := by
  by_contra h
  push Not at h
  rcases h with ⟨hdeep, htransition, hextreme⟩
  linarith

/-- Exact fixed-window composition of the scalar three-arm lemma.  A
pointwise four-arm decomposition is summed over the actual strict
fixed-polylogarithmic divisor window; once the localized small arm fits the
reserved budget, one localized unresolved arm carries `share`.

This is the finite window statement used before the paper's elementary
subsequence and infinite-pigeonhole argument. -/
theorem polylogLocalizedBlockMass_threeArm_of_small_budget
    (total small deep transition extreme : ℕ → ℝ) (k m : ℕ)
    {target share : ℝ}
    (hdecomp : ∀ d,
      total d ≤ small d + deep d + transition d + extreme d)
    (htarget : target ≤ polylogLocalizedBlockMass total k m)
    (hsmall : polylogLocalizedBlockMass small k m ≤ target - 3 * share) :
    share ≤ polylogLocalizedBlockMass deep k m ∨
      share ≤ polylogLocalizedBlockMass transition k m ∨
      share ≤ polylogLocalizedBlockMass extreme k m := by
  have hsum :
      polylogLocalizedBlockMass total k m ≤
        polylogLocalizedBlockMass small k m +
          polylogLocalizedBlockMass deep k m +
          polylogLocalizedBlockMass transition k m +
          polylogLocalizedBlockMass extreme k m := by
    unfold polylogLocalizedBlockMass restrictedDivisorMass
    calc
      (∑ d ∈ m.divisors.filter
          (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
          total d) ≤
          ∑ d ∈ m.divisors.filter
            (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
            (small d + deep d + transition d + extreme d) := by
              exact Finset.sum_le_sum fun d _ => hdecomp d
      _ =
          (∑ d ∈ m.divisors.filter
              (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
              small d) +
            (∑ d ∈ m.divisors.filter
              (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
              deep d) +
            (∑ d ∈ m.divisors.filter
              (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
              transition d) +
            (∑ d ∈ m.divisors.filter
              (fun d => Real.log (m / d : ℕ) < fixedPolylogScale k m),
              extreme d) := by
                simp only [Finset.sum_add_distrib]
  exact deep_or_transition_or_extreme_of_small_budget
    (htarget.trans hsum) hsmall

/-- The convenient quarter specialization: a small arm costing at most a
quarter leaves three quarters for the three unresolved arms. -/
theorem deep_or_transition_or_extreme_of_one_controlled_arm
    {target small deep transition extreme : ℝ}
    (htotal : target ≤ small + deep + transition + extreme)
    (hsmall : small ≤ target / 4) :
    target / 4 ≤ deep ∨
      target / 4 ≤ transition ∨
      target / 4 ≤ extreme := by
  apply deep_or_transition_or_extreme_of_small_budget htotal
  calc
    small ≤ target / 4 := hsmall
    _ = target - 3 * (target / 4) := by ring

/-- A transition arm of mass at least `share`, with positive pointwise cap,
contains at least `share / cap` distinct elements. -/
theorem transition_card_lowerBound_of_share
    {ι : Type*} (s : Finset ι) (weight : ι → ℝ)
    {share cap : ℝ}
    (hweight : ∀ x ∈ s, 0 ≤ weight x)
    (hcapPos : 0 < cap)
    (hcap : ∀ x ∈ s, weight x ≤ cap)
    (hmass : share ≤ ∑ x ∈ s, weight x) :
    share / cap ≤ (s.card : ℝ) := by
  exact transitionCard_lowerBound_of_mass
    s weight hweight hcapPos hcap hmass

/-- Logarithmic specialization used with
`cap = (2 + delta) * log m`. -/
theorem transition_card_lowerBound_of_log_share
    (s : Finset ℕ) {share delta m : ℝ}
    (hweight : ∀ q ∈ s, 0 ≤ Real.log (q : ℝ))
    (hcapPos : 0 < (2 + delta) * Real.log m)
    (hcap : ∀ q ∈ s,
      Real.log (q : ℝ) ≤ (2 + delta) * Real.log m)
    (hmass : share ≤ ∑ q ∈ s, Real.log (q : ℝ)) :
    share / ((2 + delta) * Real.log m) ≤ (s.card : ℝ) := by
  exact transition_card_lowerBound_of_share
    s (fun q : ℕ => Real.log (q : ℝ))
      hweight hcapPos hcap hmass

#print axioms deep_or_transition_or_extreme_of_small_budget
#print axioms polylogLocalizedBlockMass_threeArm_of_small_budget
#print axioms deep_or_transition_or_extreme_of_one_controlled_arm
#print axioms transition_card_lowerBound_of_log_share

/-! ## Exact scope counterexamples for the constants -/

/-- Full finite premises for one controlled small arm and three unresolved
nonnegative arms. -/
def OneSmallArmPremises
    (target small deep transition extreme : ℝ) : Prop :=
  0 ≤ target ∧ 0 ≤ small ∧ 0 ≤ deep ∧
  0 ≤ transition ∧ 0 ≤ extreme ∧
  target = small + deep + transition + extreme ∧
  small ≤ target / 4

/-- The quarter coefficient cannot be increased under exactly the finite
quarter-budget premises: `(4,1,1,1,1)` is a full-premise example. -/
theorem quarter_coefficient_is_sharp
    {c : ℝ} (hc : (1 : ℝ) / 4 < c) :
    ∃ target small deep transition extreme : ℝ,
      OneSmallArmPremises target small deep transition extreme ∧
      ¬ (c * target ≤ deep ∨
         c * target ≤ transition ∨
         c * target ≤ extreme) := by
  refine ⟨4, 1, 1, 1, 1, ?_, ?_⟩
  · norm_num [OneSmallArmPremises]
  · push Not
    constructor
    · nlinarith
    constructor <;> nlinarith

/-- Full finite premises for a three-arm ledger with zero controlled mass. -/
def ZeroSmallArmPremises
    (target small deep transition extreme : ℝ) : Prop :=
  0 ≤ target ∧ 0 ≤ small ∧ 0 ≤ deep ∧
  0 ≤ transition ∧ 0 ≤ extreme ∧
  target = small + deep + transition + extreme ∧
  small = 0

/-- The coefficient one third is the algebraic ceiling of a three-arm
decomposition: `(3,0,1,1,1)` defeats every larger coefficient while
satisfying every displayed premise. -/
theorem one_third_is_sharp_three_arm_ceiling
    {c : ℝ} (hc : (1 : ℝ) / 3 < c) :
    ∃ target small deep transition extreme : ℝ,
      ZeroSmallArmPremises target small deep transition extreme ∧
      ¬ (c * target ≤ deep ∨
         c * target ≤ transition ∨
         c * target ≤ extreme) := by
  refine ⟨3, 0, 1, 1, 1, ?_, ?_⟩
  · norm_num [ZeroSmallArmPremises]
  · push Not
    constructor
    · nlinarith
    constructor <;> nlinarith

#print axioms quarter_coefficient_is_sharp
#print axioms one_third_is_sharp_three_arm_ceiling

end MersenneFixedPolylogBlockMassTriage20260901
end IUTThreeClosures
