import DeepRootPhaseArithmetic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Analysis.Real.Sqrt
import Mathlib.Data.Finset.Lattice.Fold

/-! Actual finite root counting from the proved integer phase fiber.
The same-image modular divisibility and finite target size are explicit.
The ordinary finite-ring construction, lifting and sieve remain separate. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCActualDeepRootCount20260907
open ABCDeepRootPhase20260907
open scoped BigOperators

def divisorEnvelope (N : Nat) : Nat :=
  (Finset.range (N + 1)).sup fun k ↦ k.divisors.card

theorem divisor_count_le_envelope (N K : Nat) (hK : K ≤ N) :
    K.divisors.card ≤ divisorEnvelope N := by
  unfold divisorEnvelope
  exact Finset.le_sup (s := Finset.range (N + 1)) (f := fun k : Nat ↦ k.divisors.card)
    (b := K) (Finset.mem_range.mpr (by omega))

theorem actual_pair_image_fiber_bound {H : Type*} [Mul H] [DecidableEq H]
    (S : Finset Int) (phi : Int → H) (B m : Int) (hB : 0 < B)
    (hblock : ∀ a ∈ S, 3 * B ≤ a ∧ a < 6 * B) (hm : 864 * B ^ 3 < m)
    (hdiv : ∀ a ∈ S, ∀ b ∈ S, ∀ c ∈ S, ∀ d ∈ S,
      phi a * phi b = phi c * phi d → m ∣ phaseDet a b c d) (y : H) :
    ((S.product S).filter fun p ↦ phi p.1 * phi p.2 = y).card ≤
      divisorEnvelope (2500 * B.natAbs ^ 4) := by
  classical
  let T := (S.product S).filter fun p ↦ phi p.1 * phi p.2 = y
  change T.card ≤ _
  by_cases hne : T.Nonempty
  · obtain ⟨⟨a, b⟩, hab⟩ := hne
    obtain ⟨hpair, himage⟩ := Finset.mem_filter.mp hab
    obtain ⟨haS, hbS⟩ := Finset.mem_product.mp hpair
    have ha := hblock a haS
    have hb := hblock b hbS
    obtain ⟨hu, huB, hv, hvB⟩ := actual_pair_height_bounds B a b hB ha.1 ha.2 hb.1 hb.2
    have hfiber : T.card ≤ (phaseConstant (phaseReal a b) (phaseImag a b)).natAbs.divisors.card := by
      apply phase_fiber_card_le_divisors T _ _ hu hv
      intro p hp
      rcases p with ⟨c, d⟩
      obtain ⟨hcd, hci⟩ := Finset.mem_filter.mp hp
      obtain ⟨hcS, hdS⟩ := Finset.mem_product.mp hcd
      have hc := hblock c hcS
      have hd := hblock d hdS
      have hphase := actual_large_modulus_phase_rigidity B c d a b m hB
        hc.1 hc.2 hd.1 hd.2 ha.1 ha.2 hb.1 hb.2 hm
        (hdiv c hcS d hdS a haS b hbS (hci.trans himage.symm))
      refine ⟨by omega, by omega, ?_⟩
      change phaseImag a b * phaseReal c d = phaseReal a b * phaseImag c d
      exact (mul_comm _ _).trans hphase
    have hK := reduced_phase_constant_bound B _ _ hB hu hv huB hvB
    have hKpos := phase_constant_positive _ _ hu hv
    have hKN : (phaseConstant (phaseReal a b) (phaseImag a b)).natAbs ≤
        2500 * B.natAbs ^ 4 := by
      have hKi : ((phaseConstant (phaseReal a b) (phaseImag a b)).natAbs : Int) ≤
          2500 * (B.natAbs : Int) ^ 4 := by
        simpa only [Int.natCast_natAbs, abs_of_pos hKpos, abs_of_pos hB] using hK
      exact_mod_cast hKi
    exact hfiber.trans (divisor_count_le_envelope _ _ hKN)
  · rw [Finset.not_nonempty_iff_eq_empty.mp hne]
    simp

theorem actual_root_count_square_bound {H : Type*} [Mul H] [Fintype H] [DecidableEq H]
    (S : Finset Int) (phi : Int → H) (B m : Int) (n : Nat) (hB : 0 < B)
    (hblock : ∀ a ∈ S, 3 * B ≤ a ∧ a < 6 * B) (hm : 864 * B ^ 3 < m)
    (hcard : Fintype.card H ≤ 3 * n)
    (hdiv : ∀ a ∈ S, ∀ b ∈ S, ∀ c ∈ S, ∀ d ∈ S,
      phi a * phi b = phi c * phi d → m ∣ phaseDet a b c d) :
    S.card ^ 2 ≤ 3 * n * divisorEnvelope (2500 * B.natAbs ^ 4) := by
  classical
  calc
    S.card ^ 2 = (S.product S).card := by simp [pow_two]
    _ = ∑ y : H, ((S.product S).filter fun p ↦ phi p.1 * phi p.2 = y).card := by
      apply Finset.card_eq_sum_card_fiberwise
      intro p hp
      exact Finset.mem_univ _
    _ ≤ ∑ _y : H, divisorEnvelope (2500 * B.natAbs ^ 4) := by
      apply Finset.sum_le_sum
      intro y hy
      exact actual_pair_image_fiber_bound S phi B m hB hblock hm hdiv y
    _ = Fintype.card H * divisorEnvelope (2500 * B.natAbs ^ 4) := by simp
    _ ≤ 3 * n * divisorEnvelope (2500 * B.natAbs ^ 4) :=
      Nat.mul_le_mul_right _ hcard

theorem fourth_power_exceeds_block_determinant (n q : Nat) (hn : 0 < n)
    (hq : 6 * n ^ 3 < q) : (864 : Int) * ((n : Int) ^ 4) ^ 3 < (q : Int) ^ 4 := by
  have hnI : (0 : Int) < n := by exact_mod_cast hn
  have hqI : (6 : Int) * (n : Int) ^ 3 < q := by exact_mod_cast hq
  have hp : ((6 : Int) * (n : Int) ^ 3) ^ 4 < (q : Int) ^ 4 :=
    pow_lt_pow_left₀ hqI (by positivity) (by decide)
  have hn12 : (0 : Int) < (n : Int) ^ 12 := pow_pos hnI _
  calc
    (864 : Int) * ((n : Int) ^ 4) ^ 3 < 1296 * (n : Int) ^ 12 := by
      nlinarith [hn12]
    _ = ((6 : Int) * (n : Int) ^ 3) ^ 4 := by ring
    _ < (q : Int) ^ 4 := hp

theorem actual_fourth_depth_count {H : Type*} [Mul H] [Fintype H] [DecidableEq H]
    (S : Finset Int) (phi : Int → H) (n q : Nat) (hn : 0 < n)
    (hblock : ∀ a ∈ S, 3 * (n : Int) ^ 4 ≤ a ∧ a < 6 * (n : Int) ^ 4)
    (hq : 6 * n ^ 3 < q) (hcard : Fintype.card H ≤ 3 * n)
    (hdiv : ∀ a ∈ S, ∀ b ∈ S, ∀ c ∈ S, ∀ d ∈ S,
      phi a * phi b = phi c * phi d → (q : Int) ^ 4 ∣ phaseDet a b c d) :
    S.card ^ 2 ≤ 3 * n * divisorEnvelope (2500 * n ^ 16) := by
  have hb : (0 : Int) < (n : Int) ^ 4 := by positivity
  have h := actual_root_count_square_bound S phi ((n : Int) ^ 4) ((q : Int) ^ 4) n
    hb hblock (fourth_power_exceeds_block_determinant n q hn hq) hcard hdiv
  simpa only [Int.natAbs_pow, Int.natAbs_natCast, ← pow_mul] using h

theorem actual_fourth_depth_sqrt_bound {H : Type*} [Mul H] [Fintype H] [DecidableEq H]
    (S : Finset Int) (phi : Int → H) (n q : Nat) (hn : 0 < n)
    (hblock : ∀ a ∈ S, 3 * (n : Int) ^ 4 ≤ a ∧ a < 6 * (n : Int) ^ 4)
    (hq : 6 * n ^ 3 < q) (hcard : Fintype.card H ≤ 3 * n)
    (hdiv : ∀ a ∈ S, ∀ b ∈ S, ∀ c ∈ S, ∀ d ∈ S,
      phi a * phi b = phi c * phi d → (q : Int) ^ 4 ∣ phaseDet a b c d) :
    (S.card : Real) ≤ Real.sqrt (3 * (n : Real)) *
      Real.sqrt (divisorEnvelope (2500 * n ^ 16)) := by
  have h := actual_fourth_depth_count S phi n q hn hblock hq hcard hdiv
  have hr : (S.card : Real) ^ 2 ≤
      (3 * (n : Real)) * (divisorEnvelope (2500 * n ^ 16) : Real) := by exact_mod_cast h
  have hs := Real.le_sqrt_of_sq_le hr
  simpa only [Real.sqrt_mul (by positivity : (0 : Real) ≤ 3 * (n : Real))] using hs

#print axioms divisor_count_le_envelope
#print axioms actual_pair_image_fiber_bound
#print axioms actual_root_count_square_bound
#print axioms fourth_power_exceeds_block_determinant
#print axioms actual_fourth_depth_count
#print axioms actual_fourth_depth_sqrt_bound
end ABCActualDeepRootCount20260907
