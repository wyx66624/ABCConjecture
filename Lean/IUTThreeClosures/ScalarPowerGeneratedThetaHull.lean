/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PrimePowerGeneratedThetaHullComponents

/-!
# Generated theta hulls from actual local scalar powers

The rational-prime-power calculation is useful for public normalization, but
actual Tate/Kummer outputs are naturally powers of a local scalar such as a
Tate parameter or a uniformizer.  This module proves the corresponding local
hull theorem without assuming that the scalar is the rational residue
characteristic.

For every finite packet component choose a nonzero scalar `a` belonging to the
integral subring.  Suppose each concrete output has component region

`a^(n_o) · O`.

These regions are antitone in `n_o`.  The least holomorphic hull of the union
is therefore the product of the componentwise minimum powers, even when the
minimum at different components is attained by different outputs.  The proof
uses zero in all off-diagonal components exactly as in the prime-power case.

The final section separates the purely geometric hull theorem from the local
Haar calculation.  Once a source proves the local scalar-power volume law, the
actual theta-hull component and packet volumes follow with no freely supplied
component upper values.
-/

set_option linter.checkUnivs false

namespace Iut

open scoped Pointwise

universe u₁ u₂ v₁

namespace ScalarPowerRegion

/-- Region obtained by multiplying an integral subring by a power of one
local scalar. -/
def powerRegion
    {F : Type*} [Field F] (a : F) (O : Subring F) (n : ℕ) : Set F :=
  (fun x : F => a ^ n * x) '' (O : Set F)

/-- Image and pointwise-scalar presentations agree. -/
theorem powerRegion_eq_pow_smul
    {F : Type*} [Field F] (a : F) (O : Subring F) (n : ℕ) :
    powerRegion a O n = a ^ n • (O : Set F) := by
  ext x
  constructor
  · rintro ⟨y, hy, rfl⟩
    apply Set.mem_smul_set.mpr
    exact ⟨y, hy, by simp [smul_eq_mul]⟩
  · intro hx
    rcases Set.mem_smul_set.mp hx with ⟨y, hy, hxy⟩
    exact ⟨y, hy, by simpa [smul_eq_mul] using hxy⟩

/-- Zero belongs to every scalar-power region. -/
theorem zero_mem_powerRegion
    {F : Type*} [Field F] (a : F) (O : Subring F) (n : ℕ) :
    (0 : F) ∈ powerRegion a O n := by
  exact ⟨0, O.zero_mem, by simp⟩

/-- If the local scalar is integral, the family `a^n O` is antitone in `n`. -/
theorem powerRegion_antitone
    {F : Type*} [Field F]
    {a : F} {O : Subring F} (ha : a ∈ O)
    {m n : ℕ} (hmn : m ≤ n) :
    powerRegion a O n ⊆ powerRegion a O m := by
  rintro x ⟨y, hy, rfl⟩
  refine ⟨a ^ (n - m) * y, O.mul_mem (O.pow_mem ha _) hy, ?_⟩
  calc
    a ^ m * (a ^ (n - m) * y) =
        a ^ (m + (n - m)) * y := by
      rw [pow_add]
      ring
    _ = a ^ n * y := by
      rw [Nat.add_sub_of_le hmn]

/-- Product packet built from independently chosen scalar powers. -/
def packetScalarPowerRegion
    {ι : Type u₁} {V : Type u₂}
    {D : LargeVolumeContainerData.{u₁, u₂, v₁} ι V}
    (i : Fin D.proc.length) (p : Nat.Primes)
    (scalar : ∀ c : D.Components i (.finite p),
      (D.packet i (.finite p)).Summand c)
    (power : D.Components i (.finite p) → ℕ) :
    Set (D.packet i (.finite p)).Total :=
  (D.packet i (.finite p)).productRegion fun c =>
    powerRegion (scalar c)
      ((D.packet i (.finite p)).integral c) (power c)

/-- A scalar-power packet is a public hull region whenever all scalars are
nonzero. -/
theorem packetScalarPowerRegion_isHullRegion
    {ι : Type u₁} {V : Type u₂}
    {D : LargeVolumeContainerData.{u₁, u₂, v₁} ι V}
    (i : Fin D.proc.length) (p : Nat.Primes)
    (scalar : ∀ c : D.Components i (.finite p),
      (D.packet i (.finite p)).Summand c)
    (power : D.Components i (.finite p) → ℕ)
    (hscalar : ∀ c, scalar c ≠ 0) :
    (D.packet i (.finite p)).IsHullRegion
      (packetScalarPowerRegion i p scalar power) := by
  refine ⟨fun c => (scalar c) ^ power c,
    fun c => pow_ne_zero _ (hscalar c), ?_⟩
  ext x
  change
    (∀ c, x c ∈ powerRegion (scalar c)
      ((D.packet i (.finite p)).integral c) (power c)) ↔
    ∀ c, x c ∈
      (scalar c) ^ power c •
        ((D.packet i (.finite p)).integral c :
          Set ((D.packet i (.finite p)).Summand c))
  constructor
  · intro hx c
    simpa only [powerRegion_eq_pow_smul] using hx c
  · intro hx c
    simpa only [powerRegion_eq_pow_smul] using hx c

end ScalarPowerRegion

end Iut

namespace IUTThreeClosures

open Iut
open scoped Pointwise

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- Finite-place description of actual generated outputs by powers of one
canonical local scalar in each packet component. -/
structure GeneratedScalarPowerThetaHullData
    (G : GeneratedRHSData.{u, v, w} D) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  scalar :
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
    (c : G.container.Components i (.finite p)) →
      (G.container.packet i (.finite p)).Summand c
  scalar_ne_zero : ∀ i p c, scalar i p c ≠ 0
  scalar_mem_integral : ∀ i p c,
    scalar i p c ∈ (G.container.packet i (.finite p)).integral c
  power :
    (o : G.outputs.Output) →
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
      G.container.Components i (.finite p) → ℕ
  realize_finite : ∀ o i p,
    (G.outputs.realize o i).region (.finite p) =
      ScalarPowerRegion.packetScalarPowerRegion i p
        (scalar i p) (power o i p)

namespace GeneratedScalarPowerThetaHullData

variable {G : GeneratedRHSData.{u, v, w} D}

/-- The nonempty output family supplies at least one power value. -/
theorem powerValue_exists
    (A : GeneratedScalarPowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    ∃ n : ℕ, ∃ o : G.outputs.Output,
      A.power o i p c = n := by
  let o : G.outputs.Output := Classical.choice G.outputs.outputNonempty
  exact ⟨A.power o i p c, o, rfl⟩

/-- Canonical componentwise minimum output power. -/
noncomputable def minimumPower
    (A : GeneratedScalarPowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) : ℕ := by
  classical
  exact Nat.find (A.powerValue_exists i p c)

/-- The minimum power is attained by an actual output. -/
theorem minimumPower_attained
    (A : GeneratedScalarPowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    ∃ o : G.outputs.Output,
      A.power o i p c = A.minimumPower i p c := by
  classical
  exact Nat.find_spec (A.powerValue_exists i p c)

/-- The minimum power is below every output power. -/
theorem minimumPower_le
    (A : GeneratedScalarPowerThetaHullData G)
    (o : G.outputs.Output)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    A.minimumPower i p c ≤ A.power o i p c := by
  classical
  exact Nat.find_min' (A.powerValue_exists i p c) ⟨o, rfl⟩

/-- Every actual output is contained in the componentwise-minimum scalar-power
product. -/
theorem realize_finite_subset_minimum
    (A : GeneratedScalarPowerThetaHullData G)
    (o : G.outputs.Output)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    (G.outputs.realize o i).region (.finite p) ⊆
      ScalarPowerRegion.packetScalarPowerRegion i p
        (A.scalar i p) (A.minimumPower i p) := by
  rw [A.realize_finite o i p]
  intro x hx
  change
    (∀ c, x c ∈ ScalarPowerRegion.powerRegion (A.scalar i p c)
      ((G.container.packet i (.finite p)).integral c)
      (A.power o i p c)) at hx
  change
    ∀ c, x c ∈ ScalarPowerRegion.powerRegion (A.scalar i p c)
      ((G.container.packet i (.finite p)).integral c)
      (A.minimumPower i p c)
  intro c
  exact ScalarPowerRegion.powerRegion_antitone
    (A.scalar_mem_integral i p c)
    (A.minimumPower_le o i p c) (hx c)

/-- The generated union is contained in the componentwise-minimum packet. -/
theorem unionRegion_finite_subset_minimum
    (A : GeneratedScalarPowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    (G.outputs.unionRegion i).region (.finite p) ⊆
      ScalarPowerRegion.packetScalarPowerRegion i p
        (A.scalar i p) (A.minimumPower i p) := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨o, hx⟩
  exact A.realize_finite_subset_minimum o i p hx

/-- The componentwise-minimum scalar-power product is the least public hull
region containing the generated finite-place union. -/
theorem minimumRegion_isLeastHullRegion
    (A : GeneratedScalarPowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    (G.container.packet i (.finite p)).IsLeastHullRegion
      ((G.outputs.unionRegion i).region (.finite p))
      (ScalarPowerRegion.packetScalarPowerRegion i p
        (A.scalar i p) (A.minimumPower i p)) := by
  refine ⟨
    ScalarPowerRegion.packetScalarPowerRegion_isHullRegion
      i p (A.scalar i p) (A.minimumPower i p)
      (A.scalar_ne_zero i p),
    A.unionRegion_finite_subset_minimum i p,
    ?_⟩
  intro R' hR' hUnionR'
  rcases hR' with ⟨a, ha, hRa⟩
  rw [hRa]
  intro x hx
  change
    ∀ c, x c ∈ a c •
      ((G.container.packet i (.finite p)).integral c :
        Set ((G.container.packet i (.finite p)).Summand c))
  intro c
  rcases A.minimumPower_attained i p c with ⟨o, ho⟩
  classical
  let z : (G.container.packet i (.finite p)).Total :=
    Function.update (fun _ => 0) c (x c)
  have hzOutput :
      z ∈ (G.outputs.realize o i).region (.finite p) := by
    rw [A.realize_finite o i p]
    change
      ∀ d, z d ∈ ScalarPowerRegion.powerRegion (A.scalar i p d)
        ((G.container.packet i (.finite p)).integral d)
        (A.power o i p d)
    intro d
    by_cases hdc : d = c
    · subst d
      rw [ho]
      simpa [z] using hx c
    · have hz0 := ScalarPowerRegion.zero_mem_powerRegion
        (A.scalar i p d)
        ((G.container.packet i (.finite p)).integral d)
        (A.power o i p d)
      have hzd : z d = 0 := Function.update_noteq hdc
      rw [hzd]
      exact hz0
  have hzUnion :
      z ∈ (G.outputs.unionRegion i).region (.finite p) :=
    Set.mem_iUnion.mpr ⟨o, hzOutput⟩
  have hzR' : z ∈ R' := hUnionR' hzUnion
  rw [hRa] at hzR'
  simpa [z] using hzR' c

/-- The actual generated public theta hull is the componentwise-minimum
scalar-power packet. -/
theorem thetaHull_finite_eq_minimum
    (A : GeneratedScalarPowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    ((G.toRHSData).thetaHull i).region (.finite p) =
      ScalarPowerRegion.packetScalarPowerRegion i p
        (A.scalar i p) (A.minimumPower i p) := by
  change
    (G.hull.system i (.finite p)).hull
      ((G.outputs.unionRegion i).region (.finite p)) = _
  exact
    ((G.hull.system i (.finite p)).isLeastHullRegion_hull
      ((G.outputs.unionRegion i).region (.finite p))
      (G.union_hullAdmissible i (.finite p))).unique
        (A.minimumRegion_isLeastHullRegion i p)

/-- The actual theta-hull component is the corresponding minimum scalar-power
region. -/
theorem thetaHullComponentRegion_finite_eq
    (A : GeneratedScalarPowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    thetaHullComponentRegion (G.toRHSData) i (.finite p) c =
      ScalarPowerRegion.powerRegion (A.scalar i p c)
        ((G.container.packet i (.finite p)).integral c)
        (A.minimumPower i p c) := by
  let P := G.container.packet i (.finite p)
  apply P.component_eq_of_productRegion_eq
  · intro d
    unfold thetaHullComponentRegion
    apply Set.mem_smul_set.mpr
    exact ⟨0, (G.container.packet i (.finite p)).integral d |>.zero_mem,
      by simp [smul_eq_mul]⟩
  · intro d
    exact ScalarPowerRegion.zero_mem_powerRegion
      (A.scalar i p d)
      ((G.container.packet i (.finite p)).integral d)
      (A.minimumPower i p d)
  · change
      (G.container.packet i (.finite p)).scaledIntegral
          (thetaHullScale (G.toRHSData) i (.finite p)) =
        ScalarPowerRegion.packetScalarPowerRegion i p
          (A.scalar i p) (A.minimumPower i p)
    rw [← thetaHull_region_eq_scaledIntegral,
      A.thetaHull_finite_eq_minimum]

end GeneratedScalarPowerThetaHullData

/-- Local scalar-power log-volume theorem for the actual component measures.
For a Haar-normalized local field, `logScale` is the logarithm of the modulus
of the chosen scalar; for a Tate parameter it is `log ‖q‖`. -/
structure GeneratedScalarPowerLogVolumeData
    {G : GeneratedRHSData.{u, v, w} D}
    (A : GeneratedScalarPowerThetaHullData G) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  logScale :
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
      G.container.Components i (.finite p) → ℝ
  componentVol_power : ∀ i p c n,
    G.vol.componentVol i (.finite p) c
        (ScalarPowerRegion.powerRegion (A.scalar i p c)
          ((G.container.packet i (.finite p)).integral c) n) =
      (n : ℝ) * logScale i p c

namespace GeneratedScalarPowerLogVolumeData

variable {G : GeneratedRHSData.{u, v, w} D}
variable {A : GeneratedScalarPowerThetaHullData G}

/-- Literal componentwise formula for the actual scalar-power theta hull. -/
theorem componentVol_thetaHull_finite_eq
    (V : GeneratedScalarPowerLogVolumeData A)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    G.vol.componentVol i (.finite p) c
        (thetaHullComponentRegion (G.toRHSData) i (.finite p) c) =
      (A.minimumPower i p c : ℝ) * V.logScale i p c := by
  rw [A.thetaHullComponentRegion_finite_eq i p c]
  exact V.componentVol_power i p c (A.minimumPower i p c)

/-- Exact packet product-log-volume formula for the generated scalar-power
theta hull. -/
theorem packetVol_thetaHull_finite_eq
    (V : GeneratedScalarPowerLogVolumeData A)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    G.vol.packetVol i (.finite p)
        (((G.toRHSData).thetaHull i).region (.finite p)) =
      ∑ c : G.container.Components i (.finite p),
        G.vol.packetWeight i (.finite p) c *
          ((A.minimumPower i p c : ℝ) * V.logScale i p c) := by
  rw [A.thetaHull_finite_eq_minimum i p]
  unfold ScalarPowerRegion.packetScalarPowerRegion
  rw [G.vol.packetVol_product']
  apply Finset.sum_congr rfl
  intro c hc
  rw [V.componentVol_power i p c (A.minimumPower i p c)]

end GeneratedScalarPowerLogVolumeData

end IUTThreeClosures
