/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GeneratedSource
import IUTThreeClosures.PrimePowerQPilotRegion
import IUTThreeClosures.PublicThetaHullUpperBound

/-!
# Prime-power generated theta hulls

At a nonarchimedean rational place, the Kummer images used by the q-pilot are
fractional-ideal regions of the form `p^n O`.  These regions form a nested
chain: a larger exponent gives a smaller region.  If the allowed output family
has a componentwise lower exponent vector which is attained by one output,
then the union of all outputs is already the single product region determined
by that minimum vector.  Since this product region is itself a hull region,
its public holomorphic hull is fixed by the least-hull operation.

This file proves the resulting formula at the level of the actual generated
public theta-pilot.  In particular, at every finite rational place, each
component of the public theta hull has exact log-volume

`- minimumExponent * log p`,

and the packet log-volume is the corresponding product-weighted sum.  No
independent component-volume formula is assumed.

The simultaneous-attainment premise is the precise coherence condition on the
actual theta/Kummer/tempered output family: the independently minimal local
choices must occur in one allowed multiradial output.  Establishing this
premise from the concrete indeterminacy actions remains the source-level task.
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
  induction n with
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

/-- The recursive prime-power image is the ordinary pointwise scaling by
`p^n`. -/
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

/-- Every prime-power image of an integral subring is still contained in that
integral subring. -/
theorem primePowerImage_integral_subset
    {F : Type*} [Field F]
    (p : Nat.Primes) (O : Subring F) (n : ℕ) :
    primePowerImage p n (O : Set F) ⊆ O := by
  intro x hx
  rcases (mem_primePowerImage_iff p n (O : Set F) x).1 hx with
    ⟨y, hy, rfl⟩
  have hpO : (((p : ℕ) : F)) ∈ O := O.natCast_mem _
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
  have hpO : (((p : ℕ) : F)) ∈ O := O.natCast_mem _
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
  simp_rw [primePowerImage_eq_pow_smul]

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
The lower exponent vector must be attained simultaneously by one output. -/
structure GeneratedPrimePowerThetaHullData
    (G : GeneratedRHSData.{u, v, w} D) :
    Type (max (u + 1) (v + 1) (w + 1)) where
  exponent :
    (o : G.outputs.Output) →
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
      G.container.Components i (.finite p) → ℕ
  minimum :
    (i : Fin G.container.proc.length) →
    (p : Nat.Primes) →
      G.container.Components i (.finite p) → ℕ
  realize_finite : ∀ o i p,
    (G.outputs.realize o i).region (.finite p) =
      PrimePowerQPilotRegion.packetPrimePowerRegion i p
        (exponent o i p)
  minimum_le : ∀ o i p c,
    minimum i p c ≤ exponent o i p c
  minimum_attained : ∀ i p,
    ∃ o : G.outputs.Output, ∀ c,
      exponent o i p c = minimum i p c
  prime_ne_zero : ∀ i p c,
    (((p : ℕ) :
      (G.container.packet i (.finite p)).Summand c)) ≠ 0

namespace GeneratedPrimePowerThetaHullData

variable {G : GeneratedRHSData.{u, v, w} D}

/-- Every actual finite-place output is contained in the product region given
by the minimum exponent vector. -/
theorem realize_finite_subset_minimum
    (A : GeneratedPrimePowerThetaHullData G)
    (o : G.outputs.Output)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    (G.outputs.realize o i).region (.finite p) ⊆
      PrimePowerQPilotRegion.packetPrimePowerRegion i p
        (A.minimum i p) := by
  rw [A.realize_finite o i p]
  intro x hx
  change
    (∀ c, x c ∈ PrimePowerQPilotRegion.primePowerImage p
      (A.exponent o i p c)
      ((G.container.packet i (.finite p)).integral c)) at hx
  change
    ∀ c, x c ∈ PrimePowerQPilotRegion.primePowerImage p
      (A.minimum i p c)
      ((G.container.packet i (.finite p)).integral c)
  intro c
  exact PrimePowerQPilotRegion.primePowerImage_integral_antitone
    p (G.container.packet i (.finite p)).integral c
    (A.minimum_le o i p c) (hx c)

/-- The finite-place union of all actual outputs is exactly the minimum
prime-power product region. -/
theorem unionRegion_finite_eq_minimum
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    (G.outputs.unionRegion i).region (.finite p) =
      PrimePowerQPilotRegion.packetPrimePowerRegion i p
        (A.minimum i p) := by
  apply Set.Subset.antisymm
  · intro x hx
    rcases Set.mem_iUnion.mp hx with ⟨o, hx⟩
    exact A.realize_finite_subset_minimum o i p hx
  · rcases A.minimum_attained i p with ⟨o, ho⟩
    have hexp : A.exponent o i p = A.minimum i p := funext ho
    intro x hx
    apply Set.mem_iUnion.mpr
    refine ⟨o, ?_⟩
    rw [A.realize_finite o i p, hexp]
    exact hx

/-- The actual public theta hull at a finite rational place is already the
minimum prime-power product region. -/
theorem thetaHull_finite_eq_minimum
    (A : GeneratedPrimePowerThetaHullData G)
    (i : Fin G.container.proc.length)
    (p : Nat.Primes) :
    ((G.toRHSData).thetaHull i).region (.finite p) =
      PrimePowerQPilotRegion.packetPrimePowerRegion i p
        (A.minimum i p) := by
  have hregion := A.unionRegion_finite_eq_minimum i p
  have hHull :
      (G.container.packet i (.finite p)).IsHullRegion
        ((G.outputs.unionRegion i).region (.finite p)) := by
    rw [hregion]
    exact PrimePowerQPilotRegion.packetPrimePowerRegion_isHullRegion
      i p (A.minimum i p) (A.prime_ne_zero i p)
  change
    (G.hull.system i (.finite p)).hull
      ((G.outputs.unionRegion i).region (.finite p)) = _
  rw [(G.hull.system i (.finite p)).hull_eq_self
    (G.union_hullAdmissible i (.finite p)) hHull]
  exact hregion

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
          (- (A.minimum i p c : ℝ) * Real.log p) := by
  rw [A.thetaHull_finite_eq_minimum i p]
  exact PrimePowerQPilotRegion.packetVol_packetPrimePowerRegion
    G.vol i p (A.minimum i p) (A.prime_ne_zero i p)

end GeneratedPrimePowerThetaHullData

end IUTThreeClosures
