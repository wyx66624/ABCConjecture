import Iut.Cor312.Container

/-!
# Relative compactness of generated unions inside log-shells

If a generated possible-image union lies inside a log-shell whose closure is
compact, then the closure of the union is compact.  This removes the relative
compactness part of hull admissibility; existence of the least scaled-integral
hull remains a discrete/archimedean local-field theorem.
-/

namespace Iut

universe u₁ u₂ v

variable {ι : Type u₁} {V : Type u₂}
variable {D : LargeVolumeContainerData.{u₁, u₂, v} ι V}

theorem closure_compact_of_subset_logShell
    (i : Fin D.proc.length) (vQ : RationalPlace)
    (U : Set (D.packet i vQ).Total)
    (hU : U ⊆ D.logShell i vQ) :
    IsCompact (closure U) := by
  have hsubset :
      closure U ⊆ closure (D.logShell i vQ) :=
    closure_mono hU
  exact (D.logShell_relCompact i vQ).of_isClosed_subset
    isClosed_closure hsubset

end Iut
