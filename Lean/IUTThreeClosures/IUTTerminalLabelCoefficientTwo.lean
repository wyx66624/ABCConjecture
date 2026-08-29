/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualBadPlaceProcessionAssembly
import IUTThreeClosures.SymmetricProductCoefficientBarrier
import Mathlib.Tactic

/-!
# The terminal-label coefficient-two threshold

The standard IUT procession averages the distinguished square labels
`1, ..., n`, where the admissible prime is `ell = 2*n+1`.  At label `j`, the
scalar comparison has q-gain `j^2-1` and support cost `j+1`.  After using that
the Frey q-divisor has twice the symmetric-product logarithm, the resulting
coefficient is

`ell * (j+1) / (j^2-1) = ell / (j-1)`.

Thus the terminal label `j=n` is optimal among all nonnegative weighted label
readings and gives

`(2*n+1)/(n-1) = 2 + 3/(n-1)`.

It approaches the coefficient two required by
`SymmetricProductCoefficientBarrier`, whereas the standard uniform procession
has coefficient

`3*(2*n+1)*(n+3)/((2*n+5)*(n-1))`

and approaches three.  The file also proves that the terminal label is an
actual finite-positive local region already constructed in the source-faithful
bad-place procession.  What is not asserted is the missing global theorem that
this terminal slice, rather than the standard procession average, is bounded
by a genuine source-derived theta possible-image hull.
-/

namespace IUTThreeClosures
namespace IUTTerminalLabelCoefficientTwo

open scoped BigOperators

noncomputable section

/-- The q-gain at a square label after subtracting the q-pilot left side. -/
def labelGain (j : ℝ) : ℝ := j ^ 2 - 1

/-- The linear support/error cost at label `j`. -/
def labelCost (j : ℝ) : ℝ := j + 1

/-- Coefficient obtained after converting the Frey q-divisor to
`log(a*b*c)`. -/
def coefficientFromGain (ell gain cost : ℝ) : ℝ :=
  ell * cost / gain

/-- Product coefficient obtained from the terminal label `j=n` and
`ell=2*n+1`. -/
def terminalProductCoefficient (n : ℝ) : ℝ :=
  (2 * n + 1) / (n - 1)

/-- Product coefficient obtained from the uniform average of labels
`1, ..., n`. -/
def standardProductCoefficient (n : ℝ) : ℝ :=
  3 * (2 * n + 1) * (n + 3) /
    ((2 * n + 5) * (n - 1))

/-- The terminal coefficient has the exact coefficient-two expansion. -/
theorem terminalProductCoefficient_eq_two_add
    {n : ℝ} (hn : n ≠ 1) :
    terminalProductCoefficient n = 2 + 3 / (n - 1) := by
  unfold terminalProductCoefficient
  field_simp [sub_ne_zero.mpr hn]
  ring

/-- At every finite admissible procession length, the terminal coefficient is
strictly larger than two. -/
theorem two_lt_terminalProductCoefficient
    {n : ℝ} (hn : 1 < n) :
    2 < terminalProductCoefficient n := by
  rw [terminalProductCoefficient_eq_two_add (ne_of_gt hn)]
  have hden : 0 < n - 1 := sub_pos.mpr hn
  have hfrac : 0 < 3 / (n - 1) := div_pos (by norm_num) hden
  linarith

/-- The terminal coefficient enters any prescribed coefficient-two window
once `3 < epsilon*(n-1)`. -/
theorem terminalProductCoefficient_lt_two_add
    {n epsilon : ℝ}
    (hn : 1 < n)
    (hbudget : 3 < epsilon * (n - 1)) :
    terminalProductCoefficient n < 2 + epsilon := by
  rw [terminalProductCoefficient_eq_two_add (ne_of_gt hn)]
  have hden : 0 < n - 1 := sub_pos.mpr hn
  have hfrac : 3 / (n - 1) < epsilon := by
    apply (div_lt_iff₀ hden).2
    simpa [mul_comm] using hbudget
  linarith

/-- Exact expansion of the standard uniform-procession coefficient. -/
theorem standardProductCoefficient_eq_three_add
    {n : ℝ} (hn : 1 < n) :
    standardProductCoefficient n =
      3 + 12 * (n + 2) / ((n - 1) * (2 * n + 5)) := by
  have h₁ : n - 1 ≠ 0 := ne_of_gt (sub_pos.mpr hn)
  have h₂ : 2 * n + 5 ≠ 0 := by nlinarith
  unfold standardProductCoefficient
  field_simp [h₁, h₂]
  ring

/-- The standard procession coefficient remains strictly above three. -/
theorem three_lt_standardProductCoefficient
    {n : ℝ} (hn : 1 < n) :
    3 < standardProductCoefficient n := by
  rw [standardProductCoefficient_eq_three_add hn]
  have hleft : 0 < n - 1 := sub_pos.mpr hn
  have hright : 0 < 2 * n + 5 := by nlinarith
  have hden : 0 < (n - 1) * (2 * n + 5) := mul_pos hleft hright
  have hnum : 0 < 12 * (n + 2) := by nlinarith
  have hfrac :
      0 < 12 * (n + 2) / ((n - 1) * (2 * n + 5)) :=
    div_pos hnum hden
  linarith

/-- The terminal-label coefficient is strictly smaller than the coefficient
of the standard uniform procession. -/
theorem terminalProductCoefficient_lt_standard
    {n : ℝ} (hn : 1 < n) :
    terminalProductCoefficient n < standardProductCoefficient n := by
  have h₁ : n - 1 ≠ 0 := ne_of_gt (sub_pos.mpr hn)
  have h₂ : 2 * n + 5 ≠ 0 := by nlinarith
  have hdiff :
      standardProductCoefficient n - terminalProductCoefficient n =
        (n + 4) * (2 * n + 1) /
          ((n - 1) * (2 * n + 5)) := by
    unfold standardProductCoefficient terminalProductCoefficient
    field_simp [h₁, h₂]
    ring
  have hden : 0 < (n - 1) * (2 * n + 5) := by
    apply mul_pos
    · linarith
    · nlinarith
  have hnum : 0 < (n + 4) * (2 * n + 1) := by
    apply mul_pos <;> nlinarith
  have hpos :
      0 < standardProductCoefficient n - terminalProductCoefficient n := by
    rw [hdiff]
    exact div_pos hnum hden
  linarith

/-- The terminal coefficient is exactly the gain/cost quotient at `j=n`. -/
theorem coefficientFromGain_terminal
    {n : ℝ} (hn : 1 < n) :
    coefficientFromGain (2 * n + 1) (labelGain n) (labelCost n) =
      terminalProductCoefficient n := by
  have hgain : 0 < labelGain n := by
    unfold labelGain
    nlinarith
  have hden : n - 1 ≠ 0 := ne_of_gt (sub_pos.mpr hn)
  unfold coefficientFromGain labelGain labelCost terminalProductCoefficient
  field_simp [hgain.ne', hden]
  ring

/-- Mean square label of the standard uniform procession. -/
def standardSquareMean (n : ℝ) : ℝ :=
  (n + 1) * (2 * n + 1) / 6

/-- Mean linear cost of the standard uniform procession. -/
def standardLinearMean (n : ℝ) : ℝ :=
  (n + 3) / 2

/-- Gain of the standard average after subtracting the q-pilot left side. -/
def standardGain (n : ℝ) : ℝ := standardSquareMean n - 1

/-- Factorization of the standard average gain. -/
theorem standardGain_factor (n : ℝ) :
    standardGain n = (2 * n + 5) * (n - 1) / 6 := by
  unfold standardGain standardSquareMean
  ring

/-- The standard uniform moments give the stated coefficient-three family. -/
theorem coefficientFromGain_standard
    {n : ℝ} (hn : 1 < n) :
    coefficientFromGain (2 * n + 1) (standardGain n)
        (standardLinearMean n) =
      standardProductCoefficient n := by
  have h₁ : n - 1 ≠ 0 := ne_of_gt (sub_pos.mpr hn)
  have h₂ : 2 * n + 5 ≠ 0 := by nlinarith
  rw [standardGain_factor]
  unfold coefficientFromGain standardLinearMean
    standardProductCoefficient
  field_simp [h₁, h₂]
  ring

/-- Weighted gain of labels `1, ..., n`; the weight at index `i` belongs to
label `i+1`. -/
def weightedLabelGain (n : ℕ) (weight : ℕ → ℝ) : ℝ :=
  ∑ i ∈ Finset.range n,
    weight i * labelGain ((i : ℝ) + 1)

/-- Weighted linear cost of labels `1, ..., n`. -/
def weightedLabelCost (n : ℕ) (weight : ℕ → ℝ) : ℝ :=
  ∑ i ∈ Finset.range n,
    weight i * labelCost ((i : ℝ) + 1)

/-- For every nonnegative weighting, gain is at most `(n-1)` times cost.
This is the sharp finite-dimensional optimization behind terminal-label
selection. -/
theorem weightedLabelGain_le_terminalFactor_mul_cost
    (n : ℕ) (weight : ℕ → ℝ)
    (hweight : ∀ i ∈ Finset.range n, 0 ≤ weight i) :
    weightedLabelGain n weight ≤
      ((n : ℝ) - 1) * weightedLabelCost n weight := by
  unfold weightedLabelGain weightedLabelCost
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  have hiNat : i < n := Finset.mem_range.mp hi
  have hiSucc : i + 1 ≤ n := Nat.succ_le_iff.mpr hiNat
  have hiReal : (i : ℝ) + 1 ≤ (n : ℝ) := by
    exact_mod_cast hiSucc
  have hfactor :
      labelGain ((i : ℝ) + 1) ≤
        ((n : ℝ) - 1) * labelCost ((i : ℝ) + 1) := by
    unfold labelGain labelCost
    nlinarith
  calc
    weight i * labelGain ((i : ℝ) + 1) ≤
        weight i *
          (((n : ℝ) - 1) * labelCost ((i : ℝ) + 1)) :=
      mul_le_mul_of_nonneg_left hfactor (hweight i hi)
    _ = ((n : ℝ) - 1) *
        (weight i * labelCost ((i : ℝ) + 1)) := by ring

/-- No nonnegative weighted label packet can have a smaller product
coefficient than the terminal label. -/
theorem coefficient_ge_terminal_of_weighted_comparison
    {n : ℕ} {weight : ℕ → ℝ} {ell coefficient : ℝ}
    (hn : 1 < n)
    (hweight : ∀ i ∈ Finset.range n, 0 ≤ weight i)
    (hcost : 0 < weightedLabelCost n weight)
    (hcoefficient : 0 ≤ coefficient)
    (hcomparison :
      ell * weightedLabelCost n weight ≤
        coefficient * weightedLabelGain n weight) :
    ell / ((n : ℝ) - 1) ≤ coefficient := by
  have hgain :=
    weightedLabelGain_le_terminalFactor_mul_cost n weight hweight
  have hscaled :
      coefficient * weightedLabelGain n weight ≤
        coefficient *
          (((n : ℝ) - 1) * weightedLabelCost n weight) :=
    mul_le_mul_of_nonneg_left hgain hcoefficient
  have htotal := hcomparison.trans hscaled
  have hell : ell ≤ coefficient * ((n : ℝ) - 1) := by
    apply (mul_le_mul_right hcost).mp
    calc
      ell * weightedLabelCost n weight ≤
          coefficient *
            (((n : ℝ) - 1) * weightedLabelCost n weight) := htotal
      _ = (coefficient * ((n : ℝ) - 1)) *
          weightedLabelCost n weight := by ring
  have hnReal : (1 : ℝ) < n := by exact_mod_cast hn
  have hden : 0 < (n : ℝ) - 1 := sub_pos.mpr hnReal
  apply (div_le_iff₀ hden).2
  simpa [mul_comm] using hell

/-- A standard-coefficient inequality does not, by scalar algebra alone,
force the strictly stronger terminal-coefficient inequality. -/
theorem standard_bound_does_not_force_terminal_bound
    {n : ℝ} (hn : 1 < n) :
    ∃ product count : ℝ,
      0 < count ∧
      product ≤ standardProductCoefficient n * count ∧
      ¬ product ≤ terminalProductCoefficient n * count := by
  have hstrict := terminalProductCoefficient_lt_standard hn
  let count : ℝ := 1
  let product : ℝ :=
    (terminalProductCoefficient n + standardProductCoefficient n) / 2
  refine ⟨product, count, by norm_num [count], ?_, ?_⟩
  · dsimp [product, count]
    nlinarith
  · dsimp [product, count]
    intro hterminal
    nlinarith

/-! ## The terminal slice already exists in the actual local source -/

open Iut

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- The last capsule index belongs to the standard procession. -/
theorem terminalCapsuleIndex_mem :
    ActualBadPlaceProcessionAssembly.processionLength D - 1 ∈
      Finset.range (ActualBadPlaceProcessionAssembly.processionLength D) := by
  rw [Finset.mem_range]
  have hpos :=
    ActualBadPlaceProcessionAssembly.processionLength_pos (D := D)
  omega

/-- The terminal distinguished-label packet has the exact square-label local
Haar volume.  This is an unconditional theorem about the already constructed
finite-positive source. -/
theorem terminalLabelPacketLog_eq
    (Q : QPilotData D) :
    ActualBadPlaceProcessionAssembly.distinguishedLabelPacketLog Q
        (ActualBadPlaceProcessionAssembly.processionLength D - 1) =
      (ActualBadPlaceProcessionAssembly.processionLength D : ℝ) ^ 2 *
        ActualBadPlaceQPilotPacket.signedHaarLogSum Q := by
  have hpos :=
    ActualBadPlaceProcessionAssembly.processionLength_pos (D := D)
  have hone : 1 ≤ ActualBadPlaceProcessionAssembly.processionLength D := hpos
  simpa [Nat.sub_add_cancel hone] using
    (ActualBadPlaceProcessionAssembly.
      distinguishedLabelPacketLog_eq_sq_mul_signedHaarLogSum
        Q (ActualBadPlaceProcessionAssembly.processionLength D - 1))

/-- At each bad-place coordinate, the terminal component is literally the
log-volume of the actual finite-positive square-label region. -/
theorem terminalComponentLog_eq_actualRegion
    (Q : QPilotData D)
    (w : ActualBadPlaceQPilotPacket.Index Q) :
    ActualBadPlaceProcessionAssembly.componentLog Q
        (ActualBadPlaceProcessionAssembly.processionLength D - 1) w =
      ((ActualBadPlaceQPilotPacket.place Q w).squareLabelRegion
        (ActualBadPlaceProcessionAssembly.processionLength D)).logVolume := by
  have hpos :=
    ActualBadPlaceProcessionAssembly.processionLength_pos (D := D)
  have hone : 1 ≤ ActualBadPlaceProcessionAssembly.processionLength D := hpos
  simpa [Nat.sub_add_cancel hone] using
    (ActualBadPlaceProcessionAssembly.
      componentLog_eq_squareLabelRegion_logVolume
        Q (ActualBadPlaceProcessionAssembly.processionLength D - 1) w)

#print axioms terminalProductCoefficient_eq_two_add
#print axioms two_lt_terminalProductCoefficient
#print axioms terminalProductCoefficient_lt_two_add
#print axioms standardProductCoefficient_eq_three_add
#print axioms three_lt_standardProductCoefficient
#print axioms terminalProductCoefficient_lt_standard
#print axioms coefficientFromGain_terminal
#print axioms coefficientFromGain_standard
#print axioms weightedLabelGain_le_terminalFactor_mul_cost
#print axioms coefficient_ge_terminal_of_weighted_comparison
#print axioms standard_bound_does_not_force_terminal_bound
#print axioms terminalCapsuleIndex_mem
#print axioms terminalLabelPacketLog_eq
#print axioms terminalComponentLog_eq_actualRegion

end
end IUTTerminalLabelCoefficientTwo
end IUTThreeClosures
