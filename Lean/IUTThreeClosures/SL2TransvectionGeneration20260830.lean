/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Field.ZMod
import Mathlib.GroupTheory.OrderOfElement
import Mathlib.LinearAlgebra.Matrix.GeneralLinearGroup.Defs
import Mathlib.Tactic.FinCases

/-!
# Two nonzero opposite transvections generate the actual SL₂ over a prime field

The mathematical proofs precede this file in
`research/SL2_TRANSVECTION_GENERATION_2026_08_30.md`, Sections 1--3.

All matrix groups below are mathlib's actual special/general linear groups.
The proof traverses each root group by powers of one nonzero element and
then uses `Matrix.SL2.transvection_induction`. No subgroups are enumerated.

The module also proves a coprime-index retention lemma for normal subgroups
and its image consequences. Choosing a common basis from two distinct fixed
lines, and all arithmetic/Galois/Frobenius/Tate interpretations, remain the
separate mathematical arguments in the report. No such statement is added
as an axiom or an unproved interface here.
-/

namespace IUTThreeClosures.SL2TransvectionGeneration20260830

open Matrix.SpecialLinearGroup
open scoped MatrixGroups

section RootPowers

variable {ι R : Type*} [Fintype ι] [DecidableEq ι] [CommRing R]

/-- Powers of an elementary transvection add its parameter. -/
theorem transvection_nat_pow {i j : ι} (hij : i ≠ j) (s : R) (n : ℕ) :
    transvection hij s ^ n = transvection hij ((n : R) * s) := by
  induction n with
  | zero => simp
  | succ n ih =>
    rw [pow_succ, ih, ← transvection_add]
    congr 1
    simp [Nat.cast_add, add_mul]

/-- The upper root matrix `[[1,s],[0,1]]`, with determinant one. -/
def upper (s : R) : SL(2, R) := transvection zero_ne_one s

/-- The lower root matrix `[[1,0],[t,1]]`, with determinant one. -/
def lower (t : R) : SL(2, R) := transvection one_ne_zero t

end RootPowers

section PrimeField

variable {p : ℕ} [Fact p.Prime]

/-- A single nonzero parameter gives every matrix in the same root group. -/
theorem transvection_parameter_mem
    (H : Subgroup (SL(2, ZMod p))) {i j : Fin 2} (hij : i ≠ j)
    {s : ZMod p} (hs : s ≠ 0) (hmem : transvection hij s ∈ H)
    (c : ZMod p) : transvection hij c ∈ H := by
  have hpow := H.pow_mem hmem (c / s).val
  rw [transvection_nat_pow, ZMod.natCast_zmod_val, div_mul_cancel₀ c hs] at hpow
  exact hpow

/-- Two nonzero opposite root elements generate the actual `SL(2, ZMod p)`. -/
theorem subgroup_eq_top_of_upper_lower
    (H : Subgroup (SL(2, ZMod p))) {s t : ZMod p}
    (hs : s ≠ 0) (ht : t ≠ 0)
    (hu : upper s ∈ H) (hl : lower t ∈ H) : H = ⊤ := by
  have hroot : ∀ (i j : Fin 2) (hij : i ≠ j) (c : ZMod p),
      transvection hij c ∈ H := by
    intro i j hij c
    fin_cases i <;> fin_cases j
    · exact False.elim (hij rfl)
    · exact transvection_parameter_mem H hij hs hu c
    · exact transvection_parameter_mem H hij ht hl c
    · exact False.elim (hij rfl)
  exact le_antisymm le_top (fun A _ =>
    Matrix.SL2.transvection_induction (fun B => B ∈ H) hroot
      (fun _ _ hA hB => H.mul_mem hA hB) A)

/-- Every transvection over `ZMod p` has p-th power one, including parameter zero. -/
theorem transvection_pow_prime {i j : Fin 2} (hij : i ≠ j) (s : ZMod p) :
    transvection hij s ^ p = 1 := by
  rw [transvection_nat_pow, ZMod.natCast_self, zero_mul, transvection_coeff_zero]

/-- A subgroup containing the two root images contains every special-linear image. -/
theorem hom_mem_of_upper_lower {G : Type*} [Group G]
    (ρ : SL(2, ZMod p) →* G) (H : Subgroup G) {s t : ZMod p}
    (hs : s ≠ 0) (ht : t ≠ 0)
    (hu : ρ (upper s) ∈ H) (hl : ρ (lower t) ∈ H)
    (A : SL(2, ZMod p)) : ρ A ∈ H := by
  have htop : H.comap ρ = ⊤ :=
    subgroup_eq_top_of_upper_lower (H.comap ρ) hs ht hu hl
  change A ∈ H.comap ρ
  rw [htop]
  exact Subgroup.mem_top A

/-- The preceding image conclusion in subgroup order form. -/
theorem hom_range_le_of_upper_lower {G : Type*} [Group G]
    (ρ : SL(2, ZMod p) →* G) (H : Subgroup G) {s t : ZMod p}
    (hs : s ≠ 0) (ht : t ≠ 0)
    (hu : ρ (upper s) ∈ H) (hl : ρ (lower t) ∈ H) : ρ.range ≤ H := by
  intro x hx
  obtain ⟨A, rfl⟩ := hx
  exact hom_mem_of_upper_lower ρ H hs ht hu hl A

/-- In the actual general linear group, the two standard roots force all of SL₂. -/
theorem toGL_mem_of_upper_lower
    (H : Subgroup (Matrix.GeneralLinearGroup (Fin 2) (ZMod p)))
    {s t : ZMod p} (hs : s ≠ 0) (ht : t ≠ 0)
    (hu : toGL (upper s) ∈ H) (hl : toGL (lower t) ∈ H)
    (A : SL(2, ZMod p)) : toGL A ∈ H :=
  hom_mem_of_upper_lower toGL H hs ht hu hl A

end PrimeField

section NormalRetention

variable {G : Type*} [Group G]

/-- An element killed by n lies in any normal subgroup of index coprime to n.

The general `Nat.card` convention also covers infinite index: index zero
and coprimality force n=1, so no finite-index hypothesis is suppressed.
-/
theorem mem_normal_of_pow_eq_one_of_coprime_index
    (H : Subgroup G) [H.Normal] {x : G} {n : ℕ}
    (hx : x ^ n = 1) (hcop : n.Coprime H.index) : x ∈ H := by
  have hd₁ : orderOf (x : G ⧸ H) ∣ n := by
    apply orderOf_dvd_of_pow_eq_one
    rw [← QuotientGroup.mk_pow, hx, QuotientGroup.mk_one]
  have hd₂ : orderOf (x : G ⧸ H) ∣ H.index :=
    orderOf_dvd_natCard (x : G ⧸ H)
  have hone : orderOf (x : G ⧸ H) = 1 :=
    Nat.eq_one_of_dvd_coprimes hcop hd₁ hd₂
  exact (QuotientGroup.eq_one_iff x).mp (orderOf_eq_one_iff.mp hone)

end NormalRetention

section PrimeIndex

variable {p : ℕ} [Fact p.Prime]

/-- A normal subgroup of prime-to-p index retains every image of SL₂(F_p). -/
theorem hom_mem_normal_of_coprime_index {G : Type*} [Group G]
    (ρ : SL(2, ZMod p) →* G) (H : Subgroup G) [H.Normal]
    (hcop : p.Coprime H.index) (A : SL(2, ZMod p)) : ρ A ∈ H := by
  apply hom_mem_of_upper_lower ρ H (s := 1) (t := 1) one_ne_zero one_ne_zero
  · apply mem_normal_of_pow_eq_one_of_coprime_index H (n := p) _ hcop
    rw [← map_pow, upper, transvection_pow_prime, map_one]
  · apply mem_normal_of_pow_eq_one_of_coprime_index H (n := p) _ hcop
    rw [← map_pow, lower, transvection_pow_prime, map_one]

/-- The retained special-linear image, as an inclusion of actual subgroups. -/
theorem hom_range_le_normal_of_coprime_index {G : Type*} [Group G]
    (ρ : SL(2, ZMod p) →* G) (H : Subgroup G) [H.Normal]
    (hcop : p.Coprime H.index) : ρ.range ≤ H := by
  intro x hx
  obtain ⟨A, rfl⟩ := hx
  exact hom_mem_normal_of_coprime_index ρ H hcop A

/-- The actual SL₂(F_p) has no proper normal subgroup of index prime to p. -/
theorem normal_eq_top_of_coprime_index
    (H : Subgroup (SL(2, ZMod p))) [H.Normal]
    (hcop : p.Coprime H.index) : H = ⊤ := by
  apply le_antisymm le_top
  intro A _
  exact hom_mem_normal_of_coprime_index (MonoidHom.id _) H hcop A

/-- The embedded SL₂ lies in a normal subgroup of GL₂ whose index is prime to p. -/
theorem toGL_mem_normal_of_coprime_index
    (H : Subgroup (Matrix.GeneralLinearGroup (Fin 2) (ZMod p))) [H.Normal]
    (hcop : p.Coprime H.index) (A : SL(2, ZMod p)) : toGL A ∈ H :=
  hom_mem_normal_of_coprime_index toGL H hcop A

end PrimeIndex

end IUTThreeClosures.SL2TransvectionGeneration20260830
