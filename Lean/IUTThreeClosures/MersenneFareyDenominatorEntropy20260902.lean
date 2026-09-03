/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneSigmaOneExactOrderCoupling20260902

/-!
# Denominator entropy at the Mersenne Farey endpoint

The mathematical argument precedes this module in
`research/ABC_MERSENNE_FAREY_DENOMINATOR_ENTROPY_2026_09_02.md`.

The finite theorem below splits an indexed Farey packet at a denominator
cutoff.  Numerators below `H` have a triangular total capacity in every
denominator fibre, while every row above `T` has slope at most `H/T`.
This is the exact finite core of the paper's new swarm theorem: linear
endpoint energy forces many large-denominator rows, which on the actual
packet are distinct super-Wieferich primes.

No asymptotic row-count estimate, statement about the distribution of
Wieferich primes, or abc consequence is assumed here.
-/

namespace IUTThreeClosures
namespace MersenneFareyDenominatorEntropy20260902

open scoped BigOperators

/-! ## Indexed finite Farey packets -/

/-- Numerators present in the denominator fibre `q`.  A finite arithmetic
packet can be encoded by taking `rows q` to be its set of multipliers. -/
noncomputable def numeratorMass (rows : ℕ → Finset ℕ) (q : ℕ) : ℝ :=
  ∑ r ∈ rows q, (r : ℝ)

/-- Slope mass in one denominator fibre. -/
noncomputable def fibreSlopeMass (rows : ℕ → Finset ℕ) (q : ℕ) : ℝ :=
  ∑ r ∈ rows q, (r : ℝ) / (q : ℝ)

/-- Harmonic denominator mass through `T`. -/
noncomputable def harmonicPrefix (T : ℕ) : ℝ :=
  ∑ q ∈ Finset.Icc 1 T, (1 : ℝ) / (q : ℝ)

/-- Total numerator capacity below the strict cutoff `r < H`. -/
noncomputable def triangularCapacity (H : ℕ) : ℝ :=
  ∑ r ∈ Finset.Ico 1 H, (r : ℝ)

/-- The strict numerator cutoff has the expected triangular capacity. -/
theorem triangularCapacity_eq (H : ℕ) :
    triangularCapacity H = ((H * (H - 1) / 2 : ℕ) : ℝ) := by
  unfold triangularCapacity
  cases H with
  | zero => simp
  | succ n =>
      rw [Finset.sum_Ico_eq_sub (fun r => (r : ℝ))
        (Nat.succ_le_succ (Nat.zero_le n))]
      simp only [Finset.sum_range_one, Nat.cast_zero, sub_zero]
      have h := congrArg (fun z : ℕ => (z : ℝ))
        (Finset.sum_range_id (n + 1))
      push_cast at h
      exact h

/-- Farey energy in the denominator prefix `1 <= q <= T`. -/
noncomputable def prefixFareyEnergy (rows : ℕ → Finset ℕ) (T : ℕ) : ℝ :=
  ∑ q ∈ Finset.Icc 1 T, fibreSlopeMass rows q

/-- Farey energy in the denominator tail `T < q <= Q`. -/
noncomputable def tailFareyEnergy (rows : ℕ → Finset ℕ) (T Q : ℕ) : ℝ :=
  ∑ q ∈ Finset.Icc (T + 1) Q, fibreSlopeMass rows q

/-- Number of rows in the denominator tail. -/
def tailRowCount (rows : ℕ → Finset ℕ) (T Q : ℕ) : ℕ :=
  ∑ q ∈ Finset.Icc (T + 1) Q, (rows q).card

theorem fibreSlopeMass_eq_numeratorMass_div
    (rows : ℕ → Finset ℕ) (q : ℕ) :
    fibreSlopeMass rows q = numeratorMass rows q / (q : ℝ) := by
  simp [fibreSlopeMass, numeratorMass, Finset.sum_div]

/-- Any multiplier fibre contained in `1,...,H-1` has at most the full
triangular numerator mass. -/
theorem numeratorMass_le_triangularCapacity
    (rows : ℕ → Finset ℕ) (q H : ℕ)
    (hsub : rows q ⊆ Finset.Ico 1 H) :
    numeratorMass rows q ≤ triangularCapacity H := by
  unfold numeratorMass triangularCapacity
  exact Finset.sum_le_sum_of_subset_of_nonneg hsub (by
    intro r _hr _hnot
    positivity)

/-- The complete low-denominator packet is bounded by triangular numerator
capacity times harmonic denominator mass. -/
theorem prefixFareyEnergy_le_triangular_mul_harmonic
    (rows : ℕ → Finset ℕ) (T H : ℕ)
    (hsub : ∀ q ∈ Finset.Icc 1 T, rows q ⊆ Finset.Ico 1 H) :
    prefixFareyEnergy rows T ≤ triangularCapacity H * harmonicPrefix T := by
  unfold prefixFareyEnergy harmonicPrefix
  calc
    (∑ q ∈ Finset.Icc 1 T, fibreSlopeMass rows q) ≤
        ∑ q ∈ Finset.Icc 1 T, triangularCapacity H / (q : ℝ) := by
      apply Finset.sum_le_sum
      intro q hq
      rw [fibreSlopeMass_eq_numeratorMass_div]
      exact div_le_div_of_nonneg_right
        (numeratorMass_le_triangularCapacity rows q H (hsub q hq)) (by positivity)
    _ = triangularCapacity H *
        (∑ q ∈ Finset.Icc 1 T, (1 : ℝ) / (q : ℝ)) := by
      simp_rw [div_eq_mul_inv]
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro q _hq
      ring

/-! ## Large-denominator tail -/

/-- Clearing positive denominators proves the elementary slope cutoff used
in the tail: `r <= H` and `T <= q` imply `r/q <= H/T`. -/
theorem natSlope_le_of_cutoffs
    {r q H T : ℕ} (hT : 0 < T) (hr : r ≤ H) (hq : T ≤ q) :
    (r : ℝ) / (q : ℝ) ≤ (H : ℝ) / (T : ℝ) := by
  have hqpos : 0 < q := hT.trans_le hq
  have hmul : r * T ≤ H * q := by
    exact (Nat.mul_le_mul hr le_rfl).trans (Nat.mul_le_mul_left H hq)
  apply (div_le_div_iff₀ (by exact_mod_cast hqpos) (by exact_mod_cast hT)).2
  exact_mod_cast hmul

/-- A single high-denominator fibre is bounded by its cardinality times the
uniform tail slope `H/T`. -/
theorem fibreSlopeMass_le_card_mul_cutoff
    (rows : ℕ → Finset ℕ) {q H T : ℕ} (hT : 0 < T) (hq : T ≤ q)
    (hr : ∀ r ∈ rows q, r ≤ H) :
    fibreSlopeMass rows q ≤ (rows q).card * ((H : ℝ) / (T : ℝ)) := by
  unfold fibreSlopeMass
  calc
    (∑ r ∈ rows q, (r : ℝ) / (q : ℝ)) ≤
        ∑ _r ∈ rows q, (H : ℝ) / (T : ℝ) := by
      apply Finset.sum_le_sum
      intro r hmem
      exact natSlope_le_of_cutoffs hT (hr r hmem) hq
    _ = (rows q).card * ((H : ℝ) / (T : ℝ)) := by simp

/-- The entire denominator tail costs at most `H/T` per row. -/
theorem tailFareyEnergy_le_count_mul_cutoff
    (rows : ℕ → Finset ℕ) {T Q H : ℕ} (hT : 0 < T)
    (hr : ∀ q ∈ Finset.Icc (T + 1) Q, ∀ r ∈ rows q, r ≤ H) :
    tailFareyEnergy rows T Q ≤
      (tailRowCount rows T Q : ℝ) * ((H : ℝ) / (T : ℝ)) := by
  unfold tailFareyEnergy tailRowCount
  calc
    (∑ q ∈ Finset.Icc (T + 1) Q, fibreSlopeMass rows q) ≤
        ∑ q ∈ Finset.Icc (T + 1) Q,
          (rows q).card * ((H : ℝ) / (T : ℝ)) := by
      apply Finset.sum_le_sum
      intro q hqmem
      have hq : T ≤ q := by
        have : T + 1 ≤ q := (Finset.mem_Icc.mp hqmem).1
        omega
      exact fibreSlopeMass_le_card_mul_cutoff rows hT hq (hr q hqmem)
    _ = (tailRowCount rows T Q : ℝ) * ((H : ℝ) / (T : ℝ)) := by
      have hcast :
          ((∑ q ∈ Finset.Icc (T + 1) Q, (rows q).card : ℕ) : ℝ) =
            ∑ q ∈ Finset.Icc (T + 1) Q, ((rows q).card : ℝ) := by
        simp
      rw [tailRowCount]
      rw [hcast, Finset.sum_mul]

/-! ## Finite entropy forcing -/

/-- If total energy dominates a target and the prefix has budget `small`,
the tail row count must carry the remaining energy at cost `H/T` per row.
The asymptotic paper chooses `T` to be a small power of `log m`. -/
theorem tailRowCount_forced_product
    (rows : ℕ → Finset ℕ) {T Q H : ℕ} {total target small : ℝ}
    (hT : 0 < T)
    (hr : ∀ q ∈ Finset.Icc (T + 1) Q, ∀ r ∈ rows q, r ≤ H)
    (htotal : target ≤ total)
    (hsplit : total ≤ prefixFareyEnergy rows T + tailFareyEnergy rows T Q)
    (hsmall : prefixFareyEnergy rows T ≤ small) :
    target - small ≤
      (tailRowCount rows T Q : ℝ) * ((H : ℝ) / (T : ℝ)) := by
  have htail := tailFareyEnergy_le_count_mul_cutoff rows hT hr
  linarith

/-- Multiplying the preceding conclusion by the positive cutoff removes the
division.  This is the form used to read off a row-count lower bound. -/
theorem cutoff_mul_energyDefect_le_count_mul_height
    (rows : ℕ → Finset ℕ) {T Q H : ℕ} {total target small : ℝ}
    (hT : 0 < T)
    (hr : ∀ q ∈ Finset.Icc (T + 1) Q, ∀ r ∈ rows q, r ≤ H)
    (htotal : target ≤ total)
    (hsplit : total ≤ prefixFareyEnergy rows T + tailFareyEnergy rows T Q)
    (hsmall : prefixFareyEnergy rows T ≤ small) :
    (T : ℝ) * (target - small) ≤ (tailRowCount rows T Q : ℝ) * H := by
  have hbound := tailRowCount_forced_product rows hT hr htotal hsplit hsmall
  have hTreal : (0 : ℝ) < T := by exact_mod_cast hT
  calc
    (T : ℝ) * (target - small) ≤
        (T : ℝ) * ((tailRowCount rows T Q : ℝ) * ((H : ℝ) / (T : ℝ))) :=
      mul_le_mul_of_nonneg_left hbound hTreal.le
    _ = (tailRowCount rows T Q : ℝ) * H := by
      field_simp

/-! ## Exact boundary checks -/

/-- Exact-order depth three implies the usual base-two super-Wieferich
congruence.  The only input is that the exact order divides `p-1`; no
distribution assertion is involved. -/
theorem exactOrder_depthThree_implies_superWieferich
    {p d r : ℕ} (hindex : p - 1 = d * r)
    (hdepth : p ^ 3 ∣ 2 ^ d - 1) :
    p ^ 3 ∣ 2 ^ (p - 1) - 1 := by
  have hdvd : d ∣ p - 1 := ⟨r, hindex⟩
  exact hdepth.trans (Nat.pow_sub_one_dvd_pow_sub_one 2 hdvd)

/-- The depth-three rows in the actual common-index structure are therefore
base-two super-Wieferich rows. -/
theorem endpointRow_depthThree_implies_superWieferich
    {m : ℕ}
    (x : MersenneSigmaOneExactOrderCoupling20260902.EndpointExactOrderRow m)
    (hdepth : x.p ^ 3 ∣ 2 ^ x.d - 1) :
    x.p ^ 3 ∣ 2 ^ (x.p - 1) - 1 := by
  apply exactOrder_depthThree_implies_superWieferich (p := x.p)
      (d := x.d) (r := x.r) ?_ hdepth
  simp [x.prime_eq]

/-- For a fixed common index, an endpoint exact-order row is determined by
its represented prime.  Exact-order uniqueness first determines `d`; the
common-index identity and multiplier representation then determine `q` and
`r`. -/
theorem endpointExactOrderRow_eq_of_prime_eq
    {m : ℕ}
    (x y : MersenneSigmaOneExactOrderCoupling20260902.EndpointExactOrderRow m)
    (hp : x.p = y.p) :
    x = y := by
  have hd : x.d = y.d := by
    calc
      x.d = MersenneOrderBlockDecomposition20260901.mersenneExactOrder x.p :=
        x.exactOrder_eq.symm
      _ = MersenneOrderBlockDecomposition20260901.mersenneExactOrder y.p := by rw [hp]
      _ = y.d := y.exactOrder_eq
  have hq : x.q = y.q := by
    apply Nat.mul_left_cancel x.d_pos
    calc
      x.d * x.q = m := x.index_eq
      _ = y.d * y.q := y.index_eq.symm
      _ = x.d * y.q := by rw [hd]
  have hdr : x.d * x.r = y.d * y.r := by
    apply Nat.add_left_cancel (n := 1)
    exact x.prime_eq.symm.trans (hp.trans y.prime_eq)
  have hr : x.r = y.r := by
    apply Nat.mul_left_cancel x.d_pos
    calc
      x.d * x.r = y.d * y.r := hdr
      _ = x.d * y.r := by rw [hd]
  cases x
  cases y
  simp_all

/-- The row-to-prime map used in the swarm reduction is injective. -/
theorem endpointPrime_injective {m : ℕ} :
    Function.Injective
      (fun x : MersenneSigmaOneExactOrderCoupling20260902.EndpointExactOrderRow m => x.p) :=
  fun x y hp => endpointExactOrderRow_eq_of_prime_eq x y hp

/-- A row beyond the denominator cutoff lies in a shorter prime window.
This division-free form says `p - 1 < m*H/T` after clearing `T`. -/
theorem endpointRow_tail_prime_crossBound
    {m T H : ℕ}
    (x : MersenneSigmaOneExactOrderCoupling20260902.EndpointExactOrderRow m)
    (hTq : T < x.q) (hrH : x.r < H) :
    T * (x.p - 1) < m * H := by
  have hpSub : x.p - 1 = x.d * x.r := by
    simp [x.prime_eq]
  calc
    T * (x.p - 1) = T * (x.d * x.r) := by rw [hpSub]
    _ < x.q * (x.d * x.r) :=
      Nat.mul_lt_mul_of_pos_right hTq (Nat.mul_pos x.d_pos x.r_pos)
    _ = (x.q * x.d) * x.r := by ring
    _ < (x.q * x.d) * H := by
      exact Nat.mul_lt_mul_of_pos_left hrH (Nat.mul_pos x.q_pos x.d_pos)
    _ = m * H := by rw [Nat.mul_comm x.q x.d, x.index_eq]

/-- The first known base-two Wieferich prime is not a depth-three row. -/
theorem wieferich_1093_not_superWieferich_at_exactOrder :
    1093 ^ 2 ∣ 2 ^ 364 - 1 ∧ ¬ 1093 ^ 3 ∣ 2 ^ 364 - 1 := by
  exact ⟨
    MersenneSigmaOneExactOrderCoupling20260902.wieferich_1093_exactly_one_repeated_layer.2.2.2.1,
    MersenneSigmaOneExactOrderCoupling20260902.wieferich_1093_exactly_one_repeated_layer.2.2.2.2⟩

/-- The second known base-two Wieferich prime is also not a depth-three row. -/
theorem wieferich_3511_not_superWieferich_at_exactOrder :
    3511 ^ 2 ∣ 2 ^ 1755 - 1 ∧ ¬ 3511 ^ 3 ∣ 2 ^ 1755 - 1 := by
  exact ⟨
    MersenneSigmaOneExactOrderCoupling20260902.wieferich_3511_exactly_one_repeated_layer.2.2.2.1,
    MersenneSigmaOneExactOrderCoupling20260902.wieferich_3511_exactly_one_repeated_layer.2.2.2.2⟩

#print axioms fibreSlopeMass_eq_numeratorMass_div
#print axioms triangularCapacity_eq
#print axioms numeratorMass_le_triangularCapacity
#print axioms prefixFareyEnergy_le_triangular_mul_harmonic
#print axioms natSlope_le_of_cutoffs
#print axioms fibreSlopeMass_le_card_mul_cutoff
#print axioms tailFareyEnergy_le_count_mul_cutoff
#print axioms tailRowCount_forced_product
#print axioms cutoff_mul_energyDefect_le_count_mul_height
#print axioms exactOrder_depthThree_implies_superWieferich
#print axioms endpointRow_depthThree_implies_superWieferich
#print axioms endpointExactOrderRow_eq_of_prime_eq
#print axioms endpointPrime_injective
#print axioms endpointRow_tail_prime_crossBound
#print axioms wieferich_1093_not_superWieferich_at_exactOrder
#print axioms wieferich_3511_not_superWieferich_at_exactOrder

end MersenneFareyDenominatorEntropy20260902
end IUTThreeClosures
