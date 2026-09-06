import BoundaryGcd

/-!
Author: ChatGPT. Ordinary proofs precede these scoped formalizations.
This module proves exact integer boundary identities and a finite-list
truncation identity. It does not assume or prove an analytic logarithmic-form
bound, a radical-growth conjecture, or ABCConjecture.
The list variables are explicit arithmetic data, not an asserted global model.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCMovingSupport20260906
open ABCEisenstein20260905

theorem gcd_square (a b : Int) (h : Int.gcd a b = 1) :
    Int.gcd a (b^2) = 1 := by
  simpa [Int.gcd_eq_natAbs_gcd_natAbs, Int.natAbs_pow] using
    (Nat.gcd_pow_right_of_gcd_eq_one (k:=2) h)

theorem norm_boundary_coprime (x y : Int) (h : Int.gcd x y = 1) :
    Int.gcd (norm (x,y)) (boundary (x,y)) = 1 := by
  have hyx : Int.gcd y x = 1 := by simpa [Int.gcd_comm] using h
  have hxs : Int.gcd x (x+y) = 1 := by simpa using h
  have hys : Int.gcd y (x+y) = 1 := by simpa [Int.gcd_comm] using h
  have hsy : Int.gcd (x+y) y = 1 := by simpa using h
  have hprod : Int.gcd (x*y) (x+y) = 1 := by
    rw [int_gcd_product x y (x+y) h, hxs, hys]
  have hx : Int.gcd x (norm (x,y)) = 1 := by
    have hd : x ∣ norm (x,y)-y^2 := by
      refine ⟨x+y, ?_⟩
      dsimp [norm]
      grind
    rw [gcd_of_remainder x (norm (x,y)) (y^2) hd]
    exact gcd_square x y h
  have hy : Int.gcd y (norm (x,y)) = 1 := by
    have hd : y ∣ norm (x,y)-x^2 := by
      refine ⟨x+y, ?_⟩
      dsimp [norm]
      grind
    rw [gcd_of_remainder y (norm (x,y)) (x^2) hd]
    exact gcd_square y x hyx
  have hs : Int.gcd (x+y) (norm (x,y)) = 1 := by
    have hd : x+y ∣ norm (x,y)-y^2 := by
      refine ⟨x, ?_⟩
      dsimp [norm]
      grind
    rw [gcd_of_remainder (x+y) (norm (x,y)) (y^2) hd]
    exact gcd_square (x+y) y hsy
  rw [Int.gcd_comm]
  change Int.gcd ((x*y)*(x+y)) (norm (x,y)) = 1
  rw [int_gcd_product (x*y) (x+y) (norm (x,y)) hprod,
    int_gcd_product x y (norm (x,y)) h, hx, hy, hs]

theorem cubic_boundary_identity (x y : Int) :
    (x+y)^3 - 4*boundary (x,y) = (x+y)*(x-y)^2 := by
  dsimp [boundary]
  grind

theorem cubic_boundary_upper (x y : Int) (hx : 0 ≤ x) (hy : 0 ≤ y) :
    4*boundary (x,y) ≤ (x+y)^3 := by
  have hs : 0 ≤ x+y := by omega
  have hsq : 0 ≤ (x-y)^2 := by
    have h := Int.mul_self_nonneg (x-y)
    simpa [Int.pow_two] using h
  have hmul := Int.mul_nonneg hs hsq
  have he := cubic_boundary_identity x y
  omega

theorem cubic_conjugate_coordinates (x y : Int) :
    let z : Pair := (x,y)
    let u := mul (mul z z) z
    let v := mul (mul (conjugate z) (conjugate z)) (conjugate z)
    u.1-v.1 = -3*boundary z ∧ u.2-v.2 = 6*boundary z := by
  dsimp [mul,conjugate,boundary]
  constructor <;> grind

structure Datum where
  p : Nat
  first : Nat
  lift : Nat

def full (xs : List Datum) : Nat :=
  (xs.map fun t => t.p^(t.first+t.lift)).prod

def support (xs : List Datum) : Nat :=
  (xs.map fun t => t.p).prod

def lifting (xs : List Datum) : Nat :=
  (xs.map fun t => t.p^t.lift).prod

def excess (k : Nat) (xs : List Datum) : Nat :=
  (xs.map fun t => t.p^(t.first-k)).prod

def credit (k : Nat) (xs : List Datum) : Nat :=
  (xs.map fun t => t.p^(k-t.first)).prod

theorem truncation_exponents (s l k : Nat) :
    s+l+(k-s) = k+l+(s-k) := by omega

theorem single_compensated_identity (p s l k : Nat) :
    p^(s+l)*p^(k-s) = p^k*p^l*p^(s-k) := by
  rw [← Nat.pow_add, ← Nat.pow_add, ← Nat.pow_add]
  exact congrArg (fun e => p^e) (truncation_exponents s l k)

theorem compensated_identity (xs : List Datum) (k : Nat) :
    full xs * credit k xs = support xs ^ k * lifting xs * excess k xs := by
  induction xs with
  | nil => simp [full,credit,support,lifting,excess]
  | cons t ts ih =>
    simp only [full,credit,support,lifting,excess,List.map_cons,List.prod_cons,
      Nat.mul_pow] at *
    have ht := single_compensated_identity t.p t.first t.lift k
    calc
      t.p^(t.first+t.lift) * (ts.map fun a => a.p^(a.first+a.lift)).prod *
          (t.p^(k-t.first) * (ts.map fun a => a.p^(k-a.first)).prod)
          = (t.p^(t.first+t.lift)*t.p^(k-t.first)) *
            ((ts.map fun a => a.p^(a.first+a.lift)).prod *
              (ts.map fun a => a.p^(k-a.first)).prod) := by grind
      _ = (t.p^k*t.p^t.lift*t.p^(t.first-k)) *
            ((ts.map fun a => a.p).prod^k *
              (ts.map fun a => a.p^a.lift).prod *
              (ts.map fun a => a.p^(a.first-k)).prod) := by rw [ht,ih]
      _ = _ := by grind

theorem credit_positive (xs : List Datum) (k : Nat)
    (hp : ∀ t ∈ xs, 1 ≤ t.p) : 1 ≤ credit k xs := by
  induction xs with
  | nil => simp [credit]
  | cons t ts ih =>
    have ht : 1 ≤ t.p := hp t (by simp)
    have hs : ∀ s ∈ ts, 1 ≤ s.p := by
      intro s hs
      exact hp s (by simp [hs])
    have he : 1 ≤ t.p^(k-t.first) := by
      have he := Nat.pow_le_pow_left ht (k-t.first)
      simpa using he
    have hr := Nat.mul_le_mul he (ih hs)
    simpa [credit] using hr

theorem truncated_bound (xs : List Datum) (k : Nat)
    (hp : ∀ t ∈ xs, 1 ≤ t.p) :
    full xs ≤ support xs ^ k * lifting xs * excess k xs := by
  have h := Nat.mul_le_mul_left (full xs) (credit_positive xs k hp)
  simpa only [Nat.mul_one,compensated_identity] using h

theorem cubic_height_bridge (h u r l f A : Nat)
    (hgeo : h^3 ≤ A*u) (hledger : u ≤ r^3*l*f) :
    h^3 ≤ A*r^3*l*f := by
  have hh := Nat.le_trans hgeo (Nat.mul_le_mul_left A hledger)
  simpa only [Nat.mul_assoc] using hh

theorem exact_balance_bridge (h u r l f k A : Nat)
    (hgeo : h^3 ≤ A*u) (hledger : u*k = r^3*l*f) :
    h^3*k ≤ A*r^3*l*f := by
  have hh := Nat.mul_le_mul_right k hgeo
  calc
    h^3*k ≤ (A*u)*k := hh
    _ = A*(u*k) := Nat.mul_assoc _ _ _
    _ = A*(r^3*l*f) := congrArg (fun t => A*t) hledger
    _ = A*r^3*l*f := by grind

#print axioms gcd_square
#print axioms norm_boundary_coprime
#print axioms cubic_boundary_identity
#print axioms cubic_boundary_upper
#print axioms cubic_conjugate_coordinates
#print axioms truncation_exponents
#print axioms single_compensated_identity
#print axioms compensated_identity
#print axioms credit_positive
#print axioms truncated_bound
#print axioms cubic_height_bridge
#print axioms exact_balance_bridge
end ABCMovingSupport20260906
