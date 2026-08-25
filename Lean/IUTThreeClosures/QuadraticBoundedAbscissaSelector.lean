/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.WeightedPoitouTateSelectorAudit

/-!
# A bounded-abscissa quadratic selector

This module formalizes the finite combinatorics and scalar height ledger in
the bounded-abscissa quadratic globalization argument.  The paper companion
constructs the actual points

`(j, sqrt (j * (j - a) * (j + b)))`

over fields of degree at most two by CRT residue avoidance and removes the
uniformly bounded set of torsion candidates by degree-two torsion
boundedness.

Lean proves the collision uniqueness, weighted double count, surviving-row
average, local-degree normalization, signed local-height ledger, and the
quadratic-character orthogonality mechanism.  It does not model elliptic
curves, Neron models, Merel's theorem, quadratic fields, or canonical local
heights.  No abc or height estimate is stored in a structure field.
-/

namespace IUTThreeClosures

/-! ## Affine CRT rows have at most one collision at a large prime -/

/-- If the step is coprime to the modulus and both row indices are smaller
than the modulus, an affine residue class can be hit by at most one row. -/
theorem affineCandidate_collision_unique
    {p M r k l L : ℕ}
    (hMp : Nat.Coprime p M)
    (hk : k < L) (hl : l < L) (hLp : L ≤ p)
    (hcollision : (r + M * k) % p = (r + M * l) % p) :
    k = l := by
  have hfull : r + M * k ≡ r + M * l [MOD p] := hcollision
  have hmul : M * k ≡ M * l [MOD p] :=
    Nat.ModEq.add_left_cancel' r hfull
  have hkl : k ≡ l [MOD p] :=
    Nat.ModEq.cancel_left_of_coprime hMp.gcd_eq_one hmul
  apply le_antisymm
  · exact hkl.le_of_lt_add (by omega)
  · exact hkl.symm.le_of_lt_add (by omega)

/-! ## An owner encoding for the weighted double count -/

/-- The loss of a candidate when every label has at most one bad owner.
`none` means that the label is good for every candidate in the family. -/
noncomputable def ownerBadMass
    {Label Candidate : Type*}
    [Fintype Label] [DecidableEq Candidate]
    (weight : Label → ℝ) (owner : Label → Option Candidate)
    (candidate : Candidate) : ℝ :=
  ∑ label, if owner label = some candidate then weight label else 0

theorem ownerBadMass_nonneg
    {Label Candidate : Type*}
    [Fintype Label] [DecidableEq Candidate]
    (weight : Label → ℝ) (owner : Label → Option Candidate)
  (hweight : ∀ label, 0 ≤ weight label) (candidate : Candidate) :
    0 ≤ ownerBadMass weight owner candidate := by
  exact Finset.sum_nonneg fun label _ => by
    split
    · exact hweight label
    · exact le_rfl

/-- Summing the collision loss over any collection of distinct candidates
costs at most the total label weight. -/
theorem sum_ownerBadMass_le_total
    {Label Candidate : Type*}
    [Fintype Label] [DecidableEq Candidate]
    (candidates : Finset Candidate)
    (weight : Label → ℝ) (owner : Label → Option Candidate)
    (hweight : ∀ label, 0 ≤ weight label) :
    ∑ candidate ∈ candidates, ownerBadMass weight owner candidate ≤
      ∑ label, weight label := by
  unfold ownerBadMass
  rw [Finset.sum_comm]
  apply Finset.sum_le_sum
  intro label _
  cases howner : owner label with
  | none =>
      simp [hweight label]
  | some candidate =>
      by_cases hc : candidate ∈ candidates
      · simp [hc]
      · simp [hc, hweight label]

/-- A nonempty surviving family contains a row whose cardinality-scaled
loss is at most the total weight.  In the paper the survivors are precisely
the candidates left after removing all degree-at-most-two torsion points. -/
theorem exists_survivor_ownerBadMass_le
    {Label Candidate : Type*}
    [Fintype Label] [DecidableEq Candidate]
    (survivors : Finset Candidate) (hsurvivors : survivors.Nonempty)
    (weight : Label → ℝ) (owner : Label → Option Candidate)
    (hweight : ∀ label, 0 ≤ weight label) :
    ∃ candidate ∈ survivors,
      (survivors.card : ℝ) * ownerBadMass weight owner candidate ≤
        ∑ label, weight label := by
  obtain ⟨candidate, hc, hmin⟩ :=
    Finset.exists_min_image survivors (ownerBadMass weight owner) hsurvivors
  refine ⟨candidate, hc, ?_⟩
  calc
    (survivors.card : ℝ) * ownerBadMass weight owner candidate =
        survivors.card • ownerBadMass weight owner candidate := by
          simp
    _ ≤ ∑ c ∈ survivors, ownerBadMass weight owner c := by
      exact Finset.card_nsmul_le_sum survivors
        (ownerBadMass weight owner) _ fun c hc' => hmin c hc'
    _ ≤ ∑ label, weight label :=
      sum_ownerBadMass_le_total survivors weight owner hweight

/-- If the surviving cardinality is at least the reciprocal target loss,
the selected row loses at most the requested fraction of total mass. -/
theorem exists_survivor_ownerBadMass_le_fraction
    {Label Candidate : Type*}
    [Fintype Label] [DecidableEq Candidate]
    (survivors : Finset Candidate) (hsurvivors : survivors.Nonempty)
    (weight : Label → ℝ) (owner : Label → Option Candidate)
    (hweight : ∀ label, 0 ≤ weight label)
    {η : ℝ} (hη : 0 ≤ η)
    (hcard : 1 ≤ η * survivors.card) :
    ∃ candidate ∈ survivors,
      ownerBadMass weight owner candidate ≤ η * ∑ label, weight label := by
  obtain ⟨candidate, hc, hcandidate⟩ :=
    exists_survivor_ownerBadMass_le survivors hsurvivors weight owner hweight
  refine ⟨candidate, hc, ?_⟩
  have hmass : 0 ≤ ownerBadMass weight owner candidate :=
    ownerBadMass_nonneg weight owner hweight candidate
  have htotal : 0 ≤ ∑ label, weight label :=
    Finset.sum_nonneg fun label _ => hweight label
  have hleft : ownerBadMass weight owner candidate ≤
      (η * survivors.card) * ownerBadMass weight owner candidate :=
    by simpa using mul_le_mul_of_nonneg_right hcard hmass
  have hscaled : η * ((survivors.card : ℝ) *
      ownerBadMass weight owner candidate) ≤
      η * ∑ label, weight label :=
    mul_le_mul_of_nonneg_left hcandidate hη
  calc
    ownerBadMass weight owner candidate ≤
        (η * survivors.card) * ownerBadMass weight owner candidate := hleft
    _ = η * ((survivors.card : ℝ) *
        ownerBadMass weight owner candidate) := by ring
    _ ≤ η * ∑ label, weight label := hscaled

/-! ## The exact local-height ledger -/

/-- Separate control of exponent-excess and reduced-radical collision mass
implies control of their combined multiplicative-depth mass. -/
theorem quadraticSelector_separatedBadMass
    {excess radical badExcess badRadical δ : ℝ}
    (hExcess : badExcess ≤ δ * excess)
    (hRadical : badRadical ≤ δ * radical) :
    badExcess + badRadical ≤ δ * (excess + radical) := by
  nlinarith

/-- Good identity-component mass contributes with coefficient `1/6`, while
the worst multiplicative component contributes `-1/12`. -/
theorem quadraticSelector_localHeightLedger
    (totalMass badMass : ℝ) :
    (totalMass - badMass) / 6 - badMass / 12 =
      (2 * totalMass - 3 * badMass) / 12 := by
  ring

/-- Losing at most an `η` fraction of nonnegative mass leaves the exact
coefficient `(2 - 3η)/12`. -/
theorem quadraticSelector_localHeightLedger_lower
    {totalMass badMass η : ℝ}
    (_htotal : 0 ≤ totalMass) (hbad : badMass ≤ η * totalMass) :
    (2 - 3 * η) / 12 * totalMass ≤
      (totalMass - badMass) / 6 - badMass / 12 := by
  rw [quadraticSelector_localHeightLedger]
  nlinarith

/-- Ramification and residue degrees cancel after global normalization, so
the identity-component coefficient is unchanged by a finite base change. -/
theorem normalizedLocalDegree_identityComponent
    {Place : Type*}
    (places : Finset Place) (ramification residueDegree : Place → ℝ)
    {globalDegree depth : ℝ} (hdegree : globalDegree ≠ 0)
    (hsum : ∑ v ∈ places, ramification v * residueDegree v = globalDegree) :
    ∑ v ∈ places,
        (ramification v * residueDegree v / globalDegree) * (depth / 6) =
      depth / 6 := by
  rw [← Finset.sum_mul]
  rw [← Finset.sum_div]
  rw [hsum]
  field_simp

/-! ## Distinct quadratic characters are height-orthogonal -/

/-- The abstract sign argument behind orthogonality of points belonging to
distinct quadratic-character eigenspaces. -/
theorem quadraticCharacter_pairing_eq_zero
    {Point : Type*} (pairing : Point → Point → ℝ)
    (sigma neg : Point → Point) (P Q : Point)
    (hinvariant : pairing (sigma P) (sigma Q) = pairing P Q)
    (hsigmaP : sigma P = neg P) (hsigmaQ : sigma Q = Q)
    (hneg : pairing (neg P) Q = -pairing P Q) :
    pairing P Q = 0 := by
  have hsign : pairing P Q = -pairing P Q := by
    calc
      pairing P Q = pairing (sigma P) (sigma Q) := hinvariant.symm
      _ = pairing (neg P) Q := by rw [hsigmaP, hsigmaQ]
      _ = -pairing P Q := hneg
  linarith

/-! ## The remaining quantitative bridge -/

/-- A genuinely small full-height/adverse budget would turn the quadratic
selector's retained local mass into the desired exponent-mass estimate.
The hard input remains explicit in `hbudget`; it is not a structure field. -/
theorem quadraticSelector_smallBudget_to_massBound
    {κ mass radicalBudget fullBudget η C : ℝ}
    (hκ : 0 < κ)
    (hlocal : κ * mass ≤ fullBudget)
    (hbudget : fullBudget ≤ κ * η * radicalBudget + C) :
    mass ≤ η * radicalBudget + C / κ := by
  have hmul : κ * mass ≤ κ * (η * radicalBudget + C / κ) := by
    calc
      κ * mass ≤ fullBudget := hlocal
      _ ≤ κ * η * radicalBudget + C := hbudget
      _ = κ * (η * radicalBudget + C / κ) := by field_simp
  by_contra hnot
  have hgt : η * radicalBudget + C / κ < mass := lt_of_not_ge hnot
  exact (not_lt_of_ge hmul) (mul_lt_mul_of_pos_left hgt hκ)

end IUTThreeClosures
