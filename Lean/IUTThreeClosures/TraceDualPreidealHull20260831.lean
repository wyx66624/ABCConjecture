/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.BilinearForm.DualLattice
import Mathlib.RingTheory.Trace.Defs
import Mathlib.LinearAlgebra.Span.Basic
import Mathlib.Algebra.Module.Submodule.Pointwise

/-!
# Trace duals and the span of a transported order ideal

The mathematical proofs precede this module in
research/TRACE_DUAL_PREIDEAL_EXACT_HULL_2026_08_31.md and
research/TRACE_DUAL_PREIDEAL_LEAN_BOUNDARY_2026_08_31.md.

We use the actual algebra trace and mathlib dualSubmodule. The algebra
may be a product of fields; it is not assumed to be a field.
The local valuation, inverse-different identification, tensor dual-basis
calculation, actual Galois witness, and closed-lattice/Haar conclusions
remain outside this module. No such input is introduced as an axiom.
-/

namespace IUTThreeClosures.TraceDualPreidealHull20260831

open scoped Pointwise

variable {R K D : Type*} [CommRing R] [Field K] [CommRing D]
variable [Algebra R K] [Algebra K D] [Algebra R D] [IsScalarTower R K D]

/-- The integral dual for the actual algebra trace pairing. -/
noncomputable abbrev integralTraceDual (L : Submodule R D) : Submodule R D :=
  (Algebra.traceForm K D).dualSubmodule L

/-- Membership tests the actual trace against the coefficient-ring image. -/
theorem mem_integralTraceDual (L : Submodule R D) (x : D) :
    x ∈ integralTraceDual (K := K) L ↔
      ∀ y ∈ L, Algebra.trace K D (x * y) ∈ (1 : Submodule R K) :=
  Iff.rfl

/-- Enlarging the testing lattice reverses containment of its integral dual. -/
theorem integralTraceDual_antitone {L N : Submodule R D} (hLN : L ≤ N) :
    integralTraceDual (K := K) N ≤ integralTraceDual (K := K) L := by
  intro x hx y hy
  exact hx y (hLN hy)

section Product

variable {D₁ D₂ : Type*} [CommRing D₁] [CommRing D₂]
variable [Algebra K D₁] [Algebra K D₂] [Algebra R D₁] [Algebra R D₂]
variable [IsScalarTower R K D₁] [IsScalarTower R K D₂]
variable [Module.Finite K D₁] [Module.Finite K D₂]

/-- Product duality uses the sum of the component traces without a degree factor.
Testing against a zero in one component isolates the other component. -/
theorem integralTraceDual_prod (L₁ : Submodule R D₁) (L₂ : Submodule R D₂) :
    integralTraceDual (K := K) (L₁.prod L₂) =
      (integralTraceDual (K := K) L₁).prod (integralTraceDual (K := K) L₂) := by
  ext x
  constructor
  · intro hx
    constructor
    · intro y hy
      have h := hx (y, 0) ⟨hy, L₂.zero_mem⟩
      simpa only [Algebra.traceForm_apply, Prod.mul_def, Algebra.trace_prod_apply,
        mul_zero, map_zero, add_zero] using h
    · intro y hy
      have h := hx (0, y) ⟨L₁.zero_mem, hy⟩
      simpa only [Algebra.traceForm_apply, Prod.mul_def, Algebra.trace_prod_apply,
        mul_zero, map_zero, zero_add] using h
  · rintro ⟨h₁, h₂⟩ y ⟨hy₁, hy₂⟩
    change Algebra.trace K (D₁ × D₂) (x * y) ∈ (1 : Submodule R K)
    rw [Algebra.trace_prod_apply]
    exact (1 : Submodule R K).add_mem (h₁ y.1 hy₁) (h₂ y.2 hy₂)

end Product

/-- The principal ideal of the specified order, formed before transport. -/
noncomputable def principalOrderIdeal (B : Subalgebra R D) (z : D) : Submodule R D :=
  z • B.toSubmodule

/-- One trace-dual generator controls its entire order ideal by closure under multiplication. -/
theorem principalOrderIdeal_le_traceDual {A B : Subalgebra R D} (hAB : A ≤ B)
    {z : D} (hz : z ∈ integralTraceDual (K := K) B.toSubmodule) :
    principalOrderIdeal B z ≤ integralTraceDual (K := K) A.toSubmodule := by
  intro x hx
  obtain ⟨b, hb, rfl⟩ :=
    (Submodule.mem_smul_pointwise_iff_exists x z B.toSubmodule).mp hx
  intro a ha
  change Algebra.trace K D ((z * b) * a) ∈ (1 : Submodule R K)
  rw [mul_assoc]
  exact hz (b * a) (B.mul_mem hb (hAB ha))

/-- The scaled inclusion is proved from the normalized generator's trace condition,
not postulated for the entire source ideal. -/
theorem principalOrderIdeal_le_scaled_traceDual {A B : Subalgebra R D} (hAB : A ≤ B)
    {z : D} {c : K} (hc : c ≠ 0)
    (hz : c⁻¹ • z ∈ integralTraceDual (K := K) B.toSubmodule) :
    principalOrderIdeal B z ≤ c • integralTraceDual (K := K) A.toSubmodule := by
  have hwhole := principalOrderIdeal_le_traceDual hAB hz
  intro x hx
  obtain ⟨b, hb, rfl⟩ :=
    (Submodule.mem_smul_pointwise_iff_exists x z B.toSubmodule).mp hx
  apply (Submodule.mem_smul_pointwise_iff_exists _ c _).mpr
  refine ⟨(c⁻¹ • z) * b, ?_, ?_⟩
  · exact hwhole (Submodule.smul_mem_pointwise_smul b (c⁻¹ • z) B.toSubmodule hb)
  · change c • ((c⁻¹ • z) * b) = z * b
    rw [← smul_mul_assoc, smul_smul, mul_inv_cancel₀ hc, one_smul]

/-- The actual B-module span of images of the already formed source ideal. -/
noncomputable def transportedOrderSpan (B : Subalgebra R D) (z : D)
    (maps : Set (D →ₗ[K] D)) : Submodule B D :=
  Submodule.span B {y | ∃ f ∈ maps, ∃ x ∈ principalOrderIdeal B z, f x = y}

/-- Arbitrary K-linear arrows preserving the dual give the required B-span upper bound.
The arrows need not be B-linear, invertible, decomposable, or trace-preserving. -/
theorem transportedOrderSpan_le {A B : Subalgebra R D} (hAB : A ≤ B)
    {z : D} {c : K} (hc : c ≠ 0)
    (hz : c⁻¹ • z ∈ integralTraceDual (K := K) B.toSubmodule)
    (maps : Set (D →ₗ[K] D))
    (hstable : ∀ f ∈ maps, ∀ y ∈ integralTraceDual (K := K) A.toSubmodule,
      f y ∈ integralTraceDual (K := K) A.toSubmodule) :
    transportedOrderSpan B z maps ≤
      c • Submodule.span B (integralTraceDual (K := K) A.toSubmodule : Set D) := by
  apply Submodule.span_le.mpr
  rintro _ ⟨f, hf, x, hx, rfl⟩
  have hxc := principalOrderIdeal_le_scaled_traceDual hAB hc hz hx
  obtain ⟨y, hy, rfl⟩ :=
    (Submodule.mem_smul_pointwise_iff_exists x c _).mp hxc
  rw [f.map_smul]
  exact Submodule.smul_mem_pointwise_smul (f y) c _
    (Submodule.subset_span (hstable f hf y hy))

end IUTThreeClosures.TraceDualPreidealHull20260831

#print axioms IUTThreeClosures.TraceDualPreidealHull20260831.integralTraceDual_antitone
#print axioms IUTThreeClosures.TraceDualPreidealHull20260831.integralTraceDual_prod
#print axioms IUTThreeClosures.TraceDualPreidealHull20260831.principalOrderIdeal_le_scaled_traceDual
#print axioms IUTThreeClosures.TraceDualPreidealHull20260831.transportedOrderSpan_le
