/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineAdaptiveCommonKernel20260901
import Mathlib.Combinatorics.Pigeonhole

/-!
# Common-kernel triple selection in the affine route

The mathematical proofs precede this module in
`research/ABC_AFFINE_COMMON_KERNEL_TRIPLE_SELECTION_2026_09_01.md`.

This file proves the integer-line cap, turns actual shared arm divisors into
a large-label fibre and incidence bound, formalizes the exact third-gcd
totient-energy expansion, and checks both an actual box-wide collinear
counterexample and an explicitly abstract pointwise-overlap model.  It
assumes no common-kernel density estimate and proves no abc statement.
-/

namespace IUTThreeClosures
namespace AffineCommonKernelTripleSelection20260901

open scoped BigOperators
open AffineTemplateEntropy20260901
open AffineAdaptiveCommonKernel20260901

/-- One actual divisor selected from each of the three affine arms. -/
structure ArmDivisorLabel where
  u : ℕ
  v : ℕ
  w : ℕ
deriving DecidableEq

namespace ArmDivisorLabel

/-- Product that enters the adaptive determinant obstruction. -/
def product (label : ArmDivisorLabel) : ℕ :=
  label.u * label.v * label.w

/-- The exact pairwise-coprimality condition on a label. -/
def PairwiseCoprime (label : ArmDivisorLabel) : Prop :=
  Nat.Coprime label.u label.v ∧ Nat.Coprime label.u label.w ∧
    Nat.Coprime label.v label.w

end ArmDivisorLabel

/-- Points of `S` at which every component of `label` divides its
corresponding affine arm. -/
noncomputable def labelFiber (S : Finset (ℕ × ℕ)) (R B C : ℕ)
    (label : ArmDivisorLabel) : Finset (ℕ × ℕ) := by
  classical
  exact S.filter fun p ↦ armDivisorsAt R B C p label.u label.v label.w

/-- Number of labels in a finite catalogue incident to one affine point. -/
noncomputable def incidentLabelCount
    (labels : Finset ArmDivisorLabel) (R B C : ℕ) (p : ℕ × ℕ) : ℕ := by
  classical
  exact (labels.filter fun label ↦
    armDivisorsAt R B C p label.u label.v label.w).card

@[simp] theorem mem_labelFiber_iff
    {S : Finset (ℕ × ℕ)} {R B C : ℕ}
    {label : ArmDivisorLabel} {p : ℕ × ℕ} :
    p ∈ labelFiber S R B C label ↔
      p ∈ S ∧ armDivisorsAt R B C p label.u label.v label.w := by
  classical
  simp [labelFiber]

/-! ## The sharp integer-line cap -/

/-- More than `M` lattice points in the positive square `[1,M]^2` contain
a noncollinear triple.  Equivalently, every collinear subset has at most
`M` points. -/
theorem exists_noncollinear_triple_of_side_lt_card
    (S : Finset (ℕ × ℕ)) {M : ℕ}
    (hbox : ∀ p ∈ S,
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M)
    (hcard : M < S.card) :
    ∃ p ∈ S, ∃ q ∈ S, ∃ r ∈ S, natTriangleDet p q r ≠ 0 := by
  by_contra hno
  push Not at hno
  have hSpos : 0 < S.card := lt_of_le_of_lt (Nat.zero_le M) hcard
  obtain ⟨p, hp⟩ := Finset.card_pos.mp hSpos
  have hMpos : 0 < M := by
    have := hbox p hp
    omega
  have htwo : 1 < S.card := by omega
  obtain ⟨p, hp, q, hq, hpq⟩ := Finset.one_lt_card.mp htwo
  by_cases hx : p.1 = q.1
  · have hp2q2 : p.2 ≠ q.2 := by
      intro hy
      apply hpq
      exact Prod.ext hx hy
    have hvertical : ∀ r ∈ S, r.1 = p.1 := by
      intro r hr
      have hdet := hno p hp q hq r hr
      have hq1z : (q.1 : ℤ) - p.1 = 0 := by omega
      have hmul :
          ((q.2 : ℤ) - p.2) * ((r.1 : ℤ) - p.1) = 0 := by
        simp only [natTriangleDet, hq1z, zero_mul, zero_sub] at hdet
        exact neg_eq_zero.mp hdet
      rcases mul_eq_zero.mp hmul with hq2z | hr1z
      · have hbad : p.2 = q.2 := by omega
        exact (hp2q2 hbad).elim
      · omega
    let cells : Finset ℕ := Finset.range M
    have hmaps : Set.MapsTo (fun r : ℕ × ℕ ↦ r.2 - 1)
        (S : Set (ℕ × ℕ)) (cells : Set ℕ) := by
      intro r hr
      rw [Finset.mem_coe, Finset.mem_range]
      change r.2 - 1 < M
      have hb := hbox r hr
      omega
    have hinj : Set.InjOn (fun r : ℕ × ℕ ↦ r.2 - 1)
        (S : Set (ℕ × ℕ)) := by
      intro r hr s hs heq
      change r.2 - 1 = s.2 - 1 at heq
      apply Prod.ext
      · exact (hvertical r hr).trans (hvertical s hs).symm
      · have hrb := hbox r hr
        have hsb := hbox s hs
        omega
    have hle := Finset.card_le_card_of_injOn
      (fun r : ℕ × ℕ ↦ r.2 - 1) hmaps hinj
    have : S.card ≤ M := by simpa [cells] using hle
    omega
  · have hinjCoord : Set.InjOn (fun r : ℕ × ℕ ↦ r.1 - 1)
        (S : Set (ℕ × ℕ)) := by
      intro r hr s hs heq
      change r.1 - 1 = s.1 - 1 at heq
      have hrb := hbox r hr
      have hsb := hbox s hs
      have hrs1 : r.1 = s.1 := by omega
      have hdr := hno p hp q hq r hr
      have hds := hno p hp q hq s hs
      have hmul :
          ((q.1 : ℤ) - p.1) * ((r.2 : ℤ) - s.2) = 0 := by
        simp only [natTriangleDet] at hdr hds
        have hrs1z : (r.1 : ℤ) = s.1 := by exact_mod_cast hrs1
        rw [hrs1z] at hdr
        nlinarith
      have hq1z : (q.1 : ℤ) - p.1 ≠ 0 := by
        exact sub_ne_zero.mpr (by
          exact_mod_cast (fun h : q.1 = p.1 ↦ hx h.symm))
      have hrs2z : (r.2 : ℤ) - s.2 = 0 :=
        (mul_eq_zero.mp hmul).resolve_left hq1z
      have hrs2 : r.2 = s.2 := by omega
      exact Prod.ext hrs1 hrs2
    let cells : Finset ℕ := Finset.range M
    have hmaps : Set.MapsTo (fun r : ℕ × ℕ ↦ r.1 - 1)
        (S : Set (ℕ × ℕ)) (cells : Set ℕ) := by
      intro r hr
      rw [Finset.mem_coe, Finset.mem_range]
      change r.1 - 1 < M
      have hb := hbox r hr
      omega
    have hle := Finset.card_le_card_of_injOn
      (fun r : ℕ × ℕ ↦ r.1 - 1) hmaps hinjCoord
    have : S.card ≤ M := by simpa [cells] using hle
    omega

#print axioms exists_noncollinear_triple_of_side_lt_card

/-! ## Actual labels and the adaptive interface -/

/-- Using one identical actual arm-divisor label at three points specializes
the gcd construction to that label and produces the exact six congruences. -/
theorem sameLabel_gives_adaptiveInterface
    {R B C : ℕ} {p q r : ℕ × ℕ} {label : ArmDivisorLabel}
    (hp : armDivisorsAt R B C p label.u label.v label.w)
    (hq : armDivisorsAt R B C q label.u label.v label.w)
    (hr : armDivisorsAt R B C r label.u label.v label.w)
    (hUVp : Nat.Coprime (affineU R p) (affineV R C p))
    (hUWp : Nat.Coprime (affineU R p) (affineW R B p))
    (hVWp : Nat.Coprime (affineV R C p) (affineW R B p)) :
    label.PairwiseCoprime ∧
      (label.u : ℤ) ∣ (natPointDiff q p).1 ∧
      (label.v : ℤ) ∣ (natPointDiff q p).1 +
        (C : ℤ) * (natPointDiff q p).2 ∧
      (label.w : ℤ) ∣ (natPointDiff q p).1 +
        (B : ℤ) * (natPointDiff q p).2 ∧
      (label.u : ℤ) ∣ (natPointDiff r p).1 ∧
      (label.v : ℤ) ∣ (natPointDiff r p).1 +
        (C : ℤ) * (natPointDiff r p).2 ∧
      (label.w : ℤ) ∣ (natPointDiff r p).1 +
        (B : ℤ) * (natPointDiff r p).2 := by
  rcases hp with ⟨hUp, hVp, hWp⟩
  rcases hq with ⟨hUq, hVq, hWq⟩
  rcases hr with ⟨hUr, hVr, hWr⟩
  have h := triplePoint_armDivisorGcds_give_adaptiveInterface
    hUp hVp hWp hUq hVq hWq hUr hVr hWr hUVp hUWp hVWp
  simp only [threePointCommonGcd, Nat.gcd_self] at h
  rcases h with ⟨hUV, hUW, hVW, hqU, hqV, hqW, hrU, hrV, hrW⟩
  exact ⟨⟨hUV, hUW, hVW⟩, hqU, hqV, hqW, hrU, hrV, hrW⟩

#print axioms sameLabel_gives_adaptiveInterface

/-- Signed natural-coordinate differences have the same sup norm as
`pairSupDist`. -/
theorem signedSupNorm_natCast_sub_eq_pairSupDist (p q : ℕ × ℕ) :
    signedSupNorm ((p.1 : ℤ) - q.1) ((p.2 : ℤ) - q.2) =
      pairSupDist p q := by
  have hcoord (a b : ℕ) :
      ((a : ℤ) - b).natAbs = Nat.dist a b := by
    by_cases h : b ≤ a
    · rw [Int.natAbs_natCast_sub_natCast_of_ge h, Nat.dist_comm,
        Nat.dist_eq_sub_of_le h]
    · have hab : a ≤ b := Nat.le_of_not_ge h
      rw [Int.natAbs_natCast_sub_natCast_of_le hab,
        Nat.dist_eq_sub_of_le hab]
  simp only [signedSupNorm, pairSupDist, hcoord]

#print axioms mem_labelFiber_iff
#print axioms signedSupNorm_natCast_sub_eq_pairSupDist

/-- Direct fixed-label packing theorem with actual affine arm divisibility.
It composes cancellation, all four separation branches, and sup-cell
packing.  This gives a sharper fibre capacity than the line cap whenever a
label satisfies the full cubic and individual-cap thresholds. -/
theorem fixedLabel_fiber_card_le_packing
    (S : Finset (ℕ × ℕ)) {R B C M L XU XV XW : ℕ}
    (label : ArmDivisorLabel)
    (hBC : B ≤ C)
    (hbox : ∀ p ∈ S, p.1 ≤ M ∧ p.2 ≤ M)
    (hdiv : ∀ p ∈ S,
      armDivisorsAt R B C p label.u label.v label.w)
    (hpairwise : label.PairwiseCoprime)
    (hVC : Nat.Coprime label.v C) (hWB : Nat.Coprime label.w B)
    (hUC : Nat.Coprime label.u C)
    (hWCB : Nat.Coprime label.w (C - B))
    (hUB : Nat.Coprime label.u B)
    (hVCB : Nat.Coprime label.v (C - B))
    (hUcap : label.u ≤ XU) (hVcap : label.v ≤ XV)
    (hWcap : label.w ≤ XW)
    (hcubic : (C + 1) ^ 2 * L ^ 3 < label.product)
    (hUthreshold : L * XU < label.product)
    (hVthreshold : L * XV < label.product)
    (hWthreshold : L * XW < label.product) :
    S.card ≤ (M / (L + 1) + 1) ^ 2 := by
  apply supSeparated_card_le S M L hbox
  intro p hp q hq hpq
  rcases hdiv p hp with ⟨hUp, hVp, hWp⟩
  rcases hdiv q hq with ⟨hUq, hVq, hWq⟩
  have hUR : Nat.Coprime label.u R :=
    Nat.Coprime.of_dvd hUp (dvd_refl R) (by simp [affineU])
  have hVR : Nat.Coprime label.v R :=
    Nat.Coprime.of_dvd hVp (dvd_refl R) (by simp [affineV])
  have hWR : Nat.Coprime label.w R :=
    Nat.Coprime.of_dvd hWp (dvd_refl R) (by simp [affineW])
  have hdiff := affineTemplate_membership_gives_differenceDivisibilities
    hUR hVR hWR hUp hUq hVp hVq hWp hWq
  have hnonzero :
      (p.1 : ℤ) - q.1 ≠ 0 ∨ (p.2 : ℤ) - q.2 ≠ 0 := by
    by_contra hnot
    push Not at hnot
    apply hpq
    apply Prod.ext <;> omega
  have hsep := threeForm_separated_of_direct_bounds hBC hnonzero
    hpairwise.1 hpairwise.2.1 hpairwise.2.2
    hVC hWB hUC hWCB hUB hVCB
    hdiff.1 hdiff.2.1 hdiff.2.2 hUcap hVcap hWcap
    (by simpa [ArmDivisorLabel.product] using hcubic)
    (by simpa [ArmDivisorLabel.product] using hUthreshold)
    (by simpa [ArmDivisorLabel.product] using hVthreshold)
    (by simpa [ArmDivisorLabel.product] using hWthreshold)
  simpa [signedSupNorm_natCast_sub_eq_pairSupDist] using hsep

#print axioms fixedLabel_fiber_card_le_packing

/-- If one actual shared label has product larger than the sharp box-square,
its affine divisor fibre contains at most one side length of points. -/
theorem largeLabel_fiber_card_le_side
    (S : Finset (ℕ × ℕ)) {R B C M : ℕ}
    (label : ArmDivisorLabel)
    (hbox : ∀ p ∈ S,
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M)
    (harms : ∀ p ∈ S,
      Nat.Coprime (affineU R p) (affineV R C p) ∧
      Nat.Coprime (affineU R p) (affineW R B p) ∧
      Nat.Coprime (affineV R C p) (affineW R B p))
    (hlarge : (M - 1) ^ 2 < label.product) :
    (labelFiber S R B C label).card ≤ M := by
  by_contra hnot
  have hcard : M < (labelFiber S R B C label).card :=
    Nat.lt_of_not_ge hnot
  have hfiberBox : ∀ p ∈ labelFiber S R B C label,
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M := by
    intro p hp
    exact hbox p (mem_labelFiber_iff.mp hp).1
  obtain ⟨p, hp, q, hq, r, hr, hdet⟩ :=
    exists_noncollinear_triple_of_side_lt_card
      (labelFiber S R B C label) hfiberBox hcard
  have hpData := mem_labelFiber_iff.mp hp
  have hqData := mem_labelFiber_iff.mp hq
  have hrData := mem_labelFiber_iff.mp hr
  have hinterface := sameLabel_gives_adaptiveInterface
    hpData.2 hqData.2 hrData.2
    (harms p hpData.1).1 (harms p hpData.1).2.1
      (harms p hpData.1).2.2
  have hbound := adaptive_commonModulusProduct_le_boxSq_of_noncollinear
    (hbox p hpData.1) (hbox q hqData.1) (hbox r hrData.1)
    hinterface.1.1 hinterface.1.2.1 hinterface.1.2.2
    hinterface.2.1 hinterface.2.2.1 hinterface.2.2.2.1
    hinterface.2.2.2.2.1 hinterface.2.2.2.2.2.1
    hinterface.2.2.2.2.2.2 hdet
  change label.u * label.v * label.w ≤ (M - 1) ^ 2 at hbound
  simpa [ArmDivisorLabel.product] using (not_lt_of_ge hbound hlarge)

#print axioms largeLabel_fiber_card_le_side

/-- Summed point-label incidence budget for any finite family of labels whose
products all exceed the box-square. -/
theorem largeLabel_incidenceBudget
    (S : Finset (ℕ × ℕ)) (labels : Finset ArmDivisorLabel)
    {R B C M : ℕ}
    (hbox : ∀ p ∈ S,
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M)
    (harms : ∀ p ∈ S,
      Nat.Coprime (affineU R p) (affineV R C p) ∧
      Nat.Coprime (affineU R p) (affineW R B p) ∧
      Nat.Coprime (affineV R C p) (affineW R B p))
    (hlarge : ∀ label ∈ labels, (M - 1) ^ 2 < label.product) :
    ∑ label ∈ labels, (labelFiber S R B C label).card ≤
      labels.card * M := by
  calc
    ∑ label ∈ labels, (labelFiber S R B C label).card ≤
        ∑ _label ∈ labels, M := by
      exact Finset.sum_le_sum fun label hlabel ↦
        largeLabel_fiber_card_le_side S label hbox harms
          (hlarge label hlabel)
    _ = labels.card * M := by simp

#print axioms largeLabel_incidenceBudget

/-- Multiplicity form of the incidence budget.  If every point is incident
to at least `mu` large actual arm-divisor labels, then
`mu * point count ≤ side * label count`. -/
theorem largeLabel_incidenceMultiplicity_bound
    (S : Finset (ℕ × ℕ)) (labels : Finset ArmDivisorLabel)
    {R B C M mu : ℕ}
    (hbox : ∀ p ∈ S,
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M)
    (harms : ∀ p ∈ S,
      Nat.Coprime (affineU R p) (affineV R C p) ∧
      Nat.Coprime (affineU R p) (affineW R B p) ∧
      Nat.Coprime (affineV R C p) (affineW R B p))
    (hlarge : ∀ label ∈ labels, (M - 1) ^ 2 < label.product)
    (hmultiplicity : ∀ p ∈ S,
      mu ≤ incidentLabelCount labels R B C p) :
    mu * S.card ≤ labels.card * M := by
  classical
  have hdouble :
      (∑ p ∈ S, incidentLabelCount labels R B C p) =
      ∑ label ∈ labels, (labelFiber S R B C label).card := by
    simp only [incidentLabelCount]
    change
      (∑ p ∈ S, (labels.filter fun label ↦
        armDivisorsAt R B C p label.u label.v label.w).card) =
      ∑ label ∈ labels, (S.filter fun p ↦
        armDivisorsAt R B C p label.u label.v label.w).card
    simp_rw [Finset.card_filter]
    rw [Finset.sum_comm]
  calc
    mu * S.card = ∑ _p ∈ S, mu := by simp [mul_comm]
    _ ≤ ∑ p ∈ S, incidentLabelCount labels R B C p := by
      exact Finset.sum_le_sum hmultiplicity
    _ = ∑ label ∈ labels, (labelFiber S R B C label).card := hdouble
    _ ≤ labels.card * M :=
      largeLabel_incidenceBudget S labels hbox harms hlarge

#print axioms largeLabel_incidenceMultiplicity_bound

/-- Pigeonhole form: assigning every point an actual large label from a
finite catalogue forces the point count below `catalogue size * side`. -/
theorem assignedLargeLabel_card_le_catalog_mul_side
    (S : Finset (ℕ × ℕ)) (labels : Finset ArmDivisorLabel)
    (labelOf : ℕ × ℕ → ArmDivisorLabel) {R B C M : ℕ}
    (hmaps : ∀ p ∈ S, labelOf p ∈ labels)
    (hdiv : ∀ p ∈ S,
      armDivisorsAt R B C p (labelOf p).u (labelOf p).v (labelOf p).w)
    (hbox : ∀ p ∈ S,
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M)
    (harms : ∀ p ∈ S,
      Nat.Coprime (affineU R p) (affineV R C p) ∧
      Nat.Coprime (affineU R p) (affineW R B p) ∧
      Nat.Coprime (affineV R C p) (affineW R B p))
    (hlarge : ∀ label ∈ labels, (M - 1) ^ 2 < label.product) :
    S.card ≤ labels.card * M := by
  by_contra hnot
  have hgt : labels.card * M < S.card := Nat.lt_of_not_ge hnot
  obtain ⟨label, hlabel, hfiber⟩ :=
    Finset.exists_lt_card_fiber_of_mul_lt_card_of_maps_to hmaps hgt
  let assignedFiber := S.filter fun p ↦ labelOf p = label
  have hsubset : assignedFiber ⊆ labelFiber S R B C label := by
    intro p hp
    have hpData : p ∈ S ∧ labelOf p = label := by
      simpa [assignedFiber] using hp
    apply mem_labelFiber_iff.mpr
    refine ⟨hpData.1, ?_⟩
    simpa [hpData.2] using hdiv p hpData.1
  have hassignedLe : assignedFiber.card ≤
      (labelFiber S R B C label).card := Finset.card_le_card hsubset
  have hlabelCap : (labelFiber S R B C label).card ≤ M :=
    largeLabel_fiber_card_le_side S label hbox harms
      (hlarge label hlabel)
  have : assignedFiber.card ≤ M := hassignedLe.trans hlabelCap
  change M < assignedFiber.card at hfiber
  omega

#print axioms assignedLargeLabel_card_le_catalog_mul_side

/-! ## Exact third-gcd energy identity -/

private theorem sum_three_comm_three
    (A : Finset α) (B : Finset β) (C : Finset γ)
    (D : Finset δ) (E : Finset ε) (F : Finset ζ)
    (f : α → β → γ → δ → ε → ζ → ℕ) :
    (∑ a ∈ A, ∑ b ∈ B, ∑ c ∈ C, ∑ d ∈ D, ∑ e ∈ E, ∑ z ∈ F,
      f a b c d e z) =
    ∑ d ∈ D, ∑ e ∈ E, ∑ z ∈ F, ∑ a ∈ A, ∑ b ∈ B, ∑ c ∈ C,
      f a b c d e z := by
  simpa only [Finset.sum_product] using
    (Finset.sum_comm
      (s := (A ×ˢ B) ×ˢ C) (t := (D ×ˢ E) ×ˢ F)
      (f := fun abc dez ↦ f abc.1.1 abc.1.2 abc.2 dez.1.1 dez.1.2 dez.2))

private theorem ite_sum_zero (p : Prop) [Decidable p]
    (A : Finset α) (f : α → ℕ) :
    (if p then ∑ a ∈ A, f a else 0) =
      ∑ a ∈ A, if p then f a else 0 := by
  by_cases hp : p <;> simp [hp]

private theorem threePointCommonGcd_pos {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    0 < threePointCommonGcd a b c := by
  simp only [threePointCommonGcd, Nat.gcd_pos_iff]
  aesop

private theorem mem_threePointCommonGcd_divisors_iff {a b c e : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
    e ∈ (threePointCommonGcd a b c).divisors ↔
      e ∣ a ∧ e ∣ b ∧ e ∣ c := by
  rw [Nat.mem_divisors]
  simp only [threePointCommonGcd, Nat.dvd_gcd_iff]
  have hne : (Nat.gcd (Nat.gcd a b) c) ≠ 0 := by
    simpa [threePointCommonGcd] using
      (ne_of_gt (threePointCommonGcd_pos ha hb hc))
  aesop

/-- The divisor-sum identity for a threefold gcd, extended to any finite
range containing all divisors of the first positive label. -/
theorem threePointCommonGcd_eq_totient_sum_over
    (E : Finset ℕ) {a b c : ℕ}
    (ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hcover : a.divisors ⊆ E) :
    threePointCommonGcd a b c =
      ∑ e ∈ E with e ∣ a ∧ e ∣ b ∧ e ∣ c, Nat.totient e := by
  have hfilter : E.filter (fun e ↦ e ∣ a ∧ e ∣ b ∧ e ∣ c) =
      (threePointCommonGcd a b c).divisors := by
    ext e
    simp only [Finset.mem_filter,
      mem_threePointCommonGcd_divisors_iff ha hb hc]
    constructor
    · exact fun h ↦ h.2
    · intro h
      exact ⟨hcover (Nat.mem_divisors.mpr ⟨h.1, ne_of_gt ha⟩), h⟩
  rw [← Nat.sum_totient (threePointCommonGcd a b c), ← hfilter]

private def predicateOccupancy
    (S : Finset α) (P : α → Prop) [DecidablePred P] : ℕ :=
  (S.filter P).card

private theorem predicateOccupancy_cube
    (S : Finset α) (P : α → Prop) [DecidablePred P] :
    predicateOccupancy S P ^ 3 =
      ∑ x ∈ S, ∑ y ∈ S, ∑ z ∈ S,
        if P x ∧ P y ∧ P z then 1 else 0 := by
  let n := predicateOccupancy S P
  have hz (x y : α) :
      (∑ z ∈ S, if P x ∧ P y ∧ P z then 1 else 0) =
        if P x ∧ P y then n else 0 := by
    by_cases hx : P x <;> by_cases hy : P y <;>
      simp [hx, hy, n, predicateOccupancy, Finset.sum_boole]
  have hy (x : α) :
      (∑ y ∈ S, if P x ∧ P y then n else 0) =
        if P x then n * n else 0 := by
    by_cases hx : P x
    · simp only [hx, true_and, if_pos]
      rw [← Finset.sum_filter]
      simp [n, predicateOccupancy]
    · simp [hx]
  have hx :
      (∑ x ∈ S, if P x then n * n else 0) = n * n * n := by
    rw [← Finset.sum_filter]
    simp [n, predicateOccupancy, mul_assoc]
  calc
    predicateOccupancy S P ^ 3 = n * n * n := by
      simp [n, pow_succ, mul_assoc]
    _ = ∑ x ∈ S, if P x then n * n else 0 := hx.symm
    _ = ∑ x ∈ S, ∑ y ∈ S, if P x ∧ P y then n else 0 := by
      exact Finset.sum_congr rfl fun x _ ↦ (hy x).symm
    _ = ∑ x ∈ S, ∑ y ∈ S, ∑ z ∈ S,
        if P x ∧ P y ∧ P z then 1 else 0 := by
      apply Finset.sum_congr rfl
      intro x _
      exact Finset.sum_congr rfl fun y _ ↦ (hz x y).symm

/-- Number of points simultaneously incident to one divisor triple. -/
def divisorTripleOccupancy (S : Finset α)
    (dU dV dW : α → ℕ) (eU eV eW : ℕ) : ℕ :=
  (S.filter fun x ↦ eU ∣ dU x ∧ eV ∣ dV x ∧ eW ∣ dW x).card

/-- Ordered third-gcd energy of three positive integer labels on `S`. -/
def thirdGcdEnergy (S : Finset α) (dU dV dW : α → ℕ) : ℕ :=
  ∑ x ∈ S, ∑ y ∈ S, ∑ z ∈ S,
    threePointCommonGcd (dU x) (dU y) (dU z) *
      threePointCommonGcd (dV x) (dV y) (dV z) *
        threePointCommonGcd (dW x) (dW y) (dW z)

private theorem point_thirdGcd_totient_expansion
    (EU EV EW : Finset ℕ) (dU dV dW : α → ℕ)
    {x y z : α}
    (hUx : 0 < dU x) (hUy : 0 < dU y) (hUz : 0 < dU z)
    (hVx : 0 < dV x) (hVy : 0 < dV y) (hVz : 0 < dV z)
    (hWx : 0 < dW x) (hWy : 0 < dW y) (hWz : 0 < dW z)
    (hcoverU : (dU x).divisors ⊆ EU)
    (hcoverV : (dV x).divisors ⊆ EV)
    (hcoverW : (dW x).divisors ⊆ EW) :
    threePointCommonGcd (dU x) (dU y) (dU z) *
        threePointCommonGcd (dV x) (dV y) (dV z) *
          threePointCommonGcd (dW x) (dW y) (dW z) =
      ∑ eW ∈ EW with eW ∣ dW x ∧ eW ∣ dW y ∧ eW ∣ dW z,
        ∑ eV ∈ EV with eV ∣ dV x ∧ eV ∣ dV y ∧ eV ∣ dV z,
          ∑ eU ∈ EU with eU ∣ dU x ∧ eU ∣ dU y ∧ eU ∣ dU z,
            Nat.totient eU * Nat.totient eV * Nat.totient eW := by
  rw [threePointCommonGcd_eq_totient_sum_over EU hUx hUy hUz hcoverU,
    threePointCommonGcd_eq_totient_sum_over EV hVx hVy hVz hcoverV,
    threePointCommonGcd_eq_totient_sum_over EW hWx hWy hWz hcoverW]
  simp only [Finset.sum_mul, Finset.mul_sum]

private theorem weighted_divisorTripleOccupancy_cube
    (S : Finset α) (dU dV dW : α → ℕ) (eU eV eW weight : ℕ) :
    weight * divisorTripleOccupancy S dU dV dW eU eV eW ^ 3 =
      ∑ x ∈ S, ∑ y ∈ S, ∑ z ∈ S,
        if eW ∣ dW x ∧ eW ∣ dW y ∧ eW ∣ dW z then
          if eV ∣ dV x ∧ eV ∣ dV y ∧ eV ∣ dV z then
            if eU ∣ dU x ∧ eU ∣ dU y ∧ eU ∣ dU z then weight else 0
          else 0
        else 0 := by
  let P : α → Prop := fun x ↦ eU ∣ dU x ∧ eV ∣ dV x ∧ eW ∣ dW x
  have hocc := predicateOccupancy_cube S P
  change divisorTripleOccupancy S dU dV dW eU eV eW ^ 3 = _ at hocc
  rw [hocc]
  simp only [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro x _
  apply Finset.sum_congr rfl
  intro y _
  apply Finset.sum_congr rfl
  intro z _
  dsimp only [P]
  have hreorder :
      ((eU ∣ dU x ∧ eV ∣ dV x ∧ eW ∣ dW x) ∧
          (eU ∣ dU y ∧ eV ∣ dV y ∧ eW ∣ dW y) ∧
            eU ∣ dU z ∧ eV ∣ dV z ∧ eW ∣ dW z) ↔
        (eW ∣ dW x ∧ eW ∣ dW y ∧ eW ∣ dW z) ∧
          (eV ∣ dV x ∧ eV ∣ dV y ∧ eV ∣ dV z) ∧
            (eU ∣ dU x ∧ eU ∣ dU y ∧ eU ∣ dU z) := by
    tauto
  simp only [hreorder]
  by_cases hW : eW ∣ dW x ∧ eW ∣ dW y ∧ eW ∣ dW z <;>
    by_cases hV : eV ∣ dV x ∧ eV ∣ dV y ∧ eV ∣ dV z <;>
      by_cases hU : eU ∣ dU x ∧ eU ∣ dU y ∧ eU ∣ dU z <;>
        simp [hW, hV, hU]

set_option maxHeartbeats 800000 in
/-- Exact third-gcd incidence expansion.  The finite ranges may contain
extra integers, but must contain all divisors of every positive point label.
The right side is the cubic moment of simultaneous divisor-triple fibre
occupancies, weighted by the three Euler totients. -/
theorem thirdGcd_incidence_expansion
    (S : Finset α) (dU dV dW : α → ℕ)
    (EU EV EW : Finset ℕ)
    (hposU : ∀ x ∈ S, 0 < dU x)
    (hposV : ∀ x ∈ S, 0 < dV x)
    (hposW : ∀ x ∈ S, 0 < dW x)
    (hcoverU : ∀ x ∈ S, (dU x).divisors ⊆ EU)
    (hcoverV : ∀ x ∈ S, (dV x).divisors ⊆ EV)
    (hcoverW : ∀ x ∈ S, (dW x).divisors ⊆ EW) :
    thirdGcdEnergy S dU dV dW =
      ∑ eW ∈ EW, ∑ eV ∈ EV, ∑ eU ∈ EU,
        Nat.totient eU * Nat.totient eV * Nat.totient eW *
          divisorTripleOccupancy S dU dV dW eU eV eW ^ 3 := by
  classical
  unfold thirdGcdEnergy
  calc
    (∑ x ∈ S, ∑ y ∈ S, ∑ z ∈ S,
        threePointCommonGcd (dU x) (dU y) (dU z) *
          threePointCommonGcd (dV x) (dV y) (dV z) *
            threePointCommonGcd (dW x) (dW y) (dW z)) =
      ∑ x ∈ S, ∑ y ∈ S, ∑ z ∈ S,
        ∑ eW ∈ EW with eW ∣ dW x ∧ eW ∣ dW y ∧ eW ∣ dW z,
          ∑ eV ∈ EV with eV ∣ dV x ∧ eV ∣ dV y ∧ eV ∣ dV z,
            ∑ eU ∈ EU with eU ∣ dU x ∧ eU ∣ dU y ∧ eU ∣ dU z,
              Nat.totient eU * Nat.totient eV * Nat.totient eW := by
      apply Finset.sum_congr rfl
      intro x hx
      apply Finset.sum_congr rfl
      intro y hy
      apply Finset.sum_congr rfl
      intro z hz
      exact point_thirdGcd_totient_expansion EU EV EW dU dV dW
        (hposU x hx) (hposU y hy) (hposU z hz)
        (hposV x hx) (hposV y hy) (hposV z hz)
        (hposW x hx) (hposW y hy) (hposW z hz)
        (hcoverU x hx) (hcoverV x hx) (hcoverW x hx)
    _ = ∑ x ∈ S, ∑ y ∈ S, ∑ z ∈ S,
        ∑ eW ∈ EW, ∑ eV ∈ EV, ∑ eU ∈ EU,
          if eW ∣ dW x ∧ eW ∣ dW y ∧ eW ∣ dW z then
            if eV ∣ dV x ∧ eV ∣ dV y ∧ eV ∣ dV z then
              if eU ∣ dU x ∧ eU ∣ dU y ∧ eU ∣ dU z then
                Nat.totient eU * Nat.totient eV * Nat.totient eW
              else 0
            else 0
          else 0 := by
      simp only [Finset.sum_filter, ite_sum_zero]
    _ = ∑ eW ∈ EW, ∑ eV ∈ EV, ∑ eU ∈ EU,
        ∑ x ∈ S, ∑ y ∈ S, ∑ z ∈ S,
          if eW ∣ dW x ∧ eW ∣ dW y ∧ eW ∣ dW z then
            if eV ∣ dV x ∧ eV ∣ dV y ∧ eV ∣ dV z then
              if eU ∣ dU x ∧ eU ∣ dU y ∧ eU ∣ dU z then
                Nat.totient eU * Nat.totient eV * Nat.totient eW
              else 0
            else 0
          else 0 := by
      exact sum_three_comm_three S S S EW EV EU
        (fun x y z eW eV eU ↦
          if eW ∣ dW x ∧ eW ∣ dW y ∧ eW ∣ dW z then
            if eV ∣ dV x ∧ eV ∣ dV y ∧ eV ∣ dV z then
              if eU ∣ dU x ∧ eU ∣ dU y ∧ eU ∣ dU z then
                Nat.totient eU * Nat.totient eV * Nat.totient eW
              else 0
            else 0
          else 0)
    _ = ∑ eW ∈ EW, ∑ eV ∈ EV, ∑ eU ∈ EU,
        Nat.totient eU * Nat.totient eV * Nat.totient eW *
          divisorTripleOccupancy S dU dV dW eU eV eW ^ 3 := by
      apply Finset.sum_congr rfl
      intro eW _
      apply Finset.sum_congr rfl
      intro eV _
      apply Finset.sum_congr rfl
      intro eU _
      exact (weighted_divisorTripleOccupancy_cube S dU dV dW eU eV eW
        (Nat.totient eU * Nat.totient eV * Nat.totient eW)).symm

#print axioms threePointCommonGcd_eq_totient_sum_over
#print axioms thirdGcd_incidence_expansion

/-! ## Exact pressure tests -/

/-- The deliberately overstrong box-wide implication tested below.  It
retains all actual affine, divisor, common-label, and six-congruence premises
but tries to infer noncollinearity from a product larger than the box-square.
The correct determinant theorem does not make this inference. -/
def boxWideLargeCommonLabelNoncollinearityImplication
    (R B C M : ℕ) (p q r : ℕ × ℕ) (label : ArmDivisorLabel) : Prop :=
  (seedOneCanonicalPremises R B C M ∧
      certifiedAffinePointInBox R B C M p ∧
      certifiedAffinePointInBox R B C M q ∧
      certifiedAffinePointInBox R B C M r ∧
      armDivisorsAt R B C p label.u label.v label.w ∧
      armDivisorsAt R B C q label.u label.v label.w ∧
      armDivisorsAt R B C r label.u label.v label.w ∧
      p ≠ q ∧ p ≠ r ∧ q ≠ r ∧ label.PairwiseCoprime ∧
      (label.u : ℤ) ∣ (natPointDiff q p).1 ∧
      (label.v : ℤ) ∣ (natPointDiff q p).1 +
        (C : ℤ) * (natPointDiff q p).2 ∧
      (label.w : ℤ) ∣ (natPointDiff q p).1 +
        (B : ℤ) * (natPointDiff q p).2 ∧
      (label.u : ℤ) ∣ (natPointDiff r p).1 ∧
      (label.v : ℤ) ∣ (natPointDiff r p).1 +
        (C : ℤ) * (natPointDiff r p).2 ∧
      (label.w : ℤ) ∣ (natPointDiff r p).1 +
        (B : ℤ) * (natPointDiff r p).2 ∧
      (M - 1) ^ 2 < label.product) →
    natTriangleDet p q r ≠ 0

private theorem radical_72 : abcRadical 72 = 6 := by
  rw [show 72 = 2 ^ 3 * 3 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 2).prime) (by norm_num),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 3).prime) (by norm_num)]
  norm_num

/-- Actual seed `(1,8,9)` data with a common product larger than the full
box-square and zero determinant.  This refutes only
`boxWideLargeCommonLabelNoncollinearityImplication`; the valid box-wide
theorem assumes noncollinearity and is untouched. -/
theorem seed189_boxWideLargeCommonProduct_collinear_implication_counterexample :
    let B : ℕ := 8
    let C : ℕ := 9
    let R : ℕ := 6
    let M : ℕ := canonicalBoxM C R
    let p : ℕ × ℕ := (21480, 282)
    let q : ℕ × ℕ := (21480, 6211)
    let r : ℕ × ℕ := (21480, 12140)
    let s : ℕ × ℕ := (21480, 18069)
    let label : ArmDivisorLabel := ⟨128881, 49, 121⟩
    seedOneCanonicalPremises R B C M ∧
      certifiedAffinePointInBox R B C M p ∧
      certifiedAffinePointInBox R B C M q ∧
      certifiedAffinePointInBox R B C M r ∧
      certifiedAffinePointInBox R B C M s ∧
      armDivisorsAt R B C p label.u label.v label.w ∧
      armDivisorsAt R B C q label.u label.v label.w ∧
      armDivisorsAt R B C r label.u label.v label.w ∧
      armDivisorsAt R B C s label.u label.v label.w ∧
      (affineU R p, affineV R C p, affineW R B p) =
        (128881, 144109, 142417) ∧
      (affineU R q, affineV R C q, affineW R B q) =
        (128881, 464275, 427009) ∧
      (affineU R r, affineV R C r, affineW R B r) =
        (128881, 784441, 711601) ∧
      (affineU R s, affineV R C s, affineW R B s) =
        (128881, 1104607, 996193) ∧
      Nat.Prime 359 ∧ Nat.Prime 7 ∧ Nat.Prime 11 ∧
      (label.u, label.v, label.w) = (359 ^ 2, 7 ^ 2, 11 ^ 2) ∧
      (threePointCommonGcd label.u label.u label.u,
        threePointCommonGcd label.v label.v label.v,
        threePointCommonGcd label.w label.w label.w) =
          (128881, 49, 121) ∧
      label.PairwiseCoprime ∧ label.product = 764135449 ∧
      (M - 1) ^ 2 = 490268164 ∧ (M - 1) ^ 2 < label.product ∧
      (label.u : ℤ) ∣ (natPointDiff q p).1 ∧
      (label.v : ℤ) ∣ (natPointDiff q p).1 +
        (C : ℤ) * (natPointDiff q p).2 ∧
      (label.w : ℤ) ∣ (natPointDiff q p).1 +
        (B : ℤ) * (natPointDiff q p).2 ∧
      (label.u : ℤ) ∣ (natPointDiff r p).1 ∧
      (label.v : ℤ) ∣ (natPointDiff r p).1 +
        (C : ℤ) * (natPointDiff r p).2 ∧
      (label.w : ℤ) ∣ (natPointDiff r p).1 +
        (B : ℤ) * (natPointDiff r p).2 ∧
      pairSupDist p q = 5929 ∧ pairSupDist q r = 5929 ∧
      pairSupDist p r = 11858 ∧ natTriangleDet p q r = 0 ∧
      ¬ boxWideLargeCommonLabelNoncollinearityImplication
        R B C M p q r label := by
  norm_num [seedOneCanonicalPremises, certifiedAffinePointInBox,
    armDivisorsAt, boxWideLargeCommonLabelNoncollinearityImplication,
    ArmDivisorLabel.PairwiseCoprime, ArmDivisorLabel.product,
    threePointCommonGcd, canonicalBoxM, affineU, affineV, affineW,
    natPointDiff, pairSupDist, Nat.dist, natTriangleDet, radical_72]

#print axioms seed189_boxWideLargeCommonProduct_collinear_implication_counterexample

/-- Abstract implication that tries to deduce shared triplewise gcd mass
from three unrelated pointwise-large labels.  It intentionally contains no
affine-arm or box premise. -/
def pointwiseLargeProductsForceTripleGcdProduct
    (T : ℕ) (x y z : ArmDivisorLabel) : Prop :=
  (x.PairwiseCoprime ∧ y.PairwiseCoprime ∧ z.PairwiseCoprime ∧
      T < x.product ∧ T < y.product ∧ T < z.product) →
    T < threePointCommonGcd x.u y.u z.u *
      threePointCommonGcd x.v y.v z.v *
        threePointCommonGcd x.w y.w z.w

/-- Exact abstract-model counterexample: all three pointwise products exceed
`1000`, but their triplewise common product is one.  This does not claim
that the labels occur at affine points. -/
theorem abstract_pointwiseLargeProducts_no_tripleOverlap_counterexample :
    let x : ArmDivisorLabel := ⟨49, 25, 1⟩
    let y : ArmDivisorLabel := ⟨121, 169, 1⟩
    let z : ArmDivisorLabel := ⟨289, 361, 1⟩
    x.PairwiseCoprime ∧ y.PairwiseCoprime ∧ z.PairwiseCoprime ∧
      1000 < x.product ∧ 1000 < y.product ∧ 1000 < z.product ∧
      threePointCommonGcd x.u y.u z.u = 1 ∧
      threePointCommonGcd x.v y.v z.v = 1 ∧
      threePointCommonGcd x.w y.w z.w = 1 ∧
      ¬ pointwiseLargeProductsForceTripleGcdProduct 1000 x y z := by
  norm_num [ArmDivisorLabel.PairwiseCoprime, ArmDivisorLabel.product,
    threePointCommonGcd, pointwiseLargeProductsForceTripleGcdProduct]

#print axioms abstract_pointwiseLargeProducts_no_tripleOverlap_counterexample

end AffineCommonKernelTripleSelection20260901
end IUTThreeClosures
