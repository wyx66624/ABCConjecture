import Iut.Cor312.Procession

/-!
# The canonical coric zero label in the standard procession
-/

namespace Iut.Procession

/-- Every capsule of the standard procession contains the label zero. -/
def standardZeroLabel (n : ℕ) (i : Fin n) :
    ((standard n).capsule i).LabelType :=
  ⟨0, by simp [standard, procLabels]⟩

@[simp]
theorem standardZeroLabel_val (n : ℕ) (i : Fin n) :
    (standardZeroLabel n i).1 = 0 := rfl

end Iut.Procession
