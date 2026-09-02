/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineCatalogueWeightOverlap20260901

/-!
# Signed affine ray capacities and canonical arm energy

The mathematical proofs precede this module in
`research/ABC_AFFINE_SIGNED_RAY_CANONICAL_CAPS_2026_09_01.md`.

This file retains the strict large-label inequality in the ray-period
ledger.  It proves the linear capture squeeze, the signed non-arm cap, exact
capture and linear capacity on all three primitive arm-level directions, and
the optimal global conversion from shifted to unshifted cubic energy.  It
assumes no density theorem and proves no abc statement.
-/

namespace IUTThreeClosures
namespace AffineSignedRayCanonicalCaps20260901

open scoped BigOperators
open AffineTemplateEntropy20260901
open AffineAdaptiveCommonKernel20260901
open AffineCommonKernelTripleSelection20260901
open AffineCollinearPeriodEnergy20260901

/-! ## The exact period/span ledger -/

/-- Removing the first occurrence from an exact residue-class capacity
retains the complete period factor. -/
theorem shiftedCard_mul_period_le
    {card H T : ℕ} (hcard : card ≤ H / T + 1) :
    (card - 1) * T ≤ H := by
  have ha : card - 1 ≤ H / T := by
    apply Nat.sub_le_iff_le_add.mpr
    simpa [add_comm] using hcard
  calc
    (card - 1) * T ≤ (H / T) * T := Nat.mul_le_mul_right T ha
    _ ≤ H := Nat.div_mul_le_self H T

/-- The strict large-label inequality converts period capacity into a linear
bound by the direction capture.  This is the lossless arithmetic core of all
four signed direction branches. -/
theorem shiftedCard_mul_ambient_mul_scale_lt_capture
    {card H T capture D N L : ℕ}
    (hT : 0 < T)
    (hcard : card ≤ H / T + 1)
    (hspan : H * L ≤ N)
    (hfactor : T * capture = D)
    (hlarge : N ^ 2 < D) :
    (card - 1) * N * L < capture := by
  let a := card - 1
  have haT : a * T ≤ H := shiftedCard_mul_period_le hcard
  have haTL : a * T * L ≤ N :=
    (Nat.mul_le_mul_right L haT).trans hspan
  have hraw : T * (a * N * L) < T * capture := by
    calc
      T * (a * N * L) = (a * T * L) * N := by ring
      _ ≤ N * N := Nat.mul_le_mul_right N haTL
      _ = N ^ 2 := by ring
      _ < D := hlarge
      _ = T * capture := hfactor.symm
  exact (Nat.mul_lt_mul_left hT).mp hraw

/-- A period-weighted square consequence of the same exact ledger. -/
theorem shiftedCard_square_mul_period_scaleSq_lt_capture
    {card H T capture D N L : ℕ}
    (hT : 0 < T)
    (hcard : card ≤ H / T + 1)
    (hspan : H * L ≤ N)
    (hfactor : T * capture = D)
    (hlarge : N ^ 2 < D) :
    (card - 1) ^ 2 * T * L ^ 2 < capture := by
  let a := card - 1
  have haT : a * T ≤ H := shiftedCard_mul_period_le hcard
  have haTL : a * T * L ≤ N :=
    (Nat.mul_le_mul_right L haT).trans hspan
  have hlin := shiftedCard_mul_ambient_mul_scale_lt_capture
    hT hcard hspan hfactor hlarge
  change a ^ 2 * T * L ^ 2 < capture
  calc
    a ^ 2 * T * L ^ 2 = (a * T * L) * (a * L) := by ring
    _ ≤ N * (a * L) := Nat.mul_le_mul_right (a * L) haTL
    _ = a * N * L := by ring
    _ < capture := by simpa [a] using hlin

/-- A supplementary quadratic capture bound normalizes the square estimate
to one period factor.  This premise is distinct from the cubic non-arm
coefficient bound. -/
theorem shiftedCard_square_mul_period_lt_of_capture_le_quadratic
    {card H T capture D N L K : ℕ}
    (hT : 0 < T) (hL : 0 < L)
    (hcard : card ≤ H / T + 1)
    (hspan : H * L ≤ N)
    (hfactor : T * capture = D)
    (hlarge : N ^ 2 < D)
    (hcapture : capture ≤ K * L ^ 2) :
    (card - 1) ^ 2 * T < K := by
  have hsq := shiftedCard_square_mul_period_scaleSq_lt_capture
    hT hcard hspan hfactor hlarge
  have hchain : ((card - 1) ^ 2 * T) * L ^ 2 < K * L ^ 2 := by
    calc
      ((card - 1) ^ 2 * T) * L ^ 2 =
          (card - 1) ^ 2 * T * L ^ 2 := by ring
      _ < capture := hsq
      _ ≤ K * L ^ 2 := hcapture
  exact (Nat.mul_lt_mul_right (pow_pos hL 2)).mp hchain

/-- The period-squared shifted cubic cap, still retaining the exact capture. -/
theorem shiftedCard_cube_mul_periodSq_scaleCube_lt_capture_mul_ambient
    {card H T capture D N L : ℕ}
    (hT : 0 < T) (hN : 0 < N) (hL : 0 < L)
    (hcard : card ≤ H / T + 1)
    (hspan : H * L ≤ N)
    (hfactor : T * capture = D)
    (hlarge : N ^ 2 < D) :
    (card - 1) ^ 3 * T ^ 2 * L ^ 3 < capture * N := by
  let a := card - 1
  have haT : a * T ≤ H := shiftedCard_mul_period_le hcard
  have haTL : a * T * L ≤ N :=
    (Nat.mul_le_mul_right L haT).trans hspan
  have hsq := shiftedCard_square_mul_period_scaleSq_lt_capture
    hT hcard hspan hfactor hlarge
  by_cases ha : a = 0
  · change a ^ 3 * T ^ 2 * L ^ 3 < capture * N
    rw [ha]
    simp only [zero_pow (by norm_num : 3 ≠ 0), zero_mul]
    have hcap : 0 < capture := by
      by_contra hz
      have : capture = 0 := Nat.eq_zero_of_not_pos hz
      rw [this, mul_zero] at hfactor
      omega
    exact mul_pos hcap hN
  · have hapos : 0 < a := Nat.pos_of_ne_zero ha
    have hmultPos : 0 < a * T * L := mul_pos (mul_pos hapos hT) hL
    have hmul : (a * T * L) * (a ^ 2 * T * L ^ 2) <
        (a * T * L) * capture :=
      (Nat.mul_lt_mul_left hmultPos).2 (by simpa [a] using hsq)
    calc
      a ^ 3 * T ^ 2 * L ^ 3 =
          (a * T * L) * (a ^ 2 * T * L ^ 2) := by ring
      _ < (a * T * L) * capture := hmul
      _ ≤ N * capture := Nat.mul_le_mul_right capture haTL
      _ = capture * N := by ring

/-- The exact physical period cube. -/
theorem shiftedCard_physicalPeriod_cube_lt_labelProduct_mul_ambient
    {card H T capture D N L : ℕ}
    (hT : 0 < T) (hN : 0 < N) (hL : 0 < L)
    (hcard : card ≤ H / T + 1)
    (hspan : H * L ≤ N)
    (hfactor : T * capture = D)
    (hlarge : N ^ 2 < D) :
    ((card - 1) * T * L) ^ 3 < D * N := by
  have hcubic := shiftedCard_cube_mul_periodSq_scaleCube_lt_capture_mul_ambient
    hT hN hL hcard hspan hfactor hlarge
  have hmul : T * ((card - 1) ^ 3 * T ^ 2 * L ^ 3) <
      T * (capture * N) := (Nat.mul_lt_mul_left hT).2 hcubic
  calc
    ((card - 1) * T * L) ^ 3 =
        T * ((card - 1) ^ 3 * T ^ 2 * L ^ 3) := by ring
    _ < T * (capture * N) := hmul
    _ = D * N := by rw [← hfactor]; ring

/-! ## Signed non-arm directions -/

/-- Sup scale of a signed primitive direction. -/
def signedDirectionScale (s t : ℤ) : ℕ := max s.natAbs t.natAbs

/-- Absolute product of the three affine direction coefficients. -/
def signedDirectionProduct (B C : ℕ) (s t : ℤ) : ℕ :=
  s.natAbs * (s + (C : ℤ) * t).natAbs *
    (s + (B : ℤ) * t).natAbs

/-- Direction capture with arbitrary signed coefficients. -/
def signedDirectionCapture (label : ArmDivisorLabel)
    (B C : ℕ) (s t : ℤ) : ℕ :=
  directionCapture label s.natAbs
    (s + (C : ℤ) * t).natAbs
    (s + (B : ℤ) * t).natAbs

/-- Product of the three reduced periods for arbitrary signed direction
coefficients. -/
def signedDirectionPeriod (label : ArmDivisorLabel)
    (B C : ℕ) (s t : ℤ) : ℕ :=
  directionPeriod label s.natAbs
    (s + (C : ℤ) * t).natAbs
    (s + (B : ℤ) * t).natAbs

theorem signedDirectionPeriod_pos
    {label : ArmDivisorLabel} {B C : ℕ} {s t : ℤ}
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w) :
    0 < signedDirectionPeriod label B C s t :=
  directionPeriod_pos hu hv hw

/-- Exact signed factorization into reduced period and captured part. -/
theorem signedDirectionPeriod_mul_capture
    (label : ArmDivisorLabel) (B C : ℕ) (s t : ℤ) :
    signedDirectionPeriod label B C s t *
      signedDirectionCapture label B C s t = label.product :=
  directionPeriod_mul_capture label _ _ _

/-- Signed component divisibilities and pairwise coprimality make the product
of the three reduced periods divide the index gap. -/
theorem signedDirectionPeriod_dvd_gap
    {label : ArmDivisorLabel} {B C gap : ℕ} {s t : ℤ}
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (hpair : label.PairwiseCoprime)
    (hU : label.u ∣ gap * s.natAbs)
    (hV : label.v ∣ gap * (s + (C : ℤ) * t).natAbs)
    (hW : label.w ∣ gap * (s + (B : ℤ) * t).natAbs) :
    signedDirectionPeriod label B C s t ∣ gap :=
  directionPeriod_dvd_gap hu hv hw hpair hU hV hW

/-- Convert an integer signed direction divisibility into the natural
absolute-coefficient form used by `signedDirectionPeriod_dvd_gap`. -/
theorem nat_dvd_gap_mul_natAbs_of_intCast_dvd
    {d gap : ℕ} {A : ℤ} (h : (d : ℤ) ∣ (gap : ℤ) * A) :
    d ∣ gap * A.natAbs := by
  have habs : Int.natAbs (d : ℤ) ∣ Int.natAbs ((gap : ℤ) * A) :=
    Int.natAbs_dvd_natAbs.mpr h
  simpa [Int.natAbs_mul] using habs

/-- Two actual affine occurrences whose coordinate difference is an integer
multiple of a signed direction have index gap divisible by the exact signed
direction period. -/
theorem actualSignedLine_directionPeriod_dvd_gap
    {R B C gap : ℕ} {p q : ℕ × ℕ} {s t : ℤ}
    {label : ArmDivisorLabel}
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (hpair : label.PairwiseCoprime)
    (hp : armDivisorsAt R B C p label.u label.v label.w)
    (hq : armDivisorsAt R B C q label.u label.v label.w)
    (hfirst : (p.1 : ℤ) - q.1 = (gap : ℤ) * s)
    (hsecond : (p.2 : ℤ) - q.2 = (gap : ℤ) * t) :
    signedDirectionPeriod label B C s t ∣ gap := by
  have hUR : Nat.Coprime label.u R :=
    Nat.Coprime.of_dvd hp.1 (dvd_refl R) (by simp [affineU])
  have hVR : Nat.Coprime label.v R :=
    Nat.Coprime.of_dvd hp.2.1 (dvd_refl R) (by simp [affineV])
  have hWR : Nat.Coprime label.w R :=
    Nat.Coprime.of_dvd hp.2.2 (dvd_refl R) (by simp [affineW])
  obtain ⟨hUint, hVint, hWint⟩ :=
    affineTemplate_membership_gives_differenceDivisibilities
      hUR hVR hWR hp.1 hq.1 hp.2.1 hq.2.1 hp.2.2 hq.2.2
  have hUint' : (label.u : ℤ) ∣ (gap : ℤ) * s := by
    simpa [hfirst] using hUint
  have hVint' : (label.v : ℤ) ∣
      (gap : ℤ) * (s + (C : ℤ) * t) := by
    rw [hfirst, hsecond] at hVint
    convert hVint using 1
    ring
  have hWint' : (label.w : ℤ) ∣
      (gap : ℤ) * (s + (B : ℤ) * t) := by
    rw [hfirst, hsecond] at hWint
    convert hWint using 1
    ring
  exact signedDirectionPeriod_dvd_gap hu hv hw hpair
    (nat_dvd_gap_mul_natAbs_of_intCast_dvd hUint')
    (nat_dvd_gap_mul_natAbs_of_intCast_dvd hVint')
    (nat_dvd_gap_mul_natAbs_of_intCast_dvd hWint')

/-- On the non-arm branch the capture is at most the exact absolute
coefficient product. -/
theorem signedDirectionCapture_le_product
    (label : ArmDivisorLabel) {B C : ℕ} {s t : ℤ}
    (hU : s ≠ 0)
    (hV : s + (C : ℤ) * t ≠ 0)
    (hW : s + (B : ℤ) * t ≠ 0) :
    signedDirectionCapture label B C s t ≤
      signedDirectionProduct B C s t := by
  have hgU : Nat.gcd label.u s.natAbs ≤ s.natAbs :=
    Nat.gcd_le_right _ (Int.natAbs_pos.mpr hU)
  have hgV : Nat.gcd label.v (s + (C : ℤ) * t).natAbs ≤
      (s + (C : ℤ) * t).natAbs :=
    Nat.gcd_le_right _ (Int.natAbs_pos.mpr hV)
  have hgW : Nat.gcd label.w (s + (B : ℤ) * t).natAbs ≤
      (s + (B : ℤ) * t).natAbs :=
    Nat.gcd_le_right _ (Int.natAbs_pos.mpr hW)
  exact Nat.mul_le_mul (Nat.mul_le_mul hgU hgV) hgW

/-- Sharp universal cubic coefficient bound for signed directions. -/
theorem signedDirectionProduct_le_sharp_cubic
    {B C : ℕ} (s t : ℤ) :
    signedDirectionProduct B C s t ≤
      (B + 1) * (C + 1) * signedDirectionScale s t ^ 3 := by
  have hU : s.natAbs ≤ signedDirectionScale s t := Nat.le_max_left _ _
  have hV : (s + (C : ℤ) * t).natAbs ≤
      (C + 1) * signedDirectionScale s t :=
    secondForm_natAbs_le s t
  have hW : (s + (B : ℤ) * t).natAbs ≤
      (B + 1) * signedDirectionScale s t :=
    secondForm_natAbs_le s t
  calc
    signedDirectionProduct B C s t ≤
        signedDirectionScale s t *
          ((C + 1) * signedDirectionScale s t) *
            ((B + 1) * signedDirectionScale s t) := by
      exact Nat.mul_le_mul (Nat.mul_le_mul hU hV) hW
    _ = (B + 1) * (C + 1) * signedDirectionScale s t ^ 3 := by ring

/-- The universal coefficient is attained by the primitive direction
`(1,1)`. -/
theorem signedDirectionProduct_one_one_is_sharp (B C : ℕ) :
    signedDirectionProduct B C 1 1 =
      (B + 1) * (C + 1) * signedDirectionScale 1 1 ^ 3 := by
  have hC : (1 + (C : ℤ)).natAbs = C + 1 := by
    rw [show (1 : ℤ) + (C : ℤ) = ((C + 1 : ℕ) : ℤ) by omega,
      Int.natAbs_natCast]
  have hB : (1 + (B : ℤ)).natAbs = B + 1 := by
    rw [show (1 : ℤ) + (B : ℤ) = ((B + 1 : ℕ) : ℤ) by omega,
      Int.natAbs_natCast]
  simp [signedDirectionProduct, signedDirectionScale, hB, hC]
  ring

/-- Direction scale is positive for a nonzero signed direction. -/
theorem signedDirectionScale_pos {s t : ℤ} (hdir : s ≠ 0 ∨ t ≠ 0) :
    0 < signedDirectionScale s t := by
  unfold signedDirectionScale
  rcases hdir with hs | ht
  · exact lt_of_lt_of_le (Int.natAbs_pos.mpr hs) (Nat.le_max_left _ _)
  · exact lt_of_lt_of_le (Int.natAbs_pos.mpr ht) (Nat.le_max_right _ _)

/-- Pure signed non-arm cap after the exact period capacity is supplied. -/
theorem signedNonarm_shifted_mul_ambient_scale_lt_product
    {card H T D N B C : ℕ} {s t : ℤ} (label : ArmDivisorLabel)
    (_hdir : s ≠ 0 ∨ t ≠ 0)
    (hU : s ≠ 0)
    (hV : s + (C : ℤ) * t ≠ 0)
    (hW : s + (B : ℤ) * t ≠ 0)
    (hT : 0 < T)
    (hcard : card ≤ H / T + 1)
    (hspan : H * signedDirectionScale s t ≤ N)
    (hfactor : T * signedDirectionCapture label B C s t = D)
    (hlarge : N ^ 2 < D) :
    (card - 1) * N * signedDirectionScale s t <
      signedDirectionProduct B C s t := by
  exact (shiftedCard_mul_ambient_mul_scale_lt_capture hT hcard hspan
    hfactor hlarge).trans_le
      (signedDirectionCapture_le_product label hU hV hW)

/-- Retaining the period gives an inverse-square-period cubic cap with the
sharp universal direction coefficient. -/
theorem signedNonarm_shiftedCube_mul_periodSq_lt
    {card H T D N B C : ℕ} {s t : ℤ} (label : ArmDivisorLabel)
    (hdir : s ≠ 0 ∨ t ≠ 0)
    (hU : s ≠ 0)
    (hV : s + (C : ℤ) * t ≠ 0)
    (hW : s + (B : ℤ) * t ≠ 0)
    (hT : 0 < T) (hN : 0 < N)
    (hcard : card ≤ H / T + 1)
    (hspan : H * signedDirectionScale s t ≤ N)
    (hfactor : T * signedDirectionCapture label B C s t = D)
    (hlarge : N ^ 2 < D) :
    (card - 1) ^ 3 * T ^ 2 < (B + 1) * (C + 1) * N := by
  let L := signedDirectionScale s t
  have hL : 0 < L := signedDirectionScale_pos hdir
  have hcubic := shiftedCard_cube_mul_periodSq_scaleCube_lt_capture_mul_ambient
    hT hN hL hcard hspan hfactor hlarge
  have hcap := (signedDirectionCapture_le_product label hU hV hW).trans
    (signedDirectionProduct_le_sharp_cubic (B := B) (C := C) s t)
  have hchain : (card - 1) ^ 3 * T ^ 2 * L ^ 3 <
      ((B + 1) * (C + 1) * N) * L ^ 3 := by
    calc
      (card - 1) ^ 3 * T ^ 2 * L ^ 3 <
          signedDirectionCapture label B C s t * N := hcubic
      _ ≤ ((B + 1) * (C + 1) * L ^ 3) * N :=
        Nat.mul_le_mul_right N hcap
      _ = ((B + 1) * (C + 1) * N) * L ^ 3 := by ring
  exact (Nat.mul_lt_mul_right (pow_pos hL 3)).mp (by
    simpa [mul_assoc] using hchain)

/-- Any direction below the square-root direction threshold supports no
second occurrence of a large non-arm label. -/
theorem signedNonarm_smallDirection_is_singleton
    {card H T D N B C : ℕ} {s t : ℤ} (label : ArmDivisorLabel)
    (hcardPos : 0 < card)
    (hdir : s ≠ 0 ∨ t ≠ 0)
    (hU : s ≠ 0)
    (hV : s + (C : ℤ) * t ≠ 0)
    (hW : s + (B : ℤ) * t ≠ 0)
    (hT : 0 < T)
    (hcard : card ≤ H / T + 1)
    (hspan : H * signedDirectionScale s t ≤ N)
    (hfactor : T * signedDirectionCapture label B C s t = D)
    (hlarge : N ^ 2 < D)
    (hsmall : (B + 1) * (C + 1) * signedDirectionScale s t ^ 2 ≤ N) :
    card = 1 := by
  let a := card - 1
  let L := signedDirectionScale s t
  have hL : 0 < L := signedDirectionScale_pos hdir
  have hlin := signedNonarm_shifted_mul_ambient_scale_lt_product label
    hdir hU hV hW hT hcard hspan hfactor hlarge
  have hprod := signedDirectionProduct_le_sharp_cubic (B := B) (C := C) s t
  by_contra hne
  have ha : 0 < a := by dsimp [a]; omega
  have hNL : N * L ≤ a * N * L := by
    calc
      N * L = 1 * N * L := by simp
      _ ≤ a * N * L := Nat.mul_le_mul_right L
        (Nat.mul_le_mul_right N (by omega))
  have hupper : (B + 1) * (C + 1) * L ^ 3 ≤ N * L := by
    calc
      (B + 1) * (C + 1) * L ^ 3 =
          ((B + 1) * (C + 1) * L ^ 2) * L := by ring
      _ ≤ N * L := Nat.mul_le_mul_right L hsmall
  have hlin' : a * N * L < signedDirectionProduct B C s t := by
    simpa [a, L] using hlin
  have hprod' : signedDirectionProduct B C s t ≤
      (B + 1) * (C + 1) * L ^ 3 := by
    simpa [L] using hprod
  have : N * L < N * L :=
    hNL.trans_lt (hlin'.trans_le (hprod'.trans hupper))
  exact (Nat.lt_irrefl _ this).elim

/-! ## Exact canonical arm captures -/

/-- Primitive vertical direction: the capture is exactly the constant
`U`-component under the canonical coefficient coprimalities. -/
theorem directionCapture_zeroU_eq
    (label : ArmDivisorLabel) {B C : ℕ}
    (hVC : Nat.Coprime label.v C) (hWB : Nat.Coprime label.w B) :
    directionCapture label 0 C B = label.u := by
  simp [directionCapture, hVC.gcd_eq_one, hWB.gcd_eq_one]

/-- Primitive `V`-level direction `(C,-1)` when `C-B=1`. -/
theorem directionCapture_zeroV_eq
    (label : ArmDivisorLabel) {C : ℕ}
    (hUC : Nat.Coprime label.u C) :
    directionCapture label C 0 1 = label.v := by
  simp [directionCapture, hUC.gcd_eq_one]

/-- Primitive `W`-level direction `(B,-1)` when `C-B=1`. -/
theorem directionCapture_zeroW_eq
    (label : ArmDivisorLabel) {B : ℕ}
    (hUB : Nat.Coprime label.u B) :
    directionCapture label B 1 0 = label.w := by
  simp [directionCapture, hUB.gcd_eq_one]

/-- Linear capacity on the primitive `U`-level direction. -/
theorem zeroU_shifted_mul_ambient_lt
    {card H N B C : ℕ} (label : ArmDivisorLabel)
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (hVC : Nat.Coprime label.v C) (hWB : Nat.Coprime label.w B)
    (hcard : card ≤ H / directionPeriod label 0 C B + 1)
    (hspan : H ≤ N)
    (hlarge : N ^ 2 < label.product) :
    (card - 1) * N < label.u := by
  let T := directionPeriod label 0 C B
  have hT : 0 < T := directionPeriod_pos hu hv hw
  have hfactor : T * label.u = label.product := by
    rw [← directionCapture_zeroU_eq label hVC hWB]
    exact directionPeriod_mul_capture label 0 C B
  have := shiftedCard_mul_ambient_mul_scale_lt_capture
    (card := card) (H := H) (T := T) (capture := label.u)
    (D := label.product) (N := N) (L := 1)
    hT (by simpa [T] using hcard) (by simpa using hspan) hfactor hlarge
  simpa using this

/-- Linear capacity on the primitive `V`-level direction. -/
theorem zeroV_shifted_mul_ambient_scale_lt
    {card H N C : ℕ} (label : ArmDivisorLabel)
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (_hC : 0 < C) (hUC : Nat.Coprime label.u C)
    (hcard : card ≤ H / directionPeriod label C 0 1 + 1)
    (hspan : H * C ≤ N)
    (hlarge : N ^ 2 < label.product) :
    (card - 1) * N * C < label.v := by
  let T := directionPeriod label C 0 1
  have hT : 0 < T := directionPeriod_pos hu hv hw
  have hfactor : T * label.v = label.product := by
    rw [← directionCapture_zeroV_eq label hUC]
    exact directionPeriod_mul_capture label C 0 1
  exact shiftedCard_mul_ambient_mul_scale_lt_capture
    hT (by simpa [T] using hcard) hspan hfactor hlarge

/-- Linear capacity on the primitive `W`-level direction. -/
theorem zeroW_shifted_mul_ambient_scale_lt
    {card H N B : ℕ} (label : ArmDivisorLabel)
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (_hB : 0 < B) (hUB : Nat.Coprime label.u B)
    (hcard : card ≤ H / directionPeriod label B 1 0 + 1)
    (hspan : H * B ≤ N)
    (hlarge : N ^ 2 < label.product) :
    (card - 1) * N * B < label.w := by
  let T := directionPeriod label B 1 0
  have hT : 0 < T := directionPeriod_pos hu hv hw
  have hfactor : T * label.w = label.product := by
    rw [← directionCapture_zeroW_eq label hUB]
    exact directionPeriod_mul_capture label B 1 0
  exact shiftedCard_mul_ambient_mul_scale_lt_capture
    hT (by simpa [T] using hcard) hspan hfactor hlarge

/-- Factor-three canonical specialization of the `U`-level cap. -/
theorem zeroU_three_mul_shifted_ambient_lt_power
    {card N c dU : ℕ}
    (hcap : (card - 1) * N < dU)
    (harm : 3 * dU ≤ c ^ 6) :
    3 * (card - 1) * N < c ^ 6 := by
  calc
    3 * (card - 1) * N = 3 * ((card - 1) * N) := by ring
    _ < 3 * dU := Nat.mul_lt_mul_left (by norm_num) |>.2 hcap
    _ ≤ c ^ 6 := harm

/-- Factor-three canonical specialization of the `V`-level cap. -/
theorem zeroV_three_mul_shifted_ambient_scale_lt_power
    {card N C c dV : ℕ}
    (hcap : (card - 1) * N * C < dV)
    (harm : 3 * dV ≤ c ^ 7) :
    3 * (card - 1) * N * C < c ^ 7 := by
  calc
    3 * (card - 1) * N * C = 3 * ((card - 1) * N * C) := by ring
    _ < 3 * dV := Nat.mul_lt_mul_left (by norm_num) |>.2 hcap
    _ ≤ c ^ 7 := harm

/-- Factor-three canonical specialization of the `W`-level cap. -/
theorem zeroW_three_mul_shifted_ambient_scale_lt_power
    {card N B c dW : ℕ}
    (hcap : (card - 1) * N * B < dW)
    (harm : 3 * dW ≤ c ^ 7) :
    3 * (card - 1) * N * B < c ^ 7 := by
  calc
    3 * (card - 1) * N * B = 3 * ((card - 1) * N * B) := by ring
    _ < 3 * dW := Nat.mul_lt_mul_left (by norm_num) |>.2 hcap
    _ ≤ c ^ 7 := harm

/-! ## Shifted energy to global energy -/

/-- Optimal singleton-plus-shifted cubic conversion. -/
theorem cube_le_one_add_seven_shiftedCube (n : ℕ) :
    n ^ 3 ≤ 1 + 7 * (n - 1) ^ 3 := by
  by_cases hn0 : n = 0
  · subst n
    norm_num
  by_cases hn1 : n = 1
  · subst n
    norm_num
  let a := n - 1
  have hna : n = a + 1 := by dsimp [a]; omega
  have ha : 0 < a := by dsimp [a]; omega
  obtain ⟨b, hb⟩ : ∃ b, a = b + 1 := Nat.exists_eq_succ_of_ne_zero (ne_of_gt ha)
  rw [hna]
  rw [hb]
  simp only [Nat.add_sub_cancel]
  have hid : 1 + 7 * (b + 1) ^ 3 =
      (b + 1 + 1) ^ 3 + 3 * (b + 1) * b * (2 * (b + 1) + 1) := by ring
  rw [hid]
  omega

/-- The coefficient seven is forced already at occupancy two. -/
theorem factorSix_singletonShift_counterexample :
    ¬ (2 ^ 3 ≤ 1 + 6 * (2 - 1) ^ 3) := by norm_num

/-- Global weighted large-label energy is its singleton catalogue baseline
plus at most seven times its shifted energy. -/
theorem weightedCubicEnergy_le_catalogue_add_sevenShifted
    {α : Type*} (s : Finset α) (weight count : α → ℕ) :
    ∑ i ∈ s, weight i * count i ^ 3 ≤
      (∑ i ∈ s, weight i) +
        7 * ∑ i ∈ s, weight i * (count i - 1) ^ 3 := by
  calc
    ∑ i ∈ s, weight i * count i ^ 3 ≤
        ∑ i ∈ s, weight i * (1 + 7 * (count i - 1) ^ 3) := by
      exact Finset.sum_le_sum fun i hi ↦
        Nat.mul_le_mul_left (weight i) (cube_le_one_add_seven_shiftedCube _)
    _ = (∑ i ∈ s, weight i) +
        7 * ∑ i ∈ s, weight i * (count i - 1) ^ 3 := by
      simp_rw [mul_add]
      simp only [mul_one, Finset.sum_add_distrib]
      rw [Finset.mul_sum]
      apply congrArg₂ (· + ·) rfl
      apply Finset.sum_congr rfl
      intro i _hi
      ring

/-- Label-specific shifted caps aggregate globally without a number-of-rays
factor. -/
theorem weightedCubicEnergy_le_catalogue_add_caps
    {α : Type*} (s : Finset α) (weight count cap : α → ℕ)
    (hcap : ∀ i ∈ s, (count i - 1) ^ 3 ≤ cap i) :
    ∑ i ∈ s, weight i * count i ^ 3 ≤
      (∑ i ∈ s, weight i) + 7 * ∑ i ∈ s, weight i * cap i := by
  refine (weightedCubicEnergy_le_catalogue_add_sevenShifted
    s weight count).trans ?_
  apply Nat.add_le_add_left
  apply Nat.mul_le_mul_left
  exact Finset.sum_le_sum fun i hi ↦
    Nat.mul_le_mul_left (weight i) (hcap i hi)

/-- A fixed arm scale converts the linear capture squeeze into a global
third-moment bound. -/
theorem weightedShiftedEnergy_mul_scaledAmbientCube_le_armMoment
    {α : Type*} (s : Finset α) (weight count arm : α → ℕ)
    {N L : ℕ}
    (hcap : ∀ i ∈ s, (count i - 1) * N * L < arm i) :
    (N * L) ^ 3 * ∑ i ∈ s, weight i * (count i - 1) ^ 3 ≤
      ∑ i ∈ s, weight i * arm i ^ 3 := by
  rw [Finset.mul_sum]
  apply Finset.sum_le_sum
  intro i hi
  have hp : ((count i - 1) * N * L) ^ 3 ≤ arm i ^ 3 :=
    Nat.pow_le_pow_left (Nat.le_of_lt (hcap i hi)) 3
  calc
    (N * L) ^ 3 * (weight i * (count i - 1) ^ 3) =
        weight i * (((count i - 1) * N * L) ^ 3) := by ring
    _ ≤ weight i * arm i ^ 3 := Nat.mul_le_mul_left (weight i) hp

/-- Abstract owner-catalogue third-moment bound.  Each distinct label is
assigned to exactly one containing catalogue; the per-owner weight budget
then controls the coordinate moment without any disjointness premise on the
original catalogues. -/
theorem weightedCoordinateMoment_le_ownerCatalogue
    {α κ : Type*} [DecidableEq κ]
    (labels : Finset α) (classes : Finset κ)
    (owner : α → κ) (weight coordinate : α → ℕ)
    (mass cap : κ → ℕ)
    (hmaps : ∀ i ∈ labels, owner i ∈ classes)
    (hcoordinate : ∀ i ∈ labels, coordinate i ≤ cap (owner i))
    (hmass : ∀ k ∈ classes,
      ∑ i ∈ labels.filter (fun i ↦ owner i = k), weight i ≤ mass k) :
    ∑ i ∈ labels, weight i * coordinate i ^ 3 ≤
      ∑ k ∈ classes, mass k * cap k ^ 3 := by
  classical
  have hdecomp :
      (∑ i ∈ labels, weight i * coordinate i ^ 3) =
        ∑ k ∈ classes,
          ∑ i ∈ labels.filter (fun i ↦ owner i = k),
            weight i * coordinate i ^ 3 := by
    calc
      (∑ i ∈ labels, weight i * coordinate i ^ 3) =
          ∑ i ∈ labels, ∑ k ∈ classes,
            if owner i = k then weight i * coordinate i ^ 3 else 0 := by
        apply Finset.sum_congr rfl
        intro i hi
        simp [hmaps i hi]
      _ = ∑ k ∈ classes, ∑ i ∈ labels,
            if owner i = k then weight i * coordinate i ^ 3 else 0 := by
        rw [Finset.sum_comm]
      _ = ∑ k ∈ classes,
          ∑ i ∈ labels.filter (fun i ↦ owner i = k),
            weight i * coordinate i ^ 3 := by
        apply Finset.sum_congr rfl
        intro k _hk
        simp [Finset.sum_filter]
  rw [hdecomp]
  apply Finset.sum_le_sum
  intro k hk
  calc
    (∑ i ∈ labels.filter (fun i ↦ owner i = k),
        weight i * coordinate i ^ 3) ≤
        ∑ i ∈ labels.filter (fun i ↦ owner i = k),
          weight i * cap k ^ 3 := by
      apply Finset.sum_le_sum
      intro i hi
      have hi' := Finset.mem_filter.mp hi
      have hcoord : coordinate i ≤ cap k := by
        simpa [hi'.2] using hcoordinate i hi'.1
      exact Nat.mul_le_mul_left (weight i)
        (Nat.pow_le_pow_left hcoord 3)
    _ = (∑ i ∈ labels.filter (fun i ↦ owner i = k), weight i) *
        cap k ^ 3 := by rw [Finset.sum_mul]
    _ ≤ mass k * cap k ^ 3 :=
      Nat.mul_le_mul_right (cap k ^ 3) (hmass k hk)

/-- Owner-catalogue moment bound with the coordinate condition stated in its
actual divisor form.  The per-owner totient mass budget is the exact Euler
catalogue identity supplied by the imported catalogue module. -/
theorem weightedCoordinateMoment_le_ownerCatalogue_of_dvd
    {α κ : Type*} [DecidableEq κ]
    (labels : Finset α) (classes : Finset κ)
    (owner : α → κ) (weight coordinate : α → ℕ)
    (mass cap : κ → ℕ)
    (hmaps : ∀ i ∈ labels, owner i ∈ classes)
    (hcapPos : ∀ k ∈ classes, 0 < cap k)
    (hcoordinateDvd : ∀ i ∈ labels, coordinate i ∣ cap (owner i))
    (hmass : ∀ k ∈ classes,
      ∑ i ∈ labels.filter (fun i ↦ owner i = k), weight i ≤ mass k) :
    ∑ i ∈ labels, weight i * coordinate i ^ 3 ≤
      ∑ k ∈ classes, mass k * cap k ^ 3 := by
  apply weightedCoordinateMoment_le_ownerCatalogue
    labels classes owner weight coordinate mass cap hmaps
  · intro i hi
    exact Nat.le_of_dvd (hcapPos (owner i) (hmaps i hi))
      (hcoordinateDvd i hi)
  · exact hmass

/-- The corresponding owner-catalogue baseline-weight bound. -/
theorem weightedCatalogue_le_ownerMass
    {α κ : Type*} [DecidableEq κ]
    (labels : Finset α) (classes : Finset κ)
    (owner : α → κ) (weight : α → ℕ) (mass : κ → ℕ)
    (hmaps : ∀ i ∈ labels, owner i ∈ classes)
    (hmass : ∀ k ∈ classes,
      ∑ i ∈ labels.filter (fun i ↦ owner i = k), weight i ≤ mass k) :
    ∑ i ∈ labels, weight i ≤ ∑ k ∈ classes, mass k := by
  classical
  have hdecomp : (∑ i ∈ labels, weight i) =
      ∑ k ∈ classes,
        ∑ i ∈ labels.filter (fun i ↦ owner i = k), weight i := by
    calc
      (∑ i ∈ labels, weight i) =
          ∑ i ∈ labels, ∑ k ∈ classes,
            if owner i = k then weight i else 0 := by
        apply Finset.sum_congr rfl
        intro i hi
        simp [hmaps i hi]
      _ = ∑ k ∈ classes, ∑ i ∈ labels,
            if owner i = k then weight i else 0 := by
        rw [Finset.sum_comm]
      _ = ∑ k ∈ classes,
          ∑ i ∈ labels.filter (fun i ↦ owner i = k), weight i := by
        apply Finset.sum_congr rfl
        intro k _hk
        simp [Finset.sum_filter]
  rw [hdecomp]
  exact Finset.sum_le_sum hmass

/-- Final finite assembly: an owner baseline and separate non-arm and arm
shifted charges control the complete unshifted cubic energy. -/
theorem weightedCubicEnergy_le_ownerMass_add_sevenCharges
    {α : Type*} (labels : Finset α) (weight count : α → ℕ)
    (ownerMass nonarmCharge armCharge : ℕ)
    (hbase : ∑ i ∈ labels, weight i ≤ ownerMass)
    (hshift : ∑ i ∈ labels, weight i * (count i - 1) ^ 3 ≤
      nonarmCharge + armCharge) :
    ∑ i ∈ labels, weight i * count i ^ 3 ≤
      ownerMass + 7 * nonarmCharge + 7 * armCharge := by
  calc
    ∑ i ∈ labels, weight i * count i ^ 3 ≤
        (∑ i ∈ labels, weight i) +
          7 * ∑ i ∈ labels, weight i * (count i - 1) ^ 3 :=
      weightedCubicEnergy_le_catalogue_add_sevenShifted labels weight count
    _ ≤ ownerMass + 7 * (nonarmCharge + armCharge) :=
      Nat.add_le_add hbase (Nat.mul_le_mul_left 7 hshift)
    _ = ownerMass + 7 * nonarmCharge + 7 * armCharge := by ring

/-! ## Exact countermodels for over-strengthenings -/

/-- Replacing the strict large-label threshold by a closed threshold breaks
the linear capture squeeze with every other ledger premise retained. -/
theorem closedLargeThreshold_breaks_captureSqueeze :
    let card := 2
    let H := 1
    let T := 1
    let capture := 1
    let D := 1
    let N := 1
    let L := 1
    0 < T ∧ card ≤ H / T + 1 ∧ H * L ≤ N ∧
      T * capture = D ∧ N ^ 2 ≤ D ∧
      ¬ ((card - 1) * N * L < capture) := by norm_num

/-- All premises of the uniform cubic ledger hold, but adding a third
period factor while keeping the same `K*N` right side is false. -/
theorem extraPeriodFactor_cubic_counterexample :
    let card := 2
    let H := 3
    let T := 3
    let capture := 6
    let D := 18
    let N := 3
    let K := 6
    let L := 1
    0 < T ∧ 0 < N ∧ 0 < K ∧ 0 < L ∧
      card ≤ H / T + 1 ∧ H * L ≤ N ∧
      T * capture = D ∧ capture ≤ K * L ^ 3 ∧ N ^ 2 < D ∧
      (card - 1) ^ 3 * T ^ 2 < K * N ∧
      ¬ ((card - 1) ^ 3 * T ^ 3 < K * N) := by norm_num

/-- The same ledger also shows that the normalized square cap retains only
one period factor. -/
theorem extraPeriodFactor_square_counterexample :
    let card := 2
    let H := 3
    let T := 3
    let capture := 6
    let D := 18
    let N := 3
    let K := 6
    let L := 1
    0 < T ∧ card ≤ H / T + 1 ∧ H * L ≤ N ∧
      T * capture = D ∧ capture ≤ K * L ^ 2 ∧ N ^ 2 < D ∧
      (card - 1) ^ 2 * T < K ∧
      ¬ ((card - 1) ^ 2 * T ^ 2 < K) := by norm_num

/-- Primitive capture can fail on every arm if its relevant coefficient
coprimality premise is deleted. -/
theorem missingCoefficientCoprimality_breaks_all_armCaptures :
    (⟨1, 3, 1⟩ : ArmDivisorLabel).PairwiseCoprime ∧
      Nat.Coprime 1 2 ∧ ¬ Nat.Coprime 3 3 ∧
      directionCapture (⟨1, 3, 1⟩ : ArmDivisorLabel) 0 3 2 = 3 ∧
      3 ≠ (⟨1, 3, 1⟩ : ArmDivisorLabel).u ∧
    (⟨1, 1, 2⟩ : ArmDivisorLabel).PairwiseCoprime ∧
      Nat.Coprime 1 3 ∧ ¬ Nat.Coprime 2 2 ∧
      directionCapture (⟨1, 1, 2⟩ : ArmDivisorLabel) 0 3 2 = 2 ∧
      2 ≠ (⟨1, 1, 2⟩ : ArmDivisorLabel).u ∧
    (⟨3, 1, 1⟩ : ArmDivisorLabel).PairwiseCoprime ∧
      ¬ Nat.Coprime 3 3 ∧ Nat.Coprime 1 1 ∧
      directionCapture (⟨3, 1, 1⟩ : ArmDivisorLabel) 3 0 1 = 3 ∧
      3 ≠ (⟨3, 1, 1⟩ : ArmDivisorLabel).v ∧
    (⟨2, 1, 1⟩ : ArmDivisorLabel).PairwiseCoprime ∧
      ¬ Nat.Coprime 2 2 ∧ Nat.Coprime 1 1 ∧
      directionCapture (⟨2, 1, 1⟩ : ArmDivisorLabel) 2 1 0 = 2 ∧
      2 ≠ (⟨2, 1, 1⟩ : ArmDivisorLabel).w := by
  norm_num [ArmDivisorLabel.PairwiseCoprime, directionCapture]

/-- Even with coefficient coprimality, a scaled nonprimitive direction can
absorb the scale on every arm. -/
theorem nonprimitiveDirection_breaks_all_exact_armCaptures :
    (⟨1, 5, 1⟩ : ArmDivisorLabel).PairwiseCoprime ∧
      Nat.Coprime 5 3 ∧ Nat.Coprime 1 2 ∧ Nat.gcd 0 5 = 5 ∧
      directionCapture (⟨1, 5, 1⟩ : ArmDivisorLabel) 0 15 10 = 5 ∧
      5 ≠ (⟨1, 5, 1⟩ : ArmDivisorLabel).u ∧
    (⟨5, 1, 1⟩ : ArmDivisorLabel).PairwiseCoprime ∧
      Nat.Coprime 5 3 ∧ Nat.Coprime 1 1 ∧ Nat.gcd 15 5 = 5 ∧
      directionCapture (⟨5, 1, 1⟩ : ArmDivisorLabel) 15 0 5 = 5 ∧
      5 ≠ (⟨5, 1, 1⟩ : ArmDivisorLabel).v ∧
    (⟨5, 1, 1⟩ : ArmDivisorLabel).PairwiseCoprime ∧
      Nat.Coprime 5 2 ∧ Nat.Coprime 1 1 ∧ Nat.gcd 10 5 = 5 ∧
      directionCapture (⟨5, 1, 1⟩ : ArmDivisorLabel) 10 5 0 = 5 ∧
      5 ≠ (⟨5, 1, 1⟩ : ArmDivisorLabel).w := by
  norm_num [ArmDivisorLabel.PairwiseCoprime, directionCapture]

#print axioms shiftedCard_mul_period_le
#print axioms shiftedCard_mul_ambient_mul_scale_lt_capture
#print axioms shiftedCard_square_mul_period_scaleSq_lt_capture
#print axioms shiftedCard_square_mul_period_lt_of_capture_le_quadratic
#print axioms shiftedCard_cube_mul_periodSq_scaleCube_lt_capture_mul_ambient
#print axioms shiftedCard_physicalPeriod_cube_lt_labelProduct_mul_ambient
#print axioms signedDirectionCapture_le_product
#print axioms signedDirectionPeriod_dvd_gap
#print axioms actualSignedLine_directionPeriod_dvd_gap
#print axioms signedDirectionProduct_le_sharp_cubic
#print axioms signedDirectionProduct_one_one_is_sharp
#print axioms signedNonarm_shifted_mul_ambient_scale_lt_product
#print axioms signedNonarm_shiftedCube_mul_periodSq_lt
#print axioms signedNonarm_smallDirection_is_singleton
#print axioms directionCapture_zeroU_eq
#print axioms directionCapture_zeroV_eq
#print axioms directionCapture_zeroW_eq
#print axioms zeroU_shifted_mul_ambient_lt
#print axioms zeroV_shifted_mul_ambient_scale_lt
#print axioms zeroW_shifted_mul_ambient_scale_lt
#print axioms cube_le_one_add_seven_shiftedCube
#print axioms weightedCubicEnergy_le_catalogue_add_sevenShifted
#print axioms weightedShiftedEnergy_mul_scaledAmbientCube_le_armMoment
#print axioms weightedCoordinateMoment_le_ownerCatalogue
#print axioms weightedCoordinateMoment_le_ownerCatalogue_of_dvd
#print axioms weightedCatalogue_le_ownerMass
#print axioms weightedCubicEnergy_le_ownerMass_add_sevenCharges
#print axioms closedLargeThreshold_breaks_captureSqueeze
#print axioms extraPeriodFactor_cubic_counterexample
#print axioms extraPeriodFactor_square_counterexample
#print axioms missingCoefficientCoprimality_breaks_all_armCaptures
#print axioms nonprimitiveDirection_breaks_all_exact_armCaptures

end AffineSignedRayCanonicalCaps20260901
end IUTThreeClosures
