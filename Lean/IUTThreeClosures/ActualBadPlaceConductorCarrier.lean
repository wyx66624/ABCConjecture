/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualBadPlaceProcessionAssembly

/-!
# The finite bad-place conductor carrier of the actual q-pilot

This module constructs the reduced effective divisor supported on the actual
finite bad locus of a `QPilotData`.  Its coefficient at every enumerated bad
place is one.  Since a bad Tate parameter has strictly positive integral
uniformizer order, this reduced conductor divisor is pointwise bounded by the
actual arithmetic q-divisor.

## Mathematical statement and proof

For a bad finite place `w`, put

`C_bad(w) = 1` and `Q_q(w) = ord_w(q_w)`.

Badness and the Tate uniformization in initial theta data give
`ord_w(q_w) > 0`; integrality therefore gives `1 <= ord_w(q_w)`.  Hence

`C_bad <= Q_q`

coefficient by coefficient.  Multiplication by the nonnegative arithmetic
place weight `log N(w)`, followed by summation over the finite bad locus,
gives

`sum_w log N(w) <= sum_w ord_w(q_w) log N(w)`.

After division by the positive number-field degree this is the normalized
conductor-support estimate.  The exact local Haar formula also identifies the
right side at `w` with the negative logarithmic volume of the actual Tate
region `q_w O_w`.

Combining this inequality with the already proved procession identity gives
a genuine lower carrier inside the positive procession mass: the square
average times the normalized reduced bad-locus conductor is at most the
normalized mass of the actual distinguished-label procession.

## Boundary

The divisor constructed here is the reduced conductor of the *enumerated
actual bad Tate locus*.  It is not yet identified with the global minimal
conductor of a Frey curve, and it has no archimedean or different component.
In particular, this theorem supplies one finite-place term required by the
IUT IV component estimate; it does not supply the missing global theta-hull
upper estimate or the negative all-place `j` term of Theorem 1.10.
-/

namespace IUTThreeClosures

noncomputable section

open Iut NumberField TateCurvesTheta
open scoped BigOperators

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

namespace ActualBadPlaceConductorCarrier

open ActualBadPlaceQPilotPacket
open ActualBadPlaceProcessionAssembly

/-- The reduced effective arithmetic divisor supported on the actual finite
bad locus.  Every enumerated bad place occurs with coefficient one. -/
noncomputable def badSupportConductorDivisor (Q : QPilotData D) :
    Iut4Sec1.ArithmeticDivisor D.F :=
  ∑ w ∈ Q.badFinset.attach,
    Finsupp.single (.inl w.1) 1

/-- The unnormalized logarithmic degree of the reduced bad-locus divisor. -/
noncomputable def badSupportConductorMass (Q : QPilotData D) : ℝ :=
  ∑ w ∈ Q.badFinset.attach,
    Iut4Sec1.arithmeticPlaceWeight (.inl w.1)

/-- The number-field-degree-normalized reduced bad-locus conductor. -/
noncomputable def normalizedBadSupportConductor (Q : QPilotData D) : ℝ :=
  badSupportConductorMass Q / (Module.finrank ℚ D.F : ℝ)

/-- A bad Tate parameter has integral order at least one. -/
theorem one_le_qOrder (Q : QPilotData D) (w : Index Q) :
    1 ≤ D.prime.qOrder w.1 (Q.mem_bad w.2) := by
  exact Nat.one_le_iff_ne_zero.mpr
    (D.prime.qOrder_pos w.1 (Q.mem_bad w.2)).ne'

/-- The local reduced-conductor weight is bounded by the local q-divisor
weight. -/
theorem local_conductorWeight_le_qWeight
    (Q : QPilotData D) (w : Index Q) :
    Iut4Sec1.arithmeticPlaceWeight (.inl w.1) ≤
      (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
        Iut4Sec1.arithmeticPlaceWeight (.inl w.1) := by
  calc
    Iut4Sec1.arithmeticPlaceWeight (.inl w.1) =
        (1 : ℝ) * Iut4Sec1.arithmeticPlaceWeight (.inl w.1) := by ring
    _ ≤ (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
          Iut4Sec1.arithmeticPlaceWeight (.inl w.1) := by
      apply mul_le_mul_of_nonneg_right
      · exact_mod_cast one_le_qOrder Q w
      · exact Iut4Sec1.arithmeticPlaceWeight_nonneg (.inl w.1)

/-- Equivalently, the local reduced-conductor weight is bounded by the
negative logarithmic Haar volume of the actual Tate region `q_w O_w`. -/
theorem local_conductorWeight_le_neg_entry
    (Q : QPilotData D) (w : Index Q) :
    Iut4Sec1.arithmeticPlaceWeight (.inl w.1) ≤ -entry Q w := by
  calc
    Iut4Sec1.arithmeticPlaceWeight (.inl w.1) ≤
        (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
          Iut4Sec1.arithmeticPlaceWeight (.inl w.1) :=
      local_conductorWeight_le_qWeight Q w
    _ = -entry Q w := by
      rw [entry_eq_neg_qOrder_arithmeticPlaceWeight]
      ring

/-- Coefficientwise divisor estimate: the reduced actual bad-locus
conductor is bounded by the actual arithmetic q-divisor. -/
theorem badSupportConductorDivisor_le_qArithmeticDivisor
    (Q : QPilotData D) :
    badSupportConductorDivisor Q ≤ qArithmeticDivisor Q := by
  classical
  rw [badSupportConductorDivisor, qArithmeticDivisor]
  apply Finset.sum_le_sum
  intro w hw
  intro v
  by_cases hv : v = (.inl w.1 : Iut4Sec1.ArithmeticPlace D.F)
  · subst v
    simpa using (show (1 : ℝ) ≤
      (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) by
        exact_mod_cast one_le_qOrder Q w)
  · simp [hv]

private theorem arithmeticDivisorDegree_single
    (w : Iut4Sec1.ArithmeticPlace D.F) (c : ℝ) :
    Iut4Sec1.arithmeticDivisorDegree
        (Finsupp.single w c : Iut4Sec1.ArithmeticDivisor D.F) =
      c * Iut4Sec1.arithmeticPlaceWeight w := by
  classical
  simp [Iut4Sec1.arithmeticDivisorDegree]

/-- The explicit reduced divisor has exactly the expected logarithmic
support mass. -/
theorem arithmeticDivisorDegree_badSupportConductorDivisor
    (Q : QPilotData D) :
    Iut4Sec1.arithmeticDivisorDegree (badSupportConductorDivisor Q) =
      badSupportConductorMass Q := by
  classical
  rw [badSupportConductorDivisor, badSupportConductorMass]
  change
    Iut4Sec1.arithmeticDivisorDegreeHom
      (∑ w ∈ Q.badFinset.attach,
        Finsupp.single (.inl w.1) 1) = _
  simp only [map_sum, Iut4Sec1.arithmeticDivisorDegreeHom_apply,
    arithmeticDivisorDegree_single, one_mul]

/-- Global finite-place estimate obtained by summing the proved local
inequalities. -/
theorem badSupportConductorMass_le_arithmeticMass
    (Q : QPilotData D) :
    badSupportConductorMass Q ≤ arithmeticMass Q := by
  classical
  rw [badSupportConductorMass, arithmeticMass]
  exact Finset.sum_le_sum fun w hw => local_conductorWeight_le_qWeight Q w

/-- Divisor-degree form of the same finite-place estimate. -/
theorem badSupportConductorDegree_le_qDivisorDegree
    (Q : QPilotData D) :
    Iut4Sec1.arithmeticDivisorDegree (badSupportConductorDivisor Q) ≤
      Iut4Sec1.arithmeticDivisorDegree (qArithmeticDivisor Q) := by
  rw [arithmeticDivisorDegree_badSupportConductorDivisor,
    ActualBadPlaceQPilotPacket.arithmeticDivisorDegree_qArithmeticDivisor_eq_arithmeticMass]
  exact badSupportConductorMass_le_arithmeticMass Q

/-- The normalized reduced conductor is bounded by the source-faithful
normalized q logarithm. -/
theorem normalizedBadSupportConductor_le_arithmeticLogQ
    (Q : QPilotData D) :
    normalizedBadSupportConductor Q ≤ arithmeticLogQ Q := by
  rw [normalizedBadSupportConductor, arithmeticLogQ,
    Iut4Sec1.normalizedArithmeticDivisorDegree,
    ActualBadPlaceQPilotPacket.arithmeticDivisorDegree_qArithmeticDivisor_eq_arithmeticMass]
  exact div_le_div_of_nonneg_right
    (badSupportConductorMass_le_arithmeticMass Q) (by positivity)

/-- The square-average coefficient is nonnegative. -/
theorem squareAverage_nonneg : 0 ≤ squareAverage D := by
  unfold squareAverage
  positivity

/-- The finite bad-locus conductor provides a genuine lower carrier inside
the positive mass of the actual distinguished-label procession. -/
theorem squareAverage_mul_normalizedBadSupportConductor_le_processionMass
    (Q : QPilotData D) :
    squareAverage D * normalizedBadSupportConductor Q ≤
      normalizedProcessionMass Q := by
  rw [normalizedProcessionMass_eq_squareAverage_mul_arithmeticLogQ]
  exact mul_le_mul_of_nonneg_left
    (normalizedBadSupportConductor_le_arithmeticLogQ Q)
    squareAverage_nonneg

end ActualBadPlaceConductorCarrier

end
end IUTThreeClosures
