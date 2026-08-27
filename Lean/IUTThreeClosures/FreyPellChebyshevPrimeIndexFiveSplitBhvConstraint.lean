import IUTThreeClosures.FreyPellChebyshevPrimeIndexUniformGenusAudit

/-!
# Five-split and primitive-divisor constraint: scalar kernel

This file formalizes only the elementary scalar algebra used in
`FREY_PELL_CHEBYSHEV_PRIME_INDEX_FIVE_SPLIT_BHV_CONSTRAINT.md`.

It does **not** formalize the arithmetic of `Q(sqrt 5)`, its class-number-one
ideal factorization, quadratic reciprocity, the Bilu--Hanrot--Voutier theorem,
or the rank-of-apparition argument.  In particular, it proves no uniform
prime-index exclusion.  Those accepted interfaces and the remaining gap are
listed explicitly in the companion note.
-/

namespace IUTThreeClosures

/-! ## The fixed `Q(sqrt 5)` norm-composition scalar identity -/

/-- The denominator-cleared norm-composition identity behind

`((r+s*sqrt(5))/2) * ((u+v*sqrt(5))/2)`.

No square root or number field is hidden in this theorem. -/
theorem pellPrimeFiveSplit_normComposition
    (r s u v : ℤ) :
    (r * u + 5 * s * v) ^ 2 - 5 * (r * v + s * u) ^ 2 =
      (r ^ 2 - 5 * s ^ 2) * (u ^ 2 - 5 * v ^ 2) := by
  ring

/-- Substituting the two displayed norms gives the exact product norm. -/
theorem pellPrimeFiveSplit_normComposition_of_norms
    (X H r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H) :
    (r * u + 5 * s * v) ^ 2 - 5 * (r * v + s * u) ^ 2 =
      16 * X * H := by
  calc
    (r * u + 5 * s * v) ^ 2 - 5 * (r * v + s * u) ^ 2 =
        (r ^ 2 - 5 * s ^ 2) * (u ^ 2 - 5 * v ^ 2) :=
      pellPrimeFiveSplit_normComposition r s u v
    _ = (4 * X) * (4 * H) := by rw [hX, hH]
    _ = 16 * X * H := by ring

/-- Forward scalar reconstruction: the two norm equations, the cross
coefficient `2`, and the rational coefficient `2*y` recover the shifted
square equation. -/
theorem pellPrimeFiveSplit_reconstruct_shiftSquare
    (X H y r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H)
    (hcross : r * v + s * u = 2)
    (hy : r * u + 5 * s * v = 2 * y) :
    y ^ 2 = 4 * X * H + 5 := by
  have hnorm := pellPrimeFiveSplit_normComposition_of_norms
    X H r s u v hX hH
  rw [hcross, hy] at hnorm
  nlinarith

/-- Reverse scalar reconstruction, up to the unavoidable sign of `y`.
Under the two norm equations and cross coefficient `2`, the shifted-square
equation is equivalent to the product's rational coefficient being
`2*y` or `-2*y`. -/
theorem pellPrimeFiveSplit_shiftSquare_iff_productCoefficient
    (X H y r s u v : ℤ)
    (hX : r ^ 2 - 5 * s ^ 2 = 4 * X)
    (hH : u ^ 2 - 5 * v ^ 2 = 4 * H)
    (hcross : r * v + s * u = 2) :
    y ^ 2 = 4 * X * H + 5 ↔
      2 * y = r * u + 5 * s * v ∨
        2 * y = -(r * u + 5 * s * v) := by
  have hnorm := pellPrimeFiveSplit_normComposition_of_norms
    X H r s u v hX hH
  rw [hcross] at hnorm
  constructor
  · intro hy
    have hsquares : (2 * y) ^ 2 = (r * u + 5 * s * v) ^ 2 := by
      nlinarith
    exact eq_or_eq_neg_of_sq_eq_sq _ _ hsquares
  · rintro (hy | hy)
    · have hsquares : (2 * y) ^ 2 = (r * u + 5 * s * v) ^ 2 := by
        rw [hy]
      nlinarith [hsquares]
    · have hsquares : (2 * y) ^ 2 = (r * u + 5 * s * v) ^ 2 := by
        rw [hy]
        ring
      nlinarith [hsquares]

/-! ## The adjacent-square gap -/

/-- There are no two positive natural-number squares differing by one.
The positivity assumption is necessary: `0^2 + 1 = 1^2`. -/
theorem pellPrimeFiveSplit_natSquare_add_one_ne_square
    (a y : ℕ) (ha : 0 < a) :
    y ^ 2 ≠ a ^ 2 + 1 := by
  intro h
  by_cases hya : y ≤ a
  · have hpowers : y ^ 2 ≤ a ^ 2 := Nat.pow_le_pow_left hya 2
    omega
  · have hay : a + 1 ≤ y := by omega
    have hpowers : (a + 1) ^ 2 ≤ y ^ 2 :=
      Nat.pow_le_pow_left hay 2
    nlinarith

/-- The exact pure-natural-number kernel used when the half-angle identity
has `X+1=a^2`.  Both nonzero hypotheses are essential. -/
theorem pellPrimeFiveSplit_neighborSquare_excludes
    (X a G y : ℕ)
    (hneighbor : X + 1 = a ^ 2)
    (ha : 0 < a)
    (hG : 0 < G) :
    y ^ 2 ≠ 4 * (X + 1) * G ^ 2 + 1 := by
  intro hy
  have hpositive : 0 < 2 * a * G := by positivity
  apply pellPrimeFiveSplit_natSquare_add_one_ne_square
    (2 * a * G) y hpositive
  calc
    y ^ 2 = 4 * (X + 1) * G ^ 2 + 1 := hy
    _ = (2 * a * G) ^ 2 + 1 := by rw [hneighbor]; ring

/-! ## Transparent modular and CRT ledgers -/

/-- A divisor of the Chebyshev coordinate sees the shifted equation as
`y^2 = 5` modulo that divisor.  Turning this congruence into
`q = ±1 (mod 5)` for an odd prime `q != 5` uses quadratic reciprocity and
is deliberately left to the accepted-interface ledger in the note. -/
theorem pellPrimeFiveSplit_factor_sees_five_as_square
    (q T y : ℤ)
    (hq : q ∣ T)
    (hy : y ^ 2 = 4 * T + 5) :
    y ^ 2 ≡ 5 [ZMOD q] := by
  have hzero : T ≡ 0 [ZMOD q] := Int.modEq_zero_iff_dvd.mpr hq
  rw [hy]
  simpa using (hzero.mul_left 4).add (Int.ModEq.refl 5)

/-- If two factors are each `±1 (mod 5)` and their reduced product is
`1`, their signs agree. -/
theorem pellPrimeFiveSplit_modFive_sameSign
    (A B : ℤ)
    (hA : A % 5 = 1 ∨ A % 5 = 4)
    (hB : B % 5 = 1 ∨ B % 5 = 4)
    (hproduct : ((A % 5) * (B % 5)) % 5 = 1) :
    (A % 5 = 1 ∧ B % 5 = 1) ∨
      (A % 5 = 4 ∧ B % 5 = 4) := by
  rcases hA with hA | hA <;> rcases hB with hB | hB
  · exact Or.inl ⟨hA, hB⟩
  · norm_num [hA, hB] at hproduct
  · norm_num [hA, hB] at hproduct
  · exact Or.inr ⟨hA, hB⟩

/-- The non-5 branch of the target CRT: `23 (mod 24)` and
`±1 (mod 5)` give exactly `71` or `119 (mod 120)`. -/
theorem pellPrimeFiveSplit_crt_nonFive
    (X : ℤ)
    (h24 : X % 24 = 23)
    (h5 : X % 5 = 1 ∨ X % 5 = 4) :
    X % 120 = 71 ∨ X % 120 = 119 := by
  rcases h5 with h5 | h5
  · left
    omega
  · right
    omega

/-- First ramified-5 CRT branch. -/
theorem pellPrimeFiveSplit_crt_five_positive
    (X : ℤ)
    (h24 : X % 24 = 23)
    (h25 : X % 25 = 5) :
    X % 600 = 455 := by
  omega

/-- Second ramified-5 CRT branch. -/
theorem pellPrimeFiveSplit_crt_five_negative
    (X : ℤ)
    (h24 : X % 24 = 23)
    (h25 : X % 25 = 20) :
    X % 600 = 95 := by
  omega

/-- The complete scalar lookup coupling the four possible prime classes to
the two ramified-5 CRT classes.  The number-theoretic proof that a solution
supplies `hclasses` is kept in the companion note. -/
theorem pellPrimeFiveSplit_crt_primeClassLookup
    (p X : ℤ)
    (h24 : X % 24 = 23)
    (hclasses :
      ((p % 20 = 1 ∨ p % 20 = 19) ∧ X % 25 = 5) ∨
        ((p % 20 = 9 ∨ p % 20 = 11) ∧ X % 25 = 20)) :
    ((p % 20 = 1 ∨ p % 20 = 19) ∧ X % 600 = 455) ∨
      ((p % 20 = 9 ∨ p % 20 = 11) ∧ X % 600 = 95) := by
  rcases hclasses with ⟨hp, h25⟩ | ⟨hp, h25⟩
  · exact Or.inl ⟨hp, pellPrimeFiveSplit_crt_five_positive X h24 h25⟩
  · exact Or.inr ⟨hp, pellPrimeFiveSplit_crt_five_negative X h24 h25⟩

/-! ## Elementary boundary ledgers around the BHV output -/

/-- If both `p` and the primitive divisor `q` are `±1 (mod 5)`, neither
of the first order-compatible integers `4*p-1`, `4*p+1` can be `q`.
The theorem is only CRT arithmetic; existence of `q` and the order `4*p`
come from the accepted BHV/rank interface in the note. -/
theorem pellPrimeFiveSplit_firstFourPBoundaries_incompatible
    (p q : ℤ)
    (hp5 : p % 5 = 1 ∨ p % 5 = 4)
    (hq5 : q % 5 = 1 ∨ q % 5 = 4) :
    q ≠ 4 * p - 1 ∧ q ≠ 4 * p + 1 := by
  rcases hp5 with hp5 | hp5 <;> rcases hq5 with hq5 | hq5 <;>
    constructor <;> omega

#print axioms pellPrimeFiveSplit_normComposition
#print axioms pellPrimeFiveSplit_normComposition_of_norms
#print axioms pellPrimeFiveSplit_reconstruct_shiftSquare
#print axioms pellPrimeFiveSplit_shiftSquare_iff_productCoefficient
#print axioms pellPrimeFiveSplit_natSquare_add_one_ne_square
#print axioms pellPrimeFiveSplit_neighborSquare_excludes
#print axioms pellPrimeFiveSplit_factor_sees_five_as_square
#print axioms pellPrimeFiveSplit_modFive_sameSign
#print axioms pellPrimeFiveSplit_crt_nonFive
#print axioms pellPrimeFiveSplit_crt_five_positive
#print axioms pellPrimeFiveSplit_crt_five_negative
#print axioms pellPrimeFiveSplit_crt_primeClassLookup
#print axioms pellPrimeFiveSplit_firstFourPBoundaries_incompatible

end IUTThreeClosures
