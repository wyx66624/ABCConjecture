/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.TateInertiaTransvectionReduction
import IUTThreeClosures.MatrixTwoEquivFinTwo

/-!
# Reduction of the semistable Frey large-image theorem

The standard uniform large-image argument for semistable elliptic curves over
`ℚ` has only two genuinely arithmetic inputs.

1. **Mazur irreducibility.** Above the largest prime degree of a rational
   isogeny, the mod-`ell` representation is irreducible.
2. **Tate inertia.** At a multiplicative place of residue characteristic
   different from `ell`, if `ell` does not divide the Tate/minimal-discriminant
   order, inertia contains a nonzero transvection.

After choosing a basis in which the transvection is upper unipotent, the first
input says that the upper fixed line is moved by some image matrix.  The
explicit finite-group theorem proved in this branch then forces the image to
contain every determinant-one matrix.

This file packages the exact source-facing consequences and proves the entire
remaining implication.  It does not assume an eventual open-image theorem and
uses no classification of subgroups of `GL₂`.
-/

namespace IUTThreeClosures

namespace MatrixTwo

/-- A family of prime-field matrix images attached to one semistable elliptic
curve and one chosen multiplicative place. -/
structure SemistableFreyImageSource where
  /-- Uniform rational-isogeny cutoff.  For the classical theorem over `ℚ`, one
  may take `163`; a sharper semistable cutoff may also be substituted. -/
  cutoff : ℕ
  /-- Positive Tate/minimal-discriminant order at the chosen multiplicative
  place. -/
  localOrder : ℕ
  localOrder_pos : 0 < localOrder
  /-- Residue characteristic of the chosen multiplicative place. -/
  residuePrime : ℕ
  residuePrime_prime : Nat.Prime residuePrime
  /-- The actual mod-`ell` image in a basis adapted to the local
  transvection. -/
  image : ∀ ell : Nat.Primes,
    PrimeFieldMatrixImage (ell : ℕ)
  /-- Source theorem supplied by Mazur's rational-isogeny classification and
  the equivalence between reducibility and a rational cyclic subgroup. -/
  irreducible_above_cutoff :
    ∀ ell : Nat.Primes,
      cutoff < (ell : ℕ) →
      (image ell).UpperLineIrreducible
  /-- Source theorem supplied by Tate uniformization and tame inertia. -/
  transvection_of_avoidance :
    ∀ ell : Nat.Primes,
      ell ≠ ⟨residuePrime, residuePrime_prime⟩ →
      ¬ (ell : ℕ) ∣ localOrder →
      upper (1 : ZMod (ell : ℕ)) ∈ (image ell).carrier

namespace SemistableFreyImageSource

/-- The source image contains `SL₂` at every prime above the cutoff satisfying
the two local avoidance conditions. -/
theorem contains_SL2_of_conditions
    (S : SemistableFreyImageSource)
    (ell : Nat.Primes)
    (hcutoff : S.cutoff < (ell : ℕ))
    (hresidue :
      ell ≠ ⟨S.residuePrime, S.residuePrime_prime⟩)
    (horder : ¬ (ell : ℕ) ∣ S.localOrder) :
    ∀ M : MatrixTwo (ZMod (ell : ℕ)),
      det M = 1 → M ∈ (S.image ell).carrier := by
  letI : Fact (Nat.Prime (ell : ℕ)) := ⟨ell.property⟩
  exact (S.image ell).contains_SL2_of_transvection_irreducible
    (by
      letI : NeZero (ell : ℕ) := ⟨ell.property.ne_zero⟩
      exact one_ne_zero)
    (S.transvection_of_avoidance ell hresidue horder)
    (S.irreducible_above_cutoff ell hcutoff)

/-- Predicate expressing the actual large-image conclusion of the source
family. -/
def LargeImageAt
    (S : SemistableFreyImageSource)
    (ell : Nat.Primes) : Prop :=
  ∀ M : MatrixTwo (ZMod (ell : ℕ)),
    det M = 1 → M ∈ (S.image ell).carrier

/-- Exact uniform large-image criterion. -/
theorem largeImageAt_of_conditions
    (S : SemistableFreyImageSource)
    (ell : Nat.Primes)
    (hcutoff : S.cutoff < (ell : ℕ))
    (hresidue :
      ell ≠ ⟨S.residuePrime, S.residuePrime_prime⟩)
    (horder : ¬ (ell : ℕ) ∣ S.localOrder) :
    S.LargeImageAt ell :=
  S.contains_SL2_of_conditions ell hcutoff hresidue horder

end SemistableFreyImageSource

end MatrixTwo

end IUTThreeClosures
