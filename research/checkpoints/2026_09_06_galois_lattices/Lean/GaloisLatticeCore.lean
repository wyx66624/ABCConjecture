import Std

/-!
Author: ChatGPT. September 6, 2026.
Finite integer coefficient cores for the Galois height lattice.
These are NOT Jacobian, number-field, Neron--Tate or ABC formalizations.
The nonconstant witness is an explicit permutation with two distinct entries.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCGaloisLattice20260906

def agg (f : Int → Int) : List Int → Int
  | [] => 0
  | a :: xs => f a + agg f xs

def count (xs : List Int) : Int := agg (fun _ => 1) xs
def linear (xs : List Int) : Int := agg (fun a => a) xs
def squares (xs : List Int) : Int := agg (fun a => a*a) xs
def row (a : Int) (xs : List Int) : Int := agg (fun b => (a-b)*(a-b)) xs

def energy : List Int → Int
  | [] => 0
  | a :: xs => row a xs + energy xs

theorem square_nonnegative (x : Int) : 0 ≤ x*x := by
  by_cases hx : 0 ≤ x
  · exact Int.mul_nonneg hx hx
  · have hn : 0 ≤ -x := by omega
    have hp := Int.mul_nonneg hn hn
    grind

theorem square_positive (x : Int) (hx : x ≠ 0) : 1 ≤ x*x := by
  by_cases hn : 0 ≤ x
  · have h1 : 0 ≤ x-1 := by omega
    have h2 : 0 ≤ x+1 := by omega
    have hp := Int.mul_nonneg h1 h2
    grind
  · have h1 : 0 ≤ -x-1 := by omega
    have h2 : 0 ≤ -x+1 := by omega
    have hp := Int.mul_nonneg h1 h2
    grind

theorem aggregate_permutation (f : Int → Int) {xs ys : List Int}
    (h : List.Perm xs ys) : agg f xs = agg f ys := by
  induction h with
  | nil => rfl
  | cons a h ih => simp only [agg, ih]
  | swap a b xs => simp only [agg]; grind
  | trans h1 h2 ih1 ih2 => exact Eq.trans ih1 ih2

theorem row_formula (a : Int) (xs : List Int) :
    row a xs = count xs * (a*a) - 2*a*linear xs + squares xs := by
  induction xs with
  | nil => simp [row, count, linear, squares, agg]
  | cons b xs ih =>
    change (a-b)*(a-b) + row a xs =
      (1+count xs)*(a*a)-2*a*(b+linear xs)+(b*b+squares xs)
    grind

theorem variance_identity (xs : List Int) :
    count xs * squares xs - linear xs * linear xs = energy xs := by
  induction xs with
  | nil => simp [count, linear, squares, agg, energy]
  | cons a xs ih =>
    have hr := row_formula a xs
    change (1+count xs)*(a*a+squares xs) -
      (a+linear xs)*(a+linear xs) = row a xs + energy xs
    grind

theorem row_nonnegative (a : Int) (xs : List Int) : 0 ≤ row a xs := by
  induction xs with
  | nil => simp [row, agg]
  | cons b xs ih =>
    change 0 ≤ (a-b)*(a-b)+row a xs
    exact Int.add_nonneg (square_nonnegative (a-b)) ih

theorem energy_nonnegative (xs : List Int) : 0 ≤ energy xs := by
  induction xs with
  | nil => simp [energy]
  | cons a xs ih =>
    change 0 ≤ row a xs + energy xs
    exact Int.add_nonneg (row_nonnegative a xs) ih

theorem two_coordinate_separation (a b x : Int) (hab : a ≠ b) :
    1 ≤ (a-x)*(a-x)+(b-x)*(b-x) := by
  by_cases ha : a = x
  · have hb : b-x ≠ 0 := by omega
    have hp := square_positive (b-x) hb
    grind
  · have hax : a-x ≠ 0 := by omega
    have hp := square_positive (a-x) hax
    have hn := square_nonnegative (b-x)
    omega

theorem two_row_bound (a b : Int) (xs : List Int) (hab : a ≠ b) :
    count xs ≤ row a xs + row b xs := by
  induction xs with
  | nil => simp [count, row, agg]
  | cons x xs ih =>
    have hp := two_coordinate_separation a b x hab
    change 1+count xs ≤
      ((a-x)*(a-x)+row a xs)+((b-x)*(b-x)+row b xs)
    omega

theorem two_distinct_minimum (a b : Int) (xs : List Int) (hab : a ≠ b) :
    count (a::b::xs)-1 ≤ energy (a::b::xs) := by
  have hz : a-b ≠ 0 := by omega
  have hp := square_positive (a-b) hz
  have hr := two_row_bound a b xs hab
  have hn := energy_nonnegative xs
  change (1+(1+count xs))-1 ≤
    ((a-b)*(a-b)+row a xs)+(row b xs+energy xs)
  omega

theorem energy_permutation {xs ys : List Int} (h : List.Perm xs ys) :
    energy xs = energy ys := by
  have hc : count xs = count ys := aggregate_permutation (fun _ => 1) h
  have hl : linear xs = linear ys := aggregate_permutation (fun a => a) h
  have hs : squares xs = squares ys := aggregate_permutation (fun a => a*a) h
  have hvx := variance_identity xs
  have hvy := variance_identity ys
  grind

theorem nonconstant_minimum (xs : List Int)
    (h : ∃ a b : Int, ∃ tail : List Int,
      List.Perm xs (a::b::tail) ∧ a ≠ b) :
    count xs - 1 ≤ energy xs := by
  rcases h with ⟨a,b,tail,hperm,hab⟩
  have he := energy_permutation hperm
  have hc : count xs = count (a::b::tail) :=
    aggregate_permutation (fun _ => 1) hperm
  have hm := two_distinct_minimum a b tail hab
  omega

theorem five_coordinate_variance (a b c d e : Int) :
    5*(a*a+b*b+c*c+d*d+e*e)-(a+b+c+d+e)*(a+b+c+d+e) =
    (a-b)*(a-b)+(a-c)*(a-c)+(a-d)*(a-d)+(a-e)*(a-e)+
    (b-c)*(b-c)+(b-d)*(b-d)+(b-e)*(b-e)+
    (c-d)*(c-d)+(c-e)*(c-e)+(d-e)*(d-e) := by grind

theorem curve_point_identity (a b c : Int) (hc : a+b=c) :
    (a-b)*(a-b)+4*a*b=c*c := by grind

theorem compositum_coefficient_identity (u v : Int) :
    (1-u)+(1-v)-(1-u*v)=(1-u)*(1-v) := by grind

#print axioms square_nonnegative
#print axioms square_positive
#print axioms aggregate_permutation
#print axioms row_formula
#print axioms variance_identity
#print axioms row_nonnegative
#print axioms energy_nonnegative
#print axioms two_coordinate_separation
#print axioms two_row_bound
#print axioms two_distinct_minimum
#print axioms energy_permutation
#print axioms nonconstant_minimum
#print axioms five_coordinate_variance
#print axioms curve_point_identity
#print axioms compositum_coefficient_identity
end ABCGaloisLattice20260906
