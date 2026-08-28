/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCTwoBoundarySupports
import IUTThreeClosures.TwoInertiaSublinearHeight

/-!
# A sublinear full-image prime from the two canonical ABC supports

Every nontrivial positive pairwise-coprime ABC tuple has two canonical
boundary supports with positive local exponents bounded by the global
coordinate `c`.  The only remaining local arithmetic input is the actual
Picard--Lefschetz statement that inertia at these two selected supports contains
the corresponding transvection matrices in one common symplectic basis.

This module packages exactly those two local memberships.  It then constructs
the uniform two-inertia source used by the Euclid selector and proves that, for
every positive slope `eta`, there is a full-`SL₂` auxiliary prime satisfying

`log ell ≤ eta * log c + C`.

Thus the quantitative large-image theorem for the Frey/Legendre family is
reduced to two explicit local inertia formulas, not to a global Serre
open-image conclusion or an opaque exceptional-prime set.

The bounded tuple `(1,1,2)` is deliberately excluded and can be absorbed into
the final ABC constant.
-/

namespace IUTThreeClosures

open ABCTwoBoundarySupports
open LegendreTwoInertia
open TwoInertiaEuclidPrime
open TwoInertiaSublinearHeight
open TransvectionLargeImage
open TransvectionLargeImage.Matrix2

namespace ABCCanonicalTwoInertiaPrime

/-- Every boundary coordinate of an ABC tuple is at most `c`. -/
theorem boundaryValue_le_c
    (T : Triple) (d : BoundaryDirection) :
    boundaryValue T d ≤ T.c := by
  have hsum := T.sum_eq
  have haPos := T.a_pos
  have hbPos := T.b_pos
  cases d <;> simp [boundaryValue] <;> omega

/-- Every canonical boundary support has its binary exponent bound by `c`. -/
theorem support_two_pow_exponent_le_c
    {T : Triple} (S : BoundarySupport T) :
    2 ^ S.exponent ≤ T.c := by
  exact S.two_pow_exponent_le_value.trans
    (boundaryValue_le_c T S.direction)

/-- The two actual local inertia memberships attached to a chosen pair of
canonical ABC supports. -/
structure LocalInertiaSource
    (T : Triple)
    (S : TwoSupports T)
    (B : ℕ) where
  image : ∀ ell : ℕ,
    MultiplicativeCarrier (Matrix2 (ZMod ell))
  first_inertia :
    ∀ ell : ℕ, ell.Prime → B < ell →
      boundaryTransvection S.first.direction
          (S.first.exponent : ZMod ell) ∈
        (image ell).carrier
  second_inertia :
    ∀ ell : ℕ, ell.Prime → B < ell →
      boundaryTransvection S.second.direction
          (S.second.exponent : ZMod ell) ∈
        (image ell).carrier

namespace LocalInertiaSource

/-- Convert the two actual local memberships into the uniform source consumed
by the Euclid selector. -/
def toUniformTwoInertiaAbove
    {T : Triple} {S : TwoSupports T} {B : ℕ}
    (L : LocalInertiaSource T S B) :
    UniformTwoInertiaAbove B S.first.exponent S.second.exponent where
  image := L.image
  direction₁ := S.first.direction
  direction₂ := S.second.direction
  directions_ne := S.directions_ne
  inertia₁ := L.first_inertia
  inertia₂ := L.second_inertia

/-- The selected auxiliary prime has a quadratic bound in `log c`. -/
theorem exists_full_SL2_prime_quadratic_log_height
    {T : Triple} {S : TwoSupports T} {B : ℕ}
    (L : LocalInertiaSource T S B) :
    ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      (ell : ℝ) ≤
        1 + (B.factorial : ℝ) *
          (Real.log T.c / Real.log 2) ^ 2 ∧
      (∀ M : Matrix2 (ZMod ell),
        det M = 1 → M ∈ (L.image ell).carrier) := by
  exact
    L.toUniformTwoInertiaAbove.
      exists_full_SL2_prime_quadratic_log_height
        S.first.exponent_pos S.second.exponent_pos
        (support_two_pow_exponent_le_c S.first)
        (support_two_pow_exponent_le_c S.second)

/-- The selected auxiliary prime has arbitrarily small logarithmic slope in
the ABC height `log c`. -/
theorem exists_full_SL2_prime_sublinear_log_height
    {T : Triple} {S : TwoSupports T} {B : ℕ}
    (L : LocalInertiaSource T S B)
    {eta : ℝ} (heta : 0 < eta) :
    ∃ C : ℝ, ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      Real.log ell ≤ eta * Real.log T.c + C ∧
      (∀ M : Matrix2 (ZMod ell),
        det M = 1 → M ∈ (L.image ell).carrier) := by
  exact
    L.toUniformTwoInertiaAbove.
      exists_full_SL2_prime_sublinear_log_height
        S.first.exponent_pos S.second.exponent_pos
        (support_two_pow_exponent_le_c S.first)
        (support_two_pow_exponent_le_c S.second)
        heta

end LocalInertiaSource

/-- Pointwise source for every nontrivial ABC tuple.  The support pair is the
canonical elementary pair constructed from the tuple; the only substantive
fields are the two local inertia memberships. -/
structure Family (B : ℕ) where
  source :
    ∀ T : Triple,
      ¬ (T.a = 1 ∧ T.b = 1) →
      LocalInertiaSource T
        (Classical.choice (exists_twoSupports T ‹_›)) B

namespace Family

/-- Every nontrivial tuple in a canonical local-inertia family admits a
sublinear full-image prime. -/
theorem pointwise_sublinear_full_SL2_prime
    {B : ℕ} (F : Family B)
    (T : Triple)
    (hnontrivial : ¬ (T.a = 1 ∧ T.b = 1))
    {eta : ℝ} (heta : 0 < eta) :
    ∃ C : ℝ, ∃ ell : ℕ,
      ell.Prime ∧
      B < ell ∧
      Real.log ell ≤ eta * Real.log T.c + C ∧
      (∀ M : Matrix2 (ZMod ell),
        det M = 1 →
          M ∈ ((F.source T hnontrivial).image ell).carrier) := by
  exact (F.source T hnontrivial).
    exists_full_SL2_prime_sublinear_log_height heta

end Family

end ABCCanonicalTwoInertiaPrime

end IUTThreeClosures
