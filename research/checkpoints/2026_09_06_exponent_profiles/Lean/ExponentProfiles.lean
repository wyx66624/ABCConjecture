import EisensteinDescent

/-!
Author: ChatGPT. Ordinary proofs precede these scoped declarations.
This file proves regrouping in the actual integer-pair algebra, exact norm
products and universal progression divisibility. It does not assert the
external logarithmic-form estimates, Linnik's theorem, or ABCConjecture.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCExponentProfiles20260906
open ABCEisenstein20260905

def epow (z : Pair) : Nat → Pair
  | 0 => (1,0)
  | n+1 => mul (epow z n) z

def eprod : List Pair → Pair
  | [] => (1,0)
  | z :: zs => mul z (eprod zs)

theorem one_mul (z : Pair) : mul (1,0) z = z := by
  rw [mul_comm, mul_one]

theorem mul_interchange (a b c d : Pair) :
    mul (mul a b) (mul c d) = mul (mul a c) (mul b d) := by
  calc
    mul (mul a b) (mul c d) = mul a (mul b (mul c d)) := mul_assoc a b (mul c d)
    _ = mul a (mul (mul b c) d) := congrArg (mul a) (mul_assoc b c d).symm
    _ = mul a (mul (mul c b) d) := by rw [mul_comm b c]
    _ = mul a (mul c (mul b d)) := congrArg (mul a) (mul_assoc c b d)
    _ = mul (mul a c) (mul b d) := (mul_assoc a c (mul b d)).symm

theorem epow_add (z : Pair) (m n : Nat) :
    epow z (m+n) = mul (epow z m) (epow z n) := by
  induction n with
  | zero => simp [epow, mul_one]
  | succ n ih =>
    simp only [Nat.add_succ, epow, ih]
    exact mul_assoc (epow z m) (epow z n) z

theorem epow_mul (z : Pair) (m n : Nat) :
    epow z (m*n) = epow (epow z m) n := by
  induction n with
  | zero => simp [epow]
  | succ n ih =>
    rw [Nat.mul_succ, epow_add, ih]
    rfl

theorem epow_product (z w : Pair) (n : Nat) :
    epow (mul z w) n = mul (epow z n) (epow w n) := by
  induction n with
  | zero => simp [epow, mul_one]
  | succ n ih =>
    simp only [epow, ih]
    exact mul_interchange (epow z n) (epow w n) z w

theorem norm_epow (z : Pair) (n : Nat) :
    norm (epow z n) = norm z ^ n := by
  induction n with
  | zero => simp [epow, norm]
  | succ n ih => rw [epow, norm_mul, ih, Int.pow_succ]

theorem eprod_power (zs : List Pair) (k : Nat) :
    epow (eprod zs) k = eprod (zs.map fun z => epow z k) := by
  induction zs with
  | nil =>
    simp only [eprod, List.map_nil]
    induction k with
    | zero => rfl
    | succ k ih => simp [epow, ih, mul_one]
  | cons z zs ih =>
    simp only [eprod, List.map_cons]
    rw [epow_product, ih]

theorem content_extraction (xs : List (Pair × Nat)) (k : Nat) :
    eprod (xs.map fun s => epow s.1 (s.2*k)) =
      epow (eprod (xs.map fun s => epow s.1 s.2)) k := by
  induction xs with
  | nil =>
    simpa [eprod] using (eprod_power ([] : List Pair) k).symm
  | cons s xs ih =>
    simp only [List.map_cons, eprod]
    rw [epow_mul, ih, epow_product]

theorem norm_weighted_product (xs : List (Pair × Nat)) :
    norm (eprod (xs.map fun s => epow s.1 s.2)) =
      (xs.map fun s => norm s.1 ^ s.2).prod := by
  induction xs with
  | nil => simp [eprod, norm]
  | cons s xs ih =>
    simp only [List.map_cons, eprod, List.prod_cons, norm_mul, norm_epow]
    rw [ih]

def endpoint (p j : Nat) : Nat := p^4*(1+p*j)

theorem endpoint_expansion (p j : Nat) :
    endpoint p j = p^4+j*p^5 := by
  dsimp [endpoint]
  have h : p^5 = p^4*p := rfl
  rw [h]
  grind

theorem endpoint_fourth_divides (p j : Nat) : p^4 ∣ endpoint p j :=
  ⟨1+p*j, rfl⟩

theorem endpoint_fifth_not_divides (p j : Nat) (hp : 2 ≤ p) :
    ¬p^5 ∣ endpoint p j := by
  rintro ⟨s, hs⟩
  have hpos : 0 < p^4 := Nat.pow_pos (by omega : 0 < p)
  have h5 : p^5 = p^4*p := rfl
  have he : p^4*(1+p*j) = p^4*(p*s) := by
    simpa only [endpoint, h5, Nat.mul_assoc] using hs
  have hcancel : 1+p*j = p*s := Nat.eq_of_mul_eq_mul_left hpos he
  have hd : p ∣ 1+p*j := ⟨s,hcancel⟩
  have hz := Nat.mod_eq_zero_of_dvd hd
  have hrem : (1+p*j)%p = 1 := by
    simp [Nat.add_mod, Nat.mul_mod, Nat.mod_eq_of_lt (by omega : 1 < p)]
  omega

theorem endpoint_progression (p j : Nat) (hp : 2 ≤ p) :
    endpoint p j - 1 = p^4-1+j*p^5 := by
  have hpos : 0 < p^4 := Nat.pow_pos (by omega : 0 < p)
  rw [endpoint_expansion]
  omega

theorem endpoint_lower_bound (p j : Nat) : p^4 ≤ endpoint p j := by
  rw [endpoint_expansion]
  omega

theorem primitive_neighbour (n : Nat) : Nat.gcd n (n+1) = 1 := by
  simpa using Nat.gcd_add_self_right n 1

theorem compensated_shape_identity (a b : Int) :
    (a+b)^3 = (a+b)*(a-b)^2+4*a*b*(a+b) := by grind

#print axioms one_mul
#print axioms mul_interchange
#print axioms epow_add
#print axioms epow_mul
#print axioms epow_product
#print axioms norm_epow
#print axioms eprod_power
#print axioms content_extraction
#print axioms norm_weighted_product
#print axioms endpoint_expansion
#print axioms endpoint_fourth_divides
#print axioms endpoint_fifth_not_divides
#print axioms endpoint_progression
#print axioms endpoint_lower_bound
#print axioms primitive_neighbour
#print axioms compensated_shape_identity
end ABCExponentProfiles20260906
