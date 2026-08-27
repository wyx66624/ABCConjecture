import IUTThreeClosures.FreyPellChebyshevIndexSeventeenDyadicColemanCertificate
import IUTThreeClosures.FreyPellChebyshevIndexNineteenStollGammaCertificate
import IUTThreeClosures.FreyPellChebyshevIndexTwentyThreeStollGammaCertificate
import IUTThreeClosures.FreyPellChebyshevIndexTwentyNineStollGammaCertificate

/-!
# Odd Chebyshev indices reduce exactly to prime indices at least 29

This file formalizes the quantifier bridge used by the Pell square-base
route.  The accepted external certificates at prime indices below 29 remain
explicit hypotheses.  Once those are supplied, any shifted-square solution
at an odd index greater than one produces one at a prime index at least 29,
with the new base still greater than one and still congruent to 23 modulo 24.

No assertion about the residual prime-index family is assumed silently: it
is isolated below as `OddPrimeShiftSquareExclusionAtLeastTwentyNine`.
-/

namespace IUTThreeClosures

/-- Integer Chebyshev evaluation respects congruence of its base. -/
theorem pellChebyshev_modEq
    (q : ℤ) (n : ℕ) (a b : ℤ) (hab : a ≡ b [ZMOD q]) :
    pellChebyshev n a ≡ pellChebyshev n b [ZMOD q] := by
  induction n using Nat.twoStepInduction with
  | zero => simp
  | one => simpa using hab
  | more n hn hn1 =>
      rw [pellChebyshev_add_two, pellChebyshev_add_two]
      have hprod :
          2 * a * pellChebyshev (n + 1) a ≡
            2 * b * pellChebyshev (n + 1) b [ZMOD q] := by
        simpa [mul_assoc] using (hab.mul hn1).mul_left 2
      exact hprod.sub hn

/-- An odd first-kind Chebyshev polynomial takes the value `-1` at `-1`. -/
theorem pellChebyshev_negOne_of_odd
    (m : ℕ) (hm : Odd m) : pellChebyshev m (-1) = -1 := by
  have hmz : Odd (m : ℤ) := by
    exact_mod_cast hm
  simp only [pellChebyshev, Polynomial.Chebyshev.T_eval_neg_one]
  rw [Int.negOnePow_odd _ hmz]
  rfl

/-- Odd-index Chebyshev composition preserves the Pell residue class
`23 = -1 (mod 24)`. -/
theorem pellChebyshev_pellResidue_of_odd
    (m : ℕ) (T : ℤ) (hm : Odd m) (hT : T % 24 = 23) :
    pellChebyshev m T % 24 = 23 := by
  have hmod : T ≡ -1 [ZMOD 24] := by
    change T % 24 = (-1 : ℤ) % 24
    norm_num
    exact hT
  have hcheb := pellChebyshev_modEq 24 m T (-1) hmod
  rw [pellChebyshev_negOne_of_odd m hm] at hcheb
  change pellChebyshev m T % 24 = (-1 : ℤ) % 24 at hcheb
  norm_num at hcheb
  exact hcheb

/-- The already certified odd prime range, stated without hiding any external
rational-point input. -/
def OddPrimeShiftSquareExclusionBelowTwentyNine : Prop :=
  ∀ p : ℕ, Nat.Prime p → Odd p → p < 29 →
    ∀ X : ℤ, 1 < X → X % 24 = 23 →
      ¬ ∃ z : ℤ, z ^ 2 = 4 * pellChebyshev p X + 5

/-- The exact unresolved uniform prime-index statement. -/
def OddPrimeShiftSquareExclusionAtLeastTwentyNine : Prop :=
  ∀ p : ℕ, Nat.Prime p → Odd p → 29 ≤ p →
    ∀ X : ℤ, 1 < X → X % 24 = 23 →
      ¬ ∃ z : ℤ, z ^ 2 = 4 * pellChebyshev p X + 5

/-- The exact uniform residual after the transparent prime-twenty-nine
certificate is supplied. -/
def OddPrimeShiftSquareExclusionAtLeastThirtyOne : Prop :=
  ∀ p : ℕ, Nat.Prime p → Odd p → 31 ≤ p →
    ∀ X : ℤ, 1 < X → X % 24 = 23 →
      ¬ ∃ z : ℤ, z ^ 2 = 4 * pellChebyshev p X + 5

/-- The elementary list of odd primes below 29. -/
theorem odd_prime_lt_twentyNine_cases
    (p : ℕ) (hp : Nat.Prime p) (hpodd : Odd p) (hlt : p < 29) :
    p = 3 ∨ p = 5 ∨ p = 7 ∨ p = 11 ∨
      p = 13 ∨ p = 17 ∨ p = 19 ∨ p = 23 := by
  have hfinite :
      ∀ q : Fin 29, Nat.Prime q.1 → Odd q.1 →
        q.1 = 3 ∨ q.1 = 5 ∨ q.1 = 7 ∨ q.1 = 11 ∨
          q.1 = 13 ∨ q.1 = 17 ∨ q.1 = 19 ∨ q.1 = 23 := by
    decide
  exact hfinite ⟨p, hlt⟩ hp hpodd

/-- The frozen external certificates at `3,5,7,11,13,17,19,23` supply the
complete small-prime exclusion interface. -/
theorem oddPrimeShiftSquareExclusionBelowTwentyNine_of_external_certificates
    (h3 : MagmaIntegralXCertificate216a1)
    (h5 : MagmaIntegralXCertificateIndexFive)
    (h7 : MagmaSageRationalXCertificateIndexSeven)
    (h11 : MagmaSageRationalXCertificateIndexEleven)
    (h13 : MagmaSageRationalXCertificateIndexThirteen)
    (h17 : MagmaSageRationalTCertificateIndexSeventeen)
    (h19 : MagmaSageRationalTargetDiskCertificateIndexNineteen)
    (h23 : PARISageRationalTargetDiskCertificateIndexTwentyThree) :
    OddPrimeShiftSquareExclusionBelowTwentyNine := by
  intro p hp hpodd hlt X hX hresidue
  rcases odd_prime_lt_twentyNine_cases p hp hpodd hlt with
      rfl | rfl | rfl | rfl | rfl | rfl | rfl | rfl
  · exact no_indexThree_of_external_certificate h3 X hX
  · exact no_indexFive_chebyshev_shiftSquare_of_external_certificate h5 X hX
  · exact no_indexSeven_chebyshev_shiftSquare_of_external_certificate h7 X hX
  · exact no_indexEleven_chebyshev_shiftSquare_of_external_certificate h11 X hX
  · exact no_indexThirteen_chebyshev_shiftSquare_of_external_certificate h13 X hX
  · exact no_indexSeventeen_chebyshev_shiftSquare_of_external_certificate h17 X hX
  · exact no_indexNineteen_chebyshev_shiftSquare_in_pellResidue_of_external_certificate
      h19 X hX hresidue
  · exact no_indexTwentyThree_chebyshev_shiftSquare_in_pellResidue_of_external_certificate
      h23 X hX hresidue

/-- Exact composite-to-prime reduction.  A hypothetical solution at an odd
index `k>1` yields a solution at a prime divisor `p≥29`.  The cofactor is odd,
so Chebyshev composition preserves both positivity and the residue class. -/
theorem oddChebyshevIndex_primeDivisor_reduction
    (hsmall : OddPrimeShiftSquareExclusionBelowTwentyNine)
    (k : ℕ) (T y : ℤ)
    (hk : 1 < k) (hkodd : Odd k)
    (hT : 1 < T) (hTresidue : T % 24 = 23)
    (hsquare : y ^ 2 = 4 * pellChebyshev k T + 5) :
    ∃ p m : ℕ, ∃ X : ℤ,
      Nat.Prime p ∧ Odd p ∧ p ∣ k ∧ k = p * m ∧ 29 ≤ p ∧ Odd m ∧
        X = pellChebyshev m T ∧ 1 < X ∧ X % 24 = 23 ∧
          y ^ 2 = 4 * pellChebyshev p X + 5 := by
  obtain ⟨p, hp, hpdvd⟩ := Nat.exists_prime_and_dvd (by omega : k ≠ 1)
  obtain ⟨m, hkfactor⟩ := hpdvd
  have hpodd : Odd p := by
    apply Nat.Odd.of_mul_left
    rw [← hkfactor]
    exact hkodd
  have hmodd : Odd m := by
    apply Nat.Odd.of_mul_right
    rw [← hkfactor]
    exact hkodd
  have hmpos : 0 < m := by
    by_contra hm
    have : m = 0 := by omega
    subst m
    simp at hkfactor
    omega
  let X := pellChebyshev m T
  have hXgt : 1 < X := one_lt_pellChebyshev m T hmpos hT
  have hXresidue : X % 24 = 23 :=
    pellChebyshev_pellResidue_of_odd m T hmodd hTresidue
  have hshift : y ^ 2 = 4 * pellChebyshev p X + 5 := by
    dsimp [X]
    rw [← pellChebyshev_mul p m T]
    rw [← hkfactor]
    exact hsquare
  have hpge : 29 ≤ p := by
    by_contra hnot
    have hplt : p < 29 := by omega
    exact hsmall p hp hpodd hplt X hXgt hXresidue ⟨y, hshift⟩
  refine ⟨p, m, X, hp, hpodd, ?_, hkfactor, hpge, hmodd, rfl,
    hXgt, hXresidue, hshift⟩
  exact ⟨m, hkfactor⟩

/-- Small-prime certificates plus the displayed residual uniform statement
exclude every odd Chebyshev index greater than one. -/
theorem no_oddChebyshevIndex_shiftSquare_of_primeRanges
    (hsmall : OddPrimeShiftSquareExclusionBelowTwentyNine)
    (hlarge : OddPrimeShiftSquareExclusionAtLeastTwentyNine)
    (k : ℕ) (T : ℤ)
    (hk : 1 < k) (hkodd : Odd k)
    (hT : 1 < T) (hTresidue : T % 24 = 23) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev k T + 5 := by
  rintro ⟨y, hy⟩
  obtain ⟨p, m, X, hp, hpodd, _hpdvd, _hkfactor, hpge, _hmodd,
      _hX, hXgt, hXresidue, hshift⟩ :=
    oddChebyshevIndex_primeDivisor_reduction hsmall k T y hk hkodd hT
      hTresidue hy
  exact hlarge p hp hpodd hpge X hXgt hXresidue ⟨y, hshift⟩

/-- Once the explicit prime-twenty-nine certificate is supplied, the exact
composite-to-prime reduction lands at an odd prime at least 31. -/
theorem oddChebyshevIndex_primeDivisor_reduction_atLeastThirtyOne
    (hsmall : OddPrimeShiftSquareExclusionBelowTwentyNine)
    (h29 : PARISageRationalTargetDiskCertificateIndexTwentyNine)
    (k : ℕ) (T y : ℤ)
    (hk : 1 < k) (hkodd : Odd k)
    (hT : 1 < T) (hTresidue : T % 24 = 23)
    (hsquare : y ^ 2 = 4 * pellChebyshev k T + 5) :
    ∃ p m : ℕ, ∃ X : ℤ,
      Nat.Prime p ∧ Odd p ∧ p ∣ k ∧ k = p * m ∧ 31 ≤ p ∧ Odd m ∧
        X = pellChebyshev m T ∧ 1 < X ∧ X % 24 = 23 ∧
          y ^ 2 = 4 * pellChebyshev p X + 5 := by
  obtain ⟨p, m, X, hp, hpodd, hpdvd, hkfactor, hpge, hmodd,
      hX, hXgt, hXresidue, hshift⟩ :=
    oddChebyshevIndex_primeDivisor_reduction hsmall k T y hk hkodd hT
      hTresidue hsquare
  have hpne : p ≠ 29 := by
    intro hp29
    subst p
    exact no_indexTwentyNine_chebyshev_shiftSquare_in_pellResidue_of_external_certificate
      h29 X hXgt hXresidue ⟨y, hshift⟩
  have hpoddCopy := hpodd
  obtain ⟨r, hr⟩ := hpoddCopy
  have hpge31 : 31 ≤ p := by omega
  exact ⟨p, m, X, hp, hpodd, hpdvd, hkfactor, hpge31, hmodd,
    hX, hXgt, hXresidue, hshift⟩

/-- Small-prime certificates through 29 plus the displayed residual uniform
statement exclude every odd Chebyshev index greater than one. -/
theorem no_oddChebyshevIndex_shiftSquare_of_primeRanges_afterTwentyNine
    (hsmall : OddPrimeShiftSquareExclusionBelowTwentyNine)
    (h29 : PARISageRationalTargetDiskCertificateIndexTwentyNine)
    (hlarge : OddPrimeShiftSquareExclusionAtLeastThirtyOne)
    (k : ℕ) (T : ℤ)
    (hk : 1 < k) (hkodd : Odd k)
    (hT : 1 < T) (hTresidue : T % 24 = 23) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev k T + 5 := by
  rintro ⟨y, hy⟩
  obtain ⟨p, m, X, hp, hpodd, _hpdvd, _hkfactor, hpge, _hmodd,
      _hX, hXgt, hXresidue, hshift⟩ :=
    oddChebyshevIndex_primeDivisor_reduction_atLeastThirtyOne
      hsmall h29 k T y hk hkodd hT hTresidue hy
  exact hlarge p hp hpodd hpge X hXgt hXresidue ⟨y, hshift⟩

#print axioms pellChebyshev_modEq
#print axioms pellChebyshev_negOne_of_odd
#print axioms pellChebyshev_pellResidue_of_odd
#print axioms odd_prime_lt_twentyNine_cases
#print axioms
  oddPrimeShiftSquareExclusionBelowTwentyNine_of_external_certificates
#print axioms oddChebyshevIndex_primeDivisor_reduction
#print axioms no_oddChebyshevIndex_shiftSquare_of_primeRanges
#print axioms oddChebyshevIndex_primeDivisor_reduction_atLeastThirtyOne
#print axioms
  no_oddChebyshevIndex_shiftSquare_of_primeRanges_afterTwentyNine

end IUTThreeClosures
