import QuarticSupportArithmetic

/-! The independently reviewed integral bridge for the actual residual
square class thirteen. The elliptic rational group classification is not
assumed implicitly and is not formalized by these arithmetic identities. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCThirteenMapArithmetic20260907
open ABCLocalPowerArithmetic20260907 ABCQuarticSupportArithmetic20260907

def complement (a b : Int) : Int := 7*a^2+12*a*b+7*b^2
def mapU (a b s : Int) : Int := 13*(complement a b-26*s)
def mapV (a b s : Int) : Int := 13*mapU a b s*(a+b)

theorem complement_identity (a b : Int) :
    (complement a b)^2+3*(a-b)^4=52*second a b := by
  rw [second_quartic]
  dsimp [complement]
  grind

theorem complement_sum_identity (a b : Int) :
    (a-b)^2+13*(a+b)^2=2*complement a b := by
  dsimp [complement]
  grind

theorem integral_map_identity (a b s : Int) :
    (mapV a b s)^2-(mapU a b s)^3+
      13*(mapU a b s)^2*(a-b)^2+507*mapU a b s*(a-b)^4 =
      8788*mapU a b s*(second a b-13*s^2) := by
  rw [second_quartic]
  dsimp [mapU,mapV,complement]
  grind

theorem actual_weighted_curve (a b s : Int) (hf : second a b=13*s^2) :
    (mapV a b s)^2=(mapU a b s)^3-
      13*(mapU a b s)^2*(a-b)^2-507*mapU a b s*(a-b)^4 := by
  have h := integral_map_identity a b s
  rw [hf] at h
  grind

theorem actual_mapU_nonzero (a b s : Int)
    (hf : second a b=13*s^2) (hc : a-b ≠ 0) : mapU a b s ≠ 0 := by
  intro hu
  have hi := complement_identity a b
  have ha : complement a b=26*s := by dsimp [mapU] at hu; omega
  rw [hf,ha] at hi
  have h4 : (a-b)^4=0 := by grind
  have hsq : (a-b)^2 ≠ 0 := by
    simpa [Int.pow_succ,Int.pow_zero] using Int.mul_ne_zero hc hc
  have hsq4 : (a-b)^2*(a-b)^2 ≠ 0 := Int.mul_ne_zero hsq hsq
  have he : (a-b)^4=(a-b)^2*(a-b)^2 := by grind
  rw [he] at h4
  exact hsq4 h4

theorem actual_nontrivial_integral_point (a b s : Int)
    (hf : second a b=13*s^2) (hc : a-b ≠ 0) :
    ∃ U V c : Int, U ≠ 0 ∧ c ≠ 0 ∧
      V^2=U^3-13*U^2*c^2-507*U*c^4 := by
  exact ⟨mapU a b s,mapV a b s,a-b,
    actual_mapU_nonzero a b s hf hc,hc,actual_weighted_curve a b s hf⟩

/-- An explicit conditional interface. The antecedent is an open formal
obligation here, separately proved by ordinary elliptic descent. -/
theorem diagonal_of_integral_point_obstruction
    (hE : ∀ U V c : Int, c ≠ 0 →
      V^2=U^3-13*U^2*c^2-507*U*c^4 → U=0)
    (a b s : Int) (hf : second a b=13*s^2) : a=b := by
  by_cases hc : a-b=0
  · omega
  · exact False.elim (actual_mapU_nonzero a b s hf hc
      (hE (mapU a b s) (mapV a b s) (a-b) hc (actual_weighted_curve a b s hf)))

#print axioms complement_identity
#print axioms complement_sum_identity
#print axioms integral_map_identity
#print axioms actual_weighted_curve
#print axioms actual_mapU_nonzero
#print axioms actual_nontrivial_integral_point
#print axioms diagonal_of_integral_point_obstruction
end ABCThirteenMapArithmetic20260907
