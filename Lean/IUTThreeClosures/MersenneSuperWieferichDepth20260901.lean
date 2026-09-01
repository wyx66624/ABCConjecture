/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneCanonicalBlockWitness20260901
import IUTThreeClosures.MersenneWieferichTailReduction20260901
import Mathlib.Algebra.Order.BigOperators.Group.Finset
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-!
# Super-Wieferich depth layers in canonical Mersenne blocks

The paper proofs precede this file in
`research/ABC_MERSENNE_SUPER_WIEFERICH_DEPTH_2026_09_01.md`.

For a finite super-Wieferich support, a prime of canonical depth `w`
contributes `(w - 2) * log q` to the genuinely deep mass.  This module proves
the exact layer-cake identity and, for every threshold `K ≥ 2`, the split

`w - 2 = min (w - 2) (K - 2) + (w - K)`.

Consequently the deep mass is at most

`(K - 2) * (one-copy super support mass) + (mass above depth K)`.

The resulting moving-threshold theorem is sufficient to make the deep factor
`D_d` little-oh of `phi(d)`.  Combined with a little-oh bound for the repeated
support factor `T_d`, it proves the existing Mersenne endpoint.  Both analytic
inputs remain explicit hypotheses.

The final section gives a complete counterexample to the tempting parity
strengthening that every base-two Wieferich prime has even exact order:

`ord_3511(2) = 1755` and `v_3511(2^1755 - 1) = 2`.

No finite no-hit computation, abc statement, super-Wieferich finiteness
claim, or fixed-base distribution assertion is assumed.
-/

namespace IUTThreeClosures
namespace MersenneSuperWieferichDepth20260901

open Filter Asymptotics
open scoped BigOperators Topology
open MersenneOrderBlockDecomposition20260901
open MersenneOrderBlockAsymptotic20260901

/-! ## Abstract finite depth masses -/

/-- Full excess above the first two copies of every support factor. -/
def depthExcessMass {ι : Type*} (s : Finset ι)
    (depth : ι → ℕ) (weight : ι → ℝ) : ℝ :=
  ∑ x ∈ s, ((depth x - 2 : ℕ) : ℝ) * weight x

/-- The part of the depth excess retained after capping the residual depth at
`K - 2`. -/
def depthTruncatedMass {ι : Type*} (s : Finset ι)
    (depth : ι → ℕ) (weight : ι → ℝ) (K : ℕ) : ℝ :=
  ∑ x ∈ s,
    ((min (depth x - 2) (K - 2) : ℕ) : ℝ) * weight x

/-- The residual mass strictly above the threshold `K`. -/
def depthTailMass {ι : Type*} (s : Finset ι)
    (depth : ι → ℕ) (weight : ι → ℝ) (K : ℕ) : ℝ :=
  ∑ x ∈ s, ((depth x - K : ℕ) : ℝ) * weight x

/-- One copy of every factor in the selected support. -/
def depthSupportMass {ι : Type*} (s : Finset ι)
    (weight : ι → ℝ) : ℝ :=
  ∑ x ∈ s, weight x

/-- The logarithmic layer formed by support points of depth at least `j`. -/
def depthLayerMass {ι : Type*} (s : Finset ι)
    (depth : ι → ℕ) (weight : ι → ℝ) (j : ℕ) : ℝ :=
  ∑ x ∈ s, if j ≤ depth x then weight x else 0

/-- Truncated subtraction splits a residual depth into a capped part and its
tail.  No lower bound on `w` is needed. -/
theorem nat_depthExcess_split {w K : ℕ} (hK : 2 ≤ K) :
    w - 2 = min (w - 2) (K - 2) + (w - K) := by
  simp only [min_def]
  split_ifs <;> omega

/-- Exact finite threshold decomposition of a weighted depth mass. -/
theorem depthExcessMass_eq_truncated_add_tail
    {ι : Type*} (s : Finset ι) (depth : ι → ℕ)
    (weight : ι → ℝ) (K : ℕ) (hK : 2 ≤ K) :
    depthExcessMass s depth weight =
      depthTruncatedMass s depth weight K +
        depthTailMass s depth weight K := by
  unfold depthExcessMass depthTruncatedMass depthTailMass
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro x _hx
  rw [← add_mul]
  congr 1
  exact_mod_cast nat_depthExcess_split (w := depth x) hK

/-- The capped part costs at most `K - 2` copies of the one-copy support. -/
theorem depthTruncatedMass_le_cap_mul_support
    {ι : Type*} (s : Finset ι) (depth : ι → ℕ)
    (weight : ι → ℝ) (K : ℕ)
    (hweight : ∀ x ∈ s, 0 ≤ weight x) :
    depthTruncatedMass s depth weight K ≤
      ((K - 2 : ℕ) : ℝ) * depthSupportMass s weight := by
  unfold depthTruncatedMass depthSupportMass
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro x hx
  exact mul_le_mul_of_nonneg_right
    (by exact_mod_cast Nat.min_le_right (depth x - 2) (K - 2))
    (hweight x hx)

/-- The finite moving-threshold upper bound before taking any limit. -/
theorem depthExcessMass_le_cap_mul_support_add_tail
    {ι : Type*} (s : Finset ι) (depth : ι → ℕ)
    (weight : ι → ℝ) (K : ℕ) (hK : 2 ≤ K)
    (hweight : ∀ x ∈ s, 0 ≤ weight x) :
    depthExcessMass s depth weight ≤
      ((K - 2 : ℕ) : ℝ) * depthSupportMass s weight +
        depthTailMass s depth weight K := by
  rw [depthExcessMass_eq_truncated_add_tail s depth weight K hK]
  exact add_le_add
    (depthTruncatedMass_le_cap_mul_support s depth weight K hweight)
    (le_refl _)

/-- If all selected depths are at most `K`, the high-depth tail vanishes. -/
theorem depthTailMass_eq_zero_of_depth_le
    {ι : Type*} (s : Finset ι) (depth : ι → ℕ)
    (weight : ι → ℝ) (K : ℕ)
    (hdepth : ∀ x ∈ s, depth x ≤ K) :
    depthTailMass s depth weight K = 0 := by
  unfold depthTailMass
  apply Finset.sum_eq_zero
  intro x hx
  rw [Nat.sub_eq_zero_of_le (hdepth x hx)]
  norm_num

/-- A uniform depth ceiling reduces the whole deep mass to the one-copy
support mass. -/
theorem depthExcessMass_le_cap_mul_support_of_depth_le
    {ι : Type*} (s : Finset ι) (depth : ι → ℕ)
    (weight : ι → ℝ) (K : ℕ) (hK : 2 ≤ K)
    (hweight : ∀ x ∈ s, 0 ≤ weight x)
    (hdepth : ∀ x ∈ s, depth x ≤ K) :
    depthExcessMass s depth weight ≤
      ((K - 2 : ℕ) : ℝ) * depthSupportMass s weight := by
  rw [depthExcessMass_eq_truncated_add_tail s depth weight K hK,
    depthTailMass_eq_zero_of_depth_le s depth weight K hdepth, add_zero]
  exact depthTruncatedMass_le_cap_mul_support s depth weight K hweight

/-- A large deep mass forces either a large one-copy support or a tail above
the selected threshold.  This division-free form is convenient over `ℝ`. -/
theorem depth_support_or_tail_of_large_excess
    {ι : Type*} (s : Finset ι) (depth : ι → ℕ)
    (weight : ι → ℝ) (K : ℕ) {target : ℝ}
    (hK : 2 < K)
    (hweight : ∀ x ∈ s, 0 ≤ weight x)
    (hlarge : target ≤ depthExcessMass s depth weight) :
    target ≤
        2 * ((K - 2 : ℕ) : ℝ) * depthSupportMass s weight ∨
      target / 2 ≤ depthTailMass s depth weight K := by
  by_contra h
  push Not at h
  rcases h with ⟨hsupport, htail⟩
  have htruncated :=
    depthTruncatedMass_le_cap_mul_support s depth weight K hweight
  have hsplit :=
    depthExcessMass_eq_truncated_add_tail s depth weight K hK.le
  linarith

/-- Cardinal-style normalized form of the frequency/depth dichotomy. -/
theorem depth_support_or_tail_of_large_excess_div
    {ι : Type*} (s : Finset ι) (depth : ι → ℕ)
    (weight : ι → ℝ) (K : ℕ) {target : ℝ}
    (hK : 2 < K)
    (hweight : ∀ x ∈ s, 0 ≤ weight x)
    (hlarge : target ≤ depthExcessMass s depth weight) :
    target / (2 * ((K - 2 : ℕ) : ℝ)) ≤
        depthSupportMass s weight ∨
      target / 2 ≤ depthTailMass s depth weight K := by
  rcases depth_support_or_tail_of_large_excess
      s depth weight K hK hweight hlarge with hsupport | htail
  · left
    have hdenom : 0 < 2 * ((K - 2 : ℕ) : ℝ) := by
      have hkNat : 0 < K - 2 := Nat.sub_pos_of_lt hK
      exact mul_pos (by norm_num) (by exact_mod_cast hkNat)
    exact (div_le_iff₀ hdenom).2
      (by simpa [mul_assoc, mul_comm, mul_left_comm] using hsupport)
  · exact Or.inr htail

/-! ## Exact layer-cake identities -/

/-- The number of integral layers from `3` through a depth `w` is `w - 2`. -/
theorem depthLayer_count (w M : ℕ) (hw : w ≤ M) :
    (∑ j ∈ Finset.Icc 3 M, if j ≤ w then (1 : ℕ) else 0) = w - 2 := by
  calc
    (∑ j ∈ Finset.Icc 3 M, if j ≤ w then (1 : ℕ) else 0) =
        ((Finset.Icc 3 M).filter (fun j => j ≤ w)).card := by simp
    _ = (Finset.Icc 3 w).card := by
      congr 1
      ext j
      simp only [Finset.mem_filter, Finset.mem_Icc]
      omega
    _ = w - 2 := by
      rw [Nat.card_Icc]
      omega

/-- Weighted form of `depthLayer_count`. -/
theorem weighted_depthLayer_sum
    (w M : ℕ) (a : ℝ) (hw : w ≤ M) :
    (∑ j ∈ Finset.Icc 3 M, if j ≤ w then a else 0) =
      ((w - 2 : ℕ) : ℝ) * a := by
  calc
    (∑ j ∈ Finset.Icc 3 M, if j ≤ w then a else 0) =
        ∑ j ∈ Finset.Icc 3 M,
          (if j ≤ w then (1 : ℝ) else 0) * a := by
      apply Finset.sum_congr rfl
      intro j _hj
      split_ifs <;> simp_all
    _ = (∑ j ∈ Finset.Icc 3 M,
          (if j ≤ w then (1 : ℝ) else 0)) * a := by
      rw [Finset.sum_mul]
    _ = ((w - 2 : ℕ) : ℝ) * a := by
      congr 1
      exact_mod_cast depthLayer_count w M hw

/-- Exact finite layer-cake identity for the full depth excess. -/
theorem depthExcessMass_eq_sum_layers
    {ι : Type*} (s : Finset ι) (depth : ι → ℕ)
    (weight : ι → ℝ) (M : ℕ)
    (hdepth : ∀ x ∈ s, depth x ≤ M) :
    depthExcessMass s depth weight =
      ∑ j ∈ Finset.Icc 3 M, depthLayerMass s depth weight j := by
  unfold depthExcessMass depthLayerMass
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro x hx
  exact (weighted_depthLayer_sum
    (depth x) M (weight x) (hdepth x hx)).symm

/-- The tail above `K` is exactly the sum of layers `K+1, ..., M`. -/
theorem depthTailMass_eq_sum_layersAbove
    {ι : Type*} (s : Finset ι) (depth : ι → ℕ)
    (weight : ι → ℝ) (K M : ℕ)
    (hdepth : ∀ x ∈ s, depth x ≤ M) :
    depthTailMass s depth weight K =
      ∑ j ∈ Finset.Icc (K + 1) M,
        depthLayerMass s depth weight j := by
  have hcount : ∀ w : ℕ, w ≤ M →
      (∑ j ∈ Finset.Icc (K + 1) M,
        if j ≤ w then (1 : ℕ) else 0) = w - K := by
    intro w hw
    calc
      (∑ j ∈ Finset.Icc (K + 1) M,
          if j ≤ w then (1 : ℕ) else 0) =
          ((Finset.Icc (K + 1) M).filter (fun j => j ≤ w)).card := by simp
      _ = (Finset.Icc (K + 1) w).card := by
        congr 1
        ext j
        simp only [Finset.mem_filter, Finset.mem_Icc]
        omega
      _ = w - K := by
        rw [Nat.card_Icc]
        omega
  unfold depthTailMass depthLayerMass
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro x hx
  calc
    ((depth x - K : ℕ) : ℝ) * weight x =
        (∑ j ∈ Finset.Icc (K + 1) M,
          (if j ≤ depth x then (1 : ℝ) else 0)) * weight x := by
      congr 1
      exact_mod_cast (hcount (depth x) (hdepth x hx)).symm
    _ = ∑ j ∈ Finset.Icc (K + 1) M,
          (if j ≤ depth x then (1 : ℝ) else 0) * weight x := by
      rw [Finset.sum_mul]
    _ = ∑ j ∈ Finset.Icc (K + 1) M,
          if j ≤ depth x then weight x else 0 := by
      apply Finset.sum_congr rfl
      intro j _hj
      split_ifs <;> simp_all

/-! ## Moving-threshold asymptotics -/

/-- Pointwise domination by a nonnegative little-oh function preserves
little-oh. -/
theorem isLittleO_of_nonnegative_domination
    {α : Type*} {l : Filter α} {f g h : α → ℝ}
    (hf : ∀ x, 0 ≤ f x) (hg : ∀ x, 0 ≤ g x)
    (hfg : ∀ x, f x ≤ g x) (hgo : g =o[l] h) :
    f =o[l] h := by
  rw [isLittleO_iff]
  intro c hc
  filter_upwards [hgo.bound hc] with x hx
  rw [Real.norm_eq_abs, abs_of_nonneg (hf x)]
  rw [Real.norm_eq_abs, abs_of_nonneg (hg x)] at hx
  exact (hfg x).trans hx

/-- Moving-threshold sufficient criterion for a sequence of finite depth
masses.  The first hypothesis controls the capped one-copy support; the
second controls all layers above the moving threshold. -/
theorem depthExcessMass_isLittleO_of_threshold
    {ι : Type*} (support : ℕ → Finset ι)
    (depth : ℕ → ι → ℕ) (weight : ℕ → ι → ℝ)
    (K : ℕ → ℕ) (scale : ℕ → ℝ)
    (hK : ∀ d, 2 ≤ K d)
    (hweight : ∀ d x, 0 ≤ weight d x)
    (hcapSupport :
      (fun d => ((K d - 2 : ℕ) : ℝ) *
        depthSupportMass (support d) (weight d)) =o[atTop] scale)
    (htail :
      (fun d => depthTailMass (support d) (depth d) (weight d) (K d))
        =o[atTop] scale) :
    (fun d => depthExcessMass (support d) (depth d) (weight d))
      =o[atTop] scale := by
  have htruncated :
      (fun d => depthTruncatedMass
        (support d) (depth d) (weight d) (K d)) =o[atTop] scale := by
    refine isLittleO_of_nonnegative_domination
      (f := fun d => depthTruncatedMass
        (support d) (depth d) (weight d) (K d))
      (g := fun d => ((K d - 2 : ℕ) : ℝ) *
        depthSupportMass (support d) (weight d)) ?_ ?_ ?_ hcapSupport
    · intro d
      unfold depthTruncatedMass
      exact Finset.sum_nonneg fun x _ =>
        mul_nonneg (by positivity) (hweight d x)
    · intro d
      apply mul_nonneg (by positivity)
      unfold depthSupportMass
      exact Finset.sum_nonneg fun x _ => hweight d x
    · intro d
      exact depthTruncatedMass_le_cap_mul_support
        (support d) (depth d) (weight d) (K d)
        (fun x _ => hweight d x)
  have hadd := htruncated.add htail
  apply hadd.congr_left
  intro d
  exact (depthExcessMass_eq_truncated_add_tail
    (support d) (depth d) (weight d) (K d) (hK d)).symm

/-- If a separate base mass is little-oh, the threshold criterion controls
their total.  This is the abstract form of `log E_d = log T_d + log D_d`. -/
theorem totalExcessMass_isLittleO_of_support_and_deepThreshold
    {ι : Type*} (support : ℕ → Finset ι)
    (depth : ℕ → ι → ℕ) (weight : ℕ → ι → ℝ)
    (K : ℕ → ℕ) (scale baseMass totalMass : ℕ → ℝ)
    (hK : ∀ d, 2 ≤ K d)
    (hweight : ∀ d x, 0 ≤ weight d x)
    (hbase : baseMass =o[atTop] scale)
    (hcapSupport :
      (fun d => ((K d - 2 : ℕ) : ℝ) *
        depthSupportMass (support d) (weight d)) =o[atTop] scale)
    (htail :
      (fun d => depthTailMass (support d) (depth d) (weight d) (K d))
        =o[atTop] scale)
    (htotal : ∀ d, totalMass d = baseMass d +
      depthExcessMass (support d) (depth d) (weight d)) :
    totalMass =o[atTop] scale := by
  have hdeep := depthExcessMass_isLittleO_of_threshold
    support depth weight K scale hK hweight hcapSupport htail
  exact (hbase.add hdeep).congr_left fun d => (htotal d).symm

/-! ## Actual canonical Mersenne factors -/

/-- Prime support of the canonical exact-order block. -/
noncomputable def mersenneExactOrderSupport (d : ℕ) : Finset ℕ :=
  (2 ^ d - 1).primeFactors.filter (fun p => mersenneExactOrder p = d)

/-- Repeated exact-order primes, one copy each. -/
noncomputable def mersenneRepeatedPrimeSupport (d : ℕ) : Finset ℕ :=
  (mersenneExactOrderSupport d).filter
    (fun p => 2 ≤ (2 ^ d - 1).factorization p)

/-- Super-Wieferich exact-order primes, one copy each. -/
noncomputable def mersenneSuperWieferichSupport (d : ℕ) : Finset ℕ :=
  (mersenneExactOrderSupport d).filter
    (fun p => 3 ≤ (2 ^ d - 1).factorization p)

/-- The one-copy repeated factor `T_d`. -/
noncomputable def mersenneRepeatedSupportFactor (d : ℕ) : ℕ :=
  ∏ p ∈ mersenneRepeatedPrimeSupport d, p

/-- The one-copy super-Wieferich support factor `S_d^(3)`. -/
noncomputable def mersenneSuperSupportFactor (d : ℕ) : ℕ :=
  ∏ p ∈ mersenneSuperWieferichSupport d, p

/-- The genuinely deep factor `D_d`. -/
noncomputable def mersenneCanonicalDeepFactor (d : ℕ) : ℕ :=
  ∏ p ∈ mersenneSuperWieferichSupport d,
    p ^ ((2 ^ d - 1).factorization p - 2)

/-- Logarithmic mass above a selected canonical depth. -/
noncomputable def mersenneDeepTailLogMass (d K : ℕ) : ℝ :=
  depthTailMass (mersenneSuperWieferichSupport d)
    (fun p => (2 ^ d - 1).factorization p)
    (fun p => Real.log (p : ℝ)) K

/-- The deep factor is positive. -/
theorem mersenneCanonicalDeepFactor_pos (d : ℕ) :
    0 < mersenneCanonicalDeepFactor d := by
  classical
  unfold mersenneCanonicalDeepFactor
  apply Finset.prod_pos
  intro p hp
  have hprime : p.Prime := Nat.prime_of_mem_primeFactors
    (Finset.mem_filter.mp (Finset.mem_filter.mp hp).1).1
  exact pow_pos hprime.pos _

/-- The repeated one-copy factor is positive. -/
theorem mersenneRepeatedSupportFactor_pos (d : ℕ) :
    0 < mersenneRepeatedSupportFactor d := by
  classical
  unfold mersenneRepeatedSupportFactor
  apply Finset.prod_pos
  intro p hp
  have hprime : p.Prime := Nat.prime_of_mem_primeFactors
    (Finset.mem_filter.mp (Finset.mem_filter.mp hp).1).1
  exact hprime.pos

/-- Primewise exponent split behind `E_d = T_d * D_d`. -/
theorem canonicalExponent_split {a : ℕ} (ha : 1 ≤ a) :
    a - 1 = (if 2 ≤ a then 1 else 0) + (a - 2) := by
  split_ifs <;> omega

/-- Extending the deep product from its super support to the whole exact-order
support inserts only factors equal to one. -/
theorem mersenneCanonicalDeepFactor_eq_fullSupportProduct (d : ℕ) :
    mersenneCanonicalDeepFactor d =
      ∏ p ∈ mersenneExactOrderSupport d,
        p ^ ((2 ^ d - 1).factorization p - 2) := by
  classical
  unfold mersenneCanonicalDeepFactor mersenneSuperWieferichSupport
  apply Finset.prod_filter_of_ne
  intro p _hp hne
  by_contra h
  have hle : (2 ^ d - 1).factorization p ≤ 2 := by omega
  have hz : (2 ^ d - 1).factorization p - 2 = 0 :=
    Nat.sub_eq_zero_of_le hle
  simp [hz] at hne

/-- The repeated support product has a full-support conditional-exponent
form. -/
theorem mersenneRepeatedSupportFactor_eq_fullSupportProduct (d : ℕ) :
    mersenneRepeatedSupportFactor d =
      ∏ p ∈ mersenneExactOrderSupport d,
        p ^ (if 2 ≤ (2 ^ d - 1).factorization p then 1 else 0) := by
  classical
  unfold mersenneRepeatedSupportFactor mersenneRepeatedPrimeSupport
  calc
    (∏ p ∈ mersenneExactOrderSupport d with
        2 ≤ (2 ^ d - 1).factorization p, p) =
        ∏ p ∈ mersenneExactOrderSupport d with
          2 ≤ (2 ^ d - 1).factorization p,
          p ^ (if 2 ≤ (2 ^ d - 1).factorization p then 1 else 0) := by
      apply Finset.prod_congr rfl
      intro p hp
      simp [(Finset.mem_filter.mp hp).2]
    _ = ∏ p ∈ mersenneExactOrderSupport d,
          p ^ (if 2 ≤ (2 ^ d - 1).factorization p then 1 else 0) := by
      apply Finset.prod_filter_of_ne
      intro p _hp hne
      by_contra h
      simp [h] at hne

/-- Exact arithmetic factorization of the canonical order block. -/
theorem mersenneCanonicalOrderBlock_eq_repeated_mul_deep (d : ℕ) :
    mersenneCanonicalOrderBlock d =
      mersenneRepeatedSupportFactor d * mersenneCanonicalDeepFactor d := by
  classical
  unfold mersenneCanonicalOrderBlock
  change (∏ p ∈ mersenneExactOrderSupport d,
      p ^ ((2 ^ d - 1).factorization p - 1)) =
        mersenneRepeatedSupportFactor d * mersenneCanonicalDeepFactor d
  rw [mersenneRepeatedSupportFactor_eq_fullSupportProduct,
    mersenneCanonicalDeepFactor_eq_fullSupportProduct,
    ← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro p hp
  have hmem : p ∈ (2 ^ d - 1).primeFactors :=
    (Finset.mem_filter.mp hp).1
  have hn : 2 ^ d - 1 ≠ 0 := by
    intro hz
    have hd : d = 0 := by
      by_contra hd0
      exact (mersenne_sub_one_pos (Nat.pos_of_ne_zero hd0)).ne' hz
    subst d
    norm_num at hmem
  have hfac : 1 ≤ (2 ^ d - 1).factorization p := by
    have hprime : p.Prime := Nat.prime_of_mem_primeFactors hmem
    exact (hprime.dvd_iff_one_le_factorization hn).mp
      (Nat.dvd_of_mem_primeFactors hmem)
  rw [canonicalExponent_split hfac, pow_add]

/-- Logarithmic form of `E_d = T_d * D_d`. -/
theorem log_mersenneCanonicalOrderBlock_eq_repeated_add_deep (d : ℕ) :
    Real.log (mersenneCanonicalOrderBlock d : ℝ) =
      Real.log (mersenneRepeatedSupportFactor d : ℝ) +
        Real.log (mersenneCanonicalDeepFactor d : ℝ) := by
  have hcast :
      (mersenneCanonicalOrderBlock d : ℝ) =
        (mersenneRepeatedSupportFactor d : ℝ) *
          (mersenneCanonicalDeepFactor d : ℝ) := by
    exact_mod_cast mersenneCanonicalOrderBlock_eq_repeated_mul_deep d
  rw [hcast, Real.log_mul]
  · exact_mod_cast (mersenneRepeatedSupportFactor_pos d).ne'
  · exact_mod_cast (mersenneCanonicalDeepFactor_pos d).ne'

/-- The logarithm of the actual deep factor is exactly the abstract weighted
depth excess. -/
theorem log_mersenneCanonicalDeepFactor_eq_depthExcessMass (d : ℕ) :
    Real.log (mersenneCanonicalDeepFactor d : ℝ) =
      depthExcessMass (mersenneSuperWieferichSupport d)
        (fun p => (2 ^ d - 1).factorization p)
        (fun p => Real.log (p : ℝ)) := by
  classical
  unfold mersenneCanonicalDeepFactor depthExcessMass
  have hcast :
      ((∏ p ∈ mersenneSuperWieferichSupport d,
          p ^ ((2 ^ d - 1).factorization p - 2) : ℕ) : ℝ) =
        ∏ p ∈ mersenneSuperWieferichSupport d,
          (p : ℝ) ^ ((2 ^ d - 1).factorization p - 2) := by
    push_cast
    rfl
  rw [hcast, Real.log_prod]
  · apply Finset.sum_congr rfl
    intro p _hp
    rw [Real.log_pow]
  · intro p hp
    have hprime : p.Prime := Nat.prime_of_mem_primeFactors
      (Finset.mem_filter.mp (Finset.mem_filter.mp hp).1).1
    exact pow_ne_zero _ (by exact_mod_cast hprime.ne_zero)

/-- The logarithm of the one-copy super support is its support mass. -/
theorem log_mersenneSuperSupportFactor_eq_depthSupportMass (d : ℕ) :
    Real.log (mersenneSuperSupportFactor d : ℝ) =
      depthSupportMass (mersenneSuperWieferichSupport d)
        (fun p => Real.log (p : ℝ)) := by
  classical
  unfold mersenneSuperSupportFactor depthSupportMass
  have hcast :
      ((∏ p ∈ mersenneSuperWieferichSupport d, p : ℕ) : ℝ) =
        ∏ p ∈ mersenneSuperWieferichSupport d, (p : ℝ) := by
    push_cast
    rfl
  rw [hcast, Real.log_prod]
  intro p hp
  have hprime : p.Prime := Nat.prime_of_mem_primeFactors
    (Finset.mem_filter.mp (Finset.mem_filter.mp hp).1).1
  exact_mod_cast hprime.ne_zero

/-- Actual finite version of the moving-threshold bound
`log D_d ≤ (K-2) log S_d^(3) + R_d(K)`. -/
theorem log_mersenneCanonicalDeepFactor_le_threshold
    (d K : ℕ) (hK : 2 ≤ K) :
    Real.log (mersenneCanonicalDeepFactor d : ℝ) ≤
      ((K - 2 : ℕ) : ℝ) *
          Real.log (mersenneSuperSupportFactor d : ℝ) +
        mersenneDeepTailLogMass d K := by
  rw [log_mersenneCanonicalDeepFactor_eq_depthExcessMass,
    log_mersenneSuperSupportFactor_eq_depthSupportMass]
  have hbound := depthExcessMass_le_cap_mul_support_add_tail
    (mersenneSuperWieferichSupport d)
    (fun p => (2 ^ d - 1).factorization p)
    (fun p => Real.log (p : ℝ)) K hK
    (fun p _ => Real.log_natCast_nonneg p)
  simpa only [mersenneDeepTailLogMass] using hbound

/-- Actual moving-threshold closure for the canonical deep factor `D_d`. -/
theorem log_mersenneCanonicalDeepFactor_isLittleO_of_threshold
    (K : ℕ → ℕ) (hK : ∀ d, 2 ≤ K d)
    (hcapSupport :
      (fun d => ((K d - 2 : ℕ) : ℝ) *
        Real.log (mersenneSuperSupportFactor d : ℝ)) =o[atTop]
          (fun d : ℕ => (Nat.totient d : ℝ)))
    (htail :
      (fun d => mersenneDeepTailLogMass d (K d)) =o[atTop]
        (fun d : ℕ => (Nat.totient d : ℝ))) :
    (fun d => Real.log (mersenneCanonicalDeepFactor d : ℝ)) =o[atTop]
      (fun d : ℕ => (Nat.totient d : ℝ)) := by
  have hcapSupport' :
      (fun d => ((K d - 2 : ℕ) : ℝ) *
        depthSupportMass (mersenneSuperWieferichSupport d)
          (fun p => Real.log (p : ℝ))) =o[atTop]
            (fun d : ℕ => (Nat.totient d : ℝ)) := by
    apply hcapSupport.congr_left
    intro d
    rw [log_mersenneSuperSupportFactor_eq_depthSupportMass]
  have htail' :
      (fun d => depthTailMass (mersenneSuperWieferichSupport d)
        (fun p => (2 ^ d - 1).factorization p)
        (fun p => Real.log (p : ℝ)) (K d)) =o[atTop]
          (fun d : ℕ => (Nat.totient d : ℝ)) := by
    simpa only [mersenneDeepTailLogMass] using htail
  have hcore := depthExcessMass_isLittleO_of_threshold
    mersenneSuperWieferichSupport
    (fun d p => (2 ^ d - 1).factorization p)
    (fun _d p => Real.log (p : ℝ)) K
    (fun d : ℕ => (Nat.totient d : ℝ)) hK
    (fun _d p => Real.log_natCast_nonneg p)
    hcapSupport' htail'
  apply hcore.congr_left
  intro d
  exact (log_mersenneCanonicalDeepFactor_eq_depthExcessMass d).symm

/-- Sufficient criterion for the full canonical block `E_d`. -/
theorem mersenneCanonicalOrderBlockLogMass_isLittleO_of_superDepthThreshold
    (K : ℕ → ℕ) (hK : ∀ d, 2 ≤ K d)
    (hrepeated :
      (fun d => Real.log (mersenneRepeatedSupportFactor d : ℝ)) =o[atTop]
        (fun d : ℕ => (Nat.totient d : ℝ)))
    (hcapSupport :
      (fun d => ((K d - 2 : ℕ) : ℝ) *
        Real.log (mersenneSuperSupportFactor d : ℝ)) =o[atTop]
          (fun d : ℕ => (Nat.totient d : ℝ)))
    (htail :
      (fun d => mersenneDeepTailLogMass d (K d)) =o[atTop]
        (fun d : ℕ => (Nat.totient d : ℝ))) :
    mersenneCanonicalOrderBlockLogMass =o[atTop]
      (fun d : ℕ => (Nat.totient d : ℝ)) := by
  have hdeep := log_mersenneCanonicalDeepFactor_isLittleO_of_threshold
    K hK hcapSupport htail
  apply (hrepeated.add hdeep).congr_left
  intro d
  exact (log_mersenneCanonicalOrderBlock_eq_repeated_add_deep d).symm

/-- The same sufficient inputs reach the existing Mersenne power-loss
endpoint. -/
theorem log_mersennePowerLoss_isLittleO_of_superDepthThreshold
    (K : ℕ → ℕ) (hK : ∀ d, 2 ≤ K d)
    (hrepeated :
      (fun d => Real.log (mersenneRepeatedSupportFactor d : ℝ)) =o[atTop]
        (fun d : ℕ => (Nat.totient d : ℝ)))
    (hcapSupport :
      (fun d => ((K d - 2 : ℕ) : ℝ) *
        Real.log (mersenneSuperSupportFactor d : ℝ)) =o[atTop]
          (fun d : ℕ => (Nat.totient d : ℝ)))
    (htail :
      (fun d => mersenneDeepTailLogMass d (K d)) =o[atTop]
        (fun d : ℕ => (Nat.totient d : ℝ))) :
    (fun m : ℕ => Real.log (mersennePowerLoss m : ℝ)) =o[atTop]
      (fun m : ℕ => (m : ℝ)) := by
  apply log_mersennePowerLoss_isLittleO_of_orderBlocks
  exact mersenneCanonicalOrderBlockLogMass_isLittleO_of_superDepthThreshold
    K hK hrepeated hcapSupport htail

/-! ## The odd exact-order Wieferich counterexample `3511` -/

theorem prime_3511 : Nat.Prime 3511 := by
  norm_num

/-- The second classical base-two Wieferich prime occurs squared already at
its first exponent `1755`. -/
theorem wieferich_3511_sq_dvd_two_pow_1755_sub_one :
    3511 ^ 2 ∣ 2 ^ 1755 - 1 := by
  rw [show (1755 : ℕ) = 135 * 13 by norm_num, pow_mul]
  norm_num

/-- Its canonical depth is not three. -/
theorem wieferich_3511_cube_not_dvd_two_pow_1755_sub_one :
    ¬ 3511 ^ 3 ∣ 2 ^ 1755 - 1 := by
  intro h
  have hmod : (2 ^ 1755 - 1) % (3511 ^ 3) = 21954602501 := by
    rw [show (1755 : ℕ) = 135 * 13 by norm_num, pow_mul]
    norm_num
  rw [Nat.dvd_iff_mod_eq_zero] at h
  omega

/-- Proper-prime-quotient residues for `1755 = 3^3 * 5 * 13`. -/
theorem wieferich_3511_order_checks :
    2 ^ 585 % 3511 = 756 ∧
      2 ^ 351 % 3511 = 1578 ∧
      2 ^ 135 % 3511 = 88 := by
  constructor
  · rw [show (585 : ℕ) = 45 * 13 by norm_num, pow_mul]
    norm_num
  constructor
  · rw [show (351 : ℕ) = 27 * 13 by norm_num, pow_mul]
    norm_num
  · norm_num

/-- Exact odd order of two modulo `3511`. -/
theorem mersenneExactOrder_3511 :
    mersenneExactOrder 3511 = 1755 := by
  unfold mersenneExactOrder
  apply orderOf_eq_of_pow_and_pow_div_prime (n := 1755)
  · norm_num
  · apply zmod_two_pow_eq_one_of_prime_dvd_mersenne prime_3511
    exact (dvd_pow_self 3511 (n := 2) (by norm_num)).trans
      wieferich_3511_sq_dvd_two_pow_1755_sub_one
  · intro p hp hpd
    have hfactor : (1755 : ℕ) = 3 ^ 3 * 5 * 13 := by norm_num
    rw [hfactor] at hpd
    have hp_cases : p = 3 ∨ p = 5 ∨ p = 13 := by
      rcases hp.dvd_mul.mp hpd with hleft | h13
      · rcases hp.dvd_mul.mp hleft with hthree | h5
        · exact Or.inl <|
            (Nat.prime_dvd_prime_iff_eq hp (by decide)).mp
              (hp.dvd_of_dvd_pow hthree)
        · exact Or.inr <| Or.inl <|
            (Nat.prime_dvd_prime_iff_eq hp (by decide)).mp h5
      · exact Or.inr <| Or.inr <|
          (Nat.prime_dvd_prime_iff_eq hp (by decide)).mp h13
    rcases wieferich_3511_order_checks with ⟨h585, h351, h135⟩
    rcases hp_cases with rfl | rfl | rfl
    · intro hpow
      have hdiv : 1755 / 3 = 585 := by norm_num
      rw [hdiv] at hpow
      have hcast : ((2 ^ 585 : ℕ) : ZMod 3511) = 1 := by
        simpa only [Nat.cast_pow, Nat.cast_ofNat] using hpow
      have hmod :=
        (ZMod.natCast_eq_natCast_iff' (2 ^ 585) 1 3511).mp hcast
      rw [h585] at hmod
      norm_num at hmod
    · intro hpow
      have hdiv : 1755 / 5 = 351 := by norm_num
      rw [hdiv] at hpow
      have hcast : ((2 ^ 351 : ℕ) : ZMod 3511) = 1 := by
        simpa only [Nat.cast_pow, Nat.cast_ofNat] using hpow
      have hmod :=
        (ZMod.natCast_eq_natCast_iff' (2 ^ 351) 1 3511).mp hcast
      rw [h351] at hmod
      norm_num at hmod
    · intro hpow
      have hdiv : 1755 / 13 = 135 := by norm_num
      rw [hdiv] at hpow
      have hcast : ((2 ^ 135 : ℕ) : ZMod 3511) = 1 := by
        simpa only [Nat.cast_pow, Nat.cast_ofNat] using hpow
      have hmod :=
        (ZMod.natCast_eq_natCast_iff' (2 ^ 135) 1 3511).mp hcast
      rw [h135] at hmod
      norm_num at hmod

/-- The canonical valuation at the odd order `1755` is exactly two. -/
theorem factorization_mersenne_1755_at_3511 :
    (2 ^ 1755 - 1).factorization 3511 = 2 := by
  have hn : 2 ^ 1755 - 1 ≠ 0 :=
    (mersenne_sub_one_pos (by norm_num : 0 < 1755)).ne'
  have hge : 2 ≤ (2 ^ 1755 - 1).factorization 3511 :=
    (prime_3511.pow_dvd_iff_le_factorization hn).mp
      wieferich_3511_sq_dvd_two_pow_1755_sub_one
  have hlt : (2 ^ 1755 - 1).factorization 3511 < 3 := by
    apply Nat.lt_of_not_ge
    intro hthree
    exact wieferich_3511_cube_not_dvd_two_pow_1755_sub_one
      ((prime_3511.pow_dvd_iff_le_factorization hn).mpr hthree)
  omega

/-- Full-premise counterexample to confinement of order-level base-two
Wieferich primes to even exact orders. -/
theorem not_all_orderLevelWieferich_exactOrder_even :
    ¬ ∀ q : ℕ, q.Prime →
      q ^ 2 ∣ 2 ^ (mersenneExactOrder q) - 1 →
        Even (mersenneExactOrder q) := by
  intro hall
  have hsquare : 3511 ^ 2 ∣ 2 ^ (mersenneExactOrder 3511) - 1 := by
    rw [mersenneExactOrder_3511]
    exact wieferich_3511_sq_dvd_two_pow_1755_sub_one
  have heven := hall 3511 prime_3511 hsquare
  rw [mersenneExactOrder_3511] at heven
  norm_num at heven

set_option maxRecDepth 12000 in
/-- The odd-order Wieferich prime gives a nontrivial canonical block at
`d = 1755`. -/
theorem prime_3511_dvd_mersenneCanonicalOrderBlock_1755 :
    3511 ∣ mersenneCanonicalOrderBlock 1755 := by
  classical
  have hn : 2 ^ 1755 - 1 ≠ 0 :=
    (mersenne_sub_one_pos (by norm_num : 0 < 1755)).ne'
  have hpDvd : 3511 ∣ 2 ^ 1755 - 1 :=
    (dvd_pow_self 3511 (n := 2) (by norm_num)).trans
      wieferich_3511_sq_dvd_two_pow_1755_sub_one
  have hpMem : 3511 ∈ (2 ^ 1755 - 1).primeFactors :=
    Nat.mem_primeFactors.mpr ⟨prime_3511, hpDvd, hn⟩
  have hpFiber :
      3511 ∈ (2 ^ 1755 - 1).primeFactors.filter
        (fun p => mersenneExactOrder p = 1755) :=
    Finset.mem_filter.mpr ⟨hpMem, mersenneExactOrder_3511⟩
  have hterm :
      3511 ^ ((2 ^ 1755 - 1).factorization 3511 - 1) ∣
        mersenneCanonicalOrderBlock 1755 := by
    unfold mersenneCanonicalOrderBlock
    exact Finset.dvd_prod_of_mem
      (fun p => p ^ ((2 ^ 1755 - 1).factorization p - 1)) hpFiber
  rw [factorization_mersenne_1755_at_3511] at hterm
  norm_num at hterm
  exact hterm

#print axioms nat_depthExcess_split
#print axioms depthExcessMass_eq_truncated_add_tail
#print axioms depthTruncatedMass_le_cap_mul_support
#print axioms depthExcessMass_le_cap_mul_support_add_tail
#print axioms depthTailMass_eq_zero_of_depth_le
#print axioms depthExcessMass_le_cap_mul_support_of_depth_le
#print axioms depth_support_or_tail_of_large_excess
#print axioms depth_support_or_tail_of_large_excess_div
#print axioms depthLayer_count
#print axioms weighted_depthLayer_sum
#print axioms depthExcessMass_eq_sum_layers
#print axioms depthTailMass_eq_sum_layersAbove
#print axioms isLittleO_of_nonnegative_domination
#print axioms depthExcessMass_isLittleO_of_threshold
#print axioms totalExcessMass_isLittleO_of_support_and_deepThreshold
#print axioms mersenneCanonicalDeepFactor_pos
#print axioms mersenneRepeatedSupportFactor_pos
#print axioms canonicalExponent_split
#print axioms mersenneCanonicalDeepFactor_eq_fullSupportProduct
#print axioms mersenneRepeatedSupportFactor_eq_fullSupportProduct
#print axioms mersenneCanonicalOrderBlock_eq_repeated_mul_deep
#print axioms log_mersenneCanonicalOrderBlock_eq_repeated_add_deep
#print axioms log_mersenneCanonicalDeepFactor_eq_depthExcessMass
#print axioms log_mersenneSuperSupportFactor_eq_depthSupportMass
#print axioms log_mersenneCanonicalDeepFactor_le_threshold
#print axioms log_mersenneCanonicalDeepFactor_isLittleO_of_threshold
#print axioms mersenneCanonicalOrderBlockLogMass_isLittleO_of_superDepthThreshold
#print axioms log_mersennePowerLoss_isLittleO_of_superDepthThreshold
#print axioms prime_3511
#print axioms wieferich_3511_sq_dvd_two_pow_1755_sub_one
#print axioms wieferich_3511_cube_not_dvd_two_pow_1755_sub_one
#print axioms wieferich_3511_order_checks
#print axioms mersenneExactOrder_3511
#print axioms factorization_mersenne_1755_at_3511
#print axioms not_all_orderLevelWieferich_exactOrder_even
#print axioms prime_3511_dvd_mersenneCanonicalOrderBlock_1755

end MersenneSuperWieferichDepth20260901
end IUTThreeClosures
