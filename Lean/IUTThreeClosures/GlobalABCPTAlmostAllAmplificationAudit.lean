/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Order.Monoid.Unbundled.Pow
import Mathlib.Data.Real.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.Ring

/-!
# Scalar audit for PT transfer versus exceptional-count bounds

This file formalizes only two elementary pieces of
`GLOBAL_ABC_PT_ALMOST_ALL_AMPLIFICATION_AUDIT.md`:

* an unbounded upper envelope is logically compatible with an unbounded
  monotone exceptional-count function, and a doubly exponential sequence of
  possible bad heights is strictly increasing and unbounded;
* the fixed Pythagorean transfer forces a target exponent above `3/4`, while
  each published scalar exceptional exponent used in the audit is above the
  `1/2` capacity exponent of the whole squared-Pythagorean locus.

No analytic exceptional-set theorem, Pythagorean counting asymptotic, Dickman
estimate, or statement of the abc conjecture is assumed or formalized here.
-/

namespace IUTThreeClosures

section AbstractExceptionalCount

/-- A natural-valued counting function is unbounded. -/
def UnboundedExceptionalCount (E : ℕ → ℕ) : Prop :=
  ∀ M : ℕ, ∃ X : ℕ, M < E X

/-- An envelope is compatible with a monotone, unbounded count below it. -/
def CompatibleWithInfiniteExceptionalCount (B : ℕ → ℕ) : Prop :=
  ∃ E : ℕ → ℕ,
    Monotone E ∧
    (∀ X : ℕ, E X ≤ B X) ∧
    UnboundedExceptionalCount E

/-- Any monotone unbounded upper envelope is itself a witness that the upper
bound alone does not imply finiteness. -/
theorem unboundedEnvelope_compatibleWithInfiniteExceptionalCount
    (B : ℕ → ℕ) (hmono : Monotone B)
    (hunbounded : UnboundedExceptionalCount B) :
    CompatibleWithInfiniteExceptionalCount B := by
  exact ⟨B, hmono, fun _ ↦ le_rfl, hunbounded⟩

/-- A concrete, deliberately lacunary sequence of possible bad heights. -/
def lacunaryBadHeight (n : ℕ) : ℕ :=
  2 ^ (2 ^ n)

/-- A predicate has infinitely many bad heights when it contains the range of
a strictly increasing height sequence. -/
def HasInfiniteBadHeightWitness (Bad : ℕ → Prop) : Prop :=
  ∃ H : ℕ → ℕ, StrictMono H ∧ ∀ n : ℕ, Bad (H n)

/-- The concrete predicate selecting the doubly exponential heights. -/
def LacunaryBadAt (X : ℕ) : Prop :=
  ∃ n : ℕ, X = lacunaryBadHeight n

/-- Powers of two are strictly increasing on natural exponents. -/
private theorem twoPow_strictMono : StrictMono (fun n : ℕ ↦ 2 ^ n) := by
  apply strictMono_nat_of_lt_succ
  intro n
  rw [pow_succ, mul_two]
  exact lt_add_of_pos_right _ (by positivity)

/-- The lacunary height sequence has no repetitions and is ordered by its
index. -/
theorem lacunaryBadHeight_strictMono : StrictMono lacunaryBadHeight := by
  exact twoPow_strictMono.comp twoPow_strictMono

/-- The doubly exponential support is an explicit infinite bad-height
witness, independently of how slowly its prefix count grows. -/
theorem lacunaryBadAt_hasInfiniteBadHeightWitness :
    HasInfiniteBadHeightWitness LacunaryBadAt := by
  exact ⟨lacunaryBadHeight, lacunaryBadHeight_strictMono,
    fun n ↦ ⟨n, rfl⟩⟩

/-- The lacunary height sequence is unbounded. -/
theorem lacunaryBadHeight_unbounded :
    UnboundedExceptionalCount lacunaryBadHeight := by
  intro M
  refine ⟨M, ?_⟩
  exact M.lt_two_pow_self.trans
    (twoPow_strictMono M.lt_two_pow_self)

/-- A bounded per-seed production estimate only scales a source count by its
multiplicity bound.  This is deliberately a one-line cardinality surrogate;
it supplies no positive-power lower bound. -/
theorem boundedProduction_preservesEnvelope
    (source output envelope : ℕ → ℕ) (K : ℕ)
    (houtput : ∀ X : ℕ, output X ≤ K * source X)
    (hsource : ∀ X : ℕ, source X ≤ envelope X) :
    ∀ X : ℕ, output X ≤ K * envelope X := by
  intro X
  exact (houtput X).trans (Nat.mul_le_mul_left K (hsource X))

end AbstractExceptionalCount

section PythagoreanExponentLedger

/-- A source radical exponent `lambda` in `(0,1)` transfers through the fixed
Pythagorean construction at the threshold `(lambda+3)/4`, which lies strictly
between `3/4` and `1`. -/
theorem fixedPythagorean_transferredExponent_window
    (lam : ℝ) (hlam0 : 0 < lam) (hlam1 : lam < 1) :
    (3 : ℝ) / 4 < (lam + 3) / 4 ∧ (lam + 3) / 4 < 1 := by
  constructor <;> linarith

/-- At every exponent permitted by the fixed-Pythagorean radical transfer,
the current `(23*mu+3)/40` exponent and the refined `3/5` exponent are both
strictly above the `1/2` capacity exponent of the full squared-Pythagorean
locus.  This is a scalar comparison only. -/
theorem currentExceptionalExponent_above_fixedPythagoreanCapacity
    (lam mu : ℝ) (hlam0 : 0 < lam) (hmu : (lam + 3) / 4 < mu) :
    (1 : ℝ) / 2 < min ((3 : ℝ) / 5) ((23 * mu + 3) / 40) := by
  have hmu34 : (3 : ℝ) / 4 < mu := by
    linarith
  apply lt_min
  · norm_num
  · linarith

/-- Under quartic target-height dilation, an exponent strictly above `1/2`
becomes a source-height exponent strictly above the trivial quadratic source
capacity. -/
theorem fixedPythagorean_quarticHeightExponent_mismatch
    (lam mu : ℝ) (hlam0 : 0 < lam) (hmu : (lam + 3) / 4 < mu) :
    (2 : ℝ) < 4 * min ((3 : ℝ) / 5) ((23 * mu + 3) / 40) := by
  have hgap :=
    currentExceptionalExponent_above_fixedPythagoreanCapacity lam mu hlam0 hmu
  linarith

/-- The original three-author `33/50` exponent exceeds the target-locus
capacity exponent `1/2`. -/
theorem originalBLTExponent_above_fixedPythagoreanCapacity :
    (1 : ℝ) / 2 < 33 / 50 := by
  norm_num

/-- Lichtman's headline `2/3` exponent exceeds the target-locus capacity
exponent `1/2`. -/
theorem lichtmanExponent_above_fixedPythagoreanCapacity :
    (1 : ℝ) / 2 < 2 / 3 := by
  norm_num

/-- The de Bruijn-type `2*mu/3` exponent is also above `1/2` throughout the
fixed-Pythagorean transfer range `mu>3/4`. -/
theorem deBruijnExponent_above_fixedPythagoreanCapacity
    (mu : ℝ) (hmu : (3 : ℝ) / 4 < mu) :
    (1 : ℝ) / 2 < 2 * mu / 3 := by
  linarith

/-- The moving-`D` transfer threshold lies strictly between `1/2` and `1`. -/
theorem movingD_transferredExponent_window
    (lam : ℝ) (hlam0 : 0 < lam) (hlam1 : lam < 1) :
    (1 : ℝ) / 2 < (lam + 1) / 2 ∧ (lam + 1) / 2 < 1 := by
  constructor <;> linarith

/-- Quadratic target-height dilation changes the `3/5` count exponent to
`6/5`, strictly worsening the direct `3/5` source-height bound. -/
theorem movingD_quadraticHeight_worsensThreeFifths :
    (3 : ℝ) / 5 < 2 * ((3 : ℝ) / 5) := by
  norm_num

/-- With the current affine exponent formula, transferring through moving
`D` loses exactly `26/40` in source-height exponent at the limiting transfer
threshold. -/
theorem movingD_affineExponent_exactLoss (lam : ℝ) :
    (23 * lam + 29) / 40 - (23 * lam + 3) / 40 = (26 : ℝ) / 40 := by
  ring

end PythagoreanExponentLedger

end IUTThreeClosures
