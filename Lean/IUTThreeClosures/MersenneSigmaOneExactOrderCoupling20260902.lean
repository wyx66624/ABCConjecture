/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MersenneCriticalSlowSlackGate20260901
import IUTThreeClosures.MersenneSuperWieferichDepth20260901

/-!
# Exact-order coupling at the Mersenne endpoint `sigma = 1`

The mathematical argument precedes this file in
`research/ABC_MERSENNE_SIGMA_ONE_EXACT_ORDER_COUPLING_2026_09_02.md`.

The paper proves the endpoint low one-copy estimate using the published
weighted Brun--Titchmarsh theorem and reduces the low-multiplier deep term to
an exact-order Farey energy.  Those analytic statements are not encoded here.
This module formalizes the finite core of the new reduction:

* common-index rows with equal multiplier slope are identical;
* the identity `d * r = m * (r / q)` preserves the cross-fibre correlation;
* a supplied pointwise estimate transfers to a finite Farey-energy bound;
* order modulo `p^j` stays equal to the order modulo `p` exactly through
  the canonical factorization depth;
* stable lift layers split exactly into layer two and layers three through
  the prime depth;
* after supplied low-arm budgets, one of the two critical arms is large.

No asymptotic estimate, Brun--Titchmarsh theorem, Yamada theorem, Wieferich
density statement, or abc consequence is introduced as an assumption.
-/

namespace IUTThreeClosures
namespace MersenneSigmaOneExactOrderCoupling20260902

open scoped BigOperators
open MersenneOrderBlockDecomposition20260901
open MersenneSuperWieferichDepth20260901
open MersenneCriticalSlowSlackGate20260901
open MersenneCanonicalBlockWitness20260901

/-! ## Common-index exact-order rows -/

/-- The finite arithmetic data used by one row of the endpoint packet.
Primality and depth are deliberately absent: cross-fibre injectivity uses
only the common index, the multiplier representation, and exact order. -/
structure EndpointExactOrderRow (m : ℕ) where
  d : ℕ
  q : ℕ
  r : ℕ
  p : ℕ
  d_pos : 0 < d
  q_pos : 0 < q
  r_pos : 0 < r
  index_eq : d * q = m
  prime_eq : p = 1 + d * r
  exactOrder_eq : mersenneExactOrder p = d

/-- Equality of slopes can be cleared without independently estimating the
two labels.  The common-index equations force equality of `d * r`. -/
theorem index_multiplier_eq_of_slope_eq
    {m : ℕ} (x y : EndpointExactOrderRow m)
    (hslope : x.r * y.q = y.r * x.q) :
    x.d * x.r = y.d * y.r := by
  have hscaled :
      (x.d * x.r) * (x.q * y.q) =
        (y.d * y.r) * (x.q * y.q) := by
    calc
      (x.d * x.r) * (x.q * y.q) =
          (x.d * x.q) * (x.r * y.q) := by ring
      _ = m * (x.r * y.q) := by rw [x.index_eq]
      _ = m * (y.r * x.q) := by rw [hslope]
      _ = (y.d * y.q) * (y.r * x.q) := by rw [y.index_eq]
      _ = (y.d * y.r) * (x.q * y.q) := by ring
  exact Nat.mul_right_cancel (Nat.mul_pos x.q_pos y.q_pos) hscaled

/-- Cross-fibre multiplier slopes are injective on a fixed common index.
Exact-order uniqueness is used only after the common-index algebra has
identified the represented prime. -/
theorem endpointExactOrderRow_eq_of_slope_eq
    {m : ℕ} (x y : EndpointExactOrderRow m)
    (hslope : x.r * y.q = y.r * x.q) : x = y := by
  have hdr : x.d * x.r = y.d * y.r :=
    index_multiplier_eq_of_slope_eq x y hslope
  have hp : x.p = y.p := by
    rw [x.prime_eq, y.prime_eq, hdr]
  have hd : x.d = y.d := by
    calc
      x.d = mersenneExactOrder x.p := x.exactOrder_eq.symm
      _ = mersenneExactOrder y.p := congrArg mersenneExactOrder hp
      _ = y.d := y.exactOrder_eq
  have hq : x.q = y.q := by
    apply Nat.mul_left_cancel x.d_pos
    calc
      x.d * x.q = m := x.index_eq
      _ = y.d * y.q := y.index_eq.symm
      _ = x.d * y.q := by rw [hd]
  have hr : x.r = y.r := by
    apply Nat.mul_left_cancel x.d_pos
    calc
      x.d * x.r = y.d * y.r := hdr
      _ = x.d * y.r := by rw [hd]
  cases x
  cases y
  simp_all

/-- The natural cross-product formulation gives injectivity of the map from
rows to rational slopes without invoking division in `ℕ`. -/
theorem endpointSlopeCross_injective {m : ℕ} :
    ∀ x y : EndpointExactOrderRow m,
      x.r * y.q = y.r * x.q → x = y :=
  endpointExactOrderRow_eq_of_slope_eq

#print axioms index_multiplier_eq_of_slope_eq
#print axioms endpointExactOrderRow_eq_of_slope_eq
#print axioms endpointSlopeCross_injective

/-! ## Finite coupling of the size and multiplier cutoffs -/

/-- Once the low-multiplier size ceiling `d*H <= d^2/F` is available, every
row strictly above the size cutoff has multiplier at least `H`.  Integrality
is decisive: `r < H` implies `1 + d*r <= d*H` for positive `d`. -/
theorem aboveSizeCutoff_forces_highMultiplier
    {d p r H : ℕ} {F : ℝ} (hd : 0 < d)
    (hrep : p = 1 + d * r)
    (hcut : (d : ℝ) * (H : ℝ) ≤ (d : ℝ) ^ 2 / F)
    (habove : (d : ℝ) ^ 2 / F < (p : ℝ)) :
    H ≤ r := by
  by_contra hnot
  have hr : r < H := Nat.lt_of_not_ge hnot
  have hpNat : p ≤ d * H := by
    have hrSucc : r + 1 ≤ H := Nat.succ_le_iff.mpr hr
    calc
      p = 1 + d * r := hrep
      _ ≤ d + d * r := Nat.add_le_add_right hd (d * r)
      _ = d * (r + 1) := by ring
      _ ≤ d * H := Nat.mul_le_mul_left d hrSucc
  have hpReal : (p : ℝ) ≤ (d : ℝ) * (H : ℝ) := by
    exact_mod_cast hpNat
  exact (not_lt_of_ge (hpReal.trans hcut)) habove

#print axioms aboveSizeCutoff_forces_highMultiplier

/-! ## The exact Farey-energy transfer -/

/-- The finite energy which retains the joint numerator-denominator labels. -/
noncomputable def fareyEnergy {α : Type*} (s : Finset α)
    (numerator denominator : α → ℝ) : ℝ :=
  ∑ x ∈ s, numerator x / denominator x

/-- The weighted mass of a finite packet. -/
noncomputable def packetMass {α : Type*} (s : Finset α)
    (weight : α → ℝ) : ℝ :=
  ∑ x ∈ s, weight x

/-- The common-index identity `d*q=m` turns the Yamada numerator `d*r`
into `m` times the actual Farey slope `r/q`. -/
theorem indexMultiplier_real_eq_fareySlope
    {d q r m : ℕ} (hq : 0 < q) (hindex : d * q = m) :
    (d : ℝ) * (r : ℝ) = (m : ℝ) * ((r : ℝ) / (q : ℝ)) := by
  have hqReal : (q : ℝ) ≠ 0 := by exact_mod_cast hq.ne'
  field_simp [hqReal]
  exact_mod_cast (by
    calc
      (d * r) * q = (d * q) * r := by ring
      _ = m * r := by rw [hindex]
      _ = r * m := by ring)

/-- On an actual common-index row, the Farey slope is exactly the first
moment `(p - 1) / m` of its represented prime. -/
theorem endpointSlope_eq_primeSubOne_div_index
    {m : ℕ} (hm : 0 < m) (x : EndpointExactOrderRow m) :
    (x.r : ℝ) / (x.q : ℝ) = ((x.p - 1 : ℕ) : ℝ) / (m : ℝ) := by
  have hqReal : (x.q : ℝ) ≠ 0 := by exact_mod_cast x.q_pos.ne'
  have hmReal : (m : ℝ) ≠ 0 := by exact_mod_cast hm.ne'
  apply (div_eq_div_iff hqReal hmReal).2
  exact_mod_cast (by
    have hpSub : x.p - 1 = x.d * x.r := by simp [x.prime_eq]
    calc
      x.r * m = x.r * (x.d * x.q) := by rw [x.index_eq]
      _ = (x.d * x.r) * x.q := by ring
      _ = (x.p - 1) * x.q := by rw [hpSub])

/-- The total Farey energy of a finite endpoint packet is exactly its
prime first moment divided by the common index. -/
theorem endpointFareyEnergy_eq_primeMoment_div_index
    {m : ℕ} (hm : 0 < m) (s : Finset (EndpointExactOrderRow m)) :
    fareyEnergy s (fun x => (x.r : ℝ)) (fun x => (x.q : ℝ)) =
      (∑ x ∈ s, ((x.p - 1 : ℕ) : ℝ)) / (m : ℝ) := by
  rw [Finset.sum_div]
  unfold fareyEnergy
  apply Finset.sum_congr rfl
  intro x _hx
  exact endpointSlope_eq_primeSubOne_div_index hm x

/-- Summing a pointwise linear energy estimate preserves the paired labels.
This is the finite kernel of the correlation-preserving Yamada transfer; all
analytic constants and logarithmic comparisons remain external premises. -/
theorem packetMass_le_mul_fareyEnergy_add_card
    {α : Type*} (s : Finset α)
    (numerator denominator weight : α → ℝ) (κ error : ℝ)
    (hpoint : ∀ x ∈ s,
      weight x ≤ κ * (numerator x / denominator x) + error) :
    packetMass s weight ≤
      κ * fareyEnergy s numerator denominator + (s.card : ℝ) * error := by
  unfold packetMass fareyEnergy
  calc
    (∑ x ∈ s, weight x) ≤
        ∑ x ∈ s, (κ * (numerator x / denominator x) + error) := by
      exact Finset.sum_le_sum hpoint
    _ = κ * (∑ x ∈ s, numerator x / denominator x) +
          (s.card : ℝ) * error := by
      rw [Finset.sum_add_distrib, Finset.mul_sum]
      simp

#print axioms indexMultiplier_real_eq_fareySlope
#print axioms endpointSlope_eq_primeSubOne_div_index
#print axioms endpointFareyEnergy_eq_primeMoment_div_index
#print axioms packetMass_le_mul_fareyEnergy_add_card

/-! ## Exact order on prime-power lift layers -/

/-- Divisibility by a modulus is exactly the corresponding power-one
identity in `ZMod`, with no primality assumption on the modulus. -/
theorem zmod_two_pow_eq_one_iff_dvd_mersenne (n d : ℕ) :
    (2 : ZMod n) ^ d = 1 ↔ n ∣ 2 ^ d - 1 := by
  constructor
  · intro hpow
    have hzero : ((2 ^ d - 1 : ℕ) : ZMod n) = 0 := by
      rw [Nat.cast_sub (one_le_pow₀ (by norm_num))]
      simp only [Nat.cast_pow, Nat.cast_ofNat]
      simpa using (sub_eq_zero.mpr hpow)
    exact (CharP.cast_eq_zero_iff (ZMod n) n _).mp hzero
  · intro hdiv
    have hzero : ((2 ^ d - 1 : ℕ) : ZMod n) = 0 :=
      (CharP.cast_eq_zero_iff (ZMod n) n _).mpr hdiv
    have hcast : ((2 ^ d - 1 : ℕ) : ZMod n) =
        (2 : ZMod n) ^ d - 1 := by
      rw [Nat.cast_sub (one_le_pow₀ (by norm_num))]
      simp
    rw [hcast] at hzero
    exact sub_eq_zero.mp hzero

/-- Exact multiplicative order of two at the prime-power layer `p^j`. -/
noncomputable def mersennePrimePowerExactOrder (p j : ℕ) : ℕ :=
  orderOf (2 : ZMod (p ^ j))

/-- If an actual prime-power layer divides the exact-order Mersenne value,
the order remains equal to the base-prime exact order on that layer. -/
theorem mersennePrimePowerExactOrder_eq_of_layer
    {p d j : ℕ} (hp : p.Prime) (hj : 0 < j)
    (horder : mersenneExactOrder p = d)
    (hlayer : p ^ j ∣ 2 ^ d - 1) :
    mersennePrimePowerExactOrder p j = d := by
  have hpow : (2 : ZMod (p ^ j)) ^ d = 1 :=
    (zmod_two_pow_eq_one_iff_dvd_mersenne (p ^ j) d).2 hlayer
  have hordDvd : mersennePrimePowerExactOrder p j ∣ d := by
    unfold mersennePrimePowerExactOrder
    exact orderOf_dvd_of_pow_eq_one hpow
  have horderPow :
      (2 : ZMod (p ^ j)) ^ mersennePrimePowerExactOrder p j = 1 := by
    unfold mersennePrimePowerExactOrder
    exact pow_orderOf_eq_one _
  have hpjDvd :
      p ^ j ∣ 2 ^ mersennePrimePowerExactOrder p j - 1 :=
    (zmod_two_pow_eq_one_iff_dvd_mersenne
      (p ^ j) (mersennePrimePowerExactOrder p j)).1 horderPow
  have hpDvd : p ∣ 2 ^ mersennePrimePowerExactOrder p j - 1 :=
    (dvd_pow_self p hj.ne').trans hpjDvd
  have hbaseDvd : d ∣ mersennePrimePowerExactOrder p j := by
    rw [← horder]
    exact mersenneExactOrder_dvd_index hp hpDvd
  exact Nat.dvd_antisymm hordDvd hbaseDvd

/-- **Stable-lift criterion.**  At a positive layer over an exact-order
prime, order stability is equivalent to the layer index being at most the
canonical factorization depth. -/
theorem mersennePrimePowerExactOrder_eq_iff_layer_le_depth
    {p d j : ℕ} (hp : p.Prime) (hd : 0 < d) (hj : 0 < j)
    (horder : mersenneExactOrder p = d) :
    mersennePrimePowerExactOrder p j = d ↔
      j ≤ (2 ^ d - 1).factorization p := by
  have hne : 2 ^ d - 1 ≠ 0 := (mersenne_sub_one_pos hd).ne'
  constructor
  · intro hliftOrder
    have hpow : (2 : ZMod (p ^ j)) ^ d = 1 := by
      rw [← hliftOrder]
      unfold mersennePrimePowerExactOrder
      exact pow_orderOf_eq_one _
    have hdiv : p ^ j ∣ 2 ^ d - 1 :=
      (zmod_two_pow_eq_one_iff_dvd_mersenne (p ^ j) d).1 hpow
    exact (hp.pow_dvd_iff_le_factorization hne).1 hdiv
  · intro hjDepth
    have hdiv : p ^ j ∣ 2 ^ d - 1 :=
      (hp.pow_dvd_iff_le_factorization hne).2 hjDepth
    exact mersennePrimePowerExactOrder_eq_of_layer hp hj horder hdiv

#print axioms zmod_two_pow_eq_one_iff_dvd_mersenne
#print axioms mersennePrimePowerExactOrder_eq_of_layer
#print axioms mersennePrimePowerExactOrder_eq_iff_layer_le_depth

/-! ## Stable prime-power layer identities -/

/-- A prime-power layer is present precisely when its exponent is no larger
than the supplied factorization depth.  The preceding theorem proves that,
for an actual exact-order prime and a positive layer, these are exactly the
layers on which the order remains unchanged. -/
abbrev stableLiftLayerPresent (depth j : ℕ) : Prop := j ≤ depth

/-- The number of stable repeated layers `2, ..., w` is exactly `w - 1`. -/
theorem stableLiftLayer_count (w M : ℕ) (hw : w ≤ M) :
    (∑ j ∈ Finset.Icc 2 M,
      if stableLiftLayerPresent w j then (1 : ℕ) else 0) = w - 1 := by
  calc
    (∑ j ∈ Finset.Icc 2 M,
        if stableLiftLayerPresent w j then (1 : ℕ) else 0) =
        ((Finset.Icc 2 M).filter (fun j => j ≤ w)).card := by
      simp [stableLiftLayerPresent]
    _ = (Finset.Icc 2 w).card := by
      congr 1
      ext j
      simp only [Finset.mem_filter, Finset.mem_Icc]
      omega
    _ = w - 1 := by
      rw [Nat.card_Icc]
      omega

/-- Weighted version of the complete stable repeated-layer count. -/
theorem weighted_stableLiftLayer_sum
    (w M : ℕ) (a : ℝ) (hw : w ≤ M) :
    (∑ j ∈ Finset.Icc 2 M,
      if stableLiftLayerPresent w j then a else 0) =
      ((w - 1 : ℕ) : ℝ) * a := by
  calc
    (∑ j ∈ Finset.Icc 2 M,
        if stableLiftLayerPresent w j then a else 0) =
        ∑ j ∈ Finset.Icc 2 M,
          (if stableLiftLayerPresent w j then (1 : ℝ) else 0) * a := by
      apply Finset.sum_congr rfl
      intro j _hj
      split_ifs <;> simp_all
    _ = (∑ j ∈ Finset.Icc 2 M,
          if stableLiftLayerPresent w j then (1 : ℝ) else 0) * a := by
      rw [Finset.sum_mul]
    _ = ((w - 1 : ℕ) : ℝ) * a := by
      congr 1
      exact_mod_cast stableLiftLayer_count w M hw

/-- For a repeated prime, all stable layers split exactly into layer two and
the genuinely deep layers `3, ..., w`. -/
theorem weighted_stableLiftLayer_eq_second_add_deep
    (w M : ℕ) (a : ℝ) (hw : w ≤ M) (hrepeated : 2 ≤ w) :
    (∑ j ∈ Finset.Icc 2 M,
      if stableLiftLayerPresent w j then a else 0) =
      a + ((w - 2 : ℕ) : ℝ) * a := by
  rw [weighted_stableLiftLayer_sum w M a hw]
  have hcount : w - 1 = 1 + (w - 2) := by omega
  rw [hcount, Nat.cast_add]
  norm_num
  ring

/-- One selected copy of every repeated row satisfying `select`. -/
def selectedSecondLayerMass {α : Type*} (s : Finset α)
    (depth : α → ℕ) (weight : α → ℝ) (select : α → Bool) : ℝ :=
  depthSupportMass
    (s.filter (fun x => select x && decide (2 ≤ depth x))) weight

/-- Deep stable layers `3, ..., M` satisfying `select`. -/
def selectedHigherStableLayerMass {α : Type*} (s : Finset α)
    (depth : α → ℕ) (weight : α → ℝ) (select : α → Bool)
    (M : ℕ) : ℝ :=
  ∑ j ∈ Finset.Icc 3 M,
    depthLayerMass (s.filter fun x => select x) depth weight j

/-- The selected deep stable layers are exactly the selected depth excess. -/
theorem selectedHigherStableLayerMass_eq_depthExcessMass
    {α : Type*} (s : Finset α) (depth : α → ℕ)
    (weight : α → ℝ) (select : α → Bool) (M : ℕ)
    (hdepth : ∀ x ∈ s, depth x ≤ M) :
    selectedHigherStableLayerMass s depth weight select M =
      depthExcessMass (s.filter fun x => select x) depth weight := by
  apply Eq.symm
  apply depthExcessMass_eq_sum_layers
  intro x hx
  exact hdepth x (Finset.mem_filter.mp hx).1

/-- The finite critical packet: selected second layers plus independently
selected higher layers. -/
def criticalStableLayerMass {α : Type*} (s : Finset α)
    (depth : α → ℕ) (weight : α → ℝ)
    (nearSquare highMultiplier : α → Bool) (M : ℕ) : ℝ :=
  selectedSecondLayerMass s depth weight nearSquare +
    selectedHigherStableLayerMass s depth weight highMultiplier M

/-- Exact two-arm identity for the critical stable-lift packet. -/
theorem criticalStableLayerMass_eq_twoArms
    {α : Type*} (s : Finset α) (depth : α → ℕ)
    (weight : α → ℝ) (nearSquare highMultiplier : α → Bool) (M : ℕ)
    (hdepth : ∀ x ∈ s, depth x ≤ M) :
    criticalStableLayerMass s depth weight nearSquare highMultiplier M =
      selectedSecondLayerMass s depth weight nearSquare +
        depthExcessMass (s.filter fun x => highMultiplier x) depth weight := by
  unfold criticalStableLayerMass
  rw [selectedHigherStableLayerMass_eq_depthExcessMass
    s depth weight highMultiplier M hdepth]

#print axioms stableLiftLayer_count
#print axioms weighted_stableLiftLayer_sum
#print axioms weighted_stableLiftLayer_eq_second_add_deep
#print axioms selectedHigherStableLayerMass_eq_depthExcessMass
#print axioms criticalStableLayerMass_eq_twoArms

/-! ## Finite endpoint ledger and exact boundary witnesses -/

/-- Once supplied endpoint estimates make both low arms smaller than the
available budget, a large total packet forces one of the two critical arms.
This is finite; the little-oh premises are not asserted in Lean. -/
theorem sigmaOne_highDeep_or_nearSquare
    {target lowOne lowDeep highDeep nearSquare share : ℝ}
    (htotal : target ≤ lowOne + lowDeep + highDeep + nearSquare)
    (hlow : lowOne + lowDeep ≤ target - 2 * share) :
    share ≤ highDeep ∨ share ≤ nearSquare := by
  exact criticalHigh_or_criticalNearSquare_of_enlarged_low_budgets
    (target := target) (oldLow := lowOne)
    (newlyRemovedDeep := lowDeep) (newlyRemovedOne := 0)
    (criticalHigh := highDeep) (criticalNear := nearSquare)
    (share := share) (by linarith) (by linarith)

/-- The actual prime `1093` has multiplier three and exactly one repeated
layer.  It is therefore an arithmetic warning that a near-square one-copy
carrier need not supply any genuinely deep mass. -/
theorem wieferich_1093_exactly_one_repeated_layer :
    Nat.Prime 1093 ∧
      mersenneExactOrder 1093 = 364 ∧
      (1093 - 1) / 364 = 3 ∧
      1093 ^ 2 ∣ 2 ^ 364 - 1 ∧
      ¬ 1093 ^ 3 ∣ 2 ^ 364 - 1 := by
  exact ⟨prime_1093, mersenneExactOrder_1093, by norm_num,
    wieferich_1093_sq_dvd_two_pow_364_sub_one,
    wieferich_1093_cube_not_dvd_two_pow_364_sub_one⟩

/-- The actual prime `3511` has multiplier two and exactly one repeated
layer.  It supplies the analogous even-multiplier boundary witness. -/
theorem wieferich_3511_exactly_one_repeated_layer :
    Nat.Prime 3511 ∧
      mersenneExactOrder 3511 = 1755 ∧
      (3511 - 1) / 1755 = 2 ∧
      3511 ^ 2 ∣ 2 ^ 1755 - 1 ∧
      ¬ 3511 ^ 3 ∣ 2 ^ 1755 - 1 := by
  exact ⟨prime_3511, mersenneExactOrder_3511, by norm_num,
    wieferich_3511_sq_dvd_two_pow_1755_sub_one,
    wieferich_3511_cube_not_dvd_two_pow_1755_sub_one⟩

#print axioms sigmaOne_highDeep_or_nearSquare
#print axioms wieferich_1093_exactly_one_repeated_layer
#print axioms wieferich_3511_exactly_one_repeated_layer

end MersenneSigmaOneExactOrderCoupling20260902
end IUTThreeClosures
