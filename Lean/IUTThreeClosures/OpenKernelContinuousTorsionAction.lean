/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MatrixRepresentationFromTorsionAction
import Mathlib.Topology.Algebra.Group.Basic

/-!
# Open kernels of continuous torsion actions

The open-kernel clause of admissible-prime data is not an independent
arithmetic input once the actual torsion action is known to be continuous.
A continuous homomorphism to a discrete target has open kernel, since the
kernel is the inverse image of the open singleton `{1}`.

Combined with `matrixRepresentationFromAction_ker`, this proves that the
matrix representation derived from an actual continuous torsion action has the
same open kernel. The remaining source theorem is continuity of the genuine
Galois action in the Krull topology; the matrix conversion introduces no new
topological obligation.
-/

namespace IUTThreeClosures

universe u v

/-- The kernel of a continuous homomorphism to a discrete group is open. -/
theorem isOpen_ker_of_continuous_to_discrete
    {G : Type u} {H : Type v}
    [Group G] [Group H]
    [TopologicalSpace G] [TopologicalSpace H]
    [DiscreteTopology H]
    (f : G →* H) (hf : Continuous f) :
    IsOpen (f.ker : Set G) := by
  have hopen : IsOpen ({1} : Set H) :=
    isOpen_discrete {1}
  have hpre : IsOpen (f ⁻¹' ({1} : Set H)) :=
    hopen.preimage hf
  have hker : (f.ker : Set G) = f ⁻¹' ({1} : Set H) := by
    ext x
    simp [MonoidHom.mem_ker]
  rw [hker]
  exact hpre

section MatrixAction

variable {ell : ℕ}
variable {G : Type u} [Group G]
variable {T : Type v} [AddCommGroup T] [Module (ZMod ell) T]
variable [TopologicalSpace G]

/-- If the actual linear torsion action is continuous into a discrete general
linear group, then the derived matrix representation has open kernel. -/
theorem matrixRepresentationFromAction_isOpen_ker
    (basis : T ≃+ TorsionCoordinates ell)
    (action : G →* LinearMap.GeneralLinearGroup (ZMod ell) T)
    [TopologicalSpace (LinearMap.GeneralLinearGroup (ZMod ell) T)]
    [DiscreteTopology (LinearMap.GeneralLinearGroup (ZMod ell) T)]
    (haction : Continuous action) :
    IsOpen ((matrixRepresentationFromAction basis action).ker : Set G) := by
  rw [matrixRepresentationFromAction_ker basis action]
  exact isOpen_ker_of_continuous_to_discrete action haction

end MatrixAction

end IUTThreeClosures
