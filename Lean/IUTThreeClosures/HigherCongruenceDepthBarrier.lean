import IUTThreeClosures.GeneralizedFermatExponentLayers

/-!
# Higher congruence depth: exact arithmetic and aggregation barriers

For multiplicative reduction away from the residual characteristic, the
Tate-curve inertia calculation tests divisibility of the minimal
discriminant exponent by `ell^k`.  This file formalizes the complete
elementary arithmetic shadow of that calculation for the Frey curve.

It also records two strict aggregation obstructions.

* Simultaneous removal at many places retains the same depth; repeated local
  congruences at one prime do not multiply their moduli.
* The primitive family `(3^(m+1), 2, 3^(m+1)+2)` has Frey discriminant
  exponent `2(m+1)` at `3`, while the node tangent parameter `2` is a
  nonsquare modulo `3`.  On paper this is nonsplit multiplicative type
  `I_(2(m+1))`, whose rational Tamagawa number is always `2`.

The local Tate representation, Kodaira classification, Tamagawa theorem,
modularity, level lowering, congruence modules, modular degrees, and Sturm
theorem are not postulated here.  No abc or Szpiro estimate occurs as an
assumption or structure field.
-/

namespace IUTThreeClosures

open scoped BigOperators

/-! ## Arithmetic shadow of higher-depth level lowering -/

/-- The divisibility condition detected by an `ell^k`-torsion monodromy
class with multiplicative exponent `e`. -/
def higherDepthCondition (ell k e : ℕ) : Prop :=
  ell ^ k ∣ e

/-- Simultaneous disappearance of a finite collection of multiplicative
monodromy exponents at depth `ell^k`. -/
def simultaneousHigherDepthCondition
    {ι : Type*} (ell k : ℕ) (s : Finset ι) (e : ι → ℕ) : Prop :=
  ∀ i ∈ s, higherDepthCondition ell k (e i)

namespace ABCPoint

/-- At every odd Frey place and for every odd residual prime, the full
prime-power depth in the discriminant exponent is exactly the prime-power
depth in the corresponding exponent of `abc`. -/
theorem oddPrimePower_dvd_freyDeltaExponent_iff
    (P : ABCPoint) {p ell k : ℕ}
    (hp : p.Prime) (hp_ne_two : p ≠ 2)
    (hell : ell.Prime) (hell_ne_two : ell ≠ 2) :
    ell ^ k ∣ P.freyDeltaNat.factorization p ↔
      ell ^ k ∣ (P.a * P.b * P.c).factorization p := by
  rw [P.freyDeltaNat_factorization_at_oddPrime hp hp_ne_two]
  have hell_not_dvd_two : ¬ ell ∣ 2 := by
    intro hdiv
    rcases (Nat.dvd_prime Nat.prime_two).mp hdiv with hell_one | hell_two
    · exact hell.ne_one hell_one
    · exact hell_ne_two hell_two
  have hcoprime : Nat.Coprime (ell ^ k) 2 :=
    (hell.coprime_iff_not_dvd.mpr hell_not_dvd_two).pow_left k
  exact hcoprime.dvd_mul_left

end ABCPoint

/-! ## Depth across several removed places is a minimum, not a sum -/

noncomputable section FiniteDepth

variable {ι : Type*}

/-- A constant local monodromy exponent `ell^k` passes the depth-`k` test at
arbitrarily many places. -/
theorem constantDepth_simultaneous
    (ell k : ℕ) (s : Finset ι) :
    simultaneousHigherDepthCondition ell k s (fun _ => ell ^ k) := by
  intro i hi
  exact dvd_rfl

/-- Adding more places of the same depth does not create one extra power of
`ell`: for a nonempty collection, depth `k+1` already fails. -/
theorem constantDepth_next_fails
    {ell k : ℕ} (hell : ell.Prime)
    (s : Finset ι) (hs : s.Nonempty) :
    ¬ simultaneousHigherDepthCondition ell (k + 1) s
      (fun _ => ell ^ k) := by
  intro hnext
  obtain ⟨i, hi⟩ := hs
  have hdiv := hnext i hi
  unfold higherDepthCondition at hdiv
  rw [Nat.pow_dvd_pow_iff_le_right hell.one_lt] at hdiv
  omega

end FiniteDepth

/-- Repeating the same depth `k` `r >= 2` times does not justify multiplying
the modulus to depth `k*r`.  Congruences at the same residual prime require
an independence theorem before lengths may be added. -/
theorem repeatedSameDepth_not_multiplicative
    {ell k r : ℕ} (hell : ell.Prime) (hk : 0 < k) (hr : 2 ≤ r) :
    ¬ (ell ^ k) ^ r ∣ ell ^ k := by
  rw [← pow_mul, Nat.pow_dvd_pow_iff_le_right hell.one_lt]
  intro hle
  have htwo : k * 2 ≤ k * r := Nat.mul_le_mul_left k hr
  have hlt : k < k * 2 := by omega
  omega

/-- The same fixed local depth can be attached to an arbitrarily large
support prime.  Thus the depth datum alone contains no support-prime weight. -/
theorem fixedDepth_with_arbitrarilyLarge_supportPrime
    (ell k B : ℕ) (hell : ell.Prime) :
    ∃ p : ℕ, p.Prime ∧ B < p ∧
      higherDepthCondition ell k (ell ^ k) ∧
      ¬ higherDepthCondition ell (k + 1) (ell ^ k) ∧
      B < ell ^ k * p := by
  obtain ⟨p, hpB, hp⟩ := Nat.exists_infinite_primes (B + 1)
  refine ⟨p, hp, by omega, dvd_rfl, ?_, ?_⟩
  · unfold higherDepthCondition
    rw [Nat.pow_dvd_pow_iff_le_right hell.one_lt]
    omega
  · have hpow : 1 ≤ ell ^ k := Nat.one_le_pow k ell hell.pos
    have hp_le : p ≤ ell ^ k * p := by
      simpa using Nat.mul_le_mul_right p hpow
    omega

/-! ## An actual primitive Frey family with nonsplit tangent cone at `3` -/

/-- The primitive endpoint family
`(a,b,c)=(3^(m+1),2,3^(m+1)+2)`. -/
def nonsplitThreeFreyPoint (m : ℕ) : ABCPoint where
  a := 3 ^ (m + 1)
  b := 2
  c := 3 ^ (m + 1) + 2
  a_pos := pow_pos (by norm_num) _
  b_pos := by norm_num
  c_pos := by positivity
  sum_eq := rfl
  pairwise_coprime := by
    have ha2 : Nat.Coprime (3 ^ (m + 1)) 2 :=
      (by norm_num : Nat.Coprime 3 2).pow_left (m + 1)
    have h2c : Nat.Coprime 2 (3 ^ (m + 1) + 2) := by
      rw [Nat.coprime_add_self_right]
      exact ha2.symm
    have hca : Nat.Coprime (3 ^ (m + 1) + 2) (3 ^ (m + 1)) := by
      rw [show 3 ^ (m + 1) + 2 = 2 + 3 ^ (m + 1) by omega,
        Nat.coprime_add_self_left]
      exact ha2.symm
    exact ⟨ha2, h2c, hca⟩

@[simp] theorem nonsplitThreeFreyPoint_a (m : ℕ) :
    (nonsplitThreeFreyPoint m).a = 3 ^ (m + 1) := rfl

@[simp] theorem nonsplitThreeFreyPoint_b (m : ℕ) :
    (nonsplitThreeFreyPoint m).b = 2 := rfl

@[simp] theorem nonsplitThreeFreyPoint_c (m : ℕ) :
    (nonsplitThreeFreyPoint m).c = 3 ^ (m + 1) + 2 := rfl

/-- The third term is a unit at `3`. -/
theorem three_not_dvd_nonsplitThreeFreyPoint_c (m : ℕ) :
    ¬ 3 ∣ (nonsplitThreeFreyPoint m).c := by
  simp only [nonsplitThreeFreyPoint_c]
  intro hdiv
  have hpow : 3 ∣ 3 ^ (m + 1) := dvd_pow_self 3 (by omega)
  have htwo : 3 ∣ 2 := (Nat.dvd_add_iff_right hpow).2 hdiv
  norm_num at htwo

/-- The exponent of `3` in the abc product is exactly `m+1`. -/
theorem nonsplitThreeFreyPoint_abc_factorization_three (m : ℕ) :
    ((nonsplitThreeFreyPoint m).a *
      (nonsplitThreeFreyPoint m).b *
      (nonsplitThreeFreyPoint m).c).factorization 3 = m + 1 := by
  have ha0 : 3 ^ (m + 1) ≠ 0 := pow_ne_zero _ (by norm_num)
  have hab0 : 3 ^ (m + 1) * 2 ≠ 0 := mul_ne_zero ha0 (by norm_num)
  have hc0 : 3 ^ (m + 1) + 2 ≠ 0 := by positivity
  have h3c : ¬ 3 ∣ 3 ^ (m + 1) + 2 := by
    simpa using three_not_dvd_nonsplitThreeFreyPoint_c m
  rw [nonsplitThreeFreyPoint_a, nonsplitThreeFreyPoint_b,
    nonsplitThreeFreyPoint_c,
    Nat.factorization_mul hab0 hc0,
    Nat.factorization_mul ha0 (by norm_num)]
  simp only [Finsupp.add_apply]
  rw [Nat.factorization_pow_self Nat.prime_three,
    Nat.factorization_eq_zero_of_not_dvd (by norm_num : ¬ 3 ∣ 2),
    Nat.factorization_eq_zero_of_not_dvd h3c]

/-- Accordingly, the Frey discriminant exponent at `3` is `2(m+1)`. -/
theorem nonsplitThreeFreyPoint_freyDelta_factorization_three (m : ℕ) :
    (nonsplitThreeFreyPoint m).freyDeltaNat.factorization 3 =
      2 * (m + 1) := by
  rw [(nonsplitThreeFreyPoint m).freyDeltaNat_factorization_at_oddPrime
      Nat.prime_three (by norm_num),
    nonsplitThreeFreyPoint_abc_factorization_three]

/-- The discriminant exponent in the family is unbounded. -/
theorem nonsplitThreeFreyPoint_freyDeltaExponent_unbounded (B : ℕ) :
    B < (nonsplitThreeFreyPoint B).freyDeltaNat.factorization 3 := by
  rw [nonsplitThreeFreyPoint_freyDelta_factorization_three]
  omega

/-- Two is not a square modulo three.  This is the finite-field arithmetic
input showing that the node tangent cone `y^2-2x^2` does not split. -/
theorem two_not_square_mod_three (x : ℕ) :
    x ^ 2 % 3 ≠ 2 := by
  have hxlt : x % 3 < 3 := Nat.mod_lt x (by norm_num)
  have hcases : x % 3 = 0 ∨ x % 3 = 1 ∨ x % 3 = 2 := by omega
  rcases hcases with hzero | hone | htwo
  · simp [Nat.pow_mod, hzero]
  · simp [Nat.pow_mod, hone]
  · simp [Nat.pow_mod, htwo]

/-! ## The exact coefficient threshold behind a higher-depth Sturm step -/

/-- A natural coefficient difference divisible by a modulus larger than its
absolute bound must vanish.  In the number-field application the modulus is
`ell^(f*k)` after taking norms. -/
theorem coefficient_eq_zero_of_modulus_dvd_of_lt
    {M D : ℕ} (hdiv : M ∣ D) (hlt : D < M) :
    D = 0 := by
  rcases hdiv with ⟨q, rfl⟩
  by_cases hq : q = 0
  · simp [hq]
  · have hMpos : 0 < M := by omega
    have hqpos : 0 < q := Nat.pos_of_ne_zero hq
    have hle : M ≤ M * q := Nat.le_mul_of_pos_right M hqpos
    omega

/-! ## A strict coefficient-only barrier for higher level raising -/

/-- The numerical information available from a rational higher level-raising
coefficient: the trace proxy has Weil-square size and the monodromy exponent
divides the signed Frobenius difference. -/
def HigherLevelRaisingNumerics (p e A : ℕ) : Prop :=
  A ≤ p + 1 ∧ A ^ 2 ≤ 4 * p ∧ e ∣ p + 1 - A

/-- As a purely numerical observation, the coefficient conditions permit the
exponent to equal the support prime: take trace proxy `A=1` and `e=p`.
This example is not used as an away-from-`p` residual representation. -/
theorem higherLevelRaisingNumerics_linear_example
    {p : ℕ} (hp : 0 < p) :
    HigherLevelRaisingNumerics p p 1 := by
  constructor
  · omega
  constructor
  · norm_num
    omega
  · simp

/-- A prime divisor of `p-2` is an odd residual prime different from the
support prime `p`, provided `p` is prime and larger than two. -/
theorem primeDivisor_sub_two_is_away
    {p ell : ℕ} (hp : p.Prime) (hp_two : 2 < p)
    (hell : ell.Prime) (hdiv : ell ∣ p - 2) :
    ell ≠ 2 ∧ ell ≠ p := by
  constructor
  · intro hell_two
    subst ell
    have htwo_dvd_p : 2 ∣ p := by
      have hsum : 2 ∣ (p - 2) + 2 := dvd_add hdiv (dvd_refl 2)
      rw [Nat.sub_add_cancel (by omega : 2 ≤ p)] at hsum
      exact hsum
    rcases (Nat.dvd_prime hp).mp htwo_dvd_p with htwo_one | htwo_p
    · omega
    · omega
  · intro hell_p
    subst ell
    have hp_sub_pos : 0 < p - 2 := by omega
    have hp_le : p ≤ p - 2 := Nat.le_of_dvd hp_sub_pos hdiv
    omega

/-- The same linear obstruction exists entirely away from the support
characteristic: use trace proxy `A=3` and exponent `e=p-2`. -/
theorem higherLevelRaisingNumerics_away_linear_example
    {p : ℕ} (hp_two : 2 < p) :
    HigherLevelRaisingNumerics p (p - 2) 3 := by
  constructor
  · omega
  constructor
  · nlinarith
  · have hsub : p + 1 - 3 = p - 2 := by omega
    rw [hsub]

/-- Hence no square-root-type bound can follow from divisibility and the
Weil-size condition alone, even when every residual prime dividing the
exponent is odd and different from the support prime. -/
theorem higherLevelRaisingNumerics_no_uniform_sqrt_bound
    (C : ℕ) :
    ∃ p : ℕ, p.Prime ∧ HigherLevelRaisingNumerics p (p - 2) 3 ∧
      C * p < (p - 2) ^ 2 ∧
      ∀ ell : ℕ, ell.Prime → ell ∣ p - 2 → ell ≠ 2 ∧ ell ≠ p := by
  obtain ⟨p, hpC, hp⟩ := Nat.exists_infinite_primes (C + 5)
  have hp_two : 2 < p := by omega
  refine ⟨p, hp, higherLevelRaisingNumerics_away_linear_example hp_two,
    ?_, ?_⟩
  · let q := p - 2
    have hpq : p = q + 2 := by
      dsimp [q]
      omega
    have hq : C + 3 ≤ q := by
      dsimp [q]
      omega
    have htwice : 2 * C < 3 * q := by omega
    calc
      C * p = C * q + 2 * C := by rw [hpq]; ring
      _ < C * q + 3 * q := Nat.add_lt_add_left htwice (C * q)
      _ = (C + 3) * q := by ring
      _ ≤ q * q := Nat.mul_le_mul_right q hq
      _ = (p - 2) ^ 2 := by simp [q, pow_two]
  · intro ell hell hdiv
    exact primeDivisor_sub_two_is_away hp hp_two hell hdiv

end IUTThreeClosures
