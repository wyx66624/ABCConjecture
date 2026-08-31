/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Coprime divisibility moduli do not force a positive additive gap

A Bezout identity for coprime moduli produces an entire affine family of
adjacent multiples.  If

`R*x + S*y = 1`,

then for every integer parameter `t`,

`S*(y+tR) - R*(-x+tS) = 1`.

Thus a large square, cube, or higher-power divisor on each of two coprime
endpoints cannot by itself give a lower bound larger than one for their gap.
Any successful abc argument must also control the residual coefficients or
their radical.
-/

namespace IUTThreeClosures
namespace CoprimeModuliAdjacentNoGo

/-- Affine Bezout family of adjacent multiples. -/
theorem bezout_adjacent_multiples
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (t : ℤ) :
    S * (y + t * R) - R * (-x + t * S) = 1 := by
  calc
    S * (y + t * R) - R * (-x + t * S) =
        R * x + S * y := by ring
    _ = 1 := hbezout

/-- Both constructed endpoints have the prescribed divisibility. -/
theorem bezout_adjacent_divisibility
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (t : ℤ) :
    R ∣ R * (-x + t * S) ∧
      S ∣ S * (y + t * R) := by
  exact ⟨dvd_mul_right R _, dvd_mul_right S _⟩

/-- The family simultaneously has the prescribed divisibility and gap one. -/
theorem bezout_adjacent_family
    {R S x y : ℤ}
    (hbezout : R * x + S * y = 1) (t : ℤ) :
    R ∣ R * (-x + t * S) ∧
      S ∣ S * (y + t * R) ∧
      S * (y + t * R) - R * (-x + t * S) = 1 := by
  exact ⟨(bezout_adjacent_divisibility hbezout t).1,
    (bezout_adjacent_divisibility hbezout t).2,
    bezout_adjacent_multiples hbezout t⟩

/-- Under the displayed elementary inequalities, the adjacent multiples are
strictly positive. -/
theorem bezout_adjacent_positive
    {R S x y t : ℤ}
    (hR : 0 < R) (hS : 0 < S)
    (hx : x < t * S) (hy : -y < t * R) :
    0 < R * (-x + t * S) ∧
      0 < S * (y + t * R) := by
  constructor
  · exact mul_pos hR (by linarith)
  · exact mul_pos hS (by linarith)

#print axioms bezout_adjacent_multiples
#print axioms bezout_adjacent_divisibility
#print axioms bezout_adjacent_family
#print axioms bezout_adjacent_positive

end CoprimeModuliAdjacentNoGo
end IUTThreeClosures
