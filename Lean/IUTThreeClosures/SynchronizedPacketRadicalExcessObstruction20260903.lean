/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ABCSynchronizedDivisorPackets20260903
import Mathlib.Tactic.NormNum.Prime

/-!
# Radical-excess obstructions for synchronized divisor packets

This module extracts exact, unconditional consequences of the synchronized
packet definitions.  It proves a symmetric formula for the pair-max envelope,
factors the arm product through its radical, and shows that every rational
power packet-compression estimate forces a corresponding bound on the
radical excess.  A dyadic infinite family then violates the exponent `4 / 3`
packet-compression estimate for every packet in its spectrum.

There is no `abc` conclusion here.  The last result refutes the previously
proposed all-but-finitely-many packet gate at the single exact exponent
`4 / 3`; it does not refute the `abc` conjecture.
-/

namespace IUTThreeClosures
namespace SynchronizedPacketRadicalExcessObstruction20260903

open UniqueFactorizationMonoid
open ABCSynchronizedDivisorPackets20260903

abbrev PrimitiveABC :=
  ABCSynchronizedDivisorPackets20260903.PrimitiveABC

abbrev SynchronizedPacket :=
  ABCSynchronizedDivisorPackets20260903.SynchronizedPacket

namespace SynchronizedPacket

variable {P : PrimitiveABC} (Q : SynchronizedPacket P)

/-- The smallest of the three packet coordinates. -/
def minCoordinate : ℕ := min Q.x (min Q.y Q.z)

/-- The unsquared root occurring in the definition of `pairMaxBound`. -/
def pairMaxRoot : ℕ :=
  max Q.y Q.z * max Q.x Q.z * max Q.x Q.y

/-- The pair-max envelope is an exact square. -/
theorem pairMaxBound_eq_pairMaxRoot_sq :
    Q.pairMaxBound = Q.pairMaxRoot ^ 2 := by
  simp only [ABCSynchronizedDivisorPackets20260903.SynchronizedPacket.pairMaxBound,
    pairMaxRoot]
  ring

/-- Symmetric order-statistic identity: the minimum times the pair-max root
is the coordinate product times the maximum. -/
theorem min_mul_pairMaxRoot :
    Q.minCoordinate * Q.pairMaxRoot = Q.x * Q.y * Q.z * Q.height := by
  simp only [minCoordinate, pairMaxRoot,
    ABCSynchronizedDivisorPackets20260903.SynchronizedPacket.height,
    min_def, max_def]
  split_ifs <;> ring

/-- Squared form of the exact order-statistic identity. -/
theorem min_sq_mul_pairMaxBound :
    Q.minCoordinate ^ 2 * Q.pairMaxBound =
      (Q.x * Q.y * Q.z * Q.height) ^ 2 := by
  rw [Q.pairMaxBound_eq_pairMaxRoot_sq]
  calc
    Q.minCoordinate ^ 2 * Q.pairMaxRoot ^ 2 =
        (Q.minCoordinate * Q.pairMaxRoot) ^ 2 := by ring
    _ = (Q.x * Q.y * Q.z * Q.height) ^ 2 := by
      rw [Q.min_mul_pairMaxRoot]

/-- The coordinate product divides the arm product. -/
theorem coordinateProduct_dvd_modulusProduct :
    Q.x * Q.y * Q.z ∣ P.a * P.b * P.c := by
  exact mul_dvd_mul (mul_dvd_mul Q.x_dvd Q.y_dvd) Q.z_dvd

/-- Packet coordinate support is contained in the full `abc` support. -/
theorem coordinateRadical_dvd_abcRadical :
    radical (Q.x * Q.y * Q.z) ∣ abcRadical P := by
  apply radical_dvd_radical Q.coordinateProduct_dvd_modulusProduct
  exact (Nat.mul_pos
    (Nat.mul_pos (lt_trans Nat.zero_lt_one P.a_gt_one)
      (lt_trans Nat.zero_lt_one P.b_gt_one)) P.c_pos).ne'

/-- Coordinatewise divisor monotonicity puts every packet below the full
packet in the exact pair-max envelope. -/
theorem pairMaxBound_le_fullPacket :
    Q.pairMaxBound ≤ (fullPacket P).pairMaxBound := by
  have hx : Q.x ≤ P.a := Nat.le_of_dvd
    (lt_trans Nat.zero_lt_one P.a_gt_one) Q.x_dvd
  have hy : Q.y ≤ P.b := Nat.le_of_dvd
    (lt_trans Nat.zero_lt_one P.b_gt_one) Q.y_dvd
  have hz : Q.z ≤ P.c := Nat.le_of_dvd P.c_pos Q.z_dvd
  simp only [ABCSynchronizedDivisorPackets20260903.SynchronizedPacket.pairMaxBound,
    fullPacket]
  exact Nat.mul_le_mul
    (Nat.mul_le_mul
      (Nat.pow_le_pow_left (max_le_max hy hz) 2)
      (Nat.pow_le_pow_left (max_le_max hx hz) 2))
    (Nat.pow_le_pow_left (max_le_max hx hy) 2)

end SynchronizedPacket

/-- Multiplicity left after removing the squarefree radical of `abc`. -/
noncomputable def radicalExcess (P : PrimitiveABC) : ℕ :=
  (P.a * P.b * P.c) / abcRadical P

/-- The radical divides the arm product. -/
theorem abcRadical_dvd_modulusProduct (P : PrimitiveABC) :
    abcRadical P ∣ P.a * P.b * P.c := by
  exact radical_dvd_self

/-- Exact radical/excess factorization of the arm product. -/
theorem abcRadical_mul_radicalExcess (P : PrimitiveABC) :
    abcRadical P * radicalExcess P = P.a * P.b * P.c := by
  exact Nat.mul_div_cancel' (abcRadical_dvd_modulusProduct P)

/-- Every rational power packet-compression estimate forces the matching
power bound on the radical excess. -/
theorem compressionPower_forces_radicalExcessPower
    {P : PrimitiveABC} (Q : SynchronizedPacket P) (m n : ℕ)
    (hcompression : Q.pairMaxBound ^ m ≤ abcRadical P ^ (m + n)) :
    radicalExcess P ^ m ≤ abcRadical P ^ n := by
  have hproduct : P.a * P.b * P.c ≤ Q.pairMaxBound :=
    Q.modulusProduct_le_pairMaxBound
  have hpowers : (P.a * P.b * P.c) ^ m ≤ Q.pairMaxBound ^ m :=
    Nat.pow_le_pow_left hproduct m
  have hcombined :
      abcRadical P ^ m * radicalExcess P ^ m ≤
        abcRadical P ^ m * abcRadical P ^ n := by
    calc
      abcRadical P ^ m * radicalExcess P ^ m =
          (abcRadical P * radicalExcess P) ^ m := by ring
      _ = (P.a * P.b * P.c) ^ m := by
        rw [abcRadical_mul_radicalExcess]
      _ ≤ Q.pairMaxBound ^ m := hpowers
      _ ≤ abcRadical P ^ (m + n) := hcompression
      _ = abcRadical P ^ m * abcRadical P ^ n := by
        rw [pow_add]
  exact Nat.le_of_mul_le_mul_left hcombined
    (pow_pos (Nat.radical_pos (P.a * P.b * P.c)) m)

/-- Contrapositive, packet-independent obstruction to a rational power
compression estimate. -/
theorem radicalExcessPower_obstructs_compressionPower
    {P : PrimitiveABC} (Q : SynchronizedPacket P) (m n : ℕ)
    (hobstruction : abcRadical P ^ n < radicalExcess P ^ m) :
    abcRadical P ^ (m + n) < Q.pairMaxBound ^ m := by
  by_contra hnot
  have hcompression : Q.pairMaxBound ^ m ≤ abcRadical P ^ (m + n) :=
    Nat.le_of_not_gt hnot
  have hforced := compressionPower_forces_radicalExcessPower
    Q m n hcompression
  omega

/-- A compensated packet estimate has exactly the scale needed for an `abc`
power estimate: the compensator is the product of the two summand arms.  This
is only an implication; no such uniform packet estimate is asserted. -/
theorem compensatedCompression_forces_cPower
    {P : PrimitiveABC} (Q : SynchronizedPacket P) (m n : ℕ)
    (hcompression :
      Q.pairMaxBound ^ m ≤
        (P.a * P.b) ^ m * abcRadical P ^ (m + n)) :
    P.c ^ m ≤ abcRadical P ^ (m + n) := by
  have hproduct : P.a * P.b * P.c ≤ Q.pairMaxBound :=
    Q.modulusProduct_le_pairMaxBound
  have hpowers : (P.a * P.b * P.c) ^ m ≤ Q.pairMaxBound ^ m :=
    Nat.pow_le_pow_left hproduct m
  have hcombined :
      (P.a * P.b) ^ m * P.c ^ m ≤
        (P.a * P.b) ^ m * abcRadical P ^ (m + n) := by
    calc
      (P.a * P.b) ^ m * P.c ^ m =
          (P.a * P.b * P.c) ^ m := by ring
      _ ≤ Q.pairMaxBound ^ m := hpowers
      _ ≤ (P.a * P.b) ^ m * abcRadical P ^ (m + n) :=
        hcompression
  have habpos : 0 < P.a * P.b := Nat.mul_pos
    (lt_trans Nat.zero_lt_one P.a_gt_one)
    (lt_trans Nat.zero_lt_one P.b_gt_one)
  exact Nat.le_of_mul_le_mul_left hcombined (pow_pos habpos m)

/-! ## Complete-premise pointwise counterexamples -/

/-- The smallest primitive nonunit datum used to refute pointwise packet
compression statements. -/
def twoThreeFiveDatum : PrimitiveABC where
  a := 2
  b := 3
  c := 5
  a_gt_one := by norm_num
  b_gt_one := by norm_num
  sum_eq := by norm_num
  coprime_ab := by norm_num

/-- Every synchronized packet over `(2,3,5)` is the full packet. -/
theorem twoThreeFivePacket_rigid (Q : SynchronizedPacket twoThreeFiveDatum) :
    Q = fullPacket twoThreeFiveDatum := by
  have hxdiv : Q.x ∣ 2 := by simpa only [twoThreeFiveDatum] using Q.x_dvd
  have hydiv : Q.y ∣ 3 := by simpa only [twoThreeFiveDatum] using Q.y_dvd
  have hzdiv : Q.z ∣ 5 := by simpa only [twoThreeFiveDatum] using Q.z_dvd
  have hx : Q.x = 2 := by
    rcases (Nat.dvd_prime (by norm_num : Nat.Prime 2)).mp hxdiv with h | h
    · have hgt := Q.x_gt_one
      omega
    · exact h
  have hy : Q.y = 3 := by
    rcases (Nat.dvd_prime (by norm_num : Nat.Prime 3)).mp hydiv with h | h
    · have hgt := Q.y_gt_one
      omega
    · exact h
  have hz : Q.z = 5 := by
    rcases (Nat.dvd_prime (by norm_num : Nat.Prime 5)).mp hzdiv with h | h
    · have hgt := Q.z_gt_one
      omega
    · exact h
  apply ABCSynchronizedDivisorPackets20260903.SynchronizedPacket.ext hx hy
  simpa only [fullPacket, twoThreeFiveDatum] using hz

/-- Exact radical of `(2,3,5)`. -/
theorem radical_thirty : radical (30 : ℕ) = 30 := by
  change radical ((2 * 3) * 5 : ℕ) = 30
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp
    (by norm_num : Nat.Coprime (2 * 3) 5))]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp
    (by norm_num : Nat.Coprime 2 3))]
  rw [radical_of_prime (by exact (by norm_num : Nat.Prime 2).prime)]
  rw [radical_of_prime (by exact (by norm_num : Nat.Prime 3).prime)]
  rw [radical_of_prime (by exact (by norm_num : Nat.Prime 5).prime)]
  norm_num

theorem twoThreeFive_abcRadical : abcRadical twoThreeFiveDatum = 30 := by
  simpa only [abcRadical, twoThreeFiveDatum] using radical_thirty

/-- The pointwise four-thirds packet estimate already fails at `(2,3,5)`. -/
theorem twoThreeFive_no_fourThirdCompressedPacket :
    ¬ ∃ Q : SynchronizedPacket twoThreeFiveDatum,
      Q.pairMaxBound ^ 3 ≤ abcRadical twoThreeFiveDatum ^ 4 := by
  rintro ⟨Q, hcompression⟩
  rw [twoThreeFivePacket_rigid Q, twoThreeFive_abcRadical] at hcompression
  norm_num [ABCSynchronizedDivisorPackets20260903.SynchronizedPacket.pairMaxBound,
    fullPacket, twoThreeFiveDatum] at hcompression

/-- Even the pointwise compensated four-thirds packet estimate fails at
`(2,3,5)`.  This finite counterexample does not refute an eventual estimate. -/
theorem twoThreeFive_no_compensatedFourThirdCompressedPacket :
    ¬ ∃ Q : SynchronizedPacket twoThreeFiveDatum,
      Q.pairMaxBound ^ 3 ≤
        (twoThreeFiveDatum.a * twoThreeFiveDatum.b) ^ 3 *
          abcRadical twoThreeFiveDatum ^ 4 := by
  rintro ⟨Q, hcompression⟩
  rw [twoThreeFivePacket_rigid Q, twoThreeFive_abcRadical] at hcompression
  norm_num [ABCSynchronizedDivisorPackets20260903.SynchronizedPacket.pairMaxBound,
    fullPacket, twoThreeFiveDatum] at hcompression

/-- A proper synchronized packet need not carry all radical support of its
underlying primitive datum. -/
theorem radical_seventy : radical (70 : ℕ) = 70 := by
  change radical ((2 * 5) * 7 : ℕ) = 70
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp
    (by norm_num : Nat.Coprime (2 * 5) 7))]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp
    (by norm_num : Nat.Coprime 2 5))]
  rw [radical_of_prime (by exact (by norm_num : Nat.Prime 2).prime)]
  rw [radical_of_prime (by exact (by norm_num : Nat.Prime 5).prime)]
  rw [radical_of_prime (by exact (by norm_num : Nat.Prime 7).prime)]
  norm_num

theorem radical_fourHundredTwenty : radical (420 : ℕ) = 210 := by
  change radical ((5 * 7) * 12 : ℕ) = 210
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp
    (by norm_num : Nat.Coprime (5 * 7) 12))]
  rw [radical_mul (Nat.coprime_iff_isRelPrime.mp
    (by norm_num : Nat.Coprime 5 7))]
  have h12 : radical (12 : ℕ) = 6 := by
    change radical (3 * (2 ^ 2) : ℕ) = 6
    rw [radical_mul (Nat.coprime_iff_isRelPrime.mp
      (by norm_num : Nat.Coprime 3 (2 ^ 2)))]
    rw [radical_pow (2 : ℕ) (by norm_num : (2 : ℕ) ≠ 0)]
    rw [radical_of_prime (by exact (by norm_num : Nat.Prime 3).prime)]
    rw [radical_of_prime (by exact (by norm_num : Nat.Prime 2).prime)]
    norm_num
  rw [h12]
  rw [radical_of_prime (by exact (by norm_num : Nat.Prime 5).prime)]
  rw [radical_of_prime (by exact (by norm_num : Nat.Prime 7).prime)]
  norm_num

theorem cubicCounterexamplePacket_coordinateRadical_ne_abcRadical :
    radical (cubicCounterexamplePacket.x * cubicCounterexamplePacket.y *
      cubicCounterexamplePacket.z) ≠ abcRadical cubicCounterexampleDatum := by
  change radical (5 * 7 * 2 : ℕ) ≠ radical (5 * 7 * 12 : ℕ)
  rw [show 5 * 7 * 2 = 70 by norm_num,
    show 5 * 7 * 12 = 420 by norm_num,
    radical_seventy, radical_fourHundredTwenty]
  norm_num

/-- The dyadic family `2^(k+4) + 3 = 2^(k+4)+3`.  Its fixed arm `3` is
coprime to the dyadic arm. -/
def dyadicThreeDatum (k : ℕ) : PrimitiveABC where
  a := 2 ^ (k + 4)
  b := 3
  c := 2 ^ (k + 4) + 3
  a_gt_one := by
    have h := Nat.pow_le_pow_right (by omega : 0 < 2)
      (by omega : 4 ≤ k + 4)
    norm_num at h ⊢
  b_gt_one := by norm_num
  sum_eq := rfl
  coprime_ab := (by norm_num : Nat.Coprime 2 3).pow_left _

/-- The dyadic family is injectively parametrized. -/
theorem dyadicThreeDatum_injective : Function.Injective dyadicThreeDatum := by
  intro k l hdatum
  have ha := congrArg PrimitiveABC.a hdatum
  simp only [dyadicThreeDatum] at ha
  have hexponents := Nat.pow_right_injective (by norm_num : 2 ≤ 2) ha
  omega

/-- There are infinitely many distinct primitive data in the dyadic family. -/
theorem dyadicThreeDatum_range_infinite :
    (Set.range dyadicThreeDatum).Infinite :=
  Set.infinite_range_of_injective dyadicThreeDatum_injective

/-- Exact radical of the dyadic arm. -/
theorem radical_two_pow_add_four (k : ℕ) :
    radical (2 ^ (k + 4) : ℕ) = 2 := by
  rw [radical_pow_of_prime (by exact (by norm_num : Nat.Prime 2).prime)
    (by omega)]
  simp

/-- The full `abc` radical in the dyadic family is at most six times the sum
arm. -/
theorem dyadicThree_abcRadical_le (k : ℕ) :
    abcRadical (dyadicThreeDatum k) ≤ 6 * (2 ^ (k + 4) + 3) := by
  let a : ℕ := 2 ^ (k + 4)
  let c : ℕ := a + 3
  have ha : radical a = 2 := by
    simpa only [a] using radical_two_pow_add_four k
  have hthree : radical (3 : ℕ) = 3 := by
    exact radical_of_prime (by exact (by norm_num : Nat.Prime 3).prime)
  have hcpos : 0 < c := by simp [c, a]
  have hcle : radical c ≤ c := (Nat.radical_le_self_iff.mpr hcpos.ne')
  have houter : radical ((a * 3) * c) ∣ radical (a * 3) * radical c :=
    radical_mul_dvd
  have hinner : radical (a * 3) ∣ radical a * radical 3 :=
    radical_mul_dvd
  have hdiv : radical ((a * 3) * c) ∣
      (radical a * radical 3) * radical c :=
    houter.trans (mul_dvd_mul_right hinner (radical c))
  have hupper : radical ((a * 3) * c) ≤
      (radical a * radical 3) * radical c :=
    Nat.le_of_dvd (by positivity) hdiv
  change radical ((a * 3) * c) ≤ 6 * c
  calc
    radical ((a * 3) * c) ≤
        (radical a * radical 3) * radical c := hupper
    _ = 6 * radical c := by rw [ha, hthree]
    _ ≤ 6 * c := Nat.mul_le_mul_left 6 hcle

/-- The radical excess of the dyadic family retains at least half of the
dyadic arm. -/
theorem dyadicThree_halfArm_le_radicalExcess (k : ℕ) :
    2 ^ (k + 3) ≤ radicalExcess (dyadicThreeDatum k) := by
  let h : ℕ := 2 ^ (k + 3)
  let c : ℕ := 2 ^ (k + 4) + 3
  have hrad : abcRadical (dyadicThreeDatum k) ≤ 6 * c := by
    simpa only [c] using dyadicThree_abcRadical_le k
  have hpow : 2 ^ (k + 4) = 2 * h := by
    simp only [h]
    rw [show k + 4 = (k + 3) + 1 by omega, pow_succ]
    ring
  have hfactor := abcRadical_mul_radicalExcess (dyadicThreeDatum k)
  have hmul :
      abcRadical (dyadicThreeDatum k) * h ≤
        abcRadical (dyadicThreeDatum k) *
          radicalExcess (dyadicThreeDatum k) := by
    calc
      abcRadical (dyadicThreeDatum k) * h ≤ (6 * c) * h :=
        Nat.mul_le_mul_right h hrad
      _ = (dyadicThreeDatum k).a * (dyadicThreeDatum k).b *
          (dyadicThreeDatum k).c := by
        simp only [dyadicThreeDatum, c]
        rw [hpow]
        ring
      _ = abcRadical (dyadicThreeDatum k) *
          radicalExcess (dyadicThreeDatum k) := hfactor.symm
  have hradpos : 0 < abcRadical (dyadicThreeDatum k) :=
    Nat.radical_pos _
  exact Nat.le_of_mul_le_mul_left hmul hradpos

/-- In every member of the dyadic family, the radical excess cubed is
strictly larger than the radical. -/
theorem dyadicThree_abcRadical_lt_radicalExcess_cube (k : ℕ) :
    abcRadical (dyadicThreeDatum k) <
      radicalExcess (dyadicThreeDatum k) ^ 3 := by
  let h : ℕ := 2 ^ (k + 3)
  have hh : 8 ≤ h := by
    have hpow := Nat.pow_le_pow_right (by omega : 0 < 2)
      (by omega : 3 ≤ k + 3)
    norm_num at hpow ⊢
    exact hpow
  have hpow4 : 2 ^ (k + 4) = 2 * h := by
    simp only [h]
    rw [show k + 4 = (k + 3) + 1 by omega, pow_succ]
    ring
  have hsquare : 64 ≤ h ^ 2 := by
    have := Nat.pow_le_pow_left hh 2
    norm_num at this ⊢
    exact this
  have hcubic : 64 * h ≤ h ^ 3 := by
    calc
      64 * h ≤ h ^ 2 * h := Nat.mul_le_mul_right h hsquare
      _ = h ^ 3 := by ring
  have hlinear : 6 * (2 * h + 3) < 64 * h := by omega
  have hrad : abcRadical (dyadicThreeDatum k) ≤ 6 * (2 * h + 3) := by
    simpa only [hpow4] using dyadicThree_abcRadical_le k
  have hhalf : h ≤ radicalExcess (dyadicThreeDatum k) := by
    simpa only [h] using dyadicThree_halfArm_le_radicalExcess k
  have hcubele : h ^ 3 ≤ radicalExcess (dyadicThreeDatum k) ^ 3 :=
    Nat.pow_le_pow_left hhalf 3
  exact hrad.trans_lt (hlinear.trans_le (hcubic.trans hcubele))

/-- Every synchronized packet over the dyadic family violates the exact
integer form `B <= R^(4/3)`, namely `B^3 <= R^4`. -/
theorem dyadicThree_everyPacket_fails_fourThirdCompression
    (k : ℕ) (Q : SynchronizedPacket (dyadicThreeDatum k)) :
    abcRadical (dyadicThreeDatum k) ^ 4 < Q.pairMaxBound ^ 3 := by
  have hobstruction :
      abcRadical (dyadicThreeDatum k) ^ 1 <
        radicalExcess (dyadicThreeDatum k) ^ 3 := by
    simpa using dyadicThree_abcRadical_lt_radicalExcess_cube k
  simpa only [Nat.reduceAdd] using
    radicalExcessPower_obstructs_compressionPower Q 3 1 hobstruction

/-- Hence no packet in any member of the dyadic family meets the exact
four-thirds power compression inequality. -/
theorem dyadicThree_no_fourThirdCompressedPacket (k : ℕ) :
    ¬ ∃ Q : SynchronizedPacket (dyadicThreeDatum k),
      Q.pairMaxBound ^ 3 ≤ abcRadical (dyadicThreeDatum k) ^ 4 := by
  rintro ⟨Q, hcompression⟩
  have hfailure := dyadicThree_everyPacket_fails_fourThirdCompression k Q
  omega

/-- Primitive data for which every packet violates `B^3 <= R^4`. -/
def fourThirdObstructionLocus : Set PrimitiveABC :=
  {P | ∀ Q : SynchronizedPacket P,
    abcRadical P ^ 4 < Q.pairMaxBound ^ 3}

/-- The entire dyadic range lies in the four-thirds obstruction locus. -/
theorem dyadicThreeDatum_range_subset_fourThirdObstructionLocus :
    Set.range dyadicThreeDatum ⊆ fourThirdObstructionLocus := by
  rintro P ⟨k, rfl⟩ Q
  exact dyadicThree_everyPacket_fails_fourThirdCompression k Q

/-- The four-thirds packet-compression obstruction occurs for infinitely many
primitive data, so the corresponding all-but-finitely-many packet gate is
false. -/
theorem fourThirdObstructionLocus_infinite :
    fourThirdObstructionLocus.Infinite :=
  (dyadicThreeDatum_range_infinite.mono
    dyadicThreeDatum_range_subset_fourThirdObstructionLocus)

end SynchronizedPacketRadicalExcessObstruction20260903
end IUTThreeClosures
