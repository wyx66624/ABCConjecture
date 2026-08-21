import Iut.Cor312.LeftHandSide
import Iut4Sec1.Global.ArithmeticDivisor

/-!
# The arithmetic q-divisor and the normalization of the public q scalar

The q-order in the public Tate-parameter library is the uniformizer-normalized
integer order.  The arithmetic q-divisor therefore has this order as its
finite-place coefficient.  Its normalized degree is the source-faithful
`log(q)` of IUT IV, Definition 1.9 and Theorem 1.10.

The public `QPilotData.logQ` agrees with this degree precisely when its weight
field is compatible with the arithmetic-place weight.  This exposes, rather
than hides, the normalization condition on the public statement interface.
-/

namespace IUTThreeClosures

open scoped BigOperators
open NumberField

universe u

variable {AG : Iut.AnabelianGeometry.{u}} {TG : Iut.TemperedGeometry AG}
variable {D : Iut.InitialThetaData AG TG}

/-- The effective arithmetic divisor whose coefficient at a bad finite place
is the normalized uniformizer order of the Tate parameter. -/
noncomputable def qArithmeticDivisor (Q : Iut.QPilotData D) :
    Iut4Sec1.ArithmeticDivisor D.F :=
  ∑ w ∈ Q.badFinset.attach,
    Finsupp.single (.inl w.1)
      (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ)

/-- The source-faithful global q-logarithm: normalized arithmetic-divisor
 degree of the q-divisor. -/
noncomputable def arithmeticLogQ (Q : Iut.QPilotData D) : ℝ :=
  Iut4Sec1.normalizedArithmeticDivisorDegree (qArithmeticDivisor Q)

/-- Exact compatibility required of the scalar weights in the public
`QPilotData` interface.  It is stated at the level actually used in the sum,
so it is independent of a choice of notation for ramification and inertia
indices. -/
def QPilotWeightDegreeCompatible (Q : Iut.QPilotData D) : Prop :=
  ∀ w (_hw : w ∈ Q.badFinset),
    Q.weight w * Real.log (Iut.residueChar w) =
      Iut4Sec1.arithmeticPlaceWeight (.inl w) /
        (Module.finrank ℚ D.F : ℝ)

private theorem arithmeticDivisorDegree_single
    (w : Iut4Sec1.ArithmeticPlace D.F) (c : ℝ) :
    Iut4Sec1.arithmeticDivisorDegree
        (Finsupp.single w c : Iut4Sec1.ArithmeticDivisor D.F) =
      c * Iut4Sec1.arithmeticPlaceWeight w := by
  classical
  simp [Iut4Sec1.arithmeticDivisorDegree]

/-- Expansion of the normalized degree of the explicit q-divisor. -/
theorem arithmeticLogQ_eq_sum (Q : Iut.QPilotData D) :
    arithmeticLogQ Q =
      ∑ w ∈ Q.badFinset.attach,
        (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
          Iut4Sec1.arithmeticPlaceWeight (.inl w.1) /
            (Module.finrank ℚ D.F : ℝ) := by
  classical
  rw [arithmeticLogQ, Iut4Sec1.normalizedArithmeticDivisorDegree,
    qArithmeticDivisor]
  change
    Iut4Sec1.arithmeticDivisorDegreeHom
        (∑ w ∈ Q.badFinset.attach,
          Finsupp.single (.inl w.1)
            (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ)) /
        (Module.finrank ℚ D.F : ℝ) = _
  simp only [map_sum, Iut4Sec1.arithmeticDivisorDegreeHom_apply,
    arithmeticDivisorDegree_single]
  rw [Finset.sum_div]

/-- Under the exact arithmetic-degree weight compatibility, the public scalar
`QPilotData.logQ` is the normalized degree of the actual q-divisor. -/
theorem arithmeticLogQ_eq_publicLogQ
    (Q : Iut.QPilotData D) (hcompat : QPilotWeightDegreeCompatible Q) :
    arithmeticLogQ Q = Q.logQ := by
  classical
  rw [arithmeticLogQ_eq_sum, Iut.QPilotData.logQ]
  apply Finset.sum_congr rfl
  intro w hw
  have hc := hcompat w.1 (by simpa using w.2)
  calc
    (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
          Iut4Sec1.arithmeticPlaceWeight (.inl w.1) /
            (Module.finrank ℚ D.F : ℝ) =
        (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
          (Iut4Sec1.arithmeticPlaceWeight (.inl w.1) /
            (Module.finrank ℚ D.F : ℝ)) := by ring
    _ = (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
          (Q.weight w.1 * Real.log (Iut.residueChar w.1)) := by
      exact congrArg
        (fun x : ℝ => (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) * x)
        hc.symm
    _ = Q.weight w.1 *
          (D.prime.qOrder w.1 (Q.mem_bad w.2) : ℝ) *
            Real.log (Iut.residueChar w.1) := by ring

/-- Corrected absolute q-logarithm defined directly from the arithmetic
q-divisor, without an independent real weight field. -/
noncomputable def arithmeticAbsLogQ (Q : Iut.QPilotData D) : ℝ :=
  arithmeticLogQ Q / (2 * (D.ℓ : ℝ))

/-- Corrected q-pilot left-hand side. -/
noncomputable def arithmeticQPilotLHS (Q : Iut.QPilotData D) : ℝ :=
  -arithmeticAbsLogQ Q

/-- Compatibility identifies the corrected source-faithful left-hand side with
 the public interface left-hand side. -/
theorem arithmeticQPilotLHS_eq_publicLHS
    (Q : Iut.QPilotData D) (hcompat : QPilotWeightDegreeCompatible Q) :
    arithmeticQPilotLHS Q = Q.lhs := by
  rw [arithmeticQPilotLHS, arithmeticAbsLogQ,
    Iut.QPilotData.lhs, Iut.QPilotData.absLogQ,
    arithmeticLogQ_eq_publicLogQ Q hcompat]

end IUTThreeClosures