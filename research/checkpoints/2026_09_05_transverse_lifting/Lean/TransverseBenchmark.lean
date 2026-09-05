import Std

/-!
Author: ChatGPT. 2026-09-05.
A complete exact-arithmetic certificate for the transverse optimization
at 2 + 3^10 * 109 = 23^5. No ABC theorem is asserted or assumed.
The general CRT lifting and real-relaxation theorems in the paper are
NOT claimed formalized by this standalone module.
-/
set_option autoImplicit false
set_option maxRecDepth 10000
namespace ABCTransverseLifting20260905

structure Weights where
  at2 : Int
  at3 : Int
  at109 : Int
  at23 : Int
  deriving DecidableEq

def tripleAdditive (v : Weights) : Prop :=
  v.at2 + 21454470 * v.at3 + 59049 * v.at109 = 1399205 * v.at23

def wronskian (v : Weights) : Int :=
  2 * (21454470 * v.at3 + 59049 * v.at109) - 6436341 * v.at2

def level (v : Weights) : Int :=
  25070 * v.at3 + 69 * v.at109 - 1635 * v.at23

/-- Exactly the closed ball H(v) <= numerator / denominator for positive inputs. -/
def Within (numerator denominator : Int) (v : Weights) : Prop :=
  -2 * numerator <= denominator * v.at2 /\
  denominator * v.at2 <= 2 * numerator /\
  -3 * numerator <= denominator * v.at3 /\
  denominator * v.at3 <= 3 * numerator /\
  -109 * numerator <= denominator * v.at109 /\
  denominator * v.at109 <= 109 * numerator /\
  -23 * numerator <= denominator * v.at23 /\
  denominator * v.at23 <= 23 * numerator

/-- Exactly the open ball H(v) < numerator / denominator for positive inputs. -/
def Below (numerator denominator : Int) (v : Weights) : Prop :=
  -2 * numerator < denominator * v.at2 /\
  denominator * v.at2 < 2 * numerator /\
  -3 * numerator < denominator * v.at3 /\
  denominator * v.at3 < 3 * numerator /\
  -109 * numerator < denominator * v.at109 /\
  denominator * v.at109 < 109 * numerator /\
  -23 * numerator < denominator * v.at23 /\
  denominator * v.at23 < 23 * numerator

def witness : Weights := { at2 := -141, at3 := 107, at109 := 79, at23 := 1644 }
def tangent : Weights := { at2 := 0, at3 := 3, at109 := -1090, at23 := 0 }
def zeroWeights : Weights := { at2 := 0, at3 := 0, at109 := 0, at23 := 0 }

/-- Finite trial-division predicate, used only for the four small factors below. -/
def trialPrime (n : Nat) : Prop :=
  2 <= n /\ forall d : Fin n, 2 <= d.val -> n % d.val != 0

theorem small_prime_certificates :
    trialPrime 2 /\ trialPrime 3 /\ trialPrime 109 /\ trialPrime 23 := by decide

theorem factorization_and_coprimality :
    (2 : Nat) + 3^10 * 109 = 23^5 /\
    Nat.gcd 2 (3^10 * 109) = 1 /\
    (2 : Nat) * 3 * 109 * 23 = 15042 /\
    (2 : Nat) * (3^10 * 109) * 23^5 = 15042 * 5508110403 := by decide

theorem coefficient_certificates :
    (6436341 : Nat) / 3 * 10 = 21454470 /\
    (6436341 : Nat) / 109 = 59049 /\
    (6436343 : Nat) / 23 * 5 = 1399205 := by decide

theorem level_equation (v : Weights) (h : tripleAdditive v) :
    10 * v.at23 - 23 * v.at2 = 19683 * level v := by
  unfold tripleAdditive at h
  unfold level
  omega

theorem wronskian_level (v : Weights) (h : tripleAdditive v) :
    wronskian v = 5508110403 * level v := by
  unfold tripleAdditive at h
  unfold wronskian level
  omega

theorem witness_certificate :
    tripleAdditive witness /\ wronskian witness = 5508110403 /\
    Within 1644 23 witness := by decide

theorem every_level_realized (m : Int) :
    exists v : Weights, tripleAdditive v /\ wronskian v = 5508110403 * m := by
  refine Exists.intro { at2 := -141*m, at3 := 107*m, at109 := 79*m, at23 := 1644*m } ?_
  constructor
  · dsimp [tripleAdditive]
    omega
  · dsimp [wronskian]
    omega

theorem exact_wronskian_image (k : Int) :
    (exists v : Weights, tripleAdditive v /\ wronskian v = k) <->
    (exists m : Int, k = 5508110403 * m) := by
  constructor
  · intro h
    obtain ⟨v, hv, hk⟩ := h
    exact ⟨level v, hk.symm.trans (wronskian_level v hv)⟩
  · intro h
    obtain ⟨m, hm⟩ := h
    obtain ⟨v, hv, hw⟩ := every_level_realized m
    exact ⟨v, hv, hw.trans hm.symm⟩

theorem gap_cell (x w m : Int)
    (hx0 : -142 <= x) (hx1 : x <= 142)
    (hw0 : -1643 <= w) (hw1 : w <= 1643)
    (heq : 10*w - 23*x = 19683*m) : m = 0 := by
  omega

theorem no_smaller_transverse (v : Weights)
    (h : tripleAdditive v) (hb : Below 1644 23 v) : wronskian v = 0 := by
  have heq := level_equation v h
  unfold Below at hb
  have hx0 : -142 <= v.at2 := by omega
  have hx1 : v.at2 <= 142 := by omega
  have hw0 : -1643 <= v.at23 := by omega
  have hw1 : v.at23 <= 1643 := by omega
  have hz := gap_cell v.at2 v.at23 (level v) hx0 hx1 hw0 hw1 heq
  rw [wronskian_level v h, hz]
  decide

/-- A witness at 1644/23, and a quantified exclusion of every smaller radius. -/
theorem exact_transverse_minimum :
    tripleAdditive witness /\ wronskian witness != 0 /\
    Within 1644 23 witness /\
    (forall v : Weights, tripleAdditive v -> wronskian v != 0 ->
      Not (Below 1644 23 v)) := by
  refine ⟨witness_certificate.1, ?_, witness_certificate.2.2, ?_⟩
  · rw [witness_certificate.2.1]
    decide
  · intro v hv hn hb
    exact hn (no_smaller_transverse v hv hb)

theorem short_tangent_certificate :
    tripleAdditive tangent /\ wronskian tangent = 0 /\
    Within 10 1 tangent /\ tangent != zeroWeights := by decide

theorem every_vector_within_ten_is_tangent (v : Weights)
    (h : tripleAdditive v) (hb : Within 10 1 v) : wronskian v = 0 := by
  apply no_smaller_transverse v h
  unfold Within at hb
  unfold Below
  omega

theorem centered_residue (p r : Int) (hp : 0 < p)
    (hr0 : 0 <= r) (hrp : r < p) :
    let z := if 2*r <= p then r else r-p
    -p <= 2*z /\ 2*z <= p /\ (z = r \/ z = r-p) := by
  dsimp
  split <;> omega

#print axioms small_prime_certificates
#print axioms factorization_and_coprimality
#print axioms coefficient_certificates
#print axioms level_equation
#print axioms wronskian_level
#print axioms witness_certificate
#print axioms every_level_realized
#print axioms exact_wronskian_image
#print axioms gap_cell
#print axioms no_smaller_transverse
#print axioms exact_transverse_minimum
#print axioms short_tangent_certificate
#print axioms every_vector_within_ten_is_tangent
#print axioms centered_residue
end ABCTransverseLifting20260905
