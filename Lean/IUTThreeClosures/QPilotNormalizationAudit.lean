import Mathlib

/-!
# Audit of the local q-pilot normalization

There are two natural local quantities at a finite place over `p`.

* The public LANA documentation describes the place weight as
  `[K_v : ℚ_p] / [K : ℚ] = e f / d`.
* The public local q-order is the integer uniformizer order `n`, i.e.
  `ord_v(π) = 1`.

Multiplying these directly gives `e f n log(p) / d`. On the other hand, the
normalized arithmetic-divisor degree of the divisor with coefficient `n` is
`f n log(p) / d`. The two differ by the ramification index.

The correct packet-normalized local response is `(n/e) log p`, so the product
with the local-degree weight is the arithmetic-divisor term.
-/

namespace IUTThreeClosures

structure LocalQPilotNormalizationDatum where
  ramification : ℝ
  residueDegree : ℝ
  globalDegree : ℝ
  uniformizerOrder : ℝ
  logPrime : ℝ
  ramification_pos : 0 < ramification
  residueDegree_pos : 0 < residueDegree
  globalDegree_pos : 0 < globalDegree
  uniformizerOrder_pos : 0 < uniformizerOrder
  logPrime_pos : 0 < logPrime

namespace LocalQPilotNormalizationDatum

/-- The term obtained by directly multiplying the documented local-degree
weight by the integer uniformizer order. -/
noncomputable def documentedTerm (D : LocalQPilotNormalizationDatum) : ℝ :=
  ((D.ramification * D.residueDegree) / D.globalDegree) *
    D.uniformizerOrder * D.logPrime

/-- The normalized arithmetic-divisor contribution. -/
noncomputable def divisorTerm (D : LocalQPilotNormalizationDatum) : ℝ :=
  (D.residueDegree / D.globalDegree) *
    D.uniformizerOrder * D.logPrime

/-- The corrected packet term: keep the local-degree weight but use the
`p`-normalized order `n/e`. -/
noncomputable def correctedPacketTerm
    (D : LocalQPilotNormalizationDatum) : ℝ :=
  ((D.ramification * D.residueDegree) / D.globalDegree) *
    (D.uniformizerOrder / D.ramification) * D.logPrime

theorem correctedPacketTerm_eq_divisorTerm
    (D : LocalQPilotNormalizationDatum) :
    D.correctedPacketTerm = D.divisorTerm := by
  unfold correctedPacketTerm divisorTerm
  field_simp [D.ramification_pos.ne', D.globalDegree_pos.ne']

theorem documentedTerm_eq_ramification_mul_divisorTerm
    (D : LocalQPilotNormalizationDatum) :
    D.documentedTerm = D.ramification * D.divisorTerm := by
  unfold documentedTerm divisorTerm
  field_simp [D.globalDegree_pos.ne']

theorem divisorTerm_pos (D : LocalQPilotNormalizationDatum) :
    0 < D.divisorTerm := by
  unfold divisorTerm
  exact mul_pos
    (mul_pos (div_pos D.residueDegree_pos D.globalDegree_pos)
      D.uniformizerOrder_pos)
    D.logPrime_pos

/-- At a genuinely ramified place, the direct combination of local-degree
weight and integer uniformizer order cannot equal the arithmetic-divisor
normalization. -/
theorem documentedTerm_ne_divisorTerm_of_ramified
    (D : LocalQPilotNormalizationDatum)
    (hRamified : 1 < D.ramification) :
    D.documentedTerm ≠ D.divisorTerm := by
  rw [D.documentedTerm_eq_ramification_mul_divisorTerm]
  have hpos := D.divisorTerm_pos
  nlinarith

theorem documentedTerm_gt_divisorTerm_of_ramified
    (D : LocalQPilotNormalizationDatum)
    (hRamified : 1 < D.ramification) :
    D.divisorTerm < D.documentedTerm := by
  rw [D.documentedTerm_eq_ramification_mul_divisorTerm]
  have hpos := D.divisorTerm_pos
  nlinarith

end LocalQPilotNormalizationDatum

/-- A concrete one-place ramified model: `e = 2`, `f = 1`, `d = 2`,
`n = 1`. -/
noncomputable def ramifiedQuadraticExample : LocalQPilotNormalizationDatum where
  ramification := 2
  residueDegree := 1
  globalDegree := 2
  uniformizerOrder := 1
  logPrime := Real.log 2
  ramification_pos := by norm_num
  residueDegree_pos := by norm_num
  globalDegree_pos := by norm_num
  uniformizerOrder_pos := by norm_num
  logPrime_pos := Real.log_pos (by norm_num)

theorem ramifiedQuadraticExample_mismatch :
    ramifiedQuadraticExample.documentedTerm ≠
      ramifiedQuadraticExample.divisorTerm := by
  apply LocalQPilotNormalizationDatum.documentedTerm_ne_divisorTerm_of_ramified
  change (1 : ℝ) < 2
  norm_num

section Global

variable {V : Type*} [Fintype V]

structure GlobalQPilotNormalizationDatum (V : Type*) where
  local : V → LocalQPilotNormalizationDatum

namespace GlobalQPilotNormalizationDatum

noncomputable def documentedLogQ
    (D : GlobalQPilotNormalizationDatum V) : ℝ :=
  ∑ v, (D.local v).documentedTerm

noncomputable def divisorLogQ
    (D : GlobalQPilotNormalizationDatum V) : ℝ :=
  ∑ v, (D.local v).divisorTerm

noncomputable def correctedPacketLogQ
    (D : GlobalQPilotNormalizationDatum V) : ℝ :=
  ∑ v, (D.local v).correctedPacketTerm

theorem correctedPacketLogQ_eq_divisorLogQ
    (D : GlobalQPilotNormalizationDatum V) :
    D.correctedPacketLogQ = D.divisorLogQ := by
  unfold correctedPacketLogQ divisorLogQ
  apply Finset.sum_congr rfl
  intro v hv
  exact (D.local v).correctedPacketTerm_eq_divisorTerm

end GlobalQPilotNormalizationDatum
end Global

end IUTThreeClosures
