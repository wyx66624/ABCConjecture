/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.AffineCommonKernelTripleSelection20260901

/-!
# Direction periods and collinear cubic energy in the affine route

The mathematical proofs precede this module in
`research/ABC_AFFINE_COLLINEAR_PERIOD_ENERGY_2026_09_01.md`.

This file extracts the exact index period of one actual arm-divisor label on
an affine ray.  It proves a cube-root occupancy bound away from arm-level
directions, a weighted cubic-energy ceiling, and a square-root bound on the
vertical exceptional direction when the constant arm component is capped.
It also checks the precise countermodels recorded in the paper.  It assumes
no density theorem and proves no abc statement.
-/

namespace IUTThreeClosures
namespace AffineCollinearPeriodEnergy20260901

open scoped BigOperators
open AffineTemplateEntropy20260901
open AffineDeterminantLayerEntropy20260901
open AffineAdaptiveCommonKernel20260901
open AffineCommonKernelTripleSelection20260901

/-! ## Direction periods -/

/-- A nonnegative affine ray in the parameter lattice. -/
def affineRayPoint (base : ℕ × ℕ) (s t n : ℕ) : ℕ × ℕ :=
  (base.1 + n * s, base.2 + n * t)

/-- The part of a label component that is not absorbed by one direction
coefficient. -/
def reducedDirectionPeriod (d A : ℕ) : ℕ :=
  d / Nat.gcd d A

/-- Product of the three reduced periods. -/
def directionPeriod (label : ArmDivisorLabel) (AU AV AW : ℕ) : ℕ :=
  reducedDirectionPeriod label.u AU *
    reducedDirectionPeriod label.v AV *
      reducedDirectionPeriod label.w AW

/-- Product of the three pieces absorbed by the direction coefficients. -/
def directionCapture (label : ArmDivisorLabel) (AU AV AW : ℕ) : ℕ :=
  Nat.gcd label.u AU * Nat.gcd label.v AV * Nat.gcd label.w AW

theorem reducedDirectionPeriod_pos {d A : ℕ} (hd : 0 < d) :
    0 < reducedDirectionPeriod d A := by
  unfold reducedDirectionPeriod
  apply Nat.div_pos
  · exact Nat.le_of_dvd hd (Nat.gcd_dvd_left d A)
  · exact Nat.gcd_pos_of_pos_left A hd

theorem reducedDirectionPeriod_dvd_self (d A : ℕ) :
    reducedDirectionPeriod d A ∣ d := by
  exact Nat.div_dvd_of_dvd (Nat.gcd_dvd_left d A)

/-- If `d ∣ gap*A`, cancellation by `gcd d A` leaves the reduced period as
a divisor of `gap`. -/
theorem reducedDirectionPeriod_dvd_of_dvd_mul {d A gap : ℕ}
    (hd : 0 < d) (hdiv : d ∣ gap * A) :
    reducedDirectionPeriod d A ∣ gap := by
  unfold reducedDirectionPeriod
  have hgpos : 0 < Nat.gcd d A := Nat.gcd_pos_of_pos_left A hd
  rw [Nat.div_dvd_iff_dvd_mul (Nat.gcd_dvd_left d A) hgpos]
  rw [mul_comm]
  exact Nat.dvd_mul_gcd_iff_dvd_mul.mpr hdiv

theorem directionPeriod_pos
    {label : ArmDivisorLabel} {AU AV AW : ℕ}
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w) :
    0 < directionPeriod label AU AV AW := by
  unfold directionPeriod
  exact mul_pos (mul_pos (reducedDirectionPeriod_pos hu)
    (reducedDirectionPeriod_pos hv)) (reducedDirectionPeriod_pos hw)

/-- Pairwise coprimality lets the three component periods multiply rather
than merely take an lcm. -/
theorem directionPeriod_dvd_gap
    {label : ArmDivisorLabel} {AU AV AW gap : ℕ}
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (hpair : label.PairwiseCoprime)
    (hU : label.u ∣ gap * AU)
    (hV : label.v ∣ gap * AV)
    (hW : label.w ∣ gap * AW) :
    directionPeriod label AU AV AW ∣ gap := by
  have hrU := reducedDirectionPeriod_dvd_of_dvd_mul hu hU
  have hrV := reducedDirectionPeriod_dvd_of_dvd_mul hv hV
  have hrW := reducedDirectionPeriod_dvd_of_dvd_mul hw hW
  have hUV : Nat.Coprime (reducedDirectionPeriod label.u AU)
      (reducedDirectionPeriod label.v AV) :=
    Nat.Coprime.of_dvd (reducedDirectionPeriod_dvd_self _ _)
      (reducedDirectionPeriod_dvd_self _ _) hpair.1
  have hUW : Nat.Coprime (reducedDirectionPeriod label.u AU)
      (reducedDirectionPeriod label.w AW) :=
    Nat.Coprime.of_dvd (reducedDirectionPeriod_dvd_self _ _)
      (reducedDirectionPeriod_dvd_self _ _) hpair.2.1
  have hVW : Nat.Coprime (reducedDirectionPeriod label.v AV)
      (reducedDirectionPeriod label.w AW) :=
    Nat.Coprime.of_dvd (reducedDirectionPeriod_dvd_self _ _)
      (reducedDirectionPeriod_dvd_self _ _) hpair.2.2
  have hUVdvd : reducedDirectionPeriod label.u AU *
      reducedDirectionPeriod label.v AV ∣ gap :=
    hUV.mul_dvd_of_dvd_of_dvd hrU hrV
  exact (hUW.mul_left hVW).mul_dvd_of_dvd_of_dvd hUVdvd hrW

/-- Exact factorization of the label product into period and direction
capture. -/
theorem directionPeriod_mul_capture
    (label : ArmDivisorLabel) (AU AV AW : ℕ) :
    directionPeriod label AU AV AW *
      directionCapture label AU AV AW = label.product := by
  unfold directionPeriod directionCapture reducedDirectionPeriod
    ArmDivisorLabel.product
  calc
    label.u / Nat.gcd label.u AU * (label.v / Nat.gcd label.v AV) *
          (label.w / Nat.gcd label.w AW) *
          (Nat.gcd label.u AU * Nat.gcd label.v AV * Nat.gcd label.w AW) =
        (label.u / Nat.gcd label.u AU * Nat.gcd label.u AU) *
          (label.v / Nat.gcd label.v AV * Nat.gcd label.v AV) *
          (label.w / Nat.gcd label.w AW * Nat.gcd label.w AW) := by ring
    _ = label.u * label.v * label.w := by
      rw [Nat.div_mul_cancel (Nat.gcd_dvd_left label.u AU),
        Nat.div_mul_cancel (Nat.gcd_dvd_left label.v AV),
        Nat.div_mul_cancel (Nat.gcd_dvd_left label.w AW)]

#print axioms reducedDirectionPeriod_pos
#print axioms reducedDirectionPeriod_dvd_self
#print axioms reducedDirectionPeriod_dvd_of_dvd_mul
#print axioms directionPeriod_pos
#print axioms directionPeriod_dvd_gap
#print axioms directionPeriod_mul_capture

/-! ## Actual affine cancellation on a ray -/

private theorem natAbs_natCast_sub_eq_dist (n m : ℕ) :
    Int.natAbs ((n : ℤ) - m) = Nat.dist n m := by
  by_cases h : m ≤ n
  · rw [Int.natAbs_natCast_sub_natCast_of_ge h, Nat.dist_comm,
      Nat.dist_eq_sub_of_le h]
  · have hnm : n ≤ m := Nat.le_of_not_ge h
    rw [Int.natAbs_natCast_sub_natCast_of_le hnm,
      Nat.dist_eq_sub_of_le hnm]

private theorem nat_dvd_dist_mul_of_intCast_dvd_sub_mul
    {d n m A : ℕ}
    (hdiv : (d : ℤ) ∣ ((n : ℤ) - m) * (A : ℤ)) :
    d ∣ Nat.dist n m * A := by
  have habs : Int.natAbs (d : ℤ) ∣
      Int.natAbs (((n : ℤ) - m) * (A : ℤ)) :=
    Int.natAbs_dvd_natAbs.mpr hdiv
  simpa [natAbs_natCast_sub_eq_dist, Int.natAbs_mul] using habs

/-- Two actual occurrences of one label on a ray give the three direction
divisibilities after cancellation of the affine step `R`. -/
theorem sharedLabel_ray_directionDivisibilities
    {R B C : ℕ} {base : ℕ × ℕ} {s t n m : ℕ}
    {label : ArmDivisorLabel}
    (hn : armDivisorsAt R B C (affineRayPoint base s t n)
      label.u label.v label.w)
    (hm : armDivisorsAt R B C (affineRayPoint base s t m)
      label.u label.v label.w) :
    label.u ∣ Nat.dist n m * s ∧
      label.v ∣ Nat.dist n m * (s + C * t) ∧
      label.w ∣ Nat.dist n m * (s + B * t) := by
  have hUR : Nat.Coprime label.u R :=
    Nat.Coprime.of_dvd hn.1 (dvd_refl R) (by simp [affineU])
  have hVR : Nat.Coprime label.v R :=
    Nat.Coprime.of_dvd hn.2.1 (dvd_refl R) (by simp [affineV])
  have hWR : Nat.Coprime label.w R :=
    Nat.Coprime.of_dvd hn.2.2 (dvd_refl R) (by simp [affineW])
  have hdiff := affineTemplate_membership_gives_differenceDivisibilities
    hUR hVR hWR hn.1 hm.1 hn.2.1 hm.2.1 hn.2.2 hm.2.2
  have hUeq :
      (((affineRayPoint base s t n).1 : ℤ) -
        (affineRayPoint base s t m).1) =
      ((n : ℤ) - m) * (s : ℤ) := by
    simp only [affineRayPoint, Nat.cast_add, Nat.cast_mul]
    ring
  have hVeq :
      (((affineRayPoint base s t n).1 : ℤ) -
          (affineRayPoint base s t m).1) +
          (C : ℤ) * (((affineRayPoint base s t n).2 : ℤ) -
            (affineRayPoint base s t m).2) =
      ((n : ℤ) - m) * ((s : ℤ) + (C : ℤ) * (t : ℤ)) := by
    simp only [affineRayPoint, Nat.cast_add, Nat.cast_mul]
    ring
  have hWeq :
      (((affineRayPoint base s t n).1 : ℤ) -
          (affineRayPoint base s t m).1) +
          (B : ℤ) * (((affineRayPoint base s t n).2 : ℤ) -
            (affineRayPoint base s t m).2) =
      ((n : ℤ) - m) * ((s : ℤ) + (B : ℤ) * (t : ℤ)) := by
    simp only [affineRayPoint, Nat.cast_add, Nat.cast_mul]
    ring
  rcases hdiff with ⟨hU, hV, hW⟩
  rw [hUeq] at hU
  rw [hVeq] at hV
  rw [hWeq] at hW
  exact ⟨nat_dvd_dist_mul_of_intCast_dvd_sub_mul hU,
    nat_dvd_dist_mul_of_intCast_dvd_sub_mul hV,
    nat_dvd_dist_mul_of_intCast_dvd_sub_mul hW⟩

/-- The actual affine version of the direction-period divisibility. -/
theorem sharedLabel_ray_directionPeriod_dvd_dist
    {R B C : ℕ} {base : ℕ × ℕ} {s t n m : ℕ}
    {label : ArmDivisorLabel}
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (hpair : label.PairwiseCoprime)
    (hn : armDivisorsAt R B C (affineRayPoint base s t n)
      label.u label.v label.w)
    (hm : armDivisorsAt R B C (affineRayPoint base s t m)
      label.u label.v label.w) :
    directionPeriod label s (s + C * t) (s + B * t) ∣
      Nat.dist n m := by
  rcases sharedLabel_ray_directionDivisibilities hn hm with ⟨hU, hV, hW⟩
  exact directionPeriod_dvd_gap hu hv hw hpair hU hV hW

#print axioms natAbs_natCast_sub_eq_dist
#print axioms nat_dvd_dist_mul_of_intCast_dvd_sub_mul
#print axioms sharedLabel_ray_directionDivisibilities
#print axioms sharedLabel_ray_directionPeriod_dvd_dist

/-! ## Exact period capacity -/

/-- A finite set in `[0,H]` whose pairwise differences are divisible by a
positive period has the exact residue-class capacity. -/
theorem periodicIndexSet_card_le
    (S : Finset ℕ) (H T : ℕ)
    (hT : 0 < T)
    (hbox : ∀ n ∈ S, n ≤ H)
    (hperiod : ∀ n ∈ S, ∀ m ∈ S, n ≠ m → T ∣ Nat.dist n m) :
    S.card ≤ H / T + 1 := by
  have hsep : ∀ n ∈ S, ∀ m ∈ S, n ≠ m →
      T - 1 < Nat.dist n m := by
    intro n hn m hm hnm
    have hdist : 0 < Nat.dist n m := by
      rcases le_total n m with hle | hle
      · rw [Nat.dist_eq_sub_of_le hle]
        omega
      · rw [Nat.dist_comm, Nat.dist_eq_sub_of_le hle]
        omega
    have hle : T ≤ Nat.dist n m :=
      Nat.le_of_dvd hdist (hperiod n hn m hm hnm)
    omega
  have hcard := oneDimSeparated_card_le S H (T - 1) hbox hsep
  have hsucc : T - 1 + 1 = T := by omega
  simpa [hsucc] using hcard

/-- Actual ray indices carrying one label. -/
noncomputable def rayLabelFiber (S : Finset ℕ) (R B C : ℕ)
    (base : ℕ × ℕ) (s t : ℕ) (label : ArmDivisorLabel) : Finset ℕ := by
  classical
  exact S.filter fun n ↦ armDivisorsAt R B C
    (affineRayPoint base s t n) label.u label.v label.w

@[simp] theorem mem_rayLabelFiber_iff
    {S : Finset ℕ} {R B C : ℕ} {base : ℕ × ℕ}
    {s t n : ℕ} {label : ArmDivisorLabel} :
    n ∈ rayLabelFiber S R B C base s t label ↔
      n ∈ S ∧ armDivisorsAt R B C
        (affineRayPoint base s t n) label.u label.v label.w := by
  classical
  simp [rayLabelFiber]

/-- Exact period capacity for one actual label fibre on a ray. -/
theorem rayLabelFiber_card_le_directionPeriod
    (S : Finset ℕ) {H R B C : ℕ} {base : ℕ × ℕ}
    {s t : ℕ} (label : ArmDivisorLabel)
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (hpair : label.PairwiseCoprime)
    (hbox : ∀ n ∈ S, n ≤ H) :
    (rayLabelFiber S R B C base s t label).card ≤
      H / directionPeriod label s (s + C * t) (s + B * t) + 1 := by
  apply periodicIndexSet_card_le
    (rayLabelFiber S R B C base s t label) H
    (directionPeriod label s (s + C * t) (s + B * t))
    (directionPeriod_pos hu hv hw)
  · intro n hn
    exact hbox n (mem_rayLabelFiber_iff.mp hn).1
  · intro n hn m hm _hnm
    exact sharedLabel_ray_directionPeriod_dvd_dist hu hv hw hpair
      (mem_rayLabelFiber_iff.mp hn).2 (mem_rayLabelFiber_iff.mp hm).2

#print axioms periodicIndexSet_card_le
#print axioms mem_rayLabelFiber_iff
#print axioms rayLabelFiber_card_le_directionPeriod

/-! ## Nonconstant-ray cube-root capacity -/

/-- The direction capture is cubic in the sup scale when the first direction
coordinate is nonzero. -/
theorem directionCapture_nonconstant_le_cubic
    (label : ArmDivisorLabel) {B C s t : ℕ} (hs : 0 < s) :
    directionCapture label s (s + C * t) (s + B * t) ≤
      (B + 1) * (C + 1) * (max s t) ^ 3 := by
  let L := max s t
  have hsL : s ≤ L := Nat.le_max_left s t
  have htL : t ≤ L := Nat.le_max_right s t
  have hVpos : 0 < s + C * t := by omega
  have hWpos : 0 < s + B * t := by omega
  have hV : s + C * t ≤ (C + 1) * L := by
    calc
      s + C * t ≤ L + C * L :=
        Nat.add_le_add hsL (Nat.mul_le_mul_left C htL)
      _ = (C + 1) * L := by ring
  have hW : s + B * t ≤ (B + 1) * L := by
    calc
      s + B * t ≤ L + B * L :=
        Nat.add_le_add hsL (Nat.mul_le_mul_left B htL)
      _ = (B + 1) * L := by ring
  have hgU : Nat.gcd label.u s ≤ s := Nat.gcd_le_right label.u hs
  have hgV : Nat.gcd label.v (s + C * t) ≤ s + C * t :=
    Nat.gcd_le_right label.v hVpos
  have hgW : Nat.gcd label.w (s + B * t) ≤ s + B * t :=
    Nat.gcd_le_right label.w hWpos
  calc
    directionCapture label s (s + C * t) (s + B * t) ≤
        s * (s + C * t) * (s + B * t) := by
      exact Nat.mul_le_mul (Nat.mul_le_mul hgU hgV) hgW
    _ ≤ L * ((C + 1) * L) * ((B + 1) * L) := by
      exact Nat.mul_le_mul (Nat.mul_le_mul hsL hV) hW
    _ = (B + 1) * (C + 1) * L ^ 3 := by ring

/-- Pure arithmetic form of the cube-root capacity argument. -/
theorem cubic_card_bound_of_period
    {card H T capture D N K L : ℕ}
    (hT : 0 < T) (hN : 0 < N) (hK : 0 < K) (hL : 0 < L)
    (hcard : card ≤ H / T + 1)
    (hHL : H * L ≤ N)
    (hfactor : T * capture = D)
    (hcapture : capture ≤ K * L ^ 3)
    (hlarge : N ^ 2 < D) :
    (card - 1) ^ 3 < K * N := by
  let a := card - 1
  have haDiv : a ≤ H / T := by
    dsimp [a]
    apply Nat.sub_le_iff_le_add.mpr
    simpa [add_comm] using hcard
  have haT : a * T ≤ H := by
    calc
      a * T ≤ (H / T) * T := Nat.mul_le_mul_right T haDiv
      _ ≤ H := Nat.div_mul_le_self H T
  have haTL : a * T * L ≤ N :=
    (Nat.mul_le_mul_right L haT).trans hHL
  have hcoeff : D ≤ T * (K * L ^ 3) := by
    rw [← hfactor]
    exact Nat.mul_le_mul_left T hcapture
  have hsquare : (a * T * L) ^ 2 ≤ N ^ 2 :=
    Nat.pow_le_pow_left haTL 2
  have hraw : (T * L ^ 2) * (a ^ 2 * T) <
      (T * L ^ 2) * (K * L) := by
    calc
      (T * L ^ 2) * (a ^ 2 * T) = (a * T * L) ^ 2 := by ring
      _ ≤ N ^ 2 := hsquare
      _ < D := hlarge
      _ ≤ T * (K * L ^ 3) := hcoeff
      _ = (T * L ^ 2) * (K * L) := by ring
  have hfactorPos : 0 < T * L ^ 2 := mul_pos hT (pow_pos hL 2)
  have ha2T : a ^ 2 * T < K * L :=
    (Nat.mul_lt_mul_left hfactorPos).mp hraw
  have hTone : 1 ≤ T := hT
  have ha2le : a ^ 2 ≤ a ^ 2 * T := by
    simpa using Nat.mul_le_mul_left (a ^ 2) hTone
  have ha2 : a ^ 2 < K * L := ha2le.trans_lt ha2T
  have haL : a * L ≤ N := by
    calc
      a * L ≤ a * T * L := by
        apply Nat.mul_le_mul_right L
        calc
          a = a * 1 := by simp
          _ ≤ a * T := Nat.mul_le_mul_left a hTone
      _ ≤ N := haTL
  change a ^ 3 < K * N
  by_cases ha : a = 0
  · rw [ha]
    simpa using Nat.mul_pos hK hN
  · have hapos : 0 < a := Nat.pos_of_ne_zero ha
    calc
      a ^ 3 = a * a ^ 2 := by ring
      _ < a * (K * L) := (Nat.mul_lt_mul_left hapos).2 ha2
      _ = K * (a * L) := by ring
      _ ≤ K * N := Nat.mul_le_mul_left K haL

/-- Actual nonconstant-ray cube-root occupancy bound. -/
theorem rayLabelFiber_nonconstant_shiftedCube_lt
    (S : Finset ℕ) {H R B C N : ℕ} {base : ℕ × ℕ}
    {s t : ℕ} (label : ArmDivisorLabel)
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (hpair : label.PairwiseCoprime)
    (hs : 0 < s) (hN : 0 < N)
    (hbox : ∀ n ∈ S, n ≤ H)
    (hspan : H * max s t ≤ N)
    (hlarge : N ^ 2 < label.product) :
    ((rayLabelFiber S R B C base s t label).card - 1) ^ 3 <
      (B + 1) * (C + 1) * N := by
  let T := directionPeriod label s (s + C * t) (s + B * t)
  let capture := directionCapture label s (s + C * t) (s + B * t)
  let K := (B + 1) * (C + 1)
  let L := max s t
  apply cubic_card_bound_of_period
    (T := T) (capture := capture) (D := label.product)
    (K := K) (L := L)
  · exact directionPeriod_pos hu hv hw
  · exact hN
  · dsimp [K]
    positivity
  · dsimp [L]
    exact lt_of_lt_of_le hs (Nat.le_max_left s t)
  · exact rayLabelFiber_card_le_directionPeriod S label hu hv hw hpair hbox
  · exact hspan
  · exact directionPeriod_mul_capture label s (s + C * t) (s + B * t)
  · exact directionCapture_nonconstant_le_cubic label hs
  · exact hlarge

/-- Every other displayed premise of the pure cubic ledger can hold at
`N = 0`, while its strict conclusion fails.  Thus ambient positivity is a
necessary premise rather than a proof artefact. -/
theorem omitting_positive_ambient_breaks_cubic_card_bound :
    let card : ℕ := 1
    let H : ℕ := 0
    let T : ℕ := 1
    let capture : ℕ := 1
    let D : ℕ := 1
    let N : ℕ := 0
    let K : ℕ := 1
    let L : ℕ := 1
    0 < T ∧ 0 < K ∧ 0 < L ∧
      card ≤ H / T + 1 ∧ H * L ≤ N ∧
      T * capture = D ∧ capture ≤ K * L ^ 3 ∧ N ^ 2 < D ∧
      ¬ ((card - 1) ^ 3 < K * N) := by
  norm_num

#print axioms directionCapture_nonconstant_le_cubic
#print axioms cubic_card_bound_of_period
#print axioms rayLabelFiber_nonconstant_shiftedCube_lt
#print axioms omitting_positive_ambient_breaks_cubic_card_bound

/-! ## Optimal weighted cubic conversion -/

/-- The optimal integer conversion from a shifted cube bound to an
unshifted cube bound. -/
theorem cube_le_four_mul_of_shiftedCube_lt
    {n X : ℕ} (hX : 0 < X) (hshift : (n - 1) ^ 3 < X) :
    n ^ 3 ≤ 4 * X := by
  by_cases hn : n = 0
  · subst n
    simp
  have hnpos : 0 < n := Nat.pos_of_ne_zero hn
  let a := n - 1
  have hna : n = a + 1 := by
    dsimp [a]
    omega
  have haCube : a ^ 3 + 1 ≤ X := by
    rw [show a = n - 1 by rfl]
    omega
  by_cases ha : a = 0
  · rw [hna, ha]
    simp
    omega
  · obtain ⟨b, hb⟩ : ∃ b, a = b + 1 := by
      exact Nat.exists_eq_succ_of_ne_zero ha
    have hpoly : (a + 1) ^ 3 ≤ 4 * (a ^ 3 + 1) := by
      rw [hb]
      have hid : 4 * ((b + 1) ^ 3 + 1) =
          (b + 1 + 1) ^ 3 + 3 * b ^ 2 * (b + 2) := by ring
      rw [hid]
      omega
    calc
      n ^ 3 = (a + 1) ^ 3 := by rw [hna]
      _ ≤ 4 * (a ^ 3 + 1) := hpoly
      _ ≤ 4 * X := Nat.mul_le_mul_left 4 haCube

/-- Factor three already fails at `n=X=2`, so factor four is the optimal
integer constant in the preceding conversion. -/
theorem factorThree_shiftedCube_counterexample :
    ((2 - 1) ^ 3 < 2) ∧ ¬ (2 ^ 3 ≤ 3 * 2) := by
  norm_num

/-- Weighted cubic-moment consequence of uniform shifted-cube bounds. -/
theorem weightedCubicMoment_le_four
    {α : Type*} (I : Finset α) (weight count : α → ℕ) (X : ℕ)
    (hX : 0 < X)
    (hshift : ∀ i ∈ I, (count i - 1) ^ 3 < X) :
    ∑ i ∈ I, weight i * count i ^ 3 ≤
      4 * X * ∑ i ∈ I, weight i := by
  calc
    ∑ i ∈ I, weight i * count i ^ 3 ≤
        ∑ i ∈ I, weight i * (4 * X) := by
      exact Finset.sum_le_sum fun i hi ↦
        Nat.mul_le_mul_left (weight i)
          (cube_le_four_mul_of_shiftedCube_lt hX (hshift i hi))
    _ = 4 * X * ∑ i ∈ I, weight i := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro i _hi
      ring

/-- The weighted cubic-energy ceiling for any finite catalogue of actual
large labels on one nonconstant ray. -/
theorem rayCatalogue_weightedCubicEnergy_le
    (S : Finset ℕ) (labels : Finset ArmDivisorLabel)
    (weight : ArmDivisorLabel → ℕ)
    {H R B C N : ℕ} {base : ℕ × ℕ} {s t : ℕ}
    (hs : 0 < s) (hN : 0 < N)
    (hbox : ∀ n ∈ S, n ≤ H)
    (hspan : H * max s t ≤ N)
    (hpositive : ∀ label ∈ labels,
      0 < label.u ∧ 0 < label.v ∧ 0 < label.w)
    (hpair : ∀ label ∈ labels, label.PairwiseCoprime)
    (hlarge : ∀ label ∈ labels, N ^ 2 < label.product) :
    ∑ label ∈ labels, weight label *
        (rayLabelFiber S R B C base s t label).card ^ 3 ≤
      4 * ((B + 1) * (C + 1) * N) *
        ∑ label ∈ labels, weight label := by
  apply weightedCubicMoment_le_four labels weight
    (fun label ↦ (rayLabelFiber S R B C base s t label).card)
    ((B + 1) * (C + 1) * N)
  · positivity
  · intro label hlabel
    exact rayLabelFiber_nonconstant_shiftedCube_lt S label
      (hpositive label hlabel).1 (hpositive label hlabel).2.1
      (hpositive label hlabel).2.2 (hpair label hlabel)
      hs hN hbox hspan (hlarge label hlabel)

#print axioms cube_le_four_mul_of_shiftedCube_lt
#print axioms factorThree_shiftedCube_counterexample
#print axioms weightedCubicMoment_le_four
#print axioms rayCatalogue_weightedCubicEnergy_le

/-! ## The vertical exceptional direction -/

/-- On a vertical ray, the entire `U` component is absorbed by the direction;
an individual cap on it leaves a quadratic direction capture. -/
theorem directionCapture_vertical_le_quadratic
    (label : ArmDivisorLabel) {B C t XU : ℕ}
    (hB : 0 < B) (hC : 0 < C) (ht : 0 < t)
    (hUcap : label.u ≤ XU) :
    directionCapture label 0 (C * t) (B * t) ≤
      (XU * B * C) * t ^ 2 := by
  have hCt : 0 < C * t := mul_pos hC ht
  have hBt : 0 < B * t := mul_pos hB ht
  have hgV : Nat.gcd label.v (C * t) ≤ C * t :=
    Nat.gcd_le_right label.v hCt
  have hgW : Nat.gcd label.w (B * t) ≤ B * t :=
    Nat.gcd_le_right label.w hBt
  simp only [directionCapture, Nat.gcd_zero_right]
  calc
    label.u * Nat.gcd label.v (C * t) * Nat.gcd label.w (B * t) ≤
        XU * (C * t) * (B * t) := by
      exact Nat.mul_le_mul (Nat.mul_le_mul hUcap hgV) hgW
    _ = (XU * B * C) * t ^ 2 := by ring

/-- Pure arithmetic form of the square-root vertical capacity argument. -/
theorem quadratic_card_bound_of_period
    {card H T capture D N K L : ℕ}
    (hT : 0 < T) (hL : 0 < L)
    (hcard : card ≤ H / T + 1)
    (hHL : H * L ≤ N)
    (hfactor : T * capture = D)
    (hcapture : capture ≤ K * L ^ 2)
    (hlarge : N ^ 2 < D) :
    (card - 1) ^ 2 < K := by
  let a := card - 1
  have haDiv : a ≤ H / T := by
    dsimp [a]
    apply Nat.sub_le_iff_le_add.mpr
    simpa [add_comm] using hcard
  have haT : a * T ≤ H := by
    calc
      a * T ≤ (H / T) * T := Nat.mul_le_mul_right T haDiv
      _ ≤ H := Nat.div_mul_le_self H T
  have haTL : a * T * L ≤ N :=
    (Nat.mul_le_mul_right L haT).trans hHL
  have hcoeff : D ≤ T * (K * L ^ 2) := by
    rw [← hfactor]
    exact Nat.mul_le_mul_left T hcapture
  have hsquare : (a * T * L) ^ 2 ≤ N ^ 2 :=
    Nat.pow_le_pow_left haTL 2
  have hraw : (T * L ^ 2) * (a ^ 2 * T) <
      (T * L ^ 2) * K := by
    calc
      (T * L ^ 2) * (a ^ 2 * T) = (a * T * L) ^ 2 := by ring
      _ ≤ N ^ 2 := hsquare
      _ < D := hlarge
      _ ≤ T * (K * L ^ 2) := hcoeff
      _ = (T * L ^ 2) * K := by ring
  have hfactorPos : 0 < T * L ^ 2 := mul_pos hT (pow_pos hL 2)
  have ha2T : a ^ 2 * T < K :=
    (Nat.mul_lt_mul_left hfactorPos).mp hraw
  have hTone : 1 ≤ T := hT
  have ha2le : a ^ 2 ≤ a ^ 2 * T := by
    simpa using Nat.mul_le_mul_left (a ^ 2) hTone
  exact ha2le.trans_lt ha2T

/-- Actual square-root cap for a large label on a vertical ray. -/
theorem rayLabelFiber_vertical_shiftedSquare_lt
    (S : Finset ℕ) {H R B C N XU : ℕ} {base : ℕ × ℕ}
    {t : ℕ} (label : ArmDivisorLabel)
    (hu : 0 < label.u) (hv : 0 < label.v) (hw : 0 < label.w)
    (hpair : label.PairwiseCoprime)
    (hB : 0 < B) (hC : 0 < C) (ht : 0 < t)
    (hUcap : label.u ≤ XU)
    (hbox : ∀ n ∈ S, n ≤ H)
    (hspan : H * t ≤ N)
    (hlarge : N ^ 2 < label.product) :
    ((rayLabelFiber S R B C base 0 t label).card - 1) ^ 2 <
      XU * B * C := by
  let T := directionPeriod label 0 (C * t) (B * t)
  let capture := directionCapture label 0 (C * t) (B * t)
  let K := XU * B * C
  apply quadratic_card_bound_of_period
    (T := T) (capture := capture) (D := label.product)
    (K := K) (L := t)
  · exact directionPeriod_pos hu hv hw
  · exact ht
  · simpa [T] using
      (rayLabelFiber_card_le_directionPeriod
        (R := R) (B := B) (C := C) (base := base) (s := 0) (t := t)
        S label hu hv hw hpair hbox)
  · exact hspan
  · simpa [T, capture] using
      directionPeriod_mul_capture label 0 (C * t) (B * t)
  · exact directionCapture_vertical_le_quadratic label hB hC ht hUcap
  · exact hlarge

#print axioms directionCapture_vertical_le_quadratic
#print axioms quadratic_card_bound_of_period
#print axioms rayLabelFiber_vertical_shiftedSquare_lt

/-! ## Exact pressure tests -/

/-- Without pairwise coprimality, component periods need not multiply. -/
theorem omitting_pairwise_breaks_directionPeriod_product :
    let label : ArmDivisorLabel := ⟨2, 2, 1⟩
    label.u ∣ 2 * 1 ∧ label.v ∣ 2 * 1 ∧ label.w ∣ 2 * 1 ∧
      ¬ label.PairwiseCoprime ∧
      reducedDirectionPeriod label.u 1 = 2 ∧
      reducedDirectionPeriod label.v 1 = 2 ∧
      reducedDirectionPeriod label.w 1 = 1 ∧
      directionPeriod label 1 1 1 = 4 ∧
      ¬ directionPeriod label 1 1 1 ∣ 2 := by
  norm_num [ArmDivisorLabel.PairwiseCoprime, reducedDirectionPeriod,
    directionPeriod]

/-- The deliberately overstrong assertion that uses the whole label product
as a ray period while retaining the actual seed, box, admissibility, and
arm-divisibility premises. -/
def productAsPeriodRayCapacityImplication
    (S : Finset ℕ) (H R B C M N : ℕ) (base : ℕ × ℕ)
    (s t : ℕ) (label : ArmDivisorLabel) : Prop :=
  (seedOneCanonicalPremises R B C M ∧
      (∀ n ∈ S, n ≤ H) ∧
      (∀ n ∈ S, certifiedAffinePointInBox R B C M
        (affineRayPoint base s t n)) ∧
      (∀ n ∈ S, armDivisorsAt R B C
        (affineRayPoint base s t n) label.u label.v label.w) ∧
      0 < label.u ∧ 0 < label.v ∧ 0 < label.w ∧
      label.PairwiseCoprime ∧ N ^ 2 < label.product) →
    S.card ≤ H / label.product + 1

private theorem radical_72 : abcRadical 72 = 6 := by
  rw [show 72 = 2 ^ 3 * 3 ^ 2 by norm_num, abcRadical_eq_natRadical,
    UniqueFactorizationMonoid.radical_mul
      (Nat.coprime_iff_isRelPrime.mp (by norm_num)),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 2).prime) (by norm_num),
    UniqueFactorizationMonoid.radical_pow_of_prime
      (by exact (by norm_num : Nat.Prime 3).prime) (by norm_num)]
  norm_num

#print axioms radical_72

/-- The canonical `(1,8,9)` four-point fibre attains the correct period cap
but refutes the whole-product-as-period assertion with every actual premise
retained. -/
theorem seed189_productAsPeriod_fullPremise_counterexample :
    let B : ℕ := 8
    let C : ℕ := 9
    let R : ℕ := 6
    let M : ℕ := canonicalBoxM C R
    let N : ℕ := M - 1
    let base : ℕ × ℕ := (21480, 282)
    let s : ℕ := 0
    let t : ℕ := 1
    let H : ℕ := 17787
    let S : Finset ℕ := {0, 5929, 11858, 17787}
    let label : ArmDivisorLabel := ⟨128881, 49, 121⟩
    seedOneCanonicalPremises R B C M ∧
      (∀ n ∈ S, n ≤ H) ∧
      (∀ n ∈ S, certifiedAffinePointInBox R B C M
        (affineRayPoint base s t n)) ∧
      (∀ n ∈ S, armDivisorsAt R B C
        (affineRayPoint base s t n) label.u label.v label.w) ∧
      label.PairwiseCoprime ∧
      N ^ 2 < label.product ∧ S.card = 4 ∧
      directionPeriod label s (s + C * t) (s + B * t) = 5929 ∧
      directionCapture label s (s + C * t) (s + B * t) = 128881 ∧
      ¬ directionCapture label s (s + C * t) (s + B * t) ≤
        (B + 1) * (C + 1) * (max s t) ^ 3 ∧
      directionPeriod label s (s + C * t) (s + B * t) *
        directionCapture label s (s + C * t) (s + B * t) =
          label.product ∧
      S.card = H /
        directionPeriod label s (s + C * t) (s + B * t) + 1 ∧
      H / label.product + 1 = 1 ∧
      ¬ productAsPeriodRayCapacityImplication
        S H R B C M N base s t label := by
  norm_num [seedOneCanonicalPremises, certifiedAffinePointInBox,
    armDivisorsAt, productAsPeriodRayCapacityImplication,
    ArmDivisorLabel.PairwiseCoprime, ArmDivisorLabel.product,
    canonicalBoxM, affineRayPoint, affineU, affineV, affineW,
    reducedDirectionPeriod, directionPeriod, directionCapture, radical_72]

#print axioms omitting_pairwise_breaks_directionPeriod_product
#print axioms seed189_productAsPeriod_fullPremise_counterexample

end AffineCollinearPeriodEnergy20260901
end IUTThreeClosures
