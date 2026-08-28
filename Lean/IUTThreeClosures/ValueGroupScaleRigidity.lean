/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Scale rigidity required by a q-pilot log-volume comparison

Suppose an abstract value-group interface forgets enough arithmetic structure
that every positive real rescaling is regarded as an admissible symmetry.  A
nonzero q-log value then has every positive real number as a possible image:
for `x > 0` and target `y > 0`, scale by `y/x`.

Consequently no nonempty family of positive q-log values can be both invariant
under all positive rescalings and bounded above, bounded away from zero, or
contained in a finite exponent window.  Such an interface cannot support a
finite q-linked log-volume estimate.

This is a rigorous obstruction only to **unrestricted** scale-forgetting
models.  It does not refute the genuine IUT route; rather, it isolates a source
theorem that the genuine log-Kummer/mono-theta construction must prove:
allowed indeterminacies preserve the relevant q-spectrum or otherwise admit a
specific finite envelope.  The spectrum-preserving Ind2 implementation in the
repository is one possible formal target.
-/

namespace IUTThreeClosures

/-- A set of real q-log magnitudes is invariant under every positive scalar. -/
def FullPositiveScaleInvariant (S : Set ℝ) : Prop :=
  ∀ ⦃x λ : ℝ⦄, x ∈ S → 0 < λ → λ * x ∈ S

/-- One positive point in a fully scale-invariant set forces every positive
real number into the set. -/
theorem Ioi_subset_of_fullPositiveScaleInvariant
    {S : Set ℝ}
    (hscale : FullPositiveScaleInvariant S)
    {x : ℝ} (hxS : x ∈ S) (hx : 0 < x) :
    Set.Ioi (0 : ℝ) ⊆ S := by
  intro y hy
  have hλ : 0 < y / x := div_pos hy hx
  have hmem := hscale hxS hλ
  convert hmem using 1
  field_simp [ne_of_gt hx]

/-- A nonempty positive fully scale-invariant set is unbounded above. -/
theorem not_bddAbove_of_fullPositiveScaleInvariant
    {S : Set ℝ}
    (hscale : FullPositiveScaleInvariant S)
    (hpositive : ∃ x ∈ S, 0 < x) :
    ¬ BddAbove S := by
  rintro ⟨B, hB⟩
  rcases hpositive with ⟨x, hxS, hx⟩
  have hall := Ioi_subset_of_fullPositiveScaleInvariant
    hscale hxS hx
  have hmem : max (B + 1) 1 ∈ S := by
    apply hall
    exact lt_of_lt_of_le zero_lt_one (le_max_right _ _)
  have hle := hB hmem
  have hBlt : B < max (B + 1) 1 := by
    by_cases h : B + 1 ≤ 1
    · have : B < 1 := by linarith
      exact this.trans_le (le_max_right _ _)
    · rw [max_eq_left (le_of_not_ge h)]
      linarith
  exact hBlt.not_le hle

/-- A nonempty positive fully scale-invariant set cannot be bounded away from
zero by a positive constant. -/
theorem no_positive_lower_bound_of_fullPositiveScaleInvariant
    {S : Set ℝ}
    (hscale : FullPositiveScaleInvariant S)
    (hpositive : ∃ x ∈ S, 0 < x) :
    ¬ ∃ a : ℝ, 0 < a ∧ ∀ y ∈ S, a ≤ y := by
  rintro ⟨a, ha, hLower⟩
  rcases hpositive with ⟨x, hxS, hx⟩
  have hall := Ioi_subset_of_fullPositiveScaleInvariant
    hscale hxS hx
  have hhalf : a / 2 ∈ S := by
    apply hall
    positivity
  have := hLower (a / 2) hhalf
  linarith

/-- No finite positive interval can contain a nonempty positive set invariant
under all positive rescalings. -/
theorem no_finite_window_of_fullPositiveScaleInvariant
    {S : Set ℝ}
    (hscale : FullPositiveScaleInvariant S)
    (hpositive : ∃ x ∈ S, 0 < x) :
    ¬ ∃ a b : ℝ,
      0 < a ∧
      ∀ y ∈ S, a ≤ y ∧ y ≤ b := by
  rintro ⟨a, b, ha, hwindow⟩
  apply no_positive_lower_bound_of_fullPositiveScaleInvariant
    hscale hpositive
  exact ⟨a, ha, fun y hy => (hwindow y hy).1⟩

/-- In fact the positive part of a fully scale-invariant set containing one
positive point is exactly all positive reals. -/
theorem inter_Ioi_eq_Ioi_of_fullPositiveScaleInvariant
    {S : Set ℝ}
    (hscale : FullPositiveScaleInvariant S)
    {x : ℝ} (hxS : x ∈ S) (hx : 0 < x) :
    S ∩ Set.Ioi (0 : ℝ) = Set.Ioi 0 := by
  apply Set.Subset.antisymm
  · exact Set.inter_subset_right
  · intro y hy
    exact ⟨Ioi_subset_of_fullPositiveScaleInvariant
      hscale hxS hx hy, hy⟩

end IUTThreeClosures
