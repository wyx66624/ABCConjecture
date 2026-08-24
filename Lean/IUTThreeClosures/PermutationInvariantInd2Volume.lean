/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Permutation-invariant packet volumes for the Ind2 direction

Literal coordinatewise union over arbitrary label permutations is too large:
the repository already contains a counterexample showing that this operation
can collapse a q-power component to the unit ball.  Restricting Ind2 to
permutations that fix every numerical label avoids the collapse, but is much
stronger than the symmetry used in the printed multiradial argument.

The procession-normalized argument of IUT III instead says that Ind2 is
invisible to the normalized volume.  The correct elementary mechanism is
permutation invariance of a symmetrically weighted finite sum.  This module
formalizes that mechanism without imposing pointwise preservation of the
label spectrum.

For a finite label type, an exponent packet `e : Label -> Nat`, a local
contribution function `phi`, and weights `w`, define

`sum_j w(j) * phi(e(j))`.

After a permutation `sigma`, the same volume is obtained whenever the weights
are invariant under `sigma`; in particular this holds for uniform weights and
for every permutation.  Thus arbitrary Ind2 permutations are harmless at the
quotient/averaged-volume level even though their literal coordinatewise union
may be harmful.

This does not by itself identify the public theta-hull volume with the orbit
volume.  It isolates the exact theorem that a genuine Theorem 3.11
formalization must use: quotient or average by Ind2 before applying a set-level
union/hull operation, or prove that the public volume factors through this
permutation quotient.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u

namespace Ind2PacketVolume

variable {Label : Type u} [Fintype Label]

/-- A finite weighted packet volume depending only on one numerical datum at
each label. -/
noncomputable def packetVolume
    (weight : Label → ℝ)
    (phi : ℕ → ℝ)
    (exponent : Label → ℕ) : ℝ :=
  ∑ j : Label, weight j * phi (exponent j)

/-- Pull an exponent packet back along a label permutation. -/
def permuteExponent
    (sigma : Equiv.Perm Label)
    (exponent : Label → ℕ) : Label → ℕ :=
  fun j => exponent (sigma j)

/-- A permutation preserves the weighted packet volume whenever it preserves
the weights.  No pointwise condition on the exponents is required. -/
theorem packetVolume_permute
    (weight : Label → ℝ)
    (phi : ℕ → ℝ)
    (exponent : Label → ℕ)
    (sigma : Equiv.Perm Label)
    (hweight : ∀ j, weight (sigma.symm j) = weight j) :
    packetVolume weight phi (permuteExponent sigma exponent) =
      packetVolume weight phi exponent := by
  classical
  unfold packetVolume permuteExponent
  calc
    (∑ j : Label, weight j * phi (exponent (sigma j))) =
        ∑ j : Label, weight (sigma.symm j) * phi (exponent j) := by
      simpa using
        (Equiv.sum_comp sigma
          (fun j : Label => weight (sigma.symm j) * phi (exponent j)))
    _ = ∑ j : Label, weight j * phi (exponent j) := by
      apply Finset.sum_congr rfl
      intro j hj
      rw [hweight j]

/-- The uniform probability weight on a nonempty finite label type. -/
noncomputable def uniformWeight [Nonempty Label] : Label → ℝ :=
  fun _ => 1 / Fintype.card Label

/-- Uniform weights are invariant under every permutation. -/
theorem uniformWeight_symm
    [Nonempty Label]
    (sigma : Equiv.Perm Label)
    (j : Label) :
    uniformWeight (Label := Label) (sigma.symm j) =
      uniformWeight (Label := Label) j :=
  rfl

/-- Every label permutation preserves the uniformly averaged packet volume. -/
theorem uniform_packetVolume_permute
    [Nonempty Label]
    (phi : ℕ → ℝ)
    (exponent : Label → ℕ)
    (sigma : Equiv.Perm Label) :
    packetVolume (uniformWeight (Label := Label)) phi
        (permuteExponent sigma exponent) =
      packetVolume (uniformWeight (Label := Label)) phi exponent :=
  packetVolume_permute
    (uniformWeight (Label := Label)) phi exponent sigma
    (uniformWeight_symm sigma)

/-- The squared-label packet used by the Tate/Kummer candidate enjoys the same
arbitrary permutation invariance at the uniformly averaged volume level. -/
theorem squaredLabel_uniform_volume_permute
    [Nonempty Label]
    (labelNat : Label → ℕ)
    (phi : ℕ → ℝ)
    (sigma : Equiv.Perm Label) :
    packetVolume (uniformWeight (Label := Label)) phi
        (fun j => (labelNat (sigma j)) ^ 2) =
      packetVolume (uniformWeight (Label := Label)) phi
        (fun j => (labelNat j) ^ 2) := by
  simpa [permuteExponent] using
    (uniform_packetVolume_permute
      (Label := Label) phi (fun j => (labelNat j) ^ 2) sigma)

/-- More generally, an arbitrary label contribution—not only a square—is
invariant after uniform averaging. -/
theorem arbitraryLabelContribution_uniform_volume_permute
    [Nonempty Label]
    (contribution : Label → ℝ)
    (sigma : Equiv.Perm Label) :
    (∑ j : Label,
        uniformWeight (Label := Label) j * contribution (sigma j)) =
      ∑ j : Label,
        uniformWeight (Label := Label) j * contribution j := by
  let exponent : Label → ℕ := fun _ => 0
  let phi : ℕ → ℝ := fun _ => 0
  classical
  calc
    (∑ j : Label,
        uniformWeight (Label := Label) j * contribution (sigma j)) =
      ∑ j : Label,
        uniformWeight (Label := Label) (sigma.symm j) * contribution j := by
      simpa using
        (Equiv.sum_comp sigma
          (fun j : Label =>
            uniformWeight (Label := Label) (sigma.symm j) * contribution j))
    _ = ∑ j : Label,
        uniformWeight (Label := Label) j * contribution j := by
      apply Finset.sum_congr rfl
      intro j hj
      rfl

end Ind2PacketVolume

end IUTThreeClosures
