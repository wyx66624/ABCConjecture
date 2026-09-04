/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Algebra.Prime.Lemmas
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Data.Nat.GCD.Basic
import Mathlib.Data.Nat.ModEq
import Mathlib.RingTheory.Radical.NatInt
import Mathlib.Tactic.NormNum
import Mathlib.Tactic.NormNum.GCD
import Mathlib.Tactic.NormNum.ModEq
import Mathlib.Tactic.Ring

/-!
# Synchronized divisor packets for primitive abc triples

This module formalizes the finite algebraic core of the synchronized-divisor-
packet route and its exact real-log packet-energy majorant.  It contains no
asymptotic, uniform radical-compression, or `abc` assumption.  In particular,
it does not assert that short proper packets exist or that minimum packet
energy has a uniform upper bound.
-/

namespace IUTThreeClosures
namespace ABCSynchronizedDivisorPackets20260903

/-- A positive primitive `abc` datum with both summands larger than one. -/
structure PrimitiveABC where
  a : ℕ
  b : ℕ
  c : ℕ
  a_gt_one : 1 < a
  b_gt_one : 1 < b
  sum_eq : a + b = c
  coprime_ab : a.Coprime b

namespace PrimitiveABC

/-- The first and third arms of a primitive datum are coprime. -/
theorem coprime_ac (P : PrimitiveABC) : P.a.Coprime P.c := by
  rw [← P.sum_eq, add_comm]
  simpa only [one_mul] using
    (Nat.coprime_add_mul_right_right P.a P.b 1).2 P.coprime_ab

/-- The second and third arms of a primitive datum are coprime. -/
theorem coprime_bc (P : PrimitiveABC) : P.b.Coprime P.c := by
  rw [← P.sum_eq]
  simpa only [one_mul] using
    (Nat.coprime_add_mul_right_right P.b P.a 1).2 P.coprime_ab.symm

/-- The third arm of a primitive datum is positive. -/
theorem c_pos (P : PrimitiveABC) : 0 < P.c := by
  have ha := P.a_gt_one
  have hsum := P.sum_eq
  omega

/-- The first summand is strictly below the third arm. -/
theorem a_lt_c (P : PrimitiveABC) : P.a < P.c := by
  have hb := P.b_gt_one
  have hsum := P.sum_eq
  omega

/-- The second summand is strictly below the third arm. -/
theorem b_lt_c (P : PrimitiveABC) : P.b < P.c := by
  have ha := P.a_gt_one
  have hsum := P.sum_eq
  omega

/-- For a nonunit primitive datum, the sum is strictly smaller than the product. -/
theorem c_lt_mul_ab (P : PrimitiveABC) : P.c < P.a * P.b := by
  rw [← P.sum_eq]
  have ha2 : 2 ≤ P.a := P.a_gt_one
  have hb2 : 2 ≤ P.b := P.b_gt_one
  have hle : P.a + P.b ≤ P.a * P.b :=
    Nat.add_le_mul ha2 hb2
  refine lt_of_le_of_ne hle ?_
  intro heq
  have hadvd_sum : P.a ∣ P.a + P.b := by
    rw [heq]
    exact dvd_mul_right P.a P.b
  have hadvd_b : P.a ∣ P.b :=
    (Nat.dvd_add_iff_right (dvd_refl P.a)).2 hadvd_sum
  have ha_one : P.a = 1 := P.coprime_ab.eq_one_of_dvd hadvd_b
  have ha := P.a_gt_one
  omega

end PrimitiveABC

/-- The nonnegative absolute gap between two natural-number squares. -/
def squareGap (r s : ℕ) : ℕ :=
  max r s ^ 2 - min r s ^ 2

@[simp] theorem squareGap_comm (r s : ℕ) : squareGap r s = squareGap s r := by
  simp [squareGap, max_comm, min_comm]

/-- Distinct natural numbers have a positive square gap. -/
theorem squareGap_pos {r s : ℕ} (h : r ≠ s) : 0 < squareGap r s := by
  rw [squareGap, Nat.sub_pos_iff_lt]
  exact Nat.pow_lt_pow_left (min_lt_max.mpr h) (by decide)

/-- A square gap is at most the square of the larger coordinate. -/
theorem squareGap_le_max_sq (r s : ℕ) : squareGap r s ≤ max r s ^ 2 := by
  exact Nat.sub_le _ _

/-- With ordered inputs, the square gap is the corresponding subtraction. -/
theorem squareGap_of_le {r s : ℕ} (h : r ≤ s) : squareGap r s = s ^ 2 - r ^ 2 := by
  simp [squareGap, h]

/-- A synchronized packet consists of positive nonunit divisors whose opposite
square gaps absorb the three arms. -/
structure SynchronizedPacket (P : PrimitiveABC) where
  x : ℕ
  y : ℕ
  z : ℕ
  x_gt_one : 1 < x
  y_gt_one : 1 < y
  z_gt_one : 1 < z
  x_dvd : x ∣ P.a
  y_dvd : y ∣ P.b
  z_dvd : z ∣ P.c
  sync_a : P.a ∣ squareGap y z
  sync_b : P.b ∣ squareGap x z
  sync_c : P.c ∣ squareGap x y

namespace SynchronizedPacket

variable {P : PrimitiveABC} (Q : SynchronizedPacket P)

/-- Synchronized packets are determined by their three divisor coordinates. -/
@[ext] theorem ext {Q R : SynchronizedPacket P}
    (hx : Q.x = R.x) (hy : Q.y = R.y) (hz : Q.z = R.z) : Q = R := by
  cases Q
  cases R
  simp_all

/-- The first two packet coordinates inherit coprimality from the arms. -/
theorem coprime_xy : Q.x.Coprime Q.y :=
  Nat.Coprime.of_dvd Q.x_dvd Q.y_dvd P.coprime_ab

/-- The first and third packet coordinates inherit coprimality from the arms. -/
theorem coprime_xz : Q.x.Coprime Q.z :=
  Nat.Coprime.of_dvd Q.x_dvd Q.z_dvd P.coprime_ac

/-- The second and third packet coordinates inherit coprimality from the arms. -/
theorem coprime_yz : Q.y.Coprime Q.z :=
  Nat.Coprime.of_dvd Q.y_dvd Q.z_dvd P.coprime_bc

/-- The first two nonunit packet coordinates are distinct. -/
theorem x_ne_y : Q.x ≠ Q.y := by
  have hx := Q.x_gt_one
  intro h
  have hself : Q.x.Coprime Q.x := h ▸ Q.coprime_xy
  have hx_one : Q.x = 1 := (Nat.coprime_self Q.x).1 hself
  omega

/-- The first and third nonunit packet coordinates are distinct. -/
theorem x_ne_z : Q.x ≠ Q.z := by
  have hx := Q.x_gt_one
  intro h
  have hself : Q.x.Coprime Q.x := h ▸ Q.coprime_xz
  have hx_one : Q.x = 1 := (Nat.coprime_self Q.x).1 hself
  omega

/-- The second and third nonunit packet coordinates are distinct. -/
theorem y_ne_z : Q.y ≠ Q.z := by
  have hy := Q.y_gt_one
  intro h
  have hself : Q.y.Coprime Q.y := h ▸ Q.coprime_yz
  have hy_one : Q.y = 1 := (Nat.coprime_self Q.y).1 hself
  omega

/-- Product of the three synchronized square gaps. -/
def gapProduct : ℕ :=
  squareGap Q.y Q.z * squareGap Q.x Q.z * squareGap Q.x Q.y

/-- Product of the three squared pair maxima. -/
def pairMaxBound : ℕ :=
  max Q.y Q.z ^ 2 * max Q.x Q.z ^ 2 * max Q.x Q.y ^ 2

/-- Largest packet coordinate. -/
def height : ℕ :=
  max Q.x (max Q.y Q.z)

/-- The arm product divides the synchronized gap product. -/
theorem modulusProduct_dvd_gapProduct : P.a * P.b * P.c ∣ Q.gapProduct := by
  rcases Q.sync_a with ⟨α, hα⟩
  rcases Q.sync_b with ⟨β, hβ⟩
  rcases Q.sync_c with ⟨γ, hγ⟩
  refine ⟨α * β * γ, ?_⟩
  simp only [gapProduct, hα, hβ, hγ]
  ring

/-- The synchronized gap product is positive. -/
theorem gapProduct_pos : 0 < Q.gapProduct := by
  exact Nat.mul_pos (Nat.mul_pos
    (squareGap_pos Q.y_ne_z) (squareGap_pos Q.x_ne_z))
    (squareGap_pos Q.x_ne_y)

/-- The arm product is at most the synchronized gap product. -/
theorem modulusProduct_le_gapProduct : P.a * P.b * P.c ≤ Q.gapProduct :=
  Nat.le_of_dvd Q.gapProduct_pos Q.modulusProduct_dvd_gapProduct

/-- The gap product is at most the exact pair-max envelope. -/
theorem gapProduct_le_pairMaxBound : Q.gapProduct ≤ Q.pairMaxBound := by
  exact Nat.mul_le_mul
    (Nat.mul_le_mul (squareGap_le_max_sq Q.y Q.z)
      (squareGap_le_max_sq Q.x Q.z))
    (squareGap_le_max_sq Q.x Q.y)

/-- Each pair maximum is at most the packet height. -/
theorem pairMax_le_height :
    max Q.y Q.z ≤ Q.height ∧
      max Q.x Q.z ≤ Q.height ∧
      max Q.x Q.y ≤ Q.height := by
  constructor
  · exact Nat.le_max_right Q.x (max Q.y Q.z)
  constructor
  · apply max_le
    · exact Nat.le_max_left Q.x (max Q.y Q.z)
    · exact (Nat.le_max_right Q.y Q.z).trans
        (Nat.le_max_right Q.x (max Q.y Q.z))
  · apply max_le
    · exact Nat.le_max_left Q.x (max Q.y Q.z)
    · exact (Nat.le_max_left Q.y Q.z).trans
        (Nat.le_max_right Q.x (max Q.y Q.z))

/-- The pair-max envelope is at most the sixth power of packet height. -/
theorem pairMaxBound_le_height_pow_six : Q.pairMaxBound ≤ Q.height ^ 6 := by
  rcases Q.pairMax_le_height with ⟨hyz, hxz, hxy⟩
  calc
    Q.pairMaxBound ≤ Q.height ^ 2 * Q.height ^ 2 * Q.height ^ 2 := by
      exact Nat.mul_le_mul
        (Nat.mul_le_mul (Nat.pow_le_pow_left hyz 2)
          (Nat.pow_le_pow_left hxz 2))
        (Nat.pow_le_pow_left hxy 2)
    _ = Q.height ^ 6 := by ring

/-- Exact local-to-global pair-max bound. -/
theorem modulusProduct_le_pairMaxBound : P.a * P.b * P.c ≤ Q.pairMaxBound :=
  Q.modulusProduct_le_gapProduct.trans Q.gapProduct_le_pairMaxBound

/-- Coarser sixth-power height bound. -/
theorem modulusProduct_le_height_pow_six : P.a * P.b * P.c ≤ Q.height ^ 6 :=
  Q.modulusProduct_le_pairMaxBound.trans Q.pairMaxBound_le_height_pow_six

/-- Integral quotient of the synchronized gap product by the arm product. -/
def synchronizationIndex : ℕ :=
  Q.gapProduct / (P.a * P.b * P.c)

/-- The synchronization index is positive. -/
theorem synchronizationIndex_pos : 0 < Q.synchronizationIndex := by
  apply Nat.div_pos Q.modulusProduct_le_gapProduct
  exact Nat.mul_pos (Nat.mul_pos
    (lt_trans Nat.zero_lt_one P.a_gt_one)
    (lt_trans Nat.zero_lt_one P.b_gt_one)) P.c_pos

/-- Multiplying the index by the arm product recovers the gap product. -/
theorem modulusProduct_mul_synchronizationIndex :
    (P.a * P.b * P.c) * Q.synchronizationIndex = Q.gapProduct := by
  exact Nat.mul_div_cancel' Q.modulusProduct_dvd_gapProduct

/-- Index one is equivalent to equality in the product divisibility. -/
theorem synchronizationIndex_eq_one_iff :
    Q.synchronizationIndex = 1 ↔ Q.gapProduct = P.a * P.b * P.c := by
  constructor
  · intro h
    have hrecover := Q.modulusProduct_mul_synchronizationIndex
    simpa only [h, mul_one] using hrecover.symm
  · intro h
    have hpos : 0 < P.a * P.b * P.c :=
      Nat.mul_pos (Nat.mul_pos
        (lt_trans Nat.zero_lt_one P.a_gt_one)
        (lt_trans Nat.zero_lt_one P.b_gt_one)) P.c_pos
    simp [synchronizationIndex, h, Nat.div_self hpos]

/-- At index one, all three component square gaps equal their arm moduli. -/
theorem exactGaps_of_synchronizationIndex_eq_one
    (hindex : Q.synchronizationIndex = 1) :
    squareGap Q.y Q.z = P.a ∧
      squareGap Q.x Q.z = P.b ∧
      squareGap Q.x Q.y = P.c := by
  rcases Q.sync_a with ⟨α, hα⟩
  rcases Q.sync_b with ⟨β, hβ⟩
  rcases Q.sync_c with ⟨γ, hγ⟩
  have hproduct := Q.synchronizationIndex_eq_one_iff.1 hindex
  have habc_pos : 0 < P.a * P.b * P.c :=
    Nat.mul_pos (Nat.mul_pos
      (lt_trans Nat.zero_lt_one P.a_gt_one)
      (lt_trans Nat.zero_lt_one P.b_gt_one)) P.c_pos
  have hquotient : α * β * γ = 1 := by
    apply Nat.eq_of_mul_eq_mul_left habc_pos
    calc
      (P.a * P.b * P.c) * (α * β * γ) = Q.gapProduct := by
        simp only [gapProduct, hα, hβ, hγ]
        ring
      _ = P.a * P.b * P.c := hproduct
      _ = (P.a * P.b * P.c) * 1 := by simp
  rcases mul_eq_one.mp hquotient with ⟨hαβ, hγ_one⟩
  rcases mul_eq_one.mp hαβ with ⟨hα_one, hβ_one⟩
  exact ⟨by simpa only [hα_one, mul_one] using hα,
    by simpa only [hβ_one, mul_one] using hβ,
    by simpa only [hγ_one, mul_one] using hγ⟩

/-- Exact component gaps force synchronization index one. -/
theorem synchronizationIndex_eq_one_of_exactGaps
    (ha : squareGap Q.y Q.z = P.a)
    (hb : squareGap Q.x Q.z = P.b)
    (hc : squareGap Q.x Q.y = P.c) :
    Q.synchronizationIndex = 1 := by
  apply Q.synchronizationIndex_eq_one_iff.2
  simp only [gapProduct, ha, hb, hc]

/-- Index one is exactly the componentwise exact-gap stratum. -/
theorem synchronizationIndex_eq_one_iff_exactGaps :
    Q.synchronizationIndex = 1 ↔
      squareGap Q.y Q.z = P.a ∧
        squareGap Q.x Q.z = P.b ∧
        squareGap Q.x Q.y = P.c := by
  exact ⟨Q.exactGaps_of_synchronizationIndex_eq_one,
    fun h ↦ Q.synchronizationIndex_eq_one_of_exactGaps h.1 h.2.1 h.2.2⟩

/-- Whole-arm sign choices matching the equation `a + b = c`. -/
def CanonicallyOriented : Prop :=
  Q.y ≡ Q.z [MOD P.a] ∧
    Q.x ≡ Q.z [MOD P.b] ∧
    P.c ∣ Q.x + Q.y

/-- A packet coordinate is bounded by the arm it divides. -/
theorem coordinate_bounds : Q.x ≤ P.a ∧ Q.y ≤ P.b ∧ Q.z ≤ P.c := by
  exact ⟨Nat.le_of_dvd (lt_trans Nat.zero_lt_one P.a_gt_one) Q.x_dvd,
    Nat.le_of_dvd (lt_trans Nat.zero_lt_one P.b_gt_one) Q.y_dvd,
    Nat.le_of_dvd P.c_pos Q.z_dvd⟩

/-- The canonical whole-arm orientation forces the full packet. -/
theorem canonicalOrientation_rigid (h : Q.CanonicallyOriented) :
    Q.x = P.a ∧ Q.y = P.b ∧ Q.z = P.c := by
  rcases Q.coordinate_bounds with ⟨hxle, hyle, hzle⟩
  rcases h with ⟨hya, hxb, hc⟩
  have hxgt := Q.x_gt_one
  have hygt := Q.y_gt_one
  have hsumabc := P.sum_eq
  have hxy_pos : 0 < Q.x + Q.y := by omega
  have hc_le : P.c ≤ Q.x + Q.y := Nat.le_of_dvd hxy_pos hc
  have hxy_le : Q.x + Q.y ≤ P.c := by omega
  have hxy : Q.x + Q.y = P.c := le_antisymm hxy_le hc_le
  have hx : Q.x = P.a := by omega
  have hy : Q.y = P.b := by omega
  have hzc_a : Q.z ≡ P.c [MOD P.a] := by
    rw [← P.sum_eq]
    simpa [hx, hy, Nat.ModEq, Nat.add_mod] using hya.symm
  have hzc_b : Q.z ≡ P.c [MOD P.b] := by
    rw [← P.sum_eq]
    simpa [hx, hy, Nat.ModEq, Nat.add_mod] using hxb.symm
  have hzc_ab : Q.z ≡ P.c [MOD P.a * P.b] :=
    (Nat.modEq_and_modEq_iff_modEq_mul P.coprime_ab).1 ⟨hzc_a, hzc_b⟩
  have hzlt : Q.z < P.a * P.b := hzle.trans_lt P.c_lt_mul_ab
  exact ⟨hx, hy, hzc_ab.eq_of_lt_of_lt hzlt P.c_lt_mul_ab⟩

/-- Bounded finite coordinates containing every synchronized packet. -/
def finiteCoordinates :
    Fin (P.a + 1) × Fin (P.b + 1) × Fin (P.c + 1) :=
  (⟨Q.x, Nat.lt_succ_of_le Q.coordinate_bounds.1⟩,
    ⟨Q.y, Nat.lt_succ_of_le Q.coordinate_bounds.2.1⟩,
    ⟨Q.z, Nat.lt_succ_of_le Q.coordinate_bounds.2.2⟩)

/-- The bounded coordinate map is injective. -/
theorem finiteCoordinates_injective (P : PrimitiveABC) :
    Function.Injective (finiteCoordinates (P := P)) := by
  intro Q R h
  apply ext
  · exact congrArg (fun w ↦ w.1.val) h
  · exact congrArg (fun w ↦ w.2.1.val) h
  · exact congrArg (fun w ↦ w.2.2.val) h

end SynchronizedPacket

/-- The synchronized packet spectrum is an actual finite type. -/
noncomputable instance synchronizedPacketFintype (P : PrimitiveABC) :
    Fintype (SynchronizedPacket P) :=
  Fintype.ofInjective SynchronizedPacket.finiteCoordinates
    (SynchronizedPacket.finiteCoordinates_injective P)

/-- Proposition-level statement of finiteness for the packet spectrum. -/
theorem finite_synchronizedPacket (P : PrimitiveABC) :
    Finite (SynchronizedPacket P) := inferInstance

/-- The full corner is always a synchronized packet. -/
def fullPacket (P : PrimitiveABC) : SynchronizedPacket P where
  x := P.a
  y := P.b
  z := P.c
  x_gt_one := P.a_gt_one
  y_gt_one := P.b_gt_one
  z_gt_one := P.a_gt_one.trans P.a_lt_c
  x_dvd := dvd_refl P.a
  y_dvd := dvd_refl P.b
  z_dvd := dvd_refl P.c
  sync_a := by
    refine ⟨P.c + P.b, ?_⟩
    rw [squareGap_of_le P.b_lt_c.le, Nat.sq_sub_sq]
    have hsub : P.c - P.b = P.a := by
      have hsum := P.sum_eq
      omega
    rw [hsub, mul_comm]
  sync_b := by
    refine ⟨P.c + P.a, ?_⟩
    rw [squareGap_of_le P.a_lt_c.le, Nat.sq_sub_sq]
    have hsub : P.c - P.a = P.b := by
      have hsum := P.sum_eq
      omega
    rw [hsub, mul_comm]
  sync_c := by
    simp only [squareGap, Nat.sq_sub_sq]
    rw [max_add_min, P.sum_eq]
    exact dvd_mul_right P.c (max P.a P.b - min P.a P.b)

/-- The full packet has the canonical orientation. -/
theorem fullPacket_canonicallyOriented (P : PrimitiveABC) :
    (fullPacket P).CanonicallyOriented := by
  constructor
  · rw [Nat.ModEq]
    simp [fullPacket, ← P.sum_eq]
  constructor
  · rw [Nat.ModEq]
    simp [fullPacket, ← P.sum_eq]
  · simp [fullPacket, P.sum_eq]

/-- The full packet makes every synchronized packet spectrum nonempty. -/
instance synchronizedPacketNonempty (P : PrimitiveABC) :
    Nonempty (SynchronizedPacket P) := ⟨fullPacket P⟩

/-- The actual squarefree radical of the three-arm product. -/
noncomputable def abcRadical (P : PrimitiveABC) : ℕ :=
  UniqueFactorizationMonoid.radical (P.a * P.b * P.c)

/-- The radical of a nonunit primitive datum is larger than one. -/
theorem abcRadical_gt_one (P : PrimitiveABC) : 1 < abcRadical P := by
  rw [abcRadical, Nat.one_lt_radical_iff]
  have hbc : 0 < P.b * P.c :=
    Nat.mul_pos (lt_trans Nat.zero_lt_one P.b_gt_one) P.c_pos
  have ha : P.a ≤ P.a * (P.b * P.c) :=
    Nat.le_mul_of_pos_right P.a hbc
  rw [← mul_assoc] at ha
  exact P.a_gt_one.trans_le ha

/-- Standard logarithmic abc quality on the present primitive nonunit scope. -/
noncomputable def standardQuality (P : PrimitiveABC) : ℝ :=
  Real.log P.c / Real.log (abcRadical P)

/-- Pair-max logarithmic energy of one synchronized packet. -/
noncomputable def packetEnergy {P : PrimitiveABC}
    (Q : SynchronizedPacket P) : ℝ :=
  Real.log Q.pairMaxBound / Real.log (abcRadical P)

/-- Every individual packet energy majorizes standard abc quality. -/
theorem standardQuality_le_packetEnergy {P : PrimitiveABC}
    (Q : SynchronizedPacket P) :
    standardQuality P ≤ packetEnergy Q := by
  have hnat : P.c ≤ Q.pairMaxBound := by
    have hab : 0 < P.a * P.b :=
      Nat.mul_pos (lt_trans Nat.zero_lt_one P.a_gt_one)
        (lt_trans Nat.zero_lt_one P.b_gt_one)
    exact (Nat.le_mul_of_pos_left P.c hab).trans
      Q.modulusProduct_le_pairMaxBound
  have hreal : (P.c : ℝ) ≤ (Q.pairMaxBound : ℝ) := by
    exact_mod_cast hnat
  have hcpos : (0 : ℝ) < P.c := by
    exact_mod_cast P.c_pos
  have hlog : Real.log (P.c : ℝ) ≤ Real.log (Q.pairMaxBound : ℝ) :=
    Real.log_le_log hcpos hreal
  have hradlog : 0 ≤ Real.log (abcRadical P : ℝ) :=
    (Real.log_pos (by exact_mod_cast abcRadical_gt_one P)).le
  exact div_le_div_of_nonneg_right hlog hradlog

/-- Minimum packet energy over the actual finite nonempty spectrum. -/
noncomputable def minimumPacketEnergy (P : PrimitiveABC) : ℝ :=
  Finset.univ.inf' Finset.univ_nonempty (packetEnergy (P := P))

/-- The standard quality is bounded by the minimum synchronized-packet energy. -/
theorem standardQuality_le_minimumPacketEnergy (P : PrimitiveABC) :
    standardQuality P ≤ minimumPacketEnergy P := by
  apply Finset.le_inf' Finset.univ_nonempty (packetEnergy (P := P))
  intro Q _
  exact standardQuality_le_packetEnergy Q

/-- A prime power dividing a product lies wholly in one factor when the prime
does not divide both factors. -/
theorem primePower_orientation_channel {p e u v : ℕ} (hp : p.Prime)
    (hnotboth : ¬(p ∣ u ∧ p ∣ v)) (hpow : p ^ e ∣ u * v) :
    p ^ e ∣ u ∨ p ^ e ∣ v := by
  by_cases hu : p ∣ u
  · left
    exact hp.prime.pow_dvd_of_dvd_mul_right e
      (fun hv ↦ hnotboth ⟨hu, hv⟩) hpow
  · right
    exact hp.prime.pow_dvd_of_dvd_mul_left e hu hpow

/-- Coprime channels recover the entire modulus through their two gcds. -/
theorem coprime_channel_allocation {n u v : ℕ} (hcop : u.Coprime v)
    (hdiv : n ∣ u * v) : Nat.gcd n u * Nat.gcd n v = n :=
  (Nat.gcd_mul_gcd_eq_iff_dvd_mul_of_coprime hcop).2 hdiv

/-- First arm in the explicit exact-gap family. -/
def familyA (t : ℕ) : ℕ := 2 * t + 1

/-- Second arm in the explicit exact-gap family. -/
def familyB (t : ℕ) : ℕ := t * (3 * t + 2)

/-- Third arm in the explicit exact-gap family. -/
def familyC (t : ℕ) : ℕ := (t + 1) * (3 * t + 1)

/-- The parametric family satisfies its additive equation. -/
theorem family_sum (t : ℕ) : familyA t + familyB t = familyC t := by
  simp only [familyA, familyB, familyC]
  ring

/-- The first two arms in the parametric family are coprime. -/
theorem family_coprime (t : ℕ) : (familyA t).Coprime (familyB t) := by
  have ht : (familyA t).Coprime t := by
    have h := (Nat.coprime_add_mul_right_right t 1 2).2 (Nat.coprime_one_right t)
    convert h.symm using 1
    simp [familyA, add_comm, mul_comm]
  have ht1 : (familyA t).Coprime (t + 1) := by
    have hconsecutive : t.Coprime (t + 1) := by
      have h :=
        (Nat.coprime_add_mul_right_right t 1 1).2 (Nat.coprime_one_right t)
      convert h using 1
      simp [add_comm]
    have hadd := (Nat.coprime_add_self_left).2 hconsecutive
    convert hadd using 1
    simp [familyA]
    omega
  have hthree : (familyA t).Coprime (3 * t + 2) := by
    have hadd := (Nat.coprime_add_self_right).2 ht1
    convert hadd using 1
    simp [familyA]
    omega
  change (familyA t).Coprime (t * (3 * t + 2))
  exact ht.mul_right hthree

/-- The three square gaps in the parametric family are exactly the three arms. -/
theorem family_exact_gaps {t : ℕ} (ht : 1 ≤ t) :
    squareGap t (t + 1) = familyA t ∧
      squareGap (familyA t) (t + 1) = familyB t ∧
      squareGap (familyA t) t = familyC t := by
  have ht_zx : t + 1 ≤ familyA t := by
    simp only [familyA]
    omega
  have ht_yx : t ≤ familyA t := by omega
  constructor
  · rw [squareGap_of_le (Nat.le_add_right t 1), Nat.sq_sub_sq]
    have hsub : t + 1 - t = 1 := by omega
    rw [hsub, mul_one, familyA]
    omega
  constructor
  · rw [squareGap_comm, squareGap_of_le ht_zx, Nat.sq_sub_sq]
    have hsub : familyA t - (t + 1) = t := by
      simp only [familyA]
      omega
    rw [hsub]
    simp only [familyA, familyB]
    ring
  · rw [squareGap_comm, squareGap_of_le ht_yx, Nat.sq_sub_sq]
    have hsub : familyA t - t = t + 1 := by
      simp only [familyA]
      omega
    rw [hsub]
    simp only [familyA, familyC]
    ring

/-- The explicit family packaged as primitive `abc` data. -/
def familyDatum (t : ℕ) (ht : 2 ≤ t) : PrimitiveABC where
  a := familyA t
  b := familyB t
  c := familyC t
  a_gt_one := by
    simp only [familyA]
    omega
  b_gt_one := by
    have hfactor : 0 < 3 * t + 2 := by omega
    have hle : t ≤ familyB t := by
      exact Nat.le_mul_of_pos_right t hfactor
    omega
  sum_eq := family_sum t
  coprime_ab := family_coprime t

/-- The short divisor triple in the explicit family is an actual synchronized
packet, not merely a triple satisfying three polynomial identities. -/
def familyPacket (t : ℕ) (ht : 2 ≤ t) : SynchronizedPacket (familyDatum t ht) where
  x := familyA t
  y := t
  z := t + 1
  x_gt_one := by
    simp only [familyA]
    omega
  y_gt_one := by omega
  z_gt_one := by omega
  x_dvd := dvd_refl (familyA t)
  y_dvd := by
    change t ∣ familyB t
    exact dvd_mul_right t (3 * t + 2)
  z_dvd := by
    change t + 1 ∣ familyC t
    exact dvd_mul_right (t + 1) (3 * t + 1)
  sync_a := by
    rw [(family_exact_gaps (show 1 ≤ t by omega)).1]
    exact dvd_refl (familyA t)
  sync_b := by
    rw [(family_exact_gaps (show 1 ≤ t by omega)).2.1]
    exact dvd_refl (familyB t)
  sync_c := by
    rw [(family_exact_gaps (show 1 ≤ t by omega)).2.2]
    exact dvd_refl (familyC t)

/-- The explicit synchronized packet is proper in its second coordinate. -/
theorem familyPacket_y_ne_full (t : ℕ) (ht : 2 ≤ t) :
    (familyPacket t ht).y ≠ (familyDatum t ht).b := by
  simp only [familyPacket, familyDatum, familyB]
  have hfactor : 1 < 3 * t + 2 := by omega
  have hlt : t < t * (3 * t + 2) := by
    have hmul := Nat.mul_lt_mul_of_pos_left hfactor (show 0 < t by omega)
    simpa only [mul_one] using hmul
  omega

/-! ## Complete-premise certificates for the finite counterexamples -/

/-- Primitive datum showing that the full packet need not be unique. -/
def cornerCounterexampleDatum : PrimitiveABC where
  a := 3
  b := 5
  c := 8
  a_gt_one := by norm_num
  b_gt_one := by norm_num
  sum_eq := by norm_num
  coprime_ab := by norm_num

/-- The proper synchronized packet (3,5,2) over (3,5,8). -/
def cornerCounterexamplePacket :
    SynchronizedPacket cornerCounterexampleDatum where
  x := 3
  y := 5
  z := 2
  x_gt_one := by norm_num
  y_gt_one := by norm_num
  z_gt_one := by norm_num
  x_dvd := by norm_num [cornerCounterexampleDatum]
  y_dvd := by norm_num [cornerCounterexampleDatum]
  z_dvd := by norm_num [cornerCounterexampleDatum]
  sync_a := by norm_num [cornerCounterexampleDatum, squareGap]
  sync_b := by norm_num [cornerCounterexampleDatum, squareGap]
  sync_c := by norm_num [cornerCounterexampleDatum, squareGap]

/-- The corner counterexample packet is genuinely different from the full packet. -/
theorem cornerCounterexamplePacket_ne_full :
    cornerCounterexamplePacket ≠ fullPacket cornerCounterexampleDatum := by
  intro h
  have hz := congrArg (fun Q ↦ Q.z) h
  norm_num [cornerCounterexamplePacket, cornerCounterexampleDatum, fullPacket] at hz

/-- Primitive datum for the failure of the cubic height candidate. -/
def cubicCounterexampleDatum : PrimitiveABC where
  a := 5
  b := 7
  c := 12
  a_gt_one := by norm_num
  b_gt_one := by norm_num
  sum_eq := by norm_num
  coprime_ab := by norm_num

/-- The synchronized packet (5,7,2) over (5,7,12). -/
def cubicCounterexamplePacket :
    SynchronizedPacket cubicCounterexampleDatum where
  x := 5
  y := 7
  z := 2
  x_gt_one := by norm_num
  y_gt_one := by norm_num
  z_gt_one := by norm_num
  x_dvd := by norm_num [cubicCounterexampleDatum]
  y_dvd := by norm_num [cubicCounterexampleDatum]
  z_dvd := by norm_num [cubicCounterexampleDatum]
  sync_a := by norm_num [cubicCounterexampleDatum, squareGap]
  sync_b := by norm_num [cubicCounterexampleDatum, squareGap]
  sync_c := by norm_num [cubicCounterexampleDatum, squareGap]

/-- The complete-premise cubic height bound is false. -/
theorem cubicCounterexamplePacket_fails_height_pow_three :
    ¬(cubicCounterexampleDatum.a * cubicCounterexampleDatum.b *
      cubicCounterexampleDatum.c ≤ cubicCounterexamplePacket.height ^ 3) := by
  norm_num [cubicCounterexampleDatum, cubicCounterexamplePacket,
    SynchronizedPacket.height]

/-- Primitive datum for the quartic and coordinate-product counterexample. -/
def quarticCounterexampleDatum : PrimitiveABC where
  a := 5
  b := 16
  c := 21
  a_gt_one := by norm_num
  b_gt_one := by norm_num
  sum_eq := by norm_num
  coprime_ab := by norm_num

/-- The exact-gap synchronized packet (5,2,3) over (5,16,21). -/
def quarticCounterexamplePacket :
    SynchronizedPacket quarticCounterexampleDatum where
  x := 5
  y := 2
  z := 3
  x_gt_one := by norm_num
  y_gt_one := by norm_num
  z_gt_one := by norm_num
  x_dvd := by norm_num [quarticCounterexampleDatum]
  y_dvd := by norm_num [quarticCounterexampleDatum]
  z_dvd := by norm_num [quarticCounterexampleDatum]
  sync_a := by norm_num [quarticCounterexampleDatum, squareGap]
  sync_b := by norm_num [quarticCounterexampleDatum, squareGap]
  sync_c := by norm_num [quarticCounterexampleDatum, squareGap]

/-- The quartic counterexample has all three component gaps exact. -/
theorem quarticCounterexamplePacket_exactGaps :
    squareGap quarticCounterexamplePacket.y quarticCounterexamplePacket.z =
        quarticCounterexampleDatum.a ∧
      squareGap quarticCounterexamplePacket.x quarticCounterexamplePacket.z =
        quarticCounterexampleDatum.b ∧
      squareGap quarticCounterexamplePacket.x quarticCounterexamplePacket.y =
        quarticCounterexampleDatum.c := by
  norm_num [quarticCounterexamplePacket, quarticCounterexampleDatum, squareGap]

/-- The complete-premise quartic height bound is false. -/
theorem quarticCounterexamplePacket_fails_height_pow_four :
    ¬(quarticCounterexampleDatum.a * quarticCounterexampleDatum.b *
      quarticCounterexampleDatum.c ≤ quarticCounterexamplePacket.height ^ 4) := by
  norm_num [quarticCounterexampleDatum, quarticCounterexamplePacket,
    SynchronizedPacket.height]

/-- The complete-premise squared coordinate-product bound is false. -/
theorem quarticCounterexamplePacket_fails_coordinateProduct_sq :
    ¬(quarticCounterexampleDatum.a * quarticCounterexampleDatum.b *
      quarticCounterexampleDatum.c ≤
        (quarticCounterexamplePacket.x * quarticCounterexamplePacket.y *
          quarticCounterexamplePacket.z) ^ 2) := by
  norm_num [quarticCounterexampleDatum, quarticCounterexamplePacket]

/-- Primitive datum for the constant-one quintic counterexample. -/
def quinticCounterexampleDatum : PrimitiveABC where
  a := 385
  b := 527
  c := 912
  a_gt_one := by norm_num
  b_gt_one := by norm_num
  sum_eq := by norm_num
  coprime_ab := by norm_num

/-- The exact-gap synchronized packet (7,31,24) over (385,527,912). -/
def quinticCounterexamplePacket :
    SynchronizedPacket quinticCounterexampleDatum where
  x := 7
  y := 31
  z := 24
  x_gt_one := by norm_num
  y_gt_one := by norm_num
  z_gt_one := by norm_num
  x_dvd := by norm_num [quinticCounterexampleDatum]
  y_dvd := by norm_num [quinticCounterexampleDatum]
  z_dvd := by norm_num [quinticCounterexampleDatum]
  sync_a := by norm_num [quinticCounterexampleDatum, squareGap]
  sync_b := by norm_num [quinticCounterexampleDatum, squareGap]
  sync_c := by norm_num [quinticCounterexampleDatum, squareGap]

/-- The quintic counterexample has all three component gaps exact. -/
theorem quinticCounterexamplePacket_exactGaps :
    squareGap quinticCounterexamplePacket.y quinticCounterexamplePacket.z =
        quinticCounterexampleDatum.a ∧
      squareGap quinticCounterexamplePacket.x quinticCounterexamplePacket.z =
        quinticCounterexampleDatum.b ∧
      squareGap quinticCounterexamplePacket.x quinticCounterexamplePacket.y =
        quinticCounterexampleDatum.c := by
  norm_num [quinticCounterexamplePacket, quinticCounterexampleDatum, squareGap]

/-- The complete-premise constant-one quintic height bound is false. -/
theorem quinticCounterexamplePacket_fails_height_pow_five :
    ¬(quinticCounterexampleDatum.a * quinticCounterexampleDatum.b *
      quinticCounterexampleDatum.c ≤ quinticCounterexamplePacket.height ^ 5) := by
  norm_num [quinticCounterexampleDatum, quinticCounterexamplePacket,
    SynchronizedPacket.height]

end ABCSynchronizedDivisorPackets20260903
end IUTThreeClosures
