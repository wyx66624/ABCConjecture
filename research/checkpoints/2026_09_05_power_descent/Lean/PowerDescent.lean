import Std

/-!
Author: ChatGPT, September 5, 2026.
A scoped formalization: an infinite first-appearance obstruction and
integer transfer lemmas conditional on an explicit radical balance.
This file neither assumes nor proves ABC. The general order/LTE-to-radical
translation and the real-valued proximity theorem are paper proofs only.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCPowerDescent20260905

def phi (x : Nat) : Nat := x*x+x+1
def step (x : Nat) : Nat := x+32*phi x
def factor (x : Nat) : Nat := 1024*x*x+1088*x+1057
def orbit : Nat → Nat
  | 0 => 226
  | k+1 => step (orbit k)

def ExactDiv (p e n : Nat) : Prop := p^e ∣ n ∧ ¬ p^(e+1) ∣ n

theorem phi_step (x : Nat) : phi (step x) = phi x * factor x := by
  unfold phi step factor
  grind

theorem step_mod49 (x : Nat) (h : x%49=30) : step x %49=30 := by
  simp [step, phi, Nat.add_mod, Nat.mul_mod, h]

theorem factor_mod49 (x : Nat) (h : x%49=30) : factor x %49=42 := by
  simp [factor, Nat.add_mod, Nat.mul_mod, h]

theorem step_mod4 (x : Nat) : step x %4=x%4 := by
  simp [step, Nat.add_mod, Nat.mul_mod]

theorem factor_decomposition (x : Nat) (h : x%49=30) :
    factor x = 7*(7*(factor x/49)+6) := by
  have hm := factor_mod49 x h
  have hd := Nat.mod_add_div (factor x) 49
  omega

theorem orbit_residues (k : Nat) : orbit k %49=30 ∧ orbit k %4=2 := by
  induction k with
  | zero => decide
  | succ k ih =>
    exact ⟨step_mod49 (orbit k) ih.1, by simpa [orbit, step_mod4] using ih.2⟩

theorem step_increases (x : Nat) : x < step x := by
  unfold step phi
  omega

theorem orbit_increases (k : Nat) : orbit k < orbit (k+1) :=
  step_increases (orbit k)

theorem orbit_lower (k : Nat) : 226 ≤ orbit k := by
  induction k with
  | zero => decide
  | succ k ih =>
    have hh := orbit_increases k
    omega

theorem orbit_unit_factor (k : Nat) :
    ∃ u : Nat, phi (orbit k) = 7^(k+2)*u ∧ (u%7=3 ∨ u%7=4) := by
  induction k with
  | zero => exact ⟨1047, by decide, by decide⟩
  | succ k ih =>
    obtain ⟨u, hu, hm⟩ := ih
    let t := factor (orbit k)/49
    have hf : factor (orbit k)=7*(7*t+6) :=
      factor_decomposition (orbit k) (orbit_residues k).1
    refine ⟨u*(7*t+6), ?_, ?_⟩
    · change phi (step (orbit k)) = 7^(k+1+2)*(u*(7*t+6))
      rw [phi_step, hu, hf]
      have he : k+1+2=(k+2)+1 := by omega
      rw [he, Nat.pow_succ]
      simp only [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
    · rcases hm with hm | hm
      · right
        simp [Nat.mul_mod, Nat.add_mod, hm]
      · left
        simp [Nat.mul_mod, Nat.add_mod, hm]

theorem exact_from_unit (p e n u : Nat) (hp : 0<p)
    (h : n=p^e*u) (hu : u%p ≠ 0) : ExactDiv p e n := by
  constructor
  · exact ⟨u,h⟩
  · intro hd
    obtain ⟨t,ht⟩ := hd
    have he : p^e*u=p^e*(p*t) := by
      rw [h, Nat.pow_succ] at ht
      simpa only [Nat.mul_assoc] using ht
    have hc : u=p*t := Nat.eq_of_mul_eq_mul_left (Nat.pow_pos hp) he
    rw [hc] at hu
    simp at hu

theorem orbit_exact_phi (k : Nat) : ExactDiv 7 (k+2) (phi (orbit k)) := by
  obtain ⟨u,hu,hm⟩ := orbit_unit_factor k
  apply exact_from_unit 7 (k+2) (phi (orbit k)) u (by decide) hu
  omega

theorem orbit_order_three (k : Nat) :
    orbit k %7=2 ∧ (orbit k)^2%7=4 ∧ (orbit k)^3%7=1 := by
  have h49 := (orbit_residues k).1
  have h7 : orbit k %7=2 := by omega
  exact ⟨h7, by simp [Nat.pow_mod,h7], by simp [Nat.pow_mod,h7]⟩

theorem mod_four_not_power (x : Nat) (hx : x%4=2) :
    ∀ y e : Nat, 2≤e → x ≠ y^e := by
  intro y e he hxy
  by_cases hy : y%2=0
  · have hy4 : y%4=0 ∨ y%4=2 := by omega
    have hp : e=(e-2)+2 := by omega
    have hs : y^2%4=0 := by
      rcases hy4 with h | h <;> simp [Nat.pow_mod,h]
    have hz : y^e%4=0 := by
      rw [hp, Nat.pow_add]
      simp [Nat.mul_mod, hs]
    omega
  · have hy1 : y%2=1 := by omega
    have hz : y^e%2=1 := by simp [Nat.pow_mod,hy1]
    have hx2 : x%2=0 := by omega
    omega

theorem orbit_not_perfect_power (k y e : Nat) (he : 2≤e) : orbit k ≠ y^e :=
  mod_four_not_power (orbit k) (orbit_residues k).2 y e he

theorem cubic_factorization (x : Nat) (hx : 1≤x) :
    x^3=1+(x-1)*phi x := by
  have he : x=(x-1)+1 := by omega
  rw [he]
  unfold phi
  grind

theorem orbit_exact_cubic_difference (k : Nat) :
    ExactDiv 7 (k+2) ((orbit k)^3-1) := by
  obtain ⟨u,hu,hm⟩ := orbit_unit_factor k
  have hl : 1≤orbit k := by have := orbit_lower k; omega
  have hi := cubic_factorization (orbit k) hl
  have hf : (orbit k)^3-1=7^(k+2)*((orbit k-1)*u) := by
    rw [hu] at hi
    have hh : (orbit k-1)*(7^(k+2)*u)=7^(k+2)*((orbit k-1)*u) := by
      simp only [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
    rw [hh] at hi
    omega
  apply exact_from_unit 7 (k+2) ((orbit k)^3-1) ((orbit k-1)*u) (by decide) hf
  have ho := (orbit_order_three k).1
  have ho1 : (orbit k-1)%7=1 := by omega
  rcases hm with hm | hm <;> simp [Nat.mul_mod, ho1, hm]

theorem infinite_first_appearance_certificate (k : Nat) :
    ∃ x : Nat, 226≤x ∧ x%4=2 ∧ x%7=2 ∧
      ExactDiv 7 (k+2) (x^3-1) ∧
      (∀ y e : Nat, 2≤e → x ≠ y^e) := by
  exact ⟨orbit k, orbit_lower k, (orbit_residues k).2,
    (orbit_order_three k).1, orbit_exact_cubic_difference k,
    fun y e he => orbit_not_perfect_power k y e he⟩

/- An exact, exponent-cleared transfer, not a substitute ABC statement. -/
theorem transfer_criterion (m K h s R0 R1 B g : Nat)
    (hB : 0<B) (hseed : h^m ≤ K*R0^(m+1))
    (hbalance : R1*B=R0*g)
    (hcritical : s^m*B^(m+1) ≤ g^(m+1)) :
    (h*s)^m ≤ K*R1^(m+1) := by
  have hp : 0<B^(m+1) := Nat.pow_pos hB
  have hh : (h*s)^m*B^(m+1) ≤ (K*R1^(m+1))*B^(m+1) := by
    calc
      (h*s)^m*B^(m+1) = h^m*(s^m*B^(m+1)) := by
        rw [Nat.mul_pow]
        simp only [Nat.mul_assoc]
      _ ≤ (K*R0^(m+1))*(s^m*B^(m+1)) := Nat.mul_le_mul_right _ hseed
      _ ≤ (K*R0^(m+1))*g^(m+1) := Nat.mul_le_mul_left _ hcritical
      _ = K*(R0*g)^(m+1) := by rw [Nat.mul_pow]; simp only [Nat.mul_assoc]
      _ = K*(R1*B)^(m+1) := by rw [hbalance]
      _ = (K*R1^(m+1))*B^(m+1) := by rw [Nat.mul_pow]; simp only [Nat.mul_assoc]
  exact Nat.le_of_mul_le_mul_right hh hp

theorem difference_subcritical (m K h s R0 R1 B g : Nat)
    (hB : 0<B) (hseed : h^m ≤ K*R0^(m+1))
    (hbalance : R1*B=R0*g) (hsg : s≤g) (hsmall : B^(m+1)≤s) :
    (h*s)^m ≤ K*R1^(m+1) := by
  apply transfer_criterion m K h s R0 R1 B g hB hseed hbalance
  calc
    s^m*B^(m+1) ≤ s^m*s := Nat.mul_le_mul_left _ hsmall
    _ = s^(m+1) := (Nat.pow_succ s m).symm
    _ ≤ g^(m+1) := Nat.pow_le_pow_left hsg

theorem sum_subcritical (m K h R0 R1 B g : Nat)
    (hB : 0<B) (hseed : h^m ≤ K*R0^(m+1))
    (hbalance : R1*B=R0*g) (hsmall : B^(m+1)≤g) :
    (h*g)^m ≤ K*R1^(m+1) :=
  difference_subcritical m K h g R0 R1 B g hB hseed hbalance (Nat.le_refl g) hsmall

theorem difference_obstruction (m K h s R0 R1 B g : Nat)
    (hB : 0<B) (hseed : h^m ≤ K*R0^(m+1))
    (hbalance : R1*B=R0*g) (hsg : s≤g)
    (hbad : K*R1^(m+1)<(h*s)^m) : s<B^(m+1) := by
  by_contra hn
  have hs : B^(m+1)≤s := by omega
  have hg := difference_subcritical m K h s R0 R1 B g hB hseed hbalance hsg hs
  omega

theorem budget_cocycle (R0 Rm RN gm gn Bm Bn BN : Nat)
    (hRN : 0<RN) (h1 : Rm*Bm=R0*gm) (h2 : RN*Bn=Rm*gn)
    (h3 : RN*BN=R0*(gm*gn)) : BN=Bm*Bn := by
  apply Nat.eq_of_mul_eq_mul_left hRN
  calc
    RN*BN = R0*(gm*gn) := h3
    _ = (Rm*Bm)*gn := by rw [h1]; simp only [Nat.mul_assoc]
    _ = (RN*Bn)*Bm := by rw [h2]; simp only [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
    _ = RN*(Bm*Bn) := by simp only [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]

theorem exchange_identity (a b x y : Int) :
    a*(x+b)^2+b*(y-a)^2 = a*x^2+b*y^2+a*b*(2*(x-y)+a+b) := by
  grind

#print axioms phi_step
#print axioms step_mod49
#print axioms factor_mod49
#print axioms step_mod4
#print axioms factor_decomposition
#print axioms orbit_residues
#print axioms step_increases
#print axioms orbit_increases
#print axioms orbit_lower
#print axioms orbit_unit_factor
#print axioms exact_from_unit
#print axioms orbit_exact_phi
#print axioms orbit_order_three
#print axioms mod_four_not_power
#print axioms orbit_not_perfect_power
#print axioms cubic_factorization
#print axioms orbit_exact_cubic_difference
#print axioms infinite_first_appearance_certificate
#print axioms transfer_criterion
#print axioms difference_subcritical
#print axioms sum_subcritical
#print axioms difference_obstruction
#print axioms budget_cocycle
#print axioms exchange_identity
end ABCPowerDescent20260905
