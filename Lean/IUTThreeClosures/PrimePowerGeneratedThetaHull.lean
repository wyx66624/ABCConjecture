/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneratedSource
import IUTThreeClosures.PrimePowerQPilotRegion
import IUTThreeClosures.PublicThetaHullUpperBound
import Mathlib.Data.Nat.Find

/-!
# Prime-power generated theta hulls

At a nonarchimedean rational place, the Kummer images used by the q-pilot are
fractional-ideal regions of the form `p^n O`. These regions form a nested
chain: a larger exponent gives a smaller region.

For every component, the set of exponents occurring among the nonempty family
of actual outputs is a nonempty subset of `ℕ`; hence it has a canonically
attained least element. No minimum exponent, lower-bound theorem, or
simultaneous minimizing output is supplied as data.

The least holomorphic hull of the union is exactly the product of these
componentwise minimum regions. Indeed, this product contains every output.
Conversely, if a hull region contains the union, then for a fixed component
`c` one inserts an arbitrary point of the minimum region at `c` into an output
attaining the minimum at `c`, and puts zero in all other components. This
vector belongs to the union and therefore to the competing hull; projecting
to `c` proves the required component containment.

Thus the holomorphic hull itself performs the independent mixing of local
Kummer choices. A single globally minimizing output and an extra multiradial
independence axiom are unnecessary.

Applied to the actual generated public theta-pilot, the theorem gives at every
finite rational place

`thetaHull = ∏_c p^(minimumExponent c) O_c`

and hence the exact packet formula

`∑_c packetWeight(c) * (-(minimumExponent c : ℝ) * log p)`.

The remaining finite-place source obligation is reduced to the local statement
that every concrete theta/Kummer/tempered output is a prime-power product
region and that the rational prime has nonzero image in every summand field.
-/

set_option linter.checkUnivs false

namespace Iut

open scoped Pointwise

universe u₁ u₂ v₁

namespace PrimePowerQPilotRegion

/-- Prime-power image membership is multiplication by the corresponding
natural power of the rational prime. -/
theorem mem_primePowerImage_iff
    {F : Type*} [Field F]
    (p : Nat.Primes) (n : ℕ) (U : Set F) (x : F) :
    x ∈ primePowerImage p n U ↔
      ∃ y ∈ U, x = ((((p : ℕ) : F)) ^ n) * y := by
  induction n generalizing x with
  | zero => simp [primePowerImage]
  | succ n ih =>
      rw [primePowerImage]
      constructor
      · rintro ⟨z, hz, rfl⟩
        rcases (ih z).1 hz with ⟨y, hy, rfl⟩
        refine ⟨y, hy, ?_⟩
        rw [pow_succ]
        ring
      · rintro ⟨y, hy, rfl⟩
        refine ⟨((((p : ℕ) : F)) ^ n) * y, ?_, ?_⟩
        · exact (ih _).2 ⟨y, hy, rfl⟩
        · rw [pow_succ]
          ring

/-- The recursive prime-power image is ordinary pointwise scaling by `p^n`. -/
theorem primePowerImage_eq_pow_smul
    {F : Type*} [Field F]
    (p : Nat.Primes) (n : ℕ) (U : Set F) :
    primePowerImage p n U =
      ((((p : ℕ) : F)) ^ n) • U := by
  ext x
  rw [mem_primePowerImage_iff, Set.mem_smul_set]
  constructor
  · rintro ⟨y, hy, hxy⟩
    exact ⟨y, hy, by simpa [smul_eq_mul] using hxy.symm⟩
  · rintro ⟨y, hy, hxy⟩
    exact ⟨y, hy, by simpa [smul_eq_mul] using hxy.symm⟩

/-- Every natural scalar belongs to every subring. -/
theorem natCast_mem_subring
    {F : Type*} [Field F] (O : Subring F) (n : ℕ) :
    (n : F) ∈ O := by
  induction n with
  | zero => simpa using O.zero_mem
  | succ n ih =>
      simpa [Nat.cast_succ] using O.add_mem ih O.one_mem

/-- Every prime-power image of an integral subring remains in that subring. -/
theorem primePowerImage_integral_subset
    {F : Type*} [Field F]
    (p : Nat.Primes) (O : Subring F) (n : ℕ) :
    primePowerImage p n (O : Set F) ⊆ O := by
  intro x hx
  rcases (mem_primePowerImage_iff p n (O : Set F) x).1 hx with
    ⟨y, hy, rfl⟩
  have hpO : (((p : ℕ) : F)) ∈ O :=
    natCast_mem_subring O (p : ℕ)
  exact O.mul_mem (O.pow_mem hpO n) hy

/-- The chain `p^n O` is antitone in the exponent. -/
theorem primePowerImage_integral_antitone
    {F : Type*} [Field F]
    (p : Nat.Primes) (O : Subring F)
    {m n : ℕ} (hmn : m ≤ n) :
    primePowerImage p n (O : Set F) ⊆
      primePowerImage p m (O : Set F) := by
  intro x hx
  rcases (mem_primePowerImage_iff p n (O : Set F) x).1 hx with
    ⟨y, hy, rfl⟩
  have hpO : (((p : ℕ) : F)) ∈ O :=
    natCast_mem_subring O (p : ℕ)
  apply (mem_primePowerImage_iff p m (O : Set F) _).2
  refine ⟨((((p : ℕ) : F)) ^ (n - m)) * y, ?_, ?_⟩
  · exact O.mul_mem (O.pow_mem hpO (n - m)) hy
  · calc
      ((((p : ℕ) : F)) ^ n) * y =
          ((((p : ℕ) : F)) ^ (m + (n - m))) * y := by
            rw [Nat.add_sub_of_le hmn]
      _ = ((((p : ℕ) : F)) ^ m) *
          (((((p : ℕ) : F)) ^ (n - m)) * y) := by
            rw [pow_add]
            ring

/-- A packet prime-power region is genuinely a public hull region `a · O`. -/
theorem packetPrimePowerRegion_isHullRegion
    {ι : Type u₁} {V : Type u₂}
    {D : LargeVolumeContainerData.{u₁, u₂, v₁} ι V}
    (i : Fin D.proc.length) (p : Nat.Primes)
    (order : D.Components i (.finite p) → ℕ)
    (hp : ∀ c : D.Components i (.finite p),
      (((p : ℕ) : (D.packet i (.finite p)).Summand c)) ≠ 0) :
    (D.packet i (.finite p)).IsHullRegion
      (packetPrimePowerRegion i p order) := by
  refine ⟨fun c =>
      (((p : ℕ) : (D.packet i (.finite p)).Summand c)) ^ order c,
    fun c => pow_ne_zero _ (hp c), ?_⟩
  ext x
  change
    (∀ c, x c ∈ primePowerImage p (order c)
      ((D.packet i (.finite p)).integral c)) ↔
    ∀ c, x c ∈
      ((((p : ℕ) : (D.packet i (.finite p)).Summand c)) ^ order c) •
        ((D.packet i (.finite p)).integral c :
          Set ((D.packet i (.finite p)).Summand c))
  constructor
  · intro hx c
    rw [primePowerImage_eq_pow_smul] at hx
    exact hx c
  · intro hx c
    rw [primePowerImage_eq_pow_smul]
    exact hx c

/-- Zero belongs to every prime-power image of an integral subring. -/
theorem zero_mem_primePowerImage_integral
    {F : Type*} [Field F]
    (p : Nat.Primes) (O : Subring F) (n : ℕ) :
    (0 : F) ∈ primePowerImage p n (O : Set F) := by
  apply (mem_primePowerImage_iff p n (O : Set F) 0).2
  exact ⟨0, O.zero_mem, by simp⟩

end PrimePowerQPilotRegion

end Iut

namespace IUTThreeClosures

open Iut
open scoped Pointwise

universe u v w

variable {AG : AnabelianGeometry.{u}} {TG : TemperedGeometry AG}
variable {D : InitialThetaData AG TG}

/-- Finite-place prime-power description of an actual generated output family.
The minimum exponents are derived canonically from the nonempty output family. -/
structure GeneratedPrimePowerThetaHullData
    (G : GeneratedRHSData.{u, v, w} D) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  exponent :
    (o : G.outputs.Output) →
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
      G.container.Components i (.finite p) → ℕ
  realize_finite : ∀ o i p,
    (G.outputs.realize o i).region (.finite p) =
      PrimePowerQPilotRegion.packetPrimePowerRegion i p
        (exponent o i p)
  prime_ne_zero : ∀ i p c,
    (((p : ℕ) :
      (G.container.packet i (.finite p)).Summand c)) ≠ 0

namespace GeneratedPrimePowerThetaHullData

variable {G : GeneratedRHSData.{u, v, w} D}

/-- There is at least one exponent value at each component, because the output
family is nonempty. -/
theorem exponentValue_exists
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    ∃ n : ℕ, ∃ o : G.outputs.Output,
      A.exponent o i p c = n := by
  let o : G.outputs.Output := Classical.choice G.outputs.outputNonempty
  exact ⟨A.exponent o i p c, o, rfl⟩

/-- Canonical componentwise minimum exponent occurring among the actual
outputs. -/
noncomputable def minimumExponent
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) : ℕ := by
  classical
  exact Nat.find (A.exponentValue_exists i p c)

/-- The canonical minimum is attained by an actual output. -/
theorem minimumExponent_attained
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    ∃ o : G.outputs.Output,
      A.exponent o i p c = A.minimumExponent i p c := by
  classical
  exact Nat.find_spec (A.exponentValue_exists i p c)

/-- The canonical minimum is below every actual output exponent. -/
theorem minimumExponent_le
    (A : GeneratedPrimePowerThetaHullData G)
    (o : G.outputs.Output)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes)
    (c : G.container.Components i (.finite p)) :
    A.minimumExponent i p c ≤ A.exponent o i p c := by
  classical
  exact Nat.find_min' (A.exponentValue_exists i p c) ⟨o, rfl⟩

/-- Every actual finite-place output is contained in the product region given
by the canonical componentwise minimum exponent vector. -/
theorem realize_finite_subset_minimum
    (A : GeneratedPrimePowerThetaHullData G)
    (o : G.outputs.Output)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    (G.outputs.realize o i).region (.finite p) ⊆
      PrimePowerQPilotRegion.packetPrimePowerRegion i p
        (A.minimumExponent i p) := by
  rw [A.realize_finite o i p]
  intro x hx
  change
    (∀ c, x c ∈ PrimePowerQPilotRegion.primePowerImage p
      (A.exponent o i p c)
      ((G.container.packet i (.finite p)).integral c)) at hx
  change
    ∀ c, x c ∈ PrimePowerQPilotRegion.primePowerImage p
      (A.minimumExponent i p c)
      ((G.container.packet i (.finite p)).integral c)
  intro c
  exact PrimePowerQPilotRegion.primePowerImage_integral_antitone
    p ((G.container.packet i (.finite p)).integral c)
    (A.minimumExponent_le o i p c) (hx c)

/-- The generated finite-place union is contained in the canonical minimum
product region. -/
theorem unionRegion_finite_subset_minimum
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    (G.outputs.unionRegion i).region (.finite p) ⊆
      PrimePowerQPilotRegion.packetPrimePowerRegion i p
        (A.minimumExponent i p) := by
  intro x hx
  rcases Set.mem_iUnion.mp hx with ⟨o, hx⟩
  exact A.realize_finite_subset_minimum o i p hx

/-- The canonical minimum prime-power product is the least hull region
containing the actual generated finite-place union. The least product hull
combines the separately attained local minima. -/
theorem minimumRegion_isLeastHullRegion
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    (G.container.packet i (.finite p)).IsLeastHullRegion
      ((G.outputs.unionRegion i).region (.finite p))
      (PrimePowerQPilotRegion.packetPrimePowerRegion i p
        (A.minimumExponent i p)) := by
  refine ⟨
    PrimePowerQPilotRegion.packetPrimePowerRegion_isHullRegion
      i p (A.minimumExponent i p) (A.prime_ne_zero i p),
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
  rcases A.minimumExponent_attained i p c with ⟨o, ho⟩
  classical
  let z : (G.container.packet i (.finite p)).Total :=
    Function.update (fun _ => 0) c (x c)
  have hzOutput :
      z ∈ (G.outputs.realize o i).region (.finite p) := by
    rw [A.realize_finite o i p]
    change
      ∀ d, z d ∈ PrimePowerQPilotRegion.primePowerImage p
        (A.exponent o i p d)
        ((G.container.packet i (.finite p)).integral d)
    intro d
    by_cases hdc : d = c
    · subst d
      rw [ho]
      simpa [z] using hx c
    · have hz0 :=
        PrimePowerQPilotRegion.zero_mem_primePowerImage_integral
          p ((G.container.packet i (.finite p)).integral d)
          (A.exponent o i p d)
      simpa [z, hdc] using hz0
  have hzUnion :
      z ∈ (G.outputs.unionRegion i).region (.finite p) :=
    Set.mem_iUnion.mpr ⟨o, hzOutput⟩
  have hzR' : z ∈ R' := hUnionR' hzUnion
  rw [hRa] at hzR'
  simpa [z] using hzR' c

/-- The actual public theta hull at a finite rational place is exactly the
canonical componentwise-minimum prime-power product region. -/
theorem thetaHull_finite_eq_minimum
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    ((G.toRHSData).thetaHull i).region (.finite p) =
      PrimePowerQPilotRegion.packetPrimePowerRegion i p
        (A.minimumExponent i p) := by
  change
    (G.hull.system i (.finite p)).hull
      ((G.outputs.unionRegion i).region (.finite p)) = _
  exact
    ((G.hull.system i (.finite p)).isLeastHullRegion_hull
      ((G.outputs.unionRegion i).region (.finite p))
      (G.union_hullAdmissible i (.finite p))).unique
        (A.minimumRegion_isLeastHullRegion i p)

/-- Exact finite-place packet formula for the actual generated public theta
hull. -/
theorem packetVol_thetaHull_finite_eq
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    G.vol.packetVol i (.finite p)
        (((G.toRHSData).thetaHull i).region (.finite p)) =
      ∑ c : G.container.Components i (.finite p),
        G.vol.packetWeight i (.finite p) c *
          (- (A.minimumExponent i p c : ℝ) * Real.log p) := by
  rw [A.thetaHull_finite_eq_minimum i p]
  exact PrimePowerQPilotRegion.packetVol_packetPrimePowerRegion
    G.vol i p (A.minimumExponent i p) (A.prime_ne_zero i p)

end GeneratedPrimePowerThetaHullData

end IUTThreeClosures
