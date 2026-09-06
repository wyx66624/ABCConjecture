import EisensteinDescent

/-!
Author: ChatGPT. Exact full-premise boundary gcd and strong divisibility.
No global ABC estimate is assumed or concluded.
-/
set_option autoImplicit false
namespace ABCEisenstein20260905

theorem nat_gcd_product (a b t : Nat) (hab : Nat.gcd a b=1) :
    Nat.gcd (a*b) t=Nat.gcd a t*Nat.gcd b t := by
  apply Nat.dvd_antisymm
  · exact Nat.gcd_mul_left_dvd_mul_gcd t a b
  · have hg : Nat.gcd (Nat.gcd a t) (Nat.gcd b t)=1 := by
      apply Nat.gcd_eq_one_iff.mpr
      intro d hda hdb
      exact Nat.gcd_eq_one_iff.mp hab d
        (Nat.dvd_trans hda (Nat.gcd_dvd_left a t))
        (Nat.dvd_trans hdb (Nat.gcd_dvd_left b t))
    have ht : Nat.gcd a t*Nat.gcd b t ∣ t := by
      have hh := Nat.lcm_dvd (Nat.gcd_dvd_right a t) (Nat.gcd_dvd_right b t)
      simpa [Nat.lcm_eq_mul_div,hg] using hh
    exact Nat.dvd_gcd
      (Nat.mul_dvd_mul (Nat.gcd_dvd_left a t) (Nat.gcd_dvd_left b t)) ht

theorem int_gcd_product (a b t : Int) (hab : Int.gcd a b=1) :
    Int.gcd (a*b) t=Int.gcd a t*Int.gcd b t := by
  simpa [Int.gcd_eq_natAbs_gcd_natAbs,Int.natAbs_mul] using
    nat_gcd_product a.natAbs b.natAbs t.natAbs hab

theorem int_gcd_cancel (a b t : Int) (hab : Int.gcd a b=1) :
    Int.gcd a (b*t)=Int.gcd a t := by
  simpa [Int.gcd_eq_natAbs_gcd_natAbs,Int.natAbs_mul] using
    (Nat.gcd_mul_right_right_of_gcd_eq_one (k:=t.natAbs) hab)

theorem int_gcd_cancel_cube (a b t : Int) (hab : Int.gcd a b=1) :
    Int.gcd a (t*b^3)=Int.gcd a t := by
  have hb : Int.gcd a (b^3)=1 := by
    simpa [Int.gcd_eq_natAbs_gcd_natAbs,Int.natAbs_pow] using
      (Nat.gcd_pow_right_of_gcd_eq_one (k:=3) hab)
  rw [Int.mul_comm t (b^3)]
  exact int_gcd_cancel a (b^3) t hb

theorem gcd_of_remainder (a b c : Int) (h : a ∣ b-c) :
    Int.gcd a b=Int.gcd a c := by
  have hh := Int.gcd_add_left_right_of_dvd c h
  simpa using hh

theorem boundary_gcd (u v x y : Int) (hxy : Int.gcd x y=1) :
    Int.gcd (boundary (x,y)) (boundary (mul (u,v) (x,y))) =
    Int.gcd (boundary (x,y)) (boundary (u,v)) := by
  let T := boundary (mul (u,v) (x,y))
  let A := boundary (u,v)
  have hxS : Int.gcd x (x+y)=1 := by simpa using hxy
  have hyS : Int.gcd y (x+y)=1 := by
    simpa [Int.gcd_comm] using hxy
  have hSy : Int.gcd (x+y) y=1 := by simpa using hxy
  have hprod : Int.gcd (x*y) (x+y)=1 := by
    rw [int_gcd_product x y (x+y) hxy,hxS,hyS]
  have hx : Int.gcd x T=Int.gcd x A := by
    have hd : x ∣ T-(-(A*y^3)) := by
      simpa [T,A] using boundary_remainder_x u v x y
    rw [gcd_of_remainder x T (-(A*y^3)) hd,Int.gcd_neg]
    exact int_gcd_cancel_cube x y A hxy
  have hy : Int.gcd y T=Int.gcd y A := by
    have hd : y ∣ T-A*x^3 := boundary_remainder_y u v x y
    rw [gcd_of_remainder y T (A*x^3) hd]
    apply int_gcd_cancel_cube
    simpa [Int.gcd_comm] using hxy
  have hS : Int.gcd (x+y) T=Int.gcd (x+y) A := by
    have hd : x+y ∣ T-A*y^3 := boundary_remainder_sum u v x y
    rw [gcd_of_remainder (x+y) T (A*y^3) hd]
    exact int_gcd_cancel_cube (x+y) y A hSy
  change Int.gcd ((x*y)*(x+y)) T=Int.gcd ((x*y)*(x+y)) A
  rw [int_gcd_product (x*y) (x+y) T hprod,
    int_gcd_product (x*y) (x+y) A hprod,
    int_gcd_product x y T hxy,int_gcd_product x y A hxy,hx,hy,hS]

theorem gcd_seven_of_nonzero_residue (y : Int) (hy : y%7≠0) : Int.gcd y 7=1 := by
  have he : y=y%7+7*(y/7) := by omega
  have hh : Int.gcd y 7=Int.gcd (y%7) 7 := by
    calc
      Int.gcd y 7 = Int.gcd (y%7+7*(y/7)) 7 := congrArg (fun z => Int.gcd z 7) he
      _ = Int.gcd (y%7) 7 := Int.gcd_add_mul_left_left 7 (y%7) (y/7)
  rw [hh]
  have hr : y%7=1 ∨ y%7=2 ∨ y%7=3 ∨ y%7=4 ∨ y%7=5 ∨ y%7=6 := by omega
  rcases hr with h|h|h|h|h|h <;> rw [h] <;> decide

theorem orbit_primitive (n : Nat) : Int.gcd (orbit n).1 (orbit n).2=1 := by
  cases n with
  | zero => decide
  | succ n =>
    let x := (orbit (n+1)).1
    let y := (orbit (n+1)).2
    let d := Int.gcd x y
    have hdx : (d:Int) ∣ x := Int.gcd_dvd_left x y
    have hdy : (d:Int) ∣ y := Int.gcd_dvd_right x y
    have hn : (d:Int) ∣ norm (orbit (n+1)) := by
      obtain ⟨s,hs⟩ := hdx
      obtain ⟨t,ht⟩ := hdy
      refine ⟨(d:Int)*(s*s+s*t+t*t),?_⟩
      change x*x+x*y+y*y=(d:Int)*((d:Int)*(s*s+s*t+t*t))
      rw [hs,ht]
      grind
    rw [orbit_norm] at hn
    have hdpow : d ∣ 7^(n+1) := by
      have hh := Int.natAbs_dvd_natAbs.mpr hn
      simpa using hh
    have hy7 : Int.gcd y 7=1 :=
      gcd_seven_of_nonzero_residue y (orbit_mod_seven n).2
    have hd7 : Nat.gcd d 7=1 := by
      have hh := Int.gcd_dvd_gcd_of_dvd_left (7:Int) hdy
      change Nat.gcd d 7 ∣ Int.gcd y 7 at hh
      rw [hy7] at hh
      exact Nat.dvd_one.mp hh
    have hp := Nat.gcd_pow_right_of_gcd_eq_one (k:=n+1) hd7
    rw [Nat.gcd_eq_left_iff_dvd.mpr hdpow] at hp
    exact hp

def mass (n : Nat) : Nat := (boundary (orbit n)).natAbs

theorem mass_gcd_add (m n : Nat) :
    Nat.gcd (mass m) (mass (m+n))=Nat.gcd (mass m) (mass n) := by
  have hh := boundary_gcd (orbit n).1 (orbit n).2
    (orbit m).1 (orbit m).2 (orbit_primitive m)
  change Int.gcd (boundary (orbit m)) (boundary (mul (orbit n) (orbit m))) =
    Int.gcd (boundary (orbit m)) (boundary (orbit n)) at hh
  rw [orbit_add,Nat.add_comm n m] at hh
  exact hh

theorem mass_gcd_multiple (m r q : Nat) :
    Nat.gcd (mass m) (mass (r+q*m))=Nat.gcd (mass m) (mass r) := by
  induction q with
  | zero => simp
  | succ q ih =>
    have he : r+(q+1)*m=m+(r+q*m) := by grind
    rw [he,mass_gcd_add,ih]

theorem mass_strong_divisibility (m n : Nat) :
    Nat.gcd (mass m) (mass n)=mass (Nat.gcd m n) := by
  induction m,n using Nat.gcd.induction with
  | H0 n => simp [mass,orbit,boundary]
  | H1 m n _ ih =>
    have he : n=n%m+(n/m)*m := by
      simpa [Nat.mul_comm] using (Nat.mod_add_div n m).symm
    calc
      Nat.gcd (mass m) (mass n) = Nat.gcd (mass m) (mass (n%m)) := by
        have hn := congrArg mass he
        rw [hn]
        exact mass_gcd_multiple m (n%m) (n/m)
      _ = Nat.gcd (mass (n%m)) (mass m) := Nat.gcd_comm _ _
      _ = mass (Nat.gcd (n%m) m) := ih
      _ = mass (Nat.gcd m n) := congrArg mass (Nat.gcd_rec m n).symm

#print axioms nat_gcd_product
#print axioms int_gcd_product
#print axioms int_gcd_cancel
#print axioms int_gcd_cancel_cube
#print axioms gcd_of_remainder
#print axioms boundary_gcd
#print axioms gcd_seven_of_nonzero_residue
#print axioms orbit_primitive
#print axioms mass_gcd_add
#print axioms mass_gcd_multiple
#print axioms mass_strong_divisibility
end ABCEisenstein20260905
