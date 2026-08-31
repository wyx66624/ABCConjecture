/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.Tactic

/-!
# Quantized normalized-mass obstruction for one arithmetic Wronskian

Suppose positive endpoint radicals are `A,B`, the third powerful quotient is
`q`, and an admissible nonzero Wronskian quantizes the normalized derivative
gap as

`A*B*|L_b-L_a| = k*q`

with a positive integer `k`.  Then necessarily

`q/(A*B) <= |L_a|+|L_b|`.

In an abc triple, `q/(A*B)=c/rad(abc)`.  Hence the triangle-inequality upper
bound used by a single arithmetic Wronskian is automatically at least the
quantity it is supposed to bound.  No choice of a nondegenerate compatible
single derivation can make that normalized mass smaller.

The theorem is scalar and contains no abc assumption.
-/

namespace IUTThreeClosures
namespace WronskianNormalizedMassNoGo

noncomputable section

/-- Quantization of a nonzero normalized derivative gap forces the exact
Wronskian mass floor. -/
theorem normalized_mass_lower_bound_of_quantized_gap
    {A B q La Lb : ℝ} {k : ℕ}
    (hA : 0 < A) (hB : 0 < B) (hq : 0 < q)
    (hk : 0 < k)
    (hquant : A * B * |Lb - La| = (k : ℝ) * q) :
    q / (A * B) ≤ |La| + |Lb| := by
  have hAB : 0 < A * B := mul_pos hA hB
  have hkR : (1 : ℝ) ≤ (k : ℝ) := by
    exact_mod_cast hk
  have hq_le_quant : q ≤ A * B * |Lb - La| := by
    rw [hquant]
    nlinarith
  have htriangle : |Lb - La| ≤ |Lb| + |La| := by
    calc
      |Lb - La| = |Lb + (-La)| := by ring_nf
      _ ≤ |Lb| + |-La| := abs_add _ _
      _ = |Lb| + |La| := by simp
  have hmul :
      A * B * |Lb - La| ≤ A * B * (|Lb| + |La|) :=
    mul_le_mul_of_nonneg_left htriangle hAB.le
  have hq_le : q ≤ A * B * (|La| + |Lb|) := by
    calc
      q ≤ A * B * |Lb - La| := hq_le_quant
      _ ≤ A * B * (|Lb| + |La|) := hmul
      _ = A * B * (|La| + |Lb|) := by ring
  exact (div_le_iff₀ hAB).2 (by simpa [mul_comm] using hq_le)

/-- Consequently a strictly smaller normalized mass is impossible. -/
theorem not_mass_lt_quantized_floor
    {A B q La Lb : ℝ} {k : ℕ}
    (hA : 0 < A) (hB : 0 < B) (hq : 0 < q)
    (hk : 0 < k)
    (hquant : A * B * |Lb - La| = (k : ℝ) * q) :
    ¬ (|La| + |Lb| < q / (A * B)) := by
  exact not_lt_of_ge
    (normalized_mass_lower_bound_of_quantized_gap
      hA hB hq hk hquant)

/-- The scalar floor is sharp: a gap of exactly `q/(A*B)` attains it. -/
theorem normalized_mass_floor_is_sharp
    {A B q : ℝ} (hA : 0 < A) (hB : 0 < B) (hq : 0 < q) :
    |(0 : ℝ)| + |q / (A * B)| = q / (A * B) := by
  have hAB : 0 < A * B := mul_pos hA hB
  have hquot : 0 < q / (A * B) := div_pos hq hAB
  simp [abs_of_pos hquot]

#print axioms normalized_mass_lower_bound_of_quantized_gap
#print axioms not_mass_lt_quantized_floor
#print axioms normalized_mass_floor_is_sharp

end
end WronskianNormalizedMassNoGo
end IUTThreeClosures
