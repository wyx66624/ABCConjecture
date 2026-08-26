import IUTThreeClosures.FreyPellRadicalRecurrenceBarrier
import Mathlib.RingTheory.UniqueFactorizationDomain.NormalizedFactors

/-!
# Scalar kernel for the Pell nonmaximal-order conductor audit

For a squarefree-kernel decomposition `c = A * f^2`, the companion note
places the already-identified fundamental unit in the quadratic order of
conductor `f`.  The accepted real-quadratic ring class number formula then
multiplies the field class number by a relative factor `q`; the order
class-number identity is just the field identity multiplied by the same
`q`.

This file verifies the elementary scalar content of that audit:

* the order-discriminant identity and the coordinatewise ray congruence;
* exact cancellation of the relative class factor;
* the sharp bounds comparing radical deficit with conductor height;
* a prime-power profile whose radical stays fixed while its multiplier
  grows; and
* an exact modular certificate showing `v_23 (pellRadicalC 1575) = 3`.

It does not formalize quadratic orders, unit groups, Bennett--Walsh, ring or
ray class groups, genus theory, analytic class-number formulas, or any
radical asymptotic.
-/

namespace IUTThreeClosures

/-! ## Elementary order coordinates -/

/-- If `c = A*f^2`, then the order of conductor `f` has the scalar
discriminant `4*A*f^2 = 4*c` in the congruence class used by the Pell
family. -/
theorem pellNonmaximalOrder_discriminant
    (A f c : ℤ) (hc : c = A * f ^ 2) :
    4 * A * f ^ 2 = 4 * c := by
  rw [hc]
  ring

/-- The two nonconstant coordinates of
`(A*f^2+1) + f*s*sqrt(A) - 1` are both divisible by `f`.  This is the
scalar shadow of the fundamental unit being `1` modulo `f * O_K`. -/
theorem pellNonmaximalOrder_unitRayCongruence
    (A f s : ℤ) :
    ∃ a b : ℤ,
      (A * f ^ 2 + 1) - 1 = f * a ∧
      f * s = f * b := by
  refine ⟨A * f, s, ?_, ?_⟩ <;> ring

/-! ## Exact cancellation of the ring class multiplier -/

/-- If the order class number is the field class number multiplied by a
nonzero relative factor `q`, then the order class-number identity is
equivalent to the field identity.  This is the precise scalar no-go behind
the ring class route. -/
theorem pellNonmaximalOrder_ringClassFormula_cancel
    (h hf R B q : ℝ) (hq : q ≠ 0) (hhf : hf = h * q) :
    hf * R = q * B ↔ h * R = B := by
  rw [hhf]
  constructor
  · intro horder
    apply mul_left_cancel₀ hq
    calc
      q * (h * R) = (h * q) * R := by ring
      _ = q * B := horder
  · intro hfield
    calc
      (h * q) * R = q * (h * R) := by ring
      _ = q * B := by rw [hfield]

/-! ## Radical deficit versus conductor height -/

/-- Write

`H = log A + 2 log f` and
`radHeight = log A + log(rad f) - log(gcd(A,f))`.

The elementary inequalities
`0 ≤ log(gcd(A,f)) ≤ log(rad f) ≤ log f` force the radical deficit
to lie between one and two copies of the conductor height. -/
theorem pellNonmaximalOrder_conductorDeficit_bounds
    (a u rho g H radHeight : ℝ)
    (hH : H = a + 2 * u)
    (hRad : radHeight = a + rho - g)
    (hg0 : 0 ≤ g) (hgrho : g ≤ rho) (hrhou : rho ≤ u) :
    u ≤ H - radHeight ∧ H - radHeight ≤ 2 * u := by
  constructor <;> linarith

/-- A sublinear conductor height is sufficient for a coefficient-one
radical estimate, with an explicit epsilon conversion. -/
theorem pellNonmaximalOrder_smallConductor_implies_radicalCoefficient
    (a u rho g H radHeight epsilon : ℝ)
    (hH : H = a + 2 * u)
    (hRad : radHeight = a + rho - g)
    (hg0 : 0 ≤ g) (hgrho : g ≤ rho) (hrhou : rho ≤ u)
    (hu : u ≤ epsilon * H) :
    (1 - 2 * epsilon) * H ≤ radHeight := by
  have hbounds := pellNonmaximalOrder_conductorDeficit_bounds
    a u rho g H radHeight hH hRad hg0 hgrho hrhou
  nlinarith [hbounds.2]

/-- Conversely, a coefficient-one radical deficit already bounds the
conductor height by the same epsilon.  Thus controlling `log f` is not a
dispensable technical strengthening: it is equivalent at leading order. -/
theorem pellNonmaximalOrder_radicalCoefficient_implies_smallConductor
    (a u rho g H radHeight epsilon : ℝ)
    (hH : H = a + 2 * u)
    (hRad : radHeight = a + rho - g)
    (hg0 : 0 ≤ g) (hgrho : g ≤ rho) (hrhou : rho ≤ u)
    (hRadical : (1 - epsilon) * H ≤ radHeight) :
    u ≤ epsilon * H := by
  have hbounds := pellNonmaximalOrder_conductorDeficit_bounds
    a u rho g H radHeight hH hRad hg0 hgrho hrhou
  nlinarith [hbounds.1]

/-! ## A fixed-radical local counterprofile -/

/-- Every positive power of the congruence-compatible prime `23` has
radical exactly `23`. -/
theorem pellNonmaximalOrder_radical_twentyThree_pow_succ (m : ℕ) :
    UniqueFactorizationMonoid.radical (23 ^ (m + 1)) = 23 := by
  simpa using
    (UniqueFactorizationMonoid.radical_pow_of_prime
      (Nat.prime_iff.mp (by norm_num : Nat.Prime 23))
      (show m + 1 ≠ 0 by omega))

/-- Prime-power conductor multipliers are unbounded while their radical
support remains the single allowed prime `23`.  In the paper this models
the ramified local factor `p^a` in the exact ring class formula; it is not a
claim that every such profile occurs on the Pell orbit. -/
theorem pellNonmaximalOrder_multiplier_unbounded_at_fixedRadical (B : ℕ) :
    ∃ q : ℕ,
      UniqueFactorizationMonoid.radical q = 23 ∧ B < q := by
  refine ⟨23 ^ (B + 1), pellNonmaximalOrder_radical_twentyThree_pow_succ B, ?_⟩
  have htwo : B < 2 ^ B := B.lt_two_pow_self
  have hbase : 2 ^ B ≤ 23 ^ B :=
    Nat.pow_le_pow_left (by omega : 2 ≤ 23) B
  have hstep : 23 ^ B ≤ 23 ^ (B + 1) :=
    Nat.pow_le_pow_right (n := 23) (by omega) (by omega)
  exact htwo.trans_le (hbase.trans hstep)

/-! ## An actual overlap on the Pell orbit -/

/-- A linear-time presentation of the doubled Pell coordinates.  The
repository's original mutually recursive presentation is optimized for
proofs rather than large generated computations. -/
def pellNonmaximalOrder_fastPair : ℕ → ℤ × ℤ
  | 0 => (1, 0)
  | n + 1 =>
      let z := pellNonmaximalOrder_fastPair n
      (7 * z.1 + 12 * z.2, 4 * z.1 + 7 * z.2)

/-- The linear-time presentation is extensionally the repository's Pell
coordinate pair. -/
theorem pellNonmaximalOrder_fastPair_eq (n : ℕ) :
    pellNonmaximalOrder_fastPair n = (pellDoubleS n, pellDoubleR n) := by
  induction n with
  | zero =>
      norm_num [pellNonmaximalOrder_fastPair, pellDoubleS, pellDoubleR,
        pellOrbitQ, pellOrbitP]
  | succ n ih =>
      simp only [pellNonmaximalOrder_fastPair, ih]
      rw [pellDoubleS_succ, pellDoubleR_succ]

/-- Generated exact-decision certificate for the efficiently presented
residue `c_1575 mod 23^4 = 7 * 23^3`. -/
private theorem pellNonmaximalOrder_fastOverlap_residue :
    ((pellNonmaximalOrder_fastPair 1575).1 ^ 2 - 2) %
        ((23 : ℤ) ^ 4) = 85169 := by
  native_decide

/-- The public residue certificate, transported to the repository's actual
Pell companion by the proved recurrence equivalence. -/
theorem pellNonmaximalOrder_actualOverlap_residue :
    pellRadicalC 1575 % ((23 : ℤ) ^ 4) = 85169 := by
  have hfst :
      (pellNonmaximalOrder_fastPair 1575).1 = pellDoubleS 1575 := by
    simpa using congrArg Prod.fst (pellNonmaximalOrder_fastPair_eq 1575)
  rw [pellRadicalC, ← hfst]
  exact pellNonmaximalOrder_fastOverlap_residue

/-- Generated exact-decision certificate for the valuation boundary in the
linear-time presentation. -/
private theorem pellNonmaximalOrder_fastOverlap_exactDepth :
    (23 : ℤ) ^ 3 ∣ (pellNonmaximalOrder_fastPair 1575).1 ^ 2 - 2 ∧
      ¬ (23 : ℤ) ^ 4 ∣ (pellNonmaximalOrder_fastPair 1575).1 ^ 2 - 2 := by
  native_decide

/-- The same exact computation stated as the valuation-depth boundary:
`23^3` divides the actual Pell companion and `23^4` does not. -/
theorem pellNonmaximalOrder_actualOverlap_exactDepth :
    (23 : ℤ) ^ 3 ∣ pellRadicalC 1575 ∧
      ¬ (23 : ℤ) ^ 4 ∣ pellRadicalC 1575 := by
  have hfst :
      (pellNonmaximalOrder_fastPair 1575).1 = pellDoubleS 1575 := by
    simpa using congrArg Prod.fst (pellNonmaximalOrder_fastPair_eq 1575)
  rw [pellRadicalC, ← hfst]
  exact pellNonmaximalOrder_fastOverlap_exactDepth

end IUTThreeClosures
