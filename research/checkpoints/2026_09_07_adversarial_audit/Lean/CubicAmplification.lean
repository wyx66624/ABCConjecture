import PowerDescent

/-!
Author: ChatGPT, September 7, 2026.

Scoped formalization of the cubic-amplification ordinary proof. This file proves
unbounded normalized polynomial-root certificates, a compression implication
conditional on the explicit radical inequality, and the exponent-cleared defect
amplification. The actual radical function and its factorization inequality are
ordinary mathematics in the companion paper, not supplied by this Std module.
No ABC statement or unproved asymptotic estimate is assumed.
-/

set_option autoImplicit false
set_option maxRecDepth 10000

namespace ABCCubicAmplification20260907

open ABCPowerDescent20260905

/-- The cubic cofactor is bounded by three times the square of its base. -/
theorem phi_le_three_square (x : Nat) (hx : 2 ≤ x) : phi x ≤ 3 * x ^ 2 := by
  unfold phi
  simp only [Nat.pow_succ, Nat.pow_zero, Nat.one_mul]
  have hs : x ≤ x * x := by
    have h := Nat.mul_le_mul_right x (show 1 ≤ x by omega)
    simpa using h
  omega

/-- The cubic cofactor is increasing on the nonnegative integers. -/
theorem phi_mono (x y : Nat) (hxy : x ≤ y) : phi x ≤ phi y := by
  unfold phi
  have hs := Nat.mul_le_mul hxy hxy
  omega

/-- An elementary growth certificate suffices; no analytic limit is imported. -/
theorem seven_power_exceeds_index (k : Nat) : k < 7 ^ (k + 2) := by
  induction k with
  | zero => decide
  | succ k ih =>
    rw [show k + 1 + 2 = (k + 2) + 1 by omega, Nat.pow_succ]
    omega

/-- A concrete index, obtained from the desired bound, produces a larger root. -/
theorem small_root_exceeds (M : Nat) : M < smallRoot (phi M) := by
  have hs := small_root_size (phi M)
  by_cases h : M < smallRoot (phi M)
  · exact h
  have hle : smallRoot (phi M) ≤ M := by omega
  have hp := phi_mono (smallRoot (phi M)) M hle
  have hg := seven_power_exceeds_index (phi M)
  omega

/-- The prior explicit roots escape every height bound while remaining normalized. -/
theorem unbounded_normalized_roots (M : Nat) :
    ∃ k x : Nat, M < x ∧ 2 ≤ x ∧ x < 28 * 7 ^ (k + 1) ∧
      x % 4 = 2 ∧ x % 7 = 2 ∧ 7 ^ (k + 2) ∣ phi x ∧
      (∀ y e : Nat, 2 ≤ e → x ≠ y ^ e) := by
  let k := phi M
  let x := smallRoot k
  have hs := small_root_size k
  have hr := small_root_residues k
  have hMx : M < x := small_root_exceeds M
  exact ⟨k, x, hMx, hs.1, hs.2.1, hr.1, hr.2, small_root_divisibility k,
    fun y e he ↦ mod_four_not_power x hr.1 y e he⟩

/-- Arithmetic radical compression implies the numerical bound used in the paper. -/
theorem compression_bound (x R1 R3 B : Nat) (hx : 2 ≤ x) (hR1 : 0 < R1)
    (hsize : x < 28 * B) (hcompression : B * R3 ≤ R1 * phi x) :
    R3 < 84 * x * R1 := by
  have hcap := phi_le_three_square x hx
  have hb : B * R3 ≤ R1 * (3 * x ^ 2) :=
    Nat.le_trans hcompression (Nat.mul_le_mul_left R1 hcap)
  have hpos : 0 < 3 * x * R1 := by
    exact Nat.mul_pos (Nat.mul_pos (by decide) (by omega)) hR1
  have ht := Nat.mul_lt_mul_of_pos_right hsize hpos
  have he1 : x * (3 * x * R1) = R1 * (3 * x ^ 2) := by grind
  have he2 : (28 * B) * (3 * x * R1) = B * (84 * x * R1) := by grind
  rw [he1, he2] at ht
  exact Nat.lt_of_mul_lt_mul_left (Nat.lt_of_le_of_lt hb ht)

/-- The cross-multiplied lower bound for the quotient of two cleared defects. -/
theorem cleared_amplification (m x R1 R3 : Nat) (hm : 1 ≤ m) (hx : 0 < x)
    (hcompression : R3 < 84 * x * R1) :
    R3 ^ (m + 1) * x ^ (m - 1) <
      84 ^ (m + 1) * x ^ (2 * m) * R1 ^ (m + 1) := by
  have hp : R3 ^ (m + 1) < (84 * x * R1) ^ (m + 1) :=
    Nat.pow_lt_pow_left hcompression (by omega)
  have hxpow : 0 < x ^ (m - 1) := Nat.pow_pos hx
  have ht := Nat.mul_lt_mul_of_pos_right hp hxpow
  have he : (84 * x * R1) ^ (m + 1) * x ^ (m - 1) =
      84 ^ (m + 1) * x ^ (2 * m) * R1 ^ (m + 1) := by
    rw [Nat.mul_pow, Nat.mul_pow]
    have hexp : x ^ (m + 1) * x ^ (m - 1) = x ^ (2 * m) := by
      rw [← Nat.pow_add, show (m + 1) + (m - 1) = 2 * m by omega]
    calc
      (84 ^ (m + 1) * x ^ (m + 1) * R1 ^ (m + 1)) * x ^ (m - 1) =
          84 ^ (m + 1) * (x ^ (m + 1) * x ^ (m - 1)) * R1 ^ (m + 1) := by
        grind
      _ = _ := by rw [hexp]
  exact he ▸ ht

/-- The compression premise at every prior root yields the amplification certificate. -/
theorem root_cleared_amplification (k m R1 R3 : Nat) (hm : 1 ≤ m) (hR1 : 0 < R1)
    (hcompression : 7 ^ (k + 1) * R3 ≤ R1 * phi (smallRoot k)) :
    R3 ^ (m + 1) * smallRoot k ^ (m - 1) <
      84 ^ (m + 1) * smallRoot k ^ (2 * m) * R1 ^ (m + 1) := by
  have hs := small_root_size k
  have hc := compression_bound (smallRoot k) R1 R3 (7 ^ (k + 1))
    hs.1 hR1 hs.2.1 hcompression
  exact cleared_amplification m (smallRoot k) R1 R3 hm (by omega) hc

/-- No uniform cleared-defect comparison can coexist with the root compression premises. -/
theorem no_uniform_relative_bound (m : Nat) (hm : 2 ≤ m) (R1 R3 : Nat → Nat)
    (hR1 : ∀ k, 0 < R1 k) (hR3 : ∀ k, 0 < R3 k)
    (hcompression : ∀ k, 7 ^ (k + 1) * R3 k ≤ R1 k * phi (smallRoot k)) :
    ¬ ∃ A : Nat, ∀ k, smallRoot k ^ (2 * m) * R1 k ^ (m + 1) ≤
      A * R3 k ^ (m + 1) := by
  intro ⟨A, hA⟩
  let K := 84 ^ (m + 1)
  let k := phi (K * A)
  let x := smallRoot k
  have hx : 0 < x := by have hs := small_root_size k; change 0 < smallRoot k; omega
  have hlarge : K * A < x := small_root_exceeds (K * A)
  have hxp : x ≤ x ^ (m - 1) := by
    have hexp : m - 1 = (m - 2) + 1 := by omega
    rw [hexp, Nat.pow_succ]
    have hp : 1 ≤ x ^ (m - 2) := by have := Nat.pow_pos hx (n := m - 2); omega
    have hh := Nat.mul_le_mul_right x hp
    simpa using hh
  have hleft := Nat.mul_lt_mul_of_pos_right (Nat.lt_of_lt_of_le hlarge hxp)
    (Nat.pow_pos (hR3 k) (n := m + 1))
  have hamp := root_cleared_amplification k m (R1 k) (R3 k) (by omega)
    (hR1 k) (hcompression k)
  have hstrict : K * (A * R3 k ^ (m + 1)) <
      K * (x ^ (2 * m) * R1 k ^ (m + 1)) := by
    calc
      K * (A * R3 k ^ (m + 1)) = (K * A) * R3 k ^ (m + 1) := by grind
      _ < x ^ (m - 1) * R3 k ^ (m + 1) := hleft
      _ = R3 k ^ (m + 1) * x ^ (m - 1) := Nat.mul_comm _ _
      _ < K * (x ^ (2 * m) * R1 k ^ (m + 1)) := by
        simpa only [K, x, Nat.mul_assoc] using hamp
  have hbound := Nat.mul_le_mul_left K (hA k)
  change K * (x ^ (2 * m) * R1 k ^ (m + 1)) ≤ K * (A * R3 k ^ (m + 1)) at hbound
  omega

#print axioms phi_le_three_square
#print axioms phi_mono
#print axioms seven_power_exceeds_index
#print axioms small_root_exceeds
#print axioms unbounded_normalized_roots
#print axioms compression_bound
#print axioms cleared_amplification
#print axioms root_cleared_amplification
#print axioms no_uniform_relative_bound

end ABCCubicAmplification20260907
