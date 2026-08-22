/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FullPolyCore
import IUTThreeClosures.TateParameterPowerRegions
import Iut.Cor312.ThetaData.Basic
import Iut.Cor312.PacketPresentation

/-!
# Actual local theta-theater objects and Kummer output choices

This module constructs the part of a Hodge-theater needed by the component
calculation directly from `InitialThetaData`.

For a bad finite place of the global curve it derives, rather than supplies:

* the bad place of the field of moduli below it;
* the selected place of the torsion field;
* the localized theta-root orbicurve;
* its tempered fundamental group;
* the type-`(1,Z/ell Z)^±`, theta-root-model and canonical-cusp proofs;
* the genuine Tate parameter and normalized uniformizer at the original bad
  completion.

On the Tate completion, the theta label `j` is represented by the nonzero
Kummer point `q^(j^2)`. Horizontal Kummer arrows are translations sending one
distinguished point to another.

The three candidate indeterminacies are represented separately:

* `Ind1`: multiplication by a norm-one Kummer unit;
* `Ind2`: permutation of the finite label type;
* `Ind3`: a nonnegative componentwise exponent enlargement.

The resulting output is an actual unit-twisted power of `q`; its norm and
principal norm-unit-ball region are theorems. An explicit carrier equivalence
then transports this concrete product region to a public packet. The theorem
identifying this candidate choice model with every genuine IUT possible image
remains a separate source theorem.
-/

set_option linter.checkUnivs false

namespace IUTThreeClosures

open Iut NumberField TateCurvesTheta
open scoped BigOperators Pointwise

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}

/-! ## Actual local objects derived from initial theta data -/

/-- A bad finite place of the global field occurring in actual initial theta
data. Membership in `badPlacesOver` retains the field-of-moduli place below
it. -/
structure ActualBadHodgeTheaterPlace
    (D : InitialThetaData AG TG) where
  w : FinitePlace D.F
  hw : w ∈ badPlacesOver D.F D.E D.VBad

namespace ActualBadHodgeTheaterPlace

variable {D : InitialThetaData AG TG}
variable (H : ActualBadHodgeTheaterPlace D)

/-- The bad field-of-moduli place below the chosen global place exists by the
definition of `badPlacesOver`. -/
theorem exists_modPlace :
    ∃ v : FinitePlace ↥(fieldOfModuli D.F D.E),
      v ∈ D.VBad ∧ H.w.1.LiesOver v.1 := by
  simpa [badPlacesOver] using H.hw

/-- The source-derived field-of-moduli place. -/
noncomputable def modPlace :
    FinitePlace ↥(fieldOfModuli D.F D.E) :=
  Classical.choose H.exists_modPlace

/-- The derived place is one of the chosen bad moduli places. -/
theorem modPlace_mem : H.modPlace ∈ D.VBad :=
  (Classical.choose_spec H.exists_modPlace).1

/-- The original global place lies over the derived moduli place. -/
theorem liesOver_modPlace : H.w.1.LiesOver H.modPlace.1 :=
  (Classical.choose_spec H.exists_modPlace).2

/-- The place selected in the torsion field by the actual valuation section. -/
noncomputable def selectedKPlace : FinitePlace ↥D.prime.torsionField :=
  D.localData.sect.sectFin H.modPlace

/-- The actual local theta-root orbicurve at the selected torsion-field place. -/
noncomputable def localThetaOrbicurve :
    AG.Orbicurve (localCompletion H.selectedKPlace) :=
  localize H.selectedKPlace D.orb.XKu

/-- The actual tempered fundamental group used by the bad-place convention. -/
noncomputable def temperedPi : Type u :=
  D.localData.PivBad H.modPlace

/-- The localized model has the required `(1,Z/ell Z)^±` type. -/
theorem local_type_one_zmod :
    AG.IsTypeOneZModPM D.prime.ℓ H.localThetaOrbicurve :=
  D.localData.bad_type H.modPlace H.modPlace_mem

/-- The localized model is an actual theta-root model. -/
theorem local_isThetaRootModel :
    TG.IsThetaRootModel D.prime.ℓ H.localThetaOrbicurve :=
  D.localData.bad_theta_model H.modPlace H.modPlace_mem

/-- The distinguished cusp is the canonical graph-quotient cusp locally. -/
theorem local_epsilon_graph :
    AG.cuspBaseChange
        (FinitePlace.embedding H.selectedKPlace.maximalIdeal) D.orb.epsilon =
      TG.canonicalGraphCusp (localize H.selectedKPlace D.orb.CKu) :=
  D.localData.epsilon_graph H.modPlace H.modPlace_mem

/-- The actual completed local field carrying the Tate parameter. -/
noncomputable abbrev TateField := localCompletion H.w

/-- The genuine Tate parameter of the given elliptic curve at the chosen bad
place. -/
noncomputable def tate : TateParameter H.TateField :=
  D.prime.tate H.w H.hw

/-- The genuine normalized uniformizer at the chosen bad place. -/
noncomputable def uniformizer : H.TateField :=
  D.prime.unif H.w H.hw

/-- The chosen element really is a uniformizer. -/
theorem uniformizer_isUniformizer : IsUniformizer H.uniformizer :=
  D.prime.unif_isUniformizer H.w H.hw

/-- The actual positive normalized order of the Tate parameter. -/
noncomputable def qOrder : ℕ := D.prime.qOrder H.w H.hw

/-- The actual Tate order is positive. -/
theorem qOrder_pos : 0 < H.qOrder :=
  D.prime.qOrder_pos H.w H.hw

end ActualBadHodgeTheaterPlace

/-! ## Canonical horizontal Kummer equivalences -/

namespace KummerTorsor

variable {K : Type v} [NormedField K]

/-- Left translation on the multiplicative Kummer torsor. -/
def leftMulEquiv (a : Kˣ) : Kˣ ≃ Kˣ where
  toFun x := a * x
  invFun x := a⁻¹ * x
  left_inv x := by simp [mul_assoc]
  right_inv x := by simp [mul_assoc]

@[simp]
theorem leftMulEquiv_apply (a x : Kˣ) :
    leftMulEquiv a x = a * x := rfl

/-- The distinguished Kummer point at theta label `j`. -/
noncomputable def thetaPoint (t : TateParameter K) (j : ℕ) : Kˣ :=
  Units.mk0 ((t.q : K) ^ (j ^ 2))
    (pow_ne_zero _ t.q.ne_zero)

@[simp]
theorem thetaPoint_coe (t : TateParameter K) (j : ℕ) :
    ((thetaPoint t j : Kˣ) : K) = (t.q : K) ^ (j ^ 2) := rfl

/-- Translation multiplier from the `j`-labeled Kummer point to the
`k`-labeled point. -/
noncomputable def horizontalMultiplier
    (t : TateParameter K) (j k : ℕ) : Kˣ :=
  thetaPoint t k * (thetaPoint t j)⁻¹

/-- The canonical horizontal Kummer equivalence between two label copies. -/
noncomputable def horizontalEquiv
    (t : TateParameter K) (j k : ℕ) : Kˣ ≃ Kˣ :=
  leftMulEquiv (horizontalMultiplier t j k)

/-- The horizontal equivalence sends the distinguished source point to the
distinguished target point. -/
@[simp]
theorem horizontalEquiv_thetaPoint
    (t : TateParameter K) (j k : ℕ) :
    horizontalEquiv t j k (thetaPoint t j) = thetaPoint t k := by
  simp [horizontalEquiv, horizontalMultiplier, leftMulEquiv, mul_assoc]

/-- The horizontal arrow at one label is the identity. -/
theorem horizontalEquiv_refl
    (t : TateParameter K) (j : ℕ) :
    horizontalEquiv t j j = Equiv.refl Kˣ := by
  apply Equiv.ext
  intro x
  simp [horizontalEquiv, horizontalMultiplier, leftMulEquiv]

/-- Reversing a horizontal arrow gives its inverse. -/
theorem horizontalEquiv_symm
    (t : TateParameter K) (j k : ℕ) :
    (horizontalEquiv t j k).symm = horizontalEquiv t k j := by
  apply Equiv.ext
  intro x
  simp [horizontalEquiv, horizontalMultiplier, leftMulEquiv,
    mul_assoc, mul_comm, mul_left_comm]

/-- Horizontal arrows satisfy the cocycle law. -/
theorem horizontalEquiv_trans
    (t : TateParameter K) (i j k : ℕ) :
    (horizontalEquiv t i j).trans (horizontalEquiv t j k) =
      horizontalEquiv t i k := by
  apply Equiv.ext
  intro x
  simp [horizontalEquiv, horizontalMultiplier, leftMulEquiv,
    mul_assoc, mul_comm, mul_left_comm]

end KummerTorsor

namespace ActualBadHodgeTheaterPlace

variable {D : InitialThetaData AG TG}
variable (H : ActualBadHodgeTheaterPlace D)

/-- The distinguished theta point in the actual local Tate Kummer torsor. -/
noncomputable def thetaPoint (j : ℕ) : H.TateFieldˣ :=
  KummerTorsor.thetaPoint H.tate j

/-- The actual local horizontal Kummer equivalence between labels. -/
noncomputable def horizontalKummerEquiv (j k : ℕ) :
    H.TateFieldˣ ≃ H.TateFieldˣ :=
  KummerTorsor.horizontalEquiv H.tate j k

@[simp]
theorem horizontalKummerEquiv_thetaPoint (j k : ℕ) :
    H.horizontalKummerEquiv j k (H.thetaPoint j) = H.thetaPoint k :=
  KummerTorsor.horizontalEquiv_thetaPoint H.tate j k

end ActualBadHodgeTheaterPlace

/-! ## Explicit Ind1/Ind2/Ind3 choices and their output -/

/-- The Ind1 ambiguity: multiplication by a nonzero scalar of norm one. -/
structure NormOneKummerUnit (K : Type v) [NormedField K] where
  unit : Kˣ
  norm_eq_one : ‖(unit : K)‖ = 1

namespace NormOneKummerUnit

variable {K : Type v} [NormedField K]

/-- Trivial Ind1 choice. -/
def one : NormOneKummerUnit K where
  unit := 1
  norm_eq_one := norm_one

end NormOneKummerUnit

/-- A concrete candidate model for the three local indeterminacies. -/
structure ThetaIndeterminacyChoice
    (K : Type v) [NormedField K] (Label : Type w) where
  ind1 : NormOneKummerUnit K
  ind2 : Equiv.Perm Label
  ind3 : Label → ℕ

namespace ThetaIndeterminacyChoice

variable {K : Type v} [NormedField K]
variable {Label : Type w}

/-- The ordinary branch, with no indeterminacy applied. -/
def ordinary : ThetaIndeterminacyChoice K Label where
  ind1 := NormOneKummerUnit.one
  ind2 := Equiv.refl Label
  ind3 := fun _ => 0

/-- The source-derived exponent of one output component. -/
def outputPower
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label)
    (j : Label) : ℕ :=
  (labelNat (C.ind2 j)) ^ 2 + C.ind3 j

/-- The Kummer output value after the candidate Ind1, Ind2 and Ind3 choices. -/
noncomputable def outputValue
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label)
    (j : Label) : K :=
  (C.ind1.unit : K) * (t.q : K) ^ C.outputPower labelNat j

/-- Every candidate output value is nonzero. -/
theorem outputValue_ne_zero
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label)
    (j : Label) :
    C.outputValue t labelNat j ≠ 0 := by
  unfold outputValue
  exact mul_ne_zero (Units.ne_zero C.ind1.unit)
    (pow_ne_zero _ t.q.ne_zero)

/-- Exact local norm formula for the candidate output. -/
theorem norm_outputValue
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label)
    (j : Label) :
    ‖C.outputValue t labelNat j‖ =
      ‖(t.q : K)‖ ^ C.outputPower labelNat j := by
  unfold outputValue
  rw [norm_mul, C.ind1.norm_eq_one, one_mul, norm_pow]

/-- The component region generated by the candidate output value. -/
def outputRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label)
    (j : Label) : Set K :=
  scaledRegion (C.outputValue t labelNat j)
    (normIntegralRegion (K := K))

/-- Ind1 does not alter the principal region. -/
theorem outputRegion_eq_qPowerRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label)
    (j : Label) :
    C.outputRegion t labelNat j =
      t.qPowerRegion (C.outputPower labelNat j) := by
  unfold outputRegion TateParameter.qPowerRegion
  apply scaledRegion_eq_of_norm_eq
  · exact pow_ne_zero _ t.q.ne_zero
  · simpa only [norm_pow] using C.norm_outputValue t labelNat j

/-- Product packet region obtained from one concrete choice. -/
def packetRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label) : Set (Label → K) :=
  {x | ∀ j, x j ∈ C.outputRegion t labelNat j}

@[simp]
theorem mem_packetRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (C : ThetaIndeterminacyChoice K Label)
    (x : Label → K) :
    x ∈ C.packetRegion t labelNat ↔
      ∀ j, x j ∈ C.outputRegion t labelNat j :=
  Iff.rfl

/-- The ordinary branch realizes the unmodified squared-label Tate packet. -/
theorem ordinary_packetRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    (ordinary : ThetaIndeterminacyChoice K Label).packetRegion t labelNat =
      {x | ∀ j, x j ∈ t.qPowerRegion ((labelNat j) ^ 2)} := by
  ext x
  constructor
  · intro hx j
    have hj := hx j
    rw [outputRegion_eq_qPowerRegion] at hj
    simpa [ordinary, outputPower] using hj
  · intro hx j
    rw [outputRegion_eq_qPowerRegion]
    simpa [ordinary, outputPower] using hx j

end ThetaIndeterminacyChoice

/-! ## Transport to a public packet presentation -/

/-- A carrier coordinate identification between a concrete Kummer packet and a
public direct-sum packet. The actual semisimple local-field construction of
this equivalence is a separate theorem. -/
structure PublicPacketKummerCoordinates
    {C : Type u} (P : DirectSumPresentation.{u, v} C)
    (K : Type v) (Label : Type w) where
  coordinates : P.Total ≃ (Label → K)

namespace PublicPacketKummerCoordinates

variable {C : Type u} {P : DirectSumPresentation.{u, v} C}
variable {K : Type v} [NormedField K]
variable {Label : Type w}

/-- Realization of a concrete choice as a region of the public packet carrier. -/
def realize
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (choice : ThetaIndeterminacyChoice K Label) : Set P.Total :=
  M.coordinates ⁻¹' choice.packetRegion t labelNat

@[simp]
theorem mem_realize
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (choice : ThetaIndeterminacyChoice K Label)
    (x : P.Total) :
    x ∈ M.realize t labelNat choice ↔
      M.coordinates x ∈ choice.packetRegion t labelNat :=
  Iff.rfl

/-- In coordinates, the public realization is exactly the componentwise
product of the source-derived Tate-power regions. -/
theorem coordinates_image_realize
    (M : PublicPacketKummerCoordinates P K Label)
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (choice : ThetaIndeterminacyChoice K Label) :
    M.coordinates '' M.realize t labelNat choice =
      choice.packetRegion t labelNat := by
  apply Set.Subset.antisymm
  · rintro y ⟨x, hx, rfl⟩
    exact hx
  · intro y hy
    refine ⟨M.coordinates.symm y, ?_, M.coordinates.apply_symm_apply y⟩
    simpa using hy

end PublicPacketKummerCoordinates

end IUTThreeClosures
