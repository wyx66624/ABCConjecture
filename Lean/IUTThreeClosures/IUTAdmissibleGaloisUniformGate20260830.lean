/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Module.Submodule.Ker
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.RingTheory.Valuation.Basic

/-!
# Consequences of integral trace transport

The mathematical proofs precede this file in
`research/IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md`, Sections 3--5.

This module checks the algebraic consequences of transporting a trace
functional up to a scalar unit. It includes the kernel constraint,
composition, preservation of additive valuation when the scalar has
valuation zero, and separation of affine trace-depth labels.

The transport identity and the explicit trace-depth formula are hypotheses
of these lemmas. Their local-class-field-theory, Galois-cohomology and
p-adic-logarithm proofs remain mathematical proofs in the report, not Lean
proofs in this module. The all-open-subgroup Ism classification, Ind3,
holomorphic hulls, global initial data and ABC are not asserted here.

A final span lemma checks the algebraic statement proved first in
`research/IUT_PROCESSION_ADMISSIBILITY_CONTINUATION_2026_08_30.md`,
Theorem 4.2: a family of scalar-unit operators containing the identity
does not enlarge a module span. Identifying the actual Ind2 operators
with such a family remains a separate mathematical source argument.
-/

namespace IUTThreeClosures.IUTAdmissibleGaloisUniformGate20260830

universe uK uM uN uP uV

variable {K : Type uK} [Field K]
variable {M : Type uM} [AddCommGroup M] [Module K M]
variable {N : Type uN} [AddCommGroup N] [Module K N]
variable {P : Type uP} [AddCommGroup P] [Module K P]

/-- A functional transported up to a unit has the same vanishing locus. -/
theorem trace_zero_iff (f : M →ₗ[K] N)
    (tM : M →ₗ[K] K) (tN : N →ₗ[K] K) (c : Kˣ)
    (h : ∀ x, tN (f x) = (c : K) * tM x) (x : M) :
    tN (f x) = 0 ↔ tM x = 0 := by
  rw [h x, c.mul_right_eq_zero]

/-- The preceding pointwise condition is exactly a kernel-comap equality. -/
theorem trace_kernel_comap (f : M →ₗ[K] N)
    (tM : M →ₗ[K] K) (tN : N →ₗ[K] K) (c : Kˣ)
    (h : ∀ x, tN (f x) = (c : K) * tM x) :
    tN.ker.comap f = tM.ker := by
  ext x
  exact trace_zero_iff f tM tN c h x

/-- Successive coefficient-compatible arrows still transport trace by a unit. -/
theorem trace_transport_comp (f : M →ₗ[K] N) (g : N →ₗ[K] P)
    (tM : M →ₗ[K] K) (tN : N →ₗ[K] K) (tP : P →ₗ[K] K)
    (c d : Kˣ)
    (hf : ∀ x, tN (f x) = (c : K) * tM x)
    (hg : ∀ y, tP (g y) = (d : K) * tN y) (x : M) :
    tP ((g.comp f) x) = ((d * c : Kˣ) : K) * tM x := by
  simp only [LinearMap.comp_apply, hg, hf, Units.val_mul, mul_assoc]

/-- Integral unit scalars have additive valuation zero. This explicit
condition is essential: being a unit of the field alone would not suffice. -/
theorem trace_addValuation {V : Type uV} [LinearOrderedAddCommMonoidWithTop V]
    (v : AddValuation K V) (f : M →ₗ[K] N)
    (tM : M →ₗ[K] K) (tN : N →ₗ[K] K) (c : Kˣ)
    (hc : v (c : K) = 0)
    (h : ∀ x, tN (f x) = (c : K) * tM x) (x : M) :
    v (tN (f x)) = v (tM x) := by
  rw [h x, v.map_mul, hc, zero_add]

/-- Different trace valuations exclude the specified transport arrow. -/
theorem not_maps_of_trace_addValuation_ne
    {V : Type uV} [LinearOrderedAddCommMonoidWithTop V]
    (v : AddValuation K V) (f : M →ₗ[K] N)
    (tM : M →ₗ[K] K) (tN : N →ₗ[K] K) (c : Kˣ)
    (hc : v (c : K) = 0)
    (h : ∀ x, tN (f x) = (c : K) * tM x)
    (x : M) (y : N) (hxy : v (tM x) ≠ v (tN y)) :
    f x ≠ y := by
  intro hfxy
  apply hxy
  simpa only [hfxy] using (trace_addValuation v f tM tN c hc h x).symm

/-- The exact depth formula `offset + label * slope` distinguishes labels
when its slope is nonzero. No p-adic logarithm identity is assumed as an axiom. -/
theorem affine_traceDepth_injective (offset slope : ℤ) (hslope : slope ≠ 0) :
    Function.Injective (fun label : ℤ => offset + label * slope) := by
  intro s t hst
  exact mul_right_cancel₀ hslope (add_left_cancel hst)

/-- Substitution of proved affine depth formulas gives the native root-label
obstruction. The formulas themselves, and the source admissibility of `f`,
must be supplied separately; they are not claims made by this theorem. -/
theorem no_transport_between_affine_trace_depths
    (v : AddValuation K (WithTop ℤ)) (f : M →ₗ[K] N)
    (tM : M →ₗ[K] K) (tN : N →ₗ[K] K) (c : Kˣ)
    (hc : v (c : K) = 0)
    (h : ∀ x, tN (f x) = (c : K) * tM x)
    (offset slope s t : ℤ) (hslope : slope ≠ 0) (hst : s ≠ t)
    (x : M) (y : N)
    (hx : v (tM x) = ((offset + s * slope : ℤ) : WithTop ℤ))
    (hy : v (tN y) = ((offset + t * slope : ℤ) : WithTop ℤ)) :
    f x ≠ y := by
  apply not_maps_of_trace_addValuation_ne v f tM tN c hc h x y
  intro heq
  rw [hx, hy] at heq
  exact hst (affine_traceDepth_injective offset slope hslope
    (WithTop.coe_injective heq))

section UnitHull

variable {R : Type*} [Semiring R]
variable {W : Type*} [AddCommMonoid W] [Module R W]
variable {G : Type*}

/-- The union of the images of a set under a prescribed family of units. -/
def unitScalarOrbit (c : G → Rˣ) (S : Set W) : Set W :=
  {y | ∃ g, ∃ x ∈ S, y = (c g : R) • x}

/-- Scalar-unit saturation does not enlarge the module span. The family
contains the identity as it does for the Ind2 application. This theorem
does not assert that an arbitrary Galois-induced operator is scalar. -/
theorem span_unitScalarOrbit (c : G → Rˣ) (hOne : ∃ g, c g = 1)
    (S : Set W) :
    Submodule.span R (unitScalarOrbit c S) = Submodule.span R S := by
  apply le_antisymm
  · apply Submodule.span_le.mpr
    rintro y ⟨g, x, hx, rfl⟩
    exact Submodule.smul_mem _ _ (Submodule.subset_span hx)
  · apply Submodule.span_mono
    intro x hx
    obtain ⟨g, hg⟩ := hOne
    refine ⟨g, x, hx, ?_⟩
    simp [hg]

end UnitHull

end IUTThreeClosures.IUTAdmissibleGaloisUniformGate20260830
