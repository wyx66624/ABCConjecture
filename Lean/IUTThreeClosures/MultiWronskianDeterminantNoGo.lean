/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.WronskianNormalizedMassNoGo
import Mathlib.Tactic

/-!
# Determinant no-go for two compatible arithmetic derivations

For two normalized derivative vectors `(L_a,L_b)` and `(M_a,M_b)`, the natural
Jacobian determinant is

`L_a*M_b - M_a*L_b`.

If powerful-part divisibility quantizes this determinant by

`A*B*|det| = k*q`,

then the product of the two `l1` masses is at least `q/(A*B)`.  Thus passing
from one Wronskian to two and applying Hadamard/triangle inequalities does not
remove the exact `c/rad` covolume floor: it merely distributes it between two
vectors.

No abc statement is assumed.
-/

namespace IUTThreeClosures
namespace MultiWronskianDeterminantNoGo

noncomputable section

/-- The two-dimensional determinant. -/
def det₂ (La Lb Ma Mb : ℝ) : ℝ :=
  La * Mb - Ma * Lb

/-- Elementary `l1` Hadamard bound. -/
theorem abs_det₂_le_l1_mul_l1
    (La Lb Ma Mb : ℝ) :
    |det₂ La Lb Ma Mb| ≤
      (|La| + |Lb|) * (|Ma| + |Mb|) := by
  have htriangle :
      |La * Mb - Ma * Lb| ≤ |La * Mb| + |Ma * Lb| := by
    calc
      |La * Mb - Ma * Lb| = |La * Mb + (-(Ma * Lb))| := by ring_nf
      _ ≤ |La * Mb| + |-(Ma * Lb)| := abs_add _ _
      _ = |La * Mb| + |Ma * Lb| := by simp
  unfold det₂
  rw [abs_mul, abs_mul] at htriangle
  have hLa : 0 ≤ |La| := abs_nonneg La
  have hLb : 0 ≤ |Lb| := abs_nonneg Lb
  have hMa : 0 ≤ |Ma| := abs_nonneg Ma
  have hMb : 0 ≤ |Mb| := abs_nonneg Mb
  nlinarith

/-- A quantized nonzero determinant forces the exact covolume floor on the
product of the two normalized masses. -/
theorem l1_mass_product_lower_bound_of_quantized_det
    {A B q La Lb Ma Mb : ℝ} {k : ℕ}
    (hA : 0 < A) (hB : 0 < B) (hq : 0 < q)
    (hk : 0 < k)
    (hquant :
      A * B * |det₂ La Lb Ma Mb| = (k : ℝ) * q) :
    q / (A * B) ≤
      (|La| + |Lb|) * (|Ma| + |Mb|) := by
  have hAB : 0 < A * B := mul_pos hA hB
  have hkR : (1 : ℝ) ≤ (k : ℝ) := by
    exact_mod_cast hk
  have hq_le_det : q ≤ A * B * |det₂ La Lb Ma Mb| := by
    rw [hquant]
    nlinarith
  have hHadamard := abs_det₂_le_l1_mul_l1 La Lb Ma Mb
  have hscaled :
      A * B * |det₂ La Lb Ma Mb| ≤
        A * B * ((|La| + |Lb|) * (|Ma| + |Mb|)) :=
    mul_le_mul_of_nonneg_left hHadamard hAB.le
  apply (div_le_iff₀ hAB).2
  calc
    q ≤ A * B * |det₂ La Lb Ma Mb| := hq_le_det
    _ ≤ A * B * ((|La| + |Lb|) * (|Ma| + |Mb|)) := hscaled
    _ = ((|La| + |Lb|) * (|Ma| + |Mb|)) * (A * B) := by ring

/-- The determinant floor is sharp. -/
theorem determinant_mass_floor_is_sharp
    {A B q : ℝ} (hA : 0 < A) (hB : 0 < B) (hq : 0 < q) :
    |det₂ (q / (A * B)) 0 0 1| = q / (A * B) ∧
      (|q / (A * B)| + |(0 : ℝ)|) *
          (|(0 : ℝ)| + |(1 : ℝ)|) = q / (A * B) := by
  have hAB : 0 < A * B := mul_pos hA hB
  have hquot : 0 < q / (A * B) := div_pos hq hAB
  constructor <;> simp [det₂, abs_of_pos hquot]

#print axioms abs_det₂_le_l1_mul_l1
#print axioms l1_mass_product_lower_bound_of_quantized_det
#print axioms determinant_mass_floor_is_sharp

end
end MultiWronskianDeterminantNoGo
end IUTThreeClosures
