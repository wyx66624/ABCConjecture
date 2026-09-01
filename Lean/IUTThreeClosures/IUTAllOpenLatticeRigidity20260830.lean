/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.NumberTheory.Padics.PadicIntegers
import Mathlib.LinearAlgebra.Pi
import Mathlib.Tactic.Ring

/-!
# The algebraic core of the all-open lattice condition

The mathematical proof was written first in section 3 of
`research/UNIFORM_GATE_STRUCTURAL_TESTS_2026_08_30.md`.

We prove rigidity from preservation of every line modulo every power of
the uniformizer, including an actual `PadicInt` specialization. Local
class field theory and the identification with the source's `Ism` group
are not axioms or formalized claims in this file.
-/

namespace IUTThreeClosures.IUTAllOpenLatticeRigidity20260830

open scoped BigOperators

variable {R : Type*} [CommRing R]
variable {ι : Type*} [DecidableEq ι]

/-- Membership of every image in the line plus the indicated shrinking lattice. -/
def RespectsLineNeighborhoods (π : R) (F : (ι → R) →ₗ[R] (ι → R)) : Prop :=
  ∀ v n, ∃ a : R, ∃ z : ι → R, F v = a • v + π ^ n • z

theorem off_diagonal_eq_zero
    {π : R} (hsep : ∀ z : R, (∀ n : ℕ, π ^ n ∣ z) → z = 0)
    {F : (ι → R) →ₗ[R] (ι → R)} (hF : RespectsLineNeighborhoods π F)
    {i j : ι} (hij : i ≠ j) : F (Pi.single i 1) j = 0 := by
  apply hsep
  intro n
  obtain ⟨a, z, hz⟩ := hF (Pi.single i 1) n
  refine ⟨z j, ?_⟩
  simpa [Pi.single_apply, hij, Ne.symm hij] using congrFun hz j

theorem diagonal_eq
    {π : R} (hsep : ∀ z : R, (∀ n : ℕ, π ^ n ∣ z) → z = 0)
    {F : (ι → R) →ₗ[R] (ι → R)} (hF : RespectsLineNeighborhoods π F)
    (i j : ι) : F (Pi.single i 1) i = F (Pi.single j 1) j := by
  by_cases hij : i = j
  · subst j
    rfl
  apply sub_eq_zero.mp
  apply hsep
  intro n
  obtain ⟨a, z, hz⟩ := hF (Pi.single i 1 + Pi.single j 1) n
  have hi : F (Pi.single i 1) i = a + π ^ n * z i := by
    simpa [map_add, Pi.single_apply, hij, Ne.symm hij,
      off_diagonal_eq_zero hsep hF (Ne.symm hij)] using congrFun hz i
  have hj : F (Pi.single j 1) j = a + π ^ n * z j := by
    simpa [map_add, Pi.single_apply, hij, Ne.symm hij,
      off_diagonal_eq_zero hsep hF hij] using congrFun hz j
  refine ⟨z i - z j, ?_⟩
  rw [hi, hj]
  ring

omit [DecidableEq ι] in
theorem exists_scalar_of_line_neighborhoods [Finite ι] [Nonempty ι]
    {π : R} (hsep : ∀ z : R, (∀ n : ℕ, π ^ n ∣ z) → z = 0)
    {F : (ι → R) →ₗ[R] (ι → R)} (hF : RespectsLineNeighborhoods π F) :
    ∃ a : R, F = a • LinearMap.id := by
  classical
  letI : Fintype ι := Fintype.ofFinite ι
  let i₀ : ι := Classical.choice inferInstance
  refine ⟨F (Pi.single i₀ 1) i₀, ?_⟩
  apply (Pi.basisFun R ι).ext
  intro i
  ext j
  by_cases hij : i = j
  · subst j
    simpa using diagonal_eq hsep hF i i₀
  · simpa [Pi.single_apply, hij, Ne.symm hij] using off_diagonal_eq_zero hsep hF hij

omit [DecidableEq ι] in
theorem exists_unit_scalar_of_line_neighborhoods [Finite ι] [Nonempty ι]
    {π : R} (hsep : ∀ z : R, (∀ n : ℕ, π ^ n ∣ z) → z = 0)
    (F : (ι → R) ≃ₗ[R] (ι → R))
    (hF : RespectsLineNeighborhoods π F.toLinearMap) :
    ∃ a : Rˣ, F.toLinearMap = (a : R) • LinearMap.id := by
  classical
  obtain ⟨a, ha⟩ := exists_scalar_of_line_neighborhoods hsep hF
  let i₀ : ι := Classical.choice inferInstance
  obtain ⟨v, hv⟩ := F.surjective (Pi.single i₀ 1)
  have hav : a * v i₀ = 1 := by
    have h := congrFun hv i₀
    change F.toLinearMap v i₀ = _ at h
    simpa [ha] using h
  let u : Rˣ := ⟨a, v i₀, hav, by simpa [mul_comm] using hav⟩
  exact ⟨u, ha⟩

theorem padic_eq_zero_of_all_power_dvd (p : ℕ) [Fact p.Prime]
    (z : ℤ_[p]) (h : ∀ n : ℕ, (p : ℤ_[p]) ^ n ∣ z) : z = 0 := by
  by_contra hz
  have hmem : z ∈ (Ideal.span {(p : ℤ_[p]) ^ (z.valuation + 1)} : Ideal ℤ_[p]) := by
    exact Ideal.mem_span_singleton.mpr (h (z.valuation + 1))
  have := (PadicInt.mem_span_pow_iff_le_valuation z hz (z.valuation + 1)).mp hmem
  omega

omit [DecidableEq ι] in
theorem padic_exists_unit_scalar [Finite ι] [Nonempty ι] (p : ℕ) [Fact p.Prime]
    (F : (ι → ℤ_[p]) ≃ₗ[ℤ_[p]] (ι → ℤ_[p]))
    (hF : RespectsLineNeighborhoods (p : ℤ_[p]) F.toLinearMap) :
    ∃ a : (ℤ_[p])ˣ, F.toLinearMap = (a : ℤ_[p]) • LinearMap.id :=
  exists_unit_scalar_of_line_neighborhoods (padic_eq_zero_of_all_power_dvd p) F hF

end IUTThreeClosures.IUTAllOpenLatticeRigidity20260830
