import JointPhasePackets
import Mathlib.Data.Int.GCD
import Mathlib.RingTheory.Coprime.Lemmas
import Mathlib.Data.Nat.Factorization.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Basic

/-! Actual integer normalization of the Eisenstein product/complement map.
The final theorem uses the literal gcd and integer quotient of each product.
It proves exact recovery of the primitive boundary, including its common gcd.
No analytic estimate, geometric input or ABC assumption occurs in this module. -/
set_option autoImplicit false
set_option maxHeartbeats 4000000
namespace ABCComplementContent20260907
open ABCEisenstein20260905 ABCGramRigidity20260907 ABCJointPhasePackets20260907

def scale (c : ℤ) (z : Pair) : Pair := (c * z.1, c * z.2)
def content (z : Pair) : ℤ := Int.gcd z.1 z.2
def primitive (z : Pair) : Pair := (z.1 / content z, z.2 / content z)
def normalizer (v w : Pair) : ℤ := content (mul v w) * content v
def multiplier (v w : Pair) : ℤ := ABCEisenstein20260905.norm v / normalizer v w
def recoveredProduct (v w : Pair) : ℕ :=
  ((phaseLeft (primitive (mul v w)) (primitive v) / multiplier v w) *
    (phaseMiddle (primitive (mul v w)) (primitive v) / multiplier v w) *
    (phaseRight (primitive (mul v w)) (primitive v) / multiplier v w)).natAbs
def primeRadical (n : ℕ) : ℕ := ∏ p ∈ n.primeFactors, p
noncomputable def signedDepthLedger (n : ℕ) : ℝ :=
  ∑ p ∈ n.primeFactors, ((n.factorization p : ℝ) - 3) * Real.log (p : ℝ)

theorem norm_positive (z : Pair) (hz : z ≠ (0, 0)) :
    0 < ABCEisenstein20260905.norm z := by
  have hn := actual_norm_nonnegative z
  by_contra h
  have he : ABCEisenstein20260905.norm z = 0 := by omega
  have hi : 2 * ABCEisenstein20260905.norm z =
      z.1 ^ 2 + z.2 ^ 2 + (z.1 + z.2) ^ 2 := by
    simp only [ABCEisenstein20260905.norm]
    ring
  have h1 : z.1 = 0 := by
    nlinarith [sq_nonneg z.1, sq_nonneg z.2, sq_nonneg (z.1 + z.2)]
  have h2 : z.2 = 0 := by
    nlinarith [sq_nonneg z.1, sq_nonneg z.2, sq_nonneg (z.1 + z.2)]
  exact hz (Prod.ext h1 h2)

theorem product_nonzero (v w : Pair) (hv : v ≠ (0, 0)) (hw : w ≠ (0, 0)) :
    mul v w ≠ (0, 0) := by
  have hpos := mul_pos (norm_positive v hv) (norm_positive w hw)
  rw [← norm_mul] at hpos
  intro h
  rw [h] at hpos
  norm_num [ABCEisenstein20260905.norm] at hpos

theorem primitive_source_nonzero (w : Pair) (hw : Int.gcd w.1 w.2 = 1) :
    w ≠ (0, 0) := by
  intro h
  subst w
  norm_num at hw

theorem content_positive (z : Pair) (hz : z ≠ (0, 0)) : 0 < content z := by
  have hg : Int.gcd z.1 z.2 ≠ 0 := by
    intro h
    obtain ⟨h1, h2⟩ := Int.gcd_eq_zero_iff.mp h
    exact hz (Prod.ext h1 h2)
  unfold content
  exact_mod_cast Nat.pos_of_ne_zero hg

theorem primitive_reconstruction (z : Pair) : scale (content z) (primitive z) = z := by
  apply Prod.ext
  · exact Int.mul_ediv_cancel' (Int.gcd_dvd_left z.1 z.2)
  · exact Int.mul_ediv_cancel' (Int.gcd_dvd_right z.1 z.2)

theorem primitive_is_primitive (z : Pair) (hz : z ≠ (0, 0)) :
    Int.gcd (primitive z).1 (primitive z).2 = 1 := by
  have hp : 0 < Int.gcd z.1 z.2 := by
    have hh : (0 : ℤ) < Int.gcd z.1 z.2 := content_positive z hz
    exact_mod_cast hh
  exact Int.gcd_ediv_gcd_ediv_gcd hp

theorem common_multiplication_determinant (v z w : Pair) :
    determinant (mul v z) (mul v w) =
      ABCEisenstein20260905.norm v * determinant z w := by
  simp only [determinant, mul, ABCEisenstein20260905.norm]
  ring

theorem scaled_phase_left (c d : ℤ) (z w : Pair) :
    phaseLeft (scale c z) (scale d w) = c * d * phaseLeft z w := by
  simp only [phaseLeft, determinant, scale]
  ring

theorem scaled_phase_middle (c d : ℤ) (z w : Pair) :
    phaseMiddle (scale c z) (scale d w) = c * d * phaseMiddle z w := by
  simp only [phaseMiddle, determinant, rotate, scale]
  ring

theorem scaled_phase_right (c d : ℤ) (z w : Pair) :
    phaseRight (scale c z) (scale d w) = c * d * phaseRight z w := by
  simp only [phaseRight, determinant, rotate, scale]
  ring

theorem raw_complement_phases (v w : Pair) :
    phaseLeft (mul v w) v = -w.2 * ABCEisenstein20260905.norm v ∧
    phaseMiddle (mul v w) v = w.1 * ABCEisenstein20260905.norm v ∧
    phaseRight (mul v w) v = (w.1 + w.2) * ABCEisenstein20260905.norm v := by
  simp only [phaseLeft, phaseMiddle, phaseRight, determinant, rotate, mul,
    ABCEisenstein20260905.norm]
  constructor
  · ring
  constructor <;> ring

theorem cleared_complement_phases (v w : Pair) :
    normalizer v w * phaseLeft (primitive (mul v w)) (primitive v) =
      -w.2 * ABCEisenstein20260905.norm v ∧
    normalizer v w * phaseMiddle (primitive (mul v w)) (primitive v) =
      w.1 * ABCEisenstein20260905.norm v ∧
    normalizer v w * phaseRight (primitive (mul v w)) (primitive v) =
      (w.1 + w.2) * ABCEisenstein20260905.norm v := by
  have h := raw_complement_phases v w
  unfold normalizer
  rw [← scaled_phase_left, ← scaled_phase_middle, ← scaled_phase_right]
  simpa only [primitive_reconstruction] using h

theorem normalizer_positive (v w : Pair) (hv : v ≠ (0, 0))
    (hw : Int.gcd w.1 w.2 = 1) : 0 < normalizer v w :=
  mul_pos (content_positive _ (product_nonzero v w hv (primitive_source_nonzero w hw)))
    (content_positive v hv)

theorem bezout_normalizer_divides_norm (v w : Pair) (hw : Int.gcd w.1 w.2 = 1) :
    normalizer v w ∣ ABCEisenstein20260905.norm v := by
  obtain ⟨u, t, hbez⟩ := Int.isCoprime_iff_gcd_eq_one.mpr hw
  obtain ⟨hx, hD, _⟩ := cleared_complement_phases v w
  refine ⟨u * phaseMiddle (primitive (mul v w)) (primitive v) -
    t * phaseLeft (primitive (mul v w)) (primitive v), ?_⟩
  calc
    ABCEisenstein20260905.norm v =
        (u * w.1 + t * w.2) * ABCEisenstein20260905.norm v := by rw [hbez]; ring
    _ = u * (normalizer v w * phaseMiddle (primitive (mul v w)) (primitive v)) -
        t * (normalizer v w * phaseLeft (primitive (mul v w)) (primitive v)) := by
      rw [hD, hx]
      ring
    _ = _ := by ring

theorem multiplier_factorization (v w : Pair) (hw : Int.gcd w.1 w.2 = 1) :
    normalizer v w * multiplier v w = ABCEisenstein20260905.norm v :=
  Int.mul_ediv_cancel' (bezout_normalizer_divides_norm v w hw)

theorem multiplier_positive (v w : Pair) (hv : v ≠ (0, 0))
    (hw : Int.gcd w.1 w.2 = 1) : 0 < multiplier v w := by
  have hc := normalizer_positive v w hv hw
  have hn := norm_positive v hv
  have hf := multiplier_factorization v w hw
  nlinarith

theorem actual_complement_phases (v w : Pair) (hv : v ≠ (0, 0))
    (hw : Int.gcd w.1 w.2 = 1) :
    phaseLeft (primitive (mul v w)) (primitive v) = multiplier v w * (-w.2) ∧
    phaseMiddle (primitive (mul v w)) (primitive v) = multiplier v w * w.1 ∧
    phaseRight (primitive (mul v w)) (primitive v) = multiplier v w * (w.1 + w.2) := by
  have hc : normalizer v w ≠ 0 := ne_of_gt (normalizer_positive v w hv hw)
  have hf := multiplier_factorization v w hw
  obtain ⟨hx, hD, hy⟩ := cleared_complement_phases v w
  rw [← hf] at hx hD hy
  constructor
  · apply mul_left_cancel₀ hc
    calc
      normalizer v w * phaseLeft (primitive (mul v w)) (primitive v) =
          -w.2 * (normalizer v w * multiplier v w) := hx
      _ = _ := by ring
  constructor
  · apply mul_left_cancel₀ hc
    calc
      normalizer v w * phaseMiddle (primitive (mul v w)) (primitive v) =
          w.1 * (normalizer v w * multiplier v w) := hD
      _ = _ := by ring
  · apply mul_left_cancel₀ hc
    calc
      normalizer v w * phaseRight (primitive (mul v w)) (primitive v) =
          (w.1 + w.2) * (normalizer v w * multiplier v w) := hy
      _ = _ := by ring

theorem recovered_phase_coordinates (v w : Pair) (hv : v ≠ (0, 0))
    (hw : Int.gcd w.1 w.2 = 1) :
    phaseLeft (primitive (mul v w)) (primitive v) / multiplier v w = -w.2 ∧
    phaseMiddle (primitive (mul v w)) (primitive v) / multiplier v w = w.1 ∧
    phaseRight (primitive (mul v w)) (primitive v) / multiplier v w = w.1 + w.2 := by
  obtain ⟨hx, hD, hy⟩ := actual_complement_phases v w hv hw
  have hr : multiplier v w ≠ 0 := ne_of_gt (multiplier_positive v w hv hw)
  simp only [hx, hD, hy, Int.mul_ediv_cancel_left _ hr, and_self]

theorem recovered_absolute_boundary (v w : Pair) (hv : v ≠ (0, 0))
    (hw : Int.gcd w.1 w.2 = 1) :
    ((phaseLeft (primitive (mul v w)) (primitive v) / multiplier v w) *
      (phaseMiddle (primitive (mul v w)) (primitive v) / multiplier v w) *
      (phaseRight (primitive (mul v w)) (primitive v) / multiplier v w)).natAbs =
        (boundary w).natAbs := by
  obtain ⟨hx, hD, hy⟩ := recovered_phase_coordinates v w hv hw
  rw [hx, hD, hy]
  have he : -w.2 * w.1 * (w.1 + w.2) = -boundary w := by unfold boundary; ring
  rw [he, Int.natAbs_neg]

theorem actual_phase_pair_gcd (v w : Pair) (hv : v ≠ (0, 0))
    (hw : Int.gcd w.1 w.2 = 1) :
    Int.gcd (phaseLeft (primitive (mul v w)) (primitive v))
      (phaseMiddle (primitive (mul v w)) (primitive v)) = (multiplier v w).natAbs := by
  obtain ⟨hx, hD, _⟩ := actual_complement_phases v w hv hw
  rw [hx, hD, Int.gcd_mul_left]
  have hg : Int.gcd (-w.2) w.1 = 1 := by
    rw [Int.gcd_comm, Int.gcd_neg]
    exact hw
  rw [hg, Nat.mul_one]

theorem actual_phase_triple_gcd (v w : Pair) (hv : v ≠ (0, 0))
    (hw : Int.gcd w.1 w.2 = 1) :
    Int.gcd (Int.gcd (phaseLeft (primitive (mul v w)) (primitive v))
      (phaseMiddle (primitive (mul v w)) (primitive v)))
      (phaseRight (primitive (mul v w)) (primitive v)) = (multiplier v w).natAbs := by
  rw [actual_phase_pair_gcd v w hv hw]
  have hr := multiplier_positive v w hv hw
  have hy := (actual_complement_phases v w hv hw).2.2
  rw [Int.natAbs_of_nonneg (le_of_lt hr), hy]
  have hg := Int.gcd_eq_left (le_of_lt hr) (dvd_mul_right (multiplier v w) (w.1 + w.2))
  apply Int.ofNat_inj.mp
  rw [Int.natAbs_of_nonneg (le_of_lt hr)]
  exact hg

theorem actual_primitive_boundary_observable {A : Type*} (f : ℕ → A)
    (v w : Pair) (hv : v ≠ (0, 0)) (hw : Int.gcd w.1 w.2 = 1) :
    f (((phaseLeft (primitive (mul v w)) (primitive v) / multiplier v w) *
      (phaseMiddle (primitive (mul v w)) (primitive v) / multiplier v w) *
      (phaseRight (primitive (mul v w)) (primitive v) / multiplier v w)).natAbs) =
        f (boundary w).natAbs := by rw [recovered_absolute_boundary v w hv hw]

theorem actual_recovered_radical (v w : Pair) (hv : v ≠ (0, 0))
    (hw : Int.gcd w.1 w.2 = 1) :
    primeRadical (recoveredProduct v w) = primeRadical (boundary w).natAbs :=
  actual_primitive_boundary_observable primeRadical v w hv hw

theorem actual_recovered_signed_ledger (v w : Pair) (hv : v ≠ (0, 0))
    (hw : Int.gcd w.1 w.2 = 1) :
    signedDepthLedger (recoveredProduct v w) = signedDepthLedger (boundary w).natAbs :=
  actual_primitive_boundary_observable signedDepthLedger v w hv hw

#print axioms norm_positive
#print axioms product_nonzero
#print axioms primitive_source_nonzero
#print axioms content_positive
#print axioms primitive_reconstruction
#print axioms primitive_is_primitive
#print axioms common_multiplication_determinant
#print axioms scaled_phase_left
#print axioms scaled_phase_middle
#print axioms scaled_phase_right
#print axioms raw_complement_phases
#print axioms cleared_complement_phases
#print axioms normalizer_positive
#print axioms bezout_normalizer_divides_norm
#print axioms multiplier_factorization
#print axioms multiplier_positive
#print axioms actual_complement_phases
#print axioms recovered_phase_coordinates
#print axioms recovered_absolute_boundary
#print axioms actual_phase_pair_gcd
#print axioms actual_phase_triple_gcd
#print axioms actual_primitive_boundary_observable
#print axioms actual_recovered_radical
#print axioms actual_recovered_signed_ledger
end ABCComplementContent20260907
