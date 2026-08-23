/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ActualTateLocalOutputRelation

/-!
# The simultaneous actual output relation over all bad places

`ActualTateLocalOutputRelation` constructs the genuine local analytic relation
at one bad place extracted from `InitialThetaData`.  This module assembles those
relations simultaneously over the dependent family of all actual bad places.

The operation types are themselves dependent families:

* an ordinary output chooses one nonnegative q-power at every bad place;
* Ind1 chooses a norm-one Kummer unit at every bad place;
* Ind2 is handled globally by the already formalized packet reindexing and
  spectral-factor automorphism theorems, so its local shadow is trivial here;
* Ind3 chooses a further nonnegative q-power at every bad place.

The native branch is `q O` at every bad place and the envelope is the product
of the genuine local norm unit balls.  Every containment theorem is proved
pointwise from the actual Tate parameter.  No arbitrary output realization,
volume, height inequality, or abc statement is an input.

This is still the bad nonarchimedean part of the source.  Identification with
the paper's global Hodge-theater/log-Kummer possible-image system, the
archimedean factors, and the packet-weighted Haar calculation remain separate
source theorems.
-/

namespace IUTThreeClosures

open Iut NumberField TateCurvesTheta
open scoped Pointwise

universe u

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- The actual bad-place index attached to one collection of initial theta-data. -/
abbrev ActualBadPlaceIndex (D : InitialThetaData AG TG) : Type u :=
  ActualBadHodgeTheaterPlace D

/-- The actual completed local field at a bad-place index. -/
noncomputable abbrev ActualBadPlaceCarrier
    (H : ActualBadPlaceIndex D) : Type u :=
  H.TateField

/-- A simultaneous ordinary branch: one q-power exponent at every bad place. -/
abbrev ActualBadPlaceOrdinary (D : InitialThetaData AG TG) : Type u :=
  ∀ H : ActualBadPlaceIndex D, ℕ

/-- A simultaneous Ind1 choice: one norm-one Kummer unit at every bad place. -/
abbrev ActualBadPlaceInd1 (D : InitialThetaData AG TG) : Type u :=
  ∀ H : ActualBadPlaceIndex D, NormOneKummerUnit H.TateField

/-- The local shadow of Ind2.  The nontrivial packet/spectral action is treated
by the separate global reindexing theorems. -/
abbrev ActualBadPlaceInd2 : Type u := ULift.{u} Unit

/-- A simultaneous Ind3 choice: one extra q-power exponent at every bad place. -/
abbrev ActualBadPlaceInd3 (D : InitialThetaData AG TG) : Type u :=
  ∀ H : ActualBadPlaceIndex D, ℕ

/-- The source-generated relation over every actual bad place at once. -/
noncomputable def actualBadPlaceOutputRelation
    (D : InitialThetaData AG TG) :
    ActualIUTOutputRelation D (ActualBadPlaceIndex D)
      (ActualBadPlaceCarrier (D := D)) where
  Ordinary := ActualBadPlaceOrdinary D
  Ind1 := ActualBadPlaceInd1 D
  Ind2 := ActualBadPlaceInd2 (u := u)
  Ind3 := ActualBadPlaceInd3 D

  ordinaryRegion := fun n H => H.tate.qPowerRegion (n H)
  act1 := fun a H U => scaledRegion ((a H).unit : H.TateField) U
  act2 := fun _ _ U => U
  act3 := fun n H U => scaledRegion ((H.tate.q : H.TateField) ^ (n H)) U

  native := fun _ => 1
  envelope := fun H => normIntegralRegion (K := H.TateField)

  ordinary_le_envelope := by
    intro n H
    have h := H.tate.qPowerRegion_antitone (Nat.zero_le (n H))
    simpa using h

  ind1_preserves_envelope := by
    intro a H U hU
    rintro x ⟨y, hy, rfl⟩
    have hy' : ‖y‖ ≤ 1 := hU hy
    change ‖((a H).unit : H.TateField) * y‖ ≤ 1
    rw [norm_mul, (a H).norm_eq_one, one_mul]
    exact hy'

  ind2_preserves_envelope := by
    intro a H U hU
    exact hU

  ind3_preserves_envelope := by
    intro n H U hU
    rintro x ⟨y, hy, rfl⟩
    have hy' : ‖y‖ ≤ 1 := hU hy
    have hpow : ‖(H.tate.q : H.TateField)‖ ^ (n H) ≤ 1 :=
      pow_le_one₀ (norm_nonneg _) H.tate.norm_lt_one.le
    change ‖((H.tate.q : H.TateField) ^ (n H)) * y‖ ≤ 1
    calc
      ‖((H.tate.q : H.TateField) ^ (n H)) * y‖ =
          ‖(H.tate.q : H.TateField)‖ ^ (n H) * ‖y‖ := by
        rw [norm_mul, norm_pow]
      _ ≤ 1 * 1 :=
        mul_le_mul hpow hy' (norm_nonneg _) (by norm_num)
      _ = 1 := by norm_num

namespace ActualBadPlaceOutputRelation

variable (D : InitialThetaData AG TG)

/-- At every actual bad place the native component is exactly `q O`. -/
@[simp]
theorem nativeQPilotRegion
    (H : ActualBadPlaceIndex D) :
    (actualBadPlaceOutputRelation D).nativeQPilotRegion H =
      H.tate.qPowerRegion 1 :=
  rfl

/-- At every actual bad place the common envelope is its genuine norm unit
ball. -/
@[simp]
theorem envelope
    (H : ActualBadPlaceIndex D) :
    (actualBadPlaceOutputRelation D).envelope H =
      normIntegralRegion (K := H.TateField) :=
  rfl

/-- Simultaneous source theorem, componentwise form: the native q-pilot image
belongs to the generated possible-image union at every bad place. -/
theorem actualNativeImage
    (H : ActualBadPlaceIndex D) :
    H.tate.qPowerRegion 1 ⊆
      (actualBadPlaceOutputRelation D).actualThetaPossibleUnion H := by
  simpa using
    (actualBadPlaceOutputRelation D).actualNativeImage H

/-- Simultaneous source theorem, componentwise form: every generated possible
image lies in the genuine local norm unit ball at every bad place. -/
theorem actualPossibleImageEnvelope
    (H : ActualBadPlaceIndex D) :
    (actualBadPlaceOutputRelation D).actualThetaPossibleUnion H ⊆
      normIntegralRegion (K := H.TateField) := by
  simpa using
    (actualBadPlaceOutputRelation D).actualPossibleImageEnvelope H

/-- The dependent product region associated to one generated global word. -/
def packetRealize
    (W : (actualBadPlaceOutputRelation D).PossibleImage) :
    Set (∀ H : ActualBadPlaceIndex D, H.TateField) :=
  {x | ∀ H, x H ∈ (actualBadPlaceOutputRelation D).realize W H}

/-- The literal dependent-product union of every generated bad-place output. -/
def actualThetaPossiblePacketUnion :
    Set (∀ H : ActualBadPlaceIndex D, H.TateField) :=
  ⋃ W : (actualBadPlaceOutputRelation D).PossibleImage,
    packetRealize D W

/-- The simultaneous native bad-place packet. -/
def nativeQPilotPacketRegion :
    Set (∀ H : ActualBadPlaceIndex D, H.TateField) :=
  {x | ∀ H, x H ∈ H.tate.qPowerRegion 1}

/-- The simultaneous product of the genuine local unit-ball envelopes. -/
def explicitBadPlacePacketEnvelope :
    Set (∀ H : ActualBadPlaceIndex D, H.TateField) :=
  {x | ∀ H, x H ∈ normIntegralRegion (K := H.TateField)}

/-- **Global bad-place native-image theorem.**  The entire dependent native
q-pilot packet is one generated possible-image packet. -/
theorem actualNativePacketImage :
    nativeQPilotPacketRegion D ⊆ actualThetaPossiblePacketUnion D := by
  intro x hx
  refine Set.mem_iUnion.mpr
    ⟨(actualBadPlaceOutputRelation D).nativePossibleImage, ?_⟩
  intro H
  simpa [packetRealize, nativeQPilotPacketRegion] using hx H

/-- **Global bad-place envelope theorem.**  Every generated dependent packet
lies in the product of the actual local norm unit balls. -/
theorem actualPossiblePacketEnvelope :
    actualThetaPossiblePacketUnion D ⊆ explicitBadPlacePacketEnvelope D := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨W, hxW⟩
  intro H
  exact (actualBadPlaceOutputRelation D).realize_le_envelope H W (hxW H)

/-- Consequently the native dependent packet lies in the explicit global
bad-place envelope. -/
theorem nativePacket_le_envelope :
    nativeQPilotPacketRegion D ⊆ explicitBadPlacePacketEnvelope D :=
  (actualNativePacketImage D).trans (actualPossiblePacketEnvelope D)

end ActualBadPlaceOutputRelation

end IUTThreeClosures
