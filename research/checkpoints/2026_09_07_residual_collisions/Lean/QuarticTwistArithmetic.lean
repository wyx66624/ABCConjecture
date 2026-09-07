import Std

/-!
Integer arithmetic from the independently reviewed two-isogeny descent in
independent_route/third_round/quartic_square_geometry.md. These local
obstructions do not formalize the elliptic group or the complete descent.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCQuarticTwistArithmetic20260907

def quartic (A B C u v : Int) : Int := A*u^4+B*u^2*v^2+C*v^4

def bad16 (r : Int) : Prop := r = 2 ∨ r = 6 ∨ r = 8 ∨ r = 14
instance (r : Int) : Decidable (bad16 r) := inferInstanceAs
  (Decidable (r = 2 ∨ r = 6 ∨ r = 8 ∨ r = 14))

theorem square_residue_table : ∀ w : Fin 16,
    ((w.val : Int)^2)%16 = 0 ∨ ((w.val : Int)^2)%16 = 1 ∨
    ((w.val : Int)^2)%16 = 4 ∨ ((w.val : Int)^2)%16 = 9 := by decide

theorem dual_parity_tables : ∀ u v : Fin 16,
    ¬ (u.val % 2 = 0 ∧ v.val % 2 = 0) →
    bad16 (quartic 2 (-4) 8 u.val v.val % 16) ∧
    bad16 (quartic 2 (-12) 72 u.val v.val % 16) ∧
    bad16 (quartic 6 (-12) 24 u.val v.val % 16) := by decide

theorem quartic_mod (A B C u v m : Int) :
    quartic A B C u v % m = quartic A B C (u%m) (v%m) % m := by
  simp [quartic, Int.pow_succ, Int.pow_zero, Int.add_emod, Int.mul_emod]

theorem primitive_not_both_zero_mod (u v p : Int) (hp : ¬ p ∣ 1)
    (hg : Int.gcd u v = 1) : ¬ (u%p = 0 ∧ v%p = 0) := by
  rintro ⟨hu,hv⟩
  exact hp (Int.gcd_eq_one_iff.mp hg p
    (Int.dvd_of_emod_eq_zero hu) (Int.dvd_of_emod_eq_zero hv))

theorem integer_square_not_bad16 (w : Int) : ¬ bad16 (w^2%16) := by
  let fw : Fin 16 := ⟨(w%16).toNat, by omega⟩
  have he : (fw.val : Int) = w%16 := by dsimp [fw]; omega
  have h := square_residue_table fw
  rw [he] at h
  have hm : w^2%16 = (w%16)^2%16 := by
    simp [Int.pow_succ, Int.pow_zero, Int.mul_emod]
  rw [hm]
  dsimp [bad16]
  omega

theorem primitive_dual_rhs_bad16 (u v : Int) (hg : Int.gcd u v = 1) :
    bad16 (quartic 2 (-4) 8 u v % 16) ∧
    bad16 (quartic 2 (-12) 72 u v % 16) ∧
    bad16 (quartic 6 (-12) 24 u v % 16) := by
  let fu : Fin 16 := ⟨(u%16).toNat, by omega⟩
  let fv : Fin 16 := ⟨(v%16).toNat, by omega⟩
  have hu : (fu.val : Int) = u%16 := by dsimp [fu]; omega
  have hv : (fv.val : Int) = v%16 := by dsimp [fv]; omega
  have hp := primitive_not_both_zero_mod u v 2 (by decide) hg
  have hpar : ¬ (fu.val%2=0 ∧ fv.val%2=0) := by
    dsimp [fu, fv]
    omega
  have h := dual_parity_tables fu fv hpar
  rw [hu, hv] at h
  rw [quartic_mod 2 (-4) 8 u v 16, quartic_mod 2 (-12) 72 u v 16,
    quartic_mod 6 (-12) 24 u v 16]
  exact h

theorem three_dual_class_exclusions (u v w : Int) (hg : Int.gcd u v = 1) :
    w^2 ≠ quartic 2 (-4) 8 u v ∧
    w^2 ≠ quartic 2 (-12) 72 u v ∧
    w^2 ≠ quartic 6 (-12) 24 u v := by
  have h := primitive_dual_rhs_bad16 u v hg
  have hw := integer_square_not_bad16 w
  constructor
  · intro he; rw [he] at hw; exact hw h.1
  constructor
  · intro he; rw [he] at hw; exact hw h.2.1
  · intro he; rw [he] at hw; exact hw h.2.2

theorem mod_three_table : ∀ u v : Fin 3,
    ¬ (u.val = 0 ∧ v.val = 0) →
    quartic 1 (-4) 16 u.val v.val % 3 = 1 := by decide

theorem square_zero_mod_three (w : Int) (hw : w^2%3 = 0) : w%3 = 0 := by
  have hm : w^2%3 = (w%3)^2%3 := by
    simp [Int.pow_succ, Int.pow_zero, Int.mul_emod]
  rw [hm] at hw
  have hr : w%3=0 ∨ w%3=1 ∨ w%3=2 := by omega
  rcases hr with h | h | h
  · exact h
  · rw [h] at hw; contradiction
  · rw [h] at hw; contradiction

theorem dual_three_class_exclusion (u v w : Int) (hg : Int.gcd u v = 1) :
    w^2 ≠ quartic 3 (-12) 48 u v := by
  intro he
  have hz : w^2%3=0 := by
    rw [he]
    simp [quartic, Int.add_emod, Int.mul_emod]
  have hw := square_zero_mod_three w hz
  obtain ⟨k,hk⟩ := Int.dvd_of_emod_eq_zero hw
  have hdiv : 3*k^2 = quartic 1 (-4) 16 u v := by
    rw [hk] at he
    dsimp [quartic] at *
    grind
  let fu : Fin 3 := ⟨(u%3).toNat, by omega⟩
  let fv : Fin 3 := ⟨(v%3).toNat, by omega⟩
  have hu : (fu.val : Int) = u%3 := by dsimp [fu]; omega
  have hv : (fv.val : Int) = v%3 := by dsimp [fv]; omega
  have hp := primitive_not_both_zero_mod u v 3 (by decide) hg
  have hpar : ¬ (fu.val=0 ∧ fv.val=0) := by dsimp [fu, fv]; omega
  have ht := mod_three_table fu fv hpar
  rw [hu, hv, ← quartic_mod] at ht
  rw [← hdiv] at ht
  simp at ht

def firstNorm (a b : Int) : Int := a^2+a*b+b^2
def secondNorm (a b : Int) : Int := a^4+3*a^3*b+5*a^2*b^2+3*a*b^3+b^4

theorem reciprocal_twist_identity (a b : Int) :
    (2*a^2+3*a*b+2*b^2)^4 +
      2*(2*a^2+3*a*b+2*b^2)^2*(a*b)^2 - 3*(a*b)^4 =
    16*firstNorm a b*secondNorm a b*(a+b)^2 := by
  dsimp [firstNorm, secondNorm]
  grind

theorem actual_square_second_norm : secondNorm 101 355 = 192529^2 := by decide

#print axioms square_residue_table
#print axioms dual_parity_tables
#print axioms quartic_mod
#print axioms primitive_not_both_zero_mod
#print axioms integer_square_not_bad16
#print axioms primitive_dual_rhs_bad16
#print axioms three_dual_class_exclusions
#print axioms mod_three_table
#print axioms square_zero_mod_three
#print axioms dual_three_class_exclusion
#print axioms reciprocal_twist_identity
#print axioms actual_square_second_norm
end ABCQuarticTwistArithmetic20260907
