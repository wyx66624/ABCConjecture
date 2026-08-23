/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.QuantifierCorrectPublicFreyTheorem110

/-!
# Rational j-invariants force moduli degree one

The base field of initial theta-data is generally larger than `ℚ`: it must
contain a square root of `-1`, rationalize the required torsion, and support
the chosen local data.  Nevertheless the field of moduli is generated only by
the j-invariant:

`F_mod = ℚ(j(E))`.

Thus whenever the actual source curve has rational j-invariant inside its base
field, `F_mod` is the bottom intermediate field, hence has degree one over
`ℚ`.  For a Frey specialization this reduces the numerical correction in the
public IUT IV Theorem 1.10 bound from

`20 * d_mod / ell`

to the exact expression

`20 / ell`.

This module proves that reduction directly from the definitions.  No choice
of source prime, theta-hull estimate, or abc inequality is assumed.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut

universe u v w z

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {Input : Type z}
variable {F : PointwiseIUTIIIFamily.{u, v, w, z}
  (AG := AG) (TG := TG) Input}

/-- If the j-invariant of initial theta-data comes from `ℚ`, its field of
moduli is the bottom intermediate field. -/
theorem fieldOfModuli_eq_bot_of_j_rational
    (D : InitialThetaData AG TG)
    (hj : ∃ q : ℚ, D.E.j = algebraMap ℚ D.F q) :
    fieldOfModuli D.F D.E = ⊥ := by
  rcases hj with ⟨q, hq⟩
  apply le_antisymm
  · rw [fieldOfModuli, IntermediateField.adjoin_le_iff]
    intro x hx
    simp only [Set.mem_singleton_iff] at hx
    subst x
    rw [IntermediateField.mem_bot]
    exact ⟨q, hq.symm⟩
  · exact bot_le

/-- The field of moduli of rational-j initial theta-data has degree one over
`ℚ`. -/
theorem fieldOfModuli_finrank_eq_one_of_j_rational
    (D : InitialThetaData AG TG)
    (hj : ∃ q : ℚ, D.E.j = algebraMap ℚ D.F q) :
    Module.finrank ℚ ↥(fieldOfModuli D.F D.E) = 1 := by
  rw [fieldOfModuli_eq_bot_of_j_rational D hj]
  have h :=
    (IntermediateField.botEquiv ℚ D.F).toLinearEquiv.finrank_eq
  simpa using h

/-- The canonical real moduli degree occurring in public Theorem 1.10 is
exactly one for rational-j source data. -/
theorem initialThetaModuliDegree_eq_one_of_j_rational
    (D : InitialThetaData AG TG)
    (hj : ∃ q : ℚ, D.E.j = algebraMap ℚ D.F q) :
    initialThetaModuliDegree D = 1 := by
  unfold initialThetaModuliDegree
  rw [fieldOfModuli_finrank_eq_one_of_j_rational D hj]
  norm_num

/-- Elementary absorption lemma for the remaining correction `20 / ell`.
A real lower bound `20 / ε ≤ ell` implies `20 / ell ≤ ε`. -/
theorem twenty_div_le_epsilon_of_threshold
    {ε ell : ℝ}
    (hε : 0 < ε)
    (hell : 20 / ε ≤ ell) :
    20 / ell ≤ ε := by
  have hthreshold : 0 < (20 : ℝ) / ε :=
    div_pos (by norm_num) hε
  have hell_pos : 0 < ell := hthreshold.trans_le hell
  apply (div_le_iff₀ hell_pos).2
  have hmul : (20 : ℝ) ≤ ell * ε :=
    (div_le_iff₀ hε).1 hell
  simpa [mul_comm] using hmul

/-- Under rational-j calibration, the public Frey Theorem 1.10 correction is
exactly `20 / ell`. -/
theorem publicFreyTheorem110Correction_eq_twenty_div_ell
    (B : PublicFreyTheorem110Bridge F)
    (P : ABCPoint)
    (hj : ∃ q : ℚ,
      (F.data (B.encode P)).E.j =
        algebraMap ℚ (F.data (B.encode P)).F q) :
    publicFreyTheorem110Correction B P =
      20 / initialThetaEllReal (F.data (B.encode P)) := by
  unfold publicFreyTheorem110Correction
  rw [initialThetaModuliDegree_eq_one_of_j_rational
    (F.data (B.encode P)) hj]
  ring

/-- A rational-j source whose canonical prime is at least `20 / ε` satisfies
the correction condition required by the quantifier-correct closure. -/
theorem publicFreyTheorem110Correction_le_epsilon_of_rational_j
    (B : PublicFreyTheorem110Bridge F)
    (P : ABCPoint)
    {ε : ℝ}
    (hε : 0 < ε)
    (hj : ∃ q : ℚ,
      (F.data (B.encode P)).E.j =
        algebraMap ℚ (F.data (B.encode P)).F q)
    (hell :
      20 / ε ≤ initialThetaEllReal (F.data (B.encode P))) :
    publicFreyTheorem110Correction B P ≤ ε := by
  rw [publicFreyTheorem110Correction_eq_twenty_div_ell B P hj]
  exact twenty_div_le_epsilon_of_threshold hε hell

end IUTThreeClosures
