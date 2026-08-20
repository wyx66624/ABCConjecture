import IUTThreeClosures.QPilotNormalizationAudit

/-!
# The exact normalization fork

The same correct local term can be represented in either of two ways:

1. local-degree weight `e f / d` times the `p`-normalized real order `n/e`;
2. residue-degree weight `f / d` times the integer uniformizer order `n`.

Using local-degree weight and integer uniformizer order simultaneously adds an
extra factor `e`.
-/

namespace IUTThreeClosures

theorem normalization_fork
    (D : LocalQPilotNormalizationDatum) :
    D.correctedPacketTerm = D.divisorTerm ∧
      D.documentedTerm = D.ramification * D.divisorTerm :=
  ⟨D.correctedPacketTerm_eq_divisorTerm,
    D.documentedTerm_eq_ramification_mul_divisorTerm⟩

theorem equality_for_all_local_data_requires_unramified
    (D : LocalQPilotNormalizationDatum)
    (hEq : D.documentedTerm = D.divisorTerm) :
    D.ramification = 1 := by
  rw [D.documentedTerm_eq_ramification_mul_divisorTerm] at hEq
  have hpos := D.divisorTerm_pos
  nlinarith

end IUTThreeClosures
