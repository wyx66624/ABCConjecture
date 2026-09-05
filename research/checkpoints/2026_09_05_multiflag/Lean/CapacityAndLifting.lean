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
  conv_rhs => rw [ex, ey]
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
    simp only [geometric, Nat.mul_mod, Nat.add_mod, ih, hx]
    simp [Nat.add_mod, Nat.mul_mod]

#check Nat.gcd_rec
#check Nat.gcd_comm
#check Nat.mul_mod

#print axioms greedy_two_sum
#print axioms greedy_two_feasible
#print axioms greedy_two_optimal
#print axioms splitting_never_worse
#print axioms no_face_no_transfer
#print axioms strict_abstract_example
#print axioms positive_product_lower
#print axioms separated_face_product_lower
#print axioms geometric_mod
end ABCResearch20260905
