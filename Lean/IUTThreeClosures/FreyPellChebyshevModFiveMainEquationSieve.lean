/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.FreyPellChebyshevOddQuotientGcdLedger
import Mathlib.NumberTheory.LegendreSymbol.JacobiSymbol

/-!
# The main shifted-square equation modulo five

This file closes the elementary modulo-five bridge for

`y^2 = 4 * pellChebyshev p X + 5`.

It proves that a prime index `p > 5` makes `pellChebyshev p` the identity
map modulo five, hence a solution forces `X % 5` to be a square residue.  In
the ramified branch `X = 5*u`, it also proves the exact first five-adic digit
and the signed-index condition.  Finally, under the positivity and oddness
conditions of the repository's residual equation, Jacobi reciprocity proves
that the index cannot have `(5/p) = -1`.

There are no external certificates, new axioms, or conjectural interfaces in
this module.
-/

namespace IUTThreeClosures

open scoped NumberTheorySymbols

/-! ## The Chebyshev map on `F_5` -/

/-- Integer Chebyshev evaluation transports a congruence of bases.  This
local version keeps the present module independent of the large fixed-index
certificate import chain. -/
theorem pellChebyshev_modEq_sieve
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

/-- Odd first-kind Chebyshev evaluations are odd functions of the base. -/
theorem pellChebyshev_neg_of_odd
    (n : ℕ) (x : ℤ) (hn : Odd n) :
    pellChebyshev n (-x) = -pellChebyshev n x := by
  have hnz : Odd (n : ℤ) := by
    exact_mod_cast hn
  unfold pellChebyshev
  rw [Polynomial.Chebyshev.T_eval_neg]
  rw [Int.negOnePow_odd _ hnz]
  norm_num

/-- An odd first-kind Chebyshev polynomial vanishes at zero. -/
theorem pellChebyshev_zero_of_odd
    (n : ℕ) (hn : Odd n) : pellChebyshev n 0 = 0 := by
  have hnz : Odd (n : ℤ) := by
    exact_mod_cast hn
  unfold pellChebyshev
  simpa using
    (Polynomial.Chebyshev.T_eval_zero_of_odd (R := ℤ) hnz)

/-- At the residue `2`, the Chebyshev sequence is periodic modulo five with
period three. -/
theorem pellChebyshev_two_modFive_period_three (n : ℕ) :
    pellChebyshev (n + 3) 2 ≡ pellChebyshev n 2 [ZMOD 5] := by
  induction n using Nat.twoStepInduction with
  | zero =>
      rw [show 0 + 3 = 3 by omega, pellChebyshev_three]
      simp
      norm_num
  | one =>
      rw [show 1 + 3 = 2 + 2 by omega, pellChebyshev_add_two]
      norm_num only [Nat.reduceAdd]
      rw [show 3 = 1 + 2 by omega, pellChebyshev_add_two]
      norm_num only [Nat.reduceAdd]
      rw [show 2 = 0 + 2 by omega, pellChebyshev_add_two]
      simp
      norm_num
  | more n hn hn1 =>
      rw [show (n + 2) + 3 = (n + 3) + 2 by omega,
        pellChebyshev_add_two]
      rw [pellChebyshev_add_two n]
      have hstep := (hn1.mul_left 4).sub hn
      simpa [mul_assoc] using hstep

/-- Iterating the period-three congruence reduces an index to its remainder. -/
theorem pellChebyshev_two_modFive_mul_three_add
    (k r : ℕ) :
    pellChebyshev (3 * k + r) 2 ≡ pellChebyshev r 2 [ZMOD 5] := by
  induction k with
  | zero => simp
  | succ k ih =>
      have hperiod := pellChebyshev_two_modFive_period_three (3 * k + r)
      simpa [Nat.mul_succ, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using
        hperiod.trans ih

/-- Every positive index not divisible by three takes the value `2` at the
residue `2`, modulo five. -/
theorem pellChebyshev_two_modFive_of_three_not_dvd
    (n : ℕ) (hn3 : ¬ 3 ∣ n) :
    pellChebyshev n 2 ≡ 2 [ZMOD 5] := by
  have hrem : n % 3 < 3 := Nat.mod_lt n (by norm_num)
  have hdecomp : 3 * (n / 3) + n % 3 = n := by
    omega
  have hperiod := pellChebyshev_two_modFive_mul_three_add (n / 3) (n % 3)
  rw [hdecomp] at hperiod
  interval_cases h : n % 3
  · exfalso
    apply hn3
    exact Nat.dvd_of_mod_eq_zero h
  · simpa [h, pellChebyshev_one] using hperiod
  · rw [show 2 = 0 + 2 by omega, pellChebyshev_add_two] at hperiod
    exact hperiod.trans (by norm_num)

/-- A prime index strictly larger than five is neither two nor three and is
therefore odd and not divisible by three. -/
theorem prime_gt_five_odd_and_three_not_dvd
    (p : ℕ) (hp : Nat.Prime p) (hp5 : 5 < p) :
    Odd p ∧ ¬ 3 ∣ p := by
  have hp2 : p ≠ 2 := by omega
  refine ⟨hp.odd_of_ne_two hp2, ?_⟩
  intro h3
  have hcases := hp.eq_one_or_self_of_dvd 3 h3
  rcases hcases with h | h
  · norm_num at h
  · omega

/-- For a prime `p > 5`, the first-kind Chebyshev map is the identity on all
integer residue classes modulo five. -/
theorem pellChebyshev_modFive_eq_self_of_prime_gt_five
    (p : ℕ) (X : ℤ) (hp : Nat.Prime p) (hp5 : 5 < p) :
    pellChebyshev p X ≡ X [ZMOD 5] := by
  rcases prime_gt_five_odd_and_three_not_dvd p hp hp5 with ⟨hpodd, hp3⟩
  have htwo := pellChebyshev_two_modFive_of_three_not_dvd p hp3
  have hminusTwo : pellChebyshev p (-2) ≡ -2 [ZMOD 5] := by
    rw [pellChebyshev_neg_of_odd p 2 hpodd]
    exact htwo.neg
  have hremNonneg : 0 ≤ X % 5 := Int.emod_nonneg X (by norm_num)
  have hremLt : X % 5 < 5 := Int.emod_lt_of_pos X (by norm_num)
  interval_cases hX : X % 5
  · have hbase : X ≡ 0 [ZMOD 5] := by
      change X % 5 = (0 : ℤ) % 5
      norm_num [hX]
    calc
      pellChebyshev p X ≡ pellChebyshev p 0 [ZMOD 5] :=
        pellChebyshev_modEq_sieve 5 p X 0 hbase
      _ = 0 := pellChebyshev_zero_of_odd p hpodd
      _ ≡ X [ZMOD 5] := hbase.symm
  · have hbase : X ≡ 1 [ZMOD 5] := by
      change X % 5 = (1 : ℤ) % 5
      norm_num [hX]
    calc
      pellChebyshev p X ≡ pellChebyshev p 1 [ZMOD 5] :=
        pellChebyshev_modEq_sieve 5 p X 1 hbase
      _ = 1 := by simp [pellChebyshev]
      _ ≡ X [ZMOD 5] := hbase.symm
  · have hbase : X ≡ 2 [ZMOD 5] := by
      change X % 5 = (2 : ℤ) % 5
      norm_num [hX]
    exact (pellChebyshev_modEq_sieve 5 p X 2 hbase).trans (htwo.trans hbase.symm)
  · have hbase : X ≡ -2 [ZMOD 5] := by
      change X % 5 = (-2 : ℤ) % 5
      norm_num [hX]
    exact (pellChebyshev_modEq_sieve 5 p X (-2) hbase).trans
      (hminusTwo.trans hbase.symm)
  · have hbase : X ≡ -1 [ZMOD 5] := by
      change X % 5 = (-1 : ℤ) % 5
      norm_num [hX]
    calc
      pellChebyshev p X ≡ pellChebyshev p (-1) [ZMOD 5] :=
        pellChebyshev_modEq_sieve 5 p X (-1) hbase
      _ = -1 := by
        rw [pellChebyshev_neg_of_odd p 1 hpodd]
        simp [pellChebyshev]
      _ ≡ X [ZMOD 5] := hbase.symm

/-! ## The direct main-equation sieve -/

/-- The complete list of square residues modulo five, restated here through
an explicit five-case reduction. -/
theorem shiftedSquare_square_emod_five (y : ℤ) :
    y ^ 2 % 5 = 0 ∨ y ^ 2 % 5 = 1 ∨ y ^ 2 % 5 = 4 := by
  have hyNonneg : 0 ≤ y % 5 := Int.emod_nonneg y (by norm_num)
  have hyLt : y % 5 < 5 := Int.emod_lt_of_pos y (by norm_num)
  have hreduce : y ^ 2 % 5 = ((y % 5) ^ 2) % 5 := by
    simp [pow_two, Int.mul_emod]
  rw [hreduce]
  interval_cases h : y % 5 <;> norm_num [h]

/-! ## A Jacobi reciprocity kernel -/

/-- If five is represented by a square modulo a positive odd modulus
coprime to five, its Jacobi symbol at that modulus is one. -/
theorem jacobiSym_five_eq_one_of_isSquare_mod
    (N : ℕ) (y : ℤ)
    (_hNodd : Odd N) (hN5 : ¬ 5 ∣ N)
    (hy : y ^ 2 ≡ 5 [ZMOD (N : ℤ)]) :
    J(5 | N) = 1 := by
  have hcopNat : Nat.Coprime 5 N :=
    Nat.prime_five.coprime_iff_not_dvd.mpr hN5
  have hcopInt : Int.gcd (5 : ℤ) (N : ℤ) = 1 := by
    calc
      Int.gcd (5 : ℤ) (N : ℤ) = Nat.gcd 5 N := by
        simpa using Int.gcd_natCast_natCast 5 N
      _ = 1 := hcopNat
  have hsquare : IsSquare ((5 : ℤ) : ZMod N) := by
    refine ⟨(y : ZMod N), ?_⟩
    have hcast : ((5 : ℤ) : ZMod N) = ((y ^ 2 : ℤ) : ZMod N) := by
      rw [ZMod.intCast_eq_intCast_iff']
      exact hy.symm
    simpa [pow_two] using hcast
  rcases jacobiSym.eq_one_or_neg_one hcopInt with h | h
  · exact h
  · exact False.elim ((ZMod.nonsquare_of_jacobiSym_eq_neg_one h) hsquare)

/-- Because `5 = 1 (mod 4)`, the preceding square condition also forces the
reversed Jacobi symbol modulo five to be one. -/
theorem jacobiSym_modFive_eq_one_of_five_isSquare_mod
    (N : ℕ) (y : ℤ)
    (hNodd : Odd N) (hN5 : ¬ 5 ∣ N)
    (hy : y ^ 2 ≡ 5 [ZMOD (N : ℤ)]) :
    J((N : ℤ) | 5) = 1 := by
  have hrec := jacobiSym.quadratic_reciprocity_one_mod_four
    (a := 5) (b := N) (by norm_num) hNodd
  rw [← hrec]
  exact jacobiSym_five_eq_one_of_isSquare_mod N y hNodd hN5 hy

/-- The main shifted-square equation at a prime index `p > 5` forces the base
to be a square residue modulo five. -/
theorem pellChebyshev_shiftSquare_base_modFive
    (p : ℕ) (X y : ℤ)
    (hp : Nat.Prime p) (hp5 : 5 < p)
    (hy : y ^ 2 = 4 * pellChebyshev p X + 5) :
    X % 5 = 0 ∨ X % 5 = 1 ∨ X % 5 = 4 := by
  have hT := pellChebyshev_modFive_eq_self_of_prime_gt_five p X hp hp5
  have hshift : y ^ 2 ≡ 4 * X + 5 [ZMOD 5] := by
    have heq : y ^ 2 ≡ 4 * pellChebyshev p X + 5 [ZMOD 5] := by
      rw [hy]
    exact heq.trans ((hT.mul_left 4).add (Int.ModEq.refl 5))
  have hreduce : (4 * X + 5) % 5 = (4 * (X % 5) + 5) % 5 := by
    simp [Int.mul_emod]
  rcases shiftedSquare_square_emod_five y with hs | hs | hs
  · left
    change y ^ 2 % 5 = (4 * X + 5) % 5 at hshift
    rw [hreduce] at hshift
    omega
  · right
    right
    change y ^ 2 % 5 = (4 * X + 5) % 5 at hshift
    rw [hreduce] at hshift
    omega
  · right
    left
    change y ^ 2 % 5 = (4 * X + 5) % 5 at hshift
    rw [hreduce] at hshift
    omega

/-! ## The ramified branch `X = 5*u` -/

/-- In the ramified branch the first exact digit is

`(-1)^m * (2*m+1) * u = 1 (mod 5)`.

This is the requested `s*p*u = 1 (mod 5)` condition, with
`s = (-1)^m` and `p = 2*m+1`. -/
theorem pellChebyshev_ramifiedFive_signedIndex_mul_cofactor_modFive
    (m : ℕ) (u y : ℤ)
    (hy : y ^ 2 =
      4 * pellChebyshev (2 * m + 1) (5 * u) + 5) :
    (((-1 : ℤ) ^ m * (2 * (m : ℤ) + 1)) * u) % 5 = 1 := by
  have hyq : y ^ 2 =
      4 * (5 * u) * pellOddChebyshevQuotient m (5 * u) + 5 := by
    calc
      y ^ 2 = 4 * pellChebyshev (2 * m + 1) (5 * u) + 5 := hy
      _ = 4 * (5 * u) * pellOddChebyshevQuotient m (5 * u) + 5 := by
        rw [pellChebyshev_odd_eq_mul_quotient]
        ring
  let H : ℤ := pellOddChebyshevQuotient m (5 * u)
  let c : ℤ := pellOddChebyshevLinearCoefficient m
  have hfiveSq : (5 : ℤ) ∣ y ^ 2 := by
    refine ⟨4 * u * H + 1, ?_⟩
    simpa [H] using hyq.trans (by ring)
  have hfiveY : (5 : ℤ) ∣ y :=
    Int.Prime.dvd_pow' Nat.prime_five hfiveSq
  rcases hfiveY with ⟨z, hz⟩
  have hscalar : 5 * z ^ 2 = 4 * u * H + 1 := by
    rw [hz] at hyq
    dsimp [H] at hyq ⊢
    nlinarith [hyq]
  have huH : u * H ≡ 1 [ZMOD 5] := by
    apply Int.modEq_of_dvd
    refine ⟨z ^ 2 - u * H, ?_⟩
    nlinarith [hscalar]
  have hHcBase : H ≡ c [ZMOD (5 * u)] := by
    simpa [H, c] using pellOddChebyshevQuotient_mod_base m (5 * u)
  have hHcFive : H ≡ c [ZMOD 5] := by
    exact Int.ModEq.of_dvd ⟨u, rfl⟩ hHcBase
  have huc : u * c ≡ 1 [ZMOD 5] :=
    ((Int.ModEq.refl u).mul hHcFive).symm.trans huH
  change (((-1 : ℤ) ^ m * (2 * (m : ℤ) + 1)) * u) % 5 = 1
  have hucEq : (u * c) % 5 = 1 := by
    simpa using huc.eq
  simpa [c, pellOddChebyshevLinearCoefficient, mul_comm, mul_left_comm,
    mul_assoc] using hucEq

/-- The same equation makes the base exactly divisible by five: `5 | 5*u`
but `25 ∤ 5*u`.  This is the integer-divisibility form of `v_5(X) = 1`,
and avoids any convention for the valuation of zero. -/
theorem pellChebyshev_ramifiedFive_exact_base_divisibility
    (m : ℕ) (u y : ℤ)
    (hy : y ^ 2 =
      4 * pellChebyshev (2 * m + 1) (5 * u) + 5) :
    (5 : ℤ) ∣ 5 * u ∧ ¬ (25 : ℤ) ∣ 5 * u := by
  have hspu :=
    pellChebyshev_ramifiedFive_signedIndex_mul_cofactor_modFive m u y hy
  constructor
  · exact ⟨u, rfl⟩
  · intro h25
    rcases h25 with ⟨k, hk⟩
    have hu : u = 5 * k := by
      nlinarith [hk]
    rw [hu] at hspu
    norm_num [Int.mul_emod] at hspu

/-- A generic prime-index wrapper for the two ramified conclusions. -/
theorem pellChebyshev_prime_shiftSquare_ramifiedFive_conditions
    (p : ℕ) (X y : ℤ)
    (hp : Nat.Prime p) (hp5 : 5 < p)
    (hX5 : (5 : ℤ) ∣ X)
    (hy : y ^ 2 = 4 * pellChebyshev p X + 5) :
    ∃ m : ℕ, ∃ u : ℤ,
      p = 2 * m + 1 ∧ X = 5 * u ∧
      (((-1 : ℤ) ^ m * (p : ℤ)) * u) % 5 = 1 ∧
      ¬ (25 : ℤ) ∣ X := by
  have hpodd := (prime_gt_five_odd_and_three_not_dvd p hp hp5).1
  obtain ⟨m, hm⟩ := hpodd
  rcases hX5 with ⟨u, hu⟩
  refine ⟨m, u, hm, hu, ?_, ?_⟩
  · subst p
    subst X
    exact pellChebyshev_ramifiedFive_signedIndex_mul_cofactor_modFive m u y hy
  · subst p
    subst X
    exact (pellChebyshev_ramifiedFive_exact_base_divisibility m u y hy).2

/-! ## The inert-index exclusion -/

/-- In the positive odd-base ramified branch, the shifted-square equation
forces `(5/p) = 1`, written as a Jacobi symbol.  For prime `p` this is exactly
the Legendre symbol. -/
theorem pellChebyshev_ramifiedFive_jacobiSym_five_index_eq_one
    (m : ℕ) (u y : ℤ)
    (_hp : Nat.Prime (2 * m + 1))
    (hXgt : 1 < 5 * u)
    (hXodd : Odd (5 * u))
    (hy : y ^ 2 =
      4 * pellChebyshev (2 * m + 1) (5 * u) + 5) :
    J(5 | 2 * m + 1) = 1 := by
  let p : ℕ := 2 * m + 1
  let X : ℤ := 5 * u
  let H : ℤ := pellOddChebyshevQuotient m X
  let c : ℤ := pellOddChebyshevLinearCoefficient m
  have hpodd : Odd p := by
    exact ⟨m, by simp [p, two_mul]⟩
  have hfactor : pellChebyshev p X = X * H := by
    simpa [p, X, H] using pellChebyshev_odd_eq_mul_quotient m X
  have hyq : y ^ 2 = 4 * X * H + 5 := by
    have hy' : y ^ 2 = 4 * pellChebyshev p X + 5 := by
      simpa [p, X] using hy
    calc
      y ^ 2 = 4 * pellChebyshev p X + 5 := hy'
      _ = 4 * X * H + 5 := by rw [hfactor]; ring
  have hTgt : 1 < pellChebyshev p X :=
    one_lt_pellChebyshev p X (by simp [p]) (by simpa [X] using hXgt)
  have hHpos : 0 < H := by
    by_contra hnot
    have hHle : H ≤ 0 := le_of_not_gt hnot
    have hXnonneg : 0 ≤ X := by omega
    have hprod : X * H ≤ 0 := mul_nonpos_of_nonneg_of_nonpos hXnonneg hHle
    rw [hfactor] at hTgt
    omega
  have hH8 : H ≡ 1 [ZMOD 8] := by
    simpa [X, H] using
      pellOddChebyshevQuotient_mod_eight_of_odd m (5 * u) hXodd
  have hHodd : Odd H := by
    rw [Int.odd_iff]
    change H % 8 = (1 : ℤ) % 8 at hH8
    omega
  have hspu : (c * u) % 5 = 1 := by
    have h :=
      pellChebyshev_ramifiedFive_signedIndex_mul_cofactor_modFive m u y hy
    simpa [c, pellOddChebyshevLinearCoefficient] using h
  have hHcX : H ≡ c [ZMOD X] := by
    simpa [H, c, X] using pellOddChebyshevQuotient_mod_base m (5 * u)
  have hHc5 : H ≡ c [ZMOD 5] := by
    apply Int.ModEq.of_dvd (show (5 : ℤ) ∣ X by exact ⟨u, rfl⟩)
    exact hHcX
  have hc5 : ¬ (5 : ℤ) ∣ c := by
    intro hc
    have hc0 : c % 5 = 0 := Int.dvd_iff_emod_eq_zero.mp hc
    have : (c * u) % 5 = 0 := by
      rw [Int.mul_emod, hc0]
      norm_num
    omega
  have hH5 : ¬ (5 : ℤ) ∣ H := by
    intro hH
    have hH0 : H ≡ 0 [ZMOD 5] := Int.modEq_zero_iff_dvd.mpr hH
    have hc0 : c ≡ 0 [ZMOD 5] := hHc5.symm.trans hH0
    exact hc5 (Int.modEq_zero_iff_dvd.mp hc0)
  have hyH : y ^ 2 ≡ 5 [ZMOD H] := by
    rw [hyq]
    have hzero : X * H ≡ 0 [ZMOD H] :=
      Int.modEq_zero_iff_dvd.mpr ⟨X, by ring⟩
    simpa [mul_assoc] using
      (hzero.mul_left 4).add (Int.ModEq.refl 5)
  let N : ℕ := H.natAbs
  have hNcast : (N : ℤ) = H := by
    simp [N, Int.natAbs_of_nonneg (le_of_lt hHpos)]
  have hNodd : Odd N := by
    have hNoddInt : Odd (N : ℤ) := by
      simpa [hNcast] using hHodd
    exact_mod_cast hNoddInt
  have hN5 : ¬ 5 ∣ N := by
    intro h
    apply hH5
    have hcastDiv : (5 : ℤ) ∣ (N : ℤ) := by
      exact_mod_cast h
    simpa [hNcast] using hcastDiv
  have hyN : y ^ 2 ≡ 5 [ZMOD (N : ℤ)] := by
    simpa [hNcast] using hyH
  have hNJ : J((N : ℤ) | 5) = 1 :=
    jacobiSym_modFive_eq_one_of_five_isSquare_mod N y hNodd hN5 hyN
  have hcJ : J(c | 5) = 1 := by
    have hNc : (N : ℤ) ≡ c [ZMOD 5] := by
      simpa [hNcast] using hHc5
    rw [← jacobiSym.mod_left' hNc.eq]
    exact hNJ
  have hminusOneJ : J((-1 : ℤ) | 5) = 1 := by
    rw [jacobiSym.at_neg_one (by decide : Odd 5)]
    exact ZMod.χ₄_nat_one_mod_four (by norm_num)
  have hsignJ : J(((-1 : ℤ) ^ m) | 5) = 1 := by
    rw [jacobiSym.pow_left, hminusOneJ, one_pow]
  have hpJ : J((p : ℤ) | 5) = 1 := by
    dsimp [c] at hcJ
    rw [pellOddChebyshevLinearCoefficient, jacobiSym.mul_left,
      hsignJ, one_mul] at hcJ
    simpa [p] using hcJ
  have hrec := jacobiSym.quadratic_reciprocity_one_mod_four
    (a := 5) (b := p) (by norm_num) hpodd
  simpa [p] using hrec.trans hpJ

/-- Therefore a prime index with `(5/p) = -1` has no solution in the
ramified branch of the repository residual equation. -/
theorem no_pellChebyshev_prime_shiftSquare_of_five_dvd_base_of_jacobi_neg_one
    (p : ℕ) (X : ℤ)
    (hp : Nat.Prime p) (hp5 : 5 < p)
    (hXgt : 1 < X) (hX24 : X % 24 = 23)
    (hX5 : (5 : ℤ) ∣ X)
    (hinert : J(5 | p) = -1) :
    ¬ ∃ y : ℤ, y ^ 2 = 4 * pellChebyshev p X + 5 := by
  rintro ⟨y, hy⟩
  have hpodd := (prime_gt_five_odd_and_three_not_dvd p hp hp5).1
  obtain ⟨m, hm⟩ := hpodd
  rcases hX5 with ⟨u, hu⟩
  have hXodd : Odd X := by
    rw [Int.odd_iff]
    omega
  subst p
  subst X
  have hsplit :=
    pellChebyshev_ramifiedFive_jacobiSym_five_index_eq_one
      m u y hp hXgt hXodd hy
  omega

#print axioms pellChebyshev_modFive_eq_self_of_prime_gt_five
#print axioms pellChebyshev_shiftSquare_base_modFive
#print axioms pellChebyshev_ramifiedFive_signedIndex_mul_cofactor_modFive
#print axioms pellChebyshev_ramifiedFive_exact_base_divisibility
#print axioms pellChebyshev_prime_shiftSquare_ramifiedFive_conditions
#print axioms pellChebyshev_ramifiedFive_jacobiSym_five_index_eq_one
#print axioms no_pellChebyshev_prime_shiftSquare_of_five_dvd_base_of_jacobi_neg_one

end IUTThreeClosures
