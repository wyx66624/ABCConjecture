import EisensteinDescent
import Mathlib.Tactic

/-! Actual integer Gram and divisibility arithmetic for the reviewed US proof.
The arithmetic construction of the residue algebra and its torsion is separate. -/
set_option autoImplicit false
namespace ABCGramRigidity20260907
open ABCEisenstein20260905

def determinant (z w : Pair) : Int := z.1 * w.2 - w.1 * z.2

def doubledInner (z w : Pair) : Int :=
  2 * z.1 * w.1 + z.1 * w.2 + z.2 * w.1 + 2 * z.2 * w.2

theorem actual_norm_nonnegative (z : Pair) : 0 ≤ ABCEisenstein20260905.norm z := by
  have h : 4 * ABCEisenstein20260905.norm z = (2 * z.1 + z.2) ^ 2 + 3 * z.2 ^ 2 := by
    simp only [ABCEisenstein20260905.norm]
    ring
  nlinarith [sq_nonneg (2 * z.1 + z.2), sq_nonneg z.2]

theorem actual_gram_identity (z w : Pair) :
    4 * ABCEisenstein20260905.norm z * ABCEisenstein20260905.norm w - doubledInner z w ^ 2 = 3 * determinant z w ^ 2 := by
  simp only [ABCEisenstein20260905.norm, doubledInner, determinant]
  ring

theorem actual_determinant_square_bound (z w : Pair) :
    3 * determinant z w ^ 2 ≤ 4 * ABCEisenstein20260905.norm z * ABCEisenstein20260905.norm w := by
  have h := actual_gram_identity z w
  nlinarith [sq_nonneg (doubledInner z w)]

theorem actual_determinant_zero_of_modulus (z w : Pair) (m : Int)
    (hdiv : m ∣ determinant z w)
    (hheight : 4 * ABCEisenstein20260905.norm z * ABCEisenstein20260905.norm w < 3 * m ^ 2) : determinant z w = 0 := by
  have hlt : determinant z w ^ 2 < m ^ 2 := by
    have h := actual_determinant_square_bound z w
    omega
  have hz : determinant z w ^ 2 = 0 :=
    Int.eq_zero_of_dvd_of_nonneg_of_lt (sq_nonneg _) hlt (pow_dvd_pow_of_dvd hdiv 2)
  nlinarith [sq_nonneg (determinant z w)]

#print axioms actual_norm_nonnegative
#print axioms actual_gram_identity
#print axioms actual_determinant_square_bound
#print axioms actual_determinant_zero_of_modulus
end ABCGramRigidity20260907
