/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LegendreTwoInertiaSL2

/-!
# An explicitly bounded prime avoiding two inertia exponents

For a lower threshold `B` and positive natural exponents `m₁,m₂`, set

`N = B! * (m₁*m₂) + 1`.

Every prime divisor `ell` of `N` satisfies

* `B < ell`;
* `ell ∤ m₁*m₂`;
* `ell ≤ N`.

Indeed, any prime at most `B` divides `B!`, while any prime dividing `m₁*m₂`
also divides the product preceding the final `+1`; either possibility would
make it divide one.  This gives a fully elementary quantitative replacement
for controlling a complete Serre exceptional set, once two actual local
inertia directions are available.
-/

namespace IUTThreeClosures

/-- The Euclidean integer used to select a prime avoiding both local inertia
exponents. -/
def twoInertiaAvoidanceInteger (B m₁ m₂ : ℕ) : ℕ :=
  B.factorial * (m₁ * m₂) + 1

/-- A prime selected from the two-inertia avoidance integer. -/
structure TwoInertiaPrimeData (B m₁ m₂ : ℕ) where
  ell : ℕ
  ell_prime : ell.Prime
  threshold_lt : B < ell
  avoids_product : ¬ ell ∣ m₁ * m₂
  ell_le : ell ≤ twoInertiaAvoidanceInteger B m₁ m₂

private theorem not_dvd_product_of_dvd_add_one
    {p M : ℕ}
    (hp : p.Prime)
    (hpd : p ∣ M + 1) :
    ¬ p ∣ M := by
  intro hpM
  have hmodSum : (M + 1) % p = 0 := Nat.dvd_iff_mod_eq_zero.mp hpd
  have hmodM : M % p = 0 := Nat.dvd_iff_mod_eq_zero.mp hpM
  have hmodOne : 1 % p = 0 := by
    simpa [Nat.add_mod, hmodM] using hmodSum
  have honeMod : 1 % p = 1 := Nat.mod_eq_of_lt hp.one_lt
  omega

/-- The avoidance integer is strictly larger than one for positive local
exponents. -/
theorem one_lt_twoInertiaAvoidanceInteger
    (B m₁ m₂ : ℕ)
    (hm₁ : 0 < m₁) (hm₂ : 0 < m₂) :
    1 < twoInertiaAvoidanceInteger B m₁ m₂ := by
  have hfac : 0 < B.factorial := Nat.factorial_pos B
  have hprod : 0 < m₁ * m₂ := Nat.mul_pos hm₁ hm₂
  unfold twoInertiaAvoidanceInteger
  have hmul : 0 < B.factorial * (m₁ * m₂) := Nat.mul_pos hfac hprod
  omega

/-- **Explicit two-inertia prime selector.** -/
theorem exists_twoInertiaPrimeData
    (B m₁ m₂ : ℕ)
    (hm₁ : 0 < m₁) (hm₂ : 0 < m₂) :
    Nonempty (TwoInertiaPrimeData B m₁ m₂) := by
  let N := twoInertiaAvoidanceInteger B m₁ m₂
  have hNgt : 1 < N := by
    dsimp [N]
    exact one_lt_twoInertiaAvoidanceInteger B m₁ m₂ hm₁ hm₂
  have hNne : N ≠ 1 := Nat.ne_of_gt hNgt
  rcases Nat.exists_prime_and_dvd hNne with ⟨ell, hellPrime, hellN⟩
  have hNpos : 0 < N := lt_trans Nat.zero_lt_one hNgt
  have hellLe : ell ≤ N := Nat.le_of_dvd hNpos hellN
  have havoidsFull : ¬ ell ∣ B.factorial * (m₁ * m₂) := by
    dsimp [N, twoInertiaAvoidanceInteger] at hellN
    exact not_dvd_product_of_dvd_add_one hellPrime hellN
  have havoidsProduct : ¬ ell ∣ m₁ * m₂ := by
    intro h
    exact havoidsFull (dvd_mul_of_dvd_right h B.factorial)
  have hthreshold : B < ell := by
    by_contra hnot
    have hellB : ell ≤ B := Nat.le_of_not_gt hnot
    have hellFac : ell ∣ B.factorial :=
      Nat.dvd_factorial hellPrime.pos hellB
    have hellFull : ell ∣ B.factorial * (m₁ * m₂) :=
      dvd_mul_of_dvd_left hellFac (m₁ * m₂)
    exact havoidsFull hellFull
  exact ⟨{
    ell := ell
    ell_prime := hellPrime
    threshold_lt := hthreshold
    avoids_product := havoidsProduct
    ell_le := hellLe
  }⟩

namespace TwoInertiaPrimeData

/-- The selected prime avoids the first local exponent. -/
theorem avoids_first
    {B m₁ m₂ : ℕ}
    (D : TwoInertiaPrimeData B m₁ m₂) :
    ¬ D.ell ∣ m₁ := by
  intro h
  exact D.avoids_product (dvd_mul_of_dvd_left h m₂)

/-- The selected prime avoids the second local exponent. -/
theorem avoids_second
    {B m₁ m₂ : ℕ}
    (D : TwoInertiaPrimeData B m₁ m₂) :
    ¬ D.ell ∣ m₂ := by
  intro h
  exact D.avoids_product (dvd_mul_of_dvd_right h m₁)

/-- The displayed explicit upper bound. -/
theorem explicit_upper_bound
    {B m₁ m₂ : ℕ}
    (D : TwoInertiaPrimeData B m₁ m₂) :
    D.ell ≤ B.factorial * (m₁ * m₂) + 1 :=
  D.ell_le

end TwoInertiaPrimeData

end IUTThreeClosures
