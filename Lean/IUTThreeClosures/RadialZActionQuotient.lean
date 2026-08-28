/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Topology.Instances.AddCircle.Real

/-!
# Radial integer actions and compact quotients

This module isolates the topological mechanism used by the corrected Tate
 theta-root construction.

An integer action on a space `X` is called radial when it admits a real
coordinate `rho` satisfying

`rho(n • x) = rho(x) + n`.

No metric or analytic geometry is needed for the following consequences:

* every bounded radial band meets only finitely many of its integer translates;
* every orbit has a unique representative in the half-open strip
  `0 <= rho < 1`;
* the orbit relation is an equivalence relation;
* if the closed strip `0 <= rho <= 1` is compact and the orbit projection is
  continuous, then the orbit quotient is compact.

Thus a future Berkovich/Tate theorem need only supply a continuous radial
integer action and compactness of one closed fundamental strip.  The quotient
and its compactness then follow formally.
-/

namespace IUTThreeClosures

universe u

/-- An honest action of `ℤ` together with an exactly equivariant real radial
coordinate. -/
structure RadialZAction (X : Type u) where
  iterate : ℤ → X → X
  iterate_zero : ∀ x, iterate 0 x = x
  iterate_add : ∀ m n x,
    iterate (m + n) x = iterate m (iterate n x)
  rho : X → ℝ
  rho_iterate : ∀ n x, rho (iterate n x) = rho x + (n : ℝ)

namespace RadialZAction

variable {X : Type u} (A : RadialZAction X)

/-- Orbit equivalence for the integer action. -/
def orbitRel (x y : X) : Prop :=
  ∃ n : ℤ, A.iterate n x = y

/-- The integer orbit relation is an equivalence relation. -/
def orbitSetoid : Setoid X where
  r := A.orbitRel
  iseqv := by
    refine ⟨?_, ?_, ?_⟩
    · intro x
      exact ⟨0, A.iterate_zero x⟩
    · intro x y hxy
      rcases hxy with ⟨n, rfl⟩
      refine ⟨-n, ?_⟩
      rw [← A.iterate_add]
      simp [A.iterate_zero]
    · intro x y z hxy hyz
      rcases hxy with ⟨n, rfl⟩
      rcases hyz with ⟨m, rfl⟩
      refine ⟨m + n, ?_⟩
      exact A.iterate_add m n x

/-- The orbit quotient. -/
abbrev OrbitQuotient := Quotient A.orbitSetoid

/-- The canonical orbit projection. -/
def quotientMap : X → A.OrbitQuotient :=
  Quotient.mk A.orbitSetoid

/-- A bounded radial band. -/
def band (a b : ℝ) : Set X :=
  {x | a ≤ A.rho x ∧ A.rho x ≤ b}

/-- Indices whose translate of a band meets the band. -/
def bandIntersectionIndices (a b : ℝ) : Set ℤ :=
  {n | ∃ x, x ∈ A.band a b ∧ A.iterate n x ∈ A.band a b}

/-- A translate meeting a band has an index bounded solely by the band. -/
theorem index_bounds_of_band_intersection
    {a b : ℝ} {n : ℤ}
    (hn : n ∈ A.bandIntersectionIndices a b) :
    a - b ≤ (n : ℝ) ∧ (n : ℝ) ≤ b - a := by
  rcases hn with ⟨x, hx, hnx⟩
  change a ≤ A.rho x ∧ A.rho x ≤ b at hx
  change a ≤ A.rho (A.iterate n x) ∧ A.rho (A.iterate n x) ≤ b at hnx
  rw [A.rho_iterate] at hnx
  constructor <;> linarith

/-- An explicit finite window containing every translate meeting a band. -/
noncomputable def bandWindow (a b : ℝ) : Finset ℤ :=
  Finset.Icc ⌊a - b⌋ ⌈b - a⌉

/-- Every intersecting translate belongs to the explicit finite window. -/
theorem mem_bandWindow_of_intersection
    {a b : ℝ} {n : ℤ}
    (hn : n ∈ A.bandIntersectionIndices a b) :
    n ∈ A.bandWindow a b := by
  have hb := A.index_bounds_of_band_intersection hn
  have hlowerReal : ((⌊a - b⌋ : ℤ) : ℝ) ≤ (n : ℝ) :=
    (Int.floor_le _).trans hb.1
  have hupperReal : (n : ℝ) ≤ ((⌈b - a⌉ : ℤ) : ℝ) :=
    hb.2.trans (Int.le_ceil _)
  have hlower : (⌊a - b⌋ : ℤ) ≤ n := by
    exact_mod_cast hlowerReal
  have hupper : n ≤ (⌈b - a⌉ : ℤ) := by
    exact_mod_cast hupperReal
  exact Finset.mem_Icc.mpr ⟨hlower, hupper⟩

/-- **Radial proper-discontinuity estimate.**  A bounded radial band meets only
finitely many integer translates of itself. -/
theorem finite_bandIntersectionIndices (a b : ℝ) :
    (A.bandIntersectionIndices a b).Finite := by
  refine (A.bandWindow a b).finite_toSet.subset ?_
  intro n hn
  exact A.mem_bandWindow_of_intersection hn

/-- The half-open fundamental strip. -/
def fundamentalStrip : Set X :=
  {x | 0 ≤ A.rho x ∧ A.rho x < 1}

/-- The closed strip used in the compactness theorem. -/
def closedStrip : Set X :=
  {x | 0 ≤ A.rho x ∧ A.rho x ≤ 1}

/-- Canonical integer bringing a point into the fundamental strip. -/
noncomputable def normalizeIndex (x : X) : ℤ :=
  -⌊A.rho x⌋

/-- The canonical translate lies in the half-open strip. -/
theorem iterate_normalizeIndex_mem (x : X) :
    A.iterate (A.normalizeIndex x) x ∈ A.fundamentalStrip := by
  have hfloor : ((⌊A.rho x⌋ : ℤ) : ℝ) ≤ A.rho x := Int.floor_le _
  have hlt : A.rho x < ((⌊A.rho x⌋ : ℤ) : ℝ) + 1 :=
    Int.lt_floor_add_one _
  change
    0 ≤ A.rho (A.iterate (A.normalizeIndex x) x) ∧
      A.rho (A.iterate (A.normalizeIndex x) x) < 1
  rw [A.rho_iterate]
  dsimp [normalizeIndex]
  push_cast
  constructor <;> linarith

/-- The normalizing integer is unique. -/
theorem normalizeIndex_unique
    (x : X) (n : ℤ)
    (hn : A.iterate n x ∈ A.fundamentalStrip) :
    n = A.normalizeIndex x := by
  have hc := A.iterate_normalizeIndex_mem x
  change 0 ≤ A.rho (A.iterate n x) ∧ A.rho (A.iterate n x) < 1 at hn
  change
    0 ≤ A.rho (A.iterate (A.normalizeIndex x) x) ∧
      A.rho (A.iterate (A.normalizeIndex x) x) < 1 at hc
  rw [A.rho_iterate] at hn hc
  have hupper :
      ((n - A.normalizeIndex x : ℤ) : ℝ) < 1 := by
    push_cast
    linarith
  have hlower :
      (-1 : ℝ) < ((n - A.normalizeIndex x : ℤ) : ℝ) := by
    push_cast
    linarith
  have hupperInt : n - A.normalizeIndex x < 1 := by
    exact_mod_cast hupper
  have hlowerInt : -1 < n - A.normalizeIndex x := by
    exact_mod_cast hlower
  omega

/-- Every orbit has exactly one representative in the half-open strip. -/
theorem exists_unique_fundamentalStrip (x : X) :
    ∃! n : ℤ, A.iterate n x ∈ A.fundamentalStrip := by
  refine ⟨A.normalizeIndex x, A.iterate_normalizeIndex_mem x, ?_⟩
  intro n hn
  exact A.normalizeIndex_unique x n hn

/-- The normalized point represents the same quotient class. -/
theorem quotientMap_normalized (x : X) :
    A.quotientMap (A.iterate (A.normalizeIndex x) x) =
      A.quotientMap x := by
  apply Quotient.sound
  exact A.orbitSetoid.symm ⟨A.normalizeIndex x, rfl⟩

end RadialZAction

section TopologicalQuotient

variable {X : Type u} [TopologicalSpace X]
variable (A : RadialZAction X)

/-- The orbit projection restricted to the closed fundamental strip. -/
def closedStripQuotientMap :
    ↥A.closedStrip → A.OrbitQuotient :=
  fun x => A.quotientMap x.1

/-- Every quotient class has a representative in the closed strip. -/
theorem surjective_closedStripQuotientMap :
    Function.Surjective A.closedStripQuotientMap := by
  intro q
  refine Quotient.inductionOn q ?_
  intro x
  let y := A.iterate (A.normalizeIndex x) x
  have hyHalf : y ∈ A.fundamentalStrip := A.iterate_normalizeIndex_mem x
  have hyClosed : y ∈ A.closedStrip := ⟨hyHalf.1, hyHalf.2.le⟩
  refine ⟨⟨y, hyClosed⟩, ?_⟩
  exact A.quotientMap_normalized x

/-- If the orbit projection is continuous and one closed strip is compact,
then the full orbit quotient is compact. -/
theorem isCompact_univ_orbitQuotient
    (hcontinuous : Continuous A.quotientMap)
    (hcompact : IsCompact A.closedStrip) :
    IsCompact (Set.univ : Set A.OrbitQuotient) := by
  have hrestricted : Continuous A.closedStripQuotientMap :=
    hcontinuous.comp continuous_subtype_val
  have himage :
      A.closedStripQuotientMap '' Set.univ =
        (Set.univ : Set A.OrbitQuotient) := by
    ext q
    constructor
    · intro _
      trivial
    · intro _
      rcases A.surjective_closedStripQuotientMap q with ⟨x, rfl⟩
      exact ⟨x, Set.mem_univ _, rfl⟩
  have hdomain : IsCompact (Set.univ : Set ↥A.closedStrip) := by
    simpa only [isCompact_univ_iff] using
      (show CompactSpace ↥A.closedStrip from
        isCompact_iff_compactSpace.mp hcompact)
  rw [← himage]
  exact hdomain.image hrestricted.continuousOn

end TopologicalQuotient

end IUTThreeClosures
