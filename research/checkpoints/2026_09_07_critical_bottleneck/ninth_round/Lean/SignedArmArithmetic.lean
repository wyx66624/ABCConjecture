import GeneralLucasBoundary

/-! Actual arm arithmetic for the independently reviewed SA theorem.
The logarithmic-form bounds and membership in the signed compensation
class are not asserted by this module. -/
set_option autoImplicit false
set_option maxRecDepth 10000
set_option maxHeartbeats 8000000
namespace ABCSignedArmArithmetic20260907
open ABCEisenstein20260905 ABCGeneralLucasBoundary20260907

def pairCong (m : Int) (u v : Pair) : Prop :=
  u.1%m=v.1%m ∧ u.2%m=v.2%m

def scale (s : Int) (w : Pair) : Pair := (s*w.1,s*w.2)

def normalizedPower (w : Pair) (n : Nat) : Pair :=
  if n%6=1 then power w n else conjugate (power w n)

theorem add_mod_congr (m a b c d : Int) (ha : a%m=c%m) (hb : b%m=d%m) :
    (a+b)%m=(c+d)%m := by
  calc
    (a+b)%m=(a%m+b%m)%m := Int.add_emod _ _ _
    _=(c%m+d%m)%m := by rw [ha,hb]
    _=(c+d)%m := (Int.add_emod _ _ _).symm

theorem sub_mod_congr (m a b c d : Int) (ha : a%m=c%m) (hb : b%m=d%m) :
    (a-b)%m=(c-d)%m := by
  calc
    (a-b)%m=(a%m-b%m)%m := Int.sub_emod _ _ _
    _=(c%m-d%m)%m := by rw [ha,hb]
    _=(c-d)%m := (Int.sub_emod _ _ _).symm

theorem mul_mod_congr (m a b c d : Int) (ha : a%m=c%m) (hb : b%m=d%m) :
    (a*b)%m=(c*d)%m := by
  calc
    (a*b)%m=(a%m*(b%m))%m := Int.mul_emod _ _ _
    _=(c%m*(d%m))%m := by rw [ha,hb]
    _=(c*d)%m := (Int.mul_emod _ _ _).symm

theorem mul_congr (m : Int) (u v x y : Pair) (hu : pairCong m u v)
    (hx : pairCong m x y) : pairCong m (mul u x) (mul v y) := by
  rcases hu with ⟨hu₁,hu₂⟩
  rcases hx with ⟨hx₁,hx₂⟩
  constructor <;> dsimp [mul]
  · exact sub_mod_congr m _ _ _ _
      (mul_mod_congr m _ _ _ _ hu₁ hx₁) (mul_mod_congr m _ _ _ _ hu₂ hx₂)
  · exact add_mod_congr m _ _ _ _
      (add_mod_congr m _ _ _ _
        (mul_mod_congr m _ _ _ _ hu₁ hx₂) (mul_mod_congr m _ _ _ _ hu₂ hx₁))
      (mul_mod_congr m _ _ _ _ hu₂ hx₂)

theorem conjugate_congr (m : Int) (u v : Pair) (h : pairCong m u v) :
    pairCong m (conjugate u) (conjugate v) := by
  rcases h with ⟨h₁,h₂⟩
  constructor <;> dsimp [conjugate]
  · exact add_mod_congr m _ _ _ _ h₁ h₂
  · simpa only [Int.zero_sub] using sub_mod_congr m 0 u.2 0 v.2 rfl h₂

theorem power_congr (m : Int) (u v : Pair) (h : pairCong m u v) (n : Nat) :
    pairCong m (power u n) (power v n) := by
  induction n with
  | zero => exact ⟨rfl,rfl⟩
  | succ n ih => exact mul_congr m u v (power u n) (power v n) h ih

theorem normalized_power_congr (m : Int) (u v : Pair) (h : pairCong m u v)
    (n : Nat) : pairCong m (normalizedPower u n) (normalizedPower v n) := by
  unfold normalizedPower
  split
  · exact power_congr m u v h n
  · exact conjugate_congr m _ _ (power_congr m u v h n)

theorem power_add (w : Pair) (n m : Nat) :
    power w (n+m)=mul (power w n) (power w m) := by
  induction n with
  | zero => simp [power,mul_comm,mul_one]
  | succ n ih =>
    rw [Nat.succ_add]
    simp only [power,ih,mul_assoc]

theorem power_scale (s : Int) (w : Pair) (n : Nat) :
    power (scale s w) n=scale (s^n) (power w n) := by
  induction n with
  | zero => simp [power,scale]
  | succ n ih =>
    rw [power,ih]
    apply Prod.ext <;> dsimp [scale,mul,power]
    · rw [Int.pow_succ]
      grind
    · rw [Int.pow_succ]
      grind

theorem power_six_blocks (w : Pair) (h : power w 6=(1,0)) (k : Nat) :
    power w (6*k)=(1,0) := by
  induction k with
  | zero => rfl
  | succ k ih => simp [Nat.mul_succ,power_add,ih,h,mul_one]

theorem power_six_residue (w : Pair) (h : power w 6=(1,0)) (n : Nat) :
    power w n=power w (n%6) := by
  calc
    power w n=power w (n%6+6*(n/6)) := by congr 1; omega
    _=power w (n%6) := by rw [power_add,power_six_blocks w h,mul_one]

theorem normalized_zeta_arm (b : Int) (n : Nat) (hn : n%6=1 ∨ n%6=5) :
    normalizedPower (0,b) n=(0,b^n) := by
  have hs : (0,b)=scale b (0,1) := by simp [scale]
  have hp := power_six_residue (0,1) (by decide) n
  rw [hs]
  unfold normalizedPower
  rw [power_scale,hp]
  rcases hn with h | h
  · simp [h,power,mul,scale]
  · simp [h,power,mul,scale,conjugate]
    grind

theorem normalized_real_arm (a : Int) (n : Nat) :
    normalizedPower (a,0) n=(a^n,0) := by
  have hs : (a,0)=scale a (1,0) := by simp [scale]
  have hp : power (1,0) n=(1,0) := by
    induction n with
    | zero => rfl
    | succ n ih => simp [power,ih,mul_one]
  rw [hs]
  unfold normalizedPower
  rw [power_scale,hp]
  split <;> simp [scale,conjugate]

theorem normalized_sum_arm (b : Int) (n : Nat) (hn : n%6=1 ∨ n%6=5) :
    normalizedPower (-b,b) n=(-b^n,b^n) := by
  have hs : (-b,b)=scale b (-1,1) := by simp [scale]
  have hp := power_six_residue (-1,1) (by decide) n
  rw [hs]
  unfold normalizedPower
  rw [power_scale,hp]
  rcases hn with h | h
  · simp [h,power,mul,scale]
  · simp [h,power,mul,scale,conjugate]

theorem normalized_first_divisible (a b : Int) (n : Nat)
    (hn : n%6=1 ∨ n%6=5) : a ∣ (normalizedPower (a,b) n).1 := by
  have hb : pairCong a (a,b) (0,b) := by simp [pairCong]
  have h := normalized_power_congr a (a,b) (0,b) hb n
  rw [normalized_zeta_arm b n hn] at h
  exact Int.dvd_of_emod_eq_zero (by simpa using h.1)

theorem normalized_second_divisible (a b : Int) (n : Nat) :
    b ∣ (normalizedPower (a,b) n).2 := by
  have hb : pairCong b (a,b) (a,0) := by simp [pairCong]
  have h := normalized_power_congr b (a,b) (a,0) hb n
  rw [normalized_real_arm a n] at h
  exact Int.dvd_of_emod_eq_zero (by simpa using h.2)

theorem normalized_sum_divisible (a b : Int) (n : Nat)
    (hn : n%6=1 ∨ n%6=5) :
    a+b ∣ (normalizedPower (a,b) n).1+(normalizedPower (a,b) n).2 := by
  have hb : pairCong (a+b) (a,b) (-b,b) := by
    constructor
    · change a%(a+b)=(-b)%(a+b)
      calc
        a%(a+b)=((a+b)-b)%(a+b) := by congr 1; omega
        _=(-b)%(a+b) := Int.sub_emod_left _ _
    · rfl
  have h := normalized_power_congr (a+b) (a,b) (-b,b) hb n
  rw [normalized_sum_arm b n hn] at h
  have he := add_mod_congr (a+b) _ _ _ _ h.1 h.2
  have hz : -b^n+b^n=0 := by omega
  rw [hz] at he
  exact Int.dvd_of_emod_eq_zero (by simpa using he)

def armQuotients (w : Pair) (n : Nat) : Int × Int × Int :=
  let z := normalizedPower w n
  (z.1/w.1,z.2/w.2,(z.1+z.2)/(w.1+w.2))

theorem actual_arm_reconstruction (w : Pair) (n : Nat)
    (hn : n%6=1 ∨ n%6=5) :
    w.1*(armQuotients w n).1=(normalizedPower w n).1 ∧
    w.2*(armQuotients w n).2.1=(normalizedPower w n).2 ∧
    (w.1+w.2)*(armQuotients w n).2.2=
      (normalizedPower w n).1+(normalizedPower w n).2 := by
  exact ⟨Int.mul_ediv_cancel_of_dvd (normalized_first_divisible w.1 w.2 n hn),
    Int.mul_ediv_cancel_of_dvd (normalized_second_divisible w.1 w.2 n),
    Int.mul_ediv_cancel_of_dvd (normalized_sum_divisible w.1 w.2 n hn)⟩

theorem actual_arm_additive_relation (w : Pair) (n : Nat)
    (hn : n%6=1 ∨ n%6=5) :
    w.1*(armQuotients w n).1+w.2*(armQuotients w n).2.1=
      (w.1+w.2)*(armQuotients w n).2.2 := by
  have h := actual_arm_reconstruction w n hn
  omega

theorem actual_boundary_quotient_product (w : Pair) (n : Nat)
    (hn : n%6=1 ∨ n%6=5) :
    boundary (normalizedPower w n)=boundary w*
      ((armQuotients w n).1*(armQuotients w n).2.1*(armQuotients w n).2.2) := by
  have h := actual_arm_reconstruction w n hn
  dsimp [boundary]
  grind

theorem norm_conjugate (w : Pair) : norm (conjugate w)=norm w := by
  dsimp [norm,conjugate]
  grind

theorem normalized_power_norm (w : Pair) (n : Nat) :
    norm (normalizedPower w n)=(norm w)^n := by
  unfold normalizedPower
  split
  · exact norm_power w n
  · rw [norm_conjugate,norm_power]

theorem actual_quotient_norm (w : Pair) (n : Nat) (hn : n%6=1 ∨ n%6=5) :
    (w.1*(armQuotients w n).1)^2+
      (w.1*(armQuotients w n).1)*(w.2*(armQuotients w n).2.1)+
      (w.2*(armQuotients w n).2.1)^2=(norm w)^n := by
  have h := actual_arm_reconstruction w n hn
  rw [h.1,h.2.1]
  simpa only [norm,Int.pow_succ,Int.pow_zero,Int.mul_one,Int.one_mul] using
    normalized_power_norm w n

theorem coprime_divisors (a b x y : Int) (hx : x ∣ a) (hy : y ∣ b)
    (hab : Int.gcd a b=1) : Int.gcd x y=1 := by
  apply Int.gcd_eq_one_iff.mpr
  intro d hdx hdy
  exact (Int.gcd_eq_one_iff.mp hab) d (Int.dvd_trans hdx hx) (Int.dvd_trans hdy hy)

/-- Output primitivity is explicit; its number-theoretic derivation from
primitive unramified roots remains an ordinary input in this module. -/
theorem actual_quotients_pairwise_coprime (w : Pair) (n : Nat)
    (hn : n%6=1 ∨ n%6=5)
    (hprim : Int.gcd (normalizedPower w n).1 (normalizedPower w n).2=1) :
    Int.gcd (armQuotients w n).1 (armQuotients w n).2.1=1 ∧
    Int.gcd (armQuotients w n).1 (armQuotients w n).2.2=1 ∧
    Int.gcd (armQuotients w n).2.1 (armQuotients w n).2.2=1 := by
  have h := actual_arm_reconstruction w n hn
  have hd₁ : (armQuotients w n).1 ∣ (normalizedPower w n).1 := ⟨w.1,by grind⟩
  have hd₂ : (armQuotients w n).2.1 ∣ (normalizedPower w n).2 := ⟨w.2,by grind⟩
  have hd₃ : (armQuotients w n).2.2 ∣
      (normalizedPower w n).1+(normalizedPower w n).2 := ⟨w.1+w.2,by grind⟩
  refine ⟨coprime_divisors _ _ _ _ hd₁ hd₂ hprim,?_,?_⟩
  · apply coprime_divisors _ _ _ _ hd₁ hd₃
    simpa only [Int.gcd_self_add_right] using hprim
  · apply coprime_divisors _ _ _ _ hd₂ hd₃
    simpa only [Int.gcd_add_self_right,Int.gcd_comm] using hprim

/-- Exact linear kernel of SA2 for integer weights. The variables are
explicit weight budgets, not hidden formalized prime valuations or logs. -/
theorem two_arm_integer_budget (s₁ s₂ s₃ r₁ r₂ r₃ e₁ e₂ t delta l₁ l₂ : Int)
    (h₃ : s₃ ≤ t) (h₁ : t-delta-l₁ ≤ s₁) (h₂ : t-delta-l₂ ≤ s₂)
    (hr₁ : s₁-e₁ ≤ 2*r₁) (hr₂ : s₂-e₂ ≤ 2*r₂) :
    2*(s₁+s₂+s₃-3*(r₁+r₂+r₃)) ≤
      2*delta+l₁+l₂+3*(e₁+e₂)-6*r₃ := by omega

/-- A zero two-arm excess leaves the third arm's depth unrestricted. -/
theorem two_cubefree_integer_budget (s₁ s₂ s₃ r₁ r₂ r₃ t delta l₁ l₂ : Int)
    (h₃ : s₃ ≤ t) (h₁ : t-delta-l₁ ≤ s₁) (h₂ : t-delta-l₂ ≤ s₂)
    (hr₁ : s₁ ≤ 2*r₁) (hr₂ : s₂ ≤ 2*r₂) :
    2*(s₁+s₂+s₃-3*(r₁+r₂+r₃)) ≤ 2*delta+l₁+l₂-6*r₃ := by
  have h := two_arm_integer_budget s₁ s₂ s₃ r₁ r₂ r₃ 0 0 t delta l₁ l₂
    h₃ h₁ h₂ (by omega) (by omega)
  omega

def weightedDepth : List (Nat × Int) → Int
  | [] => 0
  | (e,w)::xs => (e:Int)*w+weightedDepth xs

def weightedRadical : List (Nat × Int) → Int
  | [] => 0
  | (e,w)::xs => (if e=0 then 0 else w)+weightedRadical xs

def weightedExcess : List (Nat × Int) → Int
  | [] => 0
  | (e,w)::xs => ((e-2:Nat):Int)*w+weightedExcess xs

theorem local_depth_radical_budget (e : Nat) (w : Int) (hw : 0 ≤ w) :
    (e:Int)*w-((e-2:Nat):Int)*w ≤ 2*(if e=0 then 0 else w) := by
  by_cases he : e=0
  · simp [he]
  · have hn : 0 ≤ 2-(e:Int)+((e-2:Nat):Int) := by omega
    have hm := Int.mul_nonneg hn hw
    simp only [if_neg he]
    grind

theorem finite_depth_radical_budget (xs : List (Nat × Int))
    (hw : ∀ ew ∈ xs, 0 ≤ ew.2) :
    weightedDepth xs-weightedExcess xs ≤ 2*weightedRadical xs := by
  induction xs with
  | nil => simp [weightedDepth,weightedRadical,weightedExcess]
  | cons ew xs ih =>
    rcases ew with ⟨e,w⟩
    have hhead := local_depth_radical_budget e w (hw (e,w) (by simp))
    have htail := ih (by intro ew hew; exact hw ew (by simp [hew]))
    simp only [weightedDepth,weightedRadical,weightedExcess]
    omega

/-- The two-arm ledger is instantiated with actual finite lists of depths
and nonnegative integer weights. No claim identifies these weights with
real logarithms or proves the height antecedents for all arithmetic roots. -/
theorem finite_two_arm_compensation (xs ys zs : List (Nat × Int))
    (hx : ∀ ew ∈ xs, 0 ≤ ew.2) (hy : ∀ ew ∈ ys, 0 ≤ ew.2)
    (t delta l₁ l₂ : Int) (hz : weightedDepth zs ≤ t)
    (h₁ : t-delta-l₁ ≤ weightedDepth xs)
    (h₂ : t-delta-l₂ ≤ weightedDepth ys) :
    2*(weightedDepth xs+weightedDepth ys+weightedDepth zs-
      3*(weightedRadical xs+weightedRadical ys+weightedRadical zs)) ≤
      2*delta+l₁+l₂+3*(weightedExcess xs+weightedExcess ys)-6*weightedRadical zs := by
  exact two_arm_integer_budget _ _ _ _ _ _ _ _ _ _ _ _ hz h₁ h₂
    (finite_depth_radical_budget xs hx) (finite_depth_radical_budget ys hy)

def signedExponent (e : Nat) : Int := if e=0 then 0 else (e:Int)-3

theorem local_overlap_budget (u v : Nat) :
    signedExponent (u+v) ≤ signedExponent v+(u:Int) := by
  simp only [signedExponent]
  split <;> split <;> omega

theorem weighted_overlap_budget (u v : Nat) (w : Int) (hw : 0 ≤ w) :
    signedExponent (u+v)*w ≤ signedExponent v*w+(u:Int)*w := by
  have h := local_overlap_budget u v
  have hm := Int.mul_nonneg (show 0 ≤ signedExponent v+(u:Int)-signedExponent (u+v)
    by omega) hw
  grind

#print axioms add_mod_congr
#print axioms sub_mod_congr
#print axioms mul_mod_congr
#print axioms mul_congr
#print axioms conjugate_congr
#print axioms power_congr
#print axioms normalized_power_congr
#print axioms power_add
#print axioms power_scale
#print axioms power_six_blocks
#print axioms power_six_residue
#print axioms normalized_zeta_arm
#print axioms normalized_real_arm
#print axioms normalized_sum_arm
#print axioms normalized_first_divisible
#print axioms normalized_second_divisible
#print axioms normalized_sum_divisible
#print axioms actual_arm_reconstruction
#print axioms actual_arm_additive_relation
#print axioms actual_boundary_quotient_product
#print axioms norm_conjugate
#print axioms normalized_power_norm
#print axioms actual_quotient_norm
#print axioms coprime_divisors
#print axioms actual_quotients_pairwise_coprime
#print axioms two_arm_integer_budget
#print axioms two_cubefree_integer_budget
#print axioms local_depth_radical_budget
#print axioms finite_depth_radical_budget
#print axioms finite_two_arm_compensation
#print axioms local_overlap_budget
#print axioms weighted_overlap_budget

end ABCSignedArmArithmetic20260907
