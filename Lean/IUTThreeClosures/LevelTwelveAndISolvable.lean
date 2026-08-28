/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.GL2ZMod12Solvable

/-!
# Solvability after adjoining an explicit square root of `-1`

The fixed global core does not need to obtain `sqrt(-1)` from the Weil pairing.
One may instead adjoin `i` explicitly to the full level-twelve torsion field.
At the Galois-group level this adds at most a quadratic factor.

The ambient group for the resulting compositum embeds into

`GL₂(Z/12Z) × C₂`,

which remains solvable.  Thus the perfect-image restriction argument for the
auxiliary prime is unaffected.  This supplies a rigorous alternative research
route around formalizing the Weil pairing:

* construct the level-twelve torsion field;
* adjoin one root of `X² + 1`;
* embed the Galois group of the compositum in the product group below.

The field-theoretic construction and injection remain source theorems.
-/

namespace IUTThreeClosures

/-- The quadratic sign factor used when adjoining `i`. -/
abbrev QuadraticSignGroup := Multiplicative (ZMod 2)

/-- Ambient Galois image after adjoining the level-twelve torsion and an
explicit quadratic square root of `-1`. -/
abbrev GL2ZMod12WithI := GL2ZMod12 × QuadraticSignGroup

/-- The quadratic factor is abelian, hence solvable. -/
theorem quadraticSignGroup_isSolvable :
    IsSolvable QuadraticSignGroup := by
  infer_instance

/-- The product ambient group remains solvable. -/
theorem gl2ZMod12WithI_isSolvable :
    IsSolvable GL2ZMod12WithI := by
  letI : IsSolvable GL2ZMod12 := gl2ZMod12_isSolvable
  letI : IsSolvable QuadraticSignGroup :=
    quadraticSignGroup_isSolvable
  infer_instance

/-- Every group injecting into the combined level-twelve/quadratic ambient
group is solvable. -/
theorem isSolvable_of_injective_to_gl2ZMod12WithI
    {G : Type*} [Group G]
    (ρ : G →* GL2ZMod12WithI)
    (hρ : Function.Injective ρ) :
    IsSolvable G := by
  letI : IsSolvable GL2ZMod12WithI :=
    gl2ZMod12WithI_isSolvable
  exact IsSolvable.of_injective ρ hρ

end IUTThreeClosures
