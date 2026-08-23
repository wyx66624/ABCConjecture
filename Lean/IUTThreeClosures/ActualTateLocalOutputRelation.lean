/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualIUTOutputRelation
import IUTThreeClosures.ActualHodgeTheaterOutput

/-!
# The actual local Tate/Kummer output relation

This module instantiates the source-generated output relation at an actual bad
place extracted from `InitialThetaData`.

At one local component:

* an ordinary branch is a genuine Tate region `q^n O`;
* Ind1 scales by an actual norm-one Kummer unit;
* the one-component shadow of Ind2 is identity (packet reindexing is handled
  separately by the global permutation/spectral theorems);
* Ind3 scales by a further nonnegative power of the actual Tate parameter;
* the common envelope is the norm unit ball `O`.

Every ordinary region lies in `O`, norm-one scaling preserves `O`, and further
q-power scaling preserves `O` because `||q|| < 1`. Hence the generic
`actualNativeImage` and `actualPossibleImageEnvelope` theorems become genuine
local Tate statements without a freely supplied envelope proof.

This closes the local analytic part of the output relation. The remaining
source theorem is the global identification of the paper's Hodge-theater/
log-Kummer possible-image system with the generated local operations assembled
here, together with packet coordinates and the archimedean branches.
-/

namespace IUTThreeClosures

open Iut NumberField TateCurvesTheta
open scoped Pointwise

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

namespace ActualBadHodgeTheaterPlace

/-! `ActualIUTOutputRelation` keeps the component index and all four operation
sorts in one universe.  The small arithmetic indices are therefore lifted to
the universe of the genuine local field. -/

abbrev TateLocalIndex : Type u := ULift.{u} Unit
abbrev TateLocalNat : Type u := ULift.{u} ℕ
abbrev TateLocalUnit : Type u := ULift.{u} Unit

def tateLocalIndex : TateLocalIndex.{u} := ⟨Unit.unit⟩
def tateLocalOne : TateLocalNat.{u} := ⟨1⟩

/-- The source-generated local relation associated to the genuine Tate
parameter at an actual bad Hodge-theater place. -/
noncomputable def actualTateLocalOutputRelation
    (H : ActualBadHodgeTheaterPlace D) :
    ActualIUTOutputRelation D TateLocalIndex.{u}
      (fun _ => H.TateField) where
  Ordinary := TateLocalNat.{u}
  Ind1 := NormOneKummerUnit H.TateField
  Ind2 := TateLocalUnit.{u}
  Ind3 := TateLocalNat.{u}

  ordinaryRegion := fun n _ => H.tate.qPowerRegion n.down
  act1 := fun a _ U => scaledRegion (a.unit : H.TateField) U
  act2 := fun _ _ U => U
  act3 := fun n _ U => scaledRegion ((H.tate.q : H.TateField) ^ n.down) U

  native := tateLocalOne.{u}
  envelope := fun _ => normIntegralRegion (K := H.TateField)

  ordinary_le_envelope := by
    intro n i
    have h := H.tate.qPowerRegion_antitone (Nat.zero_le n.down)
    simpa using h

  ind1_preserves_envelope := by
    intro a i U hU
    rintro x ⟨y, hy, rfl⟩
    have hy' : ‖y‖ ≤ 1 := hU hy
    change ‖(a.unit : H.TateField) * y‖ ≤ 1
    rw [norm_mul, a.norm_eq_one, one_mul]
    exact hy'

  ind2_preserves_envelope := by
    intro a i U hU
    exact hU

  ind3_preserves_envelope := by
    intro n i U hU
    rintro x ⟨y, hy, rfl⟩
    have hy' : ‖y‖ ≤ 1 := hU hy
    have hpow : ‖(H.tate.q : H.TateField)‖ ^ n.down ≤ 1 :=
      pow_le_one₀ (norm_nonneg _) H.tate.norm_lt_one.le
    change ‖((H.tate.q : H.TateField) ^ n.down) * y‖ ≤ 1
    calc
      ‖((H.tate.q : H.TateField) ^ n.down) * y‖ =
          ‖(H.tate.q : H.TateField)‖ ^ n.down * ‖y‖ := by
        rw [norm_mul, norm_pow]
      _ ≤ 1 * 1 :=
        mul_le_mul hpow hy' (norm_nonneg _) (by norm_num)
      _ = 1 := by norm_num

@[simp]
theorem actualTateLocal_nativeQPilotRegion
    (H : ActualBadHodgeTheaterPlace D) :
    H.actualTateLocalOutputRelation.nativeQPilotRegion tateLocalIndex.{u} =
      H.tate.qPowerRegion 1 := by
  rfl

@[simp]
theorem actualTateLocal_envelope
    (H : ActualBadHodgeTheaterPlace D) :
    H.actualTateLocalOutputRelation.envelope tateLocalIndex.{u} =
      normIntegralRegion (K := H.TateField) :=
  rfl

/-- **Actual local native-image theorem.** The genuine `q O` region is one of
the generated local possible images. -/
theorem actualTateNativeImage
    (H : ActualBadHodgeTheaterPlace D) :
    H.tate.qPowerRegion 1 ⊆
      H.actualTateLocalOutputRelation.actualThetaPossibleUnion
        tateLocalIndex.{u} := by
  simpa using
    H.actualTateLocalOutputRelation.actualNativeImage tateLocalIndex.{u}

/-- **Actual local possible-image envelope theorem.** Every finite composition
of the ordinary Tate branch, norm-one Kummer ambiguity and nonnegative vertical
q-scaling lies in the actual local norm unit ball. -/
theorem actualTatePossibleImageEnvelope
    (H : ActualBadHodgeTheaterPlace D) :
    H.actualTateLocalOutputRelation.actualThetaPossibleUnion
        tateLocalIndex.{u} ⊆
      normIntegralRegion (K := H.TateField) := by
  simpa using
    H.actualTateLocalOutputRelation.actualPossibleImageEnvelope tateLocalIndex.{u}

/-- In particular the native q-pilot region lies in the actual local unit-ball
envelope. -/
theorem actualTateNativeImage_le_envelope
    (H : ActualBadHodgeTheaterPlace D) :
    H.tate.qPowerRegion 1 ⊆
      normIntegralRegion (K := H.TateField) :=
  H.actualTateNativeImage.trans H.actualTatePossibleImageEnvelope

end ActualBadHodgeTheaterPlace

end IUTThreeClosures
