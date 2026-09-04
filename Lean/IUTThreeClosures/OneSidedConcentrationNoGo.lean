/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointOneSidedConcentration
import Mathlib.Tactic

/-!
# Infinite counterexample to a one-sided-only closure strategy

The one-sided radical concentration forced by an abc violation is a necessary
condition, not by itself a contradiction. The elementary family

`m = 1`, `x = 2^(n+3)`

satisfies

`rad(x)^2 * rad(m) < x`

for every `n`, and `x` is coprime to `x+1`. Thus any proof must also use the
radical of the companion endpoint; attempting to rule out the one-sided
condition alone is false.
-/

namespace IUTThreeClosures
namespace OneSidedConcentrationNoGo

open UniqueFactorizationMonoid

/-- Radical of a positive power of two. -/
theorem abcRadical_two_pow {k : ℕ} (hk : 0 < k) :
    abcRadical (2 ^ k) = 2 := by
  rw [abcRadical_eq_natRadical]
  simpa using
    (radical_pow_of_prime (a := (2 : ℕ)) Nat.prime_two.prime
      (n := k) hk)

/-- Every member of the dyadic family satisfies the strict one-sided
concentration inequality with small endpoint one. -/
theorem dyadic_oneSidedConcentration (n : ℕ) :
    abcRadical (2 ^ (n + 3)) ^ 2 * abcRadical 1 <
      2 ^ (n + 3) := by
  have hk : 0 < n + 3 := by omega
  rw [abcRadical_two_pow hk]
  simp only [abcRadical_one]
  have hpow : 2 ^ 2 < 2 ^ (n + 3) := by
    exact Nat.pow_lt_pow_right (by norm_num) (by omega)
  norm_num at hpow ⊢
  exact hpow

/-- The concentrated endpoint and its companion are coprime. -/
theorem dyadic_companion_coprime (n : ℕ) :
    Nat.Coprime (2 ^ (n + 3)) (2 ^ (n + 3) + 1) := by
  exact Nat.coprime_add_self_right.mpr (by simp)

/-- The one-sided concentration condition occurs along an unbounded family. -/
theorem exists_unbounded_oneSidedConcentration :
    ∀ B : ℕ, ∃ x : ℕ,
      B < x ∧
      abcRadical x ^ 2 * abcRadical 1 < x ∧
      Nat.Coprime x (x + 1) := by
  intro B
  let x := 2 ^ (B + 3)
  refine ⟨x, ?_, ?_, ?_⟩
  · dsimp [x]
    exact B.lt_two_pow_self.trans
      (Nat.pow_lt_pow_right (by norm_num) (by omega))
  · dsimp [x]
    exact dyadic_oneSidedConcentration B
  · dsimp [x]
    exact dyadic_companion_coprime B

#print axioms abcRadical_two_pow
#print axioms dyadic_oneSidedConcentration
#print axioms dyadic_companion_coprime
#print axioms exists_unbounded_oneSidedConcentration

end OneSidedConcentrationNoGo
end IUTThreeClosures
