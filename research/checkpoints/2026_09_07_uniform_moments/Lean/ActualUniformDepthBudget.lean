import PrivateValuationMultisets
import UniformMomentArithmetic
import Mathlib.Algebra.BigOperators.Group.Finset.Piecewise

/-! Complete finite prime-depth sums on actual root-index subtypes.
Arithmetic private valuations, modular rigidity and finite target sizes are explicit. -/
set_option autoImplicit false
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCActualUniformDepth20260907
open ABCPrivateValuationMultisets20260907 ABCUniformMoment20260907
open scoped BigOperators

variable {I G H : Type*} [Fintype I] [DecidableEq I] [CommMonoid G]

abbrev DeepIndex (e : I → Nat) (h : Nat) := {i : I // h ≤ e i}

theorem restricted_private_symmetric_count [CommMonoid H] [Fintype H]
    (e : I → Nat) (a : I → G) (v : I → G →* Multiplicative Int)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0) (h nu n : Nat)
    (phi : DeepIndex e h → H)
    (hrigid : ∀ s t : Sym (DeepIndex e h) nu,
      actualProduct phi s.val = actualProduct phi t.val →
      actualProduct (fun i : DeepIndex e h ↦ a i.val) s.val =
        actualProduct (fun i : DeepIndex e h ↦ a i.val) t.val)
    (hcard : Fintype.card H ≤ 3 * n) :
    (Fintype.card (DeepIndex e h) + nu - 1).choose nu ≤ 3 * n := by
  apply actual_symmetric_three_n_bound (fun i : DeepIndex e h ↦ a i.val) phi
    (fun i : DeepIndex e h ↦ v i.val) ?_ ?_ nu n hrigid hcard
  · intro i j hji
    apply hoff i.val j.val
    intro heq
    exact hji (Subtype.ext heq)
  · intro i
    exact hdiag i.val

theorem square_bound_from_pair_multisets (M n : Nat)
    (h : (M + 1).choose 2 ≤ 3 * n) : M ^ 2 ≤ 6 * n := by
  have hc := Nat.add_one_mul_choose_eq M 1
  simp only [Nat.choose_one_right] at hc
  nlinarith

omit [DecidableEq I] in
theorem sum_indicator_eq_deep_card (e : I → Nat) (h : Nat) :
    (∑ i : I, if h ≤ e i then 1 else 0) = Fintype.card (DeepIndex e h) := by
  classical
  simp [DeepIndex, Fintype.card_subtype]

omit [DecidableEq I] in
theorem actual_finite_index_excess (e : I → Nat) (r cap n : Nat)
    (hrlow : 4 ≤ 2 * r) (hrhigh : r ^ 2 ≤ 4 * n)
    (hcap : ∀ i, e i ≤ cap)
    (hlow : (Fintype.card (DeepIndex e 4)) ^ 2 ≤ 6 * n)
    (hhigh : Fintype.card (DeepIndex e (2 * r)) ≤ 3) :
    (∑ i : I, (e i - 3)) ≤ 10 * n + 3 * cap := by
  have hp : ∀ i : I, e i - 3 ≤
      (2 * r) * (if 4 ≤ e i then 1 else 0) + cap * (if 2 * r ≤ e i then 1 else 0) := by
    intro i
    exact pointwise_complete_excess (e i) (2 * r) cap hrlow (hcap i)
  have hs := Finset.sum_le_sum (s := Finset.univ) (fun i _ ↦ hp i)
  simp only [Finset.sum_add_distrib, ← Finset.mul_sum, sum_indicator_eq_deep_card] at hs
  have hl := low_layer_count_bound n r (Fintype.card (DeepIndex e 4)) hrhigh hlow
  have hh := Nat.mul_le_mul_left cap hhigh
  simpa only [Nat.mul_comm cap 3] using hs.trans (Nat.add_le_add hl hh)

omit [DecidableEq I] in
theorem actual_finite_index_excess_from_multisets (e : I → Nat) (cap n : Nat)
    (hn : 324 < n) (hcap : ∀ i, e i ≤ cap)
    (hpair : (Fintype.card (DeepIndex e 4) + 1).choose 2 ≤ 3 * n)
    (hhigh : (Fintype.card (DeepIndex e (2 * (Nat.sqrt n + 1))) + Nat.sqrt n).choose
      (Nat.sqrt n + 1) ≤ 3 * n) :
    (∑ i : I, (e i - 3)) ≤ 10 * n + 3 * cap := by
  have hr := explicit_root_threshold n (by omega)
  have hs := Nat.sqrt_pos.mpr (show 0 < n by omega)
  exact actual_finite_index_excess e (Nat.sqrt n + 1) cap n (by omega) hr.2 hcap
    (square_bound_from_pair_multisets _ n hpair)
    (count_le_three_at_explicit_threshold _ n hn hhigh)

section PrivateDepthBudget
variable {Hlo Hhi : Type*} [CommMonoid Hlo] [Fintype Hlo]
  [CommMonoid Hhi] [Fintype Hhi]
  (e : I → Nat) (a : I → G) (v : I → G →* Multiplicative Int)
  (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
  (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0)
  (cap n : Nat) (hn : 324 < n) (hcap : ∀ i, e i ≤ cap)
  (phiLo : DeepIndex e 4 → Hlo)
  (phiHi : DeepIndex e (2 * (Nat.sqrt n + 1)) → Hhi)
  (hrigidLo : ∀ s t : Sym (DeepIndex e 4) 2,
    actualProduct phiLo s.val = actualProduct phiLo t.val →
    actualProduct (fun i : DeepIndex e 4 ↦ a i.val) s.val =
      actualProduct (fun i : DeepIndex e 4 ↦ a i.val) t.val)
  (hrigidHi : ∀ s t : Sym (DeepIndex e (2 * (Nat.sqrt n + 1))) (Nat.sqrt n + 1),
    actualProduct phiHi s.val = actualProduct phiHi t.val →
    actualProduct (fun i : DeepIndex e (2 * (Nat.sqrt n + 1)) ↦ a i.val) s.val =
      actualProduct (fun i : DeepIndex e (2 * (Nat.sqrt n + 1)) ↦ a i.val) t.val)
  (hcardLo : Fintype.card Hlo ≤ 3 * n) (hcardHi : Fintype.card Hhi ≤ 3 * n)

include hoff hdiag hn hcap hrigidLo hrigidHi hcardLo hcardHi

theorem actual_private_depth_budget :
    (∑ i : I, (e i - 3)) ≤ 10 * n + 3 * cap := by
  have hlo := restricted_private_symmetric_count e a v hoff hdiag 4 2 n
    phiLo hrigidLo hcardLo
  have hhi := restricted_private_symmetric_count e a v hoff hdiag
    (2 * (Nat.sqrt n + 1)) (Nat.sqrt n + 1) n phiHi hrigidHi hcardHi
  have heqLo : Fintype.card (DeepIndex e 4) + 2 - 1 =
      Fintype.card (DeepIndex e 4) + 1 := by omega
  have heqHi : Fintype.card (DeepIndex e (2 * (Nat.sqrt n + 1))) +
      (Nat.sqrt n + 1) - 1 =
      Fintype.card (DeepIndex e (2 * (Nat.sqrt n + 1))) + Nat.sqrt n := by omega
  rw [heqLo] at hlo
  rw [heqHi] at hhi
  exact actual_finite_index_excess_from_multisets e cap n hn hcap hlo hhi

theorem actual_private_weighted_depth_budget (w L : Real) (hw : 0 ≤ w)
    (hheight : (cap : Real) * w ≤ 3 * n * L) :
    (((∑ i : I, (e i - 3 : Nat)) : Nat) : Real) * w ≤ 10 * n * w + 9 * n * L := by
  have hf := actual_private_depth_budget e a v hoff hdiag cap n hn hcap
    phiLo phiHi hrigidLo hrigidHi hcardLo hcardHi
  have hfr : (((∑ i : I, (e i - 3 : Nat)) : Nat) : Real) ≤ 10 * n + 3 * cap := by
    exact_mod_cast hf
  have hm := mul_le_mul_of_nonneg_right hfr hw
  nlinarith

theorem actual_private_normalized_depth_budget (w L B s : Real)
    (hw : 0 ≤ w) (hheight : (cap : Real) * w ≤ 3 * n * L)
    (hB : 0 < B) (hs : 0 < s) (hwupper : w ≤ 2 * s) (hL : L ≤ 2 * s) :
    ((((∑ i : I, (e i - 3 : Nat)) : Nat) : Real) * w) / (B * n * s) ≤ 38 / B := by
  have hf := actual_private_weighted_depth_budget e a v hoff hdiag cap n hn hcap
    phiLo phiHi hrigidLo hrigidHi hcardLo hcardHi w L hw hheight
  have hnpos : (0 : Real) < n := by exact_mod_cast (show 0 < n by omega)
  exact normalized_prime_budget _ B n w L s hB hnpos hs hf hwupper hL
end PrivateDepthBudget

#print axioms restricted_private_symmetric_count
#print axioms square_bound_from_pair_multisets
#print axioms sum_indicator_eq_deep_card
#print axioms actual_finite_index_excess
#print axioms actual_finite_index_excess_from_multisets
#print axioms actual_private_depth_budget
#print axioms actual_private_weighted_depth_budget
#print axioms actual_private_normalized_depth_budget
end ABCActualUniformDepth20260907
