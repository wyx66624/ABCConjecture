/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# The exact-order-twelve core of the cyclotomic prime selector

The twelfth-cyclotomic selector produces, modulo a selected prime, an element
whose twelfth power is one, whose sixth power is not one, and whose fourth
power is not one.  This module isolates the finite-group consequence:
its multiplicative order is exactly twelve.  Any further exponent annihilating
the element is therefore divisible by twelve.

The application to a prime divisor of `M^4 - M^2 + 1`, and the conversion of
Fermat's theorem into the congruence `ell ≡ 1 [MOD 12]`, are kept as subsequent
arithmetic layers.
-/

namespace IUTThreeClosures

/-- A divisor of twelve which divides neither six nor four is twelve. -/
theorem nat_eq_twelve_of_dvd_not_dvd_six_not_dvd_four
    {d : ℕ}
    (hdvd : d ∣ 12)
    (hnotSix : ¬ d ∣ 6)
    (hnotFour : ¬ d ∣ 4) :
    d = 12 := by
  have hdne : d ≠ 0 := by
    intro hd
    subst d
    norm_num at hdvd
  have hdpos : 0 < d := Nat.pos_of_ne_zero hdne
  have hdle : d ≤ 12 := Nat.le_of_dvd (by norm_num) hdvd
  interval_cases d <;> norm_num at hdvd hnotSix hnotFour ⊢

/-- Exact multiplicative order twelve from the three relevant power tests. -/
theorem orderOf_eq_twelve_of_pow_twelve_eq_one
    {G : Type*} [Group G]
    (u : G)
    (hTwelve : u ^ 12 = 1)
    (hSix : u ^ 6 ≠ 1)
    (hFour : u ^ 4 ≠ 1) :
    orderOf u = 12 := by
  have hdvdTwelve : orderOf u ∣ 12 :=
    (orderOf_dvd_iff_pow_eq_one).2 hTwelve
  have hnotSix : ¬ orderOf u ∣ 6 := by
    intro h
    exact hSix ((orderOf_dvd_iff_pow_eq_one).1 h)
  have hnotFour : ¬ orderOf u ∣ 4 := by
    intro h
    exact hFour ((orderOf_dvd_iff_pow_eq_one).1 h)
  exact nat_eq_twelve_of_dvd_not_dvd_six_not_dvd_four
    hdvdTwelve hnotSix hnotFour

/-- Every exponent annihilating an exact-order-twelve element is divisible by
twelve. -/
theorem twelve_dvd_of_pow_eq_one
    {G : Type*} [Group G]
    (u : G)
    (hTwelve : u ^ 12 = 1)
    (hSix : u ^ 6 ≠ 1)
    (hFour : u ^ 4 ≠ 1)
    {n : ℕ}
    (hn : u ^ n = 1) :
    12 ∣ n := by
  have horder : orderOf u = 12 :=
    orderOf_eq_twelve_of_pow_twelve_eq_one u hTwelve hSix hFour
  have hdvd : orderOf u ∣ n :=
    (orderOf_dvd_iff_pow_eq_one).2 hn
  simpa [horder] using hdvd

end IUTThreeClosures
