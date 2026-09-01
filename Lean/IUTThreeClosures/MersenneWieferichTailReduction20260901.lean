/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

/-!
# A finite mass reduction for canonical Mersenne Wieferich blocks

For an odd prime `q`, put

`d_q = ord_q(2)` and `w_q = v_q(2 ^ d_q - 1)`.

The canonical order block and its two useful factors are

`E_d = ∏_{d_q = d} q ^ (w_q - 1)`,

`T_d = ∏_{d_q = d, 2 ≤ w_q} q`, and

`D_d = ∏_{d_q = d, 3 ≤ w_q} q ^ (w_q - 2)`.

Prime by prime, `E_d = T_d * D_d`.  Thus the logarithmic block mass is
the sum of a one-copy repeated-prime support mass and a genuinely deep-lift
mass.  An external Brun--Titchmarsh argument controls the part of `T_d`
with

`q ≤ d ^ 2 / (log log (3 * d)) ^ 3`

by `o(phi(d))`.  That analytic estimate is deliberately **not** asserted in
this file.  Once it is supplied, a counterexample-sized total mass must lie
in the deep-lift arm or in the remaining large-prime arm.  Splitting the
large-prime arm at `d ^ (2 + delta)` gives three possible obstructions:

1. deep Wieferich lifts;
2. a transition-range cluster of repeated primes;
3. primes of exceptionally small multiplicative order relative to their
   size.

The theorems below formalize exactly the finite ordered-ring core of this
reduction.  All number-theoretic and analytic inputs (the product identity,
the small-arm estimate, prime-size bounds, and mass lower bounds) occur as
explicit hypotheses.  In particular, no Brun--Titchmarsh theorem, totient
lower bound, multiplicative-order distribution theorem, or unresolved
Wieferich assertion is hidden in the formal statements.

## Paper proofs represented here

* If `E = T * D` and `1 ≤ T, D`, then logarithmic multiplicativity gives
  `log E = log T + log D`, and both summands are nonnegative.
* On a finite repeated-prime support, if every exponent `a_p` is at least
  two, the excess factor with exponent `a_p - 1` is at most the powerful
  factor with exponent `a_p`, which is in turn at most the square of the
  excess factor.  Consequently their logarithmic masses differ by at most
  a factor of two.  The cyclotomic identification of these products is an
  external input and is not asserted here.
* If the total bad mass is at least `epsilon * phi`, while the controlled
  small arm is at most half that amount, then the deep or large arm is at
  least one quarter of it.  Otherwise their sum is too small.
* If the uncontrolled mass is split into deep, transition, and extreme
  arms, and the small arm is at most one quarter of the target, then one of
  those three arms is at least one quarter of the target.
* A finite transition set whose every logarithmic weight is at most `cap`
  has total mass at most `card * cap`.  Hence a positive lower bound for its
  mass yields the corresponding lower bound for its cardinality.  Taking
  `cap = (2 + delta) * log d` is the finite core of the transition-cluster
  conclusion.
-/

namespace IUTThreeClosures
namespace MersenneWieferichTailReduction20260901

open scoped BigOperators

/-- Abstract logarithmic form of the exact factorization `E_d = T_d * D_d`.
The lower bounds by one record that the factors are positive integral
products and also provide nonnegativity of both logarithmic masses. -/
theorem logMass_decomposition_of_excess_eq_support_mul_deep
    {E T D : ℝ} (hT : 1 ≤ T) (hD : 1 ≤ D) (hE : E = T * D) :
    0 ≤ Real.log T ∧
      0 ≤ Real.log D ∧
      Real.log E = Real.log T + Real.log D := by
  have hTne : T ≠ 0 := ne_of_gt (lt_of_lt_of_le zero_lt_one hT)
  have hDne : D ≠ 0 := ne_of_gt (lt_of_lt_of_le zero_lt_one hD)
  refine ⟨Real.log_nonneg hT, Real.log_nonneg hD, ?_⟩
  rw [hE, Real.log_mul hTne hDne]

#print axioms logMass_decomposition_of_excess_eq_support_mul_deep

/-! ## Powerful-part comparison -/

/-- The exponentwise inequality behind the comparison of canonical excess
and powerful part.  For a base at least one and an exponent at least two,
the exponent `a - 1` lies below `a`, while `a` lies below `2 * (a - 1)`. -/
theorem primePower_excess_le_powerful_le_square
    {p a : ℕ} (hp : 1 ≤ p) (ha : 2 ≤ a) :
    p ^ (a - 1) ≤ p ^ a ∧ p ^ a ≤ (p ^ (a - 1)) ^ 2 := by
  constructor
  · exact pow_le_pow_right₀ hp (Nat.sub_le a 1)
  · rw [← pow_mul]
    apply pow_le_pow_right₀ hp
    omega

#print axioms primePower_excess_le_powerful_le_square

/-- Finite product with one copy removed from every exponent.  In the
number-theoretic application the bases are the repeated prime divisors of a
cyclotomic value. -/
def finitePowerfulExcess {ι : Type*} (s : Finset ι)
    (base exponent : ι → ℕ) : ℕ :=
  ∏ i ∈ s, base i ^ (exponent i - 1)

/-- Finite powerful part retaining every repeated-prime exponent. -/
def finitePowerfulPart {ι : Type*} (s : Finset ι)
    (base exponent : ι → ℕ) : ℕ :=
  ∏ i ∈ s, base i ^ exponent i

/-- For any finite family of bases at least one and exponents at least two,
the excess product is at most the powerful product, which is at most the
square of the excess product. -/
theorem finitePowerfulExcess_le_part_le_square
    {ι : Type*} (s : Finset ι) (base exponent : ι → ℕ)
    (hbase : ∀ i ∈ s, 1 ≤ base i)
    (hexponent : ∀ i ∈ s, 2 ≤ exponent i) :
    finitePowerfulExcess s base exponent ≤
        finitePowerfulPart s base exponent ∧
      finitePowerfulPart s base exponent ≤
        (finitePowerfulExcess s base exponent) ^ 2 := by
  have hfactor : ∀ i ∈ s,
      base i ^ (exponent i - 1) ≤ base i ^ exponent i ∧
      base i ^ exponent i ≤ (base i ^ (exponent i - 1)) ^ 2 := by
    intro i hi
    exact primePower_excess_le_powerful_le_square
      (hbase i hi) (hexponent i hi)
  constructor
  · unfold finitePowerfulExcess finitePowerfulPart
    exact Finset.prod_le_prod
      (fun _i _hi => Nat.zero_le _)
      (fun i hi => (hfactor i hi).1)
  · unfold finitePowerfulExcess finitePowerfulPart
    calc
      (∏ i ∈ s, base i ^ exponent i)
          ≤ ∏ i ∈ s, (base i ^ (exponent i - 1)) ^ 2 := by
            exact Finset.prod_le_prod
              (fun _i _hi => Nat.zero_le _)
              (fun i hi => (hfactor i hi).2)
      _ = (∏ i ∈ s, base i ^ (exponent i - 1)) ^ 2 := by
            exact Finset.prod_pow s 2
              (fun i => base i ^ (exponent i - 1))

#print axioms finitePowerfulExcess_le_part_le_square

/-- Ordered-logarithm core of the equivalence between excess mass and
powerful-part mass. -/
theorem logMass_comparison_of_excess_powerful_bounds
    {E V : ℝ} (hE : 1 ≤ E) (hEV : E ≤ V) (hVE : V ≤ E ^ 2) :
    Real.log E ≤ Real.log V ∧ Real.log V ≤ 2 * Real.log E := by
  have hEpos : 0 < E := lt_of_lt_of_le zero_lt_one hE
  have hVpos : 0 < V := lt_of_lt_of_le hEpos hEV
  constructor
  · exact Real.strictMonoOn_log.monotoneOn hEpos hVpos hEV
  · calc
      Real.log V ≤ Real.log (E ^ 2) :=
        Real.strictMonoOn_log.monotoneOn hVpos (pow_pos hEpos 2) hVE
      _ = 2 * Real.log E := by
        rw [Real.log_pow]
        norm_num

#print axioms logMass_comparison_of_excess_powerful_bounds

/-- The concrete finite-product logarithmic comparison.  This is the
finite squeeze needed to transfer any normalized little-oh estimate between
the excess product and the powerful product. -/
theorem finitePowerful_logMass_comparison
    {ι : Type*} (s : Finset ι) (base exponent : ι → ℕ)
    (hbase : ∀ i ∈ s, 1 ≤ base i)
    (hexponent : ∀ i ∈ s, 2 ≤ exponent i) :
    Real.log (finitePowerfulExcess s base exponent : ℝ) ≤
        Real.log (finitePowerfulPart s base exponent : ℝ) ∧
      Real.log (finitePowerfulPart s base exponent : ℝ) ≤
        2 * Real.log (finitePowerfulExcess s base exponent : ℝ) := by
  have hEoneNat : 1 ≤ finitePowerfulExcess s base exponent := by
    unfold finitePowerfulExcess
    apply Finset.one_le_prod
    intro i hi
    exact Nat.one_le_pow _ _
      (lt_of_lt_of_le Nat.zero_lt_one (hbase i hi))
  have hbounds := finitePowerfulExcess_le_part_le_square
    s base exponent hbase hexponent
  apply logMass_comparison_of_excess_powerful_bounds
  · exact_mod_cast hEoneNat
  · exact_mod_cast hbounds.1
  · exact_mod_cast hbounds.2

#print axioms finitePowerful_logMass_comparison

/-! ## Finite mass dichotomies -/

/-- Once a small arm is bounded by half of a nonnegative target mass, a
total mass at least that target forces the deep arm or the large-prime arm
to carry at least one quarter of the target. -/
theorem deep_or_large_of_small_control
    {epsilon phi small deep large : ℝ}
    (hepsilon : 0 ≤ epsilon) (hphi : 0 ≤ phi)
    (htotal : epsilon * phi ≤ small + deep + large)
    (hsmall : small ≤ epsilon * phi / 2) :
    epsilon * phi / 4 ≤ deep ∨ epsilon * phi / 4 ≤ large := by
  by_contra h
  push Not at h
  rcases h with ⟨hdeep, hlarge⟩
  have htarget : 0 ≤ epsilon * phi := mul_nonneg hepsilon hphi
  linarith

#print axioms deep_or_large_of_small_control

/-- Splitting the large-prime arm into transition and extreme ranges gives
the finite three-way obstruction.  If the controlled small arm costs at
most one quarter of the target, at least one uncontrolled arm costs one
quarter. -/
theorem deep_or_transition_or_extreme_of_small_control
    {epsilon phi small deep transition extreme : ℝ}
    (hepsilon : 0 ≤ epsilon) (hphi : 0 ≤ phi)
    (htotal :
      epsilon * phi ≤ small + deep + transition + extreme)
    (hsmall : small ≤ epsilon * phi / 4) :
    epsilon * phi / 4 ≤ deep ∨
      epsilon * phi / 4 ≤ transition ∨
      epsilon * phi / 4 ≤ extreme := by
  by_contra h
  push Not at h
  rcases h with ⟨hdeep, htransition, hextreme⟩
  have htarget : 0 ≤ epsilon * phi := mul_nonneg hepsilon hphi
  linarith

#print axioms deep_or_transition_or_extreme_of_small_control

/-- A finite sum of terms bounded above by `cap` is bounded by the
cardinality times `cap`.  Nonnegativity is included to match logarithmic
prime weights, although the upper-bound argument itself only needs the
pointwise cap. -/
theorem transitionMass_le_card_mul_cap
    {ι : Type*} (s : Finset ι) (weight : ι → ℝ) {cap : ℝ}
    (_hweight : ∀ x ∈ s, 0 ≤ weight x)
    (hcap : ∀ x ∈ s, weight x ≤ cap) :
    (∑ x ∈ s, weight x) ≤ (s.card : ℝ) * cap := by
  calc
    (∑ x ∈ s, weight x) ≤ ∑ _x ∈ s, cap := by
      exact Finset.sum_le_sum fun x hx => hcap x hx
    _ = (s.card : ℝ) * cap := by simp

#print axioms transitionMass_le_card_mul_cap

/-- A positive transition mass and a positive pointwise cap force a lower
bound for the size of the transition set. -/
theorem transitionCard_lowerBound_of_mass
    {ι : Type*} (s : Finset ι) (weight : ι → ℝ)
    {mass cap : ℝ}
    (hweight : ∀ x ∈ s, 0 ≤ weight x)
    (hcapPos : 0 < cap)
    (hcap : ∀ x ∈ s, weight x ≤ cap)
    (hmass : mass ≤ ∑ x ∈ s, weight x) :
    mass / cap ≤ (s.card : ℝ) := by
  apply (div_le_iff₀ hcapPos).2
  calc
    mass ≤ ∑ x ∈ s, weight x := hmass
    _ ≤ (s.card : ℝ) * cap :=
      transitionMass_le_card_mul_cap s weight hweight hcap

#print axioms transitionCard_lowerBound_of_mass

/-- Specialized transition-cluster estimate.  In the intended application
`s` is the set of repeated exact-order primes in
`Y_d < q ≤ d ^ (2 + delta)`, and the displayed pointwise hypothesis comes
from `log q ≤ (2 + delta) * log d`. -/
theorem transitionCard_lowerBound_of_log_bound
    (s : Finset ℕ) {epsilon phi delta d : ℝ}
    (heachNonneg : ∀ q ∈ s, 0 ≤ Real.log (q : ℝ))
    (hcapPos : 0 < (2 + delta) * Real.log d)
    (heach : ∀ q ∈ s,
      Real.log (q : ℝ) ≤ (2 + delta) * Real.log d)
    (hmass :
      epsilon * phi / 4 ≤ ∑ q ∈ s, Real.log (q : ℝ)) :
    (epsilon * phi / 4) / ((2 + delta) * Real.log d) ≤
      (s.card : ℝ) := by
  exact transitionCard_lowerBound_of_mass s
    (fun q : ℕ => Real.log (q : ℝ)) heachNonneg hcapPos heach hmass

#print axioms transitionCard_lowerBound_of_log_bound

/-! ## Square-budget saturation

There is a second finite obstruction behind the transition alternative.
Let `S` be the repeated exact-order support and let `T` be the product of
its primes.  Since every repeated factor occurs at least to the second
power in the cyclotomic value `Phi`, one has `T ^ 2 ≤ Phi`.  Also every
exact-order prime is at least `d + 1`.  Therefore

`card(S) * log(d + 1) ≤ log T ≤ log Phi / 2`.

The first inequality is obtained by summing the pointwise lower bounds on
the logarithms; the second follows by taking logarithms of `T ^ 2 ≤ Phi`.
Pomerance's numerical upper bound for `Phi_d(2)` is **not** formalized here:
the finite theorem retains `T ^ 2 ≤ Phi` as an explicit hypothesis.

Combining this square budget with a transition mass lower bound gives a
quantitative saturation statement.  If transition weights are at most
`cap`, their mass is at least `mass`, the total support has log floor
`floor`, and its available ambient log budget is `phiLog / 2`, then the
transition cardinality is at least the fraction

`2 * mass * floor / (cap * phiLog)`

of the total support cardinality.  In the arithmetic application, putting
`mass = eta * phi(d)`, `floor = log(d + 1)`,
`cap = (2 + delta) * log d`, and
`phiLog = (phi(d) + 1) * log 2` makes this fraction tend to the fixed
positive constant `2 * eta / ((2 + delta) * log 2)`.
-/

/-- Finite repeated-support log budget.  The product-square hypothesis is
the exact abstract form of saying that each support factor occurs at least
twice in the ambient cyclotomic value. -/
theorem repeatedSupport_card_log_budget
    {ι : Type*} (s : Finset ι) (factor : ι → ℝ) {d Phi : ℝ}
    (hd : 0 < d + 1)
    (hfactor : ∀ i ∈ s, d + 1 ≤ factor i)
    (hsquare : (∏ i ∈ s, factor i) ^ 2 ≤ Phi) :
    (s.card : ℝ) * Real.log (d + 1) ≤
        Real.log (∏ i ∈ s, factor i) ∧
      Real.log (∏ i ∈ s, factor i) ≤ Real.log Phi / 2 := by
  have hfactorPos : ∀ i ∈ s, 0 < factor i := by
    intro i hi
    exact lt_of_lt_of_le hd (hfactor i hi)
  have hfactorNe : ∀ i ∈ s, factor i ≠ 0 := by
    intro i hi
    exact ne_of_gt (hfactorPos i hi)
  have hprodPos : 0 < ∏ i ∈ s, factor i :=
    Finset.prod_pos hfactorPos
  have hPhiPos : 0 < Phi := by
    exact lt_of_lt_of_le (pow_pos hprodPos 2) hsquare
  constructor
  · rw [Real.log_prod hfactorNe]
    calc
      (s.card : ℝ) * Real.log (d + 1) =
          ∑ _i ∈ s, Real.log (d + 1) := by simp
      _ ≤ ∑ i ∈ s, Real.log (factor i) := by
        exact Finset.sum_le_sum fun i hi =>
          Real.strictMonoOn_log.monotoneOn hd (hfactorPos i hi)
            (hfactor i hi)
  · have hlogSquare :
        Real.log ((∏ i ∈ s, factor i) ^ 2) ≤ Real.log Phi :=
      Real.strictMonoOn_log.monotoneOn (pow_pos hprodPos 2) hPhiPos hsquare
    rw [Real.log_pow] at hlogSquare
    norm_num at hlogSquare ⊢
    linarith

#print axioms repeatedSupport_card_log_budget

/-- Combining a transition mass/cardinality lower bound with a total
square-budget upper bound.  The conclusion is written without dividing by
the total cardinality, so it remains meaningful when the support is empty. -/
theorem transitionCard_fixedFraction_of_squareBudget
    {ι : Type*} (transition support : Finset ι) (weight : ι → ℝ)
    {mass cap floor phiLog : ℝ}
    (_hsubset : transition ⊆ support)
    (hmassNonneg : 0 ≤ mass)
    (hcapPos : 0 < cap)
    (hfloorPos : 0 < floor)
    (hphiLogPos : 0 < phiLog)
    (hweight : ∀ x ∈ transition, 0 ≤ weight x)
    (hcap : ∀ x ∈ transition, weight x ≤ cap)
    (hmass : mass ≤ ∑ x ∈ transition, weight x)
    (hsupportBudget : (support.card : ℝ) * floor ≤ phiLog / 2) :
    (2 * mass * floor / (cap * phiLog)) * (support.card : ℝ) ≤
      (transition.card : ℝ) := by
  have htransitionLower :
      mass / cap ≤ (transition.card : ℝ) :=
    transitionCard_lowerBound_of_mass transition weight hweight hcapPos hcap hmass
  have htwoFloorPos : 0 < 2 * floor := mul_pos (by norm_num) hfloorPos
  have hsupportUpper :
      (support.card : ℝ) ≤ phiLog / (2 * floor) := by
    apply (le_div_iff₀ htwoFloorPos).2
    nlinarith
  have hfractionNonneg :
      0 ≤ 2 * mass * floor / (cap * phiLog) := by
    positivity
  have hidentity :
      (2 * mass * floor / (cap * phiLog)) *
          (phiLog / (2 * floor)) = mass / cap := by
    field_simp
  calc
    (2 * mass * floor / (cap * phiLog)) * (support.card : ℝ) ≤
        (2 * mass * floor / (cap * phiLog)) *
          (phiLog / (2 * floor)) :=
      mul_le_mul_of_nonneg_left hsupportUpper hfractionNonneg
    _ = mass / cap := hidentity
    _ ≤ (transition.card : ℝ) := htransitionLower

#print axioms transitionCard_fixedFraction_of_squareBudget

/-- Exact finite algebraic form of the paper's ambient square-budget ratio.
Here `phiLog / (2 * floor)` is the explicit real budget `B`; unlike
`transitionCard_fixedFraction_of_squareBudget`, the denominator is this
ambient cap rather than the cardinality of the realized support. -/
theorem transitionCard_fixedFraction_of_ambientSquareBudget
    {ι : Type*} (transition : Finset ι) (weight : ι → ℝ)
    {mass cap floor phiLog : ℝ}
    (_hmassNonneg : 0 ≤ mass)
    (hcapPos : 0 < cap)
    (hfloorPos : 0 < floor)
    (hphiLogPos : 0 < phiLog)
    (hweight : ∀ x ∈ transition, 0 ≤ weight x)
    (hcap : ∀ x ∈ transition, weight x ≤ cap)
    (hmass : mass ≤ ∑ x ∈ transition, weight x) :
    2 * mass * floor / (cap * phiLog) ≤
      (transition.card : ℝ) / (phiLog / (2 * floor)) := by
  have htransitionLower :
      mass / cap ≤ (transition.card : ℝ) :=
    transitionCard_lowerBound_of_mass transition weight hweight hcapPos hcap hmass
  have hbudgetPos : 0 < phiLog / (2 * floor) := by positivity
  apply (le_div_iff₀ hbudgetPos).2
  calc
    (2 * mass * floor / (cap * phiLog)) *
        (phiLog / (2 * floor)) = mass / cap := by field_simp
    _ ≤ (transition.card : ℝ) := htransitionLower

#print axioms transitionCard_fixedFraction_of_ambientSquareBudget

end MersenneWieferichTailReduction20260901
end IUTThreeClosures
