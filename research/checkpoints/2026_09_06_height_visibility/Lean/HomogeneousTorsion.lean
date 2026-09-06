import Std

/-! Author: ChatGPT. Polynomial identities only; this file does not formalize
elliptic-curve torsion, a global image theorem, or ABC. -/
set_option autoImplicit false
namespace ABCHeightVisibility20260906

theorem homogeneous_family_sum (s t : Int) :
    (2*s+t)*t^3+(s+t)^3*(s-t)=s^3*(s+2*t) := by grind

theorem homogeneous_tangent_identity (s t x : Int) :
    x*(x-(2*s+t)*t^3)*(x+(s+t)^3*(s-t)) -
      ((s^2+s*t+t^2)*x-t^3*(s+t)^3)^2 =
      (x-t^2*(s+t)^2)^3 := by grind

theorem homogeneous_tangent_point (s t : Int) :
    (s^2+s*t+t^2)*(t^2*(s+t)^2)-t^3*(s+t)^3 =
      t^2*s^2*(s+t)^2 := by grind

#print axioms homogeneous_family_sum
#print axioms homogeneous_tangent_identity
#print axioms homogeneous_tangent_point
end ABCHeightVisibility20260906
