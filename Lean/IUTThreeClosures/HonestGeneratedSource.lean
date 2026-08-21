import IUTThreeClosures.HonestPilotWitness

/-!
# Source-generated finite-positive theta regions

The public `LogVolumeData` interface is total on arbitrary sets and its scaling
law is inconsistent on the empty set.  This module continues the corrected
route: every local region carries an actual finite, nonzero measure, and the
theta region is defined as the union of the finitely many concrete outputs.
It is therefore not an unrelated field that may be populated independently.

A common finite-positive envelope supplies the finiteness of the generated
union.  A distinguished native output calibrates the actual q-logarithm.  The
usual numerical conclusion `-1 ≤ C_Theta` is then a theorem of measure
monotonicity rather than an assumed field.

This is the consistent numerical source layer.  Constructing its regions from
actual local fields, Kummer images and multiradial output maps remains the
geometric source problem.
-/

namespace IUTThreeClosures

open MeasureTheory

universe u v w

/-- A finite family of concrete finite-positive outputs, together with one
finite-positive envelope and a distinguished native q-output. -/
structure HonestGeneratedSource
    (I : Type v) [Fintype I]
    (α : I → Type u)
    [∀ i, MeasurableSpace (α i)]
    (μ : ∀ i, Measure (α i)) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  /-- The actual finite collection of output branches. -/
  Output : Type w
  outputFintype : Fintype Output
  /-- The region produced by each branch in every capsule. -/
  realize : Output → ∀ i, FinitePositiveRegion (α i) (μ i)
  /-- A common finite-positive shell containing every concrete output. -/
  envelope : ∀ i, FinitePositiveRegion (α i) (μ i)
  realize_le_envelope :
    ∀ o i, (realize o i : Set (α i)) ⊆ (envelope i : Set (α i))
  /-- The distinguished native q-output. -/
  native : Output
  /-- The positive, source-derived q-logarithm. -/
  qLog : ℝ
  qLog_pos : 0 < qLog
  /-- Calibration of the native procession average. -/
  nativeAverage :
    (∑ i, (realize native i).logVolume) / Fintype.card I = -qLog

namespace HonestGeneratedSource

variable {I : Type v} [Fintype I]
variable {α : I → Type u} [∀ i, MeasurableSpace (α i)]
variable {μ : ∀ i, Measure (α i)}

instance (S : HonestGeneratedSource.{u, v, w} I α μ) : Fintype S.Output :=
  S.outputFintype

/-- The theta region is the literal union of all concrete output regions.  Its
positive measure comes from the native output, and its finite measure comes
from the common envelope. -/
noncomputable def theta
    (S : HonestGeneratedSource.{u, v, w} I α μ)
    (i : I) : FinitePositiveRegion (α i) (μ i) where
  carrier := ⋃ o : S.Output, (S.realize o i : Set (α i))
  measurable := MeasurableSet.iUnion fun o => (S.realize o i).measurable
  measure_ne_zero := by
    intro hzero
    apply (S.realize S.native i).measure_ne_zero
    apply le_antisymm
    · calc
        μ i (S.realize S.native i).carrier ≤
            μ i (⋃ o : S.Output, (S.realize o i : Set (α i))) := by
          apply measure_mono
          intro x hx
          exact Set.mem_iUnion.mpr ⟨S.native, hx⟩
        _ = 0 := hzero
    · exact bot_le
  measure_ne_top := by
    intro htop
    apply (S.envelope i).measure_ne_top
    apply top_unique
    calc
      ⊤ = μ i (⋃ o : S.Output, (S.realize o i : Set (α i))) := htop.symm
      _ ≤ μ i (S.envelope i).carrier := by
        apply measure_mono
        intro x hx
        rcases Set.mem_iUnion.mp hx with ⟨o, hx⟩
        exact S.realize_le_envelope o i hx

/-- Every concrete output belongs to the source-generated theta region. -/
theorem realize_le_theta
    (S : HonestGeneratedSource.{u, v, w} I α μ)
    (o : S.Output) (i : I) :
    (S.realize o i : Set (α i)) ⊆ (S.theta i : Set (α i)) := by
  intro x hx
  change x ∈ ⋃ o : S.Output, (S.realize o i : Set (α i))
  exact Set.mem_iUnion.mpr ⟨o, hx⟩

/-- The generated source gives the corrected procession witness with
`qLHS = -qLog`. -/
noncomputable def toProcessionWitness
    (S : HonestGeneratedSource.{u, v, w} I α μ) :
    HonestProcessionWitness I α μ where
  native := S.realize S.native
  theta := S.theta
  native_le_theta := S.realize_le_theta S.native
  qLHS := -S.qLog
  nativeAverage := S.nativeAverage

/-- The canonical average log-volume of the generated theta regions. -/
noncomputable def thetaAverage
    (S : HonestGeneratedSource.{u, v, w} I α μ) : ℝ :=
  S.toProcessionWitness.thetaAverage

/-- The distinguished native output is bounded by the generated theta union. -/
theorem neg_qLog_le_thetaAverage
    (S : HonestGeneratedSource.{u, v, w} I α μ) :
    -S.qLog ≤ S.thetaAverage := by
  simpa [thetaAverage, toProcessionWitness] using
    S.toProcessionWitness.qLHS_le_thetaAverage

/-- Canonical theta coefficient of the honest source. -/
noncomputable def thetaCoefficient
    (S : HonestGeneratedSource.{u, v, w} I α μ) : ℝ :=
  S.thetaAverage / S.qLog

/-- The finite-positive source-generated numerical Corollary 3.12 bound. -/
theorem thetaCoefficient_ge_neg_one
    (S : HonestGeneratedSource.{u, v, w} I α μ) :
    -1 ≤ S.thetaCoefficient := by
  rw [thetaCoefficient]
  apply (le_div_iff₀ S.qLog_pos).2
  simpa only [neg_mul, one_mul] using S.neg_qLog_le_thetaAverage

end HonestGeneratedSource

end IUTThreeClosures
