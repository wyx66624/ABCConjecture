/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.CyclotomicTwelveOrderCore

/-!
# A twelfth-cyclotomic auxiliary-prime selector

For

`Phi12(M) = M^4 - M^2 + 1`,

a prime divisor of `Phi12(M)` has exact multiplicative order twelve modulo the
prime whenever `6 ∣ M`.  Consequently the selected prime is congruent to one
modulo twelve.

Taking

`M = 6 * B! * m1 * m2`

simultaneously gives:

* the prime is strictly above `B`;
* it divides neither prescribed positive local exponent;
* `12 ∣ ell - 1`;
* it is bounded by `Phi12(M) ≤ M^4 + 1`.

This aligns the two-local-inertia prime selection with the integral Legendre
discriminant power `Delta^((ell-1)/12)`.
-/

namespace IUTThreeClosures

/-- The natural-number value of the twelfth cyclotomic polynomial. -/
def cyclotomicTwelveNat (M : ℕ) : ℕ :=
  M ^ 4 - M ^ 2 + 1

/-- Casting the natural cyclotomic value into `ZMod p` gives the expected
polynomial expression. -/
theorem cast_cyclotomicTwelveNat
    {p M : ℕ} (hM : 1 ≤ M) :
    ((cyclotomicTwelveNat M : ℕ) : ZMod p) =
      (M : ZMod p) ^ 4 - (M : ZMod p) ^ 2 + 1 := by
  have hle : M ^ 2 ≤ M ^ 4 := by
    nlinarith [Nat.one_le_pow 2 hM]
  simp [cyclotomicTwelveNat, Nat.cast_sub hle]

/-- A natural divisor of the cyclotomic value becomes zero modulo that
divisor. -/
theorem cast_cyclotomicTwelveNat_eq_zero_of_dvd
    {p M : ℕ}
    (hdiv : p ∣ cyclotomicTwelveNat M) :
    ((cyclotomicTwelveNat M : ℕ) : ZMod p) = 0 := by
  rcases hdiv with ⟨k, hk⟩
  subst hk
  simp

/-- The cyclotomic value is positive for a positive input. -/
theorem cyclotomicTwelveNat_pos
    {M : ℕ} (hM : 1 ≤ M) :
    0 < cyclotomicTwelveNat M := by
  unfold cyclotomicTwelveNat
  omega

/-- The cyclotomic value is at least two once the input is at least two. -/
theorem cyclotomicTwelveNat_two_le
    {M : ℕ} (hM : 2 ≤ M) :
    2 ≤ cyclotomicTwelveNat M := by
  unfold cyclotomicTwelveNat
  have hlt : M ^ 2 < M ^ 4 := by
    nlinarith [Nat.one_le_pow 2 hM]
  omega

/-- Elementary polynomial upper bound used by the quantitative selector. -/
theorem cyclotomicTwelveNat_le_fourth_add_one (M : ℕ) :
    cyclotomicTwelveNat M ≤ M ^ 4 + 1 := by
  unfold cyclotomicTwelveNat
  omega

/-- A prime divisor of `Phi12(M)`, with `6 ∣ M`, does not divide `M` and is
congruent to one modulo twelve. -/
theorem prime_cyclotomicTwelve_package
    {p M : ℕ}
    (hp : p.Prime)
    (hMpos : 0 < M)
    (hSixM : 6 ∣ M)
    (hdiv : p ∣ cyclotomicTwelveNat M) :
    ¬ p ∣ M ∧ 12 ∣ p - 1 := by
  letI : Fact p.Prime := ⟨hp⟩
  let x : ZMod p := M
  have hphi : x ^ 4 - x ^ 2 + 1 = 0 := by
    calc
      x ^ 4 - x ^ 2 + 1 =
          ((cyclotomicTwelveNat M : ℕ) : ZMod p) := by
        symm
        exact cast_cyclotomicTwelveNat (p := p) hMpos
      _ = 0 := cast_cyclotomicTwelveNat_eq_zero_of_dvd hdiv
  have hx : x ≠ 0 := by
    intro hx0
    have hone : (1 : ZMod p) = 0 := by
      simpa [x, hx0] using hphi
    exact one_ne_zero hone
  have hpM : ¬ p ∣ M := by
    intro h
    rcases h with ⟨k, rfl⟩
    simp [x] at hx
  have hTwoM : 2 ∣ M := dvd_trans (by norm_num) hSixM
  have hThreeM : 3 ∣ M := dvd_trans (by norm_num) hSixM
  have hpTwo : p ≠ 2 := by
    intro h
    subst p
    exact hpM hTwoM
  have hpThree : p ≠ 3 := by
    intro h
    subst p
    exact hpM hThreeM
  have hnegOne : (-1 : ZMod p) ≠ 1 := by
    intro h
    have htwo : (2 : ZMod p) = 0 := by
      calc
        (2 : ZMod p) = 1 + 1 := by norm_num
        _ = (-1) + 1 := by rw [h]
        _ = 0 := by ring
    have hpdiv : p ∣ 2 :=
      (ZMod.natCast_eq_zero_iff_dvd).mp htwo
    have hple : p ≤ 2 := Nat.le_of_dvd (by norm_num) hpdiv
    omega
  have htwoNeg : (2 : ZMod p) ≠ -1 := by
    intro h
    have hthree : (3 : ZMod p) = 0 := by
      calc
        (3 : ZMod p) = 2 + 1 := by norm_num
        _ = (-1) + 1 := by rw [h]
        _ = 0 := by ring
    have hpdiv : p ∣ 3 :=
      (ZMod.natCast_eq_zero_iff_dvd).mp hthree
    have hple : p ≤ 3 := Nat.le_of_dvd (by norm_num) hpdiv
    omega
  have hid :
      (x ^ 4 - x ^ 2 + 1) * (x ^ 2 + 1) = x ^ 6 + 1 := by
    ring
  have hx6sum : x ^ 6 + 1 = 0 := by
    rw [← hid, hphi, zero_mul]
  have hx6 : x ^ 6 = -1 := by
    calc
      x ^ 6 = (x ^ 6 + 1) - 1 := by ring
      _ = -1 := by rw [hx6sum]; ring
  have hx12 : x ^ 12 = 1 := by
    calc
      x ^ 12 = (x ^ 6) ^ 2 := by ring
      _ = (-1) ^ 2 := by rw [hx6]
      _ = 1 := by ring
  have hx4ne : x ^ 4 ≠ 1 := by
    intro hx4
    have hx2 : x ^ 2 = 2 := by
      linear_combination hphi - hx4
    have hx6two : x ^ 6 = 2 := by
      calc
        x ^ 6 = x ^ 4 * x ^ 2 := by ring
        _ = 1 * 2 := by rw [hx4, hx2]
        _ = 2 := by ring
    exact htwoNeg (hx6two.symm.trans hx6)
  let u : (ZMod p)ˣ := Units.mk0 x hx
  have hu12 : u ^ 12 = 1 := by
    apply Units.ext
    exact hx12
  have hu6ne : u ^ 6 ≠ 1 := by
    intro hu6
    have : x ^ 6 = 1 := congrArg Units.val hu6
    exact hnegOne (hx6.symm.trans this)
  have hu4ne : u ^ 4 ≠ 1 := by
    intro hu4
    apply hx4ne
    exact congrArg Units.val hu4
  have hxFermat : x ^ (p - 1) = 1 :=
    ZMod.pow_card_sub_one_eq_one x hx
  have huFermat : u ^ (p - 1) = 1 := by
    apply Units.ext
    exact hxFermat
  have hdiv12 : 12 ∣ p - 1 :=
    twelve_dvd_of_pow_eq_one u hu12 hu6ne hu4ne huFermat
  exact ⟨hpM, hdiv12⟩

/-- Threshold, avoidance, congruence and size package for a chosen prime
divisor. -/
theorem prime_cyclotomicTwelve_threshold
    {p M B m1 m2 : ℕ}
    (hp : p.Prime)
    (hMpos : 0 < M)
    (hSixM : 6 ∣ M)
    (hBM : B ! ∣ M)
    (hm1M : m1 ∣ M)
    (hm2M : m2 ∣ M)
    (hdiv : p ∣ cyclotomicTwelveNat M) :
    B < p ∧
      ¬ p ∣ m1 ∧
      ¬ p ∣ m2 ∧
      12 ∣ p - 1 ∧
      p ≤ cyclotomicTwelveNat M := by
  have hpack :=
    prime_cyclotomicTwelve_package hp hMpos hSixM hdiv
  have hpM := hpack.1
  have hpB : B < p := by
    by_contra h
    have hple : p ≤ B := by omega
    have hpfact : p ∣ B ! := hp.dvd_factorial hple
    exact hpM (dvd_trans hpfact hBM)
  have hpM1 : ¬ p ∣ m1 := by
    intro h
    exact hpM (dvd_trans h hm1M)
  have hpM2 : ¬ p ∣ m2 := by
    intro h
    exact hpM (dvd_trans h hm2M)
  have hpphi : p ≤ cyclotomicTwelveNat M :=
    Nat.le_of_dvd (cyclotomicTwelveNat_pos hMpos) hdiv
  exact ⟨hpB, hpM1, hpM2, hpack.2, hpphi⟩

/-- Complete existence theorem for the explicit input
`M = 6 * B! * m1 * m2`. -/
theorem exists_cyclotomicTwelve_auxiliary_prime
    (B m1 m2 : ℕ)
    (hm1 : 0 < m1)
    (hm2 : 0 < m2) :
    ∃ p : ℕ,
      p.Prime ∧
      B < p ∧
      ¬ p ∣ m1 ∧
      ¬ p ∣ m2 ∧
      12 ∣ p - 1 ∧
      p ≤ cyclotomicTwelveNat (6 * B ! * m1 * m2) ∧
      p ≤ (6 * B ! * m1 * m2) ^ 4 + 1 := by
  let M := 6 * B ! * m1 * m2
  have hMtwo : 2 ≤ M := by
    dsimp [M]
    have hfact : 0 < B ! := Nat.factorial_pos B
    positivity
  obtain ⟨p, hp, hdiv⟩ :=
    Nat.exists_prime_and_dvd (cyclotomicTwelveNat_two_le hMtwo)
  have hMpos : 0 < M := lt_of_lt_of_le (by norm_num) hMtwo
  have hSixM : 6 ∣ M := by
    dsimp [M]
    exact dvd_mul_right 6 (B ! * m1 * m2)
  have hBM : B ! ∣ M := by
    dsimp [M]
    use 6 * m1 * m2
    ring
  have hm1M : m1 ∣ M := by
    dsimp [M]
    use 6 * B ! * m2
    ring
  have hm2M : m2 ∣ M := by
    dsimp [M]
    use 6 * B ! * m1
    ring
  have hpack :=
    prime_cyclotomicTwelve_threshold
      hp hMpos hSixM hBM hm1M hm2M hdiv
  refine ⟨p, hp, hpack.1, hpack.2.1, hpack.2.2.1,
    hpack.2.2.2.1, hpack.2.2.2.2, ?_⟩
  exact hpack.2.2.2.2.trans (cyclotomicTwelveNat_le_fourth_add_one M)

end IUTThreeClosures
