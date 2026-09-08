import ActualGramRigidity
import ActualSignedProducts
import Mathlib.RingTheory.Coprime.Lemmas
import Mathlib.Data.Fintype.BigOperators
import Mathlib.Tactic

/-! The actual three-phase determinant and finite joint-capacity bridge.
The arithmetic reduction maps, torsion sizes, product heights and separation
of actual signed products remain explicit inputs in the final capacity theorem. -/
set_option autoImplicit false
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCJointPhasePackets20260907
open scoped BigOperators
open ABCEisenstein20260905 ABCGramRigidity20260907 ABCActualSignedProducts20260907

def phaseLeft (z w : Pair) : ℤ := determinant z w
def phaseRight (z w : Pair) : ℤ := determinant z (rotate (rotate w))
def phaseMiddle (z w : Pair) : ℤ := determinant z (rotate w)
def phaseProduct (z w : Pair) : ℤ := phaseLeft z w * phaseRight z w * phaseMiddle z w

theorem actual_phase_addition (z w : Pair) :
    phaseMiddle z w = phaseLeft z w + phaseRight z w := by
  simp only [phaseMiddle, phaseLeft, phaseRight, determinant, rotate]
  ring

theorem actual_phase_norm (z w : Pair) :
    ABCEisenstein20260905.norm z * ABCEisenstein20260905.norm w = phaseLeft z w ^ 2 +
      phaseLeft z w * phaseRight z w + phaseRight z w ^ 2 := by
  simp only [ABCEisenstein20260905.norm, phaseLeft, phaseRight, determinant, rotate]
  ring

theorem cubic_discriminant_identity (x y : ℤ) :
    4 * (x ^ 2 + x * y + y ^ 2) ^ 3 - 27 * (x * y * (x + y)) ^ 2 =
      ((x - y) * (2 * x + y) * (x + 2 * y)) ^ 2 := by ring

theorem actual_phase_product_square_bound (z w : Pair) :
    27 * phaseProduct z w ^ 2 ≤
      4 * (ABCEisenstein20260905.norm z * ABCEisenstein20260905.norm w) ^ 3 := by
  have h := cubic_discriminant_identity (phaseLeft z w) (phaseRight z w)
  rw [← actual_phase_norm, ← actual_phase_addition] at h
  unfold phaseProduct
  nlinarith [sq_nonneg ((phaseLeft z w - phaseRight z w) *
    (2 * phaseLeft z w + phaseRight z w) * (phaseLeft z w + 2 * phaseRight z w))]

theorem actual_phase_zero_of_modulus (z w : Pair) (m : ℤ)
    (hdiv : m ∣ phaseProduct z w)
    (hheight : 4 * (ABCEisenstein20260905.norm z *
      ABCEisenstein20260905.norm w) ^ 3 < 27 * m ^ 2) :
    phaseLeft z w = 0 ∨ phaseRight z w = 0 ∨ phaseMiddle z w = 0 := by
  have hlt : phaseProduct z w ^ 2 < m ^ 2 := by
    have hb := actual_phase_product_square_bound z w
    omega
  have hz : phaseProduct z w ^ 2 = 0 :=
    Int.eq_zero_of_dvd_of_nonneg_of_lt (sq_nonneg _) hlt (pow_dvd_pow_of_dvd hdiv 2)
  have hp : phaseProduct z w = 0 := by nlinarith [sq_nonneg (phaseProduct z w)]
  simpa only [phaseProduct, mul_eq_zero, or_assoc] using hp

theorem phase_divisor_dvd_product (z w : Pair) (m : ℤ)
    (h : m ∣ phaseLeft z w ∨ m ∣ phaseRight z w ∨ m ∣ phaseMiddle z w) :
    m ∣ phaseProduct z w := by
  unfold phaseProduct
  rcases h with h | h | h
  · exact dvd_mul_of_dvd_left (dvd_mul_of_dvd_left h _) _
  · exact dvd_mul_of_dvd_left (dvd_mul_of_dvd_right h _) _
  · exact dvd_mul_of_dvd_right h _

theorem coprime_phase_moduli_dvd {S : Type*} [Fintype S]
    (m : S → ℤ) (hcop : Pairwise fun i j ↦ IsCoprime (m i) (m j)) (z w : Pair)
    (hlocal : ∀ i, m i ∣ phaseLeft z w ∨ m i ∣ phaseRight z w ∨
      m i ∣ phaseMiddle z w) : (∏ i, m i) ∣ phaseProduct z w :=
  Fintype.prod_dvd_of_coprime hcop fun i ↦ phase_divisor_dvd_product z w (m i) (hlocal i)

theorem joint_phase_injective {A S : Type*} [Fintype S] (H : S → Type*)
    (z : A → Pair) (f : (i : S) → A → H i) (m : S → ℤ)
    (hcop : Pairwise fun i j ↦ IsCoprime (m i) (m j))
    (hlocal : ∀ u v i, f i u = f i v →
      m i ∣ phaseLeft (z u) (z v) ∨ m i ∣ phaseRight (z u) (z v) ∨
        m i ∣ phaseMiddle (z u) (z v))
    (hheight : ∀ u v, 4 * (ABCEisenstein20260905.norm (z u) *
      ABCEisenstein20260905.norm (z v)) ^ 3 < 27 * (∏ i, m i) ^ 2)
    (hsep : ∀ u v, (phaseLeft (z u) (z v) = 0 ∨ phaseRight (z u) (z v) = 0 ∨
      phaseMiddle (z u) (z v) = 0) → u = v) :
    Function.Injective (fun u i ↦ f i u) := by
  intro u v huv
  apply hsep u v
  exact actual_phase_zero_of_modulus (z u) (z v) _
    (coprime_phase_moduli_dvd m hcop _ _ fun i ↦ hlocal u v i (congrFun huv i))
    (hheight u v)

theorem joint_phase_capacity {A S : Type*} [Fintype A] [Fintype S]
    (H : S → Type*) [∀ i, Fintype (H i)]
    (z : A → Pair) (f : (i : S) → A → H i) (m : S → ℤ)
    (hcop : Pairwise fun i j ↦ IsCoprime (m i) (m j))
    (hlocal : ∀ u v i, f i u = f i v →
      m i ∣ phaseLeft (z u) (z v) ∨ m i ∣ phaseRight (z u) (z v) ∨
        m i ∣ phaseMiddle (z u) (z v))
    (hheight : ∀ u v, 4 * (ABCEisenstein20260905.norm (z u) *
      ABCEisenstein20260905.norm (z v)) ^ 3 < 27 * (∏ i, m i) ^ 2)
    (hsep : ∀ u v, (phaseLeft (z u) (z v) = 0 ∨ phaseRight (z u) (z v) = 0 ∨
      phaseMiddle (z u) (z v) = 0) → u = v)
    (n : ℕ) (hcard : ∀ i, Fintype.card (H i) ≤ n) :
    Fintype.card A ≤ n ^ Fintype.card S := by
  classical
  calc
    Fintype.card A ≤ Fintype.card ((i : S) → H i) :=
      Fintype.card_le_of_injective _ (joint_phase_injective H z f m hcop hlocal hheight hsep)
    _ = ∏ i, Fintype.card (H i) := Fintype.card_pi
    _ ≤ ∏ _ : S, n := Finset.prod_le_prod' fun i _ ↦ hcard i
    _ = n ^ Fintype.card S := by simp

theorem private_independence_through_cube_kernel {I G H : Type*}
    [Fintype I] [CommGroup G] [Group H]
    (a : I → G) (v : I → G →* Multiplicative ℤ)
    (hoff : ∀ i j : I, j ≠ i → v i (a j) = 1)
    (hdiag : ∀ i : I, (v i (a i)).toAdd ≠ 0)
    (phi : G →* H) (hkernel : ∀ g, phi g = 1 → g ^ 3 = 1) :
    Function.Injective (fun x ↦ phi (signedProduct a x)) := by
  intro x y hxy
  change phi (signedProduct a x) = phi (signedProduct a y) at hxy
  have hk : phi (signedProduct a x / signedProduct a y) = 1 := by
    simp only [map_div, hxy, div_self']
  have ht := hkernel _ hk
  funext i
  have hv := congrArg (v i) ht
  rw [map_pow, map_div, map_one, private_signed_valuation a v hoff i x,
    private_signed_valuation a v hoff i y] at hv
  have hi := congrArg Multiplicative.toAdd hv
  simp only [toAdd_pow, toAdd_div, toAdd_zpow, toAdd_one, zsmul_eq_mul,
    nsmul_eq_mul, Int.cast_id, Nat.cast_ofNat] at hi
  have he : (x i - y i) * (v i (a i)).toAdd = 0 := by nlinarith [hi]
  have hz := (mul_eq_zero.mp he).resolve_right (hdiag i)
  omega

#print axioms actual_phase_addition
#print axioms actual_phase_norm
#print axioms cubic_discriminant_identity
#print axioms actual_phase_product_square_bound
#print axioms actual_phase_zero_of_modulus
#print axioms phase_divisor_dvd_product
#print axioms coprime_phase_moduli_dvd
#print axioms joint_phase_injective
#print axioms joint_phase_capacity
#print axioms private_independence_through_cube_kernel
end ABCJointPhasePackets20260907
