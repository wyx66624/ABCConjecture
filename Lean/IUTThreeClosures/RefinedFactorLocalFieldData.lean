/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.SemisimplePacketCoordinates
import Iut4Sec1.LocalField.Basic

/-!
# Local-field data on refined tensor-packet factors

After correcting a place-tuple tensor algebra by splitting it into primitive
factors, every refined component is a finite separable field extension of the
rational local base field.  For a base `ℚ_[p]`, the existing IUT4 local-field
infrastructure therefore constructs on each factor:

* the canonical spectral norm and rank-one valuation;
* the complete nonarchimedean topology;
* the valuation ring as the integral closure of `ℤ_p`;
* the normalized discrete order and ramification index;
* the finite residue field and inertia degree;
* the Dedekind different ideal.

Thus norms, valuation rings and local different data on the primitive factors
are derived from the finite-etale tensor algebra; they are not arbitrary packet
fields.  What remains is to compare the image of the tensor product of the
label-wise integral orders with the product of these canonical factor rings.
That comparison is the finite-index/different theorem.
-/

namespace IUTThreeClosures

universe u v w

namespace TupleFiniteEtalePacket

variable {k : Type u} [Field k] {Tuple : Type v}
variable (P : TupleFiniteEtalePacket.{u, v, w} k Tuple)

/-- Every primitive packet factor is finite over the base field. -/
noncomputable instance summandFinite (d : P.RefinedComponent) :
    Module.Finite k (P.Summand d) := by
  infer_instance

/-- Every primitive packet factor is separable over the base field. -/
noncomputable instance summandSeparable (d : P.RefinedComponent) :
    Algebra.IsSeparable k (P.Summand d) := by
  infer_instance

/-- In particular, every primitive packet factor is finite dimensional. -/
noncomputable instance summandFiniteDimensional (d : P.RefinedComponent) :
    FiniteDimensional k (P.Summand d) := by
  infer_instance

end TupleFiniteEtalePacket

section MixedCharacteristic

variable (p : ℕ) [Fact p.Prime]
variable {Tuple : Type v}
variable (P : TupleFiniteEtalePacket.{0, v, w} ℚ_[p] Tuple)

/-- Canonical mixed-characteristic local-field package on a primitive tensor
factor. -/
noncomputable def refinedFactorLocalFieldData
    (d : P.RefinedComponent) :
    Iut4Sec1.MixedCharLocalFieldData p (P.Summand d) :=
  Iut4Sec1.mixedCharLocalFieldData_of_finiteExtension p (P.Summand d)

/-- The canonical integral ring on a primitive tensor factor. -/
noncomputable abbrev refinedFactorIntegers
    (d : P.RefinedComponent) : Subring (P.Summand d) :=
  (refinedFactorLocalFieldData p P d).ringOfIntegers

/-- The canonical different on a primitive tensor factor. -/
noncomputable abbrev refinedFactorDifferent
    (d : P.RefinedComponent) :
    Ideal (refinedFactorLocalFieldData p P d).ringOfIntegers :=
  (refinedFactorLocalFieldData p P d).different

/-- Membership in the canonical factor valuation ring is exactly integrality
over the base p-adic integer ring. -/
theorem mem_refinedFactorIntegers_iff_isIntegral
    (d : P.RefinedComponent) (x : P.Summand d) :
    x ∈ refinedFactorIntegers p P d ↔
      IsIntegral (Iut4Sec1.MixedCharLocalFieldData.baseRingOfIntegers (p := p)) x :=
  (refinedFactorLocalFieldData p P d).mem_ringOfIntegers_iff_isIntegral x

end MixedCharacteristic

end IUTThreeClosures
