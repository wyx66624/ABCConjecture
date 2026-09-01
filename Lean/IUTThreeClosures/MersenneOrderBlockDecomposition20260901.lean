/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneRadicalWieferichBarrier

/-!
# The global Mersenne order-block lifting factor

For `m > 0`, this module gives a natural-number realization of the lifting
factor in the order-block decomposition of `2^m - 1`:

`mersenneLiftingFactor m = gcd m (2^m - 1)`.

If a prime `p` divides `2^m - 1` and `d` is the exact multiplicative order of
`2` modulo `p`, then `d | m`, `d | p - 1`, and hence `p ∤ d`.  The existing
odd-prime LTE theorem therefore gives the exact local identity

`v_p(2^m - 1) = v_p(2^d - 1) + v_p(m)`.

In particular, every prime power appearing in `gcd m (2^m - 1)` survives
after one radical copy is removed.  Thus the lifting factor divides the full
Mersenne power loss.  Defining the remaining base quotient by exact natural
division gives an unconditional factorization

`mersennePowerLoss m = mersenneLiftingFactor m * mersenneBaseQuotient m`.

This is the actual global arithmetic part of equation (1.2) in
`research/ABC_MERSENNE_PRIME_LAYER_RADICAL_2026_09_01.md`.  The base quotient
is then reconstructed prime by prime and grouped, by exact order, into the
paper's finite blocks `E_d`.  This yields the full unconditional identity
`W_m = L_m * ∏_{d ∣ m} E_d` in natural-number arithmetic.
-/

namespace IUTThreeClosures
namespace MersenneOrderBlockDecomposition20260901

open UniqueFactorizationMonoid
open scoped BigOperators

/-- The exact multiplicative-order block of the base two modulo `p`. -/
noncomputable def mersenneExactOrder (p : ℕ) : ℕ :=
  orderOf (2 : ZMod p)

/-- Natural-number realization of the Mersenne index-lifting factor. -/
def mersenneLiftingFactor (m : ℕ) : ℕ :=
  Nat.gcd m (2 ^ m - 1)

/-- The lifting factor always divides the exponent. -/
theorem mersenneLiftingFactor_dvd_index (m : ℕ) :
    mersenneLiftingFactor m ∣ m := by
  exact Nat.gcd_dvd_left _ _

/-- The lifting factor also divides the corresponding Mersenne value. -/
theorem mersenneLiftingFactor_dvd_mersenne (m : ℕ) :
    mersenneLiftingFactor m ∣ 2 ^ m - 1 := by
  exact Nat.gcd_dvd_right _ _

/-- A positive-index Mersenne value is positive. -/
theorem mersenne_sub_one_pos {m : ℕ} (hm : 0 < m) :
    0 < 2 ^ m - 1 := by
  exact Nat.sub_pos_of_lt (one_lt_pow₀ (by norm_num) hm.ne')

/-- A prime divisor of a positive-index Mersenne value is odd. -/
theorem prime_ne_two_of_dvd_mersenne {m p : ℕ}
    (hm : 0 < m) (hp : p.Prime) (hpm : p ∣ 2 ^ m - 1) :
    p ≠ 2 := by
  intro hp2
  subst p
  have hpmod : 2 ^ m % 2 = 0 :=
    Nat.mod_eq_zero_of_dvd (dvd_pow_self 2 hm.ne')
  have hodd : Odd (2 ^ m - 1) := by
    rw [Nat.odd_sub (one_le_pow₀ (by norm_num))]
    simp [Nat.odd_iff, Nat.even_iff, hpmod]
  exact hodd.not_two_dvd_nat hpm

/-- Divisibility by a Mersenne value is the corresponding power-one identity
in `ZMod p`. -/
theorem zmod_two_pow_eq_one_of_prime_dvd_mersenne {m p : ℕ}
    (hp : p.Prime) (hpm : p ∣ 2 ^ m - 1) :
    (2 : ZMod p) ^ m = 1 := by
  letI : Fact p.Prime := ⟨hp⟩
  have hzero : ((2 ^ m - 1 : ℕ) : ZMod p) = 0 := by
    rw [CharP.cast_eq_zero_iff]
    exact hpm
  have hcastSub : ((2 ^ m - 1 : ℕ) : ZMod p) =
      (2 : ZMod p) ^ m - 1 := by
    rw [Nat.cast_sub (one_le_pow₀ (by norm_num))]
    simp
  rw [hcastSub] at hzero
  exact sub_eq_zero.mp hzero

/-- The exact order block of a prime divisor divides the Mersenne index. -/
theorem mersenneExactOrder_dvd_index {m p : ℕ}
    (hp : p.Prime) (hpm : p ∣ 2 ^ m - 1) :
    mersenneExactOrder p ∣ m := by
  letI : Fact p.Prime := ⟨hp⟩
  unfold mersenneExactOrder
  exact orderOf_dvd_of_pow_eq_one
    (zmod_two_pow_eq_one_of_prime_dvd_mersenne hp hpm)

/-- The exact order block of a prime divisor divides `p - 1`. -/
theorem mersenneExactOrder_dvd_prime_sub_one {m p : ℕ}
    (hm : 0 < m) (hp : p.Prime) (hpm : p ∣ 2 ^ m - 1) :
    mersenneExactOrder p ∣ p - 1 := by
  letI : Fact p.Prime := ⟨hp⟩
  unfold mersenneExactOrder
  apply ZMod.orderOf_dvd_card_sub_one
  intro hzero
  have hpdiv2 : p ∣ 2 :=
    (CharP.cast_eq_zero_iff (ZMod p) p 2).mp hzero
  have hp2 : p = 2 :=
    (Nat.prime_dvd_prime_iff_eq hp Nat.prime_two).mp hpdiv2
  exact (prime_ne_two_of_dvd_mersenne hm hp hpm) hp2

/-- The step prime cannot divide its own exact-order block. -/
theorem prime_not_dvd_mersenneExactOrder {m p : ℕ}
    (hm : 0 < m) (hp : p.Prime) (hpm : p ∣ 2 ^ m - 1) :
    ¬ p ∣ mersenneExactOrder p := by
  intro hpd
  have hdvdm : mersenneExactOrder p ∣ m :=
    mersenneExactOrder_dvd_index hp hpm
  have hdpos : 0 < mersenneExactOrder p :=
    Nat.pos_of_dvd_of_pos hdvdm hm
  have hdvdPred : mersenneExactOrder p ∣ p - 1 :=
    mersenneExactOrder_dvd_prime_sub_one hm hp hpm
  have hp2 : p ≠ 2 := prime_ne_two_of_dvd_mersenne hm hp hpm
  have hpge : 2 ≤ p := hp.two_le
  have hpredpos : 0 < p - 1 := by omega
  have hdle : mersenneExactOrder p ≤ p - 1 :=
    Nat.le_of_dvd hpredpos hdvdPred
  have hple : p ≤ mersenneExactOrder p := Nat.le_of_dvd hdpos hpd
  omega

/-- The exact order itself supplies the base Mersenne divisibility. -/
theorem prime_dvd_exactOrder_mersenne {m p : ℕ}
    (hm : 0 < m) (hp : p.Prime) (hpm : p ∣ 2 ^ m - 1) :
    p ∣ 2 ^ mersenneExactOrder p - 1 := by
  letI : Fact p.Prime := ⟨hp⟩
  have hdvdm : mersenneExactOrder p ∣ m :=
    mersenneExactOrder_dvd_index hp hpm
  have hdpos : 0 < mersenneExactOrder p :=
    Nat.pos_of_dvd_of_pos hdvdm hm
  have hpow : (2 : ZMod p) ^ mersenneExactOrder p = 1 := by
    unfold mersenneExactOrder
    exact pow_orderOf_eq_one _
  have hzero :
      (((2 ^ mersenneExactOrder p - 1 : ℕ) : ZMod p)) = 0 := by
    rw [Nat.cast_sub (one_le_pow₀ (by norm_num))]
    simp only [Nat.cast_pow, Nat.cast_ofNat]
    simpa using (sub_eq_zero.mpr hpow)
  exact (CharP.cast_eq_zero_iff (ZMod p) p _).mp hzero

/-- Local LTE written at the actual exact-order block.  The lifting term is
exactly the `p`-adic exponent of the global index `m`. -/
theorem factorization_mersenne_eq_exactOrder_add_index
    {m p : ℕ} (hm : 0 < m) (hp : p.Prime)
    (hpm : p ∣ 2 ^ m - 1) :
    (2 ^ m - 1).factorization p =
      (2 ^ mersenneExactOrder p - 1).factorization p +
        m.factorization p := by
  let d := mersenneExactOrder p
  let k := m / d
  have hdvdm : d ∣ m := mersenneExactOrder_dvd_index hp hpm
  have hdpos : 0 < d := Nat.pos_of_dvd_of_pos hdvdm hm
  have hdk : d * k = m := by
    exact Nat.mul_div_cancel' hdvdm
  have hk : k ≠ 0 := by
    intro hk0
    rw [hk0, mul_zero] at hdk
    omega
  have hpneTwo : p ≠ 2 := prime_ne_two_of_dvd_mersenne hm hp hpm
  have hpodd : Odd p := hp.odd_of_ne_two hpneTwo
  have hpd : p ∣ 2 ^ d - 1 := by
    simpa [d] using prime_dvd_exactOrder_mersenne hm hp hpm
  have hpdOrder : ¬ p ∣ d := by
    simpa [d] using prime_not_dvd_mersenneExactOrder hm hp hpm
  have hdfac : d.factorization p = 0 := by
    rw [Nat.factorization_def _ hp,
      padicValNat.eq_zero_of_not_dvd hpdOrder]
  have hkfac : k.factorization p = m.factorization p := by
    rw [← hdk, Nat.factorization_mul hdpos.ne' hk]
    simp [hdfac]
  have hlte := factorization_two_pow_mul_sub_one
    p d k hp hpodd hdpos hk hpd
  rw [hdk, hkfac] at hlte
  simpa [d] using hlte

/-- A prime divisor of `2^m - 1` occurs there to strictly greater depth than
it occurs in the index `m`. -/
theorem factorization_index_lt_mersenne
    {m p : ℕ} (hm : 0 < m) (hp : p.Prime)
    (hpm : p ∣ 2 ^ m - 1) :
    m.factorization p < (2 ^ m - 1).factorization p := by
  have hdvdm : mersenneExactOrder p ∣ m :=
    mersenneExactOrder_dvd_index hp hpm
  have hdpos : 0 < mersenneExactOrder p :=
    Nat.pos_of_dvd_of_pos hdvdm hm
  have hbaseNe : 2 ^ mersenneExactOrder p - 1 ≠ 0 :=
    (mersenne_sub_one_pos hdpos).ne'
  have hbaseDvd : p ∣ 2 ^ mersenneExactOrder p - 1 :=
    prime_dvd_exactOrder_mersenne hm hp hpm
  have hbaseFac :
      1 ≤ (2 ^ mersenneExactOrder p - 1).factorization p :=
    (hp.dvd_iff_one_le_factorization hbaseNe).mp hbaseDvd
  rw [factorization_mersenne_eq_exactOrder_add_index hm hp hpm]
  omega

/-- At every supported prime, the gcd realization of the lifting factor
contains exactly the full `p`-adic exponent of the index. -/
theorem factorization_liftingFactor_eq_index
    {m p : ℕ} (hm : 0 < m) (hp : p.Prime)
    (hpm : p ∣ 2 ^ m - 1) :
    (mersenneLiftingFactor m).factorization p = m.factorization p := by
  unfold mersenneLiftingFactor
  rw [Nat.factorization_gcd hm.ne' (mersenne_sub_one_pos hm).ne',
    Finsupp.inf_apply]
  exact inf_eq_left.mpr
    (Nat.le_of_lt (factorization_index_lt_mersenne hm hp hpm))

/-- Removing one radical copy lowers the factorization at a supported prime
by exactly one. -/
theorem factorization_powerfulPart_add_one
    {n p : ℕ} (hn : 0 < n) (hp : p.Prime) (hpn : p ∣ n) :
    (abcPowerfulPart n).factorization p + 1 = n.factorization p := by
  have hfactor := abcRadical_mul_abcPowerfulPart n
  have hr : abcRadical n ≠ 0 := (abcRadical_pos n).ne'
  have hq : abcPowerfulPart n ≠ 0 := by
    intro hz
    rw [hz, mul_zero] at hfactor
    omega
  have hsf : Squarefree (abcRadical n) := by
    rw [abcRadical_eq_natRadical]
    exact UniqueFactorizationMonoid.squarefree_radical
  have hrfacLe : (abcRadical n).factorization p ≤ 1 :=
    hsf.natFactorization_le_one p
  have hpRad : p ∣ abcRadical n := by
    rw [abcRadical_eq_natRadical]
    exact
      (UniqueFactorizationMonoid.dvd_radical_iff
        hp.squarefree.isRadical hn.ne').2 hpn
  have hrfacGe : 1 ≤ (abcRadical n).factorization p :=
    (hp.dvd_iff_one_le_factorization hr).mp hpRad
  have hrfac : (abcRadical n).factorization p = 1 := by omega
  have heq := congrArg (fun z : ℕ => z.factorization p) hfactor
  rw [Nat.factorization_mul hr hq] at heq
  change (abcRadical n).factorization p +
    (abcPowerfulPart n).factorization p = n.factorization p at heq
  omega

/-- The Mersenne power loss is positive at every positive index. -/
theorem mersennePowerLoss_pos {m : ℕ} (hm : 0 < m) :
    0 < mersennePowerLoss m := by
  have hfactor := mersenneRadical_mul_powerLoss m
  by_contra hnot
  have hzero : mersennePowerLoss m = 0 := Nat.eq_zero_of_not_pos hnot
  rw [hzero, mul_zero] at hfactor
  have hmpos := mersenne_sub_one_pos hm
  omega

/-- The natural lifting factor divides the full Mersenne power loss. -/
theorem mersenneLiftingFactor_dvd_powerLoss
    {m : ℕ} (hm : 0 < m) :
    mersenneLiftingFactor m ∣ mersennePowerLoss m := by
  have hLpos : 0 < mersenneLiftingFactor m := by
    unfold mersenneLiftingFactor
    exact Nat.gcd_pos_of_pos_left _ hm
  have hWpos : 0 < mersennePowerLoss m := mersennePowerLoss_pos hm
  rw [← Nat.factorization_prime_le_iff_dvd hLpos.ne' hWpos.ne']
  intro p hp
  by_cases hpL : p ∣ mersenneLiftingFactor m
  · have hpM : p ∣ 2 ^ m - 1 :=
      hpL.trans (mersenneLiftingFactor_dvd_mersenne m)
    have hLfacLe :
        (mersenneLiftingFactor m).factorization p ≤ m.factorization p :=
      (Nat.factorization_prime_le_iff_dvd hLpos.ne' hm.ne').2
        (mersenneLiftingFactor_dvd_index m) p hp
    have hgt : m.factorization p < (2 ^ m - 1).factorization p :=
      factorization_index_lt_mersenne hm hp hpM
    have hloss :
        (mersennePowerLoss m).factorization p + 1 =
          (2 ^ m - 1).factorization p :=
      factorization_powerfulPart_add_one (mersenne_sub_one_pos hm) hp hpM
    omega
  · have hzero : (mersenneLiftingFactor m).factorization p = 0 := by
      rw [Nat.factorization_def _ hp,
        padicValNat.eq_zero_of_not_dvd hpL]
    simp [hzero]

/-- What remains of the power loss after exact natural division by the
lifting factor. -/
def mersenneBaseQuotient (m : ℕ) : ℕ :=
  mersennePowerLoss m / mersenneLiftingFactor m

/-- The actual global natural-number decomposition of the full Mersenne
power loss into lifting factor and base quotient. -/
theorem mersennePowerLoss_eq_lifting_mul_base
    {m : ℕ} (hm : 0 < m) :
    mersennePowerLoss m =
      mersenneLiftingFactor m * mersenneBaseQuotient m := by
  rw [mersenneBaseQuotient]
  exact (Nat.mul_div_cancel'
    (mersenneLiftingFactor_dvd_powerLoss hm)).symm

/-- The base quotient is positive at every positive index. -/
theorem mersenneBaseQuotient_pos {m : ℕ} (hm : 0 < m) :
    0 < mersenneBaseQuotient m := by
  have hdecomp := mersennePowerLoss_eq_lifting_mul_base hm
  by_contra hnot
  have hzero : mersenneBaseQuotient m = 0 := Nat.eq_zero_of_not_pos hnot
  rw [hzero, mul_zero] at hdecomp
  have hWpos := mersennePowerLoss_pos hm
  omega

/-- The base quotient is an actual divisor of the full power loss. -/
theorem mersenneBaseQuotient_dvd_powerLoss {m : ℕ} (hm : 0 < m) :
    mersenneBaseQuotient m ∣ mersennePowerLoss m := by
  refine ⟨mersenneLiftingFactor m, ?_⟩
  rw [Nat.mul_comm, ← mersennePowerLoss_eq_lifting_mul_base hm]

/-- Prime by prime, the global base quotient retains precisely the excess
already present in the exact-order block: its exponent plus one is the base
block exponent.  This is the local arithmetic content of the paper's `E_d`
grouping, without introducing an additional finite-product encoding. -/
theorem factorization_baseQuotient_add_one_eq_exactOrder
    {m p : ℕ} (hm : 0 < m) (hp : p.Prime)
    (hpm : p ∣ 2 ^ m - 1) :
    (mersenneBaseQuotient m).factorization p + 1 =
      (2 ^ mersenneExactOrder p - 1).factorization p := by
  have hLpos : 0 < mersenneLiftingFactor m := by
    unfold mersenneLiftingFactor
    exact Nat.gcd_pos_of_pos_left _ hm
  have hBpos : 0 < mersenneBaseQuotient m :=
    mersenneBaseQuotient_pos hm
  have hdecomp := mersennePowerLoss_eq_lifting_mul_base hm
  have hfac := congrArg (fun z : ℕ => z.factorization p) hdecomp
  rw [Nat.factorization_mul hLpos.ne' hBpos.ne'] at hfac
  change (mersennePowerLoss m).factorization p =
    (mersenneLiftingFactor m).factorization p +
      (mersenneBaseQuotient m).factorization p at hfac
  have hLfac := factorization_liftingFactor_eq_index hm hp hpm
  have htotal :=
    factorization_mersenne_eq_exactOrder_add_index hm hp hpm
  have hloss := factorization_powerfulPart_add_one
    (mersenne_sub_one_pos hm) hp hpm
  have hloss' :
      (mersennePowerLoss m).factorization p + 1 =
        (2 ^ m - 1).factorization p := by
    simpa [mersennePowerLoss] using hloss
  rw [hLfac] at hfac
  have hstart :
      m.factorization p +
          ((mersenneBaseQuotient m).factorization p + 1) =
        (mersennePowerLoss m).factorization p + 1 := by
    rw [hfac]
    omega
  have hchain :
      m.factorization p +
          ((mersenneBaseQuotient m).factorization p + 1) =
        (2 ^ mersenneExactOrder p - 1).factorization p +
          m.factorization p :=
    hstart.trans (hloss'.trans htotal)
  have hadd :
      m.factorization p +
          ((mersenneBaseQuotient m).factorization p + 1) =
        m.factorization p +
          (2 ^ mersenneExactOrder p - 1).factorization p :=
    hchain.trans (Nat.add_comm _ _)
  exact Nat.add_left_cancel hadd

/-! ## Finite exact-order blocks -/

/-- The finite block at divisor `d` of a fixed index `m`.  Its support is
restricted to the actual prime divisors of `2^m - 1`; each exponent is the
base exact-order exponent with its one radical copy removed. -/
noncomputable def mersenneOrderBlock (m d : ℕ) : ℕ :=
  ∏ p ∈ (2 ^ m - 1).primeFactors with mersenneExactOrder p = d,
    p ^ ((2 ^ d - 1).factorization p - 1)

/-- Product of all finite exact-order blocks indexed by divisors of `m`. -/
noncomputable def mersenneOrderBlockProduct (m : ℕ) : ℕ :=
  ∏ d ∈ m.divisors, mersenneOrderBlock m d

/-- Reconstruction of the base quotient directly from its supported prime
coordinates.  This is the prime-by-prime form just before grouping by exact
order. -/
theorem mersenneBaseQuotient_eq_primeProduct
    {m : ℕ} (hm : 0 < m) :
    mersenneBaseQuotient m =
      ∏ p ∈ (2 ^ m - 1).primeFactors,
        p ^ ((2 ^ mersenneExactOrder p - 1).factorization p - 1) := by
  classical
  have hBpos : 0 < mersenneBaseQuotient m :=
    mersenneBaseQuotient_pos hm
  have hBdM : mersenneBaseQuotient m ∣ 2 ^ m - 1 :=
    (mersenneBaseQuotient_dvd_powerLoss hm).trans
      (abcPowerfulPart_dvd (2 ^ m - 1))
  have hsubset :
      (mersenneBaseQuotient m).primeFactors ⊆
        (2 ^ m - 1).primeFactors :=
    Nat.primeFactors_mono hBdM (mersenne_sub_one_pos hm).ne'
  calc
    mersenneBaseQuotient m =
        ∏ p ∈ (mersenneBaseQuotient m).primeFactors,
          p ^ (mersenneBaseQuotient m).factorization p :=
      Nat.prod_primeFactors_pow_factorization hBpos.ne'
    _ = ∏ p ∈ (2 ^ m - 1).primeFactors,
          p ^ (mersenneBaseQuotient m).factorization p := by
      apply Finset.prod_subset_one_on_sdiff hsubset
      · intro p hpDiff
        have hpM : p ∈ (2 ^ m - 1).primeFactors :=
          (Finset.mem_sdiff.mp hpDiff).1
        have hp : p.Prime := Nat.prime_of_mem_primeFactors hpM
        have hpNotMem : p ∉ (mersenneBaseQuotient m).primeFactors :=
          (Finset.mem_sdiff.mp hpDiff).2
        have hpNotDvd : ¬ p ∣ mersenneBaseQuotient m := by
          intro hpDvd
          exact hpNotMem (Nat.mem_primeFactors.mpr
            ⟨hp, hpDvd, hBpos.ne'⟩)
        rw [Nat.factorization_eq_zero_of_not_dvd hpNotDvd, pow_zero]
      · intro p hpB
        rfl
    _ = ∏ p ∈ (2 ^ m - 1).primeFactors,
          p ^ ((2 ^ mersenneExactOrder p - 1).factorization p - 1) := by
      refine Finset.prod_congr rfl ?_
      intro p hpM
      have hp : p.Prime := Nat.prime_of_mem_primeFactors hpM
      have hpDvd : p ∣ 2 ^ m - 1 := Nat.dvd_of_mem_primeFactors hpM
      have hlocal :=
        factorization_baseQuotient_add_one_eq_exactOrder hm hp hpDvd
      have hexp :
          (mersenneBaseQuotient m).factorization p =
            (2 ^ mersenneExactOrder p - 1).factorization p - 1 := by
        omega
      exact congrArg (fun e : ℕ => p ^ e) hexp
    _ = ∏ p ∈ (2 ^ m - 1).primeFactors,
          p ^ ((2 ^ mersenneExactOrder p - 1).factorization p - 1) := rfl
  simp

/-- Inside a fixed order fiber, the displayed `d` in the base Mersenne
exponent can be replaced by the exact order of the running prime. -/
theorem mersenneOrderBlock_eq_orderExponent (m d : ℕ) :
    mersenneOrderBlock m d =
      ∏ p ∈ (2 ^ m - 1).primeFactors with mersenneExactOrder p = d,
        p ^ ((2 ^ mersenneExactOrder p - 1).factorization p - 1) := by
  classical
  unfold mersenneOrderBlock
  refine Finset.prod_congr rfl ?_
  intro p hpFiber
  have hpOrder : mersenneExactOrder p = d :=
    (Finset.mem_filter.mp hpFiber).2
  rw [hpOrder]

/-- Every supported prime is sent by its exact-order map to an actual divisor
of the fixed positive index. -/
theorem mersenneExactOrder_mem_divisors
    {m p : ℕ} (hm : 0 < m) (hpM : p ∈ (2 ^ m - 1).primeFactors) :
    mersenneExactOrder p ∈ m.divisors := by
  have hp : p.Prime := Nat.prime_of_mem_primeFactors hpM
  have hpDvd : p ∣ 2 ^ m - 1 := Nat.dvd_of_mem_primeFactors hpM
  exact Nat.mem_divisors.mpr
    ⟨mersenneExactOrder_dvd_index hp hpDvd, hm.ne'⟩

/-- Exact finite fiber decomposition: multiplying the blocks over all
divisors of `m` is precisely the supported prime product. -/
theorem mersenneOrderBlockProduct_eq_primeProduct
    {m : ℕ} (hm : 0 < m) :
    mersenneOrderBlockProduct m =
      ∏ p ∈ (2 ^ m - 1).primeFactors,
        p ^ ((2 ^ mersenneExactOrder p - 1).factorization p - 1) := by
  classical
  unfold mersenneOrderBlockProduct
  simp_rw [mersenneOrderBlock_eq_orderExponent]
  exact Finset.prod_fiberwise_of_maps_to
    (fun p hpM => mersenneExactOrder_mem_divisors hm hpM)
    (fun p => p ^
      ((2 ^ mersenneExactOrder p - 1).factorization p - 1))

/-- The base quotient is exactly the product of the paper's finite
exact-order blocks `E_d`, with support restricted to the primes actually
occurring at the fixed index `m`. -/
theorem mersenneBaseQuotient_eq_orderBlockProduct
    {m : ℕ} (hm : 0 < m) :
    mersenneBaseQuotient m = mersenneOrderBlockProduct m := by
  rw [mersenneBaseQuotient_eq_primeProduct hm,
    mersenneOrderBlockProduct_eq_primeProduct hm]

/-- Full arithmetic order-block decomposition from equation (1.2): the
Mersenne power loss is the lifting factor times the finite exact-order block
product. -/
theorem mersennePowerLoss_eq_lifting_mul_orderBlockProduct
    {m : ℕ} (hm : 0 < m) :
    mersennePowerLoss m =
      mersenneLiftingFactor m * mersenneOrderBlockProduct m := by
  rw [mersennePowerLoss_eq_lifting_mul_base hm,
    mersenneBaseQuotient_eq_orderBlockProduct hm]

/-- Equivalently, the lifting factor is the entire common part of the index
and the full Mersenne power loss. -/
theorem mersenneLiftingFactor_eq_gcd_index_powerLoss
    {m : ℕ} (hm : 0 < m) :
    mersenneLiftingFactor m = Nat.gcd m (mersennePowerLoss m) := by
  apply Nat.dvd_antisymm
  · exact Nat.dvd_gcd
      (mersenneLiftingFactor_dvd_index m)
      (mersenneLiftingFactor_dvd_powerLoss hm)
  · apply Nat.dvd_gcd
    · exact Nat.gcd_dvd_left _ _
    · exact (Nat.gcd_dvd_right m (mersennePowerLoss m)).trans
        (abcPowerfulPart_dvd (2 ^ m - 1))

/-- The index-six audit realizes exactly the missing lifting factor `3`. -/
theorem mersenneLiftingFactor_six :
    mersenneLiftingFactor 6 = 3 := by
  norm_num [mersenneLiftingFactor]

/-- The elementary factorization behind the index-six numerical audit. -/
theorem mersenne_six_factorization_local :
    2 ^ 6 - 1 = 3 ^ 2 * 7 := by
  norm_num

/-- Complete prime support of the index-six Mersenne value, proved locally so
this module does not depend on the concurrently developed prime-layer file. -/
theorem mersenne_six_support_local :
    (2 ^ 6 - 1).primeFactors = {3, 7} := by
  have hcop : Nat.Coprime (3 ^ 2) 7 := by norm_num
  rw [mersenne_six_factorization_local, hcop.primeFactors_mul]
  rw [Nat.primeFactors_prime_pow (by norm_num : 2 ≠ 0) Nat.prime_three]
  simp [(by norm_num : Nat.Prime 7).primeFactors]

/-- Exact radical of the index-six Mersenne value. -/
theorem mersenne_six_radical_local :
    abcRadical (2 ^ 6 - 1) = 21 := by
  unfold abcRadical
  rw [mersenne_six_support_local]
  norm_num

/-- Exact power loss at index six. -/
theorem mersennePowerLoss_six :
    mersennePowerLoss 6 = 3 := by
  unfold mersennePowerLoss abcPowerfulPart
  rw [mersenne_six_radical_local]
  norm_num

/-- At index six the base quotient is one: the entire power loss is the
lifting factor. -/
theorem mersenneBaseQuotient_six :
    mersenneBaseQuotient 6 = 1 := by
  norm_num [mersenneBaseQuotient, mersennePowerLoss_six,
    mersenneLiftingFactor_six]

/-- At index six all finite base blocks multiply to one. -/
theorem mersenneOrderBlockProduct_six :
    mersenneOrderBlockProduct 6 = 1 := by
  rw [← mersenneBaseQuotient_eq_orderBlockProduct (by norm_num : 0 < 6)]
  exact mersenneBaseQuotient_six

/-- Fully numerical instance of `W_m = L_m B_m` at `m = 6`. -/
theorem mersennePowerLoss_six_decomposition :
    mersennePowerLoss 6 =
      mersenneLiftingFactor 6 * mersenneBaseQuotient 6 := by
  rw [mersennePowerLoss_six, mersenneLiftingFactor_six,
    mersenneBaseQuotient_six]

/-- Fully numerical exact-order-block instance: `3 = 3 * 1`. -/
theorem mersennePowerLoss_six_orderBlockDecomposition :
    mersennePowerLoss 6 =
      mersenneLiftingFactor 6 * mersenneOrderBlockProduct 6 := by
  rw [mersennePowerLoss_six, mersenneLiftingFactor_six,
    mersenneOrderBlockProduct_six]

#print axioms mersenneLiftingFactor_dvd_index
#print axioms mersenneLiftingFactor_dvd_mersenne
#print axioms mersenne_sub_one_pos
#print axioms prime_ne_two_of_dvd_mersenne
#print axioms zmod_two_pow_eq_one_of_prime_dvd_mersenne
#print axioms mersenneExactOrder_dvd_index
#print axioms mersenneExactOrder_dvd_prime_sub_one
#print axioms prime_not_dvd_mersenneExactOrder
#print axioms prime_dvd_exactOrder_mersenne
#print axioms factorization_mersenne_eq_exactOrder_add_index
#print axioms factorization_index_lt_mersenne
#print axioms factorization_liftingFactor_eq_index
#print axioms factorization_powerfulPart_add_one
#print axioms mersennePowerLoss_pos
#print axioms mersenneLiftingFactor_dvd_powerLoss
#print axioms mersennePowerLoss_eq_lifting_mul_base
#print axioms mersenneBaseQuotient_pos
#print axioms mersenneBaseQuotient_dvd_powerLoss
#print axioms factorization_baseQuotient_add_one_eq_exactOrder
#print axioms mersenneBaseQuotient_eq_primeProduct
#print axioms mersenneOrderBlock_eq_orderExponent
#print axioms mersenneExactOrder_mem_divisors
#print axioms mersenneOrderBlockProduct_eq_primeProduct
#print axioms mersenneBaseQuotient_eq_orderBlockProduct
#print axioms mersennePowerLoss_eq_lifting_mul_orderBlockProduct
#print axioms mersenneLiftingFactor_eq_gcd_index_powerLoss
#print axioms mersenneLiftingFactor_six
#print axioms mersenne_six_factorization_local
#print axioms mersenne_six_support_local
#print axioms mersenne_six_radical_local
#print axioms mersennePowerLoss_six
#print axioms mersenneBaseQuotient_six
#print axioms mersenneOrderBlockProduct_six
#print axioms mersennePowerLoss_six_decomposition
#print axioms mersennePowerLoss_six_orderBlockDecomposition

end MersenneOrderBlockDecomposition20260901
end IUTThreeClosures
