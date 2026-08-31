/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LowRadicalDensityBarrier
import IUTThreeClosures.SparseExceptionalTransfer
import Mathlib.Tactic

/-!
# Prime-power exceptional exponent thresholds

A direct cardinality transfer from an ambient almost-all theorem to centres of
the form `p^k` needs the exceptional set to be smaller than the prime-power
centre set. At power-exponent level, prime-power centres have exponent `1 / k`.
Thus an exceptional-set estimate of shape `X^(1-delta)` must satisfy

`1 - delta < 1 / k`,

equivalently `delta > 1 - 1 / k`.

The equality case is deliberately excluded: the prime number theorem predicts
only about `X^(1/k) / log X` prime-power centres, so an `O(X^(1/k))` exceptional
bound can still contain every centre.

Combining this transfer threshold with the square-root low-radical density
barrier shows that every dense/all-primes route in the feasible range `k >= 5`
would need an ambient power saving strictly larger than `4/5`. This module
formalizes only the finite selection and exact exponent arithmetic. It does not
axiomatize the prime number theorem or any short-interval theorem.
-/

namespace IUTThreeClosures
namespace PrimePowerExceptionalExponentThreshold

open LowRadicalDensityBarrier SparseExceptionalTransfer

/-- Power exponent of the fixed-`k` prime-power centre family. -/
def primePowerCenterExponent (k : ℕ) : ℝ :=
  1 / (k : ℝ)

/-- Power saving required for a strict exponent-level transfer to `p^k`
centres. -/
def directTransferSavingThreshold (k : ℕ) : ℝ :=
  1 - primePowerCenterExponent k

/-- The saving condition and the exceptional-exponent condition are the same
linear inequality. -/
theorem saving_gt_threshold_iff_exceptionExponent_lt_center
    {k : ℕ} {delta : ℝ} :
    directTransferSavingThreshold k < delta ↔
      1 - delta < primePowerCenterExponent k := by
  unfold directTransferSavingThreshold
  linarith

/-- At the threshold itself, the exceptional exponent merely equals the centre
exponent; it is not strictly smaller. -/
theorem threshold_equality_is_not_strict (k : ℕ) :
    ¬ (1 - directTransferSavingThreshold k <
      primePowerCenterExponent k) := by
  simp [directTransferSavingThreshold]

/-- For `k >= 5`, the prime-power centre exponent is at most `1/5`. -/
theorem primePowerCenterExponent_le_one_fifth_of_five_le
    {k : ℕ}
    (hk : 5 ≤ k) :
    primePowerCenterExponent k ≤ (1 : ℝ) / 5 := by
  have hkposNat : 0 < k := by omega
  have hkpos : 0 < (k : ℝ) := by exact_mod_cast hkposNat
  have hkreal : (5 : ℝ) ≤ k := by exact_mod_cast hk
  unfold primePowerCenterExponent
  apply (div_le_iff₀ hkpos).2
  nlinarith

/-- Consequently, every feasible exponent `k >= 5` has direct-transfer saving
threshold at least `4/5`. -/
theorem directTransferSavingThreshold_ge_four_fifths_of_five_le
    {k : ℕ}
    (hk : 5 ≤ k) :
    (4 : ℝ) / 5 ≤ directTransferSavingThreshold k := by
  have hcenter :=
    primePowerCenterExponent_le_one_fifth_of_five_le hk
  unfold directTransferSavingThreshold
  linarith

/-- A strict exceptional-exponent transfer to any fixed `k >= 5` prime-power
family therefore needs a power saving strictly larger than `4/5`. -/
theorem direct_transfer_requires_saving_gt_four_fifths_of_five_le
    {k : ℕ} {delta : ℝ}
    (hk : 5 ≤ k)
    (hexceptionExponent :
      1 - delta < primePowerCenterExponent k) :
    (4 : ℝ) / 5 < delta := by
  have hthreshold : directTransferSavingThreshold k < delta :=
    (saving_gt_threshold_iff_exceptionExponent_lt_center).2
      hexceptionExponent
  have hfour :=
    directTransferSavingThreshold_ge_four_fifths_of_five_le hk
  linarith

/-- The fifth-power threshold is exactly `4/5`. -/
@[simp] theorem directTransferSavingThreshold_five :
    directTransferSavingThreshold 5 = (4 : ℝ) / 5 := by
  norm_num [directTransferSavingThreshold, primePowerCenterExponent]

/-- If an ambient numerical cap is at least as large as the centre set, that
cap is consistent with every centre being exceptional. This is the finite
countermodel behind the exponent threshold. -/
theorem ambient_cap_can_cover_all_centers
    {α : Type*} [DecidableEq α]
    (centers ambient : Finset α)
    (hsubset : centers ⊆ ambient)
    (cap : ℕ)
    (hcap : centers.card ≤ cap) :
    ∃ exceptional : Finset α,
      exceptional ⊆ ambient ∧
      exceptional.card ≤ cap ∧
      centers ⊆ exceptional := by
  exact ⟨centers, hsubset, hcap, by
    intro x hx
    exact hx⟩

/-- Conversely, an ambient exceptional-cardinality cap strictly below the
centre count forces a good centre, provided every failure is covered by the
exceptional set. -/
theorem exists_good_center_of_ambient_cap_lt
    {α : Type*} [DecidableEq α]
    (centers exceptional : Finset α)
    (Good : α → Prop)
    (hcover : ∀ x ∈ centers, ¬ Good x → x ∈ exceptional)
    (cap : ℕ)
    (hexceptional : exceptional.card ≤ cap)
    (hcap : cap < centers.card) :
    ∃ x ∈ centers, Good x := by
  classical
  apply exists_good_center_of_exceptional_cover
    centers exceptional Good hcover
  have hinter : (exceptional ∩ centers).card ≤ exceptional.card := by
    apply Finset.card_le_card
    intro x hx
    exact (Finset.mem_inter.mp hx).1
  omega

/-- Combining the low-radical density obstruction with direct exceptional-set
transfer: any dense/all-primes square-root route that is subcritical and is
obtained from an ambient power-saving theorem needs saving `delta > 4/5`. -/
theorem squareRoot_dense_route_direct_transfer_requires_four_fifths
    {k : ℕ} {beta delta : ℝ}
    (hk : 0 < k)
    (hdensity : primePowerCenterExponent k ≤ beta)
    (hsubcritical :
      (1 : ℝ) / 2 + primePowerCenterExponent k + beta < 1)
    (hexceptionExponent :
      1 - delta < primePowerCenterExponent k) :
    (4 : ℝ) / 5 < delta := by
  have hkgt : 4 < k := by
    apply exponent_gt_four_of_squareRoot_subcritical_and_density hk
    · simpa [primePowerCenterExponent] using hdensity
    · simpa [primePowerCenterExponent] using hsubcritical
  have hkfive : 5 ≤ k := by omega
  exact direct_transfer_requires_saving_gt_four_fifths_of_five_le
    hkfive hexceptionExponent

#print axioms saving_gt_threshold_iff_exceptionExponent_lt_center
#print axioms threshold_equality_is_not_strict
#print axioms primePowerCenterExponent_le_one_fifth_of_five_le
#print axioms directTransferSavingThreshold_ge_four_fifths_of_five_le
#print axioms direct_transfer_requires_saving_gt_four_fifths_of_five_le
#print axioms directTransferSavingThreshold_five
#print axioms ambient_cap_can_cover_all_centers
#print axioms exists_good_center_of_ambient_cap_lt
#print axioms squareRoot_dense_route_direct_transfer_requires_four_fifths

end PrimePowerExceptionalExponentThreshold
end IUTThreeClosures
