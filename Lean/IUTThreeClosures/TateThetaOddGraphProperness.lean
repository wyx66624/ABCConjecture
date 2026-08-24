/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaOddGraphAction
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Topology.Algebra.ConstMulAction
import Mathlib.Topology.Covering.Quotient
import Mathlib.Topology.Instances.ZMultiples

/-!
# Proper discontinuity of the odd graph-period action

This file equips the theta-root locus with the metric topology induced by its
actual coordinates in `Kˣ × K`.  It proves that every integral graph-period
translation is continuous and that the free integer action constructed in
`TateThetaOddGraphAction` is properly discontinuous in Mathlib's compact-set
sense.

The proof uses the continuous height `log ‖base‖`.  Translation by the
`n`-th graph period adds

`n * log ‖q^(2*k+1)‖`,

whose nonzero step makes the inverse image of every compact real set finite.
Explicit height bands then prove that the ordinary orbit projection is a
topological covering, without a local compactness hypothesis.  No
rigid/Berkovich analytic quotient or tempered-fundamental-group statement is
asserted here.
-/

namespace IUTThreeClosures

open Filter Set Topology
open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootPoint

omit [CompleteSpace K] in
/-- The honest coordinate map of the theta-root locus. -/
def coordinates (t : TateParameter K) (ell : ℕ) :
    TateThetaRootPoint t ell → (K × K) × K :=
  fun z => (((z.base : K), (↑z.base⁻¹ : K)), z.root)

omit [CompleteSpace K] in
theorem coordinates_injective (t : TateParameter K) (ell : ℕ) :
    Function.Injective (coordinates t ell) := by
  intro x y h
  apply ext
  · apply Units.ext
    exact congrArg (fun p => p.1.1) h
  · exact congrArg Prod.snd h

/-- The natural metric topology pulled back from the two coordinates. -/
noncomputable instance instMetricSpace (t : TateParameter K) (ell : ℕ) :
    MetricSpace (TateThetaRootPoint t ell) :=
  MetricSpace.induced (coordinates t ell) (coordinates_injective t ell) inferInstance

omit [CompleteSpace K] in
@[continuity]
theorem continuous_coordinates (t : TateParameter K) (ell : ℕ) :
    Continuous (coordinates t ell) :=
  continuous_induced_dom

omit [CompleteSpace K] in
@[continuity]
theorem continuous_base (t : TateParameter K) (ell : ℕ) :
    Continuous (fun z : TateThetaRootPoint t ell => z.base) :=
  Units.continuous_iff.2 ⟨
    continuous_fst.comp (continuous_fst.comp (continuous_coordinates t ell)),
    continuous_snd.comp (continuous_fst.comp (continuous_coordinates t ell))⟩

omit [CompleteSpace K] in
@[continuity]
theorem continuous_root (t : TateParameter K) (ell : ℕ) :
    Continuous (fun z : TateThetaRootPoint t ell => z.root) :=
  continuous_snd.comp (continuous_coordinates t ell)

/-- The odd graph-period generator is continuous for the coordinate topology. -/
theorem continuous_oddPeriodShift (t : TateParameter K) (k : ℕ) :
    Continuous (oddPeriodShift t k) := by
  apply continuous_induced_rng.2
  change Continuous fun z : TateThetaRootPoint t (2 * k + 1) =>
    (((↑(t.q ^ (2 * k + 1) * z.base) : K),
        (↑(t.q ^ (2 * k + 1) * z.base)⁻¹ : K)),
      (↑(t.q ^ (k + 1) * z.base) : K)⁻¹ * z.root)
  have hbase : Continuous fun z : TateThetaRootPoint t (2 * k + 1) =>
      t.q ^ (2 * k + 1) * z.base :=
    continuous_const.mul (continuous_base t (2 * k + 1))
  have hcoeff : Continuous fun z : TateThetaRootPoint t (2 * k + 1) =>
      t.q ^ (k + 1) * z.base :=
    continuous_const.mul (continuous_base t (2 * k + 1))
  have hcoeffVal : Continuous fun z : TateThetaRootPoint t (2 * k + 1) =>
      (↑(t.q ^ (k + 1) * z.base) : K) :=
    Units.continuous_val.comp hcoeff
  have hroot : Continuous fun z : TateThetaRootPoint t (2 * k + 1) =>
      (↑(t.q ^ (k + 1) * z.base) : K)⁻¹ * z.root :=
    (hcoeffVal.inv₀ (fun z => Units.ne_zero (t.q ^ (k + 1) * z.base))).mul
        (continuous_root t (2 * k + 1))
  exact (Units.continuous_val.comp hbase).prodMk
    (Units.continuous_coe_inv.comp hbase) |>.prodMk hroot

/-- The explicit inverse graph-period generator is continuous. -/
theorem continuous_oddPeriodShiftInv (t : TateParameter K) (k : ℕ) :
    Continuous (oddPeriodShiftInv t k) := by
  apply continuous_induced_rng.2
  change Continuous fun z : TateThetaRootPoint t (2 * k + 1) =>
    (((↑((t.q ^ (2 * k + 1))⁻¹ * z.base) : K),
        (↑((t.q ^ (2 * k + 1))⁻¹ * z.base)⁻¹ : K)),
      (↑((t.q ^ k)⁻¹ * z.base) : K) * z.root)
  have hbase : Continuous fun z : TateThetaRootPoint t (2 * k + 1) =>
      (t.q ^ (2 * k + 1))⁻¹ * z.base :=
    continuous_const.mul (continuous_base t (2 * k + 1))
  have hcoeff : Continuous fun z : TateThetaRootPoint t (2 * k + 1) =>
      (t.q ^ k)⁻¹ * z.base :=
    continuous_const.mul (continuous_base t (2 * k + 1))
  have hroot : Continuous fun z : TateThetaRootPoint t (2 * k + 1) =>
      (↑((t.q ^ k)⁻¹ * z.base) : K) * z.root :=
    (Units.continuous_val.comp hcoeff).mul
        (continuous_root t (2 * k + 1))
  exact (Units.continuous_val.comp hbase).prodMk
    (Units.continuous_coe_inv.comp hbase) |>.prodMk hroot

/-- The algebraic graph-period equivalence is a homeomorphism for the
coordinate topology. -/
noncomputable def oddPeriodShiftHomeomorph (t : TateParameter K) (k : ℕ) :
    TateThetaRootPoint t (2 * k + 1) ≃ₜ
      TateThetaRootPoint t (2 * k + 1) where
  toEquiv := oddPeriodShiftEquiv t k
  continuous_toFun := continuous_oddPeriodShift t k
  continuous_invFun := continuous_oddPeriodShiftInv t k

/-- Every integral iterate of the graph-period generator is continuous. -/
theorem continuous_oddPeriodShiftIterate
    (t : TateParameter K) (k : ℕ) (n : ℤ) :
    Continuous (oddPeriodShiftIterate t k n) := by
  let F : (TateThetaRootPoint t (2 * k + 1) ≃ₜ
      TateThetaRootPoint t (2 * k + 1)) →*
      Equiv.Perm (TateThetaRootPoint t (2 * k + 1)) := {
    toFun e := e.toEquiv
    map_one' := rfl
    map_mul' _ _ := rfl }
  have hpow : (oddPeriodShiftEquiv t k) ^ n =
      F ((oddPeriodShiftHomeomorph t k) ^ n) := by
    rw [map_zpow]
    rfl
  rw [oddPeriodShiftIterate, hpow]
  exact ((oddPeriodShiftHomeomorph t k) ^ n).continuous

/-- The free integer action has continuous translations. -/
theorem oddPeriodShiftAddAction_continuousConstVAdd
    (t : TateParameter K) (k : ℕ) :
    letI := oddPeriodShiftAddAction t k
    ContinuousConstVAdd ℤ (TateThetaRootPoint t (2 * k + 1)) := by
  letI := oddPeriodShiftAddAction t k
  exact ⟨continuous_oddPeriodShiftIterate t k⟩

omit [CompleteSpace K] in
/-- Logarithmic norm on the genuine unit coordinate. -/
noncomputable def unitLogNorm (u : Kˣ) : ℝ :=
  Real.log ‖(u : K)‖

omit [CompleteSpace K] in
@[continuity]
theorem continuous_unitLogNorm :
    Continuous (unitLogNorm : Kˣ → ℝ) := by
  change Continuous fun u : Kˣ => Real.log ‖(u : K)‖
  let f : Kˣ → {x : ℝ // x ≠ 0} := fun u =>
    ⟨‖(u : K)‖, norm_ne_zero_iff.mpr u.ne_zero⟩
  have hf : Continuous f :=
    (continuous_norm.comp Units.continuous_val).subtype_mk _
  simpa [f, Function.comp_def] using Real.continuous_log.comp hf

omit [CompleteSpace K] in
theorem unitLogNorm_mul (u v : Kˣ) :
    unitLogNorm (u * v) = unitLogNorm u + unitLogNorm v := by
  simp [unitLogNorm, norm_mul, Real.log_mul,
    norm_ne_zero_iff.mpr u.ne_zero, norm_ne_zero_iff.mpr v.ne_zero]

omit [CompleteSpace K] in
theorem unitLogNorm_zpow (u : Kˣ) (n : ℤ) :
    unitLogNorm (u ^ n) = (n : ℝ) * unitLogNorm u := by
  simp [unitLogNorm, norm_zpow, Real.log_zpow]

omit [CompleteSpace K] in
/-- The real logarithmic period of the odd graph generator is nonzero. -/
theorem oddGraphPeriod_unitLogNorm_ne_zero (t : TateParameter K) (k : ℕ) :
    unitLogNorm (t.q ^ (2 * k + 1)) ≠ 0 := by
  have hlog : Real.log ‖(t.q : K)‖ < 0 :=
    Real.log_neg t.norm_q_pos t.norm_lt_one
  change Real.log ‖(t.q : K) ^ (2 * k + 1)‖ ≠ 0
  rw [norm_pow, Real.log_pow]
  exact (mul_neg_of_pos_of_neg (by positivity) hlog).ne

omit [CompleteSpace K] in
/-- Integer powers with nonzero logarithmic norm meet a compact set of units
for only finitely many exponents. -/
theorem finite_zpow_mem_compact
    (p : Kˣ) (hp : unitLogNorm p ≠ 0)
    {C : Set Kˣ} (hC : IsCompact C) :
    Set.Finite {n : ℤ | p ^ n ∈ C} := by
  have himage : IsCompact (unitLogNorm '' C) :=
    hC.image continuous_unitLogNorm
  have hfinite : Set.Finite
      ((zmultiplesHom ℝ (unitLogNorm p)) ⁻¹' (unitLogNorm '' C)) :=
    (tendsto_cofinite_cocompact_iff.mp
      (Int.tendsto_zmultiplesHom_cofinite hp)) _ himage
  apply hfinite.subset
  intro n hn
  change zmultiplesHom ℝ (unitLogNorm p) n ∈ unitLogNorm '' C
  refine ⟨p ^ n, hn, ?_⟩
  simpa [zmultiplesHom] using unitLogNorm_zpow p n

/-- Exact translation law for the continuous logarithmic base height. -/
theorem unitLogNorm_oddPeriodShiftIterate_base
    (t : TateParameter K) (k : ℕ) (n : ℤ)
    (z : TateThetaRootPoint t (2 * k + 1)) :
    unitLogNorm (oddPeriodShiftIterate t k n z).base =
      (n : ℝ) * unitLogNorm (t.q ^ (2 * k + 1)) +
        unitLogNorm z.base := by
  rw [oddPeriodShiftIterate_base, unitLogNorm_mul, unitLogNorm_zpow]

/-- The actual odd graph-period action is properly discontinuous.  This is
the compact-set definition, proved from the real logarithmic base height. -/
theorem oddPeriodShiftAddAction_properlyDiscontinuousVAdd
    (t : TateParameter K) (k : ℕ) :
    letI := oddPeriodShiftAddAction t k
    ProperlyDiscontinuousVAdd ℤ
      (TateThetaRootPoint t (2 * k + 1)) := by
  letI := oddPeriodShiftAddAction t k
  constructor
  intro C D hC hD
  let h : TateThetaRootPoint t (2 * k + 1) → ℝ :=
    fun z => unitLogNorm z.base
  let a : ℝ := unitLogNorm (t.q ^ (2 * k + 1))
  let R : Set ℝ :=
    (fun xy : ℝ × ℝ => xy.1 - xy.2) '' ((h '' D) ×ˢ (h '' C))
  have hh : Continuous h :=
    continuous_unitLogNorm.comp (continuous_base t (2 * k + 1))
  have hR : IsCompact R := by
    exact ((hD.image hh).prod (hC.image hh)).image
      (continuous_fst.sub continuous_snd)
  have ha : a ≠ 0 := oddGraphPeriod_unitLogNorm_ne_zero t k
  have hfinite : Set.Finite ((zmultiplesHom ℝ a) ⁻¹' R) :=
    (tendsto_cofinite_cocompact_iff.mp
      (Int.tendsto_zmultiplesHom_cofinite ha)) _ hR
  apply hfinite.subset
  intro n hn
  rcases hn with ⟨y, ⟨z, hzC, rfl⟩, hyD⟩
  change zmultiplesHom ℝ a n ∈ R
  refine ⟨(h (n +ᵥ z), h z), ?_, ?_⟩
  · exact ⟨⟨n +ᵥ z, hyD, rfl⟩, ⟨z, hzC, rfl⟩⟩
  · dsimp [h, a]
    change unitLogNorm (oddPeriodShiftIterate t k n z).base -
      unitLogNorm z.base = _
    rw [unitLogNorm_oddPeriodShiftIterate_base]
    simp

/-- A concrete height band around every root point is disjoint from all of
its nontrivial graph-period translates.  Unlike the generic compact-set
argument, this local statement needs no local compactness hypothesis. -/
theorem oddPeriodShiftAddAction_disjoint_nhds
    (t : TateParameter K) (k : ℕ)
    (e : TateThetaRootPoint t (2 * k + 1)) :
    letI := oddPeriodShiftAddAction t k
    ∃ U ∈ 𝓝 e, ∀ n : ℤ,
      ((n +ᵥ ·) '' U ∩ U).Nonempty → n = 0 := by
  letI := oddPeriodShiftAddAction t k
  let h : TateThetaRootPoint t (2 * k + 1) → ℝ :=
    fun z => unitLogNorm z.base
  let a : ℝ := unitLogNorm (t.q ^ (2 * k + 1))
  have hh : Continuous h :=
    continuous_unitLogNorm.comp (continuous_base t (2 * k + 1))
  have ha : a ≠ 0 := oddGraphPeriod_unitLogNorm_ne_zero t k
  have ha_pos : 0 < |a| := abs_pos.mpr ha
  let U : Set (TateThetaRootPoint t (2 * k + 1)) :=
    h ⁻¹' Ioo (h e - |a| / 4) (h e + |a| / 4)
  have heU : U ∈ 𝓝 e := by
    apply (isOpen_Ioo.preimage hh).mem_nhds
    change h e - |a| / 4 < h e ∧ h e < h e + |a| / 4
    constructor <;> nlinarith
  refine ⟨U, heU, ?_⟩
  intro n hn
  rcases hn with ⟨y, ⟨z, hzU, rfl⟩, hnzU⟩
  change h z ∈ Ioo (h e - |a| / 4) (h e + |a| / 4) at hzU
  change h (n +ᵥ z) ∈ Ioo (h e - |a| / 4) (h e + |a| / 4) at hnzU
  have hshift : h (n +ᵥ z) = (n : ℝ) * a + h z := by
    dsimp [h, a]
    change unitLogNorm (oddPeriodShiftIterate t k n z).base = _
    exact unitLogNorm_oddPeriodShiftIterate_base t k n z
  rcases hzU with ⟨hz_lower, hz_upper⟩
  rcases hnzU with ⟨hnz_lower, hnz_upper⟩
  rw [hshift] at hnz_lower hnz_upper
  have hsmall : |(n : ℝ) * a| < |a| := by
    rw [abs_lt]
    constructor <;> nlinarith
  have hnsmall : |(n : ℝ)| < 1 := by
    rw [abs_mul] at hsmall
    nlinarith [abs_nonneg (n : ℝ)]
  rw [← Int.cast_abs, ← Int.cast_one, Int.cast_lt] at hnsmall
  exact Int.abs_lt_one_iff.mp hnsmall

/-- The orbit projection is an ordinary topological covering quotient.  All
fields are supplied by the actual quotient relation, the continuous action,
and the explicit disjoint height bands above.  This statement carries no
rigid-analytic or Berkovich structure. -/
theorem oddPeriodShift_orbitQuotient_isAddQuotientCoveringMap
    (t : TateParameter K) (k : ℕ) :
    letI := oddPeriodShiftAddAction t k
    IsAddQuotientCoveringMap
      (Quotient.mk <| AddAction.orbitRel ℤ
        (TateThetaRootPoint t (2 * k + 1))) ℤ := by
  letI := oddPeriodShiftAddAction t k
  refine ⟨isQuotientMap_quotient_mk',
    oddPeriodShiftAddAction_continuousConstVAdd t k, ?_, ?_⟩
  · exact Quotient.eq''
  · exact oddPeriodShiftAddAction_disjoint_nhds t k

end TateThetaRootPoint

end IUTThreeClosures
