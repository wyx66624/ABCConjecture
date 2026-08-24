/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NormControlledSourceGenerators
import IUTThreeClosures.SpectrumPreservingInd2Envelope

/-!
# A spectrum-preserving relational source on a finite Tate packet

The one-place source has only a trivial shadow of Ind2.  This module upgrades
it to a finite packet indexed by a label type `Label`.

* ordinary regions are products of genuine Tate regions `q^(e j) O`;
* Ind1 acts by an independent norm-one Kummer multiplier at every label;
* Ind2 is an arbitrary label permutation that preserves the numerical theta
  spectrum `labelNat`;
* Ind3 acts by independent nonnegative powers of the actual Tate parameter;
* the packet norm is the finite-product sup norm, and the common envelope is
  its unit ball.

Coordinatewise norm estimates therefore instantiate the relational source
framework.  In addition, a spectrum-preserving Ind2 permutation carries the
native packet region onto itself exactly, so the nontrivial finite-label Ind2
action does not collapse the q-spectrum.

This remains a homogeneous single-local-field packet.  The genuine global
Theorem 3.11 source must still identify its heterogeneous local packets,
procession synchronization and archimedean factors with such source data.
-/

namespace IUTThreeClosures

open Iut TateCurvesTheta

universe v w

variable {K : Type v} [NormedField K]
variable {Label : Type w} [Fintype Label]

/-- Product of actual Tate-power regions over a finite label set. -/
def tatePacketQPowerRegion
    (t : TateParameter K) (exponent : Label → ℕ) :
    Set (Label → K) :=
  {z | ∀ j, z j ∈ t.qPowerRegion (exponent j)}

@[simp]
theorem mem_tatePacketQPowerRegion
    (t : TateParameter K) (exponent : Label → ℕ)
    (z : Label → K) :
    z ∈ tatePacketQPowerRegion t exponent ↔
      ∀ j, z j ∈ t.qPowerRegion (exponent j) :=
  Iff.rfl

/-- Every product of nonnegative Tate-power regions lies in the finite packet
unit ball. -/
theorem tatePacketQPowerRegion_subset_unitBall
    (t : TateParameter K) (exponent : Label → ℕ) :
    tatePacketQPowerRegion t exponent ⊆
      radialEnvelope (α := Label → K) 1 := by
  intro z hz
  change ‖z‖ ≤ 1
  rw [pi_norm_le_iff_of_nonneg (by norm_num : (0 : ℝ) ≤ 1)]
  intro j
  have hj := t.qPowerRegion_antitone
    (Nat.zero_le (exponent j)) (hz j)
  rw [t.qPowerRegion_zero] at hj
  exact hj

/-- A finite-label Ind2 operation together with the exact spectrum it
preserves. -/
structure TateSpectrumPerm (labelNat : Label → ℕ) where
  perm : Equiv.Perm Label
  preserves : ∀ j, labelNat (perm j) = labelNat j

namespace TateSpectrumPerm

/-- Spectrum preservation also holds for the inverse permutation. -/
theorem preserves_symm
    {labelNat : Label → ℕ}
    (σ : TateSpectrumPerm labelNat)
    (j : Label) :
    labelNat (σ.perm.symm j) = labelNat j := by
  have h := σ.preserves (σ.perm.symm j)
  simpa using h.symm

end TateSpectrumPerm

/-- Independent norm-one Kummer multipliers at all packet labels. -/
abbrev TatePacketNormOneUnit (K : Type v) [NormedField K]
    (Label : Type w) :=
  ∀ j : Label, NormOneKummerUnit K

/-- The norm-controlled relational source on a finite homogeneous Tate packet. -/
noncomputable def actualTatePacketRelationalSource
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    NormControlledSourceGenerators (Label → K) where
  Ordinary := Label → ℕ
  Ind1 := TatePacketNormOneUnit K Label
  Ind2 := TateSpectrumPerm labelNat
  Ind3 := Label → ℕ
  ordinaryRegion := tatePacketQPowerRegion t
  native := fun j => labelNat j ^ 2
  radius := 1
  ordinary_le_radius :=
    tatePacketQPowerRegion_subset_unitBall t
  ind1Map := fun a z j => ((a j).unit : K) * z j
  ind2Map := fun σ z => z ∘ σ.perm
  ind3Map := fun n z j => (t.q : K) ^ n j * z j
  ind1_norm := by
    intro a z
    rw [pi_norm_le_iff_of_nonneg (norm_nonneg z)]
    intro j
    rw [norm_mul, (a j).norm_eq_one, one_mul]
    exact norm_le_pi_norm z j
  ind2_norm := by
    intro σ z
    exact (σ.perm.surjective.pi_norm_comp z).le
  ind3_norm := by
    intro n z
    rw [pi_norm_le_iff_of_nonneg (norm_nonneg z)]
    intro j
    calc
      ‖(t.q : K) ^ n j * z j‖ =
          ‖(t.q : K)‖ ^ n j * ‖z j‖ := by
        rw [norm_mul, norm_pow]
      _ ≤ 1 * ‖z j‖ := by
        exact mul_le_mul_of_nonneg_right
          (pow_le_one₀ (norm_nonneg _) t.norm_lt_one.le)
          (norm_nonneg _)
      _ = ‖z j‖ := one_mul _
      _ ≤ ‖z‖ := norm_le_pi_norm z j

/-- The exact native packet region of the finite source. -/
@[simp]
theorem actualTatePacket_nativeRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    (actualTatePacketRelationalSource t labelNat).ordinaryRegion
        (actualTatePacketRelationalSource t labelNat).native =
      tatePacketQPowerRegion t (fun j => labelNat j ^ 2) :=
  rfl

/-- A spectrum-preserving label permutation maps the native packet region
onto itself, rather than merely preserving the ambient unit ball. -/
theorem spectrumPerm_image_nativeRegion
    (t : TateParameter K)
    (labelNat : Label → ℕ)
    (σ : TateSpectrumPerm labelNat) :
    (fun z : Label → K => z ∘ σ.perm) ''
        tatePacketQPowerRegion t (fun j => labelNat j ^ 2) =
      tatePacketQPowerRegion t (fun j => labelNat j ^ 2) := by
  apply Set.Subset.antisymm
  · rintro y ⟨z, hz, rfl⟩
    intro j
    have hj := hz (σ.perm j)
    simpa [σ.preserves j] using hj
  · intro y hy
    let z : Label → K := y ∘ σ.perm.symm
    have hz : z ∈ tatePacketQPowerRegion t
        (fun j => labelNat j ^ 2) := by
      intro j
      have hj := hy (σ.perm.symm j)
      simpa [z, σ.preserves_symm j] using hj
    refine ⟨z, hz, ?_⟩
    funext j
    simp [z]

/-- The native finite Tate packet lies in the generated possible-image union. -/
theorem actualTatePacket_nativeImage
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    tatePacketQPowerRegion t (fun j => labelNat j ^ 2) ⊆
      ((actualTatePacketRelationalSource t labelNat)
        .toUpperSemicompatibleSystem).possibleUnion := by
  simpa using
    (actualTatePacketRelationalSource t labelNat).actualNativeImage

/-- Every relationally generated finite-packet image lies in the packet unit
ball. -/
theorem actualTatePacket_possibleImageEnvelope
    (t : TateParameter K)
    (labelNat : Label → ℕ) :
    ((actualTatePacketRelationalSource t labelNat)
        .toUpperSemicompatibleSystem).possibleUnion ⊆
      radialEnvelope (α := Label → K) 1 :=
  (actualTatePacketRelationalSource t labelNat).actualPossibleImageEnvelope

end IUTThreeClosures
