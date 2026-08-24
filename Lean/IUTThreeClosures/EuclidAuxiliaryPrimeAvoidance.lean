/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.EuclidAuxiliaryPrimeSelector

/-!
# Divisor-wise consequences of the Euclidean auxiliary-prime selector

The selected prime avoids not only the product `N` itself, but every divisor
of `N`.  This is the form needed when `N` is chosen to be a product of local
Tate orders, extension degrees, residue characteristics, and any other finite
avoidance data.
-/

namespace IUTThreeClosures

/-- Every divisor of the avoidance product is avoided by the selected prime. -/
theorem euclidAuxiliaryPrime_not_dvd_of_dvd
    {B N d : ℕ} (hN : 0 < N) (hd : d ∣ N) :
    ¬ euclidAuxiliaryPrime B N ∣ d := by
  intro hld
  exact euclidAuxiliaryPrime_not_dvd hN (hld.trans hd)

/-- Quantitative selection with an arbitrary property that follows from
avoiding the prescribed product. -/
theorem exists_quantitative_prime_of_avoidance
    (B N : ℕ) (hN : 0 < N)
    (Good : ℕ → Prop)
    (hGood :
      ∀ ell : ℕ,
        Nat.Prime ell → B < ell → ¬ ell ∣ N → Good ell) :
    ∃ ell : ℕ,
      Nat.Prime ell ∧
      B < ell ∧
      Good ell ∧
      ell ≤ B.factorial * N + 1 := by
  rcases exists_prime_above_not_dvd_le B N hN with
    ⟨ell, hp, hB, havoid, hupper⟩
  exact ⟨ell, hp, hB, hGood ell hp hB havoid, hupper⟩

/-- A uniform large-image theorem above a threshold and away from one
avoidance product automatically acquires an explicit upper bound for the
selected prime. -/
theorem exists_bounded_largeImage_prime
    (B N : ℕ) (hN : 0 < N)
    (LargeImage : ℕ → Prop)
    (hLargeImage :
      ∀ ell : ℕ,
        Nat.Prime ell → B < ell → ¬ ell ∣ N → LargeImage ell) :
    ∃ ell : ℕ,
      Nat.Prime ell ∧
      B < ell ∧
      LargeImage ell ∧
      ell ≤ B.factorial * N + 1 :=
  exists_quantitative_prime_of_avoidance
    B N hN LargeImage hLargeImage

end IUTThreeClosures
