import Std

/-!
Author: ChatGPT. September 5, 2026.
Scoped formalization accompanying the norm-seven rank/depth continuation.
The local valuation laws, finite-field order argument, and their translation
into the actual radical are proved in the paper, not assumed as Lean axioms.
This file does not state or prove ABCConjecture.
-/
set_option autoImplicit false
set_option maxRecDepth 100000
set_option maxHeartbeats 4000000
namespace ABCRankDepth20260905

def FirstIndex (f : Nat → Nat) (m d : Nat) : Prop :=
  0 < d ∧ m ∣ f d ∧ ∀ k, 0 < k → m ∣ f k → d ≤ k

theorem first_index_support (f : Nat → Nat) (m d n : Nat)
    (hs : ∀ i j, Nat.gcd (f i) (f j) = f (Nat.gcd i j))
    (hf : FirstIndex f m d) : m ∣ f n ↔ d ∣ n := by
  rcases hf with ⟨hd, hmd, hmin⟩
  constructor
  · intro hmn
    have hc : m ∣ f (Nat.gcd d n) := by
      rw [← hs]
      exact Nat.dvd_gcd hmd hmn
    have hlo := hmin (Nat.gcd d n) (Nat.gcd_pos_of_pos_left n hd) hc
    have hhi := Nat.gcd_le_left n hd
    have heq : Nat.gcd d n = d := by omega
    exact Nat.gcd_eq_left_iff_dvd.mp heq
  · intro hdn
    have heq : Nat.gcd d n = d := Nat.gcd_eq_left_iff_dvd.mpr hdn
    have heqf : Nat.gcd (f d) (f n) = f d := by rw [hs, heq]
    exact Nat.dvd_trans hmd (Nat.gcd_eq_left_iff_dvd.mp heqf)

theorem positive_product_bound (x y : Nat) (hx : 1 ≤ x) (hy : 1 ≤ y) :
    x + y ≤ x*y + 1 := by
  have ex : x=(x-1)+1 := by omega
  have ey : y=(y-1)+1 := by omega
  rw [ex,ey]
  simp only [Nat.add_mul,Nat.mul_add,Nat.one_mul,Nat.mul_one]
  omega

theorem boundary_norm_identity (x y : Nat) (hx : 1 ≤ x) (hy : 1 ≤ y) :
    x*y*(x+y)+1 = x*x+x*y+y*y+(x+y+1)*((x-1)*(y-1)) := by
  have ex : x=(x-1)+1 := by omega
  have ey : y=(y-1)+1 := by omega
  rw [ex,ey]
  simp only [Nat.add_sub_cancel]
  grind

theorem boundary_dominates_norm (x y : Nat) (hx : 1 ≤ x) (hy : 1 ≤ y) :
    x*x+x*y+y*y ≤ x*y*(x+y)+1 := by
  have h := boundary_norm_identity x y hx hy
  omega

theorem height_square_boundary (x y : Nat) (hx : 1 ≤ x) (hy : 1 ≤ y) :
    (x+y)^2 ≤ 2*(x*y*(x+y)) := by
  have h1 := positive_product_bound x y hx hy
  have hxy : 1 ≤ x*y := by
    have h := Nat.mul_le_mul hx hy
    simpa using h
  have h2 : x+y ≤ 2*(x*y) := by omega
  have h3 := Nat.mul_le_mul_right (x+y) h2
  simpa only [Nat.pow_two,Nat.mul_assoc] using h3

theorem exponent_two_excess (p s : Nat) (hp : 1 ≤ p) :
    p^s ≤ p^2 * p^(s-2) := by
  cases s with
  | zero =>
    have h := Nat.mul_le_mul hp hp
    simpa [Nat.pow_two] using h
  | succ s =>
    cases s with
    | zero =>
      have h := Nat.mul_le_mul_left p hp
      simpa [Nat.pow_two] using h
    | succ s =>
      have he : s+1+1-2=s := by omega
      rw [he]
      have he2 : s+1+1=s+2 := by omega
      rw [he2,Nat.pow_add,Nat.mul_comm]

structure Datum where
  p : Nat
  first : Nat
  lift : Nat

def full (xs : List Datum) : Nat :=
  (xs.map fun t => t.p^(t.first+t.lift)).prod

def support (xs : List Datum) : Nat := (xs.map fun t => t.p).prod

def lifting (xs : List Datum) : Nat := (xs.map fun t => t.p^t.lift).prod

def deep (xs : List Datum) : Nat := (xs.map fun t => t.p^(t.first-2)).prod

theorem multiplicity_square_bound (xs : List Datum)
    (hp : ∀ t ∈ xs, 1 ≤ t.p) :
    full xs ≤ support xs ^ 2 * lifting xs * deep xs := by
  induction xs with
  | nil => simp [full,support,lifting,deep]
  | cons t ts ih =>
    have ht : 1 ≤ t.p := hp t (by simp)
    have hts : ∀ q ∈ ts, 1 ≤ q.p := by
      intro q hq
      exact hp q (by simp [hq])
    have hfirst := exponent_two_excess t.p t.first ht
    have hrow : t.p^(t.first+t.lift) ≤
        (t.p^2*t.p^(t.first-2))*t.p^t.lift := by
      rw [Nat.pow_add]
      exact Nat.mul_le_mul_right _ hfirst
    have h := Nat.mul_le_mul hrow (ih hts)
    simpa only [full,support,lifting,deep,List.map_cons,List.prod_cons,
      Nat.mul_pow,Nat.mul_assoc,Nat.mul_comm,Nat.mul_left_comm] using h

theorem square_first_is_harmless (xs : List Datum)
    (hs : ∀ t ∈ xs, t.first ≤ 2) : deep xs = 1 := by
  induction xs with
  | nil => rfl
  | cons t ts ih =>
    have ht : t.first-2=0 := by have := hs t (by simp); omega
    have hts : ∀ q ∈ ts, q.first ≤ 2 := by
      intro q hq
      exact hs q (by simp [hq])
    simp [deep,ht,show (ts.map fun t => t.p^(t.first-2)).prod=1 from ih hts]

theorem height_depth_bridge (H U n R D : Nat)
    (hgeom : H^2 ≤ 12*U) (hledger : U ≤ n*R^2*D) :
    H^2 ≤ 12*n*R^2*D := by
  have h := Nat.mul_le_mul_left 12 hledger
  exact Nat.le_trans hgeom (by simpa only [Nat.mul_assoc] using h)

theorem cubic_free_height_bridge (H U n R : Nat)
    (hgeom : H^2 ≤ 12*U) (hledger : U ≤ n*R^2) :
    H^2 ≤ 12*n*R^2 := by
  have h := Nat.mul_le_mul_left 12 hledger
  exact Nat.le_trans hgeom (by simpa only [Nat.mul_assoc] using h)

def mulMod (a b : Nat × Nat) (m : Nat) : Nat × Nat :=
  (((a.1*b.1)%m+m-(a.2*b.2)%m)%m,
   (a.1*b.2+a.2*b.1+a.2*b.2)%m)

def powerMod (n m : Nat) : Nat × Nat :=
  if _h : n=0 then (1%m,0) else
    let r := powerMod (n/2) m
    let s := mulMod r r m
    if n%2=0 then s else mulMod s (1,18) m
termination_by n
decreasing_by exact Nat.div_lt_self (by omega) (by decide)

def trialCertificate (p : Nat) : Bool :=
  (List.range 197).all (fun d => decide (d < 2 ∨ p%d ≠ 0))

theorem prime_trial_certificate : trialCertificate 38629 = true := by decide

theorem rank_factorization : (12876 : Nat) = 2^2*3*29*37 := by decide

theorem modulus_identity :
    (38629 : Nat)^2=1492199641 ∧ 38629^3=57642179932189 := by decide

theorem full_period_certificate : powerMod 12876 38629=(1,0) := by decide

theorem proper_period_certificates :
    powerMod 6438 38629=(25926,25406) ∧
    powerMod 4292 38629=(38628,1) ∧
    powerMod 444 38629=(10564,19690) ∧
    powerMod 348 38629=(23253,26998) := by decide

theorem square_depth_certificate :
    powerMod 12876 1492199641=(89232991,0) := by decide

theorem not_cube_depth_certificate :
    powerMod 12876 57642179932189=(43039603478354,40547540844893) := by decide

theorem nonzero_cube_coefficient : (40547540844893 : Nat) ≠ 0 := by decide

#print axioms first_index_support
#print axioms positive_product_bound
#print axioms boundary_norm_identity
#print axioms boundary_dominates_norm
#print axioms height_square_boundary
#print axioms exponent_two_excess
#print axioms multiplicity_square_bound
#print axioms square_first_is_harmless
#print axioms height_depth_bridge
#print axioms cubic_free_height_bridge
#print axioms prime_trial_certificate
#print axioms rank_factorization
#print axioms modulus_identity
#print axioms full_period_certificate
#print axioms proper_period_certificates
#print axioms square_depth_certificate
#print axioms not_cube_depth_certificate
#print axioms nonzero_cube_coefficient
end ABCRankDepth20260905
