import IUTThreeClosures.FreyPellCongruentNumberTwistAudit2026
import IUTThreeClosures.FreyPellRadicalRecurrenceBarrier

/-!
# Congruent-twist index-transfer audit

This file records only scalar consequences used in the accompanying audit note.
It does not assert an `abc` theorem, a lower bound for the squarefree core, or a
classification of integral points on the congruent-number twists.
-/

namespace IUTThreeClosures

/-! ## The exact adjacent Pell resultant -/

/--
For `s^2 - 3 r^2 = 1`, put `c = s^2 - 2` and
`cNext = (7s + 12r)^2 - 2`.  The displayed identity is an exact
resultant/Bezout carrier.  In particular, every common divisor of `c` and
`cNext` divides `240`.
-/
theorem pellIndexTransfer_adjacentBezout
    (s r : ℤ)
    (hpell : s ^ 2 - 3 * r ^ 2 = 1) :
    let c : ℤ := s ^ 2 - 2
    let cNext : ℤ := (7 * s + 12 * r) ^ 2 - 2
    let L : ℤ := 7 * s * r - 6
    c * (1176 * c + 3528 + 291 * L) - 3 * L * cNext = 240 := by
  dsimp
  calc
    (s ^ 2 - 2) *
          (1176 * (s ^ 2 - 2) + 3528 + 291 * (7 * s * r - 6)) -
        3 * (7 * s * r - 6) * ((7 * s + 12 * r) ^ 2 - 2) =
        240 + 24 * (49 * s ^ 2 + 42 * r * s - 36) *
          (s ^ 2 - 3 * r ^ 2 - 1) := by ring
    _ = 240 := by rw [hpell]; ring

/-- Every common divisor of two adjacent Pell carriers divides `240`. -/
theorem pellIndexTransfer_commonDivisor_dvd_240
    (s r d : ℤ)
    (hpell : s ^ 2 - 3 * r ^ 2 = 1)
    (hc : d ∣ s ^ 2 - 2)
    (hcNext : d ∣ (7 * s + 12 * r) ^ 2 - 2) :
    d ∣ 240 := by
  let c : ℤ := s ^ 2 - 2
  let cNext : ℤ := (7 * s + 12 * r) ^ 2 - 2
  let L : ℤ := 7 * s * r - 6
  have hc' : d ∣ c := by simpa [c] using hc
  have hcNext' : d ∣ cNext := by simpa [cNext] using hcNext
  rcases hc' with ⟨a, ha⟩
  rcases hcNext' with ⟨b, hb⟩
  have hbez :
      c * (1176 * c + 3528 + 291 * L) - 3 * L * cNext = 240 := by
    simpa [c, cNext, L] using pellIndexTransfer_adjacentBezout s r hpell
  refine ⟨(1176 * c + 3528 + 291 * L) * a - 3 * L * b, ?_⟩
  calc
    240 = c * (1176 * c + 3528 + 291 * L) - 3 * L * cNext := hbez.symm
    _ = (d * a) * (1176 * c + 3528 + 291 * L) - 3 * L * (d * b) := by
      rw [ha, hb]
    _ = d * ((1176 * c + 3528 + 291 * L) * a - 3 * L * b) := by ring

/--
If the fixed carrier `240` has no nonunit common divisor with `c`, the exact
resultant upgrades the adjacent divisor carrier to the usual coprimality
criterion.  This formulation avoids hiding any gcd normalization convention.
-/
theorem pellIndexTransfer_adjacent_coprime_divisorCriterion
    (s r : ℤ)
    (hpell : s ^ 2 - 3 * r ^ 2 = 1)
    (h240 : ∀ d : ℤ, d ∣ s ^ 2 - 2 → d ∣ 240 → d ∣ 1) :
    ∀ d : ℤ,
      d ∣ s ^ 2 - 2 → d ∣ (7 * s + 12 * r) ^ 2 - 2 → d ∣ 1 := by
  intro d hc hcNext
  exact h240 d hc
    (pellIndexTransfer_commonDivisor_dvd_240 s r d hpell hc hcNext)

/-! ## A division-free pointwise-to-counting envelope -/

/--
The algebraic core of the transfer
`n^2 <= C A L^2`, `A <= X`, `L^2 <= B^2`
implies `n^2 <= C X B^2`.  It is deliberately division-free, so endpoint
and positivity bookkeeping in counting applications cannot be concealed.
-/
theorem pellIndexTransfer_pointwiseEnvelope
    (n A X L B C : ℝ)
    (hpoint : n ^ 2 ≤ C * A * L ^ 2)
    (hAX : A ≤ X)
    (hLsq : L ^ 2 ≤ B ^ 2)
    (hC : 0 ≤ C)
    (hX : 0 ≤ X) :
    n ^ 2 ≤ C * X * B ^ 2 := by
  have hAL : A * L ^ 2 ≤ X * B ^ 2 := by
    calc
      A * L ^ 2 ≤ X * L ^ 2 :=
        mul_le_mul_of_nonneg_right hAX (sq_nonneg L)
      _ ≤ X * B ^ 2 := mul_le_mul_of_nonneg_left hLsq hX
  calc
    n ^ 2 ≤ C * A * L ^ 2 := hpoint
    _ = C * (A * L ^ 2) := by ring
    _ ≤ C * (X * B ^ 2) := mul_le_mul_of_nonneg_left hAL hC
    _ = C * X * B ^ 2 := by ring

/-! ## A scalar separation profile -/

/--
The polynomial profile `core = index^2` obeys the same quadratic envelope,
while its logarithm is not linearly comparable with an independently assigned
linear source height.  This theorem records only the exact scalar envelope;
the asymptotic prime-in-progressions realization is stated in the audit note.
-/
theorem pellIndexTransfer_polynomialProfile
    (index : ℝ) :
    let core := index ^ 2
    index ^ 2 = core ∧ core ≤ (index ^ 2 + 1) := by
  dsimp
  constructor
  · rfl
  · linarith

#print axioms pellIndexTransfer_adjacentBezout
#print axioms pellIndexTransfer_commonDivisor_dvd_240
#print axioms pellIndexTransfer_adjacent_coprime_divisorCriterion
#print axioms pellIndexTransfer_pointwiseEnvelope
#print axioms pellIndexTransfer_polynomialProfile

end IUTThreeClosures
