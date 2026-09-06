import Std

/-!
Author: ChatGPT. Ordinary mathematical proofs precede these scoped certificates.
This file does not formalize a prime-element theorem, a Siegel-zero theorem,
an infinite sieve, Riemann--Hurwitz, or ABCConjecture. Its arithmetic objects
are explicit; the degree-budget implication has its hypotheses displayed.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCCorrelatedCompletions20260906

def norm (a b : Int) : Int := a*a+a*b+b*b

theorem norm_seven_expansion (j : Int) :
    norm 1 (2+49*j) = 7+49*(5*j+49*j*j) := by
  dsimp [norm]
  grind

theorem exact_norm_seven (j : Int) :
    7 ∣ norm 1 (2+49*j) ∧ ¬49 ∣ norm 1 (2+49*j) := by
  rw [norm_seven_expansion]
  constructor
  · refine ⟨1+7*(5*j+49*j*j), ?_⟩
    grind
  · intro h
    have hz := Int.emod_eq_zero_of_dvd h
    omega

theorem forced_small_prime_residues (j : Int) :
    (6+36*j)%4=2 ∧ (6+36*j)%9=6 ∧ (7+36*j)%6=1 := by
  omega

theorem prescribed_power_divides (p k j : Nat) :
    p^k ∣ p^k*(1+p*j) := ⟨1+p*j,rfl⟩

theorem prescribed_power_exact (p k j : Nat) (hp : 2 ≤ p) :
    ¬p^(k+1) ∣ p^k*(1+p*j) := by
  rintro ⟨s,hs⟩
  have hpos : 0 < p^k := Nat.pow_pos (by omega : 0 < p)
  have he : p^k*(1+p*j)=p^k*(p*s) := by
    simpa only [Nat.pow_succ, Nat.mul_assoc] using hs
  have hc := Nat.eq_of_mul_eq_mul_left hpos he
  have hd : p ∣ 1+p*j := ⟨s,hc⟩
  have hm := Nat.mod_eq_zero_of_dvd hd
  have hr : (1+p*j)%p=1 := by
    simp [Nat.add_mod, Nat.mod_eq_of_lt (by omega : 1 < p)]
  omega

theorem completion_radical_lower (a b c G R k : Nat)
    (hG : 0 < G) (hledger : a*b*c=G*R) (hab : k*G ≤ a*b) :
    k*c ≤ R := by
  have h := Nat.mul_le_mul_right c hab
  have hh : G*(k*c) ≤ G*R := by
    calc
      G*(k*c) = (k*G)*c := by grind
      _ ≤ (a*b)*c := h
      _ = G*R := hledger
  exact Nat.le_of_mul_le_mul_left hh hG

theorem squarefree_complement_identity (G R T C E : Nat)
    (hT : T=G*R) (htrunc : T*C=R^3*E) :
    G*R*C=R^3*E := by
  simpa only [hT] using htrunc

structure Row where
  weight : Nat
  hits : Nat

def total (xs : List Row) : Nat := (xs.map fun x => x.weight).sum
def good (xs : List Row) : Nat :=
  (xs.map fun x => if x.hits=0 then x.weight else 0).sum
def incidence (xs : List Row) : Nat :=
  (xs.map fun x => x.weight*x.hits).sum

theorem weighted_union_bound (xs : List Row) :
    total xs ≤ good xs+incidence xs := by
  induction xs with
  | nil => simp [total,good,incidence]
  | cons x xs ih =>
    by_cases h : x.hits=0
    · simp only [total,good,incidence,List.map_cons,List.sum_cons,h,ite_true,
        Nat.mul_zero] at *
      omega
    · have hx : 1 ≤ x.hits := by omega
      have hw : x.weight ≤ x.weight*x.hits := by
        simpa only [Nat.mul_one] using Nat.mul_le_mul_left x.weight hx
      simp only [total,good,incidence,List.map_cons,List.sum_cons,h,ite_false] at *
      omega

theorem surviving_weight (xs : List Row)
    (hcost : 27*incidence xs ≤ 23*total xs) :
    4*total xs ≤ 27*good xs := by
  have h := weighted_union_bound xs
  omega

theorem sieve_margin : (5 : Int)*81-6*56 = 23*3 := by decide

theorem norm_square_map (x y : Int) :
    norm (x*x-y*y) (2*x*y+y*y) = (norm x y)^2 := by
  dsimp [norm]
  grind

theorem square_map_boundary (x y : Int) :
    (x*x-y*y)*(2*x*y+y*y)*(x*x+2*x*y) =
      x*y*(x+y)*(x-y)*(2*x+y)*(x+2*y) := by
  grind

theorem square_map_jacobian (x y : Int) :
    (2*x)*(2*x+2*y)-(-2*y)*(2*y)=4*norm x y := by
  dsimp [norm]
  grind

theorem ramification_budget (d s h v g : Int)
    (hdegree : h+g*v=2*d)
    (hbudget : (3*d-s)+(2*d-h-v) ≤ 2*d-2) :
    d+2+(g-1)*v ≤ s := by
  grind

theorem pure_power_new_degree (d s g m : Int)
    (hg : 2 ≤ g) (hm : 1 ≤ m) (hd : d=g*m)
    (hs : 3*d-2*m+2 ≤ s) :
    d+1 ≤ s-3 := by
  have hn : 0 ≤ (g-2)*m := Int.mul_nonneg (by omega) (by omega)
  grind

theorem degree_only_transfer_nonpositive (d D n k : Int)
    (hd : 1 ≤ d) (hD : d+1 ≤ D) (hn : 1 ≤ n) (hk : 0 ≤ k) :
    n*d-(n+k)*D < 0 := by
  have h1 : 0 ≤ n*(D-d-1) := Int.mul_nonneg (by omega) (by omega)
  have h2 : 0 ≤ k*D := Int.mul_nonneg hk (by omega)
  grind

#print axioms norm_seven_expansion
#print axioms exact_norm_seven
#print axioms forced_small_prime_residues
#print axioms prescribed_power_divides
#print axioms prescribed_power_exact
#print axioms completion_radical_lower
#print axioms squarefree_complement_identity
#print axioms weighted_union_bound
#print axioms surviving_weight
#print axioms sieve_margin
#print axioms norm_square_map
#print axioms square_map_boundary
#print axioms square_map_jacobian
#print axioms ramification_budget
#print axioms pure_power_new_degree
#print axioms degree_only_transfer_nonpositive
end ABCCorrelatedCompletions20260906
