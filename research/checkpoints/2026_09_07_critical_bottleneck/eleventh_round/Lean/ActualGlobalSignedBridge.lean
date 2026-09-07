import ActualPrimeLogHeight
import Mathlib.Tactic.FieldSimp

/-! Actual finite passage from a tail cost to the global radical logarithm.
The tail and small-prime bounds remain explicit hypotheses. This does not
formalize their analytic estimates or claim arbitrary-root membership. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 4000000
noncomputable section
namespace ABCActualGlobalSignedBridge20260907
open ABCActualPrimeLogCompensation20260907
open ABCActualPrimeLogHeight20260907
open scoped BigOperators

theorem prime_weight_antitone (Y Z p : Nat) (hp : p.Prime) (hYZ : Y ≤ Z) :
    weight Z p ≤ weight Y p := by
  by_cases hZ : Z < p
  · have hY : Y < p := lt_of_le_of_lt hYZ hZ
    simp [weight, hY, hZ]
  · calc
      weight Z p = 0 := by simp [weight, hZ]
      _ ≤ weight Y p := prime_weight_nonnegative Y p hp

theorem radical_antitone (Y Z N : Nat) (hYZ : Y ≤ Z) :
    radical Z N ≤ radical Y N := by
  unfold radical
  apply Finset.sum_le_sum
  intro p hp
  exact prime_weight_antitone Y Z p (Nat.prime_of_mem_primeFactors hp) hYZ

theorem small_mass_zero_cutoff (N : Nat) : smallMass 0 N = 0 := by
  unfold smallMass Finsupp.sum
  apply Finset.sum_eq_zero
  intro p hp
  have hpos : 0 < p := (Nat.prime_of_mem_primeFactors hp).pos
  simp [Nat.not_le.mpr hpos]

theorem mass_zero_cutoff (N : Nat) : mass 0 N = Real.log N := by
  have h := mass_partition 0 N
  simpa [small_mass_zero_cutoff] using h

theorem signed_zero_cutoff (N : Nat) :
    signedCost 0 N = Real.log N - 3 * radical 0 N := by
  unfold signedCost
  rw [mass_zero_cutoff]

theorem global_signed_le_tail_plus_small (Y N : Nat) :
    signedCost 0 N ≤ signedCost Y N + smallMass Y N := by
  have hm := mass_partition Y N
  have hr := radical_antitone 0 Y N (Nat.zero_le Y)
  rw [signed_zero_cutoff]
  unfold signedCost
  linarith

theorem global_radical_height_transfer (Y N : Nat) (t delta cost low : Real)
    (hlog : 3*t-delta ≤ Real.log N)
    (htail : signedCost Y N ≤ cost) (hlow : smallMass Y N ≤ low) :
    t-(delta+cost+low)/3 ≤ radical 0 N := by
  have h := global_signed_le_tail_plus_small Y N
  rw [signed_zero_cutoff] at h
  linarith

theorem large_cutoff_numerical_transfer (Y N n : Nat) (hn : n ≠ 0)
    (t eta net : Real) (ht : 0 < t)
    (hlog : 3*t-4*t/(n : Real) ≤ Real.log N)
    (htail : signedCost Y N ≤ 39*t/(n : Real)+2*eta*t+net)
    (hlow : smallMass Y N ≤ eta*t) :
    1-43/(3*(n : Real))-eta-net/(3*t) ≤ radical 0 N/t := by
  have hnR : (n : Real) ≠ 0 := by exact_mod_cast hn
  have htR : t ≠ 0 := ne_of_gt ht
  have h := global_radical_height_transfer Y N t (4*t/(n : Real))
    (39*t/(n : Real)+2*eta*t+net) (eta*t) hlog htail hlow
  apply (le_div_iff₀ ht).2
  calc
    (1-43/(3*(n : Real))-eta-net/(3*t))*t =
        t-(4*t/(n : Real)+(39*t/(n : Real)+2*eta*t+net)+eta*t)/3 := by
      field_simp
      ring
    _ ≤ radical 0 N := h

/-- The finite SA inequality for the actual global signed prime cost.
The cutoff's full small-prime mass is paid exactly once in addition to
its half-cost in the finite tail theorem. No analytic input is assumed. -/
theorem finite_actual_global_arm_compensation (Y a b d A B C H H1 : Nat)
    (ha : a ≠ 0) (hb : b ≠ 0) (hd : d ≠ 0)
    (hA : A ≠ 0) (hB : B ≠ 0) (hC : C ≠ 0)
    (hAB : A.Coprime B) (hAC : A.Coprime C) (hBC : B.Coprime C)
    (haH1 : a ≤ H1) (hbH1 : b ≤ H1)
    (haH : a*A ≤ H) (hbH : b*B ≤ H) (hdH : d*C ≤ H) :
    signedCost 0 ((a*A)*(b*B)*(d*C)) ≤
      (3*Real.log H-Real.log ((a*A)*(b*B)*(d*C) : Nat))+
      Real.log H1+Real.log (a*b*d : Nat)+3*smallMass Y ((a*A)*(b*B)*(d*C))/2+
      3*(excess 2 Y A+excess 2 Y B)/2-3*radical Y C := by
  have hg := global_signed_le_tail_plus_small Y ((a*A)*(b*B)*(d*C))
  have hf := finite_actual_arm_compensation Y a b d A B C H H1
    ha hb hd hA hB hC hAB hAC hBC haH1 hbH1 haH hbH hdH
  linarith

#print axioms prime_weight_antitone
#print axioms radical_antitone
#print axioms small_mass_zero_cutoff
#print axioms mass_zero_cutoff
#print axioms signed_zero_cutoff
#print axioms global_signed_le_tail_plus_small
#print axioms global_radical_height_transfer
#print axioms large_cutoff_numerical_transfer
#print axioms finite_actual_global_arm_compensation
end ABCActualGlobalSignedBridge20260907
