/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineDeterminantLayerEntropy20260901
import IUTThreeClosures.AffineDensityAttack20260901

/-!
# Sharp square determinants and adaptive common affine kernels

The mathematical proofs precede this module in
`research/ABC_AFFINE_ADAPTIVE_COMMON_KERNEL_2026_09_01.md`.

This file kernel-checks the finite geometry and arithmetic core.  It does not
assume an adaptive-kernel density theorem and does not assert the abc
conjecture.
-/

namespace IUTThreeClosures
namespace AffineAdaptiveCommonKernel20260901

open AffineTemplateEntropy20260901
open AffineDeterminantLayerEntropy20260901
open AffineDensityAttack20260901

/-! ## The sharp determinant of a triangle in a square -/

/-- Signed twice-area determinant for three natural lattice points. -/
def natTriangleDet (p q r : ℕ × ℕ) : ℤ :=
  ((q.1 : ℤ) - p.1) * ((r.2 : ℤ) - p.2) -
    ((q.2 : ℤ) - p.2) * ((r.1 : ℤ) - p.1)

/-- If the first coordinates are ordered and all three points lie in
`[0,N]^2`, their determinant has absolute value at most `N^2`.  This is the
sharp square-triangle bound. -/
theorem natTriangleDet_natAbs_le_boxSq_of_first_sorted
    {N : ℕ} {p q r : ℕ × ℕ}
    (hp2 : p.2 ≤ N)
    (hq2 : q.2 ≤ N)
    (hr1 : r.1 ≤ N) (hr2 : r.2 ≤ N)
    (hpq : p.1 ≤ q.1) (hqr : q.1 ≤ r.1) :
    (natTriangleDet p q r).natAbs ≤ N ^ 2 := by
  let s : ℤ := (q.1 : ℤ) - p.1
  let t : ℤ := (r.1 : ℤ) - q.1
  let n : ℤ := N
  have hs : 0 ≤ s := by
    dsimp [s]
    omega
  have ht : 0 ≤ t := by
    dsimp [t]
    omega
  have hspan : s + t ≤ n := by
    dsimp [s, t, n]
    omega
  have hp2z : (p.2 : ℤ) ≤ n := by
    dsimp [n]
    exact_mod_cast hp2
  have hq2z : (q.2 : ℤ) ≤ n := by
    dsimp [n]
    exact_mod_cast hq2
  have hr2z : (r.2 : ℤ) ≤ n := by
    dsimp [n]
    exact_mod_cast hr2
  have hp2nonneg : (0 : ℤ) ≤ p.2 := by positivity
  have hq2nonneg : (0 : ℤ) ≤ q.2 := by positivity
  have hr2nonneg : (0 : ℤ) ≤ r.2 := by positivity
  have hn : 0 ≤ n := by positivity
  have htP : t * (p.2 : ℤ) ≤ t * n :=
    mul_le_mul_of_nonneg_left hp2z ht
  have hsR : s * (r.2 : ℤ) ≤ s * n :=
    mul_le_mul_of_nonneg_left hr2z hs
  have hspanQ : (s + t) * (q.2 : ℤ) ≤ (s + t) * n :=
    mul_le_mul_of_nonneg_left hq2z (add_nonneg hs ht)
  have hpositive :
      t * (p.2 : ℤ) + s * (r.2 : ℤ) ≤ (s + t) * n := by
    linarith
  have hpositiveNonneg :
      0 ≤ t * (p.2 : ℤ) + s * (r.2 : ℤ) := by positivity
  have hnegativeNonneg : 0 ≤ (s + t) * (q.2 : ℤ) := by positivity
  have hspanN : (s + t) * n ≤ n ^ 2 := by
    nlinarith
  have hdet : natTriangleDet p q r =
      t * (p.2 : ℤ) - (s + t) * (q.2 : ℤ) +
        s * (r.2 : ℤ) := by
    dsimp [natTriangleDet, s, t]
    ring
  have hupper : natTriangleDet p q r ≤ n ^ 2 := by
    rw [hdet]
    linarith
  have hlower : -(n ^ 2) ≤ natTriangleDet p q r := by
    rw [hdet]
    linarith
  have habs : |natTriangleDet p q r| ≤ n ^ 2 :=
    (abs_le).2 ⟨hlower, hupper⟩
  have hcast : ((natTriangleDet p q r).natAbs : ℤ) ≤
      ((N ^ 2 : ℕ) : ℤ) := by
    simpa [Int.natCast_natAbs, n] using habs
  exact_mod_cast hcast

#print axioms natTriangleDet_natAbs_le_boxSq_of_first_sorted

/-- Swapping the final two vertices reverses the signed determinant. -/
theorem natTriangleDet_swap_last (p q r : ℕ × ℕ) :
    natTriangleDet p r q = -natTriangleDet p q r := by
  simp only [natTriangleDet]
  ring

/-- Swapping the first two vertices reverses the signed determinant. -/
theorem natTriangleDet_swap_first (p q r : ℕ × ℕ) :
    natTriangleDet q p r = -natTriangleDet p q r := by
  simp only [natTriangleDet]
  ring

/-- Cyclically rotating the vertices preserves the signed determinant. -/
theorem natTriangleDet_rotate (p q r : ℕ × ℕ) :
    natTriangleDet q r p = natTriangleDet p q r := by
  simp only [natTriangleDet]
  ring

/-- The sharp bound without an ordering hypothesis. -/
theorem natTriangleDet_natAbs_le_boxSq
    {N : ℕ} {p q r : ℕ × ℕ}
    (hp : p.1 ≤ N ∧ p.2 ≤ N)
    (hq : q.1 ≤ N ∧ q.2 ≤ N)
    (hr : r.1 ≤ N ∧ r.2 ≤ N) :
    (natTriangleDet p q r).natAbs ≤ N ^ 2 := by
  by_cases hpq : p.1 ≤ q.1
  · by_cases hqr : q.1 ≤ r.1
    · exact natTriangleDet_natAbs_le_boxSq_of_first_sorted
        hp.2 hq.2 hr.1 hr.2 hpq hqr
    · have hrq : r.1 ≤ q.1 := Nat.le_of_not_ge hqr
      by_cases hpr : p.1 ≤ r.1
      · have h := natTriangleDet_natAbs_le_boxSq_of_first_sorted
          hp.2 hr.2 hq.1 hq.2 hpr hrq
        rw [natTriangleDet_swap_last, Int.natAbs_neg] at h
        exact h
      · have hrp : r.1 ≤ p.1 := Nat.le_of_not_ge hpr
        have h := natTriangleDet_natAbs_le_boxSq_of_first_sorted
          hr.2 hp.2 hq.1 hq.2 hrp hpq
        have heq : natTriangleDet r p q = natTriangleDet p q r := by
          simp only [natTriangleDet]
          ring
        rwa [heq] at h
  · have hqp : q.1 ≤ p.1 := Nat.le_of_not_ge hpq
    by_cases hpr : p.1 ≤ r.1
    · have h := natTriangleDet_natAbs_le_boxSq_of_first_sorted
        hq.2 hp.2 hr.1 hr.2 hqp hpr
      rw [natTriangleDet_swap_first] at h
      simpa only [Int.natAbs_neg] using h
    · have hrp : r.1 ≤ p.1 := Nat.le_of_not_ge hpr
      by_cases hqr : q.1 ≤ r.1
      · have h := natTriangleDet_natAbs_le_boxSq_of_first_sorted
          hq.2 hr.2 hp.1 hp.2 hqr hrp
        rw [natTriangleDet_rotate p q r] at h
        exact h
      · have hrq : r.1 ≤ q.1 := Nat.le_of_not_ge hqr
        have h := natTriangleDet_natAbs_le_boxSq_of_first_sorted
          hr.2 hq.2 hp.1 hp.2 hrq hqp
        have hswap : natTriangleDet r q p = -natTriangleDet p q r := by
          simp only [natTriangleDet]
          ring
        rw [hswap, Int.natAbs_neg] at h
        exact h

/-- Translation from the positive box `[1,M]^2` gives the sharp side
`(M-1)^2`, rather than the coarser `M^2`. -/
theorem natTriangleDet_natAbs_le_positiveBoxSq
    {M : ℕ} {p q r : ℕ × ℕ}
    (hp : 1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M)
    (hq : 1 ≤ q.1 ∧ q.1 ≤ M ∧ 1 ≤ q.2 ∧ q.2 ≤ M)
    (hr : 1 ≤ r.1 ∧ r.1 ≤ M ∧ 1 ≤ r.2 ∧ r.2 ≤ M) :
    (natTriangleDet p q r).natAbs ≤ (M - 1) ^ 2 := by
  let shift : ℕ × ℕ → ℕ × ℕ := fun x ↦ (x.1 - 1, x.2 - 1)
  have hps : (shift p).1 ≤ M - 1 ∧ (shift p).2 ≤ M - 1 := by
    dsimp [shift]
    omega
  have hqs : (shift q).1 ≤ M - 1 ∧ (shift q).2 ≤ M - 1 := by
    dsimp [shift]
    omega
  have hrs : (shift r).1 ≤ M - 1 ∧ (shift r).2 ≤ M - 1 := by
    dsimp [shift]
    omega
  have h := natTriangleDet_natAbs_le_boxSq hps hqs hrs
  have hdet : natTriangleDet (shift p) (shift q) (shift r) =
      natTriangleDet p q r := by
    dsimp [shift, natTriangleDet]
    push_cast [Nat.cast_sub hp.1, Nat.cast_sub hp.2.2.1,
      Nat.cast_sub hq.1, Nat.cast_sub hq.2.2.1,
      Nat.cast_sub hr.1, Nat.cast_sub hr.2.2.1]
    ring
  rwa [hdet] at h

#print axioms natTriangleDet_natAbs_le_boxSq
#print axioms natTriangleDet_natAbs_le_positiveBoxSq

/-! ## Adaptive triplewise common moduli -/

/-- Signed parameter difference, with the second argument as base point. -/
def natPointDiff (q p : ℕ × ℕ) : ℤ × ℤ :=
  ((q.1 : ℤ) - p.1, (q.2 : ℤ) - p.2)

/-- The determinant of the two differences from `p` is the triangle
determinant. -/
theorem signedPairDet_natPointDiff (p q r : ℕ × ℕ) :
    signedPairDet (natPointDiff q p) (natPointDiff r p) =
      natTriangleDet p q r := by
  rfl

/-- Three point-adaptive certificates can use unrelated moduli at each
point.  Once their triplewise common moduli give the six displayed
difference congruences, noncollinearity and the sharp square bound force the
common product below `(M-1)^2`.

The congruence interface is exactly what follows by taking the three gcds of
the pointwise arm divisors and cancelling the radical step, which is coprime
to every arm divisor. -/
theorem adaptive_commonModulusProduct_le_boxSq_of_noncollinear
    {gU gV gW B C M : ℕ} {p q r : ℕ × ℕ}
    (hp : 1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M)
    (hq : 1 ≤ q.1 ∧ q.1 ≤ M ∧ 1 ≤ q.2 ∧ q.2 ≤ M)
    (hr : 1 ≤ r.1 ∧ r.1 ≤ M ∧ 1 ≤ r.2 ∧ r.2 ≤ M)
    (hUV : Nat.Coprime gU gV)
    (hUW : Nat.Coprime gU gW)
    (hVW : Nat.Coprime gV gW)
    (hqU : (gU : ℤ) ∣ (natPointDiff q p).1)
    (hqV : (gV : ℤ) ∣
      (natPointDiff q p).1 + (C : ℤ) * (natPointDiff q p).2)
    (hqW : (gW : ℤ) ∣
      (natPointDiff q p).1 + (B : ℤ) * (natPointDiff q p).2)
    (hrU : (gU : ℤ) ∣ (natPointDiff r p).1)
    (hrV : (gV : ℤ) ∣
      (natPointDiff r p).1 + (C : ℤ) * (natPointDiff r p).2)
    (hrW : (gW : ℤ) ∣
      (natPointDiff r p).1 + (B : ℤ) * (natPointDiff r p).2)
    (hnoncollinear : natTriangleDet p q r ≠ 0) :
    gU * gV * gW ≤ (M - 1) ^ 2 := by
  have hdivInt : ((gU * gV * gW : ℕ) : ℤ) ∣
      natTriangleDet p q r := by
    rw [← signedPairDet_natPointDiff]
    exact threeForm_modulusProduct_dvd_det hUV hUW hVW
      hqU hqV hqW hrU hrV hrW
  have hdiv : gU * gV * gW ∣ (natTriangleDet p q r).natAbs :=
    nat_dvd_natAbs_of_intCast_dvd hdivInt
  have habsPos : 0 < (natTriangleDet p q r).natAbs :=
    Int.natAbs_pos.mpr hnoncollinear
  exact (Nat.le_of_dvd habsPos hdiv).trans
    (natTriangleDet_natAbs_le_positiveBoxSq hp hq hr)

#print axioms adaptive_commonModulusProduct_le_boxSq_of_noncollinear

/-! ## Canonical factor-three arm bounds -/

/-- The short affine arm retains the useful factor three throughout the
canonical box. -/
theorem canonical_three_mul_affineU_le
    {c R : ℕ} {p : ℕ × ℕ}
    (hc : 9 ≤ c) (_hR : 0 < R)
    (hp : p.1 ≤ canonicalBoxM c R) :
    3 * affineU R p ≤ c ^ 6 := by
  have hM : (4 * R) * canonicalBoxM c R ≤ c ^ 6 := by
    dsimp [canonicalBoxM]
    exact Nat.mul_div_le _ _
  have hpScaled : (4 * R) * p.1 ≤ c ^ 6 :=
    (Nat.mul_le_mul_left (4 * R) hp).trans hM
  have hc6 : 12 ≤ c ^ 6 := by
    have hpow : 9 ^ 6 ≤ c ^ 6 := Nat.pow_le_pow_left hc 6
    norm_num at hpow ⊢
    omega
  have hfour : 4 * (3 * affineU R p) ≤ 4 * c ^ 6 := by
    simp only [affineU]
    nlinarith
  omega

/-- The `V` arm retains the factor three in the canonical box. -/
theorem canonical_three_mul_affineV_le
    {c R C : ℕ} {p : ℕ × ℕ}
    (hc : 9 ≤ c) (_hR : 0 < R) (hC : C ≤ c)
    (hp1 : p.1 ≤ canonicalBoxM c R)
    (hp2 : p.2 ≤ canonicalBoxM c R) :
    3 * affineV R C p ≤ c ^ 7 := by
  let M := canonicalBoxM c R
  have hM : (4 * R) * M ≤ c ^ 6 := by
    dsimp [M, canonicalBoxM]
    exact Nat.mul_div_le _ _
  have hparam : p.1 + C * p.2 ≤ M + c * M := by
    exact Nat.add_le_add hp1 (Nat.mul_le_mul hC hp2)
  have hscaled : 4 * R * (p.1 + C * p.2) ≤ c ^ 6 * (c + 1) := by
    calc
      4 * R * (p.1 + C * p.2) ≤ 4 * R * (M + c * M) :=
        Nat.mul_le_mul_left (4 * R) hparam
      _ = ((4 * R) * M) * (c + 1) := by ring
      _ ≤ c ^ 6 * (c + 1) := Nat.mul_le_mul_right (c + 1) hM
  have hc6 : 12 ≤ c ^ 6 := by
    have hpow : 9 ^ 6 ≤ c ^ 6 := Nat.pow_le_pow_left hc 6
    norm_num at hpow ⊢
    omega
  have hgap : 12 ≤ (c - 3) * c ^ 6 := by
    have hone : 1 ≤ c - 3 := by omega
    calc
      12 ≤ c ^ 6 := hc6
      _ = 1 * c ^ 6 := by simp
      _ ≤ (c - 3) * c ^ 6 := Nat.mul_le_mul_right _ hone
  have hcoef : (c - 3) + 3 * (c + 1) = 4 * c := by omega
  have hconstant : 12 + 3 * (c ^ 6 * (c + 1)) ≤ 4 * c ^ 7 := by
    calc
      12 + 3 * (c ^ 6 * (c + 1)) ≤
          (c - 3) * c ^ 6 + 3 * (c ^ 6 * (c + 1)) :=
        Nat.add_le_add_right hgap _
      _ = ((c - 3) + 3 * (c + 1)) * c ^ 6 := by ring
      _ = (4 * c) * c ^ 6 := by rw [hcoef]
      _ = 4 * c ^ 7 := by ring
  have hfour : 4 * (3 * affineV R C p) ≤ 4 * c ^ 7 := by
    simp only [affineV]
    nlinarith
  omega

/-- The `W` arm has the same factor-three bound when its seed coefficient is
at most `c`. -/
theorem canonical_three_mul_affineW_le
    {c R B : ℕ} {p : ℕ × ℕ}
    (hc : 9 ≤ c) (hR : 0 < R) (hB : B ≤ c)
    (hp1 : p.1 ≤ canonicalBoxM c R)
    (hp2 : p.2 ≤ canonicalBoxM c R) :
    3 * affineW R B p ≤ c ^ 7 := by
  simpa only [affineW, affineV] using
    (canonical_three_mul_affineV_le (p := p) hc hR hB hp1 hp2)

/-- All three canonical size bounds packaged together. -/
theorem canonical_threeArm_bounds
    {c R B C : ℕ} {p : ℕ × ℕ}
    (hc : 9 ≤ c) (hR : 0 < R) (hB : B ≤ c) (hC : C ≤ c)
    (hp1 : p.1 ≤ canonicalBoxM c R)
    (hp2 : p.2 ≤ canonicalBoxM c R) :
    3 * affineU R p ≤ c ^ 6 ∧
      3 * affineV R C p ≤ c ^ 7 ∧
      3 * affineW R B p ≤ c ^ 7 := by
  exact ⟨canonical_three_mul_affineU_le hc hR hp1,
    canonical_three_mul_affineV_le hc hR hC hp1 hp2,
    canonical_three_mul_affineW_le hc hR hB hp1 hp2⟩

#print axioms canonical_three_mul_affineU_le
#print axioms canonical_three_mul_affineV_le
#print axioms canonical_three_mul_affineW_le
#print axioms canonical_threeArm_bounds

/-! ## Long-arm square excess and the factor-27 support bounds -/

/-- Cancelling the factor-three short-arm cap from the full exceptional
threshold forces the product of the two long-arm excesses above the
`3*R*c^8` scale. -/
theorem longArm_excessProduct_lower
    {R c EU EV EW : ℕ}
    (hc : 0 < c) (hU : 3 * EU ≤ c ^ 6)
    (hex : R * c ^ 14 < 8192 * EU * EV * EW) :
    3 * R * c ^ 8 < 8192 * EV * EW := by
  have hscaledHex : 3 * (R * c ^ 14) <
      3 * (8192 * EU * EV * EW) :=
    (Nat.mul_lt_mul_left (by norm_num : 0 < 3)).2 hex
  have hupper : 3 * (8192 * EU * EV * EW) ≤
      c ^ 6 * (8192 * EV * EW) := by
    have h := Nat.mul_le_mul_right (8192 * EV * EW) hU
    nlinarith
  have hchain : c ^ 6 * (3 * R * c ^ 8) <
      c ^ 6 * (8192 * EV * EW) := by
    calc
      c ^ 6 * (3 * R * c ^ 8) = 3 * (R * c ^ 14) := by ring
      _ < 3 * (8192 * EU * EV * EW) := hscaledHex
      _ ≤ c ^ 6 * (8192 * EV * EW) := hupper
  exact (Nat.mul_lt_mul_left (pow_pos hc 6)).mp hchain

/-- One of the two long arms carries the full product lower bound in its
square. -/
theorem longArm_squareExcess_dichotomy
    {R c EU EV EW : ℕ}
    (hc : 0 < c) (hU : 3 * EU ≤ c ^ 6)
    (hex : R * c ^ 14 < 8192 * EU * EV * EW) :
    3 * R * c ^ 8 < 8192 * EV ^ 2 ∨
      3 * R * c ^ 8 < 8192 * EW ^ 2 := by
  have hprod := longArm_excessProduct_lower hc hU hex
  rcases le_total EV EW with hVE | hWV
  · right
    have hbound : 8192 * EV * EW ≤ 8192 * EW ^ 2 := by
      calc
        8192 * EV * EW = 8192 * (EV * EW) := by ring
        _ ≤ 8192 * (EW * EW) :=
          Nat.mul_le_mul_left 8192
            (Nat.mul_le_mul hVE (le_rfl : EW ≤ EW))
        _ = 8192 * EW ^ 2 := by ring
    exact hprod.trans_le hbound
  · left
    have hbound : 8192 * EV * EW ≤ 8192 * EV ^ 2 := by
      calc
        8192 * EV * EW = 8192 * (EW * EV) := by ring
        _ ≤ 8192 * (EV * EV) :=
          Nat.mul_le_mul_left 8192
            (Nat.mul_le_mul hWV (le_rfl : EV ≤ EV))
        _ = 8192 * EV ^ 2 := by ring
    exact hprod.trans_le hbound

/-- Actual powerful-part specialization of the long-arm dichotomy. -/
theorem canonical_longArm_squareExcess_dichotomy
    {R c U V W : ℕ}
    (hc : 0 < c) (hUpos : 0 < U)
    (hU : 3 * U ≤ c ^ 6)
    (hex : R * c ^ 14 <
      8192 * abcPowerfulPart U * abcPowerfulPart V * abcPowerfulPart W) :
    3 * R * c ^ 8 < 8192 * abcPowerfulPart V ^ 2 ∨
      3 * R * c ^ 8 < 8192 * abcPowerfulPart W ^ 2 := by
  apply longArm_squareExcess_dichotomy hc
  · exact (Nat.mul_le_mul_left 3
      (abcPowerfulPart_le_self hUpos)).trans hU
  · exact hex

/-- Arithmetic core of the one-arm factor-27 radical-support bound. -/
theorem longArm_radicalSupport_sq
    {R c Z EZ radZ : ℕ}
    (hc : 0 < c) (hrad : 0 < radZ)
    (hfactor : radZ * EZ = Z)
    (hsize : 3 * Z ≤ c ^ 7)
    (hexcess : 3 * R * c ^ 8 < 8192 * EZ ^ 2) :
    27 * R * radZ ^ 2 < 8192 * c ^ 6 := by
  have hsizeSq := Nat.pow_le_pow_left hsize 2
  have hsupportExcess : 9 * radZ ^ 2 * EZ ^ 2 ≤ c ^ 14 := by
    calc
      9 * radZ ^ 2 * EZ ^ 2 = (3 * Z) ^ 2 := by
        rw [← hfactor]
        ring
      _ ≤ (c ^ 7) ^ 2 := hsizeSq
      _ = c ^ 14 := by ring
  have hscaled : (9 * radZ ^ 2) * (3 * R * c ^ 8) <
      (9 * radZ ^ 2) * (8192 * EZ ^ 2) :=
    (Nat.mul_lt_mul_left
      (mul_pos (by norm_num : 0 < 9) (pow_pos hrad 2))).2 hexcess
  have hchain : c ^ 8 * (27 * R * radZ ^ 2) <
      c ^ 8 * (8192 * c ^ 6) := by
    calc
      c ^ 8 * (27 * R * radZ ^ 2) =
          (9 * radZ ^ 2) * (3 * R * c ^ 8) := by ring
      _ < (9 * radZ ^ 2) * (8192 * EZ ^ 2) := hscaled
      _ = 8192 * (9 * radZ ^ 2 * EZ ^ 2) := by ring
      _ ≤ 8192 * c ^ 14 := Nat.mul_le_mul_left 8192 hsupportExcess
      _ = c ^ 8 * (8192 * c ^ 6) := by ring
  exact (Nat.mul_lt_mul_left (pow_pos hc 8)).mp hchain

/-- The selected actual long arm has square radical support below the sharp
factor-27 threshold. -/
theorem actualLongArm_radicalSupport_sq
    {R c Z : ℕ}
    (hc : 0 < c)
    (hsize : 3 * Z ≤ c ^ 7)
    (hexcess : 3 * R * c ^ 8 < 8192 * abcPowerfulPart Z ^ 2) :
    27 * R * abcRadical Z ^ 2 < 8192 * c ^ 6 := by
  exact longArm_radicalSupport_sq hc (abcRadical_pos Z)
    (abcRadical_mul_abcPowerfulPart Z) hsize hexcess

/-- Pure arithmetic seam for the full canonical repeated-kernel support
bound.  `kernelProduct = kernelRadical * EU * EV * EW` is the exact
prime-exponent identity for pairwise-coprime repeated kernels, while
`kernelProduct ≤ U*V*W` follows from armwise divisibility. -/
theorem canonicalKernel_radicalSupport_factor27
    {R c U V W EU EV EW kernelProduct kernelRadical : ℕ}
    (hc : 0 < c)
    (hU : 3 * U ≤ c ^ 6)
    (hV : 3 * V ≤ c ^ 7)
    (hW : 3 * W ≤ c ^ 7)
    (hkernel : kernelProduct ≤ U * V * W)
    (hfactor : kernelRadical * (EU * EV * EW) = kernelProduct)
    (hex : R * c ^ 14 < 8192 * EU * EV * EW) :
    27 * R * kernelRadical < 8192 * c ^ 6 := by
  by_cases hk : kernelRadical = 0
  · subst kernelRadical
    simpa only [mul_zero] using
      (mul_pos (by norm_num : 0 < 8192) (pow_pos hc 6))
  have harms : 27 * (U * V * W) ≤ c ^ 20 := by
    have hmul := Nat.mul_le_mul (Nat.mul_le_mul hU hV) hW
    calc
      27 * (U * V * W) = (3 * U) * (3 * V) * (3 * W) := by ring
      _ ≤ (c ^ 6) * (c ^ 7) * (c ^ 7) := hmul
      _ = c ^ 20 := by ring
  have hkernelSize : 27 * kernelProduct ≤ c ^ 20 :=
    (Nat.mul_le_mul_left 27 hkernel).trans harms
  have hscaled : (27 * kernelRadical) * (R * c ^ 14) <
      (27 * kernelRadical) * (8192 * EU * EV * EW) := by
    exact (Nat.mul_lt_mul_left
      (mul_pos (by norm_num : 0 < 27) (Nat.pos_of_ne_zero hk))).2 hex
  have hchain : c ^ 14 * (27 * R * kernelRadical) <
      c ^ 14 * (8192 * c ^ 6) := by
    calc
      c ^ 14 * (27 * R * kernelRadical) =
          (27 * kernelRadical) * (R * c ^ 14) := by ring
      _ < (27 * kernelRadical) * (8192 * EU * EV * EW) := hscaled
      _ = 8192 * (27 * kernelProduct) := by rw [← hfactor]; ring
      _ ≤ 8192 * c ^ 20 := Nat.mul_le_mul_left 8192 hkernelSize
      _ = c ^ 14 * (8192 * c ^ 6) := by ring
  exact (Nat.mul_lt_mul_left (pow_pos hc 14)).mp hchain

#print axioms longArm_excessProduct_lower
#print axioms longArm_squareExcess_dichotomy
#print axioms canonical_longArm_squareExcess_dichotomy
#print axioms longArm_radicalSupport_sq
#print axioms actualLongArm_radicalSupport_sq
#print axioms canonicalKernel_radicalSupport_factor27

/-! ## Exact degenerate examples in the canonical `(1,8,9)` box -/

/-- Common divisor retained by two pointwise arm certificates. -/
def twoPointCommonGcd (a b : ℕ) : ℕ := Nat.gcd a b

/-- Common divisor retained by three pointwise arm certificates. -/
def threePointCommonGcd (a b c : ℕ) : ℕ :=
  Nat.gcd (Nat.gcd a b) c

/-- Sup-norm diameter of a three-point parameter packet. -/
def tripleSupDiameter (p q r : ℕ × ℕ) : ℕ :=
  max (pairSupDist p q) (max (pairSupDist p r) (pairSupDist q r))

theorem threePointCommonGcd_dvd_left (a b c : ℕ) :
    threePointCommonGcd a b c ∣ a :=
  (Nat.gcd_dvd_left (Nat.gcd a b) c).trans (Nat.gcd_dvd_left a b)

theorem threePointCommonGcd_dvd_middle (a b c : ℕ) :
    threePointCommonGcd a b c ∣ b :=
  (Nat.gcd_dvd_left (Nat.gcd a b) c).trans (Nat.gcd_dvd_right a b)

theorem threePointCommonGcd_dvd_right (a b c : ℕ) :
    threePointCommonGcd a b c ∣ c :=
  Nat.gcd_dvd_right (Nat.gcd a b) c

/-- Actual pointwise arm divisors yield the complete six-congruence
interface required by `adaptive_commonModulusProduct_le_boxSq_of_noncollinear`.
The common moduli are the three triplewise gcds.  Their coprimality follows
from pairwise coprimality of the three arms at the base point, and their
coprimality with the affine step follows from the identity `arm = 1 mod R`.
-/
theorem triplePoint_armDivisorGcds_give_adaptiveInterface
    {R B C : ℕ} {p q r : ℕ × ℕ}
    {dUp dVp dWp dUq dVq dWq dUr dVr dWr : ℕ}
    (hUp : dUp ∣ affineU R p)
    (hVp : dVp ∣ affineV R C p)
    (hWp : dWp ∣ affineW R B p)
    (hUq : dUq ∣ affineU R q)
    (hVq : dVq ∣ affineV R C q)
    (hWq : dWq ∣ affineW R B q)
    (hUr : dUr ∣ affineU R r)
    (hVr : dVr ∣ affineV R C r)
    (hWr : dWr ∣ affineW R B r)
    (hUVp : Nat.Coprime (affineU R p) (affineV R C p))
    (hUWp : Nat.Coprime (affineU R p) (affineW R B p))
    (hVWp : Nat.Coprime (affineV R C p) (affineW R B p)) :
    let gU := threePointCommonGcd dUp dUq dUr
    let gV := threePointCommonGcd dVp dVq dVr
    let gW := threePointCommonGcd dWp dWq dWr
    Nat.Coprime gU gV ∧ Nat.Coprime gU gW ∧ Nat.Coprime gV gW ∧
      (gU : ℤ) ∣ (natPointDiff q p).1 ∧
      (gV : ℤ) ∣ (natPointDiff q p).1 +
        (C : ℤ) * (natPointDiff q p).2 ∧
      (gW : ℤ) ∣ (natPointDiff q p).1 +
        (B : ℤ) * (natPointDiff q p).2 ∧
      (gU : ℤ) ∣ (natPointDiff r p).1 ∧
      (gV : ℤ) ∣ (natPointDiff r p).1 +
        (C : ℤ) * (natPointDiff r p).2 ∧
      (gW : ℤ) ∣ (natPointDiff r p).1 +
        (B : ℤ) * (natPointDiff r p).2 := by
  dsimp only
  have hgUp : threePointCommonGcd dUp dUq dUr ∣ affineU R p :=
    (threePointCommonGcd_dvd_left _ _ _).trans hUp
  have hgUq : threePointCommonGcd dUp dUq dUr ∣ affineU R q :=
    (threePointCommonGcd_dvd_middle _ _ _).trans hUq
  have hgUr : threePointCommonGcd dUp dUq dUr ∣ affineU R r :=
    (threePointCommonGcd_dvd_right _ _ _).trans hUr
  have hgVp : threePointCommonGcd dVp dVq dVr ∣ affineV R C p :=
    (threePointCommonGcd_dvd_left _ _ _).trans hVp
  have hgVq : threePointCommonGcd dVp dVq dVr ∣ affineV R C q :=
    (threePointCommonGcd_dvd_middle _ _ _).trans hVq
  have hgVr : threePointCommonGcd dVp dVq dVr ∣ affineV R C r :=
    (threePointCommonGcd_dvd_right _ _ _).trans hVr
  have hgWp : threePointCommonGcd dWp dWq dWr ∣ affineW R B p :=
    (threePointCommonGcd_dvd_left _ _ _).trans hWp
  have hgWq : threePointCommonGcd dWp dWq dWr ∣ affineW R B q :=
    (threePointCommonGcd_dvd_middle _ _ _).trans hWq
  have hgWr : threePointCommonGcd dWp dWq dWr ∣ affineW R B r :=
    (threePointCommonGcd_dvd_right _ _ _).trans hWr
  have hUgV : Nat.Coprime (threePointCommonGcd dUp dUq dUr)
      (threePointCommonGcd dVp dVq dVr) :=
    Nat.Coprime.of_dvd hgUp hgVp hUVp
  have hUgW : Nat.Coprime (threePointCommonGcd dUp dUq dUr)
      (threePointCommonGcd dWp dWq dWr) :=
    Nat.Coprime.of_dvd hgUp hgWp hUWp
  have hVgW : Nat.Coprime (threePointCommonGcd dVp dVq dVr)
      (threePointCommonGcd dWp dWq dWr) :=
    Nat.Coprime.of_dvd hgVp hgWp hVWp
  have hUR : Nat.Coprime (threePointCommonGcd dUp dUq dUr) R :=
    Nat.Coprime.of_dvd hgUp (dvd_refl R) (by simp [affineU])
  have hVR : Nat.Coprime (threePointCommonGcd dVp dVq dVr) R :=
    Nat.Coprime.of_dvd hgVp (dvd_refl R) (by simp [affineV])
  have hWR : Nat.Coprime (threePointCommonGcd dWp dWq dWr) R :=
    Nat.Coprime.of_dvd hgWp (dvd_refl R) (by simp [affineW])
  have hq := affineTemplate_membership_gives_differenceDivisibilities
    (p := q) (q := p) hUR hVR hWR
    hgUq hgUp hgVq hgVp hgWq hgWp
  have hr := affineTemplate_membership_gives_differenceDivisibilities
    (p := r) (q := p) hUR hVR hWR
    hgUr hgUp hgVr hgVp hgWr hgWp
  exact ⟨hUgV, hUgW, hVgW, hq.1, hq.2.1, hq.2.2,
    hr.1, hr.2.1, hr.2.2⟩

#print axioms triplePoint_armDivisorGcds_give_adaptiveInterface

private theorem radical_72 : abcRadical 72 = 6 := by
  rw [show 72 = 2 ^ 3 * 3 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 2).prime) (by norm_num),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 3).prime) (by norm_num)]
  norm_num

private theorem radical_121 : abcRadical 121 = 11 := by
  rw [show 121 = 11 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 11).prime) (by norm_num)]
  norm_num

private theorem radical_961 : abcRadical 961 = 31 := by
  rw [show 961 = 31 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 31).prime) (by norm_num)]
  norm_num

/-- Canonical seed premises for the primitive seed `(1,B,C)`. -/
def seedOneCanonicalPremises (R B C M : ℕ) : Prop :=
  0 < B ∧ B < C ∧ 0 < R ∧
    1 + B = C ∧ Nat.Coprime 1 B ∧
    abcRadical (1 * B * C) = R ∧ M = canonicalBoxM C R

/-- A parameter lies in the positive canonical box and gives an admissible
primitive affine triple. -/
def certifiedAffinePointInBox
    (R B C M : ℕ) (p : ℕ × ℕ) : Prop :=
  1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M ∧
    Nat.Coprime (affineU R p) p.2 ∧
    Nat.Coprime (affineU R p) (affineV R C p) ∧
    Nat.Coprime (affineU R p) (affineW R B p) ∧
    Nat.Coprime (affineV R C p) (affineW R B p)

/-- A pointwise certificate consists of one divisor from each affine arm. -/
def armDivisorsAt (R B C : ℕ) (p : ℕ × ℕ)
    (dU dV dW : ℕ) : Prop :=
  dU ∣ affineU R p ∧ dV ∣ affineV R C p ∧ dW ∣ affineW R B p

/-- The false local assertion obtained by applying the nonzero cubic-product
bound to a pair whose first difference coordinate is zero.  All actual arm
divisibility, gcd, coprimality, box, and congruence premises are retained;
only the needed nonzero-direction alternative is absent. -/
def localZeroFirstGcdCubicImplication
    (R B C M : ℕ) (p q : ℕ × ℕ)
    (dUp dVp dWp dUq dVq dWq : ℕ) : Prop :=
  let gU := twoPointCommonGcd dUp dUq
  let gV := twoPointCommonGcd dVp dVq
  let gW := twoPointCommonGcd dWp dWq
  (seedOneCanonicalPremises R B C M ∧
      certifiedAffinePointInBox R B C M p ∧
      certifiedAffinePointInBox R B C M q ∧
      armDivisorsAt R B C p dUp dVp dWp ∧
      armDivisorsAt R B C q dUq dVq dWq ∧
      p ≠ q ∧
      Nat.Coprime gU gV ∧ Nat.Coprime gU gW ∧ Nat.Coprime gV gW ∧
      Nat.Coprime gU R ∧ Nat.Coprime gV R ∧ Nat.Coprime gW R ∧
      (gU : ℤ) ∣ (natPointDiff q p).1 ∧
      (gV : ℤ) ∣ (natPointDiff q p).1 +
        (C : ℤ) * (natPointDiff q p).2 ∧
      (gW : ℤ) ∣ (natPointDiff q p).1 +
        (B : ℤ) * (natPointDiff q p).2 ∧
      (natPointDiff q p).1 = 0) →
    gU * gV * gW ≤ (C + 1) ^ 2 * pairSupDist p q ^ 3

/-- The false local assertion that a common-gcd product larger than the
diameter-cubic scale forces three points to be noncollinear.  Its conclusion
is deliberately local: the sharp box-wide theorem still requires an already
nonzero determinant. -/
def localDiameterCubicNoncollinearityImplication
    (R B C M : ℕ) (p q r : ℕ × ℕ)
    (dUp dVp dWp dUq dVq dWq dUr dVr dWr : ℕ) : Prop :=
  let gU := threePointCommonGcd dUp dUq dUr
  let gV := threePointCommonGcd dVp dVq dVr
  let gW := threePointCommonGcd dWp dWq dWr
  (seedOneCanonicalPremises R B C M ∧
      certifiedAffinePointInBox R B C M p ∧
      certifiedAffinePointInBox R B C M q ∧
      certifiedAffinePointInBox R B C M r ∧
      armDivisorsAt R B C p dUp dVp dWp ∧
      armDivisorsAt R B C q dUq dVq dWq ∧
      armDivisorsAt R B C r dUr dVr dWr ∧
      p ≠ q ∧ p ≠ r ∧ q ≠ r ∧
      Nat.Coprime gU gV ∧ Nat.Coprime gU gW ∧ Nat.Coprime gV gW ∧
      (gU : ℤ) ∣ (natPointDiff q p).1 ∧
      (gV : ℤ) ∣ (natPointDiff q p).1 +
        (C : ℤ) * (natPointDiff q p).2 ∧
      (gW : ℤ) ∣ (natPointDiff q p).1 +
        (B : ℤ) * (natPointDiff q p).2 ∧
      (gU : ℤ) ∣ (natPointDiff r p).1 ∧
      (gV : ℤ) ∣ (natPointDiff r p).1 +
        (C : ℤ) * (natPointDiff r p).2 ∧
      (gW : ℤ) ∣ (natPointDiff r p).1 +
        (B : ℤ) * (natPointDiff r p).2 ∧
      (C + 1) ^ 2 * tripleSupDiameter p q r ^ 3 < gU * gV * gW) →
    natTriangleDet p q r ≠ 0

/-- The two canonical parameters `(20,1)` and `(20,2)` for the seed
`(1,8,9)` share the complete square kernel `121` in the `U` arm, but have
vertical difference of sup norm one.  This is the full in-box witness that
the zero-first-coordinate alternative cannot be deleted from a local
separation theorem. -/
theorem seed189_zeroFirstDirection_counterexample :
    let B : ℕ := 8
    let C : ℕ := 9
    let R : ℕ := 6
    let M : ℕ := canonicalBoxM C R
    let p : ℕ × ℕ := (20, 1)
    let q : ℕ × ℕ := (20, 2)
    1 + B = C ∧ Nat.Coprime 1 B ∧ abcRadical (1 * B * C) = R ∧
      M = 22143 ∧
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M ∧
      1 ≤ q.1 ∧ q.1 ≤ M ∧ 1 ≤ q.2 ∧ q.2 ≤ M ∧
      Nat.Coprime (affineU R p) p.2 ∧
      Nat.Coprime (affineU R q) q.2 ∧
      (affineU R p, affineV R C p, affineW R B p) =
        (121, 175, 169) ∧
      (affineU R q, affineV R C q, affineW R B q) =
        (121, 229, 217) ∧
      Nat.Coprime (affineU R p) (affineV R C p) ∧
      Nat.Coprime (affineU R p) (affineW R B p) ∧
      Nat.Coprime (affineV R C p) (affineW R B p) ∧
      Nat.Coprime (affineU R q) (affineV R C q) ∧
      Nat.Coprime (affineU R q) (affineW R B q) ∧
      Nat.Coprime (affineV R C q) (affineW R B q) ∧
      abcRadical 121 = 11 ∧ abcPowerfulPart 121 = 11 ∧
      affineU R p = affineU R q ∧
      natPointDiff q p = (0, 1) ∧
      pairSupDist p q = 1 ∧
      (B + 1) * (C + 1) < 121 ∧ (C + 1) ^ 2 < 121 := by
  norm_num [canonicalBoxM, affineU, affineV, affineW, natPointDiff,
    pairSupDist, Nat.dist, abcPowerfulPart, radical_72, radical_121]

/-- The three canonical parameters `(160,k)`, `k=1,2,3`, are collinear and
share the full square `U` kernel `961`.  Although `961` exceeds the local
cubic scale `(c+1)^2*2^3=800`, it is far below the box-wide square
`(M-1)^2`.  Thus this witness refutes only deletion of the collinearity
alternative from the local cubic branch; it does not refute the sharp
box-wide theorem. -/
theorem seed189_collinearLocalCubic_counterexample :
    let B : ℕ := 8
    let C : ℕ := 9
    let R : ℕ := 6
    let M : ℕ := canonicalBoxM C R
    let p : ℕ × ℕ := (160, 1)
    let q : ℕ × ℕ := (160, 2)
    let r : ℕ × ℕ := (160, 3)
    1 + B = C ∧ Nat.Coprime 1 B ∧ abcRadical (1 * B * C) = R ∧
      M = 22143 ∧
      1 ≤ p.1 ∧ p.1 ≤ M ∧ 1 ≤ p.2 ∧ p.2 ≤ M ∧
      1 ≤ q.1 ∧ q.1 ≤ M ∧ 1 ≤ q.2 ∧ q.2 ≤ M ∧
      1 ≤ r.1 ∧ r.1 ≤ M ∧ 1 ≤ r.2 ∧ r.2 ≤ M ∧
      Nat.Coprime (affineU R p) p.2 ∧
      Nat.Coprime (affineU R q) q.2 ∧
      Nat.Coprime (affineU R r) r.2 ∧
      (affineU R p, affineV R C p, affineW R B p) =
        (961, 1015, 1009) ∧
      (affineU R q, affineV R C q, affineW R B q) =
        (961, 1069, 1057) ∧
      (affineU R r, affineV R C r, affineW R B r) =
        (961, 1123, 1105) ∧
      Nat.Coprime (affineU R p) (affineV R C p) ∧
      Nat.Coprime (affineU R p) (affineW R B p) ∧
      Nat.Coprime (affineV R C p) (affineW R B p) ∧
      Nat.Coprime (affineU R q) (affineV R C q) ∧
      Nat.Coprime (affineU R q) (affineW R B q) ∧
      Nat.Coprime (affineV R C q) (affineW R B q) ∧
      Nat.Coprime (affineU R r) (affineV R C r) ∧
      Nat.Coprime (affineU R r) (affineW R B r) ∧
      Nat.Coprime (affineV R C r) (affineW R B r) ∧
      abcRadical 961 = 31 ∧ abcPowerfulPart 961 = 31 ∧
      affineU R p = affineU R q ∧ affineU R q = affineU R r ∧
      pairSupDist p q = 1 ∧ pairSupDist q r = 1 ∧
      pairSupDist p r = 2 ∧
      natTriangleDet p q r = 0 ∧
      (C + 1) ^ 2 * 2 ^ 3 < 961 ∧
      961 ≤ (M - 1) ^ 2 := by
  norm_num [canonicalBoxM, affineU, affineV, affineW, natTriangleDet,
    pairSupDist, Nat.dist, abcPowerfulPart, radical_72, radical_961]

/-- Full-premise failure of the *local* zero-first-direction cubic
implication.  The pointwise arm divisors are
`(121,25,169)` and `(121,1,1)`; their two-point common gcds are
`(121,1,1)`, with product `121`.  The conclusion would bound that product
by `100`, so the implication is false.  This statement makes no claim
against the box-wide determinant theorem. -/
theorem seed189_zeroFirstDirection_fullPremise_counterexample :
    let B : ℕ := 8
    let C : ℕ := 9
    let R : ℕ := 6
    let M : ℕ := canonicalBoxM C R
    let p : ℕ × ℕ := (20, 1)
    let q : ℕ × ℕ := (20, 2)
    let dUp : ℕ := 121
    let dVp : ℕ := 25
    let dWp : ℕ := 169
    let dUq : ℕ := 121
    let dVq : ℕ := 1
    let dWq : ℕ := 1
    let gU : ℕ := twoPointCommonGcd dUp dUq
    let gV : ℕ := twoPointCommonGcd dVp dVq
    let gW : ℕ := twoPointCommonGcd dWp dWq
    seedOneCanonicalPremises R B C M ∧
      certifiedAffinePointInBox R B C M p ∧
      certifiedAffinePointInBox R B C M q ∧
      armDivisorsAt R B C p dUp dVp dWp ∧
      armDivisorsAt R B C q dUq dVq dWq ∧
      (gU, gV, gW) = (121, 1, 1) ∧
      gU * gV * gW = 121 ∧
      Nat.Coprime gU gV ∧ Nat.Coprime gU gW ∧ Nat.Coprime gV gW ∧
      Nat.Coprime gU R ∧ Nat.Coprime gV R ∧ Nat.Coprime gW R ∧
      (gU : ℤ) ∣ (natPointDiff q p).1 ∧
      (gV : ℤ) ∣ (natPointDiff q p).1 +
        (C : ℤ) * (natPointDiff q p).2 ∧
      (gW : ℤ) ∣ (natPointDiff q p).1 +
        (B : ℤ) * (natPointDiff q p).2 ∧
      natPointDiff q p = (0, 1) ∧ pairSupDist p q = 1 ∧
      (B + 1) * (C + 1) = 90 ∧
      (C + 1) ^ 2 * pairSupDist p q ^ 3 = 100 ∧
      (B + 1) * (C + 1) < gU * gV * gW ∧
      (C + 1) ^ 2 * pairSupDist p q ^ 3 < gU * gV * gW ∧
      ¬ localZeroFirstGcdCubicImplication R B C M p q
        dUp dVp dWp dUq dVq dWq := by
  norm_num [seedOneCanonicalPremises, certifiedAffinePointInBox,
    armDivisorsAt, localZeroFirstGcdCubicImplication, twoPointCommonGcd,
    canonicalBoxM, affineU, affineV, affineW, natPointDiff, pairSupDist,
    Nat.dist, radical_72]

/-- Full-premise failure of the *local* diameter-cubic implication.  The
three pointwise `U` divisors are all `961` and the remaining six divisors are
`1`, so the triplewise common product is `961 > 800`.  The determinant is
nevertheless zero.  The additional checked inequality
`961 ≤ (M-1)^2` records inside the theorem that this example does not
contradict the sharp box-wide result. -/
theorem seed189_diameterCubic_fullPremise_counterexample :
    let B : ℕ := 8
    let C : ℕ := 9
    let R : ℕ := 6
    let M : ℕ := canonicalBoxM C R
    let p : ℕ × ℕ := (160, 1)
    let q : ℕ × ℕ := (160, 2)
    let r : ℕ × ℕ := (160, 3)
    let dUp : ℕ := 961
    let dVp : ℕ := 1
    let dWp : ℕ := 1
    let dUq : ℕ := 961
    let dVq : ℕ := 1
    let dWq : ℕ := 1
    let dUr : ℕ := 961
    let dVr : ℕ := 1
    let dWr : ℕ := 1
    let gU : ℕ := threePointCommonGcd dUp dUq dUr
    let gV : ℕ := threePointCommonGcd dVp dVq dVr
    let gW : ℕ := threePointCommonGcd dWp dWq dWr
    seedOneCanonicalPremises R B C M ∧
      certifiedAffinePointInBox R B C M p ∧
      certifiedAffinePointInBox R B C M q ∧
      certifiedAffinePointInBox R B C M r ∧
      armDivisorsAt R B C p dUp dVp dWp ∧
      armDivisorsAt R B C q dUq dVq dWq ∧
      armDivisorsAt R B C r dUr dVr dWr ∧
      (gU, gV, gW) = (961, 1, 1) ∧
      gU * gV * gW = 961 ∧
      Nat.Coprime gU gV ∧ Nat.Coprime gU gW ∧ Nat.Coprime gV gW ∧
      (gU : ℤ) ∣ (natPointDiff q p).1 ∧
      (gV : ℤ) ∣ (natPointDiff q p).1 +
        (C : ℤ) * (natPointDiff q p).2 ∧
      (gW : ℤ) ∣ (natPointDiff q p).1 +
        (B : ℤ) * (natPointDiff q p).2 ∧
      (gU : ℤ) ∣ (natPointDiff r p).1 ∧
      (gV : ℤ) ∣ (natPointDiff r p).1 +
        (C : ℤ) * (natPointDiff r p).2 ∧
      (gW : ℤ) ∣ (natPointDiff r p).1 +
        (B : ℤ) * (natPointDiff r p).2 ∧
      tripleSupDiameter p q r = 2 ∧
      (C + 1) ^ 2 * tripleSupDiameter p q r ^ 3 = 800 ∧
      (C + 1) ^ 2 * tripleSupDiameter p q r ^ 3 < gU * gV * gW ∧
      natTriangleDet p q r = 0 ∧
      gU * gV * gW ≤ (M - 1) ^ 2 ∧
      ¬ localDiameterCubicNoncollinearityImplication R B C M p q r
        dUp dVp dWp dUq dVq dWq dUr dVr dWr := by
  norm_num [seedOneCanonicalPremises, certifiedAffinePointInBox,
    armDivisorsAt, localDiameterCubicNoncollinearityImplication,
    twoPointCommonGcd, threePointCommonGcd, tripleSupDiameter,
    canonicalBoxM, affineU, affineV, affineW, natPointDiff,
    natTriangleDet, pairSupDist, Nat.dist, radical_72]

#print axioms seed189_zeroFirstDirection_counterexample
#print axioms seed189_collinearLocalCubic_counterexample
#print axioms seed189_zeroFirstDirection_fullPremise_counterexample
#print axioms seed189_diameterCubic_fullPremise_counterexample

end AffineAdaptiveCommonKernel20260901
end IUTThreeClosures
