import QuarticSupportArithmetic

/-! Integer consequences of the reviewed boundary-support argument.
The elliptic, modular and prime-factor implications remain ordinary inputs;
the explicit trace congruence and root bound below are not asserted here
for arbitrary actual seeds. No analytic logarithm estimate is formalized. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCBoundarySupportArithmetic20260907
open ABCLocalPowerArithmetic20260907 ABCQuarticSupportArithmetic20260907

theorem hasse_strict_interval (q t : Int) (hq : 7 ≤ q) (ht : t^2 ≤ 4*q) :
    1-q < t ∧ t < q-1 := by
  have hprod := Int.mul_nonneg (show 0 ≤ q-7 by omega) (show 0 ≤ q+1 by omega)
  have hs : 4*q < (q-1)^2 := by grind
  constructor
  · by_cases h : 1-q < t
    · exact h
    · have hp := Int.mul_nonneg (show 0 ≤ -t-(q-1) by omega)
        (show 0 ≤ -t+(q-1) by omega)
      grind
  · by_cases h : t < q-1
    · exact h
    · have hp := Int.mul_nonneg (show 0 ≤ t-(q-1) by omega)
        (show 0 ≤ t+(q-1) by omega)
      grind

theorem small_multiple_zero (p d : Int) (hl : -p < d) (hu : d < p)
    (hd : p ∣ d) : d=0 := by
  by_cases hp : 0 < d
  · have := Int.le_of_dvd hp hd
    omega
  · by_cases hn : d < 0
    · have hneg : p ∣ -d := Int.dvd_neg.mpr hd
      have := Int.le_of_dvd (show 0 < -d by omega) hneg
      omega
    · omega

theorem even_hasse_excludes_unit_residues (p t : Int) (hp : 7 < p)
    (ht : t^2 ≤ 4*p) (he : t%2=0) : ¬ (p ∣ t-1 ∨ p ∣ t+1) := by
  have hi := hasse_strict_interval p t (by omega) ht
  rintro (hm | hp')
  · have hz := small_multiple_zero p (t-1) (by omega) (by omega) hm
    omega
  · have hz := small_multiple_zero p (t+1) (by omega) (by omega) hp'
    omega

theorem odd_divisor_of_even (p d : Int) (hp : p%2=1) (he : d%2=0)
    (hd : p ∣ d) : 2*p ∣ d := by
  rcases hd with ⟨k,hk⟩
  have hk2 : k%2=0 := by
    rw [hk,Int.mul_emod,hp] at he
    omega
  rcases Int.dvd_of_emod_eq_zero hk2 with ⟨j,hj⟩
  exact ⟨j,by grind⟩

theorem even_trace_prime_cutoff (p q t : Int) (hp : p%2=1) (hq : 7 ≤ q)
    (hqo : q%2=1) (ht : t^2 ≤ 4*q) (he : t%2=0)
    (hc : p ∣ q+1-t ∨ p ∣ q+1+t) : p < q := by
  have hi := hasse_strict_interval q t hq ht
  rcases hc with hm | hp'
  · have hd := odd_divisor_of_even p (q+1-t) hp (by omega) hm
    have hl := Int.le_of_dvd (show 0 < q+1-t by omega) hd
    omega
  · have hd := odd_divisor_of_even p (q+1+t) hp (by omega) hp'
    have hl := Int.le_of_dvd (show 0 < q+1+t by omega) hd
    omega

theorem second_sum_height_identity (a b : Int) :
    (a+b)^4-second a b=a*b*(a^2+a*b+b^2) := by
  rw [second_quartic]
  grind

theorem second_le_sum_fourth (a b : Int) (ha : 0 ≤ a) (hb : 0 ≤ b) :
    second a b ≤ (a+b)^4 := by
  have hab := Int.mul_nonneg ha hb
  have ha2 := Int.pow_nonneg (m:=2) ha
  have hb2 := Int.pow_nonneg (m:=2) hb
  have hp := Int.mul_nonneg hab (show 0 ≤ a^2+a*b+b^2 by omega)
  have hi := second_sum_height_identity a b
  omega

theorem second_le_thirteen_left_fourth (a b : Int) (ha : 0 ≤ a)
    (hb : 0 ≤ b) (hba : b ≤ a) : second a b ≤ 13*a^4 := by
  have ha3 := Int.pow_nonneg (m:=3) ha
  have hb3 := Int.pow_nonneg (m:=3) hb
  have ha2b := Int.mul_nonneg (Int.pow_nonneg (m:=2) ha) hb
  have hab2 := Int.mul_nonneg ha (Int.pow_nonneg (m:=2) hb)
  have hp := Int.mul_nonneg (show 0 ≤ a-b by omega)
    (show 0 ≤ 12*a^3+9*(a^2*b)+4*(a*b^2)+b^3 by omega)
  rw [second_quartic]
  grind

theorem second_le_thirteen_height_fourth (a b : Int) (ha : 0 ≤ a)
    (hb : 0 ≤ b) : second a b ≤ 13*(max a b)^4 := by
  by_cases h : b ≤ a
  · simpa [Int.max_eq_left h] using second_le_thirteen_left_fourth a b ha hb h
  · have hi : second a b=second b a := by
      rw [second_quartic,second_quartic]
      grind
    rw [hi,Int.max_eq_right (show a ≤ b by omega)]
    exact second_le_thirteen_left_fourth b a hb ha (by omega)

/-- The root inequality is an explicit antecedent supplied by the separate
ordinary modular and local theorem, not a hidden formalized conclusion. -/
theorem pure_power_height_budget (a b : Int) (p Q : Nat)
    (ha : 0 ≤ a) (hb : 0 ≤ b) (hp : p ≠ 0) (hroot : p < Q)
    (hf : second a b=(Q : Int)^p) : (p : Int)^p < 13*(max a b)^4 := by
  have hpow := Nat.pow_lt_pow_left hroot hp
  have hi : (p : Int)^p < (Q : Int)^p := by
    exact Int.ofNat_lt.mpr hpow
  have hh := second_le_thirteen_height_fourth a b ha hb
  rw [hf] at hh
  omega

#print axioms hasse_strict_interval
#print axioms small_multiple_zero
#print axioms even_hasse_excludes_unit_residues
#print axioms odd_divisor_of_even
#print axioms even_trace_prime_cutoff
#print axioms second_sum_height_identity
#print axioms second_le_sum_fourth
#print axioms second_le_thirteen_left_fourth
#print axioms second_le_thirteen_height_fourth
#print axioms pure_power_height_budget
end ABCBoundarySupportArithmetic20260907
