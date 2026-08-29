/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.PrimePowerExceptionalExponentThreshold
import Mathlib.Tactic

/-!
# Current global abc exceptional bounds do not hit fixed prime-power centres

The current refined global exceptional-set theorem has power exponent
`3/5 + delta`.  A fixed nontrivial prime-power centre family `p^k`, `k >= 2`,
has power exponent at most `1/2`.  Therefore the ambient global count is not
small enough, by cardinality alone, to force a good point on any such centre
family.

This file formalizes only the rational exponent comparison.  It does not
formalize or assume the external exceptional-set theorem.
-/

namespace IUTThreeClosures
namespace CurrentExceptionalSetPrimePowerNoGo

open PrimePowerExceptionalExponentThreshold

/-- Every fixed prime-power family with `k >= 2` has centre exponent at most
`1/2`. -/
theorem primePowerCenterExponent_le_one_half_of_two_le
    {k : ℕ}
    (hk : 2 ≤ k) :
    primePowerCenterExponent k ≤ (1 : ℝ) / 2 := by
  have hkposNat : 0 < k := by omega
  have hkpos : 0 < (k : ℝ) := by exact_mod_cast hkposNat
  have hktwo : (2 : ℝ) ≤ k := by exact_mod_cast hk
  unfold primePowerCenterExponent
  apply (div_le_iff₀ hkpos).2
  nlinarith

/-- The exponent `3/5` is strictly larger than the centre exponent of every
fixed `p^k` family with `k >= 2`. -/
theorem primePowerCenterExponent_lt_three_fifths_of_two_le
    {k : ℕ}
    (hk : 2 ≤ k) :
    primePowerCenterExponent k < (3 : ℝ) / 5 := by
  have hhalf :=
    primePowerCenterExponent_le_one_half_of_two_le hk
  have hrat : (1 : ℝ) / 2 < (3 : ℝ) / 5 := by
    norm_num
  exact lt_of_le_of_lt hhalf hrat

/-- Hence an ambient exceptional estimate with exact exponent `3/5` does not
meet the strict exponent condition required for direct transfer to `p^k`
centres. -/
theorem three_fifths_exceptionExponent_fails_direct_transfer
    {k : ℕ}
    (hk : 2 ≤ k) :
    ¬ ((3 : ℝ) / 5 < primePowerCenterExponent k) := by
  have h := primePowerCenterExponent_lt_three_fifths_of_two_le hk
  linarith

/-- Equivalently, the corresponding power saving `2/5` lies strictly below
the direct-transfer threshold for every nontrivial prime-power family. -/
theorem two_fifths_saving_below_directTransferThreshold
    {k : ℕ}
    (hk : 2 ≤ k) :
    (2 : ℝ) / 5 < directTransferSavingThreshold k := by
  have h := primePowerCenterExponent_lt_three_fifths_of_two_le hk
  unfold directTransferSavingThreshold
  linarith

#print axioms primePowerCenterExponent_le_one_half_of_two_le
#print axioms primePowerCenterExponent_lt_three_fifths_of_two_le
#print axioms three_fifths_exceptionExponent_fails_direct_transfer
#print axioms two_fifths_saving_below_directTransferSavingThreshold

end CurrentExceptionalSetPrimePowerNoGo
end IUTThreeClosures
