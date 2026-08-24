/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import TateCurvesTheta.AnalyticQuotient
import Mathlib.Topology.ProperlyDiscontinuous
import Mathlib.Topology.Covering.Basic

/-!
# The Tate analytic quotient as a genuine topological covering quotient

The upstream Tate-curve library defines `Kˣ / qᶻ` as a quotient group.  The
same cyclic subgroup acts properly discontinuously on `Kˣ`: this follows from
Mathlib's cofinite escape theorem for powers in a topological group.  Hence the
natural projection to the quotient group is a covering map.

This upgrades the quotient from a purely group-theoretic object to the
intrinsic topological quotient of a properly discontinuous action.  It also
identifies the acting subgroup with `ℤ` using the strict Tate norm, so the deck
parameter is not an opaque cyclic group.

Compactness of the full Tate curve and comparison with the Berkovich skeleton
still require local compactness/properness and the analytic uniformization
theorem; those are not assumed here.
-/

namespace IUTThreeClosures

open TateCurvesTheta

universe u

namespace TateAnalyticTopologicalQuotient

variable {K : Type u} [NormedField K]

/-- Powers of the Tate parameter act properly discontinuously on `Kˣ`. -/
instance (T : TateDatum K) :
    ProperlyDiscontinuousSMul T.qpowers.op Kˣ :=
  T.qpowers.properlyDiscontinuousSMul_opposite_of_tendsto_cofinite
    (Subgroup.tendsto_zpowers_subtype_cofinite T.q)

/-- The natural projection `Kˣ → Kˣ/qᶻ` is a covering map. -/
theorem quotientProjection_isCoveringMap (T : TateDatum K) :
    IsCoveringMap (QuotientGroup.mk' T.qpowers) := by
  infer_instance

/-- In particular, the quotient projection is a local homeomorphism. -/
theorem quotientProjection_isLocalHomeomorph (T : TateDatum K) :
    IsLocalHomeomorph (QuotientGroup.mk' T.qpowers) :=
  (quotientProjection_isCoveringMap T).isLocalHomeomorph

/-- Integer powers of `q` as elements of the cyclic deck subgroup. -/
def integerToQPower (T : TateDatum K) (n : ℤ) : T.qpowers :=
  ⟨T.q ^ n, Subgroup.zpow_mem _ (Subgroup.mem_zpowers T.q) n⟩

@[simp]
theorem integerToQPower_coe (T : TateDatum K) (n : ℤ) :
    ((integerToQPower T n : T.qpowers) : Kˣ) = T.q ^ n :=
  rfl

/-- The cyclic deck subgroup is canonically equivalent to `ℤ`. -/
def integerEquivQPowers (T : TateDatum K) : ℤ ≃ T.qpowers where
  toFun := integerToQPower T
  invFun u := Classical.choose (Subgroup.mem_zpowers_iff.mp u.property)
  left_inv := by
    intro n
    apply T.q_zpow_injective
    have h := Classical.choose_spec
      (Subgroup.mem_zpowers_iff.mp (integerToQPower T n).property)
    simpa [integerToQPower] using h
  right_inv := by
    intro u
    apply Subtype.ext
    exact Classical.choose_spec (Subgroup.mem_zpowers_iff.mp u.property)

/-- One integer deck step acts by multiplication by the corresponding power
of the Tate parameter. -/
def deckShift (T : TateDatum K) (n : ℤ) (u : Kˣ) : Kˣ :=
  T.q ^ n * u

@[simp]
theorem deckShift_zero (T : TateDatum K) (u : Kˣ) :
    deckShift T 0 u = u := by
  simp [deckShift]

@[simp]
theorem deckShift_add (T : TateDatum K) (m n : ℤ) (u : Kˣ) :
    deckShift T m (deckShift T n u) = deckShift T (n + m) u := by
  simp [deckShift, zpow_add]
  ac_rfl

/-- Every integer deck shift has the same image in the analytic quotient. -/
theorem quotientProjection_deckShift
    (T : TateDatum K) (n : ℤ) (u : Kˣ) :
    QuotientGroup.mk' T.qpowers (deckShift T n u) =
      QuotientGroup.mk' T.qpowers u := by
  rw [QuotientGroup.eq_iff_div_mem]
  change T.q ^ n * u / u ∈ T.qpowers
  simpa [div_eq_mul_inv, mul_assoc] using
    (Subgroup.zpow_mem T.qpowers (Subgroup.mem_zpowers T.q) n)

/-- The complete integer deck action is free. -/
theorem deckShift_injective_index (T : TateDatum K) (u : Kˣ) :
    Function.Injective (fun n : ℤ => deckShift T n u) := by
  intro m n h
  have hpow : T.q ^ m = T.q ^ n := by
    apply mul_right_cancel (b := u)
    simpa [deckShift] using h
  exact T.q_zpow_injective hpow

/-- No nonzero integer deck translation fixes a point. -/
theorem deckShift_ne_of_ne_zero
    (T : TateDatum K) {n : ℤ} (hn : n ≠ 0) (u : Kˣ) :
    deckShift T n u ≠ u := by
  intro h
  apply hn
  apply T.deckShift_injective_index u
  simpa using h

/-- The orbit of one point is exactly its quotient fiber. -/
theorem quotient_eq_iff_exists_deckShift
    (T : TateDatum K) (u v : Kˣ) :
    QuotientGroup.mk' T.qpowers u =
        QuotientGroup.mk' T.qpowers v ↔
      ∃ n : ℤ, deckShift T n u = v := by
  constructor
  · intro h
    rw [QuotientGroup.eq_iff_div_mem] at h
    rcases Subgroup.mem_zpowers_iff.mp h with ⟨n, hn⟩
    refine ⟨-n, ?_⟩
    apply mul_right_cancel (b := u⁻¹)
    have hu : u * u⁻¹ = 1 := by simp
    rw [deckShift, mul_assoc, hu, mul_one]
    calc
      T.q ^ (-n) = (T.q ^ n)⁻¹ := by simp
      _ = (u / v)⁻¹ := by rw [hn]
      _ = v / u := by simp [div_eq_mul_inv]
      _ = v * u⁻¹ := by rfl
  · rintro ⟨n, rfl⟩
    exact (T.quotientProjection_deckShift n u).symm

/-- The fiber over any quotient point is canonically parametrized by `ℤ`. -/
def integerEquivFiber (T : TateDatum K) (u : Kˣ) :
    ℤ ≃ {v : Kˣ //
      QuotientGroup.mk' T.qpowers v =
        QuotientGroup.mk' T.qpowers u} where
  toFun n :=
    ⟨deckShift T n u,
      T.quotientProjection_deckShift n u⟩
  invFun v := Classical.choose
    ((T.quotient_eq_iff_exists_deckShift u v.1).1 v.2.symm)
  left_inv := by
    intro n
    apply T.deckShift_injective_index u
    exact Classical.choose_spec
      ((T.quotient_eq_iff_exists_deckShift u (deckShift T n u)).1
        (T.quotientProjection_deckShift n u).symm)
  right_inv := by
    intro v
    apply Subtype.ext
    exact Classical.choose_spec
      ((T.quotient_eq_iff_exists_deckShift u v.1).1 v.2.symm)

end TateAnalyticTopologicalQuotient

end IUTThreeClosures
