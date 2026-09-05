import Std

/-!
Elementary cores for the September 5 third research supplement.
Author: ChatGPT.
This module does not state or assume ABCConjecture.
Natural capacities encode the discrete version of the allocation lemma;
the full real-capacity arithmetic network is not claimed formalized here.
-/
set_option autoImplicit false
namespace ABCResearch20260905

def firstAllocation (s a : Nat) : Nat := min s a

def secondAllocation (s a b : Nat) : Nat := min (s - min s a) b

theorem greedy_two_sum (s a b : Nat) :
    firstAllocation s a + secondAllocation s a b = min s (a + b) := by
  unfold firstAllocation secondAllocation
  omega

theorem greedy_two_feasible (s a b : Nat) :
    firstAllocation s a <= a /\ secondAllocation s a b <= b /\
    firstAllocation s a + secondAllocation s a b <= s := by
  unfold firstAllocation secondAllocation
  omega

theorem greedy_two_optimal (s a b x y : Nat)
    (hx : x <= a) (hy : y <= b) (hxy : x + y <= s) :
    x + y <= firstAllocation s a + secondAllocation s a b := by
  rw [greedy_two_sum]
  omega

def splitResidual (s u v r t : Nat) : Nat :=
  r + t - min s (min r u + min t v)

def singleResidual (s u v r t : Nat) : Nat :=
  r + t - min s (max (min r u) (min t v))

theorem splitting_never_worse (s u v r t : Nat) :
    splitResidual s u v r t <= singleResidual s u v r t := by
  unfold splitResidual singleResidual
  omega

theorem no_face_no_transfer (s r t : Nat) :
    splitResidual s 0 0 r t = r + t := by
  unfold splitResidual
  simp

theorem strict_abstract_example :
    splitResidual 2 1 1 1 1 = 0 /\ singleResidual 2 1 1 1 1 = 1 := by
  decide

theorem positive_product_lower (x y : Nat) (hx : 1 <= x) (hy : 1 <= y) :
    x + y <= x * y + 1 := by
  have ex : x = (x - 1) + 1 := by omega
  have ey : y = (y - 1) + 1 := by omega
  rw [ex, ey]
  simp only [Nat.add_mul, Nat.mul_add, Nat.one_mul, Nat.mul_one]
  omega

theorem separated_face_product_lower
    (M A B X Y : Nat) (hM : 2 <= M)
    (hA : 1 <= A) (hB : 1 <= B) (hY : 1 <= Y)
    (hAB : M <= A + B) (hXY : Y + M <= X) :
    (M - 1) * (M + 1) <= (A * X) * (B * Y) := by
  have h1 : M - 1 <= A * B := by
    have := positive_product_lower A B hA hB
    omega
  have h2 : M + 1 <= X * Y := by
    have hh := Nat.mul_le_mul_left X hY
    simp only [Nat.mul_one] at hh
    omega
  have hh := Nat.mul_le_mul h1 h2
  simpa only [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using hh

def geometric (x : Nat) : Nat -> Nat
  | 0 => 0
  | n + 1 => geometric x n * x + 1

theorem geometric_mod (x m n : Nat) (hx : x % m = 1 % m) :
    geometric x n % m = n % m := by
  induction n with
  | zero => simp [geometric]
  | succ n ih =>
    change (geometric x n * x + 1) % m = (n + 1) % m
    calc
      (geometric x n * x + 1) % m =
          ((geometric x n * x) % m + 1 % m) % m :=
        Nat.add_mod (geometric x n * x) 1 m
      _ = (((geometric x n % m) * (x % m)) % m + 1 % m) % m := by
        rw [Nat.mul_mod (geometric x n) x m]
      _ = (((n % m) * (1 % m)) % m + 1 % m) % m := by rw [ih, hx]
      _ = ((n * 1) % m + 1 % m) % m := by rw [Nat.mul_mod n 1 m]
      _ = (n + 1) % m := by rw [Nat.mul_one, Nat.add_mod n 1 m]

theorem geometric_gcd (x n : Nat) (hx : 1 <= x) :
    Nat.gcd (x - 1) (geometric x n) = Nat.gcd (x - 1) n := by
  have heq : x = (x - 1) + 1 := by omega
  have hm : x % (x - 1) = 1 % (x - 1) := by
    calc
      x % (x - 1) = ((x - 1) + 1) % (x - 1) := congrArg (fun z => z % (x - 1)) heq
      _ = 1 % (x - 1) := by simp
  rw [Nat.gcd_rec (x - 1) (geometric x n), geometric_mod x (x - 1) n hm,
    Nat.gcd_rec (x - 1) n]

theorem coprime_parity (a b : Nat) (h : Nat.gcd a b = 1) :
    a % 2 = 1 \/ b % 2 = 1 := by
  by_cases ha : a % 2 = 0
  · by_cases hb : b % 2 = 0
    · have hd : 2 ∣ Nat.gcd a b := Nat.dvd_gcd
        (Nat.dvd_of_mod_eq_zero ha) (Nat.dvd_of_mod_eq_zero hb)
      rw [h] at hd
      omega
    · right; omega
  · left; omega

theorem unit_cell_impossible (M A B : Nat)
    (hAB : A + B = M)
    (hAX : Nat.gcd A (M + 1) = 1)
    (hBX : Nat.gcd B (M + 1) = 1)
    (hABg : Nat.gcd A B = 1)
    (hMC : Nat.gcd M (A + 1) = 1) : False := by
  have h1 := coprime_parity A (M + 1) hAX
  have h2 := coprime_parity B (M + 1) hBX
  have h3 := coprime_parity A B hABg
  have h4 := coprime_parity M (A + 1) hMC
  omega

theorem threshold_comparison (M : Nat) :
    (M - 1) * (2 * M + 1) <= (2 * M - 1) * (M + 1) := by
  have h : 2 * (M - 1) <= 2 * M - 1 := by omega
  calc
    (M - 1) * (2 * M + 1) <= (M - 1) * (2 * (M + 1)) :=
      Nat.mul_le_mul_left (M - 1) (by omega)
    _ = (2 * (M - 1)) * (M + 1) := by
      simp only [Nat.mul_comm, Nat.mul_left_comm]
    _ <= (2 * M - 1) * (M + 1) := Nat.mul_le_mul_right (M + 1) h

theorem normalized_unitary_face_threshold (M A B Y k l : Nat)
    (hM : 4 <= M) (hA : 1 <= A) (hB : 1 <= B)
    (hY : 1 <= Y) (hk : 1 <= k) (hl : 1 <= l)
    (hAB : A + B = k * M)
    (hAX : Nat.gcd A (Y + l * M) = 1)
    (hBX : Nat.gcd B (Y + l * M) = 1)
    (hABg : Nat.gcd A B = 1)
    (hMC : Nat.gcd M (k * Y + l * A) = 1) :
    (M - 1) * (2 * M + 1) <= (A * (Y + l * M)) * (B * Y) := by
  have hmprod : M - 1 <= A * B := by
    have hh := positive_product_lower A B hA hB
    have hm := Nat.mul_le_mul_right M hk
    simp only [Nat.one_mul] at hm
    omega
  have hx : M + 1 <= Y + l * M := by
    have hh := Nat.mul_le_mul_right M hl
    simp only [Nat.one_mul] at hh
    omega
  by_cases hy2 : 2 <= Y
  · have hxy : 2 * M + 1 <= (Y + l * M) * Y := by
      calc
        2 * M + 1 <= (M + 1) * 2 := by
          rw [Nat.mul_two]
          omega
        _ <= (Y + l * M) * Y := Nat.mul_le_mul hx hy2
    have hh := Nat.mul_le_mul hmprod hxy
    simpa only [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using hh
  · have ey : Y = 1 := by omega
    subst Y
    by_cases hk2 : 2 <= k
    · have hprod : 2 * M - 1 <= A * B := by
        have hh := positive_product_lower A B hA hB
        have hm := Nat.mul_le_mul_right M hk2
        omega
      have hh := Nat.mul_le_mul hprod hx
      have hfinal := Nat.le_trans (threshold_comparison M) hh
      simpa only [Nat.mul_one, Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using hfinal
    · have ek : k = 1 := by omega
      subst k
      by_cases hl2 : 2 <= l
      · have hxx : 2 * M + 1 <= 1 + l * M := by
          have hh := Nat.mul_le_mul_right M hl2
          omega
        have hh := Nat.mul_le_mul hmprod hxx
        simpa only [Nat.mul_one, Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using hh
      · have el : l = 1 := by omega
        subst l
        simp only [Nat.one_mul, Nat.mul_one] at hAB hAX hBX hMC
        have hAX' : Nat.gcd A (M + 1) = 1 := by simpa [Nat.add_comm] using hAX
        have hBX' : Nat.gcd B (M + 1) = 1 := by simpa [Nat.add_comm] using hBX
        have hMC' : Nat.gcd M (A + 1) = 1 := by simpa [Nat.add_comm] using hMC
        exact False.elim (unit_cell_impossible M A B hAB hAX' hBX' hABg hMC')

#print axioms greedy_two_sum
#print axioms greedy_two_feasible
#print axioms greedy_two_optimal
#print axioms splitting_never_worse
#print axioms no_face_no_transfer
#print axioms strict_abstract_example
#print axioms positive_product_lower
#print axioms separated_face_product_lower
#print axioms geometric_mod
#print axioms geometric_gcd
#print axioms coprime_parity
#print axioms unit_cell_impossible
#print axioms threshold_comparison
#print axioms normalized_unitary_face_threshold
end ABCResearch20260905
