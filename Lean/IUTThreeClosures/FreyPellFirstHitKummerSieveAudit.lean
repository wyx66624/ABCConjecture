import Mathlib

/-!
# Scalar audit of Pell first-hit Kummer and sieve data

This module checks the elementary identities and inequalities used in
`FREY_PELL_FIRST_HIT_KUMMER_SIEVE_AUDIT.md`:

* the fixed eighth-power and square-target identities;
* the strengthened residual-order size squeeze;
* the truncated-depth synchronization and super-square split;
* the exceptional small-representative geometry of a lifted Hensel class;
* a finite computation showing an actual depth-three hit in the fixed Pell
  recurrence at `p = 23`, `n = 1552`.

The last computation is explicitly **not** a first-hit example: its residual
order is `11`.  The module does not formalize or assume local fields,
cyclotomic resultants, Chebotarev, a large sieve, prime splitting, or any
bound for the Pell super-square tail.
-/

namespace IUTThreeClosures

/-! ## Fixed power structure -/

/-- The elementary identities behind
`lambda = ((sqrt 6 + sqrt 2) / 2)^8` and the two square targets, written in
a real algebraic form. -/
theorem pellFirstHit_fixedPowerIdentities
    (x y : ℝ) (hx : x ^ 2 = 2) (hy : y ^ 2 = 3) :
    ((x * y + x) / 2) ^ 8 = 97 + 56 * y ∧
      (y + x) ^ 2 = 5 + 2 * (x * y) ∧
      (1 + x) ^ 2 = 3 + 2 * x := by
  have hxy : (x * y + x) ^ 2 = 4 * (2 + y) := by
    calc
      (x * y + x) ^ 2 = x ^ 2 * (y + 1) ^ 2 := by ring
      _ = 2 * (y + 1) ^ 2 := by rw [hx]
      _ = 4 * (2 + y) := by nlinarith [hy]
  have htwoPlusY : (2 + y) ^ 2 = 7 + 4 * y := by
    nlinarith [hy]
  constructor
  · calc
      ((x * y + x) / 2) ^ 8 = ((x * y + x) ^ 2 / 4) ^ 4 := by ring
      _ = (2 + y) ^ 4 := by rw [hxy]; ring
      _ = ((2 + y) ^ 2) ^ 2 := by ring
      _ = (7 + 4 * y) ^ 2 := by rw [htwoPlusY]
      _ = 97 + 56 * y := by nlinarith [hy]
  · constructor
    · rw [show (y + x) ^ 2 = y ^ 2 + 2 * (x * y) + x ^ 2 by ring,
        hx, hy]
      ring
    · rw [show (1 + x) ^ 2 = 1 + 2 * x + x ^ 2 by ring, hx]
      ring

/-! ## Residual-order and depth geometry -/

/-- In the split class `p = 1 (mod 24)`, the eighth-power presentation gives
`8 * t ≤ p - 1`.  A first hit `t > 2 * n` therefore gives the stronger
linear restriction `p - 1 > 16 * n`. -/
theorem pellFirstHit_orderSqueeze_modTwentyFourOne
    (n t p : ℕ) (hfirst : 2 * n < t) (horder : 8 * t ≤ p - 1) :
    16 * n < p - 1 := by
  omega

/-- In the split class `p = 23 (mod 24)`, the eighth-power presentation gives
`2 * t ≤ p - 1`, hence `p - 1 > 4 * n` at a first hit. -/
theorem pellFirstHit_orderSqueeze_modTwentyFourTwentyThree
    (n t p : ℕ) (hfirst : 2 * n < t) (horder : 2 * t ≤ p - 1) :
    4 * n < p - 1 := by
  omega

/-- Numerical form of order-lifting synchronization.  Equality of the
lifted `p`-power exponents is equivalent to equality of the corresponding
depths truncated at the tested level `e`.

In the number-theoretic application `v` is `v_p(n / gcd(n,t))`. -/
theorem pellFirstHit_truncatedDepth_sync_iff
    (e sourceDepth targetDepth v : ℕ) :
    e - targetDepth = e - (sourceDepth + v) ↔
      min e targetDepth = min e (sourceDepth + v) := by
  omega

/-- At a genuine first hit the support prime exceeds the index, so `v = 0`:
the source and target cyclotomic depths agree after truncation at `e`. -/
theorem pellFirstHit_truncatedDepth_sync
    (e sourceDepth targetDepth : ℕ)
    (hlift : e - targetDepth = e - sourceDepth) :
    min e targetDepth = min e sourceDepth := by
  omega

/-- Once `q` is the common depth truncated at `e`, copies after the second
split exactly into a common cyclotomic part and a residual lift-collision
part. -/
theorem pellFirstHit_superSquare_split
    (e q : ℕ) (hq : q ≤ e) :
    e - 2 = (q - 2) + (e - max q 2) := by
  omega

/-- Positive collision mass forces the untruncated source and target depths
to coincide at the common truncated depth. -/
theorem pellFirstHit_collision_forces_equalDepths
    (e sourceDepth targetDepth q : ℕ)
    (hsource : min e sourceDepth = q)
    (htarget : min e targetDepth = q)
    (hcollision : max q 2 < e) :
    sourceDepth = q ∧ targetDepth = q := by
  omega

/-! ## The least lifted representative -/

/-- For base depth one and target depth three, the lifted hit modulus is
`t * p^2`.  A first-hit representative `n < t/2` occupies less than the
`1/(2p^2)` fraction of that modulus, here stated without division. -/
theorem pellFirstHit_cubeClass_smallRepresentative
    (n t p q : ℕ) (hp : 0 < p) (hfirst : 2 * n < t)
    (hq : q = t * p ^ 2) :
    2 * p ^ 2 * n < q := by
  have hp2 : 0 < p ^ 2 := pow_pos hp 2
  calc
    2 * p ^ 2 * n = (2 * n) * p ^ 2 := by ring
    _ < t * p ^ 2 := (Nat.mul_lt_mul_right hp2).2 hfirst
    _ = q := hq.symm

/-- Two representatives below a modulus which are congruent modulo that
modulus are equal.  This is the scalar reason a first-hit lifted class meets
the interval `[0,n]` only at its endpoint. -/
theorem pellFirstHit_endpointClass_unique
    (m n q : ℕ) (hm : m ≤ n) (hnq : n < q)
    (hmod : m ≡ n [MOD q]) :
    m = n := by
  exact hmod.eq_of_lt_of_lt (lt_of_le_of_lt hm hnq) hnq

/-- Each endpoint error retains at least half of its nonnegative weight when
the main density term is at most one half. -/
theorem pellFirstHit_endpointRemainder_half
    (weight density : ℝ) (hweight : 0 ≤ weight)
    (hdensity : density ≤ 1 / 2) :
    weight / 2 ≤ weight * (1 - density) := by
  nlinarith

/-- Finite weighted form of the endpoint obstruction.  A sieve estimate
whose main term samples at most half of each lifted class leaves at least
half of the entire unknown weight in its endpoint remainders. -/
theorem pellFirstHit_finiteEndpointRemainder_half
    {I : Type*} (S : Finset I) (weight density : I → ℝ)
    (hweight : ∀ i ∈ S, 0 ≤ weight i)
    (hdensity : ∀ i ∈ S, density i ≤ 1 / 2) :
    (∑ i ∈ S, weight i) / 2 ≤
      ∑ i ∈ S, weight i * (1 - density i) := by
  rw [Finset.sum_div]
  apply Finset.sum_le_sum
  intro i hi
  exact pellFirstHit_endpointRemainder_half
    (weight i) (density i) (hweight i hi) (hdensity i hi)

/-! ## A finite fixed-Pell diagnostic, not a first hit -/

/-- The reduced Pell trace `s_n`, computed by a finite tail-recursive loop
from `s_0 = 1`, `s_1 = 7`, and `s_{n+2} = 14s_{n+1}-s_n`. -/
def pellFirstHit_traceResidue (modulus n : ℕ) : ℕ :=
  Id.run do
    let mut previous := 1 % modulus
    let mut current := 7 % modulus
    for _ in [0:n] do
      let next := (14 * current + modulus - previous) % modulus
      previous := current
      current := next
    return previous

/-- Exact reduced trace at the cube modulus. -/
theorem pellFirstHit_fixedPell_23_trace_mod_cube :
    pellFirstHit_traceResidue (23 ^ 3) 1552 = 6654 := by
  native_decide

/-- Exact reduced trace at the fourth-power modulus. -/
theorem pellFirstHit_fixedPell_23_trace_mod_fourth :
    pellFirstHit_traceResidue (23 ^ 4) 1552 = 140491 := by
  native_decide

/-- The fixed Pell sequence really has a depth-three shifted hit at
`p = 23`, `n = 1552`: `23^3` divides `s_n^2 - 3`. -/
theorem pellFirstHit_fixedPell_23_cube_at_1552 :
    (pellFirstHit_traceResidue (23 ^ 3) 1552) ^ 2 % (23 ^ 3) =
      3 % (23 ^ 3) := by
  rw [pellFirstHit_fixedPell_23_trace_mod_cube]
  norm_num

/-- The same value is not divisible by `23^4`, so its depth is exactly
three. -/
theorem pellFirstHit_fixedPell_23_not_fourthPower_at_1552 :
    (pellFirstHit_traceResidue (23 ^ 4) 1552) ^ 2 % (23 ^ 4) ≠
      3 % (23 ^ 4) := by
  rw [pellFirstHit_fixedPell_23_trace_mod_fourth]
  norm_num

/-- The exact nonzero fourth-power residue of the shifted trace. -/
theorem pellFirstHit_fixedPell_23_exactDepthResidue :
    (((pellFirstHit_traceResidue (23 ^ 4) 1552) ^ 2 + 23 ^ 4 - 3) %
        (23 ^ 4)) =
      (21 * 23 ^ 3) % (23 ^ 4) := by
  rw [pellFirstHit_fixedPell_23_trace_mod_fourth]
  norm_num

/-- This certified cube is outside the first-hit range because its residual
order is `11 ≤ 2 * 1552`.  It is used only to refute a blanket inference
from fixed units and simple roots to absence of deep shifted contact. -/
theorem pellFirstHit_fixedPell_23_diagnostic_isNotFirstHit :
    11 ≤ 2 * 1552 := by
  norm_num

/-- At the selected split embedding modulo `23`, the residue of `lambda` is
`6`, and its multiplicative order is exactly `11`. -/
theorem pellFirstHit_fixedPell_23_lambdaOrder :
    6 ^ 11 % 23 = 1 ∧
      ∀ k ∈ Finset.Icc 1 10, 6 ^ k % 23 ≠ 1 := by
  native_decide

end IUTThreeClosures
