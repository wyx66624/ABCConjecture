/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateThetaOddGraphProperness
import TateCurvesTheta.TateCurve.Quotient
import Mathlib.Topology.Instances.AddCircle.Defs

/-!
# The honest valuation-circle comparison for odd graph descent

This file constructs the first comparison available from the current local
APIs.  The verified topological orbit quotient of the odd theta-root locus
maps continuously to the existing Tate `K`-point quotient `Kˣ / q^ℤ` by its
base coordinate.  The logarithmic norm then gives a continuous homomorphism
from that quotient to the real additive circle of period `ord(q)`.

The final section proves a precise obstruction to upgrading this map to a
skeleton equivalence on `K`-points: every nontrivial norm-one unit gives a
nonzero element in its kernel.  No rigid, adic, Huber, Berkovich, or tempered
structure is introduced or assumed.
-/

namespace IUTThreeClosures

open Filter Set Topology
open TateCurvesTheta

universe u

variable {K : Type u} [NormedField K] [CompleteSpace K]

namespace TateThetaRootPoint

/-- The orbit relation of the actual odd graph-period action, frozen as an
explicit setoid so its quotient can be named without a hidden action field. -/
noncomputable def oddGraphOrbitRel
    (t : TateParameter K) (k : ℕ) :
    Setoid (TateThetaRootPoint t (2 * k + 1)) := by
  letI := oddPeriodShiftAddAction t k
  exact AddAction.orbitRel ℤ (TateThetaRootPoint t (2 * k + 1))

/-- The ordinary topological orbit quotient already proved to be covered by
the theta-root locus. -/
abbrev OddGraphOrbitQuotient (t : TateParameter K) (k : ℕ) :=
  Quotient (oddGraphOrbitRel t k)

/-- The orbit projection, with the action relation made explicit. -/
noncomputable def oddGraphOrbitMk
    (t : TateParameter K) (k : ℕ) :
    TateThetaRootPoint t (2 * k + 1) →
      OddGraphOrbitQuotient t k :=
  Quotient.mk (oddGraphOrbitRel t k)

/-- Multiplying the base by any integral odd graph period is invisible in
the existing Tate quotient `Kˣ / q^ℤ`. -/
theorem toAnalyticQuotient_oddPeriodShiftIterate_base
    (t : TateParameter K) (k : ℕ) (n : ℤ)
    (z : TateThetaRootPoint t (2 * k + 1)) :
    t.toAnalyticQuotient (oddPeriodShiftIterate t k n z).base =
      t.toAnalyticQuotient z.base := by
  rw [oddPeriodShiftIterate_base, map_mul]
  have hQ : t.q ^ (2 * k + 1) ∈ t.qpowers :=
    Subgroup.pow_mem _ (Subgroup.mem_zpowers t.q) (2 * k + 1)
  have hperiod : (t.q ^ (2 * k + 1)) ^ n ∈ t.qpowers :=
    Subgroup.zpow_mem _ hQ n
  have hone : t.toAnalyticQuotient ((t.q ^ (2 * k + 1)) ^ n) = 1 := by
    change (QuotientGroup.mk' t.qpowers)
      ((t.q ^ (2 * k + 1)) ^ n) = 1
    rw [QuotientGroup.mk'_apply, QuotientGroup.eq_one_iff]
    exact hperiod
  rw [hone]
  change (1 : t.AnalyticQuotient) * t.toAnalyticQuotient z.base =
    t.toAnalyticQuotient z.base
  exact one_mul (t.toAnalyticQuotient z.base)

/-- The base Tate-quotient class is constant on the explicit orbit relation. -/
theorem toAnalyticQuotient_base_eq_of_oddGraphOrbitRel
    (t : TateParameter K) (k : ℕ)
    {x y : TateThetaRootPoint t (2 * k + 1)}
    (hxy : oddGraphOrbitRel t k x y) :
    t.toAnalyticQuotient x.base = t.toAnalyticQuotient y.base := by
  letI := oddPeriodShiftAddAction t k
  change x ∈ AddAction.orbit ℤ y at hxy
  obtain ⟨n, rfl⟩ := AddAction.mem_orbit_iff.mp hxy
  exact toAnalyticQuotient_oddPeriodShiftIterate_base t k n y

/-- The comparison from the verified theta-root orbit quotient to the
existing group/topological Tate quotient. -/
noncomputable def oddGraphOrbitToAnalyticQuotient
    (t : TateParameter K) (k : ℕ) :
    OddGraphOrbitQuotient t k → t.AnalyticQuotient :=
  @Quotient.lift _ _ (oddGraphOrbitRel t k)
    (fun z : TateThetaRootPoint t (2 * k + 1) =>
      t.toAnalyticQuotient z.base)
    (by
      intro x y hxy
      exact toAnalyticQuotient_base_eq_of_oddGraphOrbitRel t k hxy)

@[simp]
theorem oddGraphOrbitToAnalyticQuotient_mk
    (t : TateParameter K) (k : ℕ)
    (z : TateThetaRootPoint t (2 * k + 1)) :
    oddGraphOrbitToAnalyticQuotient t k (oddGraphOrbitMk t k z) =
      t.toAnalyticQuotient z.base :=
  by
    simp [oddGraphOrbitToAnalyticQuotient, oddGraphOrbitMk]

omit [CompleteSpace K] in
/-- The prequotient base-class map is continuous for the honest coordinate
topology on the theta-root locus. -/
theorem continuous_toAnalyticQuotient_base
    (t : TateParameter K) (k : ℕ) :
    Continuous (fun z : TateThetaRootPoint t (2 * k + 1) =>
      t.toAnalyticQuotient z.base) :=
  QuotientGroup.continuous_mk.comp (continuous_base t (2 * k + 1))

/-- The base comparison is continuous for the two actual quotient
topologies. -/
theorem continuous_oddGraphOrbitToAnalyticQuotient
    (t : TateParameter K) (k : ℕ) :
    Continuous (oddGraphOrbitToAnalyticQuotient t k) := by
  change Continuous
    (@Quotient.lift _ _ (oddGraphOrbitRel t k)
      (fun z : TateThetaRootPoint t (2 * k + 1) =>
        t.toAnalyticQuotient z.base) _)
  exact (continuous_toAnalyticQuotient_base t k).quotient_lift (by
    intro x y hxy
    exact toAnalyticQuotient_base_eq_of_oddGraphOrbitRel t k hxy)

/-! ## The logarithmic valuation circle -/

/-- The real valuation circle with positive period `ord(q)`. -/
noncomputable abbrev TateValuationCircle (t : TateParameter K) :=
  AddCircle t.ord

/-- The logarithmic order of a unit, reduced modulo the period `ord(q)`, as
a multiplicative homomorphism into the multiplicativized additive circle. -/
noncomputable def unitOrderCircleHom (t : TateParameter K) :
    Kˣ →* Multiplicative (TateValuationCircle t) where
  toFun u := Multiplicative.ofAdd
    ((-unitLogNorm u : ℝ) : TateValuationCircle t)
  map_one' := by
    change ((-unitLogNorm (1 : Kˣ) : ℝ) : TateValuationCircle t) = 0
    simp [unitLogNorm]
  map_mul' u v := by
    change ((-unitLogNorm (u * v) : ℝ) : TateValuationCircle t) =
      ((-unitLogNorm u : ℝ) : TateValuationCircle t) +
        ((-unitLogNorm v : ℝ) : TateValuationCircle t)
    rw [unitLogNorm_mul, neg_add]
    exact AddCircle.coe_add t.ord (-unitLogNorm u) (-unitLogNorm v)

omit [CompleteSpace K] in
/-- The Tate parameter has one full valuation period, hence maps to the
identity of the circle. -/
@[simp]
theorem unitOrderCircleHom_q (t : TateParameter K) :
    unitOrderCircleHom t t.q = 1 := by
  change ((-unitLogNorm t.q : ℝ) : TateValuationCircle t) = 0
  simpa [unitLogNorm, TateParameter.ord] using
    (AddCircle.coe_period t.ord)

omit [CompleteSpace K] in
/-- Every integral power of the Tate period lies in the kernel. -/
theorem qpowers_le_unitOrderCircleHom_ker (t : TateParameter K) :
    t.qpowers ≤ (unitOrderCircleHom t).ker := by
  rw [show t.qpowers = Subgroup.zpowers t.q from rfl, Subgroup.zpowers_le]
  exact unitOrderCircleHom_q t

/-- The logarithmic order descends from units to the existing Tate quotient. -/
noncomputable def valuationCircleMap (t : TateParameter K) :
    t.AnalyticQuotient →* Multiplicative (TateValuationCircle t) :=
  QuotientGroup.lift t.qpowers (unitOrderCircleHom t)
    (qpowers_le_unitOrderCircleHom_ker t)

omit [CompleteSpace K] in
@[simp]
theorem valuationCircleMap_mk (t : TateParameter K) (u : Kˣ) :
    valuationCircleMap t (t.toAnalyticQuotient u) =
      Multiplicative.ofAdd
        ((-unitLogNorm u : ℝ) : TateValuationCircle t) := by
  exact QuotientGroup.lift_mk' _ _ u

omit [CompleteSpace K] in
/-- The unit-level logarithmic circle coordinate is continuous. -/
theorem continuous_unitOrderCircleHom (t : TateParameter K) :
    Continuous (unitOrderCircleHom t) := by
  change Continuous fun u : Kˣ => Multiplicative.ofAdd
    ((-unitLogNorm u : ℝ) : TateValuationCircle t)
  change Continuous fun u : Kˣ =>
    ((-unitLogNorm u : ℝ) : TateValuationCircle t)
  exact (AddCircle.continuous_mk' t.ord).comp continuous_unitLogNorm.neg

omit [CompleteSpace K] in
/-- The descended valuation-circle map is continuous for the quotient
topology on `Kˣ/q^ℤ`. -/
theorem continuous_valuationCircleMap (t : TateParameter K) :
    Continuous (valuationCircleMap t) := by
  rw [← QuotientGroup.isOpenQuotientMap_mk.continuous_comp_iff]
  simpa [Function.comp_def, valuationCircleMap] using
    continuous_unitOrderCircleHom t

/-- The complete comparison triangle has the advertised explicit value on
every root point. -/
@[simp]
theorem valuationCircleMap_oddGraphOrbitToAnalyticQuotient_mk
    (t : TateParameter K) (k : ℕ)
    (z : TateThetaRootPoint t (2 * k + 1)) :
    valuationCircleMap t
        (oddGraphOrbitToAnalyticQuotient t k (oddGraphOrbitMk t k z)) =
      Multiplicative.ofAdd
        ((-unitLogNorm z.base : ℝ) : TateValuationCircle t) := by
  rw [oddGraphOrbitToAnalyticQuotient_mk, valuationCircleMap_mk]

/-! ## A precise obstruction to a `K`-point skeleton equivalence -/

omit [CompleteSpace K] in
/-- A nontrivial norm-one unit cannot be an integral power of a Tate
parameter. -/
theorem norm_one_unit_not_mem_qpowers
    (t : TateParameter K) {u : Kˣ}
    (hu : ‖(u : K)‖ = 1) (hu_ne : u ≠ 1) :
    u ∉ t.qpowers := by
  intro humem
  obtain ⟨n, rfl⟩ := Subgroup.mem_zpowers_iff.mp humem
  have hnorm : ‖(t.q : K)‖ ^ n = ‖(t.q : K)‖ ^ (0 : ℤ) := by
    calc
      ‖(t.q : K)‖ ^ n = ‖((t.q ^ n : Kˣ) : K)‖ :=
        (t.toTateDatum.norm_val_zpow n).symm
      _ = 1 := hu
      _ = ‖(t.q : K)‖ ^ (0 : ℤ) := by simp
  have hn : n = 0 :=
    zpow_right_injective₀ t.norm_q_pos t.norm_lt_one.ne hnorm
  subst n
  exact hu_ne (by simp)

omit [CompleteSpace K] in
/-- The class of a nontrivial norm-one unit is nontrivial in `Kˣ/q^ℤ`. -/
theorem toAnalyticQuotient_norm_one_unit_ne_one
    (t : TateParameter K) {u : Kˣ}
    (hu : ‖(u : K)‖ = 1) (hu_ne : u ≠ 1) :
    t.toAnalyticQuotient u ≠ 1 := by
  intro heq
  apply norm_one_unit_not_mem_qpowers t hu hu_ne
  change (QuotientGroup.mk' t.qpowers) u = 1 at heq
  rwa [QuotientGroup.mk'_apply, QuotientGroup.eq_one_iff] at heq

omit [CompleteSpace K] in
/-- Every norm-one unit maps to the zero valuation-circle coordinate. -/
theorem valuationCircleMap_norm_one_unit
    (t : TateParameter K) {u : Kˣ} (hu : ‖(u : K)‖ = 1) :
    valuationCircleMap t (t.toAnalyticQuotient u) = 1 := by
  rw [valuationCircleMap_mk]
  change ((-unitLogNorm u : ℝ) : TateValuationCircle t) = 0
  simp [unitLogNorm, hu]

omit [CompleteSpace K] in
/-- A single nontrivial norm-one unit is a concrete obstruction to the
valuation-circle map being injective, hence to treating it as the missing
Berkovich skeleton equivalence. -/
theorem valuationCircleMap_not_injective_of_norm_one_unit
    (t : TateParameter K) {u : Kˣ}
    (hu : ‖(u : K)‖ = 1) (hu_ne : u ≠ 1) :
    ¬ Function.Injective (valuationCircleMap t) := by
  intro hinj
  apply toAnalyticQuotient_norm_one_unit_ne_one t hu hu_ne
  apply hinj
  simpa using valuationCircleMap_norm_one_unit t hu

omit [CompleteSpace K] in
/-- In the intended characteristic-zero setting, `-1` supplies a canonical
nontrivial norm-one kernel element, so no extra witness is needed. -/
theorem valuationCircleMap_not_injective_of_charZero
    (t : TateParameter K) [CharZero K] :
    ¬ Function.Injective (valuationCircleMap t) := by
  apply valuationCircleMap_not_injective_of_norm_one_unit
    (t := t) (u := (-1 : Kˣ))
  · simp
  · intro h
    have hval : (-1 : K) = 1 := by
      simpa using congrArg Units.val h
    norm_num at hval

end TateThetaRootPoint

end IUTThreeClosures
