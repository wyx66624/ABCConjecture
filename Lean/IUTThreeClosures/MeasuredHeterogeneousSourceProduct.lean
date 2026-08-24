/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.HeterogeneousFiniteSourceProduct
import IUTThreeClosures.FiniteProductLogVolume

/-!
# Measured finite products of heterogeneous source regions

The finite-product source theorem constructs one global possible-image system
from finitely many local sources.  To enter the Corollary 3.12 volume ledger,
one must additionally know that every local native region is measurable and
has finite positive measure.

This module packages exactly that extra information.  If each local source's
native region is represented by a `FinitePositiveRegion`, then:

* their product is a finite-positive region for the genuine product measure;
* its carrier is exactly the native region of the assembled product source;
* it is therefore contained in the generated global possible-image union;
* its logarithmic volume is the sum of the local logarithmic volumes.

Thus local native-volume calibrations combine without a new global volume
axiom.  The remaining multiradial work is to construct the actual local
measures/regions, identify the procession coordinates and prove that the
public theta-hull/component measures are the corresponding product measures or
controlled pushforwards.
-/

namespace IUTThreeClosures

open MeasureTheory Set
open scoped BigOperators

universe u v w x y z

/-- A finite family of norm-controlled sources whose native regions carry
finite positive local measures. -/
structure MeasuredNormControlledSourceFamily
    (J : Type z) [Fintype J]
    (α : J → Type y)
    [∀ j, SeminormedAddCommGroup (α j)]
    [∀ j, MeasurableSpace (α j)]
    (μ : ∀ j, Measure (α j))
    [∀ j, SigmaFinite (μ j)] :
    Type (max (u + 1) (v + 1) (w + 1) (x + 1) (y + 1) (z + 1))
    extends NormControlledSourceFamily.{u, v, w, x, y, z} J α where
  nativeRegion : ∀ j : J, FinitePositiveRegion (α j) (μ j)
  native_carrier :
    ∀ j : J,
      (nativeRegion j : Set (α j)) =
        (source j).ordinaryRegion (source j).native

namespace MeasuredNormControlledSourceFamily

variable {J : Type z} [Fintype J]
variable {α : J → Type y}
variable [∀ j, SeminormedAddCommGroup (α j)]
variable [∀ j, MeasurableSpace (α j)]
variable {μ : ∀ j, Measure (α j)}
variable [∀ j, SigmaFinite (μ j)]

/-- The genuine finite-positive product of all local native regions. -/
noncomputable def productNativeRegion
    (F : MeasuredNormControlledSourceFamily.{u, v, w, x, y, z}
      J α μ) :
    FinitePositiveRegion (∀ j : J, α j) (Measure.pi μ) :=
  FinitePositiveRegion.pi μ F.nativeRegion

/-- The measured product carrier is exactly the source-generated product
native region. -/
@[simp]
theorem productNativeRegion_carrier
    (F : MeasuredNormControlledSourceFamily.{u, v, w, x, y, z}
      J α μ) :
    (F.productNativeRegion : Set (∀ j : J, α j)) =
      {a : ∀ j : J, α j |
        ∀ j,
          a j ∈ (F.source j).ordinaryRegion (F.source j).native} := by
  ext a
  simp only [productNativeRegion, FinitePositiveRegion.coe_pi,
    Set.mem_pi, Set.mem_univ, true_implies, Set.mem_setOf_eq]
  constructor
  · intro ha j
    rw [← F.native_carrier j]
    exact ha j
  · intro ha j
    rw [F.native_carrier j]
    exact ha j

/-- The measured product carrier is definitionally the native region of the
assembled product source. -/
theorem productNativeRegion_eq_productSourceNative
    (F : MeasuredNormControlledSourceFamily.{u, v, w, x, y, z}
      J α μ) :
    (F.productNativeRegion : Set (∀ j : J, α j)) =
      F.toNormControlledSourceFamily.productSource.ordinaryRegion
        F.toNormControlledSourceFamily.productSource.native := by
  rw [F.productNativeRegion_carrier]
  rfl

/-- The genuinely measured native packet is one of the generated possible
images of the assembled source. -/
theorem productNativeRegion_le_possibleUnion
    (F : MeasuredNormControlledSourceFamily.{u, v, w, x, y, z}
      J α μ) :
    (F.productNativeRegion : Set (∀ j : J, α j)) ⊆
      F.toNormControlledSourceFamily.productSource
        .toUpperSemicompatibleSystem.possibleUnion := by
  rw [F.productNativeRegion_carrier]
  exact F.toNormControlledSourceFamily.productNativeImage

/-- Exact additivity of the measured native logarithmic volume. -/
theorem productNativeLogVolume
    (F : MeasuredNormControlledSourceFamily.{u, v, w, x, y, z}
      J α μ) :
    F.productNativeRegion.logVolume =
      ∑ j, (F.nativeRegion j).logVolume := by
  exact FinitePositiveRegion.logVolume_pi F.nativeRegion

/-- Local numerical calibrations combine into the corresponding sum without
any extra global calibration field. -/
theorem productNativeLogVolume_eq_sum
    (F : MeasuredNormControlledSourceFamily.{u, v, w, x, y, z}
      J α μ)
    (q : J → ℝ)
    (hq : ∀ j, (F.nativeRegion j).logVolume = q j) :
    F.productNativeRegion.logVolume = ∑ j, q j := by
  rw [F.productNativeLogVolume]
  apply Finset.sum_congr rfl
  intro j hj
  exact hq j

/-- A precomputed global signed q-log is enough once it is identified with the
sum of the local native log-volumes. -/
theorem productNativeLogVolume_eq
    (F : MeasuredNormControlledSourceFamily.{u, v, w, x, y, z}
      J α μ)
    (qSigned : ℝ)
    (hq : (∑ j, (F.nativeRegion j).logVolume) = qSigned) :
    F.productNativeRegion.logVolume = qSigned := by
  rw [F.productNativeLogVolume, hq]

end MeasuredNormControlledSourceFamily

end IUTThreeClosures
