/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCBidirectionalPrimeTransportSuccessor20260903
import IUTThreeClosures.ABCThreeArmIncidenceSuccessor20260903
import Mathlib.NumberTheory.PrimesCongruentOne
import Mathlib.NumberTheory.SumTwoSquares
import Mathlib.Tactic

/-!
# Prime-hypotenuse Pythagorean obstruction to bidirectional endpoint energy

The ordinary optimization and number-theoretic proofs precede this
formalization in
`research/ABC_BIDIRECTIONAL_ENERGY_ADVERSARIAL_AUDIT_2026_09_03.md`.

For every sufficiently large prime `p = m^2 + n^2` congruent to one modulo
four, squaring the primitive Pythagorean triple gives an `ABCPoint` whose
endpoint source is the single excess layer at `p`.  Every external sink prime
is at most `m+n`, hence its fourth power is at most `p^3`.  Every unit of
carried mass therefore pays at least `1/4` in relative logarithmic drop.
Together with the unmatched source mass, every bidirectional flow has energy
at least `(log p)/4`, whereas the conductor is at most `3 log p`.

This supplies an infinite complete-premise counterexample to the exact
`UniformBidirectionalEndpointEnergyBound`.  It makes no assertion against the
standard `ABCConjecture`.
-/

namespace IUTThreeClosures

open scoped BigOperators
open UniqueFactorizationMonoid

noncomputable section

namespace ABCBidirectionalEnergyPythagoreanObstruction20260903

open SignedEndpointPrimeTokenTransport
open ABCBidirectionalPrimeTransportSuccessor20260903
open ABCThreeArmIncidenceSuccessor20260903

/-! ## Arbitrarily large ordered primitive two-square data -/

/-- A prime congruent to one modulo four, with its two-square representation
ordered and equipped with the exact coprimality and parity data needed for
Euclid's primitive Pythagorean construction. -/
structure PrimeHypotenuseDatum where
  p : ℕ
  m : ℕ
  n : ℕ
  prime : p.Prime
  mod_four : p % 4 = 1
  n_pos : 0 < n
  n_lt_m : n < m
  coprime : m.Coprime n
  oppositeParity : (Odd m ∧ Even n) ∨ (Even m ∧ Odd n)
  sq_add_sq : m ^ 2 + n ^ 2 = p

/-- Neither coordinate in a two-square representation of a prime congruent
to one modulo four can vanish. -/
theorem twoSquare_left_pos
    {p u v : ℕ} (hp : p.Prime) (hsum : u ^ 2 + v ^ 2 = p) : 0 < u := by
  have hu : u ≠ 0 := by
    intro hu
    have hvSq : v ^ 2 = p := by simpa [hu] using hsum
    have hvPrime : (v ^ 2).Prime := by simpa [hvSq] using hp
    exact Nat.Prime.not_prime_pow (by norm_num) hvPrime
  exact Nat.pos_of_ne_zero hu

theorem twoSquare_right_pos
    {p u v : ℕ} (hp : p.Prime) (hsum : u ^ 2 + v ^ 2 = p) : 0 < v := by
  have hv : v ≠ 0 := by
    intro hv
    have huSq : u ^ 2 = p := by simpa [hv] using hsum
    have huPrime : (u ^ 2).Prime := by simpa [huSq] using hp
    exact Nat.Prime.not_prime_pow (by norm_num) huPrime
  exact Nat.pos_of_ne_zero hv

/-- The coordinates of a two-square representation of a prime are coprime. -/
theorem twoSquare_coprime
    {p u v : ℕ} (hp : p.Prime) (hsum : u ^ 2 + v ^ 2 = p) :
    u.Coprime v := by
  have huPos := twoSquare_left_pos hp hsum
  have hvPos := twoSquare_right_pos hp hsum
  have huLt : u < p := by
    have huLeSq : u ≤ u ^ 2 := by nlinarith
    have huSqLt : u ^ 2 < p := by nlinarith
    exact huLeSq.trans_lt huSqLt
  apply Nat.coprime_of_dvd
  intro q hq hqu hqv
  have hqp : q ∣ p := by
    rw [← hsum]
    exact Nat.dvd_add
      (dvd_pow hqu (by norm_num : 2 ≠ 0))
      (dvd_pow hqv (by norm_num : 2 ≠ 0))
  rcases (Nat.dvd_prime hp).mp hqp with hqOne | hqpEq
  · exact hq.ne_one hqOne
  · subst q
    have hpLeU := Nat.le_of_dvd huPos hqu
    omega

/-- For an odd prime represented by two squares, the coordinates have
opposite parity. -/
theorem twoSquare_oppositeParity
    {p u v : ℕ} (hp : p.Prime) (hpOdd : p ≠ 2)
    (hsum : u ^ 2 + v ^ 2 = p) :
    (Odd u ∧ Even v) ∨ (Even u ∧ Odd v) := by
  have hpIsOdd : Odd p := hp.odd_of_ne_two hpOdd
  rcases Nat.even_or_odd u with huEven | huOdd
  · rcases Nat.even_or_odd v with hvEven | hvOdd
    · have hsumEven : Even (u ^ 2 + v ^ 2) := by
        apply Even.add
        · simpa [pow_two] using huEven.mul_right u
        · simpa [pow_two] using hvEven.mul_right v
      rw [hsum] at hsumEven
      exact False.elim ((Nat.not_even_iff_odd.mpr hpIsOdd) hsumEven)
    · exact Or.inr ⟨huEven, hvOdd⟩
  · rcases Nat.even_or_odd v with hvEven | hvOdd
    · exact Or.inl ⟨huOdd, hvEven⟩
    · have hsumEven : Even (u ^ 2 + v ^ 2) :=
        huOdd.pow.add_odd hvOdd.pow
      rw [hsum] at hsumEven
      exact False.elim ((Nat.not_even_iff_odd.mpr hpIsOdd) hsumEven)

/-- Every prime congruent to one modulo four gives an ordered datum. -/
theorem primeHypotenuseDatum_exists
    {p : ℕ} (hp : p.Prime) (hmod : p % 4 = 1) :
    ∃ D : PrimeHypotenuseDatum, D.p = p := by
  letI : Fact p.Prime := ⟨hp⟩
  obtain ⟨u, v, hsum⟩ := Nat.Prime.sq_add_sq (p := p) (by omega)
  have huPos := twoSquare_left_pos hp hsum
  have hvPos := twoSquare_right_pos hp hsum
  have hcop := twoSquare_coprime hp hsum
  have hpOdd : p ≠ 2 := by omega
  have hpar := twoSquare_oppositeParity hp hpOdd hsum
  rcases lt_trichotomy u v with huv | huv | huv
  · refine ⟨{
      p := p
      m := v
      n := u
      prime := hp
      mod_four := hmod
      n_pos := huPos
      n_lt_m := huv
      coprime := hcop.symm
      oppositeParity := ?_
      sq_add_sq := ?_ }, rfl⟩
    · rcases hpar with h | h
      · exact Or.inr ⟨h.2, h.1⟩
      · exact Or.inl ⟨h.2, h.1⟩
    · simpa [add_comm] using hsum
  · subst v
    rcases hpar with h | h
    · exact False.elim ((Nat.not_even_iff_odd.mpr h.1) h.2)
    · exact False.elim ((Nat.not_even_iff_odd.mpr h.2) h.1)
  · refine ⟨{
      p := p
      m := u
      n := v
      prime := hp
      mod_four := hmod
      n_pos := hvPos
      n_lt_m := huv
      coprime := hcop
      oppositeParity := hpar
      sq_add_sq := hsum }, rfl⟩

/-- The prime-hypotenuse data are unbounded. -/
theorem exists_primeHypotenuseDatum_gt (N : ℕ) :
    ∃ D : PrimeHypotenuseDatum, N < D.p := by
  obtain ⟨p, hp, hNp, hmod⟩ :=
    Nat.exists_prime_gt_modEq_one (k := 4) N (by norm_num)
  have hmod' : p % 4 = 1 := by
    change p % 4 = 1 % 4 at hmod
    norm_num at hmod ⊢
    exact hmod
  obtain ⟨D, hDp⟩ := primeHypotenuseDatum_exists hp hmod'
  exact ⟨D, by simpa [hDp] using hNp⟩

namespace PrimeHypotenuseDatum

/-- The odd leg in Euclid's construction. -/
def X (D : PrimeHypotenuseDatum) : ℕ := D.m ^ 2 - D.n ^ 2

/-- The even leg in Euclid's construction. -/
def Y (D : PrimeHypotenuseDatum) : ℕ := 2 * D.m * D.n

theorem m_pos (D : PrimeHypotenuseDatum) : 0 < D.m :=
  lt_trans D.n_pos D.n_lt_m

theorem n_sq_lt_m_sq (D : PrimeHypotenuseDatum) : D.n ^ 2 < D.m ^ 2 := by
  exact Nat.pow_lt_pow_left D.n_lt_m (by norm_num)

theorem X_pos (D : PrimeHypotenuseDatum) : 0 < D.X := by
  unfold X
  exact Nat.sub_pos_of_lt D.n_sq_lt_m_sq

theorem Y_pos (D : PrimeHypotenuseDatum) : 0 < D.Y := by
  unfold Y
  exact Nat.mul_pos (Nat.mul_pos (by norm_num) D.m_pos) D.n_pos

theorem p_pos (D : PrimeHypotenuseDatum) : 0 < D.p := D.prime.pos

theorem p_ne_two (D : PrimeHypotenuseDatum) : D.p ≠ 2 := by
  have hmod := D.mod_four
  omega

theorem four_le_p (D : PrimeHypotenuseDatum) : 4 ≤ D.p := by
  have := D.prime.two_le
  have hmod := D.mod_four
  omega

theorem X_odd (D : PrimeHypotenuseDatum) : Odd D.X := by
  have hsq : D.n ^ 2 ≤ D.m ^ 2 := D.n_sq_lt_m_sq.le
  rcases D.oppositeParity with h | h
  · exact Nat.Odd.sub_even hsq h.1.pow (by
      simpa [pow_two] using h.2.mul_right D.n)
  · exact Nat.Even.sub_odd hsq (by
      simpa [pow_two] using h.1.mul_right D.m) h.2.pow

/-- The two Euclidean legs are coprime. -/
theorem X_coprime_Y (D : PrimeHypotenuseDatum) : D.X.Coprime D.Y := by
  have hsq : D.n ^ 2 ≤ D.m ^ 2 := D.n_sq_lt_m_sq.le
  have hpow : (D.m ^ 2).Coprime (D.n ^ 2) := D.coprime.pow 2 2
  have hXmSq : D.X.Coprime (D.m ^ 2) := by
    unfold X
    exact (Nat.coprime_self_sub_left hsq).mpr hpow.symm
  have hXnSq : D.X.Coprime (D.n ^ 2) := by
    unfold X
    exact (Nat.coprime_sub_self_left hsq).mpr hpow
  have hXm : D.X.Coprime D.m :=
    (Nat.coprime_pow_right_iff (by norm_num : 0 < 2) D.X D.m).mp hXmSq
  have hXn : D.X.Coprime D.n :=
    (Nat.coprime_pow_right_iff (by norm_num : 0 < 2) D.X D.n).mp hXnSq
  have hXtwo : D.X.Coprime 2 := D.X_odd.coprime_two_right
  simpa [Y, mul_assoc] using hXtwo.mul_right (hXm.mul_right hXn)

/-- Euclid's identity, with the prime hypotenuse substituted. -/
theorem pythagorean_identity (D : PrimeHypotenuseDatum) :
    D.X ^ 2 + D.Y ^ 2 = D.p ^ 2 := by
  have hsub : D.X + D.n ^ 2 = D.m ^ 2 := by
    unfold X
    exact Nat.sub_add_cancel D.n_sq_lt_m_sq.le
  unfold Y
  rw [← D.sq_add_sq]
  nlinarith

/-- Squaring the primitive Euclidean legs gives pairwise-coprime coordinates. -/
theorem square_point_pairwise (D : PrimeHypotenuseDatum) :
    PairwiseCoprimeABC (D.X ^ 2) (D.Y ^ 2) (D.p ^ 2) := by
  have hab : (D.X ^ 2).Coprime (D.Y ^ 2) := D.X_coprime_Y.pow 2 2
  have hbc : (D.Y ^ 2).Coprime (D.p ^ 2) := by
    rw [← D.pythagorean_identity]
    exact Nat.coprime_add_self_right.mpr hab.symm
  have hca : (D.p ^ 2).Coprime (D.X ^ 2) := by
    rw [← D.pythagorean_identity]
    exact Nat.coprime_self_add_left.mpr hab.symm
  exact ⟨hab, hbc, hca⟩

/-- The complete positive primitive abc point. -/
def point (D : PrimeHypotenuseDatum) : ABCPoint where
  a := D.X ^ 2
  b := D.Y ^ 2
  c := D.p ^ 2
  a_pos := pow_pos D.X_pos 2
  b_pos := pow_pos D.Y_pos 2
  c_pos := pow_pos D.p_pos 2
  sum_eq := D.pythagorean_identity
  pairwise_coprime := D.square_point_pairwise

@[simp] theorem point_a (D : PrimeHypotenuseDatum) : D.point.a = D.X ^ 2 := rfl
@[simp] theorem point_b (D : PrimeHypotenuseDatum) : D.point.b = D.Y ^ 2 := rfl
@[simp] theorem point_c (D : PrimeHypotenuseDatum) : D.point.c = D.p ^ 2 := rfl

theorem X_factorization (D : PrimeHypotenuseDatum) :
    D.X = (D.m + D.n) * (D.m - D.n) := by
  unfold X
  exact Nat.sq_sub_sq D.m D.n

theorem X_le_p (D : PrimeHypotenuseDatum) : D.X ≤ D.p := by
  unfold X
  rw [← D.sq_add_sq]
  omega

theorem Y_le_p (D : PrimeHypotenuseDatum) : D.Y ≤ D.p := by
  unfold Y
  rw [← D.sq_add_sq]
  nlinarith [sq_nonneg (D.m - D.n : ℤ)]

/-- Every external sink prime divides one of the unsquared Euclidean legs. -/
theorem endpointSinkPrime_dvd_X_or_Y
    (D : PrimeHypotenuseDatum)
    (q : PrimeSupportToken (D.point.a * D.point.b)) :
    q.1 ∣ D.X ∨ q.1 ∣ D.Y := by
  have hqPrime : q.1.Prime := Nat.prime_of_mem_primeFactors q.2
  have hqDvd : q.1 ∣ D.X ^ 2 * D.Y ^ 2 := by
    simpa using (Nat.mem_primeFactors.mp q.2).2.1
  rcases hqPrime.dvd_mul.mp hqDvd with hX | hY
  · exact Or.inl (hqPrime.dvd_of_dvd_pow hX)
  · exact Or.inr (hqPrime.dvd_of_dvd_pow hY)

/-- Every external sink prime is no larger than `m+n`. -/
theorem endpointSinkPrime_le_m_add_n
    (D : PrimeHypotenuseDatum)
    (q : PrimeSupportToken (D.point.a * D.point.b)) :
    q.1 ≤ D.m + D.n := by
  have hqPrime : q.1.Prime := Nat.prime_of_mem_primeFactors q.2
  rcases D.endpointSinkPrime_dvd_X_or_Y q with hX | hY
  · rw [D.X_factorization] at hX
    rcases hqPrime.dvd_mul.mp hX with hplus | hminus
    · exact Nat.le_of_dvd (Nat.add_pos_left D.m_pos D.n) hplus
    · exact (Nat.le_of_dvd (Nat.sub_pos_of_lt D.n_lt_m) hminus).trans
        (Nat.sub_le _ _ |>.trans (Nat.le_add_right D.m D.n))
  · change q.1 ∣ 2 * D.m * D.n at hY
    rw [mul_assoc] at hY
    rcases hqPrime.dvd_mul.mp hY with htwo | hmn
    · have htwoLe : 2 ≤ D.m + D.n := by
        have hm := D.m_pos
        have hn := D.n_pos
        omega
      exact (Nat.le_of_dvd (by norm_num) htwo).trans htwoLe
    · rcases hqPrime.dvd_mul.mp hmn with hm | hn
      · exact (Nat.le_of_dvd D.m_pos hm).trans (Nat.le_add_right _ _)
      · exact (Nat.le_of_dvd D.n_pos hn).trans (Nat.le_add_left _ _)

theorem m_add_n_sq_le_two_mul_p (D : PrimeHypotenuseDatum) :
    (D.m + D.n) ^ 2 ≤ 2 * D.p := by
  rw [← D.sq_add_sq]
  nlinarith [sq_nonneg (D.m - D.n : ℤ)]

/-- The fourth power of every external sink prime is at most `p^3`.  This
integer form avoids any square-root operation in the formal energy bound. -/
theorem endpointSinkPrime_fourth_le_p_cube
    (D : PrimeHypotenuseDatum)
    (q : PrimeSupportToken (D.point.a * D.point.b)) :
    q.1 ^ 4 ≤ D.p ^ 3 := by
  have hqSq : q.1 ^ 2 ≤ 2 * D.p :=
    (Nat.pow_le_pow_left (D.endpointSinkPrime_le_m_add_n q) 2).trans
      D.m_add_n_sq_le_two_mul_p
  calc
    q.1 ^ 4 = (q.1 ^ 2) ^ 2 := by ring
    _ ≤ (2 * D.p) ^ 2 := Nat.pow_le_pow_left hqSq 2
    _ = 4 * D.p ^ 2 := by ring
    _ = D.p ^ 2 * 4 := by ring
    _ ≤ D.p ^ 2 * D.p := Nat.mul_le_mul_left (D.p ^ 2) D.four_le_p
    _ = D.p ^ 3 := by ring

/-- Every endpoint source token has the unique key `p`. -/
theorem endpointSourcePrime_eq_p
    (D : PrimeHypotenuseDatum) (s : PrimeExcessToken D.point.c) :
    primeExcessTokenPrime s = D.p := by
  have hs := s.1.2
  change s.1.1 ∈ (D.p ^ 2).primeFactors at hs
  rw [Nat.primeFactors_prime_pow (by norm_num) D.prime] at hs
  simpa [primeExcessTokenPrime] using hs

/-- The endpoint core of `p^2` is exactly `p`. -/
theorem point_endpointCore_eq_p (D : PrimeHypotenuseDatum) :
    endpointCore D.point = D.p := by
  have hrad : abcRadical (D.p ^ 2) = D.p := by
    unfold abcRadical
    rw [Nat.primeFactors_prime_pow (by norm_num : 2 ≠ 0) D.prime]
    simp
  unfold endpointCore abcPowerfulPart
  change D.p ^ 2 / abcRadical (D.p ^ 2) = D.p
  rw [hrad, pow_two, Nat.mul_div_left D.p D.p_pos]

/-- The fourth-power comparison becomes `4 log q <= 3 log p`. -/
theorem four_log_endpointSinkPrime_le_three_log_p
    (D : PrimeHypotenuseDatum)
    (q : PrimeSupportToken (D.point.a * D.point.b)) :
    4 * Real.log (q.1 : ℝ) ≤ 3 * Real.log (D.p : ℝ) := by
  have hcast : ((q.1 : ℝ) ^ 4) ≤ (D.p : ℝ) ^ 3 := by
    exact_mod_cast D.endpointSinkPrime_fourth_le_p_cube q
  have hqPos : 0 < (q.1 : ℝ) := by
    exact_mod_cast (Nat.prime_of_mem_primeFactors q.2).pos
  have hlog := Real.log_le_log (pow_pos hqPos 4) hcast
  rw [Real.log_pow, Real.log_pow] at hlog
  norm_num at hlog ⊢
  exact hlog

/-- Every source-sink edge pays at least one quarter of its carried mass in
relative logarithmic downward displacement. -/
theorem quarter_le_endpoint_relativeLogDrop
    (D : PrimeHypotenuseDatum)
    (s : PrimeExcessToken D.point.c)
    (q : PrimeSupportToken (D.point.a * D.point.b)) :
    (1 / 4 : ℝ) ≤ relativeLogDrop
      (fun i : PrimeExcessToken D.point.c => primeExcessTokenPrime i)
      (fun j : PrimeSupportToken (D.point.a * D.point.b) =>
        primeSupportTokenPrime j) s q := by
  have hlogP : 0 < Real.log (D.p : ℝ) :=
    Real.log_pos (by exact_mod_cast D.prime.one_lt)
  have hlogQ := D.four_log_endpointSinkPrime_le_three_log_p q
  have hquot : (1 / 4 : ℝ) ≤
      (Real.log (D.p : ℝ) - Real.log (q.1 : ℝ)) /
        Real.log (D.p : ℝ) := by
    apply (le_div_iff₀ hlogP).2
    nlinarith
  rw [relativeLogDrop, D.endpointSourcePrime_eq_p s]
  exact hquot.trans (le_max_right _ _)

/-! ## Energy and conductor bounds -/

/-- Summing the pointwise edge bound charges one quarter of all carried
mass. -/
theorem quarter_mul_carriedMass_le_endpointDownwardCost
    (D : PrimeHypotenuseDatum) (F : EndpointBidirectionalFlow D.point) :
    (1 / 4 : ℝ) * F.carriedMass ≤ endpointDownwardCost F := by
  classical
  unfold MonotoneWeightedFlow.carriedMass endpointDownwardCost
    BidirectionalWeightedFlow.downwardCost
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro s _
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro q _
  have h := mul_le_mul_of_nonneg_left
    (D.quarter_le_endpoint_relativeLogDrop s q) (F.flow_nonneg s q)
  simpa [mul_comm, mul_left_comm] using h

/-- Every bidirectional endpoint flow on the prime-hypotenuse point has
energy at least one quarter of `log p`. -/
theorem quarter_log_p_le_endpointBidirectionalEnergy
    (D : PrimeHypotenuseDatum) (F : EndpointBidirectionalFlow D.point) :
    (1 / 4 : ℝ) * Real.log (D.p : ℝ) ≤ endpointBidirectionalEnergy F := by
  have hsource : F.sourceMass = Real.log (D.p : ℝ) := by
    rw [endpointBidirectionalFlow_sourceMass_eq_log_core D.point F,
      D.point_endpointCore_eq_p]
  have hcarried : F.carriedMass ≤ Real.log (D.p : ℝ) := by
    have h := F.toUnorderedMassRelaxation.carried_le_source
    change F.carriedMass ≤ F.sourceMass at h
    exact h.trans_eq hsource
  have hunmatched := F.unmatchedMass_eq_sourceMass_sub_carriedMass
  rw [hsource] at hunmatched
  have hcost := D.quarter_mul_carriedMass_le_endpointDownwardCost F
  unfold endpointBidirectionalEnergy
  rw [hunmatched]
  nlinarith

/-- The total radical is at most the cube of the prime hypotenuse. -/
theorem point_totalRadical_le_p_cube (D : PrimeHypotenuseDatum) :
    totalRadical D.point ≤ D.p ^ 3 := by
  let P := D.point
  unfold totalRadical
  rw [P.abcRadical_abcProduct]
  change abcRadical (D.X ^ 2) * abcRadical (D.Y ^ 2) *
      abcRadical (D.p ^ 2) ≤ D.p ^ 3
  calc
    abcRadical (D.X ^ 2) * abcRadical (D.Y ^ 2) *
          abcRadical (D.p ^ 2) ≤ D.X * D.Y * D.p := by
      exact Nat.mul_le_mul
        (Nat.mul_le_mul
          (abcRadical_square_le_base D.X D.X_pos)
          (abcRadical_square_le_base D.Y D.Y_pos))
        (abcRadical_square_le_base D.p D.p_pos)
    _ ≤ D.p * D.p * D.p :=
      Nat.mul_le_mul (Nat.mul_le_mul D.X_le_p D.Y_le_p) le_rfl
    _ = D.p ^ 3 := by ring

/-- The logarithmic conductor is at most `3 log p`. -/
theorem point_conductor_le_three_log_p (D : PrimeHypotenuseDatum) :
    D.point.conductor ≤ 3 * Real.log (D.p : ℝ) := by
  have hrad := D.point_totalRadical_le_p_cube
  have hcast : (totalRadical D.point : ℝ) ≤ (D.p : ℝ) ^ 3 := by
    exact_mod_cast hrad
  have hlog := Real.log_le_log (by exact_mod_cast totalRadical_pos D.point) hcast
  change Real.log (totalRadical D.point : ℝ) ≤ 3 * Real.log (D.p : ℝ)
  simpa [Real.log_pow] using hlog

end PrimeHypotenuseDatum

/-! ## Infinite complete-premise refutation -/

/-- The exact bidirectional relative-drop energy gate is false. -/
theorem not_uniformBidirectionalEndpointEnergyBound :
    ¬ UniformBidirectionalEndpointEnergyBound := by
  intro hgate
  obtain ⟨C, hC⟩ := hgate (1 / 24 : ℝ) (by norm_num)
  obtain ⟨N, hN⟩ := exists_nat_gt (Real.exp (8 * C))
  obtain ⟨D, hND⟩ := exists_primeHypotenuseDatum_gt N
  have hExp : Real.exp (8 * C) < (D.p : ℝ) := by
    exact hN.trans (by exact_mod_cast hND)
  have hlogLarge : 8 * C < Real.log (D.p : ℝ) :=
    (Real.lt_log_iff_exp_lt (by exact_mod_cast D.p_pos)).2 hExp
  obtain ⟨F, hF⟩ := hC D.point
  have henergy := D.quarter_log_p_le_endpointBidirectionalEnergy F
  have hcond := D.point_conductor_le_three_log_p
  norm_num at hF
  nlinarith

end ABCBidirectionalEnergyPythagoreanObstruction20260903
end
end IUTThreeClosures
