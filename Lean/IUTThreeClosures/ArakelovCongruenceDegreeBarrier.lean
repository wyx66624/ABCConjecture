/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArithmeticLeibnizWronskian
import IUTThreeClosures.GeneralizedFermatExponentLayers
import Mathlib.Data.ZMod.Basic

/-!
# Arakelov degree of the exponent-excess module

On `Spec Z`, the arithmetic degree of a finite torsion module remembers the
residue-prime norm.  Consequently, for a positive integer `n`, there is a
completely canonical module whose degree is its weighted exponent excess:

`ZMod (n / rad(n))`.

Its degree is exactly

`sum_{p | n} (v_p(n) - 1) log p`.

This gives the desired `log p` weighting, but it does so by putting the full
powerful part into the modulus.  The exact logarithmic decomposition proved
below shows that a radical-level upper bound for this degree is precisely a
powerful-part height estimate; it is not supplied by the formal properties of
Fitting ideals or arithmetic degree.

The file also records two strict scope barriers.

* Powerful-part degree is unbounded for general vertical data of fixed
  radical.
* A congruence modulus supported at a residual prime `ell` has trivial
  scheme-theoretic intersection with a bad-prime modulus supported at a
  distinct prime `p`.

No modularity, level lowering, congruence-ideal formula, Arakelov
intersection inequality, Szpiro estimate, or abc estimate is assumed.
-/

namespace IUTThreeClosures

open scoped BigOperators
open UniqueFactorizationMonoid

noncomputable section

/-! ## A finite-profile exponent-excess carrier -/

variable {ι : Type*}

/-- The product left after removing one copy of every chosen base. -/
def exponentExcessCarrier
    (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  ∏ i ∈ s, base i ^ (exponent i - 1)

/-- The Arakelov weight of the exponent excess.  For prime bases one takes
`weight i = log (base i)`. -/
def exponentExcessDegree
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, ((exponent i - 1 : ℕ) : ℝ) * weight i

/-- Removing one base copy and then restoring the radical copy recovers the
full exponent profile. -/
theorem radicalCarrier_mul_exponentExcessCarrier
    (s : Finset ι) (base exponent : ι → ℕ)
    (hexponent : ∀ i ∈ s, 0 < exponent i) :
    (∏ i ∈ s, base i) * exponentExcessCarrier s base exponent =
      exponentProfileProduct s base exponent := by
  classical
  unfold exponentExcessCarrier exponentProfileProduct
  rw [← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro i hi
  have hsplit : exponent i - 1 + 1 = exponent i := by
    have := hexponent i hi
    omega
  calc
    base i * base i ^ (exponent i - 1) =
        base i ^ (exponent i - 1) * base i := by ac_rfl
    _ = base i ^ (exponent i - 1 + 1) := by
      rw [pow_succ]
    _ = base i ^ exponent i := by rw [hsplit]

/-- Exact additive accounting of total logarithmic exponent mass. -/
theorem exponentTotalWeight_eq_radical_add_excess
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hexponent : ∀ i ∈ s, 0 < exponent i) :
    exponentTotalWeight s weight exponent =
      exponentRadicalWeight s weight +
        exponentExcessDegree s weight exponent := by
  classical
  unfold exponentTotalWeight exponentRadicalWeight exponentExcessDegree
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  have hsplit : (exponent i - 1) + 1 = exponent i := by
    have := hexponent i hi
    omega
  have hsplitReal :
      (exponent i : ℝ) = 1 + ((exponent i - 1 : ℕ) : ℝ) := by
    have hcast :
        (exponent i : ℝ) = ((exponent i - 1 : ℕ) : ℝ) + 1 := by
      exact_mod_cast hsplit.symm
    linarith
  rw [hsplitReal]
  ring

/-- The ordinary logarithm of the carrier is its Arakelov weighted degree.
This is where the residue-norm factor `log p` enters. -/
theorem log_exponentExcessCarrier_eq_degree
    (s : Finset ι) (base exponent : ι → ℕ)
    (hbase : ∀ i ∈ s, 0 < base i) :
    Real.log (exponentExcessCarrier s base exponent : ℝ) =
      exponentExcessDegree s
        (fun i => Real.log (base i : ℝ)) exponent := by
  classical
  unfold exponentExcessCarrier exponentExcessDegree
  push_cast
  rw [Real.log_prod]
  · apply Finset.sum_congr rfl
    intro i hi
    rw [Real.log_pow]
  · intro i hi
    exact pow_ne_zero _ (by exact_mod_cast (hbase i hi).ne')

/-! ## The canonical module for an integer -/

/-- The prime-profile carrier of `n`. -/
def primeExponentExcessCarrier (n : ℕ) : ℕ :=
  exponentExcessCarrier n.primeFactors id n.factorization

/-- The corresponding explicitly `log p`-weighted degree. -/
def primeExponentExcessDegree (n : ℕ) : ℝ :=
  exponentExcessDegree n.primeFactors
    (fun p => Real.log (p : ℝ)) n.factorization

/-- The prime-profile carrier is exactly the usual powerful part
`n / rad(n)`. -/
theorem primeExponentExcessCarrier_eq_abcPowerfulPart
    {n : ℕ} (hn : n ≠ 0) :
    primeExponentExcessCarrier n = abcPowerfulPart n := by
  have hexponent : ∀ p ∈ n.primeFactors, 0 < n.factorization p := by
    intro p hp
    exact (Nat.prime_of_mem_primeFactors hp).factorization_pos_of_dvd hn
      (Nat.dvd_of_mem_primeFactors hp)
  have hprofile :
      exponentProfileProduct n.primeFactors id n.factorization = n := by
    simpa [exponentProfileProduct] using
      (Nat.prod_primeFactors_pow_factorization hn).symm
  have hcarrier := radicalCarrier_mul_exponentExcessCarrier
    n.primeFactors id n.factorization hexponent
  have hradical : (∏ p ∈ n.primeFactors, id p) = abcRadical n := by
    rfl
  rw [hprofile, hradical] at hcarrier
  have hpowerful := abcRadical_mul_abcPowerfulPart n
  exact Nat.eq_of_mul_eq_mul_left (abcRadical_pos n)
    (hcarrier.trans hpowerful.symm)

/-- The explicit weighted sum is the logarithm of the powerful part. -/
theorem primeExponentExcessDegree_eq_log_powerfulPart
    {n : ℕ} (hn : n ≠ 0) :
    primeExponentExcessDegree n =
      Real.log (abcPowerfulPart n : ℝ) := by
  have hbase : ∀ p ∈ n.primeFactors, 0 < id p := by
    intro p hp
    exact (Nat.prime_of_mem_primeFactors hp).pos
  rw [← primeExponentExcessCarrier_eq_abcPowerfulPart hn]
  exact (log_exponentExcessCarrier_eq_degree
    n.primeFactors id n.factorization hbase).symm

/-- The cyclic `Z`-module carrying the exponent excess.  It is genuinely
finite when `n != 0`, as proved below; at `n = 0`, `ZMod 0` is infinite. -/
abbrev ArakelovExcessModule (n : ℕ) :=
  ZMod (abcPowerfulPart n)

/-- Cardinality formula used for arithmetic degree over `Spec Z`.  `Nat.card`
has a convention for infinite types, but every arithmetic application below
assumes `n != 0`, in which case the displayed `ZMod` is genuinely finite. -/
def finiteTorsionArithmeticDegree (M : Type*) : ℝ :=
  Real.log (Nat.card M)

/-- The canonical module has cardinality exactly the powerful part. -/
theorem arakelovExcessModule_card (n : ℕ) :
    Nat.card (ArakelovExcessModule n) = abcPowerfulPart n := by
  exact Nat.card_zmod _

/-- For a nonzero input, the canonical excess module is genuinely finite. -/
theorem arakelovExcessModule_finite
    {n : ℕ} (hn : n ≠ 0) :
    Finite (ArakelovExcessModule n) := by
  have hfactor := abcRadical_mul_abcPowerfulPart n
  have hrad : 0 < abcRadical n := abcRadical_pos n
  have hnpos : 0 < n := Nat.pos_of_ne_zero hn
  have hexcess : 0 < abcPowerfulPart n := by
    nlinarith
  letI : NeZero (abcPowerfulPart n) := ⟨hexcess.ne'⟩
  exact Finite.of_fintype (ZMod (abcPowerfulPart n))

/-- Hence its arithmetic degree is the desired prime-weighted excess. -/
theorem arakelovExcessModule_degree_eq_weighted_excess
    {n : ℕ} (hn : n ≠ 0) :
    finiteTorsionArithmeticDegree (ArakelovExcessModule n) =
      primeExponentExcessDegree n := by
  unfold finiteTorsionArithmeticDegree
  rw [arakelovExcessModule_card,
    primeExponentExcessDegree_eq_log_powerfulPart hn]

/-! ## Exact circularity boundary of a radical-level upper bound -/

/-- The powerful part is positive for every positive integer. -/
theorem abcPowerfulPart_pos {n : ℕ} (hn : 0 < n) :
    0 < abcPowerfulPart n := by
  have hfactor := abcRadical_mul_abcPowerfulPart n
  have hrad : 0 < abcRadical n := abcRadical_pos n
  nlinarith

/-- Height is exactly radical degree plus excess-module degree. -/
theorem log_nat_eq_log_radical_add_excessDegree
    {n : ℕ} (hn : 0 < n) :
    Real.log (n : ℝ) =
      Real.log (abcRadical n : ℝ) +
        finiteTorsionArithmeticDegree (ArakelovExcessModule n) := by
  have hrad : (abcRadical n : ℝ) ≠ 0 := by
    exact_mod_cast (abcRadical_pos n).ne'
  have hexcess : (abcPowerfulPart n : ℝ) ≠ 0 := by
    exact_mod_cast (abcPowerfulPart_pos hn).ne'
  unfold finiteTorsionArithmeticDegree
  rw [arakelovExcessModule_card, ← Real.log_mul hrad hexcess]
  congr 1
  exact_mod_cast (abcRadical_mul_abcPowerfulPart n).symm

/-- A proposed radical-degree upper bound for the canonical module is
algebraically equivalent to the corresponding powerful-part height bound.
This theorem supplies no such upper bound. -/
theorem excessDegree_upper_iff_productHeight_upper
    {n : ℕ} (hn : 0 < n) (eta C : ℝ) :
    finiteTorsionArithmeticDegree (ArakelovExcessModule n) ≤
        eta * Real.log (abcRadical n : ℝ) + C ↔
      Real.log (n : ℝ) ≤
        (1 + eta) * Real.log (abcRadical n : ℝ) + C := by
  rw [log_nat_eq_log_radical_add_excessDegree hn]
  constructor <;> intro h <;> linarith

/-- Doubled form of the same equivalence.  For the odd Frey discriminant the
left height is the arithmetic shadow of `log |Delta_min|`, while the radical
degree is the shadow of the multiplicative conductor. -/
theorem excessDegree_upper_iff_doubledHeight_upper
    {n : ℕ} (hn : 0 < n) (eta C : ℝ) :
    finiteTorsionArithmeticDegree (ArakelovExcessModule n) ≤
        eta * Real.log (abcRadical n : ℝ) + C ↔
      2 * Real.log (n : ℝ) ≤
        2 * (1 + eta) * Real.log (abcRadical n : ℝ) + 2 * C := by
  constructor
  · intro h
    have hheight :=
      (excessDegree_upper_iff_productHeight_upper hn eta C).mp h
    linarith
  · intro h
    apply (excessDegree_upper_iff_productHeight_upper hn eta C).mpr
    linarith

/-! ## Strict barriers for formal intersection arguments -/

/-- The radical of every positive power `2^(m+1)` is exactly two. -/
theorem radical_two_pow_succ_for_excess (m : ℕ) :
    radical (2 ^ (m + 1)) = 2 := by
  simpa using
    (radical_pow_of_prime
      (Nat.prime_iff.mp Nat.prime_two)
      (show m + 1 ≠ 0 by omega))

/-- The powerful part of `2^(m+1)` is exactly `2^m`. -/
theorem abcPowerfulPart_two_pow_succ (m : ℕ) :
    abcPowerfulPart (2 ^ (m + 1)) = 2 ^ m := by
  unfold abcPowerfulPart
  rw [abcRadical_eq_natRadical, radical_two_pow_succ_for_excess]
  simp [pow_succ]

/-- General vertical exponent-excess modules are unbounded even when their
radical is fixed.  This does not by itself refute an estimate restricted to
the global abc locus. -/
theorem arakelovExcessCarrier_unbounded_at_fixed_radical (B : ℕ) :
    ∃ n : ℕ,
      radical n = 2 ∧ B < Nat.card (ArakelovExcessModule n) := by
  refine ⟨2 ^ (B + 1), ?_, ?_⟩
  · exact radical_two_pow_succ_for_excess B
  · rw [arakelovExcessModule_card, abcPowerfulPart_two_pow_succ]
    exact B.lt_two_pow_self

/-- Fully quantified form: no function of the radical alone bounds the
carrier on arbitrary vertical exponent data. -/
theorem no_universal_radicalOnly_excessCarrier_bound (F : ℕ → ℕ) :
    ∃ n : ℕ,
      F (radical n) < Nat.card (ArakelovExcessModule n) := by
  obtain ⟨n, hrad, hlarge⟩ :=
    arakelovExcessCarrier_unbounded_at_fixed_radical (F 2)
  exact ⟨n, by simpa [hrad] using hlarge⟩

/-- Distinct vertical prime powers are comaximal.  Thus an ordinary
congruence module supported at `ell` has zero scheme-theoretic intersection
with a bad-prime vertical divisor supported at `p != ell`; tensoring or
intersecting cannot manufacture the missing `log p` weight. -/
theorem distinctPrimePower_verticalIntersection_trivial
    {p ell a b : ℕ} (hp : p.Prime) (hell : ell.Prime)
    (hne : p ≠ ell) :
    Nat.gcd (p ^ a) (ell ^ b) = 1 := by
  have hnot : ¬ p ∣ ell := by
    intro hdiv
    have hpeq : p = ell :=
      (Nat.dvd_prime hell).mp hdiv |>.resolve_left hp.ne_one
    exact hne hpeq
  have hcoprime : Nat.Coprime p ell :=
    hp.coprime_iff_not_dvd.mpr hnot
  exact (hcoprime.pow a b).gcd_eq_one

/-- A fixed unweighted congruence depth `2` is compatible with an
arbitrarily large support-prime carrier.  Therefore no bound depending only
on that depth can dominate the Arakelov-weighted carrier. -/
theorem fixedCongruenceDepth_two_has_unbounded_weightedCarrier (B : ℕ) :
    ∃ p : ℕ, p.Prime ∧ B * 2 < p ∧ p ^ (2 - 1) = p := by
  obtain ⟨p, hpB, hp⟩ := Nat.exists_infinite_primes (B * 2 + 1)
  exact ⟨p, hp, by omega, by simp⟩

/-- Fully quantified form of the depth-only obstruction. -/
theorem no_universal_unweightedDepth_excessCarrier_bound (F : ℕ → ℕ) :
    ∃ p : ℕ, p.Prime ∧ F 2 < p ^ (2 - 1) := by
  obtain ⟨p, hpF, hp⟩ := Nat.exists_infinite_primes (F 2 + 1)
  exact ⟨p, hp, by simpa using (show F 2 < p by omega)⟩

end

end IUTThreeClosures
