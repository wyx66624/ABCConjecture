import IUTThreeClosures.FreyOddMultiplicativeCriterion

set_option linter.unusedSectionVars false

/-!
# Exponent layers and the generalized-Fermat modular barrier

This file contains only elementary arithmetic and finite-sum statements.  It
formalizes the exact `n`-th-power decomposition of a finite prime-exponent
profile, the corresponding coefficient budget, and the support which can
survive level lowering modulo an exponent prime.

The main obstruction is the exponent-one layer: a coordinate whose exponent
is exactly one survives for every modulus at least two.  A finite collection
of moduli therefore cannot remove this layer by exponent divisibility alone.
The endpoint family `(1,p,p+1)` also shows that the `n`-power-free
coefficients cannot be put in a fixed finite list: a prime `p` is rigidly its
own coefficient in every decomposition `p = u*x^n`, `n >= 2`.

No modularity theorem, level-lowering theorem, generalized-Fermat finiteness
statement, height bound, or abc estimate is assumed in this module.
-/

namespace IUTThreeClosures

open scoped BigOperators

noncomputable section ExponentProfiles

variable {ι : Type*}

/-- The integer represented by a finite base/exponent profile. -/
def exponentProfileProduct
    (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  ∏ i ∈ s, base i ^ exponent i

/-- The canonical residue coefficient in an `n`-th-power decomposition. -/
def exponentResidueKernel
    (n : ℕ) (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  ∏ i ∈ s, base i ^ (exponent i % n)

/-- The canonical power base in an `n`-th-power decomposition. -/
def exponentQuotientRoot
    (n : ℕ) (s : Finset ι) (base exponent : ι → ℕ) : ℕ :=
  ∏ i ∈ s, base i ^ (exponent i / n)

/-- Exact finite-profile form of `e = (e mod n) + n * floor(e/n)`. -/
theorem exponentProfileProduct_eq_kernel_mul_root_pow
    (n : ℕ) (s : Finset ι) (base exponent : ι → ℕ) :
    exponentProfileProduct s base exponent =
      exponentResidueKernel n s base exponent *
        exponentQuotientRoot n s base exponent ^ n := by
  classical
  unfold exponentProfileProduct exponentResidueKernel exponentQuotientRoot
  calc
    (∏ i ∈ s, base i ^ exponent i) =
        ∏ i ∈ s,
          (base i ^ (exponent i % n)) *
            (base i ^ (exponent i / n)) ^ n := by
      apply Finset.prod_congr rfl
      intro i hi
      rw [← pow_mul, ← pow_add, Nat.mod_add_div']
    _ = (∏ i ∈ s, base i ^ (exponent i % n)) *
        ∏ i ∈ s, (base i ^ (exponent i / n)) ^ n := by
      exact Finset.prod_mul_distrib
    _ = (∏ i ∈ s, base i ^ (exponent i % n)) *
        (∏ i ∈ s, base i ^ (exponent i / n)) ^ n := by
      rw [Finset.prod_pow]

/-- Logarithmic total exponent mass, with arbitrary real prime weights. -/
noncomputable def exponentTotalWeight
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, (exponent i : ℝ) * weight i

/-- Logarithmic mass retained in the residue coefficient. -/
noncomputable def exponentResidueWeight
    (n : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, ((exponent i % n : ℕ) : ℝ) * weight i

/-- Logarithmic mass in the extracted `n`-th-power root. -/
noncomputable def exponentQuotientWeight
    (n : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) : ℝ :=
  ∑ i ∈ s, ((exponent i / n : ℕ) : ℝ) * weight i

/-- The radical weight of the chosen finite support. -/
noncomputable def exponentRadicalWeight
    (s : Finset ι) (weight : ι → ℝ) : ℝ :=
  ∑ i ∈ s, weight i

/-- Exact logarithmic accounting: increasing `n` merely transfers mass
between the residue coefficient and the extracted power root. -/
theorem exponentTotalWeight_eq_residue_add_n_mul_quotient
    (n : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) :
    exponentTotalWeight s weight exponent =
      exponentResidueWeight n s weight exponent +
        (n : ℝ) * exponentQuotientWeight n s weight exponent := by
  classical
  unfold exponentTotalWeight exponentResidueWeight exponentQuotientWeight
  rw [Finset.mul_sum, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  have hsplit := Nat.mod_add_div (exponent i) n
  have hsplitReal :
      (exponent i : ℝ) =
        ((exponent i % n : ℕ) : ℝ) +
          (n : ℝ) * ((exponent i / n : ℕ) : ℝ) := by
    exact_mod_cast hsplit.symm
  rw [hsplitReal]
  ring

/-- Doubling the generalized-Fermat bookkeeping gives exactly the original
Frey discriminant mass; there is no `1/n` height dilution. -/
theorem two_mul_totalWeight_eq_kernel_root_accounting
    (n : ℕ) (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ) :
    2 * exponentTotalWeight s weight exponent =
      2 * exponentResidueWeight n s weight exponent +
        2 * (n : ℝ) * exponentQuotientWeight n s weight exponent := by
  rw [exponentTotalWeight_eq_residue_add_n_mul_quotient]
  ring

/-- The elementary coefficient budget
`log kappa_n <= (n-1) log rad` for a finite exponent profile. -/
theorem exponentResidueWeight_le_radical_budget
    {n : ℕ} (hn : 0 < n)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    exponentResidueWeight n s weight exponent ≤
      ((n - 1 : ℕ) : ℝ) * exponentRadicalWeight s weight := by
  classical
  unfold exponentResidueWeight exponentRadicalWeight
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  have hmodNat : exponent i % n ≤ n - 1 := by
    have hlt := Nat.mod_lt (exponent i) hn
    omega
  have hmodReal : ((exponent i % n : ℕ) : ℝ) ≤ (n - 1 : ℕ) := by
    exact_mod_cast hmodNat
  exact mul_le_mul_of_nonneg_right hmodReal (hweight i hi)

/-- Mixed signature `(n,n,r)` has the displayed coefficient budget.  Making
the exponents large increases the a priori coefficient exponents. -/
theorem mixedSignatureResidueWeight_le
    {n r : ℕ} (hn : 0 < n) (hr : 0 < r)
    (sa sb sc : Finset ι) (weight : ι → ℝ)
    (ea eb ec : ι → ℕ)
    (hwa : ∀ i ∈ sa, 0 ≤ weight i)
    (hwb : ∀ i ∈ sb, 0 ≤ weight i)
    (hwc : ∀ i ∈ sc, 0 ≤ weight i) :
    exponentResidueWeight n sa weight ea +
        exponentResidueWeight n sb weight eb +
        exponentResidueWeight r sc weight ec ≤
      ((n - 1 : ℕ) : ℝ) *
          (exponentRadicalWeight sa weight +
            exponentRadicalWeight sb weight) +
        ((r - 1 : ℕ) : ℝ) * exponentRadicalWeight sc weight := by
  have ha := exponentResidueWeight_le_radical_budget hn sa weight ea hwa
  have hb := exponentResidueWeight_le_radical_budget hn sb weight eb hwb
  have hc := exponentResidueWeight_le_radical_budget hr sc weight ec hwc
  linarith

/-- Support remaining after the exponent-divisibility part of level lowering
at modulus `n`. -/
def exponentResidualSupport
    (n : ℕ) (s : Finset ι) (exponent : ι → ℕ) : Finset ι :=
  s.filter fun i => ¬ n ∣ exponent i

/-- The permanent exponent-one layer. -/
def exponentOneSupport
    (s : Finset ι) (exponent : ι → ℕ) : Finset ι :=
  s.filter fun i => exponent i = 1

/-- Every exponent-one coordinate survives every modulus at least two. -/
theorem exponentOneSupport_subset_residualSupport
    {n : ℕ} (hn : 2 ≤ n) (s : Finset ι) (exponent : ι → ℕ) :
    exponentOneSupport s exponent ⊆
      exponentResidualSupport n s exponent := by
  intro i hi
  simp only [exponentOneSupport, Finset.mem_filter] at hi
  simp only [exponentResidualSupport, Finset.mem_filter]
  refine ⟨hi.1, ?_⟩
  intro hdiv
  rw [hi.2] at hdiv
  have hle : n ≤ 1 := Nat.le_of_dvd (by norm_num) hdiv
  omega

/-- Product form of the permanent-support theorem: the exponent-one radical
divides every exponent-divisibility level proxy. -/
theorem exponentOneProduct_dvd_residualProduct
    {n : ℕ} (hn : 2 ≤ n)
    (s : Finset ι) (base exponent : ι → ℕ) :
    (∏ i ∈ exponentOneSupport s exponent, base i) ∣
      ∏ i ∈ exponentResidualSupport n s exponent, base i := by
  exact Finset.prod_dvd_prod_of_subset
    (exponentOneSupport s exponent)
    (exponentResidualSupport n s exponent) base
    (exponentOneSupport_subset_residualSupport hn s exponent)

/-- Weighted form of the same permanent-support theorem. -/
theorem exponentOneWeight_le_residualWeight
    {n : ℕ} (hn : 2 ≤ n)
    (s : Finset ι) (weight : ι → ℝ) (exponent : ι → ℕ)
    (hweight : ∀ i ∈ s, 0 ≤ weight i) :
    (∑ i ∈ exponentOneSupport s exponent, weight i) ≤
      ∑ i ∈ exponentResidualSupport n s exponent, weight i := by
  classical
  apply Finset.sum_le_sum_of_subset_of_nonneg
    (exponentOneSupport_subset_residualSupport hn s exponent)
  intro i hiResidual hiNotOne
  exact hweight i (Finset.mem_filter.mp hiResidual).1

/-- If `n` exceeds every positive exponent then no prime is removed: the
residual support is the entire original support. -/
theorem residualSupport_eq_self_of_exponents_lt
    {n : ℕ} (s : Finset ι) (exponent : ι → ℕ)
    (hpos : ∀ i ∈ s, 0 < exponent i)
    (hlt : ∀ i ∈ s, exponent i < n) :
    exponentResidualSupport n s exponent = s := by
  apply Finset.filter_eq_self.mpr
  intro i hi hdiv
  have hle : n ≤ exponent i := Nat.le_of_dvd (hpos i hi) hdiv
  exact (not_le_of_gt (hlt i hi)) hle

/-- For a family of candidate moduli, double counting is exact.  Thus any
pigeonhole saving must come from actual divisor coverage of the exponents. -/
theorem residualWeight_double_count
    (moduli : Finset ℕ) (s : Finset ι)
    (weight : ι → ℝ) (exponent : ι → ℕ) :
    (∑ n ∈ moduli,
        ∑ i ∈ exponentResidualSupport n s exponent, weight i) =
      ∑ i ∈ s,
        ∑ n ∈ moduli, if ¬ n ∣ exponent i then weight i else 0 := by
  classical
  simp only [exponentResidualSupport, Finset.sum_filter]
  rw [Finset.sum_comm]

/-- If all coordinates have exponent one, every modulus at least two gives
exactly the full radical weight.  This is equality, not merely a bound. -/
theorem residualWeight_eq_full_of_all_exponents_one
    (moduli : Finset ℕ) (s : Finset ι)
    (weight : ι → ℝ) (exponent : ι → ℕ)
    (hmoduli : ∀ n ∈ moduli, 2 ≤ n)
    (hone : ∀ i ∈ s, exponent i = 1) :
    (∑ n ∈ moduli,
        ∑ i ∈ exponentResidualSupport n s exponent, weight i) =
      (moduli.card : ℝ) * ∑ i ∈ s, weight i := by
  classical
  have hsupport : ∀ n ∈ moduli,
      exponentResidualSupport n s exponent = s := by
    intro n hn
    have hn2 := hmoduli n hn
    apply Finset.filter_eq_self.mpr
    intro i hi hdiv
    rw [hone i hi] at hdiv
    have hle : n ≤ 1 := Nat.le_of_dvd (by norm_num) hdiv
    omega
  calc
    (∑ n ∈ moduli,
        ∑ i ∈ exponentResidualSupport n s exponent, weight i) =
        ∑ n ∈ moduli, ∑ i ∈ s, weight i := by
          apply Finset.sum_congr rfl
          intro n hn
          rw [hsupport n hn]
    _ = (moduli.card : ℝ) * ∑ i ∈ s, weight i := by simp

/-- A finite collection of moduli has an arbitrarily high common blind
residue class: `1 + t * product(moduli)` is divisible by none of them when
all moduli are at least two. -/
theorem not_dvd_one_add_mul_moduliProduct
    (moduli : Finset ℕ) {n t : ℕ}
    (hnmem : n ∈ moduli) (hn : 2 ≤ n) :
    ¬ n ∣ 1 + t * ∏ q ∈ moduli, q := by
  have hnprod : n ∣ ∏ q ∈ moduli, q :=
    Finset.dvd_prod_of_mem (fun q => q) hnmem
  have hnmul : n ∣ t * ∏ q ∈ moduli, q :=
    dvd_mul_of_dvd_right hnprod t
  intro hsum
  have hsum' : n ∣ t * (∏ q ∈ moduli, q) + 1 := by
    simpa [add_comm] using hsum
  have hone : n ∣ 1 := (Nat.dvd_add_iff_right hnmul).2 hsum'
  have hle : n ≤ 1 := Nat.le_of_dvd (by norm_num) hone
  omega

/-- Consequently, no finite list of exponent moduli gives a combinatorial
upper bound on exponent size from its residual supports: arbitrarily large
exponents can survive every member of the list. -/
theorem exists_large_exponent_surviving_finite_moduli
    (moduli : Finset ℕ)
    (hmoduli : ∀ n ∈ moduli, 2 ≤ n)
    (B : ℕ) :
    ∃ e : ℕ, B < e ∧ ∀ n ∈ moduli, ¬ n ∣ e := by
  let M := ∏ q ∈ moduli, q
  have hMpos : 0 < M := by
    unfold M
    exact Finset.prod_pos fun q hq => by
      have hq2 := hmoduli q hq
      omega
  refine ⟨1 + (B + 1) * M, ?_, ?_⟩
  · have hmul : B + 1 ≤ (B + 1) * M :=
      Nat.le_mul_of_pos_right (B + 1) hMpos
    omega
  · intro n hn
    exact not_dvd_one_add_mul_moduliProduct moduli hn
      (hmoduli n hn) (t := B + 1)

end ExponentProfiles

/-! ## Exact odd-prime exponent of the Frey discriminant -/

namespace ABCPoint

/-- At an odd prime, the fixed factor `16` contributes nothing and the Frey
discriminant exponent is exactly twice the exponent in `abc`. -/
theorem freyDeltaNat_factorization_at_oddPrime
    (P : ABCPoint) {p : ℕ} (hp : p.Prime) (hp_ne_two : p ≠ 2) :
    P.freyDeltaNat.factorization p =
      2 * (P.a * P.b * P.c).factorization p := by
  have hprod : P.a * P.b * P.c ≠ 0 := by
    exact Nat.ne_of_gt (mul_pos (mul_pos P.a_pos P.b_pos) P.c_pos)
  have hp16 : ¬ p ∣ 16 := by
    intro h
    exact oddPrime_not_dvd_256 hp hp_ne_two
      (h.trans (by norm_num : 16 ∣ 256))
  unfold freyDeltaNat
  rw [Nat.factorization_mul (by norm_num) (pow_ne_zero 2 hprod),
    Nat.factorization_pow]
  simp [Nat.factorization_eq_zero_of_not_dvd hp16]

/-- For odd residual characteristic, divisibility of the Frey discriminant
exponent is exactly divisibility of the corresponding `abc` exponent. -/
theorem oddResidual_dvd_freyDeltaExponent_iff
    (P : ABCPoint) {p ell : ℕ}
    (hp : p.Prime) (hp_ne_two : p ≠ 2)
    (hell : ell.Prime) (hell_ne_two : ell ≠ 2) :
    ell ∣ P.freyDeltaNat.factorization p ↔
      ell ∣ (P.a * P.b * P.c).factorization p := by
  rw [P.freyDeltaNat_factorization_at_oddPrime hp hp_ne_two]
  constructor
  · intro hdiv
    rcases hell.dvd_mul.mp hdiv with hell2 | he
    · have : ell = 2 := (Nat.dvd_prime Nat.prime_two).mp hell2 |>.resolve_left hell.ne_one
      exact False.elim (hell_ne_two this)
    · exact he
  · intro hdiv
    exact dvd_mul_of_dvd_right hdiv 2

end ABCPoint

/-! ## A strict infinite-coefficient obstruction -/

/-- The primitive endpoint `(1,p,p+1)`. -/
def primeEndpointPoint (p : ℕ) (hp : p.Prime) : ABCPoint where
  a := 1
  b := p
  c := p + 1
  a_pos := by norm_num
  b_pos := hp.pos
  c_pos := by omega
  sum_eq := by omega
  pairwise_coprime := by
    constructor
    · simp
    constructor
    · simp
    · simp

@[simp] theorem primeEndpointPoint_a (p : ℕ) (hp : p.Prime) :
    (primeEndpointPoint p hp).a = 1 := rfl

@[simp] theorem primeEndpointPoint_b (p : ℕ) (hp : p.Prime) :
    (primeEndpointPoint p hp).b = p := rfl

@[simp] theorem primeEndpointPoint_c (p : ℕ) (hp : p.Prime) :
    (primeEndpointPoint p hp).c = p + 1 := rfl

/-- A nontrivial power with exponent at least two cannot equal a prime. -/
theorem pow_ne_prime
    {p x n : ℕ} (hp : p.Prime) (hn : 2 ≤ n) :
    x ^ n ≠ p := by
  intro hxp
  have hxdvd : x ∣ p := by
    rw [← hxp]
    exact dvd_pow_self x (by omega)
  rcases (Nat.dvd_prime hp).mp hxdvd with hx | hx
  · rw [hx] at hxp
    simp at hxp
    exact hp.ne_one hxp.symm
  · rw [hx] at hxp
    have hp2lt : p < p ^ 2 := by
      nlinarith [hp.two_le]
    have hp2le : p ^ 2 ≤ p ^ n :=
      Nat.pow_le_pow_right hp.pos hn
    rw [hxp] at hp2le
    exact (not_le_of_gt hp2lt) hp2le

/-- The prime decomposition is rigid: in `p = u*x^n`, with `n >= 2`, the
power base is one and the coefficient is the unbounded prime `p`. -/
theorem prime_nthPower_decomposition_rigid
    {p u x n : ℕ} (hp : p.Prime) (hn : 2 ≤ n)
    (hdecomp : p = u * x ^ n) :
    x = 1 ∧ u = p := by
  have hpowdvd : x ^ n ∣ p := by
    refine ⟨u, ?_⟩
    simpa [mul_comm] using hdecomp
  rcases (Nat.dvd_prime hp).mp hpowdvd with hpow | hpow
  · have hx : x = 1 := by
      have hxpow : x ^ n = 1 := hpow
      rcases Nat.pow_eq_one.mp hxpow with hx | hnzero
      · exact hx
      · omega
    refine ⟨hx, ?_⟩
    simpa [hx] using hdecomp.symm
  · exact False.elim (pow_ne_prime hp hn hpow)

/-- For every bound and every exponent at least two there is a primitive abc
point whose canonical generalized-Fermat coefficient is larger than the
bound.  Hence no fixed finite coefficient list follows from power
decomposition alone. -/
theorem exists_primeEndpoint_rigid_coefficient_above
    (B n : ℕ) (hn : 2 ≤ n) :
    ∃ (p : ℕ) (hp : p.Prime),
      B < (primeEndpointPoint p hp).b ∧
      ∀ u x : ℕ,
        (primeEndpointPoint p hp).b = u * x ^ n →
          x = 1 ∧ u = p := by
  obtain ⟨p, hpB, hp⟩ := Nat.exists_infinite_primes (B + 1)
  refine ⟨p, hp, ?_, ?_⟩
  · simp only [primeEndpointPoint_b]
    omega
  · intro u x hdecomp
    exact prime_nthPower_decomposition_rigid hp hn hdecomp

end IUTThreeClosures
