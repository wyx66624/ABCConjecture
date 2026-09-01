/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EndpointBalanceCoefficientTransfer
import Mathlib.Data.Nat.Log

/-!
# Subcritical-locus uniformity and the exact counting-to-abc gate

The mathematical proofs were written first in
`research/ABC_SUBCRITICAL_LOCUS_UNIFORMITY_2026_08_31.md`.

This file proves that the unchanged logarithmic `ABCConjecture` is equivalent
to uniform height boundedness on every fixed locus

`conductor ≤ μ * height`, with `0 ≤ μ < 1`.

It also records the finite-cardinality threshold needed to turn counting into
a pointwise theorem, the overlap-free single-source fibre argument, and an
explicit super-sparse sequence whose consecutive heights are related by
squaring.  No analytic counting theorem or arithmetic amplifier is assumed.
-/

namespace IUTThreeClosures
namespace ABCSubcriticalLocusUniformity20260831

noncomputable section

/-- Every fixed subcritical radical-slope locus has uniformly bounded height.
The bound may depend on `μ`, but not on the abc point or its prime support. -/
def SubcriticalLociHaveBoundedHeight : Prop :=
  ∀ μ : ℝ, 0 ≤ μ → μ < 1 →
    ∃ B : ℝ, ∀ P : ABCPoint,
      P.conductor ≤ μ * P.height → P.height ≤ B

/-- The standard abc conjecture uniformly bounds every fixed subcritical
radical locus. -/
theorem subcriticalLociHaveBoundedHeight_of_abcConjecture
    (habc : ABCConjecture) :
    SubcriticalLociHaveBoundedHeight := by
  intro μ hμ0 hμ1
  let η : ℝ := (1 - μ) / 2
  have hη : 0 < η := by
    dsimp [η]
    linarith
  obtain ⟨C, hC⟩ := habc η hη
  let gap : ℝ := 1 - (1 + η) * μ
  have hfactor : 0 < (1 - μ) * (2 - μ) := by
    exact mul_pos (sub_pos.mpr hμ1) (by linarith)
  have hgap : 0 < gap := by
    dsimp [gap, η]
    nlinarith
  refine ⟨C / gap, ?_⟩
  intro P hsubcritical
  have habcP :
      P.height ≤ (1 + η) * P.conductor + C := by
    simpa [ABCPoint.height, ABCPoint.conductor] using
      hC P.a P.b P.c P.a_pos P.b_pos P.c_pos P.sum_eq
        P.pairwise_coprime
  have hcoefficient : 0 ≤ 1 + η := by linarith
  have hscaled :
      (1 + η) * P.conductor ≤
        (1 + η) * (μ * P.height) :=
    mul_le_mul_of_nonneg_left hsubcritical hcoefficient
  apply (le_div_iff₀ hgap).2
  dsimp [gap]
  nlinarith

/-- Uniform boundedness of all fixed subcritical radical loci implies the
unchanged standard logarithmic abc conjecture. -/
theorem abcConjecture_of_subcriticalLociHaveBoundedHeight
    (hsub : SubcriticalLociHaveBoundedHeight) :
    ABCConjecture := by
  intro ε hε
  let μ : ℝ := 1 / (1 + ε)
  have hden : 0 < 1 + ε := by linarith
  have hμ0 : 0 ≤ μ := by
    dsimp [μ]
    positivity
  have hμ1 : μ < 1 := by
    dsimp [μ]
    rw [div_lt_one hden]
    linarith
  have hnormalize : (1 + ε) * μ = 1 := by
    dsimp [μ]
    field_simp
  obtain ⟨B, hB⟩ := hsub μ hμ0 hμ1
  refine ⟨max B 0, ?_⟩
  intro a b c ha hb hc hab hcoprime
  let P : ABCPoint :=
    { a := a
      b := b
      c := c
      a_pos := ha
      b_pos := hb
      c_pos := hc
      sum_eq := hab
      pairwise_coprime := hcoprime }
  have hconductor : 0 ≤ P.conductor := P.conductor_nonneg
  have hconstant : 0 ≤ max B 0 := le_max_right B 0
  have hcoefficient : 0 < 1 + ε := hden
  have hpoint :
      P.height ≤ (1 + ε) * P.conductor + max B 0 := by
    by_cases hlow : P.conductor ≤ μ * P.height
    · have hheight : P.height ≤ B := hB P hlow
      have hBmax : B ≤ max B 0 := le_max_left B 0
      have hterm : 0 ≤ (1 + ε) * P.conductor :=
        mul_nonneg hcoefficient.le hconductor
      linarith
    · have hhigh : μ * P.height < P.conductor := lt_of_not_ge hlow
      have hscaled :
          (1 + ε) * (μ * P.height) <
            (1 + ε) * P.conductor :=
        mul_lt_mul_of_pos_left hhigh hcoefficient
      have hstrict : P.height < (1 + ε) * P.conductor := by
        rw [← mul_assoc, hnormalize, one_mul] at hscaled
        exact hscaled
      linarith
  simpa [P, ABCPoint.height, ABCPoint.conductor] using hpoint

/-- Exact equivalence with the unchanged standard target. -/
theorem abcConjecture_iff_subcriticalLociHaveBoundedHeight :
    ABCConjecture ↔ SubcriticalLociHaveBoundedHeight :=
  ⟨subcriticalLociHaveBoundedHeight_of_abcConjecture,
    abcConjecture_of_subcriticalLociHaveBoundedHeight⟩

/-! ## Integer thresholds and pointwise amplification -/

/-- A finite shell whose real-valued cardinality is strictly below one is
empty.  This is the final integer step in a decaying-shell argument. -/
theorem finset_eq_empty_of_card_cast_lt_one
    {α : Type*} (s : Finset α)
    (hsmall : (s.card : ℝ) < 1) :
    s = ∅ := by
  have hnat : s.card < 1 := by exact_mod_cast hsmall
  rw [← Finset.card_eq_zero]
  omega

/-- One source fibre contained in a counted target set cannot be larger than
the entire target set.  No overlap information about other fibres occurs. -/
theorem pointwise_fiber_card_le_target
    {α : Type*}
    (fiber target : Finset α) (hsubset : fiber ⊆ target) :
    fiber.card ≤ target.card :=
  Finset.card_le_card hsubset

/-- If every alleged source has a fibre contained in the target set but
strictly larger than that set, there are no sources.  This is the
single-source amplification principle; cross-source multiplicities are
irrelevant. -/
theorem sources_eq_empty_of_pointwise_oversized_fiber
    {Source Target : Type*}
    (sources : Finset Source) (targets : Finset Target)
    (fiber : Source → Finset Target)
    (hsubset : ∀ s ∈ sources, fiber s ⊆ targets)
    (hoversized : ∀ s ∈ sources, targets.card < (fiber s).card) :
    sources = ∅ := by
  classical
  apply Finset.eq_empty_iff_forall_notMem.mpr
  intro s hs
  have hle : (fiber s).card ≤ targets.card :=
    Finset.card_le_card (hsubset s hs)
  exact (not_lt_of_ge hle) (hoversized s hs)

/-- Logarithmic exponent arithmetic behind the amplification threshold
`β > κθ`: if the fibre lower bound is dominated by the target count, then the
source height is uniformly bounded. -/
theorem height_le_of_amplification_log_count
    {height logConstant β κ θ : ℝ}
    (hgap : κ * θ < β)
    (hcount : β * height ≤ logConstant + (κ * θ) * height) :
    height ≤ logConstant / (β - κ * θ) := by
  have hden : 0 < β - κ * θ := sub_pos.mpr hgap
  apply (le_div_iff₀ hden).2
  nlinarith

/-! ## A strict sparse-gap countermodel -/

/-- Double-exponential toy heights used to separate gap principles from
eventual finiteness. -/
def superSparseHeight (n : ℕ) : ℕ :=
  2 ^ (2 ^ n)

/-- The next toy height is exactly the square of the preceding height. -/
theorem superSparseHeight_succ (n : ℕ) :
    superSparseHeight (n + 1) = superSparseHeight n ^ 2 := by
  unfold superSparseHeight
  rw [pow_succ, pow_mul]

/-- The toy heights are strictly increasing. -/
theorem superSparseHeight_strictMono : StrictMono superSparseHeight := by
  intro m n hmn
  unfold superSparseHeight
  exact Nat.pow_lt_pow_right (by decide)
    (Nat.pow_lt_pow_right (by decide) hmn)

/-- All indices whose toy height is at most `X`.  The iterated-log range is
proved below to contain every possible index, so this is an exhaustive finite
count rather than a truncation. -/
def superSparseIndicesUpTo (X : ℕ) : Finset ℕ :=
  (Finset.range (Nat.log 2 (Nat.log 2 X) + 1)).filter
    (fun n => superSparseHeight n ≤ X)

/-- Membership in the finite count is exactly the height cutoff. -/
theorem mem_superSparseIndicesUpTo {X n : ℕ} :
    n ∈ superSparseIndicesUpTo X ↔ superSparseHeight n ≤ X := by
  constructor
  · intro hn
    exact (Finset.mem_filter.mp hn).2
  · intro hheight
    have hinner : 2 ^ n ≤ Nat.log 2 X := by
      apply Nat.le_log_of_pow_le (by decide)
      simpa [superSparseHeight] using hheight
    have hnlog : n ≤ Nat.log 2 (Nat.log 2 X) :=
      Nat.le_log_of_pow_le (by decide) hinner
    apply Finset.mem_filter.mpr
    refine ⟨?_, hheight⟩
    simpa using hnlog

/-- Exact iterated-log upper bound for the cumulative sparse count. -/
theorem superSparseIndicesUpTo_card_le_log_log (X : ℕ) :
    (superSparseIndicesUpTo X).card ≤
      Nat.log 2 (Nat.log 2 X) + 1 := by
  unfold superSparseIndicesUpTo
  simpa using Finset.card_filter_le
    (Finset.range (Nat.log 2 (Nat.log 2 X) + 1))
    (fun n => superSparseHeight n ≤ X)

/-- The square of the index count at the `N`-th height is at most that
height. -/
theorem index_succ_sq_le_superSparseHeight (N : ℕ) :
    (N + 1) ^ 2 ≤ superSparseHeight N := by
  induction N with
  | zero => norm_num [superSparseHeight]
  | succ n ih =>
      rw [superSparseHeight_succ]
      by_cases hn : n = 0
      · subst n
        norm_num [superSparseHeight]
      · have hnpos : 1 ≤ n := Nat.one_le_iff_ne_zero.mpr hn
        have haux : n + 2 ≤ (n + 1) ^ 2 := by nlinarith
        have hle : n + 2 ≤ superSparseHeight n := haux.trans ih
        simpa [Nat.succ_eq_add_one, Nat.add_assoc] using
          Nat.pow_le_pow_left hle 2

/-- A genuine positive power saving: for every cutoff `X ≥ 2`, the square of
the number of toy heights up to `X` is at most `X`.  The family remains
infinite, so such a power saving does not imply eventual emptiness. -/
theorem superSparseIndicesUpTo_card_sq_le
    (X : ℕ) (hX : 2 ≤ X) :
    (superSparseIndicesUpTo X).card ^ 2 ≤ X := by
  let N : ℕ := Nat.log 2 (Nat.log 2 X)
  have hcount : (superSparseIndicesUpTo X).card ≤ N + 1 := by
    simpa [N] using superSparseIndicesUpTo_card_le_log_log X
  have hcountSq :
      (superSparseIndicesUpTo X).card ^ 2 ≤ (N + 1) ^ 2 :=
    Nat.pow_le_pow_left hcount 2
  have hlogpos : Nat.log 2 X ≠ 0 := by
    exact Nat.ne_of_gt ((Nat.log_pos_iff).2 ⟨hX, by decide⟩)
  have hXne : X ≠ 0 := by omega
  have hinner : 2 ^ N ≤ Nat.log 2 X := by
    dsimp [N]
    exact Nat.pow_le_of_le_log hlogpos le_rfl
  have hheight : superSparseHeight N ≤ X := by
    unfold superSparseHeight
    exact Nat.pow_le_of_le_log hXne hinner
  exact hcountSq.trans (index_succ_sq_le_superSparseHeight N |>.trans hheight)

/-- The first `N+1` distinct toy heights. -/
def superSparsePrefix (N : ℕ) : Finset ℕ :=
  (Finset.range (N + 1)).image superSparseHeight

/-- The prefix really contains `N+1` different heights. -/
theorem superSparsePrefix_card (N : ℕ) :
    (superSparsePrefix N).card = N + 1 := by
  unfold superSparsePrefix
  rw [Finset.card_image_of_injective _
    superSparseHeight_strictMono.injective]
  simp

/-- Every member of the prefix lies below its final height. -/
theorem superSparsePrefix_le_final {N x : ℕ}
    (hx : x ∈ superSparsePrefix N) :
    x ≤ superSparseHeight N := by
  obtain ⟨n, hn, rfl⟩ := Finset.mem_image.mp hx
  have hnN : n ≤ N := by
    simpa using hn
  exact superSparseHeight_strictMono.monotone hnN

/-- Prefix cardinalities are unbounded despite the exact square-gap law. -/
theorem superSparsePrefix_card_unbounded (M : ℕ) :
    ∃ N : ℕ, M < (superSparsePrefix N).card := by
  refine ⟨M, ?_⟩
  rw [superSparsePrefix_card]
  omega

#print axioms subcriticalLociHaveBoundedHeight_of_abcConjecture
#print axioms abcConjecture_of_subcriticalLociHaveBoundedHeight
#print axioms abcConjecture_iff_subcriticalLociHaveBoundedHeight
#print axioms finset_eq_empty_of_card_cast_lt_one
#print axioms sources_eq_empty_of_pointwise_oversized_fiber
#print axioms height_le_of_amplification_log_count
#print axioms superSparseHeight_succ
#print axioms mem_superSparseIndicesUpTo
#print axioms superSparseIndicesUpTo_card_le_log_log
#print axioms superSparseIndicesUpTo_card_sq_le
#print axioms superSparsePrefix_card
#print axioms superSparsePrefix_card_unbounded

end
end ABCSubcriticalLocusUniformity20260831
end IUTThreeClosures
