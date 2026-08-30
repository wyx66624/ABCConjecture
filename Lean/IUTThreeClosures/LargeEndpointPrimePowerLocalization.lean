/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.LargeEndpointCubefulExcess
import Mathlib.Data.Nat.Factorization.PrimePow
import Mathlib.Tactic

/-!
# Prime-power localization on the two large abc endpoints

For a positive primitive abc point, `max(a,b)` and `c` are coprime. Therefore
any prime power dividing their product is supported on exactly one endpoint.
Combined with the large-endpoint power-free closure, every violation of the
explicit coefficient-one bound forces a prime cube on exactly one of the two
large adjacent endpoints.

This is a localization theorem only; it does not bound the total cubeful mass.
-/

namespace IUTThreeClosures

noncomputable section

namespace ABCPoint

/-- The larger summand and the sum are coprime. -/
theorem largeEndpoint_coprime_c (P : ABCPoint) :
    Nat.Coprime P.largeEndpoint P.c := by
  by_cases hab : P.a ≤ P.b
  · have hmax : P.largeEndpoint = P.b := by
      simp [largeEndpoint, hab]
    rw [hmax]
    exact P.pairwise_coprime.2.1
  · have hba : P.b ≤ P.a := by omega
    have hmax : P.largeEndpoint = P.a := by
      simp [largeEndpoint, hba]
    rw [hmax]
    exact P.pairwise_coprime.2.2.symm

/-- A positive prime power dividing the product of the two large adjacent
endpoints divides one of them. -/
theorem prime_pow_dvd_largeEndpoint_or_c
    (P : ABCPoint) {p k : ℕ}
    (hp : p.Prime) (hk : 0 < k)
    (hpow : p ^ k ∣ P.largeEndpoint * P.c) :
    p ^ k ∣ P.largeEndpoint ∨ p ^ k ∣ P.c := by
  have hprimePow : IsPrimePow (p ^ k) :=
    (isPrimePow_nat_iff _).2 ⟨p, k, hp, hk, rfl⟩
  exact (P.largeEndpoint_coprime_c.isPrimePow_dvd_mul hprimePow).1 hpow

/-- The same prime power cannot divide both coprime large endpoints. -/
theorem not_prime_pow_dvd_largeEndpoint_and_c
    (P : ABCPoint) {p k : ℕ}
    (hp : p.Prime) (hk : 0 < k) :
    ¬ (p ^ k ∣ P.largeEndpoint ∧ p ^ k ∣ P.c) := by
  rintro ⟨hM, hc⟩
  have hp_pow : p ∣ p ^ k := dvd_pow_self p hk.ne'
  have hpM : p ∣ P.largeEndpoint := hp_pow.trans hM
  have hpc : p ∣ P.c := hp_pow.trans hc
  have hpone : p = 1 :=
    Nat.eq_one_of_dvd_coprimes P.largeEndpoint_coprime_c hpM hpc
  exact hp.ne_one hpone

/-- Exact localization: a prime power in the product lies on one and only one
of the two large adjacent endpoints. -/
theorem prime_pow_dvd_exactly_one_largeEndpoint_or_c
    (P : ABCPoint) {p k : ℕ}
    (hp : p.Prime) (hk : 0 < k)
    (hpow : p ^ k ∣ P.largeEndpoint * P.c) :
    (p ^ k ∣ P.largeEndpoint ∨ p ^ k ∣ P.c) ∧
      ¬ (p ^ k ∣ P.largeEndpoint ∧ p ^ k ∣ P.c) := by
  exact ⟨P.prime_pow_dvd_largeEndpoint_or_c hp hk hpow,
    P.not_prime_pow_dvd_largeEndpoint_and_c hp hk⟩

/-- Every violation of the strong coefficient-one bound forces a prime cube
on exactly one large endpoint. -/
theorem exists_prime_cube_on_exactly_one_largeEndpoint_of_strong_violation
    (P : ABCPoint)
    (hviolation : P.conductor + Real.log 2 / 2 < P.height) :
    ∃ p : ℕ, p.Prime ∧
      ((p ^ 3 ∣ P.largeEndpoint ∨ p ^ 3 ∣ P.c) ∧
        ¬ (p ^ 3 ∣ P.largeEndpoint ∧ p ^ 3 ∣ P.c)) := by
  obtain ⟨p, hp, hpow⟩ :=
    P.exists_prime_cube_dvd_largeProduct_of_strong_violation hviolation
  exact ⟨p, hp,
    P.prime_pow_dvd_exactly_one_largeEndpoint_or_c hp (by norm_num) hpow⟩

end ABCPoint

#print axioms ABCPoint.largeEndpoint_coprime_c
#print axioms ABCPoint.prime_pow_dvd_largeEndpoint_or_c
#print axioms ABCPoint.not_prime_pow_dvd_largeEndpoint_and_c
#print axioms ABCPoint.prime_pow_dvd_exactly_one_largeEndpoint_or_c
#print axioms ABCPoint.exists_prime_cube_on_exactly_one_largeEndpoint_of_strong_violation

end
end IUTThreeClosures
