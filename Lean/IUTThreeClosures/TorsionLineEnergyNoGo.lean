/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Torsion-line packet cancellation and the projective-dimension barrier

For a split Tate curve, the local sum of Neron functions over the canonical
cyclic order-`ell` subgroup has coefficient

`A_ell = (ell - 1) / 12`,

while every noncanonical cyclic subgroup has coefficient

`B_ell = -(ell - 1) / (12 * ell)`.

This module formalizes the finite-dimensional algebra that follows from these
two coefficients.

* Every fixed place-independent weighted packet has total score zero after
  averaging over the complete projective orbit of `ell + 1` cyclic lines.
* The generic `1 / (ell + 1)` projective-selection gain exactly cancels the
  noncanonical baseline.
* The canonical coefficient is exactly one sixth of the degree
  `(ell - 1) / 2` appearing in the highest Hodge line of the maximal-Higgs
  Legendre variation.

The local Neron-function calculation supplying `A_ell` and `B_ell` is a
separate arithmetic theorem.  No abc conclusion is asserted here.
-/

namespace IUTThreeClosures

/-- The canonical Tate-line coefficient. -/
noncomputable def canonicalTateLineCoefficient (ell : ℕ) : ℝ :=
  ((ell : ℝ) - 1) / 12

/-- The coefficient of every noncanonical Tate line. -/
noncomputable def noncanonicalTateLineCoefficient (ell : ℕ) : ℝ :=
  -((ell : ℝ) - 1) / (12 * ell)

/-- A fixed weighted packet score when `c` is the canonical line. -/
noncomputable def weightedLineScore
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A B : ℝ) (w : ι → ℝ) (c : ι) : ℝ :=
  A * w c + B * Finset.sum (Finset.univ.erase c) w

/-- Summing a fixed weighted packet over all possible canonical lines depends
only on the total weight and the scalar `A + (card - 1) B`. -/
theorem sum_weightedLineScore
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (A B : ℝ) (w : ι → ℝ) :
    Finset.sum Finset.univ (fun c => weightedLineScore A B w c) =
      (A + ((Fintype.card ι : ℝ) - 1) * B) *
        Finset.sum Finset.univ w := by
  classical
  let T : ℝ := Finset.sum Finset.univ w
  have hinner (c : ι) :
      Finset.sum (Finset.univ.erase c) w = T - w c := by
    have h := Finset.sum_erase_add Finset.univ w (Finset.mem_univ c)
    dsimp [T]
    linarith
  have hconst :
      Finset.sum Finset.univ (fun _c : ι => T) =
        (Fintype.card ι : ℝ) * T := by
    simp
  have hsumw : Finset.sum Finset.univ w = T := rfl
  simp_rw [weightedLineScore, hinner]
  rw [Finset.sum_add_distrib, ← Finset.mul_sum, ← Finset.mul_sum,
    Finset.sum_sub_distrib, hconst, hsumw]
  dsimp [T]
  ring

/-- The canonical contribution plus `ell` noncanonical contributions is zero. -/
theorem tateLineCoefficient_balance
    {ell : ℕ} (hell : 0 < ell) :
    canonicalTateLineCoefficient ell +
      (ell : ℝ) * noncanonicalTateLineCoefficient ell = 0 := by
  have hell0 : (ell : ℝ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hell)
  unfold canonicalTateLineCoefficient noncanonicalTateLineCoefficient
  field_simp [hell0]
  ring

/-- **Galois-average no-go theorem.**  If the cyclic lines form a projective
orbit of cardinality `ell + 1`, every fixed place-independent weighted packet
has total score zero. -/
theorem fixedPacket_totalScore_eq_zero
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    {ell : ℕ} (hell : 0 < ell)
    (hcard : Fintype.card ι = ell + 1)
    (w : ι → ℝ) :
    Finset.sum Finset.univ
      (fun c => weightedLineScore
        (canonicalTateLineCoefficient ell)
        (noncanonicalTateLineCoefficient ell) w c) = 0 := by
  rw [sum_weightedLineScore]
  have hcast : ((Fintype.card ι : ℝ) - 1) = (ell : ℝ) := by
    rw [hcard]
    norm_num
  rw [hcast, tateLineCoefficient_balance hell, zero_mul]

/-- The unweighted full packet is a special case of the fixed-packet no-go
statement. -/
theorem fullTorsionPacket_totalScore_eq_zero
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    {ell : ℕ} (hell : 0 < ell)
    (hcard : Fintype.card ι = ell + 1) :
    Finset.sum (Finset.univ : Finset ι)
      (fun c : ι => weightedLineScore
        (ι := ι)
        (canonicalTateLineCoefficient ell)
        (noncanonicalTateLineCoefficient ell)
        (fun _ : ι => (1 : ℝ)) c) = 0 := by
  exact fixedPacket_totalScore_eq_zero
    (ι := ι) (ell := ell) hell hcard (fun _ : ι => (1 : ℝ))

/-- **Projective-dimension barrier.**  The generic `1 / (ell + 1)` fraction of
the canonical/noncanonical coefficient gap exactly cancels the noncanonical
baseline. -/
theorem tateLine_projectiveDimensionBarrier
    {ell : ℕ} (hell : 0 < ell) :
    noncanonicalTateLineCoefficient ell +
      (canonicalTateLineCoefficient ell -
        noncanonicalTateLineCoefficient ell) / ((ell : ℝ) + 1) = 0 := by
  have hell0 : (ell : ℝ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hell)
  have hell1 : (ell : ℝ) + 1 ≠ 0 := by positivity
  unfold canonicalTateLineCoefficient noncanonicalTateLineCoefficient
  field_simp [hell0, hell1]
  ring

/-- The canonical Tate coefficient is exactly one sixth of the classical
highest-Hodge-line degree `(ell - 1) / 2`. -/
theorem canonicalTateLineCoefficient_eq_oneSixth_hodgeDegree
    (ell : ℕ) :
    canonicalTateLineCoefficient ell =
      (1 / 6 : ℝ) * (((ell : ℝ) - 1) / 2) := by
  unfold canonicalTateLineCoefficient
  ring

end IUTThreeClosures
