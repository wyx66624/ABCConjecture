/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MultiLabelPacketQPilot
import IUTThreeClosures.ActualBadPlaceProcessionAssembly

/-!
# Repeated-label overcount in the standard IUT procession

The standard procession of length `n` has capsule `i` with labels
`S_(i+2) = {0, ..., i+1}`. The verified bad-place assembly currently charges
only the distinguished new label `i+1`, producing the square coefficient

`D_n = Σ_(j=1)^n j^2`.

A different, tempting model is to keep every occurrence of every inherited
label as an independent q-scaled coordinate. Additive product-weight
marginalization then gives the coefficient

`T_n = Σ_(i=0)^(n-1) Σ_(j=0)^(i+1) j^2`.

This file proves

`T_n = n (n+1)^2 (n+2) / 12`

and, after procession normalization,

`T_n/n - D_n/n = n(n-1)(n+1)/12`.

Since an initial theta prime is at least five, the actual procession length is
at least two, so the excess is strictly positive. Therefore the naive
all-occurrence product agrees with the distinguished-label procession only
when the signed q-packet logarithm is zero; for a negative q-packet logarithm
it is strictly more negative.

This is a no-go theorem for one source model. It is not a proof or disproof of
abc, and it does not construct the missing IUT III possible-image or
multiradial/AHS comparison.
-/

namespace IUTThreeClosures

noncomputable section

open Iut
open scoped BigOperators

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

namespace RepeatedLabelProcessionOvercount

open ActualBadPlaceQPilotPacket
open ActualBadPlaceProcessionAssembly

private theorem procLabels_eq_range_succ (n : ℕ) :
    Iut.procLabels n = Finset.range (n + 1) := by
  ext j
  simp [Iut.procLabels]

/-- Sum of the squares of all labels in the terminal capsule `S_(n+1)`. -/
noncomputable def terminalCapsuleSquareMass (n : ℕ) : ℝ :=
  ∑ j ∈ Iut.procLabels n, ((j : ℝ) ^ 2)

/-- Sum of the square contributions of the distinguished new label in every
capsule. -/
noncomputable def distinguishedIncrementSquareMass (n : ℕ) : ℝ :=
  ∑ i ∈ Finset.range n, ((((i + 1 : ℕ) : ℝ)) ^ 2)

/-- Sum of the square contributions of every label occurrence in every
capsule of the standard procession. -/
noncomputable def repeatedLabelSquareMass (n : ℕ) : ℝ :=
  ∑ i ∈ Finset.range n,
    ∑ j ∈ Iut.procLabels (i + 1), ((j : ℝ) ^ 2)

private theorem range_succ_sq_sum (n : ℕ) :
    (∑ j ∈ Finset.range (n + 1), ((j : ℝ) ^ 2)) =
      (n : ℝ) * ((n : ℝ) + 1) *
        (2 * (n : ℝ) + 1) / 6 := by
  induction n with
  | zero =>
      simp
  | succ n ih =>
      rw [Finset.sum_range_succ, ih]
      push_cast
      ring

/-- The labels in one standard capsule have the classical square sum. -/
theorem terminalCapsuleSquareMass_formula (n : ℕ) :
    terminalCapsuleSquareMass n =
      (n : ℝ) * ((n : ℝ) + 1) *
        (2 * (n : ℝ) + 1) / 6 := by
  rw [terminalCapsuleSquareMass, procLabels_eq_range_succ]
  exact range_succ_sq_sum n

/-- The distinguished labels across the procession are exactly the positive
labels of the terminal capsule, counted once. -/
theorem distinguishedIncrementSquareMass_formula (n : ℕ) :
    distinguishedIncrementSquareMass n =
      (n : ℝ) * ((n : ℝ) + 1) *
        (2 * (n : ℝ) + 1) / 6 := by
  induction n with
  | zero =>
      simp [distinguishedIncrementSquareMass]
  | succ n ih =>
      rw [distinguishedIncrementSquareMass, Finset.sum_range_succ]
      change distinguishedIncrementSquareMass n +
        ((((n + 1 : ℕ) : ℝ)) ^ 2) = _
      rw [ih]
      push_cast
      ring

theorem distinguishedIncrementSquareMass_eq_terminalCapsuleSquareMass
    (n : ℕ) :
    distinguishedIncrementSquareMass n =
      terminalCapsuleSquareMass n := by
  rw [distinguishedIncrementSquareMass_formula,
    terminalCapsuleSquareMass_formula]

/-- Closed formula for the naive sum over every inherited label occurrence. -/
theorem repeatedLabelSquareMass_formula (n : ℕ) :
    repeatedLabelSquareMass n =
      (n : ℝ) * ((n : ℝ) + 1) ^ 2 *
        ((n : ℝ) + 2) / 12 := by
  induction n with
  | zero =>
      simp [repeatedLabelSquareMass]
  | succ n ih =>
      rw [repeatedLabelSquareMass, Finset.sum_range_succ]
      change repeatedLabelSquareMass n +
        (∑ j ∈ Iut.procLabels (n + 1), ((j : ℝ) ^ 2)) = _
      rw [ih]
      change
        (n : ℝ) * ((n : ℝ) + 1) ^ 2 *
            ((n : ℝ) + 2) / 12 +
          terminalCapsuleSquareMass (n + 1) = _
      rw [terminalCapsuleSquareMass_formula]
      push_cast
      ring

/-- Average coefficient obtained by treating every inherited occurrence as an
independent q-scaled factor. -/
noncomputable def repeatedLabelAverageCoefficient (n : ℕ) : ℝ :=
  (1 / (n : ℝ)) * repeatedLabelSquareMass n

/-- Correct average coefficient obtained from one new label per capsule. -/
noncomputable def distinguishedLabelAverageCoefficient (n : ℕ) : ℝ :=
  (1 / (n : ℝ)) * distinguishedIncrementSquareMass n

theorem repeatedLabelAverageCoefficient_formula
    {n : ℕ} (hn : 0 < n) :
    repeatedLabelAverageCoefficient n =
      ((n : ℝ) + 1) ^ 2 * ((n : ℝ) + 2) / 12 := by
  rw [repeatedLabelAverageCoefficient,
    repeatedLabelSquareMass_formula]
  have hn0 : (n : ℝ) ≠ 0 := by
    exact_mod_cast Nat.ne_of_gt hn
  field_simp [hn0]

theorem distinguishedLabelAverageCoefficient_formula
    {n : ℕ} (hn : 0 < n) :
    distinguishedLabelAverageCoefficient n =
      ((n : ℝ) + 1) * (2 * (n : ℝ) + 1) / 6 := by
  rw [distinguishedLabelAverageCoefficient,
    distinguishedIncrementSquareMass_formula]
  have hn0 : (n : ℝ) ≠ 0 := by
    exact_mod_cast Nat.ne_of_gt hn
  field_simp [hn0]

/-- Exact normalized excess caused by recounting inherited labels. -/
theorem repeatedLabelAverageCoefficient_sub_distinguished
    {n : ℕ} (hn : 0 < n) :
    repeatedLabelAverageCoefficient n -
        distinguishedLabelAverageCoefficient n =
      (n : ℝ) * ((n : ℝ) - 1) *
        ((n : ℝ) + 1) / 12 := by
  rw [repeatedLabelAverageCoefficient_formula hn,
    distinguishedLabelAverageCoefficient_formula hn]
  ring

theorem distinguishedLabelAverageCoefficient_lt_repeated
    {n : ℕ} (hn : 2 ≤ n) :
    distinguishedLabelAverageCoefficient n <
      repeatedLabelAverageCoefficient n := by
  have hnpos : 0 < n := lt_of_lt_of_le (by norm_num) hn
  rw [← sub_pos]
  rw [repeatedLabelAverageCoefficient_sub_distinguished hnpos]
  have hnR : (2 : ℝ) ≤ (n : ℝ) := by
    exact_mod_cast hn
  have h0 : 0 < (n : ℝ) := by
    linarith
  have h1 : 0 < (n : ℝ) - 1 := by
    linarith
  have h2 : 0 < (n : ℝ) + 1 := by
    linarith
  positivity

/-- The actual standard procession has at least two capsules because the
admissible prime satisfies `ell >= 5`. -/
theorem processionLength_two_le (D : InitialThetaData AG TG) :
    2 ≤ processionLength D := by
  have hfive : 5 ≤ D.ℓ := by
    simpa [InitialThetaData.ℓ] using D.prime.five_le
  rw [processionLength]
  omega

/-- The repository's `squareAverage` is the distinguished-label average. -/
theorem distinguishedLabelAverageCoefficient_eq_squareAverage
    (D : InitialThetaData AG TG) :
    distinguishedLabelAverageCoefficient (processionLength D) =
      squareAverage D := by
  rw [distinguishedLabelAverageCoefficient_formula
    (processionLength_pos (D := D))]
  rw [squareAverage]
  ring

/-- On every genuine initial theta datum, recounting all inherited labels
strictly increases the scalar coefficient. -/
theorem squareAverage_lt_repeatedLabelAverageCoefficient
    (D : InitialThetaData AG TG) :
    squareAverage D <
      repeatedLabelAverageCoefficient (processionLength D) := by
  rw [← distinguishedLabelAverageCoefficient_eq_squareAverage D]
  exact distinguishedLabelAverageCoefficient_lt_repeated
    (processionLength_two_le D)

/-- Naive procession average obtained by scaling every label occurrence in
every capsule. -/
noncomputable def repeatedLabelProcessionAverage
    (Q : QPilotData D) : ℝ :=
  repeatedLabelAverageCoefficient (processionLength D) *
    signedHaarLogSum Q

/-- Exact excess coefficient in the actual standard procession. -/
noncomputable def inheritedLabelExcessCoefficient
    (D : InitialThetaData AG TG) : ℝ :=
  let n : ℝ := processionLength D
  n * (n - 1) * (n + 1) / 12

theorem inheritedLabelExcessCoefficient_pos
    (D : InitialThetaData AG TG) :
    0 < inheritedLabelExcessCoefficient D := by
  have hn : (2 : ℝ) ≤ (processionLength D : ℝ) := by
    exact_mod_cast processionLength_two_le D
  rw [inheritedLabelExcessCoefficient]
  have h0 : 0 < (processionLength D : ℝ) := by
    linarith
  have h1 : 0 < (processionLength D : ℝ) - 1 := by
    linarith
  have h2 : 0 < (processionLength D : ℝ) + 1 := by
    linarith
  positivity

/-- The naive full-capsule average differs from the verified distinguished
average by the exact inherited-label excess times the signed q-packet log. -/
theorem repeatedLabelProcessionAverage_sub_processionAverage
    (Q : QPilotData D) :
    repeatedLabelProcessionAverage Q - processionAverage Q =
      inheritedLabelExcessCoefficient D * signedHaarLogSum Q := by
  rw [repeatedLabelProcessionAverage,
    processionAverage_eq_squareAverage_mul_signedHaarLogSum]
  calc
    repeatedLabelAverageCoefficient (processionLength D) *
          signedHaarLogSum Q -
        squareAverage D * signedHaarLogSum Q =
      (repeatedLabelAverageCoefficient (processionLength D) -
          squareAverage D) * signedHaarLogSum Q := by ring
    _ = inheritedLabelExcessCoefficient D * signedHaarLogSum Q := by
      rw [← distinguishedLabelAverageCoefficient_eq_squareAverage D]
      rw [repeatedLabelAverageCoefficient_sub_distinguished
        (processionLength_pos (D := D))]
      rfl

/-- The naive all-occurrence construction can agree with the distinguished
procession only in the degenerate zero-packet case. -/
theorem repeatedLabelProcessionAverage_eq_processionAverage_iff
    (Q : QPilotData D) :
    repeatedLabelProcessionAverage Q = processionAverage Q ↔
      signedHaarLogSum Q = 0 := by
  constructor
  · intro h
    have hz :
        inheritedLabelExcessCoefficient D * signedHaarLogSum Q = 0 := by
      rw [← repeatedLabelProcessionAverage_sub_processionAverage Q]
      exact sub_eq_zero.mpr h
    rcases mul_eq_zero.mp hz with hcoeff | hpacket
    · exact (ne_of_gt (inheritedLabelExcessCoefficient_pos D) hcoeff).elim
    · exact hpacket
  · intro hpacket
    rw [repeatedLabelProcessionAverage,
      processionAverage_eq_squareAverage_mul_signedHaarLogSum,
      hpacket, mul_zero, mul_zero]

/-- For a negative signed q-packet logarithm, the naive all-occurrence average
is strictly too negative. -/
theorem repeatedLabelProcessionAverage_lt_processionAverage
    (Q : QPilotData D) (hneg : signedHaarLogSum Q < 0) :
    repeatedLabelProcessionAverage Q < processionAverage Q := by
  rw [repeatedLabelProcessionAverage,
    processionAverage_eq_squareAverage_mul_signedHaarLogSum]
  exact mul_lt_mul_of_neg_right
    (squareAverage_lt_repeatedLabelAverageCoefficient D) hneg

end RepeatedLabelProcessionOvercount

end
end IUTThreeClosures
